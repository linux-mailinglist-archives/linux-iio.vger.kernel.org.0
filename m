Return-Path: <linux-iio+bounces-26780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD54CA6EEB
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29E7738735CB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC59033B947;
	Fri,  5 Dec 2025 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="Q93VhCCF"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023116.outbound.protection.outlook.com [40.107.162.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C82848BB;
	Fri,  5 Dec 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921226; cv=fail; b=DuXjOFy1gRGrvhvCbkg/fvPGHOiAUn4MV/upuwcc+zIWnMpQy2q9Mqi9KkhEJjSTiUr8Rlj35wZ7CdlWwQXAY2NCZqj4glFl7NGIyMHGsbz9gY2hKtux0G9c/Ykz6WbdIKAs2CQoy0z9LGqpnZ2DnGwAtCr7TgEHdc9FLQ/HwzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921226; c=relaxed/simple;
	bh=qIVjKGNgXoJ+YnHoZVEgPUd5yeg5P+ok4n0uCfAvV04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAjuSe48yTU3OSu5D1NROEtZ/eNwZ99MBJGCl+az3dzYXffsO5V4tKWoyCDzK395Vx1QMWaWwwu9npE3QV3NsSN9/etDD/WKnp3RjXjX+pm+xl44B8N+jeeWc0hQUivvbrPZrEeta+J+3NohKsCkoxcMN5+TT+1CADH3Qp91YW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=Q93VhCCF; arc=fail smtp.client-ip=40.107.162.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyIYysdUcOhegJWEe/yxxXrys8OTOUA7QEy/OTLf+abR1n/IgZhRgWDPRWSqHnWh0/2WbqC5wzVVAeVSxxxBpeJVjefD4uWr13hGVQbEk32h7PW7N72ceEobIX1yXgZQ7nP1yfpdpcKn8u20KUAW708sckvcvTRVJlMIM5J1aqsZVNc2MjIvpHY6AQdLkrLiR92ABBkqiw7uXZQ2E2FDVylpCKei0iov8T6Sw46TQWIK82U1jGCm4O+nc6bBuQiUfrCBn47Qg41S0izjyOQZWafkRIpEf+0uf6x8/mQ/sCRSHjWdFWq/8YnDqZxxp8Q8M4np8YDcjL2t8y7Emh7CFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmlFPAasahyTbbHIvTiT+iBN5yVtfdAuupXXy7tF9tk=;
 b=NmXpS4CdcQzKGIFVqul1ul/bks0VAnybjdWk5UDe165mK2Ri70toa0vW3rzKrpTgf9QXpjKM/WxjMtoG2KbZQldXPy1Y7YzmjRWDYlwHOkRsSK3ulvZR9RjN7vxv5FMPyMSoFqZSFpUWMbAg/jQcUYA01uxBp9bw+lNEW/CTWSIs4cDl/0K/LQ8IylsLTjR/r+PPq2UA6p+7PnKPvnIP3X30RMLX6wZ2HYr91jbGDjKTZkHCRT/0wN/y4DAf7V4kBei+EzBKoqWlcabcuEnktjTIgrdL7iqTqLpMIk4PTDmmvdrmDdAbYa2p7w3FrWOdnf4U4Rcx33bAU1ZVqaDpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmlFPAasahyTbbHIvTiT+iBN5yVtfdAuupXXy7tF9tk=;
 b=Q93VhCCFzgrics27iDL8BrkDRxSEqsIHiq5GnBVYCXEE1HK66bIUOFCftkDPUY6XkYDY8NKopsYlmqofli7ycOOp327w/yUQZktQWVtbeQVqrO2NC/HGxiJaciZlmn8KqAfU9GrMAB2BDHYXvJJOXb43XKjrSwTLI3NDTB3NvkGRVAtZ71lK7mvPITK7K0WIcGVy1wNW4jDA209IsEnFqeqwH2Xiy2x9mPo9qzazN954cN2/BqBS8Wa5ZeDpJWvfkqBVVEw/7m/vfVT0i+Glq6JMiDQHJjHjEe8OJtPbNd3eE8JMk9FQy1lcoHinfHoKoCRAst+Dw4uflCivIgAY/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PAXPR06MB7982.eurprd06.prod.outlook.com (2603:10a6:102:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 07:53:26 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 07:53:26 +0000
Message-ID: <95dfb96e-f7b8-45df-a704-2984bd0a2946@vaisala.com>
Date: Fri, 5 Dec 2025 09:52:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add AD4134
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
 <06d7be2af0f6520c23f612fa0249ff6a26655cb7.1764708608.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <06d7be2af0f6520c23f612fa0249ff6a26655cb7.1764708608.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0038.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::16) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PAXPR06MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 9252eedb-87f9-43c2-0551-08de33d35f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d253TzBmTUlPL0Mxa09SUFVMbmRYbG5VT3lNLzljbzNFc1dZSW8wTUxQblB2?=
 =?utf-8?B?OTRWRUY5eWdEUzlnTEZRQUJLL3JqTERlVkdLcVBQYitPajJyYjRwNTFIVzg0?=
 =?utf-8?B?UEVwOFhib0xGTTQzUE0rMzBkRi9mZXJETEZzamJ0b3huL20yanRIRzk2OHNn?=
 =?utf-8?B?OE9lTnpqSDNQdFFZNzhNMEFhTXI3b0tBSXlidlgvMHRod3dJanBrbXdxVys2?=
 =?utf-8?B?bHBGSnlmOWVaYU5WRk5zM0ZpU2ZiWFE2eHNzcUJ5ZkpWaXRPVHJicUp2SW4v?=
 =?utf-8?B?KzFBcHMzcXlrT0tuSmZuMy9qL2oxTWNQYjZiZ203bUE2Sm9xZk5ZdVBHeDJS?=
 =?utf-8?B?MmVmTUJRbkptOWl0aW5Bd2J4MS9YMHNBOGtRM3pYNVFnejB6N0FLZFFRV3JB?=
 =?utf-8?B?dVlFVkdlbjRTaDRuelpET3U2clB1U1pnMEJzeVA4VjlhbDZKa2VrMTcxSysy?=
 =?utf-8?B?a21ON002SmpDVlcyMVBhcUdOcE5ZbGtZa2gyTHhidGl1MWhnRVhDUDVHMEtl?=
 =?utf-8?B?Q0M4eWRUVmkySndBSE1lMXJhTTd2Uld6d3MxSDBOMTB5VnFyK2Z1VktDclNq?=
 =?utf-8?B?RlZyOXp6OFE4clJKSUVKaElSUlhCM2FIc1d0OTZzMzNENEF0OU8ydU1qVits?=
 =?utf-8?B?QU9qUXdjblROTTQ0N3ZhQnIwbXk3SHczMVZsR1p3aHhGSlB2TmJzR3cxdVFY?=
 =?utf-8?B?T3YwWXhJbDJuQkxCNGVlM2hBdks1QW16NFA2NjBCOHV6Slc2RThJRERpL1o5?=
 =?utf-8?B?eTUzNlErZXZIM0ZSL2ZVUFJWS1phU3ZKbENqaWgzU3pVQWtXckJud2JObFFT?=
 =?utf-8?B?aEVkTkJPa253WFdUWmE1VkNsc0lVZTRUQ2R2eVE4WEFkeXBuUkpmK2szNDJ2?=
 =?utf-8?B?WU12NjdCM2p0VDMxNTZzdWtvRTNldXNEZkpXWnFIa3dZREJZSVZRK1VxNHJF?=
 =?utf-8?B?VDhrb0FRdWZ0RXkxN1JuU1NlL3UxUlFIb04xV1hMSlJ4NG40SUhSSXFnaFpa?=
 =?utf-8?B?UkhLVWtzS1hKeGlWWHg5dHhOREJ3Mk5oZkVZdm5ZWkk3WjVhU25CQzdtcFRU?=
 =?utf-8?B?Q1d4aDNzRXIrclU1V0Qzcmd0M2dqelVBMHk3V21CeUJraWpkZ3p1WWFQT1NZ?=
 =?utf-8?B?N1RZU3lINVlkak9RdE9ESTE5NFA3eFh0cTh1MWE4TXRPblNLN1VtWml3WmlC?=
 =?utf-8?B?WVpDMFFNcGJxSnQxcjdnRXlOVTdGVU9MSk1TMjFoRTRmVW8zdWRhSEc0eFR6?=
 =?utf-8?B?U1RVNUdYMFJMREI1ekg5cjZUM1hZZzR0akJLdExwSnFIMnlyZUgvNHNiRTND?=
 =?utf-8?B?dU14QnZOZkVNaHdFVHRKRXMvWjluK1JieitFYW5SV085WlUvRzZqUjNBcjQ4?=
 =?utf-8?B?UmZnVDh0V1hJaWVOZlM1Y25rWTIwVy9rVFZ3SWNpU2NRUks5amRvUEEwRW14?=
 =?utf-8?B?eHN5V1NYVDdRcSs2TE5UWTVDeklhdmg4ZExkeTNheWRlbEpad3ViMVJQU3Zy?=
 =?utf-8?B?OXBweGtYa3lvWEs4b2E3bjlqVTZ4OHdpR0Zhb01TWFNaV1ZFUlQ2ci90T01Z?=
 =?utf-8?B?eTdFYURUL2NuY0VLT3RXRFJ2MHY0QUVhY1ptZ2lYWGk5NTZScGJ4WU13anVQ?=
 =?utf-8?B?d1ozd0UrQzZHZmUvWHlYSzVlcEc2dEtRN0FhNU50M251dDdvbS9ocDI4TTc3?=
 =?utf-8?B?bWdCNXBMQnBXS2QxLzRneXFWWlhqa3ZNamJaeVhFYXV4ZFpwK2ltRVZRem5R?=
 =?utf-8?B?cFFtUUJzMGNza1VqbUt5UytvU3Y2NnJDYWRrUTJDT1E5c0MvRGc1WXBXc2p1?=
 =?utf-8?B?RW8raVhQMU1FYzlERmV6cUdpNTA3Z1h1THlJaXhUc0U0RlZnVDdSMDlMREVB?=
 =?utf-8?B?YUNObTlIenJYck53RVcrejM4bm9SM1NRYXJwdWo0UGt0RWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVBQaFV0NXBVUldpdXA2bDdseThkUnU2OS8zZWREM0hkRUFoMlY4WXpvRXdh?=
 =?utf-8?B?aHQ3VUl1dXo3RjdkWVRlbHVDdktlTnc2dEIvSHNFcHlDZ05VcHRna3BGSzJ3?=
 =?utf-8?B?UWZwVDZPV3B6M1VNNUlpWmI2eHl2TFdCZEJKZTBWMC93ajQ0anVSNy9lTXlq?=
 =?utf-8?B?UVI1d0N4YVFCTTlnaUlVdkt0OWlQM2UvRFh6UTAramRza3BkQzhZWXJQQnJT?=
 =?utf-8?B?b2IrdjJpWUk0N3lUdExCUUhMeW95aGRRUWxSQ2c0bmN0Y1RiK0pGZldsZFJv?=
 =?utf-8?B?RlB5TW9NUVplQTVqbVpZKzdNRDdUeS91blJSWmdxQk9kMjNYdzFnY253V0FF?=
 =?utf-8?B?TXYxKzBodi9XcFZXWVoxQXlZcVVQRVpMK0RSeWJtSkdyMXprMDRSSHJTOVJE?=
 =?utf-8?B?d2RMS1h0UTZHMEhLZ1VxNVF2TDNFc2dXNmhhQ1ArRUFtQUtXZWo1MGZQZHNY?=
 =?utf-8?B?Qnp6cS9GRnpyNU9uNjlDR3g5V3lwWkZldWRpZEFTdlRpanh4NFI0RGNGc084?=
 =?utf-8?B?QmR1TGsvaU1lLzVrb3pSb3VqaTh0Mis0T1dEWVB0cU50MXptNXdVUHg4STJ0?=
 =?utf-8?B?RENBdDVNaHVjUTkxUHU3WFhGN1lnWkQ2R3VXU01odzgyZkVnUUFlNGhIYzdD?=
 =?utf-8?B?VTVKWngrdzVkQlM1aTlQblE2TElzTmphYkVCaVY4c1BqMDlDc0FoNXVZc2FH?=
 =?utf-8?B?cDhqUEhDUDA4eTdVSFYxNVNsUElYQ1pRVkU4UGZISjIvclNsSWNMOU1RZWJu?=
 =?utf-8?B?QXh5U1FPU1ErbWtMVS9ROTVWTkxzZGRNS2oyM2RFdXBoQlo5RnljMThVWDNY?=
 =?utf-8?B?VS9vSTRsa3JoSXRJTFh2cVdOSWVyUGdBWERPSnlLNDlPVm8zM2lnb1NSaWJT?=
 =?utf-8?B?RXFlZEtLUFRyWTZYVGxyTWpIVCs0Q0dpeUlDTkVXVVROS3pBdFdZMGhuMW1E?=
 =?utf-8?B?NWU5Y2dvKzBvMTAvZlZDaVBkS2pLWEoxTUMrNUlXNlh4bnIwQUhHNDQ1d2Rr?=
 =?utf-8?B?M1dMd2dRUHoycnA5YnZyYnpIRGJiOHZEY3NmSjJPWFFVdVNYQ3hqQ0hQYnZN?=
 =?utf-8?B?Zk1vNnVNemVZZ3hpZGtiOEFpcWd6RkFvNWpjSnpMNmhnak9TNm5icko5Q0gy?=
 =?utf-8?B?YVhWL1NTZENqdVBaOVdZblRvSGdHNjdqTTZCYmpJM05MQzR6eERkbTE1NGc3?=
 =?utf-8?B?Q0ZpNW1nN21zdWN0WTBoeTdJd0xBVzZZWVArckFJV25QZjhyUzBLaTkzZHBw?=
 =?utf-8?B?Ri9RM2ZsZVZCQzZxUW5OYVFjSzhFVm9ENExGdzcva1RaNllPNXJRb0xhYkZR?=
 =?utf-8?B?WUVZTW9WYmpXcFJEUU5QNHh3VC9jSnlva3NtWlFKLzdoM0dobHhONUdiNG9j?=
 =?utf-8?B?d2dBaGJpc3o0SmRHOG5RSG4vemVRWUNRb3hrUUljV2U0ajA2TlZXeGFDVEZI?=
 =?utf-8?B?WS9sMzZsbHZHOXRaQnNPL0lnbFc1K0ZRRVpqOVdoRWkvUjFZSFJIZjdnMWtt?=
 =?utf-8?B?eEZzM29tdkZ4eHVkMndZVUg1ZXA4ODR1R1JIRmx3U0tyUHcrUm4yeTdNa3h4?=
 =?utf-8?B?VWZlZVltK1ZONEtGeVM4KzZYZkNxNHBmZkhjL3lFRkNMUXBFSjY3S0pwb1FW?=
 =?utf-8?B?ZDBkWkM1ZmtXaWdGNXhVUEg2UG1Kekl1Z081c05zeS9pVWdkN3llTXYwWTNC?=
 =?utf-8?B?TVEwbUtVMkR4TWovaHFCOVk2TEh3djRyWnRBeE9ucjZWSjlGWTFPSmdvVzVl?=
 =?utf-8?B?emFsZFoyZHNqLzE5czJLUnhlM2wxMnBmZEFTMWpUcmtxZy8va0xkeHVHWnpO?=
 =?utf-8?B?L244MnJFcEQvNXV2SnJXbUp3S1k5YVVPY3JzczVXMzlkNmZTOGxnMjdkNzdQ?=
 =?utf-8?B?VjltUm5tQ3lTTVpaVExZRks3UVcxSDY2REdJaTVzQXNTejNuWVFvWUNVUW5B?=
 =?utf-8?B?dm5PU3AzSEZHSnkzVmhidGhOeFgrMzdzbEJ3ZmFDZ0UrWVBpeTgxNkxiN2Zt?=
 =?utf-8?B?bVMyMFFVZ3RzZE10QXFEQjFmdjcvNG5yUUJGSm91UjgvYzNHM01lSjFuejNl?=
 =?utf-8?B?aGphcCtqdkJMUXcrV0JCcmZocjdyYkZxRGNyYlBpeEttS29qRkhXMUx4bndL?=
 =?utf-8?B?RjJTRGd1ZHcxME9xMXE0YUkyL25iV1FIbTVVaEFCOGdNaHZBbWxjSVozbmxx?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9252eedb-87f9-43c2-0551-08de33d35f2c
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 07:53:26.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmWAL15EzMX8PrgB9Erqf61QaEQpjIFqu0VC/PFtppVnDcQlZL/HtDvVwF/NlLV4jQ2bqp3zHzSfx/ogJRM7UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7982

Hi,

On 02/12/2025 22:55, Marcelo Schmitt wrote:
> Add device tree documentation for AD4134 24-Bit, 4-channel simultaneous
> sampling, precision ADC.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3:
> - fixed typo in powerdown-gpios description.
> - picked up Conor's review tag. 
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 198 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> new file mode 100644
> index 000000000000..69a6ddf6ca92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> @@ -0,0 +1,198 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4134.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4134 ADC
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  The AD4134 is a quad channel, low noise, simultaneous sampling, precision
> +  analog-to-digital converter (ADC).
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4134.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +    maxItems: 1
> +
> +  adi,asrc-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Asynchronous Sample Rate Converter (ASRC) operation mode control input.
> +      Describes whether the MODE pin is set to a high level (for master mode
> +      operation) or to a low level (for slave mode operation).
> +    enum: [ high, low ]
> +    default: low
Since minimim I/O mode is only one currently supported, this should
always be low, right? Is the property needed at this point?

> +
> +  adi,dclkio:
> +    description:
> +      DCLK pin I/O direction control for when the device operates in Pin Control
> +      Slave Mode or in SPI Control Mode. Describes if DEC0/DCLKIO pin is at a
> +      high level (which configures DCLK as an output) or to set to a low level
> +      (configuring DCLK for input).
> +    enum: [ out, in ]
> +    default: in
> +
> +  adi,dclkmode:
> +    description:
> +      DCLK mode control for when the device operates in Pin Control Slave Mode
> +      or in SPI Control Mode. Describes whether the DEC1/DCLKMODE pin is set to
> +      a high level (configuring the DCLK to operate in free running mode) or
> +      to a low level (to configure DCLK to operate in gated mode).
> +    enum: [ free-running, gated ]
> +    default: gated
In minimum I/O mode datasheet mentions this should always be gated.
Perhaps this and adi,dclkio can be left out and added when driver gains
other support than I/O mode?

Thanks,
Tomas


> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd5-supply
> +  - dvdd5-supply
> +  - iovdd-supply
> +  - refin-supply
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      not:
> +        required:
> +          - ldoin-supply
> +    then:
> +      required:
> +        - avdd1v8-supply
> +        - dvdd1v8-supply
> +        - clkvdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4134";
> +            reg = <0>;
> +
> +            spi-max-frequency = <1000000>;
> +
> +            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
> +            odr-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
> +            powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
> +
> +            clocks = <&sys_clk>;
> +            clock-names = "clkin";
> +
> +            avdd5-supply = <&avdd5>;
> +            dvdd5-supply = <&dvdd5>;
> +            iovdd-supply = <&iovdd>;
> +            refin-supply = <&refin>;
> +            avdd1v8-supply = <&avdd1v8>;
> +            dvdd1v8-supply = <&dvdd1v8>;
> +            clkvdd-supply = <&clkvdd>;
> +
> +            adi,asrc-mode = "low";
> +            adi,dclkio = "in";
> +            adi,dclkmode = "gated";
> +
> +            regulators {
> +                vcm_reg: vcm-output {
> +                    regulator-name = "ad4134-vcm";
> +                };
> +            };
> +
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 31d98efb1ad1..b9029c4055e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1449,6 +1449,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
>  
> +ANALOG DEVICES INC AD4134 DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> +
>  ANALOG DEVICES INC AD4170-4 DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
>  L:	linux-iio@vger.kernel.org


