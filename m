Return-Path: <linux-iio+bounces-10327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA799475B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 13:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118EF1C23CDD
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 11:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372691D271F;
	Tue,  8 Oct 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="iGwGSrds"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023139.outbound.protection.outlook.com [52.101.67.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61716D4E6;
	Tue,  8 Oct 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387418; cv=fail; b=nlQTE8G8Oo7lwxdD5+vyH1NDVShc6w9T4JZmvcfHyVc6G2YpImV+KGMKxQRw4LDscFTE0cp8yRbcAJMLnZxvNJz1c/0OmoGid/HSnYghtiqU9GmqmX00VP5jZGToOZx2uPE3Lyam2hfWXzCZwAJovsvBANOGUnrsCQWL29l2C/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387418; c=relaxed/simple;
	bh=y70qyTzI+n9xo4LBsSVajII/EBC2jmhvy+AYKIl8YvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HRn/2p/5M4DIZ7WswnUGFFPf31mxWwxBFWGNVHOpFZJ+vr1ognbRWEQ447HcV+OYc91I65fbnKBW9xEKdEvUUFd4898lfL9TpJ/teCSKv7vJ+uk82LCn5dpsPeMn4bWhG+3pa7vFm/liQWZ8LLktcrHkq9t5wMRG7/Vn6KEvIs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=iGwGSrds; arc=fail smtp.client-ip=52.101.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiD2heddt/SVl6AeHlsbTUlwlzVGgDYnFiEgEcXtExvx86WCyiBuNlBrTtZbTAd5XZf3/Ds2jgO4Rw8Om2AopF9vKG2Nx9W5DvFgof74y3yN7JgjEPVUuQS6iyI96AMFDKVCy4FD+sS8h/5YzYUveyB5STS3s8/vqsjtgIhPV+xqvQsX16SKsYvEOF2ZtDkwmekxYKTYfEMAO1KvdD3n6tJmxJPYiHFrvtk8AXGEPNVKA6e9AyhJv83jFN2yFyJv/2+1Q89GNYAZklI8CzVum2/WCZ1Z27i7vrTtzElTMrP99CHUo1lyRPi5xm9EVEIMS9a7qD8R0yqsHeqvDLNi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3rUwStKQL3oJSiuLRSgM7QjJX1LdCAZiyH5m2IKkb0=;
 b=uqYGq3Sm3+gc+JewJbmciU+/MYv8MPo8xOCC/SomG0C39A+qrQWpL5Hwz2nUJiGOXMu//cnFBeh/Goca57cKI+lc+5q+fnH8eAAR53CHs9BJ1jPJsN58xKlomQyKBQUB1D5R/1vO//112tWudDJvitNCQVPH9+Sxp4z7IwDOS8gkjL0VEonDILJRSQPeEkmVowXXqd6xug08cK30PtWfC7WI7HpiiQju/5lGnES3S9jknsUMaFVM5N5soBcN+o6zmv2BO90BpRDot4EotbngxL1rmtTrxSxMuDdtlhE1t2/iU69j6eSM2tQkUU/a2Whzo/OV28qWcQ8rxaXt3/2Rjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3rUwStKQL3oJSiuLRSgM7QjJX1LdCAZiyH5m2IKkb0=;
 b=iGwGSrdsAIAcs/jqiAYyu1viokZWpP4srrp4Kc+v+byKlkE8qrJz9NBapd5kQP3X14fxjp6gbAiHFY3Kyec5snoxdXs0mMqgmVtvK3fQidOpHM144PVeLcRYVTzdpSNXwUto+3i+gc9iJ/q3LZ/r4Vq3M2wvOMAkE/M9hwuk224=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by PAVPR02MB8990.eurprd02.prod.outlook.com (2603:10a6:102:32e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 11:36:51 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%3]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 11:36:50 +0000
Message-ID: <d1d7b4be-60d7-b9ab-448c-a0d1e23f3daf@axentia.se>
Date: Tue, 8 Oct 2024 13:36:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/7] iio: fix possible race condition during access of
 available info lists
Content-Language: sv-SE, en-US
To: Matteo Martelli <matteomartelli3@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Christian Eggers <ceggers@arri.de>, Paul Cercueil <paul@crapouillou.net>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002BAB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:5) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|PAVPR02MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8f3b15-6218-4753-931b-08dce78d8022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGs1cjh0RFZtc1BWc0JhSm40VS9xc29JcWJTTkx5YWVnSUd6QlU1NXNsZVQw?=
 =?utf-8?B?Ly9ucEZwYlVzOHVNUkxPbk1Wa0RmY0dVOHQybWl5YTUxUjFGZlhRWmc1SGlE?=
 =?utf-8?B?OWdZVWNqNFVQRTBjU1JBN252YkZRQk1TRXEzcHNNTkVBSjgyT3lZUUFQWWkw?=
 =?utf-8?B?RTVYK09UTnljblJwUzNzR0hmUmE0WStITzlldWtVWEQ1SjNaL2p2amt3bmQz?=
 =?utf-8?B?Z2N6ZEo4Ukk1M21IemV1K0xLQkF5Q25BbHQ0N2RnVklGNm9ocVRCZjFTNTRW?=
 =?utf-8?B?b2hybkxPRE0vcDVMbmVFd3NHU0ZicHBzYzRvV25OUEZDWnJYNDAyL1JqMDM5?=
 =?utf-8?B?b1Y3YlJ3LzdwaWU4Vy9jblQ0L21NUGRvMVFNZm9Wc3NsczB3VHlWTUttdGt0?=
 =?utf-8?B?THZpMzkzR2tSQXpvb3ZVd3BpbmtiREVONFoxMFk4cW5oaFpKR0srUFlaRUpC?=
 =?utf-8?B?OVZXR3lBaGNvN0lacmIvU0I1dUZwaVZpelpvcHVzbENJYjZ5a25MeHhWY1lN?=
 =?utf-8?B?Y2EzY0hZdzMyNU1yK1lpSlBXSTJHdklRc045MlNrODBjVDJjc1JXVmxQTHdp?=
 =?utf-8?B?bmFQdXA5eDlOSG5zTUN4SGNPTmtVMW5LUjFRTFExZ2ZnaWV1bnNaWjBWK2xQ?=
 =?utf-8?B?NCtLeVA2eFpzZGNlc3phblN5ZTRHcno2SjRvbmlyUjF5WmtueW9yNUswdVQz?=
 =?utf-8?B?MTZ2MmZ5N3Q3M0pyN1JGWTlqTW9xUFhqNW5heVpudzU3NXBzWXZmZ2NkT0lv?=
 =?utf-8?B?NC9JOFNiYkMzOTJndUhvazFjK0dsUFpQNmhqdkdpNHJuNWdtNHNYL0YyS2JN?=
 =?utf-8?B?L2gzSkhNNVVHY1lkZHkwWTBhdzFLMVlQSmZ0SmI3MnllOElieERNVVdPNTdY?=
 =?utf-8?B?R2U4WW5pcjNXOGZMdVJKaGZ0OVE1RisrQUc5K3FYSkFjL09ER0pONDR1NHJq?=
 =?utf-8?B?ZUJ3cWx2YUFadk9sU203WFhQQkpYdWs0RzVDN0hOQnhJSkE3b3krd2JpZUZ0?=
 =?utf-8?B?REVXMUtCaXZqejhFRHBMWlBEam1MaTBsVzJmczAzWXhEb0E5QUdzdFUzOEFP?=
 =?utf-8?B?eHZDRVh2TUNtV1RwenE3Rkd0eGVLdTlUeVdLd0dwc0dXY21QTjdISEpieTJl?=
 =?utf-8?B?NlEvNjljakNwU1J0T1BRcHdOblBLYlhSVmRvOXpRV201Y2NWZUcvVTUrY1V1?=
 =?utf-8?B?OVc4STROY0hvWThqWVU2ZmV4NGhvTlZtKytESkhDdVMrWU8wUy9MclF2RnZG?=
 =?utf-8?B?TFJMMWMvNHpUaDdaSG52L0s0K3lITVc1dUs1eVd6ZWdJSUhDb29naG0rY2tY?=
 =?utf-8?B?ay90MHRmU0JRMlh5WXVLK1BvaWhWQ3VLS2JGZFFNOVdkWDNqYnM0SUJyVGp5?=
 =?utf-8?B?bVNNZ2pTVGtNUGhmclViWTdGRnMvUjRiRXFweENmaW9rbE05ZHZEWURkOWY5?=
 =?utf-8?B?Y01qdEdDVS9uaUlCOUNvSEZxZzk1SHI1T24yTER2WlIvUzA3NU9KL2FOK2E2?=
 =?utf-8?B?U2F3b3FDUnRGS2pOVGhFVmh0M3k4cHdpbVdaTUlPMk1KcUpjRFY2MGw4cm4w?=
 =?utf-8?B?R21zZ1J5NGlUZm1uS2hHRTk0ZmI4bVd3NTlyNVFKVjNFWG1FZWZXMU4vL2RU?=
 =?utf-8?B?L0ZqYkhQMmVtM0x2dTJTVWhvdjNmQldRanBCN245S3F6WFo2SEhCRThPSDE1?=
 =?utf-8?B?dStEWmZsb0VhTC8zc0hvZHMyaDBnSGdxL2RMdTRwOERJd2NZRjg5dThBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Q0WHJDVk1sK1U4LzZJekxmMDYrZm0xQUJJVW9tWXVmQnpycTlBbXpsSVV4?=
 =?utf-8?B?NENLZkdGM0x1NmF0eHZyY0NDZTE4ajNTZy9XZ3lacE9JOFRXNDNTUmFublBm?=
 =?utf-8?B?L3VyMWNTYVFQYjIwUVdGMDJVZStRVy9GYlc5QVNMdVVQQmhqOXA3UG9SNjVy?=
 =?utf-8?B?VjV3emRUWGlKTGdIK2gzc2E5dmNOU29wMUp1RTV1YmRiSDJXT01Qd2lyY3ph?=
 =?utf-8?B?cldiL2h4T1NnNmptTmg3YUl6d1B2c2ExaWEvVnFMQmFPR09iL2FpNGdjSUV3?=
 =?utf-8?B?clhKK1hnSTMxMEQ2emxZeEZ5ZkJ0YW1Eem5HWlpnNHFFenZWRjRqUll3clNw?=
 =?utf-8?B?Mkk0emhGcjQ0WGVwSFMzeng3LzB2WXhtNlB4UytUWFNOcXd1c1FFZU4vNWp2?=
 =?utf-8?B?Ny93UlRUbHdyeWtsTkhWZE5IeVlGd3hYT08xWkdhK0srUXIxYkIrWm1sZFVS?=
 =?utf-8?B?Z1NqQkJlbnVOLzZybitxeXE4enEySjlJYzFoeXhkZFdRVkpBd1lGcFlLOEtS?=
 =?utf-8?B?NktraVRDS2JvS25CSGlkMXZhOEQzUjFkUkZJVU1MZE13MzhDdkVhM2labGhE?=
 =?utf-8?B?UC8wWVE0aVpRbHJodjU4a3hZSnJZQUlaQUloRE9rcDc3KzNZM21YekR3bGc0?=
 =?utf-8?B?emxtRDk5alhkMFNJZDhDOHI2Q0JtSDN4dVVSam0zSnYwSnFNSW4yOGpzM29I?=
 =?utf-8?B?Tks1R2FPcmFvZHFxOGZEaEFVZy9uZTFiL0dQTjNNazBOM2FEek96YUlSbkYr?=
 =?utf-8?B?MDBZbS9KdmpWNllFUm5EaFRNK2xmaDkybW1yam93blNPVENDVC9CTWt3RHlR?=
 =?utf-8?B?aFVaaUY4aDBEQjFtcS9mRHcxU0RJY00xYXNxZGYxQkFDakcyNUJ3ekpGL1N3?=
 =?utf-8?B?VG5tL3B3VlorNGZXRkc2bmhkRXJiOFpmK0YxdXVhcFhhd3dYN2RibTZiaXlX?=
 =?utf-8?B?NnRCdmZKNnQ2Zm42eEVXNEhGKzVSSHdlTFFlMkN1czVmaFpORXFxSEdQWHZ5?=
 =?utf-8?B?OFZVdi90YmxiZFk4a3lQaWFWdXNxL0IwNmlrYm1ZdmU2MFJBWkdGc3JOSk10?=
 =?utf-8?B?em1Ockw2MXRKZnU2NW0zZ3BHcTh3WDY1VExYcFZidmNiTDlnZkczV3IyQW54?=
 =?utf-8?B?K0tCaGNEOWc3UG5ubkdRczlPY3ZkRGEvMndNSlZPS3pCTUp4MU5IcnJYZ3Ev?=
 =?utf-8?B?Y3JJQ0pqb3piVTdKYUF2RURlMXlxTlAxd0dua0x4UVA1QlZERERSQ0RGZHl0?=
 =?utf-8?B?dDAzNnp0cVMxT2llSzdRQkRacWxDNEgzUnZhSklGdGR0a2J2THdrUTZYYTJz?=
 =?utf-8?B?RDEzbGNGUCtPeWxNT0YraDh4Y3Yyc090RXlRejhUYUFOTldxN1BFOGN1MU1C?=
 =?utf-8?B?UStzMmlXdVBuaEpCVmR4cEcwaWs0Q1pLMWtZMGFXU2pZUkx1YlFlUXk1RXdw?=
 =?utf-8?B?cGxpRHgwQzM3Z1cxMzFQTC9DMXF3N3U1M0Nlb283bldZSVhCOTkwQis4Sm1R?=
 =?utf-8?B?K0I4ekE2RG84UGIzSFY4bEIyWGhJVm53US9LQTJtMHBIak1BQ3hHWHp5UDE1?=
 =?utf-8?B?Nnh2Sm5TUldhYzVLMS9KNEdZYkgvSVZENmJaTjFueDc5cDh6YW5UTnhZWjhD?=
 =?utf-8?B?dExVOCthUTdzWC9jOE9DWHNYMkVpb0lkdUVqN29Gb1kzbEZUaGIyTDRpY2s1?=
 =?utf-8?B?RTlmbUxoZkpXM2gzVDFySFZiMlp3ZzNYNGF4TDB6L2UyOU1tTnNNQTlNdEpz?=
 =?utf-8?B?RGxmQ3dyc3BhOXZwSVlmckxQdEJrTmtDNCtDaFQ1cHkzaEJMRGRVaTMwK2dm?=
 =?utf-8?B?cy9FTHhMQ1pTRGtPeGJSYUwzZnY3L2FaZ3k2Z3NNSHZPdk5WVUtPL0JnU1Bi?=
 =?utf-8?B?Rms0aWVLTHJKaUJKeXNCcXI3WE5GamJhU3R6SUlwanI2cGpLbnBMbUVxVDhD?=
 =?utf-8?B?Ni9tNG5HUUlmVTVhOTN5NVFYNHoyRjZrOFhjRGE5TlU3OW8vQ01lVEFTMWZB?=
 =?utf-8?B?VGIyM0JwQjBWMUZVLzdwQnNKMWxNdnZGZGs0QW1tbTZkY2lsZkhXRVAreGVM?=
 =?utf-8?B?cGxLbVhaL2hHUGwxejlueDdNZ09paEhma21Ld09VWGtOaU5Jdld3M3NMVjFa?=
 =?utf-8?Q?Pu9A=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8f3b15-6218-4753-931b-08dce78d8022
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 11:36:50.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95A7Rn1y46kmlDVeBbiKYizG5vaKccr+DFJKKk+VV7zfII1jkGs6X8sIQuz/e2RE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB8990

Hi!

2024-10-07 at 10:37, Matteo Martelli wrote:
> Some iio drivers currently share an available info list buffer that
> might be changed while iio core prints it to sysfs. This could cause the
> buffer shared with iio core to be corrupted. However, note that I was
> able to trigger the race condition only by adding a delay between each
> sysfs_emit_at calls in the iio_format_list() to force the concurrent
> access to the shared available list buffer.
> 
> This patch set extends the iio APIs and fixes some affected drivers.
> 
> Summary:
> - Patch 1: iio core: introduce a iio info release callback to let
>   drivers share a copy of their available info list and later free it.
> 
> - Patch 2: pac1921: handle the current scale available info via the
>   read_avail+read_avail_release_resource APIs instead of using an ad-hoc
>   ext_info attribute. The latter was used to avoid the risk of a race in
>   the available list.
> 
> - Patch 3,4: ad7192, as73211: fix the possible race in the drivers by
>   copying/releasing the affected available lists.
> 
> - Patch 5: inkern: make consumers copy and release the available info
>   lists of their producers, necessary after patch 1.
> 
> - Patch 6,7: iio-mux, iio-rescale, dpot-dac, ingenic-battery: adapt
>   consumers to inkern API change by freeing the now copied available
>   lists of their producers.

The series not bisectable because of leaks. I'm not certain if a simple
reordering is all that is needed or if some things have to be squashed?

Cheers,
Peter

