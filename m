Return-Path: <linux-iio+bounces-24838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC36BC2998
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C679A350561
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B9F244698;
	Tue,  7 Oct 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TTU/Qi5d"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013028.outbound.protection.outlook.com [52.101.83.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116024678A;
	Tue,  7 Oct 2025 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867620; cv=fail; b=Nu4rM5G61k0MNk1tzjppzBfI6vZoW0PABRnIFiA0/ZlifjGj3LRQh5pw+5WDoVz1W+fwN+otrwBbQHywrySSPgh5kePbOt5USC9GAhXDbL/YvVPaGQnw9Ec+DtMlCyf5tI/218WOFSuxLH4zdqT360Q9l7OUG5Z3F21DnUQJ9MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867620; c=relaxed/simple;
	bh=oB8hNInmAqJKKzs/Srzrawh2yTT2662oVpY4ckrvcIw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pwlk0sLL4phu/58FGrANZDJXTfDnSYVeA9UM3DdxKJfgEn3IwdjzayL2f2t/GG1IwJYm4OXotn7IWbYlHKDykhvWveJhlneLMAoe3hfM3fT2b9FEahqz7GZoy411raiCQ+4jZcA/4Bfh/PIeEWnPV0S7ysXZUc6yeIRhJQ9KGok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TTU/Qi5d; arc=fail smtp.client-ip=52.101.83.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXJ5ji3RJG3WSut3w11NpvvQQi41sStwmcCAuD43VgvssiiFyATRsE0+V+NSqDGwcmax1CXfA9BBjKO+CzwtRHvRePxn5FTFLeafYKVO9hwkxIYXETu8jvCfh6Icm2ykSdmaOT2inp3hNi3MzdYJVysHKE8jgvVaXXLYK0RHuMVj86nGn6keOIIrxPINbH8o2F0VdJXxD4AyDp2acqpviwx2A3cdxkk1l6JECe4Rhd5RKM0ib30qjAxb5b9f9CyQM6L8Q6BJBzdFSgp4nbAcNGP35amQ442DEF4F220ixlSMT2ycF9amOOAflh1q9qLOWEys+93qNPKmUobGuxn7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoGGQW9bLiB/QKXcUQE/usMqkF5TLtPSFT9NdIxIVuQ=;
 b=WXVAwOGjKoCbFwtrxnt9trfwF9lqouhWrLq5JFtG7FZA73w6CjIo7FgORGE1aKOHaflpZj2qvE4SUHqVzmWUBkEu5JKUVTHZ2t/6uxMbF86CZmfS70BbyXtfFluo5tzwiGWUtj/sOWPBjZNBbWbVZnxNA5uvAcFZEHIWpVeQHQFRhudM2FGCadn9Ve7vpZ7qm/XKwFX3M4ZJLPPCrZEu4RndGuhLkrae87fQJKoRsv2srNV8D5gZf+AkAqLaDJYhKzbEfnS/VEVIG/DEKkwzzLZTkWuT3N2WsyZ5fiY923vD/QcnSOkyFu2WkkY+P1CMK1TRxSOH+yjXrymM67YUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoGGQW9bLiB/QKXcUQE/usMqkF5TLtPSFT9NdIxIVuQ=;
 b=TTU/Qi5daxr972Yb3jq3SSIdRS5Tjq/5gZvasf5hSEphs0FVxE4J+xKPgchSFGTeTTGet8o5qZ25ofZQqWhOhYeVJk5lnfFxyqg67eRyHlzdvrBC5rUr+cbnHjoLOvW2C7nFyBEmfBWVODWIeXRYVY4OVBWJ1rHhDSf8EdzEdkqoKz2lN+RW/q8FMGf9Bc1Tyva0G9xIG4RYXA6d7eUWD3pnDcOoTeAoY/YYgebiICqySq2XD+xOeuyjgdWDuXo7XY7biyur6AHWD92qZN+Gbze6Qp1ZosSBzTyxL2qJ5Gh9xPPBibKorUBTZO2YLV2QFcOsJk3xZ4qyIfAOajaEEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:06:57 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:06:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 16:06:16 -0400
Subject: [PATCH v5 4/5] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v5-4-444184f7725e@nxp.com>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
In-Reply-To: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759867595; l=1103;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oB8hNInmAqJKKzs/Srzrawh2yTT2662oVpY4ckrvcIw=;
 b=qoAYtGmz7yZ1ARkFucXVtTo2L8g1oabbj5QAZpSUid5hJHjyDZ/uGlZRlq8NfAhNM6X06g0t6
 Nxze7mMoXsFBAA+rzSey0jGQOp/ZDx7MLWZyv6EjPWFx9LcJwR6lSCu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:a03:117::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c5a371-b77e-4acd-60a9-08de05dd112f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RC9FUmpjZmdwV2VRZngyU0ZJdnVTM2VkVkttVjJETk50cFlpRlEzak5VeXJl?=
 =?utf-8?B?T0dTeHJ3VlY0MHhKSGpmQW9PQUVxK0RDSHJ1c0VFQUN1YUl6MEh1eEtlUEVs?=
 =?utf-8?B?YU90NXBmeGVaZGRmR2VEdlMxZlZ6c0Rvdk9EbGVsb3VzL0FlUUlHWGFGeHMz?=
 =?utf-8?B?SGx4L0RycEU0K3BEWitNUjNEOFNFd0JVSnRMSHJaVmZGR0tVZWhSM2Ztbmd2?=
 =?utf-8?B?L01FaHo2TFZSc2ZIOTVtZ1AzYkVETGphek43SndnY21jRktMYmxvTllEV285?=
 =?utf-8?B?L0I5UnlwS3lTREl6RmZsZzVWdlBQU01TbVNwd2RnYXNXOEVjVFVMOXBnNWtU?=
 =?utf-8?B?bjlIclNLaHU0amw4aytpOGREUjduK0R0cGFMeFkrTlhLZU9RZTh5YW1yc25K?=
 =?utf-8?B?K1htSTVYb0tpcnhyWnhaVDh6R1lmQys1bThKNUdmRTBqNldMS1hlUXNuU2Ns?=
 =?utf-8?B?eTBOczZFN2IyZFpUSlpFc3RmNnlCN3c3eURycHFxNFpGN1ptM2RORk1LeC9B?=
 =?utf-8?B?NFFScTRMKzVDazV2Z1ZQOE5LeVNoMlJoeEJ3dW1ZZThsb29tUm5sWjV5WW44?=
 =?utf-8?B?a3RqZkdOYk8rVW9yODJlM0thejZ2M01LQTlFTHFaU3c0UG1sZWt0V0xnbTNO?=
 =?utf-8?B?OUtXbGI2aEZYeUdaMys2d3Fpa3JoOE1VRjdEZ1gwZ2d4dFlNMXlGT2ZjcTRY?=
 =?utf-8?B?R3kreE16bWl6ZnZ0eVhSVk90dm5vSDRkM1Q5Q052Q0kwdzR3b2tuVmkwY2xR?=
 =?utf-8?B?bHUvdEd2TVY1M0V3RGpHUlRiSnljczBwV0FHTWtOdXJ6OXRLcWtGczhrMGJH?=
 =?utf-8?B?ZWtKRDB5dGRhNXZmS3UwYjRnRlhDdGhiMjdiRWhLeS9mY0dyZHpxTkNVNURY?=
 =?utf-8?B?TnZFS0kzM3hKbmhsb1cweEhkUmYzbDM3QWNBdVYwSzViUmk5UUhISXhCaTA3?=
 =?utf-8?B?eVlhVEpTcTN4bUNiNEFYUFp1bVVISTJEa0xwd1dnaTdoaU1LeElTVDZsREFr?=
 =?utf-8?B?aXNPMkR1QkhQYTllVjRSNVhMTk1CN0JlMVhkb3NYbTkzeU04YXVtVTBBaTdz?=
 =?utf-8?B?NjR4NVkrRnM1NURGU25DdGg5amxrNndVWnR5RHBWbk9vYjlvUUw4QzFMT1ZW?=
 =?utf-8?B?d2F3TVF2YkFvT0xNZ3lVME03Z3VxMjRqYzhvSFIwMG1wZGs4R2kvVk1TUkJr?=
 =?utf-8?B?c1h6amUxZUZVei84dlVpT1ZzbVJXc2pQYW1Xa0NtSXhPclZROWU1bk5YU0lw?=
 =?utf-8?B?dFlWRWNWK083YVVlaHMxUkNYblU4MjMxUlV5VlBTQVV6TGFIYXVJTWZraFZP?=
 =?utf-8?B?NkhRVHFobko2WGk4TXFiNmxRN1o0d0wxbFhVYTJ5dnd2VUNPdVNrOTZZMElU?=
 =?utf-8?B?WW1tNHVzamZEMUxPaUdyeUQ4WFRKVFFocUh6QWppSXNtbXFQK1VyTm5DeHVS?=
 =?utf-8?B?amJoQUk3WnMwWmdXdVNoSmQrRGFrL0NSUVgrOVNLZVlldHRNeHdSSFc0Skwz?=
 =?utf-8?B?bjhMbkpmVlZlWGsyOVVSZnlMa3h6bE1ERmd3NzNZTXZSclV2dmhCYy9LZVov?=
 =?utf-8?B?bWY5MFhqS0FlaVB4SWpDc2p1TTcxUTJqQkl0Y3hJVmlMWUUySDZoS1F4Sm1K?=
 =?utf-8?B?dVU2TEp4YXF5Z2xKanZGTzUwU1VqNHZoQkRYZ01JbWw3VlpzOUR4dlY0RmVw?=
 =?utf-8?B?dktSdUhnckxSODh5czloV3VkVzlpTU1yRlNNbE4xdzdLQU83NWxRelFEMDR4?=
 =?utf-8?B?VVpMcFBsU0RhRFRIeDErRFJHQ1ZCQ1c1Uzl0V0NjL3dicnZYMTNCYkRsTHB2?=
 =?utf-8?B?ZTY1NlNYVHNwbUFyaCsvNk5pU0pVYXFVY2ttamI0T1NmSkpzZjB5Q2htRDZ5?=
 =?utf-8?B?b0k3RnBnRG1jYTRFUE9rcmdWOEQ1TzdiZHViUnY1UkVsNzV3Q2VmOS9wQmZN?=
 =?utf-8?B?VUh2MGw2cEpPVFVIbGdSUTVvMjdBeld2TGd5WHE2eE96dWxOZnIzZkNrbjBN?=
 =?utf-8?B?Umg1bWhmdW8yTFEvZlQwZCtqbGNCT2lOanNWSmtQZk5aYXZhV1EvZXo5VCs5?=
 =?utf-8?Q?09U+gJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzMwYVJIbitjQ3ptbVF3eWJGWC9teUVWM3RnakxYS0tMb3lCdTVETVpjbzdP?=
 =?utf-8?B?dnZ4RHFCaFdVYU9ydjFhUEJNOVl5NXh2WkZNbEF5Um93MXJhNzgzVnJNdkph?=
 =?utf-8?B?TWQ3YjR5dHVYOXJJck04Ny8zY3EwTlZCUmNWbnNzR0IvTG5Ia1lrVS9qNVNX?=
 =?utf-8?B?MmNSbU5oMmhzTXRNdGJvaUpwS0cwZnZhVzYyWE40R2lXSUFhbnc0Tm0vd1kw?=
 =?utf-8?B?a1BVbjZUZUd1YS8xOWZNYzlsVEFQaUZSbjE4Tm5yY3ZwSEsrbGlpU1F5SDJV?=
 =?utf-8?B?M01DR0NNZVZJcTJHQ296Rk1rMENyVTYyZ3pLbDBRS2V0RzdPNlcva2VQNlJi?=
 =?utf-8?B?eEI5UTRXNURzeUl0UG1vZGx1YnF3Uy9QSmhicjlaano5RUd1dlN1dWhWaTdz?=
 =?utf-8?B?eCtMZzhJTldiaThzODBYaTQyMTM2Q2cycWJEb0g2Z3A5b0sxbnU3OFUybW9i?=
 =?utf-8?B?bUZKcmxYUzluTSs5OUxvcEhnR3NQdngreXNKeHhJUlZDVldrR1ZjZ3R2QkJN?=
 =?utf-8?B?NWRPTzdFUHYyY3czUGx2T2kwU0x2bFhPMGpJREx2bXJDcjM1NUFIQTBEQlh0?=
 =?utf-8?B?bWVVZVdKeHRlbndyZG1YUFkrejBiVlYyWjdKUWt1MlJOOCtua0RvQ0dZMktx?=
 =?utf-8?B?emprTjRzb2hHbmYvc3U4R29oZ1pKVUdacEJhZ3RmNXR4ZWJUbU0xelpPTzVu?=
 =?utf-8?B?NjFJK0I3YW5kTVp3NUxDU3pycWNGZDBib0dhenNjT0VpTE91NzlyNmd4OTAz?=
 =?utf-8?B?VkI3YzJya1ovakMycldpZWJua1AzVkR1bWhVQzVQZmRtZ3p5N01lWXVYbXBv?=
 =?utf-8?B?eGZ1ME5jSTI3Z1l4TDlTK2YxSzdseERMR3JCZlhneGJWeVd0dXZkb0ovdG9T?=
 =?utf-8?B?c1g4R0NTM1h5dEd1cERNM3FhZ1A4eWRGcFpNRHp5WGtnVk9Eemt6MURHc3BG?=
 =?utf-8?B?RVZEM2JnT0Q4R2lMVHZNMzd2bG1teVltTjNpZmlaK1Z3Q1ZZNUc4U3NMR0Zn?=
 =?utf-8?B?MU43U2xjSUJpZjBESzFzWGY3OHdHZ1FrYll4NEhjVEVrdVh1MWhtamZUenhp?=
 =?utf-8?B?R2JMeUZMWVRqVy9qb2JDaXZqWXRtRFFDM3d2bFp0d1BLbGx5VFNoNEVCZ2FY?=
 =?utf-8?B?VWtSTGJEQkNyeHY4OFcrVzhrWjdYSFY0dFdmODE5UHJESjNzZEg5YW4xTmEx?=
 =?utf-8?B?ZzRiUGg3Mkg5YnVtN0xHbERzWE5vZ1p6WkF4TlhkbUpYSFVVRExPYTNpS0hY?=
 =?utf-8?B?VFpJRmlVc3FQKzNXSEtTNXVnbEwwY0ppeGgvTG81Rm40VEZOMzhOTko1TjZv?=
 =?utf-8?B?QzROeWQ0bkIrN1VVRXF0a1E3aXFsMjdtT2JRSjUxRDY0bzhGdGRjWGZkUE9s?=
 =?utf-8?B?ejNFVGNCNzNFVXRRdkZuYnA4eVB3MllNNWRYSldidzhhdmllL21VNiszSTF3?=
 =?utf-8?B?Wm5JbStqRG9QSFpoVWFNTXZVbVdsV2NiUTlnemkzbTNSRC9jQjF6RkoxQTlw?=
 =?utf-8?B?VW9mMlliMVVRcEIvNjhoekl2QlFDSDhpK0M0cXZSUE5rVm13MFZSVy9WNjdW?=
 =?utf-8?B?WkhzU3pvWERSOW9jNTgwRmEydGphdUViU3lwOXEyamU3Z1lpYjJCaEhueDdB?=
 =?utf-8?B?ZHYwaS9UTWhXTUhUZTJVMjZyeEdoLzQyZVdBYXlnTkxvYXZVcUdoclg1K1cr?=
 =?utf-8?B?eGdzWlc5NE5zT2VWdk5NNjFmTEhTUEhxWlorSjlqeUI4NzFlT2JrcE1WYVdG?=
 =?utf-8?B?NERpMEYrS0s5UDRWVXRmZ2s1SFhjaVAydlJGSHpDeHkwYWhpZVRCZ29vZjBn?=
 =?utf-8?B?OXlnaXhMbEtWZFpRQVNPb3h4MW9tMTc3TTFZbGdEQXJLcXpxV0VEV3J2eWpq?=
 =?utf-8?B?Umx6dWhVRTVsSlVuNlNlSmZaRGRYY3JaU3RYVHRDU1drQld2UWVaVkNnVnUr?=
 =?utf-8?B?OVI5QmpJWGw5VkppYms0Q1lMc0prbHBnY3JKaXE4N1p3UVBFQ3Z3WHE2R2lN?=
 =?utf-8?B?Tkx1ak9FT1hJY2trRDMxNlhkS1ZONEtreVpvdU9aTFBzN0lIemg4S2tqem4w?=
 =?utf-8?B?UUlkbWVMZ3oyQ29YZzR6d2MxYXRDc0FWdXhrbTZzTTFnVzBZcHloOVdqUVY4?=
 =?utf-8?Q?0nXjrSo+85lDH808ih5TRoQVx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c5a371-b77e-4acd-60a9-08de05dd112f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:06:56.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0jHd9PTQaf5ZH/hL8HM4LbwVwwJU1w8aQLRHJ1uwz7o2KhZ+ET/vPk9TELZ7OqBhg+SLIgyXw+5dCihuX4GUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424

Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
MEMSIC 3-axis magnetometer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4
- add memsic,mmc5603

Changes from v1 .. v3
- None
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7609acaa752d5c1c89a26bb007fa38357dee1a28..72786eebfbd63beffd2a09fc20c7aedbe9e96a8e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -225,6 +225,10 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
+            # MEMSIC 3-axis magnetometer
+          - memsic,mmc5603
+            # MEMSIC 3-axis magnetometer (Support I3C HDR)
+          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer

-- 
2.34.1


