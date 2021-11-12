Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE644EA9B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 16:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhKLPng (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 10:43:36 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:60274 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235391AbhKLPnV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Nov 2021 10:43:21 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AC3TuIe030996;
        Fri, 12 Nov 2021 10:40:28 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c9gdqjm8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Nov 2021 10:40:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrM/9BUkiEGy7/q6kOx23okjG1ALkWwmQDY2ob5BShS6afJPaszTET1fxZoSXrS6eJQgrvpg3RlgkTVMiszyQwJfgL3pmMKDy/bqL9kB4iv0QHRnIVUbkXltzfrvmP0KQma5B3xVFrqekwW3JV3n14VKSCwmuXDkgm5fpvNVSwrZQ4BczTaedRyErIesMx6T6+MAQa2TnvFKC8Brsx09U+LndECvT3XVKi3rDqo5bwkDpe3DgPlM6KLArOsBKRRPxIOA6YSSTO5ZMD073eyquB/SOP/l4QASdmIom6IzgVGvKikqWopWoEuD1zkGV9fxWpKIBArwGjz+oowqrF073g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5w2HYCbgMwcdvmxl1m1DqNVjpJcix/IE9CXZ0CtI1g=;
 b=WKIm0iFyReuOZ9XyiGI0BguizCUHHFuOSaGSugBMQu6KQTN87s+n2j7H4rHSNmEY3GK2TWj5suRNNtYI9z2np7sgOoaoTb6sd/DCJjOuPU2TbJVi7+FxQt+2Ui1X0WNFKqDbu/QBQtFtvZbpcBsX5D/Wrisy20BHMUQCCut9PmRupuKBdoDQoBg/cGu1+tqusrjlfD9qDuMjPCWxmtlVSNFQeuyGbs0zRVbQSMDNfBegz6NU0D8jKCTxhiQReLjNidSTz/V7kMFJ8Q/GRAgadwVlfiA9l79sNWACLw1UamH7vYybCtMnE3LS3SM43QS7sBsVz5Rz9Wk+s4Y5OetOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5w2HYCbgMwcdvmxl1m1DqNVjpJcix/IE9CXZ0CtI1g=;
 b=0xI62PN/Q+1iow5zS7D6Pqv3scLS3+Zp6dYwY8aGxtkIMr3W+hur9TYJK/AA6VhqiQZRCqOJfJfuu4wWnevjf5jSr4lPJTCB66JbzYBk/bz9CHG+8ppV4gcvcRkbxRpWN3FtrfuhagfDEK+0Z9HPR9Nn/L7BlvpmiPRNsVHGgms=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5781.namprd03.prod.outlook.com (2603:10b6:510:32::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Fri, 12 Nov
 2021 15:40:25 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Fri, 12 Nov 2021
 15:40:25 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: RE: [RFC PATCH 1/1] iio: dac: add support for ltc2688
Thread-Topic: [RFC PATCH 1/1] iio: dac: add support for ltc2688
Thread-Index: AQHX1utif38kT836ZkyleRcNhmByAav+V/wAgAAD7sCAAArFgIAAANgQgAGc34CAAARSgA==
Date:   Fri, 12 Nov 2021 15:40:24 +0000
Message-ID: <PH0PR03MB63661C1CDA531135A58F2ECB99959@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
        <20211111110043.101891-2-nuno.sa@analog.com>
        <CAHp75Ve3ZfFz5g4qH6HhuqaLKgqd058Jj-xY4=-e3ciG67cfRg@mail.gmail.com>
        <PH0PR03MB6366576BD3950F5F5D2A403599949@PH0PR03MB6366.namprd03.prod.outlook.com>
        <CAHp75VfsMa7n8BVJvN36N02u+LKLO36tZNx4rdEzSGZ4HGGoMA@mail.gmail.com>
        <PH0PR03MB636630C2C0C98896409F352999949@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20211112152235.12fdcc49@jic23-huawei>
In-Reply-To: <20211112152235.12fdcc49@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpEZzVZekpqT0dJdE5ETmpaUzB4TVdWakxUaGlPV0l0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHUTRPV015WXpoa0xUUXpZMlV0TVRGbFl5MDRZ?=
 =?utf-8?B?amxpTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpVMk55?=
 =?utf-8?B?SWdkRDBpTVRNeU9ERXlNRFV5TWpJNE1qTXdOemd5SWlCb1BTSjNVbmQxWTBw?=
 =?utf-8?B?Tk1XUnNPUzlrWm5saVlVbDRRMGhUYVhOQ1VrRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSXJWSFpUWVRJNVpsaEJWa0UzVkRVNE5IZFZSRWRWUkhSUWJu?=
 =?utf-8?B?cHFRbEZOV1VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aacc8a71-37db-40ca-d5ce-08d9a5f2beca
x-ms-traffictypediagnostic: PH0PR03MB5781:
x-microsoft-antispam-prvs: <PH0PR03MB57818D66682524537BBCA67799959@PH0PR03MB5781.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qDQ4wimdnzAiWcD0+oh3FxD7e27sXonk/wY9TH6poEErZ9jbTq0EOpZAmg36nPtjmcMN/Gaq3lbbwtNbM6nrh7TEhXXSJv6dp6W80V9CjYWnM6OrZpm4iYHODsvr8vA+IkB/SAtk8N21LF77o1I3pqMcmlS2TrNiXI/xII2C2xNrmEnB3gI8+VChs3e+BUEADIlqHgJIxg6P0hBZKIlbPYKlWc+54x5i2Bg+SDtrQse2/1uiaBB3p0tCe8IB2GQJgitMFvcSkS3EsMbItGEfeByEDWJLWQO6POCo0bTtfyiUN0wfLlu6pWSQ7xLOp9j54xbAOSXlrBNeAs76PbgnnccYv2RBcWdQBr4w+0QNEkMggCtlrH8PKOow9d/RZMx3+Z2fktJZYIfKkZV4A7rkXSCKkR4sH2V/Hro0k2kvedTORxV5l8vxuzR7j9Gcb/vMoryHtQf2UdlxvmXdgnLZKO6BiggmrlYOB9wH1Fxq7Ru57nrqS/PSq9hEJo4Vvt45d5P6GFLSLZZ/fsVqk7JjQqPVzqOJqU8TbvGJvoAFgEuRwOIsD4R1rB/rcGKZgsDyCQvEVzVQIOnswtl840V8rkkoS/G6kEvVDJ1FA1z83PyEVdDD4B+MITGIwcL3uFZNvAnJ6JPEslSJt5reQy5NkGjyw+oDhf290kph7FAl3nq7MKWIptTlfGciVsROJp3UCwTkF2Wf4X+ChC5HkXaJif1puygXg7s26YuPpcPbYhv8P/C84pk905H4frAFvd/cOd6sxDM1p60zrFuqo5ovzRfdzknC9mlASsjlDQzA8qk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(55016002)(966005)(66446008)(52536014)(508600001)(4326008)(38070700005)(8936002)(316002)(33656002)(2906002)(83380400001)(9686003)(8676002)(86362001)(6916009)(38100700002)(5660300002)(66476007)(64756008)(66946007)(71200400001)(6506007)(53546011)(76116006)(26005)(54906003)(122000001)(66556008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU9UdW82UEZocjlJdEdqYkdlY0xPWDBJbWZVZm5ZSlJUTUtiZjBzZ3JGSHhk?=
 =?utf-8?B?QmNydmRMQW14M2g2QURrWFVtQlRsS0ZzRXFwZGVKejk0UXluWHlOOE1uSTZy?=
 =?utf-8?B?Y3pDb0RBaUhlenduYjFYcmtVd3pjRHFBUFRMVkNvOEJaRTVPcXI2MXhKY3RH?=
 =?utf-8?B?WDRvQ2o3dm1XOEZ3OUJObnBENVJqZ05WbStKb1p6aTBMRktUTjVRZG9ueWZz?=
 =?utf-8?B?YWQzdERoUXU1NXB6ZGFUVU83Z3lqZ0REVWJsb3hOUWRhb0VuYnFrUy9ZL0w0?=
 =?utf-8?B?cEhWR25uTUJoNHAyMm8yY3hGR1lnZjFtcUZHZGxYY3B3dTdJQkJZS3RNRXFG?=
 =?utf-8?B?RXBVMVNuYVpyeDBWWXVVemtLUUpwKytzUXFXMzlpNkNXOVZYcDMyZUl5SWYw?=
 =?utf-8?B?czhybHcwckF1Y1gwMjB4WlZaZUZUVFFJY0s5WXE3eGFJZ0c2U05BNU5hNEN2?=
 =?utf-8?B?WnJ6bUM1UEVQVlpyc3N0THlsdTk4VzRjbGhkVTFsL0UxZXVaOXd5STNIQ0dw?=
 =?utf-8?B?Vi9aMWZWYk9KUVdJS1NYWjJDem9Ebk84MWQvVWFlWmZlclZOdW40VXJVZVl2?=
 =?utf-8?B?bmp0TUw3ckdyL0VJaWlrN0xPeXlUbGk1MnpiOFgvd3JoaVJvb00veEEycWxL?=
 =?utf-8?B?b01WSitCNElKMFVXdlJweHZPd2VvRE1UWFV0WEFyaW96Qmg1S0YrK3hMUWRo?=
 =?utf-8?B?aGk0QWwvUGlwNWV4NHFMSGJEMjNLU0NVakhCQlRBeFozczQ0S0FBdGhZL05U?=
 =?utf-8?B?RE1xa2VPKzdCTnk0bUorQVM2bnRESWcwS1p4SzlxcENoOUdCblpzU0lBZGFZ?=
 =?utf-8?B?SStxRHZlTjBJck10TW91RVozb3pCdkJLWVZLWDFxeWYrWEFob2Zjb2ZIWkJu?=
 =?utf-8?B?MUJxZTVpeUJSbUFVSGhRZjcvU0pMQlpwQ0tWaG5uazY1VlpoVHY2NGlGRERq?=
 =?utf-8?B?MENNTXdLVGZlSnhBb1dXditjaFZtYk5YU2Y4eWdKV3B5dVlTaXBESGJhQTBm?=
 =?utf-8?B?UDd3QnducGNTV2tKandLb2lkU25zZDhBamZwQU9ETEU0dUVXUkczZm5YTFBQ?=
 =?utf-8?B?M3lVZGc1NzdybWlEMzBPSkNyYXhBSVFLTkpLUGtHSzdlMVl4czRQSjlCUzI5?=
 =?utf-8?B?ckNKcWVmWkM1ZGt6NW1NZk1xcmVLaEJRM3hSbHQzakpIVlQ3dUtRMVNUbDNk?=
 =?utf-8?B?Vk04ZkZIaFk5c290MjRxd1BmcUZYTGVpblpsdzBJY3NlMDRSVll3bzlpU3Rv?=
 =?utf-8?B?blI4MlcrRlBxQWVtMnVITENLMVhkL2ttZExhc3AzRXJLajNQck5Xa0RtVThQ?=
 =?utf-8?B?emlLbG4xSFJTdGZGQ01tQVBuRlJiQ2JjQnlUKzVrV0xSN0JTUk5mcXhOV25q?=
 =?utf-8?B?b1Y4bkd3ZS9Xa3FrbzhQb2h1M3VNRWtvMWpQYXBEKzBldDFmT1RMcUYvcWhk?=
 =?utf-8?B?NE54MUk5UXJDYkpUQ3hid212TStIR1F3aVF3V2puK0oyVG9pZStZK0lqWjYy?=
 =?utf-8?B?ZllzTWMyUjZDQWZqanlIWFU3N2pkYng4S2dsNmVMWkZEdksxZ1Q4QnM5amRM?=
 =?utf-8?B?aVlnUmtJLzJiVExDS1JndFBBc2tTWEFnS0k1dVZIWDNvVUxPT1F3Qkd5Y0J6?=
 =?utf-8?B?RjdkQ2FGa1YxUzF1Z0s4a1dvQ3NMN3FVZ2pOa0JzTHF0WGdzTHk2eE0yaFl5?=
 =?utf-8?B?bmdjY1Q3OWtkU0o2UWYyQ1AyZEhwZGkyTzZ2NTh2cUFnQTJLZ3NjNlJPMXNR?=
 =?utf-8?B?TEZ2OEtMYWR2Yk50QTFLendQb0dtallKa0ZQaE8rOTB1WFJRaGpETU1nOE9n?=
 =?utf-8?B?QTQyVm91ZUhMd1l1TnpFSThsaUxWSkR5MVY4ejhWZFVpUlUwUEhKMkxJU0tJ?=
 =?utf-8?B?Wnc3RVp1MDVHbkhaL2NEckZ2VytQL1BWMEFkaHBNb1RhUmhKbm1UdjUzcVZY?=
 =?utf-8?B?YzhpbzYvdzltdHhmSERNenlsVG5SdXluUHZUNHVjWVM4V0F2YmRuK3dPTGRO?=
 =?utf-8?B?bEVDQVZEWHE3U1hqazZma0VRL2t4YkhIcTdyRlRWVmxFYUQwMDlySERYYXlJ?=
 =?utf-8?B?WFhoNGlrSWt5YlJhck9ESmYzeFp4c3RNY0x2d2N2UEhPTTZ2QW9pRjlmYlpX?=
 =?utf-8?B?Z3d5YWpxK1NsUHExd0RxQTdZczUyblVRZ0MrOXlZaEYrczZFQkpRdXY2bkdY?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc8a71-37db-40ca-d5ce-08d9a5f2beca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 15:40:24.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ2ag66ZyEj2UI8ZTPMEx9iYrTYw8a+ZSprV8ZOL40T7iHX6hSk2zOdwukgaZUh4bSOIpjbBpEkwXtFkjLgnHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5781
X-Proofpoint-ORIG-GUID: 3kIh8_WSHFfPBk0KYK3VkakmZOj7YMKn
X-Proofpoint-GUID: 3kIh8_WSHFfPBk0KYK3VkakmZOj7YMKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111120089
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxMiwgMjAyMSA0
OjIzIFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzogQW5keSBT
aGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgbGludXgtaWlvDQo+IDxsaW51
eC1paW9Admdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAxLzFdIGlp
bzogZGFjOiBhZGQgc3VwcG9ydCBmb3IgbHRjMjY4OA0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4g
DQo+ID4gPg0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGNoYW4tPm92ZXJyYW5nZSA9DQo+
IGZ3bm9kZV9wcm9wZXJ0eV9yZWFkX2Jvb2woY2hpbGQsDQo+ID4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYWRpLG92
ZXJyYW5nZSIpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT25lIGxpbmU/DQo+ID4gPiA+DQo+ID4g
PiA+IEl0IHdpbGwgcGFzcyB0aGUgODAgY29sIGxpbWl0LiBBRkFJUiwgSm9uYXRoYW4gcHJlZmVy
cyB0byBrZWVwIGl0DQo+IHdoZW4gaXQNCj4gPiA+ID4gZG9lcyBub3QgaHVydCByZWFkYWJpbGl0
eS4uLg0KPiA+ID4NCj4gPiA+IEkgYmVsaWV2ZSBpdCB3aWxsIGluY3JlYXNlIHJlYWRhYmlsaXR5
IGJlaW5nIGxvY2F0ZWQgb24gb25lIGxpbmUuDQo+ID4NCj4gPiBJIG1lYW4sIHRoaXMgaXMgcGVy
ZmVjdGx5IGFsaWduZWQgd2l0aCB0aGUgb3BlbiAiKCIsIHNvIGl0J3MgYSBwcmV0dHkNCj4gPiBu
b3JtYWwgcGF0dGVybi4gQW55d2F5cywgSSdtIG1vcmUgdGhhbiBoYXBweSB0byBtb3ZlIHRoaXMg
aW50byBhDQo+IG9uZQ0KPiA+IGxpbmVyIGFuZCBqdXN0IHVzZSB0aGUgMTAwIGxpbWl0LiBCdXQg
bGV0J3Mgc2VlIHdoYXQgSm9uYXRoYW4gaGFzIHRvIHNheQ0KPiA+IGJlY2F1c2UgSSBkbyBub3Qg
d2FudCB0byBtb3ZlIGJhY2sgYW5kIGZvcndhcmQuLi4NCj4gDQo+IEhlcmUgaXQgaGFwcGVucyB0
byBiZSBwYXJ0aWN1bGFybHkgdWdseSBiZWNhdXNlIG9mIHRoZSBzaG9ydCBmaXJzdA0KPiBwYXJh
bWV0ZXIsDQo+IHNvIEknbSBmaW5lIHdpdGggYSBsb25nZXIgbGluZSBmb3IgdGhpcyBvbmUuDQo+
IA0KDQpPayB0aGVuLi4uDQoNCj4gDQo+ID4gPiA+ID4gPiArICAgICAgIHN0LT5yZWdtYXAgPSBk
ZXZtX3JlZ21hcF9pbml0KCZzcGktPmRldiwgTlVMTCwgc3QsDQo+ID4gPiA+ID4gJmx0YzI2ODhf
cmVnbWFwX2NvbmZpZyk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJJ20gd29uZGVyaW5nIHdoeSBp
dCdzIG5vdCBhIHJlZ21hcCBTUEk/DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBwcm9ibGVtIGlzIG9u
IHRoZSByZWFkIHNpZGUuLi4gSW4gdGhlIGZpcnN0IHRyYW5zZmVyIHdlIHdyaXRlDQo+IHRoZQ0K
PiA+ID4gY29tbWFuZC9yZWdpc3Rlcg0KPiA+ID4gPiB0byByZWFkLCB0aGVuIHdlIG5lZWQgdG8g
cmVsZWFzZSB0aGUgQ1MgcGluIHNvIHRoYXQgdGhlIGRldmljZQ0KPiA+ID4gZXhlY3V0ZXMgdGhl
IGNvbW1hbmQsDQo+ID4gPiA+IGFuZCBvbmx5IHRoZW4gd2UgcmVhZCB0aGUgZGF0YS4gQUZBSUss
IHRoZSByZWdtYXAgc3BpDQo+ID4gPiBpbXBsZW1lbnRhdGlvbiB3b24ndCB3b3JrIGxpa2UNCj4g
PiA+ID4gdGhpcy4gSSB0aGluayBDUyBpcyBrZXB0IGFzc2VydGVkIHRoZSB3aG9sZSB0aW1lLi4u
DQo+ID4gPg0KPiA+ID4gSSBiZWxpZXZlIGl0J3MgY29uZmlndXJhYmxlLCBubz8gTGlrZSB0aGUg
Y3NfY2hhbmdlIGZsYWcgc29tZXdoZXJlLg0KPiA+ID4gQ2FuIHlvdSBkb3VibGUgY2hlY2s/DQo+
ID4NCj4gPiBEb24ndCB0aGluayB3ZSBjYW4uLi4gVGhlIHJlYWQgcGFydCBqdXN0IGNhbGxzOg0K
PiA+DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC9sYXRlc3Qvcw0KPiBvdXJjZS9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC0N
Cj4gc3BpLmMqTDk4X187SXchIUEzTmk4Q1MweTJZIW9yTWF1TGdLUXpjZG5jM01oN0RCUVk5bkdx
OXNnZjhqbA0KPiBLUkJSOElPSGhLTVQydGRrTGo5QXl2SUhEUFltQSQNCj4gPiBhbmQgaGFzIG5v
IGNvbnRyb2wgb3ZlciB0aGUgc3BpIHRyYW5zZmVyIGJpdHMuLi4NCj4gDQo+IEZlYXR1cmUgdG8g
YWRkIHRoZW4gb3IgYSBjdXN0b20gcmVnbWFwX2J1cyBpZiB5b3Ugd2FudCB0byBrZWVwIGl0IGlu
DQo+IHRoZSBkcml2ZXIuDQoNCkhtbSBJIHNlZSB3aGF0IHlvdSBtZWFuIHdpdGggdGhlIGN1c3Rv
bSBidXMuIFdlIGNhbiBhY3R1YWxseSBtYWtlDQp1c2Ugb2YgbW9yZSByZWdtYXAgaW5mcmFzdHJ1
Y3R1cmUgaWYgSSBqdXN0IGRlZmluZSBteSByZWdtYXBfYnVzIGluIA0KdGhlIGRyaXZlci4gVGhh
bmtzIGZvciB0aGUgdGlwIQ0KDQotIE51bm8gU8OhDQoNCg==
