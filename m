Return-Path: <linux-iio+bounces-25768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62EC262E5
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED291895072
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE32B2F60A1;
	Fri, 31 Oct 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XGxYajsk"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16C2EF64D;
	Fri, 31 Oct 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928796; cv=fail; b=ah+ZrgtiTak8ZzuACBUqylDakwpXWZkKnN1IQoYnqqtvyhseN+rd1DF1V2cLbb0O/qMu2tG5m20E2z8hy1UtTTQqBN7lY+MqJ5OkxyWUuj1GRYMfQJ13ID9h0Z867XB8/BnwJRRQYv9r5xJn1lToxFzNC62gB0YXhFy65r9b+jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928796; c=relaxed/simple;
	bh=1LUFgz7R6UhWyMwb9nmwzVP7MFNChMZ1rMIb6cYz8tQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KN67BO7oo8rqTmUUC1nRLweJWbubkYKtaP5/ioUdm7N5je5DiG8BCrho1jvBVitlH6kjywk0Nt3A+gUeWP070VupdI0x7j2g9hUZiS1obSgCvlOc7b1wrieXGsGet682Qw0rKEpaf7Bmq9dZL63A2UW8ZoStjc5lWWukxvG4cME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XGxYajsk; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhT0njuu3PyjbEkvE8Wb3c5UFP/7KZiU836WTNVgFShslFfo1uLUHruuaBfa14QOAbgxysdSf4az/CX8BASkupIfFH2EjlJKdlQnUUKzV48KGurWY69TvAS/EOafS3M0aYaX1bGciuMZ7dBMO7gRDO9vqi4epTSbrLR9IdlVpCQBx474eusSEa4fMFHfy71U8eSe8ICHdEomRs2KZPEwNzIDY2m6LgF9HU2jZzKAfm8oNJWsgh9pQr6FXND0ZpEr75unSD8Nvgnmni6ilL4non9E6mDh+0UONOjvRsI0dQ+0p9w4hFvwb7sxYwB7FpG3biY82bziC0XNucj19odweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koOhWtRsYPVlxiPkLCVF6YoTwJ7qaCgE656A0as65AQ=;
 b=goxOZMDXr5abrvE+cR9qSwtJNyJrZBCTJnrD2t5CHXwtBvhe+C1gMsvHXo8uo9PBv6sSXJq7CTwgSkxJatFOQX9kW47G6rgDlymYd97W0h4x4ZjiH0q6gxeHh7IWOOpme4PhtBWrU9970/iF/Wn9QqBLzKo6srdKqhtMh0otuXCvmwYFL32vNjZ1unnp1v+0ZgBwgmAjH5wzZHeyH6Y+gVFq4eyCQ/hVqqjwmi4AZfr9RsWl0KwN24q2nzufhGTPGdatfDMqcUf00gpgM8FlYy76xxcQyXv7qaZ0wWAkak2RnIucwgvguMiMjKRasYuDxHNlHNu4SQiHm3nqgkkGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koOhWtRsYPVlxiPkLCVF6YoTwJ7qaCgE656A0as65AQ=;
 b=XGxYajskf3xuNWEkRQ2Ra4FsDvxyu6pp0PP1VhtoqWjcypaO5LATZFlKUZUkF+VOhaHYYqjkzjJTv4b8umOpNBSVlVvohzoKcdDhHO4spYvV7lvMWCwaupQcDxEzHC5BhRmA76dbzJUOpvcyhLTXNPwrCGHUJEznY/0WgNuO4P2suWcwpWTUaqoBqHcfABd5voK8vMlP64GMXLtkdRP6DNXtGnUg4sauPYt7UBvsiiqq+icvrsSVVCTrn2QRCkGN5CkQqexnviEaRiab7SpqZ2RL9A18A7WcAN7o36vHi+uiJS7cxeMHESyau3y/F5RFDbAtgvrSMZ66fF+FNugyHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:39:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:39:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 0/6] i3c: Add basic HDR mode support
Date: Fri, 31 Oct 2025 12:39:12 -0400
Message-Id: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDmBGkC/3XQTU7DMBAF4KtUXhNkj8eecVfcAyHk+Id6QVIlK
 CqqcnfcChEHxPKN/L2R5yrmNJU0i+PhKqa0lLmMQw3u4SDCyQ9vqSuxZgESjFTguqLDa4xT1yu
 DzE6q1LOor89TyuVyb3p+qflU5o9x+rwXL+o2/duxqE52EtiTNxE14NNwOT+G8V3cGhbYlAPcF
 FRlGbxMvQZDsFe6UVpuSlfVW6AYIGX1W+GPUlLSprAq7XPydW6IzF6Zf5SpChEVYyYCk/bKNko
 1/7Lfu9ARaSVpr6hR0OyiqthaL3OmHNDuFbeKN8VVkTMxRYg9h+Ya67p+AQgMY+0WAgAA
X-Change-ID: 20250129-i3c_ddr-b15488901eb8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, 
 joshua.yeong@starfivetech.com, devicetree@vger.kernel.org, 
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Adrian Fluturel <fluturel.adrian@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761928780; l=3387;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1LUFgz7R6UhWyMwb9nmwzVP7MFNChMZ1rMIb6cYz8tQ=;
 b=MlnEGolMsKof+Yk0SME/aemw85QGdUfQ5CMdZkty5F0wIeZp/JbhDLBTIpwPSPrxlBmBKyw3v
 aitbcpNwPeRChFo1+f5KdHiQKImS6H8AoF8oFY1L683MVVQwo0Xc80q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB11533:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cbdf02-4dc9-429d-5dff-08de189c18fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk01anlaT2Y5Uk1UcEFiR3grWjNBM3E3bUNsd1BqZTBKNE1ubXh6bk82bmds?=
 =?utf-8?B?eXMxd3V1Y0ZVVk91bnBsaExZL3hDN2dSUS9kLzl3WUVraFp1R0QwV2FGM054?=
 =?utf-8?B?NjV2YmZMUUwyZUhiZVZqSGlXbzVLNmlVYmJWdWhkRW9QdU5CM0FCRUxhalRx?=
 =?utf-8?B?cjQwempNNjBuMlpvNGZUS1lJZGtWZzFmOFExM3VnbXd2ZFlhNFdHTDJoczly?=
 =?utf-8?B?NzlMM3Yva3FRcWdrSzJFYmdLM09Kc3NtSFZXTFdDSlZYNVhONGhLNlNGZHpu?=
 =?utf-8?B?azZhd3pZUHI0TUMrV0w5a21OcFhOc25EUWdiYkJIS1lPYmlIeXlXRlpqdVlV?=
 =?utf-8?B?THRRMjEzT0wyVllSZnhqS29SbC83dmdHWm1qeDJiS21RREx6K1c4RHZMTllP?=
 =?utf-8?B?Sjh1dEp2c1ZxQ20xZzRkUEF0Sjd0UUEyR1pmWFZjNFR0dnJpRlNlTGVCbjdN?=
 =?utf-8?B?Z0s4NllJV3hvNVV4aWhuT2paNEROVkZaaDZuWCtwVWNnWGhZZ2cxc25qb1Zv?=
 =?utf-8?B?dmxzZ2xlQWZ3ZWgvZTV1NXF4Vi8yUnZUdmx0MW83ZENqSUhMVVJNYytXYTVU?=
 =?utf-8?B?L3MzUWRCaVByTXVwcE1IN1VWSEo3REpJRWFmWEY0UFF4SlM3RlFmQVpoVVFT?=
 =?utf-8?B?d0xSRkRZb1FhTUFwRG1YZGxJSElGbHc4Nm5Oa2Yyb3BxU2pkbEo1TDNaZk1w?=
 =?utf-8?B?S3AzUjFCWGd6cWUwNC83UWcxOVltaHpOdWxxMGF0SjcyKzhuRVlyZHh4Rm1X?=
 =?utf-8?B?WHBBSHFUTjc5NkZkdUQwc2N5WGNFTm1nZllDZEpyQjliRDlYS1NUenhJOGRO?=
 =?utf-8?B?NVhyeWdQVjB6Tzh0QUdLM3hoL2tZdUVXYUxsaG9ra0RoZ0taY21lNGNnU2pj?=
 =?utf-8?B?ZlJOSG9EaU53QmZqMDEyNUFMS1dQMmhUUE5LZ2tsenY0d0tSU1NrcnA0eUV4?=
 =?utf-8?B?S09ES1FWeG5KRGhZUVVaUENyWGJGMUptODBkSzREZ0kzVVNFNnpneSs5TVhE?=
 =?utf-8?B?cDF0ZjVjbHU0dXpBcHFjK1pJbEpxU2hCckl5a3RzMWVWM1Q3SVVSOVBCZDZZ?=
 =?utf-8?B?OWgyVjBpUVhHYjFSYzV3SHZ5QUQyL0REMW0xT3QrSmxpd0ZESkJNSGU0WnM1?=
 =?utf-8?B?RDJ3aW9tTzdZanpWY0J3b29OVFNOSG9YcHpZM242VWh3aWpSM0xuT1B5LzRR?=
 =?utf-8?B?NU1BZHluZXQ4UURLTHZtaWdtWTJuOVdpSmdMYVZKaEkvczlqZHVyWENYVW8r?=
 =?utf-8?B?QXoxL2MxbWM4WVRXaW5LbWR2MUcyY3hhMEMyOGlZUXV1T1RBT29GZjhHZVFv?=
 =?utf-8?B?cDAycDdnOTVaVUNYbmZEU3RnZG9Wd0tlWjMxRm03bUpzUkNGMGdBWFVaVHVu?=
 =?utf-8?B?VmljT1ltSFJtY1hvTTJ0VWhMalpFeXJhdFZHd2U0MnZRMXRNdno5VUZNUVUr?=
 =?utf-8?B?RW9HZzEyZTFsMGZjSnJGWEZ5SmZOYmRzK0VucHllKzBCeUMxSGlnYXE2TVdD?=
 =?utf-8?B?MFVQY3RNc0Nyc2xaU3NRV1JsZytKU1Q3MXh2MUN5d1NPV3NHamFvNnlmd25u?=
 =?utf-8?B?bWp2bG04SW81U1kwWWpjNXA2NjdXampJeThyNEFVSHVkY2tTb2U1NEpPVUVy?=
 =?utf-8?B?bXIvYU9qdk5vbzJkTXYwM0FFWkFENjZqckZWTkVNd3VqSS91YU5nN1I2dUhs?=
 =?utf-8?B?QXNVbGtYWUpoMjdCQXhjR2laQUtiNXFlbzlCUWxUTXMzY1ZQR3pHZTQ1WHd0?=
 =?utf-8?B?R2lUSWdyVXkwa2tSTXBLQWhNWElocjJQQnAydC8za2F3MVo5UzVibmlzZ0g1?=
 =?utf-8?B?K3BDQ1dJME5EWCtHTXVYcDlIbDNUWERjZnRqVWREZjFBeE5iaFVscDNEOHhq?=
 =?utf-8?B?MUdkcGMycjZIRjFxQWVrUFZyZ0FwTENqYjBuU0FDMzFhYVdxTS9sTGZ5OWh4?=
 =?utf-8?B?cEtrMmdTamhTaUdzRjdnWUtWcW9MOFlaTTRycTRNWjhiTDJ2V3RvN1A0eTZX?=
 =?utf-8?B?aFV6Y3ErTGdVbnJaQXp6V0NWL2VCMGl2dzVzSTdUSE0yY3hZV01rY2RoRXdW?=
 =?utf-8?Q?ACp2I4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEpqOW9wNmxQdzRtQnlTL0lGVmZLVTNkeWtYVHlUbzU3WVlkZ1N6MGY4REZI?=
 =?utf-8?B?MmJra1RQVzVFcmRNWThBTnRUeXludmNGakQvN3RWTElmeC9nKzlOdTNrY0JN?=
 =?utf-8?B?NldrM0IzalhZc3FzT2N0UStYZUNYbG9STlNYMTFPM0hRWnUyODFXc2Zjb0xh?=
 =?utf-8?B?L3pMY3JHOXo1bzlsdmNNS2ViUlVEVkVvVHVVbFlzbGg5MW16MnA2QUthcFh2?=
 =?utf-8?B?UlFFWkhQVnZlK21uTHhlZEt1dnNYUGRvdk1JRkJLUitZaVNyOSsrWUVLVGJH?=
 =?utf-8?B?R2plQTZKNm9uTHovY0s3MGNkR0ljdWFtakliWDg1SjBGWi8ydXhPbnpHRS9a?=
 =?utf-8?B?QXBaKy8zMEg2OWhNVWRKdzJQN09Gb2VORGhNdmx1L3kzTjRQbjlWSWd3eVBX?=
 =?utf-8?B?Smx5eElTQWkxSW44OGcvU3B6alBLT2RBeTBNQmhkSWV5L3dDNXkvTkZ0Rytv?=
 =?utf-8?B?RGNoS0FvdlJyZ2pNSDBxWC9Rc214bXU2ekJYZzhXaEJZdUlYVnNPWDgzWHJU?=
 =?utf-8?B?WHI5Y2VsNkVycldQU25zcGpPWlpiK3ArTklyVllGU0pULyt5bzNoSll1Rmhz?=
 =?utf-8?B?a3oyNUQ1NGdpN2piV2hMNlFYK1JScDBObHZod1FkbGtPMTA0ajEzM2xMbmFS?=
 =?utf-8?B?V2srRnRNdnlFTHRWYUFZSEpSU04yTW9QcG9MYXFlQVBPc0duUFpMek9hOG40?=
 =?utf-8?B?cWU4bkQ4eFNEcUpQOFk0a3F2SzVIWTd5V1R4aDk3VjE5cW9zUzBLMEViWmRu?=
 =?utf-8?B?ejFmU0VBQlFWQUJnZUhTN3I5NkNGcnM1aEFYSldJaXVVVlVraDVHbFdBaW11?=
 =?utf-8?B?VzF4QnlubERHYVJtc0ZBK1A2NGZ2TjIwK2dPQ1YwSEhoR1ZZTW1ubVVycUZl?=
 =?utf-8?B?a0dyUW5iWnFuMUJTQnlwU2F2UWwyUjZnMVl5YU9QeTQ2UjdDVDN2Y2NyeXJG?=
 =?utf-8?B?QzA0cEdQVmVQRFNtLzc3UHhTeFlLYk5UckJ0Lzl5Y216RHgrM21xdDRya3FI?=
 =?utf-8?B?VmVyM3NwaVZuVE9oTm9BaXRRYk9DMHN4VExBak0vU1JiSy85QlRYS2syVXl3?=
 =?utf-8?B?cWxPRWVaalFTYnB5cVJiekJjYUZrOXhQb3MxMlJMYVNBcFU1M1VLQmhZZTk0?=
 =?utf-8?B?ZzJiQnpWcElBMWlSaU9YSjArWGM1NmNicmE3TjVzU0F3L0JuYWV4blp0d2M2?=
 =?utf-8?B?TmlsdXdtUVhhVDNCdmJkNmFpcldIR3Y1Y21KODNKVVRvR3UrL2Z0SWxKb1dR?=
 =?utf-8?B?dXEzMTlMRGRkYkJwOHpYN21NbWZESnU2amFUTENiVmhSUnZGOW16MTFzTzBU?=
 =?utf-8?B?SjRFbVcxMjZKRUFWZWFZOGZqcENnTjN5Vzh6UE93YjJwL0d5b1c3aUtqSnF0?=
 =?utf-8?B?cmdVRytmNC9vSEE3MnNSVERxWkY4Z0tFT1hBVlVyRGhEdHh1VUNuK29OeDlt?=
 =?utf-8?B?L1hBZmh3ZGk3dVhXSHZyWFFnRUlFUSt5ZDJnS2xxNVg4SXJ2MUdmbnJEQTlh?=
 =?utf-8?B?U3g3bmRQN2t1aFRmdFZ1UGVIdU5RU3dFaUJvMDhSMGdUQ01IZWZCelJFWklp?=
 =?utf-8?B?WU5JbDByL25jQVF5VERVdzNkSXlIZ3BvdWdKRkRheHNUeHZlOHZxRDJIYzht?=
 =?utf-8?B?YW15WUVhRFd6dHcxdmZGZ2U3TUpqMFFxVjJXMjZDdVRIektBeDZDZkxQY0Yx?=
 =?utf-8?B?aGY5eCs1U0tQSFc0SUd4WCtqdmp2Zi8zS0l5TXhwTDJNMUlaVUpNbGRZUFBj?=
 =?utf-8?B?Q3ZHNzJMY3BPVDNYVzIxN2hVUGFIZWU0bVRjY2UxYlpBTjRuM1JEMnh3VGt3?=
 =?utf-8?B?N3JGM3c5clBaNUxQUnRBRFI4TURySnIxV0F1eVpyZHptNjhHL0tGWEVVUUtq?=
 =?utf-8?B?OG1aUTk4R1JTVGw3YXBJTGdjZHpIVzU1NUVRand2TVMzQUZJWlVXWW16NFBw?=
 =?utf-8?B?eXVVS2VtYzZ3V2UvQW9uNlVhd3k5OWZlLzB6dGJ3V0lyNWJvM3IyRFo2Ulp5?=
 =?utf-8?B?amxtZVMrb0h0bVRxS1phaHpJUllua0NKUnNqSmVMaTRRczFCbnR3L1dnOHI1?=
 =?utf-8?B?WldWVDNKMHRiNVNaMWNxZFg0dkV6VHhPYmx1emw5WkJubE83Vmdtb0V3Z3NZ?=
 =?utf-8?Q?rOgc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cbdf02-4dc9-429d-5dff-08de189c18fd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:39:44.7797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ns/LtPCcWHfhAE7oY35uMQdydKlu689uu8fHQmKTCfCjzaoHeTHNYf9ilGlm8fWqBBEBTrl6qJhJjZGNfQPJSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

Add basic HDR mode support, only support private transfer, not support
CCC command.

Update i3c framework API to allow pass down mode and extend driver callback
function.

Implement HDR transfer in svc i3c master driver.

Simplifed HDR flow is (ref i3c spec line 5514) Figure 129

<--              SDR            ---> | <--- HDR
START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)

                                    ----> |
HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT

Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
read/write command.

svc hardware can auto issue SDR part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v9:
- remove reducated check for ops->priv_xfer.
- improve mmc5633 (see patch's change log for detail)
- Link to v8: https://lore.kernel.org/r/20251028-i3c_ddr-v8-0-795ded2db8c2@nxp.com

Changes in v8:
- Add cleanup patch replace framework's i3c_priv_xfer with i3c_xfer
- Link to v7: https://lore.kernel.org/r/20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com

Changes in v7:
- add explicit define for I3C_HDR_*
- add missed include files.
- detail see each patches' change log
- CONFIG_DEBUG_ATOMIC_SLEEP=y
- Link to v6: https://lore.kernel.org/r/20251014-i3c_ddr-v6-0-3afe49773107@nxp.com

Changes in v6:
- remove acpi part
- collect Conor Dooley ack tags
- Link to v5: https://lore.kernel.org/r/20251007-i3c_ddr-v5-0-444184f7725e@nxp.com

Changes in v5:
- Just realized missed CC mail list devicetree@vger.kernel.org and resend
- Link to v4: https://lore.kernel.org/r/20251007-i3c_ddr-v4-0-3afea5105775@nxp.com

Changes in v4:
- use master's hdr_cap to check HDR cap.
- add mmc5603 support.
- Link to v3: https://lore.kernel.org/r/20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com

Changes in v3:
- Add new patch for change rnw to union for svc.
- Detial changes see each patch's change log.
- Link to v2: https://lore.kernel.org/r/20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com

Changes in v2:
- Add sensor driver, which use HDR mode read/write data.
- change priv_xfer to i3c_xfer.
- Link to v1: https://lore.kernel.org/r/20250129-i3c_ddr-v1-0-028a7a5d4324@nxp.com

---
Frank Li (6):
      i3c: Add HDR API support
      i3c: Switch to use new i3c_xfer from i3c_priv_xfer
      i3c: master: svc: Replace bool rnw with union for HDR support
      i3c: master: svc: Add basic HDR mode support
      dt-bindings: trivial-devices: add MEMSIC 3-axis magnetometer
      iio: magnetometer: Add mmc5633 sensor

 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 drivers/i3c/device.c                               |  27 +-
 drivers/i3c/internals.h                            |   6 +-
 drivers/i3c/master.c                               |  19 +-
 drivers/i3c/master/svc-i3c-master.c                | 115 +++-
 drivers/iio/magnetometer/Kconfig                   |  12 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/mmc5633.c                 | 598 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  42 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 784 insertions(+), 44 deletions(-)
---
base-commit: df05ef50ada6a8e2fe758adf1b8fa35eea801b2d
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


