Return-Path: <linux-iio+bounces-27685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3350D1CE4D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 281FD30AD249
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAD379998;
	Wed, 14 Jan 2026 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="zLXjcIJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023108.outbound.protection.outlook.com [40.107.159.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56B35E546;
	Wed, 14 Jan 2026 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376523; cv=fail; b=QFKo6qUWLfx7l14CAWgh9qFtc45drimtj7Sur4Xbu3FZchPeoTUHR+DubXFoY6aMnExS54ApJECypl7Bv4EVuK/g87G/PHuMY3oWhmuN5EfO4Ez6bsZBuzqvnr8hq0p7xzYBn9Vn4hD9ytWZuNLiCkHc9V6uOJGIr8UJeEjeyY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376523; c=relaxed/simple;
	bh=3Abe4qU+VQmNzhJg7lMvsdly7w3qOV0P/0nnrmWIMZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wjb35qElmH2VehUsL/HE1zhs8IaAAwdnvWRcp7y8QyZvgixC6D1vBCQ3hG+iNG+WxGJVa9aFYxOkeEZ6tTMQZlvV3jT4c/IooJ+FAQsHcHuss1k8XsXlDxERx1R1oH6Sc62/3dd9tfEpSrHiFax/UFbGWWXahfKk3Y7qjV+s5Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=zLXjcIJD; arc=fail smtp.client-ip=40.107.159.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RujmLW9qdxFgySmKWRPpseerWuVDDPYczUHllFbTYp2lg3ki7XQePGsSdR9xYF6Hp3Yz3Mux7inKC3T0MjOX+ij/ChhB3QvWesAUnaOo3/umcNkF+NH82bG1vp7AgFulXX6jwxwf++wA5+0EspPOmRBJkXqvpSQk1bTMvIP6PBLZD0VsHMiWpjhfoSwNDdl/1yko6IAw57m3Z62QNR+P/oWGJvE4RLddM+xrxLiLfq4HHP4NHQN9U1bU5/vAGYzus/iSVuq+HjkB7Qr4bk/QgUiLGT0oVoSneQOz02RUunc7H21ejz6PrwgZILFocmsA5dj6iDSQL7iOZQIxsZQ5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIIVzU0Oxhlu1IwOSHfAFwBZQxQu9ygx7rIlEWGmO14=;
 b=zMRubBkG4QVcIuWnNRBVhNEm3q2Qp9oeTy837NOiSMY5sk0o7IM9mCnPbM2yPnQXq0vU7cU02fi0BdjofP5ZOpZPyZqSjH71YMADAQRb9uOUwq5c2FzrDu0cnwbPnXlq0XEVHB2Mx/+JnjhlJhcvOlGlIYTQyX2TNDn7vm1RV4wJ4AXK+hU8M2gFPL3hPFzTqax+57mbI9c8I/bShyOH4CYmFHNa5ahUNAAez5UGIxuNIxie4Aac3yd2nemaipbAqJs96XMYPBeqkEOoi8WdkjhXOkSYrk+RjPEsADnq44sj2ml1UO2rmeTx4S6h4sW8tz21gijlNhc3HzlehQfECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIIVzU0Oxhlu1IwOSHfAFwBZQxQu9ygx7rIlEWGmO14=;
 b=zLXjcIJD80CCOm5aAfGrovrh7wLCN3MvFo0hvXS3dpiDLTP/S0pyz9MwH+yGfyFNBeGQTKxE8vYStSIAPnw6iTC1T9yoa/vZ9HfvlUaCvKZrTi8P5UqA8FTC+Yv4gx+9JPQVgc0gXDDKIsRfhAqsENbWoM9isi9b2CKw4d69d5k5OjYoK+tOCZ5109dXAOOwrGFCN+mFoFfP5KSSm9+aR7+tkGHB3UWhTSZvaTzAUJXnUVVozmI40m7WQ8uP6QRE+TbBMBEwiURlYvE8+oUUnQNFZJPKHSUlZoFFKD/iF/t9PDhu5O1TynwmAeZJOJiUDP87qSlaezElPMxapjSzrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AS8PR06MB7734.eurprd06.prod.outlook.com (2603:10a6:20b:33f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 07:41:51 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 07:41:51 +0000
Message-ID: <2fe971bc-9ab0-42c6-a498-b67edb54dfb5@vaisala.com>
Date: Wed, 14 Jan 2026 09:41:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: adc: ad9467: include two's complement in
 default mode
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-1-0a27e7e72f41@vaisala.com>
 <aWaza9cRb0kpsE0w@smile.fi.intel.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <aWaza9cRb0kpsE0w@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::16) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AS8PR06MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 36565b6b-ccab-4a4e-d68e-08de53406187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UThkMXdveVBuVzExVkpaVUVxSVJFK1ZBYjZOd0RxK3BBTDE0R3ZiKzl0SmVF?=
 =?utf-8?B?T3Q5YkIxV1Q2aXpZak1VZTFycVFNUTMvNXo2ZWhacTk5L0VKWjd6V1YydHZl?=
 =?utf-8?B?LzRFd3VNVjZoaWtxa04yWjlNZDZ2VEIyOGdqV2p3aVBHR2Y0TjhiR3Y5Yyt3?=
 =?utf-8?B?ZDloMG5aeGpmZjZZcWRJSXVVa2xIWmE4Z0MzU3BkR0MvZE42VDdiVHhHUWJJ?=
 =?utf-8?B?dlZkWWNYcDBDd1ZBbUxDMXNVNnJ4bUdUV2NJeVZGQzZ3WW1SSHFTRkIrQVB1?=
 =?utf-8?B?YU1KNk54U1lpcEJ5bDV4TjFqWlpkdHViL3dKU0hWOGRhOGlzM3VwZmFxNlN2?=
 =?utf-8?B?dGt4RW0vT0ZXR1JJa0RiUjYwZzBKMWJDZ3VQMUFjQTkyMWR0M1JPbFRNczUr?=
 =?utf-8?B?cWd2cVUyRUVzeHArZjN1MmUvYVVIamgrWllDZGFJZzR2RThsUVROU0tvQ2FU?=
 =?utf-8?B?K09JeUlRV2pYaG1JY25RUDhoZWhaaE5SRm1pTHBRNk5EeHdHcU9Pdk1MRFhX?=
 =?utf-8?B?bmd3Z1RrcFI0cm90Y3BXcmJhNFJlZU4vNlcxWHRuRWJWa0szZ1QyUnZUVUhF?=
 =?utf-8?B?TUpYd2ZmQzZ3YVlKQnJyMkc4TmhjbFphTWowUVZFb1NjNEJmS3ljNG1HUXQ2?=
 =?utf-8?B?QVpBR3BHNk9MNVhKdlozUHR5V2xGRktwT0tmaE5TUHJxSEM3eFlJL2dSaGR3?=
 =?utf-8?B?THFVeUExUVRlMDFZR0UvMEphMlpZTmExdnJnYWwzNTZsNndxaWZHZTkxc04r?=
 =?utf-8?B?bkx0dmZKVkU5Tm1MVVZjWGt3WVZ3NndpKzUxSG5YVXZHQU42amptZFZDR2tP?=
 =?utf-8?B?aGtkeTAxcHJabjRRWEczMlFLWlBjMlRtSVdRTkxFaXY5ME1DM3VJL0UwamhE?=
 =?utf-8?B?cXdQUEtoZ0ZoT3dpTnpyRkUrL3ZBTmM0R1dZVE9mdVpQbyt0cWFxN2FzNzR3?=
 =?utf-8?B?cTVVRDdPUXQ3UDV4bmJDNktydXBuUmt1MXl0R1RJM2ttUWwvM0dpak42d1A5?=
 =?utf-8?B?Y1NRU1RWME5vMlRZY2Z2ZFVleHc2U3crcm80eENnUXhrS0xHVnlHaU1KVWsz?=
 =?utf-8?B?c0NFWUxKN3FSS0hqeXRTRUZlMzE3V0JhYml1RDdpcmhhSnNXM2grZmFkWFJL?=
 =?utf-8?B?UGNieDRLQ3loSG9BdUZhMzZiMGE2QWdtQktDVU4zdG53UDVIejYwV0pMS0V6?=
 =?utf-8?B?SjVYL3RQQmNRMmJUOGlOMHMvbS9qK1huODRqZWd1Z0Qybm8rQWhFbjVxTU1z?=
 =?utf-8?B?SERadjFBRGFYdlpmUTZlUGdZcjc5eFpGcEpaN2dTUVUwcWVhb2RhV3QrZVEv?=
 =?utf-8?B?OHFPekxJTWk1TWxYaTdydy94TEdHTTNldjdLbmRwaUdlZXRiamw5NC9iNVNO?=
 =?utf-8?B?R0djWCtVaS91YzF2VHNPc0JLTmp4NGI4RzMvT2xSM2RyeElTSytPSitaUm1n?=
 =?utf-8?B?a0YzZVVmQ0NsekZqUGdiMXdrL2cvZGNFaEJsN1pxazlxYUlqMXZBd1AvbnNG?=
 =?utf-8?B?Vlh0aTBhelJ0NTA5NTN1K3NwUTRJakI3Mi9yYUE4M3V1UTVOcklKQ3FySnFK?=
 =?utf-8?B?QUswNUErMW5pRlVzcmJLVlF1YWhHNi9COWUzelVXcUpBeHl4OEdmM1IzTUdL?=
 =?utf-8?B?dTJielgrQUdEdkd0OGppWEhXZlVWcmI2NElsdW8zbzJmdUphU3BSdDBabFNW?=
 =?utf-8?B?T1kxMUNaU3g5MVJnTnNYSW1VenkvZmNHSTVnZ3IrMHlQN1V0cm9PVm1JdWxI?=
 =?utf-8?B?UEJPV05NS3dhUXdkY1FuaUl2ZmpWU3pXNGxodmlXeUV5c3hZdzgxMjZzSTZX?=
 =?utf-8?B?UTVLYTErS2NyZjZNQW1OVkZ5VksvTHYwUGxQdklCTFdrdThKKzNzWXhCTWhS?=
 =?utf-8?B?Rk9KV1UySU5saXM3dmtwcndjTnkwSDh6U0hra2ZURGMyQ3VkcFJkcDB3bHJp?=
 =?utf-8?Q?VHTrexqZ0ACoBbSW6epTvg/6PrG0sM6N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWJkbGxMRng4ZTJ4aWhVL1hLQVU2RkpHQXFaYWVESHZyR1BYeEVwTUVsRWRi?=
 =?utf-8?B?KzNZR3JBZ3FxMGllaHoyL29uVFV0bHQ5cVdyV0ZvZ21YbGNyUmUzY2t6L3pV?=
 =?utf-8?B?SlJJRld0ZWFZSWo0bmNJTi95RXR4Z2FEdThTM1BqRHYxSk1YdFA0b3EydDkx?=
 =?utf-8?B?TndQdm9DajVvcTIybnptMldueGxHc3ZaWFFrMjVCWExITDZ3NWlIc2hyWGpu?=
 =?utf-8?B?UU5CVlJGYVIvRnpwYjdPT0UwWTlaellMcG8zSkZUbC94V0U1a1ZmcW52VDhk?=
 =?utf-8?B?TnFXcUFERGw0bDRKUFlaZVZ2bFc1Q0xEVjhGUy91V296V3BVTFBraFUyVlRM?=
 =?utf-8?B?RHdzTjFpcFo4b3NEZXVsdEhQT1FCUkFzNWx2SFNlODEyZG1HaHpmNUVqZ3hV?=
 =?utf-8?B?VTZkdXI1RkdxTm9KOVBubDZ4eE01R2lSbjlkdXAzUUFOaldCRHpGSFdKeHhL?=
 =?utf-8?B?eDEwNDVTbEU2bVE1NmxicHV2MUF5dWI2RVNuejBNNWZuVjA2ZjNOR3hheGE3?=
 =?utf-8?B?UkJ4aVJGVE14U2s4S1drUmRGK1kvQnJkdTBNM3JlT3hPY09yUDgxUmM0ZzNF?=
 =?utf-8?B?NUdHcVUwWFBTZ3NqTy9zRFdvUjE4WVAxTFozQTRZd2txQjNkcEtjSjFuRHNu?=
 =?utf-8?B?ekZQWXp4YlgzdE1NZjE1bnJWTzRDRVc3Vm5oOEpzY05JYktWT1B0Y3NvcEJk?=
 =?utf-8?B?aEMxZ1JDM21idEZqOXFpbG93UThKamdCVzA0anJqNGg0eWlOQ1ZDaG5xNWJ3?=
 =?utf-8?B?N0hCMjBYbktDYVROemJGV0VBdXJ6ZTFxMitEdXJLZ2l4cEY0dnE4dDlGd1VD?=
 =?utf-8?B?RDl4QXF6UnJqNHNjV1B1eUNlSjRlQTB5ZVpsZmdOK3Y1aFJiTmtVVkJ0amhL?=
 =?utf-8?B?d2ZackxOQkk1cmJWZy9SVE5FVnZCbjJISjNEWjJrbjJtWCsweitDM2ROZEFo?=
 =?utf-8?B?TklXK0tnQ3dWVERiVUNlcnhBcFJERm80b3hlTHVKaWVpemNWL1FUdzdud1NQ?=
 =?utf-8?B?WjVIZHBtdjcvdjg3VnNIVlFHbjVZTjJMdEE1NHZ1UGdvc3poUEZmTzhPUXNX?=
 =?utf-8?B?Q3hXZkM0bkNqRlo4QmZicVBsejQvK25FQ2xMMjBvU3l5RWtPbksrZmlkTXM4?=
 =?utf-8?B?RmdpSU1zNE52Q3dQNXo2YlpiQ1lhMlA2K3dzcjU1cUZJdGZvdm45L3hPYlFx?=
 =?utf-8?B?UkVua3Q3RHNuUytIcCtKUWozaURpY0xxUzJxUE1ITlRLckUwaGxkeVY4dG9G?=
 =?utf-8?B?cW1IaEtyTmV0KzlLckZCdEwxQjl3NVJZdG9BL0JwbVZVbVphUjFReTNZM2Z3?=
 =?utf-8?B?dW1tUGozclVPcm9iNjYvOHZWSWJubHNvejNEWGJDVjZkTXYvb3dnN29YOXgr?=
 =?utf-8?B?SUxBbTZTb3ZsbnUwR25sdmI3emRrR0J0L0JrWXlLb3hwKzBpSGs5OE5vVlBv?=
 =?utf-8?B?N2dQaXdVNjl4UHJvZDBUWE0zc1NTTzJaeXZPVDhqNjB4eVZma1pFNFRlSWJL?=
 =?utf-8?B?QnBtRlNSVUtaVC9MbWxnQUJiamZ3cU5RdGthTFpMMWNNVUhTa0FKQU1qNktY?=
 =?utf-8?B?d2JqbkZWcGVRcEJFeEVXejBZOXFHZnJqdkhYZXJscGxHb1ZMYTRhR1dqTzJN?=
 =?utf-8?B?dHBDOVgxQnFhR2JMdnVuZVo4aFphM0tSMWlxaFd5ekFIcnR5MXlEeGoyRXRP?=
 =?utf-8?B?aThwVmhrVlhLN0pCTVVSRnZYQ0QybXZYNWN3MnN6MGxybFZER0VOM0tkWVFw?=
 =?utf-8?B?QklWL3Q5bFg3dFFiZmJVMVJwUHU0VWtYQmplaThlTzJYY3kyRy9jQlNhWXls?=
 =?utf-8?B?YlNMdjlzR29RMTU3OER2VHl0UE5hQXAreHhDZHVVMzU5dUFycG1PSjNHRDZD?=
 =?utf-8?B?ekdGWjNlcmJyenIwYnV3dkh6Z2EzN0w5dnppTzlLSTBmbnBCQWJnTlNWR0FI?=
 =?utf-8?B?NzYwNS94U2ZYajNHVG8vUVBKMU01SWdLYk9RWllmY3VYRGE3cFVEZmlTOENP?=
 =?utf-8?B?RHM5RkRWM2NSN3NKTkpRWDQzWHFyYzlVbU1UVjEzeFZ1bDhyRlJEdTQzL0dE?=
 =?utf-8?B?VHJNQXZZVHNCN2VGZjlqRGZObnpnRkRsK1p5bFl4Vm9oR3owWnZiNE5GbW1Z?=
 =?utf-8?B?SjN2dVBPU2FSVTZlMTNHOGpxU0p6SU8vTWJ6SG9mLzNTdkp2ZXFIbTFXV1Qr?=
 =?utf-8?B?cjh2NDVxNUNZa0EweERHUWJ6M2V2czdqV2NBTXJxRnh3RXdIMVM4L2pISGRP?=
 =?utf-8?B?Vlh3Tno2NjRTRE5xbk96NDluQlBVYnlJZkdyclhuT0VrOFNkYW5lUk1nM2h0?=
 =?utf-8?B?WlhWYkY1bGhQL3o5aDNQeHpoNFhnR2tEOGFHbVRvQnUxdjlQeklLZzR6bFRz?=
 =?utf-8?Q?cCdm9Tycpf72o8i4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36565b6b-ccab-4a4e-d68e-08de53406187
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:41:51.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaWC10MsDw9QguQJx1hhSoWVbbcLPweF3URGk47hVY7be+437MYba1Ay15dlY5tf+sDbd3CGR2A4pPdxhCKeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7734



On 13/01/2026 23:04, Andy Shevchenko wrote:
> On Tue, Jan 13, 2026 at 12:12:47PM +0000, Tomas Melin wrote:
>> All supported drivers currently implicitly use two's complement mode.
>> Make this clear by declaring two's complement in the default
>> output mode. Calibration mode uses offset binary, so change the output
>> mode only when running the calibration or other test mode.
> 
> ...
> 
>>  #include <linux/bitmap.h>
>>  #include <linux/bitops.h>
> 
> Side note: bitmap.h implies and guarantees all bit ops to be provided. No need
> to include bitops.h when bitmap.h is present.
> 
> ...
> 
>>  #define CHIPID_AD9652                   0xC1
>> +#define AD9652_DEF_OUTPUT_MODE		0x01
>>  #define AD9652_REG_VREF_MASK            0xC0
> 
> Another side note: The other definitions around (mistakenly) have been indented
> with spaces. You can see the problem in the diff.
I noticed this too but kept it out of this diff as not directly related.
Thanks for these remarks, keeping in mind for further updates.

BR,
Tomas



> 


