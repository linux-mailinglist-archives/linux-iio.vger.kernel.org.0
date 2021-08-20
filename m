Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302903F2783
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhHTHSC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:18:02 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:61692 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238668AbhHTHSA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:18:00 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JKqghL022441;
        Fri, 20 Aug 2021 03:17:09 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ahka2npgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K03Iv21iESt3j4MYMz/hC2F51fGUUYR2GDg7M2UewvICoSf7oI5xU8vj5XxPU9S9igfBGcxGERC5W1wheFWQXTnT+ROabLpSb+ipTAMbyjGKHADLLHIaIwJx+DPXv/6TpOB5qEsLPQ/gGqaKDl6SLLJPK6SVume8/f3TwWkTW4v67ZudauF+PAs9RqP5F8op19BYu+xMAszGDTQn+qf2I04Vc6yfTVkeOtU2dsgABamCqdaYrKRBVKa7o4qXznHDROZLMk8CjVGXONHuk2k0cOmCdNwxvy2P3hD1vPLQr7L0ew7HliIJdXlnOmUNvuSONbq+PuDU0WyeRYoEyJnRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvU3b/6KzR4fvrYqYZwVyAGGGD8sJggM0DOZfo197J8=;
 b=ewASkKewdQPo0o4HL2YrWqEuNP6m+tMGeu2HEjN4jCSUF4Bed4HYjQqbX7ynQHB/jUKgjBYhqsoGsUXsfDqTI8GadyKYU5lTdT+HL3jrB4eE3QOvTCn4lIamJayZ4bST9jS2pVJCE6wfc6zCBj/kMg2D8krCaepMq2jmdYcgWAWXfs3ahZISxxTbiLD8exv3/rvMYPV5iHzk8Jy7XPv6Zrnd4o88gUetAAGq7S72DeZJKYZM/VEU/9a6xzM23D8NZ8ER22hgDbu1xKPwx5JYxBJk7F82XMIEfQecoFNOhYorBaX6Jmx/7BTjKLekcHaNkj611rYkZ7W3GCTVVQN+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvU3b/6KzR4fvrYqYZwVyAGGGD8sJggM0DOZfo197J8=;
 b=xHiqv6X/rlmx19D+xvwfAk6DHWMFVzzTrPK6tl2H+YIFfYARyHNGyh/hs4M2FqRWRLv/Wrb2QGLXzWuLzVX+SxE64XpAJYr2f3N2w4M4a3gdxxPj5GAd9RfhbG81tvRo1DICzcFWITjVnwEf2MmI5m9wj9heTCNzyYnCcdN3JRQ=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB3656.namprd03.prod.outlook.com (2603:10b6:a02:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 07:17:07 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:17:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/16] iio: adc: max1027: Explain better how the trigger
 state gets changed
Thread-Topic: [PATCH 08/16] iio: adc: max1027: Explain better how the trigger
 state gets changed
Thread-Index: AQHXlCHcxcHsCTx8jEC5LN1A8a+WRat7/mmA
Date:   Fri, 20 Aug 2021 07:17:07 +0000
Message-ID: <SJ0PR03MB63595C2F0C5FF796364008EF99C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-9-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-9-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE9XWXpZMlV4WmpJdE1ERTROaTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEbG1NMk5sTVdZMExUQXhPRFl0TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTVRjek5D?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGMwTWpZd05qWXlPREUwSWlCb1BTSm9hekZPYm1W?=
 =?utf-8?B?UlNXNVhabll6Um5WdlVscE5VaTlLV2t4eWMwazlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRmxOSEJXYUdzMVdGaEJWa012VEN0MlUwMHpOVXRWVERoMk5q?=
 =?utf-8?B?bEplbVpyYjBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 7ce14fb1-aaef-4a3d-8558-08d963aa84f3
x-ms-traffictypediagnostic: BYAPR03MB3656:
x-microsoft-antispam-prvs: <BYAPR03MB3656E1416C6D863CE1732CC099C19@BYAPR03MB3656.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOC2e0vEws6jQZt9Lcr3YhcLpwA1QfCRfvBC6x0RL6dULck3ABJgf6jzJL1+ex7xSS1y/ILzOBf9GZb/juuj3JN352/I5Mvp+gfDC4Ayev2IfnQrQ01MX4LS1OKT7C/9ityZUA92zj/Y0MJobKkAS01ajF+S8n2Zxhj2EjWEXy64GJ5wxkEmrMzulYTLwtvnI0ZkXxNcLqroCg6DPnbmoaqLigFQ5g7doRBiqBa4hJ1MSpjhlfFkbXvSSqJCBVXHBDR8guQFlRH6GWT19vySPswTQjr20S8INWNj2gr9NizYEHmUTgytnpWPxAxjxAy5NGDjvQS53sY8UB20Ub6gNF3Xg7hOrdPBqQRrTp8kj7eA/boLF4CFkfBn85CQQ5N5Yi83kuZ4lvPx7lDhKPEjdpdfL7WOXKYeNLpoF5tVRdNUiMjvxDPTa51u9I1mftmB3/wiWTkiMwCgB8umHnFy3SK4RFTTvADbiWfgqBKrQC5eXnGagKGZPMSWEkxc4uUMViKsaCDQZ515AZ28O4MbgpDd9SgbqFAaH5T/iVpn0jH53u4QVPLDWzfW6v/+ZPxdZu8rW9gJweewMFPeKRbuYFxUjopPBPrEvHhqmI5ycBO7RHyaOU/i+7pPjMVVSoBCc8h8mnd+OvYokF1+NV9xZCG8aJYbvImFKk6Y2Z+8/E9XOq+LxEQ8HI7Ws0rrVyv9a0JwHl/ak+r7/R5gXlDiTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(66946007)(478600001)(186003)(76116006)(53546011)(66476007)(6506007)(38100700002)(5660300002)(38070700005)(110136005)(122000001)(66446008)(64756008)(66556008)(54906003)(8676002)(316002)(4326008)(7696005)(52536014)(26005)(71200400001)(33656002)(8936002)(86362001)(2906002)(9686003)(55016002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDFIS3d4R2dlRW5EU3ZWOFFzUHAzb2Z2S2w4NVZnTUNXcjVIME5NVloyVmpz?=
 =?utf-8?B?OEhwRVBlVDZieVV3N3RFZ05BOHZjVHV1QkUyVFJWQ1FtdWhwbUJyV3B4WGFt?=
 =?utf-8?B?SEhBSmdRSWp6TEppRkRKeG1sVlAyODYzWTZBQ2F3Y2hVN2tIQm1QSzhqeVEy?=
 =?utf-8?B?cmd2RFE5Vk12VzRHaHczVlZhT1J6cDRpdDlIeVJUc1BmN2xKaVBnOWx5Kyti?=
 =?utf-8?B?Z1F6NVNTODRWQk5GRndRR2xFbG5LdjdwUnVwYkJDZ0VQU0Q2N3pldE9FM3Ri?=
 =?utf-8?B?YWJMQ0RZUEZFWU05UjJreitsOVVMWVFCdFVZRVpmbmdGdnMza1VQZXpucm9n?=
 =?utf-8?B?L2pCbEgzazdneGtMZllhdi8za0lZTzlNSzFVT3JwUWpPc3pVZG5lMGZtTElT?=
 =?utf-8?B?WTFQaVFkMHRZekt1OUNOeGwvcFVjTHJRWDZIMXZYbzUvUDVqd2J6VXdHeG1D?=
 =?utf-8?B?K21OOVFnQldMUWF6QS9BbzZOeWZHTmpYUzRVdERPVTMwY2hMVFQ0THFPN2Na?=
 =?utf-8?B?eVJwaVJnb0dYWStIYXV6MWJKbGF2SXMyekRUYWpFd1d1VDIzRkJaMG13czgw?=
 =?utf-8?B?bHRsTXYyL0FCUTJKZW1QRGFhVXhwdW1RMmM4M0RqRDRBSklCME9iVDhyczhL?=
 =?utf-8?B?ckZtMW1TbGlYdzVvY2xaZEpubXBPdGYxSjQvRXprK1ZFNi9ZNyt6STBCNWcr?=
 =?utf-8?B?Z0ZnUFpGbjE0UWtKY29MZHhJVWNZbjZzWWdRTmNtckF1amUzUUN4STJZK0tZ?=
 =?utf-8?B?MkVzUFVzWXBsU0ROQlpMbW5JVEVOS2c0UFBOOUtXMlRmQ3lRZHZ4VEhRdzlM?=
 =?utf-8?B?UTdlUUp4Y1NzT3V2Wlc0ZXZjR1FBLzB1Ylg3RlZiTXpjSW9SNndKbThzRVVi?=
 =?utf-8?B?OWMrLzlNM1l2Q2owb0h6blVSYm1VcnFCOUZZNHNKVEJ4UzBQTjdZVCtNaTdq?=
 =?utf-8?B?N1pDelZpWXJUUlZuRVI4R3lpcDhVbEk5Y1hnYlp3ZC9pQndIcE9EMkJ5UjhN?=
 =?utf-8?B?aWFydWZFSVlKbmdOQ0I3TUNQb3B1a3E5blQraTR2U0gralZqNmdLMjNNbGMx?=
 =?utf-8?B?WU5WRisvdXVhWDdkU0w2aGFaNGJSV2duNXRSSGdJYXBwSFcxTjZwRDUwWCtV?=
 =?utf-8?B?KytiODNYeXgwUW9ETmZON2pza2NBNWwyTnA5a005Y0lnZFluQWo5eENVR21E?=
 =?utf-8?B?bFJrcVVja0VPSDVJYURDemgrQjMvbGpjeWFrVVZqYTRYMWRxb3A5TTExMGFR?=
 =?utf-8?B?cEV2eE5KWUtLbTcyc29oZVFENm1VMlRsS0tjekMva0IzUnM4dUJQaTU3bk5q?=
 =?utf-8?B?cDFxeG9KRTYzNmwwR3ZLcVZmd0NNRUpFajdaejZUbDZmR2lBVit1MXJ2c09E?=
 =?utf-8?B?MENZTFNUZ3dkNkQrMDBlVys3clhWazQveVhTUFVuM214QXh6R1NHaWFGUFl5?=
 =?utf-8?B?VnNJNG9TRldiM21QbVpQMEJxMEhuOXl5bDFHbGlDaElOdzZPa2xveERlTVYw?=
 =?utf-8?B?UTNiZHRtV1lJU3o5cFRaOERQeFBjd2ExbHJKT0NmQVYwTXphMWJzaG1PbXd6?=
 =?utf-8?B?a3BkVjdBNnBHSzJRWFovYjRqcjlaQy91S0o0OE9HbTVicGR0S1V4THBQNjZ1?=
 =?utf-8?B?OFRLMVB6Ynpselc3REMrV0IwazdoeEw1dkNSa1N5Ri85ZlFvN1Q4OXZGdDB5?=
 =?utf-8?B?Y21oakdzYi9wUHNaOHFvUE1oR1pWQzBjT1ZhK1JWaCs3bWR0bjdBWHFTRnBU?=
 =?utf-8?Q?ROakxQNbA0gNKKD6/A=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce14fb1-aaef-4a3d-8558-08d963aa84f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:17:07.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzE3G0Wv+bEusu+Fv4HdPm8WjwrLxkjjHifiz12RcvNuG0sD9rNW5btoVRKoZ/HP6fBnWVeHUggYNkduvZIG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3656
X-Proofpoint-ORIG-GUID: farPTSvLIqjq8AFeOlvGDTn-qfi8rbqL
X-Proofpoint-GUID: farPTSvLIqjq8AFeOlvGDTn-qfi8rbqL
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
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDgvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBFeHBsYWluIGJldHRlciBob3cgdGhlDQo+IHRyaWdnZXIgc3Rh
dGUgZ2V0cyBjaGFuZ2VkDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBJdCBtYXkgYXBwZWFyIHN0
cmFuZ2UgdG8gY29uZmlndXJlIHRoZSB0cmlnZ2VyIHRvIHN0YXJ0IHVwb24gcmVnaXN0ZXINCj4g
d3JpdGUgd2hpbGUgd2Ugd2FudCB0byBkaXNhYmxlIHRoZSB0cmlnZ2VyLiBFeHBsYWluIHdoeSB3
ZSBkbyB0aGlzIGluDQo+IHRoZSBjb21tZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlxdWVs
IFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lp
by9hZGMvbWF4MTAyNy5jIHwgNyArKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L21heDEwMjcuYyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMNCj4gaW5kZXggNTk5MTRmY2Zk
MzIwLi40YTc4YzljYmMzMzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3
LmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiBAQCAtNDAxLDcgKzQwMSwx
MiBAQCBzdGF0aWMgaW50DQo+IG1heDEwMjdfc2V0X2NudnN0X3RyaWdnZXJfc3RhdGUoc3RydWN0
IGlpb190cmlnZ2VyICp0cmlnLCBib29sIHN0YXRlKQ0KPiAgCQlpZiAocmV0IDwgMCkNCj4gIAkJ
CXJldHVybiByZXQ7DQo+ICAJfSBlbHNlIHsNCj4gLQkJLyogU3RhcnQgYWNxdWlzaXRpb24gb24g
Y29udmVyc2lvbiByZWdpc3RlciB3cml0ZSAqLw0KPiArCQkvKg0KPiArCQkgKiBTdGFydCBhY3F1
aXNpdGlvbiBvbiBjb252ZXJzaW9uIHJlZ2lzdGVyIHdyaXRlLCB3aGljaA0KPiArCQkgKiBiYXNp
Y2FsbHkgZGlzYWJsZXMgdHJpZ2dlcmluZyBjb252ZXJzaW9ucyB1cG9uIGNudnN0DQo+IGNoYW5n
ZXMNCj4gKwkJICogYW5kIHRodXMgaGFzIHRoZSBlZmZlY3Qgb2YgZGlzYWJsaW5nIHRoZSBleHRl
cm5hbA0KPiBoYXJkd2FyZQ0KPiArCQkgKiB0cmlnZ2VyLg0KPiArCQkgKi8NCj4gIAkJcmV0ID0g
bWF4MTAyN19jb25maWd1cmVfdHJpZ2dlcihpbmRpb19kZXYpOw0KPiAgCQlpZiAocmV0KQ0KPiAg
CQkJcmV0dXJuIHJldDsNCj4gLS0NCj4gMi4yNy4wDQoNClJldmlld2VkLWJ5OiBOdW5vIFPDoSA8
bnVuby5zYUBhbmFsb2cuY29tPg0KDQo=
