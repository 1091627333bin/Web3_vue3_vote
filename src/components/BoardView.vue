<template>
    <div class="box3">
        <van-divider class="title">投票看板</van-divider>
        <van-cell :title="item.name" icon="shop-o" v-for="(item,index) in board" :key="item.index">
            <template #right-icon>
                <van-button size="small" @click="vote(index)">{{ item.totalAmount }}</van-button>
            </template>
        </van-cell>
        
        
    </div>
</template>
<script setup>
import {ref,onMounted} from 'vue'
import useWeb3 from '../hooks/useWeb3'

const board = ref([])
onMounted(async () => {
   
    const web = await useWeb3()
    
    window.web = web
    initEventListen()
    board.value = await web.voteContract.methods.getBoardInfo().call()
    console.log(board.value);
})

const vote = async (index)=>{
    await window.web.voteContract.methods.vore(index).send({
        from:window.web.currentAccount
    }).on("receipt",()=>{
      console.log('投票成功');
   })
}
const initEventListen = ()=>{
    window.web.voteContract.events.voteSuccess({fromBlock:0},(err,event)=>{
        console.log('监听执行');
    })
    .on("data",(event)=>{
        console.log(event.returnValues);
    })
}
</script>

<style scoped lang="less">

.title {
      margin-top: 40px;
   }
</style>