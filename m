Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AA3F275E
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhHTHNm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:13:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39176 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235996AbhHTHNm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:13:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JNIHxY025183;
        Fri, 20 Aug 2021 03:12:50 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ahdb2fxqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+OCdDJ6qSnix/qizvmdbtadGanlVSZqf9Ydxk1soOUym/VDY702MZ3npELC6w05spsbfkXzQCZvE0fXhHuSqAwK3y8SiWnF/zg8fBkNqakkbnz/r2MDeiEqZcdssmZrb5kgLerakrcdjwA79mqw5ELOtXySQKr7QidvZEevSdPEzkHStSpBwH19kDzwa07HGv9YSgmGgoNhSSLE14ABkeUQZXrwJHWhJDnHNwcPkagsVBLzAIr/J595RQk9LA8xzaXaSLvD09izsq+5gGuo+slcwTDh7O3C2+G+0zkje+tX9cTJ0deijBzMlx7TJ1HJeIfjCZddc4ZdRitptFzCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDrNxzRi4CauNrfHXIp0MRgEfneQq4IzTgzHPJh/Id0=;
 b=GG3Mhog+Mlc3FuA291WShe0Y5Y4Stfn7x5Hl0sqAQ7GY4mWu40drVP5Ayx4mY4rnWlGSfHPAECIjjE3+0vvJ19f+kP0H1PkxU1M3vtwn3VbkiUeD5oOOmmoaR4BuEcXP86hjBGPmBdStpxczWvpGRunJS6RNpDmzymXCqjvBqZoC/JH9J0oiJwQQ+0N1hObZkuBL0BOwM9FmXaTZvISYsBgSGbRQmbU1yR+3+ehatxYW21NlRneNfSBqtvsindyVqHwuQeRiFhhoDptT/aoSCJ1gAojcih77vgB9HWBaGKvChDlONju7SomV2EzGtHX1GMc7hkr3oDlLkc3m5+3F5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDrNxzRi4CauNrfHXIp0MRgEfneQq4IzTgzHPJh/Id0=;
 b=rXRZ3GfB6dIrjYh+rtdSluXTReEbS/8EJEsAgkBjXRz+ustCpa33Y8gjYxcubshufJpUXOtD4huEjrR3kEeNGF4qaiEL/FMeZxCbHFKbWAe+p068VPsyHST2lIMAw2NvTM4SIlucDaFlDcfqQ//nrm02ymt0LdhraaEZnsuggtM=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB3957.namprd03.prod.outlook.com (2603:10b6:a03:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 07:12:48 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:12:48 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 05/16] iio: adc: max1027: Drop extra warning message
Thread-Topic: [PATCH 05/16] iio: adc: max1027: Drop extra warning message
Thread-Index: AQHXlCHbogguYiOyrkSQQHqSekeDoat7/UHw
Date:   Fri, 20 Aug 2021 07:12:48 +0000
Message-ID: <SJ0PR03MB635985E95ADAD117DB0371D699C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-6-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-6-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1EUTVZV05qWVRRdE1ERTROaTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEQTBPV0ZqWTJFMkxUQXhPRFl0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRRNU15?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGN4TmpZMk1qWTNOVGd3SWlCb1BTSTJVRVV3WTNO?=
 =?utf-8?B?Rk0wdE5RbUV6WmtwQ2RWSjJhemR5T0V0NE5YTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTTRhbVpNUjJ0d1dGaEJVV295Y2tWbmMyTjNkRTFEVUdGelUw?=
 =?utf-8?B?TjRla013ZDBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 9856227b-3acd-4879-91f1-08d963a9ea6c
x-ms-traffictypediagnostic: BYAPR03MB3957:
x-microsoft-antispam-prvs: <BYAPR03MB3957009932B445FF34109AE999C19@BYAPR03MB3957.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHibix1lqVnYmDNOQ329AIMLoUqUJ8GuNRF18PE+qjxrvtr2ja+4IR4GG8UkgUJsRSI86Ouumge6nIdDsgJZBPPMNe5uaUBnpWikeyia+Rz3o/4VUFnQb17My1otpZzbz+ESeRX4UMKFkC9X8vmRD4YCwue0uWzzNIpZ1RapKHwhCrmnksBgrWq1BVW0Ry2T14W5CvQVcvjNOKtS87dUqHbpi8anpAB8btK0pxOowa5SxoNfz0TAowfjoEHMHYUu1ByGYb9QIqaD4J36+nzxT3uxs+nuiZYhwDpYNAY7ntgqi9vOOCat8m1ddMpPjcsylEBW+YKa7md0F2VVE2eSU3fqjtjJOiP6oKz0rJd+EzkalpiiSE8cx0I5YyHaNmYugHNSuLyKzAh/tVAuXdvTtnjSvwHPetcrdK99BhA3FaNPwhRV3KQvjCJx9Bcvt44x49QD/cwT60g8JsvTa60YG0HlsmfpIh1ujNl1UTIzp8Qc6fhsYnjBdnOF9+eqn8fOaHWiejhwFJdzPZSaGpYfPMRC1m2KlH4ZBukKgh6tLqzhUOMm6TTyNZEY7WKZuc9AtqKQ+EohfeIdfi0MMnbCMA9TtqaubAij3q8cJjhGaiLIfz5Qmea1INwEZp3lTBjesomzKg9mDfaIy0qaiVdw0VPgNzFgnvyKJlHEBL4J+hxW1Zc/qgNC9XqX497XflNaAa0d7gk38pSPAT0MpH8ZSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(66476007)(53546011)(26005)(66446008)(6506007)(38070700005)(4326008)(66556008)(52536014)(64756008)(71200400001)(55016002)(9686003)(54906003)(2906002)(8936002)(76116006)(66946007)(110136005)(86362001)(8676002)(83380400001)(122000001)(7696005)(5660300002)(38100700002)(33656002)(186003)(15650500001)(316002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGVCNHBtNlJuZGF2NzArN043NG9CVjIzOVNwS3R1bEQ2eStYYk5GcHM2QVQy?=
 =?utf-8?B?SC9ZeHMyNlQ1UzRPMWRZSkM1TitnOGpPeHdjWmVwZ3h0RTYwQ0lYS05MYkcw?=
 =?utf-8?B?VGF5Skc3MlUvV3ozcUphS08wMTVDNFo0RU84ZXZqWkl0cW9CbEprdjlqRFVZ?=
 =?utf-8?B?VWtqQmk0b29VbWp4NERrZkxQTUNRcW5XU3FEQVRxc09nck0xTXg4a1pmZ0V2?=
 =?utf-8?B?TEozaG9zTkd2dEF4WmFIVVlRM2hMQUh1cWxoTFByZ2ZXVEw4YUFjN25TY2g5?=
 =?utf-8?B?RDVqRVB3cXNjdXVoWVVjM04wZ2pKSWdtOXNGbE9ta1dsSzBJVjhKaFc1a1FX?=
 =?utf-8?B?NWE2dTQ4b2x5U2pua2hFaFUreVdDdmdNb2ZtcXoxZFBsNWR0TE8yNzUrWTMw?=
 =?utf-8?B?dGZwaDJwTjNjS0p5azJKNGsyUC9Wa2NobDBwS1RXNEQxd0JobFdSU1BTODNG?=
 =?utf-8?B?d3gwK28xRkhhcitqdlJvdWFWSTdYWCtncW1HbFNDMVAwQmNrZ2xMd0FUaStu?=
 =?utf-8?B?VmQ2ekxCR1Z6OFkzeCtBWlU3dm80aVBTNSs5WGVVN1NUK3hDeE5EcTBtYzM3?=
 =?utf-8?B?MFJyZFY0VWFKOUF5VHczRnliZlI5U1BiRDBjanJhNFQvT1RVSTR4QzYydEJY?=
 =?utf-8?B?NkkwTGNCY08vUVRnZ3g2NzNNYmkzZXA0UU1HcytMVTljYVd5eXVrSEkyNWR0?=
 =?utf-8?B?TjNHZFcxa093Vm9KV0M0dWN0Z1BOZi9vOXk5ZFJCTzQ3K3p1a0V2cUIwK1JR?=
 =?utf-8?B?eGFtd3pKRTJBRUVISk9oekw4YjQ5TDBsU3NwOFpjdlBOeWtoQU1TM0dtMmEw?=
 =?utf-8?B?dXkwVXVvQWZLd3J6VkUxSGdJdWJXbmZ5cW9iME40V045ZEZrV1FQQWpQa0F6?=
 =?utf-8?B?V2Nld29yNGVtdmJ6c2YvZ05kVVFhbU5kMEJMa2s3R1BJS0NWTTJ0bXY3WlFk?=
 =?utf-8?B?ZXJURzFGL0g4elMrL0VDNmVZeGhIazlCdlZwQkpmejVNRHNtOGJOd0pyVUln?=
 =?utf-8?B?OWp6WlVSWjlCWnBreTRIK21xRDV0WThXMHhZZVZEVTBta3pDUjRFc2tLSFBK?=
 =?utf-8?B?OGtqOW5jUEFOQzRxaW5jMmhQczl1OWxJMFdIaXQzaDg3eVg2bk9JSVFaUnZP?=
 =?utf-8?B?ZnFZSnlOWjQ5WjdVMTFVbHRyVUc4VU5aVi9BMG9EOThvUnlLNjB5WDBXZTk5?=
 =?utf-8?B?Q1lNYno4d3FyTFM4L05jeERTU3psQW9MemQrSFRPRjlqWFlpSTNld3dONUZy?=
 =?utf-8?B?RWE0SXFxVEdDMC9EUnNic2p1Uzd3MjVIMVpUWVV2bjYwR3Fjd0NkckhaOGZG?=
 =?utf-8?B?eFZrK3ozRnc0N1ZSQUZNMG9DNEZna1Y4NzZIWHVJM0wzUUEvUE1PbllRUGwy?=
 =?utf-8?B?UGI0TGl6SUZjZWNZdUlObC9UWVJ0dnNWZWZ0Q0duZ0psZ2xSWFk5ck9zMDAy?=
 =?utf-8?B?NlduMzlURFVQcWhyNGFMcXhVZDJPc1VXUlhkMmp3T3FKV2NLZk90MHJOU1Fk?=
 =?utf-8?B?R24zSnlSRlZCZ3p0VDY0T2I2ZTBLYkpxSTN1L1BHRHdpZjNZdDhKbjRaRm5k?=
 =?utf-8?B?Qk1XRDYzbjlVbmFFTG5IVXJjenVlNHE0QkFMRkR6UWUvbU0xa2xCYlRTc2s1?=
 =?utf-8?B?SXE4ZU1aR3Q0REYxNWZ5UG9iaHg5OUJiamdxOEVTU2VmRXBwRGhKQTg2YTRC?=
 =?utf-8?B?TXNCUnZBdm14YWEwYm8wdG4vYzJSN1NpcldkOGhkSDBRbnoxY3JHQ1BXbXBu?=
 =?utf-8?Q?M3+orMjJM0ITGPjINY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9856227b-3acd-4879-91f1-08d963a9ea6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:12:48.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZVsG6P7F9Wi14tLw6ZxpIC9ZSxRp9owe0Un3997DQGT4exr1JyH9GVjgKyw0NwDm9/P8OYeHNLgLKO4/S61Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3957
X-Proofpoint-ORIG-GUID: gDmCy5Jjvvjf90I7BvwiufFFLrTsKMDV
X-Proofpoint-GUID: gDmCy5Jjvvjf90I7BvwiufFFLrTsKMDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMSBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDUvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBEcm9wIGV4dHJhIHdhcm5pbmcgbWVzc2FnZQ0KPiANCj4gW0V4
dGVybmFsXQ0KPiANCj4gTWVtb3J5IGFsbG9jYXRpb24gZXJyb3JzIGF1dG9tYXRpY2FsbHkgdHJp
Z2dlciB0aGUgcmlnaHQgbG9ncywgbm8gbmVlZA0KPiB0byBoYXZlIG91ciBvd24uDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMgfCA0ICstLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0K
PiBpbmRleCBkNzlkYWJmMjA1NjcuLmFjNjAzYjRjYTc4NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9paW8vYWRjL21heDEwMjcuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+
IEBAIC00NjEsMTAgKzQ2MSw4IEBAIHN0YXRpYyBpbnQgbWF4MTAyN19wcm9iZShzdHJ1Y3Qgc3Bp
X2RldmljZQ0KPiAqc3BpKQ0KPiAgCXN0LT5idWZmZXIgPSBkZXZtX2ttYWxsb2NfYXJyYXkoJmlu
ZGlvX2Rldi0+ZGV2LA0KPiAgCQkJCSAgaW5kaW9fZGV2LT5udW1fY2hhbm5lbHMsIDIsDQo+ICAJ
CQkJICBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoc3QtPmJ1ZmZlciA9PSBOVUxMKSB7DQo+IC0JCWRl
dl9lcnIoJmluZGlvX2Rldi0+ZGV2LCAiQ2FuJ3QgYWxsb2NhdGUgYnVmZmVyXG4iKTsNCj4gKwlp
ZiAoIXN0LT5idWZmZXIpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAtCX0NCj4gDQo+ICAJaWYg
KHNwaS0+aXJxKSB7DQo+ICAJCXJldCA9IGRldm1faWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXAo
JnNwaS0+ZGV2LA0KPiBpbmRpb19kZXYsDQo+IC0tDQo+IDIuMjcuMA0KDQpSZXZpZXdlZC1ieTog
TnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0K
