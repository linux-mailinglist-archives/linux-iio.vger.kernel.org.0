Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F894EECDD
	for <lists+linux-iio@lfdr.de>; Fri,  1 Apr 2022 14:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiDAMJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Apr 2022 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiDAMJX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2022 08:09:23 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61852276FB1
        for <linux-iio@vger.kernel.org>; Fri,  1 Apr 2022 05:07:33 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231AWIoI003766;
        Fri, 1 Apr 2022 08:07:31 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f5yqsggkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 08:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4bQTBocGNuTkoi0CfRvBjHnGUQ68sEnhsra1p+6WXNjjR52zcFvj9dFN+851/McMG3AHdcAncKyN+1rG5YMjToImatEkRoXXXkOeSlN6OkgXmMZ6yAaJWZk9TuMZFbOuQRmFeNtTCttpCovfgbO7jBQGz+RFCAyNHFrM6v5kTWbG1GWqqPsFoXcCNcJekOSqbRld9xnTYT82yg6K5t1ZNvcfNgFgjFA7SW3NIwVsnWjsm5AMTXkKN9p92w2wt//O0xIP+oexfEw3InLVSZFloOZesCltGnidas2T4rAFc7odu+SBxQA6Iebi7sF+PPJKI3eIOKdoIEMNQj3yI2NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecBs2q3ln1sGcnLyaRseqU13n2S2ZnJg/xQ/qE7oU6o=;
 b=C3BP82JMGlnz9NtSJPWwsM14csVUmkic3YGdGKWCbaLSZulk5FIiPVHCwuKGHhcOzMFrAeRaem2V0GzE/MTwVvrateUoYwx8xstY5jIl3AjWEtvFiIVZ1xYPAGq3B3kvcmHXNS3Bk0QuEJcY3WcgX9y7yPWoVrWecZLxV6YYHn08bpiXjZBCn5ruPQG68LwPGCH0TqP+emiMFFLammuehxCj46vmXPPXWbXpQh4+0g0miJCkEBrLjbce1nNmejNrmHnCyvtJ+HwoykGGr+BrXLvpRkES7EXIdfOLqA0IuYHJN8E6/kd8lZ2Ke0rEDk+ze6IGJl0migtXprDTbcBX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecBs2q3ln1sGcnLyaRseqU13n2S2ZnJg/xQ/qE7oU6o=;
 b=tuBZleqycUDkdsAKtuz3YBpzZXsmW7YSJujE1TLop9umF8Bm3vVN/NL2OukzNPNKVTybAWulA4AEFjR1GLVB/zf9gxc0NQgCudV+W0VY730qLKQxgqilTp2zMuI9zjJGHBpS2/4Y3ztv1IKncFKwaP2t9nwAn7hK4KXvVRfttMM=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6769.namprd03.prod.outlook.com (2603:10b6:510:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 12:07:29 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%7]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 12:07:29 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [bug report] drivers:iio:dac: Add AD3552R driver support
Thread-Topic: [bug report] drivers:iio:dac: Add AD3552R driver support
Thread-Index: AQHYRbAve2fuiJm1r0+0COa6n+2mZaza9aEw
Date:   Fri, 1 Apr 2022 12:07:28 +0000
Message-ID: <PH0PR03MB678655F6A13F9AD82853FE2199E09@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220401100601.GA29860@kili>
In-Reply-To: <20220401100601.GA29860@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNGIyOTlkYWQtYjFiNC0xMWVjLThiZDUtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDRiMjk5ZGFlLWIxYjQtMTFlYy04YmQ1LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTY0OCIgdD0iMTMyOTMyODg0ND?=
 =?iso-8859-1?Q?Y2NTAyNjMxIiBoPSJKSjRuanR3MjVPS1h6dUljVzZVdHNkMnRLRUE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURuQzVnTndVWFlBWitBQ0hDaW1PYjluNEFJY0tLWTV2MERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
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
x-ms-office365-filtering-correlation-id: 2cdcba49-7c6c-4a14-3efa-08da13d83178
x-ms-traffictypediagnostic: PH0PR03MB6769:EE_
x-microsoft-antispam-prvs: <PH0PR03MB6769FD84B07242040520AB9E99E09@PH0PR03MB6769.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jk+4BrwL0aJ4sEx9lkNgs0jlPpAL/ZitQO12HofGFqgTWPNOrdqnbXzjLfsBZJrA+ZWJROQDwycMSTsKS7h6S9GvxWbRiHBI9lyxSveMOVJbL+Xda0SV7AKlGNU97e7jAjKD62CJv0NgvmqDi6z5bekduneBK46JBIyv87cBgaoioZYx36qeObDRS7TrjwVPO9vU9Kx8oR+C9AcOBtONGwM4+ienr8ZRc+JDgXoGsgzCKZrF8usnF7iasfG7A9CnZ0ObJujJkBY0tKH2CJNCVjeeXYk9yAzezSx+XRDBshvH2A0TsObuMcKaBfczSOARbTXvh3jxecexm6kaXubAK1SLjQ7jYaQGRNa7HHu+4fBLfqlsS8TjkPG1yY8f9d69k09lcXto8oYKN96VYwLBL+juiGCeGMNfOGJI/pm4aHh7sK8QWV3F3xtL7VJn4869knOqOifyJFukvXQCGWfo9ghUGQeEiDdIo84gFRtrj0JA3bmylWNxfbfcGgpMpCjjxfcTuDHbED2RVkQMVA2RxxYnWdYN8j0d7kyWNMspSwI7cV2DeCdg6OsFzgQJAmk5njs198K9ETSmWEr+CvwYefHlMDJWbTDdPxsD3azmGQrdR17vE3yl8FWq7Od1gzX2FLi9BqsgZNwA+0efhWEoL5f8i68PmwPt5CvzfDr7yuBzGLZkgKpl3NTSvR2dFxqriK7Zmp85+WZyxirZ8WlhPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(8936002)(86362001)(71200400001)(6916009)(316002)(38070700005)(38100700002)(55016003)(508600001)(52536014)(83380400001)(6506007)(9686003)(53546011)(66446008)(64756008)(8676002)(4326008)(7696005)(76116006)(33656002)(66946007)(66476007)(66556008)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xah8P3elaC6ZCp0IIXFi7gP7xNtMp06wGoGC4cIOuH6QOpMVBwy2cKiXn8?=
 =?iso-8859-1?Q?HszlyUdgr8OW/mwKajkrnE/jRN80WnIOOCxRLpv0nh9PyFlAbvNW6BOqfA?=
 =?iso-8859-1?Q?GXdQF79fpyIjSFw9bsSm1Yza2CAEyAMcIOhAieMSN8jaXoj3GVFdCBPbxA?=
 =?iso-8859-1?Q?PjLDOlwKcJ3/aKB87Bw6KeB9T/b8iYy8WeAcc8UJ2AUGr21o9CiJ/nLTrB?=
 =?iso-8859-1?Q?yt4VmY6AwoXYEOFp/8ZPMkuNYq1VNusBLJA13KIUgGDvX6h+g5/b8jjwiK?=
 =?iso-8859-1?Q?JDIlMulGS4grwqkC6Hpt2PkRhWW2W7PRDN7asqeoEmrNcCq8Wmu7Z8fHR9?=
 =?iso-8859-1?Q?sZFZz71vjWEeD8UAyfS+AzWKIkNsAKWvUbH/6ievH2lw7hqcHYfW1ypcJm?=
 =?iso-8859-1?Q?3PxYSyzafvv9TazUJSdXCC3J2UGD2X0w/6y8mTXqtpn6DJTOalwhfAV5+U?=
 =?iso-8859-1?Q?CrVbmemp3P8EgV1XEcq9gkV87SlpT0pMbHpFLZg41R0Mt3WZnNmEtKqwO2?=
 =?iso-8859-1?Q?4zoqBmV+uUA57QccRPX3lSzuGr8qfq1HBZnMJ7RWuY0UMG/Kt9R5CEL9za?=
 =?iso-8859-1?Q?cJ4s+RwfgTntmUg4hfhGGTnRQJetMrb7WGrnCROgiSwblwKt6jwdfHcZ3V?=
 =?iso-8859-1?Q?vpSxDEjDiCtb+sv/NsUdVTYv/P2cG6EkvlLRcSIIUjYOKRGJ0fmRwGZxCp?=
 =?iso-8859-1?Q?5J9luORK/iyajSn6YV6Q2QTasd6AdzTbQWBIdV6JWHdHupjl643t8N+2y1?=
 =?iso-8859-1?Q?JSfvNPTdtnsWpS+21N5gPXLzJEx3nYrDVm17yWpzNxhBcFeCYET5c9lFMa?=
 =?iso-8859-1?Q?1bmgGrxYdDfFgOCkl+1mlXAIMDSDvEK+XK38vT45GHDLshpdDniq9EtaUB?=
 =?iso-8859-1?Q?E4PDIpvu6KaRH3DXorznAsnblfDBZVrmLWUKfA2HXsmOW/+mCUxfW5+9hp?=
 =?iso-8859-1?Q?9rLRcvOM1eOsqNC6F6sg8FpcyuhJtvH9fvvpEjH5vJuhXpDaxWjwZFNIx/?=
 =?iso-8859-1?Q?Q5+EfGw3SvZFkxVG2mO3o0oTVT/+aPfGcpq2kZQ4eZ0otdFKzBI2acavMg?=
 =?iso-8859-1?Q?O7dMy8Lhsap2yG+LAXq+KXAgGkEuH/jo7xDQ7R87XRRE904NsSQllYZnNO?=
 =?iso-8859-1?Q?CjCxYQIG8XfNo0qDGcaYgjtaBzHQ7ygEvTqMQuqbaLsmohHl7EbonbUR3X?=
 =?iso-8859-1?Q?O4gkZCqoaFeg+68U+wBUcoXI2O3Dq23ZHr976Ehl+h1Ud1NLJ0NY97ADUD?=
 =?iso-8859-1?Q?63LjqGmUBU7NDcuTHbNiJyFodgXX7jH6Q26YAsPPvaCUelgkd6+MB/NVeJ?=
 =?iso-8859-1?Q?GzgXFjOeKjjDXqOulOW8OANo3CeG6erly1N2mlb+CI4gQMdQxHnRkQv/9N?=
 =?iso-8859-1?Q?fe/2rOLS1aJK32r9k3hPwb4J7XMIUzrUVBXVDzc6Qx4GRIN7B187QYQlxN?=
 =?iso-8859-1?Q?/JDSfvss/cFWAKJlFADMhJOAPrgkTfc1b6bqJgbBqWBgCkXntJSy0TBAZl?=
 =?iso-8859-1?Q?o9oQ6lmRQc48rpurLiNXkQAm2moF6ms9QzZ2G/uBSZkXYyFKAWmnQEMKqt?=
 =?iso-8859-1?Q?cIbcQIS4jjdCzOBr87TzghtezXcjTKMA0ckWmxgdTPmgEynH6LMZmmuMAl?=
 =?iso-8859-1?Q?jh0wy1A8QwKIF3ye3R2xRWFhltC2rmkhlnqtJuA0ygNe0SbXht9KBHgalP?=
 =?iso-8859-1?Q?hq7loWx9jAu1o5a+6sXbkF/FXYQRjTOHn4Xxlk/JKkgm7FtqdZy4V6AUiI?=
 =?iso-8859-1?Q?gy9a5p0UAag19y55l94SQBU6ghedYVi7PxpQXVzznR/4rQzBA+8K6C6QbN?=
 =?iso-8859-1?Q?OqNaFl+T+hi7qYoqHbw+sPH6m8Rrj25d0j1ftdtUHKfeOCARhRWl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdcba49-7c6c-4a14-3efa-08da13d83178
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 12:07:28.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyfi+HfmYAH5zCDdjZBHCslyr+fEPSmacnV0IGfYDg6qcwvALa4wV+P77W65pNlQ5QVdvArf2sTW1UTNAH0Tlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6769
X-Proofpoint-ORIG-GUID: zQk4WvHqic4YJSMhGF0wRgLhKtLLYlzl
X-Proofpoint-GUID: zQk4WvHqic4YJSMhGF0wRgLhKtLLYlzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_04,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010056
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dan,

Thanks for the report. That email is no longer valid as Mihai moved...
That reminds me that I need to send a patch to update MAINTAINERS.

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Friday, April 1, 2022 12:06 PM
> To: mihail.chindris@analog.com
> Cc: linux-iio@vger.kernel.org
> Subject: [bug report] drivers:iio:dac: Add AD3552R driver support
>=20
> [External]
>=20
> Hello Mihail Chindris,
>=20
> The patch 8f2b54824b28: "drivers:iio:dac: Add AD3552R driver support"
> from Dec 13, 2021, leads to the following Smatch static checker
> warning:
>=20
> 	drivers/iio/dac/ad3552r.c:812
> ad3552r_configure_custom_gain()
> 	warn: 'gain_child' is not an error pointer
>=20
> drivers/iio/dac/ad3552r.c
>     799 static int ad3552r_configure_custom_gain(struct ad3552r_desc
> *dac,
>     800                                          struct fwnode_handle *ch=
ild,
>     801                                          u32 ch)
>     802 {
>     803         struct device *dev =3D &dac->spi->dev;
>     804         struct fwnode_handle *gain_child;
>     805         u32 val;
>     806         int err;
>     807         u8 addr;
>     808         u16 reg =3D 0, offset;
>     809
>     810         gain_child =3D fwnode_get_named_child_node(child,
>     811                                                  "custom-output-r=
ange-config");
> --> 812         if (IS_ERR(gain_child)) {
>=20
> This should probably be a NULL check right?  return -EINVAL;?

Yes to both questions...

- Nuno S=E1
