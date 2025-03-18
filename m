Return-Path: <linux-iio+bounces-17033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D436BA67A60
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3509216DFB3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13F8210F5A;
	Tue, 18 Mar 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RfMgRbk8"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825A20FAB6
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317745; cv=fail; b=c/R2qMaYRth6dkx8DtTXHV3Sdl1PkMbg5Mt0Qw04fQ98097VScZqT1VtOqjDCMrLmqp5UM8dR7nvBzKuyEZ6KaUl8t95Tld6XIEWyi794xOIeY1EoJqoBNqQReqiwKqDJQScAeUcgBNhEvaHUcGejjdqV46tENu3I/1IjXgAnGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317745; c=relaxed/simple;
	bh=wleL9puHkivi8SLx5CKHDeAxnSeTmT5Wl7PBlUnDuyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MtnLxQVo0QSGW00Nd9x29TmO2lOHuLBTrW7I45dmGOICzRRVmVc9V5G79GZ5110rcgb2EB6JZfN9hH9S8npNcScNnvashVReBNsIfTWpcqKgaSaMP21CsBq0PpJUiILm67/0onUW59nnxHtS3Pi5RHTyUp4QCCfjNe9wiHv6FKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RfMgRbk8; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHVg9D3RR7MT9j8Coy/DDVvKt9PO+30t0pwjBMp7OsLULNZwFS1vEJgJVCxcoLuffqRDad3ua+bC4IG1KIA/6mplxIhlrwx+7vG8gTuFL+Ts/4uw8a2UUIeogvhFTeZ8BwH96kBAa0hHudyqEBt0vKJhubEmNv+KUvhkX6iUpTu6BqjlfZ9PrJWIrSaOG3gCrC3F+cplcZaeJ1SG+qkMtJnUDFFnNNAR9xhWrTdgSVZiJxD1fDrzcYXsl+s4V4uJBFFaZ21K3qPaOQPRBQF2LZxrOhjy4Hha7OCYOEMZvOhapCgWZshV5NCgdhCpEZgtpndmDUX3zUgs/EqW1kq5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7OUffohjUUcX08lAXVqaz/AWfvuCtOCCLze3XuKc28=;
 b=kwBH3x8nNkzA5hk64bstxsBT76RzPDCPoB4595UggLGv/1s2EB4x9Pm44VyhSAT+L0JbqBG9obMEK1VQ0gSszmpWlAi6gUlI9Z/FtZsKAWKHiU5/O+wLEPoHnsTpTpIGOI/TLxOAtV9ECsfY4xmJgaFSLprOAXNKyu0llhr12V5XzF3Lx6DbRDFWaqSIgyNNeJthdLEBV4XY4gfZrPRa+qXb22KGjeSBCxrxVSBrh6sLzFCpMKX7uvCn9k5hECjO6/7nJstHBb5HujbESqXMWLu1WfAgFPNQJA7CCdXfHnFNX0cOSREufSZj/seFbf7gzsUpV7mgNYEAMmR/6WDHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7OUffohjUUcX08lAXVqaz/AWfvuCtOCCLze3XuKc28=;
 b=RfMgRbk8C8GKeLCg5Tecv6pMt41HXMizmx5q6t+qi7EhHxMMa8rs32T1o0Wz0xqyjDvFrFAesnHYoqY3tbAVWEWE69Vjht808aFhmd8qAmSrSWfX/8+Rlh4Qb4EuYapj6D/w9Cb90OxqnLMb5kcKC2emvyMcBW990A7UX8tD+w0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by DBAPR02MB6039.eurprd02.prod.outlook.com (2603:10a6:10:188::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:08:57 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%2]) with mapi id 15.20.8511.026; Tue, 18 Mar 2025
 17:08:57 +0000
Message-ID: <591f4adc-60e3-4335-bd16-1cc4c422d52a@axis.com>
Date: Tue, 18 Mar 2025 18:08:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] iio: light: vcnl4000: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-18-jic23@kernel.org>
Content-Language: en-US
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
In-Reply-To: <20250309170633.1347476-18-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|DBAPR02MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 037abd31-4179-4fb8-5752-08dd663f920e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vis2elI0N014aDRXVWF4ejhVVnB0NGc4K1hxaGlmV1F4MDNSWUhheGlmWWJK?=
 =?utf-8?B?SThmQmZ5NHVKR2dTWStiNkFJVjN2S0NHYjVId2RzTXlJTERtajU5UDh4Zm1P?=
 =?utf-8?B?Ny9CSkhYRHRtK2JVTXl2Y1MyVVRRWUduWWJFMFN5U0NQTTBFYWhrQXhwSWla?=
 =?utf-8?B?Y1ZTUWdoQW9ZY3E3byt1dGRJYmNIVkh1MUpzdDg0c1QzVzVBRGQ2Z096ZWth?=
 =?utf-8?B?Ty9FeDdsdllaS3RJRjVKR1FNaGtqaTZhT3JYT09lakRYTGp0RU1vL0ZKTGUw?=
 =?utf-8?B?WUlObEpCL05OV2JyOGJaRkdhdVpMbnkwQUhsTDZmOFpIZTIyRlpBU0NYSzNs?=
 =?utf-8?B?UEdQU2kxT0tBYS9DclVjWTJkemc5d09HWlpobzJTeGNnMFpyRnNTVm5Qem92?=
 =?utf-8?B?dlhBbStkUHhUc05jaW9VUXdFczZ4S3ZIeEZHSXhJN0YvR1liMGR1S1JicTdW?=
 =?utf-8?B?OGFQbys4dXJQdGtnenA5V0JydWk0aDlBQ2ZCN01yVk5TbzJhY2RwMm1mVlpr?=
 =?utf-8?B?ZkpvL1ZZMXVZOGt0UjZ5NmxjelZNOVk2UlpNZnVaTXZobWlvOTZodkt4ZWRX?=
 =?utf-8?B?M2R2RGhZUVZFMnFNN1IyQmpRaWQycWJ6NG1tNzN4WlVSV3hDYndtTHE0QlBr?=
 =?utf-8?B?bTMyVDR4ZkhlOFZHT3MxVVBtN1ZHd2ErdzFLdFl4L3JveEpKZ0JpTVdxYWpy?=
 =?utf-8?B?ZGdabzZxa3FXY0xtSDgzOHNTbUxmQS92SU1JWmJtQmd2aldrTkxrZ0dzckl1?=
 =?utf-8?B?QnQzZ2E4VDdpOFNFVUNiR3k4MjlXVXEwQjlpMVdZbi9xWm5YSFVCZWZlWFJ4?=
 =?utf-8?B?MTR6ZWpqS013VlVFenRUbEF4blZKS2RNUXN2UXMzRTZYTGhpdmQ2VStaVHEv?=
 =?utf-8?B?N3d0aURkU2JiOGIxTW81UVRBenQ2b0V4Z3lyYndIRjNQVzdaQXNIYnI4eDYy?=
 =?utf-8?B?Y01EOXk4b1lLb080QTBvckhlakJUTjd0MWpkeDJFeitBRnl3dDdHVUNqZTlj?=
 =?utf-8?B?TnFjWVJ3WVdwV2NFTFRqSFVZN2l5RTZzRWRHRGMybWVaa1VxTzY5VGFvVzRj?=
 =?utf-8?B?eWdnWTl6WnJJOUpaS2J4eUgwL3ZZenJIdEdqR25QWnR6QzJaREhHVVM5UjJ5?=
 =?utf-8?B?SGxWSk9ZUzRVWHcvQXBSMGpQYTZTdzEzT0ZMaHBZUjNjSmFOVjQ2RXBidHp3?=
 =?utf-8?B?N0dBSXZYM1lCQVJNOTY1OVlsMHlMeER3N2x5RktYSVV4RUh5OC9UVmVpcnVh?=
 =?utf-8?B?aTZHQjhqVUphR2VxWWk5OEdyWDVmMmh5RzRBTk9qQWQzNTd4WDhBSHBGeTNH?=
 =?utf-8?B?RkJQeWpXWWNjdUJGOUR1VzY1WlpyS0ErSTlaVEUyNllrbWRSRHAvVGdYMUds?=
 =?utf-8?B?dUg3QWxzUnJyb3krZDZjYTI1Y2JkNjdPd1hISldTc1VlYU9RSnBmYUwyUU5o?=
 =?utf-8?B?NG95ZU8rYmVHUlBWd1FHc1kwSnJtNUs4cEFkRFJ3ZithWTJ3cVNkblRORUI5?=
 =?utf-8?B?c0ZMbmNyTnNaVmdIRW5Ia0lCVjN5QVkrS2ZDOGRmdFN3U1VPVktJWUVCRHdT?=
 =?utf-8?B?SWdZblVVRVI2V3h3MmZiRk1DbzZ2UGFlOVd3YW9iV1RnUnN3eVNpS0svdDBK?=
 =?utf-8?B?OEo3bnAxTmhQbktmZ1E4eWlyRDJtNFlxR2tmL2Fjc0ZRYnVZUGc5eW4vck95?=
 =?utf-8?B?SzgyQ2g1RjA5NGFHV0JPdjAyOWdmN3YwNmh2dXBqSThoeENySkhJVC8vUTJl?=
 =?utf-8?B?L3QxSXVEaWF4bTJjTktvaTh3U1lwRko5VzVSaG92ZzExbi9GS2wxcEozU1A2?=
 =?utf-8?B?L0g3N3J3TEpVUVZkdEJGMG9SZDJPd1JESlIyOEQvVTJET1NxenVrUHUwblZr?=
 =?utf-8?Q?ZSbCp+kTR5DE7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmF6SUdzTWRNWmdQa1NmSHBwS0J4c3lhbGkyRnRjTUdHU3ArQlVHQlZTZGNP?=
 =?utf-8?B?dXNrcTZ3RjZETU0xWFVLUEdVTjMxaFdTTDJDTGd1MFVUQjZRcDRBa0dXVUdt?=
 =?utf-8?B?UXZydzRkMmFzSHY4cGdpdTRGaXJMVFZudFZ3NlNTajhCSGkzakVoLzFxSW5a?=
 =?utf-8?B?ZThQcm9jVkhHWEZNaGMzWjc5aHFSYWd5WENNQm9SZlFGbnlETmxYdEkzd3BU?=
 =?utf-8?B?eExaWUFRVlZnL0xaY1JXUk5YYU1uWUJBdERTTlhMS2N5aThrbGdZUzRXQkkv?=
 =?utf-8?B?d21UNUlxZzhEelZaMEp6VDg2djF5NFZybVpVMjduQXNlN24ydkJhSWpTU1Nx?=
 =?utf-8?B?M1dGakZKZUxKUXJLVzQxYTJzYUJBNHFCQWIrUU1tRzlML2I2UTB0bUQzRnk1?=
 =?utf-8?B?d1VBTE13dnhVV0pYWkkwS0JoUXh6ODE0RzVCQ283R2tyRlpZaDRnZllkNXdn?=
 =?utf-8?B?SnpKNTNUM2IyakQveEQ0QzFKYnVYMFpyN3FienBNMHV5dC96aHo0YnY5bHlT?=
 =?utf-8?B?WUpKcHNYQ2VHRi9wdXBWYURMNm45QW8rREdxaDBjK0JNLzVGL2ozV29JNEZo?=
 =?utf-8?B?Sno2N1pwUFpLQmFRQWovb2FTZ0EwMTc4MFZncGFtMHljY09hUHBJQUw3aTQ1?=
 =?utf-8?B?UmdpbUlabHZrczROQzBvYlNBVkxETDdQNElYRzBEWldXQUJkV3greE9KMjRp?=
 =?utf-8?B?UnB2dkcxZW9PQk1TMERjeTJ3d2lsWm45b0FacDFjZm1nNjU4WFozSytmYlZZ?=
 =?utf-8?B?Ty9BM2VlSm5xdHNsdkJaY3hQNEI3bFgzTTBZNjIxMUJ1a0N6ODZFYWNQTk9k?=
 =?utf-8?B?NWxQUFVsRm15aFdNenJlK25EOTB1M2oxZWxCTXovNGRmaGlzN2lJUnFpTllF?=
 =?utf-8?B?ZXR5Mm9VVCtlYkdyNDJPWGZsclBraFovd0sxYzRDajdmZkpXTmhZUUxTSXRS?=
 =?utf-8?B?Wm01UnRkdlBBTitiYzYzQ1A4cDVKMGxncW90ZzhVTUdPd2IxQkhMU0xhNnhC?=
 =?utf-8?B?OVcxU1YrWFlmdW9YQ0l0K3VIV1N2T29TeG1MbWJrRTRqMmJmc2RNSWJSQkYx?=
 =?utf-8?B?Q1ZkcUxRbklWNjlnUWJtV05lWjM3bkZHazMzZENKYVNJVnc1MlArUHBLTTQ1?=
 =?utf-8?B?RWtRMUF2VXhhWFV5UXhkMXlhU2ZZKzlGUWlxZmhyTTF4d2xWZTE3STh6dHAz?=
 =?utf-8?B?ZzZhVU13RTFuamkzaVNnL1lKOFhvczZJWHEvVHNYajFyR2RyR0VrMUozUDdD?=
 =?utf-8?B?QUZVZ2xlOUJ3b2VBVzcyWXRwa2VpM1NZbWl5RXR3MlZNcVRUMVlDWXVWeXEv?=
 =?utf-8?B?K09QYzgwRW9JYTBaeHp4SWpDZ01kdkxuWGc2NnQ1c3k3eG5sWEVvRndrWmVF?=
 =?utf-8?B?YXNkV3A5OW5wMFNxTEdsVVE5KzNRZ0FSUzVSOWVXSVlhb3dQeFVOcENtanEz?=
 =?utf-8?B?aEY1STNTQ3BFRHJMOGNXaTVpdUZPc3RIaTRKQ0FoUjRtWjIwSjc5aEFIcCsx?=
 =?utf-8?B?eHNPR29FZG9xOHZKcW5JSmpkMk52NE1IN1hkRUJMaW02OVVJMktkNjliLysz?=
 =?utf-8?B?WW80TjNUaVJURmxoWW1Ba3RlaUNBTEkxRm5sMXA3YWVON0Y3d0QyWGo5dGhp?=
 =?utf-8?B?M2YzSUxRZjY1QUY1aWhGcFJjYmcrdVBjUDF5R2IyNWttTE56UE9FblowVnZH?=
 =?utf-8?B?d3JCWFlBZ0xCMDljRjBvWlo3cnVUVjNRQlhja0JFMmVqaDd2THEyZTdodU45?=
 =?utf-8?B?TnBISVdYamRrZTFGazFmUFdObWNTZEM5UUpFaXRKREpRS0N3YlRRL0JzMzk1?=
 =?utf-8?B?a1A5ZzRDTFdLUWhBRXZNZnJFdjVQU1pEUjc4WFBKQVJTdWpkMlZSdHFrdThh?=
 =?utf-8?B?NThXOEJGb2puTGJ3aCtsSi9WV2dpejhjamUyQ3dzQ1pSTnZyazR4RXZ5QUhJ?=
 =?utf-8?B?anF5dFZNM1JsNENudkFuTTJMSmN2NUJXNVVBMXNBb3FpSWFpZ3dWbnF6RFB1?=
 =?utf-8?B?REppREJ5MVh4N0N6OGlOc1FLQm9Pdm0vaVB2cEE5TG9hNzdjYm5sSUY0U0Mz?=
 =?utf-8?B?OVdRcE1hdXF0cU1lVUg4cSttallBNVFoZzVJcnRKSmw5UVk4MTlaZThLVG1C?=
 =?utf-8?Q?ZWg0=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037abd31-4179-4fb8-5752-08dd663f920e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:08:57.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0NScNADb3b54JUIK4cxYwiKHw47r6UBi/kxjr46IvKh35n5tg1XfM7pnk1vKkTx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6039

On 3/9/25 18:06, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Also split the enabling and disabling of thresholds into separate
> functions given overlap is small.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Astrid Rost <astrid.rost@axis.com>

Tested-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Reviewed-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>

Best regards / P-D

