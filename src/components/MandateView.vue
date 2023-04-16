<template>
   <div class="box1">
      <van-divider class="title">分发票权</van-divider>
      <div class="host">
         <van-space>
            <p class="label"><van-icon name="manager" />主持人地址</p>
            <p class="address">{{host}}</p>
         </van-space>
      </div>
      <div>
         <van-space>
            <p class="label"><van-icon name="friends-o" />投票人地址</p>
            <textarea class="votors" v-model="addressList"></textarea>
         </van-space>
      </div>
      <div class="btn">
         <van-button block @click="start">开始分发选票</van-button>
      </div>
   </div>
</template>


<script setup>
import { onMounted, reactive, ref } from 'vue'
import useWeb3 from '../hooks/useWeb3'

const host = ref('')
const addressList = ref('')

onMounted(() => {
   async function init() {
      const web = await useWeb3()
      console.log(web.voteContract, web.currentAccount, web.web3);
      window.web = web;
      host.value = await web.voteContract.methods.host().call()
   }
   /*
   [0x45C8611e02cD494A65bF9cF8f292BE257f4a1618,0xC4749dfEb52229EbFfbeF8379b9558F94d903793]
   */
   init()
})

const start = async()=>{
   
   const arr = addressList.value.slice(1,addressList.value.length-1).split(',')
   await window.web.voteContract.methods.mandate(arr).send({
      from:window.web.currentAccount
   }).on("receipt",()=>{
      console.log('分发成功');
   })
}





</script>

<style scoped lang="less">
.box1 {
   .title {
      margin-top: 40px;
   }

   .label {
      margin-left: 20px;
      width:100px;
   }

   textarea {
      height: 300px;
      width: 200px;
      border-color: lightgrey;
      margin-bottom: 20px;
   }
   .host{
      width: 100%;
      height: 100px;
      overflow: hidden;
      ;
      .address{
         width: 100%;
         height: 50px;
         // background-color: red;
         word-break:break-all;
         
      }
   }
}
</style>