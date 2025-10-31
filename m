Return-Path: <linux-iio+bounces-25772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3BC26303
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057DD189DA16
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CCA2F83C3;
	Fri, 31 Oct 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CErsIqtn"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52AA2F693D;
	Fri, 31 Oct 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928836; cv=fail; b=gQpQM9Cef45asiJy18X8B764TuIhlo/BliO/RIMUUOWkL5JIuN9F50qC3auyvOTgAnKhc/ditpaKU3OlfynMmmzIW9Dl0xAJmCJMKE1zgSXCTt+mtw0e2XIi67il26UayPRBOjW70xBllXnYaPpLVx8TztoK1x4lYU/k/DOl49c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928836; c=relaxed/simple;
	bh=qTffBCdu8Mi22zZGCzL0uFmkILG2U6LbqIh7+jK2h4k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jc6Yp/igIxnR8uykb8V4OsaK2pjsQUXntAWKTGDmnw9luuKORaOHElHECqVgekHMl5wJOWxmbanQ2p/Ye7oOXSIa5IZxksH/MpNgF5busVpu11yQcqhJMgxvnalZ8KpLthv+s4eZXdNsmyYunaRrQGCBrHSgwwkEefRgfrj9uRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CErsIqtn; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBamWBGqLHsH7L5dGerMyIrioRymnof1Jcbbe8yVFuo9sqokzcF+DbznyS+sKoBaPnJZoOSf+2xX3fTaizBbRi0cuNJQ1g0CJdL5JJT56GIauqwvXjNuKSb7ebTv1m2oQVR0QbHMXq4cBdBXkvprRw4IYFCNETCycwi/ZRnLPYQj3r14Pxezg/L8sCTeuNQNpwGaDptFQK5F+HL2RBkyBVDxIpq6ZETH6S2iX7/gzwjN5mh/MZt0R+hOFv5p1DUEOZdr26MOCVa2yaEc1dNDPUQqSbvhQf+S4/9Kv9PIlf7WA4WcXd2WHc9bObuAZcfOIQ2d3SIofPjwosuuTkUqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mizs44l9kM6gfuXuMhguTCgPiOcdxwSSLKRegAmEMuw=;
 b=Rb0Z0iQ1qq3BFegwmRxl/LMshgDY2TwUw859exTSeqz7in4dk90Liu50/8OXdRjNm2lx3xCzGxUpd8knXIfYPkiyoq1CCrCfn012Gl45+5qCnHuTGqDWmd3ict+N0c2mrd1wfTiDzYbueHAIhYUfxQLFKALCJYWHQ7+peAgastKaPYb0JuBjnK2WwHQBu85xs/QSyw59Qbio04633Dl3fhKoScpskxnkcRa6uRZWRHzO9e8jmzuAWCsnVOgJKYiuioDzQ7RSAT/bMQ6U/K+MZ50DrwTJTa7YErjzTK+YyfrjBk29Cqus6sPgaAmGP4wKUhxqcbFUkN2YvfyRXKTXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mizs44l9kM6gfuXuMhguTCgPiOcdxwSSLKRegAmEMuw=;
 b=CErsIqtnYr8PSF4LBV2ddTFzqS8nM/anKzVvFvXNcIPrxUeQWtZi15Ij14PHDrowddGBt2p7if4hmDvZMvcGBoi7NwTTqmsPADt3zi1uHNaFp+wQK7i6PBfy4KogqTv9s050o2CenEHQfaXf6pVuW/DwFvKc1qDchiDbXfMlDOXo5UlQxRdf53Uj7uGkJ4b6OEGmcy7sjx+oqoXB+tseeQWAhGm1zsMbzBKDSxcfCUgyqhCBjSfQHMswV6LFOAfRO6nEOjTTiwt6Sb4tFsqHPcVwkPKRioOmVm37ozMhqvkFonbOvbtQ4mfHHHDUtpoXykmXQ+EmikCj+8meAP7Tsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:40:00 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:40:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 31 Oct 2025 12:39:16 -0400
Subject: [PATCH v9 4/6] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-i3c_ddr-v9-4-f1e523ebaf78@nxp.com>
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
 Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761928780; l=9137;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qTffBCdu8Mi22zZGCzL0uFmkILG2U6LbqIh7+jK2h4k=;
 b=TJV/JZoT/bJoII0g1HQapd+WtVHHxgxkqzVtDrEJs/dbkTcmgcXRB3KmUjI3ufNtKYWFzQvVk
 VdllsKSOjX5Db8GqhCpmWCLKxgIKEw/buwz2K5/I3/bXnhI06+YhDm+
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
X-MS-Office365-Filtering-Correlation-Id: fad75863-21da-4035-f6aa-08de189c2218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxaUU1OQ1hKSnJiT1JFazgxdSsrUEYzODFxUWR0SmdqenhRQXpjTzFsSGNu?=
 =?utf-8?B?azRGaGR5U2VPZGgwOFNPUk5NN0JBdHRnd010VFRiTll3T0wvdzR4bEZsQk1v?=
 =?utf-8?B?dmN5eGJwWGEySkJDOXIrVHhRb1ZpcFpvOHJVUUw2MTdEOFNzQmU5eFpyYjVJ?=
 =?utf-8?B?eGMwbWhqV1oraFQ5cnZtNkJjOUlGaWYrV1ZaQ1lMdjRaMUs2MDROL1FtR1hP?=
 =?utf-8?B?bmtkMlh1UXZFNFUxZ1lBSDRFclBHNVhRVHlqODhYUmhPbG5sVGl0Rk5lQ3E3?=
 =?utf-8?B?aFpzYjE0Wlpidlh4ckxZZndsRFJRNHUvRmU3QWtBTENKNy9HckZOS1NBbEVm?=
 =?utf-8?B?MjZNVDR4R1FqM0NVV0tuU3dObzcvbStXRGpTU1Z4U0UzMlY2eVRPTElBNHFL?=
 =?utf-8?B?b3IyZ3hiaXpKOTNycFc0c3NDZjBTSlQ5QTQwdGEvbDN0eXVLQVE4OWJvM29I?=
 =?utf-8?B?alZLVTJvazczblhEbGREayt3VlpKeGxaZW5sT0Z1eVNCSmlZVVRwU1RnbTJu?=
 =?utf-8?B?N1c3Z3c2MEFjRnFpVDBqZzhpSmkrZnA3dkg3ZFVVSjFZOTZsQlFTWGUwcWNQ?=
 =?utf-8?B?bXhickdYMkU4Zjg1dU0xc1V5ZXVNS2IrZzd1UHlwaFNxdTJjYmdKSkdsbUZm?=
 =?utf-8?B?RU5zZGFIaDVUZ3NMYWN1N25meHVpYU9aeEZsTGE1aEF6RVM0QTdlcDJ1T2J6?=
 =?utf-8?B?YTl1b29aOWNTRU9sN2VhdnRiekJSeVJna0hSZGhZajlWNlRVekZnVDI5TDNC?=
 =?utf-8?B?endEUmtsVVFKQzhpNDJqMFdaNngxMDA0MURseEVaY3NPVXlQa3J0RnRxZzB1?=
 =?utf-8?B?ZElnN0t5NFhRVEVUUnNJSW1ybnRzTXhDQmg3Q2JRQmRtNlI0VjJPdjRZNHJ1?=
 =?utf-8?B?K2hNNGFNOEx4blFCMnhRd3pQMmRlU2VEdG9RN1hWcll1MHBLcUY3ZzNoMDVI?=
 =?utf-8?B?a0cvMHZDUTlrUWt0dE9aUkdLUmJwc0JXMnlOendhekxLRjVyRUpLZXVtU1Bz?=
 =?utf-8?B?WEVFWW9JalhUSnBwdUV4RndlblAzMUM4ZCtuYW5FZHorU3hWak1nQkwyTFFB?=
 =?utf-8?B?MURiZ1ptVS9iMHhkQ1VKclpOMjB2YzN2YnFOQjF5R2k3OU9SdHhCRXI0ZWhk?=
 =?utf-8?B?bERFZDY3cDhvbk1oaUNrL0VOMEVLSkR4bFlTQjNjY0pFeDRTd09qZVhzRlhS?=
 =?utf-8?B?TGR3QnM1cGUya2tBOUlwRDVvNm9oWGw0MUNVVE1BREtaYVpqeTJXSmNEeUxv?=
 =?utf-8?B?RHVGWnQxR1daMk9JMFlpYXE1cmJZL3VVUXlPbVgwZTNocjE2M0M2dGVERlhK?=
 =?utf-8?B?cExNdHJ3WURtd0x1OWlHWHgvRVJ3VWZWSnFFZ09PNEh3cEpjMjlJenFwNU1N?=
 =?utf-8?B?Z3l3RnMzT3l3Z2xDbUdaWCt3YXVhV3loaWV0Vy9nd1BMdUx3dEFzSCtrbkp2?=
 =?utf-8?B?MXI0THZRalQ4ZG5KNEJ5VkdpajlVbk1scFBTd0NwTWZ3RXVMbXkrTGpPWGth?=
 =?utf-8?B?WWZGWGxpSmhobHdER0pIQ0Y5SmNhL2xpNEMwdC9TazJndUE0Lys0bXdyZ0ha?=
 =?utf-8?B?RVY2aTNlL2tsdGFpOVpCYllwanNtUjdMR1JpZmNCdVN4bXZObzAvOEJTWFdE?=
 =?utf-8?B?RkszZGViTDZWY0ZkczlqVG1wNWJIM1Iwa25xMis1aVJOeVpKVXBDUGtoS3I2?=
 =?utf-8?B?YnVhVmFPL2pSWFlCTmo0MUphK0hCeTMvc1pVdHdyeWViZ1YrSEtIbDVhOXJH?=
 =?utf-8?B?bDJrZVVvNWo2UXo3UUYzUkdhT05RU0hlSEcvOEV3STlpdVJpQXQ5RXk2NVg5?=
 =?utf-8?B?TzN1RzJCc1lzR1lKWTN4MnMxMVRZVzk4UWZPOWlsSTh5bXhGS24zemxraDNJ?=
 =?utf-8?B?MjlKZVNDMWZhSjFGaDlVbm94Y0I1Q2FlWW5sbzA4bXkzbUFmY291c3EweGQ0?=
 =?utf-8?B?UnFTZjB4TkZHSFB5U1lQazBaVlBXZWRNZ254ak9iRXhOK3BNM3B2c1Q4TERH?=
 =?utf-8?B?dmJScDJRdFFHeHdGWWltd21kdHAwMmgvYklVb2JnOHNEOGtWREdSVVQvdDkr?=
 =?utf-8?Q?dYFmt5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z09leHhDejk1YWl1N2gzYnVuVFJYaysydTdtSVVIVmJjbi9jQ2M5L1BpZ0Rz?=
 =?utf-8?B?RGFHdEp3SW42RDIzc3RpYXBvTnZueXREWkJzWndrNlM5c3ZSMzRIQllzMTk0?=
 =?utf-8?B?UVhiZHZObEU0TWR3OVpvLzY5ZDVPck1ueFVEZWV0eTJiNXJqNXpxT1RLMlRU?=
 =?utf-8?B?ZXZtbmNMcmxtckxVTUN1ek1JZ1VWTnVRNmtKVTVsZ2VtVncxK3ptS1JZanow?=
 =?utf-8?B?YUJMWE5KTzNEOG1CQmR1YWhYcEs3NzB6ajk5V2tBMzl1cXJEWE1ESGVFSmJi?=
 =?utf-8?B?aEdpYUJXaldvZndkMGxlZGI0WjFLYVRYUUxZK294UjN1OVY4M2thcjRocXBq?=
 =?utf-8?B?b29KSjMvd2t4WFQwYisyam52UTBWYWowQkhjV1A4MEFrNjY3eVJKSGZ0RzJI?=
 =?utf-8?B?aUhVemY2UktCaXh6SHVlQkdQbUhTVWRUWjVyL2RyR2pHLzhoODZKRVFzaXIw?=
 =?utf-8?B?QWgrZVY3SnRsREI5eklXNWFJa25qRjluN0puUjJEcmtzTm4zTmNxTDhQMW45?=
 =?utf-8?B?UFkwdzNzUitLK1BTVTk4V2JCeHVRSHFaZDhZVlJuaXNKdlNHRTF3TlVBc004?=
 =?utf-8?B?b1dWUTc5RTR2QnRJeFBkUWpNNklOYW5QOFNZUHM3U2VPck85Y3AvZ3RjQVZs?=
 =?utf-8?B?cmtwY3hhNWp1Umh2UjN6bDVXbDVVT2Yzc2dLTER2RWhFSXRyYm1tbHhMeDJV?=
 =?utf-8?B?ViswYVlCRDBpZnZJVkxndkRkK0N5N3daV29XMjh3WkZuVXJsSkdsTEtSVndC?=
 =?utf-8?B?SVVRcFFUQWxkZ1V0K3ZQSXlXSm5TL0R3bUU5REg4cGxwcUpybzFrczZ4YnQ2?=
 =?utf-8?B?eEkzb2FvZEFRYmZMNTNyV1RqLzR2YWRYUEM3OGNiOE94UmxyZ1dCZGluQzlh?=
 =?utf-8?B?UkYrczdWRUlhNHFBQTFMSlkrajZETjR5Vkl0eW0vN1UwbURReHdWYXZ6bXFr?=
 =?utf-8?B?TWFhckFyU2tyT1pndjJidnRmWEJvSCtVYlNhZWRVNnR1SUcrcGNPRlR5dzMv?=
 =?utf-8?B?cXVWTktJNTRKWEU1M2YzTndxdkdLTTZlUThDV0dmTkJCd2RRUHUxajVRektH?=
 =?utf-8?B?TUN2VGEybXlhN2d1ejZ4WjhuWjVlY1pnaUt0dDAwUFZPZ1EvdkhYOGJZQzRy?=
 =?utf-8?B?dFYxQVV5b24wRmJrUUdZYUVxdkozWEozQVBRcVJNU21KQ2FWNkpJbmNzeTZX?=
 =?utf-8?B?bWwyVEVrWnd4Q2Q5NzMwblo5a0IyRHRsZnd4WURoNHp2UGlGbVNKRk9VTmg1?=
 =?utf-8?B?QkdnLzUxb29iL01QRk9HZE9JOUluZTgwVllPT0lHOFRENEFIek5SVGdKSE1N?=
 =?utf-8?B?MmY3VTNUL253UUxkdW5HNDhsU2MxRXlLc1UzL3FlaUF2QmRXZ0U5MnV3VEgx?=
 =?utf-8?B?aTJBT1E4aE9ZNk5uYkdKdk9CSmcyV3dFZkpMQ04rdzU5Z0txQkZ0NmROYkNK?=
 =?utf-8?B?Um16KzRML0lZbzRTZWRvTDNCN21zVEhrOFYzbW5DZUZmdm9hNHgyWWNxaWM0?=
 =?utf-8?B?YXZtMHZGSHpDay9ITFlaUG1BRVc0Y09SZXRtUFEybzNEK0lyU2pVbUpZcENi?=
 =?utf-8?B?bEp4Z2Z5U2NtSThwa1R1bDM4V1pLUWZDeFh3dEZ4c2c5aHlSZi9GSk1QektU?=
 =?utf-8?B?ODlwVXFwd1V3TVFsaFhQL1hzY1k0VFNHdWw3UW55dkNqcUp3RThDNHlNRTFD?=
 =?utf-8?B?T0dBcE9wSG12NmtMT2F0aTFZUTkxVXZ2SlFmSVBmNWNzUUQzbmYvTTFWd292?=
 =?utf-8?B?YTFtU1hJZ09Nd2d4dUg3dkZsa2NYd1V2ZVdIYnNSaUovU3FlOE5KNXNCbGFZ?=
 =?utf-8?B?d2lkQ1FJSVpsRGRhaTRUclhEUTNYSDJ0eHZ3U0g3Q1RYVFprWWlJM0lldVdO?=
 =?utf-8?B?YXBsN01ub0c3SmVnVFFGWU5LY0JoK0ZlVTM4elB0N0VFemJKNk1DUE1XV1Q1?=
 =?utf-8?B?UUZ5azV2YjI5VDNibmRSamVUUXhnMlRNVFVZejZyQldVZTNZZXJGamw0djk5?=
 =?utf-8?B?ZXNiQXJjNUg1TUNQSnlNLzEvbmdFUUJDNi9IeWVrMU43cTZPMjBIUE1TTUJV?=
 =?utf-8?B?bUlLalFaeDZoRS85eXVWUFVsbEtQSStBMDJPbyt0S2Rta1R5V3FSOHZRZ2Jp?=
 =?utf-8?Q?k8EQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad75863-21da-4035-f6aa-08de189c2218
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:40:00.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/bAsa5hxhe+S1wIhjSZs/6cpcXAwc8uxKgF/9khHNM25ZxPlsKzNeT9zNF+tJHh2Fr8dAj0WP9iDPqLZRfkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

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
change in v7:
- add comment about why need check return value readl_poll_timeout()
in svc_i3c_master_emit_force_exit()
- add comment about why need udelay(1)
- remove reg = 0;
- chagne to use readl_poll_timeout_atomic();
- replace all i3c_priv_xfer with new i3c_xfer.

change in v4
- use hdr_cap.

change in v3
- rename to svc_cmd_is_read()
- rename to i3c_mode_to_svc_type()
- use local varible bool rnw to reduce change

change in v2
- support HDR DDR write
- rdterm unit is byte, not words (RM is wrong).
---
 drivers/i3c/master/svc-i3c-master.c | 96 ++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7c516e05d0a1a118479ee3d8ea8ae37ae19fea57..a732443caaf15a2f6e54de46bbafdeb3fc9a9296 100644
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
@@ -174,7 +177,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
-	struct i3c_priv_xfer *xfer;
+	struct i3c_xfer *xfer;
 	bool continued;
 };
 
@@ -389,7 +392,32 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+
+	/*
+	 * Not need check error here because it is never happen at hardware. IP
+	 * just wait for few fclk cycle to complete DDR exit pattern. Even
+	 * though fclk stop, timeout happen here, the whole data actually
+	 * already finish transfer. The next command will be timeout because
+	 * wrong hardware state.
+	 */
+	readl_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, reg,
+				  SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+
+	/*
+	 * This delay is necessary after the emission of a stop, otherwise eg.
+	 * repeating IBIs do not get detected. There is a note in the manual
+	 * about it, stating that the stop condition might not be settled
+	 * correctly if a start condition follows too rapidly.
+	 */
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -521,7 +549,7 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	 * cycle, leading to missed client IBI handlers.
 	 *
 	 * A typical scenario is when IBIWON occurs and bus arbitration is lost
-	 * at svc_i3c_master_priv_xfers().
+	 * at svc_i3c_master_i3c_xfers().
 	 *
 	 * Clear SVC_I3C_MINT_IBIWON before sending SVC_I3C_MCTRL_REQUEST_AUTO_IBI.
 	 */
@@ -801,6 +829,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	info.dyn_addr = ret;
 
+	info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
 	writel(SVC_MDYNADDR_VALID | SVC_MDYNADDR_ADDR(info.dyn_addr),
 	       master->regs + SVC_I3C_MDYNADDR);
 
@@ -1314,6 +1344,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+			if (ret)
+				goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1407,7 +1447,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1420,10 +1460,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
@@ -1433,7 +1482,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
 
@@ -1480,6 +1533,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
 	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
 }
 
+static int i3c_mode_to_svc_type(enum i3c_xfer_mode mode)
+{
+	return (mode == I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_TYPE_DDR;
+}
+
 static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 {
 	struct svc_i3c_xfer *xfer = master->xferqueue.cur;
@@ -1669,9 +1727,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1679,19 +1736,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct svc_i3c_xfer *xfer;
 	int ret, i;
 
+	if (mode != I3C_SDR) {
+		/*
+		 * Only support data size less than FIFO SIZE when using DDR
+		 * mode. First entry is cmd in FIFO, so actual available FIFO
+		 * for data is SVC_I3C_FIFO_SIZE - 2 since DDR only supports
+		 * even length.
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
+	xfer->type = i3c_mode_to_svc_type(mode);
 
 	for (i = 0; i < nxfers; i++) {
+		u32 rnw_cmd = (mode == I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
+		bool rnw = svc_cmd_is_read(rnw_cmd, xfer->type);
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
-		bool rnw = xfers[i].rnw;
 
 		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
-		cmd->rnw = rnw;
+		cmd->rnw_cmd = rnw_cmd;
 		cmd->in = rnw ? xfers[i].data.in : NULL;
 		cmd->out = rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
@@ -1890,7 +1960,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
 	.do_daa = svc_i3c_master_do_daa,
 	.supports_ccc_cmd = svc_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = svc_i3c_master_send_ccc_cmd,
-	.priv_xfers = svc_i3c_master_priv_xfers,
+	.i3c_xfers = svc_i3c_master_i3c_xfers,
 	.i2c_xfers = svc_i3c_master_i2c_xfers,
 	.request_ibi = svc_i3c_master_request_ibi,
 	.free_ibi = svc_i3c_master_free_ibi,

-- 
2.34.1


