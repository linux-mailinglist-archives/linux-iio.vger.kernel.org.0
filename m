Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D793F2791
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbhHTHTN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:19:13 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:6306 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235996AbhHTHTM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:19:12 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JKiVBq022894;
        Fri, 20 Aug 2021 03:18:23 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2npqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5ZfYHW0xfVSnK9lxBmyfFK/aUCUqckHkeyiTxTCbtbKb2WwNrC8r3wDwC7/wsZETUg2mZqxFph3HBDTEC/NXFf0BN/DVwOVkN5YKjyvaO4oi4cvXtjZRnY+Pe2tzAvAvA7dyW57bQthi12KiWFalFsMLM11FJHvhTlpqeWK+bPWVYvyxnEcB6eeUh5tpSSfzrCUizj5ikQD6jvuWojKDJX7nPaQtSXE2B9ua5d+Cze1S3cDkvAUZ+1+38hOcazfZbrSD4XbKTPkOtoGPv/k1UMnyFpdAsKXEPIkvQshigIIc14EDWD1yXOSubjiM4/Ol3f7E8yjRXs5rcQ5j5cuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v61fowDXnttuRUwzVpu4L5mKoIejSDlLrEsqAmaxuw=;
 b=PgArc1CFwBRgRjF+h5wmxAAXBFmo9zULrARZAq7kJiYO21FQ1ymBgtpRmljFw1zz9Z9yPQ8yabqo2slnMtopxralZOO98gI6GsfdOb6IAQMR1DEd4fgjsSGP/GqVRrqxdNENeMkYpVKl/GHKypMu22D3+wxhoP4nmjHsyeZC7/sJ0Jz+zsxGNyGukO+UHHOsxQULZY7P/V2Oeu+PJTtc864S1imfsWgUOs3KZaEw6HWM0tAOIhX9eryApr70ven6SdsCF/6wUp+x9VKmgKRHDEtx3foo4YsfbwOXiqMY+BEOKGnTzN4tJvihBa6hFK/TG1FX5/nurmKDTebgCMpgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9v61fowDXnttuRUwzVpu4L5mKoIejSDlLrEsqAmaxuw=;
 b=VT/Njk7XATzZrYFMlUJc6h+e0vpz709S8If4Ig9tJG+sa2wDC3pOHOuZ3AgT7eUTGW8bIRm7GMWP3mYTRJdmtaNO9WCVPGcwHA8PxUQ1nwmt1mbHd0XWEpWhCdZLjCKjwu+DRgcE8CP1nj3b5iQa1g/dqKyA33XguOkR/EoqBkw=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB4711.namprd03.prod.outlook.com (2603:10b6:a03:13c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.24; Fri, 20 Aug
 2021 07:18:21 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:18:21 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/16] iio: adc: max1027: Create a helper to configure the
 channels to scan
Thread-Topic: [PATCH 09/16] iio: adc: max1027: Create a helper to configure
 the channels to scan
Thread-Index: AQHXlCHcSu5ZbCh1uEaKUffbgbNWzqt7/pzQ
Date:   Fri, 20 Aug 2021 07:18:21 +0000
Message-ID: <SJ0PR03MB63593FAF61A76DAB1D06931999C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-10-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-10-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFkySXpaVE0wTnprdE1ERTROaTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHTmlNMlV6TkRkaUxUQXhPRFl0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpVd05D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGMwT1RrNE9USXpNalkxSWlCb1BTSkhSbTFSWVVw?=
 =?utf-8?B?emVXaFNSRU42UkRKeU55OVVNVGxVVTNSMWFFazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRkNNa3BoVG1zMVdGaEJZbFZCZEVwU1p6TnRXRXQwVVVNd2JF?=
 =?utf-8?B?ZEVaVnBqYjBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 0ef52b44-eccf-474f-43b1-08d963aab12d
x-ms-traffictypediagnostic: BYAPR03MB4711:
x-microsoft-antispam-prvs: <BYAPR03MB47118C8A1514926559E8CE3B99C19@BYAPR03MB4711.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LP7swBDUeG8Y/3uY9+yaczjRRTh/5SmSoAaGIZc++HBWtwNm39iuihTlY+uRERf/wyhlllHAtBlLFzpjcQrGesxC8nlW5UwD1gw8r5ZPhbNwzwtya3BDq/43+4qqYPPLwGglPc8OqSFepIQ8tE2FIbDtavopvCNZZAJyD0CyXJUC/voW3a5tC/BbO7J99BkkilhJR4MbGHXfkzZQuThqV2uimq3ok09PpurpLGITI4CKguIGAacUStza2HNNI9UCiIm91H+aJYlbodxRi/hu2u5q1D7DIFaWSfU9xcKEkp05xF5mpZW363d56hnS3r0OlFAPF/t0Jh4B5pzatoQDtJjwx6g2XDviXkyA2dnBII8ezF4Dq0ua4/XlSkj/nqirHizL7pZZLpmG/rTB6EOAUYafDZLmgwsMXEZx0f9eG/wkWnTT5iwtqdTbbLdYywiSAwtdYdm51Ewa+aqeIvrB14MFbo37THZBpEvlCr3lpBYk1UxKUkqA4LeZb2w+KQ0gsdGgnZIQw0fWbv3BO858L5c3lVi5ETyUxNGD6trhJV+1xefVW4/b2qVo96GV5fkTYItQm+BHWGAPsjzF8LkCyxuSe5/jjP7x2srqU9ytWhwCm2+kOOHjRgOFmLePmOKtyies66/FIOMCfNi7eiabXHjpCsvLkbY4KXm2qGAgQTri5ssPztFwP5zWPE3TVxibZ9rpia2RY4pHdrYibHI3Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(71200400001)(53546011)(52536014)(64756008)(6506007)(7696005)(66946007)(66476007)(55016002)(110136005)(478600001)(38100700002)(66446008)(9686003)(2906002)(66556008)(186003)(26005)(8936002)(38070700005)(33656002)(122000001)(316002)(83380400001)(76116006)(5660300002)(4326008)(86362001)(8676002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhiKzcya3lUM0xtRVBEM2JUV2cwQW01WEYyT3RWd096RG5YdFVwMTRjRUtD?=
 =?utf-8?B?cVYvdWRGSjRIWHVZNzU2amtvK0NkWS9tNmtkeGd0ZS9UKzhQcTM0M3FJZGo4?=
 =?utf-8?B?L2dVSVNxOHFER3kzS1grc1ZWL0l2WDhWVXNCNm9URSsvSkhPd0t2dU5TR1hh?=
 =?utf-8?B?Y1NNK1kzL21qTnNaay9vcEJyd2NScU9Ub3lDQll1SDJ4dGNrcHo4TDJUcERY?=
 =?utf-8?B?ZnJPVXBXR0MzTWpqTk0wMmFhRzJGaVRNRVd4Z21XYVJCWEQvY0pWUnhvODFo?=
 =?utf-8?B?RStmMGttcmFsVXVXL2tTczBzVjFJTVl4RlRWeXVkSkRMZC8xN2UwUTltRHBu?=
 =?utf-8?B?QnlWY3lpeHB4bFh1RW5HVEI2Rloyby95UnFkVitzOEdHOG1oUHRhdEVFYU9P?=
 =?utf-8?B?Tkh1V3pkWi9VVXZnR0c1QlJVZkV1cUNrOFZVbzBnMk9yT3NwRytsNHgxTVJV?=
 =?utf-8?B?VEhUUWJwQUhhRWI4NlFMUnhkdHJ1cmtHMk1EYXpIc1VwNGg2RmU0QUYrb2U4?=
 =?utf-8?B?dno1clFnTUlyY2NHVGljN00zekk1eFFPbXNBaEhLb0diRFZKVGpmV3V4N2tJ?=
 =?utf-8?B?SmcyeEI5NWdydXpqMi83d0dyTDF0UTFBcE42UHhqU01vR0Nnc2VLYnZlb3Zt?=
 =?utf-8?B?cTBNM2wyNE5FM2ZsMmxqUDZxQmYveTlmTWdLelVjRjR6V0owNFBxQ0lOWTE4?=
 =?utf-8?B?UW5Wd3VqVm5NbEdvQnpZaHgxcjlMZDZ4djJHSzJUTkZxMlBXWGg3VjlFM2k3?=
 =?utf-8?B?eFNOSUR5eHlYTVRyVGpzQTBkY3FtZUZ5M2RkdXF0dUhHMHF3ang1T2pVOEtI?=
 =?utf-8?B?elBDUDJBbEU3TjJMUHNJYU43aUM4SHdFaGc3RDNlaEU3ZitLTlVRMmUyRUFs?=
 =?utf-8?B?a2NsMXJtRmJTNkZRM2FSSjR4Vmp5T041OERwV2dkYUNsU0wxOGszc2tyb0tD?=
 =?utf-8?B?cncvWVFOYWNOY29FM2x6blFqMnkvMGFWd2piYVpObzJidWJkYitNWHVQeTR5?=
 =?utf-8?B?OXZaMmgvOVJkMDhJTnVuNDc1NTFmZXFqeC9OWUtzNzI1VHlVRkJ6Q29tSnN1?=
 =?utf-8?B?RFk1djNkZVBHVnFVNE5iTkM2NDNlMENoNlRNZzBjMUttcCtvTlFwZyswZEhC?=
 =?utf-8?B?VUJtcERyai85aFk0VURmQVNvYzBqWXpqY1ExL0RycjhueEcxeXVlcEJmcmJY?=
 =?utf-8?B?bEs1OUpCSDJydk1MRzN2bHUvU1Jhc2xjd1ZaRHp4aW1uUUhSVHUyaXkvZkV4?=
 =?utf-8?B?SDMzTy9XYitZNHkxZHdjVmRiLyt6Tk5ZZkV2MFhBQmNDVnRHWVVVTlNNSXdl?=
 =?utf-8?B?b1N3ZVpFbGl1TFZUL0c3Y0dhNjRtWjZzb3FlRGVtSitvWjU0UDhCV2Y3emhz?=
 =?utf-8?B?bXRlRjAvUzZKYmxoR2JjcTB2Vmt4dVBUN2Q2cG80a29KaG5jWStobXk4OEdI?=
 =?utf-8?B?Rk1OMHpLZXBzRGlmSGFadW1SV2xvUkFFOHNKSlg1Y1B0WGI0cGN3bGRJeDBj?=
 =?utf-8?B?WnZHRWdIR2lZa1JvZ1hDbWZ2MHE2cS92YWhwVzNDVDkxckoyNE1oUEw4M2dG?=
 =?utf-8?B?UDd2WGpNVEJsazNMYTNWd2lmeDM5cUZ5OGVFbkpMUzRwQUpaQ1I0dGNueU9W?=
 =?utf-8?B?bHRkOVRJQkRPa3VwVVJOckVObStMNFd4RnB4bVBIVklzL0x0SnJkYmZWTHVx?=
 =?utf-8?B?Q3dLWGdKTHBTczQwZmF1VStDU2VGQm9RaThmSy80UHhEUktiV0lSc2lzWVF1?=
 =?utf-8?Q?3dRnQTt+niTl1o6cM9qJIAU1fIBp00NUx8xLxQ6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef52b44-eccf-474f-43b1-08d963aab12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:18:21.7022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoj+QDUaBZTJt6/Gx26s5ZRnmJG+9hl20UxlYoiayphj66QOjfayz9UDHcSWFpnMRzyEpbuH1pMeNUQ07Ox0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4711
X-Proofpoint-ORIG-GUID: gel15CsJrarxzx7RAHyb4844GkHgMxJF
X-Proofpoint-GUID: gel15CsJrarxzx7RAHyb4844GkHgMxJF
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
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDkvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBDcmVhdGUgYSBoZWxwZXIgdG8gY29uZmlndXJlDQo+IHRoZSBj
aGFubmVscyB0byBzY2FuDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBUaGVzZSBiaXRzIGFyZSBt
ZWFudCB0byBiZSByZXVzZWQgZm9yIHRyaWdnZXJlZCBidWZmZXJzIHNldHVwLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jIHwgMjYgKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMgYi9kcml2
ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+IGluZGV4IDRhNzhjOWNiYzMzOS4uMjIzYzllNGFiZDg2
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+ICsrKyBiL2RyaXZl
cnMvaWlvL2FkYy9tYXgxMDI3LmMNCj4gQEAgLTIzNiw2ICsyMzYsMjIgQEAgc3RydWN0IG1heDEw
Mjdfc3RhdGUgew0KPiAgCXU4CQkJCXJlZyBfX19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ICB9Ow0K
PiANCj4gKy8qIFNjYW4gZnJvbSAwIHRvIHRoZSBoaWdoZXN0IHJlcXVlc3RlZCBjaGFubmVsICov
DQo+ICtzdGF0aWMgaW50IG1heDEwMjdfY29uZmlndXJlX2NoYW5zX3RvX3NjYW4oc3RydWN0IGlp
b19kZXYNCj4gKmluZGlvX2RldikNCj4gK3sNCj4gKwlzdHJ1Y3QgbWF4MTAyN19zdGF0ZSAqc3Qg
PSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkvKiBUaGUgdGVt
cGVyYXR1cmUgY291bGQgYmUgYXZvaWRlZCBidXQgaXQgc2ltcGxpZmllcyBhIGJpdCB0aGUNCj4g
bG9naWMgKi8NCj4gKwlzdC0+cmVnID0gTUFYMTAyN19DT05WX1JFRyB8IE1BWDEwMjdfU0NBTl8w
X04gfA0KPiBNQVgxMDI3X1RFTVA7DQo+ICsJc3QtPnJlZyB8PSBNQVgxMDI3X0NIQU4oZmxzKCpp
bmRpb19kZXYtDQo+ID5hY3RpdmVfc2Nhbl9tYXNrKSAtIDIpOw0KPiArCXJldCA9IHNwaV93cml0
ZShzdC0+c3BpLCAmc3QtPnJlZywgMSk7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCg0KcmV0dXJuIHNwaV93cml0ZShzdC0+c3BpLCAmc3Qt
PnJlZywgMSk7Pw0KDQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgbWF4MTAyN19jb25maWd1cmVf
dHJpZ2dlcihzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBtYXgx
MDI3X3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+IEBAIC0zOTEsMTQgKzQwNyw4
IEBAIHN0YXRpYyBpbnQNCj4gbWF4MTAyN19zZXRfY252c3RfdHJpZ2dlcl9zdGF0ZShzdHJ1Y3Qg
aWlvX3RyaWdnZXIgKnRyaWcsIGJvb2wgc3RhdGUpDQo+ICAJCWlmIChyZXQpDQo+ICAJCQlyZXR1
cm4gcmV0Ow0KPiANCj4gLQkJLyoNCj4gLQkJICogU2NhbiBmcm9tIDAgdG8gdGhlIGhpZ2hlc3Qg
cmVxdWVzdGVkIGNoYW5uZWwuIFRoZQ0KPiB0ZW1wZXJhdHVyZQ0KPiAtCQkgKiBjb3VsZCBiZSBh
dm9pZGVkIGJ1dCBpdCBzaW1wbGlmaWVzIGEgYml0IHRoZSBsb2dpYy4NCj4gLQkJICovDQo+IC0J
CXN0LT5yZWcgPSBNQVgxMDI3X0NPTlZfUkVHIHwNCj4gTUFYMTAyN19TQ0FOXzBfTiB8IE1BWDEw
MjdfVEVNUDsNCj4gLQkJc3QtPnJlZyB8PSBNQVgxMDI3X0NIQU4oZmxzKCppbmRpb19kZXYtDQo+
ID5hY3RpdmVfc2Nhbl9tYXNrKSAtIDIpOw0KPiAtCQlyZXQgPSBzcGlfd3JpdGUoc3QtPnNwaSwg
JnN0LT5yZWcsIDEpOw0KPiAtCQlpZiAocmV0IDwgMCkNCj4gKwkJcmV0ID0gbWF4MTAyN19jb25m
aWd1cmVfY2hhbnNfdG9fc2NhbihpbmRpb19kZXYpOw0KPiArCQlpZiAocmV0KQ0KPiAgCQkJcmV0
dXJuIHJldDsNCj4gIAl9IGVsc2Ugew0KPiAgCQkvKg0KPiAtLQ0KPiAyLjI3LjANCg0K
