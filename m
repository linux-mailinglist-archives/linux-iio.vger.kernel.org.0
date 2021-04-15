Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B4C3603C4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 09:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhDOH5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 03:57:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13428 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhDOH5D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 03:57:03 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13F7uP86024290;
        Thu, 15 Apr 2021 03:56:25 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00128a01.pphosted.com with ESMTP id 37vyd214de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 03:56:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8afB6WN73oc8Ds5W+QHLRYB4PT3Srg4/Xr3POGACnfVcOB9T0iXgrIYmQLN6R74IcgCn3zkhKgm2i5BrWP0EOBlrhv9aEi4LVywheGCeVVW19vXBSU1vpR8cBXqGJdGLanzE7k/tsCdj8VoKn7SjjnNxpKpet2dWkI2EdLizf3o0iIYC+j/DzThFAFh+b1KzPCJXItmtOHwWEso4xcQzyxUs7ZphmlTm/jDHXVSUbqkGVvT+ial3yedWOcotqacgirWcqZM2nAcpTFtG/MSkePxCYwDXkDA2GuyrhWRl6BapLBeVflPKyVc++D+wd9+8Mhv14IpaU67u+5Sbyy9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saKi2keF4jBDkgpOd6otOe2iVVqFk/stGXyN/YuPZVo=;
 b=EzZELc8VqWJClzhrcuJV1Oi+YKUXSdmxfTKyEB+pmVTvVlPOT0h1qwK5SFwF2+8DbWypdWxvPjhE0urcdGaGF+UkwAKTCpMtq3bqXjjW2OH/W+4KscMYCQtJTdqNfBiXKlf8Ejgu6C8mPFJEUr+qfLu2gggFM/LU0SUCnupZWW9E20zKSr76MNK9bnhhfbp6E9xEOtBqlTCeAnONtzMOKtA57RzCLEkAegL4ByCtPmTLCXi/vucheUAP3R08SPDn1wx/NPQeAq7RS5VWkPTpIRC+FCs1sXgAff2X8m9CWcHyjQ1vIsb/viks5HbSeyVMZQocemlPDR7ADd0Kz5O7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saKi2keF4jBDkgpOd6otOe2iVVqFk/stGXyN/YuPZVo=;
 b=y04ra0C9vedxlE0RGMipNur5V4z8JQcpi+15bn8yTiWnL0kpNGyceBlNd4aVVT/NTuFYd5eKyvqL0WjWbfaUVNPGcr11iM/CBBLlqqskqOYbfFrgaHB0YrSJeHbLUBDzUBfS0Vgg2hac+xEupZ1dpe0zsXuQ0fT4TlDRyfO1/RM=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB3239.namprd03.prod.outlook.com (2603:10b6:910:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Thu, 15 Apr
 2021 07:56:18 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4020.022; Thu, 15 Apr 2021
 07:56:18 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 6/7] iio: adis_buffer: don't push data to buffers on
 failure
Thread-Topic: [PATCH 6/7] iio: adis_buffer: don't push data to buffers on
 failure
Thread-Index: AQHXMFb1PhuQbHKdHkuwJevjJZioHqqzoLuAgAGYAHA=
Date:   Thu, 15 Apr 2021 07:56:18 +0000
Message-ID: <CY4PR03MB31120D612F5BF81670DF3B20994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
 <20210413112105.69458-7-nuno.sa@analog.com>
 <CA+U=DsrsbZ_jGcXuo=mMXHs10Um5uvk4rsgs5BCWHNCZVgAdeA@mail.gmail.com>
In-Reply-To: <CA+U=DsrsbZ_jGcXuo=mMXHs10Um5uvk4rsgs5BCWHNCZVgAdeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1HUmxOemRoWWprdE9XUmpNQzB4TVdWaUxUaGlNMkV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEQmtaVGMzWVdKaUxUbGtZekF0TVRGbFlpMDRZ?=
 =?utf-8?B?ak5oTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRVMU1T?=
 =?utf-8?B?SWdkRDBpTVRNeU5qSTVORFk1TnpZM05qYzJOalE0SWlCb1BTSlhaR0ZLTjBw?=
 =?utf-8?B?MVlWbDRTVVZMWkZWcFJIRXhWV0p4UVZKNGJHYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVUnZUV3RFVVhwRVNGaEJXVlZsYTFwSlFtRjNlSFpvVWpaU2Ey?=
 =?utf-8?B?ZEdja1JIT0VaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cfb9b0d-466e-4437-5093-08d8ffe3f39a
x-ms-traffictypediagnostic: CY4PR03MB3239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB32399493F1F03498D4225A68994D9@CY4PR03MB3239.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYds+wx2mDSolIS1QqExZ/vMMTta55/ItrrErfUwQFkZAINPp9Kp5vFZc5rCZMiuCN1Ozqqzub0lktb2M/3n4264/PTD22wTp0yNCFj6X5VeoeDQRgE3eHpMCtzOXAu6Th5loSJ02n2POrj5V+rsWlyYmpw9P+IwkUg8OeKJJllyxudhomHJSvfL5MACDJP3MOhQ8elGu/arlWYCnghEtYdzPHwlquFG53Mu3ojDMrailZmroUjsP7z3HADTyCdjdX4U7LaD3xLljSruRs8oEWmqQBJlWnvmUmH0InEDzOYrJhLBpSamLqR/+92aKstg2FmiVXHaoN3/Lg2gHkTfMa/9mexUZzsJBAxHYA8cc9lpXRgoKSPiEF1JYphOuIU/Rv5fTOc1ByLwPvBN70DeQOMbm+vS7r2jeQbXPugwbHxibTKvoNSK9mNxhsHqlyROEIU4U9dswyWQZgVOiHLuCMYxAb1LUTMnjucqgOxJnAR6M+V+TXhWDOqaBnSJq+zfVfOWE+OfQITQH0XqQjk9XDFCAEU7lAgqcUD8DiVIVIJNntNwnf7CRjNY78TsWHSM0bt/R77szDtNnTacDvpWH4NQZWO4gGSNQ4SSweRvFdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(8676002)(53546011)(6506007)(478600001)(26005)(122000001)(186003)(33656002)(8936002)(71200400001)(66446008)(66556008)(83380400001)(66476007)(4326008)(9686003)(52536014)(7696005)(2906002)(66946007)(86362001)(54906003)(64756008)(76116006)(5660300002)(316002)(6916009)(55016002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dDRxc09WU0J0V0ZLbXk1ZXpvVE0vUWVuZzhDNHNzcGF4YW1HSTlyTHFLWjFX?=
 =?utf-8?B?MHYzbHRkUmw1L0lxZmNKcXpFUEJoSFFuWFNjTVFEOFFkbDBDQ1lNbkFnN1pO?=
 =?utf-8?B?c2NqRktxMi81bGx5aFJsdXBWVUs4dVlBVXd4MTljT1psUEhyZmprbHFOVGdR?=
 =?utf-8?B?VnhhUDFLZm4xWFE3cnkrcmVlUFo1Ry9WZUpCT1lpd3lKcHF2d2kzUzFnZzhK?=
 =?utf-8?B?WG5NeEFpSzkxSm0yT2lyaHlVbDZZdW5ZOERLZHlCYmJRUDdXbUVRdXZzeDlO?=
 =?utf-8?B?ZU1YdkhPQXdlNXlnbzBGMXZpdzVKRHkwdE5DODVlK0Z6c1R3N1RvU3N5WFRr?=
 =?utf-8?B?WjhwRDVvdXNPNElVcE43LzhYdkNYUVREQ0FUK005VWQySHFuclJhNExCd09m?=
 =?utf-8?B?QUQySW5lT0JJakZXb1FnbktRQ2F2Rm9RVFNObFRUWkpvOGNWczh5Z0htTTRY?=
 =?utf-8?B?Tk9pRmhrNnMzWnhqZGp0YUhDL1Nva0ZsSDRUV0N6ZGpPZFQyRlpjTGQ0dThE?=
 =?utf-8?B?d3QxTS9zczE3Y0ZBY083NFc1SStBTkVPZlJGQW1DVjg3bCtoMnE0UndvWHdp?=
 =?utf-8?B?dnBaL01WbG5RUEpaM1h3QTdEMkhxdGllWXJheXJvaGx3TzBNNUoxc3pVTVR3?=
 =?utf-8?B?bTVrYTdxSmdUSTFhN2dBSnRYZzVDdkNPUllScjg1V3JwRVByeVJ5dDA3U3F5?=
 =?utf-8?B?TDNMRnE1U3h1OVM3VlNLd3NrMEJuS05MNEFjN3p5OGNkOS9yS1NvN1FGL1Av?=
 =?utf-8?B?N096TytGZE9iSmprMERuNUZySnByM1hyZU1UdFBlekJuWHd6NFFFbG1VSFdk?=
 =?utf-8?B?bjFjaG1aN1ZTQU1LQUIvcHZIb1N4elJmQS9XT016MjRLM01PS0JycGRJUkI1?=
 =?utf-8?B?TDZ2WjI1ZE1JTEIzeWV1UlFPVjYyZDlZYjB0THB0MFNyT2RFT055OUNBdy9K?=
 =?utf-8?B?dXRYdUo1VXRKQW5rSE01RnNrK0pLaVBOUlBOTy9kT2hGci9ZQkVwWGpYRUV5?=
 =?utf-8?B?WksrZ3lxNE9qZmJPeW5vaksxWGxobEJQQXpWdnNVcitDQ2V4Y0tCQTJYSDV1?=
 =?utf-8?B?Nm83QURZK3hTS3BYTDVkanA0YmlrL0tGL2FaNE4vVllJNGw2RG12TzdhS2xa?=
 =?utf-8?B?MnRVYmpDR29oYjZOMEIyc292NFpMZTBHankzYlczRE54K3ZTQzAwZ2JMMW1y?=
 =?utf-8?B?aG5SNkFHM1pCOXdLSkk0VG5DQStjOFJ5aXVxUjNjeThJRHpYTng3Y01PSEp4?=
 =?utf-8?B?RXo4K090L3ZxeERzZWg5ek1nRkRybkt1d2xOVzF4OGw2cjU0RWY2d2VQNENK?=
 =?utf-8?B?a0x6cys1SXM4cmJIOEJYRU5xWWowaTNCUjJwRGFlclR2S2JlWWhnenlBSXVB?=
 =?utf-8?B?SU5xSlUzelBoYjhoU3hjc3M2aXlYTTF1U2RrZEpvemhsd0RJQ2RocXd6Vmxm?=
 =?utf-8?B?UHNiZFByVGJWSFovd1ptSUdobWUrdmtqYlgxQzcxTURYTEQxd1lOakRCMFBJ?=
 =?utf-8?B?azhReGhmc2FjMWFBQ1F6TDBMQkkycnZUU1B0bmYvSzE1Y3BhV21VYmYrVE1B?=
 =?utf-8?B?V2w2MWplT2gwZ2l5QWhoUGdBL1pYd0pabmJDWFRMTnFYTVZCdFNjNGVGOXoz?=
 =?utf-8?B?dUo3cUFWZXNTY2E2RTNCNTlSZmJyc2ZqbFdQekJmRmx0Q1pVejA5aExLNFY5?=
 =?utf-8?B?dVJGeDNha3lHUER2TmhESGRlVS9PeElGdVVWemVyMnlTbDRiSTJMdVhWaWE3?=
 =?utf-8?Q?Li7+jF/knr3U2Z4zYI0SDKscInnS7ra1jsjOtnc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfb9b0d-466e-4437-5093-08d8ffe3f39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 07:56:18.1682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tyb2KFwe3NGOfR0ZX/Ko+ThFzB7lsoCiCX6anMYpWszFtUNk7v1vTK5hYC9k6MkoCnuPeYakZZub44zs1E/xyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3239
X-Proofpoint-GUID: QDtBtt3Q-P6fdusQi7eCgejRSqWeJEmX
X-Proofpoint-ORIG-GUID: QDtBtt3Q-P6fdusQi7eCgejRSqWeJEmX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_03:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhcmRlbGVhbmFsZXhAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE0
LCAyMDIxIDk6MzUgQU0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENj
OiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBDYW1lcm9u
DQo+IDxqaWMyM0BrZXJuZWwub3JnPjsgSGVubmVyaWNoLCBNaWNoYWVsDQo+IDxNaWNoYWVsLkhl
bm5lcmljaEBhbmFsb2cuY29tPjsgTGFycy1QZXRlciBDbGF1c2VuDQo+IDxsYXJzQG1ldGFmb28u
ZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNi83XSBpaW86IGFkaXNfYnVmZmVyOiBkb24ndCBw
dXNoIGRhdGEgdG8gYnVmZmVycyBvbg0KPiBmYWlsdXJlDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0K
PiBPbiBUdWUsIEFwciAxMywgMjAyMSBhdCA1OjQ1IFBNIE51bm8gU2EgPG51bm8uc2FAYW5hbG9n
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGVyZSdzIG5vIHBvaW50IGluIHB1c2hpbmcgZGF0
YSB0byBJSU8gYnVmZmVycyBpbiBjYXNlICdzcGlfc3luYygpJw0KPiA+IGZhaWxzLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYyB8IDUgKysrLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiBiL2RyaXZlcnMvaWlvL2lt
dS9hZGlzX2J1ZmZlci5jDQo+ID4gaW5kZXggN2FiMTVjMDg4ODlmLi43Mzc5MGI3MTEwMmIgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8vaW11L2FkaXNfYnVmZmVyLmMNCj4gPiArKysgYi9k
cml2ZXJzL2lpby9pbXUvYWRpc19idWZmZXIuYw0KPiA+IEBAIC0xNDYsOSArMTQ2LDEwIEBAIHN0
YXRpYyBpcnFyZXR1cm5fdCBhZGlzX3RyaWdnZXJfaGFuZGxlcihpbnQNCj4gaXJxLCB2b2lkICpw
KQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICByZXQgPSBzcGlfc3luYyhhZGlzLT5z
cGksICZhZGlzLT5tc2cpOw0KPiA+IC0gICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgIGlmIChy
ZXQpIHsNCj4gPiAgICAgICAgICAgICAgICAgZGV2X2VycigmYWRpcy0+c3BpLT5kZXYsICJGYWls
ZWQgdG8gcmVhZCBkYXRhOiAlZCIsIHJldCk7DQo+ID4gLQ0KPiA+ICsgICAgICAgICAgICAgICBn
b3RvIGlycV9kb25lOw0KPiA+ICsgICAgICAgfQ0KPiANCj4gVGhpcyBhbHNvIGhhcyBzb21lIGlz
c3VlIHdpdGggbm90IHVubG9ja2luZyB0aGUgJmFkaXMtPnN0YXRlX2xvY2suDQoNCkRpdHRvIDpm
YWNlcGFsbToNCg0KVGhhbmtzIQ0KDQoNCg==
