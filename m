Return-Path: <linux-iio+bounces-25539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA79C11522
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 21:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3471A6690D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E449320A32;
	Mon, 27 Oct 2025 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UTbpmQS7"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3831B80E;
	Mon, 27 Oct 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595736; cv=fail; b=df5SqNqzYhYbcJGwZ5L9WstCtdIIyQo4hI+i/TUMT7t56Fos0Karl1K+buDvWUf7sowlPVZ4D9Y62gNq5FnsCbK5pW653qkVyPGL6D01GX16gF1LHQPwP/YlmRsMp7EBX9+FJH3gV5rhabJj/NouI0l2Hp6DMavW2wJIzYLrYyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595736; c=relaxed/simple;
	bh=SkcDYbHPBR52IILcqjk/qMhtQz4iIc4teAhidTsTJFU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Bp2gy5GKC3giODzNFgoeLiULaV+e56l0xEmBkROj9vV1BJDScE/r5a6pknaDlTo+ESkM0BXgZ8gfJfHhw1LnDpzrEKaTyuTqaEazDXxx77JK3YZ+Me/L1RekDprmuR+VZBUTFF5KxaVI09zq+k6thLYcJzFpIodJojwObJIKDXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UTbpmQS7; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0EZw9oozm8QcGmqoKRtimZ6QiKuvskWC5zE1LHUHHqN9W/3Zi77BPKZA242Ouos1L2wRcQneDUpEf7eHfvPh+jX0gvo+oCwZ/KqkMtBlVP3bsWA/3t+iV245430EoXhTJGvLjIM+cJuQhB+2p5rxVWI4SLxAAv0at+RbsXZiLlW8mqTwZmI66G53VW7hn+wBE1holJzarlX7xdu7AsPjzuoOzvUxDJbVQWeyBfCGcWIbgmcIiD8ajoXMfBzErbWVKa3cENpLLkAN3ItWSpKNE/7wZHdckujTb9cW0haAZiKpMImQaz9TYK/c0AY5k7LUxNfEMY/2zQ67GDlJK7IUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqbOr0S5EoHn0LGYFZCSYeSed/ORcdkAIJZjvhyElDE=;
 b=btbVXWlOC99RAvlVsjsvyllrc2wPUv3x07Ddyko4ebyNMHnS9CTW4wC75uN3zYcVYvsAk3R5PG6XsXKbNPE1i8wZYM+K5XFwycytkamiGAfVppq4ugWU1Gn/+D55D0S+qcxfKiMqsF3YYSmMtdQgOqSqlwiTu8tc/zXOZcG9JaNnd787HGM9I5yiCeTf5RkSREbsU0z5iRTZ27B3aymqAahx9ZtkQuGndzjNEn8+dWiN9kjPZ+yxQSku2WPZDDCG6iCJMppzRGerYKPEXQX8G7Z2ooWZU5vLYlBzda2aC7prgGuv6z+OTa/0ycEFT8zPbbAdMqBs95JjfHZ9+qEEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqbOr0S5EoHn0LGYFZCSYeSed/ORcdkAIJZjvhyElDE=;
 b=UTbpmQS7+dgcBo7bM42KsDGV48CGPzjdBartImmz8FnhO0qm8Qxsrp5azDfCe0DbfK9g4q1qwoWmcDLK6AnyteL7/Z/2mZLN+Tb3eTSX9nUvgx5x+y2bp4q8woC9SeNLDcCpeVtsEUTBFe/Le3d3CgYj28wuU3owqZilV9xqe/p7DcTa6xuCrUXwEtjSEK9hDVZifSIVniTWhVWebKgtRpCbkPyyJEVy6l8O/kgCyln/gX8uNyz9IO5bVqsV+zMPYhat51aHg2303BfVx8+9OwHrNcA1mc2SvHb8Z/WnYXeejTkii2p7HYzKJgsYLEHozmV7Vb3Ju8OBFM4MIniuHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB11919.eurprd04.prod.outlook.com (2603:10a6:800:306::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 27 Oct
 2025 20:08:50 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:08:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 27 Oct 2025 16:08:29 -0400
Subject: [PATCH v7 1/5] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-i3c_ddr-v7-1-866a0ff7fc46@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761595722; l=10504;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SkcDYbHPBR52IILcqjk/qMhtQz4iIc4teAhidTsTJFU=;
 b=1d0yjqClIvO9LeOMLcIrCcJv9XvleCKuA2npT7q7fKhXLR6v9X8X+Ogy6MGrH2gFMb12bRzdb
 SyMZ9oeba2kAUuNrMaA+iuMcTbzb05Rnl0Xe6jtxQOGPXPFPekWGksu
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
X-MS-Office365-Filtering-Correlation-Id: 91f6cf64-84d2-4796-2fa3-08de1594a4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTJFTmRZNVV5ekNxZVZ1MmwxRTBNc2w3SU5Sakxha1JpVklRMUZiNjVxaVBv?=
 =?utf-8?B?QUNoTStQamM3U1dmS2laNlc2TENMa0Q5K01TVk9IRXpia0xVdHorODVPQjlF?=
 =?utf-8?B?MW5ta1A4RU9xMndHK2hvME5xbG56ZGJWc2VlRTBWUkR5cFZiUjZDQTZuTksv?=
 =?utf-8?B?VHZFMXlURVIvdjdzSm91RFBUdDl0QlZSVzNSRnpwZFg0aHBjVFJ3bnk5ZmVK?=
 =?utf-8?B?UStxaXI4ellBNjBBUjFYSXNNUDNWajhzcFJGQitZR3owZXkwWFBYZHhVelBG?=
 =?utf-8?B?aVBlbExhNmMycVRxTlR2aW91VTRLM21GRXdJd2U2YkxoQ1EvbG9ncVQrMFF2?=
 =?utf-8?B?aTZmWG5SWmNybVZNVFZpSWhYdkVqYWYvSHRLMWtaaUoxNDB6ZEpERld5R1Qz?=
 =?utf-8?B?OW5YL0tiYkNZQmxwelR4emFISDQrdmVCYzBSNCtmMU85N0dtcHZWS2FDNlhX?=
 =?utf-8?B?NGZtZ1N2WHhYR0dyYUw2RkV5TkM0UC9jNnpkTC9OOXRwS1pOTVl6RzB4OVl1?=
 =?utf-8?B?Y3ZCcS8vTnpZYWU4eWNJdWJsRDcwdXp6Q3Y5M2xKSnNhTGFjSmRuQ1gxeFU5?=
 =?utf-8?B?Q2gxamNHc1FiZVJQVUdtQ3hPaWNnZTRNWW40MnY1U1lIUTl6dGdyZWxUOVJp?=
 =?utf-8?B?ekRlNnFiclRtTXBLYUs0QkJ1SGRBR0xla0pyR0Q4b1pDTkg3aVpVZ016R3VK?=
 =?utf-8?B?TVN2andtZFpRV3B2NDFnL1JOZEFhb2xDMmlQc1VTaU9DcVMwUEwxNUgxVldX?=
 =?utf-8?B?ZCtMWjdvazV0aTNDcDFaSWJINVZWVUV3K1VneVd4cFkyZnBURTFvdy8xdmlC?=
 =?utf-8?B?ZVMzWGJTRzBOZU42OGN6Ri80ZnJPVGVJeGRMZHdZTk15RzdpZVVucmFCS1Rr?=
 =?utf-8?B?MHhTdVd4RDVXMzBwYkVLY0dienVhRWo3RHU0cjF0dXYzUW1Tai9hRWttMzJO?=
 =?utf-8?B?eWFRSFRMVDl1ZmFhYTFLUVlnZTFFcmkwejllNlBjSXJDeUpVVHVYalRPcHlG?=
 =?utf-8?B?UzFUS05mNkZGTVNEek5YOGtuZVRGdEJKK0NCY0dYSFRtUFVWNUs3MklNdG9q?=
 =?utf-8?B?TXhCaldYcHA4YTVvWnF5dG5MV2tuYW1wRk1DUjZFbHQ4VUYwTktTWHl3a3Z2?=
 =?utf-8?B?eGZyeXYzdkJZYUFWTlpDeWhFNW41L3pISnQzejlYY0hvaDhoVDVicUFKSnkz?=
 =?utf-8?B?NEl0Y1Vuam45NElQVzIwc0FUaTZ3ZkQvdVRTRkFPbVVqWnB3aHdVbHVITWh4?=
 =?utf-8?B?cmw1N1JxVW1jbURidTJHL1prMGFjZ2R2T1JybDh2eEVrMkdzRWI2TUVYR1VP?=
 =?utf-8?B?eUM0RVJxc3dkMmt0YldwZ2lndkF0OVhEUWZqVnJOaFROTWMwU2IrWlRvVWkx?=
 =?utf-8?B?QXRRUUY2bko1TEhyaVcwMUdIK1VXbnlkZGNmRVZ0aytiVXhLZ3FJeWk3YzVO?=
 =?utf-8?B?VEIxMDE5WERKZ1M1VndaUWtMQ3Zwa1orbmRXeTFQb003SnEya2gvZ01KTmJh?=
 =?utf-8?B?QTljMXFudDQxKzlXb2tLVHZkQW5NQnVSWmloWWEwNk41R0FxVDMzYkNsNmJq?=
 =?utf-8?B?VVdrcFJRUUZsVWhTSTA3VW5rYXF2TlJ0WmJDT3dKUEs2dGVwa2QzaFFuT2d2?=
 =?utf-8?B?NkhFamV0Q0NtekQwWVg4RHVnZFVrTWE5UDJLVnFRb3RldVNndExzK21xazFn?=
 =?utf-8?B?T0dRYmJDSWpaaHFoSnhJcUpPcG42NVNRNlMrbXZYeDlwQUVQeHgxMU1YcGNt?=
 =?utf-8?B?cWQvNEgrbFM2cmhPcUdGZGJzQzRKZWlTekE2TjRFTU8wRzlEczdzaGltYmYy?=
 =?utf-8?B?THU2empBZk9EUE9Td0dJSGRUa1JzSjdQQlY0R01OZEpYRWR1dHJhNHFUQ3ZH?=
 =?utf-8?B?N2hmWHMwbzY3d3c5TEt4cXNYQWhieUJhR0JYMDhiQWNaUjZCZUdSUnZ4ZW5x?=
 =?utf-8?B?S2d1S2gzNlJZT2IxajYzdTR5QjErdkpjcHJ3WlNxMmZzajVXd2ptblNMZlBz?=
 =?utf-8?B?bHZyNDlhTlpiMU42STU2V2c2STg0SW1BTVhDU29NR0Z3bk44Wk5TeXh2S0FS?=
 =?utf-8?Q?LejS/6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjNwOXdSMmRDY2RZYnZZampMZWdHOUlaeWY5cmt3SWJVMk9qbnBVYWN4SmtW?=
 =?utf-8?B?Sk9TNHFWNlZ5bzBSeENYMXJXdGZRbEZ5NnNBaE92Vk9TdzNzZGpOcGtCVHhP?=
 =?utf-8?B?bDhxZ1pUbXlTZVllWXRvSzUwZ3J5NkZ4Sk5QYkcwRWV6S3RrTDRsM2xHWERr?=
 =?utf-8?B?d0h5aHhlMTBLeTRQQlFVa1VJT2NJdHJ6L3JXc3RZd3UrbklwaWptUzlqWHBZ?=
 =?utf-8?B?UlVZazY3amw4bjd1SGtwNE5zTVJxOVFQWGhVTEJOTU8zRzJqMnJaWG5CaDho?=
 =?utf-8?B?NllKWSsxcTZDR04rbm9WQllyU3U3MW9jaVdzUThrTStYYndBb3RzaEx2c0hq?=
 =?utf-8?B?Y0hwTlc1ZnhyS25FdU5HcHpSYjlEVFV2SjVEVGpVSGJ4K0pIZXFnMGUrQnNZ?=
 =?utf-8?B?VkRNZnBJU0ZvVHZQN0xNcUtvRUVFS0V2a3l2UHZTd2tnbTMvQVJNWmpXdUFm?=
 =?utf-8?B?RWNpY0pyT1NTeEhkUUxCZGJUbUlsZGc4MmZqSTh1OFBJZXdFVGtkSzBaWjVa?=
 =?utf-8?B?enpEQ015dnFiMG9oUWJpcFdGMG9BamRCNlU3WEY0RFlwMm1jdjlGRFJ2Zks2?=
 =?utf-8?B?WXJkWm5HK3F4NkU4c1pnWitBWkZtZXoxaXRJcEljYU9JS1BrS003QzMrNFdr?=
 =?utf-8?B?MlFaUjA4eml5UVIxMVkxakJBbnVuaTE4S3g1MjdmRytCUWorOXdCenliRVdm?=
 =?utf-8?B?Zng3dmJyNE93VnY4NVY2MTVqQldSTERwdkxhdWZMQW55OVlVMUtudXV5Um02?=
 =?utf-8?B?dGhwUTFQd1lnSjUzcEhGSXl6enZTV2JjbnFZcTNVMERMWU9WbTdxWitTLy82?=
 =?utf-8?B?WENWYnRlRUViY1M3ZCsveS9oQWhxcDR5Q3k3Tkc1UnRnTWNSbENVbTNIMCsx?=
 =?utf-8?B?cjM2RStUeit4d1VzUTBrWmJqVXRFNEtJYnNOVk5Ib1dFU2VTWHI2dlp1WDJi?=
 =?utf-8?B?NlU1MkJpS29lSHgvU0tEMEdLQXMwZnBFWjkrV1B3QmUrY2VWU3NiY005K3pY?=
 =?utf-8?B?U3JCeklOMG9KNzd1Wm54Vk5pYnJQM3JYaVZraUxCaUlxQ2pBaUNtTkpCeDZ5?=
 =?utf-8?B?OVcyZDlpTW94cFg3dytYZWRVZy90aFZoN1I2VklnZThVcURaUC9LdGIyQlc4?=
 =?utf-8?B?RmFScW4rK2QvR1BZRklZYi9IRUlGSW8yd3hsb1hwUGIzWFQ0TWRpRmxLL2tX?=
 =?utf-8?B?Y3VFQUNacTl1VGREazVpZzJLbGFKWjZEaW5Ydk03b2ZySjNRTEQ0dnZyeC9L?=
 =?utf-8?B?cm82cEtiUmoyNlI2ZWVMbUtnVGN3RlhydlVlZDlzOVJGL3NaYWVKMkV2b2tu?=
 =?utf-8?B?TnJtZ2ROSllsSFg4Q2ZnN1VrUWhHQ0dnQzhSaUYyVnBvaU96RmdrUHBKNVUy?=
 =?utf-8?B?OG1rZkNubGdLeTdCSmpRVkNlMGZDRUFkR0hKaGFRVGJjMzBlNTNDcnJkaFg4?=
 =?utf-8?B?V1BFNXJyTkFRRUliRFBUQUlnZVpXR0NONVRCY2lLMGZqaUh2QkJvME5iYkE3?=
 =?utf-8?B?TitqQ2tUVUg5aWRDVThxV2lSS1Jzc05XY2xGV1NjVGV6RkpUSjBVRG8vc3lS?=
 =?utf-8?B?SWVKOXBjTXhkRHNLV3N2dGxMK0VUSEtTcjVIcGt0bUhETkkyaCswNG8vYy9u?=
 =?utf-8?B?blNCNWRHN0s4S09FbWZHRDgrY1BnL1ZNd29seEkyOWtYRDAyb1FkbnhhNFVu?=
 =?utf-8?B?NWJOeVJZLzhjdEhvS2tXSFhpeklsNHdCaU5YZXN2MVo2TDJINDFYbnM2aUdK?=
 =?utf-8?B?a1ZPai9xdkxMc3FPRlphcm4zelNuRTAzQUJJOG53cVpDNW0vdkJoT0NiRnY3?=
 =?utf-8?B?S291S1VOUmZ6U0huQ25oYWhqTHhubU05OXNCUldoL3kzSXJrNW8xQ1RHWTdx?=
 =?utf-8?B?S0g0Y3BmVi9ZZkExOEIyN3piTXhqTStFMkx5bTdpLzRaaWJMZjJFdHVsUi82?=
 =?utf-8?B?cFlDL0xuMGFkMnZTMEkyYXplZExOM084N1p3Rlg1Z3VvN285cGE2ZTg2eVZP?=
 =?utf-8?B?TkJNSTkraHpxVk85dzFPTXRsM3ZTb05LVWt1TVJmZW9KbHU2TXJSSXZyUE5E?=
 =?utf-8?B?cThZZy85NFdLai90emFveW5IdlJlaklaNXlEV0t0TVhBOGhDWi9PM1hzMC92?=
 =?utf-8?Q?72cQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f6cf64-84d2-4796-2fa3-08de1594a4dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:08:50.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mxNkw8MyCVixrPZLM+6IbaXMikb7j/8g7Cqy/O0eWrHkDelaSPvWcWX6w+FUZOEm2PAcOxVd9JuqJ4TqYKqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11919

Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
Technical Overview.

i3c_xfer will be used for both SDR and HDR.

Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.

Add i3c_device_do_xfers() with an xfer mode argument, while keeping
i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
with I3C_SDR for backward compatibility.

Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
'rnw', since HDR mode uses read/write commands instead of the SDR address
bit.

Add .i3c_xfers() callback for master controllers. If not implemented, fall
back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
all controllers switch to .i3c_xfers().

Add 'mode_mask' bitmask to advertise controller capability.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed in
one i3c transfer. for example, can't send a HDR follow one SDR between
START and STOP.

i3c_priv_xfer should be treat as whole i3c transactions. If user want send
HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
instead put into a big i3c_priv_xfer[n].

change in v7
- explicit set enum I3C_HDR_* to value, which spec required.
- add comments about check priv_xfers and i3c_xfers

change in v5-v6
- none

change in v4
- Rename enum i3c_hdr_mode to i3c_xfer_mode.

change in v3
- Add Depreciated comment for priv_xfers.

change in v2
- don't use 'priv_' since it is refer to sdr mode transfer in spec.
- add 'mode_mask' indicate controller's capibility.
- add helper function to check master's supported transfer mode.
---
 drivers/i3c/device.c       | 27 ++++++++++++++++++++-------
 drivers/i3c/internals.h    |  6 +++---
 drivers/i3c/master.c       | 20 ++++++++++++++++----
 include/linux/i3c/device.h | 40 +++++++++++++++++++++++++++++-----------
 include/linux/i3c/master.h |  4 ++++
 5 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 2396545763ff853097d9f0173787e087f7a6e688..e6add862645196ad41d0c91d3d7103c877a1ef5a 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -15,12 +15,12 @@
 #include "internals.h"
 
 /**
- * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
- *				specific device
+ * i3c_device_do_xfers() - do I3C transfers directed to a specific device
  *
  * @dev: device with which the transfers should be done
  * @xfers: array of transfers
  * @nxfers: number of transfers
+ * @mode: transfer mode
  *
  * Initiate one or several private SDR transfers with @dev.
  *
@@ -33,9 +33,8 @@
  *   'xfers' some time later. See I3C spec ver 1.1.1 09-Jun-2021. Section:
  *   5.1.2.2.3.
  */
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers)
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode)
 {
 	int ret, i;
 
@@ -48,12 +47,12 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 	}
 
 	i3c_bus_normaluse_lock(dev->bus);
-	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
+	ret = i3c_dev_do_xfers_locked(dev->desc, xfers, nxfers, mode);
 	i3c_bus_normaluse_unlock(dev->bus);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+EXPORT_SYMBOL_GPL(i3c_device_do_xfers);
 
 /**
  * i3c_device_do_setdasa() - do I3C dynamic address assignement with
@@ -260,6 +259,20 @@ i3c_device_match_id(struct i3c_device *i3cdev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_match_id);
 
+/**
+ * i3c_device_get_supported_xfer_mode - Returns the supported transfer mode by
+ *					connected master controller.
+ * @dev: I3C device
+ *
+ * Return: a bit mask, which supported transfer mode, bit position is defined at
+ *	   enum i3c_hdr_mode
+ */
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev)
+{
+	return i3c_dev_get_master(dev->desc)->this->info.hdr_cap | BIT(I3C_SDR);
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_supported_xfer_mode);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 79ceaa5f5afd6f8772db114472cfad99d4dd4341..f609e5098137c1b00db1830a176bb44c2802eb6f 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -15,9 +15,9 @@ void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
 int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers);
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev,
+			    struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode);
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 66513a27e6e776d251203b286bcaecb9d8fc67b9..16a480865ff4a28857f1ea6df33dbe4a66d1468c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2821,10 +2821,14 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	/* Must provide one of priv_xfers (SDR only) or i3c_xfers (all modes) */
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -3014,9 +3018,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -3027,9 +3030,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master || !xfers)
 		return -EINVAL;
 
+	if (mode != I3C_SDR && !(master->this->info.hdr_cap & BIT(mode)))
+		return -EOPNOTSUPP;
+
+	if (master->ops->i3c_xfers)
+		return master->ops->i3c_xfers(dev, xfers, nxfers, mode);
+
 	if (!master->ops->priv_xfers)
 		return -EOPNOTSUPP;
 
+	if (mode != I3C_SDR)
+		return -EINVAL;
+
 	return master->ops->priv_xfers(dev, xfers, nxfers);
 }
 
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..7f7738041f3809e538816e94f90b99e58eb806f9 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -39,20 +39,25 @@ enum i3c_error_code {
 };
 
 /**
- * enum i3c_hdr_mode - HDR mode ids
+ * enum i3c_xfer_mode - I3C xfer mode ids
  * @I3C_HDR_DDR: DDR mode
  * @I3C_HDR_TSP: TSP mode
  * @I3C_HDR_TSL: TSL mode
+ * @I3C_SDR: SDR mode (NOT HDR mode)
  */
-enum i3c_hdr_mode {
-	I3C_HDR_DDR,
-	I3C_HDR_TSP,
-	I3C_HDR_TSL,
+enum i3c_xfer_mode {
+	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
+	I3C_HDR_DDR = 0,
+	I3C_HDR_TSP = 1,
+	I3C_HDR_TSL = 2,
+	/* Use for default SDR transfer mode */
+	I3C_SDR = 0x31,
 };
 
 /**
- * struct i3c_priv_xfer - I3C SDR private transfer
+ * struct i3c_xfer - I3C data transfer
  * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @cmd: Read/Write command in HDR mode, read: 0x80 - 0xff, write: 0x00 - 0x7f
  * @len: transfer length in bytes of the transfer
  * @actual_len: actual length in bytes are transferred by the controller
  * @data: input/output buffer
@@ -60,8 +65,11 @@ enum i3c_hdr_mode {
  * @data.out: output buffer. Must point to a DMA-able buffer
  * @err: I3C error code
  */
-struct i3c_priv_xfer {
-	u8 rnw;
+struct i3c_xfer {
+	union {
+		u8 rnw;
+		u8 cmd;
+	};
 	u16 len;
 	u16 actual_len;
 	union {
@@ -71,6 +79,9 @@ struct i3c_priv_xfer {
 	enum i3c_error_code err;
 };
 
+/* keep back compatible */
+#define i3c_priv_xfer i3c_xfer
+
 /**
  * enum i3c_dcr - I3C DCR values
  * @I3C_DCR_GENERIC_DEVICE: generic I3C device
@@ -297,9 +308,15 @@ static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
 		      i3c_i2c_driver_unregister,	\
 		      __i2cdrv)
 
-int i3c_device_do_priv_xfers(struct i3c_device *dev,
-			     struct i3c_priv_xfer *xfers,
-			     int nxfers);
+int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_xfer *xfers,
+			int nxfers, enum i3c_xfer_mode mode);
+
+static inline int i3c_device_do_priv_xfers(struct i3c_device *dev,
+					   struct i3c_priv_xfer *xfers,
+					   int nxfers)
+{
+	return i3c_device_do_xfers(dev, xfers, nxfers, I3C_SDR);
+}
 
 int i3c_device_do_setdasa(struct i3c_device *dev);
 
@@ -341,5 +358,6 @@ int i3c_device_request_ibi(struct i3c_device *dev,
 void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
+u32 i3c_device_get_supported_xfer_mode(struct i3c_device *dev);
 
 #endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index c52a82dd79a63436c1de6a01c11df9e295c1660e..7e22f9d2a2ca3f4ab808db50f809efd192c795cd 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -474,9 +474,13 @@ struct i3c_master_controller_ops {
 				 const struct i3c_ccc_cmd *cmd);
 	int (*send_ccc_cmd)(struct i3c_master_controller *master,
 			    struct i3c_ccc_cmd *cmd);
+	/* Depreciated, please use i3c_xfers() */
 	int (*priv_xfers)(struct i3c_dev_desc *dev,
 			  struct i3c_priv_xfer *xfers,
 			  int nxfers);
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *xfers,
+			 int nxfers, enum i3c_xfer_mode mode);
 	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
 	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
 	int (*i2c_xfers)(struct i2c_dev_desc *dev,

-- 
2.34.1


