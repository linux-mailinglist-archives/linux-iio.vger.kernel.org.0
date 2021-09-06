Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8BB4018F9
	for <lists+linux-iio@lfdr.de>; Mon,  6 Sep 2021 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhIFJjW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 05:39:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7518 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241357AbhIFJjV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2021 05:39:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 185Lnfjq013962;
        Mon, 6 Sep 2021 05:38:04 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by mx0a-00128a01.pphosted.com with ESMTP id 3aw2whaqvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 05:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqaxiWSRIp3+Fm6cWpSP4lrsvBSxxqwGtC9mgeZXZa3b1VqjYlMBP5ihYNZpWC0NYpCCs6/gPJJpsDJxrD1nh7YOvnDx0vR9segFAILVl9brcTIid5TkU2nvZOrDJnkts6w9q6vikZMWTvaRfG0bgFFqJCgXMd99kvIj4oXA1rmoZWxYJgFgBXUxYZhvlaCF77jo8TniIOUNQL5NyRdR9cwhv+i5KPqZa2eOtnG2fBREOcwLPfif2yVnOcUbilWvzGrNSMgl2HzhI5qDftOELy9TqJ51B3w4SjCdYqotayrw/fLL+zdwsoLQ9LH20+ke9RHu281kmtA+LYYWCHdyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7/guqjhQiuReSUM3xjRnBep0oqyp5vRsfgJLVrkemao=;
 b=aDXtQXUN4OkDORyGu9ZbJx3EVGrItHxV2TfCq4+Mkhv5ilLNqwgYsXWuN8VDqGu0IBm8nt3lhk8v+eQbAIi9lMPWLe1ykaJn5pgbbmQhGSK0BvS79rTtiZuWqXwKhKBnWL8QoZnv2ySTSZpKLOtQiHsujsvIeJJAxQotJ21z6MPsH0RnT/KZYqArGgmAmengKBFpxhnNA52O6QTVVUDeXAIXa3vuBw3S1XHMj3L88B7WsCJ9p/44RjToCzgMamP/o9HpzDIKzujmp6fNU6ev+6zBTX9MPd11qehtnlCZiZS54HtOS41seN6/aQTefdzU2c1o7Rkbnu2ON+yfihgZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/guqjhQiuReSUM3xjRnBep0oqyp5vRsfgJLVrkemao=;
 b=wmAfSnQpKT//Gp9OLmUDA4BaofW/0exmhjzLcgr1pefo0bKLtcEpvP5f45B3jHrevZGN2D/shRdQcrH24ltIZ0Je0Jr6rTaOFYjsWJvSiT/ECiPC174C3T2ur4M0EyUdpmnA86ngNoGcSWS3ZLy5GvXc0gnotE7+0X47pdusZ9Q=
Received: from SA1PR03MB6355.namprd03.prod.outlook.com (2603:10b6:806:1b6::10)
 by SA1PR03MB6321.namprd03.prod.outlook.com (2603:10b6:806:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Mon, 6 Sep
 2021 09:38:02 +0000
Received: from SA1PR03MB6355.namprd03.prod.outlook.com
 ([fe80::f0f4:64cb:bc0b:95d9]) by SA1PR03MB6355.namprd03.prod.outlook.com
 ([fe80::f0f4:64cb:bc0b:95d9%9]) with mapi id 15.20.4415.024; Mon, 6 Sep 2021
 09:38:02 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v2 14/16] iio: adc: max1027: Don't just sleep when the EOC
 interrupt is available
Thread-Topic: [PATCH v2 14/16] iio: adc: max1027: Don't just sleep when the
 EOC interrupt is available
Thread-Index: AQHXoD+VyvpZRmfyEUGYFlXZeOtExKuWw0JA
Date:   Mon, 6 Sep 2021 09:38:02 +0000
Message-ID: <SA1PR03MB6355578764364F98D3FF163A99D29@SA1PR03MB6355.namprd03.prod.outlook.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
 <20210902211437.503623-15-miquel.raynal@bootlin.com>
In-Reply-To: <20210902211437.503623-15-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1XWXpNMlZqTlRjdE1HVm1OaTB4TVdWakxUaGlPR1F0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhERm1Nek5sWXpVNExUQmxaall0TVRGbFl5MDRZ?=
 =?utf-8?B?amhrTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpJMk9D?=
 =?utf-8?B?SWdkRDBpTVRNeU56VXpPVFEyT0RBME5ETTVORFF5SWlCb1BTSkJNRkl5TWxa?=
 =?utf-8?B?NVJtUlVTREYyVG0xWlJXRkxTVTB6UkVObmVuTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTlRVMk12YUVGeFVGaEJWbGhKYWtWSFdtaGFhVU5XWTJsTlVW?=
 =?utf-8?B?cHRSbTFKU1VaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVmh0V21kcWQwRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-ms-office365-filtering-correlation-id: c18b6e36-f725-4215-ff1e-08d9711a0569
x-ms-traffictypediagnostic: SA1PR03MB6321:
x-microsoft-antispam-prvs: <SA1PR03MB6321FEA0044636C34B7C966099D29@SA1PR03MB6321.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 51zavDeXcpY8Pn1F8ScBH+MoDbaG1cKvPvJ3fu1Q7DrJBDpX4o0v3dkmRbwv5mQP9nSWjS07JwXi5mT3xI3yQDdYR6zfQfAjT4wvSCeo1W3AY1cikZkyUtNz4tugfJ9hBTqG9pgd1SlPUKG8ncM3QbzympqtjoF/tynG8+5MTti1w/P1WnzZMpz3Gc+LJynWGRJWtwJoHbhj4LWy5nDQOkR/It5pVL+UI44CoMlfYS6v6Mc9AylPn9k5gZf8xHPtb2AxkAZqNGci7AD/kNdEuFXlO1M0qlpSU8mBfOlqWcJ4rMrppfZQAoZeVyDkkzSdvhAhNjrdw2fmXZ715LT8xVuehFrR4Jf7eMqtZq5JlK7rNbStIePWg2U+OxPsgKGUqKzx2SN0hwyAdrtHAZRfuxdRnHAFVitdM6H5k8FMYtnB2WrmaajTkrmkT0m9lu7RX+P9BAt39nkd37Ajouyt5lUAxSXt6LQsVfVDf+rsXuYwfbGkjgfTl9CVgV3+AWalZCMq5ML/joSapFq08RQ1PQrYzoM+nxlLRagT6KX+Vbg244IOcMHIbuKlHeh3y2QZmM5njM3wex/MbzNKRYzw7DAJD3k3Rxn4LmV/OxGOyB7lTmfZhyhSav11koDLgmB7CVgkxOiTK3C+Vwj5pqHPhafoYQc4hnpwGw+7RyaSGf2OblIX5BuGZm2MrU3zIyDQQ7Rwhr5bkQh/2UZ7Fda3aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6355.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(122000001)(110136005)(38100700002)(316002)(33656002)(5660300002)(83380400001)(38070700005)(4326008)(76116006)(8676002)(66446008)(66556008)(64756008)(66476007)(86362001)(66946007)(6506007)(478600001)(2906002)(55016002)(26005)(7696005)(8936002)(52536014)(9686003)(53546011)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTJySUlCUm9FMDRMZ0tMWFdyS1IzdHNXdFdKcjlocFZ6V3BLZEhZaVZtVDUr?=
 =?utf-8?B?S1lyTndOUitKUkhSNkZuVndTMS9hd0NFRFl0N09tdHZHcEo1OTJSK0xXazg3?=
 =?utf-8?B?dGhyZ2luVm1FSExsYy95YWhCUkhhczNWaXhTMUFnRGtHVmh2NndWNk16V2Zs?=
 =?utf-8?B?UU9vTmRmS0pXWG54dzdQNnhVOGorN0s4YUY4ck9NSms5ekFWaDh2bk9nVDd3?=
 =?utf-8?B?YmJuMG5sSS9nUG0rbTBlbGZ3VTRiMklxMlBFZDgzN3RtUklXWnZnTkRwRFFv?=
 =?utf-8?B?TmgzMTkyK012NXJlNG53V3JxaVc2NjEzL214YTdEbmRERmFzWEVtNithZkxX?=
 =?utf-8?B?U0FBTnc0VG5ZM2lxZUpDUGxUTS9QZndRZHY3UEhOTVpyc3BnN2ZONWhsbDh4?=
 =?utf-8?B?emM3bVEwSEJnN3czMyt3RzhPc2hMNmJhdDZFbWk4eVhCVm5MR1ZDNTEzODcy?=
 =?utf-8?B?cDk5U09VZW9HeE4ycnhzNUFwVlR3KzE1cHJnKzVSa1Z4SWdwaXNQWWQrUmo2?=
 =?utf-8?B?RUpMd0tOeE42QjY4Q1FmaWNoamgxMzhXOG9ta05IWWF2dHgvbDF0eDhmMG1u?=
 =?utf-8?B?RE9HRXZGMlU5a0FGNWZQOWxqNTdNUWp6c0F4blRtOU00U1RRc3NrM1BHYmhx?=
 =?utf-8?B?cTQ0TGlCVUxSYTRhZzhvbXNrTVpVa2xrOEtKeGs3RGZpbklRZ1BrQ3VXd1FT?=
 =?utf-8?B?Z2FrNVZPekwxTklhU2w1WEtBTWVFRjRiQklYVGovRmtSeTQzSkVTWEhiVzlR?=
 =?utf-8?B?ZVlrdFF2d0Ewdlg3emJ6Y3F3dmFKOTd6cDdXN1VhN3QrL3VzSCtZOG5BOFhD?=
 =?utf-8?B?RlNRSzVOVUZOWEJWY0RwbC9IZHMzVTFvbDV3NEZwdm5UK05rUmxDdGswVEcw?=
 =?utf-8?B?YnVpTUx3cHJ4WkFBTTJ2TGtyODZZREhlcklDQ2pXbUhOanRHUnh3WnlCTmZx?=
 =?utf-8?B?QUJLOHRtRVY3dUgwTkoyd2VKN1duQ3JkZjNvemxGMkhpVzhrMkpneFJJQWNB?=
 =?utf-8?B?cktTQklodS9neU1TT1lSMmxkK3gvUWRFV0JxQjJQdnhiZEt2WGJhU2wvZTlB?=
 =?utf-8?B?c0Nta05ucWlPVUtDaVVNTmMvQXF4VHVqUjZjWlZTbjFzc2w0YXcvTDIvT3RZ?=
 =?utf-8?B?emRmYmVMcmF1NEkyS1cyd2paSGlhUmdNcUE0dWxNTFhwNnhsSjUyeUVHMHcv?=
 =?utf-8?B?UXFnZTRZbnA4TFM4QmhvMkMxRERhSVpyRFQ0b1pWQnBHbGFaS1AvelpkTXND?=
 =?utf-8?B?eGFGTjllZE82MXJTZ3YvV2JRbmVjNGVzN0ZLQXhaL0RJaEM1ZUNVcG54U09s?=
 =?utf-8?B?YThGQmxUZnFONmpFQ2ZVVjhEZSswdHV4VlJaVUpTUzNGc1lCdHUxeTRXcUw3?=
 =?utf-8?B?VGJFWU53UG9JR3ZscTlaSldZMGNrY1h2SUsyY3hWSTUvUk1UV0FRZjBSbmJu?=
 =?utf-8?B?NFcrbWU4M3VvUjBISlltN2F3UTNIdWlEY2NodURhSnY0K05yeFlGSDJsRmFl?=
 =?utf-8?B?RVl0NnZvcmF1cDNscHh5WFFnQ1BoRHJsN09rZDZiK0ZWdXFkYUV1ZUQycGg5?=
 =?utf-8?B?SkpNSWRhTk9sU3ZKdTRlZ0wzN0svRWxWV1hEUHhBajRNWWdMeUJwMmQrUU9E?=
 =?utf-8?B?QnVWSDN3L0toei92a3hIOGd2akVTN2pkSndISkVYK2dkdVExaDJxc0JhUFBr?=
 =?utf-8?B?bURlZEpTKzV6YnBYSlB6S1lyRm1sczdldEZuU0xRdW1WVElqTUEyc2lidFMy?=
 =?utf-8?Q?iKb95ZDC1/GAKvomzIsiZlMqEm9GyD11kD+J+Ma?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6355.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18b6e36-f725-4215-ff1e-08d9711a0569
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 09:38:02.2372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9r1yX7Rgv+9IvV62ke9ePehsQZ5YQr0/VedXPsM0jAhPPB+Y1wd4xCBW+dHGkWZhI/XXFfmXbwS6Jye25V6VeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6321
X-Proofpoint-ORIG-GUID: 1IwqVmvT0YwYXSLMFKdCUj34cdg6v8F_
X-Proofpoint-GUID: 1IwqVmvT0YwYXSLMFKdCUj34cdg6v8F_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-06_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109060060
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAy
LCAyMDIxIDExOjE1IFBNDQo+IFRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3Jn
PjsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28uZGU+OyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogVGhv
bWFzIFBldGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IFNhLCBOdW5vDQo+
IDxOdW5vLlNhQGFuYWxvZy5jb20+OyBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3Rs
aW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMTQvMTZdIGlpbzogYWRjOiBtYXgxMDI3OiBE
b24ndCBqdXN0IHNsZWVwIHdoZW4gdGhlDQo+IEVPQyBpbnRlcnJ1cHQgaXMgYXZhaWxhYmxlDQo+
IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBUaGUgaW50ZXJydXB0IHdpbGwgZmlyZSB1cG9uIGVuZCBv
ZiBjb252ZXJzaW9uLiBUaGlzIGN1cnJlbnRseSBjYW4NCj4gaGFwcGVuIGluIHR3byBzaXR1YXRp
b25zOiBlaXRoZXIgdGhlIGNudnN0IHRyaWdnZXIgd2FzIGVuYWJsZWQgYW5kDQo+IHRvZ2dsZWQs
IG9yIGEgc2luZ2xlIHJlYWQgd2FzIHJlcXVlc3RlZCBhbmQgdGhlIGRhdGEgaXMgcmVhZHkuIFRo
ZSBmaXJzdA0KPiBzaXR1YXRpb24gaXMgYWxyZWFkeSBjb3ZlcmVkIHdoaWxlIHRoZSBzZWNvbmQg
aXMgbm90LiBJbnN0ZWFkLCBhIHdhaXRpbmcNCj4gZGVsYXkgaXMgYXBwbGllZC4gTGV0J3MgaGFu
ZGxlIHRoZXNlIGludGVycnVwdHMgbW9yZSBwcm9wZXJseSBieSBhZGRpbmcNCj4gc2Vjb25kIHBh
dGggaW4gb3VyIEVPQyBoZWxwZXIuDQo+IA0KPiBSZW5hbWUgdGhlIGludGVycnVwdCBoYW5kbGVy
IHRvIGEgbW9yZSBnZW5lcmljIG5hbWUgYXMgaXQgd29uJ3Qgb25seQ0KPiBoYW5kbGUgdHJpZ2dl
cmVkIHNpdHVhdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9tYXgxMDI3
LmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiBp
bmRleCBiODVmZTBhNDhmZjkuLmU3MzRkMzJhNTUwNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9p
aW8vYWRjL21heDEwMjcuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+IEBA
IC0yNTYsMTUgKzI1NiwyNyBAQCBzdHJ1Y3QgbWF4MTAyN19zdGF0ZSB7DQo+ICAJc3RydWN0IGlp
b190cmlnZ2VyCQkqdHJpZzsNCj4gIAlfX2JlMTYJCQkJKmJ1ZmZlcjsNCj4gIAlzdHJ1Y3QgbXV0
ZXgJCQlsb2NrOw0KPiArCXN0cnVjdCBjb21wbGV0aW9uCQljb21wbGV0ZTsNCj4gDQo+ICAJdTgJ
CQkJcmVnIF9fX19jYWNoZWxpbmVfYWxpZ25lZDsNCj4gIH07DQo+IA0KPiAgc3RhdGljIGludCBt
YXgxMDI3X3dhaXRfZW9jKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ICB7DQo+ICsJc3Ry
dWN0IG1heDEwMjdfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gIAl1bnNpZ25l
ZCBpbnQgY29udmVyc2lvbl90aW1lID0NCj4gTUFYMTAyN19DT05WRVJTSU9OX1VERUxBWTsNCj4g
KwlpbnQgcmV0Ow0KPiANCj4gLQl1c2xlZXBfcmFuZ2UoY29udmVyc2lvbl90aW1lLCBjb252ZXJz
aW9uX3RpbWUgKiAyKTsNCj4gKwlpZiAoc3QtPnNwaS0+aXJxKSB7DQo+ICsJCXJldCA9IHdhaXRf
Zm9yX2NvbXBsZXRpb25fdGltZW91dCgmc3QtPmNvbXBsZXRlLA0KPiArDQo+IG1zZWNzX3RvX2pp
ZmZpZXMoMTAwMCkpOw0KPiArCQlpZiAoIXJldCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsNCj4g
KwkJcmVpbml0X2NvbXBsZXRpb24oJnN0LT5jb21wbGV0ZSk7DQoNCkkgd291bGQgY2FsbCB0aGlz
IGJlZm9yZSB0aGUgd2FpdGluZy4uLg0KDQotIE51bm8gU8OhDQo=
