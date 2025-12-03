Return-Path: <linux-iio+bounces-26664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F0C9E793
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D975342008
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECD029C326;
	Wed,  3 Dec 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="jDthw2Xv"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021097.outbound.protection.outlook.com [40.107.130.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120DC2DCC1F;
	Wed,  3 Dec 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754130; cv=fail; b=N+HlCYO/NaJnLdg97pqTAfuXNKN68034FgTsEruXXEcntZNSoVqUTMAPC6/VSWhlvRPRoYjpTrDgTbN4Egeve/0TRT957+waOj5ceLa4HrDf+XXytsueGfuxM7gp8hcMhqmm/aEg72MVRnE/a+yWllKWX8xPqg+C8Kyr8i9VjZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754130; c=relaxed/simple;
	bh=TFFbznivPt8RCNqj0/w+2X2w7RGqgB5GiuXUbDQ87Dc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uA7Bp2EfbV3LAAvTMMZuDzQxVVRJzZ490wF1/MU36DoZa2U75GA41pKDtv60RXgQALRFQD8QvhOmXjjJQORK4YJA49/5NBBPno7iJY7c2gUb1D85g9sWzYPZjaaTNNGkwPQivYQ+Utz1uQuSK8uAiGPu0aUWGqEY82cJRREFdpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=jDthw2Xv; arc=fail smtp.client-ip=40.107.130.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9mrB0SIyECgAnyT53kYlRNdaHufMPg/FDaotW+oSa+DGd57LqqIwnltQtIhGpQIiNFwTZZ11NZbwB8PB4I1cVrLDjE1fhe/yXnarj9XywETfifUzJYrngkVywDeQi6pa2xZGqLDRm/jHqphFmGwt4FWJOsrUymvC2fkOtiSVj+EFcnZIw6qYoJCblNax+5X1U590XEldVrddu20n0GfKmTf0tffqSoabUdSiwE6tKC80NdwRKm+3TWjM+UbwDLuJzJ2z7ORUDHDEqKrkgKRRo903I3nIPO/bIUtXQGUe068Fqz8qyHrjh/4NroTDerOOtpn5caO0EFseyBAknu2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuhRjC+LRTSSgyBfciDkgfLG4Om7FBUy3ApIePFoW8Q=;
 b=jzp9atfHt/vfzajRezFzxR5fnuYbhWJJK/qWe/gGPruUAEgvpjmjmDb9aa1lNO5WTgZHCoJMm5anpPG0AmxnIIKTZ0WlVkzZP/tWTUoSuXq6zTSYSOFK5Yp/Y4VgG2/l0bH+2k9ScKnu1nntBbWvN/RQ+DyfiulV0o8PyXV3nVTdoFqesOGxlon3VpBL+xx9Vz9wN1z002qrIXVftQY7Cord9dUDZ1Fng/2VlawbFbzZPC5OxJ56R8BtTgsntJNkdca7UJ8KPIyW6F6h4j9JPjtMU8f8lXtO0TfFEd26syfpUlzF1InYOArr1pyIOo1Xw3zDX1LJORJEz4UC0vh2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuhRjC+LRTSSgyBfciDkgfLG4Om7FBUy3ApIePFoW8Q=;
 b=jDthw2XvFWMpBU9Z8lILwlNMiOr8C4jhQ6i6HX5MqOGkgSuQXL638sWYTXwELCt6dav0IC92BYfWLFJn0dX+4coyRQgRM+HtppEpqmWIAEeKx1R+9gc57gzGhz+N9wB12eLBFaq8Hbn0flLSg3q6ScF+RdAkFsmAe5esXDfmdxEfH2f6Nj0c/eIRVfVs188/WOk2c54Zovpw5GSgqbYqM26nH02aTYSF6bXVqwJUaUl47J7HsI8Mg082y7j/tkyyIzwqBjJhsrO7+tmhpD09lSJra7/ZvNiu1qRXY2RR4duCJdfZTU853tdTohcBapXKkJIoXo6yJcXflzbv9NJYwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by PAXPR06MB7422.eurprd06.prod.outlook.com (2603:10a6:102:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 09:28:41 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 09:28:41 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v3 0/2] iio: adc: ad9467: fixes for ad9434
Date: Wed, 03 Dec 2025 09:28:10 +0000
Message-Id: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoCMGkC/3XMwQ6CMAzG8VchPTvDykDw5HsYD2XrpImK2cyiI
 by7g5OaePza/P4TRA7CEfbFBIGTRBlveVSbAuxAtzMrcXkDllhrLLUi15nKKC9Pjqpx3tm28X3
 basjkHnh9ZHE85T1IfIzhtdaTXq5/QkmrUtWGOktIttbmkEgiXWhrxyssqYSfHH84Zu5pVznD1
 PdM33ye5zeRiWe56QAAAA==
X-Change-ID: 20251201-ad9434-fixes-6dfdc86fb881
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764754120; l=1212;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=TFFbznivPt8RCNqj0/w+2X2w7RGqgB5GiuXUbDQ87Dc=;
 b=gn16c/zjbWwmzxsOMXwA9E1s1H6FCsHb+ewXFKIfuf5cSiZfE6/WdH5gn5xQdb0KuL+t7Qr+b
 tcZLUa+R2IPDefXID4m/J/CNUCzhs0o1rz3csSPh8JSL5S3Vojj1ael
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GVX0EPF00011B53.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:d) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|PAXPR06MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 42550c23-1b4e-428e-b641-08de324e58cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGVzc1BZU1Q5bnl0ZFZqWDN3VkZMTXdPcHAvQ2xOc21YK3A4OEFXckZySElM?=
 =?utf-8?B?V2NXOTNYa0FEdzlEZEp6cDdSVTFqVnRDcmJIUVdoZjZiK2lwWTFNNnFPMWx3?=
 =?utf-8?B?WmJDakZvVEdUTnV3Mjh1eENqOGRIWVppY29QY0ZHY2xITlZpdTZYa0M5MWRr?=
 =?utf-8?B?cDNXRUJxM2daSVhuL1ltVkN5dnhueHJobUkra0lzSEczbDFTTi9OK295SGpU?=
 =?utf-8?B?U2VjMlozTjFrSU1QMldhNDQyR2VITUhTdGlyenhCeU1zT2xpemxVZGtVV21P?=
 =?utf-8?B?VzZXNktMS3RTajBmNkZ6MWt2elI4aktiWExjeko1L2UxSlU5ditiUDJkeHpI?=
 =?utf-8?B?L2xTb2RHcno1c0ViYW9OamN0V1pnUTBhN0tmR3owWXZhMllXQnh6QjY1NElO?=
 =?utf-8?B?cVlmSjdocEh6cDRhNEFMb1lzWG9yNWs3WFVIeFg1ZjF5SXpwODRsN3lpdzVt?=
 =?utf-8?B?R0xNSHZzejNQb21nZlhyQU9VdjdSQkppRDM0OHFsYXRvd1czK01Jek0yS3ZL?=
 =?utf-8?B?MlNNdEduV3kzVVFoVncvNVhETWRac09vSi9hL1U3SWZYYkFDVkV2TFFod3J3?=
 =?utf-8?B?Z1FiblRTNlp2dHFnbmZVcmpZQkt2alNMMTdWaFVuRWx6bGhHMm9OSit0bnI5?=
 =?utf-8?B?UFcxd01vdXNGWUdOSE4wbnNibWZJQ3Nob3ByRnpLUERTNTVNU2hHQ0llbzZn?=
 =?utf-8?B?ZWpGNEZuTDdnVkpSa3dDNld1M3ZWZ3NmMDJjV1VBbGpRNmJmYmNUbWFaL1Fj?=
 =?utf-8?B?QzlTKzVDVk0ySFM5cURYaS9yVGJySTYxTWc5aENnV2ljdnZlc0xmSWQxTVFO?=
 =?utf-8?B?ckxhd1JUc3o4UjIyZThFdk5Pc3A1cnhPbWJSWkRxUlhJbFlxNTVSSU82UWNl?=
 =?utf-8?B?alZEaURvUUU0K0JnK2hmekdnM2ltVGR2c1J0ZUo0ZmdYaEZzR1V1NzE2RTJs?=
 =?utf-8?B?ek00N1VFSVFwL2FydUdIVVhtQzF1UUJ5bnZEcUFwT2VidHlWeHBZQ1k1UElu?=
 =?utf-8?B?MFQ0UW55VFltR3dFQUcxQ2NDTksyckdwUkM4cndQb05Tek4ycnFaMU5mU2Fx?=
 =?utf-8?B?ZVpwQVVta01BeFZnT2FBN2NySTUxdXBON2VuY3Q3VVl3QzQvaWRnS3FTdDEw?=
 =?utf-8?B?NE9pd2Q4RW1pclMzaWVrVUdpUjJSTndZaGtqMWZrOGl0aDl5dzNtc3RUL0g2?=
 =?utf-8?B?dkdFNFpDRE0vN0pSbGpFUmxPVmRvWUYrUUtCOCtxMGlUeDE5ZHFaNGYzdkZn?=
 =?utf-8?B?MFA4OWExSWY4NW1ZdW1CMHl5SzBKTGhJZlEvQ2xhcHJiU0MxOUl4K2t5L1ov?=
 =?utf-8?B?NW9LaTJDTDFWbWNkUXNHRWplMUxNdlU4bjNad0habVpNSldYWU9WVm56OG8x?=
 =?utf-8?B?bDFyUmVJcGgvUjVLSTk0Nm9iNGc2bFJ1R0ZZZW5wMUNZZ29pQVdBc09OZWhY?=
 =?utf-8?B?UWNPNGhxYUxrRC9WWUZ4enRpZEM0UXBQVlUrS0xKVkJyRmhjZEpkUWRPMUZi?=
 =?utf-8?B?bFdlL1pmZGljWGQySllnRUpFQ2s5ejdXS3BtdXp1VlVIN0szM3BoK1RwRWN4?=
 =?utf-8?B?Q3FsZ3hDYWhFdlRveXhRS2ZCUGFEOGRmeXRzK21vSzRwNTVpWmVxU3RrNXdm?=
 =?utf-8?B?K2g0Z3pjVjBTdUcxUlViQVY3QSszbVRmek4wcWE2a1lLL05vcVlyRzJtQkVN?=
 =?utf-8?B?OElqNllYTlVNQnNSa2VYOXJYRGdSMTRPTWZTYUZQNTl6Ui9Va1A1Y2U4cTg1?=
 =?utf-8?B?WGo0RXZDcVpDNFpYa1UxUjI1VFRuYktGMVUxKzZRa01DUmlqc2Y3cyt1c0c4?=
 =?utf-8?B?QW44R0czNXprQmlabEVDeDROYThxUktmcXVmc2NGWlhKanpiNnNIVTgvcW9a?=
 =?utf-8?B?YVBpc0grc1J4bWhrUEhMZDV0VzAyTGlKc0F0aXdHTklyVUxIN1BsN2JvUnVD?=
 =?utf-8?B?QzF4anhobmxXTHZEVFdtaVFDUWlHajZtcXlUYlFRbDYrd2Rvbi83SG8wc1Jm?=
 =?utf-8?B?bzFBVEdxQXBXT3c4MEtsbVFkMk1XZnVSam0yaWFkaHRING5FcmRHTm53VC96?=
 =?utf-8?Q?CcKelK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3NkYUNHeE01TDV6aE9IWVNQVFlpdXg1VVZvZGVveE9IRHRia0FBMklPdHhF?=
 =?utf-8?B?amtBOEhaUmJCSjVNQUU2ZjJSVnYzVlZmZkRjdG1MeGIxSzlCV0JTdGl5YUJz?=
 =?utf-8?B?VUlTbWlVcm5YbTh5VE5tdko5RTdaQm9KRnV5RmVBQm50RTVVUGNmUlVvYWJj?=
 =?utf-8?B?SXFRWWp6MFhML3Vnd1dJTGlNM3hTdVowTU56UWdzNSt5VzFNTi9McjFreEFj?=
 =?utf-8?B?ajk0S29hR0x1eGRBRXVMUzlaKzA3SFdCd05HclZqazExRm5Yc3YvYUwrMFdC?=
 =?utf-8?B?WU0zQldhbEVWdXNRdFNvak54dXBUZFJZOC9lR2tReDAzWXdRbU4yODFzTHpw?=
 =?utf-8?B?TitwZGwvSjloa0Rta09ZdEVnUkIwZWJZYXNaVVBLdGNscFNneHRHaTZJcGxs?=
 =?utf-8?B?bVQ2dWoxTERvcGhxKzZTcTFIMXl2Y0dkZCsyS1NNYlY3dFVlVSsvZXNEQ0U4?=
 =?utf-8?B?WTRsTmszb2FZc1J1TWFpaVFLNUFBN2VRMkhtUy9BTll1VExzbEVWRXkrMmFt?=
 =?utf-8?B?TDVBbStSRVROWlhLZHJONlJYMFNwZ012TVc5Y0VmZ3FlUU1ocFpkM0J6SDkx?=
 =?utf-8?B?YlA3MUhJaHFSWXdLTFd1NENwRkQreEFNcnVvZVNVam9EaTh2d24zSUtkNWw2?=
 =?utf-8?B?WjlZdUt5WnZyYjdjVFdmMG9PRTROcW4vb1ZZTzVsenQ0ZmJIalRLVmwxTEV0?=
 =?utf-8?B?alNGcUpnQlVJN3pwZ1ExZHV1aDNBRlYzVmovZFNsdzM4OUs1WEd4VDVGZTBy?=
 =?utf-8?B?eDdUd2FpMFNtdXZYeEh0ZCtFS1RmZW1TemNHZDZscGlYRHBML0tjakxGdU0x?=
 =?utf-8?B?cHpLUm9IU0tXZ3RjRE5RQ3IrVzdHdFZCWmR0Yk5WbHFDS2JnZ1QrRHFUSlFV?=
 =?utf-8?B?a0FtTFNqMFMxVU1GZXJrZ3J6L3doSHYydUxvSVZTbi9iTUVWamtScWN6d3RV?=
 =?utf-8?B?KzNZbkJvMnl6eUtqbDdpY29vRld6U09NMGxTS1JZdWxkREhMYUlGUFRvV0RZ?=
 =?utf-8?B?Q2tRTmViZFJudGVTVzdqWGovbjlEbUxRSGIxUWxrL3ZOMlpiV21hcmFneU1r?=
 =?utf-8?B?Qzg2WXdaWFBFOU1mbG0zWjhORHJmNE1CbUk2ZjFhbksxV2c3NUNkNGlGT1NL?=
 =?utf-8?B?clArRjR0ZWhhMVFNQS9xc3R3M2Z3bVJBTjQ4dUlraGdLdENZMitscVY5dzg0?=
 =?utf-8?B?RjZXWWszWnJwQ3BlYnpWQlhZekFXdGRQMFlabnpSa3YxeGhNMkJhOVYyMmpj?=
 =?utf-8?B?MDNZWjFaK3ZXbkNrMEcyQk0wL2RwZlRzZjU4dVllYUxUdHo2UW5JZ1hsdFpr?=
 =?utf-8?B?UzlKek4xS1JkUE11M1VPSTVNRXlWaXJuZjlJd29XcFhKdGRoMnFrMEhjdi95?=
 =?utf-8?B?amRlR245SFhaZ21iUmp5cngrRzlxMWNNWHNlQWJKK1YxdkR5Q0U5SktLbzRW?=
 =?utf-8?B?b0E4RSsxaVdnZ0VjQnRZTklyd2poVmpTNkEzV1owdzRqVzYxVy9RQkIxMWJs?=
 =?utf-8?B?dXI0OExlaUUzQ2dpbnA4Q21ncStsVmxlVjY4RDhwRmsvWmdIc2FoWkw3RE84?=
 =?utf-8?B?TUNNME1NN1gwd25qU2N3Q2wyclhlcWxDNzcxRmV0MmpsYTVycGVNMHZ2RERL?=
 =?utf-8?B?aENhTXRGVlp3TG8vOGZ6QUZuOHBJZys0S2htS0RsU2szY1JnYy9rV1FjSHhr?=
 =?utf-8?B?RlVWRFgwWHlEUG1aMGFhVnI0Y1VhMS84eWIzaCtlZUUrOFVRK0tKVThhRlpX?=
 =?utf-8?B?NnZRNFA4MVZPbkZXenNCVk92YXhkRVVsVUh2Tkl5a2ZqdlF6eW9ZSFJlN3d5?=
 =?utf-8?B?WXBrbUVJZjNmTHpOZHV2M21iR29VWncvd0xQbXBQTHRGaHA2V0lIQzBHU3hB?=
 =?utf-8?B?eDlGSzZxaDFHTEJ4M3pNM290Y0NqZFZ2WkZQT2FNUm45a2trN0FyR1JOeCt5?=
 =?utf-8?B?Z3hsVm1qczdtTkFYNERqQTNaSTRmaFJqZ09KTC9oaksyaEdHN3dYZnVXdTBI?=
 =?utf-8?B?RWhuQmtxVkM0VWVmeWxMcWVkQXY4bE9xQjRrTGcxcUV4S1BsT0NaemtGZlZK?=
 =?utf-8?B?WjQvV0UxekRYU1lpdzhkR29FcW9KUXJTYW5iNTJaYWdCUXp2cnAxNVpPM2R5?=
 =?utf-8?B?ZjVmNE5BS01sVFFJU3RQZTRaUE9uN3diWXlYZDUxZWQyT29lOXlkaVQvV0ZW?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42550c23-1b4e-428e-b641-08de324e58cf
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 09:28:41.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBA9ATf2f8QVJXx6mVFJ8g9PWIvH4Kjs6xoDxjiiT78WMIsrLYH2ZpxPTz82PrLO+hgNElzTcIKyjBNhYwLXFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7422

Add support for setting offset range (calibration) for the ad9434
and fixup vref mask handling.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
Changes in v3:
- Removed comment about transfer as it is generally known to a familiar reader
  that the operation is required for specific registers 
- Aligned indendation with recommendations
- Link to v2: https://lore.kernel.org/r/20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com

Changes in v2:
Updates according to received feedback:
- embed ad9434 channel description instead of resorting to macro
- change INFO_OFFSET to INFO_CALIBBIAS
- keep offset value untouched in case of error
- drop length from avail_range
- Link to v1: https://lore.kernel.org/r/20251201-ad9434-fixes-v1-0-54a9ca2ac514@vaisala.com

---
Tomas Melin (2):
      iio: adc: ad9467: fix ad9434 vref mask
      iio: adc: ad9467: support write/read offset

 drivers/iio/adc/ad9467.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)
---
base-commit: 9b9e43704d2b05514aeeaea36311addba2c72408
change-id: 20251201-ad9434-fixes-6dfdc86fb881

Best regards,
-- 
Tomas Melin <tomas.melin@vaisala.com>


