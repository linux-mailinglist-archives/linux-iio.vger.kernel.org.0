Return-Path: <linux-iio+bounces-27832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9844CD24C4A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0255C30AE7B1
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5AE3A1A31;
	Thu, 15 Jan 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="kNFsEG+x"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023089.outbound.protection.outlook.com [40.107.159.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291920C00C;
	Thu, 15 Jan 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484022; cv=fail; b=R/CqfluhyG1B9xl2CB89156CBffmokBf7HZ4phIOZZlruEfjeA9B4vpy5OkAkvukLYA+QpjDtGJG1iIokCPMlEKLrP8o9fUG3DBUhMnbTupykj2I0M5szyr6ed/+uRURm61obxsjkaZYVqOUVseXj4r/I+hahST3CDZT6Xj9otc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484022; c=relaxed/simple;
	bh=TphheK30WGvWLWCOIzPxPjM/quL4ZYstvCjUwh4Tu7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uTr65D3PQSsT63DEYJYljeF97HGPnrzMdzl/lxY/Hdi7F9i6BtuYbiWYZ4AUYEW3LLwBnNpQfCCQL2YXIfbBOcD6ynGpgOS5n8eXtc1jAqEOZTbIrqPAoir0AKhEFyOWLsAugvoN/ze9iSXjULMfkP6yZ4xxpVhnCm7yv7CjO8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=kNFsEG+x; arc=fail smtp.client-ip=40.107.159.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxEUHg3eozsYASrOn2eefcP2FaKGObZ7tyAyqJPoITWlfmRX4Cc9eEntMMURpjNwhwSh/V/ltaXNWMeY8nM+g4E8nDf4h5I3t+Jt9qpi6uvFKvJJ9YninjDpmt1fCXGBzdipDu9wIpJpTcMFv29/caHbvBBUgpLC0oD2skr89LmGDcY50cj+bOKqjeIazi6qTimkDK7gTvrh7Kj+aRL0u9ta7fvaUiIRlll2MzgisUGotDdJMBrSjcUihtI/jmXe1as2NLP4lyKvyU9WlaNJXGT6OSJHWkVZCQMGGJQmy674xcPzr7zdnthbsGa0ncJnSdeIiulYoQvYaDt7aa6yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O6W02v727VR1gxYNb2ruGIsXiDUrYP/5YSkjZK94Jc=;
 b=RmluK2oudNGJG49yRXED5YrhY7M8wlg5/ksCV+KBxQ2fZn4g8IGgyo4Ol7YJbkankVjCXUSeFhgczJhPr+qCylxbNBtS+VStdjwkYePlWB2B9m3LvapXfRWj8Fl3ZDlu15nRmQIHBaREkDvrM5RHl9jJymKpAV+ztrZ7VJi7JImpHoy9+tryYke9qyEQWhmCilQAJrSqrGUZaxIFJ2wQ3lYpr7vtzBrPLPAzXyEai7v4F4RNZY1Y0xsZQ7H4VxnYswECFioBTH7Lksj8taYHyut2xTBGy5I0TvF5V1Wx/IHtyAbnLmop7H6rXVwqkWJoRI5XvIfIK9BPcqoD4/aeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O6W02v727VR1gxYNb2ruGIsXiDUrYP/5YSkjZK94Jc=;
 b=kNFsEG+xidi4uGJPoo9T27ASL7ZxseuqqDKH540BI/EOjO7Nyp1BgBz3oYIcjmfe3qt/yQxQj+YEr1rEsq9A6/0s64Dd3M5SdoNwtWqgCXd+Gz0vxXaccen+o9XPJdKN8lqNpruMmZ0aIbt4qADV10MFqnUv1RAzD7GIABkH7WVL7/uLIEJ0V8po35DVI/Q8mHFwXsFjV27Z1FnHe2C0+o6USA5KbUrUlwe1EhtUeYgxdOmYKVL+JSwOR34MFii0hwH8gnCEZlGT4Jjn7rwvzZnfVlf++bXlWAhz3srwnz9jZKGH+VuRvGRmVvgQ8dD3SpRZoC/15XU5DhitulvTcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10767.eurprd06.prod.outlook.com (2603:10a6:10:634::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 13:33:33 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 13:33:33 +0000
Message-ID: <41cac06c-8db2-4a52-854f-659606d89121@vaisala.com>
Date: Thu, 15 Jan 2026 15:30:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] iio: adc: ad9467: Support alternative backends
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
 <0ad12e16e3fffb4b72a460d7f2b2e627a781b93b.camel@gmail.com>
 <7ac7033a-2273-4556-a605-1ea0200665a9@vaisala.com>
 <5896ab55e0d23d235908f9f592c8a7975428dc54.camel@gmail.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <5896ab55e0d23d235908f9f592c8a7975428dc54.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::12) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10767:EE_
X-MS-Office365-Filtering-Correlation-Id: df8f0910-9f92-413c-3603-08de543aad70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkJPMVg2cXAxaDhSa25oMFpjTVh4MWlVZm0zaTJDaFVPU2JkZkxZQld2VU42?=
 =?utf-8?B?ZENSQ1hHMjdVSEg4T1VJODByTmdiQm9RNmRMR0RvN213SVJHaUxHUDVhYnhz?=
 =?utf-8?B?ck52Q01LcVg0aUh1eFJhUCt1MjlkOWlCd0dkM0FiNlFTT1RiMlBQNmpqaVNW?=
 =?utf-8?B?bk9hQTQ1RVNzZUJ1L0RLVkR2QVVYTXJWWk85Z1dOODRGMG5MUlNNSWZqYmh4?=
 =?utf-8?B?YVNFcTNsOEsxWGZWRFJEb01mVTNFVjVtNjFINXZSa3VnTllaN2RZWmxFVVJk?=
 =?utf-8?B?S0EvamVnejJjUWh2SThHNHlIVjZNREhMYUV1ZHpYT0pZS210ZHdEcURKdEZm?=
 =?utf-8?B?WUh5TllmWFRzcnZEbEx5ZUJHQjlYdFRDSEllWDZ1YmVGaVNtUmZKRThlQXdL?=
 =?utf-8?B?WFpMWDQ3MmVneHh3ZHZ6N1plaG5TOTI2cm9BNEtpQlR2cUNiYWwwKzRnbmpP?=
 =?utf-8?B?ekRBWkR2aWtkaVZoQjRXanlSR0JPRXZaVzNzM3prb2hVNitQYjI3eE0vc1Rp?=
 =?utf-8?B?T01rblRDM0NVL0x6ZE5GMDRkQVFUU3QreDIxN2FjWnd4MU56Q1lwbzlMeTAx?=
 =?utf-8?B?RWZCa0NmYnI2MkJ2TG5na2YxTC9NRjRrSkpkS3l2a1k5VWdDY2U3VERBY3hO?=
 =?utf-8?B?dnVQUnluQXlicW45VEErWm9pL3VxTW5ad1hrMnhXakpVYWNJUWxUZWFJeHhx?=
 =?utf-8?B?RDJxWXpzblNjUUd1Y2VzVjY5Wi9EUHYvTjcwc3Q3YVl6NTVvZ3lBbnR6dkJn?=
 =?utf-8?B?a2xWNThPTlZBYmd6NDVmUC9sQ1dyYXpPZlorMmI5VHZsZmIxTzZ2ektveXVN?=
 =?utf-8?B?ZitzbjBpMmZzMUlZaG9xanJFYTdIRFV3d1RCUktYUjU5d0U4ZWRpTFFvbEJx?=
 =?utf-8?B?VnlUU1VHL1hhNU9FemE2MHBxdExJVVRnd09oczhpK3BES2pxM1FmME8zRXBP?=
 =?utf-8?B?QWtsL3BqczdoVXB3Mmp2ZXlJRURXTU5TeStwdTZKNVNic1VDMFRWR3dJNEVK?=
 =?utf-8?B?alhsTGdEeVNmcWNzZDMzbzJXdEJsSFUzY2VGRWhjc1d2QTFjeFZnMHkzclBh?=
 =?utf-8?B?UW82L3JBdnFBcTYwd3NqalpnN1BSc0xyL2hRZWFXTVl0eUhJYjJIeFlPRjRm?=
 =?utf-8?B?aWdOcE1JUWhmRFk1UGJ2Q2lrTGxqaTdGa3lmQmFCZnZSL2lpaGhFRzFDY2xX?=
 =?utf-8?B?OUM3UzBhUEUwZHN6WmREa0trNFpnWmlteERJc0U2SEduOHd0OHVnM1pZN25J?=
 =?utf-8?B?MkxqaTJjN2Nva2hpWU5HYXdMNXZxUmFoNVBIbUFiTjFpTHZYUXJQSEhWRUhC?=
 =?utf-8?B?SThza3E5bjYzU1QrN1lyUmtWTnZSS3doM016dXZUUGNIUzhiM2U0NXh2NFZL?=
 =?utf-8?B?RXFsT2EzcTFiREZNeW9WdjdoTzBwVFltOEpqZE1PdktZZUNKV1YyZURiNTVS?=
 =?utf-8?B?bXpQQUJEUW9zR0s4d1JzRkFzVzhsYWhWZnpDRlhZcjJHd1A4c1NOWmUyWUlq?=
 =?utf-8?B?WTBSVnI4ejc1UkovTjRUaUVqQWhVbFQxNU9LSTJzOHZmYnllLzBCMTVHcTlU?=
 =?utf-8?B?cWRxb0svQXdpMVlXeGdOOUhPZFhLa3pVUGNVNXpRYWVpdFE5NFlTTXFyRVBx?=
 =?utf-8?B?dElOVGxVRE9Va0NNSEMvTVBuQnRlUmVqT2ZQZEJsN2xpR0x3U3pYa3d4ZSs3?=
 =?utf-8?B?Z1hLM3QzckdBMCtCY3liRUVpTHJDWGdNNG5KVllDeFE0ekhSc0djV3lxY0R1?=
 =?utf-8?B?ejAyMzBhYWxWd2pIVUhIK1JjVnlwQ25PTzdiQWNIaDkvRUYzOCt5WUNWcXRM?=
 =?utf-8?B?ZUVaUEp4dE0zcWFmRysxQitubkpyL0pMdEl0blU3eUFWQURGT1hoOU9RSVBV?=
 =?utf-8?B?R2gvTU9yY2duU2czaVRUSFhGK0N4UnprRWVjTHphNGVaWHk4RjNReHdOeXJK?=
 =?utf-8?B?eXF1SnBBeXVhYmFPR3pWbjRrYm5WbjROaHJKNFZ6TTJoK2lCYUxYWEc1WEc3?=
 =?utf-8?B?blFwckRRTGsyS2s2bHE0M2VQRC9CbHFQdStxVW5xaWxLNEl4WUlhQkN2UFpr?=
 =?utf-8?B?OHE1d3NrYXhERmRxaEM3VWNsSktWNUxNVk1EV28xUnp1ekxCWE1PTDVkY1dX?=
 =?utf-8?Q?KVcg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1hmcmNUUnhtQ0Q4d1g2SUxDWGhzdWV4RUlxQ1BCcjQxdjA4YjVrRllhbG1m?=
 =?utf-8?B?aWFuMmdsVjJYZnRNTTloNHkxTkFMVktEUy81b3B2bFp2S25VcWFHbmZhRkxx?=
 =?utf-8?B?TlNlR0tuVlNjL1VGRTJNY1B3bnpsRVlMYTlseUc0K0d5azhNK3ZJYkRPWXRi?=
 =?utf-8?B?dmhFTmZIN0hTOHJoei9WaUpGRVhxTm5UTE5WRmltelZWcitZYzFtZHBIUnA1?=
 =?utf-8?B?UGl1a0RqWUovWnlQQjYxSGc2dXJNU3JkZVBiMmZnR3ZYRXBpajJzYjhvOEd6?=
 =?utf-8?B?Q1EwNVd5enVtVllINndDRHFHbUdkTG1LSFhsZlY3UC9UbTRDVWE1dkEwSGlz?=
 =?utf-8?B?N29XbkFCUXlVUXl3YkNsNllUbmd6QU5ZeFY3NHFZR3BzOXoyQ0NYR2JHbnNy?=
 =?utf-8?B?NytONkZVaCtKYU83bTlmRVdndkV1L3Avc3RGNzErQllkWXllWUQ4YUhKZFdm?=
 =?utf-8?B?U2pXMXo1Mkw3eHRKTXBIa0RBaTZ6Q1ZBSGtKUFJrTnBnN00vUi9NektacHh3?=
 =?utf-8?B?anZXYjZCY1lwQ1FiT2F1ZzFCVnJuWDcxWFdOUmtxWUJzNWJ5bHZLbUlKakUr?=
 =?utf-8?B?akRoZGVkSDVNWFF3d05NZ1p1MTlBM2o2NXpMQ3lxUVRGc05FQVdhUHNPRS9y?=
 =?utf-8?B?S1NuOGtlcWxJdXdRdzRhdzlZaFVlZmJLOEF4ZlUwWXZQeHZJVENoTWF4MU9E?=
 =?utf-8?B?VVhjVDRIdmwzZ0xydnZPYmFmN3BsdTJLRkNDMDVXRVFxL2xnTExkeGl4NXR0?=
 =?utf-8?B?YmZlZ25yaGFjc0NOZlNTTkNZc3A5VUxaSzlVclVJb3VBbkYwSitreHlMNWFo?=
 =?utf-8?B?bUtBaEtOU1FOZzJvMFhlUmRtZHRnc0JDQTJUMURLam94T3ZRdFkzYVBjTlJK?=
 =?utf-8?B?ajhIZGV5SzM4V1RpNlVtRjUyUU96Tm5LTTJTOVRMOXF0WUdkVlA5NC8zKys1?=
 =?utf-8?B?ZjN6em5Wc2RoZ013N25kdGM4TzFaVjYzS0F6MHNScFZDNHl5MjRWUHA1Mnlt?=
 =?utf-8?B?Q3UxNkJKdkNEN0NaUHJxU01LK2pFNFZHYWQ5d3EweW5DMEk5T3NMSkRFT0Ur?=
 =?utf-8?B?UzNPbDkrQTFkZWd3VTRtZGJxVU1uc2w4cmZTUFE5NktDeER4dG9NQldOZ25R?=
 =?utf-8?B?T09vcmdodkNSUXJ6bUFHNDArbjVVZ3FtUm9ZZG5RZjd5WUtvZUtncGRQVTFR?=
 =?utf-8?B?NHI2ZXhtRWJ1VGlxRmFxNE9tdEhvUDVwR0RIQU5aTU83QXh1OEExRDVSRWIy?=
 =?utf-8?B?Wm1zZE9IUXNWSG1nL0kxdHFsMzlpRkZJbWRFdm0vc1U1MU5CQkJWTWJwSGcw?=
 =?utf-8?B?L052d0NDZXd4OFV0U3g5MnlJVG1kR3RVdzlXZ2U5WnJvMThlNDdkWFZvMXg3?=
 =?utf-8?B?NWNLUTFSWEw0MG9iZXJaUXdJSWtQcC9JM0tGcklGS2RzdzlIZ3EzbHBicW1V?=
 =?utf-8?B?WnBJZGdDYU83TDBpNGVUcTZiUVlyRU1NTE5tQlkzdjd0dm0zMUpXellQYmYr?=
 =?utf-8?B?MHl3YTZ3cWNZeHZOZmdTQ3lrTG02U2ZSMHpUVDBKcXZZcUhaQW5lUEFkMDNQ?=
 =?utf-8?B?VDczaHJOZXRkc0t5V2JJUXVuT0xGQkh1WitIdk1ldjh4THE1RjRwaUo0aUd4?=
 =?utf-8?B?N3FsVWcvYzR5djRvUlNQUVhCYm50SFJhR2xrWDZVaThEVjc2a0c2cUVjTkxQ?=
 =?utf-8?B?S0hzY0FuU0t4c3VLTEhhQWt5YVlUSXNvR2RmeXFnNTZtOWRJeTRod0VpOTNj?=
 =?utf-8?B?cE1IWndRaTd3M3YxVGt5MDQvc0lxdEUwL0pmVzBCTGhWRVVic3VuUTgzaWk5?=
 =?utf-8?B?eEdXMnN5RmxNVHhsUnZVYjBFS0ZUN2NRQy8zVDc3RWhMb2k0L3NkdTNSSENm?=
 =?utf-8?B?TU9BOVo3L0tNUWRxaG5YQ1RqK2dFMnlRMkdaUlpVendNREZTSk1ub2pOZDlH?=
 =?utf-8?B?SVZpMmppU0NlSTJTK1FxWmloS0tBcnVBTlAxVXdQS2R6M29CS2xUdFMzc1Iw?=
 =?utf-8?B?OXFLdURjb250YU1udEw1K1E4TVYvS1hxdmhWTk5GUnhvY3R6ZUJkRG55aVRJ?=
 =?utf-8?B?cU1KOCtUY3pCSlpmWHJWektES1c3cTRzb3kwNFFYMkQ0OHAwVkxPZkIrazFW?=
 =?utf-8?B?OThYdGhycDk0TVNtdi9mY0t3UmpCcXRySmZlYURaMEtHcUQ2eE9TQkdyM28x?=
 =?utf-8?B?RWFCS2xkZlF3NWpGUlNCc2FYUURpN0xrdzZjZkVaNHJ2MlB2a2luR1d2SUYz?=
 =?utf-8?B?UGkxWXprdEpUWERyY0JpYnNHcXZNWDQrY1NVQ1AwWkp3MjBHclNaYTh5SVBi?=
 =?utf-8?B?bFZmaThLcGJzWUdoTWl4cDRMWjJFYTFrNGpEb2kzOHFWYVhZMkdYaDk1cjI3?=
 =?utf-8?Q?kWiAPdIP9Lvw4xD4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8f0910-9f92-413c-3603-08de543aad70
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:33:33.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmcNiP88xOc+RGImVjmlW1KPcur2Lv1qhPpmN0z4qseJTIR0yT/YSRbQzNY/+U2uP5eqwSEFQb0P7VL8NXRHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10767

Hi,

On 15/01/2026 14:04, Nuno Sá wrote:
> On Wed, 2026-01-14 at 17:32 +0200, Tomas Melin wrote:
>> Hi Nuno,
>>
>> On 14/01/2026 15:32, Nuno Sá wrote:

>>>
>>> But more importantly, how are your usecase supposed to work with this
>>> series? I'm not seeing any new backend being added as part of the series.
>>> Point is, if we are adding all of this, I would expect your usecase to
>>> have fully upstream support. If I'm not missing nothing, we would at least
>>> need a dummy backend providing stubs for enable()/disable()
>> My usecase adds simplistic backend support and registers to the
>> framework via an related driver. So that use case works with that
>> approach. I think it is better to assume there is always some entity
>> that can take on the role of being backend, rather than adding a dummy
>> backend. Adding the capabilities are defining role here, as having that
> 
> Well, I would argue your backend is exactly that. A dummy one :)

It's kindof ;)  But on general level it handles the stuff a backend
needs to do, just does not have most of the operations or capabilities
available. OTOH having the backend defined means that if some of the
capabilites would be added, there is a natural place to add it.

> 
>> allows for customer integrations with backends that differ but are of no
>> interest for the mainline.
>>
> 
> It would still be nice to have this usecase fully supported upstream 
> (having a black box backend). 
> 
> What I have in mind would be really to do the same as regulators do. If you call
> regulator_get() then the consumer really assumes a regulator must exist. But if it
> is something the kernel does not control we get a dummy one with very limited
> functionality/stubs. If you call regulator_get_optional(), then the regulator is
> really optional and might not physically exist. Seems very similar to what you have.

There could perhaps be use for a backend like this too. Is the idea such
that one would still need to define a "iio-backend-simple" node or such
to device tree which would then provide the backend link and compatible?

Thanks,
Tomas

> 
> - Nuno Sá


