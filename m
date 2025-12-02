Return-Path: <linux-iio+bounces-26619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD15DC9B1B5
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E0354E5430
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B717930DD18;
	Tue,  2 Dec 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="m1ynU7rs"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021114.outbound.protection.outlook.com [52.101.65.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA7230BCC;
	Tue,  2 Dec 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670868; cv=fail; b=WOex815CrIlSaa8qPQWjvaB0vre5RRR9vxwocfpAuPRC1tDum4ZzD5YnmcbsRK+Jf98cSLth9lWczxHj8jS8HL3pc4Ij1aQvIxFmws/NPo+O2tteh8UladOQ6KE39QeV7SvRubmH6Y49+8tdwUCkFuTxXQb9H1TXX/lRmVDt57c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670868; c=relaxed/simple;
	bh=2keDlab4tvaqJegv9BrsBLdPnZ0jP3zyropDKbcUYG0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I9LdNrYgicrLB/ETSGGIUwf6jWw2KeYkj9RST6MGOMEh7u2GjArPbLsAosLlOuad1zGZ/ggY8H9I1uKKGgXDc641xJ6uBGLReEEnogZPOBa0fPpDIzk8WvzF6n2qyTCoOfHaZGjhdQHzN/1drB2VGfm4AizHTEiP8K3ZKw7BDaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=m1ynU7rs; arc=fail smtp.client-ip=52.101.65.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP2SxFr0JyxiCaV5Co3BMZk4VCJnkXbYshR6U5Pxja1fR47cxaTTQaPHjLP01eHzDFaoQFgeSBsvs9sbM6NK/DTuqt6oAw7+bvehw3KBNsATJxSaVv2yhNMCSeL6BqS3ZMbdoOjlLs43/+GmpsllCaiodG5XiALmSvA4hBBx5QOSNKkb+GIYLHGgNDudPqvXFjNZ3WWfmsScM3sP46jJ/74hhP65iLvI5br1jbc9a6MWZujzOxHqN2ISQ0DlTPa4kiKJYnYFv8mTTXQ74+N2xR9I0JT7WmxKkfRDrKJhD26qOO/vIn8k8d4ciYH/YcOwfvQs4oNDFsZw8Ykyix0aHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbNw3VYHxecburOiX1IhT5YAhL7or8Ca5aDGjvKmfNk=;
 b=HO33Z16Q1hFQWo8H9TmfenZZl2UKRIxR7s0CbjGEf0RhiQ0FHlTCsXBAsjyrsQ2TarVYuY3wEsiOJ0xFXUCkL2AYrgLmcZM+k7ZujJyxbYsNFwPZxOcwUgXmWlUS+EaQdmfufRoFoSKI9dj/+crEREc08VDj27W5rSg/y9SD3ePapV0qWiiGpgmVxVCKAXlKxBx7cke64yrWDrJT8c+BiSiwlcmhGoGXFMXYMIhvlBNaAgo1sGahEx6BjE7Vc0Ma7g5R4Hfnw6zcc9Bp/j364tYTwdhvf6eww6vWP5kOZfK/nC5Y7yVraLOdjUaKhEFyZxuXtPhOzhVEWxYx2f1ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbNw3VYHxecburOiX1IhT5YAhL7or8Ca5aDGjvKmfNk=;
 b=m1ynU7rsabeThIkffRnTLtoPqvQgjXWTaE3F59Ksniht/5EQq023uq00E/oxxMTK1Odtvv8uUB8vzRxPZNuW1wPCiXH5aELrdYoICxtRBg5FewGxr1xYXFFn0FZuyf4IU9viDQS9J9zhPdIqYSJGvnsn+JeNEImBxGVl2+7R1zQnIhxJiAz23SzLLDMZsN56XmGVREoKB0hNkKrrwEMsYaXl9xsMxXeS0QUR7gei5mlPBrKVjJTWsG6ayi4cJbnSkxb/F3XMJGz10DZu7+DGBrDFGfd5ff1O2AsLlFBfxJJVYxjOcrxDsWqARaGV1TxH6Bs8XAgujMfwooIy/J3+9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DB9PR06MB7562.eurprd06.prod.outlook.com (2603:10a6:10:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:20:58 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:20:58 +0000
Message-ID: <9f1ba4d9-8a94-4445-988a-56725a197a1c@vaisala.com>
Date: Tue, 2 Dec 2025 12:20:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ad9467: support write/read offset
To: David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com>
 <20251201-ad9434-fixes-v1-2-54a9ca2ac514@vaisala.com>
 <7e042d4e-0ca6-4b2c-9b65-79593a526b5d@baylibre.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <7e042d4e-0ca6-4b2c-9b65-79593a526b5d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0293.eurprd05.prod.outlook.com
 (2603:10a6:7:93::24) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DB9PR06MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9e1d96-07cc-4e15-f5c8-08de318c7c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rlc5cmpFVjhSMTZlSGhxZFRheDd4a29uNk5CRVpNemxpNFJHWU04b3I1cjZR?=
 =?utf-8?B?cmp6UjlMVjZJOXZzSzlLWkRtaCtKR2NZeks5SDlTY3hqU0dpS2ZuM2lCcGxq?=
 =?utf-8?B?TzlxYWVWTzBNNGdVMTBCUmUyK0hIQU1QbXE3d1cwNGVZR29JcUZrc2pwRWt5?=
 =?utf-8?B?Q3lhMzdwUFFYbk5McHNWZnVzOGF0NmlaQWNzcmNMUGQwM1NoWCtFajc2cWJr?=
 =?utf-8?B?VkQvcjg2eW9uMm1veHR1MmhBUTJWVitaWHU3ZWFDKzYxa08zZlBsUVZ3aHJm?=
 =?utf-8?B?Q3Y2NThvU2pBL0R5VVFzYXZSYUVzZDIzQUI1aTlpTjlRT0lrcitBRDVBUlRw?=
 =?utf-8?B?M29FbmdXWmlIaDE2Mk9pTWJ0VGFQWnROc3VxMTZ1ajQ5U0RMVXIxUnA2dkQ2?=
 =?utf-8?B?L2pYQWpXY3d5bXpDOTN5SzJNRkJlTzhGSEVhcFArbGhaTS9mbU1PUnBhQzQz?=
 =?utf-8?B?Z2I1Mi93dEhIaVlHVkExUU1CRWdoWEg5Q1FrWWh0SHkzRE1GRHN3dlhHcmV2?=
 =?utf-8?B?U3BGSnlzaW9BbXpzejBnck5MaXRudkkrZHZkTTdoWXN2OWdpSEVVbW1VU1oz?=
 =?utf-8?B?eURWSmVwUGowZ1RDbGVMdlg5VXV3QWhQVGRSQTVETVJaYnFQVm9oVkpUMGhW?=
 =?utf-8?B?R3NqRGlLNm0zTDZtb0U3c3B0Rjk4MTMzK1JiN0p1d2tPaHlzckF1R0d5S1V1?=
 =?utf-8?B?bzBiZUxkVy9nSkwrREVyWVdWZWErVFdHelUzWERjQTJJblpIenE1alNFT042?=
 =?utf-8?B?ODNyMTdzRjY3MGRrNDQ4SEM4RzBnQ3ZJTUlHOXlCZk9lM2ZDSzAzSUhsVjFk?=
 =?utf-8?B?Q0RsNDJta1B1MlVmVzFDd25VMmc4Y1FISWtUTytIa2xRdFlmSHVQVm1rbGE5?=
 =?utf-8?B?K0d1U2swTTRWVW91ZHg2NjJQQlVnMlNKZEVscXk0WTI1TTBQQXlmZjVGZ1p6?=
 =?utf-8?B?ejhMQ0Yram1ENmcwcDh5ZEpDemNFTHRFcFQ2b2MwbnhMT2I2M3pIeGJUMk1J?=
 =?utf-8?B?NmdqUGM4c01TcG1tdHNnQjNITmMydzY4Mkw4YnczNU52ZXV3SklyUWJ4R1BE?=
 =?utf-8?B?bGczb0VranpzZ0tmMEkya2hXcldQdTA3ZWdrY1AzdFRHYitPOTkwQVJMR1Jw?=
 =?utf-8?B?bG9rS3hQZkcxUXdEdnlRQ2FPcW5qZ0dqekYrTVFGejdWUTc1dmVWcFhJWTZy?=
 =?utf-8?B?YUZQcFhoeXBRbjAvMi9ZSUpQc0xpd1JtNURLNjMxZUtFT1pLUlM5R2RTMGtX?=
 =?utf-8?B?dm1Yd0psNWlneVE0bllxdFhoU3dpRjh4UXZwbmpPZ3lrQmJ3VWZ2eEdzNC85?=
 =?utf-8?B?SXZmRmNBTkwvU211d2ZoT3NnNnZtaUhoeVZaUVBqUWNndkxKckZqN2IxL3Z4?=
 =?utf-8?B?UEhTRHZ5UTFrZGxHckRBbTZjbTlBZ2RabVdWSmNjRitLY2NxQUtWdXQ3OW1y?=
 =?utf-8?B?V1pSNWtQVzgycEFGa2Zya1B1QmhpVEkyYWdTanlpMFRLb25KRjI2TFpLWVVY?=
 =?utf-8?B?RXQ3dU9uU1lQUXNNOTk3TGxNRTVkMTBoQndaSnlEbnliMHBIRzA2YjBlelRk?=
 =?utf-8?B?bDdxZlBSbXBsVG5EVkJMYzdIY0JqNWYwSlQ2MlY1ZzI2Z09ZTGQydG9Xd2RP?=
 =?utf-8?B?MEdCQXhEcllHU2xrU2xXL0tzRHE2Wno1cjVqMU9hVW5sYkxiQUhwNHJKQXo4?=
 =?utf-8?B?QUluTUMwK2VMM1drMVErVnN2YUpFdE4vWGRQd3kzTG1KWU1UdWtnVFlpRU8w?=
 =?utf-8?B?akU3RHlsY0lqNC93Sm45a1Z2UzE0YjNaTnpKQTc2ZjNoUG5INEJ4L09RWG9I?=
 =?utf-8?B?NnJodnIwQ1lFZGVZUFdyMUJKcHhUYzdsOEpwRE04cFV0NHFRUEVnOWg4ZTgx?=
 =?utf-8?B?YXU0QnJVTkUzY1NCUzNUcCtlS2JhalA4dXBzRk1zVFdzUDd5dzhFbUJEcXR6?=
 =?utf-8?Q?cInlQxcQM84koU5ZczbzfGpxiqVasJ6J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUtSbytZRlpiQjBEbUN0VDIrYmt4WGNHRkRSZGtaaG9KeEZ3bG03NjVBclBu?=
 =?utf-8?B?R3FlMVJTUGpJR21iaEFHUENQaDNBejZlTmdqVG9BaHZhOURwY0sreG4rV1FT?=
 =?utf-8?B?RWcrL1ErVGY5dDRMaUo0Wm1KMytRaWVqWWpXcGgzaTVmRlJQOGtDVmRycDdu?=
 =?utf-8?B?OXNmWlFnUzUzeVpab0dKc2lYSDRKNTYvU3liZHVHaXFTSlFoN1g3c05aR1RE?=
 =?utf-8?B?ZTZ1TjF4akpMR1BUbytMRi9JdDBFTUVTU3QzRmQyVjZkQzZNMFJPRHd5RUY0?=
 =?utf-8?B?YTVvSXc5bzJTQXM1elFDV2VTS2M2VTZ1RkZDbStwMTQwR0VKVzZKQmFMcjRK?=
 =?utf-8?B?blo2SkJCZ2dGSGZiTVF5ZzNnSzNtYXh0RmhFaVhtZ29nT0VNWkNhbkxCZUpW?=
 =?utf-8?B?TkZOekRPZEdlMS9EaFJYWHh1RlhXeVdmVkVUM3hiRmEzWU45cVJkMGs1YnhB?=
 =?utf-8?B?K1c4TldDWHYzVlE5RjdCMXliRFpPU0x3NUdGcXFuc00vVFFYR3d2WWh0dkhD?=
 =?utf-8?B?bUtpSUc5aVp0ZEpMNXJEOE01Q2ExVkoxMWYyMC93YXpXdm9IUUlsZHNmUW9M?=
 =?utf-8?B?a3ZnUU0yOTZWcDV1eTA5bkpFL1RUUWg0aGJPQTNjRlFHY2ZBQzd5bVIwVFZB?=
 =?utf-8?B?dFpTeEZhelBVTXdzcHdsUFVaRTFrS25BdndPVHl1NFNNZmFnTWdHc0JnRUQr?=
 =?utf-8?B?RksrNy9qRW4wcTBEbmliTUV2QWowMnlDSlVuanFmSHJCOW9HR1QzaWpIRU01?=
 =?utf-8?B?MnZxVEJnTHl3Mml2TlZnVU4wNzZVTjdMRzd6VjJZZkwvZlByb0VYSnozSStt?=
 =?utf-8?B?cDF0L3BMVFpYQ1NvTm04ck40OTZuRjdTcmRKREs0bHlPUVBuWHRNZmgvWitH?=
 =?utf-8?B?S2VvbEx1UHVtS1p2WFdOUldaYldEaU53dC9sVmNzSUJZdTlNNzcxYS82Y2Rz?=
 =?utf-8?B?dVdhNWl5Qjk0dHFENmxJazRzYlg2Ym9hTnZiZjZsWHplSlJ6WTd1WXRZTWls?=
 =?utf-8?B?Z2lPVDhtZ2w1c25VaTVicmU2T2svN2FGSU8rbVBhbWprQU9IbGdFT1NNNkN2?=
 =?utf-8?B?a2Q4Tm5SVTVudVl4N052TkpCcDFBQ2UvUk44R3pUeGFpUnNqaHNpQTEwSTZZ?=
 =?utf-8?B?cmplRmJtQmJNdWw1U3oyZjRoUTh0SDAyVU8wTThIZ1RZd0I4c0V2SDNPOE5H?=
 =?utf-8?B?K2RFeFVjRUQ1ZytsT0s0dGhQZm1mRC8xcXZnV0FlNTgvMmVVd2lKWnozWTJV?=
 =?utf-8?B?ZWZFaU9RVndldU5Hc3o0Y0J3R1NZK1dkSlhtL1lYaXcraENKZDBJUVR6WXR0?=
 =?utf-8?B?SmFxRWl2d0E5T0xSb2lIc1hpR0VEWm9ZS0tqSTY2WUF6TnloYVhTZS9vYm5l?=
 =?utf-8?B?cUphaWpYSEFpZC9HcXBKYkZHTnFzblJQWlp4QVVsY3U5WWNqcmkxV0tZUkpQ?=
 =?utf-8?B?bENoVXgzelhuQmFBc3dCT1kxYkFwczBhN1MxblM1VlNGVkRKblJCRHk2OThm?=
 =?utf-8?B?UEZiM0FLaFdpRk80SzhkNVdGSGIyZkF4Z1lzdnVoY2k0eFl5S1FxMnY3cFBB?=
 =?utf-8?B?THBWYzhWendROU0wWWFUYTh0aitPeC9wd1dxZS9JVVFzSllSTVBaUDV1L3d3?=
 =?utf-8?B?aGRQbHFMSEtxRnRWc1pmMTE0M2hmYml4SmZ4UXVtcEcyTldUMXZob0o4amRP?=
 =?utf-8?B?ZnVXOW1qaW52aEE2Zm9MUXNVOVJjc2J4UzYxVFU4RVNQd0N1TzVDK0ttdzdh?=
 =?utf-8?B?ei9JUFJtWTJXSGxSN3JLbGhadEsyWEtQNm1GVG9VRnlUQTlxRFpDMk1tQXE3?=
 =?utf-8?B?YlZyZ0VLY0p6T3pOU1hRSGM0Y05hZkVUTVVydzdEWTlGcTlkY0JlUTRaZkta?=
 =?utf-8?B?VWtkdEtXZ0h0TEYrbm9ReU9ZQnVHQzk2OFJHWW5ZakJoU0tUbTYrdjBzejFI?=
 =?utf-8?B?dHdiZzdPbUVpWVZ1em4yRWd5R1AyZDd6dEFBZnNDTEtYUmxJa0RrNWtqMW1Y?=
 =?utf-8?B?eHVwTldFcE9wcHl3VUZRdFdxVzV4am5Tc0JPZzVWWDNMRnRzendCZjBKbjBm?=
 =?utf-8?B?aUcxNTBUSlpOVVkxYndncUErLzk0UURxdDlmN2VScGxHcXlRVVVpbmhCaTNz?=
 =?utf-8?B?eVhPWTMxbS9lTHV0eW5sMEdKQ3JST3NLaEI3ZmxTUGxuelJMenRZYkltUTBo?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9e1d96-07cc-4e15-f5c8-08de318c7c70
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:20:58.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUeLFvDM3fHgEXyMIDoeX8u74mbCAnxqnTZZrs5rAK8Hzp2WgJKFYy8mbdModsdKsOSrNkQ9VtNgpoloRuX9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7562

Hi David,

On 01/12/2025 19:40, David Lechner wrote:
> On 12/1/25 5:59 AM, Tomas Melin wrote:
>> Support configuring output offset value. Among the devices
>> currently supported by this driver, this setting is specific to
>> ad9434.
> 
> What is the purpose of adjusting the offset. If it is to compensate
> e.g. for manufacturing variations, the CALIBBIAS might be a better
> choice. In any case, the commit message should explain a bit better
> the intended use.

This is indeed more of a calibration. It should compensate for
difference between expected and actual output. I agree that the
CALIBBIAS seems to be a better fit.

> 
>>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>> ---
>>  drivers/iio/adc/ad9467.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
>> index 2910b6c5b576d101a25c0b5f0fb9024f0b4da63d..41b29e9e765b4296358bb277d63993889ce46290 100644
>> --- a/drivers/iio/adc/ad9467.c
>> +++ b/drivers/iio/adc/ad9467.c
>> @@ -145,6 +145,7 @@ struct ad9467_chip_info {
>>  	unsigned int num_lanes;
>>  	unsigned int dco_en;
>>  	unsigned int test_points;
>> +	const int *offset_range;
>>  	/* data clock output */
>>  	bool has_dco;
>>  	bool has_dco_invert;
>> @@ -234,6 +235,10 @@ static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>>  	return 0;
>>  }
>>  
>> +static const int ad9434_offset_range[] = {
>> +	-128, 1, 127,
>> +};
>> +
>>  static const unsigned int ad9265_scale_table[][2] = {
>>  	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
>>  };
>> @@ -281,6 +286,23 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
>>  	*val2 = tmp % 1000000;
>>  }
>>  
>> +#define AD9434_CHAN(_chan, avai_mask, _si, _bits, _sign)		\
>> +{									\
>> +	.type = IIO_VOLTAGE,						\
>> +	.indexed = 1,							\
>> +	.channel = _chan,						\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
>> +		BIT(IIO_CHAN_INFO_OFFSET),				\
>> +	.info_mask_shared_by_type_available = avai_mask,		\
>> +	.scan_index = _si,						\
>> +	.scan_type = {							\
>> +		.sign = _sign,						\
>> +		.realbits = _bits,					\
>> +		.storagebits = 16,					\
>> +	},								\
>> +}
>> +
>>  #define AD9467_CHAN(_chan, avai_mask, _si, _bits, _sign)		\
>>  {									\
>>  	.type = IIO_VOLTAGE,						\
>> @@ -298,7 +320,8 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
>>  }
>>  
>>  static const struct iio_chan_spec ad9434_channels[] = {
>> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
>> +	AD9434_CHAN(0, BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
>> +		    0, 12, 's'),
>>  };
>>  
>>  static const struct iio_chan_spec ad9467_channels[] = {
>> @@ -367,6 +390,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl = {
>>  	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
>>  	.vref_mask = AD9434_REG_VREF_MASK,
>>  	.num_lanes = 6,
>> +	.offset_range = ad9434_offset_range,
>>  };
>>  
>>  static const struct ad9467_chip_info ad9265_chip_tbl = {
>> @@ -499,6 +523,29 @@ static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
>>  	return -EINVAL;
>>  }
>>  
>> +static int ad9467_get_offset(struct ad9467_state *st, int *val)
>> +{
>> +	*val = ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
>> +	if (*val < 0)
>> +		return *val;
> 
> 
> Since processed value is (raw + offset) * scale, this means that
> the offset will be applied twice, once in hardware and once in
> software. I don't think that is the intended case here?
offset has not been used in "official" way here. But I think this should
be sorted out if moving to CALIBBIAS?

> 
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int ad9467_set_offset(struct ad9467_state *st, int val)
>> +{
>> +	int ret;
>> +
>> +	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
>> +		return -EINVAL;
>> +
>> +	ret = ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
>> +	if (ret < 0)
>> +		return ret;
> 
> This could use a comment explaining why we need to do the sync after
> adjusting the offset.
Certain registers in the map needs the sync to take effect. I can add
comment.>
>> +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
>> +				AN877_ADC_TRANSFER_SYNC);
>> +}
>> +
>>  static int ad9467_outputmode_set(struct ad9467_state *st, unsigned int mode)
>>  {
>>  	int ret;
>> @@ -802,6 +849,8 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
>>  	struct ad9467_state *st = iio_priv(indio_dev);
>>  
>>  	switch (m) {
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		return ad9467_get_offset(st, val);
>>  	case IIO_CHAN_INFO_SCALE:
>>  		return ad9467_get_scale(st, val, val2);
>>  	case IIO_CHAN_INFO_SAMP_FREQ:
>> @@ -836,6 +885,8 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
>>  	int ret;
>>  
>>  	switch (mask) {
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		return ad9467_set_offset(st, val);
>>  	case IIO_CHAN_INFO_SCALE:
>>  		return ad9467_set_scale(st, val, val2);
>>  	case IIO_CHAN_INFO_SAMP_FREQ:
>> @@ -874,6 +925,11 @@ static int ad9467_read_avail(struct iio_dev *indio_dev,
>>  	const struct ad9467_chip_info *info = st->info;
>>  
>>  	switch (mask) {
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		*type = IIO_VAL_INT;
>> +		*vals = info->offset_range;
>> +		*length = 3;
> 
> We don't need to specify length when using IIO_AVAIL_RANGE.
> 
>> +		return IIO_AVAIL_RANGE;
>>  	case IIO_CHAN_INFO_SCALE:
>>  		*vals = (const int *)st->scales;
>>  		*type = IIO_VAL_INT_PLUS_MICRO;
>>
> 


