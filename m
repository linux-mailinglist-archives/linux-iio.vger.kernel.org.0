Return-Path: <linux-iio+bounces-9191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A689996D67C
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B381C22E79
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92B1990DE;
	Thu,  5 Sep 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="awK8VTNO"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3C1991D6;
	Thu,  5 Sep 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533762; cv=fail; b=uAr/snrhitEBJ/dU+7HJGKY6N8fEo9f1o6Es8heQVD+SJlYc02MSFnPaB+hlC3qBHimjWqYK5nqfX4n0b6WSUhq3MaGcr2yHfcOzCKYCaVqCoTxqVPoBc6fDNR8jNtwoWbq31akDqx5kxJN8zJYTm12WazSBKsVr+ZztveLgH+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533762; c=relaxed/simple;
	bh=Qngbng6Xry4E3tji1MUgybio7kMwtN4YXGlcjVa61sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W6Yi+Lb/Y7suY4bpxekU5Ngw63Z0OVZhZOSOL7ykB8/6yN9L63a86Wt8rkbYwLzWjw9n5NsqEnLUR4kSN7OANWTDGF8NQYyYTipFUJ3Ycjc9nCHMVzJehAYuO9qDmx8cIZ3x6OwfnZr9QcNIdyf94E0fd2NiYkaXDAgXK1va0EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=awK8VTNO; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qulQRInoSEczQpbxzV+oeo0EsESISmodlMjk2kn1nobdp0Y/WI3+mduCtpKlLWoTBh17h757WT+qauc3C+Z/g4WnvgdXk/avtIeJAsdsTbYdH4sr6ldGImlu15jdyJxWHs+mHnK8Lls8wf9S3PFn3k09kyo8f0hV8KIl4FhtJGqTkdtbDz/Pwg1MwfhnGMmgWj9tiOjPYCCf9yRTGbeTX47PJI4GeYhXNqamfCrodOuG7jrOnI3xRKlePqI4v3Z+Xp1PpJHtI5kSOBjdFTHCGapPW5szmrWkvALr5+Zf9y5UqMN0XqncX8Wyt3p6WuezgJ5CdX3NCjM7n5pVanjqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qngbng6Xry4E3tji1MUgybio7kMwtN4YXGlcjVa61sk=;
 b=LY5HEze/8hKNqaYHnDgxqmVr+KKZb5jQTFhxm3j5plsxsAS2RERKG/1qSiASiS50zSsxVeyJirOk+ceCYbWpBDe0x6WN49w/Hl8lN+NzYX4cb9X17pru7LFyBUqp2L3l4XU++KnPqx5guU3wuZsv0D51/wGvmHMfz/ElVt9t0sRuLiTdqMtdcfWpPu2yGjsuhqnPRhdP5xcJs+ghVcwqdAYxOVpFXfgsoDxqhgdwSJFOKcEU8MG9Cvwc8SETUfYssrUWnGLkfRhSt5Cvp18GlzQLtc+CEvHG4RGA+AHWY/w156MjHg7p0b1Fwx3YRMTyu1af26+9s/rbX8I922wh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qngbng6Xry4E3tji1MUgybio7kMwtN4YXGlcjVa61sk=;
 b=awK8VTNOOogRP2CeYPstMj0l05H+dsbEptZTrcfGsLjifW99gAznk2+7jSVKxlhjUgzl9DV9Y9swnJkHCu05GLqFUL6lHYaovHQv8vEtsbMHhrbOKvDBKQ1LKhgtHGGIq8NVyGEW2FeAEk2yKecMIgAfF++oW+m/Fifutgvkhyw=
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15)
 by AM9PR02MB6787.eurprd02.prod.outlook.com (2603:10a6:20b:2c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 10:55:54 +0000
Received: from AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa]) by AM7PR02MB5784.eurprd02.prod.outlook.com
 ([fe80::33dc:f613:4b96:46aa%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 10:55:54 +0000
From: Emil Gedenryd <Emil.Gedenryd@axis.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "krzk@kernel.org" <krzk@kernel.org>, "dannenberg@ti.com"
	<dannenberg@ti.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Kernel
	<Kernel@axis.com>
Subject: Re: [PATCH 0/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Topic: [PATCH 0/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Thread-Index: AQHa/311E8dX1TNKokiLJr4+kR5gfLJJAHMAgAAE6wA=
Date: Thu, 5 Sep 2024 10:55:53 +0000
Message-ID: <8524fdac71721a2343dbc3cb3f656150b3b9c1e6.camel@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
	 <8917141b-13ca-40c4-9182-b78c3c6836f2@kernel.org>
In-Reply-To: <8917141b-13ca-40c4-9182-b78c3c6836f2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR02MB5784:EE_|AM9PR02MB6787:EE_
x-ms-office365-filtering-correlation-id: 9acbaebe-43b0-4e8b-0f29-08dccd99503f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3VNRGgzVzRPYm16RVNobHEvb21VckM1SXpJME41VnpFQnlIWklSOUpSbUFO?=
 =?utf-8?B?TXE1b2VCcGFkam5pcjFkOWoxWWluVzV0K0orcGlrQjJSZWFyY1hTSkhUVGRV?=
 =?utf-8?B?NU9tNUthRGRNSTFpb0tUenB5QURIWHdtaGZJdTFDZTlLZU14a0M0S21ycFNa?=
 =?utf-8?B?TE5jRkw5d3Z0VGZNY2RnZFYycGcwbVVVaU40Um5XeEtoNW0rRkFOMDdIbi9P?=
 =?utf-8?B?bmdvbk1qOFNZTlpWQzRCQU5OUFJYRW9McThReWhiWUt4Q3RGRDFUTHhTL0lL?=
 =?utf-8?B?MjJvVmpoZjhPby81UTBiNW93YkluVC9hc0Y2WWVmanFGTk5FdFRRelVIOFJT?=
 =?utf-8?B?QWU5TURteFgyWDNaQ2kxTDRqZXRDNlhZTjJwSmhZamtVa0ZVaVBqTVh3L0VW?=
 =?utf-8?B?OTM3ZUxqTnJ0bm83bEdZOUIzZFVZL1ZJQ1JYOUtBWFhzb3RoL21pWTZEbXlk?=
 =?utf-8?B?dVpmYVQxd3F0RXRKRG1ucEFqQlZEQ2tMNDBxN3ZaaktzamJkNStjOHhnWEQ4?=
 =?utf-8?B?M25jNTIySnI2bHFnVjNkTlBrMlZKZVJJa2Uvb1pJM05seElZQmRnOFByN2ZU?=
 =?utf-8?B?ZnlKalJlOE9Yb1I3T050NG5BSmV6b0xJaWFZTVpSMHhNSEh3dkZ4TWhyd0VY?=
 =?utf-8?B?SUR1TC81eEcyN1FVV01hTXRvRm9pb2lVcE1WSFA4eTg0V3BtWHhBeGNWbyth?=
 =?utf-8?B?UDE4a01rSU1wQ3ExbFZtWVNHYnZONXM1bjkrVUxycXIxMlZJaElYa0xtRkV5?=
 =?utf-8?B?Q1BJNUlXVGdlb0JVRTVaRUhZWi9NWXd6eCtQOGtqall1WmlKbmhubHpmTVRM?=
 =?utf-8?B?QWhlRmMySU5xRS9jRzVzQ2RDdnIwY3RSVkVhR21nTU5FbXV2VkpvNGlDS3ZK?=
 =?utf-8?B?czdleXBpK00zZjBHcWJkRmI0em5BU29sOVV6cTd1UmVkRnYzZmg2bk1rNFpa?=
 =?utf-8?B?YWpvdnBsVnNaWDdqa0RCMHpjNmg3bTV0OW9MWDlHbmRuYlFUdmhzQTVvZmY5?=
 =?utf-8?B?NzA4KzhOamNReGJEbWdjZ1BvM1crdXBqMXdoZUpxeG55YVJmMGMxSS9XbUQr?=
 =?utf-8?B?L2Z0WEttTzZJeG8yQUlNemdjQkkyUkU5ZmZJaHNwRHBvVjkycWhzbHVMdzg3?=
 =?utf-8?B?TFM5cUtTMk9kWW5lWDNwWjJscExtUG9zODBVaTRuMXpvajE0WG5icWVlOXJZ?=
 =?utf-8?B?OTlpM3ZzckJoTHZVNEY1SGd2WUNTZ0tBRTZFNXRhWFppdmZ1bDlCSmZKZzNE?=
 =?utf-8?B?WTIzd201aC91OVdxcWpsWTRaSnY3WGZJNlFvYmV5UHppRE1seEpBYUxPcjVI?=
 =?utf-8?B?Vi9SN0pOUG5tbFI5QnBNQkNGeGJQbGFKWGdRTFo1NU01YVJWRktON3hnRnpQ?=
 =?utf-8?B?bzh2R0pjZmxtcDFOTHJNMktGLy9Jc1I4MnpZQkx3dVROUEVZdUE0bVh0Wmwy?=
 =?utf-8?B?bnc4MHQ5NHprY214K2txd2hvKy9Tek5jS0lUM2lqZFBXTkNDNHNUM2hSQTh1?=
 =?utf-8?B?VVZKb3E3UGNrNHRoRUlydXJsM2xxTXp4MENPTTA0YVFoNjJlV2luVjJPTHNF?=
 =?utf-8?B?WWNFWjUvMk84VUdwR1VCRUpFQ0N2dzBjY1VLTnZMYjFTSllodWJBVkR2NVdC?=
 =?utf-8?B?V1pmQnZVaVJEQmFOR2txT2dVL2ZkeUZnMXhlLzFDWFI3WEo2VklyYXlVSE9t?=
 =?utf-8?B?emprVzNPR3k0SHI3QnQ1WHZhVWNxaXRwM1BFdGRoWGo0MmFrNjBaZjYvd1pG?=
 =?utf-8?B?UXQrYUxrNnAzNHUrT1gzNjR2L01PL1hzUlB4bnFXbTFLUWhUTlcyc29rS08w?=
 =?utf-8?B?d21jMmtYM1RjcGszTlJHdUg5OVNhMFkyNEhaSS9nbDJ1d0NWT0hYdndGWXB1?=
 =?utf-8?B?cXlFZ2lkeUxQbXovRTh1elNHcVNPa0EwMzBUaWloWXBjQmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR02MB5784.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3JOdWlzdnoxL1NKS2lOd095bWlUb2d1Uk1Ed3J3Z0JOWXZUeWRQNUlVWkkz?=
 =?utf-8?B?cW9XMDJZbk9pTUsrelM0RTZ6TUVGYndpeDFLUmRHT2xsLzN2bXJWd3JqM2o2?=
 =?utf-8?B?cDVxRkJnR3VvdERrbTNEaVZnNzhFSzRvcVFFSUNyVzNrWDM4MHJ0QnhRdHZR?=
 =?utf-8?B?clpWRFNnOTdBcGd1ZUpwMjJxMkVnRnB4bXA5cTRkc2M5djNkcnFwNk1kclB0?=
 =?utf-8?B?Y1Buamk0b3pERU9RcU1mL0M4SGw2V1hqQXJHTzgxME5SSnBkeVd2UWhTMnJN?=
 =?utf-8?B?eHl3M3AxOHJadGpNVXlSRGRTM3FxY2hVcWdsRmgxUVFNR1lIRUZXaUF0Sjhl?=
 =?utf-8?B?S3h4S0xhV1RROUtkZ041TVQvdlJOU1hpM0NpRXpyaFlTbkdmVm5XQ0k5QjBw?=
 =?utf-8?B?Vzc0djB3U2dQY3V4Znp6b20yOFQ4eWdEakZjb0I0d1gvR0JpdHZoL1ZwYnhx?=
 =?utf-8?B?M2paOU1xb2FpSHdHaFZmQ0VwazVOTWU0QUFzaUYyUWhyU2hWelN5SENsZTdj?=
 =?utf-8?B?TEhDcGNJcGpxUHhabHZQTk1JT01rZUt2bW5uZ0RwcFVoakFQYjg2WkhPQTZH?=
 =?utf-8?B?WEdMSXlRVWNOVlVlV29hQ2VRYkVBNC8rdnFFenBuNWlHaGlBMWd0R3RsR2JX?=
 =?utf-8?B?NG1BVkhiQkpOZ3pQTm04amcvMGtxZEx3allPaEFQeTZVaXNEOU1tZnM1bzUy?=
 =?utf-8?B?OTBKbnlaV2oxZDE4RExkSG80dFNKOVB5S1hBbmRTODZReCtiVlNwUk9uVDRj?=
 =?utf-8?B?ZWE2T1cwZjFsd0VhRGdEVzBwakpGZ0wyTWVtSnNCRjUyYzYrWjdSdStFM1lN?=
 =?utf-8?B?VlhucllTSm0yYjlYWkhZYmhRNnYzMTVxN29sMnRlS2dnUGZpRlAzazROY2Zx?=
 =?utf-8?B?bFBaWEF3M1pTVkFHRy9MdW93N0pxUTVIbUdOVWxLSVN1cXpiRkFUdEVqMG1k?=
 =?utf-8?B?V1ovUXJDM09PL0JsRERNeGVMMGtFZXkxRHp5dnVYWW56MUZXVnVKU2k4SVpq?=
 =?utf-8?B?ditqUEdZcUZoWmVWTXg4eGhsZ3VwejNwQlhWdHdHMWpPaTVpai8vMUlJM2ZE?=
 =?utf-8?B?VDd0YUp4WkFwbE8zWkpnMFhsZHFwRm85bEVYU2Q0aHRXc2MySVppcEY5Ky9M?=
 =?utf-8?B?MnR0d01qNDB4dk9Ga0JhR1ZBRkxqTlI3UGxuL0VvRTZkQmFadStEWDY4aXpp?=
 =?utf-8?B?Y1N1S0wrWGl5WStNbUYwQ2Vuc2IydW9wMy9BWHdmcW9vVElDd25LeEEzaWxy?=
 =?utf-8?B?NkdpVEVhVjFrODZoanlNVGF6SGdZUjNZeEllN1Q4SzJ5R0xQYlhNdHZ0OFQz?=
 =?utf-8?B?ZWxJQU5xcnFyd1VCb0ZMNjJSQVhOU2NLT1NFS2p6em9vMitxdXNqaEtNbG1M?=
 =?utf-8?B?SUI1NXkrdjkzZXlEeTVFYmFmQ3NoUDdXYlY0emFJdHRyNTdFYS9OSTZZSm1z?=
 =?utf-8?B?amNzQmVyWi9wQXQySzEzNUtDSEttWE5sbkJrdzFOcFlROHU2cWYwRnVCZEFW?=
 =?utf-8?B?UWlna25JYzJ2MXdTZzNMMHdBVERQbUcwK3IwSDZ5TVp4a2dFc21mdUJtQmw2?=
 =?utf-8?B?NnV6d0VMa2ZMa1p4TFgxeklYK0tRbnVnejRGN0VpTDlZUGJLLzcvTzhhQS93?=
 =?utf-8?B?aUFtd2FDRVJMSFJvazlqWjRXTEsvKzQ2ZEpxS284YTFyK3BlQ3ErN2JFcnR0?=
 =?utf-8?B?OTk4anM3NjR0bXNCc29aMElWbkkrM3F4OXQvQTJ5ZnI0RUo1REUrUENCUlBV?=
 =?utf-8?B?cTRkZ2xyeW1Hb0xyb2RHRm9rQURMSnQra055VkdDNjVQeXJYQStBTDY0WDV3?=
 =?utf-8?B?bUpMQlhRYlZ3R0xUVUV4bUZSb2FidmNjWFM1NmZOVjJiYkJXVkxFNEQxWFMy?=
 =?utf-8?B?MUtYSGN1a0VKUSt2RWRpM0pleUNqNC8wYXpndEZxSzEyclVlZzl6U2R2UWpH?=
 =?utf-8?B?T1R5SVBPV0t1M1lVaG9ZeFEwUFFCQVZRQjg3WUNSbWJjMzRrT05PK2tZQ2wr?=
 =?utf-8?B?TTRGc05JeHM1cTJrTFZ4SmIxRitZNGdPS2liSC9FenVZM3EvNUxncGQ5M24x?=
 =?utf-8?B?dlNQSnRnZU0yODVTZ2ZYcElObTFKd2Z4NnY2KytEbElFWUdvSzhTb2VGeHN6?=
 =?utf-8?Q?x737Y/pcqL2lx12SfQA4xkyWU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64EE1C14FFD70044891477120B6034A2@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR02MB5784.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acbaebe-43b0-4e8b-0f29-08dccd99503f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 10:55:53.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjKrt0RqhnTBDVjTJNPwLUpT1LujL35VIp5hWX+wup27K1QnkhGll0I6goJtk2V/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6787

T24gVGh1LCAyMDI0LTA5LTA1IGF0IDEyOjM4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwNS8wOS8yMDI0IDEyOjIwLCBFbWlsIEdlZGVucnlkIHdyb3RlOg0KPiA+IFRJ
J3Mgb3B0MzAwMiBsaWdodC10by1kaWdpdGFsIHNlbnNvciBwcm92aWRlcyB0aGUgZnVuY3Rpb25h
bGl0eQ0KPiA+IG9mIGFuIG9wdGljYWwgcG93ZXIgbWV0ZXIgd2l0aGluIGEgc2luZ2xlIGRldmlj
ZS4gSXQgc2hhcmVzIGEgbG90IG9mDQo+ID4gc2ltaWxhcml0aWVzIHdpdGggdGhlaXIgb3B0MzAw
MSBtb2RlbCBidXQgaGFzIGEgd2lkZSBzcGVjdHJhbCBiYW5kd2lkdGgsDQo+ID4gcmFuZ2luZyBm
cm9tIDMwMCBubSB0byAxMDAwIG5tLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggc2V0IGFkZHMgc3Vw
cG9ydCBmb3IgdGhlIFRJIG9wdDMwMDIgYnkgZXh0ZW5kaW5nIHRoZSBvcHQzMDAxDQo+ID4gZHJp
dmVyLiBJbiBhZGRpdGlvbiwgYSBtaXNzaW5nIGZ1bGwtc2NhbGUgcmFuZ2UgdmFsdWUgZm9yIHRo
ZSBvcHQzMDAxIGlzDQo+ID4gYWRkZWQsIHJlc3VsdGluZyBpbiBoaWdoZXIgcHJlY2lzaW9uIHdo
ZW4gc2V0dGluZyBldmVudCB0cmlnZ2VyIHZhbHVlcy4NCj4gPiANCj4gPiBTZWUgaHR0cDovL3d3
dy50aS5jb20vcHJvZHVjdC9PUFQzMDAyIGZvciBtb3JlIGluZm9ybWF0aW9uLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IEVtaWwgR2VkZW5yeWQgPGVtaWwuZ2VkZW5yeWRAYXhpcy5jb20+DQo+
ID4gLS0tDQo+ID4gRW1pbCBHZWRlbnJ5ZCAoMyk6DQo+ID4gICAgICAgaWlvOiBsaWdodDogb3B0
MzAwMTogYWRkIG1pc3NpbmcgZnVsbC1zY2FsZSByYW5nZSB2YWx1ZQ0KPiA+ICAgICAgIGlpbzog
bGlnaHQ6IG9wdDMwMDE6IGFkZCBzdXBwb3J0IGZvciBUSSdzIG9wdDMwMDIgbGlnaHQgc2Vuc29y
DQo+ID4gICAgICAgZHQtYmluZGluZ3M6IGlpbzogbGlnaHQ6IG9wdDMwMDE6IGFkZCBjb21wYXRp
YmxlIGZvciBvcHQzMDAyDQo+IA0KPiBCaW5kaW5ncyBhcmUgYmVmb3JlIHRoZWlyIHVzZXJzLg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpUaGFuayB5b3UgZm9yIHRha2lu
ZyBhIGxvb2sgYXQgdGhlIHBhdGNoIHNldC4NCkknbGwgc3VibWl0IGEgbmV3IHZlcnNpb24gdGhh
dCBmaXhlcyB0aGUgaXNzdWVzIHlvdSBoaWdobGlnaHRlZCBvbmNlIG1vcmXCoA0KcGVvcGxlIGhh
dmUgaGFkIHRpbWUgdG8gcmV2aWV3IHRoZSBjaGFuZ2VzLg0KDQpCZXN0IHJlZ2FyZHMsDQpFbWls
DQo=

