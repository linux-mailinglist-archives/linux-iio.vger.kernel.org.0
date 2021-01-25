Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0146930483B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 20:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbhAZFrr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 00:47:47 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30408 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbhAYK3t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 05:29:49 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10P8jT31006009;
        Mon, 25 Jan 2021 03:47:51 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00128a01.pphosted.com with ESMTP id 368hk9dk47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 03:47:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/Zt0ox2veapNv2QsTdBoG2q6X4iPFA0GYKi4wq0PpQtRxFlqm9yLZHMZGupG92bEiXk1K/+s7Q/dSq/Cj37daK+ADdJjgirNIlNYO6VdGWMUYvckdtd1DBddn5ri6OYQeQKQt1PvLckF75wHTOPly1lN/NXna4YHT0Q1glkkvAY5SVZXnziMEWzZxMEVbrB/X/Ul4+sjdw3lZl3CvvN6SunNBl7l+JePKQwXN43q5Ygfyi2f1StSR161WQfUpNxU3F4GvImz4nY//eBOmBMmP8o9eBE/XKXXGNxI0eIB9/3SfJSnJyIfQOEOlG5sssRFseGy6Hek2FGrhCQToLbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQw1csOs7slPbFq9vrdU00hl8J9fXXnmOPwUXdCNhbQ=;
 b=X8eoO668yO2xKXitq3zIsTLI2mN+ZsrfNg3X9sZ5QIrKoxNO4gD/wH4pUcBtGI1SlMUD7Ki6zpZaNDm3/qFp0tpXloB5D0jO5qlLLA70qehk/qZ4CBzVM6lQhIq1P1r3a5ZOpkcaIzkDYuGE7c25n2KbzDkqMvoHv+eznntxvHpjaCnukGrux0V1UZns4ZuoWG49JCFIgkfiLstksS8JkHRWcA7S41qW8oXyRnkMNHX5jddH6hTJtSbhuLMlR/zn9auXyTjmBrTtY13kHHNlxYmiwBMUPMwWTpm+MHPTPHmMEnCJEBpNWJnsqGoCyCSrvIxdycV1ReqhkKMQWwbRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQw1csOs7slPbFq9vrdU00hl8J9fXXnmOPwUXdCNhbQ=;
 b=suBkvA+TESkDcpG6LU0szBzch7CyK4D9lYk8XA8TJG6skNSjzLHpPACUnreCwjDAgvpZfysHht0dUxvWmDbh6tpkB7XVIhAGQZh3Q3cZeHO5imxKLzFfESDTPQM4I3GGqwVBnpZf5ivL/FYwAdsQda7GvZDt5xvEXfuG+dtDVf0=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY1PR03MB2299.namprd03.prod.outlook.com (2a01:111:e400:c611::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 25 Jan
 2021 08:47:49 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b%7]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 08:47:49 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH 2/4] iio: adis16480: fix pps mode sampling frequency math
Thread-Topic: [PATCH 2/4] iio: adis16480: fix pps mode sampling frequency math
Thread-Index: AQHW7+uv8GS0BY65tEeUuPsv0S5c4ao2zeqAgAE/iTA=
Date:   Mon, 25 Jan 2021 08:47:49 +0000
Message-ID: <CY4PR03MB2631F0B2BEE923F5DB8A114499BD9@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
        <20210121114954.64156-3-nuno.sa@analog.com>
 <20210124134321.713aa5ce@archlinux>
In-Reply-To: <20210124134321.713aa5ce@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFptWmhOR1UwTUdRdE5XVmxPUzB4TVdWaUxUaGlNREl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHWm1ZVFJsTkRCbUxUVmxaVGt0TVRGbFlpMDRZ?=
 =?utf-8?B?akF5TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpT1RFd015?=
 =?utf-8?B?SWdkRDBpTVRNeU5UWXdNemd3TmpnME5EYzFNamszSWlCb1BTSk5ORGhqVmxO?=
 =?utf-8?B?Ukt6bGpTM056YlVGamNuWnNhVXg2Tlc1SGJHTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTm9SeTh6UWpsMlRGZEJXa0pYTUU5aEt5OXNTQ3RyUm1KUk5Y?=
 =?utf-8?B?STNLMVZtTkVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRUzloZUdSTlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:25ba:fd01:81d3:5715:13ec:f57a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 514d9c4f-e0c2-4d35-2263-08d8c10de521
x-ms-traffictypediagnostic: CY1PR03MB2299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB229919EF9B23A88F998D3F4199BD0@CY1PR03MB2299.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hdalYu8Mwom76FKPKrkpUMau/6nz81WNXgAod5P8EC5Gc+vKQKBouIL9C+G6JsqHmbnrykrYoND2/14J5TyiOJiQ7EtX/+l8hUQBfOH+RkZ9pm3DFiIGAQlNo7KY8V8acxN9iySgNQUDZeIH+seKn6Y+bVuE8sdmqYClKaVpmq8ZD+Ocv4YkVXUJHMyDlN+bR0kBHlOVLv4fTyd0YFbcu4jJIiapLfLxtLm8KVUFd3JEbmbRVqnT1C7Qck58QXBcZDSqEs/jQisWdV4yGhple86UYCL4tbQteUQ2zLwXe81vpNlrUOG9NbeKG5JiL2HoOFt+SOJ0zOMxr8HrA0AVRhS34apOKxQhRHHR6nWuulexBMejCPxSLPEVr9iplcMoChvdQhD2+uJGNNbUGje9zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(76116006)(8936002)(107886003)(71200400001)(66476007)(66556008)(5660300002)(4326008)(64756008)(33656002)(53546011)(6506007)(52536014)(8676002)(66446008)(2906002)(6916009)(54906003)(7696005)(66946007)(55016002)(498600001)(83380400001)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ekVyL1RNZ3lMWVhaamZhSTV5dWl3UlNwMmRPWTE5cVFQMUNvbzZTbzhiNWor?=
 =?utf-8?B?T2s0K3Q0NWM4VW5JQ0VHTS9NSll4WjZlZUdVNXliZXM3dmdBYjNqZm53RXU1?=
 =?utf-8?B?RTNVajQvS2puUHJzUWU2UWtmQzg3V3hHOTNsblI2UWJCZW12aEIzamxVbnNS?=
 =?utf-8?B?NzhreWkyTERjMVpnemlqRWEwcXZFT0JKQ0k1U1VEbHdaSVdTZW1kSWV5R3U3?=
 =?utf-8?B?TWV2aFhRWXVFSEppZGppT3ZjZVJTdUQrMzVrY0g1d01HL2oyc3dGUVRXdDM5?=
 =?utf-8?B?d2dzNmhnampUeEJhM0gxUlJoUU94T09wajJyOFAxZkdLR0VvYlJrV2dmTXIr?=
 =?utf-8?B?cUxOOEZWWXplRituT1hud2VQWHRHQ2dNNGVCajFoVWxyYU9yT3NTMDhQbnZh?=
 =?utf-8?B?VDlOM2FMSXdmUit6SmlObEZHMFF1dTQ4bExYazZVdURmMXdlanFoM2JuVzc5?=
 =?utf-8?B?Vit6WmdmV2dlbjFUV09IVjJNVWZMR0t0SlRlOVEyc1ZTV3lTaGxoc3gxMVZF?=
 =?utf-8?B?elJhM2VQdEFMRTJqd2pYdGZKT2lhNEloRWgwVGRWaGpLWDYxL2xBdm4wWHA3?=
 =?utf-8?B?ZXFRTUkweUwxZGcvcU1pYU9VM09sYmpmZFo5NkFVNFlHeDNNSUk0VjlTMlBX?=
 =?utf-8?B?Z1RrR0p5STh1QUxpMG1UcTVodDBwdDZOYzFiOGt6UjhDOWZYYU1jVW9ITEFs?=
 =?utf-8?B?NDJsRUpKZ1ErYnV4MXd5V0E5dzlDbkpGOXZRbDJnRENzNng5TlJhL2VsZkFT?=
 =?utf-8?B?TVp2V1BRc01TTE9BWnkxa29lQVBkcWpndGRGaFJ6SUJCUkdNcDhCcHBPaGsy?=
 =?utf-8?B?L00zWUNraTdheUQ0elRJUzNtMXJ4OWdzaHQ3Zmp0Mlltc3BxY3FzN0FFWlkv?=
 =?utf-8?B?QnYrektMUnh4RHp5Rzl2bE9RdEdFNXZjVjZxUXBKMWZ2SjBTOVIrRU91Q3lH?=
 =?utf-8?B?cnNPN0w2UUV1UXV0SFZ2a01JRGtxUjQ4K29ZdUVOZEpjaW0wMGU0SUxrNUI2?=
 =?utf-8?B?Z3Ryd0VlcTVST2V3c25XL05oWStsQlpSQXJxbW91VmUwT2xMMGJUOEF5WXla?=
 =?utf-8?B?TzVkME1FVzBEQk83dkF0aGJ6KzFpU3ZXT3ZQVXlVUStSZmFkbE1waFdTem9j?=
 =?utf-8?B?UGdDVGhnR0lmc1ZPeHluSHMveDdoRHZITWd4KzNzWWdudm45ZjlMb0tnQUNh?=
 =?utf-8?B?Z1pMd1FzUU94ZE9kUHM2VHVoN2k3UndTRnlWd0JJMHVHbW9sQ1M0ZXp0NWlj?=
 =?utf-8?B?c0Q0aG1wQ3huMm9wMUJDRHBzelB6dWg5b3cwOFNvZFI4UXFhWTdqWEt1Zytu?=
 =?utf-8?B?YWYzVldRT0hjVDdPdWRxVTdZSUdReE5MQUVoOHN5aDRaNVNpazFLQVJKdzlE?=
 =?utf-8?B?ZitYWXc4VHdrYytja004NTZQUVhONW5zd2NpYWh0cUsvS3ZUcWJBN1IwM1dh?=
 =?utf-8?B?WlR0Y2g5OW9zRjVQdFZFcTJYamF5VUFMenJleEZSdnFhS3BxTm9vaGpjcXZD?=
 =?utf-8?Q?5wg6BqQYVLxqWDUbK8boVsnASAG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514d9c4f-e0c2-4d35-2263-08d8c10de521
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 08:47:49.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vy8K+33LUfs/bV6xlOlL9wk313yEBhTs2tO/t1O3MhzEZIQ7kp+ND0slw07JofAhN1MR376IPP2JsPLP8Q04Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2299
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_03:2021-01-22,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5k
YXksIEphbnVhcnkgMjQsIDIwMjEgMjo0MyBQTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5h
bG9nLmNvbT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgUGV0ZXIg
TWVlcndhbGQtU3RhZGxlcg0KPiA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBMYXJzLVBldGVyIENsYXVz
ZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5u
ZXJpY2hAYW5hbG9nLmNvbT47IEFyZGVsZWFuLA0KPiBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRl
bGVhbkBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gaWlvOiBhZGlzMTY0
ODA6IGZpeCBwcHMgbW9kZSBzYW1wbGluZw0KPiBmcmVxdWVuY3kgbWF0aA0KPiANCj4gW0V4dGVy
bmFsXQ0KPiANCj4gT24gVGh1LCAyMSBKYW4gMjAyMSAxMjo0OTo1MiArMDEwMA0KPiBOdW5vIFPD
oSA8bnVuby5zYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+ID4gV2hlbiB1c2luZyBQUFMgbW9k
ZSwgdGhlIGlucHV0IGNsb2NrIG5lZWRzIHRvIGJlIHNjYWxlZCBzbyB0aGF0IHdlDQo+IGhhdmUN
Cj4gPiBhbiBJTVUgc2FtcGxlIHJhdGUgYmV0d2VlbiAob3B0aW1hbGx5KSA0MDAwIGFuZCA0MjUw
LiBBZnRlciB0aGlzLA0KPiB3ZSBjYW4NCj4gPiB1c2UgdGhlIGRlY2ltYXRpb24gZmlsdGVyIHRv
IGxvd2VyIHRoZSBzYW1wbGluZyByYXRlIGluIG9yZGVyIHRvIGdldA0KPiB3aGF0DQo+ID4gdGhl
IHVzZXIgd2FudHMuIE9wdGltYWxseSwgdGhlIHVzZXIgc2FtcGxlIHJhdGUgaXMgYSBtdWx0aXBs
ZSBvZiBib3RoDQo+IHRoZQ0KPiA+IElNVSBzYW1wbGUgcmF0ZSBhbmQgdGhlIGlucHV0IGNsb2Nr
LiBIZW5jZSwgY2FsY3VsYXRpbmcgdGhlDQo+IHN5bmNfc2NhbGUNCj4gPiBkeW5hbWljYWxseSBn
aXZlcyB1cyBiZXR0ZXIgY2hhbmNlcyBvZiBhY2hpZXZpbmcgYSBwZXJmZWN0L2ludGVnZXINCj4g
dmFsdWUNCj4gPiBmb3IgREVDX1JBVEUuIFRoZSBtYXRoIGhlcmUgaXM6DQo+ID4gIDEuIGxjbSBv
ZiB0aGUgaW5wdXQgY2xvY2sgYW5kIHRoZSBkZXNpcmVkIG91dHB1dCByYXRlLg0KPiA+ICAyLiBn
ZXQgdGhlIGhpZ2hlc3QgbXVsdGlwbGUgb2YgdGhlIHByZXZpb3VzIHJlc3VsdCBsb3dlciB0aGFu
IHRoZSBhZGlzDQo+ID4gICAgIG1heCByYXRlLg0KPiA+ICAzLiBUaGUgbGFzdCByZXN1bHQgYmVj
b21lcyB0aGUgSU1VIHNhbXBsZSByYXRlLiBVc2UgdGhhdCB0byBjYWxjdWxhdGUNCj4gPiAgICAg
U1lOQ19TQ0FMRSBhbmQgREVDX1JBVEUgKHRvIGdldCB0aGUgdXNlciBvdXRwdXQgcmF0ZSkuDQo+
ID4NCj4gPiBGaXhlczogMzI2ZTIzNTc1NTNkMyAoImlpbzogaW11OiBhZGlzMTY0ODA6IEFkZCBz
dXBwb3J0IGZvciBleHRlcm5hbA0KPiBjbG9jayIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTnVubyBT
w6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gDQo+IEFzIHRoaXMgaXMgYSBmaXgsIHBsZWFzZSBt
b3ZlIHRoZSByZWZhY3RvciBvZiB0aGUgbG9jayB0byBhZnRlciB0aGlzIHBhdGNoLg0KPiBXZSBk
b24ndCByZWFsbHkgd2FudCB0byBuZWVkIHRvIGJhY2twb3J0IHRoYXQgcGF0Y2ggaW4gb3JkZXIg
dG8gYXBwbHkNCj4gdGhpcw0KPiB0byBvbGRlciBrZXJuZWxzLg0KDQpIbW0sIGNvbXBsZXRlbHkg
bWlzc2VkIHRoaXMuLi4gd2lsbCBkbyB0aGF0Lg0KDQotIE51bm8gU8OhDQoNCj4gSSdsbCByZXBs
eSB0byB0aGUgY292ZXIgbGV0dGVyIGFzIHRvIHdoYXQgbWlnaHQgbWFrZSBzZW5zZSB0byBkbyBm
b3INCj4gdGhlIGNhc2Ugd2hlcmUgd2UgYXJlIHBvdGVudGlhbGx5IHJ1bm5pbmcgdGhlIHNlbnNv
ciB0b28gc2xvdy4NCj4gDQo+IE90aGVyd2lzZSwgcGF0Y2ggbG9va3MgZmluZSB0byBtZS4NCj4g
DQo+IEpvbmF0aGFuDQoNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9paW8vaW11L2FkaXMxNjQ4MC5j
IHwgMTIwICsrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAtLS0tLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0ODAuYyBiL2RyaXZlcnMvaWlvL2lt
dS9hZGlzMTY0ODAuYw0KPiA+IGluZGV4IGRmZTg2YzU4OTMyNS4uNzYyMDgyMmYzMzUwIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzMTY0ODAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaWlvL2ltdS9hZGlzMTY0ODAuYw0KPiA+IEBAIC0xNyw2ICsxNyw3IEBADQo+ID4gICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zeXNmcy5oPg0KPiA+ICAj
aW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9sY20uaD4NCj4g
Pg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
aWlvL3N5c2ZzLmg+DQo+ID4gQEAgLTMxMiw3ICszMTMsOCBAQCBzdGF0aWMgaW50IGFkaXMxNjQ4
MF9kZWJ1Z2ZzX2luaXQoc3RydWN0DQo+IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiAgc3RhdGlj
IGludCBhZGlzMTY0ODBfc2V0X2ZyZXEoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwgaW50IHZh
bCwgaW50DQo+IHZhbDIpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBhZGlzMTY0ODAgKnN0ID0gaWlv
X3ByaXYoaW5kaW9fZGV2KTsNCj4gPiAtCXVuc2lnbmVkIGludCB0LCByZWc7DQo+ID4gKwl1bnNp
Z25lZCBpbnQgdCwgc2FtcGxlX3JhdGUgPSBzdC0+Y2xrX2ZyZXE7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+DQo+ID4gIAlpZiAodmFsIDwgMCB8fCB2YWwyIDwgMCkNCj4gPiAgCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiBAQCAtMzIxLDI4ICszMjMsNjMgQEAgc3RhdGljIGludCBhZGlzMTY0ODBfc2V0X2Zy
ZXEoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwgaW50IHZhbCwgaW50IHZhbDIpDQo+ID4g
IAlpZiAodCA9PSAwKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gKwlhZGlzX2Rl
dl9sb2NrKCZzdC0+YWRpcyk7DQo+ID4gIAkvKg0KPiA+IC0JICogV2hlbiB1c2luZyBQUFMgbW9k
ZSwgdGhlIHJhdGUgb2YgZGF0YSBjb2xsZWN0aW9uIGlzIGVxdWFsIHRvDQo+IHRoZQ0KPiA+IC0J
ICogcHJvZHVjdCBvZiB0aGUgZXh0ZXJuYWwgY2xvY2sgZnJlcXVlbmN5IGFuZCB0aGUgc2NhbGUg
ZmFjdG9yDQo+IGluIHRoZQ0KPiA+IC0JICogU1lOQ19TQ0FMRSByZWdpc3Rlci4NCj4gPiAtCSAq
IFdoZW4gdXNpbmcgc3luYyBtb2RlLCBvciBpbnRlcm5hbCBjbG9jaywgdGhlIG91dHB1dCBkYXRh
DQo+IHJhdGUgaXMNCj4gPiAtCSAqIGVxdWFsIHdpdGggIHRoZSBjbG9jayBmcmVxdWVuY3kgZGl2
aWRlZCBieSBERUNfUkFURSArIDEuDQo+ID4gKwkgKiBXaGVuIHVzaW5nIFBQUyBtb2RlLCB0aGUg
aW5wdXQgY2xvY2sgbmVlZHMgdG8gYmUgc2NhbGVkIHNvDQo+IHRoYXQgd2UgaGF2ZSBhbiBJTVUN
Cj4gPiArCSAqIHNhbXBsZSByYXRlIGJldHdlZW4gKG9wdGltYWxseSkgNDAwMCBhbmQgNDI1MC4g
QWZ0ZXIgdGhpcywNCj4gd2UgY2FuIHVzZSB0aGUNCj4gPiArCSAqIGRlY2ltYXRpb24gZmlsdGVy
IHRvIGxvd2VyIHRoZSBzYW1wbGluZyByYXRlIGluIG9yZGVyIHRvIGdldA0KPiB3aGF0IHRoZSB1
c2VyIHdhbnRzLg0KPiA+ICsJICogT3B0aW1hbGx5LCB0aGUgdXNlciBzYW1wbGUgcmF0ZSBpcyBh
IG11bHRpcGxlIG9mIGJvdGggdGhlIElNVQ0KPiBzYW1wbGUgcmF0ZSBhbmQNCj4gPiArCSAqIHRo
ZSBpbnB1dCBjbG9jay4gSGVuY2UsIGNhbGN1bGF0aW5nIHRoZSBzeW5jX3NjYWxlIGR5bmFtaWNh
bGx5DQo+IGdpdmVzIHVzIGJldHRlcg0KPiA+ICsJICogY2hhbmNlcyBvZiBhY2hpZXZpbmcgYSBw
ZXJmZWN0L2ludGVnZXIgdmFsdWUgZm9yIERFQ19SQVRFLg0KPiBUaGUgbWF0aCBoZXJlIGlzOg0K
PiA+ICsJICoJMS4gbGNtIG9mIHRoZSBpbnB1dCBjbG9jayBhbmQgdGhlIGRlc2lyZWQgb3V0cHV0
IHJhdGUuDQo+ID4gKwkgKgkyLiBnZXQgdGhlIGhpZ2hlc3QgbXVsdGlwbGUgb2YgdGhlIHByZXZp
b3VzIHJlc3VsdCBsb3dlcg0KPiB0aGFuIHRoZSBhZGlzIG1heCByYXRlLg0KPiA+ICsJICoJMy4g
VGhlIGxhc3QgcmVzdWx0IGJlY29tZXMgdGhlIElNVSBzYW1wbGUgcmF0ZS4gVXNlDQo+IHRoYXQg
dG8gY2FsY3VsYXRlIFNZTkNfU0NBTEUNCj4gPiArCSAqCSAgIGFuZCBERUNfUkFURSAodG8gZ2V0
IHRoZSB1c2VyIG91dHB1dCByYXRlKQ0KPiA+ICAJICovDQo+ID4gIAlpZiAoc3QtPmNsa19tb2Rl
ID09IEFESVMxNjQ4MF9DTEtfUFBTKSB7DQo+ID4gLQkJdCA9IHQgLyBzdC0+Y2xrX2ZyZXE7DQo+
ID4gLQkJcmVnID0gQURJUzE2NDk1X1JFR19TWU5DX1NDQUxFOw0KPiA+IC0JfSBlbHNlIHsNCj4g
PiAtCQl0ID0gc3QtPmNsa19mcmVxIC8gdDsNCj4gPiAtCQlyZWcgPSBBRElTMTY0ODBfUkVHX0RF
Q19SQVRFOw0KPiA+ICsJCXVuc2lnbmVkIGxvbmcgc2NhbGVkX3JhdGUgPSBsY20oc3QtPmNsa19m
cmVxLCB0KTsNCj4gPiArCQlpbnQgc3luY19zY2FsZTsNCj4gPiArCQlzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAmc3QtPmFkaXMuc3BpLT5kZXY7DQo+ID4gKw0KPiA+ICsJCS8qDQo+ID4gKwkJICogSWYg
bGNtIGlzIGJpZ2dlciB0aGFuIHRoZSBJTVUgbWF4aW11bSBzYW1wbGluZyByYXRlDQo+IHRoZXJl
J3Mgbm8gcGVyZmVjdA0KPiA+ICsJCSAqIHNvbHV0aW9uLiBJbiB0aGlzIGNhc2UsIHdlIGdldCB0
aGUgaGlnaGVzdCBtdWx0aXBsZSBvZg0KPiB0aGUgaW5wdXQgY2xvY2sNCj4gPiArCQkgKiBsb3dl
ciB0aGF0IHRoZSBJTVUgbWF4IHNhbXBsZSByYXRlLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWlmIChz
Y2FsZWRfcmF0ZSA+IHN0LT5jaGlwX2luZm8tPmludF9jbGspDQo+ID4gKwkJCXNjYWxlZF9yYXRl
ID0gc3QtPmNoaXBfaW5mby0+aW50X2NsayAvIHN0LQ0KPiA+Y2xrX2ZyZXEgKiBzdC0+Y2xrX2Zy
ZXE7DQo+ID4gKwkJZWxzZQ0KPiA+ICsJCQlzY2FsZWRfcmF0ZSA9IHN0LT5jaGlwX2luZm8tPmlu
dF9jbGsgLw0KPiBzY2FsZWRfcmF0ZSAqIHNjYWxlZF9yYXRlOw0KPiA+ICsNCj4gPiArCQkvKg0K
PiA+ICsJCSAqIFRoaXMgaXMgbm90IGFuIGhhcmQgcmVxdWlyZW1lbnQgYnV0IGl0J3Mgbm90IGFk
dmlzZWQgdG8NCj4gcnVuIHRoZSBJTVUNCj4gPiArCQkgKiB3aXRoIGEgc2FtcGxlIHJhdGUgbG93
ZXIgdGhhbiA0MDAwSHogZHVlIHRvIHBvc3NpYmxlDQo+IHVuZGVyc2FtcGxpbmcNCj4gPiArCQkg
KiBpc3N1ZXMgc28gd2Ugd2lsbCBsb2cgYSB3YXJuaW5nIGhlcmUuIFdlIGNvdWxkIGV2ZW4NCj4g
Zm9yY2UgdGhlIHJhdGUNCj4gPiArCQkgKiB0byA0MDAwIGJ1dCBzb21lIHVzZXJzIG1pZ2h0IHJl
YWxseSB3YW50IHRoaXMuLi4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoc2NhbGVkX3JhdGUgPCA0
MDAwMDAwKQ0KPiA+ICsJCQlkZXZfd2FybihkZXYsICJQb3NzaWJsZSB1bmRlcnNhbXBsaW5nIGlz
c3Vlcw0KPiBkdWUgdG8gc2FtcGxpbmcgcmF0ZT0lbHUgPCA0MDAwXG4iLA0KPiA+ICsJCQkJIHNj
YWxlZF9yYXRlIC8gMTAwMCk7DQo+ID4gKw0KPiA+ICsJCXN5bmNfc2NhbGUgPSBzY2FsZWRfcmF0
ZSAvIHN0LT5jbGtfZnJlcTsNCj4gPiArCQlyZXQgPSBfX2FkaXNfd3JpdGVfcmVnXzE2KCZzdC0+
YWRpcywNCj4gQURJUzE2NDk1X1JFR19TWU5DX1NDQUxFLCBzeW5jX3NjYWxlKTsNCj4gPiArCQlp
ZiAocmV0KQ0KPiA+ICsJCQlnb3RvIGVycm9yOw0KPiA+ICsNCj4gPiArCQlzYW1wbGVfcmF0ZSA9
IHNjYWxlZF9yYXRlOw0KPiA+ICAJfQ0KPiA+DQo+ID4gKwl0ID0gRElWX1JPVU5EX0NMT1NFU1Qo
c2FtcGxlX3JhdGUsIHQpOw0KPiA+ICsJaWYgKHQpDQo+ID4gKwkJdC0tOw0KPiA+ICsNCj4gPiAg
CWlmICh0ID4gc3QtPmNoaXBfaW5mby0+bWF4X2RlY19yYXRlKQ0KPiA+ICAJCXQgPSBzdC0+Y2hp
cF9pbmZvLT5tYXhfZGVjX3JhdGU7DQo+ID4NCj4gPiAtCWlmICgodCAhPSAwKSAmJiAoc3QtPmNs
a19tb2RlICE9IEFESVMxNjQ4MF9DTEtfUFBTKSkNCj4gPiAtCQl0LS07DQo+ID4gLQ0KPiA+IC0J
cmV0dXJuIGFkaXNfd3JpdGVfcmVnXzE2KCZzdC0+YWRpcywgcmVnLCB0KTsNCj4gPiArCXJldCA9
IF9fYWRpc193cml0ZV9yZWdfMTYoJnN0LT5hZGlzLA0KPiBBRElTMTY0ODBfUkVHX0RFQ19SQVRF
LCB0KTsNCj4gPiArZXJyb3I6DQo+ID4gKwlhZGlzX2Rldl91bmxvY2soJnN0LT5hZGlzKTsNCj4g
PiArCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW50IGFkaXMxNjQ4MF9n
ZXRfZnJlcShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LCBpbnQgKnZhbCwgaW50DQo+ICp2YWwy
KQ0KPiA+IEBAIC0zNTAsMzQgKzM4NywzNSBAQCBzdGF0aWMgaW50IGFkaXMxNjQ4MF9nZXRfZnJl
cShzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2LCBpbnQgKnZhbCwgaW50ICp2YWwyKQ0KPiA+
ICAJc3RydWN0IGFkaXMxNjQ4MCAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICAJdWlu
dDE2X3QgdDsNCj4gPiAgCWludCByZXQ7DQo+ID4gLQl1bnNpZ25lZCBpbnQgZnJlcTsNCj4gPiAt
CXVuc2lnbmVkIGludCByZWc7DQo+ID4gKwl1bnNpZ25lZCBpbnQgZnJlcSwgc2FtcGxlX3JhdGUg
PSBzdC0+Y2xrX2ZyZXE7DQo+ID4NCj4gPiAtCWlmIChzdC0+Y2xrX21vZGUgPT0gQURJUzE2NDgw
X0NMS19QUFMpDQo+ID4gLQkJcmVnID0gQURJUzE2NDk1X1JFR19TWU5DX1NDQUxFOw0KPiA+IC0J
ZWxzZQ0KPiA+IC0JCXJlZyA9IEFESVMxNjQ4MF9SRUdfREVDX1JBVEU7DQo+ID4gKwlhZGlzX2Rl
dl9sb2NrKCZzdC0+YWRpcyk7DQo+ID4NCj4gPiAtCXJldCA9IGFkaXNfcmVhZF9yZWdfMTYoJnN0
LT5hZGlzLCByZWcsICZ0KTsNCj4gPiArCWlmIChzdC0+Y2xrX21vZGUgPT0gQURJUzE2NDgwX0NM
S19QUFMpIHsNCj4gPiArCQl1MTYgc3luY19zY2FsZTsNCj4gPiArDQo+ID4gKwkJcmV0ID0gX19h
ZGlzX3JlYWRfcmVnXzE2KCZzdC0+YWRpcywNCj4gQURJUzE2NDk1X1JFR19TWU5DX1NDQUxFLCAm
c3luY19zY2FsZSk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJZ290byBlcnJvcjsNCj4gPiAr
DQo+ID4gKwkJc2FtcGxlX3JhdGUgPSBzdC0+Y2xrX2ZyZXEgKiBzeW5jX3NjYWxlOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCXJldCA9IF9fYWRpc19yZWFkX3JlZ18xNigmc3QtPmFkaXMsDQo+IEFE
SVMxNjQ4MF9SRUdfREVDX1JBVEUsICZ0KTsNCj4gPiAgCWlmIChyZXQpDQo+ID4gLQkJcmV0dXJu
IHJldDsNCj4gPiArCQlnb3RvIGVycm9yOw0KPiA+DQo+ID4gLQkvKg0KPiA+IC0JICogV2hlbiB1
c2luZyBQUFMgbW9kZSwgdGhlIHJhdGUgb2YgZGF0YSBjb2xsZWN0aW9uIGlzIGVxdWFsIHRvDQo+
IHRoZQ0KPiA+IC0JICogcHJvZHVjdCBvZiB0aGUgZXh0ZXJuYWwgY2xvY2sgZnJlcXVlbmN5IGFu
ZCB0aGUgc2NhbGUgZmFjdG9yDQo+IGluIHRoZQ0KPiA+IC0JICogU1lOQ19TQ0FMRSByZWdpc3Rl
ci4NCj4gPiAtCSAqIFdoZW4gdXNpbmcgc3luYyBtb2RlLCBvciBpbnRlcm5hbCBjbG9jaywgdGhl
IG91dHB1dCBkYXRhDQo+IHJhdGUgaXMNCj4gPiAtCSAqIGVxdWFsIHdpdGggIHRoZSBjbG9jayBm
cmVxdWVuY3kgZGl2aWRlZCBieSBERUNfUkFURSArIDEuDQo+ID4gLQkgKi8NCj4gPiAtCWlmIChz
dC0+Y2xrX21vZGUgPT0gQURJUzE2NDgwX0NMS19QUFMpDQo+ID4gLQkJZnJlcSA9IHN0LT5jbGtf
ZnJlcSAqIHQ7DQo+ID4gLQllbHNlDQo+ID4gLQkJZnJlcSA9IHN0LT5jbGtfZnJlcSAvICh0ICsg
MSk7DQo+ID4gKwlhZGlzX2Rldl91bmxvY2soJnN0LT5hZGlzKTsNCj4gPiArDQo+ID4gKwlmcmVx
ID0gRElWX1JPVU5EX0NMT1NFU1Qoc2FtcGxlX3JhdGUsICh0ICsgMSkpOw0KPiA+DQo+ID4gIAkq
dmFsID0gZnJlcSAvIDEwMDA7DQo+ID4gIAkqdmFsMiA9IChmcmVxICUgMTAwMCkgKiAxMDAwOw0K
PiA+DQo+ID4gIAlyZXR1cm4gSUlPX1ZBTF9JTlRfUExVU19NSUNSTzsNCj4gPiArZXJyb3I6DQo+
ID4gKwlhZGlzX2Rldl91bmxvY2soJnN0LT5hZGlzKTsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4g
IH0NCj4gPg0KPiA+ICBlbnVtIHsNCj4gPiBAQCAtMTI3OCw2ICsxMzE2LDIwIEBAIHN0YXRpYyBp
bnQgYWRpczE2NDgwX3Byb2JlKHN0cnVjdA0KPiBzcGlfZGV2aWNlICpzcGkpDQo+ID4NCj4gPiAg
CQlzdC0+Y2xrX2ZyZXEgPSBjbGtfZ2V0X3JhdGUoc3QtPmV4dF9jbGspOw0KPiA+ICAJCXN0LT5j
bGtfZnJlcSAqPSAxMDAwOyAvKiBtaWNybyAqLw0KPiA+ICsJCWlmIChzdC0+Y2xrX21vZGUgPT0g
QURJUzE2NDgwX0NMS19QUFMpIHsNCj4gPiArCQkJdTE2IHN5bmNfc2NhbGU7DQo+ID4gKw0KPiA+
ICsJCQkvKg0KPiA+ICsJCQkgKiBJbiBQUFMgbW9kZSwgdGhlIElNVSBzYW1wbGUgcmF0ZSBpcyB0
aGUNCj4gY2xrX2ZyZXEgKiBzeW5jX3NjYWxlLiBIZW5jZSwNCj4gPiArCQkJICogZGVmYXVsdCB0
aGUgSU1VIHNhbXBsZSByYXRlIHRvIHRoZSBoaWdoZXN0DQo+IG11bHRpcGxlIG9mIHRoZSBpbnB1
dCBjbG9jaw0KPiA+ICsJCQkgKiBsb3dlciB0aGFuIHRoZSBJTVUgbWF4IHNhbXBsZSByYXRlLiBU
aGUNCj4gaW50ZXJuYWwgc2FtcGxlIHJhdGUgaXMgdGhlDQo+ID4gKwkJCSAqIG1heC4uLg0KPiA+
ICsJCQkgKi8NCj4gPiArCQkJc3luY19zY2FsZSA9IHN0LT5jaGlwX2luZm8tPmludF9jbGsgLyBz
dC0NCj4gPmNsa19mcmVxOw0KPiA+ICsJCQlyZXQgPSBfX2FkaXNfd3JpdGVfcmVnXzE2KCZzdC0+
YWRpcywNCj4gQURJUzE2NDk1X1JFR19TWU5DX1NDQUxFLCBzeW5jX3NjYWxlKTsNCj4gPiArCQkJ
aWYgKHJldCkNCj4gPiArCQkJCXJldHVybiByZXQ7DQo+ID4gKwkJfQ0KPiA+ICAJfSBlbHNlIHsN
Cj4gPiAgCQlzdC0+Y2xrX2ZyZXEgPSBzdC0+Y2hpcF9pbmZvLT5pbnRfY2xrOw0KPiA+ICAJfQ0K
DQo=
