//
//  ABViewController.swift
//  iOSStudyNotes
//
//  Created by pkwans on 2022/2/17.
//

import UIKit
//import Alamofire
import SwiftyJSON

//import AppleTextureEncoder

class ABViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        self.base()
        self.dataStructure();
        
        let a = self.twoSum(nums: [3,1,2,9,10,23], target: 3);
        print(a);
        let b = self.twoSum2(nums: [3,1,2,9,10,23], target: 3);
        print(b);
        
//        Dictionary("hello".map{($0,1)},uniquingKeyswith:+)
//        "hello".map{($0,1),@warn_unqualified_access}
//        let pathString:String = Bundle.main.path(forResource: "Level8luan_2", ofType: "json")!;
//        var jsonString = String.init()
//        do {
//             jsonString = try String.init(contentsOfFile: pathString );
//        } catch  {
//            print(error)
//        }
//        let dic = JSON(jsonString)[0];
        
//        print(dic)
        // 字符串
        let str = "3"
        let num : Int? = Int(str)
        let number = 3
        let string : String = String(num!)
        print(number)
        print(string)
//        let len = str.count
//        let char = str[str.index(str.startIndex, offsetBy: n)]
//        str.remove(at: n)
//        str.append("c")
//        str += "hello world"

        let reverseString = self.reverseWords(s: "Hello nice to meet you")
        print(reverseString!)

        testListNode()
        testRemoveNthFromEnd()
        let result =  simplifyPath(path: "/a/.b/../../c/")
        print(result)
        
        testSort()
        
//        JSONDecoder
//        let json = json
//    swifty
        
//        JSON()
//        Alamofire

        letterMatrix()
        
        testFIB()
        
        testLT()
        
        testAlgorithmProblem()
    }
    

    func letterMatrix() {
        let matrix:[[Character]] =
                    [["A","B","C","D","E","F","G"],
                      ["H","I","J","K","L","M","N"],
                      ["O","P","Q","R","S","T","U"],
                      ["V","W","X","Y","Z","F","G"],
                      ["A","B","C","D","E","F","G"],
                     ["H","I","J","K","L","M","N"],
                     ["O","C","R","O","W","D","U"]];
       
        var labels =  Array(repeating: Array(repeating: UILabel.init(), count: matrix[0].count),count: matrix.count)
        
        
        var xOffset:CGFloat = 0
        var yOffset:CGFloat = 0
        let cellWidth:CGFloat = (UIScreen.main.bounds.size.width/CGFloat(matrix[0].count))
        let cellHeight:CGFloat = UIScreen.main.bounds.size.height/CGFloat(matrix.count)
        
        for i in 0 ..< matrix.count {
            for j in 0 ..< matrix[0].count {
                let label = UILabel(frame: CGRect(x: xOffset, y: yOffset, width: cellWidth, height: cellHeight))
                label.text = String(matrix[i][j])
                label.textAlignment =  NSTextAlignment.center;
                label.layer.borderWidth = 1
                label.layer.borderColor = UIColor.red.cgColor
                view.addSubview(label)
                labels[i][j] = label
                xOffset += cellWidth
            }
            xOffset = 0
            yOffset += cellHeight
        }
        
        let AAA = searchWord(matrix)
        
        print("CROWD",AAA)
    }
    
    func searchWord(_ board:[[Character]]) -> Bool {
        guard board.count > 0 && board[0].count > 0 else {
            return false
        }
        
        let (m, n) = (board.count, board[0].count)
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        let wordContent = [Character]("CROWD")
        
        for i in 0 ..< m {
            for j in 0 ..< n {
                if dfs(board, wordContent, m, n, i, j, &visited, 0) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func dfs(_ board:[[Character]],_ wordContent: [Character],_ m:Int, _ n:Int,_ i:Int, _ j:Int,_ visited: inout [[Bool]],_ index:Int ) -> Bool {
        if index == wordContent.count {
            return true
        }
        
        guard i >= 0 && i < m && j >= 0 && j < n else {
            return false
        }
        
        guard !visited[i][j] && board[i][j] == wordContent[index] else {
            return false
        }
        
        visited[i][j] = true
        
        if dfs(board, wordContent, m, n, i+1, j, &visited, index+1) ||
            dfs(board, wordContent, m, n, i - 1, j, &visited, index + 1) ||
            dfs(board, wordContent, m, n, i, j+1, &visited, index+1) ||
            dfs(board, wordContent, m, n, i, j-1, &visited, index + 1) {
            return true
        }
        
        visited[i][j] = false
        return false
    }
    
    // 优化上面搜索多个单词  把字典转化为前缀树
    func findwords(_ board : [[Character]],_ dict:Set <String>) -> [String] {
        var res = [String]()
        let (m, n) = (board.count, board[0].count)
        
        let trie = _convertSetToTrie(dict)
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        
        for i in 0 ..< m {
            for j in 0 ..< n {
                _dfs(board, m, n, i, j, &visited, &res, trie, "")
            }
        }
        
        return res
    }
    
    private func _dfs(_ board:[[Character]],_ m:Int,_ n:Int,_ i:Int,_ j:Int, _ visited:inout [[Bool]], _ res:inout [String],_ trie:Trie,_ str :String)
    {
        // 越界
        guard i >= 0 && i < m && j >= 0 && j < n else {
            return
        }
        
        // 已经访问过
        guard !visited[i][j] else {
            return
        }
        
        // 搜索目前字母组合是否是单词前缀
        let str = str + "\(board[i][j])"
        guard trie.startsWith(str)
        else {
            return
        }
        
        //确认当前字母组合是否为单词前缀
        if trie.isWord(str) && !res.contains(str) {
            res.append(str)
        }
        
        // 继续搜索 上下左右四个方向
        visited[i][j] = true
        _dfs(board, m, n, i + 1, j, &visited, &res, trie, str)
        _dfs(board, m, n, i - 1, j, &visited, &res, trie, str)
        _dfs(board, m, n, i, j + 1, &visited, &res, trie, str)
        _dfs(board, m, n, i, j - 1, &visited, &res, trie, str)
        visited[i][j] = true
    }

    
    
    // 检查字符串是否是由数字构成
    func isStrNum(str: String) -> Bool {
        return Int(str) != nil;
    }
    // 将字符串按字母排序 （不考虑大小写）
    func sortStr(str: String) -> String {
        return String(str.sorted())
    }
    
    func base() -> Void {
        let nums = [1,2,3];
        print(nums);
        let anums = [Int](repeating: 0, count: 5);
        print(anums)
        
        var dynums = [3,1,2]
        dynums.append(4);
        print(dynums)
        dynums.sort();
        print(dynums)
        dynums.sort(by: >)
        print(dynums)
        
        //将原数组除最后一个外的所有元素赋值给另一个数组
        let anothernums = Array(dynums[0 ..< dynums.count - 1]);
        print(anothernums)

    }

    func  dataStructure() -> Void {
        let primeNums: Set = [3,5,7,11,13]
        let oddNums: Set = [1,3,5,7,9]
        // 交集 并集 差集
        let primeAndOddNum = primeNums.intersection(oddNums)
        let primeOrOddNum = primeNums.union(oddNums)
        let oddNotPriNum = oddNums.subtracting(primeNums)
        
        print("primeAndOddNum",primeAndOddNum)
        print("primeOrOddNum",primeOrOddNum)
        print("oddNotPriNum", oddNotPriNum)
    }
    
    // 给参与一个整形数组 和一个目标值 判断数组中是否有两个数的之和等于目标值
    
    func twoSum(nums:[Int], target: Int) -> Bool {
        var set = Set<Int>()
        for num in nums {
            if set.contains(target-num){
                return true
            }
            set.insert(num)
        }
        return false
    }

    // 给一个整形数组 和一个目标值 有且只有两个数的之和等于目标值 求两个数再数组的序号
    func twoSum2(nums:[Int], target: Int) -> [Int] {
        var dict = [Int:Int]()
        
        for (i,num) in nums.enumerated() {
            if let lastIndex = dict[target - num]{
                return [lastIndex, i]
            }else {
                dict[num] = i;
            }
        }
        fatalError("No valid output")
    }
    
    
    
    // 给出一个字符串 要求按照单词进行反转
    
    fileprivate func _reverse<T>(_ chars:inout[T],_ start:Int,_ end:Int){
        var start = start, end = end

        while start < end {
        _swap(&chars, start, end)
            start += 1
            end -= 1
        }
    }
    
    fileprivate func _swap<T>(_ chars:inout[T],_ p:Int, _ q:Int) {
        (chars[p], chars[q]) = (chars[q], chars[p])
    }
    
    // 整个字符串反转
    // 每个单词作为字符串反转
    func reverseWords(s: String?) -> String? {
        
        guard let s = s else {
            return nil
        }
        var chars = Array(s), start = 0
        _reverse(&chars, 0, chars.count - 1)
        
        for i in 0 ..< chars.count
        {
            if i == chars.count - 1 || chars[i+1] == " " {
                _reverse(&chars, start, i)
                start = i + 2
            }
        }
        return String(chars)
    }
    
}





