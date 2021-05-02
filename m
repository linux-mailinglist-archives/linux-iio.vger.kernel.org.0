Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EFE370AD2
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhEBIxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 04:53:11 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:41186 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhEBIxJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 04:53:09 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1428oi3Q011155;
        Sun, 2 May 2021 04:52:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 3893m9hnyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 04:52:16 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1428qGCM012642;
        Sun, 2 May 2021 04:52:16 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 3893m9hnya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 May 2021 04:52:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np5X+dOmS9HrdlWTZiauoVSjl3H4OhTLAtBO/vh95hj/UqYjywtM0OfNum35Kj46FQ6A9sju3j46JZiFiLiwaCTGF2HZMs5NVrKF8VhYsbmFSYVJsFsXPpODZaj7YGyT+Kgp2B1CIUcyAAB0/aniRDNaYpjKsJK9e+EB4jlSxZOdnd025lC/Jnk0gah1rE/JL1yVWq99Mpv7e/tFQVY7QbVCIfeBmWU5dEWlwmpQ+GBbfMohpceI9JO5E2IxfYUuyz4F0fDseHoR/6PzdWGSzCCvI1o54rHGOMll7kT2SeOuxbaZAq6LgIbG6ceFaVilzbVV9T9L7eUCCnWDxMEliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT6wGcPbaKCueBjgLXs7rOPxIDakbTez+vVM0Ysdrcg=;
 b=DkksrotBvZEIsILURP6zEFEwR6f2Fu9p0AH5uVfphS5WT/uBtDRNka4odJMLEnKP75cREG6X8lu/9rKd3PPXaplEpIfecWJyXIEXtzS5L5VbvByv5WMHATKDwO6U3KBQCirG6KncaobfGwDAsZ+Jy29VGLn//WRQbLE6UwM3SL5UJT0mIpSC30Xt5hhOzk5D7aIDz9fx9DbcUvCc40BJ0eoJziCDoZlEyV5g7TPaxeffzI7Q2QyYIhEsnYa4xXqma5W9wSkCkv90qMZiyvdkgV4RB/RKfQ+VI7eWsxznmoReoX2Q1oJf8zxnvjsExHv3UcDcj0a5tbwRKMa0Z1p65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT6wGcPbaKCueBjgLXs7rOPxIDakbTez+vVM0Ysdrcg=;
 b=g2kZiI647HLLjaHgD07XSLPanzwJOES4xKbEFYY1nDjULOsqQ8GWha3rodRVftsCIRBS6ueGmwraw+F2xxi9oUtqyeUWtBIsscK8Lck+8ozRbTplaCIJehuS1bylPcBqd3sh9CdXTR9ZproZ00mzfv9X2zWNCCHgMqBxUE0+63M=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5815.namprd03.prod.outlook.com (2603:10b6:510:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Sun, 2 May
 2021 08:52:14 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef%6]) with mapi id 15.20.4087.038; Sun, 2 May 2021
 08:52:14 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [RFC PATCH 4/4] iio: imu: adis16400: Fix buffer alignment
 requirements.
Thread-Topic: [RFC PATCH 4/4] iio: imu: adis16400: Fix buffer alignment
 requirements.
Thread-Index: AQHXPq8ro2srGYXbe0SYHmAR2j2K2qrP4L1g
Date:   Sun, 2 May 2021 08:52:14 +0000
Message-ID: <PH0PR03MB6366C8EF61ED00F86FEF950C995C9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210501172515.513486-1-jic23@kernel.org>
 <20210501172515.513486-5-jic23@kernel.org>
In-Reply-To: <20210501172515.513486-5-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYWVlZGI0NWMtYWIyMy0xMWViLThiNDYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGFlZWRiNDVkLWFiMjMtMTFlYi04YjQ2LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjcyNyIgdD0iMTMyNjQ0MTkxMz?=
 =?iso-8859-1?Q?I0MTc1NDk1IiBoPSJkNFp5U1poSzNuSWVzMWNnNlhMSGljcXA0Mkk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUNIZkdWeE1EL1hBZDBWRitiRlFYYXEzUlVYNXNWQmRxb0ZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWJKUFNkUUFBQUFBQUFBQUFBQUFBQUo0?=
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
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJoQUY4QVpBQn?=
 =?iso-8859-1?Q?BBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFNUUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?iso-8859-1?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?iso-8859-1?Q?Q0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:248c:fb01:54a0:16a8:26c6:a233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5722b0ae-7a0c-4f25-b977-08d90d4794fc
x-ms-traffictypediagnostic: PH0PR03MB5815:
x-microsoft-antispam-prvs: <PH0PR03MB5815053D6E550B9FB24CCBCC995C9@PH0PR03MB5815.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JdYuMEXrEB+36k701lyMpakmAiODqNMokj8VbnY/+BUGDr7hcPSSU+jYAlDVpyZHe7OO8VHY8ft9zA51MUNt2/OJx2jCEhuJMcLdJoU7BUtBuQVZZ7PvdqxIE22GCHrXBxPjSCzAZpmTPZKQdllnipz/Ug8mCsipxA/5dQRYJfEgH0BSixnRXcdsVj4yZg20/uPybS5Pskx5ntKUBBUtSOUAKvLYAtl/KqK5JJxTmruioIDk2oL0GboU7onS3yPi7gT3M7j+TzjQeuLW/jx1Rik0K8+0O+LO5Yvm0uWq7MtbKz/nqRHVRoFsUzIZhtdTGBIJxpn8nPYvSc9ysFe8M6KeYZpTdKBe4HwxRoz1g8m1kooQrbZX8KPlRjo4yZd9rbPt/lnMOc/qi6s+qt4oWnd8rdgrInGI2FjUOOvPeDkX6wiLBvrfTw0hJOgkPnJBca63+UDJZxnk0WB8VSVKkRSPiVRpk+NeCKDaNASYtm+YKFpGxZxdAALA36kePtPAHSlTa6d3P9U/ikI4JJ7LdGg8KS288MvuIOYj6/zag3afnpVy4HLjwWqs3tbKVP2DXW4nS4IFcf7HUX9lh736EQnuR4G4Jx2aa5/NwILK5Gg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39850400004)(4326008)(76116006)(8676002)(110136005)(83380400001)(86362001)(5660300002)(52536014)(6506007)(7696005)(316002)(9686003)(71200400001)(8936002)(2906002)(66556008)(64756008)(66446008)(55016002)(66946007)(53546011)(33656002)(66476007)(122000001)(478600001)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Yv4P3DLmBsv9SY+FtiE0kC7tL+MGqs8CrUl4dp9IFmLRXMf6CPBCqGGkmQ?=
 =?iso-8859-1?Q?8lrsUDUI8uDEDy0MUdq55aoqmQh1U3tehKrIp8N3E66Cmdwsg0kfvFRRNf?=
 =?iso-8859-1?Q?CJ8Sdh8u/J9vKae5sACEqHjUOa0W3HIwzgH/X25QagIoSmj7aACIXJVkgJ?=
 =?iso-8859-1?Q?2zD/wpDpTQ5x5KowhZCvhXFt4CqNlbaTuIYvGQAoIDWeY1a1K4SQQC7wRl?=
 =?iso-8859-1?Q?BqgA89N+rUqD+v5FOjzK3XraW+Li85m6/nCdUsXiok97q26ypGlMAfdo7n?=
 =?iso-8859-1?Q?mKPm8TTVhzxkc2KXCh2L4DviiPjTz0zkbhjde62nlMLzT5TpDEjnSXzrY9?=
 =?iso-8859-1?Q?B5OKEYX2PItr6cLFs0jFswxEmFF7NONAd7JF4cok7EZdp7MZGSYm7cBbCc?=
 =?iso-8859-1?Q?HdOsL8/2IL/EzNMHMWNuxuizAHJHOao+FlVR9Kdbtx2cMisYR+ueFUn3yC?=
 =?iso-8859-1?Q?daCJEDmmooMcB2kj2mZNfqRx1mG5Q+avH+2zOQOElK7j2o201adrYh8Duf?=
 =?iso-8859-1?Q?z5znfc2VqxKT6oPYe+vIdVovxhUSR6/GidzuM8pQsIauV5ArMZrHkRazOn?=
 =?iso-8859-1?Q?H0dz9e4adgJRoGUlIjRrcDJvOz89CRRbaIdCAT9+7G7gMVUoefdINIygHj?=
 =?iso-8859-1?Q?fcb0Y11+2nOl6L4KNDvh8EdkBJC2NBYvB+8kl/qAeZVR6dBYeRQyjTbA0h?=
 =?iso-8859-1?Q?nE6YE4EtOqJKG2TfkI0J+qU5uHtC9FXZGvmlkZFq4vVX+iG9AnPmyyyr+h?=
 =?iso-8859-1?Q?BlLhiF9a8UiIZLpZZn/x2XkG1bG9N/rXYotJ36Mbivo+MdQbIbG4jyMcBr?=
 =?iso-8859-1?Q?/Vm76Mc/frSVf/qg84WaQrSxufl1IfRX3Kqhc72riA03+igLN1/Ge7R8m/?=
 =?iso-8859-1?Q?ob5P+VFnWwtIHnQGiyzEOG+BDo234rjzH4crKWkCKGEm9RfZEYHZwJgzDR?=
 =?iso-8859-1?Q?iwzWkyUIUrmpViSftc3QOpT3EMjgIsLyxXsQU4IqAXTfb6esquchUmkjv9?=
 =?iso-8859-1?Q?o2rbw5XUfiNQSl0NcgUTpyeg3fx9ZcZk4lCFLRylt/cMPERDyY7GScWipu?=
 =?iso-8859-1?Q?tW5qXjh2H2dshUJS7ah/i+29Ef255w3GOV7Lx/GFiunqTcExyi+wNHv3Y0?=
 =?iso-8859-1?Q?zBQbNjf/LJU9rumLnU+Ec92RgPJiW69WCG57nr6uiucEtINwYoYqUZkr4m?=
 =?iso-8859-1?Q?spM9nOvWhDErjScBt5kwTFOR1Y+pRaFOrgnZWJPNnSaz5nikY0SWgY2KbD?=
 =?iso-8859-1?Q?ZerLSdh99skhqapPtDoYlmsEtjXht6yacxElhtPJtV5M0zaK17dK2pmKP7?=
 =?iso-8859-1?Q?te6ptYax+zd93bl9edCrMjDLmdJ21XOWA9zs3BivWR3Kui/fkX4lieY92A?=
 =?iso-8859-1?Q?u6S3TSQaFDveJr66B8XnzgaOaWMyNjQPLUrysoMAyDuL+qG859QQ0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5722b0ae-7a0c-4f25-b977-08d90d4794fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2021 08:52:14.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYcEkFNTOBfooQa/+uV7YspC0ZuTAHVVo1RoQq+uaLrkqLS6KBAcQ6EBXRgFu9Ft2hDbcrmC4VjkvKH8ZZZblg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5815
X-Proofpoint-GUID: hc8LWneom4vOTfRNEIgyWoGkK8Wpzo4s
X-Proofpoint-ORIG-GUID: -CHNtW3pOLIE4BIx5YHoZ6E6zkdYdVyj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-02_02:2021-04-30,2021-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105020072
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, May 1, 2021 7:25 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Sa, Nuno
> <Nuno.Sa@analog.com>
> Subject: [RFC PATCH 4/4] iio: imu: adis16400: Fix buffer alignment
> requirements.
>=20
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> iio_push_to_buffers_with_timestamp() requires that the buffer
> is 8 byte alignment to ensure an inserted timestamp is naturally
> aligned.
>=20
> This requirement was not met here when burst mode is in use beause
> of a leading u16. Use the new iio_push_to_buffers_with_ts_na()
> function
> that has more relaxed requirements.
>=20
> It is somewhat complex to access that actual data length, but a
> safe bound can be found by using scan_bytes - sizeof(timestamp) so
> that
> is used in this path.
>=20
> More efficient approaches exist, but this ensure correctness at the
> cost of using a bounce buffer.
>=20
> Fixes: 5075e0720d93 ("iio: imu: adis: generalize burst mode support")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16400.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 768aa493a1a6..c6d03a37373b 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -663,13 +663,23 @@ static irqreturn_t
> adis16400_trigger_handler(int irq, void *p)
>  		spi_setup(st->adis.spi);
>  	}
>=20
> -	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
> +	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT) {
>  		buffer =3D adis->buffer + sizeof(u16);
> -	else
> -		buffer =3D adis->buffer;
> +		/*
> +		 * The size here is always larger than, or equal to the
> true
> +		 * size of the channel data. This may result in a larger
> copy
> +		 * than necessary, but as the target buffer will be
> +		 * buffer->scan_bytes this will be safe.
> +		 */
> +		iio_push_to_buffers_with_ts_na(indio_dev, buffer,
> +					       indio_dev->scan_bytes -
> sizeof(pf->timestamp),
> +					       pf->timestamp);
> +	} else {
> +		iio_push_to_buffers_with_timestamp(indio_dev,
> +						   adis->buffer,
> +						   pf->timestamp);
> +	}
>=20

Hi Jonathan,

This looks good to me although I think there's some stuff to care in
' iio_push_to_buffers_with_ts_na()'. However, for this patch alone:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

I will also check if I find any HW to test this...

- Nuno S=E1
