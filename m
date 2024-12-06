Return-Path: <linux-iio+bounces-13187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A751C9E7BC4
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61554283E50
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165C01F3D4C;
	Fri,  6 Dec 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="CsfxvXcB"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2103.outbound.protection.outlook.com [40.107.103.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A288122C6DD;
	Fri,  6 Dec 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524084; cv=fail; b=dh+Y+xFweZUSXpmSf1+kz2NBHHcZMC6vheFN4fC14vvxABxK53cYx1hqkK5gUwfYDhotcX+OYJWkeWeyngtTu5ySFMQIn4Nosu99QDMCMiFcU2YTL+RkKz9h5K1nzyQDt0x1u+dhKm/W4ZbYfvubktqJxkeF2KfgcUyBudoV4xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524084; c=relaxed/simple;
	bh=aniplOPlH8hMl5tQ+253Z60HuLu0eBCjNhRcetQ9wL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=buNHtpOAgNoBXZ+AOH9xX+CBg027eW5d/Fn+WJhhEM+NQgOJGxa8rmC32L4ifHaYX4ASWYi5qqd1JzKDqqIBc5Dvpx9iZsGOUD6Enh3lQFLw9bXNBkXdF6huejD7tAcCNxjqem30wuPWFn+6CyNR7YZ37U+8fSc6OT3g56Coyas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=CsfxvXcB; arc=fail smtp.client-ip=40.107.103.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZvsvrWuAeoUybdyNfVCCvKk9BfJVi08Co1iPggeaBG458LmHg3HKL5VaCoZs3Ie2OmBoK32efx4LOmOp7Pn08hQrTIlYrebDXe6E7yfdZkqwgGSdwz0Unh8kw/LKLO+E95UWnV6lFDWQLY/NfKypFO7rIpEvKghHBWVrVBcqRG4QdrzooFphoPeA1mKqDGx8OcTCSqZfCG1ZeeMDAee/+K/7gWln4v6HMKNruTD+W+EciSX8L6ZnCw4oD4Rr/9yzh0SGRiugbEjH2I5LvzFFqYi1zL8UAZYF55DSiPNbvBbB1ZxF9rH5yv3nZ6YoIabwJ9PHgb8MKR/eAbK2RyxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuicteeSmTsFTG1ZPSk8XRoYcMuJQJuosImxBNcCCj0=;
 b=Vv/Bs9c93EhouTQZkdoE5sKW1VKnT6O0XwE78UJG8EgGnjW9M+0172hnRDSkZnZpaEJA2EBo658fKxZ8fQcucq4kgBB+1plViDMLbmPZ+i4vbTjtO/+Y/rhMJSZDqFyNNxbRo5vUfRr8jxOx0SrPz6NrtOwqw+ETWPUGyV/mBjxCWOdI326y+0O9cSFsV3ukVNT7Y5YnVQ5byFGbPNlidJYPs3UIU5X0FPkPDjUtnA8Dh1KpOxxbD3LWUGLZ0G9gjAaXUT+WdIVEybZ9fbg3YRZzutJY76Ip3oqHrPb64SZ12vAL55Zm0szn4s7r9MytpRVoE9QXE4JOyUjL+LvCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuicteeSmTsFTG1ZPSk8XRoYcMuJQJuosImxBNcCCj0=;
 b=CsfxvXcBfJhC92KAFhmWyOXqTm7CheG2rxurdEA9dyo4uKRE7N9d3X5b7CIlk0bE2JLkrn55SpRTS1/ExmwR9gJWr2A0HPywcNb5hDHr/3RIGOsbQoQYJh2kJW2t1ykiztKvaxH3JHZKc7LoBdFrYexGcXa2jhxBLenpIEuRfSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by VI0PR02MB10609.eurprd02.prod.outlook.com (2603:10a6:800:205::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 22:27:54 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:27:54 +0000
Message-ID: <631f114e-c59f-ca69-6873-09dad1694913@axentia.se>
Date: Fri, 6 Dec 2024 23:27:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 1/4] iio: afe: rescale: Don't use ^ for booleans
Content-Language: sv-SE, en-US
To: David Laight <David.Laight@ACULAB.COM>,
 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
 <20241204013620.862943-2-andriy.shevchenko@linux.intel.com>
 <88f281a31d8342c691b2a6b2666d4e91@AcuMS.aculab.com>
 <Z1MWBsCJsTHsqNey@smile.fi.intel.com>
 <2a7a87267feb4c35ad9ef493236b6035@AcuMS.aculab.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <2a7a87267feb4c35ad9ef493236b6035@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::13) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|VI0PR02MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 93722780-16aa-4f4e-56a2-08dd16453a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3R6Q2lMMUI0aVpJYlJ5S21tK2g3ekZoRndsa1U4Mk1ENVJFT3FOa1l0a3Ax?=
 =?utf-8?B?eUc3a2VyWURwYW55L0JMdnFZRUxmLy9ucTJPVzdzU2M2SlEvbTk5amROSnRW?=
 =?utf-8?B?UDZiQUF5ZlhRZXBRcUVkbFlHNkxhRGxBTExzR0dxRGdZTDR6dG9qQlMwOGxE?=
 =?utf-8?B?N1cyTjh6eUJ2Z1JDTGxFNDRHSGdxWlJKcGRsWVROanVMMHh6R251UVhOWVFn?=
 =?utf-8?B?WGlCZWpwb3I0M1ROWVI3blBjK094RTlNVzZVemcxK2d6dzZEalB5eCtJVEQ0?=
 =?utf-8?B?SEorWE5aeW5WeElYM0RaTThOOUtTZkQ0K0YzK3I5ZTFLTTBOMEJ5bjQvOU12?=
 =?utf-8?B?dFRxajZwOFRTWmw1UGZvS2htWkRZKy9IcDVtdzNxY3hzMVpWbWRGOTFuaTAr?=
 =?utf-8?B?MXJkUHpTQUFCUkZQbGpnRlhCa3ZRODRRL3E5YXpLVm11aHRLMXNDczIwWU9H?=
 =?utf-8?B?Z1I4aE1yNzdaYzBRN1JwOFhnYXZhM3pwbmVVWWxPVTNLdUpGNlVPZFM1YXpn?=
 =?utf-8?B?WFh0V1pkdk8wWDJHYXdaSmo4N0xjVEd4YzNPZWpyUEpaZ3VxUGI5cnVMNmVC?=
 =?utf-8?B?SjlPcjV4SkVBaEQ2dDRYQ2l4eW90cTZGbzIydzM1NG80TUxzTENwZ0tGMFgv?=
 =?utf-8?B?bTROVFNFd2RSUEc3c2FHWVVzM1A5S1FHS2RvZFZjeVpsNjdEYnpRU1hXanoy?=
 =?utf-8?B?MDZlTUxxY3RwZlMrU01TOENLWFdTd01pQ3paT2sxMTIrMDVSS3RlUjd6WmVG?=
 =?utf-8?B?dStRNVNlL3lWUXMwdnJvRFl0Q2pxZG1PZTE3OVM4dzhwWTVRTzFoSkZ4MHA3?=
 =?utf-8?B?QU5Yd3RZY21OblRxTUp6cVJMa2FEUDl1S295Qmw4YjIxY2VrTUl1SDlpOERh?=
 =?utf-8?B?RmRsT3Y4NlRGZFBWTEkzRmFKNExqcnZLY1F6eGpUekJ2MmJkYXdDc2pKYWhI?=
 =?utf-8?B?RkdCVVhQNVQ4RUMzMGdySkN2Q2JEbGplTGZUT09nTmJoTnMreHlNdnFzbU5U?=
 =?utf-8?B?MGpQdU02ZDZUYkhKUVV6OUZBbENVeUY4R2Z6a2trbFh5Q0VtVFNxS1hBNVY1?=
 =?utf-8?B?RTRTL0haVVJNSE1MdCtnU3REQk9zMG5aOVFKemRYTUdJZDhPRHJXT2phVFZC?=
 =?utf-8?B?SVFaZ3VjcVI4TURpU2tRRENKVWxsLzdnTDFzVE5pczJ0ellZanVneXlzeDk3?=
 =?utf-8?B?VzF4Z212TW5KN0NINTNSblBrcnVRY1ZnYWs5dXFDUGJZUERHRVBZUUxsSDZN?=
 =?utf-8?B?KzBDWWR6amZtYVB2N25kRXNUbnoxZkl4djlNY0NPaUhKOG5KYVRuS0p2OEtV?=
 =?utf-8?B?cHB2cVVBNWpDRDVGeHlZNE95Ty8zNSsyMWtYODVpNlI1YkxlL0tFaXJIc0t6?=
 =?utf-8?B?OUt2K0RrUjNZZkkxS2sxekMzZkVDaVZzK0h1K055MHFCbVJZaUZzUHlFbW9v?=
 =?utf-8?B?cnRkemZxclRWMEs1WGJSTk11cFZPK1gyV2FFZTJUOXVsSERBRWxmeDhqV2Qw?=
 =?utf-8?B?bXJEUHpJbm1yZVlwOGdQaUZRVkgzMk9HM1NwM3ZZZURIajZkSlpnZysyYjJh?=
 =?utf-8?B?Qnpwa0hxd1V5bWd3RmpOS2ZJUjRLZDRZNmZuZUk1TC9hRWNRYzFnNjBiMzFD?=
 =?utf-8?B?emxVYmg3emp4ajVRL2ZJUktOOXpHWDFNM283eGplZGdpWWtBMWRwOUdJSDd4?=
 =?utf-8?B?TkRtVnZZd3E2UEg1RnZEa2s4aUQ4MytPeHM2bng3dTl2ejZ1UTdUQVNnbXR2?=
 =?utf-8?B?ZFgwRVBMVFozb1V5Q3JmWEU1QUF5MU0xMlhTWFV3a0t4VEVYa1pwSkZWdDN0?=
 =?utf-8?B?c3llSnNNdzFiMVFMaVJOdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QldqSVkzc1dGWlJTU1V2UTdKRnJPZjFpZTVxVTlGUnF1d2hNaXd5TmRFcXRP?=
 =?utf-8?B?VWtqMEJoVUs3dU52RVo1NThmcy9QTmRCN2V1RWJvOW9RTGQ5U3RKeFphbEw3?=
 =?utf-8?B?VDJGeTZHUHdiY3kvb0FnanM3T0htMG13UWRzWkd5dGI4TnR5MEVLNG1Ubk95?=
 =?utf-8?B?ekJoTU13RE9RZHhrSWJWanRNN0NDbjhHQ2dhM0FWbUZkNHNSc2I2cWMvNG5D?=
 =?utf-8?B?aVdwL3VuZ1lGMWVGN1VpR0R4L2lrNWhzMnBpZWJFVmZXQkMzdVI1WXVqVGpV?=
 =?utf-8?B?TEEva2IwQ1E4SlV3b1hEQStjVjVvanYxTGhwWFVyK0RaejZDclJ4bmFyTnpI?=
 =?utf-8?B?QmVOODVDZzEzWk1VUzdSdXJ5aHhBdkVHdXNoK29iTWRFRDhMTFBMdHcyWDdF?=
 =?utf-8?B?VzhYY3QzSHJkUkRSTGFkZlZJQm5WcHpsc3RIT2Nzbm9aZTYwYSsvYjNaZ0tx?=
 =?utf-8?B?RWlNT3JKdVdJd21WQTRwMDhmNzU4YU9TRTQzdmdjbHFVbGVzd2o4aVBrYjdi?=
 =?utf-8?B?Ync0d2ZEVHdvQjFOTFdtTlFPNEwwVWhscVZ6K09iVldDQkFCaEtTYXcrYXN6?=
 =?utf-8?B?Sy9PR0tySm81SVhPdzZ4SkE4V1o3VHdvUjhkejNIenVWcmhxRWhERFoxakg3?=
 =?utf-8?B?dWliVjV4YkVHK0VhcTRHWkhlU0dEaDNwRnp2V3pWUzh3MXpCVnBKc3U2SDdC?=
 =?utf-8?B?VVpVZzBMM0xiMVhNUHRkZW5LTWxsYnc3dGcrZ1Fnb1BHMVdYR0x4WHhJejV3?=
 =?utf-8?B?a3pzcXk0MFZMTmhRcVFrTWlLaDhRc1FQV0RCNC9ETEg1T1RiaDlaeGJZa2Zn?=
 =?utf-8?B?a080NlRJT1ZPZUVoaUNlVlh2R2VvdmNIMVRiaGVodFFrOW14K2tSN3RnbFlq?=
 =?utf-8?B?VGZUUjQ1TXIwQkR1Z1F2WmFQTWR0ZzdEM01Lb2U3VFArRXRjSGhac3d0aUtm?=
 =?utf-8?B?YTlvVlg3VUN0dENLWWVMR3VwdVhLWTFuZ28zcEx0N1RVNGYvS0hPOENHSWtS?=
 =?utf-8?B?L3NvZFN6ajBqL3Z0MjExL0U2RnZha3A3VVcvNHBFL1B1SXVyMWEvSmxHUy80?=
 =?utf-8?B?N25OMFg2UUZQbHYvZVpUUmpsMEJJaTNydHdiS25tY1BGREpldVJGSHJPWlFG?=
 =?utf-8?B?c2xpNnluSnVSOW0xdjF0UDA4RWNzcTVlemY4QUgwY2JJaWFPOWhkUWN4bjVU?=
 =?utf-8?B?YWE3RXRPRWRSdnNhV3gyOXRFVVBSektZS2tyL2hpYmxEUjJFcStnVm1tbStz?=
 =?utf-8?B?c2dDNk5ZNjJSTHlheU9qemZqbzhhdEJlYm5tUkF5SHhTQ21qcDdheENXVU1t?=
 =?utf-8?B?NHNOdHhNWjlqc25hZzdSY2J1VFNKeXdVR2F0Sy81a2NHWWJHd0E0c1pETThE?=
 =?utf-8?B?VS83SGRIL0l2NlQ5UHozYUY4NW5JWEFCRTJ4aGxqUVhUY2xKSXBSb1lJb1Ny?=
 =?utf-8?B?TEc4TGNKY2hhYUMyQTh6bXNuZHZ5UDBDLzdiOEJwcGQxb2VwZEFJdjh2eW5I?=
 =?utf-8?B?QlRhU0hiWW1pckJUbGdRc0FWcUZNQ2xWUXQ2bkhidDRxblJNRm9yZDltWWx6?=
 =?utf-8?B?NUFmb2ZIaUdnQWdNMytvVVpsWjBYTjNuY3l5R0RCSDhCU3JraXlJYUJsQmFZ?=
 =?utf-8?B?bGdrVXAwdU9Mekp5bnFNb0I4L3V4TEl3V1NBcndOZlJXNkdHekVqcTFFNXNV?=
 =?utf-8?B?VlJhNW44SGZ1aXlRL2ZFemJxcUVGOGlMWnpIeHgzMWxCcDRJbFdQS0tYNVlo?=
 =?utf-8?B?akVwbGhsTTYwSFczNENuaWh4MWFuQ2pQUDlpRVdYdE9tTWhaMDgrdjJHS09S?=
 =?utf-8?B?RStnbWJwc1FSWVd0RUJUSzBMYTNkUGQ1SHRLRGdDVkVyN3JzMVFhZ2ZkZ3kz?=
 =?utf-8?B?Qmh1U2ZaQWdnV0tvU095c2JRZFFjdzBYMnZhcVNIaEZYN1BuVm5KdFJRM1Vh?=
 =?utf-8?B?eXVzWFRPTHcyYmNUQlhDbXVEeEdkZTBSeTQyakdkZ1gvUFg4L3M3dXlleDJy?=
 =?utf-8?B?WnZDNitnYjR2SXd3Rmd3VitkYWNhQjd5K1ZwSEFoS3ZVeGtXYTQzQXJJOTh5?=
 =?utf-8?B?RHV6VHU3Qk1KRUJHcG1RZVdzeFVNS0o5eVptYlpUaXVScXJUWXVpMlQwOGNO?=
 =?utf-8?Q?Bt8GY1V951QoLjI0VwBuc5aLW?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 93722780-16aa-4f4e-56a2-08dd16453a60
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:27:54.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3nMcvgGZxU2Ro9TkEesw6zw0QbplsRgxPJE2y4pR+MhZfCJuNACiOc3kA6yRz9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10609

Hi!

2024-12-06 at 21:13, David Laight wrote:
> From: 'Andy Shevchenko'
>> Sent: 06 December 2024 15:20
> ...
>> ...
>>
>>>>  		 * If only one of the rescaler elements or the schan scale is
>>>>  		 * negative, the combined scale is negative.
>>>>  		 */
>>>> -		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
>>>> +		if (neg != (rescale->numerator < 0 || rescale->denominator < 0)) {
>>>
>>> That is wrong, the || would also need to be !=.
>>
>> Why do you think so? Maybe it's comment(s) that is(are) wrong?
> 
> The old code certainly negates for each of them - so you can get the double
> and triple negative cases.

Indeed. And for me, xor is the natural operator for getting to such
"oddness" when three or more values needs to be considered. So, I
prefer to keep the code as is since a ^ b ^ c is nice and succinct,
while anything you try to write using != is going to be convoluted
when you have three or more values.

> So believe the code not the comment.

I claim that the comment is correct. Or at least not incorrect. It might
not be complete, but what it does state holds. It does not spell out that
the combined scale is positive if both of the rescaler elements and the
schan scale are positive. It does not spell out that the combined scale
is negative if all three are negative. What it does give you though, is
a hint that the whole if () is all about the sign of the combined scale.

But yes, the comment could be improved.

I expect a fail from this test in iio-test-rescale.c with the new code

	{
		.name = "negative IIO_VAL_INT_PLUS_NANO, 3 negative",
		.numerator = -1000000,
		.denominator = -8060,
		.schan_scale_type = IIO_VAL_INT_PLUS_NANO,
		.schan_val = -10,
		.schan_val2 = 123456,
		.expected = "-1240.710106203",
	},

but the 0-day has been silent. I wonder why? Does it not actually
run the tests?

There could also be some more tests to try make sure the logic doesn't
regress. The first of these should also fail with this patch, while
the second should be ok.

	{
		.name = "positive IIO_VAL_INT_PLUS_MICRO, 2 negative",
		.numerator = -1,
		.denominator = -2,
		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
		.schan_val = 5,
		.schan_val2 = 1234,
		.expected = "2.500617",
	},
	{
		.name = "positive IIO_VAL_INT_PLUS_MICRO, 2 negative",
		.numerator = 1,
		.denominator = -2,
		.schan_scale_type = IIO_VAL_INT_PLUS_MICRO,
		.schan_val = -5,
		.schan_val2 = 1234,
		.expected = "2.500617",
	},

Cheers,
Peter

