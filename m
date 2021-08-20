Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D073F2799
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhHTHYZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:24:25 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:3178 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238564AbhHTHYZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:24:25 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JJnoT9022418;
        Fri, 20 Aug 2021 03:23:34 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2nqky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INDlNuOUqqLH5jo0GYMWmpd/tZdmXm6B/nFbRnLogeejatAkEeyHBCqQ+AmWbx0sJYWBJYtasrmVgO4gPEQUyn1Pugj/2SMyak840tjeIsX43C4wnpIa88iEGq3byXXey+II5F7DFzXUYTiz9xc8HVY9wUvB+py082s7iyAefo7Z0LJ1CwNTJUfebrMQtFKb1yNueZB4ooqYz0UfCYplsqraAILXT2PiEQnm4zX9htKiQVlHdQGjZcgvV2MFgsEATTY/Pod2zfeQA6YIUmqrJb8rhQF+hQ4MydOco3/ntXHv7BF3V/z1KTfj3WjlJGVEM2gixs4jZuTshWft2EmcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXGQYTxQShw62Sw0mXj/DVhZJPWeSAnon9kz500NrmI=;
 b=FlChbSb0yNnEEv12RyZyspnXLcQhVz5m72kRK5vjXJuNMxl/pc8JD6fjY8hV8LaZLfnz3xeTzvS1aI7wT47Al65i6mJd+CqSRgirafEbBjIihV7LlDKFnBkgGD/xxFZXu92/8mkxwpPxJGAiQTcMKuQG/X7zWUJ0IV17Hs6VOU5lFvE69npWIUyOuvQFupaL6PGW2gCKaArKj4bpHoNCLM21IjznMP7ED9qR/UgPkw1usYoW5B9tSQo42coE38CsYD40JFg7X9METKUYrKFVX8qnOKS0MLBfx0P0K7UxsAEpvOkojOh5vLA2XNVHC6f5VlAvl5dWme5UgHpFXI2low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXGQYTxQShw62Sw0mXj/DVhZJPWeSAnon9kz500NrmI=;
 b=zBkiNp34BX00nPmFf+dw0fl5+dPu796z8igynRAKIqq07Z54uID3xmM9FF52yX+bYhqyWEvaB1R5LOVuvPWOffH2PfRoFtoniyHJ4A7Bi1Vyqh5dgaM54jGdgv8K7+PKgWUCttj33qd5OvFzqPaYH5QfxnbPJ0mUDRwkpx4SEZU=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB4711.namprd03.prod.outlook.com (2603:10b6:a03:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Fri, 20 Aug
 2021 07:23:33 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:23:33 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/16] iio: adc: max1027: Separate the IRQ handler from
 the read logic
Thread-Topic: [PATCH 11/16] iio: adc: max1027: Separate the IRQ handler from
 the read logic
Thread-Index: AQHXlCHwvjmh9fdYcESDxHdxFBTuPat7//1Q
Date:   Fri, 20 Aug 2021 07:23:33 +0000
Message-ID: <SJ0PR03MB6359F29E247EFAA720B30EEA99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-12-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-12-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9EUm1NR1EzWXpFdE1ERTROeTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEZzBaakJrTjJNekxUQXhPRGN0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpnM05p?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGM0TVRFME16a3pOVEV4SWlCb1BTSnhiRXRLY0Vo?=
 =?utf-8?B?bFZHUndNa016T0RSWVlrNWFkamhoU25Nd1dVMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVTnVTbFZzU0d4S1dGaEJaRUZYYkVZMmEzbFFlakF3UW1GVldI?=
 =?utf-8?B?RlVTUzlRVVVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 72e356b1-5c9d-4e5d-db0f-08d963ab6adf
x-ms-traffictypediagnostic: BYAPR03MB4711:
x-microsoft-antispam-prvs: <BYAPR03MB4711FA798E9E5363F7D18EDB99C19@BYAPR03MB4711.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PQKTlXRWtLfI2+NuhmHcIZJjEYUGy3atygAyqTtTEKxdyzFWu1mqlEIYN74r5FMWKaS6zV+4vvlwwyswx9Ec/yHSQXqPS5gXXBujH8eqGMC7/1S2Dqkqa3bMREJMmSYTv8mIf9X/YlN4ZErCfUBHwJayEfTmKpWwhgDnrb9ETksZycTAGLkiM8jvujKucFYzrow8f6zMPNEQykCxHFt+whyV+hibu0TBxD71YumhCpxwGdzf/JoltN4TCa8mqqU5H3eS3DmyUcyqSFwqkhMKTn4wR9Hq3ktAUdSXNh1SuhcA6V8kuOjSx0Z6y9rWfOX2NCvA94bHsSUoCyvajQr1dZhXAkuf3i/go8AEPRUAIidGIFePAqCgh5OYhtNrzoJA8f0v2X/RROLdaKW5BJC+Wq8GvQOw1mSLY8zWuwGgggDe/5UPLkGnjhOOHG8Gm0GHeKDuzMXclOJISKxSLVk4fZ6cgNphRalLFIo2hmvxrAWGUcQfhckCViMlf3GFjudP6Bs9C4+h9G2xmEk4zuNE8fi0hSqMNdp51WlOBngV4PQ9zHb4DvfNiQHRiZge+HiyllWJJ2XZAtFBaD/3XsBkXhzzm3mtQ4+jxoC6UHTlx72YZA1qoYW8mOmETrYlx4D+q4tx2scc39aLyRg3CVlbvHfN0YsAGk05upD2Fkh8F0zS81AYAguZ13GvGIgVhiByclI5PTG+zccygkHF4uCO1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(71200400001)(53546011)(52536014)(64756008)(6506007)(7696005)(66946007)(66476007)(55016002)(110136005)(478600001)(38100700002)(66446008)(9686003)(2906002)(66556008)(186003)(26005)(8936002)(38070700005)(33656002)(122000001)(316002)(83380400001)(76116006)(5660300002)(4326008)(86362001)(8676002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1dVZ00yZmhSMWRrTjRCWE9qTzhkU3MwajNVa04xUXU5MitZMWorRmY3VSsz?=
 =?utf-8?B?Z3FTLzdzUUcvVFpFNXk2cHc2eXRza1ZJMDh0aHZIbks5M1VhK1hzSkw2V3l0?=
 =?utf-8?B?ZDFRVHpDTjJlUnJPQXE2NXRsMjcxRU9GRFphNWpvMjdMTENVV2ZJZGVoWklB?=
 =?utf-8?B?a3RBOEd6UTZCcFZaTnpkUjh5VDVydTVuaXZTZ2JOb2ZjR3V2eHgzMmVobllL?=
 =?utf-8?B?RnlFVW4reHdXOTNLR25XcjVtQUFmenF4UHc3bTFuTnRyK1dSSVMydktHSTdY?=
 =?utf-8?B?NEhUUjdvU1hteGxORThIWlk1cnRvMllnUDBJTTBoSUJPKytxZ2w2RGpVbzZT?=
 =?utf-8?B?cDlZajM5SDFUYllNQklqRTBMOTRyRk8xMmlGNVo2cEpmNmZxNjl3eDh0QzZo?=
 =?utf-8?B?MTRuM3VMV1FDalhLQ2N2Z3BpSXZNNEZDVUhnRzZvT0xCV1Y1ZEJBcFpYeGt1?=
 =?utf-8?B?ZGYxdFE1WklsY1RPaHZzMjd1eGt3RjlnaFNtZU9RTEtMWkNuQW9zUkZzS2E0?=
 =?utf-8?B?ZDk0QnRuK1cvcWx6OG5ZVjQ1bFFRK1hxNHJmNlBYc1NEeGU2WjRDaUkrMG1k?=
 =?utf-8?B?R2JFbzJmOUc5TFNCOG12eW56N1pFTVNKb2M5QVZRdWlpNTUxem1lK204WXNi?=
 =?utf-8?B?UHIyRldINXlWZ2UyamlIQkd4VkM0ZXF0NmN3cW0xb0pBV2hBOGxDbkV4QjBD?=
 =?utf-8?B?eXJMYUIxSnVYT0tWZFM1RnFrWFlmdFZ3emRTK2N0OWFQa0JzbzRqK296R2Ux?=
 =?utf-8?B?c0ZaMTdCaGVzSXRRMEtRaEpjUjArcHpuSFF6UkFMSjkxNXRmOVlkY0VLRjZ6?=
 =?utf-8?B?SDJVc0U3RjJDbjBCam1lcytpRjBBZXBBeGU2US9NazR6VE1NSmtYS1dVcXEr?=
 =?utf-8?B?NU8xQk52US9DdW1aRVlmc1ZISWowb2pQRkw2d0p2eFJ1d290V2d5a1A4V29C?=
 =?utf-8?B?SUdXUDViZFBBR3NqeW5DYmYrYmRMRDVBbGR5VU9ZeWJ1UVRRN2ZQNzBDd3pT?=
 =?utf-8?B?OUVFL2RlMWxyeDh5ckErNS9PNnhBcWp1RExTNUpXY1J0OU45Tkg4VHV1U3Ax?=
 =?utf-8?B?STVDMldSay92dTMrMnZ0VEUwWktTeDA4SU5vNUYzSlFLZ1hESHRROGJjaEtE?=
 =?utf-8?B?NFdxU0dSTU5uTTJXcUQzRzZXeVhySVpFalJqNDZKaXZFd0VweGZOdWxUNXpH?=
 =?utf-8?B?Wi9vaEQ3Q3hSVkVXM0VKQS9EajhLWjhUTXh1UUtCQ3hra0QyZEdSTmk1OEJS?=
 =?utf-8?B?WGxDZUNNK3FzU2VYQU1VQ3htYTlZdUNwTWkrSk12Y2hNTUJRVnhFVk5qckZm?=
 =?utf-8?B?SFBNdXZqYjYyWjFadkxxeUlPaHpIZUt0Y3FHcnRoY1JoYVBjaGxBS3JUb2VW?=
 =?utf-8?B?UW93bnkxaHRPcHNrcVdqTlZzd2I3bTZ0d2xUenFrMU5PYTkwcVdBTmZ3ZnNB?=
 =?utf-8?B?TFI1R0RiVm40MGRPRDBVUEVkRnpkcHR6NVlqemFaSW8zYUdFTURiNHJJNDVT?=
 =?utf-8?B?OUpwc1Q1NFFXcTlraVRvMEhOd3ZqWE0yNGVaNG1JckNHeUhHU1BBZE83Ui8w?=
 =?utf-8?B?RnUyM1p6S1lmWWFZbGZiaTA2YkxDV25zVG8vWE5Jb1FnK0NIeVJpdDYvVmkw?=
 =?utf-8?B?UXZDSGdySVFMQUJxRlRKRVRDUmIxTVdHR3NGbjd4TmN1aHFqN2RyTys1U0dM?=
 =?utf-8?B?K1VnRUFCRjIwMGNQcyt2ejN3TWFhY3MyQ2VRUnpjSFg1YU03OEd5KzNoYXhy?=
 =?utf-8?Q?K2YjqHznEO6Mbm43NOMR36I0oN2UmiCvqvKgfM7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e356b1-5c9d-4e5d-db0f-08d963ab6adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:23:33.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNho+Is3czg9vcWdk7kiyXLT6TV0pd1aGVoYFOBVHC5Ui7bF3qiDXh4k7AIEi97ZgqkUHyReCysiey3bJSFOPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4711
X-Proofpoint-ORIG-GUID: 0WLyNmxGbiJGBZOouBH7O17_bzI26jDW
X-Proofpoint-GUID: 0WLyNmxGbiJGBZOouBH7O17_bzI26jDW
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
IDIwMjEgMToxMiBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMTEvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBTZXBhcmF0ZSB0aGUgSVJRIGhhbmRsZXINCj4gZnJvbSB0aGUg
cmVhZCBsb2dpYw0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gQ3JlYXRlIGEgbWF4MTAyN19yZWFk
X3NjYW4oKSBoZWxwZXIgd2hpY2ggd2lsbCBtYWtlIGNsZWFyZXIgdGhlDQo+IGZ1dHVyZSBJUlEN
Cj4gaGFuZGxlciB1cGRhdGVzIChubyBmdW5jdGlvbmFsIGNoYW5nZSkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMgfCAyNyArKysrKysrKysrKysrKysrKysrKyst
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMgYi9kcml2ZXJz
L2lpby9hZGMvbWF4MTAyNy5jDQo+IGluZGV4IDgzNTI2ZjNkN2QzYS4uYWZjM2NlNjlmN2VhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+ICsrKyBiL2RyaXZlcnMv
aWlvL2FkYy9tYXgxMDI3LmMNCj4gQEAgLTQyNywxOSArNDI3LDE4IEBAIHN0YXRpYyBpbnQNCj4g
bWF4MTAyN19zZXRfY252c3RfdHJpZ2dlcl9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcs
IGJvb2wgc3RhdGUpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGlycXJldHVy
bl90IG1heDEwMjdfdHJpZ2dlcl9oYW5kbGVyKGludCBpcnEsIHZvaWQgKnByaXZhdGUpDQo+ICtz
dGF0aWMgaW50IG1heDEwMjdfcmVhZF9zY2FuKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+
ICB7DQo+IC0Jc3RydWN0IGlpb19wb2xsX2Z1bmMgKnBmID0gcHJpdmF0ZTsNCj4gLQlzdHJ1Y3Qg
aWlvX2RldiAqaW5kaW9fZGV2ID0gcGYtPmluZGlvX2RldjsNCj4gIAlzdHJ1Y3QgbWF4MTAyN19z
dGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiAgCXVuc2lnbmVkIGludCBzY2FubmVk
X2NoYW5zID0gZmxzKCppbmRpb19kZXYtDQo+ID5hY3RpdmVfc2Nhbl9tYXNrKTsNCj4gIAl1MTYg
KmJ1ZiA9IHN0LT5idWZmZXI7DQo+ICAJdW5zaWduZWQgaW50IGJpdDsNCj4gLQ0KPiAtCXByX2Rl
YnVnKCIlcyhpcnE9JWQsIHByaXZhdGU9MHglcClcbiIsIF9fZnVuY19fLCBpcnEsDQo+IHByaXZh
dGUpOw0KPiArCWludCByZXQ7DQo+IA0KPiAgCS8qIGZpbGwgYnVmZmVyIHdpdGggYWxsIGNoYW5u
ZWwgKi8NCj4gLQlzcGlfcmVhZChzdC0+c3BpLCBzdC0+YnVmZmVyLCBzY2FubmVkX2NoYW5zICog
Mik7DQo+ICsJcmV0ID0gc3BpX3JlYWQoc3QtPnNwaSwgc3QtPmJ1ZmZlciwgc2Nhbm5lZF9jaGFu
cyAqIDIpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiANCj4gIAkvKiBP
bmx5IGtlZXAgdGhlIGNoYW5uZWxzIHNlbGVjdGVkIGJ5IHRoZSB1c2VyICovDQo+ICAJZm9yX2Vh
Y2hfc2V0X2JpdChiaXQsIGluZGlvX2Rldi0+YWN0aXZlX3NjYW5fbWFzaywNCj4gQEAgLTQ1MSw2
ICs0NTAsMjIgQEAgc3RhdGljIGlycXJldHVybl90IG1heDEwMjdfdHJpZ2dlcl9oYW5kbGVyKGlu
dA0KPiBpcnEsIHZvaWQgKnByaXZhdGUpDQo+IA0KPiAgCWlpb19wdXNoX3RvX2J1ZmZlcnMoaW5k
aW9fZGV2LCBzdC0+YnVmZmVyKTsNCj4gDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBpcnFyZXR1cm5fdCBtYXgxMDI3X3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpw
cml2YXRlKQ0KPiArew0KPiArCXN0cnVjdCBpaW9fcG9sbF9mdW5jICpwZiA9IHByaXZhdGU7DQo+
ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBmLT5pbmRpb19kZXY7DQo+ICsJaW50IHJl
dDsNCj4gKw0KPiArCXByX2RlYnVnKCIlcyhpcnE9JWQsIHByaXZhdGU9MHglcClcbiIsIF9fZnVu
Y19fLCBpcnEsDQo+IHByaXZhdGUpOw0KPiArDQoNClRoaXMgc2hvdWxkIGJlIG1vcmUgY29uc2lz
dGVudC4uLiB1c2UgJ2Rldl9lcnIoKScuIEkgd291bGQgYWxzbw0KYXJndWUgdG8gdXNlIHRoZSBz
cGkgZGV2IGFzIHRoZSBkcml2ZXIgc3RhdGUgc3RydWN0dXJlIGhvbGRzIGENCnBvaW50ZXIgdG8g
aXQuLi4NCg0KLSBOdW5vIFPDoQ0KDQo+ICsJcmV0ID0gbWF4MTAyN19yZWFkX3NjYW4oaW5kaW9f
ZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZXZfZXJyKCZpbmRpb19kZXYtPmRldiwNCj4gKwkJ
CSJDYW5ub3QgcmVhZCBzY2FubmVkIHZhbHVlcyAoJWQpXG4iLCByZXQpOw0KPiArDQo+ICAJaWlv
X3RyaWdnZXJfbm90aWZ5X2RvbmUoaW5kaW9fZGV2LT50cmlnKTsNCj4gDQo+ICAJcmV0dXJuIElS
UV9IQU5ETEVEOw0KPiAtLQ0KPiAyLjI3LjANCg0K
