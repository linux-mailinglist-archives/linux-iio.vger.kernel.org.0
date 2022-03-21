Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639D24E22F0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 10:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbiCUJK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbiCUJK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 05:10:27 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26962E08B
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 02:09:01 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22L71DZC025375;
        Mon, 21 Mar 2022 05:08:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ew915w2qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 05:08:53 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22L8pqpk014545;
        Mon, 21 Mar 2022 05:08:52 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ew915w2q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 05:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNsvzEIamTNjVCVnCIzLFe93OKRkaWuh15NMYRWJZqX/NpxMr2Ruw15OPsY8EEUJJRXJE84vIKmdQpru2+q+iyPQ6ls7uoEp+XzVQe53qj7DdmWB974lQcNAme3dnAMD+i8+A1EUoYnpLRSGdH2V0o0gkBqFDMT3dT3jsUKUz+X4LNXPVFfGzyFsfBGL1pq0+wHfWNDy1khNQJu08L44GstqeWvJfwgfRLGHrrMty7yPPKZsJUyTHFsuwdz+ABol96Tsal6LrCNd1DiloZunqaGRDwqfvBuMVGdk5Yt9QNTw/LQ6YaFxaugpCCQhBzda2Y9gr1s2ZkbhFuGNmgX7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIQ1cEQDGeKfF86PydjB/bA5UZGpxAzpvaqhJpzDMo8=;
 b=dyhtMwHJFDhx9WXDujYZcwPoGPvjUmmN976M8012bJpLt0hapj4Ldhnhpz0qfVQ2jzJSG4d2ra4cmwHwUb5jEWvdYaaL+gYK/9hc/3UqW8SMEDefkupzrD3ENhoqve4MdR8yJcrIAYtSvNAY2i0uZ9ncIphMVNOQeVq7wKEh0Lz+n4IKI1RiK71AIAF1zdJGRpiB7D1PMwEE6wEWipHG04qRIkX9TIpSkgKIrzqxDoYOo0DD4YbIIE8gIPh2HBtrNzzvL5Blnj1B8tZ5o0LmjwcwTeVQMCkCT7/I67nWTadG6YZA9e4OBs0jULD4NsOBIXv+K/XWbzdq+RzhMx+uBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIQ1cEQDGeKfF86PydjB/bA5UZGpxAzpvaqhJpzDMo8=;
 b=KyuOdISDVYxpqMqbIw7elDIcRu09Y8qQX1gm+ktc/lzowyn7mLjA+K13Rueffs/vn38lqXJlwGwzBFQGF1B6fKek3rtDE60hZFAvZ1wJgcr2EGvZQ4+pRsDABywAgJGlyExBgZvtSmZSeBr+Go4rYki6joqb4qJ0ph8gkChXzjY=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by CY4PR03MB3240.namprd03.prod.outlook.com (2603:10b6:910:5b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 09:08:49 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 09:08:48 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Marek Vasut <marex@denx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
Thread-Topic: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
Thread-Index: AQHYPIaOMIIogrfx4UWYL3hRu1vrhazJjVtA
Date:   Mon, 21 Mar 2022 09:08:48 +0000
Message-ID: <PH0PR03MB67863BC0476700623050A16599169@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220320181542.168147-1-marex@denx.de>
In-Reply-To: <20220320181542.168147-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctODMxNWQyZjYtYThmNi0xMWVjLThiY2YtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDgzMTVkMmY4LWE4ZjYtMTFlYy04YmNmLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTg2NiIgdD0iMTMyOTIzMjczMj?=
 =?iso-8859-1?Q?Y2NDY1NzM4IiBoPSJlbi8xUEs0UnVvbmhXaUx3b2xFWVk2TzU3YlU9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURLQzI1RkF6M1lBV1Q0cnpQdHVxVG1aUGl2TSsyNnBPWURBQUFB?=
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
x-ms-office365-filtering-correlation-id: ee227d42-d20c-474f-4a25-08da0b1a692a
x-ms-traffictypediagnostic: CY4PR03MB3240:EE_
x-microsoft-antispam-prvs: <CY4PR03MB3240F86F625936DF6F901C3D99169@CY4PR03MB3240.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1w0yrxBychhyr4ZhNSNNE/3h2fvYJpJtpr8rolP84ZjuFyV4+P/LJp2k4U6x5Rs5nHSdvvfnsMLj3tYY9pnT+bve5Pzf2Qb3tsJ65Yopi7ha60GfXgiR1KC80M7Dp7IcDlLKUltgtGSCQZ1TnhIuVDpzCPWyCRuBRtHRhGRgVSG0k/Cq6ZDxtG1Up760pGy97U7SYWk/5r/veImW80rSgu+59PldXxbU5Zg7XZwVt7ZjVzO4fSs4mTVpjw4Wb1AoY37YqBVzb2jZo6gzKuVsThPIGEpf927/UYilbVStgoP+gR0W1f1FzpG+BlaXqLpsjdu2ZxWqz17gwrTkmqlGyZS4l0nTYqQAv0lbGzflCxRoNAsZ+LjEyUMuDauSmCuvi9SVfpRmtzW1V0C/7j8R+4J9fDw4fwaJ9szhRRbjdasRizsiG39aFdgyfah9CQUkqpxJqZMkAxonBCN/VZ0ovURi0MDQs0HOFczEU5EXf7MNwqpurlYeasMjeg5A0QvfDMN505Nc9p0yE/v+67HaDh4wGigJj7MvT4xcXOYJ8fU0Iymo9KzoyaNZnuQYuipIwEZKFa520nkAiLvFXkzKvfXWIEJ0I3OEMasaBSMd6HFdlreDhRFQ/3bwR8FUfaIgdVYlveeJtcLHU1q563DduDe6UIPeudN0KYH/sregTcQfUS6/fL1nfCW3oJgQb9rjDgLtsuutlKmaaTorw61f9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(53546011)(83380400001)(6506007)(7696005)(71200400001)(86362001)(8936002)(55016003)(52536014)(316002)(38070700005)(122000001)(4326008)(110136005)(9686003)(8676002)(54906003)(64756008)(33656002)(66476007)(66446008)(66946007)(26005)(76116006)(186003)(66556008)(38100700002)(508600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yXa3PF+1bg10HMIsUj3TOO3k+Izc7qUphA4HmMFOqRpFeIPfqJ64RHMn5S?=
 =?iso-8859-1?Q?fxOWBWhywdUmAczxgutH0Sd+TxVEo5T0Xnvpu9xUepKvTlB29qq6ZxnNDH?=
 =?iso-8859-1?Q?GQ+tPSmBaQNJ6CheJvAwTlELGZp1XjB4VdPnPa3yQlFmHRTM2nY79gK/6o?=
 =?iso-8859-1?Q?8V7n3enmHcb4U69ujwxr3VjijPJw81n188cCRnaQCcaKAik6IwfBF2HCDU?=
 =?iso-8859-1?Q?WYeljhw1DdvrFfFfWIgThaxnXlCTcPnv+oSrL1yr8i5C6xpYXXh7adYuhN?=
 =?iso-8859-1?Q?hJCY5TRJee1zuRrbG6jMRzBtcXbVj4VZoPzzUB0v/M/zDzulOmmzILcakS?=
 =?iso-8859-1?Q?MXAvq2gn1bebPqETQL4ftbjCDTbb5oZ/kk36OOrGaBgBLtEoX53ubYlcae?=
 =?iso-8859-1?Q?4X5rkBAYPtJ4IOtgsMEnywHZLN3X7v5lFQQxcc59LiEzhM4VzS3nKNt7gq?=
 =?iso-8859-1?Q?PwQsP9YjKvCaRdpwrHT6FL0v/4tvk5GYedcW6Qv4nSE22J7FZ4UqnGKZn/?=
 =?iso-8859-1?Q?2swd9aDTknJhqEDTE9xV+Te7LaoNtBhczsKxQrBbJJqxbVnzJua9WHJhud?=
 =?iso-8859-1?Q?SbHqCv72+qw24/y4Pm1KT2yE/26bA2u+j0tvHA8blNHO7zGe+Y5hmnguLC?=
 =?iso-8859-1?Q?cPe+HlEzBcsjYyOO+hq4xe/5p6WrawvDWcNcTI8+f1drJdxJe3AE6Ysrf6?=
 =?iso-8859-1?Q?xJf4ZwtMedt5eogo6JkLF6NSmSpvC9E6S1aBSTNEfZuG9eKHxNQrKeScU6?=
 =?iso-8859-1?Q?KR1y6d+P1ex698TSQGjpZCHbDRsJhB4qVGF77x5+s6b3sP7wQz0u8ozrgc?=
 =?iso-8859-1?Q?NVKgYdwn+z6x+3gyr6Y3fZfZ2o3TgDrf30TYT0dvyij3qWcLuWpqXMTDLU?=
 =?iso-8859-1?Q?CSahmL6abravkm/IeBDQDF5MQf5BofiEA5XM2mpNJvNUFK7z3QBXVSeOsT?=
 =?iso-8859-1?Q?eN73HWBXU4UrLXzxGGwcXrGaFg5XfnqZ0vfvQexGfvx0/T95V4TIAlyxsa?=
 =?iso-8859-1?Q?i56a6ZGFn3/v4z58WJwNWdRyE5hjRWpmIToYadM/YvmMSvrB7iJprJo90I?=
 =?iso-8859-1?Q?qTyDCLNTD0AJs9t87HT8Amt7U09jgFNxT61mEywFWd08Wfu60KhTgHD/yf?=
 =?iso-8859-1?Q?YZw9QxDUSDajNY30jPw2Augt94qLBKBLAbxvyMOOWdgySgsDj8POGTwl1s?=
 =?iso-8859-1?Q?FD6PoJl6Vu01ShoDvnTlVe1iPqjpX1tFWOF/3bXl2FvbDeyOMtLzYGWgE6?=
 =?iso-8859-1?Q?plIHmWxvYNJOYxHdmDIBaul9YqUWdCRm3j7dTuaKabhSMTFQKI09Y7a9k5?=
 =?iso-8859-1?Q?iRkjXlW6VaF6YpoR3sAr3tH+kFq/xEQ1a/o+NjODrH45LhmNpftgU+ziNL?=
 =?iso-8859-1?Q?svf2Sk9ahh7SZdDypMqkfb2u/9qMIbjtoA18j63ni/+/l2tw9EL/CzKWya?=
 =?iso-8859-1?Q?Z8/yPw2h6deCGXwqJrcAr3SvJa29MiLgsNbb3HNGFWEXP+Uc595g0v8S0A?=
 =?iso-8859-1?Q?EQuZknp2fUe5x1rid4hqmr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee227d42-d20c-474f-4a25-08da0b1a692a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 09:08:48.6999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXdR/LozB/JWkQHCxtE3hTWAiCL284uIzRdxRQYNs+20nwgiD9lM5BOdzurX06a9cPIFY3RCB5wTKumLN5mJMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3240
X-Proofpoint-GUID: a26nQ2ruMbZIZoPDVgN34_yCybzwTI4h
X-Proofpoint-ORIG-GUID: UKXhaHNTNBxZMqS6QOPPub1Qtkm89dH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210060
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Marek Vasut <marex@denx.de>
> Sent: Sunday, March 20, 2022 7:16 PM
> To: linux-iio@vger.kernel.org
> Cc: Marek Vasut <marex@denx.de>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Andy Shevchenko
> <andy.shevchenko@gmail.com>; Daniel Baluta
> <daniel.baluta@nxp.com>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>
> Subject: [PATCH] iio: core: WARN in case sample bits do not fit storage
> bits
>=20
> [External]
>=20
> Add runtime check to verify whether storagebits are at least as big
> as shifted realbits. This should help spot broken drivers which may
> set realbits + shift above storagebits.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Acked-by: Nuno S=E1 <nuno.sa@analog.com>

>  drivers/iio/industrialio-buffer.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-
> buffer.c
> index b078eb2f3c9de..bac1e994e7bef 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1629,6 +1629,11 @@ static int
> __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  			if (channels[i].scan_index < 0)
>  				continue;
>=20
> +			/* Verify that sample bits fit into storage */
> +			WARN_ON(channels[i].scan_type.storagebits <
> +				channels[i].scan_type.realbits +
> +				channels[i].scan_type.shift);
> +
>  			ret =3D iio_buffer_add_channel_sysfs(indio_dev,
> buffer,
>  							 &channels[i]);
>  			if (ret < 0)
> --
> 2.35.1

