<template>
    <div class="box2">
        <van-divider class="title">账户信息</van-divider>
        <div class="message">
            <van-space>
            <p class="label">当前账户</p>
            <p class="address">{{account}}</p>
         </van-space>
         <br/>
         <van-space>
            <p class="label">账户票数</p>
            <p class="address">{{voteInfo.amount}}</p>
         </van-space>
         <br/>
         <van-space>
            <p class="label">委托账户</p>
            <p class="address">{{voteInfo.delegator}}</p>
         </van-space>
         <br/>
         <van-space>
            <p class="label">是否已投票</p>
            <p class="address">{{voteInfo.isVoted}}</p>
         </van-space>
         <br/>
         <van-space>
            <p class="label">投票ID</p>
            <p class="address">{{voteInfo.targetId}}</p>
         </van-space>
        </div>
        
        <div class="btn">
            <van-cell-group inset>
                <van-field  v-model="to" label="受托人地址" placeholder="请输入受托人地址"/>
            </van-cell-group>
            <van-button block @click="delegate">委托他人代投</van-button>
        </div>
        
    </div>
</template>
<script setup>
import {reactive, ref,onMounted} from 'vue'
import useWeb3 from '../hooks/useWeb3'

const account = ref('')
const voteInfo = ref({})
const to = ref('')
onMounted(async () => {
    const {voteContract,currentAccount} = await useWeb3()
    const web = await useWeb3()
    window.web = web
    voteInfo.value = await voteContract.methods.voters(currentAccount).call()
    account.value = currentAccount
    console.log(voteInfo.value);
})
const delegate = async ()=>{
   await window.web.voteContract.methods.delegate(to.value).send({
      from:window.web.currentAccount
   }).on("receipt",()=>{
      console.log('委托成功');
   })
}
</script>

<style scoped lang="less">
.title {
      margin-top: 40px;
   }
   .message{
    margin-left: 20px;
   }
   .label{
    width:100px;
   }
   .address{
         width: 100%;
         // background-color: red;
         word-break:break-all;
         
      }

</style>