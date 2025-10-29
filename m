Return-Path: <linux-iio+bounces-25632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C831CC1D00F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 20:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E4188A179
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868003590DB;
	Wed, 29 Oct 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="leV89E7J"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA893587C9;
	Wed, 29 Oct 2025 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766062; cv=fail; b=KiPA9YUsPvHof54vod9sKgBjgvF2tLpRMjzVqsAkbFogMHJT1L7u1/QQMS0LwMauA+VvQmW2+BLm9CSD57k6xRqQLKi96M40yrttfNGqGp7SUe/ynxhq2rWzR5h1JxMMa5xInq+2Xt9itXz4ismUCbyRia6KZn2LSULKAaVjk4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766062; c=relaxed/simple;
	bh=2QS2hbZkSp1Ag6CddhkAu1Izvaxw/Em1zVickeEVDAU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P+Je8vYULuSLfY3CGTtv7c0ep64BDHdGMYTDqLJ+3e9OoozjMcjWiMhpr/sCSl9SMjN19nKjwp0wi9H4GAKCAqHet141fAsExhQvY+x1aneFbl/opcvYUetRLp3ufALvISvp7DO05c3tJmObFTeCzwdYtEZXEeJBUjKKy7YQQa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=leV89E7J; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcV0/0Mhaf/1tAueTf3bhxP7HmIvIRvQRUHR8rF8DmU75qzci2myg7n1XfGBb/7+iBqDopO3Tp2885l3HNIZVnZj8DFRlqV5YmwvM9tephiA6+BfERAolhFOghuFOKkEfWoBscJ/7HIboBfT15u8SALhtGa/LMu0wX7gQ65dxyQugxzVjqTsu6AX9puQACsvYSjZ1X2BonQB3hlN4qiJpxl0aT8kfi6egcQtAtgaL1r3cFyMTKz0seae9puWvTYDnsbP1ZeBv3n7nFGeKNbwDRn3n9uVTfgNZZ/LbaN1psNK8m/g0LVDUU0M7kQ7ucagJD6etrw68aNhzl36EBYkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9Z42TAwi8cM9zoMWGsDWsRDDbyVnauX97QOWf8JTN0=;
 b=tvX80+trR/BUrCwiMcXH8oBBD2Uxvznm4fuJ4+HIn5s8/V0tqnrmtmKpDXumk/PlCxRqwy53gkHIbHMONRkrcPP1qXcfnKpcsiCDvKL/U+XGRMS7ujxIyKrP+2sQeHuIbtSyyj/rfXN7p964R+Oorhn7TgBoaQE5p4XXKdNx8x+m1ftPMcb6+8wo0qF181db0G1r6VIcczwclF7Isg/QswFyEgDC8kFmNKAJCwwnMeUChaCahIUjLX1DdjPfIh++R4ePoAdjgia5pDm94/C7yr74hwG9gyVCIlsb+oBOJvEkkpBslXMRpVSqsuAdsT4G2pOnYIFYSeyWkFI3sB9U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9Z42TAwi8cM9zoMWGsDWsRDDbyVnauX97QOWf8JTN0=;
 b=leV89E7JomR6tCaRVAke/ywo9wFT49hzRTCSLTwilk3IY5zW5yG9lWhCRgeM9a9WKqt22hH+3XCCDmVj0rL+Hf11yNNAecSJ/TyfBmG4tTeEWEfpoXH3/DNk/aenZHZrQUVfnfWA5uuNrSYzddQ18UNoV5x2501+hdqhccRmE0V7Azd9pvF/juF6qbFtmd1A12NK/zuzxs8mNlmDgcrWjL/l9/wafl+cqjOoBkVuqrLPvkwsu8pQAYuQ1xRWN1ev0rh940qp8q99/PYvY4ApLnB4WH78wfdptjrOyO0QKVQ6eJp1Oou35b9dbCcCFkAYQ2SDsW2xFsu4vXt1Xh4U1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 19:27:35 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:27:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:27:18 -0400
Subject: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: remove interrupts from
 required list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qxp_sensor-v1-1-e97ee1de96d8@nxp.com>
References: <20251029-qxp_sensor-v1-0-e97ee1de96d8@nxp.com>
In-Reply-To: <20251029-qxp_sensor-v1-0-e97ee1de96d8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761766047; l=808;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2QS2hbZkSp1Ag6CddhkAu1Izvaxw/Em1zVickeEVDAU=;
 b=bn2Fi27F30wwl48rsqfU+pH7NcOc/C9G8NQMfnrRafKub2DmHc9jDCX/pQXti95MAFBB+bE+R
 IjCaL5/xW0AAHK4XgAC5WlCyBvvqW7Ctvz/buf+F+ylWzsBJ+FnzfyF
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
X-MS-Office365-Filtering-Correlation-Id: 63090713-e6f8-4553-5e46-08de172136b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFFSUnR4d3RlTHd4TFZMSXo4WVJRT2Q5K1h0TDBjMElqQ1hxTElLbGRBOG5I?=
 =?utf-8?B?N09QZkIvdDh6VGdzZ3hVQnRpTTJldmdCMEF3OXpzZzVOS2VJZU0ybVdTSnRn?=
 =?utf-8?B?bFdTTWVQUElCb1JjNEZJS2FiSlBZTkZmSGJiR0d4cmhqRkJuQ2N0VG42ejVv?=
 =?utf-8?B?eVpCKzg4RUNROVZEa0xUMDlkZXJwaFlLTC9jN3JFYXVJelFBZE9DeU5Xa0dt?=
 =?utf-8?B?QytLYURtZjR3K0x2aFlCWkdPczZ1K1hVbktTcG1EbmphbFRCQmkyaHlaUGR3?=
 =?utf-8?B?a0U2a2xNTEM4eVlJdnhDcHFpWnpTZE9wVkpDZG5TczBWZ0JPVmoxQ2lwT0l4?=
 =?utf-8?B?NGtFeGJ6bnpBWUswNm1mVXhCZk9PS2ozN0VISnI2SGtJUE1HT1FSSE04a0Yw?=
 =?utf-8?B?R2lkajVUdHQ1QVh5Rk9pS3R2Tkdkalp6dy9sc3JrZThFc0dLNXdFWmI2aFpF?=
 =?utf-8?B?VWRFck1UZGswZGhrTlV0ZGhKTmFRbFBqWEdOUE9HU0FqeGdUK0V2SlhQT2Vl?=
 =?utf-8?B?ZkRtSmdQeXdiZzIrTnVnWXFnNVMyM1dSSmI5bzdLV0RMMmd0ZHVtYk5SYWRW?=
 =?utf-8?B?SUpuQm9HZGpqdHdWVkp5RjdMTDJGclA1NUlXVi8rNzBxU0NBWnJpMnRzQUc1?=
 =?utf-8?B?TUtQZFM4YnY3QXkvV0tFNDRlWlpzZTlYb3JGNDVXaCt6bDVoVWRkd09nY1Vt?=
 =?utf-8?B?QVJNT2wwL2Iyb21hQzRzU1lIaGczR3F5SEpDZzVzZDJkOHN2Z3c0UDZUc1hI?=
 =?utf-8?B?RFBKL0hFb0grb2RnN242alFFTnU4SCtUS3JzOFZnbGFEdS9UMzZKVlp0Y3ho?=
 =?utf-8?B?eWMrLzJvMVRDcWZnRnR2QVNQVVRpWDJsOUdpdzVBSEUwZDY0UTgvVUVtcm1C?=
 =?utf-8?B?ak5EUHdZb2NtaU5CeG1ld3ZvcXZQZ291Zkl2bHVSbnlrOEp2bDdjb0hJcEVs?=
 =?utf-8?B?RU9UYzVuMlBIc3JhcGlNMUxOVlBpQVJEUEZvYXkzelRFT0luL25sR2JSbjAx?=
 =?utf-8?B?ZGxUR1BBTkovdW1HTDNKbC9GT25RUG9lOFZvSlQ3TGMxOVJlVzNtOGNzakVa?=
 =?utf-8?B?aXhMYnZIMDZteXRjeXlLUTFYS2NiWWlMVzgyRWhFaFZrQjgzcEt3YTJJQUJF?=
 =?utf-8?B?YjJoWVNib3Z3cHpSRWVIazVsaFNidjFDTWszYjVBMW0wMVQ1dWZNQnlkYit5?=
 =?utf-8?B?TEhoY1E1UjFvSm5xSjYwYzhyUkNCTlphNTN2dEUyckE5RXFadHYyTHg5OXJI?=
 =?utf-8?B?Wkk2UTljTTR1U01nTWthU2xzMHcrYk1jOStadEJtYk5HNnBzVkpNOW1VdSt1?=
 =?utf-8?B?ZVY5THNVejhTVzR6ZUdSVnJ3bnhuKzJwaUdYZXplVlZwY3NEeGlUZVR4bG5n?=
 =?utf-8?B?K2hETW1TODgrSkR6K1FvQWVCeWw4TkVocW5lVFpGNlhQSjVzellsMWpuOHor?=
 =?utf-8?B?RmdWWG5ZVlJ1YTZXaWFvZGsxMFVyQjRCVUQzci9PdURwdmNubkFSTEg3VE9V?=
 =?utf-8?B?Wlo5THVNR3pWTll2WkR2c0J0RERlOHc1aUpJaEkxMmpJcGRFYjZmQmpGanVo?=
 =?utf-8?B?OGpsSVNuMnBqMENzQnlqdnNmdlZkVFM1NkYxaEpFM1loajhscnQ2WWFxaVBv?=
 =?utf-8?B?czJLZXk4anA5bm1PeWFwOFFOeGtiZ0F6UlZMaXhnaUE3TFJXTWQrUlhtMFJL?=
 =?utf-8?B?aFY1czBTNE55OHlUSUVPcEVYNVhZYlprRDdOeW04VWY3aTVHV2ljdFRUcmVn?=
 =?utf-8?B?SlBkWDR2RmlYVGhlQXRHYzFGTHVWV3hEZ2RNL2R6S0RuOHAwcHprQ3JzWVNM?=
 =?utf-8?B?b2w5a1psSk1iSS90WWltc2ZXeHdLTGJaVEgxejhJV25QbHpkcjB3NVQ4Wmcr?=
 =?utf-8?B?dEFyc1kxM3VxNXVVSnJicEp2cFFDVkZoZE1wb1lBTmlPanNoZzZqOE9kV0hQ?=
 =?utf-8?B?VUNkMi9UNW5naC9UbTlLV3BVRmZ6LzlLdzN1UThZVFlEdmZETEtOUVdpYjVJ?=
 =?utf-8?B?QXdLUUFCTzdVdkJMU0hMSFhjTkhNNVdWM29LdWdqdGJ4bGg1OTFmcUU4cXJY?=
 =?utf-8?B?WnhQTkhvc2RKNDJUVkZ0Nyt2eGJkNDJhbzVudz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0h0SlhMdHE3NzFKR2oyYko5YVdBTE0rdXRMV05YVzN4MEorNU5rYThlS0Z5?=
 =?utf-8?B?U3ZTTVl2cmFsazI1SmJzV1RGU3NqT05YVmVLSzl0bStLTU5TZHVSR2MwTzNZ?=
 =?utf-8?B?Vm5qOWJsUjE4MWI2YUxGblAwK0pzTy9za0xmNVJLOVRnd1RPaWs3Y3BOS0NV?=
 =?utf-8?B?QVl2eUVUV1hnMEFZYlMxWUNyc3JUUVFYdzNyTnVWbEZwZ0pBU0pJVi9oUjBY?=
 =?utf-8?B?WUFoek80N2N2RnVGQjZLd1JIdFAzY1VlQ1B0RzNNV3ZtTkR0akV5Z0xYdWpP?=
 =?utf-8?B?cnphSzVFcm8renFFeVpHSThrakFxK3lUWWR0T0hDSVpqSGhyV29JYk9XaEVV?=
 =?utf-8?B?eEQ2UEtQdmI5WE9lelZ6azNjSUp1eDRkQzR6T3p0c3dwcC9rWGxwSGJEQTND?=
 =?utf-8?B?MHJubk9CdkZsZ01NR2FWQU9TRzF0YXl0Y1EzVGx3aFgyam01RTJuSjlLcWpn?=
 =?utf-8?B?bysyS01SejN5N2RvcUEzbEFjbTBPam9iSXQvNVpHQy9zZ2s2L1VPUEVlZkwx?=
 =?utf-8?B?eWdraUE3UTNUMUFqSkVOUXMxWG9YeEhHQUNjaGl2VzAwdXdwdEgwT2dsSHhU?=
 =?utf-8?B?WkRZRWtINnY3a0RZakV0ME1nc1o1RW9vL2dBZEVaT0xES1NWQzFQNjRPTkxU?=
 =?utf-8?B?NzN2Rkh4THN0T0VBZWdjWlBodVFRUDFWRjBaajVMTXVNcXhsYjRUUGxKZ0RF?=
 =?utf-8?B?TVRBVS9QY0F4OXZzcGxGcGpxSkkrTEQxVDVha0plTm9SLzh1aUYzTW5hWWRL?=
 =?utf-8?B?V0tFclFuV0FqYXhkc2NuYUFkcjdDYkZMRlY0UUlhMWc0NWtBQ2lEN0dKdW9H?=
 =?utf-8?B?WDBmQ1lUMmNiTTVRdFZrYmpYWWVDOE52UFMzV0dWSktQNkF1M0c5R3hRVUpr?=
 =?utf-8?B?VWdwZDdWOWFaZk5pNk5aaXZHY0V4RG82ZXhRbzErMTBaNlJSWmtxbUtFemtF?=
 =?utf-8?B?eG56cUVlWGNDemhXeml1MS9JcjJyVGpPMThFbTVRazFLdXVEbWt6RjJjWUpi?=
 =?utf-8?B?VjRVc1ZMbUJhdEJvVU04bGdod2pOUkp2ZlBGTGFzSTZCRlpiY3VTUkw4dTV4?=
 =?utf-8?B?Ykl0R0NHY2JBMmxjSUFPMVc1djg5QUdzdUl3blpubmlmc3NnbnhkUmtoMEZO?=
 =?utf-8?B?Szg3R2Rkb0xMS3pjZUh1R1VPekNlang1d3Y3bDVKelN3TWY4dThoZHg3eVE5?=
 =?utf-8?B?UkY3NzlOczdZWVR0S2YzUmZnRHlxRTcvblBzVkVhVlNUNUJCSngzaDVNYStv?=
 =?utf-8?B?b2hCY1ZVcTRhODVqZUdoZU8xTE56THBQZFN1MEIxREhhNUtUeVFXbmtybjNo?=
 =?utf-8?B?NXk0emNIcjU1WVMvME5UWkp1OExBS3JqaUtuaDZkakJiNC9Pck9YT25qMjhm?=
 =?utf-8?B?aVF5U0J5U2pBZ011Mmg5NS96bGtDMVFWOHZlOFNONXVQWnc5VlluOG1ramxt?=
 =?utf-8?B?UUVKNUNEYzFzRXl1SVZmQU8xYTVocjVsR3p6NVpyVHVoYUt6OTFMaW54ZGZW?=
 =?utf-8?B?T09hVjY4WDhXV1ZmSk5tZ2NBNXp0RGhUNmM5aU5YNGlxTDZ1SVB5Y0lTV2xh?=
 =?utf-8?B?V3dEc1hwVkRhVG1WZFMwQTJUVWRic25IdGorQlZsWFpEVXhySDVyOFF6dW9Z?=
 =?utf-8?B?Y1FTaTVUdTBzS1FCOHdtVTVlRW5yK0FlSTF2SzRHRkFablZhVWQ1NVRuYU9C?=
 =?utf-8?B?b21hbFU4T1BuYkYwTkpIMUNLRkxIQW9Rb3V0b3NSb20rZ2ZteDZNNVl1c2sv?=
 =?utf-8?B?eWhkcjVJcXNGQmc4ODBKelEwcHErNHNqZnVUcVFYY0JPUTMwa0N0THc2YmI1?=
 =?utf-8?B?aUk0WGs5Y3Y0Z2QrcW8rbm9XTURpdjAzdnNGQjNWK0RXTmNnZEhIY1dkZG9j?=
 =?utf-8?B?UXh2QUZaZ1ZMZkZVMVZEWThHMjZzUUY4VWJFcEhtYTk3dnVMS2JWOVJJL1NF?=
 =?utf-8?B?cnp6UE04Z3RUblgxL3ZZVVVVMWtiYnhDM3hiSHBkbVAxdmtGR3k1VUJBUGtV?=
 =?utf-8?B?MVMzV05RcFkyNEhRc1NDUVBxZTNGdzZGaTEzQzR0SERvK1V4NlNmQjBKQitj?=
 =?utf-8?B?TzY3ODdhSDNhQzZxT0VOUWRoQnhTY1IxWm5aWUlQenJyYnVUbldzaHRhV1Nj?=
 =?utf-8?Q?ubTA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63090713-e6f8-4553-5e46-08de172136b7
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:27:35.4900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4mKwKIOr/OHHWbghI6zAow01omr3wUyjP2HVONSwyPowYe04Z1ZyMzEfm8Hl9/OBNGi7JNK+2uK9Yzo8tbXyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019

Irq is optional signal to make sensor work. Not all boards connect this
signals, so remove it from required list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
index 0bce71529e34c3040f1101069e2cf22d70c3fcaa..1af0855c33e671c92f6439e7c45ef15787a9f329 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
@@ -86,7 +86,6 @@ unevaluatedProperties: false
 required:
   - compatible
   - reg
-  - interrupts
 
 examples:
   - |

-- 
2.34.1


