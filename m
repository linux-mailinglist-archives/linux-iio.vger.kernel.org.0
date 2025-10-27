Return-Path: <linux-iio+bounces-25540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF3C1155E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 21:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14324505537
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A8322DCB;
	Mon, 27 Oct 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FyXZZ2Vl"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35243320CBE;
	Mon, 27 Oct 2025 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595739; cv=fail; b=brWtFXtEE41nzBgLoTa3gNC+8rgxDXY5eHW+CcuM7Mv8T8nYdD1MG4ySYgCVzvY/AjBHidXPbSv7SBkdyC3pj6hS7TmrBP6tyDCT+RmrytEthJgM/4RlE/r/CbQkvdeWbKo4X43mOBdZMreqRhQ7ImrvTYrp18iBL7wISNzZ//c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595739; c=relaxed/simple;
	bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BBVBv1dZjHz0mjEAGWQNLioCnB5iD/d4G7IwmQLRPbBWx7q3IqyM4R+bymH51jhNbxR6DYRngKgcz5dvsIgmuEzBdu5gnJ+4aG55QKNdMt71am2RRukyLKdNXZ11zN7vP8Fuonho1JkT3o1rIQjuKD6DUEEYitXcEDcmtSlj6Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FyXZZ2Vl; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNQYRrZhSWGfejRULh2Iy49SV7Z3U0WNnId36qdhiLLU7rnFSySdNNBxdfjTYBL7GMlT2mC9DhQEV1hb8AN1TJF5YuQec2WIUo5CpodjgnTaNh097RHU641MDFr0qK1O4cOnikV39KuudGEx2UJsir1YnWjcyQDV/nyd0A+zk2n3/27rGSlV3PMCa5leffUVidKYVhdYz4wX99cTt8i813pUtw16vrq64iTY57tbPay/6ixOG2P7URgJa07y3f+VlF3XSdfa6nPQ160/4Ugh3lUTF7l452awBeaZuqcqarCrKFJ9YmK6FWN+g3I8UrNS/Hkf96qteTHi5uc8sd6OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=ALS0WYEztrcz4BT3TpSO5usZDvDx9cO+8i3nmakQwzEvxyi7E8yaMp3cCVa+didLCjN2Ssxp6iei8x1KOeYwT2HuHQAy90y15Iw9r8LnXQCYTogmOFr/GHYir6kxCeMcm3wEAJ5ARTUwAJwkUQqSeFOY0DklB+2ML5rzYo35jTTnOMRsmds2QLeSYtOkgiN1fVPPblV6Jz/IOb/Y6f5Kx7bQsuS7FvlFeYOoeA6amycLH6Qufn+xxiLL3e8B8FLq61W64Ps6KJBSPiKRabG6F/UH4zSDy1F0ljywFFu/Le8zpiS8yq3PikuoFi1VU2KBwX9txLs719yhJCjGL9EDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=FyXZZ2Vl9lbltxw7j9l+YZ8Ip7uG3NGzH/CIJP/dSaVLvF09TXOQ5DJ1pbAWjlmUNkyVBmRId+kmCn04NWck2SGneCWYxrDhWX72lZpWCzk/PgjZzEJj87ceFPpEF/lQUOwgkH3OqSvlcAS/WotUHhG+qpsSlCXdn+wsYuSpydNuA173g190GzZUbCE2EQbRsjjd0+wXdDEkWoUNz6dJ2YYrShaOKyP4masEJLkgqR29KQF9P/AKfKPEYsamwvZ3/X63ez6s/tdsb9RkmWrv1uocsiIV78s42WNNNI0JT/dLY80ouzo2BcExjkyLwzVfx2lFkwyPtk6uqAB1i3uAhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB11919.eurprd04.prod.outlook.com (2603:10a6:800:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 20:08:53 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:08:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 27 Oct 2025 16:08:30 -0400
Subject: [PATCH v7 2/5] i3c: master: svc: Replace bool rnw with union for
 HDR support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-i3c_ddr-v7-2-866a0ff7fc46@nxp.com>
References: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
In-Reply-To: <20251027-i3c_ddr-v7-0-866a0ff7fc46@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761595722; l=3017;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
 b=AJdhucHA2aQcop/xqbhWKKbEitBxo+mmK4c/kTjQpIXXER+z22qHpz5l7DMixJedoHm3LBMjE
 3FzfkxCXNUWCQnR7VHkMCij7SFKwW//7lzTCPfOwlS5be/T+vPYNWGe
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH1PEPF00013303.namprd07.prod.outlook.com
 (2603:10b6:518:1::12) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB11919:EE_
X-MS-Office365-Filtering-Correlation-Id: a3184dce-637f-4cc7-4349-08de1594a6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVZkbGZ5bk90cDdUTUVXQVBQei9kL2M1SGZ1U0UvNlh6YUhWN1UvNkwwTmdG?=
 =?utf-8?B?MkZhT1ZrbjNLejZlL0s0MW41V2ZtQ3VibmpmNHYrSVRmZklEQmdmYXczQXlL?=
 =?utf-8?B?SnBWVC95bHNTVHp4Zk95R09TSm9QMGtNRHZBdW8yckRQSGNBSVFaQXhNZ0tZ?=
 =?utf-8?B?eGczNTE0Z2N1MUV6RC9DMU1IOGVuTURCbnFiUE9LZW9KWGJEc3Y3cTgwRGU5?=
 =?utf-8?B?K1VOS3RyenZ5MU1jSjdva2thcTc3NGhUVTVTTWx0M3lZOTRZekhsUm5TazZa?=
 =?utf-8?B?WkJ3US8yd0Nrc0xlRXZUL3pOcGx1SG50a2ZJZ3ZsU2QzMk5qTU0rRGhGUnp1?=
 =?utf-8?B?cDRTWDN3YkZNYnQwQnJEMndBL0UrY04zb045cVFHODlPcGpqQlBMeitOUGNp?=
 =?utf-8?B?dkhDMFNLQ2pGU2lwN0IweUhyVEdBQStEWkxjdXRhYzBHdlIxU1dXZ2pkNXJ2?=
 =?utf-8?B?cEd0ZFduSU4vNTJLQUNvSXJ4Q0tmMlVtMk9UamFsQ3lpdTJwdkVWYTJhTEpr?=
 =?utf-8?B?NklKS1hURkt3M01xVG44VHBpeCt3QWd0aW5BV1pmU2ZkcngvVWFyby8xZnNZ?=
 =?utf-8?B?cEo4Nlo4SzFraUJQUTVjNjY3OFdOOHA0TDFsdjIvL2VkUmUyTXYvcFU0dlE2?=
 =?utf-8?B?WEZnekZDeW5IT1k4OFlMVmVsUXJId2hZQUNDQ3BBYytUQnhZWUFyb3FDb1pJ?=
 =?utf-8?B?NWlPSmorTFVOb0ZQcFY5S3M2Vm0yc2RDMkZHOW1DVE1rMGZWSlBmUWJUVkVq?=
 =?utf-8?B?M1BBemN5eHhZUFpUcU9iemtoRW10cVlwUWlXeTlyZ1YxTlIvcjA3MkY0aHFL?=
 =?utf-8?B?L1ZYV0krOFF2NkRSWUJuTWkxdjN3NDZSOVlmVFhMRE5sNlJzM3YxSG1VVGxu?=
 =?utf-8?B?TFJTRjZQeXErem9ac3pkSjJMNWpyNHZKTVhYbkdHSVhyWFc3TFUwTU11U1g2?=
 =?utf-8?B?bTF4R0hMdUNTSkY1Zko3TG9ha2VSalUzTFRmWnQ2QUhPdkJzOFRTUWhYRTZw?=
 =?utf-8?B?anlNRlhBa3R4SVpkOWg4MThqcERTcm1UczcyYUd3YVRFbTFjTXh3L0o5SjRM?=
 =?utf-8?B?RjFnNGw4S2laZkxrZ09jTENjcmVOSlUrYmhKUENGVWdsdWVIdVp4UW5wMjUv?=
 =?utf-8?B?ZkZiOUFpazdEMXF5SUx3OWpubjdDcUxGdWVEci95eXRpdFJyaDNXMm9STmtL?=
 =?utf-8?B?UWFabDJQeE44aVpWWndSK3FHWnRqVTVLcUFjZ01CdnE0NFZ3ZGlnVXlnVDZn?=
 =?utf-8?B?TG1jdWprMENrVVI3ei91WUl4MTROUmdvL1FvTWErR29JOCtablB1b3dDbWx4?=
 =?utf-8?B?R2EzWGlyMUVPOE54S3AwRkx4bERjcllSVThSU1VoR2xXUmgyZFl2NFhvdXhx?=
 =?utf-8?B?UUZUblpBU3JkdlVmeFZoV1FHanRXNzNXUjRxZFdINm1DNmpDclR5TGlYdTJi?=
 =?utf-8?B?U0IyNnBSdlhPbzY5cGFxZk5EbDZlWHp0MU9DMjRTNmVYMVBtdmRZSXliSmZ1?=
 =?utf-8?B?SWR2VXFiWjJIU2ZwRkZwRlQ2cWRwZUM1d0drTVU3eUZzaUNKek9LZWtPb204?=
 =?utf-8?B?SFNMK0F3RkxVNmR6cWsrRFlZVElWdkZ3RGRuTStxMGIrbXFjS2lOSTd5eXhO?=
 =?utf-8?B?ZWpsb3F4a2FIanJ5L0pyQkgrS25aV1k5MkNTRUNndWNIcWdOQ0VWT2dnd2tv?=
 =?utf-8?B?aEpoZUgvZXNKYVpWNlFzOWNXa2J1cXdmUk80aTZtNzlYRHltQmFoWkxERGxJ?=
 =?utf-8?B?ZERvZmkvcE1NOEVYejlpNWNNRS9kMkNGY01vQko0M1BIcWk4SkZVM3pGaEZn?=
 =?utf-8?B?SVB3S241SmJyQmdVUWRZa21EZEdPTmZvSndETkYyOWhtWURHZWFzenFBMmJT?=
 =?utf-8?B?bHY4NkRVRzllbmZvUHd5eE4xdnlKRXk4L1UxRk1FNSttbmV5ZmgycktSWkVC?=
 =?utf-8?B?SWFLaDlqN2JLSXFtb216RkFxSGJUa25icm9JT3NjTGgzdXMwazFzdUZwaCs0?=
 =?utf-8?B?SjVab1hQdXg4cGlBR2o4OHhYbVFVY3RsZ1FDbSt5SmxPckZ2VVZ5OGJ0czhq?=
 =?utf-8?Q?KhTm6s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FlNlMyT2dxRGVZK2l5c3dTeDRQY0Z0Q2xjUnkzWitrOVZzM3BvU2lWZUV1?=
 =?utf-8?B?aXZZcDhIdEpBKzJNOEZVc0Rxd1gxMnFvN1BoVUovend6aVp5c2p6QUh2SGw4?=
 =?utf-8?B?dXo4WEhkWThFb0prSmJML09vV24wNUlBY0RMOHltUW1FMGkyTG5xaG0wVTNM?=
 =?utf-8?B?OHdEL0NCeG5Id3NtSkpSVGdWUzNBUFI1MHpXTWR1UDlSUkZqQnJoU0RZTG9z?=
 =?utf-8?B?Ui81dXNEd0MzZTVCeGZVKzcvMEgyMXJwL0VjU25KdjVYbHRnSWcrVmU0cnBB?=
 =?utf-8?B?ZHJzSW1vbFVGRVJhTzFjSzh5WUgrTUkrSkNucHY2NGRzZzdvWlE4MlhrNEhO?=
 =?utf-8?B?UDcrMC9mQzVxTXFLS0lhZXRHSXVxV1lMbFNpUDUyalpUc3BoK3hQN1VWa3Jt?=
 =?utf-8?B?b2FWcDQ0V0ZXYU1NWTZmZjJXa2NsUXEvZmVxK3Q5OTdsTFNjMGthK1k1Ulk0?=
 =?utf-8?B?Uy93M1dkNjMwVzdtZEs3Rm1JWjhXYlJJKzlxZ0VYSjRIMjVjajV6Z0xQUWgz?=
 =?utf-8?B?Y3Jsbm5hK2NhcmFNcnRMTE90c1N2a1dFMUwvNHhOeXl2L1hSaGRpTGNIam5z?=
 =?utf-8?B?dy9jUGREUmIrZzlLRU9QcVBRdFVURHZGYVNyTEowd0ZpWHJyUWhHSWxqVzly?=
 =?utf-8?B?dXFmY2xaUGl2OVJrZUtDK2U5YW53dU5NYzJnbmk1M29DNlRvdDNFeG5RSHc4?=
 =?utf-8?B?anRickg3MnB4bjVpVXN1b0JtWXZCWVZqRnNjeE9LamV4SmhublNaUVNOd2d2?=
 =?utf-8?B?MW51VG1rd0dhL1E3aThMdEpGZEtHSUhCRFdBNGc5aUhId0s5S25wRDBJZHZN?=
 =?utf-8?B?SW9HTzhueEdrdmRFaFlEK0twNC9VWFBrUzVuTjdvUjcxWHlRcm5IR2VuUDY5?=
 =?utf-8?B?YndoUEcxNDVBRGZhcklQTmREVXVJMG9veVhyTU81SDFMZVZUTGJzUGJHUjhC?=
 =?utf-8?B?Y0htd2FQQmpkV0o0VkRWODl4NkhuWDYwSXZaOWVWa1JZd3VhSTFMT2RMaWVJ?=
 =?utf-8?B?azVUbjliM2hoOG95QWU3SlRXTFc1WjNuUjAvOE83VGpsa3VUYVdyTmFRZHRw?=
 =?utf-8?B?Tng4NWYyc0lsTlJ0MGg2ZWtZOGVLRm4zTkdMOWg4Nk9EUjhQcWVUZW5zaGMx?=
 =?utf-8?B?R295MHV2OU9GR1JuOTNua3pFZWdmWDMvUy9RNjNtcnhpYXdOTFJPeVJ0S0tN?=
 =?utf-8?B?YXNXWExkVXVLdFVQaFF4aXFyZ3l4Qlg3NjUxbjNoR2R1VEdiSTM5TW5yY2sy?=
 =?utf-8?B?OGNRekMrdVpubENjK0ppa21UYkZEdkVLK0M3dWNBZTBmQlJYajR4Qy9heGIv?=
 =?utf-8?B?NTVIaGVnbXQ4VGtHcnFVbFFBTjkxL0lXeHB0UGQ3am9tWW9UZnBuT2lkdTYr?=
 =?utf-8?B?S2tQbE41TDMyNjZQdlVjQ1E3U05hTFJoaTJJa2ZuY1FmblFhaVFvS2t1UTY2?=
 =?utf-8?B?SHJneUoxb0Z4TGEyd2VSRXJManNCdEFFMno2YkhHTWZxNEdoVEZ4SXRNQXp6?=
 =?utf-8?B?TDJrMzc4WXYwMldXSkZOWHJ4QUdRUXhSN05kWGE5QzBCdWtkdUQyNGVEeGpH?=
 =?utf-8?B?dVhhVTZ6ekR5TFV0T0tHNTJCYjdSUzgxdTN1d1FST2hGRXBXWGh2RFY2UXpn?=
 =?utf-8?B?b3FaMmdiSzhWdFhEVk40OHFkblZzSHg4MW1hVG5oQ1o4YTQ4MzJJUlVpTXdK?=
 =?utf-8?B?MkY0N0J3OTI5N1MrS3kvRmlGaDVIMHlkUFl5VEt5eDFKSFRlN042clBuSTJL?=
 =?utf-8?B?UmVDK2QwQlFHY1Y5NjFrRDBWOEhHMEUzajc0YXZxRkNsbE9BUjhhb3lzZ2FK?=
 =?utf-8?B?b3dZazVveklGQS9taHVOQk03SlUxSGNwcnFtVk5wWGdlZURRdnhxbGJBNWpW?=
 =?utf-8?B?UDhkaDRtb2F5QUcxUDB1ZTZ6SkFmdE0rOC9oK0ZTejk0RkxVbXhMS2dyNDg1?=
 =?utf-8?B?UnJ3bjZqVFFsUkZJekJqaFFaN1Z2QmhURURDbEpnVUYxYVdqVE5YMjlEbVpi?=
 =?utf-8?B?YXdIL05zRnN5dWl2NStub3ZLd1ViMWR0L2JwSjJqZ0NoQURpUURXa2FkcW9Y?=
 =?utf-8?B?clR6eWJwc1JzNWlvaU8zUnhrWUFMWUcvNWdGajVBU1pFTnIrTUFuU0QxY0dw?=
 =?utf-8?Q?u9BU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3184dce-637f-4cc7-4349-08de1594a6fc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:08:53.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xE5bJYANsdSz9HopPZ+QmVnXsL9O62oaPW1GyUNdkRl8tJcOdmmnJCDyCoA8VhqeQNXq8nhC7rJn6Z/a72MSAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11919

Replace the bool rnw field with a union in preparation for adding HDR
support. HDR uses a cmd field instead of the rnw bit to indicate read or
write direction.

Add helper function svc_cmd_is_read() to check transfer direction.

Add a local variable 'rnw' in svc_i3c_master_priv_xfers() to avoid
repeatedly accessing xfers[i].rnw.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v7
none
---
 drivers/i3c/master/svc-i3c-master.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9641e66a4e5f2da3bd84b30fa741e5e19d87465d..7c516e05d0a1a118479ee3d8ea8ae37ae19fea57 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -165,7 +165,11 @@
 
 struct svc_i3c_cmd {
 	u8 addr;
-	bool rnw;
+	union {
+		bool rnw;
+		u8 cmd;
+		u32 rnw_cmd;
+	};
 	u8 *in;
 	const void *out;
 	unsigned int len;
@@ -383,6 +387,11 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 	return master->descs[i];
 }
 
+static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
+{
+	return rnw_cmd;
+}
+
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
 {
 	writel(SVC_I3C_MCTRL_REQUEST_STOP, master->regs + SVC_I3C_MCTRL);
@@ -1293,10 +1302,11 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 }
 
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
-			       bool rnw, unsigned int xfer_type, u8 addr,
+			       u32 rnw_cmd, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
 			       unsigned int *actual_len, bool continued, bool repeat_start)
 {
+	bool rnw = svc_cmd_is_read(rnw_cmd, xfer_type);
 	int retry = repeat_start ? 1 : 2;
 	u32 reg;
 	int ret;
@@ -1484,7 +1494,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 	for (i = 0; i < xfer->ncmds; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
-		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
+		ret = svc_i3c_master_xfer(master, cmd->rnw_cmd, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued, i > 0);
@@ -1677,14 +1687,15 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
+		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = xfers[i].rnw;
-		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
+		cmd->rnw = rnw;
+		cmd->in = rnw ? xfers[i].data.in : NULL;
+		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 

-- 
2.34.1


