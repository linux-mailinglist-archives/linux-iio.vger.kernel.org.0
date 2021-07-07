Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB903BE485
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 10:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhGGIjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 04:39:48 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:21064 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhGGIjr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 04:39:47 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678V7eN026148;
        Wed, 7 Jul 2021 04:36:49 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-00128a01.pphosted.com with ESMTP id 39masxdcmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 04:36:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4M4AfTe7qSULDGGxU/ybHQm+/R/jGKCI7+hj+ze7Co0O66V++oyN7cgzAJTdf22sNIX7faK2E7X8ZH0fYmmtTu86YMPu6afxIxNKcqAITRouLf3hg5v3x2ob4RVA4sdf+qXhzNdWwkjlV4iH4ggkQaBG92BUAj1P/DzKq6+tXIDIfvqZW8TJ7nEmpZo6fPw9mW6N8yj8dkT5ZHuiOm5eZaqds8wX5L+jqNE6cZ33VRB1asKUfuSlmdlGVuGEX4ctPhyRomdr1H5A0RLG5FUYTXhUscqlK84FPGAdLugcrceRy4b6fH+1BWo6XklnZQMY0f1mcV1qtyftioYcNyvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt8M/X9eYoP+9giOJI1WPA9tdZ0OzG1Pbbos0hOSQpA=;
 b=JZIOaNxiXKIq0wKYKf93a7lx9zqR70IRxiMXPz3egsfJnPTJrjNNUbjwmoMtQ9SOOG/JwQiEr1ZgpAvxD9Wx92eqUcrJ+e8Dm67vYWNctbcC8qPH3UBegEYwdaqFX6tgQRj4MIryBMms25Ga6A6cL1Ie3BG42x1O82Ej+L4udz+jEzrKWglyoxtRDlD6x6OM/fr6+16Ybcy7/eH0nqzJNXgYl7UOPO2fw4WW0F3rUTZbI4GZYGONH9JuhVpGu+us3/68Qabv01sQDaE97l9o6A1XW85ySAFGhe5u2oSpb6zv819A5MNO0JYCt/vG+O3FPxM5atebAAwcDzMaFHNh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bt8M/X9eYoP+9giOJI1WPA9tdZ0OzG1Pbbos0hOSQpA=;
 b=nNkD5N1uE/6HFJxP+7Ttncup1xBru7rSQffGC24gN7Y84cg3fOwkSwl8EECSmqyhLSACh8eXHm0/7OCnkrT+ipNEH9PyNbwzgMdfMEL33FuuwIac8hX1fd+e3o/pStXH6fJF+1vDey7feX96wuZYrRqiSFPHp9RA9onvBEboxfU=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6284.namprd03.prod.outlook.com (2603:10b6:510:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 7 Jul
 2021 08:36:47 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Wed, 7 Jul 2021
 08:36:47 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     =?utf-8?B?QW50dGkgS2Vyw6RuZW4=?= <detegr@rbx.email>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [RESEND PATCH] iio: adis: set GPIO reset pin direction
Thread-Topic: [RESEND PATCH] iio: adis: set GPIO reset pin direction
Thread-Index: AQHXcklvdTRDzb/7JkGBcbv7kuO7Zas3MR5Q
Date:   Wed, 7 Jul 2021 08:36:47 +0000
Message-ID: <PH0PR03MB63661EDEE130924514602A84991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
In-Reply-To: <20210706092922.v555jjvxbyv52ifw@haukka.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE56VXlZalExTnpNdFpHVm1aUzB4TVdWaUxUaGlObVl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEYzFNbUkwTlRjMUxXUmxabVV0TVRGbFlpMDRZ?=
 =?utf-8?B?alptTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRnME5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56QXhNakEyTURRek9UVTJNVFUySWlCb1BTSnpkVXcwZFho?=
 =?utf-8?B?R05WWkJUM1ZNZVhsWmVXMVRPRXRyUlVObWVGRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTTRSVFJSTTBNelVGaEJVWHBYZUZwcFVUVkRWazFFVG1KR2JV?=
 =?utf-8?B?cEVhMHBWZDBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: rbx.email; dkim=none (message not signed)
 header.d=none;rbx.email; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 378ada6a-3856-4104-0b2f-08d941225bc0
x-ms-traffictypediagnostic: PH0PR03MB6284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB628441155F4B3F2FB3102901991A9@PH0PR03MB6284.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qb0bV9HqDsDhxD+N+we1kEwSvrmnXU/DrGl+hZ9sOGzUuxowFzCZnc9B08gupA2cl2zp39+7SkloijSMWdASSj3XjzqcPh4CqgH6AUhOhceU0wiRXA9qxEW/eMhiQlxkXMOFv0qUfVnxZFJU2lFpzr7jmiQl/ylBr10l6EZCDvrjqRgsjZqor8j+kWFKHeicxHSEVBg3Jfjk+ffBQMPzbqFX5/gZ2S/MDQhUWe/F3geXcrzcIZN1wxybpRi+phS24EqhxJeneVzvF0kSBSclLm638lxXzbrCgkn1xjSBP9gn6AnEmld/9OxcbWX1mLeN+QptXcCqmMZauQ5qDQYQ495lt68Q9POn5vj7EjcFmSZn4xYeB9+NzcetNmc/YOHH5IKj7V4p91qfhPMEfYpxhGap8fixJ6dDu7EhHJn1z67fuOJITAd925vtZrVJODAqGbe8nafCXCF+BrzT3V3fmrt6T0xwhh8j6wHUE1nA5wzcS/MT0pNH3uttyslxy24k84JcAX2XLHp6U4Vlg9LOJdH8KhLf0Soclr/et+KLmZ8g/maFf2qhuhMwjIBjFDW6zi/+v1osdxT2Oc0E6pNUKV9WVZtoSf1HqhhDPO2qxUUFCLGHQabfaAw3KXX1IAlJkU3yFRDwm9oNOvIG8Z0hMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(55016002)(9686003)(186003)(66574015)(64756008)(38100700002)(83380400001)(66946007)(86362001)(122000001)(478600001)(7696005)(8676002)(4326008)(53546011)(6506007)(76116006)(8936002)(66446008)(2906002)(66556008)(71200400001)(66476007)(316002)(5660300002)(52536014)(110136005)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHFMQm5oQU9nM25RT05lREdNUlFKSGNjWWtaS1U1NXZKTDlmRm9SSVdOZUxx?=
 =?utf-8?B?YmUxYVpmOVBmbXZZNjlJOWRWTWpVOG5GZFhGU3N6UGtQY2JiM2EzQng1V2lz?=
 =?utf-8?B?RmtITEpCV3djaXlCVHg4RTZPL3Q5d242VmtGbVRXVTVNcVltUE82MWFoT3dG?=
 =?utf-8?B?MDF6UVp0Wm81UmdkNzcwVm0yc1laTGV1SWtOZitOWHV5QXE3ZTJDZWg1WEty?=
 =?utf-8?B?NDVtZmE5WnBQQlkwTjRzOE16UG40d1d5S3l0Q3lVdm4vZWVwTjFhci9pQkhr?=
 =?utf-8?B?VXlPQmJZRHIvYVpkdXhjQ0tFM0tPMlJ6ejNOMStQdzNSeDNiUHhmS2p2U3lh?=
 =?utf-8?B?U25OY2k3b3VjR3BCOStBeHU0eEdxcWtYQ0tuOU5tTG5tYk00cnIxUktXTDha?=
 =?utf-8?B?QXVSbk5kc3dENmRhaE91K0krR1RxbjZ6NGR1U3FIN0pLZW44V2R1MW5GbmRI?=
 =?utf-8?B?WTNOcm1vRnpXQkxUd2FIeEY5dmFuVzZweGEwTm9saXJvNXdiZ2Y5aG9tQi81?=
 =?utf-8?B?MVE4TUFhbzlZak00TFU0VWU5dXl1ZFl3SFdoNFl1Yklhb2V2RkFGaEdNdnJK?=
 =?utf-8?B?UlczMjlyZzR4TFhMcTVxbDlUWVQ4UGZ0dG5qeE9NUGpPR3I2ZERlYWZFVlFW?=
 =?utf-8?B?a3F0VDRNemFkb1hUV3lkNDJMOVhYVy92blBRcy9VTXR5bzdRTlVzN0hMUjMr?=
 =?utf-8?B?NEsvZFBjU2JuSU1oVGxnU2prc3BQbllCMW1RaDdjdXpqejVRSElZeE5XRXhX?=
 =?utf-8?B?eEhJd3RQSTMwVnFJbTVPVVlJbkh1bGNZVFhRUC91T0dLSmNDaFdBRkZWd3ZW?=
 =?utf-8?B?T0QvTXk0RzZkTkpac1gzUWo3dWNQVGZQMTRjalh4MXhuUlRuZWxnV0gwVUwz?=
 =?utf-8?B?aENzeFBpREdCdzZrZUdNME5hMDhabWloUWVDMUJ3SFdScVJsWFFacFM2OTNK?=
 =?utf-8?B?RnVEVHpEcHhQWnQvMDNSbFNyMkxLc2pZSEhWdzNXTkp4bmZ0TVhIb1Q1Skxm?=
 =?utf-8?B?amR2eTZZbEFwRUJudVBVazJha3h6MjBTcjVMOEJtQTlQbDFPNzJSL0lGejho?=
 =?utf-8?B?c29RN2kyTkJCcjBXWDJSMy9Ca1N5UFpqeUxoc3NiYXhBTGlicG5yZXlCcEgr?=
 =?utf-8?B?TU1OZmdoVWdqeU5wc21XckhHdFVldDc5NDB3VlE1elQ2NWJhRHF4ektqb1pN?=
 =?utf-8?B?RXMrbjdsbjVodjVGVm9CaExMb0FZellKTGhFcjJWdHRQZUVqT3l3NTd1STRo?=
 =?utf-8?B?Ti9mT1JlNzAvRU1jRGcyL3g0SVdjbmxkbWV6L0ZNK2ZtaFlTamhqekJmKzZi?=
 =?utf-8?B?aThBSVFjL2RPWEFsNzFrUWY1U1hZTkt4TmJlNzBNVUFxaWJZTG9sMFBsd0lT?=
 =?utf-8?B?S01SUVJNVi90a002SWwzMWZWQ3IzYTdLQTNRVGZralZVUXpFYTgzTTV5TDgy?=
 =?utf-8?B?c2UwWWZyNnVSa0ZGMkI4N001TkhXNVQ2N1daSWZSRFRSOVphS0RBN2FhNURX?=
 =?utf-8?B?Q1gwcUJDUFFjOWVWVi9vR3RKUEZSRkVRSEVjazNacVg3RG9XRTBab0lIQWRj?=
 =?utf-8?B?bU9tT0Z4MWpmN0xNeWhsc042TExiRzdaMWxaZnd2MktXWnlhYy85Y3NmSU41?=
 =?utf-8?B?MVRkZzdoZ3BHckxsUmF0eXgzckxlLzE5ZElZWUtITXhIaXJlZnorTHhVaUFp?=
 =?utf-8?B?K1FXWUo0RDVxdHNmNTBDUFpxeDBDNTA5T1c1M1U5WFZFd3BpNmw2K2VuMVh3?=
 =?utf-8?B?bmJQcnBjK1N2bWFZcUN0R0djeVFRVHJpQVNySnB2TXF6UHo0d1crN3NGemE4?=
 =?utf-8?B?b094aWJtYnIrazNrQnNFL0xsZ1lTU3VTS3JCU2lIcXozUmdNSi9NZzdOMG9i?=
 =?utf-8?Q?11rw+xQk5clm0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378ada6a-3856-4104-0b2f-08d941225bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 08:36:47.2526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XN7ekw4+aJaPx0XS+Zunud0C2wQLbgufTqOOYk9YijwkptHY4QATmUiL7+GZel+7OG8HAYO97SrbRwlivJh4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6284
X-Proofpoint-GUID: CyqxtTvlg-5BlU5XZeAbSON5NtdlhsfZ
X-Proofpoint-ORIG-GUID: CyqxtTvlg-5BlU5XZeAbSON5NtdlhsfZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070050
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IEZyb206IEFudHRpIEtlcsOkbmVuIDxkZXRlZ3JAcmJ4LmVtYWlsPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdWx5IDYsIDIwMjEgMTE6MjkgQU0NCj4gVG86IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IEFudHRpIEtlcsOkbmVuIDxkZXRlZ3JAcmJ4LmVtYWlsPjsgSGFubnUgSGFydGlr
YWluZW4NCj4gPGhhbm51QGhydGsuaW4+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZv
by5kZT47IEhlbm5lcmljaCwNCj4gTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNv
bT47IFNhLCBOdW5vDQo+IDxOdW5vLlNhQGFuYWxvZy5jb20+OyBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbUkVTRU5EIFBBVENIXSBpaW86IGFkaXM6IHNl
dCBHUElPIHJlc2V0IHBpbiBkaXJlY3Rpb24NCj4gDQo+IFVzZSBHUElPRF9PVVRfTE9XIGluc3Rl
YWQgb2YgR1BJT0RfQVNJUyBhcyB0aGUgcmVzZXQgcGluIG5lZWRzDQo+IHRvIGJlIGFuDQo+IGFj
dGl2ZSBsb3cgb3V0cHV0IHBpbi4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogSGFubnUgSGFydGlrYWlu
ZW4gPGhhbm51QGhydGsuaW4+DQo+IFNpZ25lZC1vZmYtYnk6IEFudHRpIEtlcsOkbmVuIDxkZXRl
Z3JAcmJ4LmVtYWlsPg0KPiAtLS0NCj4gVGhlIGRvY3VtZW50YXRpb24gb2YgR1BJTyBjb25zdW1l
ciBpbnRlcmZhY2Ugc3RhdGVzOg0KPiANCj4gQmUgYXdhcmUgdGhhdCB0aGVyZSBpcyBubyBkZWZh
dWx0IGRpcmVjdGlvbiBmb3IgR1BJT3MuIFRoZXJlZm9yZSwNCj4gKip1c2luZyBhIEdQSU8gd2l0
aG91dCBzZXR0aW5nIGl0cyBkaXJlY3Rpb24gZmlyc3QgaXMgaWxsZWdhbCBhbmQgd2lsbA0KPiBy
ZXN1bHQgaW4gdW5kZWZpbmVkIGJlaGF2aW9yISoqDQo+IA0KPiBUaGVyZWZvcmUgdGhlIGRpcmVj
dGlvbiBvZiB0aGUgcmVzZXQgR1BJTyBwaW4gc2hvdWxkIGJlIHNldCBhcyBvdXRwdXQuDQo+IA0K
PiAgZHJpdmVycy9paW8vaW11L2FkaXMuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2ltdS9hZGlzLmMgYi9kcml2ZXJzL2lpby9pbXUvYWRpcy5jDQo+IGluZGV4IDMxOWI2NGIyZmQ4
OC4uN2YxM2IzNzYzNzMyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpcy5jDQo+
ICsrKyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMNCj4gQEAgLTQxNSw3ICs0MTUsNyBAQCBpbnQg
X19hZGlzX2luaXRpYWxfc3RhcnR1cChzdHJ1Y3QgYWRpcyAqYWRpcykNCj4gIAlpbnQgcmV0Ow0K
PiANCj4gIAkvKiBjaGVjayBpZiB0aGUgZGV2aWNlIGhhcyByc3QgcGluIGxvdyAqLw0KPiAtCWdw
aW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCgmYWRpcy0+c3BpLT5kZXYsICJyZXNldCIsDQo+
IEdQSU9EX0FTSVMpOw0KPiArCWdwaW8gPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbCgmYWRpcy0+
c3BpLT5kZXYsICJyZXNldCIsDQo+IEdQSU9EX09VVF9MT1cpOw0KPiAgCWlmIChJU19FUlIoZ3Bp
bykpDQo+ICAJCXJldHVybiBQVFJfRVJSKGdwaW8pOw0KPiANCg0KSGksDQoNClRoYW5rcyBmb3Ig
dGhlIHBhdGNoLiBGb3JjaW5nIHRoZSBkZXZpY2UgcmVzZXQgd2FzIGludGVudGlvbmFsDQoodGh1
cyB0aGUgR1BJT19BU0lTKS4gQnV0IHdoYXQgTGFycyBpcyBzdWdnZXN0aW5nIGlzIGEgZ29vZCBp
ZGVhDQphbmQgYSBuZWF0IGltcHJvdmVtZW50IGhlcmUuDQoNCi0gTnVubyBTw6ENCg0K
