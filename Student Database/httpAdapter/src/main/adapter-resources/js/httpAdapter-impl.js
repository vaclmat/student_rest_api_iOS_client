/*
 *  Licensed Materials - Property of IBM
 *  5725-I43 (C) Copyright IBM Corp. 2011, 2016. All Rights Reserved.
 *  US Government Users Restricted Rights - Use, duplication or
 *  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */

/**
 * @param tag: a topic such as MobileFirst_Platform, Bluemix, Cordova.
 * @returns json list of items.
 */
//import SwiftKeychainWrapper

function login(un, pwd) {
    var data = {"username": un,
        "password": pwd};
    var input = {
	    method : 'post',
	    returnedContentType : 'json',
	    path : '/web/services/university/user/login',
        body : {
            contentType : 'application/json; charset=UTF-8',
            content : data
        }
	};

    return WL.Server.invokeHttp(input);
}

function getAllStudents(token) {
    
    var input = {
        method : 'get',
        returnedContentType : 'json',
        path : '/web/services/university/students',
        headers : {
            accept : 'application/json',
            contentType : 'application/json; charset=UTF-8',
            authorization : 'Bearer ' + token
        }
    };
 
    return WL.Server.invokeHttp(input);
}

function getStudentByID(token, id) {

    var input = {
        method : 'get',
        returnedContentType : 'json',
        path : '/web/services/university/student/' + id,
        headers : {
             accept : 'application/json',
             contentType : 'application/json; charset=UTF-8',
             authorization : 'Bearer ' + token
         }
    };

    return WL.Server.invokeHttp(input);
}

function getUserByName(token, username) {
    
    var input = {
        method : 'get',
        returnedContentType : 'json',
        path : '/web/services/university/user/' + username,
        headers : {
            accept : 'application/json',
            contentType : 'application/json; charset=UTF-8',
            authorization : 'Bearer ' + token
        }
    };
    
    return WL.Server.invokeHttp(input);
}
