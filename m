Return-Path: <linux-iio+bounces-25631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A1C1CFF4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 20:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C434E05B2
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FEE357A31;
	Wed, 29 Oct 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nAN795xD"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D21D86DC;
	Wed, 29 Oct 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766058; cv=fail; b=cyzYM4f9DwKv9BDizfDzKfMDqvQ+XZX5Q5EAVKvidGE+QJR67aUlIFiCnYo+YbMhIbxOio0Cx6UJNtPbXUnWuZivGc5AQQ9mQDej0PfRhaDNOGsjz9UndQIkUKVSpsDaPrS0Xtdsv/LfZxAJEmbOEj8muIi4wXJsIZTKZoKabIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766058; c=relaxed/simple;
	bh=NF9ALCpGY7sUBYF+lKTFk6herS3lj4tuEOcDiZcpCF8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Om77xlAR2UvaRJD+WWXJrB5fEsUgbdCux3r32lPDp79pLzBMX/2CQhNbQL4L3hem4ZogQaPIA0lne+pJNA+pxRjE03Z8LqHoT5+LJ1CnPQOSbGtmphBQiwf2aUDex4DczLcRLpTijACvsz7bF++XTtPy/ZjO0bVF8aIzr/KzEVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nAN795xD; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoSmd/Q7mP7Iyl3ynUsFKLkVW1aVczdRXC59LnLa5DBErhwWONrw6QudWW77l+TNXqaOJEv3C1Ewc13Ft3l+1Hmasp9xgZKLoTAzzpRo94/9F78N6diD9L0hS54HzaA6z9JgvMT39IJSfSQnVTMuoVSeJ4tU8uiMRlEEM+t25d8s1fWMyBzL9OXFQGTOc3ZTJvLggEhB/IOj0nmIbpoxbYkSqNTuk+dpV7+yh7gM2NkxjsCi3uNyK4gnez2ijDugBcKq+QgRAbIEad4MV7v6DWXMKNWNW+/xwNBh2ljhSaOf3+0/aiH49HZGYyKV7lgLtBCQha7ONIXXpHm+k7A5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnrq76kzmGTQTXvCnLCB97F876HkabMj0YGGADOyrAM=;
 b=fphA3iZ9nNq5OzkwQhZdkH7TY/YURtzwhehR61BYbiPo+78aFEZaI/lT4Xvam4hbmHbl62qwmC43jtGJoFNo0dPVfFPuzXHIO+ewV55nuUQ2i5LDkILiWuexoSVMj513y0QPcHjnQxcTrXBy3oSANOc2LcGL6wcdJOt9Dgi09h/3ARBP8N2bVzRiFCyhvnaZjFfynCm+mdBtVwLpjyFIbf+yg2ZOChuqCQ2WdMlijiK6LzXgc53COyHTQEjuANisUs8HPWqbSZ5iq3AbUhusgGyGU7T75YphZ1uT9BNXYtAqPBTMht2nBSPaVUMXnhP1kYZy1oONwKOPi7c8It1ewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnrq76kzmGTQTXvCnLCB97F876HkabMj0YGGADOyrAM=;
 b=nAN795xDHEFswdWA6e3GIwvSZ1nI2qlE6C4+QOtwqLAKj8DrHGzELiSnQVLvH182/tvLy7qTnq+VEnRhd7PvH6gnivpiuFSQaw96A/u10GGENy2Q018wYTHvFO5Ip413zpRSW3aRF/eTE+9Fbu/LkA9k0Fi6u+8rZdj+F3XFXXCjtl3l5EiTHxvG4S67SO2x3qDkjUGVAw8WVToKqb1PwlnaAHFJtcN/pSWC2URJ6MtExkWAAOK8MMCTD00FB7ZurF1TplqZw0Gc59idbVR1jUm41/Xl+8P9/g2xIaHrtQwvBhjegIFf5NPqgEWrDbjCIA4OTM3p7bNR1NE5A1sh+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 19:27:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:27:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] arm64: dts: imx8qxp-mek: Add i2c1 sensors
Date: Wed, 29 Oct 2025 15:27:17 -0400
Message-Id: <20251029-qxp_sensor-v1-0-e97ee1de96d8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJVqAmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3cKKgvji1Lzi/CJdCzPD1DQj02QTQxNLJaCGgqLUtMwKsGHRsbW
 1AOrp5GtcAAAA
X-Change-ID: 20251029-qxp_sensor-861ef25c4149
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761766047; l=666;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NF9ALCpGY7sUBYF+lKTFk6herS3lj4tuEOcDiZcpCF8=;
 b=4RajtEh0bKZ2IEfUNXjTZWtZpGp7riXFvDU+awhf7pZDYGzMmn4HzGsOljoxt++YZWwSgCXvX
 drHlZCBmOt6CIrXh5oMRv/12NZD9kO/1tw2EYAa2lxxwzKJAyOvXGrY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P221CA0033.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: aea313ff-9785-4e7e-3a47-08de17213475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1RDRUJ2L1g1ZGJCUnhsVlJoTkhHY0Y2bEdxMm94WXA4UEoyV1hTb0RKSnZK?=
 =?utf-8?B?WWRhVXJmRHV4NHZNN1ptSkRDSncxMCt1V0xjTG1sQU9VTnIxWFBpR200dDRM?=
 =?utf-8?B?UGRxNFBkTEdhQ2NXYS9XVnpNYlpXNmowYjBsSGJJMXMvN3JBV0owODdld2I2?=
 =?utf-8?B?ZElWY3U3TGxJNEhER2JDZ0hlRnFRN2tMSnZTcTBuK0hvakhYU0JDdDhHVHFG?=
 =?utf-8?B?R3o5RUFPSlY5WHlscTZTRklUaEhWOW15QlREWkJrcy9nMGtuSFdZb3czL0pD?=
 =?utf-8?B?UGQzS0hGajZpS0p4WnhWaXZPcHIrMThJTW15TndNWFczOTZySVoyRjVWZjA1?=
 =?utf-8?B?UnNQbk9sRXdWeXE3MTUweHFZZUtnYlpMb1lkdk9sWkRUbEx3MFpBcWphM2Ey?=
 =?utf-8?B?TEN1cjFBOVhqRHhHVXE2Y1IwbDVNb0JINlNrdnIvcW5xdlhxUGhDdW9zTmFm?=
 =?utf-8?B?a3RwNWZleVZxS0x1UG5yNTZNeVNhT09QQWhYNStXbWNUYjcwdVhpVXdoS0Zy?=
 =?utf-8?B?SHgyc3JUYjRyZkwwSFZpSnh5N0FCOXJoVzdXQWtQVXZYTU5WVjJlTzRxK29L?=
 =?utf-8?B?MVBmdzM5ZEI2eWQ2VlRsd0Q0aWFjRHRtN3BFakJsV3VPMGh5QTl3SmNWbW45?=
 =?utf-8?B?S05hMm1jNFNKQnd0MFdUcXM4Y0xSRm1pSmdWTzhCOFI1VkV1Zkx0UWhrOElJ?=
 =?utf-8?B?NkEwakpucmpsT3BPQUUrTHFOZm1zc2lmZXpqWDVnblZpb1V6SFgwejFJVWsv?=
 =?utf-8?B?WFd4Y3dVc3pPV1lBNjdrRjNsRnlCZFphV1BjRGlLdC9paUR6ZHJhTXMrWVF2?=
 =?utf-8?B?QXNyWTlrVzA4VHAwYUxWSDhHbXlEU01jVG5MbnNWdFZxUGtOR0VSZitjR2Uz?=
 =?utf-8?B?Y3JPMFpld21RSTdLdjJENXJxanlGV1BYOXdNVFFHaXpzRGlHOFR4U25JN2gz?=
 =?utf-8?B?bmZRejZuTkxkWXBiSG9ZMkVDOUdJMU1hdGptZmZTUDV2WjlrVWVNSEZRemQr?=
 =?utf-8?B?bWxrd28rWmQ2MDBIZlllaUUwNTZ5U3Jhb2MrQWI1UGhmM3FBQkNSa0hETFg4?=
 =?utf-8?B?QjZGWHo3V1ZSUE05MEdjaFo5eDVzcFRsQ1dObFJLbXNveEpmR2x2UWVTSTJr?=
 =?utf-8?B?OGgwdTBUSUc4UXFjeXhrZWZiMlVSTklGblJQczM0QlN0NFdHY2t0VThkbkVl?=
 =?utf-8?B?MzI0cm5wWkFZdnA1TUlKSHVLOWw0WHJPa3dOcm0wTWZWTlJ5WDlEUm95OURC?=
 =?utf-8?B?UUZ1RVhHTndxeWRMdGlpcVBrKzBHMzZQQ0NlVWVHM1lWbWRteWdLeDRPVG5O?=
 =?utf-8?B?blhzSE50SjZ6bldjREZmN3hpYUYwUkFNZGRGSm9CeXlEcSs2SUpsZWc5ekNw?=
 =?utf-8?B?bkI0enVnNUhUbWxkZ1BXTUNoTmphMUhUQnFCT2k2blNhZ0RkcU84c0NUN2NR?=
 =?utf-8?B?UU9aWnhvd0JabHcvaC9XSEJNTHFEb2xpY2lOVjQ5ekJsd1FhZGZYaVV2M3FZ?=
 =?utf-8?B?Ri8yTi82aTk3WDVTa05XNWFUQkhwL2dDSzlHaSt3MXkxN21rckVjSzVWZ2xR?=
 =?utf-8?B?a2IwLzdUQkFQYjhsYnRsS3FmaFl1T0p4SDd1cjRjcG1RL21BMkdHNFE1d1d5?=
 =?utf-8?B?ZXQxQytVcGZlWUg1OUZSYTZwQ1o4SFlZT1N2Zm4ybitQdFA4TFNtLzF3NUw2?=
 =?utf-8?B?OWRYYmFpQ201SEdCMVhwdVE0dzVnbzNuMmR6RWlzL0twbWFiWGVJWjJGSURX?=
 =?utf-8?B?aFJRYVBqaGlQSXNEWXBGMFZVQm1EeEsyRXlkdHA1djRXeWs4SGdLTlVBOVVP?=
 =?utf-8?B?S1BZZ0syR25GcXNCZVJkWmtRKzBKZEFqREJoRjU4aVdSem9JeGFXMEprd2Z5?=
 =?utf-8?B?WGZVTzV3RUpKOHZNNXVQbDVrN2ZJbWRNRHcvd25mbGFFdDYvVEt6WkFPTEwy?=
 =?utf-8?B?THdITnBGeFc5dGFRby9XdVFmbHpLQlZ6Y1Vtak9QTkJMYlovN1huMXdpSkVQ?=
 =?utf-8?B?dFYyUmJLMytKWUhSWENmZW5LZi81WVFrTkdFcjg4NjNSMEhJV3VqSndvYVJ6?=
 =?utf-8?B?emxWb2JpVEhibmhJZmFSSUNaaTRGWG14NkhFQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1A4SlN6cU5la0pKbllMeVUzYjBwUlFmMHN0SUVqdE1jdFlURW5hUXVnaDVI?=
 =?utf-8?B?Ly85Wlc4cnFWZzVGbVV2NG96UkI5bVpjckRKTDBkZGNJRzZQZ1RtWktobzVH?=
 =?utf-8?B?a0YzVmRKVFRCTGt3c1VKWW45SDVJMzA0NDMybWx0TXQ3VkV6cGd5c2JWK0dG?=
 =?utf-8?B?YncvV3VDZmFueFZQcG5CUUJVd1JGS0xyeWxJN25qR3hpUE5iMXBWc2xlTW5s?=
 =?utf-8?B?VVMwckVkNk1pZ21zTHJEa0YwaVhFckV5RDlaTlAxZWVMTmlRV3crU0kyUU5F?=
 =?utf-8?B?blp0M3puZFJzOVJtWWNOcGZYWHRXck0yOFRVNnZJMWpKazRHa0RDWTh0T1dG?=
 =?utf-8?B?RWQzeW9ZMDhsaklyUWxxMEtTMGlmOUZhZEQrWkQzUmZjUndGK0NqNHAzQkFk?=
 =?utf-8?B?bXovQkwrWjNOSXRqWUc4WThnRXZSb0RZcjh1a0VlZVdzYXlnWnpVY1lsbVpO?=
 =?utf-8?B?MVhjQ2ZuZTBmclJ5L3lBNGN5OG9sSHhpcWdVdFBxQWFVVnZrTDgvWlVJdXJ0?=
 =?utf-8?B?VXNadW9wVzZ0MnBqK1E3UDAxSmY4c2p3cDVEODRGUndKbnlmdi9JOW1UZWhV?=
 =?utf-8?B?angzYUJYZis5ZG94cmNXeUl1Tmhoa0lmWGFxRmNiZDdSSTNPK1c4bFdHUGRl?=
 =?utf-8?B?RGZXL05XVlJjdUlVSWFuSVVVV0RqVkJWTlBNSml0REJuSDRBSGJ0WSsvTDNP?=
 =?utf-8?B?cWNqYk1OOUk3aE82UUY3UHA2UFdSa05jL0FtYU1VNlFBRG1ubm5XeVJhdjk0?=
 =?utf-8?B?SHVleS9GRkQxcmlTcGMvYjhvQWdkM1ZXNHl2T0FGc2ZSMTN1YmhETFdxdjZT?=
 =?utf-8?B?Snh6VmFjMmNMcW54Q3JmTVQ5amMrYk9DQ1cwTERMeSswdmJqaEs1Nmx3NEpI?=
 =?utf-8?B?ejZNbjJsYXJLNnVqRWRGT0pWZE1aUGZxWXZHT3NhSlk4YndmbmNtNFcyWFpX?=
 =?utf-8?B?NzJNQkhxODhwRWZacWd5T3FVMzhvaVRlam85MmNJZW9pV0dUMGg2Mkl0WEF6?=
 =?utf-8?B?eVBnZmw2aDdibzc1dmRPNFJIeFg0Zm5aV3FoY0x5UEVjdXpMQVJtMkRvNDFx?=
 =?utf-8?B?S0FkWmFNeEtkenJJQWgvWEpBR1R6OWozMXNRbVJtMmFaR0lHRmlOZXZkb3Bn?=
 =?utf-8?B?b3NRYTFrQ2FBbWpPT1BnTlZGS1h0aUt1ckU3dVQ3VW1zNXExeW5idHM3MFFk?=
 =?utf-8?B?dGR5RnJ5N0h3MlQ5NXNxbzVvSnVQemdNMXBLSmszdTVMSElINHVMb0oxUlVP?=
 =?utf-8?B?blQwN1JOQmh3RGNGdGpJRm0zSWRpR0JBRWlrSFpSN2IzVkpCNzczWE95bk4v?=
 =?utf-8?B?RGc3ajNYMUxMTktJSlVBUWE3bXI1UlRnSG9FdjNENGZVQmtjcW0reVRIVzVT?=
 =?utf-8?B?S1F4Q2cwc3ZNRlBHTzVHa3NHRXZ5U2wzYUF5U2EyaUhHT2NiR2d2Z1B6NHZz?=
 =?utf-8?B?Uy90NEttRDhCKzUyek1sMWcyWXlUb2UydXRIK0JORmFiZ3VxdEZVL1h3T0dD?=
 =?utf-8?B?aDV6YXJYZHFtS0hmbEcrMGYzMzJ4ZUphekxjM3E2a3o2dHpmSzBzWHMwQ1Vv?=
 =?utf-8?B?K1RYVG1TWjlINGEyVVJkSC9iUXZoc0xTMVljUHVrcENZLzdhU28ya3lINjZz?=
 =?utf-8?B?YW5YRkRCSElyZTlzSWJHSFVrWHNGMDNBV0R0YXJoME0ybXFjSWt0K2Vwd3BK?=
 =?utf-8?B?bkFSMTB6L0dFaXpjSTZBc0lCN25uTXJuZ0VjMkUvdURkSHFMZ05yRWdLK2dJ?=
 =?utf-8?B?cGFITEd4WkVCWmtSU0NnYUlnU1UwaXdoT1hKWjZNZXMyTG9GYmNJS1FFZnVN?=
 =?utf-8?B?cDBSQlpjbWtlQjJGTzcwdkF2RWJ1QmhSeWpCR0VXOUdTa3A0UFlMck1GaFBr?=
 =?utf-8?B?T0dML3hJQ1p1dGxvbDV2cTBXQ0pjT0cxUnpRT0s4MWFDN0Q2OVBwVkc5S2E5?=
 =?utf-8?B?UmRBbThDanY1cDRBMVlMTHFXVnd1SlIzRUZ5d0xOUkhBbi9YeFZyYW5NS0Qz?=
 =?utf-8?B?bzlNYVRrc1VoYzdEVEx3MmJvT3FNQUROVVNIVXBlNHNvNTlNckR0aUxPWlhm?=
 =?utf-8?B?aEd1YWVJblRiZUdOM0lWb1lNcGFFc2RocUpxR2l1THJNL1lpMVh2N2toZXJH?=
 =?utf-8?Q?QY6I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea313ff-9785-4e7e-3a47-08de17213475
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:27:31.5895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUndKoMWc6uzGUzuyi8n8WszGgwZA17hfATEEfIA/bS3dIpxyKeLG+LbGz5nFffPNO9fMWpC42J6BVn7QTJn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

update iio binding to remove interrupts from required list.
update imx8qxp-mek to support all sensors under i2c1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      dt-bindings: iio: imu: mpu6050: remove interrupts from required list
      arm64: dts: imx8qxp-mek: Add sensors under i2c1 bus

 .../bindings/iio/imu/invensense,mpu6050.yaml       |  1 -
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      | 32 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
---
base-commit: faae091652fd52f662e1fbc6b9d922b3d6e33641
change-id: 20251029-qxp_sensor-861ef25c4149

Best regards,
--
Frank Li <Frank.Li@nxp.com>


