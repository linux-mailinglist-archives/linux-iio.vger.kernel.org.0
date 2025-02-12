Return-Path: <linux-iio+bounces-15407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE6A31EEC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0A9188BFE5
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A99E1FCF53;
	Wed, 12 Feb 2025 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Ud69P4Zt"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B41FCCEC;
	Wed, 12 Feb 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341671; cv=fail; b=hye3ECKN696iXwrYItH+IjiwYthuiG1wsDxYbEslYY9Qipfm1AkImOBwdpLmACipobzaLH5MVPgHq8KrqE5vQYjlrY8L8wnW2AfCJc/NosbaEszZSKpOpi3wgj5tomuEsXa+zbrtLk41HV46gK268JIA/BE6E7zj3jBJ/DnRTCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341671; c=relaxed/simple;
	bh=yNq2rGxN/3ahiSCjCP2nl0O7M6kWD7u8FNgTb7u0Ve0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcoiybX3Et7oT36YfV3w+6Y+vFQp8dTIp3EBPzFOCGJzE3zBPovPzXBq882kmHDaIimo3lobWPlBoIOPlUfx47kKofA474pipsLrElE/r1ghKvcB+viwbuK5e8CWOSMqUGTuC736nQiKvjZUIpzn7xfHH8e+kmSLJWp1oFYkvH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Ud69P4Zt; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp5Gryi9ejsCINj2ABKxJkL0yXK21ZIcfWD9rQ3Iz3a59q7ocbSeCGiH+f2Ob9s0GpzI6qmlxAMnOoRYxqmFqXlnLvjsr0XVnKArDON8VQ8a/7mAckchUOAbacoSexDWO1hQ86A5ihiW6I37pv7EcnwnLhGRhbcOuqb4dHXDksYcGblFH5M8Rena9clwFxgGVMd9lSDe4IfIEBznSNGmp3FL707F1jCBKUFxXvp5lXzCzXVnKoG3ALxUlStMIx0UvNNEgyB+Q4AxDI1CaoSOse5b4LJUTA8yaEkUEfbdgpuPxlsEwoROLVWpActwbjHH1/qerCjmLYQuJO5ghM5KFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DoX2aho9+fc8ZcGS2mmFJ0baF6lbPjRuJTQOiZcJxs=;
 b=JkH65noReNWgV1Q8m0C9tohyWvgpoV2jz5Sdew5KzNWSoeidzMIfvbfugbNbt+ROtEYx9FxxhbxxvMkZtXyMf5uqrx8IZuPB5xIgGbxFQjlNIAE6sj6lKE+Usx0MjHBZ1GMDiIUSWyzr4zsFqCvCtAArkzLP/TIbigfC+iim43Xwwr72P6ofTmyeVyPFeAOvriP6/ZiBwqCKXIS8/u+wHgjewQz19rVjeVz/j4zGRTaECDDc26s7ewXv5i+NqvJ8sGDlzHxzcPqkwiS4t1JA4dtjkGeyEpy+2ac3ucAuuLmEiCh753I8JXj4Av234HApx75A4GbCSkDIFq6UWAL+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DoX2aho9+fc8ZcGS2mmFJ0baF6lbPjRuJTQOiZcJxs=;
 b=Ud69P4ZtHLDOXzLHjC93PZR/WqNMURml9ibfEBsw8MZb244aHkpL3ScteZQbLIqrgFpnuJ/rPhIX6dblbZh+H7P8tqhak2mbvgER85UJ/fzhrgRFuTZtNpkUH65ylt1Wq+5N4FOTw7A1iAMhfmK1YwoGtBpFmaaBPXQF+mtzFHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by DU0PR02MB8668.eurprd02.prod.outlook.com
 (2603:10a6:10:3ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 06:27:46 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::e014:24e9:48ef:92e9%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 06:27:46 +0000
Message-ID: <b237d8e1-1619-32ef-3334-44c899bd0c9b@axis.com>
Date: Wed, 12 Feb 2025 14:27:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/3] dt-bindings: iio: chemical: sensirion,senxx: Add yaml
 description
To: Conor Dooley <conor@kernel.org>
Cc: Hermes Zhang <Hermes.Zhang@axis.com>, jic23@kernel.org, robh@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, Conor Dooley <conor+dt@kernel.org>,
 kernel@axis.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
 <20250206061521.2546108-3-Hermes.Zhang@axis.com>
 <20250206-italics-reproduce-35d554c38751@spud>
 <21dd4902-7d24-6d1a-1144-2dfd7cabe9e2@axis.com>
 <20250211-whiff-handsfree-a21486cf67c7@spud>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <20250211-whiff-handsfree-a21486cf67c7@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:820::15) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|DU0PR02MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: fe37e40b-f157-46b0-198d-08dd4b2e5d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWMxSndKSTNiczgwMGQ1MExYT0UwYmwvNlJhT0EyYWcxV01JbmhKaGJyQ1VR?=
 =?utf-8?B?UjZkL3ZHVzZrNkYya2dEc3NNWUxmeVFmMTJtK3Zvb3JhVUh5djZRNnZOakdJ?=
 =?utf-8?B?Rnc0TG82Sm5Ja1BSTWRBNGlYOFJNQTBsVjVXUWJOaUR1MGplcUtEekR0Y1Nk?=
 =?utf-8?B?VEdYbEFoYnRYdkxQeU1YNUdGOGZPVHZ3QlZaOFNJdW1jcFpTL0lYS3VWMW96?=
 =?utf-8?B?K3BMUUtkemI3N2VmdDJvcHRadmo2a0tFem5RSDRQSW5YQmk3OVJValQweFd3?=
 =?utf-8?B?dTNJREpSYm9jUGk5eGYwUkRiaUVLb0plblczcVRGT2gyVGZqdTU4aDlQNVBq?=
 =?utf-8?B?S3k1bklGUUhFWnBBUnRmMEx4WWliMEI5clBRSllNV3phTHliZE1nWDJCVWlG?=
 =?utf-8?B?Mk9UeXBaVEVXRlBGRkhBcXlnV2ZPaGYzNlkwUC8xeVFjaTF1UlZTUjA5QkJK?=
 =?utf-8?B?TmpQKy9CRVJkVjFYTVk2Y1hQbktSc3MyVnZXcTFXZWdCaFdXb0dHSkdYSlBa?=
 =?utf-8?B?NlBFcUtIeEd5c25sbFI2bWxTQUIxZC8xSzkxRmZISzhITS9VU3g5bTJiMHZR?=
 =?utf-8?B?WTFIYndBWWpsdjROTjhmbC9BOG1NOUFqYjlDUDBRaXNBRG9BdkxsUmhUTWlN?=
 =?utf-8?B?bS9neTZpeDZRalY3NWE5RGU3TzVZbkt6Wm5PNlJ4ZlpmNWY0NytxZXcvL2hl?=
 =?utf-8?B?Tzh1cnFCdmpxbUFvdlhoclEyUTVTMG5TZWF1SHJHT1ozN3Jvb1NtK21VQ0hx?=
 =?utf-8?B?WFRSb1BnaXE4cjN2UmowL1ZDUHF6V25kN3YwV2cyaXBHenZOaG5oRTkxVm9Q?=
 =?utf-8?B?RFlHSVBtUWJqTE01ejB4NG1EMVN1SVFBUzN5eE5BYnVBOGFESlp0UEJwT1dK?=
 =?utf-8?B?M1FabURQREJWdFBFZXZxVUN2MUYxcjBPeWJtRklheHhxSkJROS81N2NHamha?=
 =?utf-8?B?enU1Ui93SVVISThGODBCSlVURW0zVFlPUnhIRENIYzBpNmRSMERBNGZXelJS?=
 =?utf-8?B?ZzM0QjJhczZVa29JbWdaU1JnK1RqWDJZVDB0WjYyKyt1MTFxeUhuM1VxWG5J?=
 =?utf-8?B?NStZT1EzK3VLWDhXL2RIcWZuRTBRengvZml1Z1B4bGNvSTVJVTVkTWcyS05U?=
 =?utf-8?B?Nzg3ZmxxaHpQMDN0TktRSGtRRFc1UmpRa1krZXN6TzFDOENuVW1zMkpKblFK?=
 =?utf-8?B?MzJ1MjVDZHBaeHdHOWFUbUxybEpsZzQxS2FIUVZid1VTdnp0aWw1Z0cyUGVS?=
 =?utf-8?B?dlRzZm42a2FNZk1Xelk2bHY0MFJFczBmYTE1bC9IZ0xUQW83U0RJeTgwRVBy?=
 =?utf-8?B?QlNoUHM1WnVaajFpWUVGSkM4RUF6T28rS3lZVnVhcjMza2huV1M2bkN2WDRo?=
 =?utf-8?B?aGhVMUtvZ0NOREtvWHYrb3ZSMUpoTlZ3SDJtQUVqYlcvTXZGSzU1TjFzY0E3?=
 =?utf-8?B?aGNUM0hFZFhVaEg5dVlUNFdKL1dUdFViVnVIRVRTRDE1SXdqR3EwaWgxSS85?=
 =?utf-8?B?aENReWwzbmJhQ1MycHFoTitGWU0wUkIzK2MzS3VpSTNBTFhtWlBkUm92MkdH?=
 =?utf-8?B?eTNXRkhWWWFrUDFkS0UzSldHamZ1UmRXOCtYRVdxT2NBZVFuNjN6Qlo4bG9l?=
 =?utf-8?B?eGZtU1c4eStrUE9UWEl0L1N2Vk53dFlQRWR4WHF4dUJnbG1oR3RHeEZoN2h3?=
 =?utf-8?B?TnFPWExvQjBMRXFZNFNZWWFhZXhrVHBhazlQRm84TGVlbUpuQmNUVDhreDZC?=
 =?utf-8?B?dU9HTEk3R05sZHdVNVk5ZlArZEVqQmN0T090ek5zd1I1Rm4rRGdjSm1tcFR5?=
 =?utf-8?B?cEo5K2VuZGt1QmwvY0Q0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTNmTHVSdFZLb0ZOL1ROdnZ6dzZEZ2dGM0R0OUR1MGxHd0pBb1FZQytpTlZB?=
 =?utf-8?B?UXRZTW16MUcxUk1IMFI2cmVlOWZJU2tYMW1TM3hNaDVuUEdyMTZDS0dZdE85?=
 =?utf-8?B?VmFiVWZXTnBlcTZXUSs0enNMcGV5bHU5L0M0ZENucVNhU3A2V2FBQjRCUzY5?=
 =?utf-8?B?TTVETm5DbnVrU0dMQjV6Q1RCU056Z1JKdFJmMzNMcjMvZGFLSWJieGppQjhj?=
 =?utf-8?B?eXhER3JTTG15MDM3bWVvb1kyZjYxVnM4REZxQ0JLVW54MlI2bU5raGtQTFA2?=
 =?utf-8?B?TERNT3JuZXdtelZQbWRLNVd4NitrWVZQWTl2SDdmUy8zam02c3h2WUVqNjg0?=
 =?utf-8?B?dUVRRjBwYnZxUW5WaUV3RTNFbEltcCtqbnNpUGRUU2Vta0FIZFhaTWlLdk9I?=
 =?utf-8?B?KzNWZXU0M1Nvb3BsZTFKdGxQaFVtRkVKdDZVTE5iWWV6cXBlWWxrZmhxZ05P?=
 =?utf-8?B?cnQ0WXB3RzluME9BZTlWZ3NpSkx0OCtDczlkbjE3NlEwSGFObWk2YkFEaFFR?=
 =?utf-8?B?M0FqN1p3bHBVOHhTTUJkVmx3ZDVHZWtSTHMwWGw1NjFmWW9YNzVpY3JNd25T?=
 =?utf-8?B?OVNCall1SlhlRk1zUENQbjNNSHlZZGI3NHZZelhKVENab0RNdW9IQ3MvVVkr?=
 =?utf-8?B?M0VUNDJtbWRyVVpaeG1qenVkL0FDYUt6UlFKaGRxUi9Fc2FocnFBd0JPRHFS?=
 =?utf-8?B?UXFpNlZxU0pvTFJsTXYvSzRJRnVpdjRUK1BQK2QxbEVlaThRZW0yUnE0cW9X?=
 =?utf-8?B?bjE2ZC9VRFVrKytpVjlPTlRnWmZ0WVlJMmZEdDhuRmxEVG5xWGs5aFlRM3Fv?=
 =?utf-8?B?TXQ5L1NrcDRHRGQxTVNueHptcnM2NWZ1Z3FWQ3VhSU1YL2M4cHJFWTVKMzFi?=
 =?utf-8?B?cU91SUxnTXBxQk01ZVpRMmNJWjZqVS9FMmJSK3NDUU53VDRUOE1Yc1hqWEgw?=
 =?utf-8?B?d0lRS0xqbnduN3ROeVd5RHRyNlNUR29rTzFNTWtLREFyZ1VZcFU4dVBlSDUw?=
 =?utf-8?B?cUhLMGVvQmk1eDhtTEZ5eUs0WXl1N0VtWWtQWE9TVGRuV0UvbjRsZTM4VHpy?=
 =?utf-8?B?UDkwMGVicTdoWFVKdGVGbWpDS1U0SGc1OXJUZG9HMkxNbEU3TDRoS3U5VGNh?=
 =?utf-8?B?R1pzSjk5L3MxM3dVenZsOUI3aTJCQkdma2hjckZ5cStLVGVtUjZWNjRIY0Nw?=
 =?utf-8?B?OEh5NEFlSmhDdHVYL2dFY1RwNlNUOVc2N0ZrVkRTU2pncmNTbE8vbGh4Tm9K?=
 =?utf-8?B?clFpY1M3UmdMNC9qdE8rbmU0MUpIREM5N3ZoYlEvaUU2Z2JMdVBETGp3RUJP?=
 =?utf-8?B?RXRVM29xc0lnRkpIb09tWDBJWVZROWVHaTBMckZZcEZYSisrRzZkZHUraVVF?=
 =?utf-8?B?eUNZY1QyVDMwZXNUT1VsZTExdDF6VkErTVJSNEJsVEtST3VvZmdHY2xiN1g1?=
 =?utf-8?B?dW0wTVZ6M1B3WUozdWV2YjV2aUZuMWNKdWdWc3RDL1JHTTZ0dTQxbVZaNmtF?=
 =?utf-8?B?MmVxZk1qdGF1c0xkRW90ZUJESVNJYXhSbWg4WTUxbnF4a3V0QW41OUtCcktj?=
 =?utf-8?B?RE9oOUszbGZUNU1DN3g3UXFHNktEejBhUit6eWExWjQ1MTZoR1Q2VFd4dnAv?=
 =?utf-8?B?Z0pIOXk5WWEvUkpnTnRVTDZuS3NnS1pBVzZIYk15TngvNmVveWVORlRPc0pL?=
 =?utf-8?B?dFZ1Ym1uV1ZiK3VIL3lEd0VEcDJPeHlEY21MenFlWWQzdnJqb1ZwWm5aOGtX?=
 =?utf-8?B?QWZWeE9yWURNVXBxeTdCcTNQaXk2NU9vRlBLVW5LbTNaNW15MGVYdUhGcjFG?=
 =?utf-8?B?QzZsNXBLLzMrcDBySGYrU1oyZy9UYUp2UWtwOG5rc3pmTmN4bDNnb1RkR0NL?=
 =?utf-8?B?Nnh2dktnM3AxYUd4WkwzemtTdjB6UjFBcU9vZU9yTzJGSDdGNlc2NThmUkZU?=
 =?utf-8?B?L1hpVFZUSlBEdDZxa2drakhmRDdTYUJQcTU5ZGxKZUxDTTdpVWMvdFJTS2hM?=
 =?utf-8?B?cXdNeGREQWQrbjVUVnFUdGtPMTRMUHNPVTBHZkpCOEN6SW9SWkZTTVY0U2VO?=
 =?utf-8?B?aVdNSVRGL1JHdm1mU24zdDdEOG1nN0dWWTN4N2ZOSk9IeldEY09sMTRjVUJm?=
 =?utf-8?Q?SxBW6fy1Y60rLdiBxwu98F9ZM?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe37e40b-f157-46b0-198d-08dd4b2e5d33
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 06:27:46.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tly+pTIh7SqWF9d3xJU8gXO8gSp5Gqz5qTqQpd9V28weMonm0v9KB2bf0TS2x8BdNhwLak5ckdz1LEXAJrf0Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8668


On 2025/2/12 2:44, Conor Dooley wrote:
> On Sat, Feb 08, 2025 at 03:07:08PM +0800, Hermes Zhang wrote:
>> Hi,
>>
>> On 2025/2/7 2:20, Conor Dooley wrote:
>>> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml
>>> new file mode 100644
>>> index 000000000000..4d998eabe441
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,senxx.yaml
>>> filename matching a compatible please.
>> So sensirion,sen66.yaml?
>>> +  https://sensirion.com/media/documents/6791EFA0/62A1F68F/Sensirion_Datasheet_Environmental_Node_SEN5x.pdf
>>> +  https://sensirion.com/media/documents/FAFC548D/6731FFFA/Sensirion_Datasheet_SEN6x.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - sensirion,sen50
>>> +      - sensirion,sen54
>>> +      - sensirion,sen55
>>> +      - sensirion,sen60
>>> +      - sensirion,sen65
>>> +      - sensirion,sen66
>>> I'd like a note in the commit message as to how all of these devices are
>>> different please.
>> Sure, will fix in v2.
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>> No supplies needed for this device? Seems like you would need at least
>>> one, no?
>> You mean the vdd-supply? The chip require a e.g. 3.3v VDD, but in our HW, we
>> have no gpio/regulator to control it, connect directly by the HW, should I
>> still need to have one vdd-supply here?
> Might not be controllable in your case, but if the device needs power
> from somewhere it should have one in the binding.

OK, I see. I will add it in v2. Thanks.


Best Regards,

Hermes


