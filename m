Return-Path: <linux-iio+bounces-19739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6AABDCDE
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7456E8C3EDA
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A951F24EA8D;
	Tue, 20 May 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MdgnST7o"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338E1ADC93;
	Tue, 20 May 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750797; cv=fail; b=Qe58ttO3gHDvhdHWJPL17k6aJzuL6DIscAln30vIXeaGa4t3bCGdxW5yZvNjkSgMhA/IlpUfCYFt40QqQFAUOsPUdACp9ydMD5PxYo+C7CHuZt6VEj36EmyCF2pBmJfry6L79zdIRhkgXR9MctHFDxyf0zYIAgn2cho/GtbULvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750797; c=relaxed/simple;
	bh=hBQxBvM5s9avPSn9/GDVdPNdRs6Dv0JKzaLJg0x7abg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bb2d9PIfTsb1wAPBy+e47K+9qsnNd4S5p7t1lm6GEcWLN8FmsbGoV2R3hx5R85x3eaK+q/bBwUBEgZ5E0tJsOhG1v4G3F/QXBXdgBab40HX6Hs9oH3XvplKq+gU626jMA9YoSaRcGLHXQzOpM3I/B9dTOCru9UDXu/kkvdJdtYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MdgnST7o; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQdmyCgrbu5iiPv3Ego7DWqxs55CGjZ43eYLHNFWFBhlLwGqJZicw0FAPnssOrHghbMWfcENISDLNVhJqut8SIXq2WMgBoqDXMopBDiVCLcgTVciP606kVTDd1rBG2RTb0/uVk4r5FfhxJK99Ppce6FWNxrAKO3iZGZ0P5dF/tVcD+IhesLHlCUQq6+2f1mKYm0DNCA532LTgeXMUfN8p38zx4TnKCPSQPfRf/STnOdG8WtsqwvaWajlkOovPjnLLQ1vr1luZ0q+GuM/wJi7pldie2ZI5G7gnkBa7e6/VMPz+trRJmx2HQXbK5Of+fBSdgFi5bihQl2adZ+RqAUFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBQxBvM5s9avPSn9/GDVdPNdRs6Dv0JKzaLJg0x7abg=;
 b=oE/lZutCUSip367ZtVAIQqy1QWKIi5FStOHkmH6uTgJ3VdfpvYbUXbfltRzdVf26zMHpTdfQS8y/kOxL0NKQKwBFH61gZJAoKk1TtLPLT8NbvHmgkXrlfgt785Imb97dPTSdnXHWxljBktEdxqmdf+OAG36UVjmzIT8jglFeREvE2fpBIpszRmXvn0ehoJ7Mdu/TeN9iqB7L4I2/1iWAenHAqA6LRHce/F4Tzo7/FxfoZ4rcMCcISSsaAgDAtgz6xR+BAHTeKtDBjp0gVnOkUqsfmFJkSw5kyhfn4x9p/KDOM3lLfJ4GDUVPX4MztYoKYD2i/yigcVTwbPWgY01z8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBQxBvM5s9avPSn9/GDVdPNdRs6Dv0JKzaLJg0x7abg=;
 b=MdgnST7o+0xqyI3Uoi2iLrNdxCNz9sQUdwTm8WzGy7IMHV0z0ArFOhY9Ny8Rvtkq9uNpt3qKIxWJyPBnenx/8XZ/8z8Di5xLh9MbFa/ZAd5uiIWGRvN8ffg+P+QZok9Vm08G9R0Rl6VJgq3+hSHAZpLuKYgDiTvGtxnHWJT2M+sPYkTavEDtdIlq9vBXrAKLTd7gOf2YQmqaj/2ARryC54nV4CgFf0CKAHtd3c639JIuwo82ghM8fslH5bihux0onzaaINRomnQyGkYYBpQpE518ud5Fcsz8XqkCdCPTE8TK+1IVWxejgbfT2xU+dkvcjBDPPaebtIj6cAaO7WyY5w==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by IA3PR11MB8893.namprd11.prod.outlook.com (2603:10b6:208:577::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 14:19:51 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 14:19:51 +0000
From: <Dharma.B@microchip.com>
To: <wbg@kernel.org>
CC: <kamel.bouhara@bootlin.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Topic: [PATCH] counter: microchip-tcb-capture: Add watch validation
 support
Thread-Index: AQHbxVYHRivDm+CKUUG+7oFIi18WIrPYBeIAgAHGYYCAAZvDAIAAMcwA
Date: Tue, 20 May 2025 14:19:51 +0000
Message-ID: <7b853b4c-1a25-455b-a515-0188e8e37b69@microchip.com>
References:
 <CV37uwi-rAqU3els0ckl4KLz5ortFAdc7XXy7ex6-MMhxvptyeMh8vTBXQuZliairKQ1Dy4yM3MyE8o7EZ6VfA==@protonmail.internalid>
 <20250515-counter-tcb-v1-1-e547061ed80f@microchip.com>
 <aCmPLn16Ykabvhjv@ishi>
 <axFMnvsS0JXIwXl665iZU5CeLOIRgZCScixNFgE72GD8NpyMB3FfJDDNxIDSJrPhov-HLXkGiOPEr8fNsltCIw==@protonmail.internalid>
 <823cefaf-b225-4531-8733-5d90d3ccceb3@microchip.com> <aCxlwAgX2A0dVn5l@ishi>
In-Reply-To: <aCxlwAgX2A0dVn5l@ishi>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|IA3PR11MB8893:EE_
x-ms-office365-filtering-correlation-id: 2f389394-0bd5-463a-19e3-08dd97a96270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T05aeWoyek9IWGNyTDNBOGF4OXpZQUtrb2NMNFFUQzdqTExaVVlnZjhwdTRz?=
 =?utf-8?B?djAvZ3JVaFFhUi9xeFVrTm85RWh6cmpBaWFGWjIzd3V6SGE3VzRGc1NUQ1VL?=
 =?utf-8?B?QkFTWlhEUzRaMHpFQkQrTWZnd250UGFXSjZXMk5ScytWZ3duSlNZUk5XdkhO?=
 =?utf-8?B?cEgrOUlmZzJTdVplRnhkYkhtQjQ5QklDNWIzUzk2am5aV21oYXZhbWhHejBs?=
 =?utf-8?B?MUdoTU5TVWljWGNHNVZ2L1pSMFFaMXlscndYUXplSU1PSmtnbEpUNTVVeStm?=
 =?utf-8?B?THVKMStSWmlJM0tUclo0V2xIMU80cGEvb0crRzhrSWUyTC9jUVdsNzNTNU9w?=
 =?utf-8?B?eUdJcG1GaXBOT2tPeGVwTDJLdnVnc0VIMFdaL2dsTVlKMk5HNGVlWC9BeTl1?=
 =?utf-8?B?NUI5dTYxQ0VWUEJHSExaUXZhV3RTZEN2Umd1ZEdMQkdMdk1CRFhjb280dERD?=
 =?utf-8?B?TkRudnRqNW5nMUV4Z25sY1JOUkNjWnZoVlA5R0dKazl1MGZldkFhQ09TbEky?=
 =?utf-8?B?dmhmVnFGQUVUTFFURldsMUNiZGllVlRBR3ErUG84bkZqRUlkYy9vVEFvWE0y?=
 =?utf-8?B?aERFNi9sUUpvWE4xNnFnS09tVXJIWGxmMHNsUGp5d1VyVFV1WTdzSUMrL3kv?=
 =?utf-8?B?TmE4NmNyZWtzUFFKZWxwb0pkaDNVUEVYR3dQMGc1bzJ4OHNLMWlIODA5YXRX?=
 =?utf-8?B?N2ZzcTk4K2lvT0FkRVZ3NzFyY1V5MEZXSWpPZFYxMlJFdkJQY3R4Wk5uTW9p?=
 =?utf-8?B?YU5QZWpoM2gvbzUwMzdyMXZIV1Ewajk2RlRwQURIVUUvMU0yM1NSMUc4Q1U0?=
 =?utf-8?B?Q0ZsWVlCbWZ0ZlYwdzJQS3M2R2hYYmVQditWek9kOTZSdk5abVFXUWdtZGRj?=
 =?utf-8?B?Z2E0Y3VxTGE0M012bXpRTk15dGRsTUdEaklXWFd2azJzTmpvZmRuMExmdUlt?=
 =?utf-8?B?UWoxWXNNUnRIRXNhSklZbjl0M3NpRDZDMDhRSHg0VzZwZWg5YStianZHbUV0?=
 =?utf-8?B?T1FHT1ZjMnZwN1dDTlNJZlo4anI2c3dyMFdoTFVhcWZwR3p3c1BjZkZYUGpp?=
 =?utf-8?B?TmdFaE1YQnd6WHRueHprUUR0K1VnSWlhNmtJNlZKb2d5cGJMTEhxbk9DYTBF?=
 =?utf-8?B?ZVQwSW9ORDk3VDEzNzFtZysxYVVPMWlhQk5vM21HeHlEWUFxQTNJRDdoQjln?=
 =?utf-8?B?aklXT0xkbUY5QWJzMW1ablhnTWU4OUtodGJLS21iV21yNTVydHl6bnF6amhT?=
 =?utf-8?B?aitncHZFMklBdkIvVDg4cXNXTTllWm5qSnVPODNNbk91QkgxRnVyR0dCVGNo?=
 =?utf-8?B?WUNnVFFwYXZvTktwUWQ4dUwzOXdhdXg1RzhHeUQvN29hL0FXaEtBam9yUVAv?=
 =?utf-8?B?aFBTczhTL3R2a1h1RFdBbGxDbU8vTHIrZWdNaVhjVmlBcXBpMkJKZWpRV3Fq?=
 =?utf-8?B?eFdrY2h2SU9FTmNSR2VBUHhNclJXRXBxVVhKWGsydjdMWEtUL0RYU01PVkxV?=
 =?utf-8?B?aXRTRUlqQ2FITUJjZ3pvckJWekRVcytRNlhDNWNZTURUa0M4NVJWSmVpOWpp?=
 =?utf-8?B?MEh1T2s5RXovd3lCREp2RzhBMHZ5VmkzcjcrUFZxTHFMK0RLN2pPNTFFQS9U?=
 =?utf-8?B?MDlVQjdzMTdxVW9qLzZKQUpUYjBIZVdnL21obC9TOGwxUno2bVY2Y1pvN0t0?=
 =?utf-8?B?bEFId0UzMnRVNWhIdkN0ekJXd2lWd0R3QUZVWkFENmtDSXlCNW1XSDZyNVlR?=
 =?utf-8?B?ZG40YmhTMElEK0pSZ3RuYmo5R2dyS1pjcG55b25tazFZa3h2YjBjUGlVV2sr?=
 =?utf-8?B?aEM3Rm9BTnZtSVljeEFEK041SW1pY3I2NmRseDcyQlJTZGt4aGVTaEQrOUJZ?=
 =?utf-8?B?Yzh2TVZhRmRwNzNGZDdWTzg5TUZDNldLTVRVRDcvaHlHUVdtb3BhWXRsb0tO?=
 =?utf-8?B?b2YwQk5WRlNPTzh0MWphWlc1STJGQmZuTzRjTEVkYTF2L1hLcFFOTXloNnN2?=
 =?utf-8?B?Sm4vYkhpRkx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEZ1VDZXQ3RrZEVHOUg4dEZZaW96OVh4WnY3NWRCUFNSa3ZUMm5ybUxkUFhF?=
 =?utf-8?B?Z1JheVZjMHJjbXNSUWxkWGdBWnRDUGFVcUhOTnlNcnpqQkFtOHV1S1dxbk9n?=
 =?utf-8?B?eDF0aDF1WlY0UC82L1ZCNHhRelhSbUM3ZWxoYjJnWUFmNE50OXl4R1pWTFAx?=
 =?utf-8?B?UzA4bkhONnpOSFMyRUtwUVBFUjdOUUtVYkVYdStEbmREV04yOVpHbW14ZUFr?=
 =?utf-8?B?NWpZRGl0bXM5QmNmZnlMMk4yR050U2pDbzVWVzFoeUI1d0hvK2ZWSG1MQm1N?=
 =?utf-8?B?d05obWx3bjB2SWdpODNYV1BxcGtnQURJcmdodmduQW5GZC9ieDJmSW5DNE1t?=
 =?utf-8?B?Q1JaTFlKMUZqSk5rNkllbkx4Ynh6UEFIcjdrcDNNb0dhamh6NWU5NWd4STJ4?=
 =?utf-8?B?Wkd5UVNiRHk5STBqUmNaT28zRy9heS9MU1B1VFUxL0FDRTV4S0NWdFJ2aHo2?=
 =?utf-8?B?bnduK2MzbGc2aXdwT1hscFI0Zk1oNnVOQ1JpUitSUU5JUmY2R0pSSjl2WlRZ?=
 =?utf-8?B?ejRyd3YvMC9Ud3VCK1RFODZ0MldDUS9nY2RwU0kvanpScFhnWDRWV0tBOFpS?=
 =?utf-8?B?cWRtVEdQcytKR0xHOUtNZEZ5aGpxUG5KOWZNYlNoSmJpSTlRc2JhUlVZVTVm?=
 =?utf-8?B?TXlUU3pUOG1GdlFFNzdVV3NRU3RtMjFLaEJET1pLR21tS1E3azBLSU1NellQ?=
 =?utf-8?B?YlcwcWdTdHhrWlJsN3QvQTdNNmE4a25GQVA3QWQ3bGxLMFFGV21XUjE0Nlg0?=
 =?utf-8?B?Y3oyUkpuakhuYlhuRVFNNlYwSmRxMVRqT01uMEY0M2Fya295c21YZHRQQk12?=
 =?utf-8?B?dEtLZktPMGFOb1FnMnZPTEl3dlUwdzNaM0UxKzVVRmtQMDluSnJZZUh0cWNM?=
 =?utf-8?B?STJobk9FcDZvd1hSaVRnR0w4b216eWpjdTlCK0lGZjZTRCt5Lzh5MmFlMDdU?=
 =?utf-8?B?b3VTYzdFVzVMTkh1c0NNbzZ4bVh3S2Vtd2poeEcwZGtxMDg2UVk4QnZDNWl2?=
 =?utf-8?B?bGtzdHg0b090c2IzNnJUQ3FjUUtHZ2hCRzFNSFZtT3d3clB3YWR5MFpGNU00?=
 =?utf-8?B?MW1WcE56Qnp1cm1VcnR3a09XN1lyYmVaMzl1bFhNUjdPWW93Z2NORTlKV0lV?=
 =?utf-8?B?WHdJSHhkVUdIT1RpM0g2SWNGdmFjaG9FV2Nsd3M4YmpRRHNULytGOG1XN3dV?=
 =?utf-8?B?VjczWVI0M1IvVmRSUVZ3VnhhVG9VbHBHQUs1bUZmYmVnTzA4a2RQVXZFbURR?=
 =?utf-8?B?WDloaEx4T3BNdTJpZDJLa3h0SFhKc3FieVBzWDE1dC9FalFNMU5VVHBxeElE?=
 =?utf-8?B?V29ZZENpMEFiM2VNMFBCWUlPU0ROaERFVitXZ0VnQ1JCeVNvOWQ2UVJSdUJ4?=
 =?utf-8?B?TENycDJ5aENJZy93U1FZN3RSb09zMkFad050SExBbjQ1WDZGQlV2dUJTSXJJ?=
 =?utf-8?B?YTVhMTVEMWRjU2lCL3FVQjIyNStQZU03U29xdjBITlFZWXFKS3g4MzRkRXRn?=
 =?utf-8?B?djkrRCtoUlBDUTRBcDhZSStGaUVBbkJBSVFhNlpQd0w2aEY3MTBYYUZScU1X?=
 =?utf-8?B?YXpBRzRyMWI5RnlWaVo3VmZMcHVpU09wbk4rRVArZjJiL2ExTmdSeURmUTBH?=
 =?utf-8?B?Ukg2bEJCM2YyRktwMGVXSkM1d0t0RGFwd1dhd3FaZ3diWnltUlZEcUdmLy9D?=
 =?utf-8?B?WElQMjFEZkVDVGY3QmZYQW0xb1NBVHBCVXhzd040Z1pWRk90N05qTitnaWR0?=
 =?utf-8?B?VjFKL3hBUmJ4QVNiQ2NCVjBxSklnTzRuQmQ0bldQRXlNQ3RzQ0ZLbzBnbTFC?=
 =?utf-8?B?NkNzQmphSkFXUDlqZjF4OUhIVXA0UEdqRjlVWXVsdlFjZ2lLYWRucGVsS1Ns?=
 =?utf-8?B?TlM1S0M3bWRZWTlTcmMzbDc2OTI5T1RIZmxJZElmTktzRWoyaUs0WSs3dzlZ?=
 =?utf-8?B?TlpnOW9YQ3ltR0praUZuUkxWMko2MFZUeUZVRm1YUzZjYldsYjM2amxFSkNQ?=
 =?utf-8?B?a3ZRV1BpVTVzNS9NMTZVcVdmYjBhT1ZNRDR5YTg4dDRoSkNUY3FnVHFoYk9J?=
 =?utf-8?B?NEcyMXptSFpwdkg4L3JBTmdMVE9PNEdrMEpqaVNFb0tONDZDejZZZDRpd005?=
 =?utf-8?B?cFFkSE9QcXFJQThjRWkrMlZFTnNFWlorNHpQMHNTNmNSTlNpNVUrYjY4b3VL?=
 =?utf-8?Q?mMpOblDkhXmdOTZWsGsZgDS9MLcLGjP+eWRHM0A6W8Vt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9B744DFACE93E4DA9EFC3688944EC63@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f389394-0bd5-463a-19e3-08dd97a96270
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 14:19:51.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/eIz7uW8lUUISe/ciC1ZF4F3MBBOHx22pUBvgCnYnKisO/OG6oDSDLdiWaVKLxEuX39zipvqEHcCpGxu7FOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8893

T24gMjAvMDUvMjUgNDo1MSBwbSwgV2lsbGlhbSBCcmVhdGhpdHQgR3JheSB3cm90ZToNCj4gT24g
TW9uLCBNYXkgMTksIDIwMjUgYXQgMTA6NDc6NTBBTSArMDAwMCwgRGhhcm1hLkJAbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IE9uIDE4LzA1LzI1IDE6MTEgcG0sIFdpbGxpYW0gQnJlYXRoaXR0IEdy
YXkgd3JvdGU6DQo+Pj4gSW5jbHVkZSBDT1VOVEVSX01DSFBfRVZDSE5fQ1YgYXMgd2VsbCBmb3Ig
dGhlIHNha2Ugb2YgY29tcGxldGVuZXNzLiBJDQo+Pj4ga25vdyBDT1VOVEVSX01DSFBfRVZDSE5f
Q1YgYW5kIENPVU5URVJfTUNIUF9FVkNITl9SQSBoYXZlIHRoZSBzYW1lDQo+Pj4gdW5kZXJseWlu
ZyBjaGFubmVsIGlkLCBidXQgd2UncmUgYWJzdHJhY3RpbmcgdGhpcyBmYWN0IHNvIGl0J3MgZ29v
ZCB0bw0KPj4+IG1haW50YWluIHRoZSBjb25zaXN0ZW5jeSBvZiB0aGUgYWJzdHJhY3Rpb24gYWNy
b3NzIGFsbCBjYWxsYmFja3MuDQo+Pg0KPj4gVG8gYXZvaWQgdGhlIGNvbXBpbGVyIGVycm9yIGR1
ZSB0byBDT1VOVEVSX01DSFBfRVZDSE5fQ1YgYW5kDQo+PiBDT1VOVEVSX01DSFBfRVZDSE5fUkEg
c2hhcmluZyB0aGUgc2FtZSB1bmRlcmx5aW5nIHZhbHVlLCB3b3VsZCBpdCBiZQ0KPj4gc3VmZmlj
aWVudCB0byBpbmNsdWRlIGEgY29tbWVudCBpbmRpY2F0aW5nIHRoYXQgYm90aCByZXByZXNlbnQg
dGhlIHNhbWUNCj4+IGNoYW5uZWwgSUQ/IE9yIHdvdWxkIHlvdSBwcmVmZXIgdGhhdCBJIGR1cGxp
Y2F0ZSB0aGUgbG9naWMgZXhwbGljaXRseQ0KPj4gZm9yIHRoZSBzYWtlIG9mIGFic3RyYWN0aW9u
IGNvbnNpc3RlbmN5LCBkZXNwaXRlIHRoZSBzaGFyZWQgdmFsdWU/DQo+IA0KPiBJIHNlZSB5b3Ug
dXNlIGEgY29uZGl0aW9uYWwgY2hlY2sgaW4gdGhlIHYyIHBhdGNoIHlvdSBzdWJtaXR0ZWQuIFRo
YXQNCj4gc29sdXRpb24gd29ya3Mgd2VsbCB0byBhZGRyZXNzIGJvdGggc28gd2UnbGwgZ28gd2l0
aCB0aGF0IHdheSBhcyB5b3UNCj4gaGF2ZSBpdC4NCj4gDQo+Pj4+ICsJCXN3aXRjaCAod2F0Y2gt
PmV2ZW50KSB7DQo+Pj4+ICsJCWNhc2UgQ09VTlRFUl9FVkVOVF9DQVBUVVJFOg0KPj4+PiArCQlj
YXNlIENPVU5URVJfRVZFTlRfQ0hBTkdFX09GX1NUQVRFOg0KPj4+PiArCQljYXNlIENPVU5URVJf
RVZFTlRfT1ZFUkZMT1c6DQo+Pj4+ICsJCWNhc2UgQ09VTlRFUl9FVkVOVF9USFJFU0hPTEQ6DQo+
Pj4+ICsJCQlyZXR1cm4gMDsNCj4+Pg0KPj4+IFRoZSB3YXRjaF92YWxpZGF0ZSBjYWxsYmFjayBp
cyB1c2VkIHRvIGVuc3VyZSB0aGF0IHRoZSByZXF1ZXN0ZWQgd2F0Y2gNCj4+PiBjb25maWd1cmF0
aW9uIGlzIHZhbGlkOiBpLmUuIHRoZSB3YXRjaCBldmVudCBpcyBhcHByb3ByaWF0ZSBmb3IgdGhl
DQo+Pj4gd2F0Y2ggY2hhbm5lbC4NCj4+Pg0KPj4+IExvb2tpbmcgYXQgaW5jbHVkZS91YXBpL2xp
bnV4L2NvdW50ZXIvbWljcm9jaGlwLXRjYi1jYXB0dXJlLmg6DQo+Pj4NCj4+PiAgICAgICAgKiBD
aGFubmVsIDA6DQo+Pj4gICAgICAgICogLSBDViByZWdpc3RlciBjaGFuZ2VkDQo+Pj4gICAgICAg
ICogLSBDViBvdmVyZmxvd2VkDQo+Pj4gICAgICAgICogLSBSQSBjYXB0dXJlZA0KPj4+ICAgICAg
ICAqIENoYW5uZWwgMToNCj4+PiAgICAgICAgKiAtIFJCIGNhcHR1cmVkDQo+Pj4gICAgICAgICog
Q2hhbm5lbCAyOg0KPj4+ICAgICAgICAqIC0gUkMgY29tcGFyZSB0cmlnZ2VyZWQNCj4+Pg0KPj4+
IElmIEknbSB1bmRlcnN0YW5kaW5nIGNvcnJlY3RseSwgY2hhbm5lbCAwIHN1cHBvcnRzIG9ubHkg
dGhlDQo+Pj4gQ0hBTkdFX09GX1NUQVRFLCBPVkVSRkxPVywgYW5kIENBUFRVUkUgZXZlbnRzOyBj
aGFubmVsIDEgc3VwcG9ydHMgb25seQ0KPj4+IENBUFRVUkUgZXZlbnRzOyBhbmQgY2hhbm5lbCAy
IHN1cHBvcnRzIG9ubHkgVEhSRVNIT0xEIGV2ZW50cy4NCj4+DQo+PiBTaG91bGRuJ3QgaXQgYmUN
Cj4+DQo+PiAvKg0KPj4gICAgKiBDaGFubmVsIDAgKEVWQ0hOX0NWKToNCj4+ICAgICogICAtIENW
IHJlZ2lzdGVyIGNoYW5nZWQgICAgICAgICAgICAg4oaSIENPVU5URVJfRVZFTlRfQ0hBTkdFX09G
X1NUQVRFDQo+PiAgICAqICAgLSBDViBvdmVyZmxvd2VkICAgICAgICAgICAgICAgICAgIOKGkiBD
T1VOVEVSX0VWRU5UX09WRVJGTE9XDQo+PiAgICAqDQo+PiAgICAqIENoYW5uZWwgMSAoRVZDSE5f
UkEpOg0KPj4gICAgKiAgIC0gUkEgY2FwdHVyZWQgICAgICAgICAgICAgICAgICAgICDihpIgQ09V
TlRFUl9FVkVOVF9DQVBUVVJFDQo+PiAgICAqDQo+PiAgICAqIENoYW5uZWwgMiAoRVZDSE5fUkIp
Og0KPj4gICAgKiAgIC0gUkIgY2FwdHVyZWQgICAgICAgICAgICAgICAgICAgICDihpIgQ09VTlRF
Ul9FVkVOVF9DQVBUVVJFDQo+PiAgICAqDQo+PiAgICAqIENoYW5uZWwgMyAoRVZDSE5fUkMpOg0K
Pj4gICAgKiAgIC0gUkMgY29tcGFyZSB0aHJlc2hvbGQgcmVhY2hlZCAgICDihpIgQ09VTlRFUl9F
VkVOVF9USFJFU0hPTEQNCj4+ICAgICovDQo+IA0KPiBUaGVzZSBDb3VudGVyIGV2ZW50IGNoYW5u
ZWxzIGFyZSBlc3RhYmxpc2hlZCB1bHRpbWF0ZWx5IGJ5IHdoZXJlIHlvdQ0KPiBwdXNoIHRoZSBl
dmVudHMgdmlhIGNvdW50ZXJfcHVzaF9ldmVudCgpLiBTbyBpbiB0aGVvcnksIHdoZW4gdGhlc2UN
Cj4gZXZlbnRzIHdlcmUgaW50cm9kdWNlZCB3ZSBjb3VsZCBoYXZlIGFycmFuZ2VkIHRoZW0gb250
byBmb3VyIGNoYW5uZWxzIGFzDQo+IHlvdSBkZXNjcmliZS4gVW5mb3J0dW5hdGVseSwgd2UgY2Fu
J3QgY2hhbmdlIGl0IG5vdyAodW5sZXNzIGEgc2VyaW91cw0KPiBkZWZlY3QgaXMgZm91bmQpIGJl
Y2F1c2UgaXQnbGwgYnJlYWsgdGhlIEFCSSBmb3IgZXhpc3RpbmcgcHJvZ3JhbXMuDQo+IA0KPj4g
Q291bGQgeW91IHBsZWFzZSBoZWxwIG1lIHVuZGVyc3RhbmQgd2hldGhlciB0aGVzZSBhcmUgbG9n
aWNhbCBjaGFubmVscw0KPj4gb3IgaGFyZHdhcmUgY2hhbm5lbHMgcmVsYXRlZCB0byB0aGUgcmVn
Pw0KPiANCj4gWW91IGNhbiBjb25zaWRlciB0aGVzZSBDb3VudGVyIGV2ZW50IGNoYW5uZWxzIGFz
ICJsb2dpY2FsIiBhbmQgbm90DQo+IG5lY2Vzc2FyaWx5IHRpZWQgdG8gdGhlIHVuZGVybHlpbmcg
dGhlIGhhcmR3YXJlIHJlZ2lzdGVycy4NCj4gDQo+IEkgcmVncmV0IG5hbWluZyB0aGlzIGZ1bmN0
aW9uYWxpdHkgImNoYW5uZWwiIGJlY2F1c2UgaXQgaGFzIGNhdXNlZA0KPiBjb25mdXNpb24gYmVm
b3JlIGluIG90aGVyIGRyaXZlcnMgYXMgd2VsbC4gVGhlIG9yaWdpbiBvZiB0aGUgdGVybSB3YXMN
Cj4gYmVjYXVzZSBJIGVudmlzaW9uZWQgdGhlc2UgQ291bnRlciAiZXZlbnQgY2hhbm5lbHMiIHBy
b3ZpZGluZyBhIGZsb3cgb2YNCj4gZXZlbnRzIHN0cmVhbWVkIGZyb20gdGhlIGRyaXZlciB0byB1
c2Vyc3BhY2UgKG11Y2ggbGlrZSBhIHdhdGVyIGNoYW5uZWwNCj4gcHJvdmlkZXMgYSBmbG93IG9m
IHdhdGVyKS4gTm90aWNlIGhvdyB0aGF0IGNvbmNlcHQgbGllcyBjb21wbGV0ZWx5IG9uDQo+IHRo
ZSBzb2Z0d2FyZSBzaWRlOyBpLmUuIGJldHdlZW4gdXNlcnNwYWNlIGFuZCBrZXJuZWwgLS0gbm90
IG5lY2Vzc2FyaWx5DQo+IGJldHdlZW4ga2VybmVsIGFuZCBoYXJkd2FyZS4NCj4gDQo+IEluIHBy
YWN0aWNlLCB3ZSBhcmUgbGltaXRlZCB0byB0aGUgY2FwYWJpbGl0aWVzIG9mIHRoZSBoYXJkd2Fy
ZSBzbyB0aGF0DQo+IGRvZXMgZmFjdG9yIGludG8gaG93IG11Y2ggZnJlZWRvbSB3ZSBoYXZlIGlu
IGRlZmluaW5nIG91ciBDb3VudGVyIGV2ZW50cw0KPiBjaGFubmVscy4gU28gbGV0J3Mgd2Fsa3Ro
cm91Z2ggYSBzY2VuYXJpbyB3aGVyZSB3ZSBtaWdodCB3YW50IHRvIG9mZmVyDQo+IG11bGlwbGUg
Q291bnRlciBldmVudCBjaGFubmVscyBmb3IgYSBkcml2ZXIgcmF0aGVyIHRoYW4gZnVubmVsaW5n
IGFsbA0KPiBldmVudHMgdGhyb3VnaCBhIHNpbmdsZSBjaGFubmVsLg0KPiANCj4gU3VwcG9zZSBh
IGh5cG90aGV0aWNhbCBkZXZpY2UgaGFzIHR3byBDb3VudHMgdGhhdCBpbmNyZWFzZSBpbmRlcGVu
ZGVudA0KPiBvZiBlYWNoIG90aGVyIGFuZCBjYW4gb3ZlcmZsb3cgYmFjayB0byBhIHZhbHVlIG9m
IDAuIFRoaXMgZGV2aWNlIGlzIGFibGUNCj4gdG8gaXNzdWUgYW4gaW50ZXJydXB0IHdoZW4gZWl0
aGVyIENvdW50IG92ZXJmbG93cy4gTm93IGltYWdpbmUgd2UgaGF2ZSBhDQo+IHJhY2UgYmV0d2Vl
biB0aGVzZSB0d28gQ291bnRzIHRvIHNlZSB3aGljaCBvdmVyZmxvd3MgZmlyc3Q6IHRvIGRldGVy
bWluZQ0KPiB0aGF0IHRoZSByYWNlIGVuZGVkIHdlIGp1c3QgbmVlZCB0byBjaGVjayB0aGF0IGEg
Q09VTlRFUl9FVkVOVF9PVkVSRkxPVw0KPiBldmVudCBoYXMgYmVlbiBwdXNoZWQ7IGJ1dCB3aGF0
IGRvIHdlIGRvIGlmIHdlIHdhbnQgdG8gZGV0ZXJtaW5lIHRoZQ0KPiB3aW5uZXIgb2YgdGhlIHJh
Y2U/DQo+IA0KPiBPbmUgc29sdXRpb24gaXMgdG8gY2hlY2sgdGhlIHZhbHVlcyBvZiBib3RoIENv
dW50czogd2hlbiBhIENvdW50DQo+IG92ZXJmbG93cyBpdCBzdGFydHMgb3ZlciBhdCAwLCBzbyB0
aGUgd2lubmVyIHdpbGwgaGF2ZSBhIENvdW50IHZhbHVlIG9mDQo+IDAuIFRoYXQgaXMgY29ycmVj
dCwgYnV0IGlmIG9uZSBDb3VudCBkaWQgbm90IGluY3JlYXNlIGR1cmluZyB0aGUgcmFjZQ0KPiB3
aGlsZSB0aGUgb3RoZXIgQ291bnQgZGlkIHRoZW4gYm90aCBDb3VudHMgd2lsbCBiZSAwIGF0IHRo
ZSBlbmQ6IHRoZQ0KPiB3aW5uZXIgY2Fubm90IGJlIGRpZmZlcmVudGlhdGVkIGluIHRoaXMgY2Fz
ZS4NCj4gDQo+IFRoYXQncyBhIHNjZW5hcmlvIHdoZXJlIGEgc2Vjb25kIENvdW50ZXIgZXZlbnQg
Y2hhbm5lbCBpcyB1c2VmdWw6IHRvDQo+IGRpZmZlcmVudGlhdGUgYmV0d2VlbiBldmVudHMgb2Yg
dGhlIHNhbWUgdHlwZSAoaW4gdGhpcyBjYXNlDQo+IENPVU5URVJfRVZFTlRfT1ZFUkZMT1cpLiBT
byBpZiB3ZSBkZWRpY2F0ZSB0aGUgZmlyc3QgQ291bnRlciBldmVudA0KPiBjaGFubmVsIHRvIHRo
ZSBmaXJzdCBDb3VudCBhbmQgdGhlIHNlY29uZCBDb3VudGVyIGV2ZW50IGNoYW5uZWwgdG8gdGhl
DQo+IHNlY29uZCBDb3VudCwgd2UgY2FuIGRlZmluaXRlbHkgZGV0ZXJtaW5lIHRoYXQgYSBDT1VO
VEVSX0VWRU5UX09WRVJGTE9XDQo+IHdhdGNoZWQgb24gYSBwYXJ0aWN1bGFyIGNoYW5uZWwgcmVw
cmVzZW50cyBhbiBvdmVyZmxvdyBmb3IgdGhhdA0KPiBwYXJ0aWN1bGFyIENvdW50Lg0KPiANCj4g
SSBob3BlIHRoYXQgaGVscHMgc2hvd2Nhc2Ugd2h5IHdlIG9mZmVyIG11bHRpcGxlIENvdW50ZXIg
ZXZlbnQgY2hhbm5lbHMNCj4gZXZlbiB0aG91Z2ggd2UgYXMgZHJpdmVyIGF1dGhvcnMgaGF2ZSB0
aGUgZnJlZWRvbSB0byBkZWZpbmUgdGhlc2UNCj4gY2hhbm5lbHMgYXJiaXRyYXJpbHkgYW5kIHB1
c2ggZXZlbnRzIHRvIGNoYW5uZWxzIGFzIHdlIHNlZSBmaXQuDQoNClRoYW5rcyBmb3IgdGhlIGNv
bXByZWhlbnNpdmUgZXhwbGFuYXRpb24sIHRoYXQgcmVhbGx5IGhlbHBlZCBtZSBjbGVhcmx5IA0K
dW5kZXJzdGFuZCB0aGUgcHVycG9zZSBhbmQgZGVzaWduIG9mIHRoZSBldmVudCBjaGFubmVscy4N
Cg0KSXQgbWF5IGFsc28gaGVscCBzb21lb25lIGxvb2tpbmcgZm9yIHRoZSBzYW1lIGFuc3dlciBp
biB0aGUgbWFpbGluZyANCmxpc3QuIFRoYW5rcyBhZ2Fpbi4NCg0KDQo+IA0KPiBXaWxsaWFtIEJy
ZWF0aGl0dCBHcmF5DQoNCg0KLS0gDQpXaXRoIEJlc3QgUmVnYXJkcywNCkRoYXJtYSBCLg0K

