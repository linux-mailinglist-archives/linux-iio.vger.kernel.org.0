Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392BA3F27CC
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhHTHqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:46:19 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:30980 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233162AbhHTHqS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:46:18 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JJgZNe020247;
        Fri, 20 Aug 2021 03:45:27 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahk6ynva1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:45:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiZH8KGZuOvLFSS4u6lcpiwgjtkUcdgamWCV7lflUwQWq32M/8jzEyPJsOPcBP8xVhGaVifv5NA4byIA/Gwv8RliVaOCvsxmDgXyykAJIiywoImkeVuhnBUaoqRsOwRVjbCbUmEihlnpLuLQId88Jeex4SDA9lA5QwbcxfvPH2BFJByLBvDrcqzr2NZJCXVMW09v06dJVTCJ4qundsqlfM+W7SjYopjcWcagIMNeTSDSXGwnzJbwww+NLOlHUTAqRufBYYnHuObUnb/pAhUMOXKrzx36Aw6l4867zdZ7sKeTUAOZ7EvH7Nyxxpqqqezien4bf/jSffePjxN2DGaFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvyWlv6gzAOby8wPUPsrnQXc93yj3jJX5czkkkjNkjU=;
 b=SGL/JFxJ7J3pm8lC83g6tJVMsS7bLuwsijsymK5ASBi47aZHwv2SRZqOlMO0+BYPPjfcdvtnOZdv5vh/UA7tW9SPkKyF5tF8XtUOktdXQYWgO4KOWx5yN+t21AFFRHMjw6yTUSs1tI7eTXAWwFLBDWBFo4VJL0XufOdtA7z6LmhObXKo/yUzCZuPkatszOWUn96cFE4FOgGj1GoTmy4zQJb7YRgBroe9zbLoIVZllnvSSj2QhHlnCGRLVJvvK1jy6i0sA97utUH3FA6aD7+fPB6gAH5wU0nKn84oV+UDVZdEJotHFrSLncCrqJjSVtm6i9VBzQ9Ft6qjFLzX5sWAfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvyWlv6gzAOby8wPUPsrnQXc93yj3jJX5czkkkjNkjU=;
 b=j9lhia5TI77XGSxlbZX8q0oNkmToLrGxnUO6Dq411ncscvpVbRGdRNA+upBWUARclqw5XnOf+ghUGRWEWSIZmpEKCrSz+Viz42E+e4T6mixALxFXvXHIZyxUueC96xhVyCst8h1gmuTJh0ozfa4c7CVAqQxKVKSEl1ewl4bk/I4=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB4184.namprd03.prod.outlook.com (2603:10b6:a03:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 07:45:25 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:45:25 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
 conversion helper
Thread-Topic: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
 conversion helper
Thread-Index: AQHXlCHtfQrdofpSQUuVZBISb03GLat8AqPw
Date:   Fri, 20 Aug 2021 07:45:25 +0000
Message-ID: <SJ0PR03MB6359D3BD017CEDB8553C54D499C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-15-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-15-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9UTXpZMkkzTkRRdE1ERTRZUzB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEa3pNMk5pTnpRMUxUQXhPR0V0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTXpBMU5p?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGt4TWpRek1qazNOek16SWlCb1BTSjZlalIzVDNC?=
 =?utf-8?B?RWJtSklZMGRUT0VNclpYUklPVkJDZEZwTUsxazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVUkdWVGxTVm13MVdGaEJZMDFaV2tNd01YTTVRMFIzZUdoclRG?=
 =?utf-8?B?UlhlakJKVFVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVUpQV1VkalowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59416326-9efd-4bc8-39be-08d963ae7944
x-ms-traffictypediagnostic: BYAPR03MB4184:
x-microsoft-antispam-prvs: <BYAPR03MB418439F32B418DEE36D492F799C19@BYAPR03MB4184.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAma6S3RCskNj2a0pPt4dUtYXjZY5TYz8QgImPG150YDFpBQz4CpjwnsQw1gMGln1ECwk3LxBgsXO/A+gV+EM9/ARCvWPM9udDTtfQDQWguXdr1JMc8XgNe8jq1gJWS/aUfhiWcG5beZPXc0mwYGkK2LTbRbnAw8A7ZJuuBlAXyunNSgr3vItRajAeUTfcHpkvcgqu3tDczFa8dM8LFluCprcEizonDUxKHdKQeYAca2ghtdObChByoCzPdow67P+UmZvvKdP6fBGia1CnN0Fy68JXViRUA2L8JZVTCracr4lf2O21bbIDGPSPwgaH+Lmk8pPF9i0hQj6m5Kv0nS+ckJFy6pTSiPYRBZxbyysSfPO8nKZRvFfJP79Zn6x3M95xDnVwmVkaNsGYIYAMbsRbzHpY+MkDkh+Xp2s+JO6f3xd2nlSDZdzQsDa1ovdLBz2J1RtiTSuwqsBJTiyVBuyngkdyokm1n77jtn6C5lTQ/a5i5U0DC6VolYvplEdJgNX3jDmbqAMqL8XPvFTMMfTcklsjjIIfC70L2/WFrfbLKJ4GnLEBfZs5nqTFnBPFkfQMPKjdieoiMae5WhHKv3Bl5IhOz1xzKYGHru+MvN6mWT+akwP7AgSRWopZFcBEUjz1ELmdjZye16bGZy6YpeBsrIhiH6dNbzFGJVbW4gCshgOghu6spI/z7cKqaOlM0Jhpmg/01a+eOmK9APF4xo6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(316002)(83380400001)(6506007)(52536014)(8676002)(478600001)(122000001)(55016002)(54906003)(38100700002)(4326008)(53546011)(5660300002)(110136005)(38070700005)(8936002)(66556008)(66476007)(76116006)(26005)(186003)(86362001)(33656002)(64756008)(7696005)(2906002)(66946007)(9686003)(71200400001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXhXTmkwcFFCWGNHd2tOZnFnZnoxTk5ZY2tpN1VsaW9jTnA4RU5xajU4ZlJw?=
 =?utf-8?B?dWFwdFZITzcyaXhPb3E2cEcyRU51M2Zpbm1KVndjNFhSMU1pa3lLWjB6ZFJT?=
 =?utf-8?B?Y1l3dlc1ZEM0U0RGSm9hTFNvSDdmVnczN29KL1RxU1VIa1EvazBGZlpaUlRj?=
 =?utf-8?B?a1BFME1wUVpxQVdHQ3VuZ3lBUGJseTBGYURxRTZwWE5XVnpGd01Ca2JPQzJ4?=
 =?utf-8?B?K0gyOUNQZUZrQ1RTdUFrWDV1K24zMDl0ZXJOSGp0ZWJCdXlVR3haYkdRM3hn?=
 =?utf-8?B?TnhYbzlPUzJ2enlJVWdiVUVWdzB3R0VMZ1Z2UGlxZlVubGVPOVFmbERGajdj?=
 =?utf-8?B?cmtZTkVGTk1FcEVkc21iYUpwOFFVcDBwenYwSFk0OThtbWN3RExja3dldGl1?=
 =?utf-8?B?dmZuOTFWWlBXZXQ3Zk5sYWpxQ2JlRENEbDBBa0VURkxCWXF0M3JQeTJ1bm5P?=
 =?utf-8?B?eU1iczY4MXBQMG9xclp2bjEwNkhQVFp4SHBZckJGdHQrYlZzZVQxMkdDb1RX?=
 =?utf-8?B?cTMveGgrZjRFRkFJWjNxYjNWRVQrKy9iNThBVUlCRVBoN21tWGV0akExOVpz?=
 =?utf-8?B?L1cvNE9UY3BZaXVYR0wwUGVCcloraTR3ME5DLzIzcFBkTko3L2o3OWt2Lzlx?=
 =?utf-8?B?QnQ5aHFqTXMvS3MwMmVFU0VELzYwREFaV0oxN2tqeHpsTFZyMWxxQlRqV2hw?=
 =?utf-8?B?WlBFM0lkQjF4SFRqOWw1OXd2ZWlDdE10eXFWOWVGbC93QWdJQUgvODRJVEFL?=
 =?utf-8?B?SWJTWUE1SnJHaXlSQWQwOGtWOEhDMHdwRHdwOXpXeTJ6K1BrQXNDRkN4NVNo?=
 =?utf-8?B?OTAwRTlvSUdURkdIaWZKU2c5U2lRdmg3eGZqcG02Y0ZXUTY4cXRBdWxzT25u?=
 =?utf-8?B?VVdNTEdPUHUyT0ZZbXBYVzAzbm5EaFRyS2l5aCtsM2F5L1ExK0t5N3dDYmNJ?=
 =?utf-8?B?Wjh6WGlNSmtiN2w5Q1FXbWQ3NDdYTzBCTGY5RFp4ZGhSZGVtOUFocEEwdmR1?=
 =?utf-8?B?V21YK3NtOFE1VDR2a3JqYzhZeHVBcjBQOTc4Z3luRE5SVU5oWW9pMWFpZkIx?=
 =?utf-8?B?QUt5V0hyeGVTc0sxYUhITXdORDQyTkdydW1SOENLc1FaWHhJLzFuOUZncjVz?=
 =?utf-8?B?aU80Uy91Q1NmbEJqVHM5SmFVa0xOMUZBR3I2QTFjOU5sVndFc09uS3JJSDl2?=
 =?utf-8?B?WW5LcTZnMWQ5SzMvaE04ZG9PT0dNVG9iQldQR0ZLc0lDaUp6RVBoU1BEbTRV?=
 =?utf-8?B?dVFmV3Z0SDIyNkhZd3JUSWt1WXRic2xUb0tITXRmTDVxWkd5bjVQS2tFUjds?=
 =?utf-8?B?Mlp2ZE9ZUjN0d0hOOFZ2YktZeFNPYVUxZU96YWthMjcyTkZtMTlWVG1YNFZp?=
 =?utf-8?B?cTc2Y1cwbEUwcDlKc1dxNTZ1VmY3L3l2YS9pR1pQaXRCeW1LdFAwOW1iRnRo?=
 =?utf-8?B?M3FSKzFDVzNmVm5yWEJZdzlxWm52elI3b05kSlNUSUVwV0VDbCtPekhpU0Rr?=
 =?utf-8?B?MXhxcndHZXZUV05hK25JSmVnS3AyTkRjMithYkxlN2FFejd1dEtoN2NZcjUr?=
 =?utf-8?B?MTllUDNrQ09KWk82VWduREFIOFI0dnd3Z3FhdmYzQWpOam0xVzV1WkIxYldy?=
 =?utf-8?B?L3RCUkpzbGx4TElmUDRvaWZlelBCdk9iaFYwRXZSbkQvb09jLzdIOEdxVW5m?=
 =?utf-8?B?aGZubVg5QlA3ZlU3RXZWV2RMVWxkN3lJZ1BBUHJsaU12aE5XV2l5YlJ3enJr?=
 =?utf-8?Q?/2t1579Tvva3A6tnonmBlXUcZ40JWcCrHEGuiGP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59416326-9efd-4bc8-39be-08d963ae7944
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:45:25.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQ6sNyOvLEqmawckQl9O1mtIaX4FMA4/ZP/8j0aP3mwX+FM+G8/iOScankv5N2qFa9ILnfArtE+VfY5XykxBXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4184
X-Proofpoint-ORIG-GUID: eWLcaYNCbJvJOvXKD-HT4SR3yJwq0gfM
X-Proofpoint-GUID: eWLcaYNCbJvJOvXKD-HT4SR3yJwq0gfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMiBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMTQvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBDb25zb2xpZGF0ZSB0aGUgZW5kIG9mDQo+IGNvbnZlcnNpb24g
aGVscGVyDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBOb3cgdGhhdCB3ZSBoYXZlIGEgZGVkaWNh
dGVkIGhhbmRsZXIgZm9yIEVuZCBPZiBDb252ZXJzaW9uDQo+IGludGVycnVwdHMsDQo+IGxldCdz
IGNyZWF0ZSBhIHNlY29uZCBwYXRoOg0KPiAtIFNpdHVhdGlvbiAxOiB3ZSBhcmUgdXNpbmcgdGhl
IGV4dGVybmFsIGhhcmR3YXJlIHRyaWdnZXIsIGEgY29udmVyc2lvbg0KPiAgIGhhcyBiZWVuIHRy
aWdnZXJlZCBhbmQgdGhlIEFEQyBwdXNoZWQgdGhlIGRhdGEgdG8gaXRzIEZJRk8sIHdlIG5lZWQN
Cj4gdG8NCj4gICByZXRyaWV2ZSB0aGUgZGF0YSBhbmQgcHVzaCBpdCB0byB0aGUgSUlPIGJ1ZmZl
cnMuDQo+IC0gU2l0dWF0aW9uIDI6IHdlIGFyZSBub3QgdXNpbmcgdGhlIGV4dGVybmFsIGhhcmR3
YXJlIHRyaWdnZXIsIGhlbmNlIHdlDQo+ICAgYXJlIGxpa2VseSB3YWl0aW5nIGluIGEgYmxvY2tl
ZCB0aHJlYWQgd2FpdGluZyBmb3IgdGhpcyBpbnRlcnJ1cHQgdG8NCj4gICBoYXBwZW46IGluIHRo
aXMgY2FzZSB3ZSBqdXN0IHdha2UgdXAgdGhlIHdhaXRpbmcgdGhyZWFkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIHwgMjAgKysrKysrKysrKysrKysrKystLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMgYi9kcml2ZXJzL2lpby9h
ZGMvbWF4MTAyNy5jDQo+IGluZGV4IDhkODZlNzdmYjVkYi4uOGM1OTk1YWU1OWYyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2Fk
Yy9tYXgxMDI3LmMNCj4gQEAgLTIzNSw2ICsyMzUsNyBAQCBzdHJ1Y3QgbWF4MTAyN19zdGF0ZSB7
DQo+ICAJc3RydWN0IGlpb190cmlnZ2VyCQkqdHJpZzsNCj4gIAlfX2JlMTYJCQkJKmJ1ZmZlcjsN
Cj4gIAlzdHJ1Y3QgbXV0ZXgJCQlsb2NrOw0KPiArCWJvb2wJCQkJZGF0YV9yZHk7DQo+ICAJYm9v
bAkJCQljbnZzdF90cmlnZ2VyOw0KPiAgCXU4CQkJCXJlZyBfX19fY2FjaGVsaW5lX2FsaWduZWQ7
DQo+ICB9Ow0KPiBAQCAtMjQzLDEyICsyNDQsMjIgQEAgc3RhdGljDQo+IERFQ0xBUkVfV0FJVF9R
VUVVRV9IRUFEKG1heDEwMjdfcXVldWUpOw0KPiAgc3RhdGljIGludCBtYXgxMDI3X3dhaXRfZW9j
KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+ICsJc3RydWN0IG1heDEwMjdfc3Rh
dGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gIAl1bnNpZ25lZCBpbnQgY29udmVyc2lv
bl90aW1lID0NCj4gTUFYMTAyN19DT05WRVJTSU9OX1VERUxBWTsNCj4gKwlpbnQgcmV0Ow0KPiAN
Cj4gLQlpZiAoaW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9tYXNrKQ0KPiAtCQljb252ZXJzaW9uX3Rp
bWUgKj0gaHdlaWdodDMyKCppbmRpb19kZXYtDQo+ID5hY3RpdmVfc2Nhbl9tYXNrKTsNCj4gKwlp
ZiAoc3QtPnNwaS0+aXJxKSB7DQoNCldvdWxkbid0IGl0IGJlIG1vcmUgY2xlYXIgbG9va2luZyBh
dCAnc3QtPiBjbnZzdF90cmlnZ2VyJz8gc2luY2UgdGhhdA0KaXMgd2hhdCB3ZSBhcmUgdXNpbmcg
dGhlIHdha2UgdXAgb3Igbm9yIHRoZSB3YWl0ZXJzLi4uDQoNCi0gTnVubyBTw6ENCg0KPiArCQly
ZXQgPQ0KPiB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dChtYXgxMDI3X3F1ZXVlLA0K
PiArCQkJCQkJICAgICAgIHN0LT5kYXRhX3JkeSwgSFogLw0KPiAxMDAwKTsNCj4gKwkJc3QtPmRh
dGFfcmR5ID0gZmFsc2U7DQo+ICsJCWlmIChyZXQgPT0gLUVSRVNUQVJUU1lTKQ0KPiArCQkJcmV0
dXJuIHJldDsNCj4gKwl9IGVsc2Ugew0KPiArCQlpZiAoaW5kaW9fZGV2LT5hY3RpdmVfc2Nhbl9t
YXNrKQ0KPiArCQkJY29udmVyc2lvbl90aW1lICo9IGh3ZWlnaHQzMigqaW5kaW9fZGV2LQ0KPiA+
YWN0aXZlX3NjYW5fbWFzayk7DQo+IA0KPiAtCXVzbGVlcF9yYW5nZShjb252ZXJzaW9uX3RpbWUs
IGNvbnZlcnNpb25fdGltZSAqIDIpOw0KPiArCQl1c2xlZXBfcmFuZ2UoY29udmVyc2lvbl90aW1l
LCBjb252ZXJzaW9uX3RpbWUgKiAyKTsNCj4gKwl9DQo+IA0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiBAQCAtNDgxLDYgKzQ5Miw5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtYXgxMDI3X2VvY19pcnFf
aGFuZGxlcihpbnQNCj4gaXJxLCB2b2lkICpwcml2YXRlKQ0KPiAgCWlmIChzdC0+Y252c3RfdHJp
Z2dlcikgew0KPiAgCQlyZXQgPSBtYXgxMDI3X3JlYWRfc2NhbihpbmRpb19kZXYpOw0KPiAgCQlp
aW9fdHJpZ2dlcl9ub3RpZnlfZG9uZShpbmRpb19kZXYtPnRyaWcpOw0KPiArCX0gZWxzZSB7DQo+
ICsJCXN0LT5kYXRhX3JkeSA9IHRydWU7DQo+ICsJCXdha2VfdXAoJm1heDEwMjdfcXVldWUpOw0K
PiAgCX0NCj4gDQo+ICAJaWYgKHJldCkNCj4gLS0NCj4gMi4yNy4wDQoNCg==
