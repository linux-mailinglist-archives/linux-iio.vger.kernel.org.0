Return-Path: <linux-iio+bounces-22975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51390B2C39E
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8004A029C6
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4730504A;
	Tue, 19 Aug 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RWrfTBGZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012014.outbound.protection.outlook.com [52.101.126.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3B305044;
	Tue, 19 Aug 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606316; cv=fail; b=ZWOuv2YYKMxkJGNCZq3JNB6AxcA2OmkyT5jXsLZFehKj6qseekP/eDkxS5Nu3b3U+GhrgJgEm6dFAnlnr3ReEcyC20+V1nZfSbYwo/CuhNUhlTUmAKbDsXKy+7zjkILqLReagRdI47/hKdXrDhCBf34ZVUpZTi97BtAcSY5DCxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606316; c=relaxed/simple;
	bh=HP9STJ23jqkHAMUeOCUEnV8ec0ksjSery8T7sNGfuxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vs5usKJkPxhoYAJS58eTdK5sp62qRPQ7gfW8MFHL1CkLUCV88O3kqesdGO/xmyTqSbb6uTNlNl0mNVabO5SPA5zfRDPhD+CPMoh6sEVRVtLwkJeop5PocsOp36S+WyAmlS1a4TT6OvwYXpIo9b7fki5hjyxngRBX/oAEcK//SlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RWrfTBGZ; arc=fail smtp.client-ip=52.101.126.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbbOQxJhooY4puRx8mF2z++siPh7yRTVTsU9zScUA5Bl8+mMunC7h1leaL6Tvwx/xMf6ltIRfaClz3BSQg/oFhw1IZrwhKJt4OQPDyuxm1XSR2cyujsYYmfJg9X+tFCy9xVWakg1Jhaws/q/vMhdIY+dhg64nYGVTRSgH7/3F8FCEm8K2co0O4NSShl6Bz2YmP1TQbenq11L1KqBLTBlSTaag8kGfxjGRf1dzC9NUu9+u88RwnWjXLc1HKnnr5EPLOLFQArfcCXu3ttfSE8ZykjGUShRLhHmsmfNgvhLmCzucskZ6qXeQ+A2J8jWmzVK1/82jdMDs8mjfYdbioAvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0PmNrl37yNf1faJKyd4AZ73wgmeLDDVrLq6u8hzbmo=;
 b=GZlpU2rgPQf1uzN+C9eQvatHsy79YwkfPhc3ZNodqYlIX+o2Dc37mV4A+L0QnVuujloL2CeC3TpeCKGMSYQ+GImHOPcuAqQb/5p8yjqbW3R534vZGcNN1nAhw+I+ZS8Ra2EX4yLKhSj2maTR1J/646IET5IwX6QuJQ8gA5lJByOpJ1wWvf5uzo0spWnErZZ2ZVgpEcXdZQ+wre4JQKs4FnFqcf+hefj5DOjv91LFw2FiAhtgKFFrwkEX01NeFOPb4Df10rn2v3d34EXo6HMglDsfSC0R8+2c5L9JRQowfmHLqJI6AAu/T6Db9U/xE46GmS2kpRL+23KCGhWQw7zHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0PmNrl37yNf1faJKyd4AZ73wgmeLDDVrLq6u8hzbmo=;
 b=RWrfTBGZSKior5fhzR3YTBkqGjrEkL4PYSoB4Wf11tD5aKox6jftc6lMXDaluy45QC5H/OV/ahzRSlmlvrOD6jI3bZnUXtAHGyUimigYoXawLJuLuAGMnizz833nsQ5w74D4978BbqyrOxCue/G8v5D1Q98BvpTnWpA11odRCWJIs0ZLbR7Fgy9QXenjg10evz6sabjy4GUrNhBHh7AVKCxXh4fEzN/NLvVjYpBs7Npw+lPwJjUU8bT27xlsxt4/gnbYPEMzvVg2K2IU+z0l3ljwZUbzGXOu+9xBJMomhZ8VFqVZgAm6M/3F5BXWr5SQvK1yCafHveizsTzNMQkAIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYUPR06MB5927.apcprd06.prod.outlook.com (2603:1096:400:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:25:09 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:25:09 +0000
Message-ID: <19a2d3da-a543-4a2f-8b2b-8d1e6088387f@vivo.com>
Date: Tue, 19 Aug 2025 20:25:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: common: scmi_iio: use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jyoti Bhayana <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819085542.538715-1-rongqianfeng@vivo.com>
 <CAHp75VdAySwLZ8gf_mDoQDX4KdC-hsCYL3VbkZSk_NSKNY5VTw@mail.gmail.com>
 <995cbacb-b01e-4799-84ab-44d58ab32ab7@vivo.com>
 <CAHp75VecWJXd-kP8mhFtFZpiU-qcW3_nQz=w1Addq7SHTv=SSQ@mail.gmail.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <CAHp75VecWJXd-kP8mhFtFZpiU-qcW3_nQz=w1Addq7SHTv=SSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:404::35)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYUPR06MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: f6dced95-b870-4040-9dff-08dddf1b701e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjZNdGtQR0hyY21LSEZYbGI2d1VWZGk1NWluQm9mbXMzNjM3VlpKU0pES2lJ?=
 =?utf-8?B?TXRrUEFUY0hnSm5FUEE4cE1xU2V4NXMrallmRWRuMEFOcEZGdjNhaFJqeHRi?=
 =?utf-8?B?NnovQU82TUdzaW5la0R2VlprRWlTM0ZEYVdpT3dHYlpLMFJ5U3BJdFdKOVFq?=
 =?utf-8?B?cjhWTkgrZ1doRldIQkpBSGc0YXFWNUd3b0pkRytmOE00bXU5SngwY09qUmZu?=
 =?utf-8?B?ZlZLYmtTQ2xNU01sY1o2SjYwa2JQd09Ea3F0K3RRSURtdjBMRTNzbzNDeU5B?=
 =?utf-8?B?cVk0d0ZLeEtjVm9vbGRuZGR3cC91b1VyZ1lsTTUvbFBnWnVvb2pSWU00WVZq?=
 =?utf-8?B?T2FmQ1Z1cFhuM1htcCtnZkhSKzZJTlNXSHZ2T1hERGZrUEwzTlBNZEJrMnVD?=
 =?utf-8?B?ekxTczh5NkZuSGpEcUZNbDhtZkRBcitoL1R2Yy95R21JY2YvZE1MK0UxWWRE?=
 =?utf-8?B?dWpoQitvbFp3Y1E4aWNzKzlRcUFCTlZScEdEQ2F5TkdSemduM2ROcVJLcUwx?=
 =?utf-8?B?RHFnNG9MV0huODB1OVlvN2tzNUpFY3JRU0g1NXg5ZUZxNmdiUVVQcEFJc3dK?=
 =?utf-8?B?clFKOHkwQVdqbkZINXhVQzRQV3ZRN09FQUtLSXBFdUZRSyt3UmVWOWRyNUoy?=
 =?utf-8?B?Z1FnZWZaN282NEpMQzRVc0VhRjBKTkhMV3k1dmxrVkt1T1Vwbnk4OGhsUkgx?=
 =?utf-8?B?MmpYMVFKTHQxY3dFS1VDOXRQeVJONDcxS09UTm53WEVmL0orQ0ZkRWRBbFUx?=
 =?utf-8?B?RTlXeTFOaDc3R3FUTkN2ay82M2tRSkRIT2Jhb0lBd1NvV2g0ZXpzSmo5WXRS?=
 =?utf-8?B?Sm5yaUhvMHFISUxTUmhBVE1ybEkzYkYxbU9rM1hHS1kvbERlbDJ1Ulh6ZmN2?=
 =?utf-8?B?VEhkOU0vUWRDbTM4VlFhR3VyRGNMbUpsa0l2UnY5V09Sa2FwY3ROWm5tMXpH?=
 =?utf-8?B?ZStoYTRXd3BpUUV2bit4aXBmaFIzK3pQSDduVzhtSkNsV3RrdUlIcEhzNnBF?=
 =?utf-8?B?VzRpT3VLaEtuODZKai9QbjNVd1hwZ3BHbDhyYUhEc25qVUlDd3JLakE1V01F?=
 =?utf-8?B?dEVGckwyTjFvWUd4Rm5VZGE4U2NvbkF5TWZSaEphd3lJS0FLN2N1aWdxOUto?=
 =?utf-8?B?Smh4bUVzR3FhRVp3UkUvQ3NtSWRqaXlJZnpKZnh1Q093bUVKSlZZckNvSVFl?=
 =?utf-8?B?cy9MZENJZ1Z3VUxjVElwaEdYS2ZnNnhkR2JNbFlYdjh6UHk5bXU3Q2c4MGVJ?=
 =?utf-8?B?azJWZmxiRDhkTWRXbnJuL0FlZ3VoR1ZSRzIwaWVVVGJrZ0xGZkVXdlNINzNU?=
 =?utf-8?B?UzlHT01UNGNtSnU0OUFncVpmY2ZldUlIYmkzZWFYczZsUmdvandsd0lKQkJm?=
 =?utf-8?B?Y0ZiTW5iellyaTBpcHNYWG5xUDZKb1JGL2Rya2w2eHovR1EyMW1VUUcvRXRu?=
 =?utf-8?B?b3U5bzNhUEZhem14d1V2N2JDeHl1a2RVUUVzdGFVRGVGK0l1ZFY2LzJwRWVr?=
 =?utf-8?B?QmF3aTgySWpuTjB4NDdLaEEzM3ZkdGpsSFVTb0trczJ5djNjVXU2bTdxdTMw?=
 =?utf-8?B?a3I2VE9qYXkyd2E3dlhIWGFmM011YjVRRHhJcmNuc2ovMUlqSmJvVzJkUWhi?=
 =?utf-8?B?NVc1RUFiZmFGMHJaR3JVVDgvekRjdk00Z0RTWnJpcHRIWUI2YXFFM2JpOWZF?=
 =?utf-8?B?NTE5bEg4dEVJNis1Q3NzMWRUTUp0emc3V2lZakhhQ3RPQkxicGZoRmNjL3BQ?=
 =?utf-8?B?NWV1WVZvMWJUcGJTV0txaWdibngyTUF3Z25GTEpJNlU5VjBDaXREaFN3eUw3?=
 =?utf-8?B?WHVnbVRrbkE2VzBwVTJOYU1kRWx3U0U2eXZYRHJZMm9pSDh5eWppdDF1SlNm?=
 =?utf-8?B?ZUxKalhRZnBpU09CM0cwWkJ1SktZS3FGN1VlOFpVc1JrbjRwV3F0anpRN1pC?=
 =?utf-8?Q?dLdcslAEG18=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3NzcW9mQnAwdFFaWTluNUV5Y3A1bm1ST01DNGlnb2NZZVBkSzEzQVJ3Wnp2?=
 =?utf-8?B?cTJXSlo3YzdVMzlZVnI3NzBydkRUSlRNNVo1TExacWE4cDE2YXRjN0tQcjJV?=
 =?utf-8?B?UCthNmc1VWpuK2VsdUw2eTNRcWlURVdYOGxTYjBqcHlZTjFWampYSFlYSndI?=
 =?utf-8?B?STNiMG96Ky95OGpFMHF2TzhsRERCQUZqdFFnaFUrSFVmOFZwbzJkSGtGZXli?=
 =?utf-8?B?bm5DN1NuN21vSmt0OEtIMmViYVFNK0xjS2hadExxNGxRcjVSU002UlIxQVYz?=
 =?utf-8?B?dHZUOThGL2kyUHBHTnlEQ1JCZjZXZzZkckZiaWJ6Z2pMakhuYlNORU00cklP?=
 =?utf-8?B?Nzl2RWVZYk85ZHVoTnJWUnh4cDgwdzg2ckZFdHkrbTJGd0FaQjZqc3dneDlm?=
 =?utf-8?B?UTc5WHNLS2FneThXQWFnSWtYRHFNaTkyZnpod1E0dTlHeXNMdHFvYXNxOExQ?=
 =?utf-8?B?T2MzZTZJNEQ3MzltYW9zaGpqOHFhT0RacURUNDhTMDZtaWlIWXcrLzA2aytX?=
 =?utf-8?B?Z3M5MWV2dkVneXlHb2VSbms4YUMxVHc0cWtMemplSVZQZ2NVTjZCM1MrSEFW?=
 =?utf-8?B?L2hNVDEwaVcvS29MLzd4dVFzdGh4SGJXck9za3A4TFF0UlJnTHJ4dXNBUVBn?=
 =?utf-8?B?M0J3MnJGRnJjNmsxQlRMQURoUzdETWpVTHY2YjZYeEJZUi9YUUNiWUNaaGhC?=
 =?utf-8?B?RHhGKy9nVEtnVEdNOFBOUi92dmIzTUtnUGxJRVdEVnJaRXZQZExCek41TSs1?=
 =?utf-8?B?VlhtWk5aK2E3RjNsMm5pNFM2QStBakhSSjlZdFA1Q1dJNHNEZGhMYmJTck1G?=
 =?utf-8?B?Vk13VnAxVjAxOGVRdCt1NXNOajBaU3d6SFpaYllvL0hHSkJ6S3hvbkNlTWNK?=
 =?utf-8?B?SjFhRWh1L0hvZDZnOGhNSVBnV2xMWnRsdWYyOHhaczdyT1hia2ZHWFgzcnZo?=
 =?utf-8?B?ZjRXT3dVSmtpUEtNcGVURlVycG1PSkYrakxSVFNwMkl2S3E1MzdmMmI5Sk5q?=
 =?utf-8?B?eE5YL0JTVlduenUyWVVNbmh0bEptVWM5NWNvOEFJNmNhcXJFSjdzcGhhQ0ZU?=
 =?utf-8?B?SVZjbmNJendaODdpRi9UUm1MZHg1bXcvVjhQQUQ0Y3JvNWM3MXVZWVVaQllY?=
 =?utf-8?B?bWNnRDkvVjNCNEJRSEh1dVBucDdWVFNTUmw2Vi8xYTF1eUVOYzR3WWd5OW94?=
 =?utf-8?B?bER6aDlsUW1qcXU1UVVHc04xMVRWaVkrelpweHdmYnczUWtockh3OHpmaTR5?=
 =?utf-8?B?TlZBU0dSTlVJWWxZQ2w2c1A4RUpWaWNJYktudnUxbEFaVEg4OFdvS0NqQWk1?=
 =?utf-8?B?ZUU4V1NnbVpESmpOa20zVnEwM0RZeHlWSmUrbHZNelZndXYxa1NwRzZpMjNG?=
 =?utf-8?B?LzBaKy9HMTlEUFhhTEpUcm5KT2lUSjdVQXBFTFNKUkQ2ZTkzb25CbkM4b1Vq?=
 =?utf-8?B?TmFxSGdWZXpHWGplVFpYZHIwVlI1YXU4SDMyYnZzbnJNcUlPakFnZjNIZnJy?=
 =?utf-8?B?d1R3ZXE2R0M0ZWZNcEEwOGwwWFovcUduWXl0ck43LzRSL1pqZkc0WmhoWGM5?=
 =?utf-8?B?Q1I0NmxYRndPQzRQT1Y1M21Ya0lCc0UxU1ZYM2NDMGNMYkExcW53a0NIWngw?=
 =?utf-8?B?dHpycTZFZ3dlclRLOWVRSGdTZ25sK3lld0VCV29FWDNQQi9kdkRKU1l1Z1gv?=
 =?utf-8?B?cnY0L0ZzV2Uzb3hjeTQxNENXeDNuS0NiOVBncS9pa0JXUkg4TG9ER2cvZ2ZK?=
 =?utf-8?B?bWFPYUNGbVJMcE1Bait2akQ5RXc1OHYyaTZ0TysrZU9VUFlHdENTNDBoald5?=
 =?utf-8?B?VGdJK3ljUGxBck9TTnJTbFZIRnBBcmxUa0hZOGpHWEk3dmNlMnVTSFFpOXZi?=
 =?utf-8?B?dStUNFF6aFhkVVZKc1ZnaXMwUDM1STg4Vlhkem1JUkpyT1Qrd0o1NFptV1dJ?=
 =?utf-8?B?NjlHYVpCRWRhc2FCVkhjUkJUeWhRU3cyU1ZDWmxkQVFETUN5b1c0SWt1ZUhW?=
 =?utf-8?B?c2VpTU56N3VscGpnbXNBYngrS09lRW1MdUszREJlREtHckhRU1lWbzNLb1ZF?=
 =?utf-8?B?Ny9ISW53ODhCZHExcGNYaWkwY25DeHgydjFtdDR1KzRPMStITXdrc2Y2NmZs?=
 =?utf-8?Q?mhNCu8NHYjUDr9cvmk8ub636N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dced95-b870-4040-9dff-08dddf1b701e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:25:09.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzPDfFljfNFYJsJz+wO8HGh1dwHPO1y9qB0/aVCEGWiTpXdEpbNp+4e3/XqeWcixPPFJfHgq/ucOaYEu21B8Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5927


在 2025/8/19 18:13, Andy Shevchenko 写道:
> [You don't often get email from andy.shevchenko@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Aug 19, 2025 at 1:08 PM Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>> 在 2025/8/19 17:46, Andy Shevchenko 写道:
>>> On Tue, Aug 19, 2025 at 11:56 AM Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> ...
>
>>> While this change is correct...
>>>>           sensor->freq_avail =
>>>> -               devm_kzalloc(&iio_dev->dev,
>>>> -                            sizeof(*sensor->freq_avail) *
>>>> -                                    (sensor->sensor_info->intervals.count * 2),
>>>> +               devm_kcalloc(&iio_dev->dev,
>>>> +                            sensor->sensor_info->intervals.count * 2,
>>> ...I would also switch this to use array_size() instead of explicit
>>> multiplication as it will check for boundaries that are not static in
>>> this case.
>> I don't understand what "will check for boundaries that are not static in
>> this case" means. Could you explain it to me?
> intervals.count may be anything and of any type. Compiler may or may
> not proof that it holds the value less than size_t / 2 (which may be
> == int / 2 on 32-bit platforms). That's why it's better to use
> array_size(intervals.count, 2),
Sorry, I just understood your reply, I will send v2 immediately.  :)
>
>> I've experimented with the following command and found that kmalloc_array()
>> generates fewer instructions than kmalloc(array_size()):
>> objdump -dSl --prefix-addresses <changed module>.o
> It's about the second parameter in devm_kcalloc(), and of course it
> may generate less instructions but it's irrelevant to my comment.
>
>
Best regards,
Qianfeng

