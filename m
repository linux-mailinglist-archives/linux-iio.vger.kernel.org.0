Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4A3F2803
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhHTH7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 03:59:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33926 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231448AbhHTH7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 03:59:19 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17JN9s2V024920;
        Fri, 20 Aug 2021 03:58:27 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 3ahdb2g5y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 03:58:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVnaOR8CEc73oThwlWfJVQc6v4Ysrp8Odyfgatqa9FvjUH6lA+BmHDxp6qww5Z+FwYK9a14J+6eHsqGN24mpjWVznGz+iatgGAj6ppDqRlf+Y4D2LTs12ETjxsueoEEIzTkUZsphIw7LgyTjPvmPhmxYicLYtvhTkiKJeAnAKnKiVqJViQedscczmSALhnyiYtI11hBqNz0lmNOJSNpsNoto9EOXZAPB1f9WZ2phwGxMpABjVkxdkH4+QUEAO5URzj8MQ+/BVd6BAp9OjZa7/NkX0ITqf2KLSIiTEQiN6E1DttzM124FqkIimarplnzBB1PEF7mFPQkXlyVjaA81Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qh01W6XIq07DD4g5B+3/f5Qh4bieJRm2BYeu1tIEro=;
 b=Q5M+0zVdff+3wG1cDKmKMWL+GDOJ584Id0Bm9BXobmTqNx1e3myhZSNt7FRdEURV2VZPOHSEb3SAblw81ach3xkZbfa5li6QqPSwT9LS8E/qSp6nDyxt1V7SdJyM2BxY/AUOWJ4SP1dNX2j6pNp7NvXb5CVR77ueZKwWHHJOmA1xgEEyMPUiXtEHUXsXKyYXOeYochie/izvXvSRP2TpFz5g97TFQWONFbUza/pneP8CiDEQJLOlT/t0HQugtcWRrLNM1oSHCDt1itRSeRKeEOK3iueT23W//8L+6/RXH0eqMEzUy+Wlrw8zUdon9kX+qI0WjWpRUJ4EDiTJtpiSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qh01W6XIq07DD4g5B+3/f5Qh4bieJRm2BYeu1tIEro=;
 b=57rrrG2IGTkKvIXR3ulv6h+0Bsaawvb+e7/L8RsAeRJMVCu12oURSNrMElqS8NHs4VUduLN32y4fxWriyPEnHdgFA6boUVumBALGS2R2p19K/pMNhda0PB98/L1KdWRI/WTqvsLB61AM1eKnQugyrQIcPAddxkBgT1G7A5oiiEo=
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com (2603:10b6:a03:399::5)
 by BYAPR03MB4887.namprd03.prod.outlook.com (2603:10b6:a03:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 07:58:25 +0000
Received: from SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930]) by SJ0PR03MB6359.namprd03.prod.outlook.com
 ([fe80::a010:2cb7:9a3d:d930%4]) with mapi id 15.20.4415.022; Fri, 20 Aug 2021
 07:58:25 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 15/16] iio: adc: max1027: Support software triggers
Thread-Topic: [PATCH 15/16] iio: adc: max1027: Support software triggers
Thread-Index: AQHXlCHmtYQ56hYJOEuQ9hENpTeKm6t8BnvA
Date:   Fri, 20 Aug 2021 07:58:25 +0000
Message-ID: <SJ0PR03MB63594E162F7246874CD1A72599C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
 <20210818111139.330636-16-miquel.raynal@bootlin.com>
In-Reply-To: <20210818111139.330636-16-miquel.raynal@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5qTm1PR1kzWTJNdE1ERTRZeTB4TVdWakxUaGlPRGN0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhEWXpaamhtTjJOa0xUQXhPR010TVRGbFl5MDRZ?=
 =?utf-8?B?amczTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTXpNNE1T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TTVNVGs1TURNM016WXdNemszSWlCb1BTSk5hVlZ0VlRO?=
 =?utf-8?B?NmJFaFdkRmR1TWpKVFVYbHZZVEZXZGtvMlpXTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVRk9VMWRSYlcxYVdGaEJVVEJKVEVkb1dIRjROMFZFVVdkellV?=
 =?utf-8?B?Wmxja2h6VVVaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-office365-filtering-correlation-id: 8bf0114e-216d-4381-f019-08d963b04a01
x-ms-traffictypediagnostic: BYAPR03MB4887:
x-microsoft-antispam-prvs: <BYAPR03MB488705AD6B701F7F4FD33FA399C19@BYAPR03MB4887.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qiQdmU919DgJcGRVaZZkRgus1kclW8qmxDETD1vKaCDhZob4MRor39gizDa/vZY5mfHbosiLQq+6kLlLE4IewWxGtPbyD/67iaAXD+Y3+rY+bFOx57GzDcCDN+sQ83grn4zkydbzhGUxIQC9c1l6TDDWpNXbF8LD5LG8+CxN6hL5FOcaEgAG7PWwJziN2uJKk6RpBtpEEfs/ySO+/r/0EwRWi8bW+byWTe4hI+LUXbdp/PbWM5yXzx69Td7+Woykbsn43wTy3Z8A501S/bub7tuzq+dWQTVXsrGo/o7Iz8FQeyeC/S3Mzy4hSkEd2GFyFcuLF7TEWUzPuM6Fyiz3pRbEMgDMyfW5HWnCgMOKPrTD0GZJryv8atvuh8tw9LnrvcN+1eaA4CtxJ9RDz88t7Gc2XCwgA5pBsM4+IeqfXrhZqfATKSPYXsNWu894MNyxsmHX1NUpi6QxNuMkR38dtsNW6qPOKWgNlpbJnDNww4B/c0dSTfjlr1xOgnsbGOn62/7fJAsY0nDXP/7ZWex3qcEn9km3uNo7kM7cKMpBk9ioSQyOSjAKL2an+9iQ4cOmaUV0hgnqBONwOLCP0+dYcPDpth+f24OC+pP/v9o81DCRcR51Oj15X+LwNVM6VpO8LiMKzKsk6FhZXmSpaJWgalgkyBlcLaoOqewhueOHp+5mm0yrFREFwyvsvGepZXWDtyCHBZBlMavpUc7jBmz+Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6359.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(83380400001)(110136005)(54906003)(9686003)(6506007)(86362001)(316002)(52536014)(66946007)(5660300002)(2906002)(76116006)(66446008)(55016002)(26005)(64756008)(66476007)(66556008)(4326008)(53546011)(478600001)(71200400001)(38100700002)(38070700005)(122000001)(8676002)(7696005)(33656002)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWhRUTRoS0NwWnpiNHRyUTBHM2orYnROOGczV2RGZ1JQQkszMUp4V3NEdWxn?=
 =?utf-8?B?UGJyZnd4KzdhbUhDR1JMSlNBNGxjWVZLeWVveVBFeUF1R0Z4Q0ZIRzAranZZ?=
 =?utf-8?B?eUZoVEhsbmVsbmZrQUIvcnlJaG5tOHZ5UGRiVXRONUJWRmdNNVNmOCtnVm9z?=
 =?utf-8?B?M2k1VEJzYmswTnltYTVQdTBTdlpqcnU1M3JtWTliUjArb0k5SEtDWDdVbElQ?=
 =?utf-8?B?OUxxRlhJMjZkZ0lxMkJqN29jYXZLNlIrWnBLM0VZbENTRkVnb3Zpc2c5YWRH?=
 =?utf-8?B?Z2c0SDVPSTM0WXdMRmRVaUZzc1gzaEs0aTl4ei9aK2xUQVZoM3RSczZ2b0Yv?=
 =?utf-8?B?WXhNNDAyK3F0WVcrWXVFKzN2aCtHU0RwYUpvbU5qU3MxeUpEaWxMY2lUeUMr?=
 =?utf-8?B?MkVEaDRxVW4xOTlnZnJxbkxVUlkwWVBXdWRmem9DaE5KVndFbytVVkZEUXNv?=
 =?utf-8?B?TkN1eHlCck0wb25BRW9NTVYxWm9HMnVBUG9KWkdnakNkT3V6Um5pK0dVbVFz?=
 =?utf-8?B?UGxlb1FjZUQ0YmFxMERndkowR01UZWRIM0duV1N1UkFrZ1c1Y0NEN3dweWJY?=
 =?utf-8?B?cXRIOXVmZVVvU2dTSCtsYlJFMWJMYlROeER4QUhwaWhyNXNWSkhZRnVPZ0lp?=
 =?utf-8?B?emNUakxSV1Z0RDUrOGJqUzBkMGhjOTNJSWcxaEpUSERsZHhYa3JoNENzQTIy?=
 =?utf-8?B?U3hDZjgzU3F5SStUM0dpaVZDbllXT1UvTXJvNG5QandxZXlHcExjUnI0WDcx?=
 =?utf-8?B?ZHorcVRXSlJVNE1zdk5NdGlmSlV4WEJzTTRiSlplRDdkVldFQWd3cVloWkVS?=
 =?utf-8?B?UUoxeWhFbkFqL2h6UzBRbnFYMEpPbXlIcTFtdFJ6MWt2TitlWllpY2RjanJ0?=
 =?utf-8?B?elJ6cnNlVTgzazlrQmVJaEdEWFB3M1VDOSttSnZWQ1B5R3B1RmZNR2ZQYzVz?=
 =?utf-8?B?Q2pwRG9lNHVDV0R4MkdLcnJqQWc3ZGlhbXl1NWdmSG9Qa3QvOUV1WitXZWh2?=
 =?utf-8?B?MW9UMVQ2ckZMYXJCYlBPam1FNmJBS1NaNHp4Mll0ZmdPbnlIRWIzMFVaanM1?=
 =?utf-8?B?eVpVM3F2a2lQYkVJaUlFSk82cTBGTmFudkhZajY3MlpmcTRWVHZTWGpoRVBD?=
 =?utf-8?B?RzRWZEF6YjMyQkMxdk91aDRmVE53MGZiRWtRazIyTURWL0pUYnNHazBLWHM4?=
 =?utf-8?B?U3lLK1ByNG9PaHBLRUd3UEVtSmJta0xFRjBkbWpFQk4vbDAvWXZyWmNRMGFy?=
 =?utf-8?B?OWlRbU5FZUViSFZRcnBrejZ3eEFrS2NUOWx1REZhenQxWjBqVE54UHpEaTBN?=
 =?utf-8?B?U2ZGMkVmemFVZDc4QXYxR2ZMSzFLVEFmZnhMenFWMHRJY0JpMjZIRWw0djhB?=
 =?utf-8?B?aEJXOWJYWEhCQ1l2ZjNxR1Axd1Fqb3B2YmYvZlVUSDNLNmhwR1NjSkd2RFZm?=
 =?utf-8?B?Ky9LYm1xT1dKbEpaN1pMcG13NEVwMll0bFYweUVTd0ZNZW5RUEpSYmZ3ZUo4?=
 =?utf-8?B?K0ZNdWhGSkRDaXowN1JQWWgrdmIwQU9UbDZWRkxpT3JyV1BCZ2VadGpmd2I1?=
 =?utf-8?B?UUhYVEZkY29nSWJDd3NuQjNtRUlDRmhuT01ZWVQyeUU1RUFSd1R6T0RYclNi?=
 =?utf-8?B?Y25mRVlmUEtqek1FcTR4WXh0ajVnajk4TjBTUHU0SDcvYWZnb2dqOGVQWXNL?=
 =?utf-8?B?Z0hINDlPajlrZlloNjZlNENuaXdlTVB1YmZoZzZuaTZqTDMxbkt4eWp3bTJp?=
 =?utf-8?Q?RWABxiB3cbNdTQAnLOqGA19LY59rJm1RpaLPML2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6359.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf0114e-216d-4381-f019-08d963b04a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 07:58:25.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jEPrAVUcS9eVNnhC90wcKEySQfXeEwvaIjGWqKxmQHKTg6pGhqv5Uo8hLrFzfQ6M+RIhOMgSETPuvnzRXgiFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4887
X-Proofpoint-ORIG-GUID: clro8kXfn7Bszq99yu74iRyAq0SkWHdh
X-Proofpoint-GUID: clro8kXfn7Bszq99yu74iRyAq0SkWHdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_02,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108200044
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlxdWVsIFJheW5hbCA8
bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMTgs
IDIwMjEgMToxMiBQTQ0KPiBUbzogSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBDYzogVGhvbWFzIFBl
dGF6em9uaSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT47IGxpbnV4LQ0KPiBpaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBNaXF1ZWwgUmF5bmFs
DQo+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMTUvMTZd
IGlpbzogYWRjOiBtYXgxMDI3OiBTdXBwb3J0IHNvZnR3YXJlIHRyaWdnZXJzDQo+IA0KPiBbRXh0
ZXJuYWxdDQo+IA0KPiBOb3cgdGhhdCBtYXgxMDI3X3RyaWdnZXJfaGFuZGxlcigpIGhhcyBiZWVu
IGZyZWVkIGZyb20gaGFuZGxpbmcNCj4gaGFyZHdhcmUNCj4gdHJpZ2dlcnMgRU9DIHNpdHVhdGlv
bnMsIHdlIGNhbiB1c2UgaXQgZm9yIHdoYXQgaXQgaGFzIGJlZW4gZGVzaWduZWQgaW4NCj4gdGhl
IGZpcnN0IHBsYWNlOiB0cmlnZ2VyIHNvZnR3YXJlIG9yaWdpbmF0ZWQgY29udmVyc2lvbnMuIElu
IG90aGVyDQo+IHdvcmRzLCB3aGVuIHVzZXJzcGFjZSBpbml0aWF0ZXMgYSBjb252ZXJzaW9uIHdp
dGggYSBzeXNmcyB0cmlnZ2VyIG9yIGENCj4gaHJ0aW1lciB0cmlnZ2VyLCB3ZSBtdXN0IGRvIGFs
bCBjb25maWd1cmF0aW9uIHN0ZXBzLCBpZToNCj4gMS0gQ29uZmlndXJpbmcgdGhlIHRyaWdnZXIN
Cj4gMi0gQ29uZmlndXJpbmcgdGhlIGNoYW5uZWxzIHRvIHNjYW4NCj4gMy0gU3RhcnRpbmcgdGhl
IGNvbnZlcnNpb24gKGFjdHVhbGx5IGRvbmUgYXV0b21hdGljYWxseSBieSBzdGVwIDIgaW4NCj4g
ICAgdGhpcyBjYXNlKQ0KPiA0LSBXYWl0aW5nIGZvciB0aGUgY29udmVyc2lvbiB0byBlbmQNCj4g
NS0gUmV0cmlldmluZyB0aGUgZGF0YSBmcm9tIHRoZSBBREMNCj4gNi0gUHVzaCB0aGUgZGF0YSB0
byB0aGUgSUlPIGNvcmUgYW5kIG5vdGlmeSBpdA0KPiANCj4gQWRkIHRoZSBtaXNzaW5nIHN0ZXBz
IHRvIHRoaXMgaGVscGVyIGFuZCBkcm9wIHRoZSB0cmlnZ2VyIHZlcmlmaWNhdGlvbg0KPiBob29r
IG90aGVyd2lzZSBzb2Z0d2FyZSB0cmlnZ2VycyB3b3VsZCBzaW1wbHkgbm90IGJlIGFjY2VwdGVk
IGF0IGFsbC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXlu
YWxAYm9vdGxpbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9paW8vYWRjL21heDEwMjcuYyB8IDI2
ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
YWRjL21heDEwMjcuYyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMNCj4gaW5kZXggOGM1OTk1
YWU1OWYyLi5iYjQzN2U0M2FkYWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9tYXgx
MDI3LmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL21heDEwMjcuYw0KPiBAQCAtNDEzLDE3ICs0
MTMsNiBAQCBzdGF0aWMgaW50IG1heDEwMjdfZGVidWdmc19yZWdfYWNjZXNzKHN0cnVjdA0KPiBp
aW9fZGV2ICppbmRpb19kZXYsDQo+ICAJcmV0dXJuIHNwaV93cml0ZShzdC0+c3BpLCB2YWwsIDEp
Ow0KPiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgbWF4MTAyN192YWxpZGF0ZV90cmlnZ2VyKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYsDQo+IC0JCQkJICAgIHN0cnVjdCBpaW9fdHJpZ2dlciAqdHJp
ZykNCj4gLXsNCj4gLQlzdHJ1Y3QgbWF4MTAyN19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19k
ZXYpOw0KPiAtDQo+IC0JaWYgKHN0LT50cmlnICE9IHRyaWcpDQo+IC0JCXJldHVybiAtRUlOVkFM
Ow0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBpbnQgbWF4MTAyN19z
ZXRfY252c3RfdHJpZ2dlcl9zdGF0ZShzdHJ1Y3QgaWlvX3RyaWdnZXIgKnRyaWcsDQo+IGJvb2wg
c3RhdGUpDQo+ICB7DQo+ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGlpb190cmlnZ2Vy
X2dldF9kcnZkYXRhKHRyaWcpOw0KPiBAQCAtNTEyLDcgKzUwMSwyMSBAQCBzdGF0aWMgaXJxcmV0
dXJuX3QgbWF4MTAyN190cmlnZ2VyX2hhbmRsZXIoaW50DQo+IGlycSwgdm9pZCAqcHJpdmF0ZSkN
Cj4gDQo+ICAJcHJfZGVidWcoIiVzKGlycT0lZCwgcHJpdmF0ZT0weCVwKVxuIiwgX19mdW5jX18s
IGlycSwNCj4gcHJpdmF0ZSk7DQo+IA0KPiArCXJldCA9IG1heDEwMjdfY29uZmlndXJlX3RyaWdn
ZXIoaW5kaW9fZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIG91dDsNCj4gKw0KPiArCXJl
dCA9IG1heDEwMjdfY29uZmlndXJlX2NoYW5zX3RvX3NjYW4oaW5kaW9fZGV2KTsNCj4gKwlpZiAo
cmV0KQ0KPiArCQlnb3RvIG91dDsNCj4gKw0KPiArCXJldCA9IG1heDEwMjdfd2FpdF9lb2MoaW5k
aW9fZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIG91dDsNCj4gKw0KPiAgCXJldCA9IG1h
eDEwMjdfcmVhZF9zY2FuKGluZGlvX2Rldik7DQoNClRoZXJlJ3Mgc29tZXRoaW5nIHRoYXQgSSdt
IG5vdCBnZXR0aW5nLi4uIEhvdyBhcmUgd2UgY2hlY2tpbmcgdGhhdA0Kd2UgaGF2ZSBzb2Z0d2Fy
ZSB0cmlnZ2Vycz8gVGhpcyBBUEkgaXMgY2FsbGVkIG9ubHkgaWYgdGhlIGRldmljZQ0KYWxsb2Nh
dGVzIGl0J3Mgb3duIHRyaWdnZXIgd2hpY2ggd2lsbCBoYXBwZW4gaWYgdGhlcmUncyBhIHNwaSBJ
UlEuDQoNCkknbSBwcm9iYWJseSBtaXNzaW5nIHNvbWV0aGluZyBhcyB0aGlzIHNlcmllcyBpcyBm
YWlybHkgYmlnIGJ1dCB0aGUgd2F5DQpJIHdvdWxkIGRvIGl0IGlzIChpbiB0aGUgcHJvYmUpOg0K
DQotIGFsd2F5cyBjYWxsICdkZXZtX2lpb190cmlnZ2VyZWRfYnVmZmVyX3NldHVwKCknIGZ1bmN0
aW9uIGFuZCBwcm9wZXJseSB1c2UNCmJ1ZmZlciBvcHMgWzFdIChmb3IgZXhhbXBsZSwgeW91IGNh
biB1c2UgJ3ZhbGlkYXRlX3NjYW5fbWFzaygpJyB0byBzZXR1cCB0aGUNCmNoYW5uZWxzIHRvIHJl
YWQpOyAgDQotIG9ubHkgYWxsb2NhdGUgYSB0cmlnZ2VyIGlmIGFuIElSUSBpcyBwcmVzZW50IGlu
IHdoaWNoIGNhc2UsIHdlIGFzc3VtZSBIVyANCnRyaWdnZXJpbmcgaXMgc3VwcG9ydGVkLg0KDQpE
b2VzIHRoaXMgbWFrZXMgc2Vuc2U/DQoNCi0gTnVubyBTw6ENCg0KDQo=
