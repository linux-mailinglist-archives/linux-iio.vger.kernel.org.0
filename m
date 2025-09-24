Return-Path: <linux-iio+bounces-24413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892FDB9A404
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E016E1B24F9F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3413093D2;
	Wed, 24 Sep 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EEiAHZAZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1296307AEC;
	Wed, 24 Sep 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724226; cv=fail; b=s8V4havOS7DuPslVZ8JVR4BIHn7DFygiOmqymoM2C0LgjlOswcARgvRPN1Nm6WdDOKLp2A8LJXE24jVlSOCDR91f0QaDwEO2c1l8m8NBeJgbTucS/0bxcx7llOTXdSGJS2Jochrw37DzIKIithj+IUvK9+am7Z50JVqKjHBlOdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724226; c=relaxed/simple;
	bh=OjoP8Sp6ijkJ8fzGp62HLbt2aHEx3CTOdBmLmD+3Fes=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IN7ec4Jdl6DlsZ+H65GRFZVwZe1LWWoLYvdSCVgjxgAuu/CD5ogaaHNfQJlZ6gP10fQYCzMHPsiFSwaPn7FgJgsWyozg7qE8oUN13M7smKbrElgfefUGVr4YlN3C4TZSEinZ9OAd1SgjSxc1RsCHsbPBKqqX9hCkh3G5OpM0tTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EEiAHZAZ; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFk0sk8/86PN8EvuYZmPuZr9LLys546GMlUm6zH8dXYsQER353G6rspbC0wfB/mmHlrC3PpG1kOYTCG7cjBvERnyXxK0idWesYA2B/mItl6ym1jIn6G9rPILaIwtrbe5M3s5y22offo12jFKgSJyiOFFm5GmPCzUA6a5SkKxoPpZSMRLg4Z+Xf5m8uPTg143aqL4Anxv9lJDB5Iphk9dIoEIaZ5BXewaA3jeMsPZUlQFtBrEVtDqNl11reMrPVrBfXtlAYDnunyMt1kD15FiGRPSebPI+AQf++k1rOHSh7n0sPhR0HOcvmZSPZIIDHlkmuzieb0G2eF6Dl1dgwqIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw26dRNm2i3TipfIkLNWnnVfjwIsSRLVUaIIImr5vVA=;
 b=Whwc35+uHARCD3x+9RfAZj6Rnbk1LVzSDOzw6ZCSmzl6vhiqVVkhMaS7filNEnqOhFs9+/OqA12gkU9XinCjunOtt1vn5yYRhA7r2/ZbpH3XNLXF2svlv3wd0dDuaYDsjlTX9/dziokObz45sia5Xo1JiaKGoVAxlq02q/VbIcw1Gab1PhNMbaev7jOaKECw/gzHlaMeZTuUPXdhtYFgT4qKYTpoSg2troPSmYu87EkCVIx4n8Ix9Yw4QKMwP34CjH3D+Ue0UHRxO85biigwChVYSIvTK3ynEEeQQmNFKcETai7B5b9F76eQes2unXb98gHUDSaZQZfZsEWcOCf68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw26dRNm2i3TipfIkLNWnnVfjwIsSRLVUaIIImr5vVA=;
 b=EEiAHZAZyrOksqwu0o+TnSHnxGAa8lWb5RQhTRYZMcvtwQKAukSVif7aWBSkXoNgHjiDf0F8FEjeqD3IuDuui184yCrd4aCh9xCwvM06Asc8QaTa7xUVJjklSEOV7msfKbbbxd3+eknJzaGbibHZjxdgmh4VWCzOT/tNXx8nTxDONiXbkABAwckwKeQFHydwMrC7lepGAqG5ph9efX8+O+cvAeHsiisMag42df55129a9Y2j2FiDjjd5E50NbTFf1JU5/WPN+8+txWxaFVa4/WOLF3SiITeh/ZoBmhKtu0QdmNM7aVUQ79yg0KQBYjN2AhoOZ+rBMZikePODlRXPHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI2PR04MB10192.eurprd04.prod.outlook.com (2603:10a6:800:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Wed, 24 Sep
 2025 14:30:20 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:30:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Sep 2025 10:30:03 -0400
Subject: [PATCH v2 2/4] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-i3c_ddr-v2-2-682a0eb32572@nxp.com>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
In-Reply-To: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758724211; l=8912;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OjoP8Sp6ijkJ8fzGp62HLbt2aHEx3CTOdBmLmD+3Fes=;
 b=a74RSIdVxHxGBLVh1jWJiWmhNJzX3oAci56MN/csOnYnNZjn9qa8R2kGPEunpWFAjCOX4ooU+
 /scl6AMjagrB7M6pwVlZXr1Yx7avzaZQQpNEXlFerLUOpjFTVvhsqkz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI2PR04MB10192:EE_
X-MS-Office365-Filtering-Correlation-Id: da4a66e3-1d36-48bf-3e29-08ddfb76e3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wngya1pXMUZ3Q0JzNndkYmFqR3hOOXhBOHgzSXFpWkVUcXdGQmlHMUxkcHdP?=
 =?utf-8?B?bDRzU3k1eU5YQzgwVWFIQXBreDhrQUs2R1Jaa0RrZXhZUkUzYVZxMmttampW?=
 =?utf-8?B?a3ZMT21DS1laMUpQOHBIdzFLSTZoT3FhdS9VY1RSRG0zR3hBdDJnN0p5M2N4?=
 =?utf-8?B?M0dvR3dZRzRrM0xMRXNVaGFXbnhzckNNb2YxYTBrdzZOcm81d1FhczROb2Ew?=
 =?utf-8?B?dW5PTlBuNVNiMmYzWTlJcVgrL0l0eFpmaWlySENrRzFzbGFSK3NKVDIweUNj?=
 =?utf-8?B?LzZka2I5TWd6S0s5WDg4NktKVkNiQXl4NCtNUUNUZEtaRzVSdHJ2Z1NOYTJB?=
 =?utf-8?B?Tnprc3RubzExbkFzUzRTOEJwM3NFSFFab1huWFJaaFNYSzZPWm5LRytJZGFC?=
 =?utf-8?B?ZktaOHpTb285akhKaHREYldBQ2tkMXBGdk5FU2lOeVlOUEoxWW1RWWp2VlRZ?=
 =?utf-8?B?VWVnOHRtWkZVVnJTUVFzNmI2bitvSzJMZ2pXanJGWmhrMjBPa1EweHZ6elpZ?=
 =?utf-8?B?SDhFaEFGTlpjYWFjNnJaeXRWR0lLVkUxempxZXRpaG9KSGpHRW9BVnluT1M3?=
 =?utf-8?B?cjRzS2dWamFIQ0VHdG00UEFZQngrandqUnBlUm5HMXZtbitFWWwrWittYXRJ?=
 =?utf-8?B?c3pnY0lnUUFlL21JVHdHZ3pmamFPdUFKZHQ4YlViSGV2N29uMEJIZEFZdmQ1?=
 =?utf-8?B?dkp5a2VLK3BZSlRMOTVJQ0wyUVpWd09yeEwvQzZ4SElCUUErWkJOditQQ1Zu?=
 =?utf-8?B?YUJ1L0xrSkE1RWQ0R2VJNzBzZTlDSGtlSG1ydFpKVWVNci9GZW5LSzJPM0Zv?=
 =?utf-8?B?TFJ1SzdvUlNYbTNLd1U4Yy9nTW9QOUNCUU9XRjhlT1AwUnVOZElWV3AzNFUw?=
 =?utf-8?B?a3E3K0V4REs4RXdBeDFIMzlwUis0VGRWMzlSNzcxdTI1SUdBRTlEbnBOQmlz?=
 =?utf-8?B?Q3JSdjN3OHAvQ0Y3L21tOENJZmI5d2Q1dTRNMlpOdk5icDhteGZRZEZDckxl?=
 =?utf-8?B?WFp6bHNtNVhGUjFnS2luQVprVDQ0WkpsaUZVVE0xSVdWTmR6ZUhJanhJSmVC?=
 =?utf-8?B?bG5ERjRubVJ6UXZoODVEa0grQzNLRThqR0k3TVlCVnNPNXpzS2szQkdqVnFH?=
 =?utf-8?B?ZWRKd1lhbXQ3SU5lSXF0bnNySlp6Vk1QNXJzeDhpQ2F1VEhKMkZxWm9wVVM4?=
 =?utf-8?B?ZXpHOTRLQ0YyL0hXbUNYMXJxMnFNRDZoVDE2UFZwTS9sVGtKNUpFWVphMmxL?=
 =?utf-8?B?cXd6dUxoaWpmOENoZVBsd3FVU0g2K0orb3Y3SEdQdkFBbFRqVGluOUFrTDd6?=
 =?utf-8?B?M096RVllaUxpNGlGS2trb2NvTnJsbkI5aC9RZzN4NHJ3bUt0VkdycUFDcENq?=
 =?utf-8?B?bmJoMkVwZ0MwRUlqeTg2R1RWRDlkY3ZzeHllWjk5VlRvQnNzbXhoMTRWc1dh?=
 =?utf-8?B?ZGNoajZEWW1ScSs0TWQzMk9wWTlGa1B1WXJETERBSWpaakpuRnJ3cENHVDBv?=
 =?utf-8?B?d2MxQmxQM1U1RTFQNllKNzcxY0ttZmlmSkVXUjVKU3NrTC9hVFFybEVMdVFY?=
 =?utf-8?B?cUgxYmdBNWZGSzVhUDZXQlF1cjJtVGNQYlorVlVEL0hsUjhXcG50ODhFc1pC?=
 =?utf-8?B?Tm12TmVHSzZlZmV1UEFVMnBydzVhbWJNTGFrUGdZc0hBd2NkY2FZY1Q5WW5w?=
 =?utf-8?B?eUhBdytudWlSTXdrUlF2YVdTVlpoNVNFWWFFSmdtWnhRRHZ0TkVFZEw0V3Vl?=
 =?utf-8?B?STlFRmZhTEYwRFE5VjhZMms4N3RzNjJQN2REVHlLK0cxTFpybmF1ZjZ4QUJ0?=
 =?utf-8?B?STdLME9NK1VXYzNKb1hBeFFKSmY1akpSaDBlOUhlQk5UWjM2OThmUExlRy9B?=
 =?utf-8?B?ei9aSnErTnorVDRJMnlJTTFZU09YelFmS2NkbFphdGl0cUNtZEg5eUhqaElF?=
 =?utf-8?B?SHEyWjdSZG8waGY4VnhvTVpVVVd0ZGVTaFMzdFhyTGM3czZjeVErbkNlaitF?=
 =?utf-8?B?aGt2bnlyUmFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2l4VkNNcktQYnVMSGVFK3BVMGxUM0NSZGZMKzBKSm5QdHR0VUhwOVJkZVdp?=
 =?utf-8?B?RDBiSHFiTmxhS2dTeE1GMUkwR2RUZWp5aW5MTUVWUVRGOEZaSlk3bk1hTXFi?=
 =?utf-8?B?K1QzVlhKQWF2RDhWSHFkVTh2dlhmdlhLbzVxa2g5SitPZXZGWXplL1dJZnhh?=
 =?utf-8?B?M1J4SjJsQklMeWNaMHBLRVRnZUJpcXlvZHhoSXc3M1hBQ1BUOXRRalQ1TVZN?=
 =?utf-8?B?Vy8vZERtb2hYMCt5NkNLZUJ4WWVHT0NVN29rbW5XMlFRTVlnc1p4S2lPUWZV?=
 =?utf-8?B?TWRUcG53UWVMZVN0V0JDMDdlRnFRb2dvc0xMa3R4Z1AzZ1ljY29odkFCVTRq?=
 =?utf-8?B?TGVSQ2FMSVNXNlE5QUhVODE3ZmprWnZBZ2dKaWNjRXhGQXpGQ2d4N0hOZ3RQ?=
 =?utf-8?B?MHdockU2Vm9JWCthaUFUZks4dnJrRFEzSmtkcWwrZUt2MWZ5UTYzWW9NTlVQ?=
 =?utf-8?B?MGVxa3k5SkhDUXVuWHcrTjJhUnZ0cXRaNzhEcmk1SGxuVWNJQTg0MUpScmdt?=
 =?utf-8?B?UlZacmxmdWhqYmF3aDk3SWRuckYyRkgrRnJIWHJHQVN4Szk4ZEIwNVo3WE9Q?=
 =?utf-8?B?ZmZySW4yMFdvS2xJZ2U1ZWMvZ09KQ0dHaDRyWVZmYzRNWHBKYVU2UDFMUXdB?=
 =?utf-8?B?dEVkSStOMTB2cW5WMWhwRy9WU2prNWtDSG1aQ1JHU2d0c3JqK2JpNWRzcWwv?=
 =?utf-8?B?akVKOEcyVS9vZXA4OUVabVdPVGxSRG1Wd2FsZXNXQVNhV3M1dDMrZjZVNFJh?=
 =?utf-8?B?MGdPMkJFUEs3aXAvc3FVSjc5cE4yaDRUQnlpbFcraFBuNnBobmM5YzVGR2Zo?=
 =?utf-8?B?T2NkVlQvbG9YMHZHQ25EMDBBb1FuYTBWRjRpMVpnUnVWZnRvNmZxVWQ0b1R5?=
 =?utf-8?B?RkRkbDF0WnJBTEtFbmtFNmdnNTk0ZDVTVDVaYk11anlwZWlqUFpWbytmTXFz?=
 =?utf-8?B?ZDh1MGNmQktQUklXRXpwSHB3MnNERmgrcnZwMWl2eExnblV6dEpZVXRPUkJG?=
 =?utf-8?B?T0NUN1FXb0RPWGVZWXloUWZabENrWkx4OFp5UGtJdGtmbWRmanB3ditMdUM4?=
 =?utf-8?B?ZDh4L2cwYU5rOTByME41dmw0c0xqMmRDUHNSK2NkQUlmR3E4aE05WGxTSURC?=
 =?utf-8?B?VWplVjg5VGRlMFArczUyTVgyK3phdUZaZSt5SUJqaFhBTFlEemRsZ1gzdU01?=
 =?utf-8?B?NlZ2elREM0JoTzZaL091UlRjUjB6REZsaVBaZlFVQ24rNUlJZnlWTzZaOWhF?=
 =?utf-8?B?MG82dkc4RmY3M0Y5VVpXZlhRcmZzWnlzVVN0MGZPN0ZxdFgrUGgva25MUU1R?=
 =?utf-8?B?QzFPOEFCVkFwVDZlY3htNTh3azM3eFZtcndqNmx3SnY5emptVWV5dTljSkJn?=
 =?utf-8?B?YlYyS052aUxnVHdIM3NDNiswSGY4blloUXBWQjdITW9QUVV2OE9HbFZvbXlh?=
 =?utf-8?B?TkdqRkVLR1A5eXo3U3FjRzROOU5DdXJFb0t1KzRsMkVQaWxZTE9WZVc2MEk1?=
 =?utf-8?B?RGpTdURiYVZmRFlTZit5SVhWckdla2txUnJuM3gwTUJpcUlSREdNamlXaUty?=
 =?utf-8?B?Q0dUV1hMWnA5S0lmSjhHU3VJWUFkdlBTSENIU004eXo2WVQrVkQ0NENXVXl5?=
 =?utf-8?B?cXUxSk1mVEhOTjhSTUNIY29WbVZPbUhRSGdUNFVaZmpNS0p0OG5OVTlpYklJ?=
 =?utf-8?B?ZkdDTHVJZmJHdnFLRk1uY3FiRWdVUzRnL1RvUE4yV2hST2xKNmFQYjlUL2Jl?=
 =?utf-8?B?dnlJVTBaWERXNS9kdTcvbkJFaWVwS0hHRnkwN0g0TEI4UFBXelJyODg4aGgy?=
 =?utf-8?B?Nlg1SThhUUMzTnNDQXRVRTNPTEs4VFByVWt3OFV4dHV0TlBrelBsZ0RQZkpJ?=
 =?utf-8?B?cUhPWU9ydldxSnRHWkpwVXU1WmgvUmc0d1ZtMEJqeHNnQ2NnM3BRU3ZWRzh3?=
 =?utf-8?B?NkkzUldNejFzUkNmdVh5K3BaZGQ4ekZpYTVwQjkrRmlPeThLMTVTZVZ2ZzZ4?=
 =?utf-8?B?RUU2NjhMY3BIeng3OGlqdW84b3R3eHplNmhISVhQMHJ0WVhPZ054NmNObkti?=
 =?utf-8?B?djh0OUc4UmsrSTRteEpxUGozTHlqejF4REI1cVdrK3ErdTQwY0dWbDk0QVkr?=
 =?utf-8?Q?q18c1/ZZnRq4xOzKN1LPr2Rco?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4a66e3-1d36-48bf-3e29-08ddfb76e3e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:30:20.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U0SluPGHapfWdtVT5WJATT73Vh8cm9nAtIIVkVkrAYmEqqmZBg/tXbZLWXXsH+VZK2dSlopqGAtWijMAmcXAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10192

Add basic HDR mode support for the svs I3C master driver.

Only support for private transfers and does not support sending CCC
commands in HDR mode.

Key differences:
- HDR uses commands (0x00-0x7F for write, 0x80-0xFF for read) to
distinguish transfer direction.
- HDR read/write commands must be written to FIFO before issuing the I3C
address command. The hardware automatically sends the standard CCC command
to enter HDR mode.
- HDR exit pattern must be sent instead of send a stop after transfer
completion.
- Read/write data size must be an even number.

Co-developed-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- support HDR DDR write
- rdterm unit is byte, not words (RM is wrong).
---
 drivers/i3c/master/svc-i3c-master.c | 95 +++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 701ae165b25b7991360f3a862b34cc1870a9a2ba..3885edea90db4c943a5f13ec4a291ed15cf9decb 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -40,11 +40,13 @@
 #define   SVC_I3C_MCTRL_REQUEST_NONE 0
 #define   SVC_I3C_MCTRL_REQUEST_START_ADDR 1
 #define   SVC_I3C_MCTRL_REQUEST_STOP 2
+#define   SVC_I3C_MCTRL_REQUEST_FORCE_EXIT 6
 #define   SVC_I3C_MCTRL_REQUEST_IBI_ACKNACK 3
 #define   SVC_I3C_MCTRL_REQUEST_PROC_DAA 4
 #define   SVC_I3C_MCTRL_REQUEST_AUTO_IBI 7
 #define   SVC_I3C_MCTRL_TYPE_I3C 0
 #define   SVC_I3C_MCTRL_TYPE_I2C BIT(4)
+#define   SVC_I3C_MCTRL_TYPE_DDR BIT(5)
 #define   SVC_I3C_MCTRL_IBIRESP_AUTO 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITHOUT_BYTE 0
 #define   SVC_I3C_MCTRL_IBIRESP_ACK_WITH_BYTE BIT(7)
@@ -95,6 +97,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_CRC	BIT(10)
 #define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
@@ -165,7 +168,7 @@
 
 struct svc_i3c_cmd {
 	u8 addr;
-	bool rnw;
+	u8 rnw;
 	u8 *in;
 	const void *out;
 	unsigned int len;
@@ -383,6 +386,21 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 	return master->descs[i];
 }
 
+static bool svc_is_read(u8 rnw_cmd, u32 type)
+{
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg = 0;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+	udelay(1);
+}
+
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 {
 	writel(SVC_I3C_MCTRL_REQUEST_STOP, master->regs + SVC_I3C_MCTRL);
@@ -1272,7 +1290,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 }
 
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
-			       bool rnw, unsigned int xfer_type, u8 addr,
+			       u8 rnw, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued, bool repeat_start)
 {
@@ -1283,12 +1301,22 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw, master->regs + SVC_I3C_MWDATAB);
+		if (!svc_is_read(rnw, xfer_type)) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+		if (ret)
+			goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
 		       xfer_type |
 		       SVC_I3C_MCTRL_IBIRESP_NACK |
-		       SVC_I3C_MCTRL_DIR(rnw) |
+		       SVC_I3C_MCTRL_DIR(svc_is_read(rnw, xfer_type)) |
 		       SVC_I3C_MCTRL_ADDR(addr) |
 		       SVC_I3C_MCTRL_RDTERM(*actual_len),
 		       master->regs + SVC_I3C_MCTRL);
@@ -1373,15 +1401,14 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			break;
 		}
 	}
-
-	if (rnw)
+	if (svc_is_read(rnw, xfer_type))
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
 
-	if (rnw)
+	if (svc_is_read(rnw, xfer_type))
 		*actual_len = ret;
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1389,10 +1416,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (ret)
 		goto emit_stop;
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR &&
+	    (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_CRC)) {
+		ret = -ENXIO;
+		goto emit_stop;
+	}
+
 	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
 
 	if (!continued) {
-		svc_i3c_master_emit_stop(master);
+		if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+			svc_i3c_master_emit_stop(master);
+		else
+			svc_i3c_master_emit_force_exit(master);
 
 		/* Wait idle if stop is sent. */
 		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1402,7 +1438,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	return 0;
 
 emit_stop:
-	svc_i3c_master_emit_stop(master);
+	if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
+		svc_i3c_master_emit_stop(master);
+	else
+		svc_i3c_master_emit_force_exit(master);
+
 	svc_i3c_master_clear_merrwarn(master);
 	svc_i3c_master_flush_fifo(master);
 
@@ -1449,6 +1489,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
 
+static int mode_to_type(enum i3c_hdr_mode mode)
+{
+	return (mode == I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_TYPE_DDR;
+}
+
 static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 {
 	struct svc_i3c_xfer *xfer = master->xferqueue.cur;
@@ -1638,9 +1683,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
+				    int nxfers, enum i3c_hdr_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1648,22 +1692,33 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct svc_i3c_xfer *xfer;
 	int ret, i;
 
+	if (mode != I3C_SDR) {
+		/*
+		 * Only support data size less than FIFO SIZE when use DDR mode.
+		 * First entry is cmd in FIFO, so actual available FIFO for data
+		 * is SVC_I3C_FIFO_SIZE - 2 since DDR only support even length.
+		 */
+		for (i = 0; i < nxfers; i++)
+			if (xfers[i].len > SVC_I3C_FIFO_SIZE - 2)
+				return -EINVAL;
+	}
+
 	xfer = svc_i3c_master_alloc_xfer(master, nxfers);
 	if (!xfer)
 		return -ENOMEM;
 
-	xfer->type = SVC_I3C_MCTRL_TYPE_I3C;
+	xfer->type = mode_to_type(mode);
 
 	for (i = 0; i < nxfers; i++) {
+		u8 rnw_cmd = (mode == I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
-
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = xfers[i].rnw;
-		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
+		cmd->rnw = rnw_cmd;
+		cmd->in = svc_is_read(rnw_cmd, mode_to_type(mode)) ? xfers[i].data.in : NULL;
+		cmd->out = svc_is_read(rnw_cmd, mode_to_type(mode)) ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = svc_is_read(rnw_cmd, mode_to_type(mode)) ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 
@@ -1858,7 +1913,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.do_daa = svc_i3c_master_do_daa,
 	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
-	.priv_xfers = svc_i3c_master_priv_xfers,
+	.i3c_xfers = svc_i3c_master_i3c_xfers,
 	.i2c_xfers = svc_i3c_master_i2c_xfers,
 	.request_ibi = svc_i3c_master_request_ibi,
 	.free_ibi = svc_i3c_master_free_ibi,
@@ -1947,6 +2002,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	svc_i3c_master_reset(master);
 
+	master->base.mode_mask = BIT(I3C_SDR) | BIT(I3C_HDR_DDR);
+
 	/* Register the master */
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &svc_i3c_master_ops, false);

-- 
2.34.1


