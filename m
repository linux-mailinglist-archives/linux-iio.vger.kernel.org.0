Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1E73BF7F4
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jul 2021 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhGHKIr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 06:08:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6518 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231324AbhGHKIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 06:08:47 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168A12sd003689;
        Thu, 8 Jul 2021 06:05:45 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00128a01.pphosted.com with ESMTP id 39mehm2bnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 06:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuET7esgv1qNJxRkyCxVVMeLGDst9K6AekygEeXZlVRLlqz7vaAjYMWxzOyjAMeSIwDdaNXGJPWTTghrJUxvlzXKPd6DoZEivpR+ussTvSMw317ekxlsQx+nPuYuUNG2rcCKN4iu+UEwtiWCpSSMOAajx4RljtD93/fu5lKbbNr9qTxWy89OJqkfjMfAzM+isUELAk7N4Z8hs1bsJ1VzfDtT5rNgXI6gLIk36PJ0a15bV7/Tr0UTys+qRiNMY0zw4vodBMbsaL5kTz0sAPS7oNqvwMoNJQMPURKkf+T3eogbmduP7jRsPD6w2hS21q6LfY9sxPFB1oE9LB02peqeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foob9pLL6P5IyOkNum4BMCioPh/zGj8HRh/Vdt6UGRo=;
 b=Udfo1dBuqsX2PEBZmPrAuIs39w8CnT4VHX5rTbN2RCbvj4xCOjroTIGmB0chi5ic4FtELu31IuO2D5nwW+4lFWSOpgnK7ukKQ6XVIVugevUy6C5Vr0jZ8xrarEuTG+33CB+t8wJhQ0Bwpo+SM49VuTEYQSOcgV+mMHLkesRizgXX+AjkWx1xlNyYApvVEuL2Ij5kS8ueK16w15wxL7dbHLWWcYo1vRHyMsRgfWjic2POuP6DXwowTSbdGgoI30l+w/e0X0KXSzakICasdypSnuowEJnkxe0JTvGLB1wVZUN/oYPVM67m540C1Zjhtu6/oQ3lhq6dYGjJF1qeka+TFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foob9pLL6P5IyOkNum4BMCioPh/zGj8HRh/Vdt6UGRo=;
 b=jjV11YChq8GYN51KRihvPSCxK3x+Er+VDuRjiww156zaEnwjcUVqtuug7hnz7p6Rx8g33IttMnKMewV2omtdj2IsfoNQ+Q0khLWpc/e9MgekftlHP1+phyFQszu4JuranOF1T5maLAXpM4n1T48+bp7v4URvFxCQOwbVBbWehpk=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5909.namprd03.prod.outlook.com (2603:10b6:510:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 10:05:40 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Thu, 8 Jul 2021
 10:05:40 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     =?utf-8?B?QW50dGkgS2Vyw6RuZW4=?= <detegr@rbx.email>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iio: adis: set GPIO reset pin direction
Thread-Topic: [PATCH v2] iio: adis: set GPIO reset pin direction
Thread-Index: AQHXc9/1i5er0/H1ikuyoFCAntpp2as42Zqg
Date:   Thu, 8 Jul 2021 10:05:40 +0000
Message-ID: <PH0PR03MB6366DFDA5446CDC0D57AB3A199199@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
 <20210708095425.13295-1-detegr@rbx.email>
In-Reply-To: <20210708095425.13295-1-detegr@rbx.email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1HRmpaVFJqWlRRdFpHWmtOQzB4TVdWaUxUaGlOekF0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEQmhZMlUwWTJVMkxXUm1aRFF0TVRGbFlpMDRZ?=
 =?utf-8?B?amN3TFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRnek5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56QXlNVEl6TXpneU5UazNOVFk1SWlCb1BTSm5VbFJFVVc4?=
 =?utf-8?B?MVdHTnFjSEZLTW0weWRDOWhlVWRxWVVaVFl6ZzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVUkNOWGxxVGpSSVVGaEJWVUpGVlZWQ1VsUmlhamxSUlZKU1VV?=
 =?utf-8?B?WkdUblZRTUVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 34d1cc4b-028b-4d1c-9114-08d941f7f11e
x-ms-traffictypediagnostic: PH0PR03MB5909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB590913924BD77221F41E74A299199@PH0PR03MB5909.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: De8fnU0FsQOv3uIg4jQCk9JfQc2/pbYCfkaXw/5sq1niALXzbDrzENl4LK9+djaHmUlqp9VEth3IU3WK0zdLEZ2CpZiYS+9qviQSr0B8Kn9cTrnJ+sRcwskbDiLRNzLqOtYbdqqBdgUdTi18vrXay3xK8lMAOOW/3lwsZ4eshazRW11YC7Ja6TAeqnr0aq3tTvDQANDUj9ZJOxZ8M5NsxnztYNaE+d/FTeogjUB/IkdZAYpk1bRkC11PjhQECa4/qF5mVH2WGAPtdYysw7XbEzmgQZLHAlqDIDIkt2bs7murHniRUgkKoE9UUm/4HxewA0ZpOxLa2I+9/uSns0v1YTUq2ai++uB/IySt2jFdnGUlHn06tGEbk89ITtcf40SvIC3BfJcp+rNLdW5q8jkVK8ZhxiIdG7m7u1LDDk+liLOSldhzlgA1rdj5nSpyrzDMH1PNJM9Sq9TgcoO9yR9nmtFJoOuaycZw2j7EAMUaYHzsKXxA0Wlmgw8/X+qKVh8twfdKF5LvHYvpDjvi/hQfQy7tLinC+HukPHZk/eED7/EmV3x7TavYDRM0DJbC0+YcALcF0XpZnv1uaF7HmeZsxY59NX6c8yb+a1WZQsbT1VgMr1hMco2tv8dHYJl892ZxuT0xCarmlz7q4pxQCQKdXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(66946007)(66556008)(64756008)(66446008)(66574015)(66476007)(33656002)(76116006)(2906002)(7696005)(86362001)(122000001)(26005)(55016002)(6506007)(53546011)(8936002)(38100700002)(110136005)(54906003)(83380400001)(4326008)(71200400001)(186003)(5660300002)(8676002)(52536014)(478600001)(316002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXZLSDJWc1pCOWovQmt6RUtmOHJOWjhyd0dyUGVDRTV0b3NwNTBMeFFHR3gr?=
 =?utf-8?B?RjY1ditjVnJZaWV6YjA3K0JsNXVGdWhmWDEwVGx4K2NiMTRaSjRwUi9yOVFl?=
 =?utf-8?B?TkN1S0d2RmhJZnBWQ1luQmQreHVuWWxWSUpHdEo5OCtBTDZ6cFg5ZTkwakdp?=
 =?utf-8?B?aDVQODNYRVNiengzdURvMGx0Mk1JckdKUXVxOHlTNEFvZVFQMXg5VTBsUDJO?=
 =?utf-8?B?b2NuSUsyOFYyZVR1VHVKaFQ5VjkrQURoZk5mZGxZU2ROR1JsNDhhWVBqQzFB?=
 =?utf-8?B?MWtUbzNpYlFRYUFNNWZHY3c3cXYwcHZJRWtBUEhzejJkZGxwckRpclE3Ukt6?=
 =?utf-8?B?UVJpaFBwWlVHOTlMSEpwdzBlNXJSYjVvek1HNG1Cb3J6M21IT0RHK3FHMmpN?=
 =?utf-8?B?V0puRGphMTdPWWFvOExDYVVENkQ0RGxOZVR3OXI2NW5Lb0syZXc3SHY5azJL?=
 =?utf-8?B?andSNnlQU3czUlRLdGo4VERLMDM0cE9la3VJWjZJWEZJV3dpSzNJakorU2Mx?=
 =?utf-8?B?OUYxTVJmdEVvdzRkNzJvTHUzOGV3UVROa2k3bFArcnkxUkVucWk4b09yaDlP?=
 =?utf-8?B?cm5WODJGa3kxUkRpV0gxc2VzRk9BTGhwdzR6SzBSandXUE5oSG51aVB1VjYx?=
 =?utf-8?B?LzBQYnJ4dEh3T1ZOY1FucENRaVkwVzNOVEljdWJNQXRzUGNWRW1zdVM4TDNh?=
 =?utf-8?B?SGVrek9pUDNkbmxyRkN1VU1sRDJ6dEFqbzNWMUt2Sno5c0Q2VXFTL3dHcmxK?=
 =?utf-8?B?R1dLNi9zeFhMVHlRandOaCtZbWQyVHdGNmUwdGhMV3NYRDZnNlJuM09seUJu?=
 =?utf-8?B?Y0tYbUpSdDlLdDN4NklBTmViTEFPbWRSYU9MaitBVmlXcXFLc2xvK1krcitX?=
 =?utf-8?B?SjE2Sk5jZ0tSeTA3aXhuSzBkQnlZUHBpQWhpSk9zZFlVUTREMS9zaGIwN0tR?=
 =?utf-8?B?ZmNkRnZNZ3JCRTR6eUNNMjA5OXRURFpJaHZvektQUDhTbTRWVld0dGkrOVRX?=
 =?utf-8?B?T3lCS1g3R0ZuRlBaT2p2TEQzdTl5ZEVGaGpjUDRTbWRySkhmWW9UWVg4Wktk?=
 =?utf-8?B?WjE2cWlKWVZ5ajlXZlhJdGRCblNXNDFqeG5Zcnp5Y1JrTFpBb0oxd0FNOHA2?=
 =?utf-8?B?dnpCNzdBNnJMNDdpY3NHT0pIcDh1ckcvZFFENXZEM2x5MTY0eHM4YnRGWWdk?=
 =?utf-8?B?SklyczUycStJY2xqT2ZGTTQ1YnowQnI4QkpYeityb3dxMmlwSFRMT3Rzdm5I?=
 =?utf-8?B?dVJJZ1lVODZ2S05KeXY3Z3BTR3FzL2F0MTJBUUhlVHA1VXpYTzVYNXhBbjk3?=
 =?utf-8?B?cHV2YllRY0NVZCtWYW1iMnZ6Rng5Z0RmL2hWUnQ1ZW1mTStzemVpTjBwN2li?=
 =?utf-8?B?djVhbisxMzJ0R25FUXdiYVNzTHpXTkNkTnJMTXh3amZXWTVXRnpxUTNxNDdt?=
 =?utf-8?B?ekgwbGdHMlVWM0VDbE1EOTVwRzNyK2pid0Eva0sreEhRK3ZRMzBHVTNuQ1R1?=
 =?utf-8?B?TDZpci9xeWFydjZVdXR6K0h1WmN4Ujc0Q0xmeHdYWXFwMHIydWJ5ZXNCRkxx?=
 =?utf-8?B?WkFpdndkQkIxN2ljQ0pBY2c5dndpR1J4Y0c3ZWRQckI0UjgwVkVSQ2pqdHB1?=
 =?utf-8?B?NFdhRUhSOFB5UG1qZTJ6UnFXanNvT2lBcGt4TGlFdkNTSkJSUUxPbzBMUHNW?=
 =?utf-8?B?QmNsWXM3V0YvZGRxOVYvckRRSVcrdmprUlJzKzhLZjdIMzZDQmFKK2tkL0tT?=
 =?utf-8?Q?qYYC90Ue8glWlyCev1j4LZ4NQaSdOYLzuGbSdyj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d1cc4b-028b-4d1c-9114-08d941f7f11e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 10:05:40.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAZb0K6RW1AZPArWgnZJIPkXBUlA1oVzZQSVgS3LgUBkebpVj891jcg9phuU/4F1nNNNrAXTbHlVsulnqV4lrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5909
X-Proofpoint-ORIG-GUID: I4SkbaahsBZsB7RO6sfnBbGC25rTYrW8
X-Proofpoint-GUID: I4SkbaahsBZsB7RO6sfnBbGC25rTYrW8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_04:2021-07-06,2021-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50dGkgS2Vyw6RuZW4g
PGRldGVnckByYnguZW1haWw+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDgsIDIwMjEgMTE6NTQg
QU0NCj4gVG86IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEFudHRpIEtlcsOkbmVu
IDxkZXRlZ3JAcmJ4LmVtYWlsPjsgSGFubnUgSGFydGlrYWluZW4NCj4gPGhhbm51QGhydGsuaW4+
OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwNCj4gTWlj
aGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IFNhLCBOdW5vDQo+IDxOdW5vLlNh
QGFuYWxvZy5jb20+OyBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsNCj4gb3Bl
biBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djJdIGlpbzogYWRpczogc2V0IEdQSU8gcmVzZXQgcGluIGRpcmVjdGlvbg0KPiANCj4gU2V0IHJl
c2V0IHBpbiBkaXJlY3Rpb24gdG8gb3V0cHV0IGFzIHRoZSByZXNldCBwaW4gbmVlZHMgdG8gYmUg
YW4gYWN0aXZlDQo+IGxvdyBvdXRwdXQgcGluLg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBIYW5u
dSBIYXJ0aWthaW5lbiA8aGFubnVAaHJ0ay5pbj4NCj4gU2lnbmVkLW9mZi1ieTogSGFubnUgSGFy
dGlrYWluZW4gPGhhbm51QGhydGsuaW4+DQo+IFNpZ25lZC1vZmYtYnk6IEFudHRpIEtlcsOkbmVu
IDxkZXRlZ3JAcmJ4LmVtYWlsPg0KPiAtLS0NCj4gUmVtb3ZlZCB1bm5lY2Vzc2FyeSB0b2dnbGlu
ZyBvZiB0aGUgcGluIGFzIHJlcXVlc3RlZCBieSBMYXJzLVBldGVyLiBJDQo+IG1pc3NlZCBvdXQg
b24gdGhlIGNvbnZlcnNhdGlvbiwgYnV0IEkgYWdyZWUgdGhpcyBpcyBiZXR0ZXIuDQo+IA0KPiAg
ZHJpdmVycy9paW8vaW11L2FkaXMuYyB8IDMgKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
aW11L2FkaXMuYyBiL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMNCj4gaW5kZXggMzE5YjY0YjJmZDg4
Li5mOGI3ODM3ZDhiOGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2ltdS9hZGlzLmMNCj4g
KysrIGIvZHJpdmVycy9paW8vaW11L2FkaXMuYw0KPiBAQCAtNDE1LDEyICs0MTUsMTEgQEAgaW50
IF9fYWRpc19pbml0aWFsX3N0YXJ0dXAoc3RydWN0IGFkaXMgKmFkaXMpDQo+ICAJaW50IHJldDsN
Cj4gDQo+ICAJLyogY2hlY2sgaWYgdGhlIGRldmljZSBoYXMgcnN0IHBpbiBsb3cgKi8NCj4gLQln
cGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoJmFkaXMtPnNwaS0+ZGV2LCAicmVzZXQiLA0K
PiBHUElPRF9BU0lTKTsNCj4gKwlncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoJmFkaXMt
PnNwaS0+ZGV2LCAicmVzZXQiLA0KPiBHUElPRF9PVVRfSElHSCk7DQo+ICAJaWYgKElTX0VSUihn
cGlvKSkNCj4gIAkJcmV0dXJuIFBUUl9FUlIoZ3Bpbyk7DQo+IA0KPiAgCWlmIChncGlvKSB7DQo+
IC0JCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChncGlvLCAxKTsNCj4gIAkJbXNsZWVwKDEwKTsN
Cj4gIAkJLyogYnJpbmcgZGV2aWNlIG91dCBvZiByZXNldCAqLw0KPiAgCQlncGlvZF9zZXRfdmFs
dWVfY2Fuc2xlZXAoZ3BpbywgMCk7DQo+IC0tDQoNClJldmlld2VkLWJ5OiBOdW5vIFPDoSA8bnVu
by5zYUBhbmFsb2cuY29tPiANCg0KDQpUaGFua3MhDQoNCi0gTnVubyBTw6ENCg==
