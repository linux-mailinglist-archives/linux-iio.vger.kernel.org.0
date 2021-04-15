Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8597C360410
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhDOIRI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 04:17:08 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26240 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231611AbhDOIRI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 04:17:08 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F8F1Rx023886;
        Thu, 15 Apr 2021 04:16:32 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vyd2167c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 04:16:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrK0TlnZ11HaoFNmANyGOSfDS27+DZLUk4jIwmr4MurOJfl0BrprGI4IT2c/ez4n19IT+rM7vF2z6uCAxd4aPXdgKyuEJOqnxd5VI0Yu4wD+ZoXUCxA4EZDyz+rw+21uX4+4N59GSIaYWRyV6fCJyWAaIrPWXiiXJ3ZJtgvl0wYjXUJhiNo03pnWk4OPl2hBwRAoH6mHC1Wy++7rTrzvmHXwlT3uxQxm4VOrpF8f7JTWeHFIJU5403zg6M5s2RCzybX2LiHm7hmwNuRvFIuTSuOVtcIZv6K7WdO8Mfr5Xvx9SGNaVL9hmfWveOVL/Cl4qt875TI+8WYwUA2jt4ij7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCdhkgiuFuIg/1uRxw3rTMkC9pfFHyY/OyRazat50FE=;
 b=fcnISQl/p/jTqxB3MXhTQWC45U02jyGyAmpA0WhGePskbGllfL3x19F4Mi3Ni9C99o2bEa41Aplnmsk9JjgLLl+guoypnqYAXxVRv68uu/3u/TZMTdDHFiFf2XF/CysbYh8OK8wF6w/dPedG5RbFJqM2aWlBPz+SDigmU8hVV6EasluhdjflS7nmTOgXN8JjkLn8X/9U9vn217o7/AHYOdcJtN8yK6db5Jkh7c2oNXI5gOLNecZ+9yBB4ddeiCrztLZBRqQPm4moHplPC/ZShOYGlg8pSyy8ng49rX/jrI0Ofuqr7lIPuQkcVoCZb+vqsNxqLV5vdgHdhqcO0wJN+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCdhkgiuFuIg/1uRxw3rTMkC9pfFHyY/OyRazat50FE=;
 b=z6hvFCCsx5VgD+zMv7BTYnHEFLxsmfIgyGcJx7wQ/C+1wD1iJtKAmG1rMv/I13b8iRlZt1KNPHdEfBipNOPR/JpGU74oMb6tf25ftTsV3EwVJTeQ8Z1owpp0q46vgPsHB5U+gTriubidH/1jDfMqvoNXArP9MSrn2TEeiQgZEGw=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2315.namprd03.prod.outlook.com (2a01:111:e400:c616::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 08:16:30 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 08:16:30 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Thread-Topic: [PATCH 4/7] iio: adis16475: re-set max spi transfer
Thread-Index: AQHXMFbUjw8K/uCRQ0qG6XJFfEfrAqqznvwAgAGVJPCAAAgPEA==
Date:   Thu, 15 Apr 2021 08:16:30 +0000
Message-ID: <CY4PR03MB3112BFAA334A280B0E04CB88994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
 <20210413112105.69458-5-nuno.sa@analog.com>
 <CA+U=DsqeiRRGp+Q+yZ7OVOE719aBiyMoBLsFTZL3amGfWHtgkg@mail.gmail.com>
 <CY4PR03MB3112C342E901F4E308D0AFF0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB3112C342E901F4E308D0AFF0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpHWmxZVEF3TVRFdE9XUmpNaTB4TVdWaUxUaGlNMkV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHUm1aV0V3TURFeUxUbGtZekl0TVRGbFlpMDRZ?=
 =?utf-8?B?ak5oTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTXpBM01D?=
 =?utf-8?B?SWdkRDBpTVRNeU5qSTVORGd4T0RnME9UTTJNRGt5SWlCb1BTSjVWRnBUYW1V?=
 =?utf-8?B?eU1sVkJjREkyWTNCT1NGTTVRME4xTVdGTFRYYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTmpOVE0yYVhwNlNGaEJVVmhvVDNaU05raDNaa2RDWlVVMk9V?=
 =?utf-8?B?aHZaa0k0V1VaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRV0pLVUZOa1VVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce527de7-cc10-4d02-577c-08d8ffe6c60c
x-ms-traffictypediagnostic: CY1PR03MB2315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB2315C2FF8BCC1A0289204F85994D9@CY1PR03MB2315.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/igHrq3A9AjI5GBZnVNI+tGw5Ttrr853oEZmFYbQ5eApJce0G68UgPuz89gLKffoaYaMWwo31vI93rwa3cyBmOg23uAIfOzAgMF0DOoRSbNB/n9MivKUNVdkTo+PRC04xnbVFcVU7OOVulAGJj6tMl65aVv4RFCg54F4d/YiRzBItaYRfU1TBe0DVt03b4FHsu/+FiomzSZdQPSrq3nZdsCINvvYGsVx/ewVX1wv8LuKf8jkKuZ7qrKAondBUlEVjEiQtz1smVhWCXmFe0iIukyBINoEGM0mMtZvhCTJPKIJMzZvtB0micgv9Ky7AayMjq4EFe1CQNbAHbeL1CDNw3RjWPkMek345f775SVhsQIgXcJxwEAq2zcJhhUz5wnEKgaJ2GsSmOQxRT9aBek1kR7Y+KWpj2LSXZ386czkDiUbKXJk9GTsAjAC/eINrbibtcgJ2wEecoNWHNkTvtfzajXa8AFgNDqZ3mtwG5kzCMzxojZ0pTo7akrc1fMWRDHBP5zoHtZibigM6JTSZcRmLh4BRDRZhAAm0wal5nJakPqy/TZUhZuH/0dw9zpYBalIkYqvNmeYLsBguXFWFtC+anvl2H26lHoBvbtAubqAaQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(53546011)(6506007)(2940100002)(9686003)(66446008)(83380400001)(122000001)(26005)(186003)(7696005)(33656002)(478600001)(71200400001)(4326008)(38100700002)(76116006)(8936002)(52536014)(55016002)(8676002)(54906003)(86362001)(316002)(110136005)(66946007)(2906002)(66556008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UUZUMHJwSWpTOTBqNll5VTRvOW04a25Ibm95Y2FVZElIYVNNMDNReEFiZ2Vn?=
 =?utf-8?B?SGxYMlBJQTd4Sm1Dd2NueDRSU2hsQmlEUDlhSmE4NS9hem14VlFndi8vWG0x?=
 =?utf-8?B?RFlWKzBwbXgvTFJyL1Jzc3J3ZXpLREpSQUozc3luQzhlZXVMNEFJdUpDYyto?=
 =?utf-8?B?dW9LOUoweU05NkRRY3ZIMFcxZitmeFV5S3V0S0l0UDBwYURkV25YdEdaUnpk?=
 =?utf-8?B?V0ZzUlJmZ0xPS0g3UlRMZ1kvUnlqVG55MVl1dlkzZnA5Z3R1R1dUd3NLSjFs?=
 =?utf-8?B?RHlVOHI4U0FKY0hqSWtEZzVZL25XTDdKU243aHhlaGRCbjdEUVlpWHJSUFFM?=
 =?utf-8?B?bWd1N1pJejd3dGI2OW5oL1BmUWtWTXdqQ2J3dVNJWG81VXNXVU1FMDlmZERn?=
 =?utf-8?B?bDdaRXFDdG9menlkNmNaWnlReVFyYW9memdMTzNUS3k0Mzl2ZzgxcUp4NXNo?=
 =?utf-8?B?T1pHS043UzJlMjlrd1RNclQrRnZaNXEybnRPZXBXWktwanNPUU5ZcGZISEs2?=
 =?utf-8?B?Yi9ST2FDVUFCNC9zRlNweVYxUGxxQnh1endHZjdYZVBFRGlGR1Fyd2h5VEUz?=
 =?utf-8?B?aFhRUGVGY0FrWElHaDFmQlhKQTNWL1RLa2FRQnZnelU2UmMzbU8yU1RyL0hW?=
 =?utf-8?B?ZWpVNmU0UklDSVR6V1Uybi9ZREUxZzUySjFmVFIyanJNTmhKYnVyWkI3b3dp?=
 =?utf-8?B?azJ0ZnFlNnpGRXRFWjk5RWhuV3dSbDNVTmN2cnk5QkxtRjdxUHJvc2hNeGE5?=
 =?utf-8?B?U0k4aXpEYWFtYTIvbGdHQmJQWGJqWGdQdGw5TWtKYS8rR3Q1dlVWeTY3S0hh?=
 =?utf-8?B?d1psNEdKWWpVbzZsQUlFM283U3dPUDU5cXp1TVE4Y1F5SmpCZGZmSkZqNlBx?=
 =?utf-8?B?U3dpdVdhRG5CUTJaSTdUdUtkYjdta3ZWb2pKODlaWFpMeDVyM1ZOYzFmSjh2?=
 =?utf-8?B?NDN0bjA5Vkc4ZW9TcnhYOFZyTmtsc1hTbldzR1p6QzNVeWx4YU1vOHZkVUUv?=
 =?utf-8?B?MnpxVFVyQ2wrL1Y2NllpNTZkZDdQbFVVRitydkFubUZzeWU2L3pYalNzaENa?=
 =?utf-8?B?elJjdDk4eU9hUHJLZlR2ajlWSXo5M1NsYndnalJpaURyV2NGSHRUaWZHcHg5?=
 =?utf-8?B?Ukw1VTNzZ21lZmFUb0tNMXlqOFFZRTJjdURMS05sdmE1Y0xGSldwUFR0RlZI?=
 =?utf-8?B?M0NIOWNRTVAvUjQyMFpOV2VvYUdBUCtGQTZSNW9KM1R2eVRlWWZJL3RXU2Ji?=
 =?utf-8?B?QVdQNGhSMk90ZU5VNXVUSEVJRVJxYzJMVGNlZ0l6TytabnBVK0hTVXUyTWd5?=
 =?utf-8?B?ZUNPOHNubnkzcVB1S1VKUDk1Y0pBa0dEd2Q0QnBldWpEWER3QlNFaC9ZZ2JD?=
 =?utf-8?B?QlllcURVdVIwb296a0U3cEZxd0NEcS9FbEVWNUh4OHd2cHdtM0F0SGozaEJP?=
 =?utf-8?B?eU4vVzJOM1VBc1E1MmxRblNPVWFXZS9rZ01ib3VVdVVmUGVpNlRoeXZtbkNP?=
 =?utf-8?B?SXJQT01pcVhmN2VtbFBCOFZmRWlIcmRDblFsUXYxam9ldFhoMCtDK2xQaksz?=
 =?utf-8?B?MUVlSWFrUmJxT3BZbUkzU2hMT3dJWjVWR1VjNjRBQ3crNVFUUEhiWHRsN3E3?=
 =?utf-8?B?NUZBUlJUa2pRZmRRS0tqWGxURDU2Sm1Md3pFQU5sMEwzbWFSSDRFRlBEcmFm?=
 =?utf-8?B?WGZBenN6bFJEVlhEWEhud1hSTXN2MHluOEdVazBsQ2tZV25XTUMxdkZEcDIx?=
 =?utf-8?Q?OF9qzunKQikzGO/oHtcFMNWm3yYapTDijtTsJBg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce527de7-cc10-4d02-577c-08d8ffe6c60c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 08:16:30.1871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/EUEAmJpvszafOLNzZDT50v/D+B2LDroE7V55lkuNKLx77PRsgMAX+9zt/M9Jgqou7WaiHivlRpvzwGtgfYaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2315
X-Proofpoint-GUID: jOhHRKYULuWraSlx2pN9y5niJXUa6jhR
X-Proofpoint-ORIG-GUID: jOhHRKYULuWraSlx2pN9y5niJXUa6jhR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2EsIE51bm8gPE51bm8u
U2FAYW5hbG9nLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDE1LCAyMDIxIDk6NTQgQU0N
Cj4gVG86IEFsZXhhbmRydSBBcmRlbGVhbiA8YXJkZWxlYW5hbGV4QGdtYWlsLmNvbT4NCj4gQ2M6
IGxpbnV4LWlpbyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFuIENhbWVyb24N
Cj4gPGppYzIzQGtlcm5lbC5vcmc+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPE1pY2hhZWwuSGVu
bmVyaWNoQGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPGxhcnNAbWV0YWZvby5k
ZT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCA0LzddIGlpbzogYWRpczE2NDc1OiByZS1zZXQgbWF4
IHNwaSB0cmFuc2Zlcg0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogQWxleGFuZHJ1IEFyZGVsZWFuIDxhcmRlbGVh
bmFsZXhAZ21haWwuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTQsIDIwMjEgOToy
OSBBTQ0KPiA+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiA+IENjOiBsaW51
eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9uDQo+ID4g
PGppYzIzQGtlcm5lbC5vcmc+OyBIZW5uZXJpY2gsIE1pY2hhZWwNCj4gPiA8TWljaGFlbC5IZW5u
ZXJpY2hAYW5hbG9nLmNvbT47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA+IDxsYXJzQG1ldGFmb28u
ZGU+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzddIGlpbzogYWRpczE2NDc1OiByZS1zZXQg
bWF4IHNwaSB0cmFuc2Zlcg0KPiA+DQo+ID4gW0V4dGVybmFsXQ0KPiA+DQo+ID4gT24gVHVlLCBB
cHIgMTMsIDIwMjEgYXQgNTo0NSBQTSBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+ID4g
d3JvdGU6DQo+ID4gPg0KPiA+ID4gSW4gY2FzZSAnc3BpX3N5bmMoKScgZmFpbHMsIHdlIHdvdWxk
IGJlIGxlZnQgd2l0aCBhIG1heCBzcGkgdHJhbnNmZXINCj4gPiA+IHdoaWNoIGlzIG5vdCB0aGUg
b25lIHRoZSB1c2VyIGV4cGVjdHMgaXQgdG8gYmUuIEhlbmNlLCB3ZSBuZWVkIHRvDQo+IHJlLQ0K
PiA+IHNldA0KPiA+ID4gaXQgYWxzbyBpbiB0aGlzIGVycm9yIHBhdGguDQo+ID4gPg0KPiA+ID4g
Rml4ZXM6IGZmZjczNTJiZjdhM2MgKCJpaW86IGltdTogQWRkIHN1cHBvcnQgZm9yIGFkaXMxNjQ3
NSIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFNhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMgfCA0ICsrKy0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiBiL2Ry
aXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiA+ID4gaW5kZXggNTFiNzY0NDRkYjBiLi45ZGNh
N2U1MDYyMDAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0NzUuYw0KPiA+ID4gQEAgLTEwNjcs
OCArMTA2NywxMCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QNCj4gPiBhZGlzMTY0NzVfdHJpZ2dlcl9o
YW5kbGVyKGludCBpcnEsIHZvaWQgKnApDQo+ID4gPiAgICAgICAgIGFkaXMtPnNwaS0+bWF4X3Nw
ZWVkX2h6ID0gQURJUzE2NDc1X0JVUlNUX01BWF9TUEVFRDsNCj4gPiA+DQo+ID4gPiAgICAgICAg
IHJldCA9IHNwaV9zeW5jKGFkaXMtPnNwaSwgJmFkaXMtPm1zZyk7DQo+ID4NCj4gPiBQdXJlbHkg
c3R5bGlzdGljIGhlcmUuDQo+ID4gQnV0LCB0aGUgcmVzdG9yZSBmcm9tIHRoZSBjYWNoZWQgdmFy
aWFibGUgY291bGQgYmUgZG9uZSBoZXJlIGluIGENCj4gPiBzaW5nbGUgbGluZS4NCj4gPiBTby4g
anVzdCBtb3ZpbmcgWzFdIGhlcmUuDQo+IA0KPiBZb3UgbWVhbiBhbHNvIGRvaW5nIGl0IGluIHRo
ZSBsYWJlbD8gSSB0aG91Z2h0IGFib3V0IHRoYXQgYW5kIHRoZQ0KPiByZWFzb24NCj4gd2h5IEkg
ZGlkbid0IGlzIHRoYXQgb24gYSBub3JtYWwgcnVuLCBJIHdhbnQgdG8gcmVzZXQgdGhlIG1heCBm
cmVxIGFzDQo+IHNvb24NCj4gYXMgcG9zc2libGUgc28gdGhhdCBpZiBzb21lb25lIGNvbmN1cnJl
bnRseSB0cmllcyB0byByZWFkICdkaXJlY3QgbW9kZScNCj4gYXR0cnMNCj4gZ2V0cyB0aGUgbWF4
IGZyZXEuIFRoaXMgd2FzIG15IHJlYXNvbmluZyBidXQgSSBhZG1pdCB0aGF0IGl0J3Mgbm90IHRo
YXQNCj4gaW1wb3J0YW50IHNvIEkgd2lsbCBsZWF2ZSB0aGlzIHRvIEpvbmF0aGFuJ3MgcHJlZmVy
ZW5jZS4uLg0KPiANCj4gSG1tIG5vdyB0aGF0IEkgc3Bva2UgYWJvdXQgdGhlIGNvbmN1cnJlbnRs
eSBhY2Nlc3MgdG8gSUlPIGF0dHIgYW5kDQo+IGJlaW5nIHBhcmFub2lkIGFib3V0DQo+IHRoZSBj
b21waWxlciwgSSB3b25kZXIgaWYgd2Ugc2hvdWxkIG5vdCB1c2UNCj4gV1JJVEVfT05DRShhZGlz
LT5zcGktPm1heF9zcGVlZF9oeiwNCj4gQURJUzE2NDc1X0JVUlNUX01BWF9TUEVFRCkuLi4NCg0K
SG1tbSwgYWN0dWFsbHkgV1JJVEVfT05DRSB3b3VsZCBub3QgYmUgYW55IGhlbHAgc2luY2UgdGhl
IHNwaSBjb3JlDQpkb2VzIG5vdCB1c2UgUkVBRF9PTkNFLiBTbywgaWYgd2UgYXJlIGdvaW5nIHRv
IGJlIHBhcmFub2lkIGFib3V0IHRoZQ0KY29tcGlsZXIgYW5kIGxvYWQvc3RvcmUgdGVhcmluZywg
SSBndWVzcyB0aGUgb25seSBzYWZlIHdheSBoZXJlIGlzIHRvDQphY3F1aXJlIHRoZSBhZGlzIGxv
Y2sgW2J0dywgSSdtIGEgYml0IHBhcmFub2lkIHdpdGggdGhpcyBzdHVmZiA6KV0uLi4NCg0KQW55
d2F5cywgYXJndWFibHkgdGhlIGxpa2VsaWhvb2QgZm9yIHRoaXMgdG8gaGFwcGVuIGlzIHJlYWxs
eSwgcmVhbGx5IHNtYWxsLi4uIA0K
