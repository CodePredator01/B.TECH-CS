/*
 * Created by IntelliJ IDEA.
 * User: Priyanshu (CodePredator01)
 * Date: 23-06-2021
 * File: DuplicateElements.java
 * */

package Ques1;

public class DuplicateElements {
    public void Duplicate(int arr[]){
        System.out.println("Printing Duplicate Elements");
        for(int i = 0; i < arr.length; i++) {
            for(int j = i + 1; j < arr.length; j++) {
                if(arr[i] == arr[j]) {
                    System.out.println(arr[j]);
                }
            }
        }
    }

    public static void main(String[] args) {
        int [] arr = {1, 2, 3, 4, 2, 7, 8, 8, 3};
        DuplicateElements obj=new DuplicateElements();
        obj.Duplicate(arr);
    }
}