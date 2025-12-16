Return-Path: <linux-iio+bounces-27113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA17CC3FE4
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C82D303D3C1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2642234C80A;
	Tue, 16 Dec 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="CjleisFD"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021140.outbound.protection.outlook.com [40.107.130.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44734BA53;
	Tue, 16 Dec 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885281; cv=fail; b=pvS7jG7+0ianWVyKEoPDhJhlZw8X9I+6lshVYLkJBG889GGE2MK1Xv34OUYBHlftYv+GVVv3CApBKcRnmWyoVLfG+aPrCjbvrJrGKr3wP4rLif2MPxaEEtKf2TXOp+bIbVS+AHD0K0LBT08KVPUrr0TpvmNF1IF7D7J3hAo0v+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885281; c=relaxed/simple;
	bh=U05hbxjsBFf8IL6W4PEkPCEbo6kQcOAmdd6BAXqIWwo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EnFmYUtRe7lyvrJtXXG6XxR9JtUGZ3wWC6wXw27D0t+T3SDbx6n+EuyIpNX5RrPlZngGRnWaLb19EQ6sA/eGOgYxmmgsx9b/nI4h1OwyZ7l8T1f1xlNJPRtwtZ2A0YVhj7EesvP8gc83rTrcYe7ajKoVJ7GuOWqXsCLOoi4JIHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=CjleisFD; arc=fail smtp.client-ip=40.107.130.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb1pSHhenef/Kmm23t7N2JxUWmzsTY22YVOydCHZZ1+Kl3EDh0ZGZL1f98p0ra5J7rrWhY+yZOWRUq9L8aJMuBvQS5o5I3QHALvPEpVe7QLSTLFVZKAEhia8gxmAJ1kv/CGzDVCVDD+t/74loQyLkU9g8N9wSxrPULlAW83ljKn4J1lP4iEWZ43Lywh3wIf2x+/saBMOeMtA3iHL118xytMjigiNo2IcBWMSvo7v/O5NRm2PslzaWzphK9sbCWmSjEZ1s97b1K+0rfcnWvuT8P0WWT7J/XeKanDOJiusAL8zZ6wV9b8a5zW5lylCtyciy8jpsbfJF7tgP5GwToXM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVwSL2qHAGypIBPZrqdN44PMEMUgSeO6Dm54BpH7xtI=;
 b=gNQp83N+KkdWksHT0bcGLbKbNaRPKuK5zwc1ZDIvePJnnxE1zeKlFEcXKG/Hv5ihLKdOvFt6/sWcq4amJwu1dpJHqV3+xiCmSz++0XPN69rtD97IEcbvwVCDHgR1T6dGig6fES6GzOxp66k3ATcMh5BGrZTaGg8NickkMyedfjV+vQoQ6UD7dgXxJyWJRaTEEiOEEk9TVptH2+Pn6O6aMtGLqcqWzYAqOxS2f87CP1tMACnf0IDYhhtp468p0rQ+cw1K4O5FRa63hp93UWHVriLrrzju0judfsZjlb6OA6ZkHHrePc4PmGRa1xDd9KSPWqmDCdfim4LA5vkdd9+ujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVwSL2qHAGypIBPZrqdN44PMEMUgSeO6Dm54BpH7xtI=;
 b=CjleisFDmFXx94G6usmr+LUepNliPF5nG64X536pKkhNMtXouDU+aiYqwiLPQlqv2kjr2HJR+Wqnt/B+FTFE8FtDffReQlAbA7xb9eOHkhJqeb0kBJNkXyD56yrcIWJmvcAcscorN3DguhDJa4XXuDeiRFTIzD/VmNOuh2FlpQXeCzrUj4Gzd+JH5MrPMBMgBP4QRgjiedwHsiAhjzp1Jj/AF+Qw3AFmV5y1px983/TN79WJTVFB13iPfVeEkq8PtSinML3XXeruOtTToW8dqSXw7eKYmrE4WGwfw+kcebMZJ6ulnuP+kC3bOt5n/DK6UxxKPoKAUhbDy+xW4rRoKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by DU4PR06MB10185.eurprd06.prod.outlook.com (2603:10a6:10:626::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:41:11 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 11:41:11 +0000
From: Tomas Melin <tomas.melin@vaisala.com>
Date: Tue, 16 Dec 2025 11:40:05 +0000
Subject: [PATCH 1/2] iio: adc: ad9467: include two's complement in default
 mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d@vaisala.com>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomas Melin <tomas.melin@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765885270; l=4814;
 i=tomas.melin@vaisala.com; s=20251125; h=from:subject:message-id;
 bh=U05hbxjsBFf8IL6W4PEkPCEbo6kQcOAmdd6BAXqIWwo=;
 b=f7i8jY6U2cjNhhsPxKzwNbEkaZqin6oJhLoQkJsigtxUZr0pqnet2gU+LcCCJFUR9E9MsSNr7
 bBy2I9JT4rCALOplFcjS/IysxubFxJg0UncKuFpn9tF+zZl5ArSUrWZ
X-Developer-Key: i=tomas.melin@vaisala.com; a=ed25519;
 pk=6lMiecjZ+OeyZuxYsDm/ADy9D1JKvYrKdsYv58PMepU=
X-ClientProxiedBy: GV2PEPF0000383B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:b) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|DU4PR06MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e9d432-8d8b-4259-eb19-08de3c9802cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlJnMzBKSCtJdVdzL0ZtY3R3WWRzRnF0eW1QQVBsS3VPYWVyNHpkeWxxajRK?=
 =?utf-8?B?SkhhUzhwbnVpTnhFaitWV3ZGMGdESVhlVXZkbWxTQVFLZFREUWNFWTY0aC96?=
 =?utf-8?B?QkZ4eGFjUlhicHRYUzBlcDhwTjV2dmRDSyt3WTVLM2JkU1cyNXJmYzJXNHJO?=
 =?utf-8?B?Zm5qQ1lwaDRiQUFNTDlWc3laNlRqbkhwU1Y1TGcvbm9MR1lsTzQ0anBZTUdj?=
 =?utf-8?B?SHFUNUtrVXV2czVaQ0tXNkVNWDVvL2JpckUxY2cwSy9KUDdEVXE5UnY3Q0Ni?=
 =?utf-8?B?QlU3cysveXVhVXBSYk93Ukh2MEh5N3hkREdOSm9Jb3UyTDIyeWdrVmtjc3Br?=
 =?utf-8?B?SUVMY2Y4RGUzM0ljcXoxaDJITzVha2JrUnBaQ2xEV3RlVEliUFhYRjZXbTFr?=
 =?utf-8?B?OXMyTWJyYkFSQ1NodjFuYW9jdmZOSUVueHFlRGVIZjBVQUhlNER0eDcyeXVS?=
 =?utf-8?B?WFBaQjk4VmN6OEMzRWNIaytKNU42ZU01MHhxTmNhTlBQcGxzMHpzMFpsYk9k?=
 =?utf-8?B?QVFIRzl4akk5amVTRlpTZ0dDcHBPdFMxZ0ErZ0RnQ2N6UXRVRkh1SUUyTUVG?=
 =?utf-8?B?NjgxNnpmMXYyRGpDd3pwdDQycEV2RnNJaytrdld3cmhWMVlZZ3gxMFp5M05H?=
 =?utf-8?B?V1pkTklaOWpZWHIzL0c1Zko5VUNWa3h4dVNRYlp2MkhiOFg2QjFmQkJsSis5?=
 =?utf-8?B?azFTTDhud3BnWE9YY2lNeXJFTEZWM0dNU0lsVVFQbHNIcklGNGh5Q0ZiTnVo?=
 =?utf-8?B?ekNRenpKNHlmMGtaY1FUTE1RdmNkYW9KZTNQTUhhRThFMmRxa25WWWZwdkdn?=
 =?utf-8?B?VEpiK2xyVlpTYllncUF3WFpadGowMHpwdHhOYlAvQ1RyWWdVUm13T0lwUzRq?=
 =?utf-8?B?RENJcHliRVR2ditlTjVicjhWSHJkYk1mWWhJdCs1YVYvWnJsVkoxVUZDY2V4?=
 =?utf-8?B?S2NJd3Y0a0xBMlJxNldaZjFQY3ptZTlCQ2pSNjRRV0N0UXRYUTJiWFgxV3d4?=
 =?utf-8?B?bTBtOGdpdEZvSm9vNG1Ld2dtT1RsSUEwLzcvNzZwdDFibVFFOEhpdjVjVWk1?=
 =?utf-8?B?L2szekhPa2hMc0hzRG9MSG9GZXRFUVdzcmhNUkV0RzZ1TWlLL3R4ZVpvU1F5?=
 =?utf-8?B?Y2tzc3BlNHJ2SXF6eVptVmpyL1R4cmhCSGM5SmRpajladG1kaC9YMzVENWI2?=
 =?utf-8?B?Y24vQjB1ZEVFUVFmU2xUUVFTQWpxWEEydDd4QURHZThMMk5OMlZqUUVQblJ0?=
 =?utf-8?B?UVFoVDZWOEtCcm9JdDd4K1k1SkdEZkRoWnNCbkkwOEJMVjduWFVGNVNzOWRJ?=
 =?utf-8?B?QVJReTJQdlJNSElOZlFMbGZyQWd6c1NOaWhaa1pBZnZtN2cyNy9TTTQwcy9M?=
 =?utf-8?B?cXRFbmNRaENaT3JSNG1XY1JGTEMxWmpHSmdOaysrUnB4WHRmVEhDNDZLS05w?=
 =?utf-8?B?TXROTkNDZE0xNUthc0lReWUvRmlDdVU0SGtRRWF0S3ZjemNHUllsUXZBQjNK?=
 =?utf-8?B?VVJmU0hnSkNaOEtrbHBlN3AvN2tPQ0ZVT0RRSnZaWFltdDRqL1JVWGgwSFRn?=
 =?utf-8?B?TlNLb1FTUWcyQmVrQ3JadHMzeDdRdENYbmNSbmZSUkdSYWJ1VCtSbFVndW5l?=
 =?utf-8?B?SStJQ3BKeUNablFGQ1lnQTNTbU1FTWN5NUxZbjBlWDVmdGRTenIwdG1TNFor?=
 =?utf-8?B?S0VGRENWRG93QnJVNlowWHJtbUVJcmFGOTA2NXNyOEFCamFKR3pzSm95QzJy?=
 =?utf-8?B?Q1BHb3d2WVh3a3pCVEVPeDltU0VsTmk3WmlCL1ZHemRHNVRXUThYckRQV3hT?=
 =?utf-8?B?RnNpdnVZYzZsWjNlUWc2eW9UQUtZd2Fod0loYTZqUDFyZmlGRlZzV3dTWW9K?=
 =?utf-8?B?R29MczE1MUI2eXJQNnRCUnRyaW4vN0Z3UVEyekVrK3dHZGxNN2gxRWF2UG1u?=
 =?utf-8?B?WVpkbGgvRUFRb0VpKzQ3OTg3NUc4WWJiSkg2Y0FZWFVQSzB4VmFnSm03REJV?=
 =?utf-8?B?T296ellNOHArZkp3b3RHNElHR2tiL3J4WDloUWlxTFJSeGhnNDNNd1FxdUhK?=
 =?utf-8?Q?t9V7Ln?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR06MB10365.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTFGbmt5M0dwUXp0RW0zRGxhcFEvSlcreVo0RS90Tm1xRFhDczROM2VxVjVN?=
 =?utf-8?B?NWZFWGx0Q05RQ081SFhlRWFRZGxDWWxYWXdxRWVhS2EyN21sYzhyZGE1cWNn?=
 =?utf-8?B?RnlpT2g5OXBVc2pjUklIUStOLzBKeEhsRzZQYlRxTmsvREZEY09nSlY5YTFU?=
 =?utf-8?B?ajg2RTQwOUFhd0w2aGdZaFBDdlpFV2VkdTA3dTZYUkJEbGFsZXMxaWs2SlFP?=
 =?utf-8?B?aUZxN0xBalNpMllpUlRONE5CZEk3SXZpcFM0VWlkOHdpcWlmaWhiMXp0dEYr?=
 =?utf-8?B?OEQxUzRJTnZrVFRaTG5VMGJwbGN0d0VTajQ3QWQxcmt6dGErMFczV01IOUpl?=
 =?utf-8?B?WkJ4bzkvTXRwd2hJczZnay92VU1tVzBMbDQyQTlReXpDMVNlOW4zazFDeCtS?=
 =?utf-8?B?dkZ4Mlhua0tvNjNVVEMwNmY3U3M2RzZFQU9NdWI4S2tBaFVOYmJqUVEwLzVN?=
 =?utf-8?B?SVMyd3VUeVVWT0xkWDEyZXdBQ0tUYjJOR0Q4bnNIUkNtdjNoYWtuSkRxNVhm?=
 =?utf-8?B?OE5wd3BCM3hSeFh2MXVhcVRaSmpPVlFvMk9Qd1F6Y3AyNjMxbWU4RkJVNFlV?=
 =?utf-8?B?bEVMbG45N2tnRUpoeDM5d2llMDZBS0FXdUVGNHRBZllXVmRlYlRYZUNkei9l?=
 =?utf-8?B?V3F3MzB0NTdDZVBSbnIvaGswbnZuQkwwcGVWWkU3U1pyZnFHWjBUNVpiamEy?=
 =?utf-8?B?TnZicVBEdk5KWkRYd1U2OGVEVWQyNHBDRmlhMFlNUlJsd3FxL3AwdFpVbHBT?=
 =?utf-8?B?TTJoa3JzTi9hdXlSOXB6TTR4TmhyeVNmRDlMM202MnlxQXpOR3FXNitvblFX?=
 =?utf-8?B?ZUk3eXQ1OXZ6YkZoMk1RcmQ1SXNNNjFwaGM3VkVaemVWWjdXQnZtbTBmWWNw?=
 =?utf-8?B?U1BVMFRtVlJyMVlEU2ZvNTJTWVdJK3Yzem10aHlyOHI1OGppeTVBZERqZ3dv?=
 =?utf-8?B?WXFCRU16eU1SNWdrM0FBZEswbUZ2d0tjek1zTGtXWndQSHY4Z0FEUnpLL3p0?=
 =?utf-8?B?b0wzUEljd1NSSzZCT2p2TXRSRFBPRmRVNHo4T05aRC8rZ1h4S29NV3lWYlUz?=
 =?utf-8?B?MHFxendlQVVhWUZxQ2tHdXE4UHpEVUpZWVdIZERYVXJ2OVhJMEswWVlaaTNv?=
 =?utf-8?B?TnhVVmh3RmErcUc0Z0hDc2YySVFPTmZPWk9ndDlLK0JtVm91WG5vYTJweG1Y?=
 =?utf-8?B?RUtCT2xKYjRaUFdpb1pEZHBpL05yZlVwaXFELzJSQjV1bFJ1RnIzVVdmc0FE?=
 =?utf-8?B?cEptd2VwRU9ndndRenRwOUpISk0rYWhaYi90Z1M2dnlodmQ3TVROSUJ1VFNE?=
 =?utf-8?B?bFI4eWp2Nm1EOVF1WHYyZ0pzdlRxR0txeVBhSHlTTjVoMEkzUWMvMGpsL1JG?=
 =?utf-8?B?RWNYWlpvVmlHZlpqalFqVTVsalJFSU03ZFBoVVVvY1E3SFhFVDJrSUs3MlRO?=
 =?utf-8?B?QXYyNGJEZUVDb2xKNVBuczZqZFJlc0pJemc2RUtXU3pMRXVYbFFQTlZxVVRW?=
 =?utf-8?B?YitFRDBPa3JCU0pKaW1SRXRKbmNHQ0prL3Q2QTZNMU1yZnJicDcyS3hsQ21X?=
 =?utf-8?B?MGhRRkd0YWtJZzQvaDIrOWp1NFJmclVCTDdKYmdvZ1JYQ29qVzdBc25pcW1H?=
 =?utf-8?B?bzZ1OWNZTWRLQ2lIL0M3QWNUb0x3SjhZa1l5dzQ4ZzlqSkRnMVU1RkhBWitx?=
 =?utf-8?B?NTE2N0V2YXRXNXhxK0llbTVlV2pheFVTVWdOYXRUdWYwbStpREdLY2pFMmpq?=
 =?utf-8?B?elVwMlRaRll2L0c2bC8yMXRoTVIwUzV5WXRiN25hS1RtL05rK0Q0YlphLzhU?=
 =?utf-8?B?dnJUWmY4RjQyRmFVMytVMzBCei9reENPUGFQV1lzbFU1U0s2TkFDc1ZlYnll?=
 =?utf-8?B?em04c2szaGU3dHBWKzIvQm52eEhHNjZZbnpWVGYvWEVoUVRxZ1hoVGJnOFpE?=
 =?utf-8?B?QW5hOXhocXRZcHhxb3lsMCtNVHlmV3ZCVVhXcUIrNzRJNTBCN1IyMEROTWY5?=
 =?utf-8?B?ZlZZK25EenFNd2FhYjlKOHdIQ2Z1cnhIYVhZTVcyamtXb0h4YXRZcjhsVUx5?=
 =?utf-8?B?Ymx4QzljZ0RaMFcrZXpETzZteHZNbGJ3NmJ1ekhSQXBYcFdIMjBpNTVZUkJw?=
 =?utf-8?B?aG1kVS94RzA4R1N2QnlhYlN3YzJ6a2gxZkNRQlU4VW4wZ1k4ZGs3M3Z6UWti?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e9d432-8d8b-4259-eb19-08de3c9802cc
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:41:11.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZSA8Y//soGUCa7cSDKaqt3ZOjUy67AysojWmoLVS/b5HxdKHYjCU2b2KzloxRdTmdkjEsZROD/6RO+5etrpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10185

All supported drivers currently implicitly use two's complement mode.
Make this clear by declaring two's complement in the default
output mode. Calibration mode uses offset binary, so change the output
mode only when running the calibration or other test mode.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/adc/ad9467.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 59c3fa3bcc9b0b8b36b78c3b54fd7977cae23496..60fc3361b2689a4c38287c613ef93fe00338e5fa 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -72,6 +72,7 @@
 #define AN877_ADC_OUTPUT_MODE_OFFSET_BINARY	0x0
 #define AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT	0x1
 #define AN877_ADC_OUTPUT_MODE_GRAY_CODE		0x2
+#define AN877_ADC_OUTPUT_MODE_MASK		GENMASK(1, 0)
 
 /* AN877_ADC_REG_OUTPUT_PHASE */
 #define AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN	0x20
@@ -85,7 +86,7 @@
  */
 
 #define CHIPID_AD9211			0x06
-#define AD9211_DEF_OUTPUT_MODE		0x00
+#define AD9211_DEF_OUTPUT_MODE		0x01
 #define AD9211_REG_VREF_MASK		GENMASK(4, 0)
 
 /*
@@ -93,7 +94,7 @@
  */
 
 #define CHIPID_AD9265			0x64
-#define AD9265_DEF_OUTPUT_MODE		0x40
+#define AD9265_DEF_OUTPUT_MODE		0x41
 #define AD9265_REG_VREF_MASK		0xC0
 
 /*
@@ -101,7 +102,7 @@
  */
 
 #define CHIPID_AD9434			0x6A
-#define AD9434_DEF_OUTPUT_MODE		0x00
+#define AD9434_DEF_OUTPUT_MODE		0x01
 #define AD9434_REG_VREF_MASK		0xC0
 
 /*
@@ -109,7 +110,7 @@
  */
 
 #define CHIPID_AD9467			0x50
-#define AD9467_DEF_OUTPUT_MODE		0x08
+#define AD9467_DEF_OUTPUT_MODE		0x09
 #define AD9467_REG_VREF_MASK		0x0F
 
 /*
@@ -117,6 +118,7 @@
  */
 
 #define CHIPID_AD9643			0x82
+#define AD9643_DEF_OUTPUT_MODE		0x01
 #define AD9643_REG_VREF_MASK		0x1F
 
 /*
@@ -124,6 +126,7 @@
  */
 
 #define CHIPID_AD9652                   0xC1
+#define AD9652_DEF_OUTPUT_MODE		0x01
 #define AD9652_REG_VREF_MASK            0xC0
 
 /*
@@ -131,6 +134,7 @@
  */
 
 #define CHIPID_AD9649			0x6F
+#define AD9649_DEF_OUTPUT_MODE		0x01
 #define AD9649_TEST_POINTS		8
 
 #define AD9647_MAX_TEST_POINTS		32
@@ -461,6 +465,7 @@ static const struct ad9467_chip_info ad9643_chip_tbl = {
 	.test_mask = BIT(AN877_ADC_TESTMODE_RAMP) |
 		GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY, AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_RAMP + 1,
+	.default_output_mode = AD9643_DEF_OUTPUT_MODE,
 	.vref_mask = AD9643_REG_VREF_MASK,
 	.has_dco = true,
 	.has_dco_invert = true,
@@ -479,6 +484,7 @@ static const struct ad9467_chip_info ad9649_chip_tbl = {
 	.test_mask = GENMASK(AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY,
 			     AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY + 1,
+	.default_output_mode = AD9649_DEF_OUTPUT_MODE,
 	.has_dco = true,
 	.has_dco_invert = true,
 	.dco_en = AN877_ADC_DCO_DELAY_ENABLE,
@@ -496,6 +502,7 @@ static const struct ad9467_chip_info ad9652_chip_tbl = {
 	.test_mask = GENMASK(AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE,
 			     AN877_ADC_TESTMODE_OFF),
 	.test_mask_len = AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE + 1,
+	.default_output_mode = AD9652_DEF_OUTPUT_MODE,
 	.vref_mask = AD9652_REG_VREF_MASK,
 	.has_dco = true,
 };
@@ -671,10 +678,14 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
 
 static int ad9647_calibrate_prepare(struct ad9467_state *st)
 {
+	unsigned int cmode;
 	unsigned int c;
 	int ret;
 
-	ret = ad9467_outputmode_set(st, st->info->default_output_mode);
+	cmode = (st->info->default_output_mode & ~AN877_ADC_OUTPUT_MODE_MASK) |
+		FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
+			   AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
+	ret = ad9467_outputmode_set(st, cmode);
 	if (ret)
 		return ret;
 
@@ -778,7 +789,7 @@ static int ad9647_calibrate_stop(struct ad9467_state *st)
 			return ret;
 	}
 
-	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+	mode = st->info->default_output_mode;
 	return ad9467_outputmode_set(st, mode);
 }
 
@@ -1174,12 +1185,18 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
 		if (ret)
 			return ret;
 
-		out_mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+		out_mode = st->info->default_output_mode;
 		ret = ad9467_outputmode_set(st, out_mode);
 		if (ret)
 			return ret;
 	} else {
-		ret = ad9467_outputmode_set(st, st->info->default_output_mode);
+		unsigned int cmode;
+
+		cmode = (st->info->default_output_mode &
+			~AN877_ADC_OUTPUT_MODE_MASK) |
+			FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
+				   AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
+		ret = ad9467_outputmode_set(st, cmode);
 		if (ret)
 			return ret;
 

-- 
2.47.3


