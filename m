Return-Path: <linux-iio+bounces-10642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCE99F1F8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 17:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94761B21868
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B11F666B;
	Tue, 15 Oct 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="KAcBSAFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCFA3BBF6;
	Tue, 15 Oct 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007432; cv=fail; b=TQMZin2gkOOyv272Ajw/jK/LjkPZbJ/FMbLTcOJCAC1KPKjxu5MxO8BdNg8ddke6BbLVD7nZrfITaaDiggvy3GTSkedZl5vQGoRmDf1XDspfBOroHKdhmyWc8fzO4THCWToG0z8ud6wAHZbCCe8aeruQZfDJRJvPleiIgcmdXUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007432; c=relaxed/simple;
	bh=w1Yx+xO+enO169Z3OOZ4RO/yOsvs9ziVNX8Ij0W6rWc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gxOGOh5VMMGakqYfQpfFY+7k8+oSv5WmEXr0pd6JjlFlpFUJj/nVRG/1lLy6ak3/378Miw0BkWC2FpN+Vri1D+4c5QeSQ47NthVWWtxWr8P02cT4qlc04lkxEm016PfJuJ8Pgh4WIg8VFwAPyEDUnPSOeyokbvPZJPwawA8fBqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=KAcBSAFh; arc=fail smtp.client-ip=40.107.247.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khiDVhNndg87HJzLMvPnOb988tbLQ1qCS5pxC6PRPzCGD6UiU/TkZ8w1bIl6Ygksakn9Gd3hchNNres7zBOllQz1lyeMumyjs7azO+yNOPMc9WLWmOXvwxF4SWvvvXUenYJ2Kw0k3HAJOtrhMqgibA5qxZlJ5F+oW6p73qupx46JhPnwDgivmp+NxV52DEN4D/vzgWCrEa46gWeMpamyYilWvow11fnNqALVffeFwqOQot0My9HecK+DR8DOXXFqW/Uohpcv+Y7Q6B0VUOe67UQ0ZVntyYTQXex4s/TpjhfzOrfva1d7QH5nkaB0vG4fQ/BbCv9qrds7v37ENMMQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXVimRNtnvI1BZpgc+ktRCyh41iaRhitZvz+C9QF8w8=;
 b=P6tLgN979qnoAPqMxadAKdLkEVmR/DOzXpMxXBOzau/M7ImSj2OGkmyFZfW+aPgz+isf3Jh1CcGnqofGyHBuEo513YmuLBrmEnkrGiwqU+0tgk7ppbc3YsPmDYb4vgT3oIVwfx1KBntOZyN84yQliXrgK4h9XlWnjf3eh3ETuWLjMJ8k8+efyDfjPBvhnmsxOr3Yvuam0/lKoZT5tRa/Sr02nUbVNK7GeS41C6riLztYn2gJ4gznL0BzRT5mVJB2oJ/h7jUSZNZZIY51lY5AVPY+yNB9HJ1wRf7Wo0zYlB1dnmhtSUxmbBlEyM4lcqX4nGLdPl5CrMcmle0hdSFXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXVimRNtnvI1BZpgc+ktRCyh41iaRhitZvz+C9QF8w8=;
 b=KAcBSAFhgSIERDGzxrhb2/LQYBGnf6bWVYRmL4/3IawFbRLOm3BokjbbppsF0X/hVjuEceSmEXdIFah0z7jz4g7Z8Ht+lFrvfiOXkC/NM24NauWIoqaxvhbMSgKIn7ooiPCAmA1eHTil7+ujppebEZmSdw4sxGseew35NFv4fL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by GV1PR02MB11034.eurprd02.prod.outlook.com (2603:10a6:150:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 15:50:26 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 15:50:26 +0000
Message-ID: <30ee7977-6e0f-4824-8c2b-f46033dc5ad7@axis.com>
Date: Tue, 15 Oct 2024 17:50:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Support for Texas Instruments OPT4060 RGBW Color
 sensor.
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
 <20241006162446.51a93744@jic23-huawei>
 <3ee27b01-ca9a-4f5c-b48a-c5613139895d@axis.com>
 <20241008181151.00006abd@Huawei.com>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20241008181151.00006abd@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|GV1PR02MB11034:EE_
X-MS-Office365-Filtering-Correlation-Id: cca1f2e8-acab-441d-8355-08dced311600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlhqUHFZc1pndW9LalltVnl3YzF4cDUrWGMrWSt2eWo5YktVMURRYy9BQzM4?=
 =?utf-8?B?T1c5ZVl1dFZiUmRiaUdVSkZNVEdyRDhsWWdWbFNvVVJzOUJFaG5CY2pha3Rt?=
 =?utf-8?B?ZFg4SzNPaDNsUGRYMEVaMGRHNit0MEIxb1RnQWpRTGFQSnRFbXBMeWRqZURC?=
 =?utf-8?B?Y2Q1WDdhTmdya3ZGc0pXeS8xUkFoNXY1MzJwQkpkaFc2V3J2K1I1YWttMmFi?=
 =?utf-8?B?UmovbkxyWjY4STRFbk5TZ3NEUHhUcmhQNDJscGl2a0gwVk1ySUlZUVhLVXdy?=
 =?utf-8?B?YUVuQmU1QWZMMW1wWS9BamVBaFZXaVBPbFRjdkgxZ1MxdFJUSDl4SDVZbkNT?=
 =?utf-8?B?ZlhEZVlxbzRHYk84OVcwSEFNOFAyYXhnZi9hNVUzdDdWLy91Tk9FVHExbTh3?=
 =?utf-8?B?WmlRT0FsL3d3bFk5ajNrUXBhNFJDQXRKdVAvMjdzdllDaHJzM3pYbVduWVBZ?=
 =?utf-8?B?SXlsOXczRzJRWTJJcTg1TmpZUDl3Nlh5MHNFUGtlbHhGYzEzTGdBRUNUN0FJ?=
 =?utf-8?B?aE9ZMU45M3Nuc0RzVUtnWTFHa2RiaC9yTXVSejcxaTFiY2g4TVkyWnY1aDc5?=
 =?utf-8?B?aXRGS1dwVmM5M0ozUnJpa25wQzJxL01DTWNzY2NDZm1SdC9FQTdhc3QrK3hI?=
 =?utf-8?B?bFVGK2xwQkpKb1h0S3c4cVpRR004VEsvTDQrV1EvS1NybHFNUE1xQ3hVWVFR?=
 =?utf-8?B?cERSc3VCeVQwUlNLYzZIWTZXQWZSaURpZkZyNzQxd1F5VENDS29iY3kwTFJv?=
 =?utf-8?B?MXVDRDVDK2kvQ0gyWlRaRTFWS3dwWUNncFdqRWJTN094d245UXhLTkdNVmNm?=
 =?utf-8?B?WVFscEZQZURhZE5XYTZwRjhGa2ZxSXM4MEVRM0dtNVQ1NDdUcjQreGNEYzhJ?=
 =?utf-8?B?MWUxbksxNFlhVnNHcHNLZ2xVT3BqSGhJd1RzekdJS1BJUVlucTlsU1Fpbnhv?=
 =?utf-8?B?aEcreG55V0l0QkpOaWVSS3hELzRLRVE2TmQwK3NQNGZBQVBmNUlOQXF1Ky9P?=
 =?utf-8?B?cncrbSt1cXJwTkxnUW9MR09URHRsMG83UHZBYS83ZkY5cWRiZ3htNC8yc3VL?=
 =?utf-8?B?ZGxSNnlSQzg3U2wzVnVMM2hSbUx2UnhQZ2ZkYStXYTNuem9EQ1JTTmdWYWcz?=
 =?utf-8?B?Ty92R1pTYVdVa0N6TmxwTWE4VmpPa0p1b2Myc0ZqQ1E4UEZ6S3NvUE5hZE9Q?=
 =?utf-8?B?elAzNXhTYURmUnRKVXVJeW9KU1E5N0trQklsVUFIdHZyNHJTbUw3bnpBOXEw?=
 =?utf-8?B?K0sxZE1vQWhmbzlucS9Rc0VmeWVzMUxVQTN3TFZPcSs0OUZFbzdjdnUxRWhr?=
 =?utf-8?B?Q2tiUUtJTlo1ckExUEovQlF3UldvMUowVE1VWGtVU3FUdEZIY25NOTVWUjBs?=
 =?utf-8?B?bjdWdGo4Tm03NTlLMmhDSFcvbnIxWjhmejNJYWw3eGtlS0ZMTktZeEZoWUxY?=
 =?utf-8?B?UUlsK3RTaTdERVNqSVpFR1QydDdNNXo3ZThGSUJZQ3ZIYnI0VFkwakliU25l?=
 =?utf-8?B?cndEYi8zdVJBZDY4RG52M0tBMWlUKyt4Z3lzaEtmWkdiTE85RGlFbjFvUGhx?=
 =?utf-8?B?amxsbGFlMjdQNlE2V3pIdURtZGZoSnFsVzBqVHowSXY3S0RpemxXMzVGQ0Q1?=
 =?utf-8?B?SEV0aUtTS1Bya1d0b1Bac3FxZEhlSXovRDlQMis1YmFqNEpRM0dub2dzc1Zh?=
 =?utf-8?B?WUlWOHNSNDF1bWpjeTkvM2t6NTVJbkY4cTFvM1FoRWhwWFMrR1dmSWFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGJkaEVyWVY0RjRrVE1kWElHNXdMTlV4Z2hSbWg5Wm95U1A1Qk5YdkVxamJy?=
 =?utf-8?B?WHR6TkZ2ODBhWkhjamwwQ3gwcElZZUpRMG1hQjJFV3F5eWdaYkM2aHRScVRK?=
 =?utf-8?B?ZzJFbk9MSSszTVhjdVFqUGZWN204clhNNHpheHNRcVdXK3QwQ09pOUQwend3?=
 =?utf-8?B?VEZ1bXNRSk9OamVCOUdZYm5oVDBHNWxZNmdCSVJDUFFUU0dBQkgrMXA5WnA4?=
 =?utf-8?B?bTUvY0prM2NHaC91elVIRmEyZTdvZElkYlFVK29xcFo0OXNGK3VJWGd4U0ZY?=
 =?utf-8?B?MFpCODlialpiak5DMDZyd0hSK3FDUXZYZU12WGdlY0dKNVlnZUtjN0JKd2pS?=
 =?utf-8?B?MVA4b3BTOTI0czdrSDF5RXNFUVdQZEFqbFgvUDlsSVZsWlpyVkxXd3I5c0R6?=
 =?utf-8?B?czgrejAyUDdtZXpWSjFkaVpyZDRIbHMzNTJ5b2dsTlRTNTFrNHhFcFU5d2s5?=
 =?utf-8?B?VXY1bGtPL2QxeUNUT2NqaEwyV05jd3JidnFmellxVHFMTTRQVEdtWjZ0cmRL?=
 =?utf-8?B?dlN5UlM5YlJ2VTRSM0RxamJkdEVnTWJQem1lTjVNQkR6cVdrVWVmU08zNDNO?=
 =?utf-8?B?blJqd3dscktxakpEL1ExZGJIT01WZnJOeEtTUmZ0R3pKMUpsa0VtdDYvRmhU?=
 =?utf-8?B?OFFRa2U1REVXYkFMVEt4aVdPQlVCbkN3bDJBYlBwZEFwbThLZ3A1SVZvQXY5?=
 =?utf-8?B?c0VzYnZMeEFkc0RoZDRBTmg5NXZ4MCtZM2VQcG02ZDMzaHp0b1FjcjJDbnNC?=
 =?utf-8?B?QjNERXA3clFmZ1hDN0NQVUFwN1dIL2NhaDlBN0xSOFJFbDBMTEM3YjkvRGly?=
 =?utf-8?B?cktETkJIWXE3RG9DU2dzOGpSUXhDWUVlc08rOHBtbnN0Um1mVFZJNDdIT1dY?=
 =?utf-8?B?eGxEamxLRm0xOWJJRUtKTHQzTmRkaEZrMFJodTdwRUdWeUViSUFFM1VEeXUz?=
 =?utf-8?B?eXI3cEtZWmR4ZDF6dFRZSHp0NlhkU3JiN1ZQOGZqZ3pUU1ZwWUNVRUlSdGVY?=
 =?utf-8?B?RmhyYVQ5NmJkeGhsNFNaSG5GTTZJblF3ZVFlTFptRVFLUDZXNVhrNkxKTGpP?=
 =?utf-8?B?eVlUUktnQ2xkWkVZL2FYK0w1bmFHa2NCcnVjbHpoR0hCLy9oSGRCMVBzUWhj?=
 =?utf-8?B?M1A5bkZWcElaMUlSTStjOXNuTDEyN01pUy9hajN0UGJmWlpuenZOak12OFQ3?=
 =?utf-8?B?VnlDMHg3VDljVy82R25uV01SY0UzOWpha09uUVhDblFwNVJQNGNnM2p2NEVp?=
 =?utf-8?B?cWhVVmFaN0htRU9uQWlmd2dxSlhSeVBjTndlWURDU3RUQ2JoTTFoRTZNT3RT?=
 =?utf-8?B?emlLMFFuUHNiK0MvSUZzVmwwMGN1RGtrZWgvK0ZmdHFFbFlONWQvZ0ZTTUFR?=
 =?utf-8?B?WGRjRDg2US9ZaDVxUlIvOFBDY3VxbEh3a056MVI5a3NvY1J5cjdodXNXLzBm?=
 =?utf-8?B?SFpINWl0SDJ1bk82dVJHdFNGL0dhcW14WDkwcnExeG9oc1dCaWVlVzhyT0Qw?=
 =?utf-8?B?L0Z3THlqSi9NYjFLcXRYaUphKzkxcWdTNWxnOVpBQ1FOTnFJK0J0UmEyZkpC?=
 =?utf-8?B?c3ZPZTRHczZxdzR6MWtPdi9tOFY5OHpJZEhZUWU4NGF4blZUYUw3dURneDBq?=
 =?utf-8?B?RTgvck9PMC81NnNDVWU1NUl3TUhWc09TVXl2SzY0bjBpV1NBZ0hPa3VJK0s4?=
 =?utf-8?B?VXJCd0lYNlA2c0dBZTFGTTIyMDRCRzNSdnpLcVRnRm10bkhBTldhSzIyK1hN?=
 =?utf-8?B?UWxMM2FrV0hTUUU5eEFTTkpiblFxMmxPUmpiOCt5UkMrT1Z2UUIyTzJkeDBH?=
 =?utf-8?B?WHpsSElWcFZLYWc0SVBNWWxLUTJsdnkxallHdGgxZEJLcFVtbGdkSmVjRVE3?=
 =?utf-8?B?aE9EQkFXVEJUM1M0LzdDSXY4QTE0WnJCTXNoREM3aWplWDAzVGxHYVFrOVRU?=
 =?utf-8?B?WHpNWVY5akE2dWNzTUVyS3RrZkh1UHRjblB2WXNNTXdYY2FWelpMeTBqVHNS?=
 =?utf-8?B?bkxDdUFuSHNHQmp2Z2dBYzB1SytsVHh6aXNpMXh4dDd4TmFJanI5anNxanZN?=
 =?utf-8?B?YUU4dlFQYTcwMHQwTSttZzJHUUxZYVhRVHgwUlpDdkxxSGYwZ1JQYjZIdVpI?=
 =?utf-8?Q?kCfI=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca1f2e8-acab-441d-8355-08dced311600
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 15:50:26.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qg3sIgLyV3Xvcn89kKRR9yW+HykNytlrsfynsIwXWvLoF7RebOpxSGVDPBSONHgU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB11034

On 10/8/24 19:11, Jonathan Cameron wrote:
> On Mon, 7 Oct 2024 15:37:07 +0200
> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> 
>> On 10/6/24 17:24, Jonathan Cameron wrote:
>>> On Sat, 5 Oct 2024 18:51:17 +0200
>>> Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
>>>   
>>>> This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
>>>> using the i2c interface.
>>>>
>>>> The driver exposes both raw adc values and calculated lux values though sysfs.
>>>> Integration time can be configured though sysfs as well.  
>>>
>>> Lux is a unit with a particular light curve.  It has no defined meaning for
>>> color channels.  As a result we usually only have colors as intensity channels
>>> (unit free).  If it is possible to compute an estimate of the illuminance then
>>> that can be a separate IIO_LIGHT channel.  
>>
>> The thing with lux is not actually something I know much about,
> 
> https://en.wikipedia.org/wiki/Illuminance is a decent description
> (though I haven't reread it today!)
> 
> Key thing is a brightness measure adjusted to take into account an
> approximation of the human eye sensitivity to various wavelengths.
>>> I just read the
>> data sheet (https://www.ti.com/lit/gpn/opt4060). According to chapter 8.4.5.2
>> (page 17), lux can be calculated this way:
>>
>> lux = GREEN_ADC_RAW * 2.15e-3
> ouch.  
>>
>> It is also stated that R=G=B for a D65 standard white light source if red is
>> multiplied by 2.4 and blue is multiplied with 1.3. I interpreted this as if
>> IIO_LIGHT was the best fit and that's why I didn't use IIO_INTENSITY. Should I
>> change to IIO_INTENSITY?
> 
> Yes.  Light isn't typically a d65 light unfortunately (reference lights
> are expensive!)
> 

I have switched to IIO_INTENSITY in patch v3.

> Mind you I guess if was, we'd live in a blank and white world as there
> would be no colors, just shades of gray...> 
> 
>>
>>>   
>>>> The OPT4060 sensor
>>>> supports both rising and falling threshold interrupts. These interrupts are
>>>> exposed as IIO events. The driver also implements an IIO triggered buffer with
>>>> two triggers, one trigger for conversion ready interrupts and one trigger for
>>>> threshold interrupts. The typical use case for this is to define a threshold and
>>>> listen for the events, and at the same time enable the triggered buffer with the
>>>> threshold trigger. Once the application gets the threshold event, the values
>>>> from the time of the event will be available in the triggered buffer. This
>>>> limits the number of interrupts between sensor and host and also the the usage
>>>> of sysfs for reading values after events.  
>>>
>>> We have had various discussions of threshold triggers in the past, but I don't
>>> think we ever merged any (maybe there is one somewhere?) The reasons for that are:
>>> 1) They are hard for generic userspace to understand.
>>> 2) For light sensors the input tends to be slow moving - grabbing one reading
>>>    on a threshold interrupt is rarely that informative (or are you grabbing them
>>>    on dataready once the threshold is breached?)  
>>
>> When the sensor triggers an interrupt for a threshold, it will also have the bit for
>> dataready set. So the values available at that point in time are the values that
>> triggered the threshold interrupt.
>>
>>> 3) If we want to do threshold triggers we should really add generic infrastructure
>>>    for them based on adding an in kernel events consumer path and a way to
>>>    instantiate a trigger based on any event.  Doing it in a single driver creates
>>>    an ABI we won't want to retain long term.
>>>
>>> So how important is this feature to you and why?  Maybe it is time to finally
>>> take a close look at option 3.  
>>
>> Our userspace application needs the values after getting the threshold event. Before
>> I implemented the threshold trigger and the triggered buffer, the application would
>> read the values from sysfs right after the event. In that case the values will not be
>> the ones that actually triggered the event. When the light condition is close to the
>> threshold, the value from sysfs might even be on the wrong side of the threshold which
>> can be confusing for the state machine in userspace. I would say that this feature is
>> fairly important to us, this is the way our userspace is using the sensor.
> 
> Brutal answer is fix your state machine to drop that assumption. I'd try to clamp
> the nearest to threshold to the threshold value in your userspace app. Any error
> that introduces should be lost in the noise.
> 
>>
>> If I understand you correctly, the problem you see with threshold triggers is that
>> it creates an implicit dependency between events and triggers. For the trigger to
>> function, userspace will first have to enable the event and set the threshold. I can
>> understand this issue, I think. Your suggestion with a way to instantiate triggers
>> from events sounds like a potential way forward. Do you have any more thoughts on how
>> that could be implemented? How can we proceed? How can I help?
> 
> Step one would be to add a general in kernel interface to get hold of events.
> That would have to look a little like the in kernel access to buffers (see inkern.c)
> We might be able to get away with different consumers just having to accept
> they may get events they didn't ask for.  So make the consumers filter them
> and the interface would just allow requesting 'more' events from a device.
> That device could say no if it doesn't support the requested events in addition
> to what it already has. 
> 
> That interface has a bunch of other uses such as trip points for thermal etc.
> 
> After that was done we'd also need a way to instantiate a trigger on a particular
> devices' event stream + filter.  Maybe we could do it for all devices, though that is
> going to be a little ugly as a lot of new triggers would turn up as in theory
> we should register one for every possible event each device can create.
> (imagine we want a trigger on a rising threshold and a different one to capture
> something else on the falling threshold).
> 
> Alternative would be to use configfs to provide a creation path for such triggers.
> 
> So not a small job, but not really breaking any new ground, just filling in
> a couple of long known to be missing features.
> 
> We might need some example tooling + a bunch of docs on how to use this as well.
> 
> Jonathan
>

Thank you for your thoughts and directions. I will try to find time to prototype what
you're suggesting. It will probably take a while, both since it's "not a small job" and
also because I'm not yet that familiar with the code.

/ P-D
 
>>
>> Thank you for you comments so far, looking forward to hearing your thoughts on a way
>> forward.
>>
>> / P-D
>>
>>>
>>> Jonathan
>>>   
>>>>
>>>> Changes in v2:
>>>> - dt-bindings: Removed incorrect allOf.
>>>> - dt-bindings: Changed to generic node name.
>>>> - Correction in opt4060_trigger_one_shot(...) for continuous mode.
>>>> - Correction in opt4060_power_down(...), wrong register was read.
>>>> - Corrected usage of active_scan_mask in opt4060_trigger_handler(...).
>>>> - Clean-up of various comments.
>>>> - Link to V1: https://lore.kernel.org/lkml/20241003164932.1162049-1-perdaniel.olsson@axis.com/
>>>>
>>>> Per-Daniel Olsson (2):
>>>>   dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
>>>>   iio: light: Add support for TI OPT4060 color sensor
>>>>
>>>>  .../bindings/iio/light/ti,opt4060.yaml        |   51 +
>>>>  drivers/iio/light/Kconfig                     |   13 +
>>>>  drivers/iio/light/Makefile                    |    1 +
>>>>  drivers/iio/light/opt4060.c                   | 1216 +++++++++++++++++
>>>>  4 files changed, 1281 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
>>>>  create mode 100644 drivers/iio/light/opt4060.c
>>>>
>>>>
>>>> base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5  
>>>   
>>
>>
> 


