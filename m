Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5F3F2760
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhHTHON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:14:13 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:14494 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235996AbhHTHON (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:14:13 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JKBXir022238;
        Fri, 20 Aug 2021 03:13:22 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nnxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:13:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwlSpzPfEaqQEvhWGjHwZz8R7OJHVjfn4kFcCDVu7Ashdj0BaW1Xj2vV9tg6yXGj5VVxkawIBfbTfjXYLFJlZqf6loujlwzMBcOHzvmSSScxsL3IUfmefD0WNUxOBhbGFMsIg5YB0KC+B3+K2oZNYwfn5OSUJQ574sux5prfaf9pCrcovZJfi9wBDLEJ8AGY4/pDxOVxC0THOaguhp2KgKFM91O/Izc7WEG1cBaC0OkccXz6DjcrL4J3uSozpqiWhscXd4NqkSJddFFAuVTaZ3IBt3mEObakKC4r+Jjhj64ixqgtlAuoTyYa5zxW51r29tuLzr/ZqMmpMgC2qFzcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+D1seH1oszrPcMsLz8LH7A82mA62h2P7rxLvNXNyNw=;
 b=SHARKQG04gaylo64SDhXC89kBsSq9stxk4rXY368CKasZAvUEKSrYCWFJC+Cp96e+bRTsevua9ndikoo1ROCt3SNshlVbjXOU5tyjO4rI0slWbFvrMX7efpDfYzl2kao08Hb+T/gyWh3zAOnvnAiT0pv6E1XMDOi13AGh/3GVU1+5eFppcaYYql3TTECBrisfXSO0JLR5fkLGUYm67R5IDdLuBln+WNeOTVHjlyLcneNwoZoQmr5+PalLqIQ1n/iPGnAHU7bchCa9b2KUZ9lFiba1I2J3963AnimkGpn/rrHbwTtWKB6UZRiddN0+M1PSI+oj3bhcgHmNOSqRRyLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+D1seH1oszrPcMsLz8LH7A82mA62h2P7rxLvNXNyNw=;
 b=wDi4UdbbnNRudgAbByC5X/TfaLLcFJR8EBwywsD2T0C26gEz7XjTc5azI0cn7UpirwvxEeSBujOBPj6N4MEk1UXv0kR+fZc2j655qeovgrnNTUj2lBJsZlwfHCdIzqyLJSaKznX9g+Hp5Pod89g9G6C81yF+dYsBm5uuNyFScFI=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BY5PR03MB4933.namprd03.prod.outlook.com (2603:10b6:a03:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 07:13:21 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:13:21 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/16] iio: adc: max1027: Rename a helper
Thread-Topic: [PATCH 06/16] iio: adc: max1027: Rename a helper
Thread-Index: AQHXlCHbQGgPNCVGyE2pg8vS/Vk3YKt7/WfA
Date:   Fri, 20 Aug 2021 07:13:21 +0000
Message-ID: <SJ0PR03MB6359B18276B110E1A4AD956799C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-7-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-7-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1UZzNZamRoWVRJdE1ERTROaTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhERTROMkkzWVdFMExUQXhPRFl0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRrM01D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGN4T1RrNU56QTBNVGszSWlCb1BTSjVUM0JtY0VK?=
 =?utf-8?B?Q2NXbEliM2xQVTFWSFRIaHRaell5ZVRSWUszYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTkdXazVNWVd0d1dGaEJZVk52VWpWek1sUlhTbXh3UzJoSWJY?=
 =?utf-8?B?cGFUbGx0VlVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: b67e56ed-a4dc-4a77-71c2-08d963a9fe3c
x-ms-traffictypediagnostic: BY5PR03MB4933:
x-microsoft-antispam-prvs: <BY5PR03MB49336B2D2580FC4DA173CA8B99C19@BY5PR03MB4933.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: in9xw0hiQ3h1DQrQGIg30oe+g+Dj65Dd/NVFNDo5mRtnave7tkilXy98DhkgpUvL4l121cul2jleN8F0S2yVW+gc1G90P8aROcmtrD3AJITwfDMSLhDhgPPimvzYhWL8p97g0R+X918573uVIbS2zfgvrmHk8fRE0UM1kgjSwG9Ugl3yat+/j9aDla4EO9RXemY8ESoaEa5sjKlQ8ZC9M9NnpV+90FZ5Fp65Y7DJ43xv2vuivYvngiByeRF/eXcixqf1CbI4n/TiFGBv+pD9Chlto0fJKmPO2MCQVPO1ZR0SSOhn+6Pa0DLdBVLwS6Oq015n3vqXQEjzctFTzv/iIkXLiI0qu5YvDKPKYIF+k9kdJhRJJfzQRidQ7+kotkTtr4Agi5s+YErw382Dlt/aff6O51JNO9OTAW7BY7Dd8u4kHyl0QshoOc4r5HHfq87ZP5aY3lIee3b5Gz9pHHAA6FdG5k4UPtTpk8CjwAxxnmF5te9PMwTwBEXRLl0GH8GUikM3flPByzp8VuBSTQoraIYFKLKxEO575c1XE/YAyp8Nhy2Pw0cN5b1P/9BZ/BusSftfmBob+BaUR/wpZ20lpbeutq/4LYpdmCDuc8DB5DbC/decq8cfkStRLce+YvWIKhWOArfuSzJh6RaDl3Wa8wA4PYZV+Ub11Sp2yLZiG29jFIGnjPD0oFG79grkpp2RdRLnDyffwOD9P9HZnzdyaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(26005)(33656002)(8936002)(2906002)(76116006)(110136005)(52536014)(316002)(54906003)(4326008)(5660300002)(186003)(8676002)(83380400001)(86362001)(38100700002)(66446008)(64756008)(478600001)(66556008)(66476007)(66946007)(38070700005)(122000001)(9686003)(7696005)(71200400001)(6506007)(55016002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bERET1J3eUp2bCtSbGUrMWN4ZXBqOEFLNlVYM0hqNllrWFZLYXdCRTl1bFBG?=
 =?utf-8?B?WlhWb3pvYzdVejBhMTJuNVhlZExNbWpsanBGZThhd3o3akJqTE9yZDNuSHJM?=
 =?utf-8?B?NTRPeitVRW03cmhZQkR3YmVXMERWTms3WVVXemgwd1pMR0pNQm5OZGVoVFc5?=
 =?utf-8?B?KythdmlPRUNqM0pUZ2FZL2Z5Y042MGZnN0hYR3J6ZVJWMmtDZnM5ajJIckRa?=
 =?utf-8?B?dXZZclNyWm04bnhOcDVBcHpyWTFZZy8zSklVVEsvY2NFUnc1VVV3R2UwZFlu?=
 =?utf-8?B?MWRnM3BvSmw5dEJsN1F0NjhENDhIMXNlQ2RQMmtTSEVMeWtjSGY4SmNKdHRY?=
 =?utf-8?B?cExuWVNsU2V4TEc0OVdjT0NZN20zYllMam9WZHM1OGhTcDJJdndWaDJ1RjZZ?=
 =?utf-8?B?enJIU3VMOWR2LzBiaHJ5VGZGRTdKVjNkaWtROVczeW9Vbm4rYzc4eFhyakk2?=
 =?utf-8?B?Z0J5YkpDZFVEUXJBMis2Q1ZHR3VHVk1IQzdxKzFXSHhDWkY2Qk1LSXlMWm1t?=
 =?utf-8?B?cHQyTmszZHNjN1NQVitkUnhKb29UVk5waFRLeFJsZzlhUmNGekgwQXAyZXpU?=
 =?utf-8?B?M0FkeUhybC9RSURSSkE4OUhFaHlkTUFXeTRSV0c2Q2lXclhXY3l5VHRzZmdF?=
 =?utf-8?B?RnJjemxiMHpqNy9lWVJMUUR6UTcyNm1iVWNoLytvM3VGZVdtNFFQem1KSHpp?=
 =?utf-8?B?eGEzNnAzNVJFSys5OFovMFdWN1FFWjhLVGhYU2lXMnA2b2YyR1pXK2RnMXBv?=
 =?utf-8?B?TlNBS1N3QWJ5LzluZ29jai95M3NyOHZvWTViN2VaTjBXU215bzVMR29BZjlB?=
 =?utf-8?B?bFVMZGQxZWpIMGRtcFZ1b1JIdmViMkFUQzhBOXB5ODlCZk8yN1R6Q2E0WDlu?=
 =?utf-8?B?WWdtdkwyWU9ObmxDenlLL0c1UVBRR3hNcDRTS0hCb3VKRElvVkhDWkdYcHY2?=
 =?utf-8?B?UkpDYk1BT21nVTMrQWN6MmpLQlZDUGRVRGJGSm5wVWNEUy9iSUxkUWt5QWZn?=
 =?utf-8?B?dld0SlFNV25QQVgwc2R2WFdIQ05DVUROcEZyckVBVnFMT0hxd0IydXQxSFRI?=
 =?utf-8?B?eHdqc3NjTGs5ZFYwcVBNRmIyZDNoRFJ4TDZ3SnJtTTFqVVFFZ09oTjlGR09J?=
 =?utf-8?B?ZHFaWjN0SkRENVpwT1VYSXI4d2gwWldhR1g5d0dvMUhqTEJKdmlzZ0tDdTdJ?=
 =?utf-8?B?aGJjWUlzYTFFbUVGMDZxbXc3dEhya0JmZU85YVFYdHpGL1ErdEV2S0lTYzFY?=
 =?utf-8?B?Um1rQVhUZTMzWDJuSlAvUHllTndPWkVsWkcxQjlKZFBHSTdYYmZGaVo1R2w4?=
 =?utf-8?B?U0RrNVVtazZvdVo3dU1SQkYrb2N6Z0kxZW9wR1huSmEwRjFrZUh5Y3dzL3FJ?=
 =?utf-8?B?VDBLOVNlNUdFYVN6ZEZtRXhWVU9CVkVwRExrek8wS2J3aURqdWx2Rk82K2tt?=
 =?utf-8?B?d0NKbFhZK1B2NzVFVVZ2RVRIUGJKSy9EdXZxbjRvU1FoVFNIWDJSYWV1VnYz?=
 =?utf-8?B?OE1DMmo1NXhJUzJPZHdPSVlwdU1FKzQ1ajBxcEVNUUk3RGRvbUh1SjdNc2tM?=
 =?utf-8?B?czdUY2V0aCt1V0VEeVIrNm0rYWU0SGxMRDNvcmlFWnplWDZIQkN4R05Dai9J?=
 =?utf-8?B?TlVsbnJwMXF0cU1NNnUrWEtHY0REUW1OSVZKSEV2K0dEWFd2Rjk4b3VjMGNR?=
 =?utf-8?B?c2tjejdFNHRTWmNjOEUrc1R6RTlLTnRwbE8wcE9YOFc4cXM0ODhPNTFteDNW?=
 =?utf-8?Q?TMrCsz4Au9+YZX/Wy8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67e56ed-a4dc-4a77-71c2-08d963a9fe3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:13:21.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSalP7pNLejNId6UGn8rkXsnylJ3hQa0q0xhfibOJQKbz64EKgHT0tfc1zn4t0nWxy6LLH4U384XBU2KLndZmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4933
X-Proofpoint-ORIG-GUID: H8qmYyDpDsrdVlE-ZFpRV6YaYeQlj8Yf
X-Proofpoint-GUID: H8qmYyDpDsrdVlE-ZFpRV6YaYeQlj8Yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200042
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMSBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDYvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBSZW5hbWUgYSBoZWxwZXINCj4gDQo+IFtFeHRlcm5hbF0NCj4g
DQo+IE1ha2UgaXQgY2xlYXIgdGhhdCB0aGUgKl9zZXRfdHJpZ2dlcl9zdGF0ZSgpIGhvb2sgaXMg
cmVzcG9uc2libGUgZm9yDQo+IGNudnN0IGJhc2VkIGNvbnZlcnNpb25zIGJ5IHJlbmFtaW5nIHRo
ZSBoZWxwZXIuIFRoaXMgbWF5IGF2b2lkDQo+IGNvbmZ1c2lvbnMgd2l0aCBzb2Z0d2FyZSB0cmln
Z2VyIHN1cHBvcnQgdGhhdCBpcyBnb2luZyB0byBiZQ0KPiBpbnRyb2R1Y2VkLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+
IGluZGV4IGFjNjAzYjRjYTc4Ny4uYTZlYmM5NTFjMDlhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2lpby9hZGMvbWF4MTAyNy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMNCj4g
QEAgLTM1NCw3ICszNTQsNyBAQCBzdGF0aWMgaW50IG1heDEwMjdfdmFsaWRhdGVfdHJpZ2dlcihz
dHJ1Y3QNCj4gaWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4g
LXN0YXRpYyBpbnQgbWF4MTAyN19zZXRfdHJpZ2dlcl9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIg
KnRyaWcsIGJvb2wNCj4gc3RhdGUpDQo+ICtzdGF0aWMgaW50IG1heDEwMjdfc2V0X2NudnN0X3Ry
aWdnZXJfc3RhdGUoc3RydWN0IGlpb190cmlnZ2VyICp0cmlnLA0KPiBib29sIHN0YXRlKQ0KPiAg
ew0KPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBpaW9fdHJpZ2dlcl9nZXRfZHJ2ZGF0
YSh0cmlnKTsNCj4gIAlzdHJ1Y3QgbWF4MTAyN19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19k
ZXYpOw0KPiBAQCAtNDIzLDcgKzQyMyw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtYXgxMDI3X3Ry
aWdnZXJfaGFuZGxlcihpbnQNCj4gaXJxLCB2b2lkICpwcml2YXRlKQ0KPiANCj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaWlvX3RyaWdnZXJfb3BzIG1heDEwMjdfdHJpZ2dlcl9vcHMgPSB7DQo+ICAJ
LnZhbGlkYXRlX2RldmljZSA9ICZpaW9fdHJpZ2dlcl92YWxpZGF0ZV9vd25fZGV2aWNlLA0KPiAt
CS5zZXRfdHJpZ2dlcl9zdGF0ZSA9ICZtYXgxMDI3X3NldF90cmlnZ2VyX3N0YXRlLA0KPiArCS5z
ZXRfdHJpZ2dlcl9zdGF0ZSA9ICZtYXgxMDI3X3NldF9jbnZzdF90cmlnZ2VyX3N0YXRlLA0KPiAg
fTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19pbmZvIG1heDEwMjdfaW5mbyA9IHsN
Cj4gLS0NCj4gMi4yNy4wDQoNClJldmlld2VkLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cu
Y29tPg0KDQo=
