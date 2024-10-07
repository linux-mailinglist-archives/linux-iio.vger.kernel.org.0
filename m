Return-Path: <linux-iio+bounces-10276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665D992D84
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2976B1C21EC5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 13:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA51D27A5;
	Mon,  7 Oct 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="jrkk7eYX"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DA189BAA;
	Mon,  7 Oct 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308238; cv=fail; b=a9r0GnaCXJQ8i0YV4WeCfv4M/ySJjERdQ7vy7QaTA+BTGLH23iw1wlVGFvTzkxCpa7FHbP918tchy8py6XATVXgJ+mFSSuy+0OPH18OUzjWfDAcJvw+YN65hsJF4UqFt60mcBmiRcVdZOumlPoswy8wdLatIGUwfLOQZjQKOVGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308238; c=relaxed/simple;
	bh=Ex6TLd9K+QQcQPvSnyYrDgeMHIdMa5WTM44qhQ8X2D8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sl7zOu+Ckb4au63UKMczx4mAn7ZlGPAQazyT2f2Nwe1xilRB2v8a5NVMdd697y+33NwbC0PrjLFQqeD6CcRcSymBjJ9UVFq4F4qqTzxPirxhKHELpqqz6Q22V1ESEUtqUtG4NjxjoN9CyQwI0KZTMRlfnutGU5LQM1a0pamchfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=jrkk7eYX; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIDJl8naZ8Q2y5sEs9oGKcQ0DCTMu1SBlYN/7HFwfB4Ei/74/O8YG1YLfFqGvdExRFIWmRfQlluGHT026LXKehkv0ZZlNS6SXGtQSdSyPGc+mkuGbVQXvMIEortotUCwQY32YY3YtVnlUpImFNhaNcxdsTOIf9xPbK7Yfj3J8wL/8wFOUPrf82HQPF9+IsTHMrvq7FxJ+6TF8A8T6C1lG1QMPhuZ6v288N3DYjGCyQ85+2V3xaCyy264MIuv8YvpyXavVdkNvP5Ica1j83j+GMGhrXn271rrrN/JdE2GbHaUvdiSBsjQ8cp2yUu7BUou1NJezfLiNDjulvmZTYGjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kmsS8fg1yR+hGUbjUq/TzGE340vXPzgRiDhG9pg/18=;
 b=xkNPDAd4sEGC6LjzhrMFKKos0MFI9kr2la85Nrrv9A9w1+H8OCz/O/kl53eTIlGV9sXpvIHBV9KZSE8yp0dc5Eg+3wGkp6lmkpTO0M71pYnzmCF00cL2Ydcn8usX8zQU0nuSpmoBGRNKnHLWk9HQBlpbXI0lBvUmmOXKTHreAiahUHWxagrFYxO5hIloH6ZpKsZ8L72+SLAIzQKeXM01BFh0RaS82/bTD+G63SJU/CMQQos8FxSLaAZANq0aq4bPf50IR4lplz734GhzShLLeMOotI52i08IMs8MDiXVpkD/Q6aYG/zXKexrTHxmC8Mmh++0IfIEcSfhZIrPjiBGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kmsS8fg1yR+hGUbjUq/TzGE340vXPzgRiDhG9pg/18=;
 b=jrkk7eYXJGMhh8UnkDyANz6w3Rgng7319ln/9Yp3iNXdS6oPZh+fnp1s5NEiPQ/qzc5j/x28xksyHFUCehS6iXWavkxzPfp+C0Z1yBODp9/1mid0VCfEu0K9z4higgS0kNCKGLLCm+b6EneJizOyx4eHKfOFfcZPwMCz+KyDX5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by AS4PR02MB8669.eurprd02.prod.outlook.com (2603:10a6:20b:58c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:37:09 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 13:37:09 +0000
Message-ID: <3ee27b01-ca9a-4f5c-b48a-c5613139895d@axis.com>
Date: Mon, 7 Oct 2024 15:37:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Support for Texas Instruments OPT4060 RGBW Color
 sensor.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
 <20241006162446.51a93744@jic23-huawei>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241006162446.51a93744@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|AS4PR02MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: dd84af09-a52c-459c-f7d1-08dce6d5242f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG0weW44eWtXTjY1c1hYeVJvYlA0SWlxZzRIUGRBem5BTzdiZTBIWXk4U2E0?=
 =?utf-8?B?bHcxMzdTV2I3TDl5aklvZklVTTdPaVJjR2Zia0ZZcVUrS0pWWFRaYUZjc01O?=
 =?utf-8?B?ZG1WbHpYYk5CWFNoelNtVVk3VnZYcDY2dzIrSGFwT0ROTW9TYXNMMFpDTWNq?=
 =?utf-8?B?OGVwSUlPWHNHOXlTWmYraU50Nm90Rk95UjFqRnFaLzVuQWJ3K3p3VG52N3dR?=
 =?utf-8?B?MGlTZXhhS2ZJN2IvR1JFYVZMNjZleHpSTit2WXpaZjZxSDZQTzBLaFJzbmNk?=
 =?utf-8?B?UXBPYnJGYkZXOWhuZzBVWWp4dE55UHRnTU14MlpVcjFldlhEU3luR0ErN1VN?=
 =?utf-8?B?elM0aGcrRFJyZlYrbzB6bFN5WnZ5U0tHQjZNdFFYL0ZpRll4WXcwMVY4ZVFX?=
 =?utf-8?B?RUFkMC9hUzhwUnpoQWxRanJ4RlU2c2IzbkxpOWhJdTZtZEQ1STBoajBoenJz?=
 =?utf-8?B?T1FDcm1PY2NJUHdCK21PNjNFMUl3ektMMndvZkVkb3Q1VGd6UmR2WE9qYzBN?=
 =?utf-8?B?SCtJN3Zzb1d0M0dQMlV2MWdiM3lQR3VLaS9rMWFQNCtCUG1MWHlhQ09icG5h?=
 =?utf-8?B?Mm5LN0lXbHFURUVuMjVtYW0xZGVld1p2SzZWV0JYVTQ1b281UG1sNE9BMll6?=
 =?utf-8?B?VlBKMmFmaFdGUFpTN2JmVFhxM0xlVEovTUlObzFlOWM1eVM5NzhSSFQ3YVY2?=
 =?utf-8?B?UGlkZUNMY2prbFB2VXlVR0g3UVRuNXdHdi9EbFBlVVJoMFdZWGEzaVR0djhF?=
 =?utf-8?B?L1BrdmJtZFZtazVIUituY0NBam14RXlNajh0TUI5QzJBRzhnVVlML2xabHg5?=
 =?utf-8?B?UEhGcEppc1E4Z3FlaTFSMTNwL3NmL2p0Nm93SE5lTnNBRE9aLzQ5dmxLVUp2?=
 =?utf-8?B?Wm5ldHRvd0VJVnNaUXhvMFVxRTlVOHZEN1RLdWZ4Sk1yNjM0Z3ZScFBOQjRM?=
 =?utf-8?B?U1Evc3FpMzJ6YmVkMVZnWFdXVHFXOUZUOVRiRzcrUGpCbS9SMzJSTllGUUJv?=
 =?utf-8?B?VVpPY1ZYMjkyd3BSWGNvMWVzdUNkNDM4SVY2RVFFWkVNQkRwakowN3NqS0FK?=
 =?utf-8?B?WmZ3V2ljcjNySEg1SVd2b01MdzV1emRTYnRYYit6Slk2SzVxMXVGZWw1U0gw?=
 =?utf-8?B?VzBkYy9SQWoxNE9JKzIyaVlKT2I4bmN0UGtwcnBUOU1mazlCbEh5cm9SU1FC?=
 =?utf-8?B?OW1xS1VTbHlHTUlIdzRCUXFEWmJZVW1MdjJoOW10dGhrMVpkVi9LR3Y3ZCsr?=
 =?utf-8?B?Zi90U2NEcFo4cklGbXJRaGRvem1yRDdSbW5MYlRsa2hGc3VoR3dVRnJQaFpI?=
 =?utf-8?B?YXBxLzNiN1k3YjI1SFNOYVBHUzFCVVJOWDZhMEhPVkdmdnkrd1loQWdFWnQ3?=
 =?utf-8?B?R0E5TmVVUUt6WjRtd3dYZVYvaEhBYzlCYk81Y1JqdC9TN2R1MlJ4WWZ6OExN?=
 =?utf-8?B?eU1aNFkvS1Z6QjZNWjdLbm12azA1NFRaZ1RtTjFzejZ6ejdmWUZEYmd6M2Iz?=
 =?utf-8?B?bWlEZDRwdGxEdmlDWXA4c2tRbGJyajlMdVdhNWVreWZzbGpjOVB2R0pxa3U1?=
 =?utf-8?B?b3A1bUVMb1hKMjN2a1d5cjlhWU1yZlVYME84blVMcGFTSFlQeFp1QWxwOXI3?=
 =?utf-8?B?UE84ME5HZXhLM1RIV3BUZUNLb1ZJMTVWZzhSTnVLdVhLd1UvK2EzRjlQNW9y?=
 =?utf-8?B?OERUdk1IVm96R3d4Wk01YkdGY0JkY2FReFRNZkF3b0FYV1dLQmNSdjlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE5aSlhHL3ZtY0xsN2dHaVdkZVU1UmI0WGkvMXJiTSs3TW52ZjdabTlDUDdO?=
 =?utf-8?B?MUpMTzN2ckRKdXo0OXV1TnRHWkNiWUdzajdEQjI2THJHK0g2MlQ0K3RHRVAv?=
 =?utf-8?B?ZEhQTGZHNjlTN0YwRk91MjVzUDVKMmVoSlZFTDgrWG4xWUhWUkdtbllWWURj?=
 =?utf-8?B?djczZXdNRWNiOFI3bEJGaVZ0a1A0QlloSHptOUNma1F0Zzh1TFoxZTNJWGJT?=
 =?utf-8?B?dzBWTjN4RzQ3bk1iV0JtT2c2a1BDM3Z5NkM4MDIrc2lpald6WkllRGdkMVEx?=
 =?utf-8?B?RWZvVFY1OUdNNVYxZjhoNUh4S0hUS1VDSW1NRmVVS3ZVVnpBOE1SdGxyWE1a?=
 =?utf-8?B?QTVXMmJ0THoxQllLK3ZzR2t0dzJjUWNoMjFPWFBBR2REUTFreXQwQ1YyS2tV?=
 =?utf-8?B?cEdMcG5CYjZQMzFMUGRzQWtVS09pSWZCcnVtUUc4Vy9ZNE44My9OcjRyYXU4?=
 =?utf-8?B?Z3d3VTlWSmxaNmNNZVloclJqaEw3ajBmT0RhOE9FaE1sSWMzTHMybmUxVnZZ?=
 =?utf-8?B?b0hDanJVY1FBVzg2QjMwUlNRcmErbGJGczNualhYZktrWlV0aHdzbnVrQVR4?=
 =?utf-8?B?azdJNHpidmxjNU0rOHlkTHI1TGhjbml1TUN0UEFsV1VVcytQQnovdFAyZjhX?=
 =?utf-8?B?NDBRZjA1ckJDQ0RiNW0vcHd1ZTU4VHFtTUlJWGFWN3NORGZObHpObE5lM01u?=
 =?utf-8?B?bGlrOTI1ZCtCSkVQOGlTbWhWSmVtTDNZaEFyNXdkSnNBcXpxdXk0bzJhNkov?=
 =?utf-8?B?N1k0bjVQRWRMdUxZKzJ1ZDFCVjhIYWVlVWg3Uk1oejFkTUNwNldtanV6MEdt?=
 =?utf-8?B?WFFlZHY4WTgzejg4WUhiRW12QmlUeHZTQ2RxVmUwaVhOV3ZQZ2d0RVZVTDZv?=
 =?utf-8?B?RGx1WERYelNteDJFNnhzS3ZpM3VJZzZ4aTJRVXFsNWZPY2RBMURqVHErYVFI?=
 =?utf-8?B?Q0JYMS9HRVpnMGZ2MC9DVFVTRkkxd0hMVitNenRxSE1EaHZBYTAzSlZzZU5h?=
 =?utf-8?B?TlAyTnFZMXB1cXRWcXJ6VmhMTzJlbTRBQytGVDdCY1p3aHlYMUlCY0dWUy94?=
 =?utf-8?B?V0pPVEJXbXhkMlY3UVdwcGtPWFVISUxWUlJrWHJ6ZXh5ZFpkU28vVE9EZGwz?=
 =?utf-8?B?eWtTVHJWNWNtcVhkYTVLbVJKNk5kT25GcU0vWE0vYVdrYWF4clc2Y0g3cnVQ?=
 =?utf-8?B?Z21OaCtQT2UwR3hMOTdEeksxMjAyeFdXWC8yRDBQcHRNZ2lvMk5oSnRacmxa?=
 =?utf-8?B?MkdKNEZaM2swYkJEVWhuYWttVDVBQmIvOWptOWV3NUlBWk1na05KYUk2RHVO?=
 =?utf-8?B?d0Q1NGo2YjhNRG5JQ2pZVitoV1BqUnR0TjhVVi96aEQrMFdIZkJ5SlVFTWcz?=
 =?utf-8?B?RGtSNHpzTmpYdEpnSngvSVN5Qyt3UGY3cU9uK1Rzbm15M0RnSzNONXEvN1Nz?=
 =?utf-8?B?bXZvajZmNlRmaUdWSElyUmdNK1Rscmg5eTV1T1Nlc0tVV1BaRFl6M0kwNGJm?=
 =?utf-8?B?dG55SjNoY2lpWnYyVmZsaVpESUJ4TDI3SEZTY2R1cHhJckdadFNkcjBYVk1Y?=
 =?utf-8?B?dnNJS2o0ajE2NnBMRzUwaDVSSTZiaHZRU20xc2ludlNmL3l0VDB6elkrckNC?=
 =?utf-8?B?NjRTZVJrYzBqYWIwNmthYklaRTFOOEQxWG1nSlk0LzVIY3JESHoya0JMSUc1?=
 =?utf-8?B?ZmFMUUV0NzREQVlVYURLS0UxeTJpNHB2RzBpK29HR0dWV2l3am5RMzZQcFpN?=
 =?utf-8?B?LzN2OUFTSGtyMHJzSnNpSW5GM2MyNUZnNVZtdmZubFBTTnpuM3E2K0dFUGVP?=
 =?utf-8?B?UXVTc2F5L1lIcXl3ZEtXdkxBRWlVQ1ZzdDYvY0c3N3FPdTA2L1lBcDhpUmhu?=
 =?utf-8?B?RTd5Sk81MFpocjYvV0xXaU1zRlFiTHZlZnhOZFpwdGdWTTlNWWNrS3FpZkV3?=
 =?utf-8?B?aXVzQTJVZ2VVVGZYSEdCdjNZSUxXdVJzTEFtYTg0dUZUeWZTVTc5RXVOa2Ny?=
 =?utf-8?B?ZEtSMzRjT2FMWHhiWFBldkQ3TWsxZE55M3h4c3N6a3p3d1FPeVJ1L0Q5Ni9x?=
 =?utf-8?B?Qng3UjV0WXhDZWNRZlJWT2k3OVpLSUFNOEk3eXgxUWt2WXgzR0Y1K0xITVAr?=
 =?utf-8?Q?RBbU=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd84af09-a52c-459c-f7d1-08dce6d5242f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:37:09.2967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvWOxvC9crNDBbSNSSCU3ThCy5G3GnlFasDd1heBFsVUogUzAJnjRTigLvBkxsrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8669

On 10/6/24 17:24, Jonathan Cameron wrote:
> On Sat, 5 Oct 2024 18:51:17 +0200
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
>> using the i2c interface.
>>
>> The driver exposes both raw adc values and calculated lux values though sysfs.
>> Integration time can be configured though sysfs as well.
> 
> Lux is a unit with a particular light curve.  It has no defined meaning for
> color channels.  As a result we usually only have colors as intensity channels
> (unit free).  If it is possible to compute an estimate of the illuminance then
> that can be a separate IIO_LIGHT channel.

The thing with lux is not actually something I know much about, I just read the
data sheet (https://www.ti.com/lit/gpn/opt4060). According to chapter 8.4.5.2
(page 17), lux can be calculated this way:

lux = GREEN_ADC_RAW * 2.15e-3

It is also stated that R=G=B for a D65 standard white light source if red is
multiplied by 2.4 and blue is multiplied with 1.3. I interpreted this as if
IIO_LIGHT was the best fit and that's why I didn't use IIO_INTENSITY. Should I
change to IIO_INTENSITY?

> 
>> The OPT4060 sensor
>> supports both rising and falling threshold interrupts. These interrupts are
>> exposed as IIO events. The driver also implements an IIO triggered buffer with
>> two triggers, one trigger for conversion ready interrupts and one trigger for
>> threshold interrupts. The typical use case for this is to define a threshold and
>> listen for the events, and at the same time enable the triggered buffer with the
>> threshold trigger. Once the application gets the threshold event, the values
>> from the time of the event will be available in the triggered buffer. This
>> limits the number of interrupts between sensor and host and also the the usage
>> of sysfs for reading values after events.
> 
> We have had various discussions of threshold triggers in the past, but I don't
> think we ever merged any (maybe there is one somewhere?) The reasons for that are:
> 1) They are hard for generic userspace to understand.
> 2) For light sensors the input tends to be slow moving - grabbing one reading
>    on a threshold interrupt is rarely that informative (or are you grabbing them
>    on dataready once the threshold is breached?)

When the sensor triggers an interrupt for a threshold, it will also have the bit for
dataready set. So the values available at that point in time are the values that
triggered the threshold interrupt.

> 3) If we want to do threshold triggers we should really add generic infrastructure
>    for them based on adding an in kernel events consumer path and a way to
>    instantiate a trigger based on any event.  Doing it in a single driver creates
>    an ABI we won't want to retain long term.
> 
> So how important is this feature to you and why?  Maybe it is time to finally
> take a close look at option 3.

Our userspace application needs the values after getting the threshold event. Before
I implemented the threshold trigger and the triggered buffer, the application would
read the values from sysfs right after the event. In that case the values will not be
the ones that actually triggered the event. When the light condition is close to the
threshold, the value from sysfs might even be on the wrong side of the threshold which
can be confusing for the state machine in userspace. I would say that this feature is
fairly important to us, this is the way our userspace is using the sensor.

If I understand you correctly, the problem you see with threshold triggers is that
it creates an implicit dependency between events and triggers. For the trigger to
function, userspace will first have to enable the event and set the threshold. I can
understand this issue, I think. Your suggestion with a way to instantiate triggers
from events sounds like a potential way forward. Do you have any more thoughts on how
that could be implemented? How can we proceed? How can I help?

Thank you for you comments so far, looking forward to hearing your thoughts on a way
forward.

/ P-D

> 
> Jonathan
> 
>>
>> Changes in v2:
>> - dt-bindings: Removed incorrect allOf.
>> - dt-bindings: Changed to generic node name.
>> - Correction in opt4060_trigger_one_shot(...) for continuous mode.
>> - Correction in opt4060_power_down(...), wrong register was read.
>> - Corrected usage of active_scan_mask in opt4060_trigger_handler(...).
>> - Clean-up of various comments.
>> - Link to V1: https://lore.kernel.org/lkml/20241003164932.1162049-1-perdaniel.olsson@axis.com/
>>
>> Per-Daniel Olsson (2):
>>   dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
>>   iio: light: Add support for TI OPT4060 color sensor
>>
>>  .../bindings/iio/light/ti,opt4060.yaml        |   51 +
>>  drivers/iio/light/Kconfig                     |   13 +
>>  drivers/iio/light/Makefile                    |    1 +
>>  drivers/iio/light/opt4060.c                   | 1216 +++++++++++++++++
>>  4 files changed, 1281 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
>>  create mode 100644 drivers/iio/light/opt4060.c
>>
>>
>> base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5
> 


