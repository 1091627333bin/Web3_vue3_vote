//SPDX-License-Identifier:GPL-3.0
//源码遵循协议， MIT...
pragma solidity >=0.4.16 <0.9.0; //限定solidity编译器版本

contract Vote{
    //构建投票人结构体
    struct Voter{
        uint256 amount;//票数
        bool isVoted;//是否投过票
        address delegator;//代理人地址
        uint256 targetId;//目标id

    }
    //投票看板
    struct Board{
        string name;//目标名字
        uint256 totalAmount;//票数
    }
    address public host;//主持人信息
    //投票人集合
    mapping(address=>Voter) public voters;
    //主题集合
    Board[] public board;

    constructor(string[] memory nameList){
        host = msg.sender;
        //给主持人初始化一票
        voters[host].amount = 1;
        //初始化board
        for(uint i =0;i < nameList.length;i++){
              board.push(Board(nameList[i],0));
        }
    }

    //事件
    event voteSuccess(string);

    //返回看板集合
    function getBoardInfo () public view returns(Board[] memory){
        return board;
    }
    //给某些地址赋予选票
    function mandate(address[] calldata addressList) public {
        //只有主持人可以调用
        require(msg.sender==host,unicode'没有权限');

        for(uint i =0;i < addressList.length;i++){
            //如果该地址已经已经投过票，不做处理
            if(!voters[addressList[i]].isVoted){
                voters[addressList[i]].amount = 1;
            }
              
        }
    }

    //投票
    function vore(uint targetId) public{
        Voter storage sender = voters[msg.sender];
        require(sender.amount!=0, 'has no right to vote');
        require(!sender.isVoted,'already voted');
        sender.isVoted = true;
        sender.targetId = targetId;
        board[targetId].totalAmount +=sender.amount;
        emit voteSuccess(unicode'投票成功');
    }
    //委托投票
    function delegate(address to) public {
        require(!voters[msg.sender].isVoted,unicode"委托人已经投过票了");//委托人首先没有投过票
        
        require(msg.sender!=to,unicode"不能委托给自己");

        //避免循环投票
        while(voters[to].delegator !=address(0)){
            to = voters[to].delegator;
            require(msg.sender == to,unicode"不能循环投票");
        }

        //判断被委托人是否投过票
        if(voters[to].isVoted){//投过票了
            board[voters[to].targetId].totalAmount +=voters[msg.sender].amount;
            
        }
        else{//没投过
            voters[to].amount +=voters[msg.sender].amount;
        }
        voters[msg.sender].delegator = to;
        voters[msg.sender].isVoted = true;
    }
}
