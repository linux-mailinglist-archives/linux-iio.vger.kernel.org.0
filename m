Return-Path: <linux-iio+bounces-22010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71936B11785
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 06:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BB2564D8C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 04:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694841C84B8;
	Fri, 25 Jul 2025 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FNQMyih5"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC24A3E;
	Fri, 25 Jul 2025 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418856; cv=fail; b=ciuDV4UAe+1yU1XKsj8ehQOBPyjBG3tqpurtkesUSvOJouuDVzydXlitJoTx5p6ghxhFdOgCUaj8bgLFwygc0v1+a/KEqymlihe/K6DDJ2R547mhyVbcBEQMsCENPizLHZtgj87QTHIJhVrfGhkTjlj5vis9nJsoVhtJDXaKuhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418856; c=relaxed/simple;
	bh=yW3g1ygQasvRMOwEu9h2zOYj2TUTspDsDd4mW0s2rjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ocTs243Bgt0L+CPNEgZNWihxWVq5CS3larD0W1+HssJUfOGA1DIZRNqjq0ofjhaDCZMGgboophwN7ur0A7S5WMa1vB/l5Dz3O64S+TEwd6yuuEqSEaYEFUFNw+cYCWEPmtsElzhZDNngSsCyPB/ukjBt8DI7OrHRAEFg5Luf7/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FNQMyih5; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8SKcTj0Q6sL10wS9Kz5S7v8cliCYn8MYVClzunV8FAm70795EJXf8Bz7/nkHjmpESjBqSGKLN2P0X2/Qv+lY2+j4ppukdxA/FX0XlRiD2n7s9JQPLIgMbdpvCRh5IHi8iejFmNcVWC7v7ITT1DhHvxn5NSWltD24M9wx8H6hnYXxQx62vdKS+Sr10dfIt9ANw/pS79xIZzK8LOAjTZXnw4wIt0FWvzrALX/25bDJWKs97nAUgzlfdiN0AB2koEHC2fRhYrOgS4Y1ye/TY9LWe2rKLc2Z2LcjjiWausU4mSLG5XJ3O8u2SfR2clioCj7Vy1C96uhkqX4i1M32RA3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7WmBMSPb0NTsvAmre+lbriU79RGZE+d4QR0JQahxMg=;
 b=qYjYpqtCZaYqk23hlYWGYoJfYYrEKEGAphimNOtI8XVrkYloMe4lAFch/8yRj0HQEkDgZw6O/Rd9ENt5ZE19FW7+iA3d0swaN9QlgKjnREMEquNAYMkqSmufPZHhfLXwn1mkr4q2OgdaQ1g79C3gkK6VwOpRnVUc8YUCV2REW7sbBgGwt/Ik7flBMe/okwkze77t6YP7OW1oe25xZXtG+hWYEfSTeZ9tY87v/giTH1yi3PLpzC+PYp0EeSuWHyjJefnSfvOb0qMLAk1gjCa5sAmUqv3OJlLoLGktdYdes1KS+I1KnAeRBpLu6UXj1u/lW2Scm499zs3mLXNTW+Wzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7WmBMSPb0NTsvAmre+lbriU79RGZE+d4QR0JQahxMg=;
 b=FNQMyih5mlvwP9yudkggnljt27JNZx6g3iT+xgvIV8+JSkkY+s1S7jnzDvLkjgRjeYkf4sOZq9wS2YMiVvm1QkUag6E+VO+KPER1QO28oacUHDgVZQDwzTdqdOW7NQA/UfUuW8ofhqaI0wmTz/s+8EoA9ePhZvSJ1TkwmEP0UaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 04:47:31 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 04:47:31 +0000
Message-ID: <3a77d5db-eeb4-43df-9de0-e6bafea4d9ea@amd.com>
Date: Fri, 25 Jul 2025 06:47:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: xilinx-ams: Unmask interrupts after updating alarms
To: Jonathan Cameron <jic23@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, Salih Erim <salih.erim@amd.com>,
 "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy@kernel.org>,
 Manish Narani <manish.narani@xilinx.com>, linux-kernel@vger.kernel.org
References: <20250715002847.2035228-1-sean.anderson@linux.dev>
 <20250724163219.0098ced6@jic23-huawei>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250724163219.0098ced6@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 901b1d28-0cd9-4856-b98f-08ddcb365cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGQ3MWptcHplRTRuRVZBUTRhdmh0VWdvVXI0aHRTZXVOUk1tNXhhRWpuRCtN?=
 =?utf-8?B?aC81UjN1MlJESVdhKy8xbHFaYlZGc1ZheTBhdHowcnRmZ2lNbGdKZHZUZm1R?=
 =?utf-8?B?VE5OL25ETnlTVmRJZS8xQnRQRlZsQ2N4TmNNamx2dnhmSmlqTnZSZXBVK3o1?=
 =?utf-8?B?dE9wZWRNYUZhYjlTc3VzSHM3cVdwSGprOUc3Z3pPK25TeTdka2VLRmVYUFBN?=
 =?utf-8?B?Q3JZVHNVWDVwUVRhUmJzQ0NucFFVR0R6OFV1dVZZT0o0RThDQi9PMlZyRHV2?=
 =?utf-8?B?NmpXS3dxMkJNM1FSOXRSbmFPZG1KaFRqc3lDYU5NL29ta25Zb1R1UlJiUmRX?=
 =?utf-8?B?cGx4T2VlOTJuTkhaNTNqbEdIT2dmOW9pa2Rtbm9UWEdXRFlzUy9hUzRWUnp4?=
 =?utf-8?B?ZGxDU3RoYzlPTm5rdCtjVkVjMnA3ME1Vd3RTeU9sM2xiL3F4RVpXTjNFNG1J?=
 =?utf-8?B?NHlJSWU5MENqWG9RMTZjWWM1N0VuYitQVEdUd2ZoeWpTdUZLMEc3ZU5oMUlm?=
 =?utf-8?B?bEpwVWxLcEJaT3c5SnF0ZkpFelJSdktXaThWd3d6MlRwNVltbXFqOHFCQlkx?=
 =?utf-8?B?aGsxQ3g2MTdybmV6cHdEMWI4RFJQYy90RlZsRjROQVZjaEdEeTI4eXR5SDFr?=
 =?utf-8?B?U1JLWnU0bkR2RmtvODBjMU55VlFTZDNIU3UxeEF6Z2lla09jWFVHYitGb1ho?=
 =?utf-8?B?Zm1EQ0UrVFBoZ3YwYVl2aFR2T3luWml1eDlkTnZwaTNxN0ZlQThvbXJFUTdZ?=
 =?utf-8?B?MUlsbjU1MW16RWdBU0NBMXM4MUhWcTZkVWpTMEQ0aXZCWWphQWVQWWorQ2pF?=
 =?utf-8?B?bUxWcHBMeGRDbXlsZjF6d2FIOWZWQktZNnpRU3o1QWxFWXJZR3lPaFdmS0RX?=
 =?utf-8?B?NWdPeVEvdGFpMVZFYjhZYVplQmpCMWJTdXg1dnpZMnE3QzZQOU04S0tBUW5P?=
 =?utf-8?B?eWJQUVN1aWowTGxpUHRDallnOGVlV0daanBLaTNJZTdTTmg2OUMwcFYySWJu?=
 =?utf-8?B?UVV4YVZ5cVptK0RGaDNZQWxlOW13NHpSYUdKaXRaVmJFTGN3dFkvVEpENUY2?=
 =?utf-8?B?cDNiYjN0UlVCd2tMaFdsQjgveVBVV1FzTW1rb0tpN1RwbTlMb3kvSzhDTUpE?=
 =?utf-8?B?QmtoMzFrNzMzMW9WeWYvZG5FdXFsL045aUhwa0RlWkVEcDZVKytCVmg5cjVo?=
 =?utf-8?B?YW1pK2RYSTltcXhhTFhPeEpqSHowdHFHNXowSi9CR1BHM0xWbm81blVnelps?=
 =?utf-8?B?bXR1MDRKUzJCOW1oSkp6MWlGUnRydnQ0QXh4SlJ6aXNKSXk1MWhnalFHWTRz?=
 =?utf-8?B?TnhvbzFFK0J3VGVZc3VheG05Undtc2ZFR2tiN0FsT3ZMazRLcytjUHBzM0sv?=
 =?utf-8?B?emx4aVFxRFRUNkJQaFRaRXF0KzBUcFFadSs2RmlGUW1Xa0dJR1R1cUFVUDZv?=
 =?utf-8?B?VUtnQ0YxeTVxN0pxb05EU1VZL2UyQzd3eVM1c3dMMUtzUVloNWM0ZmFzVTY4?=
 =?utf-8?B?dU5aT2luUDhyK2o2YWl6WTdyemZYdWR1M0h1M1hDbXUzbkZLWW5jWHRvSmtK?=
 =?utf-8?B?THZiVTIyZTM0cTBKWTBPQ3RncGtXNi9yY204R2syeTBZdkpPTVdhOWk1bHFz?=
 =?utf-8?B?OEh3Wlg4d0V5ZnhONjZkSENzV3J2UkVoekdVUzhyT2MxbndSbG9EMFFvc1Vj?=
 =?utf-8?B?T0xXcU5hQUYwN3ExaGxKK2VtbVUwTmRuUUNmeVoydnl4N1lFRXJ0QWFDeG4w?=
 =?utf-8?B?a2V0clRja1JVOEhSZmhRem5KdXJUUFlDMjRMWXhqckgvRnpQQWNFRUdOYlR0?=
 =?utf-8?B?bmZSdS9haTQ0cDRjMkVPZDBlQXhLcHdabnlCKzQ0QTFuaXFjb1dCUTF0SXJW?=
 =?utf-8?B?Y2YrK1RlM1dscmJIaEcvSkN1YWRNNGlGeXloeWN5MXB3dzdYL0R4dTB0ZTEv?=
 =?utf-8?Q?KRU3pnY5SvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmxWSnpLUEhwMHNZSFI3ZGYvdjBlZzAxdS90WG9IREk5WVZhb3RJK3FOMHFv?=
 =?utf-8?B?Q1ptZDVMaWNxQWZkRzZPd2ticFNNdEJ5VVlEUWpHQWRVTzVNSk93cUdQWDN4?=
 =?utf-8?B?dCtFalFlTkIvUVA1dWFaaDh5RmVZSnRNV0JBaXdFVmFRb09XSnE0MC9CeXhQ?=
 =?utf-8?B?ZWdBNlM1c28xMHhGQkY2MWg4WjZFeDZIaWQ3OGk0L1FzQ3I0SXo3Qnl3bzRI?=
 =?utf-8?B?SUtrTjJlZzg2enpXaGdXa0RaL2lnaHZjMmZtMGlORlhpQnY1MTN1M2QxNTFT?=
 =?utf-8?B?ZnJVcDBxMG5HeFNuck5jVlN6MG11OFpQNlRIQkhCMzQrQzZxNWxnd3pYamdt?=
 =?utf-8?B?MHhKQlVHOWlzWFEzRUFkZE05blltNmFDTFkzRk1MK0Q1MjVhdkdUUjYvSmtR?=
 =?utf-8?B?enBNQmxIL2ljNnlSUE1FelQzdzdwb0xMQnlpWk9ndTllSGxCWjR6bWNLZWww?=
 =?utf-8?B?MUdBNmpKZm9IdHRPQ1RIQWw3Wjc4alpNRHpxdkhWSGM1OW85YVVyNHNlUHlr?=
 =?utf-8?B?cm9MbVVBSlJpVEhEOTdJQ3pGdVl5Vmc4OUhhUlFCZThHcGRnSVppeEx2ekEr?=
 =?utf-8?B?TWVsN1diMENweitYY0NxdENiZHRSTVVlRW85K3FISGEzRXFPc29XUWZVME1C?=
 =?utf-8?B?MUNWclU5YjJsZVc2VUNSTnZlQ1RHRUZkREFxZy9zYVR1TGhvZml4MnB3MFlP?=
 =?utf-8?B?eGhtSFlKcG41czY0R1hocUJFZzVWRTNLZjU3SWM4V2s3bU40UVNaS21CUlN1?=
 =?utf-8?B?UUREZGMzQWlIVHFIMTAyU3JrY1ZqU3diWHAySUNjYnNHaUphUGhDSzNTeGhu?=
 =?utf-8?B?REJHeUZBRDhGeHNXcTB0Y3FpZW8rQkYvY2NvYW1vL3JaYi9lcjhoTEJyWmty?=
 =?utf-8?B?SGd5SW5yV21Cai9FTGRaTjNvMEU1VXRoM3JKQWlBMFhpNmNhT0ZyWVAvV0sr?=
 =?utf-8?B?UnNwWDNzcmRoK3hEVXpRUWlFMGpkMTBTRnZ4YUx0R0t6WEhJYit1NXZFNnBi?=
 =?utf-8?B?SHdFbkFJOVhFU2tGK0tOVmZMa1NoVExyTi95ckwvMGhwYTMzNDlVdVcybGlC?=
 =?utf-8?B?YVg2MEQzcmxteCt0ck9taWpBLzJHNFNaWVhibEErUzlYU1NFeHJhYVY2UXA5?=
 =?utf-8?B?VGo5N2dJRFJPQVVtZnBmbDhNSzAwWEI5NHJsdWFQUzhCMTcyS3FwbWFHbmdw?=
 =?utf-8?B?ZHYvZUc0c2xYbHJVajNGczhHaEU4amFxVXQyYzRqMTJwTjN6bVpBSGVhdXFH?=
 =?utf-8?B?QTJVZksxNjVGTEt3a1pPWnJYNjVab1VINXppeWJLK0Rkb3JaZHZ0dnU2QTRz?=
 =?utf-8?B?eEdXYjRVWldDUy8raXBJMlhOd1N6eXRKb1ROak5MMHZUMkFKbnRocnJrdXRz?=
 =?utf-8?B?U1YvRmovYzdUdzZhMlVCaG4wcHZoUmh5REV0cERaSjBWdTBPbDZhZFRiVmRC?=
 =?utf-8?B?eUhvbysrQ0J6TU8yYWxVd3BwWEU5QnV6WTFRU1crT2hwK3lxdE41S0phL1BS?=
 =?utf-8?B?RXJDUFlzaUswMXhhSnN1ZHNyRXowaXQ5Y0dBM3VXRE11YjA5RmpvUU9xK3NW?=
 =?utf-8?B?MFZnRDJsWXBXV0Q3d1hQekJDZ0xzb1QvdENyT1VqVGs0MDY2Q3lwQ2dqSDRL?=
 =?utf-8?B?KzZjaDlGRUZCOU9RY1JYNXo0ZGxqSXJPa2MyMkpqUFZLZEVwSDh0N25YdnBD?=
 =?utf-8?B?NUczaXNhUko1OVlleGVTdTZBbjg2V2V5OGFESDNXQmpGU2hhQ0tsUnRyaEZU?=
 =?utf-8?B?VEc2bmdOWjBTZnZsa3dKK01nWXJFVjU4VjNQbGVyZmNUUFdLV1dMc2RhUGwz?=
 =?utf-8?B?UmFJY1FYT2swMFpDb3pkYUg0Q2FPN3N3bHBBTkZWYjN3ZHlPV2toQlM3Zjho?=
 =?utf-8?B?RVVFYmtjMkdBRXJOK1ExUjFGZTU1UHpOeU5VNTlCZERtaStMenpXbDNTc3Bu?=
 =?utf-8?B?M0RCSjFlRUdOWUNYeUMwbGxicEFqMW05bnc1Yk85TDFkdTRCZkd3VEdFSFAw?=
 =?utf-8?B?Zjl5RzJ2U1VYN0ZCVno1cDF6ZTVSM1hWcDcrQURLZzU0Nkx6WGQ5Z1A3d1py?=
 =?utf-8?B?dHg4ZjNQUjNqNjdZLzZiSjJlQ0JCYXRNL3cwTVRzRFg3Yk5NUGcrUFN4TGNj?=
 =?utf-8?Q?YP+f11TeMmcafJwRpNKUCs/tA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b1d28-0cd9-4856-b98f-08ddcb365cbe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 04:47:31.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzU9xdWsSSKFZpfcCuTNhB61yFIc9GwyzPHg3GZpRNNxkWUR/jfgRf7BzDaJmr/g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756



On 7/24/25 17:32, Jonathan Cameron wrote:
> On Mon, 14 Jul 2025 20:28:47 -0400
> Sean Anderson <sean.anderson@linux.dev> wrote:
> 
>> To convert level-triggered alarms into edge-triggered IIO events, alarms
>> are masked when they are triggered. To ensure we catch subsequent
>> alarms, we then periodically poll to see if the alarm is still active.
>> If it isn't, we unmask it. Active but masked alarms are stored in
>> current_masked_alarm.
>>
>> If an active alarm is disabled, it will remain set in
>> current_masked_alarm until ams_unmask_worker clears it. If the alarm is
>> re-enabled before ams_unmask_worker runs, then it will never be cleared
>> from current_masked_alarm. This will prevent the alarm event from being
>> pushed even if the alarm is still active.
>>
>> Fix this by recalculating current_masked_alarm immediately when enabling
>> or disabling alarms.
>>
>> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
> Anand?
> 
> This seems fine to me, but I'm not that familiar with the hardware or driver.

Anand left some time ago. Salih or Conall should be able to provide some input.

Thanks,
Michal

