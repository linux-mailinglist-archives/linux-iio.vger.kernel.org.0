Return-Path: <linux-iio+bounces-25773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FAC262D0
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAA0D4F5597
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5182F656D;
	Fri, 31 Oct 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n4YoWQiQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2A2F7AAF;
	Fri, 31 Oct 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928844; cv=fail; b=MfGO5rpZb7viTKbIZLIOmg3zOQRps4oqj7yG1QU7Hp9QM0zWTsceGwpG9Yhw1uEAQA6r2B4uVegUAoZce092GekJwPmkXRWkwiGy9+VblhY23zpSjaqYfOgty9+nWJJL9ANG06gzrK0DWjS7hjEwFEkdNkEhdz+sm2LaaJuBAJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928844; c=relaxed/simple;
	bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qUFouyXuJt65YAZHoHbjecm35jK5fP1HrUgoyUEHDbYxrvHoJ9yN2aLIZCvlRHoXfxEGGrzSA/EvN/SiLwfnqRyS4/hu8SS6DAENcwWhDx9PDmVroxqkJpFtIN/5nA7zgsDHPoVAtk82Yk4LCmCy1UD0fYnH951tufbMYvfDvWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n4YoWQiQ; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpUCpjbS7ddUOxwEJMQchUw7TCKbVvERBk6qUyBK+RD3Y7zxpkTyDS1dU20Wq8pCxXUko9sQM4SZXVy0AaSi4w0G9j5lQMzqk3pkRPlLFfFSDJL+d7nj0VFf9dnfVbFDV8SQwFhlQWQukp4AF4oz5pmTzDTrpBUH0EVPKdrx7yf3iRVuQ5rN0PipdzNAFbe7rRDHy+Nc7qYFXI524DmNm4ZhlMEXvEdMwGoQr4ejNOWT5ErJbxrkjS+1FCsaQtR4p6tERsJzlM5l3ihWzCr5p2kwItoARJfpBLiHb45fP0MDyU/tyo+XjLPeiYgu5dusKMSXZPAXcoKfkIgWEqL1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=n3j+VmMEUR+VVcbf0DTW16S0qiyN4/SpiBo5g5ipogHavXwkn6QZ61epVlhVA0AjLv7kTNZ4+KiIlXjgqCmTEdmGhJSQbiIrc9Gmf7LwNlVeJu1vD+MHEmh8dd0/hIYDgs35OiiEFemuFIz1sqQ06psc/s/0P4exFyy2MjDBPKf5MNAA3KAJnbr1e3txxUpVSRR7TuslgLTCuq4Y8bcMGae9x+UzCtIjQDU+BNVlRBZiMQIbZu1T1PhmE3zxD/Dk1+OhWKrqWt6tzylT5QVEOJWXUstFvyHRdYFPFyhdtl58q63vx3gio91IR8KLbLkSinXKbbzuy4Z9nFbNn8or/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/2t9xOxRR0k6wvZLNSCm6blXDZasSeQSURQqJNw5AE=;
 b=n4YoWQiQMZPEnO0ZWzosYzdyLW9gOaqladWGG/KLVsgU/rGhNHOkpX0NxiLqr18YqVmGQeqkpWM4KwvkbOzkzWLD/lwFgewTI8qzuu/7xuf20Lws5d1GNXFve9wuTCRS20faBY/ka475uqyWg0UzxSOBSkbXmpWiuqw8VYD5rk/mf6oWi7S1mx6f7M+yZGBOd9hIAcX9OhQY8Xu1L/JgGo0Kt0szjY0qT5yg9Jj2De5OlkdwfsTiLMNRzxQN1jL/xag8OLqXpdPstapaT7lrPzMr0x87b456BNgkqkEpTsVLeBceKFB8c22q9yHL7euKh3SNH/fPr9JZmS+3uUibPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:40:04 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:40:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 31 Oct 2025 12:39:17 -0400
Subject: [PATCH v9 5/6] dt-bindings: trivial-devices: add MEMSIC 3-axis
 magnetometer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-i3c_ddr-v9-5-f1e523ebaf78@nxp.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
In-Reply-To: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761928780; l=1253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IyO4gvDiMVkIrAv3wfTcayqnmwaqUsnJdgwnigkUdYg=;
 b=5Lxd8QztLrTXC4wIVh0bbyTqTk2ASLNyApNagheRkxcChZqcTko41dlSL3tRi5anGp/Mj1Oad
 rg52mFjpeh4DWWY2YmRrxrXa564q3p9lnuM2QguncVFr3CRe3TerYQr
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
X-MS-Office365-Filtering-Correlation-Id: 241eb36d-12d1-4ba4-ee2d-08de189c2490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blhjUFQyY3IyaUc2b3FhMmVId0ZYR1NSczlYeUlKMzAvWDlkSldyS2JTa016?=
 =?utf-8?B?N0FYMUhoNlBzOE91T1dJYU54SVgvaXIvbzBDdnJQY0tGRWNUWDBZSUI5ek1K?=
 =?utf-8?B?MUJXK2FwRWl5bTA1aWJwQkljZmEycjdrT0c0cWphaDhKQ2dkWHhhRm9NZEFI?=
 =?utf-8?B?UEM3M24rNHBLbkFRSWU3dmg2S0Q2azFmYll0bUxDbkxNeGR0dCszV1VRWllX?=
 =?utf-8?B?ZlRldVNPVnJiMXdTL0JTODZaeVp3dTA2ZjdwUXJmWStTN3VCdHZISWFidmFQ?=
 =?utf-8?B?OUFDM2g0L05SNFpRQWZIRTI3Yk9laTArLy9jd2JlcTc0cU01ODZydk1xRUZ3?=
 =?utf-8?B?Z1FmREpTTEx1aWZsdVZ2VWNuakFNL2dnOWo0dkdacURtR1FjMEJOekxvdjht?=
 =?utf-8?B?dlc4WWg1a3lWRytHTE9vbllDRnEzS2RqSU4ybnJSdFRqRjJSYTlnVFpVYnVX?=
 =?utf-8?B?UGY5elhRdlFFL0E1M1RyTGJvUnJXQ1Q2QUdyRUYzRkhNdEl4d25kMUZMWWM2?=
 =?utf-8?B?WkZrdzFBaGtMVG0ybXJRY3phWE5SMCtVRGpaVnB0WGIrSHI5VE9RMVcyTWlo?=
 =?utf-8?B?WkFDb2daSmVBTC94MDFvSWZBcW1CTVlkM3VTYWhoN01NV055MDhvZmFGVnkx?=
 =?utf-8?B?bk1pK2o1V1dOcDNudmIwR0wwL3FoUGNXd01XTDJDTG81bDkrenJ4Wkp0NnZT?=
 =?utf-8?B?Y2xrVGZHb1Z0QUlPaW0vaGNuUUs1WWtYcEw2bmNCLytaZzhwb1pvTkRaMEx1?=
 =?utf-8?B?NjBSRDc1NHR2elRSWjlUUUlJVFV0alBGc2Z4Z0VnS1ZqUlBnbTk3NVJaZ0xk?=
 =?utf-8?B?ZCs3MXpVRkFaOHJTNzRZbTdBaDI5WG5VL1NMN0hvYWdyOUYybEwzanE1WGR5?=
 =?utf-8?B?YSsvcFU4SWJ0QkhUdk9GY0V0UW5LYitTZ0c4UnZDZzArQkRyQWdjR3lHYUt0?=
 =?utf-8?B?WHRwa2dKdHd2bFpaK1NZRnoxaW9IdkNuVkNLR295VkdhVzlGc1BPYWlSQnZV?=
 =?utf-8?B?aElwSHV0T0kvL3VrVER4cTR5ZlBZanNVVTROMFRGVHN3R3llZUdsQmE3UWc5?=
 =?utf-8?B?WVhIV0FjOFlrdU5lOGt3ZXQrMzRWWW5ESVpRQndFcGIxbEcySWxuYTlsckpv?=
 =?utf-8?B?L0F0YzQ2U0lxNktVTnRLaFFkNk9qY1huWmI1aWtueTZnQlVqNE10ZHB1bDFy?=
 =?utf-8?B?SDVDVTRYbEJXRFFob2N4clRGTGszRW1qcHozcmN2MHh1alNrbE45NnNEKzRh?=
 =?utf-8?B?b29EZ0lWVnFSM0t5b0xwWHFsR0psM0MvU2VWWCszRnRLdFYxS2hkK3lZWUg5?=
 =?utf-8?B?aEJmdFhtZjZQcXNXOGxXcVVJSmhPNWFCTkZocGZsRWZHUGhPUkpETUM4UkVR?=
 =?utf-8?B?Zm4ydHNHR2xrZzYrcGwvclJTZVBHU0lTdFRubThsbmk4MUVqTWc4ZUZzcGkw?=
 =?utf-8?B?RDU0MFl2MkZNeHNQbkhWS3F1SlNOK3FZaEVxQlkrdEpzclB0KzdXOVdtMGVu?=
 =?utf-8?B?LzFQRlZEM0dWWER3R1FjLzdLNU45QmJZUExkSnhHZUpnYU0vYVF1TkFsK1hs?=
 =?utf-8?B?L3owZUdya3FPWHNNK2xRSmlVVERSU1JWMmo5cGUwdFYzZ1g3YVZlMUxZbCtS?=
 =?utf-8?B?aU5xNVdKZE9QdHlDc25sUzZpcXdDVnY3VWU4Vm1hU1cvMVRKSkpydmZ6d3Fs?=
 =?utf-8?B?NnE4Ky9xbnNkbm9jOWJHQk1RaWZyYUwvSVkxOGFiVVRlb0ovYnVweEQzbzlM?=
 =?utf-8?B?V21UWVpXM0Uxc0RYazJSdVZxOEx4eG1jZkkvc1dtdGVjc3ZvQ3UzY2tYeTB1?=
 =?utf-8?B?UE1YbFNNNDUyK0NZemVvem5PcWdBQ2dMVU5kQnZ0RmhTYTNOaUhVK1ZKV2tK?=
 =?utf-8?B?bFN3T0FEQyt5YTBOR2h2WlBpeGlOdjJrbUE3TXgrL0NIQndUempJUnhKMU5L?=
 =?utf-8?B?c3NvNDE3a3lJeGMwYXpUOFEvMkZMWjZvM25QYWxTQ25UMTYwZWU2S1hOVE5j?=
 =?utf-8?B?YWRxYjdSYXQ2QmJ5eVhhaWdWaTlLSlNnL1FRbFFCVU95b2YvSW1yZGozcDdI?=
 =?utf-8?Q?kOCMb7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1lRbUpjUlR2VWlBb0NtdlQxN2RHSUVlOWtldE9qcGxhOTZxUDJ6eUdWbEhx?=
 =?utf-8?B?M3htVGhpdHJ6M2RldmZydis2dnAyNXJ4b0R4dTdpemMreVFoNVF0VWRId2Jt?=
 =?utf-8?B?Vi9SaVF2OENKeE9WQlA0OVEwa0IrMlFvKzZXR3pWUlJzOVBKb1RuZVhUZFJl?=
 =?utf-8?B?VWppck1FOWx2TVB6bG1aVTNMOVl3bitybk1mVFIvcEtnNU4xRXMxVVg1bGwr?=
 =?utf-8?B?SWh1SFNMSlZXWnhWQmNNQW5QSHl0am1seUdLTnBZaXlremJhOTd4cWpaNy8r?=
 =?utf-8?B?cG1GbEx1RnByWEpSRTAvRmhDS2k0QUxwZHhadXRDUE9JenBjOW1qb1ZvUEFh?=
 =?utf-8?B?Wk9KZWRwUms4RXlrQkwxbGYycEd0MGFiekxWc09YaGN5TXIxeSsyWENOdGtx?=
 =?utf-8?B?Q0VyNzV1aURMa2ZnMlVZVEFldW1DdGFTWU82dFN0VXFTYm9FUjlLL1VQYW1C?=
 =?utf-8?B?ZTZYT2lVd2pHQVNJN0ZtNWxjNm9xdXJhMzI3ZWUzRTdpQ0F4NnZhL3BIT2Iw?=
 =?utf-8?B?R3p2QzllZzVJb05EZ2RkR3hFbjlDUXdqemZqSzVURVJqQ1dRUFFUQmpUYnJm?=
 =?utf-8?B?RWh6Z0k3cHNKQjBLUjU0VVBRRnozSzhLVEtOSmhlWUduS2dBMmNIdlMrczcw?=
 =?utf-8?B?cGRSZzczWnRsUCthaFFuNzNCVzF2b1JUZVhhQnVPY1haVFk1Z09JV1NjQ083?=
 =?utf-8?B?Ti9aNUNiRSsrV0xMNVV4WVlkZXRSRmdzamQ0SDEzcFZDLzdVSjRRSlVuQ1VW?=
 =?utf-8?B?OG55aFpVOW5uQk92Ums3UUFNNVNUbStPbGt3d0ZJSjBZQ1drR21vSE1WbWFB?=
 =?utf-8?B?Q0JvWGpqT0tPMHRxTXVLL25qOC82WVN3UGYxRnNZTU90NDl5dWFMM29JODhv?=
 =?utf-8?B?emFVUnBJSXlxQnlNKzBxeWkzSGhKU0NrKzJYdmJ1VkZtMVZaUVBiRmNiWGJj?=
 =?utf-8?B?eTVoaER0cElUR0Q3bWFaN3U3M0dyS2FrS2JmNFVpdlFLNmhDMGVkUzhjS2tZ?=
 =?utf-8?B?L2VLTHB3VjlTRWpjNDV5TERtQTNLa1JBeTlvb0s2SlBSUFNCRklqU25jcm5C?=
 =?utf-8?B?dlpDVHRBSmU3bCtjbnN6cUxnRklCQ0VYSnc5a2g2WVpwc1d6aE1ORWVDanRO?=
 =?utf-8?B?RmdBMFlOdHl3WGcvSTdGWForS3Q4V2w4c3hoY0t1c0hFOXZudWdCVGpYdndU?=
 =?utf-8?B?TTloUXE4QmtQdDJrSXBiOUxLUVBGd3kyVWNjUlNTLzZWYTArUDRaUjJKUEdY?=
 =?utf-8?B?WU43RXNSNHFHVG1lZ2NlUkJIZTNlSXpLMUI5SXdiWWZPcFVWKzdnY0oweG1J?=
 =?utf-8?B?YjBWazVwWjBLQnFwK3k1S3dCVk9mOGc1NmxYejY0Skl5dUtVOGl2UnVPUVdu?=
 =?utf-8?B?Y3V0dmJ3cDFUczBhdkg5TEI0YUd4OWp1eWJCaExrR2NRbmRWdFZndlFFTGZo?=
 =?utf-8?B?Y0xxWlEzMnVCK2dFak5uZEwydWppT0xDWHE5NVNlb2dQOVg2Z3BUMlZWMi9u?=
 =?utf-8?B?bDhnd2VmcXJmeWtpZjRpVEVUaHdVYWYxRW5ISWJVdU5sK2pPZlFVek8razcz?=
 =?utf-8?B?TEJJNFA4bWtOZWN1MGtBbDNrYXo1aDB3elFma1lJOVJTMUlxcytrU0JyUmp1?=
 =?utf-8?B?aDYxcjg4ZUxPZTVDaVFjVGVteDRiTktNY2kwMEMrcWs2Sm9DTHcyQkJWd0Y4?=
 =?utf-8?B?WnlQejdmSDFYanBqM3ZEL0pLQTN1aHFBamxBMFpYNmxjaDVaTkdBdUMzTm5E?=
 =?utf-8?B?b1hPNHBvNVRRZjRJUkpZRGxtcVAzbUh6L3l6STJRR3YxdlhDbUpsTEdoR1Fw?=
 =?utf-8?B?YmwrVmJxd0VBWlk5b2xyOWszR2wyeStDRlRrV29RYzR1NVB0Rkh4OEZZc0kr?=
 =?utf-8?B?TDRXdE9yMmtKSmcxVkFsRFdTZmhKemI2SjQrUWtTcVRhbWU4WDVsWE1qMUlu?=
 =?utf-8?B?NzI3aEMzeFFVR29RUWd5VExtZE9WQXRCTFFpcTBwZ0Vmd0FyTHU2eGFWbUlD?=
 =?utf-8?B?RlIwdGd2TjFBSFFJM05XTWZpNk83NkVsTy9jWFp4Sm8yajVwL1FnemFPTkVS?=
 =?utf-8?B?TnA2TXZWRlE5UFJ2dFdnQmdkc0J0VGhMRE03YkwydVNZTXA3TVlVWWx1UVlP?=
 =?utf-8?Q?kBhk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241eb36d-12d1-4ba4-ee2d-08de189c2490
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:40:04.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPueVkGZLFPhTdMABjxopBkaCagPE4/7eGtqdAebuHV2dd/zcp069EeNsqcymOsquCQXKt3KQ3M3iCw7KLcSpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

Add compatible string 'memsic,mmc5603' and 'memsic,mmc5633' for
MEMSIC 3-axis magnetometer.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7
- none

Changes in v6:
- add Conor Dooley ack tag.

Changes in v5
- none

Changes in v4
- add memsic,mmc5603

Changes from v1 .. v3
- None
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2eff6f274302add1ef8f6ae9ec9672697bc812ea..94fc8ff4504b5dc2c0fd7b384f6acaae3d5f80a4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -227,6 +227,10 @@ properties:
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


