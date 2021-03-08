Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0098330AD3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 11:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhCHKHo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 05:07:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55218 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231610AbhCHKHT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 05:07:19 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128A6kCT025965;
        Mon, 8 Mar 2021 05:07:07 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 3744fbc81p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 05:07:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHzNjqg9R7SlJ4AK+3VOyk66BPgBekLEdfDlo1B9tu2AHJ+tUOaYHJOnpfPboyODXcYACGnHKfZU0CXapSe+SitZJzxKZ2ShcR5pAkwGFdv3G5ra2PPC46EfvGyfH2qP5fenWLtHcSwk6oQPE406ESXOpGxPAOn/TxI2pMsI4LNE2jgfWxEvv6YCndqZEJbwhzYtXzVohLGkm6jFfur/LGaJ8SCq0xh5UBwhGLlKxMeuCEqGyJMg75ui+Vd1842QsA7URFML8H7q+othMZ1xl3xyOXOWJRbG3r31mcqoI6YaurihcXdawAj/LpOvw+sAAq2kDSmYfPsIjCNq/zeklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61kqVYEpLu2ZCQbeHBvXVEUk3JQmq7GVVaqAi/tfIk0=;
 b=BCDxVf2oFmXLC7XRPcX8pm4TqdRDpZycRHGE9XHndyRcYfjFOUDAfrvV79WR8e5/+l8Xn2pNTiU5SQODDqQRAN7V+HCk8qKaIH402YbHCibCdfMM/sm1ZVvKuN6rq4KWflv2sxLJr3kAdSWIS12n1Y6A4qsMtVBiHovOUUDpmP1vJ4Laniu1R85ozJmuE0Hityxg83fd6P4EWjfkBBWZAO8whLlUqSXRYYWtWvPR9BRLViT2V8nWQfsmeM16VQqrHR1It1vtlEsJyu3XQOqCwjJxqQHnvJ42+sKhpTYrRLeylCKOaAi2sFh/P0f/JY2XQLeNKzJADGJ/AtZMPGOpxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61kqVYEpLu2ZCQbeHBvXVEUk3JQmq7GVVaqAi/tfIk0=;
 b=0bOSAmPv3K8DFB0wuKuMU+AVlGkqU4LLt5l5hUra3ehEGaaMJujRGf9dr8AhNaZ0LRjVy/tMKX5XmHBQJw1EGtjW+1LhmZmvCCkdjjyLyJY2hMtZkFI6iyqMLc+CBgCrsi/fftmUcCptUodsQtWil41WWtzxNhTMLXf3jjicBbI=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY4PR03MB2871.namprd03.prod.outlook.com (2603:10b6:903:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 10:07:05 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::b439:cc16:d1ec:1c5e%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 10:07:05 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC:     "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v3 0/6] iio: Add output buffer support
Thread-Topic: [PATCH v3 0/6] iio: Add output buffer support
Thread-Index: AQHXBrxjq9QBbWMRtka/kQD4wV/AUapihP4AgBKolACAAiL4gIACpXPg
Date:   Mon, 8 Mar 2021 10:07:05 +0000
Message-ID: <CY4PR03MB26318300B44C07A5890067B499939@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
        <20210221120106.00ae1078@archlinux>
        <BN8PR03MB497724AAAFA43E6555554DC98E969@BN8PR03MB4977.namprd03.prod.outlook.com>
 <20210306173449.06f2f32b@archlinux>
In-Reply-To: <20210306173449.06f2f32b@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1EVTNZbUpoWmpFdE4yWm1OaTB4TVdWaUxUaGlNalF0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEQTFOMkppWVdZeUxUZG1aall0TVRGbFlpMDRZ?=
 =?utf-8?B?akkwTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRrd01D?=
 =?utf-8?B?SWdkRDBpTVRNeU5UazJOekUyTWpJMU56Z3pOakExSWlCb1BTSjJVazFDY3pG?=
 =?utf-8?B?ek1sQmxaR3BXUVdocVJ5dFJlR3A2TjJsa2JVMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRXhXbmRZU2tGb1ZGaEJVbTVhVFdrclNVaHJObTVIWkd0NVRE?=
 =?utf-8?B?Um5aVlJ4WTBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:24bd:6c01:a1f5:689b:a546:7acf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d94b210-9d50-4021-e60d-08d8e219ed08
x-ms-traffictypediagnostic: CY4PR03MB2871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB2871A218E2B71629687F51B699939@CY4PR03MB2871.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBS4rQ6o9hVFbXdBY2zq99JiBLKxbz5SaEOwqVRsDrPaP8Y6owl9CJOYYjV5kKttnRVs3js70QnVUvkkY5yQ/rquWHbDlrvAIpFVfyktIem5IFpRa2AMx736Wkop2+7bKXT3RnP7gkk0gz/HaT70FSGmrqmAqpb29a8PzbrhLcnc/wvElziSdVcc3xyQNS7qRq270DNF2IIhIRbiRtjQ2JU6gQ6Jp/2YF+hZV3RY+QQ3NGNHXYAphf5cT6nExMa6boLNn5gtxZzr+G1JeJ0N1yzmgDe39vduuDYLbXNKs5tFpPNix/SlKjlnJz3lzBSWVZEXbjkf44O46t1uVOC0Efgf/uUXr+QjF45DkPOVRW59ThXxnqp6E7lkVu8XjE3Pd87pUP7fkLdmkcoDoXKNEzFCiviCNAb/LCnwwPkfQ9eKaQ4Ln7uDSSuuC8KIjgiqTphL3Urk0zPtMJG+UbAV0DsxjjUcU8tN+H+M01bwDhkWj2Gbn7JE9PFj7XyYmpEPuBagiXymRGjOoPNTLU4Zmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(9686003)(83380400001)(55016002)(71200400001)(7696005)(86362001)(76116006)(2906002)(66946007)(64756008)(66446008)(66476007)(5660300002)(52536014)(110136005)(54906003)(66556008)(316002)(478600001)(6506007)(4326008)(8676002)(8936002)(53546011)(6636002)(186003)(33656002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T1NLU2tqSlhRcDExZWhvTlY4OEk0TE84ZENsbXlYU2NROXJqeEJpSStXMGky?=
 =?utf-8?B?Y0lGSW5XWEtLY1dVRFFnaVVzWEtuVkxFRk9ubEJKc0N4bWlUWGVBTE9CWkJZ?=
 =?utf-8?B?OGN1SVlaWWpWdlZtMlpTcHdxeU9DcWZoNWd1ajJhdGUzbG9sOElySEtwM1BG?=
 =?utf-8?B?WWl2YndvYTlzSVJFTVJyWTh1Vit4US85MG9yMnhYQ3V6TjdNNXZnejFoMFEr?=
 =?utf-8?B?MU80NGo1Wmc3RW5TdW4rZGFEbGhBVmNtdUR1cXBySitFT044RlE5eTVSN2xM?=
 =?utf-8?B?TUtuZVI3V1JRa2xzUHh4NG9aUEQyRFNVbmxxRTFnWlZWdTd1RXhiczhzRTdw?=
 =?utf-8?B?VzBScXVqbnNNemFmQVdCU21lcDVNQ21zaWp3dGxQam9Fd2NmSFd6ZWlsWVB4?=
 =?utf-8?B?SVBCYlovalZDQnczZnhOK3F4d1QzZkk0VGJBZ1c3a0FuTkZUcmg1eEI5ODJm?=
 =?utf-8?B?a2lnZDFZNEFWb29MK1BHZURHUzNnNGh0VGZoWkFqeW5vblJlRGNrSDhtaWxn?=
 =?utf-8?B?KzZ3a2xHaTlzR1JEUGt5N0xNMFpMK2tZaHUvREg0ZlVCU2lvUTFudjNrUmM3?=
 =?utf-8?B?dTFYd25LaTY2dXc2cUlPc1JLSDVsMEpEekFpV21wdVVhaHl4K2Z3S09TY0ZM?=
 =?utf-8?B?SnQxbU5ndXhNbS9JVUNLUVduYldlYVB6V3hFaHBFQ015NGFMUzFDalJEUFdn?=
 =?utf-8?B?K0FoOW03Uk1ZcmExSDZjZzN4R0NpRmg0NEtyS2doZlVTQW5BQndQNXZ3V3Nr?=
 =?utf-8?B?cHVCNVZ2dHJqUzFSZldkTXVhdzVqMHAzNHJad1hzb2NtOVh0c1NQL1FidFdw?=
 =?utf-8?B?Q1hCR08wbXhOMnlTL1ZUaUhhV3g1TDNlT0xiZW05VDJVQWNzcnFPUkRvUHhZ?=
 =?utf-8?B?Wk1yTTNYS3B5N1ppdEprcTZrcy9WNmF4dDZjS2k0NndrNUVFNGRDTFVQaDRN?=
 =?utf-8?B?ZVhmdmlkMXRQWW5SVkE4dHArLzd2d2REVSttbUhVYldjUTRBaUVJYk1lY1pn?=
 =?utf-8?B?cFJPOTc2ZGd1T2JlNWNHZ1dNQUdCNVlGcTI5aVJJcktYcDZwektTZy9GcU9B?=
 =?utf-8?B?dllOaHVIWSs2YW50NCttK0VGdGtmVHdlV0g4N3N5Q3F2THVIekJBZkRFRzFT?=
 =?utf-8?B?UnBMcW1FRTZIQk9yR3JOZy9ybkVtZU1ZWHFPN2d4V1huRmQyQVhzdG5CSkp6?=
 =?utf-8?B?YStRZGRROGVNZGVBQUdLamRsTU5lekNDYnhwbjJqN1c4TVk5QlhIcHYzeEgz?=
 =?utf-8?B?ZXFGVXFEaG1TeXNpUE56NmhUL3JBcjJrRVQzWTZ2Z2ZzVkRtY0Z6bSt5eldD?=
 =?utf-8?B?cEVzUE9pOUV0VTBiTWFVYWl1K05QRXVhY0xHbmpEeUFWUTBpTFNXcEVjc0tV?=
 =?utf-8?B?RDlqdStwaGsyQkZyZEZLMUt5dlFpWWlSVHZPRmUvcWFqeE5ZTlYrZ0w2SnpC?=
 =?utf-8?B?MkNSYlJQUTdKLzQ3ZDJGUWs4VCtCejQyTE5pQVpXSjl0eU9LV291TnJQb3Bq?=
 =?utf-8?B?YXk3NStrWFVBeXBTeG0vbkUwZEk0U1V5WWdtVUJqaytmVHkwZWNuNTVQekhn?=
 =?utf-8?B?NVJLeHViaXZLNTBsYnlGbWVHMVd2K1VIZjZPWDBYUm5oVEdVRVVPU2IzaUsv?=
 =?utf-8?B?UHVHZWRYSWFJU3hmRHl5bjNXYUlyNGZzc0k1ak9MdEdONG1QN2dNaXRqNjlQ?=
 =?utf-8?B?U2ZwdDkvOTRqY2RHUXZHTW5DRkxMWnBPOTEvYk5zMVVFSHJhYTFwQ1pDL01u?=
 =?utf-8?B?Zm40SUlHd3p4VlJDWG05VWthMFZ1ZXRUMFJCSWp5RDlucm9QSWZqazlDNHdw?=
 =?utf-8?Q?84Zwn9glDXuziXDVfOI4pjWlHEmiUUYRJltn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d94b210-9d50-4021-e60d-08d8e219ed08
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 10:07:05.0628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: if6xCsEr8hJjH3hM8vzlPoqwQe6G1SNoJxdP8RwQANmVZCkyu+NWMG1YUQGJ7SrmRoZWe5uXdb0L4AqIx3p4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2871
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_04:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24g
PGppYzIzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCA2LCAyMDIxIDY6MzUg
UE0NCj4gVG86IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNv
bT4NCj4gQ2M6IHp6enpBcmRlbGVhbiwgenp6ekFsZXhhbmRydSA8YWxleGFuZHJ1LkFyZGVsZWFu
QGFuYWxvZy5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9A
dmdlci5rZXJuZWwub3JnOw0KPiBsYXJzQG1ldGFmb28uZGU7IFNhLCBOdW5vIDxOdW5vLlNhQGFu
YWxvZy5jb20+OyBCb2dkYW4sIERyYWdvcw0KPiA8RHJhZ29zLkJvZ2RhbkBhbmFsb2cuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gaWlvOiBBZGQgb3V0cHV0IGJ1ZmZlciBzdXBw
b3J0DQo+IA0KPiBPbiBGcmksIDUgTWFyIDIwMjEgMDg6NTc6MDggKzAwMDANCj4gIkhlbm5lcmlj
aCwgTWljaGFlbCIgPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4g
PiBIaSBKb25hdGhhbiBhbmQgb3RoZXJzLA0KPiA+DQo+ID4gV2l0aCBvdXRwdXQvZGFjIGJ1ZmZl
ciBzdXBwb3J0IHRoZSBzZW1hbnRpY3Mgb2YgdGhlIHNjYW5fZWxlbWVudA0KPiB0eXBlIG1heSBj
aGFuZ2UuDQo+ID4NCj4gPiBUb2RheSB0aGUgRm9ybWF0IGlzIFtiZXxsZV06W3N8dV1iaXRzL3N0
b3JhZ2ViaXRzWHJlcGVhdFs+PnNoaWZ0XS4NCj4gPg0KPiA+IFdoaWxlIHNoaWZ0IChpZiBzcGVj
aWZpZWQpIGlzIHRoZSBzaGlmdCB0aGF0IG5lZWRzIHRvIGJlIGFwcGxpZWQgcHJpb3IgdG8NCj4g
bWFza2luZyBvdXQgdW51c2VkIGJpdHMuDQo+ID4NCj4gPiBTbyBmYXIgc28gZ29vZCBhbmQgaXQg
c291bmRzIHVuaXZlcnNhbC4NCj4gPg0KPiA+IEhvd2V2ZXIsIHdlIHVzZSB0aGUgcmlnaHQgc2hp
ZnQgKG9wZXJhdG9yKSBmb3IgdGhhdCwgd2hpY2ggbWFrZXMNCj4gc2Vuc2UgZm9yIGNhcHR1cmUg
ZGV2aWNlcy4NCj4gPiBGb3Igb3V0cHV0IGRldmljZXMgdGhlIG1vcmUgbG9naWNhbCBvcGVyYXRv
ciB3b3VsZCBiZSB0aGUgbGVmdCBzaGlmdC4NCj4gPg0KPiA+IEknbSBub3QgcHJvcG9zaW5nIGEg
bmV3IEZvcm1hdCBoZXJlLiBJIGp1c3Qgd2FudCB0byBnZXQgc29tZQ0KPiBhZ3JlZW1lbnQgdGhh
dCBmb3IgYW4gb3V0cHV0IGRldmljZQ0KPiA+DQo+ID4gbGU6czEyLzE2Pj40DQo+ID4NCj4gPiBp
cyB1bmRlcnN0b29kIGFzIGEgbGVmdCBzaGlmdCBvZiA0LCBzaW5jZSB0aGUgdW51c2VkIGJpdHMg
YXJlIHRoZW4gb24NCj4gdGhlIExTQi4NCj4gDQo+IEdvb2QgcXVlc3Rpb24uIEd1ZXNzIEkgd2Fz
bid0IHRoaW5raW5nIGFoZWFkIHdoZW4gSSBjYW1lIHVwIHdpdGgNCj4gdGhhdCA6KQ0KPiANCj4g
SSdtIG5vdCBzdXJlIEknZCBtaW5kIGlmIHdlIGRpZCBkZWNpZGUgdG8gZGVmaW5lIGEgbmV3IGZv
cm1hdCBmb3INCj4gb3V0cHV0DQo+IGJ1ZmZlcnMuIEZlZWxzIGxpa2UgaXQgc2hvdWxkIGJlIGVh
c3kgdG8gZG8uDQo+IA0KPiBXaGF0IGRvIG90aGVycyB0aGluaz8NCj4gDQoNCkkgZ3Vlc3MgdGhl
IG1vc3Qgc3RyYWlnaHQgZm9yd2FyZCB0aGluZyB3b3VsZCBiZSBqdXN0IHRvIGFkZCBhICdzaGlm
dF9sJyB2YXJpYWJsZQ0KdG8gJ3N0cnVjdCBzY2FuX3R5cGUnJyBhbmQgbWFrZSBzdXJlIGVpdGhl
ciAnc2hpZnRfbCcgb3IgJ3NoaWZ0JyBpcyBkZWZpbmVkIGFuZCB0aGVuDQpwcm9wZXJseSBleHBv
cnQgZWl0aGVyICI+PiIgb3IgIjw8IiB0byB1c2Vyc3BhY2U/DQoNCi0gTnVubyBTw6EgDQoNCg==
