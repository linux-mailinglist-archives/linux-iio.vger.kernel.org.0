Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710543EA060
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhHLIOp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 04:14:45 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:23456 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234573AbhHLIOp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 04:14:45 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C85V8S028063;
        Thu, 12 Aug 2021 04:14:07 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ac8k04849-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 04:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ2jUr6wqUd/HsBztxV4j7Vgf/AhZtgcD4Bg3Z2DTGh2do7Oe4XypCWSWRLXUb9DkySqPWmixzz5Jc50jMJRuqzmkrrX2gXMY/B9gVsy/HIXaSbpg19TI3vzkE0FelAHxe7X3NpguV4QBxxkgJTxDIST6Um/EAMQ68b9+zIMUN1Ywz0JIK3R5UHs/0qTWT+ReomBUlbjOWujNGNPrGywuEzeC9JgmsQaGIYNHHy3SP5VKyLX/qznmlNz/B0DqaISFG+FnykkW0xbCYX5DWA9EqLBGDFfIbgc4odHJ4n8sWAWE0Uxz5WCCrGNoQtT8EgfsxPfmwTLH/mDul54Bemnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKceWp14Xh23qWNaPRvxeVej5KB+knxYbKzZbUXOarw=;
 b=jpPlvukscxxh+PjnRQq8Ds7BZvHFNMrfF5pmG+MxNRcVMb8yHfpGBgNIUhMfa/JD3/WEWi5CIwzHY8DCKTtJm0WUTfrqZT7mSdMo7XoTs/wjloCazJww4ohPO89bglGE/p+D8OxVAXEYqem8wrDIyDkhGSxKALN0ZOjZ5+yKUkcfJHH7nICg584FPmUmtbCQdMWX+BVCdnaOVcQXESogdEqzVG9qYJhS7Ale+1FdrPNjIv3p4MCKAPAlFoFKcEIp/WIjUmja/7gCn02brmt/jBbBh0JGPvvaH+qvxV6v3bpyy5faAHvLfMB3ol6PLPJ2ZrbtId545/jpoSfr/Oz6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKceWp14Xh23qWNaPRvxeVej5KB+knxYbKzZbUXOarw=;
 b=Q/XZjOxJTitfcs2Jab46TwzcDYAdwYDME7F6gsnWdPiEuWRxsgXpu0duY/ZBAUPPbDB0v8xy2VlnM5Vyw4o/4Wbjyd6XC8bKkyHLMFMd2Uj+mYUuIwNwUJSm8N+uuOWyU3e5QSaH/ckS6DUAp1nNHeOMJwnsR4NsGfeu8nWP1bI=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6299.namprd03.prod.outlook.com (2603:10b6:510:d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 12 Aug
 2021 08:14:06 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 08:14:06 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: ad5770r: make devicetree property reading consistent
Thread-Topic: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Thread-Index: AQHXjoTpWS49/XePMUytpStcxW5zfKtud/2AgAD4urCAAANBAIAAEosw
Date:   Thu, 12 Aug 2021 08:14:05 +0000
Message-ID: <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811074827.21889-1-nuno.sa@analog.com>
 <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
In-Reply-To: <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5EQmtZMlJqTXpjdFptSTBOUzB4TVdWaUxUaGlPRFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEUXdaR05rWXpNNUxXWmlORFV0TVRGbFlpMDRZ?=
 =?utf-8?B?amcxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpFeE5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TXlNamsyTkRNME5qWXpORGMxSWlCb1BTSjRXVU5hTTFw?=
 =?utf-8?B?bWRHTlpPVmcyVUU1S1UyY3dObGh4WjBwUk5UQTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRjZkMFJWUkZWdkwxaEJWVlJhVkVNM1NYWjZSbnBTVG14TlRI?=
 =?utf-8?B?TnBMMDFZVFVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8651bc3c-da1d-4d6f-8808-08d95d692743
x-ms-traffictypediagnostic: PH0PR03MB6299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB629971FAD5DD55403831E2EF99F99@PH0PR03MB6299.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sd4UDYZ9xMptyGWWE9jllp3kd/BA399Tyk+XKXGUahFnR956geUNw5iUuODcGrqPEohKZgGVX6F4ORR6WfK6fcs+ZWUPBJj92XRqjrbc4NmLuAwOD6djOPOdNpKwvS/eMEW9a0uJvFLeJWPWXWkoXlUysQmO1bEzOeVVc9btOx2A3m68LPv/EDj1mOjIpbL/FXQl2LMWWyBBmwsadzs6bi/LGm5n3akQ4zqLhOZTQYh8Zgfh9wPqk8H8UGO7DjBlXOr/ZIJ5y55zcYaATl/W4bqz35dIu7qHz0c6Geu+gpu56ukyTJeccTrOMivxjNq94JhbKzvLvqSm9HlMxgHMj6FssfiSDI5+NUt8H8wAOcH26xA3t7F4YMNMviX5U0COZUEujDcPl2n+yALkfQhKBBmY7YiClCxH5cabVdizETIfXDfbNltWF54XKMtuaUdXjPVkZdf+yYj2cN94IqqUaK80L4Lb/oby4ATZ6yrj+eBRg9RcTmB4U1bNiZaEoo2YRHpt8s0aE0/RgtkYTQpnegwwTMLRIk1XhneCelT/MbgB//zBbbg1J1BWyNLpGiKWumu5rv0EWl7uo3ZvcfIL1UwBU1mF7VT2w6JD/I5qwpCOB73U2oDjE7uK2EMKvoPFJR4o64ZPCpq3i2jRtm53ib5RKfMl3qf1+4sd9oMVO7MV/RiihQgdeX2fyNNikJpo7gS5yZw5TviybUp++CqCrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(8936002)(478600001)(52536014)(316002)(38100700002)(54906003)(2906002)(33656002)(7696005)(53546011)(110136005)(6506007)(5660300002)(26005)(8676002)(122000001)(9686003)(186003)(71200400001)(55016002)(83380400001)(76116006)(66476007)(66556008)(66446008)(38070700005)(66946007)(86362001)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWovVUpsb21LWHZTSFVNZGx3V1NWS1dvTVdnc2pyVXE1T1JSZ2h3bnRzSUpr?=
 =?utf-8?B?ZlVPdU9UTE83dmNPV3hZZk9JVkRlbFcyd1dBOFltTFd0NHl3Ymp4TXdlTjRu?=
 =?utf-8?B?VnVCMEYwL1JWTVBtVlViODlrZUdQdm5ld0RwRS9SQmk2djdxY0pUTjJKWVhL?=
 =?utf-8?B?eWo1Y05zd3ZBbTlzQkwwdHhsUHJ3OHROUXFFV3JpRHhlNmxBbnp3a1hmRm5y?=
 =?utf-8?B?dWl5aW5BbXRZTjVXZEVDY1JRWWZkRTJrOUhPeVBnRkFPRUtZZnp2Q2R4UG9V?=
 =?utf-8?B?WUt3aGh3SHFCV1NEUDVjRGhzcDBDd0M2TmthMjZ0b1RONXZYVWE3ZVREWkRP?=
 =?utf-8?B?QVAyUEs1Mmxza01TM2Z0ZGw4L2J0d3U1NC9sb3Z3UEI5YmRIUWZHWkRUTER5?=
 =?utf-8?B?NDVvSVVoWEZIWEhqNVVIcEVsamVnNnZDSUJRdlpLMnE1a0NhWFFrUVZTWXJW?=
 =?utf-8?B?RHZiNml5ZGZOZ3B1QVlTZWdRZkh1ZGxVKzJXNHRkTkVpZDNBL0Y3dExVZG05?=
 =?utf-8?B?NHcxcUxwRENzZGQvMmRwNlJXR1d6V09DWEQza2lNUzhDQmVIaWRvVUdKTUwr?=
 =?utf-8?B?NmE2S2o3WFYxaGpNYXBJMkR6dDI2dzJNRm1jbTlQbXRsem1VdGJMRkJZemVv?=
 =?utf-8?B?RitUbkR5bkwvcjl5cWFHWGd4WHdaMDBxM01JRFFkSk5iVTlrMHR6WmxuaWpS?=
 =?utf-8?B?SWc1blN5djJPczl5Z1kxajFZdHlpcGlRWGhPNitCWitwOW9nSURJTlZBcUtn?=
 =?utf-8?B?ZzMzN1haYWI1cWtDU0ovMXI0YzVEVlpHSDV6WEFmcU51MHRwV1hVY1BzME1L?=
 =?utf-8?B?YXJNUVEwOEhGTjUxdEZNY0FOVUpwOUJRY3plZU8wbE1HRWs1OFhjMGtHWFo3?=
 =?utf-8?B?bEpTM1hwd0NLRDNMVHc3bjRUWHlmOHpUdk56c09HRmlvUHNYMVdySjB6dkRk?=
 =?utf-8?B?QXRtUVRMVnk0d1ZmS1hsbmFpVWdiS1RnZFFubUg0M2RKUlNVbGltb1l5OGUw?=
 =?utf-8?B?ejY5TVVZNC9HOUY1dTFtRFFpaTFTcFZCcHVJbXlQWmdiQVpUV1JjZEkxbEVw?=
 =?utf-8?B?a1hnS2ZVUUptTHlXb0FESGJCOFI1Q1lKMUtjK2twK1lmNkNWTnd0V0lRS2R4?=
 =?utf-8?B?R2o2RVVEaTB3QWluWmplV2xtMU9qWjVIRWd6b0FwN0x1VTRjdjlRN3NQNFJW?=
 =?utf-8?B?bWhvTWh1b01mWHBRcUR6czE4MlBWTlR1QzRJemY0TGVMbjZQUitsM1pkS2lk?=
 =?utf-8?B?YUdsTmIrQ2dpMkVMZXNHVXlNS2pST01WQmpXNWEveTgrc0hDWDNQSHFjM0lw?=
 =?utf-8?B?eUt5N0pRK2JUR2I1M0VRMVhzR1hjZDdoYUpQSGhHSk9lWUtKSURBRVhEdGlt?=
 =?utf-8?B?dkY0ZjJyNjU3b2t5K1pyb2hBT1hPME9QNUtYVkxyNTJSdTFFcWFQOEZOWFNZ?=
 =?utf-8?B?Tlk3NTdOVWg0Y0ZwMlFwMXVWK1dUREUyemgxWkVBcDQwdUQ4NG44QXcyMHpV?=
 =?utf-8?B?TVBLZkdVU0pGWmNWeFlNSGdJK2R0amtUcjBlWk90M1BtNjUyWVZnaVE2OGVp?=
 =?utf-8?B?ZnJCWUpoandxTXhyZkZQdUtaa04wZi9VTHh1RFBoYjlnV1dKVmlXWHlicFZw?=
 =?utf-8?B?bVBud01LOElDSnpOd2FCOURqSURBSURlY3A2anFkZnFDWTE4NmNPOGhrVzRz?=
 =?utf-8?B?NE10V1RmWm5BWjhXdE5RRUNpZ2UzU0h6MlVJZ0Z5b2J4UVdXZURNeXRpN3hv?=
 =?utf-8?Q?DOUAww1WTg/FfGKD4WpQp1htLBptLteRLlDsBax?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8651bc3c-da1d-4d6f-8808-08d95d692743
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 08:14:05.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc8ZO97ZXa4A5KwohFYQp2v3cu8e/tzZNgcIa1AS1CzSzRra5mOxZZCn6eC9pUmPA/8kFm402413yHvq/5r4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6299
X-Proofpoint-GUID: 6tWZyZasGTG2hZ7fwNAKEDt1Yf2583Db
X-Proofpoint-ORIG-GUID: 6tWZyZasGTG2hZ7fwNAKEDt1Yf2583Db
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_02:2021-08-11,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120053
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDEy
LCAyMDIxIDk6MDYgQU0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9u
DQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhl
bm5lcmljaEBhbmFsb2cuY29tPjsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28u
ZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlpbzogYWQ1NzcwcjogbWFrZSBkZXZpY2V0cmVl
IHByb3BlcnR5IHJlYWRpbmcNCj4gY29uc2lzdGVudA0KPiANCj4gDQo+IA0KPiBPbiBUaHVyc2Rh
eSwgQXVndXN0IDEyLCAyMDIxLCBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tDQo+IDxtYWls
dG86TnVuby5TYUBhbmFsb2cuY29tPiA+IHdyb3RlOg0KPiANCj4gDQo+IAk+IEZyb206IEFuZHkg
U2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbQ0KPiA8bWFpbHRvOmFuZHkuc2hl
dmNoZW5rb0BnbWFpbC5jb20+ID4NCj4gCT4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTEsIDIw
MjEgNjowNCBQTQ0KPiAJPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbQ0KPiA8bWFp
bHRvOk51bm8uU2FAYW5hbG9nLmNvbT4gPg0KPiAJPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9A
dmdlci5rZXJuZWwub3JnIDxtYWlsdG86bGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmc+ID47
IEpvbmF0aGFuIENhbWVyb24NCj4gCT4gPGppYzIzQGtlcm5lbC5vcmcgPG1haWx0bzpqaWMyM0Br
ZXJuZWwub3JnPiA+OyBIZW5uZXJpY2gsDQo+IE1pY2hhZWwNCj4gCT4gPE1pY2hhZWwuSGVubmVy
aWNoQGFuYWxvZy5jb20NCj4gPG1haWx0bzpNaWNoYWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPiA+
OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gCT4gPGxhcnNAbWV0YWZvby5kZSA8bWFpbHRvOmxhcnNA
bWV0YWZvby5kZT4gPg0KPiAJPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGFkNTc3MHI6IG1h
a2UgZGV2aWNldHJlZSBwcm9wZXJ0eQ0KPiByZWFkaW5nDQo+IAk+IGNvbnNpc3RlbnQNCj4gCT4N
Cj4gCT4gT24gV2VkLCBBdWcgMTEsIDIwMjEgYXQgMTA6NDYgQU0gTnVubyBTw6ENCj4gPG51bm8u
c2FAYW5hbG9nLmNvbSA8bWFpbHRvOm51bm8uc2FAYW5hbG9nLmNvbT4gPg0KPiAJPiB3cm90ZToN
Cj4gCT4gPg0KPiAJPiA+IFRoZSBiaW5kaW5ncyBmaWxlIGZvciB0aGlzIGRyaXZlciBpcyBkZWZp
bmluZyB0aGUgcHJvcGVydHkgYXMNCj4gJ3JlZycgYnV0DQo+IAk+ID4gdGhlIGRyaXZlciB3YXMg
cmVhZGluZyBpdCB3aXRoIHRoZSAnbnVtJyBuYW1lLiBUaGlzIHBhdGNoZXMNCj4gbWFrZXMNCj4g
CT4gdGhlDQo+IAk+DQo+IAk+ICJUaGlzIHBhdGNoZXMgbWFrZXMgdGhlLi4uIiAtLT4gIk1ha2Ug
dGhlLi4uIg0KPiAJPg0KPiAJPiA+IGRyaXZlciBjb25zaXN0ZW50IHdpdGggd2hhdCBpcyBkZWZp
bmVkIGluIHRoZSBiaW5kaW5ncy4NCj4gCT4NCj4gCT4gV2hpbGUgaXQgc2VlbXMgb2theSwgaXQg
bWF5IGJlIG5vdyBhIGNoaWNrZW4tZWdnIGlzc3VlDQo+IChzb21lYm9keQ0KPiAJPiBjcmVhdGVk
IGEgRFQgd2l0aCAibnVtIiBwcm9wZXJ0eSkuDQo+IAk+DQo+IA0KPiAJQXJnaGgsIEkgc2VlLiBX
ZWxsLCBtYXliZSBsZXQncyBnbyB0aGUgb3RoZXIgd2F5IGFyb3VuZCBhbmQNCj4gY2hhbmdlIHRo
ZQ0KPiAJYmluZGluZ3MgZG9jIHRvICdudW0nPw0KPiANCj4gDQo+IE5vdCBzdXJlLCBsaWtlIEkg
c2FpZCBpdOKAmXMgYSBjaGlja2VuLWVnZyBpc3N1ZS4gQ29uc3VsdCB3aXRoIFJvYiBwZXJoYXBz
Pw0KDQpIaSBSb2IsDQoNCkNvdWxkIHlvdSBnaXZlIHlvdXIgaW5wdXQgb24gdGhpcyBvbmU/DQoN
ClRoYW5rcyENCi0gTnVubyBTw6EgDQoNCg==
