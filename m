Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08B61345F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Oct 2022 12:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJaLTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Oct 2022 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJaLTR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2022 07:19:17 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AA8DF21
        for <linux-iio@vger.kernel.org>; Mon, 31 Oct 2022 04:19:16 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29V8hVxr022865;
        Mon, 31 Oct 2022 07:19:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kj640hncx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:19:13 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29VBIC4Z021096;
        Mon, 31 Oct 2022 07:19:13 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kj640hncu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:19:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIuLiym32RtmFav8jhdcDMo+cPWZMUZIZJHQnxQJaG3N71HklurhEntc6ew3wumSWTnLxNdWXf7VWbfzAeAHF70t3TCZAkcv5m+yT4G+tozndWkr+o2KVCRl11/CTAYzpsMyvwQ3ljDpp0Urqm012qx45kADBDzsXH8qSxTlmZ95Z/m8Of7nYnra0tXVs7SwQ3YhsqnwimA4DT5oQ8Pt+kRUWA2k60WR4cCm/NtqTHIkyZCrbQvPEVKpRS9f6O5+ulsPb8CH9OvSq6q0pAGpItEeeMnMbGqviJHCdE6kkLVbXDoeqsUY78S2uFbncC3/fRkW7tRgrDh7M7JpPizZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGGG3DLCvsAz1P0eXpaTFpDBnGyydpPS/uPtWt8o5Lg=;
 b=j4hLXzhWq4oH8mYOjAyFSvFa68szll2KVjL7Zytd8pw87Et7RfqA/G6JJhUntzBbkxEIXl9vCeG8fTJqLzDyc7gemZYMTaUQ8M6gBC8eER3hvk8oSFxrDcAUQ4zvF7sxAIcpG5roTDW6QJFIo/2XHaXU5470pxOQzqNO9n2oXGzR+zU+Km3McquzO3/giiRYK97qzyyzOiAvKEm/yIyQ4xPL7vRk8dHOog1c3RPCcYXCWsJcYsWEZwDZIA6vNBEvuRVReSB9Ukuf4NoTvlD1mAI/82MPo9nd79o5GidlFy78CbAF0i93JFsKJzuISeL4s/EWMzjOdzLhfQsAwZfK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGGG3DLCvsAz1P0eXpaTFpDBnGyydpPS/uPtWt8o5Lg=;
 b=0OtzkAhHFasXW5fsG4DQOekVjiaIsl4PW9n0RFzQIgnBtWtS7jro1rFv/jvkdQ/wHTrc4Y4At6nKfx8sFwGdXW2jBdJ8+xqst6EUIqryZy2DJhhwEfstrkMlOnijwLVDqHYmxSAcBi9Zh3FY3VC2qhcwRDEoUsqEEPPpa6HDUCM=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by MW4PR03MB6635.namprd03.prod.outlook.com (2603:10b6:303:12a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 11:19:11 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 11:19:11 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 3/5] iio: adc: cc10001: Use devm_clk_get_enabled() to
 avoid boilerplate.
Thread-Topic: [PATCH 3/5] iio: adc: cc10001: Use devm_clk_get_enabled() to
 avoid boilerplate.
Thread-Index: AQHY4YIsoQg262Yu7ESKLI8ytOc6hK4ocdPQ
Date:   Mon, 31 Oct 2022 11:19:11 +0000
Message-ID: <SJ0PR03MB6778B605014E575AD11C02E399379@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221016170950.387751-1-jic23@kernel.org>
 <20221016170950.387751-4-jic23@kernel.org>
In-Reply-To: <20221016170950.387751-4-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZDY0M2EzYjUtNTkwZC0xMWVkLWI2YjktYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGQ2NDNhM2I3LTU5MGQtMTFlZC1iNmI5LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTU2NyIgdD0iMTMzMTE2ODg3ND?=
 =?iso-8859-1?Q?kyNTU3MzY1IiBoPSJxN1pXRUdkMTlwM0k5WjZSVFkyN0dpTUs1ZFk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUExZXBtWUd1M1lBY1MwZTJnUkNZcEp4TFI3YUJFSmlra0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|MW4PR03MB6635:EE_
x-ms-office365-filtering-correlation-id: 73c3778a-575d-4adf-077e-08dabb31bc61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0BrBrJuNDvJEi9YpQcHVN5wU50sI9nAIyGn0Rmw0WRpaJCjhO+pqwoCr1Q9LhQ89fvp6Tw5vtlS3O68qhcKHgIqTaBAOoK3QNnak4CDORnJLU73lAW+iIf0wlNW8TXB4U2E5ZnZ36JOcaMbVST/1qjlFvQNrcjsgYD5bxjPsA3mwGF3Q9uv/Adw/HuGDd4AM2FhuW7+AQVqVcHWxCXRwGeACcXlCj0KTa4wipdy+PSIREvJC3EiWiAOFRpHBxI4FNAxNr7vH9zMmxnOXnK5B7Zou/Dor7CID3XNnLRZpwYTItKytbSCP1bdVIY9rC/3bCN9xcpC8nU8csc+8dN4hQirollkv5Vjh3q40NjujBZ/5Owx4fWQPwq1YF/sFBgeNUtDcxYzP4wzE390Z4ovDRRFTg7RPydIt9Tjia/yaWAAfN2iaFrCQe/9tg9oaDb1oXnIOb3R0D1EMgxmXTkoxp5k7LJLbO6AzHM2K9rUg7Tt2sqSZIul9jBp97RRwx/HuFV2ljVTQNgoflTPeiz0qbUQHiMCjE92X5/xHPMBFyOE+fH3kNHBXL04ftf5182ohVpVSdCJHl29+/pM0zuHjZ3654+LldaB8d4HS064VyZCBrzprhw5ixyUDgf2bX8dwCPscSoNKdGHyih0MMvCPH76WUULRGo1gDa4dOQBEr+ApXDPQpT0fVdn8BRvkFYhpDb5n8sgh6NsrauHbKgAs4kSeoiH5DwO3ekPUvSVkotRA6utuo6TyMS0unsvH8kl5BNTHFvVNUyJRHB6x8FyCCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(38070700005)(55016003)(33656002)(86362001)(38100700002)(122000001)(110136005)(8676002)(316002)(53546011)(478600001)(7696005)(6506007)(71200400001)(9686003)(26005)(76116006)(41300700001)(8936002)(5660300002)(52536014)(64756008)(66476007)(83380400001)(66946007)(186003)(66446008)(66556008)(2906002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FTCQ/I8FgYFp/2+2iF/o+8bfL0P+vqwdGq6QPvnHQpQzIXoyKN5/xumIGP?=
 =?iso-8859-1?Q?NxK2iCDJGkwVuxk00uBVgca2+GVgAzy2f19C3QQYlK0SzhFvpdv/1Bd++8?=
 =?iso-8859-1?Q?UaKTer7VCsFp0KtPqZphulvrM8sjFeALfX/MzzQWkN1/4jDUsDMDq6srQw?=
 =?iso-8859-1?Q?1q/EvjXJ8pB56i/6Cewzm5OulsTmL8cKmuxnLGOW3gr2seXbRzT3Lt1Pz/?=
 =?iso-8859-1?Q?2+ZuzeeJxBH9drqnK2YmoQZuGVw/LlCXgeHU3qVtcLK3d82MnrM40Oy8Kl?=
 =?iso-8859-1?Q?t8j/B7u4n/gvRvGyUwWCDfGJ1LfBIUH6+9ZVnEXAyeVs5XIKyYDp6ECzu4?=
 =?iso-8859-1?Q?cijY4DbBopfH3lYsjAGMZU6nHYXXJXMqDcnBFI8lzE+TjdGLABcyd6B0BD?=
 =?iso-8859-1?Q?U2iyb66CRb/AzLjo0jcaqhD9mDcRs9r0ssU/PjxaWfgzz1hGAQI0aDYHYN?=
 =?iso-8859-1?Q?DHVIJw1HBU3jepJaKshIzcSBlbHVRYZ6Zs59OVad6r55ol4R+S6WPW+lQs?=
 =?iso-8859-1?Q?Dfr29BKz6DifRF1I4mlkofxQYg2a7ZcxgakFUBovAh+piQuMUptDQLu0eK?=
 =?iso-8859-1?Q?QMqCHwtG3N45/zbPPw4D3zWFUFok3z5u+kDEX5XeqHQtSva0C8ZKQA0NIN?=
 =?iso-8859-1?Q?VqYjUL5B2+/yPL442VasbxZCC75X/GzPyJmCXWgTDToYT928FkccUTb3Il?=
 =?iso-8859-1?Q?69ZwY7NCdyHO24MxX650/Z41Nm3c5iR/p4W49dDqqdKmoUfXPUUo2mDbGt?=
 =?iso-8859-1?Q?iPCefOZ6uphXcpaitASm/2ZXOdNSfJHp5Mv6kCLijC8pLZbCjgpKDz7cp0?=
 =?iso-8859-1?Q?q6+Rl8GfZBv6Q9AvznWueNuwuvL72zgOGkItKAx61hKq9GzKi8crMdx0g/?=
 =?iso-8859-1?Q?yBXJMH7xJ/0dCkPHlDmppEHXybFdqkYt+9/2KOvqemEI4HN0WWeh2LKhFk?=
 =?iso-8859-1?Q?tJ0oGl/EWH2VY17kEKKLR0q/uoVMKOmmIchHNCo17jUdVif3VKFRgFCleM?=
 =?iso-8859-1?Q?o5IOBIK9gcQKxz8r89I6JKAYvluR0OYYXJqF0jgbNjour4acIuqlMQsW0Q?=
 =?iso-8859-1?Q?8cnRXQh/oi4MX/d4JPdVlFBjckGzOzCZBW14l5ejh08da4PvHBM5+Y9rQn?=
 =?iso-8859-1?Q?mnZkL8zalCWs/XkLmTBrxha9eBiZ+g7A8pqDRA94ofwqhzgM5/xcbykANz?=
 =?iso-8859-1?Q?c3115mCGsDFjnpsLxC5BO0vatfTQo1gPL/MX7zIwVAdVUl0UNgWu3UoU8w?=
 =?iso-8859-1?Q?WPOnJVOhQvChQQRzjnFVrvai7RLYVibP8xUlNuB8HdbVKEdYdpGbE9TshN?=
 =?iso-8859-1?Q?Zc0lyfAexcoyfk2S8ZhaTVgO/s7CtnHGYXFIAKfDvZxTk6YKFrO+JTzscA?=
 =?iso-8859-1?Q?SZM5Mren/5AG0J0fYAksHyfh0FvYax/h1cDGYxxcZSxoAv3Fa4qZjY+w9l?=
 =?iso-8859-1?Q?lVUZwVMfPTut69PnkyoXLnBRnYGtAhMa73yppvQq7KPUpXTau90FVux4GI?=
 =?iso-8859-1?Q?VbruT2Mmj4PVz8/RJtlgdvQwWULD50tKWhMlksB3pFAVm4Nan8zytksBNK?=
 =?iso-8859-1?Q?bl/K2QCQ0NPTIOFo2LBm1gquvSzoOByIr/JchfQ+h9HrjfeuTM/Ojbw2hy?=
 =?iso-8859-1?Q?SNuGRGaKZKyMS/uHpaCSVzbQlcpyk41zLK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c3778a-575d-4adf-077e-08dabb31bc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:19:11.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWCfEfkxUB/9ihOVmPrZAS8hPC2O6v/qYWH5tp3sY1j3W1WnP5cksSTHzj0IkUaxJQu4mQnDla2/aTJbsjbVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6635
X-Proofpoint-GUID: C3kFMa8j9XgckMv22MZG0z90bd9K_7gV
X-Proofpoint-ORIG-GUID: 2R3cjBwADKWltsdGSxZh4gXmLcVnnl7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=963
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310071
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, October 16, 2022 7:10 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Subject: [PATCH 3/5] iio: adc: cc10001: Use devm_clk_get_enabled() to avo=
id
> boilerplate.
>=20
> [External]
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> As this driver just enables clock in probe() and disables in remove()
> we can use this new function to replace boilerplate and simplify
> error paths.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/cc10001_adc.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.=
c
> index 4f42ceb40ded..332f0e06369f 100644
> --- a/drivers/iio/adc/cc10001_adc.c
> +++ b/drivers/iio/adc/cc10001_adc.c
> @@ -352,23 +352,16 @@ static int cc10001_adc_probe(struct
> platform_device *pdev)
>  	if (IS_ERR(adc_dev->reg_base))
>  		return PTR_ERR(adc_dev->reg_base);
>=20
> -	adc_dev->adc_clk =3D devm_clk_get(dev, "adc");
> +	adc_dev->adc_clk =3D devm_clk_get_enabled(dev, "adc");
>  	if (IS_ERR(adc_dev->adc_clk)) {
>  		dev_err(dev, "failed to get the clock\n");
>  		return PTR_ERR(adc_dev->adc_clk);
>  	}
>=20

I guess we could also tweak the err() message as we loose
"failed to enable the clock"...

- Nuno S=E1

