Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAC361A88
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 09:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbhDPH0l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 03:26:41 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12600 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231666AbhDPH0l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 03:26:41 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13G7KxP0014969;
        Fri, 16 Apr 2021 03:26:12 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0b-00128a01.pphosted.com with ESMTP id 37x9mw4ebm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 03:26:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ns9m8tlOHhF4nowR8qxh1QGraTFqjqZ5ABqi3fw0AmvxA7mcJSfyaxVeld8EnQO09JC0tsBiATuiFG9vebJQRtsOswFWvpTgWA+pJMhzGQjtMRgEsfkl+TSc/kdbVpEBzhkjtl1ePz3gQjB9tPaFgWtgoVVDq3laGpZTYfmmAjuxJfKgxLSorRNyv+3o0I7r0vp8YnMzFo43wJHzcXKZ9A/8yVvt/YQBxsgBAMxesIhe2okIZGD+PMacBYMrcmKIwTp5rnOSKI9d08xiSqNkucxcWIfghUlWe9HG83uvJznlqWsMTpWwM0hrUau9BAnF5H+SBFs3629TbeDXHs041A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbBtTanYsCvmycl53HjKi1VKhOnAdT8RwSYHuTTLDis=;
 b=U1mwh7r5WJSBPMiPdRRMK5Z/zSVUeOiUzLlAHYd4AKq2PJ2g3Jv3mNqhXYDb0wsA1J508iLKHjkgzSpuSHk7t4iF5SK5sk5K5CK881a+mia8H9MZZlYJbyBFff7AQ6vHCKoihMJcm6jFXNSGEHcualUhkNf5xZS/yRZWVFJPEFv5pGjEmgf/re5M6FzdX4+sNeYblOamBZdrN1gytFK4JqTogaMKkPE/MLn2UrLLBAUg5Vkup8/HiN3t9H10DE0IFz4X3yZXrIwJhS48itmXB0znijLmhNiZD5mmKlyV5NKvRbXyf/gB9nx6zwYentrQIzwW085qvP/LJmpZvj1+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbBtTanYsCvmycl53HjKi1VKhOnAdT8RwSYHuTTLDis=;
 b=8BugidDDlkrBsqt6dwMcRfzR1+haytvtCVHsvLddnbc1TbW8tCCxfu3HCx4JoUNLDmcmIAV1W0nDFT0+Bt3C3FbGdMxvoCBIFr8WMwKjcPPXD+4yEvbhw88iPWxeVo2oGeqnAXOrirHhL0VfiIHOpvZ6CbGhmwylheamLqcotTQ=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2316.namprd03.prod.outlook.com (2a01:111:e400:c615::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 07:26:09 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 07:26:09 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Sean Nyekjaer <sean@geanix.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [RFC PATCH 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
Thread-Topic: [RFC PATCH 1/2] iio: accel: add support for
 FXLS8962AF/FXLS8964AF accelerometers
Thread-Index: AQHXMe48BgOnzTPNVkKybkvDFYrEQKq1qp9wgAAxVQCAAOKpIA==
Date:   Fri, 16 Apr 2021 07:26:09 +0000
Message-ID: <CY4PR03MB3112E2AD7053C5C795517089994C9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210415114614.1071928-1-sean@geanix.com>
 <CY4PR03MB31127BA6AD9A0F7DCF295ED0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
 <634cf024-dc01-431a-4955-88b453e2c629@geanix.com>
In-Reply-To: <634cf024-dc01-431a-4955-88b453e2c629@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1ERTJNakV4T1RFdE9XVTROUzB4TVdWaUxUaGlNMkl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEQXhOakl4TVRrekxUbGxPRFV0TVRGbFlpMDRZ?=
 =?utf-8?B?ak5pTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRNd01T?=
 =?utf-8?B?SWdkRDBpTVRNeU5qTXdNekUxTmpZMU9UYzFNekV6SWlCb1BTSldNbXMwZFZj?=
 =?utf-8?B?ellXZ3ZXamRxVEUxRE9FUnBWRmxPUlVsUWRGRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRlNOa3htUkd0VVRGaEJZbWh2YzBSdFIyeDBOWE4xUjJsM1Qx?=
 =?utf-8?B?bGhWek50ZDBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:250c:6a01:6534:6e99:3179:7d3b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66379b75-3ac8-4c94-9fab-08d900a8e803
x-ms-traffictypediagnostic: CY1PR03MB2316:
x-microsoft-antispam-prvs: <CY1PR03MB23162E6E8A790730B9C7A23E994C9@CY1PR03MB2316.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbe5UN3aZKViPY235Aub7OWnY4O/unxaCRDAUBQMOLP8Aix36EPqCaAuxeieRxW7id4Z1thZJhG49+3Z/+2hhN3U+ESNAlmk0S7wlNZkiY/EpmByfSf4bwi1Owasv0d6jwhzGdKF19ngY5dAWhDFSAVm3I4WS+8BBRCTnMENH4Sasjn/yEXc8+WJHPX+CHPwULd6bgCI95EAevQNDmPOC8mwjoUaMZCd1dR7O0E1rFyfqiI5X516yiWcFjEIk/cZq+s1VREw6aSIpu1c/vmUMyEfPeCyShyanflwZk5i9APKDwKXhph24Q7pfKQsmG9OkgrnX5unj9D07ST3IF7I0fg3nBtBNT3pKpyqWWBkcDEpsuo68gXkhkhDJllPANBC9mygCfMseGjSzzXHE0LP0S9D8QhbfWnLrpx2NFe7c3gRs/TlyjzRUVYH35azC/uL++YsAJdVKkGLNMn2qyD0Vsle1j6vd1lkqFAxWbgszM5O/LPavCg+sl5owRjiZ+h76XB9g4Ni3wNs4Phx7bxFBQ/VyAzHcVahiGsBcmLZzZ6136NozuHHuv6M+LGUy9mqW/aqiMDeEhA7SnS3BC+BzzjrN0AnoXVkiYK3cQdJOHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(52536014)(6506007)(53546011)(86362001)(7696005)(110136005)(83380400001)(478600001)(5660300002)(66446008)(55016002)(71200400001)(66476007)(66946007)(66556008)(64756008)(9686003)(8676002)(2906002)(316002)(33656002)(76116006)(186003)(8936002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S3ZwMVVaZDBXSHhiY0pZY1B5MWJKOFpPd3diZEpRRXNHSVJqODMvVEpiVDg3?=
 =?utf-8?B?c3hEYlR3ZGdCZllNcnRUUWxqMTZZV0FCZ2MxL0R2Y1NWcXczRjNtTmhhM0Va?=
 =?utf-8?B?Y3d5eCttUkJpZlN2ZjBMNitadXg2UkVQNEhCdkJvZkxLWmljMUxQV04zdHdh?=
 =?utf-8?B?UFVHQzBTSURJZHRvR3VsTHZIeWR2QThLbDAyUUNHSUoyMmlVRmtZT3JyajhC?=
 =?utf-8?B?WGxDa0hsU0NuQ0NFc3NkbUMxb2l1ME1Mdkg4T3ZoNDV6WGRZTG9kejl4ekIr?=
 =?utf-8?B?MnJIdlpsaDU1TEUyd01lNmxiNHRhcG5wcjFYeTBoY3YyblZHaE1vUUFHNnpL?=
 =?utf-8?B?L1Q5eDMveDZiMHBpWXJqMDJrbnN6OGpmT3JQMlJ4MEJ4eFdJbHU4dTA5bDFQ?=
 =?utf-8?B?a0xGQ3dMRldtMUFkamQwbU1FcTMyYkVZV3pYQnlTNUlQODluM28rYjA2bzB3?=
 =?utf-8?B?cWxSek9BbXhPZ1FjZXAyTmlDdjNwWUdySEFiNC9kV1drRmdRTzljN0o2QXIz?=
 =?utf-8?B?ZEQvNktpc3YyTnpvUjZjWUJTWnBaMkZmSkFod2pFT0xRcjJ2Mk5yWlI4eUJm?=
 =?utf-8?B?SW9NQ096anJiK0IyY2hOZnpVZ054YzY0RXdiQ1QyajJQOXp1VnU5TVpoR3JY?=
 =?utf-8?B?OUVHRFhmaUF0dlZGRjdvRjVCbVZDOG5oZm40MmJUcUtPWFFDMXNjZlN6Znky?=
 =?utf-8?B?Z2dxeG1WbzViT3MwQ3p1Z3VGaFRnaGRVd1FIL2xEOWlFSkJLTmFac0xEZ0k1?=
 =?utf-8?B?S3M4eE5lbkwrQW5qQUtLeldldjZTQVZONHJKUDlYRmtqT08xa2RrOUhSTkVt?=
 =?utf-8?B?TjlpeDNjMnJ6elRhS2JCNEFXVmRXZTZFdVUzNGQ4c3VST3dQamwyODNmeXlv?=
 =?utf-8?B?ajJhRDZGMDFUcW1NcUhheWJ5TjRSZXJFTjB1akV1Nms4eFNUek1iOEtpdHE1?=
 =?utf-8?B?bExTTmE0RnBMTDZUZEVMT0xUejlJclpCNHZvM1c0K2xSQ1ByUTNtcyttU1dj?=
 =?utf-8?B?MU5ObVF6Um9tRnZRbi9wQ2VpU0FFUkl6czVjWFV0S2UvTXkwUC80NndrN1J0?=
 =?utf-8?B?aFQwRlVBbGpLL1F4MTBPQVM4K0tXNUw4OERhOGc2NUVOWnV0RWtNRjI2RTZT?=
 =?utf-8?B?clgwWFUwczhQdEcwRjhXeG1UM3J2NGJEZDlWemVUTDhoTlFSSWJiMHVIQ1Rh?=
 =?utf-8?B?cXBQbEVKcTlkYjZ0WnlwQkI3azgraFp6bU1XTzJ1S2QrdTVLQnhTZWZsRUJY?=
 =?utf-8?B?b3M4ZldBQ0xJZkx6Y1QrMjRCc0dpZitRRjZubG03UituNG1LMm0xd3JYb084?=
 =?utf-8?B?dlV0akVNb2ovNm1OcVRCSnJQWVNMTi8yY3RKNzlaQUhKOCtVNHhYT3JmbFdu?=
 =?utf-8?B?Nkl2NERoZERMcWN2YmdYK0crVjhSUWVCS3BWZW56ajNUclZ4VEpqSFRtc0F2?=
 =?utf-8?B?bHl2NlhLZDdrM09QbFFJWUh1Tkh1WGJqMVNjL2Z1eEtVb0lIa3ZHM0grZGJF?=
 =?utf-8?B?d0IzTkpaWThtelZFTlhLQ3hmQjhZMlhxZUFJekJIQUhqTDBqQmxQY3JwczdM?=
 =?utf-8?B?ZFBsMjNENWp1L1dBRm8wV2R5a2o5M1dzejJxWEVSOGtnM0JraEN1Rzd2YUd5?=
 =?utf-8?B?c01RdHVDbUxVbE1RTDVQdS80ZnJmanp2N0NLSisveUZrUWlENmxsUmFGQ1JK?=
 =?utf-8?B?aThuaCttVHZsazhML1hiZER0TnB6ZTJXS1J4ekl1ZjFVSy9CakRDRHBhckZI?=
 =?utf-8?B?SmlWOFhPTWpXM21xb2lKWU00cjMyUC96aVMrR3liVDREVHNwdlJVckQrOUNE?=
 =?utf-8?B?cFNpSlhQaW9kaTQvKzF6K3NNQUplLzc3MU9KcVpuazM0ZkFBSHhheCt0QUJt?=
 =?utf-8?Q?JfrDN1Edf1rDA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66379b75-3ac8-4c94-9fab-08d900a8e803
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 07:26:09.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9OeQZx6kS8r9q2pXKFZcl+HRWf72AMyXKY+0U8PZLbqVjM2dGzVRaINiIPAAnqsgDy5xdVg6iueWO2TJYTG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2316
X-Proofpoint-GUID: lsSmeU4H3PAZLxIRHgcl9iCWt3zKpK9L
X-Proofpoint-ORIG-GUID: lsSmeU4H3PAZLxIRHgcl9iCWt3zKpK9L
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=750 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2VhbiBOeWVramFlciA8
c2VhbkBnZWFuaXguY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTUsIDIwMjEgNzo1MSBQ
TQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT47IGppYzIzQGtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBpaW9Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IDEvMl0gaWlvOiBhY2NlbDogYWRkIHN1cHBvcnQgZm9yDQo+IEZYTFM4OTYyQUYvRlhMUzg5NjRB
RiBhY2NlbGVyb21ldGVycw0KPiANCj4gDQo+IA0KPiBPbiAxNS8wNC8yMDIxIDE3LjEwLCBTYSwg
TnVubyB3cm90ZToNCj4gPj4gKwlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiA+PiArCXBtX3J1
bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KGRldiwNCj4gPj4gRlhMUzg5NjJBRl9BVVRPX1NV
U1BFTkRfREVMQVlfTVMpOw0KPiA+PiArCXBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKGRldik7
DQo+ID4gTWF5YmUgYWRkIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGhlcmUgYW5kIGFmdGVy
IGVuYWJsaW5nDQo+IHRoZQ0KPiA+IHJlZ3VsYXRvciBhbmQgd2UgY2FuIHRoZW4gZGl0Y2ggJyBm
eGxzODk2MmFmX2NvcmVfcmVtb3ZlICgpJy4uLg0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXcgOikN
Cj4gSSdtIHRoaW5rIG5vdCBhYmxlIHRvIGRpdGNoIHRoZSBmeGxzODk2MmFmX2NvcmVfcmVtb3Zl
KCkgSSBzdGlsbCBoYXZlDQo+IHRoZSBwbV9ydW50aW1lIHN0dWZmIG9yIGNhbiB0aGV5IGJlIHJl
bW92ZWQgdmlhIHNvbWUgZGV2bV8NCj4gZnVuY3Rpb25zPw0KPiANCg0KSSBkbyBub3Qgc2VlIHdo
eSB5b3UgY2FuJ3QgZG8gdGhpczoNCg0KcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQpwbV9ydW50
aW1lX3NldF9zdXNwZW5kZWQoZGV2KTsNCnBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYpOw0KDQpJ
biBhIGRldm0gaGFuZGxlci4uLiBBbnl3YXlzIHRoaXMgaXMgbW9yZSBhIHBlcnNvbmFsIHByZWZl
cmVuY2UNCnRvIHVzZSB0aGlzIGhhbmRsZXIgcmF0aGVyIHRoYW4gdGhlICdyZW1vdmUoKScgaG9v
ay4gU28sIGlmIHlvdQ0KcHJlZmVyIHRvIGtlZXAgdGhpcyBhbmQgSm9uYXRoYW4gaXMgZmluZSB3
aXRoIGl0LCBpdCdzIGFsc28gZmluZSBieQ0KbWUuLi4NCg0KLSBOdW5vIFPDoQ0K
