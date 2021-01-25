Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A53023A1
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbhAYKYt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 05:24:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6744 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbhAYKXN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 05:23:13 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10P8kCHq007218;
        Mon, 25 Jan 2021 03:46:59 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 368ehadn10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 03:46:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvGf1fqQ/ww3bvYPMpAaitj5PKdTVXCvcjFeWfYxyqeOfFyeU9Awg1qDU5pHxYq+lcBGtns6arYFvTwPwDn+DmX37pYTJmEzsZE3wxG6heSauYWaA7UUlDZrkqa7FCmOLUZYxk57BJ9Yo209j1yilt1vqWPT7X81EbN1Tf175BIZUUQSJoeH923eslk4vD0u8NfNv9xkqQFXE4G6ZXdthZyxwUf6LWdelnL/dIzYBvaXmsV1n6jPLR6DmMgx+hADkr5qV5BWdARLt4oA36jbDQd2V2tEyTE97qBRn+KV2gu3B1svFUTxeEYQJKkhLKC7odKJFhzSTxAZtCd6ZROE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o694SLNdBeleZ8i7rTVeBlnLoFhTC1FV1aforSwkMo=;
 b=cs/4ixf1bOioAs3wv3IXNFShecPoj1+QQpQqqEoJJCjkO8dZktl1LqmyddjIx9ELd82Ze9DDjrIE8Z4/2qW526dSiPR7zkrq6BpwoP3za5whaGZweSbmUfVrsJKN42TVFHf3vPya/1RSUaewaN8I845+UfVsQL3AVfy/bR+G3LUq4EW51KqQRLFnkH13qu8aObf43gko8yAxmxsDs6+OpAIhW/uYfFUFonmalR9g8W8G8q2bde3bCkAy7EhSK0w7c9dJMsS8VHyEtq/3bQCOrKJoFgLyihTdj3Y1q9/5ePqWVHPh0iegcC9/x9iD5PenpzAEYS+ag0fmqBTqx8KqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o694SLNdBeleZ8i7rTVeBlnLoFhTC1FV1aforSwkMo=;
 b=sXqYwh/NAh/mPRuARCwt0h6EhBRYhhP6MCY3CDV3Eg5RjkwdtxfiPM9mFxmHxTuK9zjqB+cxB1LFn4sk4jcBSQrWs1ErUNyp3kJqR8HGOHg1NCavKFuS4bP77yN/U2L7/KS+f7wTVnhKRC2XTYfHTV2K7XqJ5ZmqV7PRpnQ3ZF0=
Received: from CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:74::18)
 by CY1PR03MB2299.namprd03.prod.outlook.com (2a01:111:e400:c611::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 25 Jan
 2021 08:46:55 +0000
Received: from CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b]) by CY4PR03MB2631.namprd03.prod.outlook.com
 ([fe80::1c75:7035:43d8:f03b%7]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 08:46:55 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH 1/4] iio: adis: add helpers for locking
Thread-Topic: [PATCH 1/4] iio: adis: add helpers for locking
Thread-Index: AQHW7+xVFagoczjNpkm5hTaB7kEKM6o2yjKAgAFC2kA=
Date:   Mon, 25 Jan 2021 08:46:55 +0000
Message-ID: <CY4PR03MB2631B5FB9D98CCBF437A92CB99BD9@CY4PR03MB2631.namprd03.prod.outlook.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
        <20210121114954.64156-2-nuno.sa@analog.com>
 <20210124133003.6005f9e6@archlinux>
In-Reply-To: <20210124133003.6005f9e6@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFpHVmxObVZoWXpjdE5XVmxPUzB4TVdWaUxUaGlNREl0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhHUmxaVFpsWVdNNUxUVmxaVGt0TVRGbFlpMDRZ?=
 =?utf-8?B?akF5TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRJeU5T?=
 =?utf-8?B?SWdkRDBpTVRNeU5UWXdNemd3TVRNME9UazRNelF6SWlCb1BTSTNVRWxoYW5C?=
 =?utf-8?B?Q2FrMVFSWEpxV1ZobVNVWXhNRkl4UTJaTGIxVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSklkMVI1YURsMlRGZEJWMm94TXpWYU1WRTFRaXRoVUZobWJH?=
 =?utf-8?B?NVdSR3RJTkVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRUzloZUdSTlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-originating-ip: [2001:a61:25ba:fd01:81d3:5715:13ec:f57a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7cdc56e-95c5-4f01-1d01-08d8c10dc4d6
x-ms-traffictypediagnostic: CY1PR03MB2299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR03MB2299B781492F9868654F98F799BD0@CY1PR03MB2299.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1oxNDq+M016RCwujuo4PpOkNVvuiwLdOjUs774vTCA9UuRjLFRTq2T3+k4k4tWPEzM6RI4EDmmTIpZ56RO7xPoX8WpJgk0cZFvvIiQtZ10guCQqR2hgtby9z8LWhcQAlUn4gxh5FFUdZkzERLuFkJyIzY/yyPa8w0BLASBcSPnSLnxX+xYBBp4/UqEupu52vj92JhIFZyTi2dgfOIgvtJbdA+NmUrxGQUAerTAItJ6B05ZhwPy71YrZPdrqlcyMVgd9wxIxDCmDP18y084BSAaGePwTMUf0Rh/HQ7fta7LYlByV+hnxvs0Cypf2OWFNPgd0mGpENu4E0vUJ3/KPQ4VsgFopme7dRNIaJmYzqPJv/7bJmDDYLts96CBpCmimuKpgkQlhf3Ovc1nYIpGwOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2631.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(86362001)(76116006)(8936002)(107886003)(4744005)(71200400001)(66476007)(66556008)(5660300002)(4326008)(64756008)(33656002)(53546011)(316002)(6506007)(52536014)(8676002)(66446008)(2906002)(6916009)(54906003)(7696005)(66946007)(55016002)(478600001)(83380400001)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L0FINXdqbzdheVNrR2ZPenowcERGanBwREpDOVQ5Q3lERERndHgvWDNMNEFR?=
 =?utf-8?B?TGVwZkRJOTIxTU9JOFYwaUU0dDBORmsxbENudTNaU3hnQSs1T1lycVRSZ2ZI?=
 =?utf-8?B?anN1ZG5lRHUxRzQrRWhRZzRndkJaR2ZiU1hvakVvRkQ3Q2F3Z1JpcUdLdDJR?=
 =?utf-8?B?dnlYMGVHcHhtYnpscGppcDRIaVV5NjJwZVhKZGdIelZkS09sMWhPNlRhQXV1?=
 =?utf-8?B?UXlaU3BmdndzY0Z1S3c1d3BGcFMxWktVYU42RzhUZnFqTXhNNnVDL25oTG56?=
 =?utf-8?B?RStUMGpFOXh0SHA4cS8wekNSVVN4dmdmTVhIVFpoejlDTEpLU25yMUtRckNl?=
 =?utf-8?B?TDN5TUtJQkMzNndDb1ZDM3BGakJUeFNnRWFMSDNhYzV6cWp6a2trNklTdWpZ?=
 =?utf-8?B?bitWT3hmdVNmNGF0a3MvbFVFbmxHekg0VWI2VzJoRW5RaEswSGhuTm55YmpK?=
 =?utf-8?B?Qk9rcUc2Wi9rOFgvaWR1c2dxM1ZvMVYyS1ZVTzIvbkZPQ3Y4VUhLZUx0bmxt?=
 =?utf-8?B?em9ucWtiQVhFMXNkUllZWEZrd1lrK3BweXNYanhaYS84MHRNOU00MCt6V2JJ?=
 =?utf-8?B?ZjRMRW8rS3pMS3g1KzBRY1gwaWJ3UU1NVnQwT0FoV0hJbHdPZ2FpKzBDTCtI?=
 =?utf-8?B?aGZ6Y1BNYkdxd0RSZDg4UlFuUU0xaTNlTm5MejgzS0NsRzNVZnpaTURJdUcr?=
 =?utf-8?B?V3J4UkFvbWFQd0h6dE5ueUpWa0F6UlM2Z05WWCtkSmV6Slk2TDYwNHBlOWpx?=
 =?utf-8?B?b3FRMzFON2NROForVVdOYVdMRnJUVHV4dTM0eCtTN3c4QzJLdGgzVHFLdERk?=
 =?utf-8?B?QW0zcTJ0OE5LdmhJb3hidjY2L3JJME1pd0dWYWVVbXlEdldsMU5nNjBqWWd6?=
 =?utf-8?B?S1JwN3Brcmpjc2pZMjk0NEtmODRVNEQwa3JNZ3lSUCtvWC9Ia0N2aEhwVUVP?=
 =?utf-8?B?UG43Y3pneWlhdVo1b3ZvSGhFczRka1g4K1pzaUE1dnhMZ2ZaSkhJSXpsaVNs?=
 =?utf-8?B?cndrWGhVSkhSZHpyYnV0WFZxenZ6bVR6OExYZEJzWWZEYTB0MDZjMUtRMDdt?=
 =?utf-8?B?OXZhdk9Wb0xscjFqRnZUWnA0ZG03NkVNUWJuOXBzWU1YcE9ZUWFZWkwxTDZ3?=
 =?utf-8?B?WTRkUS9zWW9IRlpnNWxaWjVrT0pHeEppdEdFUGhHVkVaazIvTHhzNk5EN1Iz?=
 =?utf-8?B?bGV2WEx0YnZ6cjFqSjNNZ25ObGZDYk9uRisyZktSYlJBclRuK3lOTXNVUFM0?=
 =?utf-8?B?bkFFRTRydHFaWXIzb2p3TGFlK1pHYnlmdm5NSHJremR4MW1Fa0JQbHJsVkxO?=
 =?utf-8?B?b2poM25YYWxKWUNDNW5tVGI0d1BGVDNIclhwSmJZdXJRZFdybjkraWpKaGhB?=
 =?utf-8?B?VldYUU1WSzRBQmFhc3ljN2ZZNHR4SW1qVHhJNEIyMmJsd05oeW1VUll5YXNp?=
 =?utf-8?B?dkc5S0JGNmljWTVERHF5UjQvUVlEaG9FU0ZzOVZwcUF1bmtUTUJLLy9sbGt0?=
 =?utf-8?Q?xKGgnrDvq6anxlb9agJqx4Us/Ew?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2631.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cdc56e-95c5-4f01-1d01-08d8c10dc4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 08:46:55.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlO6oDgCUUEKFbhcEHaVmYkvh59WJ/con/SPXHZwf1O6DVeI0GY0fzv1cnhJLpcSgpuYEbUT7//Y5tRJZIV3ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2299
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_03:2021-01-22,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5k
YXksIEphbnVhcnkgMjQsIDIwMjEgMjozMCBQTQ0KPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5h
bG9nLmNvbT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgUGV0ZXIg
TWVlcndhbGQtU3RhZGxlcg0KPiA8cG1lZXJ3QHBtZWVydy5uZXQ+OyBMYXJzLVBldGVyIENsYXVz
ZW4gPGxhcnNAbWV0YWZvby5kZT47DQo+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5u
ZXJpY2hAYW5hbG9nLmNvbT47IEFyZGVsZWFuLA0KPiBBbGV4YW5kcnUgPGFsZXhhbmRydS5BcmRl
bGVhbkBhbmFsb2cuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gaWlvOiBhZGlzOiBh
ZGQgaGVscGVycyBmb3IgbG9ja2luZw0KPiANCj4gDQo+IE9uIFRodSwgMjEgSmFuIDIwMjEgMTI6
NDk6NTEgKzAxMDANCj4gTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0K
PiA+IEFkZCBzb21lIGhlbHBlcnMgdG8gbG9jayBhbmQgdW5sb2NrIHRoZSBkZXZpY2UuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0KPiANCj4g
SGkgTnVubw0KPg0KDQpIaSBKb25hdGhhbiwNCg0KPiBGb3IgYSBwYXRjaCBsaWtlIHRoaXMgSSdk
IGFsc28gZXhwZWN0IHRvIHNlZSBpdCBpbW1lZGlhdGVseSB1c2VkIGluDQo+IGFsbCByZWxldmFu
dCBwbGFjZXMgaW4gdGhlIGRyaXZlci4gSSBkb24ndCB3YW50IGEgbWl4dHVyZQ0KPiBnb2luZyBm
b3J3YXJkcyBvZiB0aGlzIHZzIGRpcmVjdCBhY2Nlc3MgdG8gdGhlIGxvY2suDQoNCkZ1bGx5IGFn
cmVlZC4uLg0KDQo+IE5vIG5lZWQgdG8gc2VwYXJhdGUgdGhhdCBpbnRvIHR3byBwYXRjaGVzIGZv
ciBzdWNoIGEgc2ltcGxlIGNhc2UNCj4ganVzdCBpbnRyb2R1Y2UgdGhpcyBhbmQgcHV0IGl0IHRv
IHVzZS4gIFRoZXJlIGFyZW4ndCB0aGF0DQo+IG1hbnkgY2FsbCBzaXRlcyBhbnl3YXkgZnJvbSBh
IHF1aWNrIGdyZXAuDQo+IA0KDQpPaywgd2lsbCBkbyB0aGF0IGluIHYyLg0KDQotIE51bm8gU8Oh
DQoNCg0KDQo=
