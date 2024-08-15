Return-Path: <linux-iio+bounces-8484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C83952AC0
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 10:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F7E1F22542
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 08:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4571ABEBE;
	Thu, 15 Aug 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="O+kp/e1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D317625E;
	Thu, 15 Aug 2024 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709592; cv=fail; b=mKXWOYrxVaGlxHcRRVl8Q+QxZZt4kLbnq7NsYscqBjglBL95XhSk2NOdWhMjvumcJfJl80NkZergLxQxSGAWQWuT7WggZVODS6Bg3RuaAWEMfSs9S+b2vLShtj0xFKolFfU9VP8ZulNDOoujr7LfROac+kC1n6seIbEPO4GbXPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709592; c=relaxed/simple;
	bh=XWgechVj8WvgMLAPDg8AgtX6xuQGY1/Y3GEmPSAo0+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSmNswGPIa092bqdLtyIj4+EBwyjjFVFF356tu77DUElhrQIY3A2l9HbUr5vH1TMDIZYiNa+J39qdRJ6vy9+BmPfwLM/KDMUMMSQ+XM7/rAkd0EkM/VzuaL+qV8uAFYyo/LOwdU6F+bM902sIQ0+GYnv7XqiYzYR/QvlESFLSwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=O+kp/e1b; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOQMDoubmEI7Lk/T1xItVjAuTXXPmjzOt90qBacp6YrEgAZtnoc+4TN7eQeX3kswkXC7fvTAO4BxXoYIs1ZHPG/1XvjAMOoLMLQH+e8SnM5JaFWrn0B7+dzHle2Xop59SNwWb5Z184Nwo1padyTNDoH6Hd7XC/3huAqWJ0nqe2ipEqiHFlxQIgYTGWLONkOHi4YAWxvaDX1GWc1RUDqMBhnqlLAJAhuCqFEqppYye6pQe4o5m9KAPw+plVLpFCAYZe7EFWywdg5yXL9flOkrwByOcypEGB7iSO9RphwMIqbuyK19K1IkXwUYtNBOJhtWz3DcMmT3WYDmJ6hI2Gpf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aors7Z6LDJg/7TZRNtuARW5fC6BHyxjiKwBk5aO2u1M=;
 b=JkNrr5AqrMqaejw9z2xv6HrlTSN28ROsi/+MsNICilqoSvXGdZ9+xcDUdi7AI+KH7jqXwtNJTtt7BtMSpc4X8rjJpyp0b882oX9qdxpAFCGkkUiOdPRv1HG5nojXBemhsl9ByLyT5buV4Kia9L5UUzD/NWzuAp+Hv3eo58HCqxmlLVkNcHJqRYbXg4UHxW4kaTxa/HDUh11FCqYKEALxLFjki2+rVWrkueIFA9/YD1rI2kizjHneAbML6xXtbz+oJCNdvRb2iijq+yE7tDOXAoBueF2sBypQMuJeS5/jCDQMmxQLbayPmeKH2KLaqcZmYQcQPPhW2PXnySK6siPgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aors7Z6LDJg/7TZRNtuARW5fC6BHyxjiKwBk5aO2u1M=;
 b=O+kp/e1bWLyihKMzo08APOu+RlcJJORVzYCAnJFfXF5kAYYsdXpkh2yCwGr9gr1DZs9ytFGVH1QtMo4iEqfFtOHSrHtixP9gf5VB6NgtKJx/dB3ubuO4O02gNxQH55/uAgUv7RxIBrVsid7FYsfDl4fjzixzX73AFE6XJ+TAZymsPraOf3AnGdP/opmd1Fl6JVuLTzojqLN0XxapM7ePgYw300I+qBZgcsfmCkgJ4JUGgTa3FJtIPgtqX5/0MHgrJFIsg7QGoMUYztZlG5kigyKUQrtYKF/KgC2+4u31QMc4PBt9qrK2K+enOsUNpX0DH7eHshDfS3sSj2JiPIpT8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 08:13:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 08:13:05 +0000
Message-ID: <3c7c75fe-68fb-44ec-822e-6d6374b0588d@siemens.com>
Date: Thu, 15 Aug 2024 10:13:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
To: Jonathan Cameron <jic23@kernel.org>,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Chao Zeng <chao.zeng@siemens.com>,
 devicetree@vger.kernel.org
References: <cover.1723527641.git.jan.kiszka@siemens.com>
 <f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
 <20240814200946.59bd8435@jic23-huawei>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240814200946.59bd8435@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 214f09d3-8ce5-460a-e6ec-08dcbd021748
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDArTytXWXVSU3hBWiswNkFaQkNtZTB2ZVNrZ0ozdUF6djdhcU9YMDhsRXBM?=
 =?utf-8?B?ZmZiWHpzRlJoMU90ZzNPZFg1ZTVIOStucThhbThWQ205U1J2UU5vV0U0ZUoy?=
 =?utf-8?B?NW1odCsrNE1WU3krMlhVK2dSQWViVFNhRzFyMkRyRUJFNEJTWUVSNHVzSldw?=
 =?utf-8?B?UnVXaFRZc2ZsWkdXcUZyaWJKUm9IaXRzWGZISFNHeGZwdENPRy8reG9KZVRo?=
 =?utf-8?B?SGRWNHVCaDkrSXdhMDFUSjg5YkxWcEp1M1lPQ1FLc1lsWG1jaVk2UFJhaXhm?=
 =?utf-8?B?OG45SlNsM3JyeWhOa0F6WmtMOExxNDJxenRVaHZuVllpWmhXSlk1Vmp5RGhX?=
 =?utf-8?B?MmJwallQbytJYUxCbDdFSEFmOGpEWlFNeTlma3phNWRRNGo2SC9UWHZOZytC?=
 =?utf-8?B?V20vS1ByRXhvak54dGFVS3JXN3N4TUpKTjJYZ3dieER3WWVtcTExSndRcmc1?=
 =?utf-8?B?SFFQQnlYbm9GWEYxS1R0V2lzVVEyaU5oMFJqekREU1dkN3RyWFNtNXN0U3I0?=
 =?utf-8?B?Z1FQZWY1WGt5aGhjbnFjZElVUTllaE1qWDEyUmJiQW5oSG9oU1dEOHpNbDlX?=
 =?utf-8?B?M25RMzJPdXBPbWlNUS8rTEJraVJUU0J3OWt6SjhTcVJpYmpKL0Zybm1mL2VX?=
 =?utf-8?B?b0JBS043MXRvVmY1YUxYUmVuZ1ErWVRHM3p4aERpMzdVZ3RFajFxRlhxNGtH?=
 =?utf-8?B?UFVTRTFwbSs5OGQrQk8rUGwyRmRpL0RTSUtXVUZ5NHZsSEQwdnhxT29kNit5?=
 =?utf-8?B?NDRsdW1SZWtlcHFVTmhiOXQzNm9UbWJKQm1ZWDk0ZnpXYWV4MmxzVTVYbHlI?=
 =?utf-8?B?cHRySThscGgzZzN4b2YxK1J6OVUzby9Ga2ZtUzMybzlNa1BaYWx4S3dOM2Ez?=
 =?utf-8?B?ZjAzWTdmM01mMFlhdXBqRXZhVmhkZDRhSnVtSlZJUUtlUEFTSGkraDhnVWFE?=
 =?utf-8?B?bVNrTkF2cFZUdGFBNi9qb3QvS0lNZDlKZGNLeEU2WEhvUTBrdk8ybEdySU5K?=
 =?utf-8?B?OE16LzFTVmFoYlRDalpaRXFnQWdkbUEwNHM5RllkUTZFd0czR2hMN2V2U0J1?=
 =?utf-8?B?UnRuUXFWMFRGR0lzdU5MbmVJWVMrVUZlK0t6MXdBNTBnV1Z1WnRMUENraDRL?=
 =?utf-8?B?VDBmU2lXWU14T3M5SGRkNkYzNmRYWXlKY01VVytIWk9UNWkycHhDWmJaeEND?=
 =?utf-8?B?aEdoMCtTbnlHMzdKaERpZmhHSGJQTDBTVGJkN3NyanpFRUQ4bjNDSzI1M01S?=
 =?utf-8?B?dzZDUGF0QnltRmduSzZQVkVzYkVheGV6WVVnaUl0WTZMNjlqYVozZkFpS3Q3?=
 =?utf-8?B?OFRuSVg0QVJlWHEzWCt5N1FwT3pZeTEzNkhQR2ZWZHdoNjVVdlpYRU8ybjVP?=
 =?utf-8?B?VzFjRXExdS9jdEVGdTdoSkszcW8vSUFFdGtTcDU1ZVNLVkVHL1dmWCtvZFJG?=
 =?utf-8?B?NEdrRVFIVGFyaHNQaElFUUovZmNoWGxvRVFLRXJ3MWY3eFBZQUJJTm9kWTdT?=
 =?utf-8?B?YXk4dVVxdm5CSmdNeStxV2ZiakxxVW9nenZmdDlBRzNNT3dmUWJtbG9sZGQ0?=
 =?utf-8?B?Tm8wODFxZWoxamFzVU5HMHAwRmxzQjkwZGk5MGJpSXdPTjJJc0ZIYithZjVF?=
 =?utf-8?B?ZklQbmVxN1VKMEh0RE41SU1ad2lrNFN4RkxNcU1XMG0rdTFnLzlsNTVocUR5?=
 =?utf-8?B?Qkh4bnUxU3d1U0RubUJEMWZSSmxaNnN4bEZEeEVOeHlkUGFpL2JSODhWZEhP?=
 =?utf-8?Q?1bhb/wp6YYy9D0Kc0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWlCRE5La2M2V0NKS0ZXY3JVN0RDZk1TU0U4dDIyb2JhWkh5eFg3a0VUUlRC?=
 =?utf-8?B?dFE1OTRBc01NODRvSk1tcE5GSEJJUFZPSnZZZUxwV05JaTlyelNrdGVPSUho?=
 =?utf-8?B?OENpOGFxSmZpYjRaaTRoUGt0a3VnSzVGTXl3SkdqMGRkcjZvQ1daWUhXYzVn?=
 =?utf-8?B?YkhrY1dQTE8zcVA0Q2NBTWR4VWg4VEpZZDRneGNzVUY0aFlEeCtwWGFUM1BY?=
 =?utf-8?B?SVNKenJIekNNamgrb2UyM0djYmJPZ3FjbktDdFZGelRicWpkOHRJQTVPeE93?=
 =?utf-8?B?TmVwbzBOMlFHa2ZQR1V4bERDY0pCL1Rsd25WeDZHZTRkYThWNlN2cHNocHRY?=
 =?utf-8?B?WGNUZ0xvZ3lzRjc2bkQ5ZHE3M2hoSHVCS2pDWFovb2JKc0RiQkxLcWFzK0dU?=
 =?utf-8?B?bkl6azM5QmRISjBEMG9YVXJXdUovMGJrdGdVdm4rbGNocnRZcUt6QnJkdDRh?=
 =?utf-8?B?YXMvYXhtS2czQnhkWEE3c3ZkcDB5Nmx2R3FnMnI5eHJPWklOd0xkMEtKb0tR?=
 =?utf-8?B?RWxaczVnOUFOTnVLUEhkbnU5d0ZwQlRFMXFua29DQlFZOGE2OGY4MC92VVM5?=
 =?utf-8?B?VEFVOTZvUGpCUE8zMGl5Wmh1L0FZVkdTNXRsamxORFVzWk9NczBiNnpFZjFS?=
 =?utf-8?B?NHY1RzVpbXlQbTdHZGVSNnBtOEN3VjlnZlpXdGZUV0w0T2pGVzcrcEI5VEY3?=
 =?utf-8?B?bnNxQ0dVS09IR294dGhucXpUMkhtU3hEWWZoaUE5YUJMa1JHSVFlL0EwdDJX?=
 =?utf-8?B?a0RWM1pyaytzdkFGY0VnREJLZUlpcVR6dGxRWUNYNDk4ZlQ3Rm9Zbmc4M3E0?=
 =?utf-8?B?Y1RQQzBDTGpzcEN1UlBMOEZseG1HbzdHNUtoTTN2WUdQVnIySWhwNWMrSnpp?=
 =?utf-8?B?UFFQYW8vRi9IZ2JKd01sSEkwZkgyVDU1a0pMdmlranNrejVZR2w3UWJhQ0xW?=
 =?utf-8?B?SHBxWUFTaGJ3MXZwYjVYUnZlTEdtZkVNNjlxUUJwMmtFY25PcGFCZm9qYjNG?=
 =?utf-8?B?OUJUdytoTUUxOHdMaFQ3RFFTTm9PdGZoOS9TaW9EaklITW1IUDAvU1FxSjdr?=
 =?utf-8?B?anVTUTJEMkl5SzN2dTVxRkNqN0ExN21RRmFxcVk0R0ovYS92dXpEMlNaTVhL?=
 =?utf-8?B?Z2FRS01HZFQrTWhmM1g3S01nUTB0RGRYRm5OampGcUYzZlFoRVlkRlJGWXh0?=
 =?utf-8?B?RldPWWI4VFI5U2Vmako2L2pvTkhwcUltSGlWeTRubTNuWFVCWUp6Y1ZWbU9v?=
 =?utf-8?B?OUNycWRuUFJSWGJranp5Q2h3clppeDNDeUYvVWptUEtheXNlcEgra2ROaGxU?=
 =?utf-8?B?ZVFzUHYrYlUzWnZVVXVKUTFha0VISTJOVFFDKzFMZGpZNEJ1cEc5YVJmeVVa?=
 =?utf-8?B?WlpTcmR5dWVFbzBScXRBTlE4RXRtSVZBVnBMRFNrbGlxWVVPbmZQc1pZSlAx?=
 =?utf-8?B?Qmh1ZGdQbkhJRnNZcWpkVWJKb3ByTmU1QXIzUEZFM1lTdEpzRXZha25RU0J6?=
 =?utf-8?B?SHJQb0JneC85WElHUGpRZ1R5WUhqaGtSRnZuMWpjL1gxU1FtQ2ZOVXA1QlBj?=
 =?utf-8?B?L1loUVZkTlVCMGgvaFc1Ky9xWGN5ajNQNlZ6SHM3aVdmVGUzZ2dKbEk3ODJw?=
 =?utf-8?B?eHNZbWEyRDAzWWMyZUtKSE1veXJ1MlJFeVYrSWRUbVNhb21UTDJ2SGlWRm1H?=
 =?utf-8?B?MUlvUER6cDFsOUN6OGZUZFk3TC90R1NLaXJlRndOTThHRm54MnFJeTRQd29l?=
 =?utf-8?B?OU1UdzZOVCtkNVFTRnpFVm43LzJ3dE5lcWNrcUFxVTNWcVZ4aGJiRzBwNU1j?=
 =?utf-8?B?cytERVRpOVo4RE5NOFNVR21MSlhCQXZzQ01mZTdGa21Nbi92QjRsbDltVTVq?=
 =?utf-8?B?dlV6SlppbmdlcTV2L1B4TERLSnJpUHV6Y3dHSjZZeEFPR3NOLzd1WjNHYlYr?=
 =?utf-8?B?OGVPc053bHZKMUZ5d0R5TXAwaDZLYmhLUnYwUGFWalRIYVdYdUVtbG85RHU5?=
 =?utf-8?B?ZTZPVEN3VHFWVTF6dXBBRnFHbHRaMytEdVNkNGNvYUVXU2llZElhWGpQSW9S?=
 =?utf-8?B?WUFuZ2RtUWlMOGtFVzUwdWtlQlJaMnpabHJiOXBNM3BJY0NNN0dhUmZRNHNt?=
 =?utf-8?Q?6ksC3li3V6LXp65I5rHVIyHrC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214f09d3-8ce5-460a-e6ec-08dcbd021748
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 08:13:05.9136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJCWUnbMr3wMaQCROOEWZQNyhxT76ndIUDcjwNwU3RcM2mkC782a6Ed/VB0c0gHY8ccPfdaizqQNTprtituMRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8474

On 14.08.24 21:10, Jonathan Cameron wrote:
> On Tue, 13 Aug 2024 07:40:41 +0200
> Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> From: Chao Zeng <chao.zeng@siemens.com>
>>
>> Add the binding document for the everlight pm16d17 sensor.
>>
>> Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
>> Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
>> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> hi Jan,
> 
> From a first read at least, almost everything in here
> is stuff we should be controlling from the driver, not
> providing as fixed values from firmware.
> 
> Specific comments inline.
> 

Thanks for the feedback. I'm looping in my colleague Hua Quian who will
try to answer your valid questions ASAP.

Good news: The datasheet link is now working, see
https://www.everlight.com.cn/wp-content/plugins/ItemRelationship/product_files/pdf/PM-16D17-2010-DF6-TR8_datasheet_V1.pdf

We just hope that we don't need to expand the IIO subsystem for this
device. ;)

Jan

> Jonathan
> 
>> ---
>>  .../iio/proximity/everlight,pm16d17.yaml      | 95 +++++++++++++++++++
>>  1 file changed, 95 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml
>> new file mode 100644
>> index 000000000000..fadc3075181a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml
>> @@ -0,0 +1,95 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/proximity/everlight,pm16d17.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Everlight PM-16D17 Ambient Light & Proximity Sensor
>> +
>> +maintainers:
>> +  - Chao Zeng <chao.zeng@siemens.com>
>> +
>> +description: |
>> +  This sensor uses standard I2C interface. Interrupt function is not covered.
>> +  Datasheet: https://en.everlight.com/sensor/category-proximity_sensor/digital_proximity_sensor/
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - everlight,pm16d17
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  ps-gain:
>> +    description: Receiver gain of proximity sensor
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 4, 8]
>> +    default: 1
> 
> This should I think be a userspace control.
> Given it's not related to proximity as such, probably 
> in_proximity0_hardwaregain
> 
>> +
>> +  ps-itime:
>> +    description: Conversion time for proximity sensor [ms]
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum:
>> +      - "0.4"
>> +      - "0.8"
>> +      - "1.6"
>> +      - "3.2"
>> +      - "6.3"
>> +      - "12.6"
>> +      - "25.2"
>> +    default: "0.4"
> Definitely a userspace control.  Is this actually integration time
> which we'd expect to affect the hardwaregain or is it just
> 1/ frequency of sampling (with fixed integration time).
> Looking at datasheet it's coupled to resolution which may
> make this oversampling related. Hard to tell.
> 
>> +
>> +  ps-wtime:
>> +    description: Waiting time for proximity sensor [ms]
> I guess the above was the integration time and this sets
> the sampling_frequency.  In that case definitely a userspace
> thing, doesn't belong in DT.
> 
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum:
>> +      - "12.5"
>> +      - "25"
>> +      - "50"
>> +      - "100"
>> +      - "200"
>> +      - "400"
>> +      - "800"
>> +      - "1600"
>> +    default: "12.5"
>> +
>> +  ps-ir-led-pulse-count:
>> +    description: IR LED drive pulse count
> 
> This needs more information.  Why would this be changed?
> Seems from datasheet that this is effectively a different
> form of gain. Why would we choose one rather than the other?
> Or are they both ways of increasing the overall sensitivity?
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 256
>> +    default: 1
>> +
>> +  ps-offset-cancel:
>> +    description: |
>> +      When PS offset cancel function is enabled, the result of subtracting any
>> +      value specified by the PS offset cancel register from the internal PS
>> +      output data is written to the PS output data register.
> That sounds like a calibbias userspace control, but more info needed.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    default: 0
>> +    maximum: 65535
>> +
> As Conor mentioned, need to describe the hardware as fully as possible so interrupts
> and power supplies (even if they are always on for your particular board)
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        lightsensor: pm16d17@44 {
>> +            compatible = "everlight,pm16d17";
>> +            reg = <0x44>;
>> +
>> +            ps-gain = <1>;
>> +            ps-itime = "0.4";
>> +            ps-wtime = "12.5";
>> +            ps-ir-led-pulse-count = <1>;
>> +            ps-offset-cancel = <280>;
>> +        };
>> +    };
> 

-- 
Siemens AG, Technology
Linux Expert Center


