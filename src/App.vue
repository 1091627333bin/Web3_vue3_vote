<template>
  <div>
    <div class="box">
      去中心化投票app
    </div>

    <!-- <router-link to="/">Home</router-link> |
    <router-link to="/about">About</router-link> -->
    <div class="content">
      <router-view></router-view>
    </div>

    <div class="bottom">
      <!-- <div class="btn"> -->
      <div class="btn">
        <router-link active-class="active" to="/">
          <van-icon name="gem-o" />
          <span>分发票权</span> 
        </router-link>
      </div>

      <div class="btn">
        <router-link active-class="active" to="/account">
          <van-icon name="todo-list-o" />
          <span>账户信息</span> 
        </router-link>

      </div>

      <div class="btn">
        <router-link active-class="active" to="/board">
          <van-icon name="label-o" />
          <span>投票看板</span> 
          
        </router-link>
      </div>

      <!-- </div> -->
    </div>
  </div>
</template>



<script setup>


</script>

<style scoped lang="less">
.box {
  // float: left;
  position: absolute;
  top: 0px;
  left: 0px;
  height: 30px;
  width: 100%;
  background-color: orange;
  text-align: center;
  line-height: 30px;
  color: white;
}

.active {
  color: orange;
}

.content {
  // float: left;
  margin-top: 30px;
}

.bottom {
  height: 70px;
  width: 100%;
  position: fixed;
  left: 0;
  bottom: 0;
  right: 0;
  display: flex;
  justify-content: space-around;
  .btn{
    padding-top: 20px;
    text-align: center;
    
  }
}
span{
    display: block;
    }
</style>