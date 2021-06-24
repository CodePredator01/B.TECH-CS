/*
 * Created by IntelliJ IDEA.
 * User: Priyanshu (CodePredator01)
 * Date: 23-06-2021
 * File: CircularLinkedList.java
 * */

package Exp2;

public class CircularLinkedList {
    private Node head;
    private Node tail;

    public void insert(int data){
        Node newNode = new Node(data);
        if (head == null){
            head = newNode;
        }else {
            tail.setNextNode(newNode);
        }
        tail = newNode;
        tail.setNextNode(head);
    }
    public boolean search(int data){
        if (head == null){
            return false;
        }else {
            Node currentNode = head;
            while (currentNode.getNextNode() != head){
                if (currentNode.getData() == data){
                    return true;
                }
                currentNode = currentNode.getNextNode();
            }
        }
        return false;
    }
    public void delete(int data){
        Node currentNode = head;
        if (head != null){
            if (currentNode.getData() == data){
                head = currentNode.getNextNode();
                tail.setNextNode(head);
            }else {
                while(currentNode.getNextNode() != head){
                    if (currentNode.getNextNode().getData() == data){
                        currentNode.setNextNode(currentNode.getNextNode().getNextNode());
                        break;
                    }
                    currentNode = currentNode.getNextNode();
                }
            }
        }
    }
    public void traverse(){
        if (head != null){
            Node currentNode = head;
            while (currentNode.getNextNode() != head){
                System.out.print(currentNode.getData() + " ");
                currentNode = currentNode.getNextNode();
            }
        }
        System.out.print(tail.getData());
    }
}
