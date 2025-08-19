Return-Path: <linux-iio+bounces-22974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE97B2C28A
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDCC188AE73
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B3334707;
	Tue, 19 Aug 2025 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YGv94zWi"
X-Original-To: linux-iio@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013035.outbound.protection.outlook.com [40.107.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B6335BDC;
	Tue, 19 Aug 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604815; cv=fail; b=YBzWlm6hxnateIKaAJOde5t+2HpBjRwvs7NxQAqLDKinwBQ2EtUETEIJHSIwmIydhZ3fNMZkFMRzDJ5he6QaA+c6rPM8Q5n/6HmcY9E3aLI6HuW40LKTEygCK2W1CMgKjfXDoSNgkYmnQlqNIYO7sKYapAki6JRzGjTlho4ipqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604815; c=relaxed/simple;
	bh=lzT91uiTvexJTqYq5XQBOpsJ3uNzOWGZIJM4c7LKTok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dUwlZLAjZ4Q6SCoPf7AMniaV90/Jl+njVjFbmY3HZgm95fDgByTbamT72Qal6l0TVsvq/De2UjpQKQbl7XawjTG8nRw1yz6nDBAh5KhEhHNkWpnJgfQthBYjQsKxhW0g/izefgsloxMDq6Lp0DvwCSRB9suUWa4novHrjxrP02c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YGv94zWi; arc=fail smtp.client-ip=40.107.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjugHgrxYXAxxc3qDQGq31LXKsakY+cpUvs3EptEbmzxwL2DTbrV8BgK/zc/A8rO/xHz5lQQUs/XGT1zeJ7WtnWo4WnpUe1Vcc4yvYacED4YdI+0bnVQKFqywKc7ck6VcP0ZXLTvC7hdAvCkzLDmapdXUPEedNylPF/ksgmr7TNYWBbPTE2pC4WH2OJN8KJhFMqRLy5BzUj1BOdhsjbZnDBmEsOnbQtsPuyw9JEodei6/+gh8DV97z86nzatr6FVTsy1aOb8TdyzKgtqN6uX72guli2z51sEfE3s4DXmhVvtuHpD7hZjwpHQBpr/rhAhHfHZjD7kXsMXQaKQSaPqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A86FshtEe+mhyAKOMKzEagxTjN91EpT6v+2mzQulx8Y=;
 b=jghR/HBhGzMhl2ocuU9grGiU3hwHXyEy4cKYil7VjuU04gbZ/Fwtu8xxDH3q8wEOzPZ5bDu97SB7zQYN+5ifbXczeTm+XguOVLUibYtX1bjzOcRxyvna7nR99tlXn6S2Xg5Q3CHdRff3MzYgM+MlH6Fk5gBMiJ8X29IIxHUf3REEl/w0N8m+FziDxxSUnGvR44SfCs0gZeItLc677xE/uRoxiBuNZZaECBp0ZPFCYymMm2ALyaBfh19mHrbshPd2eOyx3o6JLXjcVOn7jTcJRD/LcxxR6wIPeb8HtWMecdPdDIUPU1PKVdnC5cU/aEHeGqJn1t8Umiy8GrlJQ6lSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A86FshtEe+mhyAKOMKzEagxTjN91EpT6v+2mzQulx8Y=;
 b=YGv94zWighRRUC0gYFu+dDe4JsefJm2zKhBG5laO7uJEftRrX4ws7abL0IESXRIGkpF+QA/GIkOGt0qvm9eksjCMcTRIlmgP7Y+vqC7v9J/jYQEIkeMpAHXMEXnfeifCyzI/aOtmYF9QPpEpYVaChnUkstry+X9UqmlYZLn+UcnkKeaaz/ZHEx+qF6E4qa/pnYi6m0YI/k8fDS8LwoNNUGJwEyP2HI9PwzuH/+G1YUKMuosLJTjo0XC7mvMY+UvirhKmsCWrFCr0Dyh+SLrIvl4IHbWN7VwvcniQqM2gOT8fjB9QjN3iZEOY9/Qh3yBH4BkGwcEr2npiSaSNszeE+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5729.apcprd06.prod.outlook.com (2603:1096:400:273::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 12:00:09 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 12:00:08 +0000
Message-ID: <48b58e81-9d1e-497c-abcd-84deaed98ab1@vivo.com>
Date: Tue, 19 Aug 2025 20:00:03 +0800
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
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 7856a501-6765-46c4-5e80-08dddf17f193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGNnTThZdGIrNnpoa1h6MzdWc01laCt1Zmg1dGFwY291dlc0RU03MjljS09Z?=
 =?utf-8?B?dlhZME02YUhxMVc4QU10VHhjZy9NUTM2ZGVBT3lSMS9CcnV3WDRxdzd4SGVm?=
 =?utf-8?B?U01FWlNBUXplYTZGZkdBakVXSHhGVWcyS0R1ZEIxaFNqaCtvVDZsMDlzN1A4?=
 =?utf-8?B?OXdVRWUzTkxoM1lWRzlqcnBVNTIxNW5GUVNVcXRYRXUwR0pBQVRvdWIrVEIr?=
 =?utf-8?B?cm1WeXRrNUl6UFVFSTFlOGpyTVgxTlZPeFdRd2JlQksyaGNDZFlWaHVIdmp0?=
 =?utf-8?B?eHNDakRNcU5mNHpGNThpUGdaRXJVbGRYdXhVeFRhV0tBWlVDRG1oTDFObHZN?=
 =?utf-8?B?emRtUWM2dkZFTGZJRDdTamsvVjJBV25pQU8zdFR6QlZadGorYVhmWVorUmJM?=
 =?utf-8?B?bFI0TkZkMGk5cjZmbGVLOElYSkkxRGg2dXFpUVI4MFNlNzFDQUVvNCsxK21o?=
 =?utf-8?B?REttb1RyaUNIZDg5NzZmSE1FT3F3S2I2VEt1QnNucjNCeCtoYlE5THFYdVY5?=
 =?utf-8?B?ZEJtZWl5cG9FcTNuamVaWjRtYm5MQnFqTE1hTzgyS1JhU3h1TmJLVnNSTysr?=
 =?utf-8?B?dHYveEUyQVJuc3NzRGZqRGZuY09tZWRjaE9zU0RvNitZU3ZtbE5ENG5RcENu?=
 =?utf-8?B?QWNZZUdISml3bHBORnJjcUU2K2hyajMvTmtSM2Y5T2RHVTF4UTd0S3RnTUY5?=
 =?utf-8?B?YmltRHBPUUdLUjd2WEhQb1ZTTlNuOUhvVlBIZ3NxcmRXNTQwVFdEaWZXRU1h?=
 =?utf-8?B?K0hHQ2x3bUNxN0VoZTYyVnIwbGg5Z3M0UXBQZkhEQURPc05yZG5MaXk1cTFF?=
 =?utf-8?B?aFMrV2w3STZ4dDdMc2hEZE9DOU1yMTJHS3psdi9XTGZXeXBXLzVoVldzbmhl?=
 =?utf-8?B?VmVMdWNaWmdPZ01ZOHg2OElqck1xRTk3QW9wVmtCVmVvL1REZUhjOUtNOEJy?=
 =?utf-8?B?WW1PenBjSEp1aXF1WEVidU9aYlkvUXRVdDFRSm9mU0pmODZKQS9UTlpxdlJu?=
 =?utf-8?B?VUhnb2JBb1NPRWNSRENNTDZjeFpFRVlWQ1gwRFdyQW5jTDY2Wm5IejlGdE5w?=
 =?utf-8?B?a2RRN2RUWXl4Y1M4VG1wNG1QZzVhMTZTemt6Q3lqTHdSQnJ5eTU0Q25FNzl5?=
 =?utf-8?B?d240cENpUlQ3eEorS0VZVllHSG50OWZTTmhNVS9WeFVTUVQ4UGpGUlZEUW8w?=
 =?utf-8?B?QzdKajhlUHBOaUxPQ0VzazI1RGlTZjJhSmpCYlQ3K1JSMnZJY0I2dEN4TkFB?=
 =?utf-8?B?T2R6K2ZnbkxkYTdvZnFzQk0yNmJKREtmcHB5aW1PVWxhTmJCUzRzQXNBS081?=
 =?utf-8?B?SmNZOUxRT3VPUFBrUWtxQmNXam9MQWl1eTRQc0JkNlIvV1FzTkhHaStDVVBW?=
 =?utf-8?B?MGFoNEJTbEwwUndQSnBSc3lVRHVRV2tUNTRnc05CVXdKRW1WNDFqa0R2NW1j?=
 =?utf-8?B?Q3l0Vy9rNXZFbXRrN05OWFk2VVBiaWNuTlBsUFJoSGF6My9vdTlmZzRqdmdk?=
 =?utf-8?B?MjRrYnNvUDdrV0d2bTk5bFo3dXNmUWRHWUlnVTJxTHhZdDNiYm4wWnZyZkZl?=
 =?utf-8?B?R3hIcWtndlB6NGt0UWVmYWdrWnhZYXZMbWNQZThnMUlzU3BwN3BCUmxXZ3kv?=
 =?utf-8?B?WEM4MXBObFVPVEpIbXRjODNhTUI2SUlMbUxCMWdSM1YyaG4zYk5VcVIrT0U1?=
 =?utf-8?B?bVZ4YldhOWVyd09McXd0V3pBVnY4QVRocHNYVlp0czFxZTZVbkwxMklEdkNV?=
 =?utf-8?B?OHRLbUZDbkNRZ0piaDB2UzZIdlQwa2RyaER0Vy85SHB5YVhHR3U2d2xTR3Fq?=
 =?utf-8?B?T3JtUVRHZnc4cTl4VHdUalR0c3NGdUlvZVA5Z3gwVjF2M0Zld0ZncTVqU2JE?=
 =?utf-8?B?VFNYdkVSREJhZmJ5aXhzZk9uWmdiZUpFbGNrY0dZWW0wMGJpVDNJekU3MUpP?=
 =?utf-8?Q?RVFaCvhEQvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXo5VTBlZlRsbDd5OFlDcXRlbE5rVUFkOWtlOGh6ZkdpekFESHB4YnJhM1Jy?=
 =?utf-8?B?ODRLK291Y0U0V1hxekpES3pTTlpGSzRCR1o5OW93M0lvT25TclI3aXh2c3Q2?=
 =?utf-8?B?dlJDMUcyUHZabk0vNWk3WmtybnJwQXgxOHBhSnhrUm1IZ0NqVGk2RVdjNVE2?=
 =?utf-8?B?c3ZWZjIwTUh3ejNlSjJMRFd4Nm5rMUpDZCt4dFlvdlFCdmsyakJkZzJSdUpz?=
 =?utf-8?B?M3NjL0NzRzJxcnZ1bGdBMW1aZldYdEJuOWR0Qk9KUUoyYzV0Q1FlWXJoQThV?=
 =?utf-8?B?OXBHalByM3FsQncycWY5QVNmekRlMFA2UG40RmppNUR6T0xTOE9FNzdMU3JR?=
 =?utf-8?B?RWpPL09NQ3h2YmRtYllETTRTQkxDSWM5L3ZNN2N2M3hyTEpCR2lKbGtCTHBw?=
 =?utf-8?B?a1lXY0lMWUZjako1SFJwNWU5d01OYmlYeVYvSEtscU9MNjFHRk5DSEZ3QmU3?=
 =?utf-8?B?MThXSjNYU0NKWGdmVWo4KzIwdVZkZjZZdHprYUlBTDhxQnVFWHRNdFJGcmgx?=
 =?utf-8?B?d1dub3lObkQvWnRWMzdCRUVURkROVHpDRnNsanY0MHNMT0M3eDdzNUY3ckNo?=
 =?utf-8?B?Y2pOOWVJT1dIZGh5ZHZ4d3p2NFAybEY5OUNZcWt5TyswZStlaVdnNWdtNkpi?=
 =?utf-8?B?bUVWWmxIanVUdkIwTnVDeXIwQUp1T01PSlV1bzNGYzV1UitQcHU1TExGNEts?=
 =?utf-8?B?NjdWYm9acXNsU016dWozWmdjd1RmcUJYVTlqb3NobThWKzk2bjIyRDNkZnRs?=
 =?utf-8?B?c0R5SHp4TUdnRUNoNlRjRmZIVG9GbU1TT1FMblRQQklaTDZ0SHNOekdwSk03?=
 =?utf-8?B?WkIrMUZBOS9wc3JhYkQvVUcyb3ludXYrb1lqT0Y0UXNmL015eWplYTB6NXRs?=
 =?utf-8?B?TUZid1hCT0h6cGRva3dkdjQ3TnVpWno0OE5keTg5TUdQUDA2WlZLRloyWUdx?=
 =?utf-8?B?TkpocUtsY2xOem4wUytVOW01YUlKNFJlYmFJMGtUWWxtWXI2NkRyR0pBMmxV?=
 =?utf-8?B?d0xqZVk2OVl1V1pEMDFxVWtaRmlRL2NzVlpNVGFoZzRDbmNWeUlPSDB0aHNz?=
 =?utf-8?B?THoyVjNWL1VYb09qUWVuZzNZSWhlRVBKT0s2b1d5QmNNQ0diNm50M0hZVjR5?=
 =?utf-8?B?QVNCN3dTSXRQZUloS1lJYi9XRXU3c09WSUxYMFpBcCtWdVhHQmVsamNJczdj?=
 =?utf-8?B?SjZMRVQ2MVJSb2NXTXByNDl5ZnBtUFB1OWVnMmh6TDZ4NHE0YTBsdHExT2Zk?=
 =?utf-8?B?SU53cnVRQ3dXTzROU0ZJdWUvaW9MalRjcXhUNTd1WTlYdHErM1VzTElNYWFz?=
 =?utf-8?B?bEN3QTZ1SXFPM3pIV2FFSjFrS3JFbXNNcEsxNFZrRDl5RlZkeSs3MEo4dTlK?=
 =?utf-8?B?TlZLaVQ2bG4vSFYwZjZOSGs4RG52ME1WcU12L21aUHluSVdQNG5COWhDeUwv?=
 =?utf-8?B?bFl2T0IxQkkvVXlpb3VlZnd6dlh0YzdqajlzNStadHcrT3dMY2NIQXVaTXlM?=
 =?utf-8?B?bjNzSnpDOHo3aERnVkN1dlpjRmFiRmYvYUpxb21PRHBYMmFRSHVwSXhmTCtF?=
 =?utf-8?B?RkFSend6cXgvaG5WZUZ3ajl0ZVllZXYrYkxDWG5RRHV6OG9vRVFXc0QzNk01?=
 =?utf-8?B?ZjBYRUNkeHEvUTJYaXRuVGJFczZSOGJ6YnN5OGZzc1VYZkgxZ0pzL1FVOENX?=
 =?utf-8?B?ZGRuNkNkcjh6M1dTRWZFVWY1Unl3QTNHK0lWcWRhN0RXNXpZb1R1QUE2RWtk?=
 =?utf-8?B?YzV5L3VlUXl1WTFGYUpBbm9pSE5hUjBTaXFSME5zVTcvUkhYb3dlQ1p1eDVF?=
 =?utf-8?B?QjIzTUNrdjRUZGp4RUwweklZblF0ODRjL29FOXZVUzZocWlYREFGUGpjeHhm?=
 =?utf-8?B?ckJxemE1RlBxRVd3S0hVN1RxRHUvTjVUTCtldlRXUmZmcG1rcSs4NkhlemdP?=
 =?utf-8?B?NXRkUmxtemZLVklldGJzaVB6ZS9rZFZaYWFTUVdIcE9rZUdXdnlDVEZNeEg0?=
 =?utf-8?B?VFlOOEgxUFN5VVRYZTMxa21nd2M2U25ESW0xa05nNm9SZWZ3dkxpdnJCY2Jp?=
 =?utf-8?B?QXpRNnNseXU4OEhvUDdUTHh4UUdDbTF6SGhnc09YcDQ4eklxY1p2OTdYSkpy?=
 =?utf-8?Q?o/X0yIvUWXE1QcMdFe1cAhaqw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7856a501-6765-46c4-5e80-08dddf17f193
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:00:08.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PDa+nA+1MutfadBINwzXL5nXsPKkYRpi3bMhfPnr3ur6YVeEr3ruZDXYTbMg4IFAU6SA6OTFHJooL3ve5MsJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5729


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
Thanks for taking the time to explain! The devm_kmalloc_array() function
implements a check function similar to array_size() by default.


devm_kmalloc_array():

static inline void *devm_kmalloc_array(struct device *dev, size_t n, 
size_t size, gfp_t flags)
{
     size_t bytes;

     if (unlikely(check_mul_overflow(n, size, &bytes)))
         return NULL;

     return devm_kmalloc(dev, bytes, flags);
}
static inline void *devm_kcalloc(struct device *dev, size_t n, size_t 
size, gfp_t flags)
{
     return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
}


array_size():

static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
{
     size_t bytes;

     if (check_mul_overflow(factor1, factor2, &bytes))
         return SIZE_MAX;

     return bytes;
}

#define array_size(a, b)    size_mul(a, b)

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

