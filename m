Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4A442B42
	for <lists+linux-iio@lfdr.de>; Tue,  2 Nov 2021 11:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhKBKDu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Nov 2021 06:03:50 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27250 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhKBKDt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Nov 2021 06:03:49 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A1MHXJu019334;
        Tue, 2 Nov 2021 06:01:02 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c2g25mjd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 06:01:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxCmPHYNLqo7Cmh1nXKdWIkFrdnmp9obPh7cRld4+bRQ+QqtC5xIto3ok3PXT1r/i88MKQWU4/9QySGeqrYwnyI/NygTyoOPY9OH0gFfSNsec0A/w83e/D0MRMadG3UxUbXPrvQpP990NeJG6RIG8MD94hvaWcD6OWQG/Wb5QnD3P9sAbpFttZ32CuCq5tFyMmZu9/+XjhyWEmElAG7LVaJO40k5RORBCohlJrkkT0liutxAnNm9hjAt0EPiXzSGLVj6qw7ajMfY8w+LEghu/QgtwXEvjcba4+pKpbN5l2Tyiporo+q/oDYfwaa+1RKcz41GWUXQNY69Gnpg/Erugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AYyLwcknz+f36EpIiRSIeMgP4X1uASVgh6YqTjL918=;
 b=M1QntrgXPcYPBzBb0aYxiiEzGMAkqu4HDy6Ti8VHq6g2eB98hTaas9vAS/GlmUK54RkGTiKLwFQABpGBnMMzbB4Zh7S9WfRlw0JdZ5zo3C2Vb9DHM/vi32qJ98tp31dYUkxDDiX4rImrWkotsSdVRcKPtVY/+eOcvRuVrJh9PuJufUsDFMi5nu/fkqJkJ4W8iK2rXVACoBOO9q3GF0jl+OraAekOO3+vgYAtTSVMx6tU7bJbyeIm21FJEgckOqxF+1/bdVbt8dY8DN/sqkuD1mxlgUk6LPImgqhW/8HV1VVRt0HMW+j5De89J+IS1p+iP0Mk6jF9jrb/l58NZSu3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AYyLwcknz+f36EpIiRSIeMgP4X1uASVgh6YqTjL918=;
 b=NIAg2HLc1dipqKxT7+f7gsD3NqcMhvlUA05kjP1dxl7h1oQP9egc7MsCOR9S1baQunP15/lTZk+bp2kPVuzCCb6pUbXbU+N8SIUOUsBpji8XXQkzGXqwuSgW38epxGlzgdeUEDFJZC26RZ+Bl5SC9um2PobjyAD2rMib373hKl8=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5832.namprd03.prod.outlook.com (2603:10b6:510:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 10:00:58 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Tue, 2 Nov 2021
 10:00:58 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v2 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Topic: [PATCH v2 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Thread-Index: AQHXyxRXK3TV7pBLp0i0yNGLdNrftavnHh8AgAETIQCAAAZlgIABX4LwgAIUYoCABFxrsA==
Date:   Tue, 2 Nov 2021 10:00:58 +0000
Message-ID: <PH0PR03MB6366D6B1B17D3882FF2E35FA998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211027092333.5270-1-antoniu.miclaus@analog.com>
        <20211027184324.51811ef1@jic23-huawei>
        <CY4PR03MB3399339315289769615E4DCD9B869@CY4PR03MB3399.namprd03.prod.outlook.com>
        <20211028113101.0587a658@jic23-huawei>
        <PH0PR03MB636669F27992B59B8A7B603D99879@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20211030161435.6ceaab21@jic23-huawei>
In-Reply-To: <20211030161435.6ceaab21@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFl6UTRPR05sTmpVdE0ySmpNeTB4TVdWakxUaGlPVFl0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHTTBPRGhqWlRZMkxUTmlZek10TVRGbFl5MDRZ?=
 =?utf-8?B?amsyTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTlRjMU5D?=
 =?utf-8?B?SWdkRDBpTVRNeU9EQXpNakE0TlRVMU16STBNVFUzSWlCb1BTSXJWbkp1YUZO?=
 =?utf-8?B?UGFVMDBNMGRITlM5R2NpdEZWMkp5U21KWmRHczlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUTVOSFpwUnpCTkwxaEJWVlpFY1dJdlZGUlphVWhTVlU5d2Rq?=
 =?utf-8?B?bE9UbWxKWTBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 679b2371-fd6a-4454-7570-08d99de7ab54
x-ms-traffictypediagnostic: PH0PR03MB5832:
x-microsoft-antispam-prvs: <PH0PR03MB58320832E120F31A28F80EBC998B9@PH0PR03MB5832.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RuMjooSSaLuyNCuBWsqgKtFQ8k1DmRzEJz5PyqVTH/eBUdhGxHUrMPaj1V+QVO0Ys3BGp+pLx/pDUYlbTffgfwpV7V+29t2KuBEo1+DSq/yoXJo0ZX1HB+7qGfuLnCw3dE3uxUOMgVkg8bOoC7HyVxTtyMUbiEunALHut13FF+5VWd0lFPIaQpi20wl/vyC56rcMCk2AcAk/bJAXGGboXSyA893StZM4Aio65Zr58IH5/kcSkVaxloxVv1rQfBr9zeoNVhshcuaSVuaEEnXBNu+FVrdelHtLNfMuXDbIWUU2lhjWiXr3dC8UIE8YYKz2G9sGb4MuSlqdCgUOHhWnU7wL8jlikZHgmCPZQaj4Gki9owNiWdxKZ+fdB/gQwaspvf1VrFFoq7n76/RxasI6UXgy0uYXYQkO0cOUmZ5nBSjpkRZml5SZa7XV4CQip/RvPeWeKC4s+0sol6cScHuqg4MwmKfeHBoYhvUxa4SWUdsICJG3Tl3r2twrkuL4WulsyKTdTOYA/GSLQSRlEaG3zo0aW1Jc1dchl0OTRlP8X1EPVtxU+jeJAQmKCNrPetlcDx9SI3lxJIP29PGsASjm6I+WiY3QLbylPgyxTUCePAixqCkBzXbUxiaX7+fZ9rXr/vAncaYP3se55uZPLwGVswivLuYHaGhlxOI/6pxspYEmK4A0qKuRFV20VOJBC0OoyxQmlyCIZikMBaCa7CBBtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(52536014)(83380400001)(316002)(53546011)(508600001)(26005)(86362001)(38100700002)(122000001)(6506007)(7696005)(2906002)(38070700005)(55016002)(66476007)(6916009)(186003)(5660300002)(9686003)(4326008)(8936002)(8676002)(66446008)(64756008)(66556008)(33656002)(66946007)(76116006)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0xlUmFBQ1YrS01BeHMwSTdEai90WVQrNURCNXhTVk1xUW1HWWIvanRrTTZS?=
 =?utf-8?B?Y3RKajBjNnJISko2NU5LSndEdkFkbG9qdmN0Z3JGK0UvYkhMOHhGcTJOWDhD?=
 =?utf-8?B?cmRGVmlZVDNwaURuMGFpU1NIWGdpUlFGYk9lS2hNQXFWd0MzK09zR3NuZk04?=
 =?utf-8?B?UW1tQnZGU2poNFQ4aDgrVVVsZDA3eXpVT1NtMEM1TXlNWWdBTlQ5NndKZ2Rj?=
 =?utf-8?B?YjRJWUNTU3VrdnQ0OXVMUXhQbGFCeE9WUjlPcTg1cUJGVTdCMGY3S2M2SlJ5?=
 =?utf-8?B?Q1E2c1dyMkpuMHNWMkdiS2JRbjhvLzdIS1ZJWmExYUtQT0tXMG1BVXRLTTZT?=
 =?utf-8?B?T01qdVBiK1VuUitZV09kTnB2bWRpcG1NQVhzSVdUQlZSTklnaXpFcncwTkdO?=
 =?utf-8?B?RC9DK1pYZjBCcXFZbTJoZ2lDNWgzMHZmTmFLVXY2eTVUd1d0M2s1UXU3TXQw?=
 =?utf-8?B?WlZJYzQ0Y2FvOFZOUFU1WmdDc2JFVEdBdEJ1Y0N4MVV0dThUWGRGWFFFcXgz?=
 =?utf-8?B?Z2kyYnFGRWV3VUtmVUVkbDR4a0lnbFYwT0xmMlRlcVBMSGc0V3RpdFpQdU1w?=
 =?utf-8?B?cC8yQ1MzbC9qOGh3NXJIakpCOW9SbThVMTBRWkZEQkE2dHBvVFdJUmp0ZEcr?=
 =?utf-8?B?aUNRVERROVQxZy85TXQwL09ZWEYzaG1lUWRhYU9nTW0wcGkrN0tNSUdpRE1K?=
 =?utf-8?B?YVRUb05FUXVlaXFhYXI1RmxJTEpodDZzLzdHL2FPY0ZVZG1FK25aK2drbzMw?=
 =?utf-8?B?dUs2anA5YkFkTFFISnA5dTM1NUpVQTZ0dGF2amI2UkViREFHR3dTNE81MGVV?=
 =?utf-8?B?UWExZDNqelpjSWpyNkVuT3E0RmtIZlRmVDdmVSt4ZmdsTWJpb3pCQmtRQWdT?=
 =?utf-8?B?K2h0Y1VEKzhmemgxRlFZNWdtd2VOaVFxQWpqUmNXQXc5cm9XN29VRDlWaVV0?=
 =?utf-8?B?NnVxSWo0bVdFSkQ3cTBtUENDNkZvV0wvOE5uSlUrLzlCc2JMSEUrdU1IaDVQ?=
 =?utf-8?B?QXgveHVUelVIREVkVXJIRDdGV1ZtYVB5MUJaa3p5cVMrL1RsOGZGR2JZa1B5?=
 =?utf-8?B?aTB6R2dlUGthNjRpTnYySGtlcGtnaThvNW9LOVV0d3dhWmJ3QWFPSTl5S0I0?=
 =?utf-8?B?dUJHSGlXSTNPSEN6Z0M3bFRxSVZDNEd3RTBlb0ZJWTl2OGpEbWZsSXc3YTZk?=
 =?utf-8?B?Q1dOSWhGRGNKd2QxdnhENncvYkVKcEdaUW1kVGQxVExEQnVFZ2p3alBWVG9S?=
 =?utf-8?B?UFFySk9ORG84aUt6TlhCdE5SaTJ2cXh2cmRyZ3RXUHZIVjVvcGhpTWVVWDFv?=
 =?utf-8?B?Nkc5OFZuZ3VkSkJUNXp0UWdMcjJxZHcxcWlRS01lMTRSUG1oakd1SGFsZEpz?=
 =?utf-8?B?b3d3eUNCQkhIbkFPa0ZVK2FHQzNQdzgxdjNLT09QdTA0ZlpJUmZPeXpxdU8y?=
 =?utf-8?B?SzJsWUtmVFNXSTNCTnVKZnNORThpdHp3R3FraTRaYTR1MisrTzlVeU5oS3hh?=
 =?utf-8?B?RUZ5ekhBWlVLZWFnajNic0dSNlQ4Y3B2MUM4ODhMMERkcXMrWFVHeS83VXpi?=
 =?utf-8?B?VUEzTW5LcWxzRHoyWVVSNzhMT0IyZWpZMVVndVpIZW5CUy9nZmZJN1RKc2s3?=
 =?utf-8?B?dHRic1ZVVWJyS1ZheGY4bjZHRTRmVEtBR3dkS3pmWk1TTktIbnpZYVJMYzR2?=
 =?utf-8?B?NWFNS05wS3JYdEhlL2FTdUFUSzJwYU9kTGppeDBRTGc5aWp5SEx6R2NwTlNu?=
 =?utf-8?B?OVRlc3BjbGF1MjRuNDAyYkI4YTNRN2JHL2NqUGJRejBBazVUTHFJWjk3aFha?=
 =?utf-8?B?QXhkYktTbWpib3crTElZeHoweGoyZys1cTFuVDJhTk5mVjRiRnlmc29FZHdU?=
 =?utf-8?B?YnRzT2d3SW45UjhSeC9Tc2Z6MkpXQW14RW5YVVJsWkx2OU5iMWd1K0kvTC9I?=
 =?utf-8?B?VWNQcVN1cTk5dWhYYmMwUVBsd0s3UDJmcWNaVWpxcm54UGxBRUNuaS93SVZn?=
 =?utf-8?B?RG9qMXpITURuenVPazBPRHZLM1c4Sm9QM21Uby84Z1licUJBZlRLb1YrVHVM?=
 =?utf-8?B?UitwaDRDY25KUURGdDB2WFVjbTYyNkphRmtwQjNVQnB3NEpLcHhhOXU3WUs5?=
 =?utf-8?B?RVhtL1Nya01qL2JvamZjYUJTV2hzeGxqRTlhSGpOS0FLTFRYdnVNU3A5NUZW?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679b2371-fd6a-4454-7570-08d99de7ab54
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 10:00:58.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpZgU1q9svW8uRSpMJ0joeqdkpyYgjmCnrJeKiSC7xggAgIZP0Y4mrNJGhKngbFRDJWJWZue2JJXwHvt0GfObw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5832
X-Proofpoint-ORIG-GUID: PV7DKAkcUAibzjFF8OGrb-z_VCBjf5kV
X-Proofpoint-GUID: PV7DKAkcUAibzjFF8OGrb-z_VCBjf5kV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_06,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1
cmRheSwgT2N0b2JlciAzMCwgMjAyMSA1OjE1IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBh
bmFsb2cuY29tPg0KPiBDYzogTWljbGF1cywgQW50b25pdSA8QW50b25pdS5NaWNsYXVzQGFuYWxv
Zy5jb20+Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBMYXJzLVBldGVyDQo+IENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAxLzJdIGlpbzogZnJlcXVlbmN5OiBhZG12MTAxMzogYWRkIHN1cHBvcnQg
Zm9yDQo+IEFETVYxMDEzDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBPbiBGcmksIDI5IE9jdCAy
MDIxIDA3OjQ5OjQxICswMDAwDQo+ICJTYSwgTnVubyIgPE51bm8uU2FAYW5hbG9nLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+IEhpIEpvbmF0aGFuLA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4N
Cj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDI4LCAyMDIxIDEyOjMxIFBNDQo+ID4gPiBU
bzogTWljbGF1cywgQW50b25pdSA8QW50b25pdS5NaWNsYXVzQGFuYWxvZy5jb20+DQo+ID4gPiBD
Yzogcm9iaCtkdEBrZXJuZWwub3JnOyBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOw0KPiA+ID4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFNhLA0KPiBOdW5vDQo+ID4gPiA8TnVuby5TYUBhbmFsb2cuY29tPjsgTGFycy1QZXRlciBDbGF1
c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0g
aWlvOiBmcmVxdWVuY3k6IGFkbXYxMDEzOiBhZGQgc3VwcG9ydA0KPiBmb3INCj4gPiA+IEFETVYx
MDEzDQo+ID4gPg0KPiA+ID4gT24gVGh1LCAyOCBPY3QgMjAyMSAxMDowODowOCArMDAwMA0KPiA+
ID4gIk1pY2xhdXMsIEFudG9uaXUiIDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNvbT4gd3JvdGU6
DQo+ID4gPg0KPiA+ID4gPiBIZWxsbyBKb25hdGhhbiwNCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtz
IGZvciB0aGUgcmV2aWV3IQ0KPiA+ID4gPg0KPiA+ID4gPiBSZWdhcmRpbmcgdGhlIGludGVyZmFj
ZSBmb3IgdGhlIE1peGVyIE9mZnNldCBhZGp1c3RtZW50czoNCj4gPiA+ID4gQURNVjEwMTNfTUlY
RVJfT0ZGX0FESl9QDQo+ID4gPiA+IEFETVYxMDEzX01JWEVSX09GRl9BREpfTg0KPiA+ID4gPg0K
PiA+ID4gPiBUaGVzZSBwYXJhbWV0ZXJzIGFyZSByZWxhdGVkIHRvIHRoZSBMTyBmZWVkdGhyb3Vn
aCBvZmZzZXQNCj4gPiA+IGNhbGlicmF0aW9uLg0KPiA+ID4gPiAoTE8gYW5kIHNpZGViYW5kIHN1
cHByZXNzaW9uKQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiB0aGlzIG1hdHRlciwgbXkgc3VnZ2VzdGlv
biB3b3VsZCBiZSB0byBhZGQgSUlPIGNhbGlicmF0aW9uDQo+IHR5cGVzLA0KPiA+ID4gc29tZXRo
aW5nIGxpa2U6DQo+ID4gPiA+IElJT19DSEFOX0lORk9fQ0FMSUJGRUVEVFJPVUdIX1BPUw0KPiA+
ID4gPiBJSU9fQ0hBTl9JTkZPX0NBTElCRkVFRFRST1VHSF9ORUcNCj4gPiA+DQo+ID4gPiBUaGVz
ZSBzb3VuZCB0b28gc3BlY2lmaWMgdG8gbWUgLSB3ZSB3YW50IGFuIGludGVyZmFjZSB0aGF0IGlz
DQo+ID4gPiBwb3RlbnRpYWxseSB1c2VmdWwNCj4gPiA+IGluIG90aGVyIHBsYWNlcy4gIFRoZXkg
YXJlIGFmZmVjdGluZyB0aGUgJ2NoYW5uZWwnIHdoaWNoIGhlcmUgaXMNCj4gPiA+IHNpbXBseSBh
biBhbHQgdm9sdGFnZSBjaGFubmVsLCBidXQgSSdtIGFzc3VtaW5nIGl0J3Mgc29tZXRoaW5nIGxp
a2UNCj4gPiA+IHNlcGFyYXRlIGFuYWxvZyB0d2Vha3MgdG8gdGhlIHBvc2l0aXZlIGFuZCBuZWdh
dGl2ZSBvZiB0aGUNCj4gZGlmZmVyZW50aWFsDQo+ID4gPiBwYWlyPw0KPiA+DQo+ID4gVGhhdCdz
IGFsc28gbXkgdW5kZXJzdGFuZGluZy4gVGhpcyBraW5kIG9mIGNhbGlicmF0aW9uIHNlZW1zIHRv
IGJlDQo+IHZlcnkNCj4gPiBzcGVjaWZpYyBmb3IgVFggbG9jYWwgb3NjaWxsYXRvcnMuLi4NCj4g
Pg0KPiA+ID4gQ3VycmVudCBjaGFubmVsIGlzIHJlcHJlc2VudGVkIGFzIGEgc2luZ2xlIGluZGV4
LCBidXQgb25lIHJvdXRlIHRvDQo+IHRoaXMNCj4gPiA+IHdvdWxkIGJlDQo+ID4gPiB0byBoYXZl
IGl0IGFzIGEgZGlmZmVyZW50aWFsIHBhaXIuDQo+ID4gPg0KPiA+ID4gb3V0X2FsdHZvbHRhZ2Uw
LTFfcGhhc2UNCj4gPiA+IGZvciB0aGUgYXR0cmlidXRlIHRoYXQgYXBwbGllcyBhdCB0aGUgbGV2
ZWwgb2YgdGhlIGRpZmZlcmVudGlhbCBwYWlyIGFuZA0KPiA+ID4NCj4gPiA+IG91dF9hbHR2b2x0
YWdlMF9jYWxpYmJpYXMNCj4gPiA+IG91dF9hbHR2b2x0YWdlMV9jYWxpYmJpYXMNCj4gPiA+IEZv
ciB0aGUgUCBhbmQgTiBzaWduYWwgc3BlY2lmaWMgYXR0cmlidXRlcy4NCj4gPg0KPiA+IEhvbmVz
dGx5LCBJJ20gbm90IHZlcnkgZW50aHVzaWFzdGljIHdpdGggaGF2aW5nIG91dF9hbHR2b2x0YWdl
ezB8MX0NCj4gYXMgdGhlDQo+ID4gdGhpcyBhcHBsaWVzIHRvIGEgc2luZ2xlIGNoYW5uZWwuLi4g
SGF2aW5nIHRoaXMgd2l0aCBzZXBhcmF0ZSBpbmRleGVzDQo+IGZlZWxzDQo+ID4gb2RkIHRvIG1l
LiBFdmVuIHRob3VnaCB3ZSBoYXZlIHRoZSBwaGFzZSB3aXRoICIwLTEiLCB0aGlzIGNhbiBiZSBh
DQo+IHBsYWNlDQo+ID4gZm9yIG1pc3VzZSBhbmQgY29uZnVzaW9uLi4uDQo+ID4NCj4gPiBJIHdh
cyB0aGlua2luZyBhYm91dCBtb2RpZmllcnMgKHRvIGtpbmQgb2YgcmVwcmVzZW50IGRpZmZlcmVu
dGlhbA0KPiBjaGFubmVscykNCj4gPiBidXQgSSBkb24ndCB0aGluayBpdCB3b3VsZCB3b3JrIG91
dCBoZXJlLi4uIFdoYXQgYWJvdXQNCj4gSUlPX0NIQU5fSU5GT19DQUxJQkJJQVNfUA0KPiA+IGFu
ZCAgSUlPX0NIQU5fSU5GT19DQUxJQkJJQVNfTj8gT3IgbWF5YmUganVzdCBzb21ldGhpbmcgbGlr
ZQ0KPiA+IElJT19DSEFOX0lORk9fQ0FMSUJCSUFTX0RJRkYgYW5kIGludGVybmFsbHkgaW4gSUlP
IHdlIHdvdWxkDQo+IGF1dG9tYXRpY2FsbHkNCj4gPiBjcmVhdGUgYm90aCBQIGFuZCBOIHN5c2Zz
IGZpbGVzIHNpbmNlIEkgZG9uJ3QgdGhpbmsgaXQgbWFrZXMgc2Vuc2VzIGluDQo+IGFueSBjYXNl
IHRvDQo+ID4ganVzdCBkZWZpbmUgb25lIG9mIHRoZSBjYWxpYnJhdGlvbnMuLi4gQW55d2F5cywg
dGhlc2UgYXJlIG15IDUgY2VudHMgOikNCj4gDQo+IERlZmluaXRlbHkgbm90IGEgbW9kaWZpZXIu
ICBJdCdzIGFsbW9zdCBhcmd1YWJsZSB0aGF0IHRoZXNlIGFyZSBkaWZmZXJlbnQNCj4gY2hhcmFj
dGVyaXN0aWNzIG9mIHRoZSBjaGFubmVsIHNvIEkgY2FuIGxpdmUgd2l0aCB0aGUgQUJJIHBlcmhh
cHMsIGJ1dA0KPiB1bmxlc3MgdGhpcyBpcyBhIHZlcnkgY29tbW9uIHRoaW5nIEknbSBub3Qgc3Vy
ZSBJIHdhbnQgdG8gYnVybiAyIGNoYW4NCj4gaW5mbw0KPiBiaXRzIGZvciB0aGVtLiBOb3RlIHdl
IGFyZSBydW5uaW5nIHZlcnkgbG93IG9uIHRob3NlIGFueXdheSB3aXRob3V0DQo+IGNoYW5naW5n
DQo+IGhvdyB0aG9zZSBhcmUgaGFuZGxlZC4gIFdlIHdpbGwgbmVlZCB0byB0YWNrbGUgdGhhdCBh
bnl3YXksIGJ1dCBsZXQncw0KPiBub3QNCj4gdGllIHRoYXQgdG8gdGhpcyBkcml2ZXIuDQoNCkht
bSwgSG9uZXN0bHkgSSB3YXMgbm90IGV2ZW4gdGhpbmtpbmcgYWJvdXQgdGhlIG1hc2sgc2l6ZSBh
bmQgdXNlZA0KYml0cy4gQnV0IEkgZ3Vlc3MgaXQncyB2ZXJ5IHVubGlrZWx5IGZvciBhIGRyaXZl
ciB0byBkZWZpbmUgbG90cyBvZiBiaXRzIGluIG9uZQ0Kb2YgdGhlIG1hc2tzIChqdXN0IGN1cmlv
dXMpPw0KDQo+IEkgZG9uJ3QgbGlrZSB0aGUgaWRlYSBvZiBhZGRpbmcgY29yZSBtYWdpYyB0byBz
cGluIG11bHRpcGxlIGZpbGVzIGZyb20gb25lDQo+IHdpdGhvdXQgbW9yZSB1c2VjYXNlcy4gIFNv
IGZvciBub3cgdXNlIGV4dGVuZGVkIGF0dHJpYnV0ZXMgZm9yIHRoZXNlDQo+IGlmDQo+IHdlIGdv
IHRoaXMgd2F5Lg0KPiANCj4gSSB0aGluayBJIHN0aWxsIHByZWZlciB0aGUgc2VwYXJhdGUgY2hh
bm5lbHMgYXBwcm9hY2guICBOb3RlIHRoaXMgaXMgaG93DQo+IHdlIGRlYWwgd2l0aCBkZXZpY2Vz
IHRoYXQgYXJlIGNhcGFibGUgb2YgZWl0aGVyIHNpbmdsZSBlbmRlZCBvcg0KPiBkaWZmZXJlbnRp
YWwNCj4gb3BlcmF0aW9uLiAgVGhlIGNoYW5uZWwgbnVtYmVyaW5nIGlzIHJlZmxlY3RpbmcgdGhl
IHdpcmUgaW4gYm90aCBjYXNlcy4NCj4gSG93ZXZlciwgSSdtIG5vdCBzdXJlIHdlJ3ZlIGV2ZXIg
bWFkZSBpdCBjbGVhciB0aGUgQUJJIHdvdWxkIGFwcGx5DQo+IGxpa2UgdGhpcy4NCj4gV2UgbWF5
IGhhdmUgZGV2aWNlcyB0aGF0IHVzZSB0aGlzIGludGVyZmFjZSBidXQgZXhwZWN0IGl0IHRvIG5v
dCBhcHBseQ0KPiB0bw0KPiB0aGUgZGlmZmVyZW50aWFsIGNhc2UuLi4uDQo+IA0KDQpXZWxsLCB5
b3UgYWN0dWFsbHkgZ2F2ZSBtZSBzb21ldGhpbmcgdG8gdGhpbmsgYWJvdXQgb3ZlciB0aGUgd2Vl
a2VuZCBhbmQNCkknbSBnZXR0aW5nIG1vcmUgY29udmluY2VkIHdpdGggdGhlIEFCSSB5b3UgcHVy
cG9zZWQgaGVyZS4gR2V0dGluZyBhbGwNCnRoZSBiaXRzIGluIG9uZSBkaWZmZXJlbnRpYWwgY2hh
bm5lbCBjb3VsZCBsZWFkIHRvIGhhdmluZyB0byAiZHVwbGljYXRlIiBiaXQgbWFza3MNCnRvIGRp
ZmZlcmVudGlhdGUgYmV0d2VlbiBQIGFuZCBOLiBPciB3ZSB3b3VsZCBoYXZlIHRvIGRvIHNvbWUg
bm9uIG9idmlvdXMNCmhhbmRsaW5nIGluIHRoZSBjb3JlIGFzIEkgd2FzIHN1Z2dlc3RpbmcuDQoN
CldpdGggeW91ciBBQkksIHRoZSAic2luZ2xlIGVuZGVkIiBmaWxlcyBhbHJlYWR5IGRpZmZlcmVu
dGlhdGUgdGhlIHBhaXIuIFRoZSBvbmx5DQp0aGluZyB3ZSBtaWdodCBiZSBtaXNzaW5nIGlzIHRv
IGhhdmUgYSBjbGVhciBydWxlIGluIHRoZSBBQkkgZG9jcy4gTGlrZSwgaWYgd2UgaGF2ZQ0KIA0K
b3V0X2FsdHZvbHRhZ2VYLVlfcGhhc2UgYW5kIHRoZW4gDQoNCm91dF9hbHR2b2x0YWdlWF9jYWxp
YmJpYXMNCm91dF9hbHR2b2x0YWdlWV9jYWxpYmJpYXMsDQoNCml0IHNob3VsZCBiZSBjbGVhciB0
aGF0IFggaXMgdGhlIE4gcGFydCBvZiB0aGUgcGFpciB3aGlsZSBZIGlzIFAuIE9yIHRoZSBvdGhl
ciB3YXkNCmFyb3VuZC4uLiBUaGUgcG9pbnQgaXMgdG8gaGF2ZSBhIGNsZWFyIHJ1bGUuDQoNCkhv
d2V2ZXIsIGxvb2tpbmcgYXQgdGhlIG5ldyBzZXJpZXMgc3BpbiwgaXQgbG9va3MgdG8gbWUgdGhh
dCB3ZSBoYXZlIGFuIGlzc3VlDQp0aGF0IEFudG9uaXUgbWlnaHQgaGF2ZSB0byBhZGRyZXNzIGlu
IHRoZSBzZXJpZXMuLi4gVGhlc2UgY2hhbm5lbHMgYXJlIGJvdGggZGlmZmVyZW50aWFsDQphbmQg
dXNlIG1vZGlmaWVycyBhbmQgSWYgSSdtIG5vdCBtaXNzaW5nIG5vdGhpbmcsIHdlIHVzZSBjaGFu
bmVsMiBmb3IgYm90aCBjYXNlcy4NCg0KSSB3aWxsIGxlYXZlIGEgY29tbWVudCBpbiB0aGUgc2Vy
aWVzIHdoaWNoIG1pZ2h0IGJlIGJldHRlci4uLg0KDQotIE51bm8gU8OhDQo+IA0KPiA+DQo+ID4g
LSBOdW5vIFPDoQ0KDQo=
