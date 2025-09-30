Return-Path: <linux-iio+bounces-24606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81670BAE75E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 21:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3C83AF14C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0608228726B;
	Tue, 30 Sep 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HImweyg1"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487128DEE9;
	Tue, 30 Sep 2025 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759260903; cv=fail; b=NcbfL37paCT7QkvaYkenlqOlBMZKCCJfkQxp9hsOKCPkDu2Yt0Zg1GD9SsjWdkjbO4jtH80hHN5lkLfDN8s57ZikJwtPEzN8a3Rer6yEPkpU8VuDbd5u554o5N8fa1Meij7KaZJ0KudZYgZdBTIkwQAbZwekhXYwsz81LSRP7Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759260903; c=relaxed/simple;
	bh=Wn33yvLfzVS1x/wyZkwAlBReMosWj9JdoWilKNLmxX4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QdPbWHwF2PS84xjxSCZu0811AycspIy0G1f/aQpjeSPaoiDGR03lWurjma6z0hkoGbG6+VwG2JsDX/A4KTCKTq0yaF0Xoq0hSjIUurKHFbV2OB6Yenww240dsmTPFzZNStfdFhRh0S5NjML6N/jgatROQ4ggMII8L2IgNqTk+/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HImweyg1; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMXbPW6bXF3gdchV6j+v4Aw1d/axCQbIYdvBg0aR10MgvrfF2cVhsUY/KJkD7j234skJHkfI3A7MiSDO4zMwIewtuoNS0WA81BloHobywz53x3l1At1uV6e7jNE8LRcEnrlrDYUjmwfwQ0SiinGVciQPrnrCMLEs5czUz2qnzPIkAOfWW/M5M1VAPyWUAGElkhtmygDvNu0JPlsj9PkpvPOurj7rPj5PiTSBsXOfun1vx0Y1TE5p9TojH5eTh8OzoOmf/bek+2EyIe6nG/J40B8JJFKzlPmep7WYz+kUNuX5gd5dHow5+PR2KzsOjX0sS5tBhyeQTAY6YU4BLqq3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8TmE2Lm/MJEJoqeRMzY5cm8tnAS1sz3VwkFDGnGfqw=;
 b=BvER6oIpU1K/WxiPlI/o9e6x5xxPVG0ftR/dQfcBKYgHThN1/9tnTpaFmGFNswRv4W2cFifyC6SnyX4mgKsLZBlOICXk7yP4QQXAHJGNbkb/y5aRr1PRSOlxFNQpy+g9mjRFkNwz34nz2Rup6vGaUK0MB7zK2RYSlxbL9Qin+GFM31eYFxFtOlrQzhOiWJdbJAaD7+YHBvKyKEd0ZC6/ydMzu+HS1lHiliBpagNnN2KiUecvEyaFdAZMZYfq9WoVLL3x53Q8yu9iR0gH8beKRpCtqJznc+TNrEpyCteRjcX6Q2AfifK0OesZmd9TxTINb6zx9BIA1s/LLaD3T+0yGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8TmE2Lm/MJEJoqeRMzY5cm8tnAS1sz3VwkFDGnGfqw=;
 b=HImweyg1kCX3NfUmzEacbjB3MyybuC0TIOtqyGoiofSuUm+DlT760yTGVca4qobygmydBa32+cTE+C0rX1yzc6QFGig8h/I6iEfqMeJ613XDWugoVXYUpzDRD1VqqW685+UZiSBTKgxu01HTzE3IJU5fAeCfefoUKW5ymiPPYBZyjyYLx0DaJrWL27iagBk2LwsrD7RrVAFh1EIuh+UeLlHS/jPegashFeftFItuGCgwum0sEIKNMzxLhbazPPZtT59/acyeJ1r2rOoVDgd7qAhYF5yXojSOa8VgGR/vEJWvgqWr7ABVqs4RmFlodFTKhJDDYfgeHsxUSzqFlADRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10926.eurprd04.prod.outlook.com (2603:10a6:800:259::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:34:59 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:34:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Sep 2025 15:34:23 -0400
Subject: [PATCH v3 4/5] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-i3c_ddr-v3-4-b627dc2ef172@nxp.com>
References: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
In-Reply-To: <20250930-i3c_ddr-v3-0-b627dc2ef172@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759260882; l=913;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Wn33yvLfzVS1x/wyZkwAlBReMosWj9JdoWilKNLmxX4=;
 b=R9gSyYgpVayxxqItHGWy3iMBViwxkvdfQuJsrwwYdOwL/uOrSes8XtRRoQvH02mMHrQepGlri
 w355GKwAao/CpiVUirBymbCVkHvB6q5g9sHwuEUkQkgiNM2JVtja2Mn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5d3c7c-019b-4f8d-5b3a-08de005870f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZURUcGREenh6N1d5N2JtMW9NM2RudE9WYWlTUVJFMjdMNWVsSU5OYy9NTXIv?=
 =?utf-8?B?bUQ2K0xCa0ovVGhnV2NlUVlxQnloSUxxMmMzamxGRWM4aHNhNm1rcUhBT0F4?=
 =?utf-8?B?dktzc2NSa3lPeGNqdU1SVDNCcHdxdTRhRGlId0FraytLelpBTG5mMU5kUXdT?=
 =?utf-8?B?MFErcElvMkR4NFVDSXJWY3NyZldCTlo3M3NwK2VYOTdpKy82M0dIUEsrUTNE?=
 =?utf-8?B?ZEFWM2x0NEhqd2FXcWV4NlIwc2JtNjh4L0JhZncxZXZqRVZkRURiQmgyUG84?=
 =?utf-8?B?dFlmRzlUdk0yamlyWDFLbEI4MzdYSjhEdDBmM3QxQ1hGZTNaajRrRXU0K09Q?=
 =?utf-8?B?bVdsNjQ2QU9WbHY0SzhvenhiYVk4djZ1UjBpNnB4Y3k1MkNyazJ6WFpwaGpu?=
 =?utf-8?B?K1ZwVXZjVFIvei93ZGdmYUpncXpwZklsMHIwSE8zWkhiM0I0dy9ZK3d6SnVX?=
 =?utf-8?B?OTRRNjhDTXA0MEltaXFCc2VlRjhxT0VkdnVUZXNiaHJIT3d6MTNaUDhCNXA4?=
 =?utf-8?B?NDgvdk93Wmo5ajlub1lubGlLRmR0VEtBbVN3Mm5YQVp1amg2VldrMlF0LzJT?=
 =?utf-8?B?Ulh3dk5ReFR5SVRyWmlhdW9uekNCZTkwS2p2dnNsK0dyMVVxTEFidUtsZVFC?=
 =?utf-8?B?bXFPVHg1MTltL3dRa0lwZlk3TjYyZlVSbWdMbytHODlyOEd3dnB4VzBSRmc2?=
 =?utf-8?B?SGVUdzJmT0JURUplQ3JhQjVQejJzS3pHQjJicUFud1FYWmtrNFBCMUpIUzc4?=
 =?utf-8?B?bXI1L0x3Q2dER1F5VjVjOUZlUU9IWGVETUN2MFY1MlNwd1FBNVo1S3Boa2wz?=
 =?utf-8?B?SFdXUFJ2Ny9MMzJDdlg3MVZPK0tDVlIrZy9VMzUrbWI2eDNwM1l1SlFFdnQr?=
 =?utf-8?B?YWtYcHA2VFUyWXljNVV1a2RSZk1lOWhSb01xSklqTVY1ZEhDQkRLWUJ4R3Ni?=
 =?utf-8?B?d1RrTUNHWjV0V0lCc1hGdk9LNDFqQnVqdWNQZDJEQTZmZU5IVVp5M3k4d2tE?=
 =?utf-8?B?V0V0a2QrV0FGNnp0OEorQzJ1eUczNFJyUkNvMHVDMjF2cmovYjZVck9VRlRQ?=
 =?utf-8?B?TjZBRFZtSFllMzNHNnRLQTZPU2JpcWxRWUg5bnZacHRZVGJUSHg1dE5Gb1Jo?=
 =?utf-8?B?N0FWeXdEV2dyNVpwK0lDQTQxd2Z6YTNBcWwwZU1tNmdaTE4xeFhDcnlUWVNK?=
 =?utf-8?B?aW16SXdSNEpJOWRWbmNTcHJaU1YzMzJGbXo5UldHTUh4NThCQjNwVWRBSTEr?=
 =?utf-8?B?Y0tGU3FxTlJaMHFmeHJrL2hramlPSG5YajRmQUtsWlNZQmJYS29qNHlsMmJQ?=
 =?utf-8?B?ZHdDUVFVcDV3ZmJoc09qRmVHejlvTGM4ckI0S1ljSThhWWJXQU44VVFUTzBs?=
 =?utf-8?B?alhnREtQRzFUYy9xeGtxV0pvSEtpTlFQYkhyZWVpSEZWdVVMekdmKy96VWJO?=
 =?utf-8?B?b2NhdUJQVjlucXpkWExxcVN1aUpFWEtmcWlTcW9CdzZvOXF0ZWVtVmNaNng0?=
 =?utf-8?B?Y0FSdlIvTnVCQ2cxTG5uY2pieVhPMThWTE5DUldma2l1bU1rMFVJRFNYemdT?=
 =?utf-8?B?dkdDQ09EYTVXazRYVDIwemx3YlZ6VmFxN0NzT09YU1VPOCs2a3RpUUJTYUZ3?=
 =?utf-8?B?SmxFVUhpUkdmNVhDMXVhVVhBZkljRUhVejRqUEF0VCt4UUM4Rk1vRVkwU3FS?=
 =?utf-8?B?aHJBRk5UOHhDb0k3dmJVbEpmV3I5SmgrY2lxVVRnaFhRZGswUU81R1VsbDcx?=
 =?utf-8?B?aVVqTGtXRkJhU0dzODhsOEJxRHd6MVpsZk8wUk0vMFZsMWUvSlUyZHlwUmFB?=
 =?utf-8?B?eFFmRmh0VzZXa0hOUVduTWRGaWpadnJpWVNpbHB4bHJubnVWYjZOR0FxVVlR?=
 =?utf-8?B?alR0ZjdYWnJrOHVMaUJzeTVTNG1saVFxVHdPdkVTNzVXSUdwSjl2Uy9ZK0ow?=
 =?utf-8?B?THNDUEs4U1IwNmx3dDJsUi8xb0VVRTJRWmRMY1pnK3VmeGFVSlcvWHFFWDcv?=
 =?utf-8?B?K1dsMytqU1RuS0lwUzlmYThkQlQxc2pSUkdsazRsYnlGeTNhK3lmYUd5ekVX?=
 =?utf-8?Q?JI/ckt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?by8rVy82bmkycU1pekd4eVh5Mm4vd2QzbUpwN3pzY2tZT2V5VUwvL2JuM251?=
 =?utf-8?B?cFNmTE5ZL2xqSUpEdjMwMjdXdE5FVDVkdUpuVlZLL0cyemd1V0E4LzZnS2o2?=
 =?utf-8?B?aDlTNzRXcDJQdzJVZWNDcnVGMVlublFFWlRZeDhucHJrRVdrdFI1NHBQWmRH?=
 =?utf-8?B?UnhKb3dIZDhEMDcxdkgxTzVwNStZNFJoOHN4V2lyTXRiOGxNQitGNDhsU0Zx?=
 =?utf-8?B?c1FJbVRMQ0c1dEVQQ3BrMkV6ZmRYblBpNnFyY1Ridzc4ZVo0WklWSWxVTkQ3?=
 =?utf-8?B?WFoyTFB1QXZKc0dPUXNsaGcxMytLbTFVVW9DSGlMZjkwbVpTQVJ6bUJBZ3hP?=
 =?utf-8?B?U1ppaFRtcXNiYVdyL25LdVByZG5CZ084bU9VejdheEFncldMc2ZQV2NPVC9I?=
 =?utf-8?B?eDdLbjdzZ3h3aDJuRWRCVW5SUnNoOGx2OVB5bS9PUzZIRm1rOFNldFJxRFQr?=
 =?utf-8?B?dW9kYnhIRjd0VVVKWWdOTkswTzIzdE5LbkVEb3NvY0VTWm5DVHRwSXYzem1X?=
 =?utf-8?B?T0w2ZDlmS0RVVFJ1TFZWLy8vNHlXWEJyNlh6Qm9GVGMvcCs4VVlLSzNYYUVD?=
 =?utf-8?B?dTJDSG5EbFhGVmFCOFhKOWkxMnlKaXQwWmpGTDFxZ2xvMldoT3JlOFYvZHFO?=
 =?utf-8?B?bGpmWDlaVXo5L1pMK0oxRGdMU25jV0d3Wm44N3VwU0tXbE42cUx4d0NEZVUw?=
 =?utf-8?B?VWlKdEQvSVEwYnhWRDR2T2hVSU0zYWRhaXc2eDAyZnZJNjhLYitXYzhPMHlM?=
 =?utf-8?B?b0cweWEwNHgyUG5jTjRwNjQzdklQRkJ2UjlIVkU5eXVEdGVjRm8vWkRoTG9w?=
 =?utf-8?B?OVpSUlZ3Vzlxb2ZKNjU4MlZnWDlKZlpmeDhUUUx5RW1xY0tNMWJVaDZlMWVC?=
 =?utf-8?B?WUpNN0FnTklJcm4ybWkxalU4TUJHSHgrc05Ua2dRVkRSVUNKcmh5d2lUZ0sw?=
 =?utf-8?B?ZmkxOVM3YXF0akpSRVJlSmlLVHVNVnlWWjlzdm5UNmo3amFGREtaTmNXdEpz?=
 =?utf-8?B?a3J6MU5FQXZCWVA4RU5yekR0dk94YnVIWms2dkZLNGxKQlVwa1pSZ3ptV0Ry?=
 =?utf-8?B?ellQOXZyeHZmSHhtaDZoV3ZjSzY0bUwrSTBkTnIvQ1BIYk5GbGlCTm9tUVkr?=
 =?utf-8?B?NG41V2pGdkRFMVgyb3Y2L1ZNeUkrcnA0TkgwVkVKT29CcEdPWC95SzZpa1Nt?=
 =?utf-8?B?OEEydnFwZUVuODlqeUduL2RIZmtZSUdqTmQyb2ZxeGNtZXR0bWtaZWs5UmM0?=
 =?utf-8?B?T0l4Z1Q0SWRFYXo1S0lWL202TXJzejZaWUdqN0czT3lRU0svSlh5TVpJV2Vu?=
 =?utf-8?B?bWhCVm8ydDV1REc0enp6OGwwaFgySXFUNjk3aDBMT3hZdko3aktKN21vSFlW?=
 =?utf-8?B?ejdBYWt3UXBnYkt2WVViM3JtVjF3R2dIUTBZMjJHdlpPNE01TnppZ3VraXR2?=
 =?utf-8?B?ZXlMZjVmclo5NkgyV1MzVUxzVUFWdzRiMTdIQnIvVU1TcTVSVHZzOGoyaFla?=
 =?utf-8?B?Z01PY3VoSDBncWd5V2F5UzAyaWR2dlFkOGZEZTlTM3l0bU93OENXOUhJaDdH?=
 =?utf-8?B?UnphdDhkQU5uWnU4S1o4a3p1ZFVHYkF6OS81WlErVFBsb2x1Vzh6U1VVTzlO?=
 =?utf-8?B?WEhSMkdlRzdCTWVXOW1ING1iWGlVK2ZRckVUM1lZNlVmMUhvVE1jL2NORXN3?=
 =?utf-8?B?NURDbjhqRll0WXQwNnhRVE5ZcU5Ha0RJenZHU3lTVWJndWlidEtxWnYyZUY1?=
 =?utf-8?B?WGx2VG8wRThhbXZ5dUFHbUp4emZVc2FvWmx3Z251VGU2SmFwdWdxYkNkSWdV?=
 =?utf-8?B?aFdWMk40dFB6Zlg5eDFQb3FqWFk2U2tacEZBQmNSbFVTMjZUejdQSTFEY0pI?=
 =?utf-8?B?bS9NQ1QzV05ncWM3ZFhkOXlaSnRzVDJSMVVUUHQrYTFDajRlcm9XWWZRKzh4?=
 =?utf-8?B?SmNVd1p3VTNQYWZwaDVCWDNMc1g3dk0rdDRpZkZrNXA0dkNMYyt4OVJPbEts?=
 =?utf-8?B?dFdDczdsbnB6bisrWmhsb2t5NG9ER3dyN2NiL3NsYnpIbmxzVThmNFNDYWdH?=
 =?utf-8?B?cUhGQXNRTTh0T2UwVXhmSnl4MU1RaHExOTNna1h3ck5vTVFZaGd4dkJUUTJI?=
 =?utf-8?Q?JhCA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5d3c7c-019b-4f8d-5b3a-08de005870f3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:34:59.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ynr4RFFf+MhaYpYp//oAZAyMUpLORbjVlnNaFyqiEbG8c+UbEZpROgF4LlNqxmWUbQPYitmqi2r1uHWnK17Y8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10926

Add compatible string 'memsic,mmc5633' for MEMSIC 3-axis magnetometer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7609acaa752d5c1c89a26bb007fa38357dee1a28..373e36e5460c033c0c39a51c3c2c1cdee3970982 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -225,6 +225,8 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis magnetometer
+          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer

-- 
2.34.1


