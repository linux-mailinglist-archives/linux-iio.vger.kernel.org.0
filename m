Return-Path: <linux-iio+bounces-25883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBCC31EAE
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD5718C4781
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD81270EBA;
	Tue,  4 Nov 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hSgvtkJM"
X-Original-To: linux-iio@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032C212542;
	Tue,  4 Nov 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271247; cv=fail; b=ej6Q0jFcAC8g7FDQiu0PZqEZZUgZ4Qgks4zhz0VEIZH4ywpCo5Bm017T4XEXw6g667KbLIdtXevWQD8WqGNeKZOIZsMoKIAAi8l6l6cE0j6u4p+y/K1kBiv3FwsIIRJdvU9zIajgJ6zixLBdMuZa2507ofMrgOgJ84HgmYVWD2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271247; c=relaxed/simple;
	bh=nfUvEqWXcFESCbLNz9cnelUTIiVRBvwROcQdGc/WY1s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=g9okfNdnovkgwRxzX0UFC1Cy+JR8VmQAoBiqpzCjle6Se+cmCqNpLUBDW7lyuYYbXxr/9PWWWxPmnoE7HLe4l1lpJTNkYko0ZNCFDTAuSQcFXYl5dO8DzvlVG+kMHZPXbO+7E4uWXDpH40PNuEyxQ5nIBfb7ZYfomMR47BaohZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hSgvtkJM; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydK+yYgosKKnLp8XWFpls3Haqo8MDixrK42IvlMtrLIM0DVn6fyTodSD0JrGs1DG1bgmoiJvyotqS0KO9STvEcFfsXKCv1r9Jp/hHEt9PpKpqumZzga1qwHFWBU9Lj/n4Vy/s+6Wav+7ViVX2o7sApySRKPznqlQ7zOcL1t+X1n0LN0KSnnU4pC71OM5sFNo2oCfxCnozkE9ISVeM+9FKaIg2StjBf/gC5LO0a+4vFgkOaXuQ+aUYTdMoamv02z6+Yd6fv1NbdouAmtWbJY9fWaQik1sDVDA8Lbou4QFXgKmn00x1GfVrC+xOngr0bA9XJFI8Th2lmj+06R7bPsjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNq6m1a7aTjs61MNZ2Nf2PJUpIDM2WR9H9MKooxmDLQ=;
 b=Bq7QrtEmV6WqiRgpC8VlmjUmyC4beWdpdclvsYF9XJy7Snw1xtKk1pI0+8SXs0ybMMknlaKiNcvNdZbVBuXzPweMbVyj7SapViPqVjHYx1jpCNlBNs4Jz4T0IRCLUN+o5/EzDkaJGCNNUfaaB7RsRCYX3eQKMPatnmsYul8IkkgxfJpegAnCZfxBZ1PsX0Yf21/ZOsYMMlZ9OU5z+6uURBCG/Fsaa5HZ6Ki7vOKCan2nx28Im5SihrPyjeSlIirh2o9MpR2C7fXmdwcQ3+RoER1ukVa8R1ciFTqCzjzp6p67p1CHKmxd+RB/QkLAWkPWTjK8GmxdIV2mKkbBw8UN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNq6m1a7aTjs61MNZ2Nf2PJUpIDM2WR9H9MKooxmDLQ=;
 b=hSgvtkJMBfK62tJUclpcDSkOURYmvRPhv6vQFmJXkdIEVGivXX5mbUglmE7log7KPCjoHISSEy+YMgRA5U3COYofWL/kNGLzDWgatTfMgfQEWNKfJ2qSkNVZgZCFFbnRFWhR4ev/5XqDuV5mELM6Do93rZdHqKQLvrkcL6ez16IA9rLrbMbebKi6uCTpwydfTe+t6CBE6D0mFY5gHYG+lHigPS6R1a++J7T7od+xpSw561uOa/mbWJbHwBe/tX5RANlGjjoJ3M83jPCKpwZUZkDFXm1009lJ4RRJu2KWEdZLLXRIH6ajvjdEwKsoGgDBIZQa0540Ll9O9+rd31fpLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:47:17 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:47:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 0/6] i3c: Add basic HDR mode support
Date: Tue, 04 Nov 2025 10:46:38 -0500
Message-Id: <20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4fCmkC/3XQTU7DMBAF4KtUXhPkGf+MzYp7IISceEy9IKkSF
 BVVuTtuhbBTxHKe/L2R5yIWnjMv4ulwETOvecnTWAaQDwcxHMP4zl2OJRAo0UhA32U1vMU4dz0
 Y7ZyXwL0T5fVp5pTPt6qX1zIf8/I5zV+35hWu6d+OFTrZSXSBgolaoX4ez6fHYfoQ14YVq/Koq
 8KirMMguVdoCPdKNUrJqlRRvUWKA3KCe6V/FUhJVemiVEgcSm6IzF6Zf5QpSmsNTiciNLxXtlH
 Q/Mv+7NKeSIGkvaJGYbOLinLWBpkSpUHbvXKtclW5osibyBFj74a7a/hGKajKF5WADSruQyJX1
 bZt34S+qk9NAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762271232; l=3637;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nfUvEqWXcFESCbLNz9cnelUTIiVRBvwROcQdGc/WY1s=;
 b=OLBz9Egiv5dsFvm7wTxSjrchRCK7wSVznPlxWOj4QX8lyh5UDMfycAa7F1juw6/mWK+sq9GDC
 8h671tUr/xTDFh54ipW7sNa9IFNuqyQTkL9jH+ixofUGErpXstD1ynH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 07654ce0-5c6f-450c-5b70-08de1bb96e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkRlM2FvbTlsaFY0R3dpRW1VRHVPVi84NldCN3dUZ1A3MlBKSm9tbVVvWXhh?=
 =?utf-8?B?eDFPRTVrUXVsdnBYMi85eERDdmhWSDZlUDBLYlo0NFpZbSs2Wkc1VUJ4WnlN?=
 =?utf-8?B?QklBdUJYS3FPTkdqazg4L09ERWNQR1gzQUxJZk5UQkJrNE1EN1lnU2E1dXIz?=
 =?utf-8?B?eXhvdmoyYnl0cm1yVDB5SFNMQUxKcitLSlRMMXVML2w0c2ZWcjR2YVoxdW9q?=
 =?utf-8?B?TUozSXdseWtiaXRpUkVHNmI3NXNRQ3h0dnpsd0JFbnJNSG9tV3NyaVdsWWgr?=
 =?utf-8?B?SWV3cmsxZFdJek4zOWdROWJqbDRZMUtmNi9iUjJPWW5DcGJGOG5hbE1Na0pi?=
 =?utf-8?B?V3l1eUZCTTNoUTZjZGhNbzZjcVZPSlJCM24ydnRzZGc3TXVJeTVQY3ZzQ3hI?=
 =?utf-8?B?dllla2I0dUR1KzJybnVpUFhoYy9QMytKSTQxT2ZRbVN3QVJ0eWdvV211NnVS?=
 =?utf-8?B?bTdmSlE1TUF5MWxqRlYzTlhjcytOcm1MNUd4TGQrVklabjV4N0tEOE5JV05Q?=
 =?utf-8?B?QlNDUWlkUFJqVzA4WENVNzlhWFBHdTZwcXp6d0U0ckp2MzVLN0VSTWYvQ05n?=
 =?utf-8?B?Q0NUWExUcUJKVVN4eS9TNEt2bDRjdHovY1QreVF6RXhKUklLS1EwZUx3dVNS?=
 =?utf-8?B?bGI0YmdtUHI3NlU1ZGFSbk9uQmlWSVpuVCtsWjV3VGNUUEVmNWNmYnhvNkt5?=
 =?utf-8?B?dHVONHI2TytqenFPUS9TbnFoNFpYKzM5ODcySDdYOW1EU0l2clpUOWkrK0tN?=
 =?utf-8?B?bklLZ0hheGdtNWpUalFrYnZva1hCTFprSzRnWnFWa3M2Zkp1VkFsQzFCWmpt?=
 =?utf-8?B?cnN0RVorM2JhNERmSnV6cWpuZnhWc2w5cFV1dDAzbENIbVAzdkxZVjB1MnJV?=
 =?utf-8?B?VTZQbXZEUk8xaldDZ0lPcEJQa25WYS9rTzFzeTJFeXY2YktWWGVUcEtqS2Nv?=
 =?utf-8?B?NkRBMTVTS0VEcFVjeDNMdDlQdTdodFlkcXcwM3Z6QVZsNEswUHRlL3ZBSUVy?=
 =?utf-8?B?SEpjQlptL0dLSjdFMUVSUnE1eENMVktNTkpXanBGT01oSDhFUFRtbHNDeHRI?=
 =?utf-8?B?cHdrK2RVUlluOUxaenZuNXo1cGduV0hyb0R6cHA4Tk1vd2pzcTI5dG5sbGVQ?=
 =?utf-8?B?MHlmRU5RMnMrMWgwKzBkKy9yR3A5UENST0s0elQ4V1c4clBVZFpCZW5GalUv?=
 =?utf-8?B?UVdKODJBQlllUlQ0b25GeUhrMW1DNFlCYmZiZS9HNWJsOVkvbDM0Y3liY084?=
 =?utf-8?B?bTJGdE9YY1RBZnBaYWFhYWFlanpTc0JGQ1JGa0ZuMHpJZktYc1k5eFlXVlJB?=
 =?utf-8?B?MVZhZFA1RW5vOFV5QnNtVmhLSlN4SmppVWJqeGhyTmRzeUNTN09JYVUyM2J1?=
 =?utf-8?B?d21XcTNKNFlWeTcwemNtQlkwblpDOEE3SnNHY0tXOU1IMDBpUzhFN2dkRzFp?=
 =?utf-8?B?UHNXM2R1Tnl5WkxhYVUwNnc0T2UwK2xHWTl1amVDQ3ZWbDlRK3g1TUYrNUxK?=
 =?utf-8?B?L2NoK3lSYjRvMEVoRjd1UVJqd29BaVdiWlQwNWU2ZVo0RTdXVUp4Y01xZ3ha?=
 =?utf-8?B?d2lPMHdoVWFTVHBhY0lTNE1rMGpBMU5sUkgyOVJvY1k2NmR2bGNNdW5yVmdj?=
 =?utf-8?B?amRKeUd3M3c1bXp4bk5mRU1RM2VpV000UFI4bkxlbUZFMFRjTHlHc1B6TWJU?=
 =?utf-8?B?TUpkUklzdUFHbEQvMXQ0d29rVjlROWJjWlRRdzRBcm1EYURKMUxRcGRsSUlX?=
 =?utf-8?B?Sm5NZUoxd04zUEhvNjhaZU1tVDdxUmtyVnhMd0plTDBsdzNXTkZGNm83ekZ0?=
 =?utf-8?B?WWs5SUpvM0xpQThobFV5ZzBFbEkyWlJ1L0NLYjJxMzRubjlyb045L042WlBS?=
 =?utf-8?B?bVFPbTllbEhzMmdjblM4R2N2aVRyb1g0d1JxT0ljVVBqd1RCaUF0Mis4V21P?=
 =?utf-8?B?T2RObmN3a3JWN0pMWHdjSmFuMVVpZzFtS0FNRjI5cFlMVFEzc0xlZVNLRGVh?=
 =?utf-8?B?ZUtwcTJ1LzRHemFzSnBIYkpNeEJQbU5FRjEwSVp2SGpaVjRJUGhEWEVUVVIw?=
 =?utf-8?Q?HdIyr9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXExZURzVTJvL3dsZ1VqODcyVUZqTER4Q3R1bEwwdUdOdmNmVUl2R3pCVkRX?=
 =?utf-8?B?aGFKem4xb3lHengrYzdLQlk5VmprRHcxbHN3SlNNRnkrVlY4MjI5WFN4UXBE?=
 =?utf-8?B?VDNYSmFid1FHQk82Mkc4Y0RxNHJHYnVzQkRxOXpBa3FzU0xVWTd6THF4V0Ur?=
 =?utf-8?B?V3g0N1JscDVEU3o4bi9pMTU4ZjFuUGF3Rkpod0FQYWo4YTZEUTdGMitaMUF0?=
 =?utf-8?B?L29GbEdVZ2h3RUtsV01TaE5MK0E3L3hNVG1hbHZRUDJlV1FuRzBpRjlXeVpj?=
 =?utf-8?B?THZqUmxQaDBJTjdoMW8xRVVZRGhrMDNndnV2OGI3ekpOeVF5dDJSbFZnbzFY?=
 =?utf-8?B?b3JDaUgxSVpQTlVYbkg1R3B0aWlUS2VyYnQ4ZURXNERPV0tTdzlIZWJWakl2?=
 =?utf-8?B?OUhyakhsSzZkVElGNTJEOWErYkxnYW9CNjRReHBIMnl3MGpVWUo1dm9zc3dU?=
 =?utf-8?B?dC9RZHoyQjl6eEp0d1p3NmR3cDZXNXNlT3BjOWJ0V0VPY2hiUVJHNGZSQnpi?=
 =?utf-8?B?SXBlMThXOTBPV0xzcXkwb2lZUW0yMVlXY252TnoyK2VFNHA4Umx1YnMyajQ3?=
 =?utf-8?B?OENhZHMwL2hCZWNKNnIzV0E1Zk9CU2VjYktKdnoxNThsbHBJMDV6MFpod29Z?=
 =?utf-8?B?WUorZjgxZ1g3MjFONWEyNWljbEsvRFB4bmkrdG16S0xvM2Y3NzJQTCtZSmFT?=
 =?utf-8?B?UllPS0FKNzUxM3IxdFc1Wnp5VFdQSEw0VFRSMUxCNC95QklNdmVkMTBsWUJa?=
 =?utf-8?B?NlNkdEpmWkJmbGl5aFFmWDVTYkdNWE00MDlRNENuZFhmV0RJeERKUWVXMWJ1?=
 =?utf-8?B?aUdjYnV1QzRTNWluSld6U3l3L1lFRU1ybk9keG8yQW9sSXp2ZTlzMzR0S01n?=
 =?utf-8?B?QzkxZzBabHE1RHF0MVFCM1Y1Nzlhb3hnN0JoYTZZSU0yUC91WGtkZS9vTzdm?=
 =?utf-8?B?WmwyM3ArTDZUOEVROXlyZ0hlamI0Ukh0S1dyWGFmaGVQYkZKSEhTRHlXV0t5?=
 =?utf-8?B?SW1LcnMyakNvczZXR1k4KzRQUlZvb0g2ZEJBeU9RZ1VXRk4xS2dWTndFNFRK?=
 =?utf-8?B?cTk3TVBSczlocVE2N3FUTlNkVEs5b3RFQjkvclU2dlAwaWRlbFBFdkFkMjVs?=
 =?utf-8?B?Y1Jua1pybEFiQk14amtTaUU2ZkJnM3MrbnVOY0tSdTlLNWNEVFhvdGRhVkgw?=
 =?utf-8?B?aDY0RnYvY1VEeWNzYkFKRnp5dmZ4LzZWT1BZeTk3VUFUWkpxcEd4dE8wcmsx?=
 =?utf-8?B?djFIaVFiRmtjVjI0cTh3bXpxYWdReVpwYVlibFJpS0VzTjBWLzZZcGNZVURp?=
 =?utf-8?B?WjczNnNwV2JUYXlGQXBoNkxRZjU5dncrYTBGVXZMYXljeWsvMTV4bXN3K2lN?=
 =?utf-8?B?VHVvYXJCL1hEZTZsYU1PUis2eHJScjlHbjNxcmx0emFNdVVLZkZ1dW4zR3hi?=
 =?utf-8?B?NVJ2WC9hVWtUSmp2V1BYWDlLMGZScFB5bWxTL21HQmlKQ1cra2xmY2R0RkF2?=
 =?utf-8?B?K1NUdDJGSjl0em5XemlBOXoxUy9ac2pWeWZVejBqMi9QaVVscTN3eThBc2kx?=
 =?utf-8?B?OWErR3lzd1VWanRKQndVQmYrTU51VjI4cXk3TGRmYlp6RG5wOHN1ZFRmbnBh?=
 =?utf-8?B?aEgrcTN3NjZuOEVBOThrOGZQQjZrbWQrbWZ5dE5FalhWZVM2SmZLZFREYTZ6?=
 =?utf-8?B?U2ozY2xJMm1zT2FGSmQ4ejFPQXRjeFJhSERyVllmMGN1cHNQelRJU1RLNWNS?=
 =?utf-8?B?RkR6WUxKWFA2YlVCUmZiNnQyaXBHUTlPZFJKMWM5ZHUvRDBjSVREd1ZjNkM0?=
 =?utf-8?B?SUZNNk9QejE5a0JpbDF2OFBuY3JmY3hMeC9pRnJaUlFhUlk3RkdsMWNnNTJa?=
 =?utf-8?B?NG1jL0E2bWEycGh2azByRmR4NkRnRytKRmgzR2E1K3A4MTBWVW1HV3R1VTA2?=
 =?utf-8?B?c3JhYWt6OVgvU3M5aWdYVUVWMCsrbmxINHFEeFRyaVlUcXFZeXFEZ0wwcW1X?=
 =?utf-8?B?cnlUN3p0OUpuYWUvQkVVUnp4dzdRZjJnMGVONCtxS2dFN3RPVjhQaXBKai90?=
 =?utf-8?B?S0phT2FNalNjTFJYS0o4LzBzNC9GQVBpVTZ1UzVPdm9wd0lVOWZjL2ppWndi?=
 =?utf-8?Q?Gzh8hLx2KlDrz7fiuOTQtqXdD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07654ce0-5c6f-450c-5b70-08de1bb96e6b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:47:17.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpsWUE95PjOWhMtpimu4A7NBXVo3bsC9QW8V+a+ixJ5lzY1b2e02r6RyvalsKiZNVjr/NfY+flFjHV1BTIRoGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834

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
Changes in v10:
- remove !! at svc patch
- align datasheet register name in mmc5633
- remove reduntant regmap_attach_dev()
- see patch's change log for detail
- Link to v9: https://lore.kernel.org/r/20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com

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
 drivers/iio/magnetometer/mmc5633.c                 | 588 +++++++++++++++++++++
 include/linux/i3c/device.h                         |  42 +-
 include/linux/i3c/master.h                         |   4 +
 10 files changed, 774 insertions(+), 44 deletions(-)
---
base-commit: df05ef50ada6a8e2fe758adf1b8fa35eea801b2d
change-id: 20250129-i3c_ddr-b15488901eb8

Best regards,
--
Frank Li <Frank.Li@nxp.com>


