Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E383F27AA
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhHTHcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:32:39 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:61866 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238756AbhHTHcj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:32:39 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JKBXkQ022238;
        Fri, 20 Aug 2021 03:31:48 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nrst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:31:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3FtS1Tz+spyKDrwPT/Tg6ee4G7Olp5fcfXnFviIUoXHtGJx+n4BYPmZHY7rE3F76Q8LwIMicPxjr9sLk/CHKvbzyLV8WNxF3XInTDWKLbPMnp26XiPd8hKrZjKCRI/djJc98NFY5DbKunHnhoNDa6tX9wxVekrGwFI+xSOtMbYoiemnpgyAoG/j9ypbs34/jRPzoFAM30Q8bGJksjriK60+iwq5e1gTjpNTj8GrNuOl1He6cqPvOA01Sl7cZB/nIo+vRpSOb/kr1OKLTwsQMu01YMc7zRPKBMRV0XBvZtpfZRyHiYuvZwjobt8j99twHZ4CfkyRc2rHUA/Byp2GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJG8AVvqTCHEFt5l3MzGuNyq9hd8YE8IigXFb8ljt9w=;
 b=MWKhEtxG3KX0OYw12Zp2jKF2LF/zkYXk6ZAVqbGxP+tN6PjjS+MiQtilB9y2e7VDsdpv4dkB0cFl3Dz9GLkqydtJz8DlemDt0X4REOQDXufI1HstK7cIHC36Wyyq++bmLTKB9LgDJTqZNiWn3vl9ZBl942hkjkty+g46HCQM1O7jN2D9Mb2s6nJxP2s7PGfpx55LsMd3JC/gBkZMPU5KHVSbHHVkcVlRFH8xm8E9Bz2TMc/senXRmD0+f4OOGiWbQEq4AHaZ0NW0QfFLRmQ/sIj2AYG4zeyp0iwX6H2WGUAkwn7hL06K+yROd7sO8GzujbTFwNbJkWT1yKh6u6rJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJG8AVvqTCHEFt5l3MzGuNyq9hd8YE8IigXFb8ljt9w=;
 b=VnYG6dw3qZm4dxBk91rfsc4CrAUMN+iuolSWA7CjFxqp54BynYH836OcIVm3KD8BqqW2ZwhZbkKwyKGFBpRyqGj3AwJVEz0VVK2QzPDWf3A2kSX3hYh07YUAVPRj90RDwz6li5JZNRDfTDk844wDc2914CBlKbsCg/HiAGHfRu0=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by SJ0PR03MB6358.namprd03.prod.outlook.com (2603:10b6:a03:390::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Fri, 20 Aug
 2021 07:31:47 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:31:47 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 13/16] iio: adc: max1027: Prepare re-using the EOC
 interrupt
Thread-Topic: [PATCH 13/16] iio: adc: max1027: Prepare re-using the EOC
 interrupt
Thread-Index: AQHXlCHeLg1OtHqUdUiSE9dea53Qjqt8AkCw
Date:   Fri, 20 Aug 2021 07:31:46 +0000
Message-ID: <SJ0PR03MB63597D5F2FAA3BA4854F4F0499C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-14-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-14-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlXSTBNVEV3WVdFdE1ERTRPQzB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHRmlOREV4TUdGakxUQXhPRGd0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpjME55?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGd6TURVeU1qQTFNelV3SWlCb1BTSXlhMVJCY0dW?=
 =?utf-8?B?WmNXTkpjbTV5ZG1ZeE5qUkNiMUIxYUVwcWVEQTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRnRURnB3ZEd4YVdGaEJVa0pUVGxoTFkxTkxORXBGUmtreFkz?=
 =?utf-8?B?QjRTWEpuYTBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 553e28ed-172e-4605-eede-08d963ac9128
x-ms-traffictypediagnostic: SJ0PR03MB6358:
x-microsoft-antispam-prvs: <SJ0PR03MB6358D95192126388BDE9F1BA99C19@SJ0PR03MB6358.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkMNXr+KCOIiRgQXeGwXXxlRpnWDC5JkvAXJTEvK8Pa2axKU0uYNVPc/zkADN/ZHbE9ZwvaYAprZ2wtsMXA7YrPG5SHYQ5Eg7eqhv2XQrdXCWQui/DhOQCwSuLKMLW3QIuyO8+zyAT9qzlgAgiHFFPYZKqbXuRJvgpN0yuZSUJtVDWburHJzh8Px2+X/13PaC1w2DVOZEfZWMwCt5mDE1EBpdRfXk1BnOj2DqQvBBJ2sGpLStkQyQba1Y8bzV43C6Qc/k/NaylR7TwEbSB+SZ4+YVaSYIQZDqj4FOk6qUCJvHT0EToEc1yR+Hr+guYcE2CyV592CBlvJMKAQ90CMtuXHl0iPmjeRWS7qwvhvWS5sr5I+RQzdXO3AICx/t4Z5dQkZdWuGmzhsIn1OANcq/marv8WxlSy1jb0ZnZidVEsKM8Y78Hwcci/xTg6GrrxyvSsSuxhr8ul1ZIxyDTd4YMCyI3CA7QqTHEvKJYTfqdkSkSog91+95Hb/ANoJB2sx1F6FxA2x0Cfyy531joChNmLISqw+PNZ0xyi9APU5DniFk2y9ovkEvR4nEUQ3W2bxQsX84gXyN24VPngsMbk04X3IFpqjhO35x944cHIzCfhj0Zrfmze93uAg030OrZWLoBO+4gFTetPlvqndb2W/TwGDwmJ36WFz9xibzeIds7X4RmhiKc7ZwUTrsXTCjLE2goF0lBDei9UZkk2e4BxFiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(122000001)(86362001)(76116006)(66446008)(316002)(8936002)(38100700002)(478600001)(26005)(5660300002)(66556008)(64756008)(55016002)(9686003)(8676002)(7696005)(53546011)(83380400001)(6506007)(66476007)(33656002)(38070700005)(71200400001)(66946007)(54906003)(4326008)(2906002)(186003)(110136005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d20zejN4alJ6d0RwcUhFK0xUcWNLeEprcWVMVDJybStLOGZqYTROQXVlUUJn?=
 =?utf-8?B?WHZMa3pGVG9kRXl0UStTbGRTc3JydDJ1ZHJPWEx5Q1kzYURBWFdCOGxraGFN?=
 =?utf-8?B?Y25sVjduOG1DU1RLUFU3UHNwNGNCSE84YnJxSXFMcjNzR2M3ejNyNmFYQzBM?=
 =?utf-8?B?MHFGODVQdU1aaHlvU1hvbVVjME9IcWpBQkswZDdZL2daR3Y1SDFPMFU3OEJp?=
 =?utf-8?B?TnFNVkEya2hmMDdjVXJYNUQrRkFjMXh5Z08zckZybC91S09YTXBaZ08rT1lw?=
 =?utf-8?B?Sk0rMXZHREdqbUZYNVBnUDh3NHcrZXE3dzIvamQvblg2clVtOGU5NUUxZGRW?=
 =?utf-8?B?dVJnQ1ErL0E1U2lwQnVEL1pkc29pM0lDSS9mSkc0TWZzc3lzcVM4bktJc0pS?=
 =?utf-8?B?VzFOUnFiOEdhQzhua0htbXpiSk1CRmtQWkVZbStGNTlwSWdJWm5mTTdXdDgy?=
 =?utf-8?B?TzZLK0JpVzJjbHlONWU0RXNacEJtRmxGTGlqYjExbkx6eGFiMjZ1M3NNdGRU?=
 =?utf-8?B?czVXRHFUbkd3MGZPYzdYMFpBMC9yWW5pZEt6R2RNalNZRTZjaXAwRmFMdExW?=
 =?utf-8?B?c1JlM0VMbmFrMmc3V2xOMTlRWlBucytVc01ud0txYUFSbTlWUkp2L3QyU1Qx?=
 =?utf-8?B?cEZhOXhwSDBZbnJQUlpiTEhTMm52d05XV3Y0YjAzMitqWEM3Rmt0Y2N3NktS?=
 =?utf-8?B?NGZMQW40QzMrZlhVUnRMWm5rNHE2bDlxVnRoZ1NtOHVPTlhvamlvT1VEMnJk?=
 =?utf-8?B?dm90RW1CWjYyYk92SzBzNFZZSzJKM0NObkhjNmZZcUhwd2xXMnVFUHM5RTFH?=
 =?utf-8?B?OFNYbFdaNEFRNVJzbGFxanh1c3BzUlZjNyt1MndIcnpleXFmN3N3eVkxOFho?=
 =?utf-8?B?MFBEVmRwdjh4TWNKb0lDRE9qL2E0NExiTzRrbDdDZW1vc3dPSStpcjBqTEhG?=
 =?utf-8?B?ZGM2MG1FQk9OeENuMEpLaVRGZ0k2bVJRMG1pZjYxc2IvVWxscmI3KzhjTFVV?=
 =?utf-8?B?K3JrVzdDRlNEaWJ3Y3grcUIzaVhveUJNWi8vQjJLNk5CckxwbnF2NU0zOS9z?=
 =?utf-8?B?Z1FvT3VWWlAvbDBFZFZ3QzZyUUdKZ0ZHWjY1WmJ4TUtiVnJnRUZIRlFZazN1?=
 =?utf-8?B?a29VTW1jR1FLOXRGTzJzT3NKYXhZNVNzREI0SkpEZTcrVFEvd1pyVllSWit6?=
 =?utf-8?B?R2R5OFVKb25YaFVmR05ZNTFka2xNWmxMTUNYQ0dTcldYZURRbG1ZRU5xb1Q4?=
 =?utf-8?B?TFRkbG03ekVFeTg0dUlPd3BqTWlUSjg5OVhTR3g2bWMwYitrL0xYakxmTXRR?=
 =?utf-8?B?SDhraURZVFp6UVNEaWVmdnJVSmpkemZzUER6OGQ4MlNLbklrNVF4WHljalQr?=
 =?utf-8?B?Y1BNQXU1TFZhaHNwQnBGQ3FqcDFsaFFOaEZINzNoMXgvS2tRblB1cWhpZ29F?=
 =?utf-8?B?cFBOdkI5Z2t6cFFYelo3U2VONGdLUk41NWpUN2o3dTcrWlJnaDh5Zm9QMnQv?=
 =?utf-8?B?T1VOZHV4bFJCRklHK04wRHhZUmt3ZTRuemt0cTJ6NVpvd29hcFlXeDNrTURM?=
 =?utf-8?B?MFlWeTJSUlVxYlhNS0xWWW9jbjF5M1c4ZGtzN2JrRGNxd0gyVEVhWUx0cWor?=
 =?utf-8?B?eHViak9ZVmcyTHBRRDdSOVVvWnlZaUp6RzNERC82d3VOVkZlUlBMdmtPN3Nx?=
 =?utf-8?B?QmZ6SUdlTzg3c1pUdWdMaUhpVUVhdE82MWwrbWVPdVdvMVhLSWpSOFI2bEU2?=
 =?utf-8?Q?PqYqhLtcbEKWp6odR9wv+aodQegmzsng0lfLWwF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e28ed-172e-4605-eede-08d963ac9128
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:31:46.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7DIEIYJcWTi9b4Q8sfVbaJK17/0327TK1Xyqu7pIECkrW7UVTzSys79Ld9VXNzKeeryri+pVLY+7LW32ZZYv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6358
X-Proofpoint-ORIG-GUID: Ht5Oy9fTWT6LTIfTvWhFkDCBaM6C-Xdf
X-Proofpoint-GUID: Ht5Oy9fTWT6LTIfTvWhFkDCBaM6C-Xdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMTMvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBQcmVwYXJlIHJlLXVzaW5nIHRoZSBFT0MNCj4gaW50ZXJydXB0
DQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBSaWdodCBub3cgdGhlIGRyaXZlciBvbmx5IGhhcyBo
YXJkd2FyZSB0cmlnZ2VyIHN1cHBvcnQsIHdoaWNoIG1ha2VzDQo+IHVzZQ0KPiBvZiB0aGUgRW5k
IE9mIENvbnZlcnNpb24gKEVPQykgaW50ZXJydXB0IGJ5Og0KPiAtIEVuYWJsaW5nIHRoZSBleHRl
cm5hbCB0cmlnZ2VyDQo+IC0gQXQgY29tcGxldGlvbiBvZiB0aGUgY29udmVyc2lvbiwgcnVuIGEg
Z2VuZXJpYyBoYW5kbGVyDQo+IC0gUHVzaCB0aGUgZGF0YSB0byB0aGUgSUlPIHN1YnN5c3RlbSBi
eSB1c2luZyB0aGUgdHJpZ2dlcmVkIGJ1ZmZlcg0KPiAgIGluZnJhc3RydWN0dXJlLCB3aGljaCBt
YXkgbm90IG9ubHkgc2VydmUgdGhpcyBwdXJwb3NlLg0KPiANCj4gSW4gZmFjdCwgdGhlIGludGVy
cnVwdCB3aWxsIGZpcmUgZm9yIG1vcmUgcmVhc29ucyB0aGFuIGp1c3QgYSBoYXJkd2FyZQ0KPiB0
cmlnZ2VyIGNvbmRpdGlvbiwgc28gbWFrZSBhIGRlZGljYXRlZCBpbnRlcnJ1cHQgaGFuZGxlciB3
aGljaCB3aWxsIGJlDQo+IGVuaGFuY2VkIGJ5IHRoZSB1cGNvbWluZyBjaGFuZ2VzIHRvIGhhbmRs
ZSBtb3JlIHNpdHVhdGlvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxt
aXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9tYXgx
MDI3LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9hZGMvbWF4MTAyNy5jIGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiBpbmRleCAy
ZDY0ODU1OTE3NjEuLjhkODZlNzdmYjVkYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRj
L21heDEwMjcuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+IEBAIC00NzIs
NiArNDcyLDI0IEBAIHN0YXRpYyBpbnQgbWF4MTAyN19yZWFkX3NjYW4oc3RydWN0IGlpb19kZXYN
Cj4gKmluZGlvX2RldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaXJxcmV0
dXJuX3QgbWF4MTAyN19lb2NfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqcHJpdmF0ZSkNCj4g
K3sNCj4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gcHJpdmF0ZTsNCj4gKwlzdHJ1Y3Qg
bWF4MTAyN19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiArCWludCByZXQgPSAw
Ow0KPiArDQo+ICsJaWYgKHN0LT5jbnZzdF90cmlnZ2VyKSB7DQo+ICsJCXJldCA9IG1heDEwMjdf
cmVhZF9zY2FuKGluZGlvX2Rldik7DQo+ICsJCWlpb190cmlnZ2VyX25vdGlmeV9kb25lKGluZGlv
X2Rldi0+dHJpZyk7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHJldCkNCj4gKwkJZGV2X2VycigmaW5k
aW9fZGV2LT5kZXYsDQo+ICsJCQkiQ2Fubm90IHJlYWQgc2Nhbm5lZCB2YWx1ZXMgKCVkKVxuIiwg
cmV0KTsNCg0KSHVoPyBTaG91bGRuJ3QgdGhpcyBiZSByaWdodCBhZnRlciAnbWF4MTAyN19yZWFk
X3NjYW4oKSc/DQoNCi0gTnVubyBTw6ENCg0KPiArCXJldHVybiBJUlFfSEFORExFRDsNCj4gK30N
Cj4gKw0KPiAgc3RhdGljIGlycXJldHVybl90IG1heDEwMjdfdHJpZ2dlcl9oYW5kbGVyKGludCBp
cnEsIHZvaWQgKnByaXZhdGUpDQo+ICB7DQo+ICAJc3RydWN0IGlpb19wb2xsX2Z1bmMgKnBmID0g
cHJpdmF0ZTsNCj4gQEAgLTU2MywxMSArNTgxLDExIEBAIHN0YXRpYyBpbnQgbWF4MTAyN19wcm9i
ZShzdHJ1Y3Qgc3BpX2RldmljZQ0KPiAqc3BpKQ0KPiAgCQl9DQo+IA0KPiAgCQlyZXQgPSBkZXZt
X3JlcXVlc3RfdGhyZWFkZWRfaXJxKCZzcGktPmRldiwgc3BpLT5pcnEsDQo+IC0NCj4gCWlpb190
cmlnZ2VyX2dlbmVyaWNfZGF0YV9yZHlfcG9sbCwNCj4gKw0KPiAJbWF4MTAyN19lb2NfaXJxX2hh
bmRsZXIsDQo+ICAJCQkJCQlOVUxMLA0KPiANCj4gCUlSUUZfVFJJR0dFUl9GQUxMSU5HLA0KPiAg
CQkJCQkJc3BpLT5kZXYuZHJpdmVyLT5uYW1lLA0KPiAtCQkJCQkJc3QtPnRyaWcpOw0KPiArCQkJ
CQkJaW5kaW9fZGV2KTsNCj4gIAkJaWYgKHJldCA8IDApIHsNCj4gIAkJCWRldl9lcnIoJmluZGlv
X2Rldi0+ZGV2LCAiRmFpbGVkIHRvIGFsbG9jYXRlDQo+IElSUS5cbiIpOw0KPiAgCQkJcmV0dXJu
IHJldDsNCj4gLS0NCj4gMi4yNy4wDQoNCg==
