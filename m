Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76144612C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhKEJN6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 05:13:58 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:58588 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231190AbhKEJN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 05:13:58 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A50XT9B019022;
        Fri, 5 Nov 2021 05:11:16 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c4t639v7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 05:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHJF5VXskOqo2pF5dWc9pvNyKKYfhDaexDah2cYdSlCNbqZ2tO8uM/cs30oqxFnlyIbYMRe0LVMBqp5D7GvdFS+Ca67RNUw38S+7L9TDEuHNyG+KkUO2jNxESf9utAIGKQo2ck2ii2OhF6ZJK9M/QZd1N3yTsRVG2gBTp4xq4HV+BKvis120B4WfLRMLlkE2XH9HDWlT2fKbP9P3EKovKTvCnRQpRZ6AYr4JNDLcGQDjWkcI9tv7CgMcNOBdG/5xZG5UO5N6ph2K5sDwH5Au547bYQWT+UUyWtG6B3GSEd4kN+Cu1Vm356zoKiB8QA63Hlqn7FzrgaxWGiVSkG2uJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ust/K6v+u1odAeZcXEhouvg16KS+CWbJx8rhX0q0wWk=;
 b=DNFkWK4d7/Ci7+k3nUzWiruFwfXyRBrRbZ47/JvCIR+vbCR3+mH0SKn/YKqtVOYb4Ez8gPU2ySOGgvLkXG9HWTbrkMtU0ytOiv8TYSeZIiK+JPZalLKsVX6FmfSiTl3YP/nBB2p0jwMbCZlk459W9YCyvP+B7ZbvT4OwS8DQtB1cNEz2qpJR1pwy3jT4xWm4d87ux0M7lkeqdzXOk2HdjEZJ2V+djPWy8LwnX1/daw6B2CrbdFvpmJlhBi/2QaXc1i9diNg331OsTsVdDM1wCnTRtJnctG8mF9NlZPQobTfp1AXv30196foEu6faA29U1KKw2vRz5bSp2/qCDI1Rng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ust/K6v+u1odAeZcXEhouvg16KS+CWbJx8rhX0q0wWk=;
 b=AZiYphWmeNM+ZnxImJ13KkfuOT3Aio4Qiy1X4jiWmlSOv6/HoGgF/Rgw9t10GnBXMWaWdhkNofWyUiTq/S/v4rPNHS74ycvFTqZJyOi0oiUIM7cEnvmvMMa8WmLyGoDIA6+ltZT7YWzRintXrpqDit0qNx9/8csHVjWN1SeB7Ac=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5925.namprd03.prod.outlook.com (2603:10b6:510:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 09:11:14 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Fri, 5 Nov 2021
 09:11:13 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Topic: [PATCH v3 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Thread-Index: AQHXzwfgGHROvFVBxUSS1cWk9SZT/6vwAwkggAI6uACAAMOZ0IAAsqmAgAD3rxA=
Date:   Fri, 5 Nov 2021 09:11:13 +0000
Message-ID: <PH0PR03MB6366966631672FDD18926628998E9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
        <PH0PR03MB6366548C1CE5476989662F74998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211103200325.3416988c@jic23-huawei>
        <SJ0PR03MB6359234D6DA5D0CC58DB1113998D9@SJ0PR03MB6359.namprd03.prod.outlook.com>
 <20211104182317.2b448a43@jic23-huawei>
In-Reply-To: <20211104182317.2b448a43@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5URXlaR0V6TlRFdE0yVXhPQzB4TVdWakxUaGlPVGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEVXhNbVJoTXpVekxUTmxNVGd0TVRGbFl5MDRZ?=
 =?utf-8?B?amszTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTkRnNU9T?=
 =?utf-8?B?SWdkRDBpTVRNeU9EQTFOemN3TnpFME5EQXhOamc1SWlCb1BTSTJWR3N5Tmpa?=
 =?utf-8?B?dmQzWlJhRWd5UWtock9IRkhUMjVYTlRCdk4zYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTmFlVFF3VkVwa1RGaEJXRUV5VjNKVE1XUTFLMFpqUkZwaGRF?=
 =?utf-8?B?eFdNMjQwVlVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06be3b5-4f9e-440a-1864-08d9a03c3785
x-ms-traffictypediagnostic: PH0PR03MB5925:
x-microsoft-antispam-prvs: <PH0PR03MB59256C9B3BED2C5ACBB3731D998E9@PH0PR03MB5925.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvb1FONHKzJRRNEvR89eAIqg38WuuCuclL64aKpWi3YQ/KxNzaWnFBk/CXwx739ykMUV8N2vPuu5AVYd9aYalegUkvYvBMzr3NyaqipFxu3zyZiJE3/IfP0/lg+bIAxVz6ZVSwoNtcztV2E39cTlxugF55cm9IVC71y8gYS/VbERyb2nLu2Z9J/XmTRpBNQS/79MeZzuOkqwI7+GIoGWXKTY/b0dBrdVr7cb4+2l99FcRk6bi6gr+JU34rAPyxFd2Xeu0kIoi3RYApJZzoSZf67fyFp9oPfKqp5C815VumGML1oMrR2x5/ulvHhlsdjNjY4yHJoJUm1L5gkROQiwJo70NBUJ+t6dwoXtVhOaVVUXkzkNpK3lYjrfRxKGT6spp3/pkERkI03bqdrZQ3l2l0g2rGrWiU4CYnmQxV254MpACK41e/heMBA6Ne5y30OlnXc7U6/iGXB/d26TcJKN4ElHW1tziM7CyrgSO5qi4YBS1o8+8SYOXmrG58PrjGwN3BaUCayMdiFs0vkz1hM3fgc8dNVEupqaXtFnjd2KUsAt9cbjiDGXEM7LI2c0rZjcDlMrEdiV9czezjFnbsx2ItmmtyAokY0MM5XNQTh8An8g0Pjb/iJXvGdE7wv8zHtnx/TchaWeVd86U5mo07eFKJNDki3dmU0LB76Ny7la1T2YPS+ZDXiX4ECAplHoJzycoji+ZL4Gx8AGnAIhYGIDaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(5660300002)(2906002)(7696005)(6916009)(66556008)(6506007)(64756008)(33656002)(55016002)(53546011)(83380400001)(76116006)(66446008)(38070700005)(122000001)(38100700002)(54906003)(71200400001)(186003)(508600001)(8936002)(9686003)(8676002)(26005)(316002)(4326008)(52536014)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDdUUUl4US9jMEkzWThSbmJWbElvWEV2Q1BGQlVtS1dheWRvNzIwRnQ0aXdj?=
 =?utf-8?B?K1FrZVhFUzhCZ3RYMGtKY1d2aXE2VjJMQTNET2Q3Y1R3anJNL0pLcTZtNzJz?=
 =?utf-8?B?SVVDMGgrdWpUN3Rhd0tEdjlVQ1ExbkJIcjNOcm0wb0ZROWNLVlhPalROd0pR?=
 =?utf-8?B?Vzd2Uk1xbEN4UU80d2w3ZENMdkY0cGlGaVpEWUF2ejB1NDBZM05xVGt6YUxN?=
 =?utf-8?B?bmxaZ3psaDZrVjZQVHdTeUg5MG5RaXF5NmZkM25tSTA0emt0ejNYMzR6c0Yv?=
 =?utf-8?B?UnN6UHpjMjJOdDMxSDFEQjMxNC9NUjYxQlM4TDRtWFNxdnAvbWhSeHdoUnRZ?=
 =?utf-8?B?NTdTSTBTVEFTRlQwaHJUQmJMOVk1MXNrZkxFSVlVZWoxZ3drbjk2TjFqRElp?=
 =?utf-8?B?cnhDamhBcTVUMHgwcXFZbytsc2ZENmovRlJHVVJVa2xWamV6ZkxWaEk0azdW?=
 =?utf-8?B?dncvYlZmTksycnJjUnAvM0tueEpKekRsQWVnTi9WVFhQMm1lM1BPRW94YUJi?=
 =?utf-8?B?cGFFOU41cnNrZlVWaXR3L0ZkUnlMaGM1Vk1qM2MvZlB2SUhyQ2Q0c01CQzdU?=
 =?utf-8?B?dy9OSjJjRmxzWlNhTHNvaERnaklGWlN0dm41eTR2K2c3dVprQU1RNFhpa2Nl?=
 =?utf-8?B?L0xCRnBCSG9GcklsTXBTdGxLQWtmVkVHSWk3OFlYYUNRVlBEYXk2V2prblc1?=
 =?utf-8?B?aGVKMVljK28vMHVmWmo4T3JiOUs0SXkwbS94cWVHdityeEdCY05yQ2ZuWHY0?=
 =?utf-8?B?YXUySTBxc3piTjRoS2lBYWZUZXZscGlHZ1AxNm02dWMxUXh2NFZXMkd4dUxn?=
 =?utf-8?B?a1dwU1NYenFTUWJHRFRwQmk4Q2FBKzRJcS92TkhtYkI3QlFxN0l0clgvdGd5?=
 =?utf-8?B?S0JEdWorc2dYMFQvei9yZzdSb2poVzM5TkdrSW1TYjJXWHcvenZEc2djR0dN?=
 =?utf-8?B?VGxQemVxQTVZTHJmQURIbFpqQ0QvVkJTbklLUGxyWm5WUWZTUlBPN29ic3JV?=
 =?utf-8?B?OTFWaXFtVjVDb2RlSEJqU3hDbThPWFVJWnBIWXI0Q3FBamZkaW1NTEJXR1Bw?=
 =?utf-8?B?N2NyeFhyNnVDR1hJVTNOZVl5QmJYY08wSWc2b0hFcDZ6QlRIQ1VSanJuUVlW?=
 =?utf-8?B?NjV4V3JGeDNrTHRLT2tTL0U0TGxMU2c1c0VVUzlWbkxYbHVpdDRITUxrZ056?=
 =?utf-8?B?dFBRREZ1L3ZwSWdRTHhCSGFMdmlPemwvOHZLUEUrY0JEMFc5Z1ZDOW1LQSta?=
 =?utf-8?B?TEpnR0ZncFdTM0tjenVmRElNNVFZeUp2TDlkeUt2VmFVb3pLSTJSaSs4bEI3?=
 =?utf-8?B?dnYzUUNXOExkMFNWVWhpNjRVSEJyVjB3SitqVjl4MFlkMDV5S2t1eExKcHRD?=
 =?utf-8?B?NW1nZURIS1V1N2ZUcGxBcC8vYVBxV3ZxZkVVb3BlYkNGQXZKdDBuZXczQmp1?=
 =?utf-8?B?dFc2S28yWUgyaGJTR1owKzNOc3JKTm1YQXpGMVcxQ1NHQmlPMkhKZ3lBcXhV?=
 =?utf-8?B?QUJGTm80VTExTWpjcXpPUmFCN0g1V29OK1U1ZDI5cXF2TzNKSEJ4eDgwOG54?=
 =?utf-8?B?eFAzMUwvZWxXSW9xOXR6bEhvOGhydHVDUW5aWlB3SGJ0dThuSEFod1hrUzVu?=
 =?utf-8?B?M2NwUE9NNFZvRHMzZ3hsMnU5c1VsNURoZHJDdEZjYll0TTlYcWxmQWlxZWsz?=
 =?utf-8?B?QndKUUdBajIxYnY3bkc5dCtjVjRaMUhjMWMzeHFaeVNpREVGeWwrSnhscGxT?=
 =?utf-8?B?SkNFSDdIZGV2dG1qYVhKYllKVE5HMDJDMFlGbXZHZkR0bjJoc1J5OTdSR1Nq?=
 =?utf-8?B?K21BTGMwcllRMnJHQjBEak1xM0wvczFIem9uOVNub3laK1VGbzNiNmI5UDRv?=
 =?utf-8?B?TG1Raks0YlRUWFBWUWQ0RFZhZTZXcHQ5ZVpXSXlsUzFIQ3JBRzFQd2xnbkhK?=
 =?utf-8?B?QzdMQlVReXRwWmdlVzZ4UGl4WmxrUnFRZGJNWVBtRmpDbW5uZUZGWktwY0RC?=
 =?utf-8?B?MWNlY2JwaFhrczlmZlM1eTJDZ2hXZTlsdVp5dVM5WGIvK25ZUkhpYnJtS2lF?=
 =?utf-8?B?REU2U1pvUWFVT2k4bFdTL25qaG5peTJNRVFQV0ExRUJKL0xlekNBanQ0K3R4?=
 =?utf-8?B?YzlnQTFmREE2aE9RZkhtdzV2YWNoRVE0UDVVU3l2QXVqaGRPMHFtRk9hNTNp?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06be3b5-4f9e-440a-1864-08d9a03c3785
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 09:11:13.7795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzR6apiYJ8Vm9Qs3zOHXZ5ft3FcRJL4Y3xgGbpPc92LEvn9U3W0XImkCkjEUy8qD8HoX6n4Wefks4c6Na4u88A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5925
X-Proofpoint-GUID: wrqe6mGNjr9NTq3VAgZ1xwmiDjds1rBJ
X-Proofpoint-ORIG-GUID: wrqe6mGNjr9NTq3VAgZ1xwmiDjds1rBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDQsIDIwMjEg
NzoyMyBQTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gQ2M6IE1pY2xh
dXMsIEFudG9uaXUgPEFudG9uaXUuTWljbGF1c0BhbmFsb2cuY29tPjsNCj4gcm9iaCtkdEBrZXJu
ZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDEvMl0gaWlvOiBmcmVxdWVuY3k6IGFkbXYxMDEzOiBhZGQgc3VwcG9ydCBmb3INCj4g
QURNVjEwMTMNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFRodSwgNCBOb3YgMjAyMSAwODox
MToxMiArMDAwMA0KPiAiU2EsIE51bm8iIDxOdW5vLlNhQGFuYWxvZy5jb20+IHdyb3RlOg0KPiAN
Cj4gPiA+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+ID4gPiBT
ZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDMsIDIwMjEgOTowNCBQTQ0KPiA+ID4gVG86IFNhLCBO
dW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+ID4gPiBDYzogTWljbGF1cywgQW50b25pdSA8QW50
b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+Ow0KPiA+ID4gcm9iaCtkdEBrZXJuZWwub3JnOyBsaW51
eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgMS8yXSBpaW86IGZyZXF1ZW5jeTogYWRtdjEwMTM6IGFkZCBzdXBwb3J0DQo+IGZvcg0KPiA+
ID4gQURNVjEwMTMNCj4gPiA+DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPg0KPiA+ID4gT24gVHVl
LCAyIE5vdiAyMDIxIDEwOjA5OjE1ICswMDAwDQo+ID4gPiAiU2EsIE51bm8iIDxOdW5vLlNhQGFu
YWxvZy5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gPiArI2RlZmluZSBBRE1WMTAxM19DSEFO
X1BIQVNFKF9jaGFubmVsLCByZl9jb21wKSB7DQo+IAlcDQo+ID4gPiA+ID4gKwkudHlwZSA9IElJ
T19BTFRWT0xUQUdFLA0KPiAJXA0KPiA+ID4gPiA+ICsJLm1vZGlmaWVkID0gMSwJCQkJCQlcDQo+
ID4gPiA+ID4gKwkub3V0cHV0ID0gMSwJCQkJCQlcDQo+ID4gPiA+ID4gKwkuaW5kZXhlZCA9IDEs
CQkJCQkJXA0KPiA+ID4gPiA+ICsJLmNoYW5uZWwyID0gSUlPX01PRF8jI3JmX2NvbXAsDQo+IAlc
DQo+ID4gPiA+ID4gKwkuY2hhbm5lbCA9IF9jaGFubmVsLAkJCQkJXA0KPiA+ID4gPiA+ICsJLmlu
Zm9fbWFza19zZXBhcmF0ZSA9IEJJVChJSU9fQ0hBTl9JTkZPX1BIQVNFKQ0KPiAJXA0KPiA+ID4g
PiA+ICsJfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArI2RlZmluZSBBRE1WMTAxM19DSEFOX0NB
TElCKF9jaGFubmVsLCByZl9jb21wKSB7DQo+IAlcDQo+ID4gPiA+ID4gKwkudHlwZSA9IElJT19B
TFRWT0xUQUdFLA0KPiAJXA0KPiA+ID4gPiA+ICsJLm1vZGlmaWVkID0gMSwJCQkJCQlcDQo+ID4g
PiA+ID4gKwkub3V0cHV0ID0gMSwJCQkJCQlcDQo+ID4gPiA+ID4gKwkuaW5kZXhlZCA9IDEsCQkJ
CQkJXA0KPiA+ID4gPiA+ICsJLmNoYW5uZWwyID0gSUlPX01PRF8jI3JmX2NvbXAsDQo+IAlcDQo+
ID4gPiA+ID4gKwkuY2hhbm5lbCA9IF9jaGFubmVsLAkJCQkJXA0KPiA+ID4gPiA+ICsJLmluZm9f
bWFza19zZXBhcmF0ZSA9DQo+IEJJVChJSU9fQ0hBTl9JTkZPX0NBTElCQklBUykJXA0KPiA+ID4g
PiA+ICsJfQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9f
Y2hhbl9zcGVjIGFkbXYxMDEzX2NoYW5uZWxzW10gPSB7DQo+ID4gPiA+ID4gKwlBRE1WMTAxM19D
SEFOX1BIQVNFKDAsIEkpLA0KPiA+ID4gPiA+ICsJQURNVjEwMTNfQ0hBTl9QSEFTRSgwLCBRKSwN
Cj4gPiA+ID4gPiArCUFETVYxMDEzX0NIQU5fQ0FMSUIoMCwgSSksDQo+ID4gPiA+ID4gKwlBRE1W
MTAxM19DSEFOX0NBTElCKDAsIFEpLA0KPiA+ID4gPiA+ICsJQURNVjEwMTNfQ0hBTl9DQUxJQigx
LCBJKSwNCj4gPiA+ID4gPiArCUFETVYxMDEzX0NIQU5fQ0FMSUIoMSwgUSksDQo+ID4gPiA+ID4g
K307DQo+ID4gPiA+ID4gKw0KPiA+ID4gPg0KPiA+ID4gPiBIbW0sIElmIEknbSBub3QgbWlzc2lu
ZyBub3RoaW5nIHRoaXMgbGVhZHMgdG8gc29tZXRoaW5nIGxpa2U6DQo+ID4gPiA+DQo+ID4gPiA+
IG91dF9hbHR2b2x0YWdlMF9pX3BoYXNlDQo+ID4gPiA+IG91dF9hbHR2b2x0YWdlMF9xX3BoYXNl
DQo+ID4gPiA+IG91dF9hbHR2b2x0YWdlMF9pX2NhbGliYmlhcw0KPiA+ID4gPiBvdXRfYWx0dm9s
dGFnZTBfcV9jYWxpYmJpYXMNCj4gPiA+ID4gb3V0X2FsdHZvbHRhZ2UxX2lfY2FsaWJiaWFzDQo+
ID4gPiA+IG91dF9hbHR2b2x0YWdlMV9xX2NhbGliYmlhcw0KPiA+ID4gPg0KPiA+ID4gPiBUbyBt
ZSBpdCBpcyByZWFsbHkgbm9uIG9idmlvdXMgdGhhdCBpbmRleCAxIGFsc28gYXBwbGllcyB0byB0
aGUgc2FtZQ0KPiA+ID4gPiBjaGFubmVsLiBJIHNlZSB0aGF0IHdlIGhhdmUgdGhpcyBsaWtlIHRo
aXMgcHJvYmFibHkgYmVjYXVzZSB3ZQ0KPiA+ID4gPiBjYW4ndCB1c2UgbW9kaWZpZWQgYW5kIGRp
ZmZlcmVudGlhbCBhdCB0aGUgc2FtZSB0aW1lLCByaWdodD8NCj4gPiA+ID4NCj4gPiA+DQo+ID4g
PiBJbmRlZWQsIHRoaXMgaXMgdGhlIHByb2JsZW0geW91IG1lbnRpb25lZCBpbiB0aGUgZGlzY3Vz
c2lvbiBvbiB2Mg0KPiA+ID4gTXkgc3VnZ2VzdGlvbiBvZiBtYWtpbmcgaXQgY2xlYXIgaXQgaXMg
YSBkaWZmZXJlbnRpYWwgY2hhbm5lbCBhbmQgdGhlbg0KPiA+ID4gYXBwbHlpbmcgY2FsaWJiaWFz
IHRvIHRoZSBwYXJ0cyBkb2Vzbid0IHdvcmsgYXMgaXQgd291bGQgbmVlZCB0bw0KPiA+ID4gaGF2
ZSBib3RoIG1vZGlmaWVycyBhbmQgYSBzZWNvbmQgY2hhbm5lbCBpbmRleC4NCj4gPiA+IEFzIGZv
ciB3aHkgdGhhdCBpcyBhbiBpc3N1ZSwgaXQgY29tZXMgZG93biB0byB0cnlpbmcgdG8ga2VlcCB0
aGUNCj4gPiA+IGV2ZW50IGludGVyZmFjZSBkZXNjcmlwdGl2ZSwgYnV0IHN0aWxsIG1pbmltYWwu
ICBXZSBiYXNpY2FsbHkgcmFuDQo+ID4gPiBvdXQgb2YgYml0cyBhbmQgYXQgdGhlIHRpbWUgSSBj
b3VsZG4ndCB0aGluayBvZiBhIHJlYXNvbiB3ZSdkIHdhbnQNCj4gPiA+IGJvdGggZGlmZmVyZW50
aWFsIGFuZCBhIG1vZGlmaWVyLi4uDQo+ID4NCj4gPiBJJ20gbm90IHJlYWxseSBzZWVpbmcgdGhl
IGlzc3VlIHdpdGggdGhlIGV2ZW50IGludGVyZmFjZSBidXQgdGhhdCBpcw0KPiBtb3N0bHkNCj4g
PiBiZWNhdXNlIEkgc3RpbGwgbmV2ZXIgaGFkIHRvIGRlYWwgd2l0aCBpdCwgc28gSSBuZXZlciBs
b29rZWQgdGhhdCBkZWVwbHkNCj4gaW50bw0KPiA+IHRoZSBjb2RlLiBNaWdodCBiZSBhIGdvb2Qg
dGltZSBrbm93IDopDQo+IA0KPiBub3QgdGhhdCBpdCByZWFsbHkgbWF0dGVycyBmb3IgdGhpcyBk
aXNjdXNzaW9uLCBidXQgbWVoIC0gSSBrbm93IHdoZXJlDQo+IHRvIGxvb2sgOikNCj4gDQo+IC8q
Kg0KPiAgKiBJSU9fRVZFTlRfQ09ERSgpIC0gY3JlYXRlIGV2ZW50IGlkZW50aWZpZXINCj4gICog
QGNoYW5fdHlwZToJVHlwZSBvZiB0aGUgY2hhbm5lbC4gU2hvdWxkIGJlIG9uZSBvZiBlbnVtDQo+
IGlpb19jaGFuX3R5cGUuDQo+ICAqIEBkaWZmOglXaGV0aGVyIHRoZSBldmVudCBpcyBmb3IgYW4g
ZGlmZmVyZW50aWFsIGNoYW5uZWwgb3Igbm90Lg0KPiAgKiBAbW9kaWZpZXI6CU1vZGlmaWVyIGZv
ciB0aGUgY2hhbm5lbC4gU2hvdWxkIGJlIG9uZSBvZiBlbnVtDQo+IGlpb19tb2RpZmllci4NCj4g
ICogQGRpcmVjdGlvbjoJRGlyZWN0aW9uIG9mIHRoZSBldmVudC4gT25lIG9mIGVudW0NCj4gaWlv
X2V2ZW50X2RpcmVjdGlvbi4NCj4gICogQHR5cGU6CVR5cGUgb2YgdGhlIGV2ZW50LiBTaG91bGQg
YmUgb25lIG9mIGVudW0NCj4gaWlvX2V2ZW50X3R5cGUuDQo+ICAqIEBjaGFuOglDaGFubmVsIG51
bWJlciBmb3Igbm9uLWRpZmZlcmVudGlhbCBjaGFubmVscy4NCj4gICogQGNoYW4xOglGaXJzdCBj
aGFubmVsIG51bWJlciBmb3IgZGlmZmVyZW50aWFsIGNoYW5uZWxzLg0KPiAgKiBAY2hhbjI6CVNl
Y29uZCBjaGFubmVsIG51bWJlciBmb3IgZGlmZmVyZW50aWFsIGNoYW5uZWxzLg0KPiAgKi8NCj4g
I2RlZmluZSBJSU9fRVZFTlRfQ09ERShjaGFuX3R5cGUsIGRpZmYsIG1vZGlmaWVyLCBkaXJlY3Rp
b24sDQo+IAlcDQo+IAkJICAgICAgIHR5cGUsIGNoYW4sIGNoYW4xLCBjaGFuMikJCQlcDQo+IAko
KCh1NjQpdHlwZSA8PCA1NikgfCAoKHU2NClkaWZmIDw8IDU1KSB8CQkJXA0KPiAJICgodTY0KWRp
cmVjdGlvbiA8PCA0OCkgfCAoKHU2NCltb2RpZmllciA8PCA0MCkgfAkJXA0KPiAJICgodTY0KWNo
YW5fdHlwZSA8PCAzMikgfCAoKCh1MTYpY2hhbjIpIDw8IDE2KSB8ICgodTE2KWNoYW4xKSB8DQo+
IFwNCj4gCSAoKHUxNiljaGFuKSkNCj4gDQo+IEknZCBmb3Jnb3R0ZW4gdGhlIG9kZCBjaGFuIHZz
IGNoYW4xIGJpdCA6KQ0KPiANCj4gT3RoZXJ3aXNlLCBrZXkgdGhpbmcgaXMgd2UgYXJlIHJ1bm5p
bmcgb3V0IG9mIHNwYWNlIGluIHRoZSA2NCBiaXRzIHRoYXQNCj4gYXJlIHB1c2hlZCB0aHJvdWdo
IHRoZSBldmVudCBrZmlmby4NCg0KWWVhaCwgaXQgdG9vayBtZSBhIGJpdCB0byByZW1lbWJlciB0
byBsb29rIGF0IHRoZSB1YXBpIGJ1dCB0aGVuICBJIGZvdW5kDQp0aG9zZSBkZWZpbmVzLi4uDQoN
Ci0gTnVubyBTw6ENCg==
