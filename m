Return-Path: <linux-iio+bounces-25992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D86C3CDFB
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E62934D9FB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65434F49A;
	Thu,  6 Nov 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eNt/kw44"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54534F46A;
	Thu,  6 Nov 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450600; cv=fail; b=POeCNoNIqpgrOaaQbf2kKBskzxg46XQ151pLbA4YQrvkX9iSPGDHmib1QcrBV+qo7y3r9djqCMWtSvYNlRnMoLASIJ+yIiQl6iNgLqCixZYs4WErJqPzYG4Or+povoGeOnsuPonADgeSlgqxynUv1YmHarN/cq5wEZ5u50Wxt6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450600; c=relaxed/simple;
	bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iTnxQ2zxd2/awFGIG/h5To1y5Gs2l3z2NFHJmq6P2cxo93mkrl7ch7SlNDo7NZha9psmcsYvBaO3OgmHbXoLunqlur3BKi3Ss+N522pwn4uD/YfezMbHkO0uHnts2NpxTZO4fXmkzEHJw5khhr/SsR0wr7T7tqfIXZm9j0Nvv/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eNt/kw44; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYyovGNxUsEJ/a55n5EsmqUWvU8Dgr3w7tg91Ey96XrWhKIyX013UyZL04IJzp21UsaJFSEEbQlRNmUc17zLVAuNEl1xOFhsKQdCJNIZxs/V8D2Wn5fiEBntwr7cPXjGuxc+2LCRDVy5wHTENs0uKkI02+5VxxpX3oov9aq4/88/xX+Nfs7Wv+0jDbae1W/0fet+qozBuvtkf6K6Be7BdCnwI28yJYio2gMIqgnPyvoaCE8SCb8A2U/pggjFcUgszoHMocNXkVaznNYfWANWZYeUMCevrfDyjpJr/OVPn0zBhhQs63ktCmKvgz3bJD8LXaa33WKs9KJSWtE4K1cYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=IRS421sAVdh5SBURJ7gQZY4fq751pT2NubBhengc7gKHSc/QUdTjF857MAFSleA9BGvneEhjqpGVTlidaVwe3/qbZy85SjUEcH1Z6oA3PZ/tk8wDMF2vG5RvDpPQurnq9KLAL7/UdrQt1kAbjoYSB4TZYcZtlEJv/v8KtaPcJxb6mzHvrXpTou4PKfMoMhMUQymxNmp+Bxhil44eV/5rJAzafpW3Vy0N4TpT5h6zioU9j/xH7kYvRwoqKtOkQ0JXXdfbx8kSBcbnL8teV797Ry8xPoIvRisqB6GZTNyC2AZEYnu9JgPp1sQlzbu/NUMs5MrTGGbIH0r7kig8EeIseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=eNt/kw44nPqtFXlHFM4q129ydm4Dq/rFrzAcw777TR4jBERU6mkNrMNhLndGvbNg4Xh28NDcm6p3dGcBwDrVq7xY+9Ju6bisGWfGtUseSM3IGELOVByOYvIbNtQOLpqCWunbCH/L0VRWcm2fSdWpS3ioXjwVZrnJGeplR/M0rVgLIlU9gAigqxyduVixUD8gAdm5cY1R41uKA+jsfgq6wCyQdWnQM835hMZRLGZHd6DqiIhJTJRMtSXPRJSpaIwRpJzbZHfxLOU59ARZPWVa8cvG+BRZnKT8IkjYP8TSe6OHm8UTNyaL6r30jdZKfqBBAEbZ0BPUcGXgNgRq3uqEUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10989.eurprd04.prod.outlook.com (2603:10a6:150:200::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:36:34 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:36:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Nov 2025 12:36:02 -0500
Subject: [PATCH v11 3/6] i3c: master: svc: Replace bool rnw with union for
 HDR support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-i3c_ddr-v11-3-33a6a66ed095@nxp.com>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
In-Reply-To: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762450581; l=3017;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
 b=h/GIAgpXBVBMSmNhJmqocLypsA7JAfCxAjZUbbKeQ8q/jzznNz8az4KeCkQsJtkGTnPM7hAWT
 8QVVyNQ2gEwBb8P3cWx3A7AJG1rWp6rDFiA12+ANZVEG/FHxojSxBKp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0111.namprd11.prod.outlook.com
 (2603:10b6:806:d1::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ddda24b-a866-49f6-6965-08de1d5b07bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXFyOHZSTkNzWUVqU1ZLaGhPWHJZb2E5UWNyQ1hCOHFsaDF2aFg2cXVRcG42?=
 =?utf-8?B?c0NabER5bU1tRCtiTmNrcnJqd2Y4bnUzWWVZdUNxc2treE9ESE53dnVETlpQ?=
 =?utf-8?B?dXNMczZwelVSbEEwOFVrK0dXQndrV0d0MWRYSXdBTWtzbVFwVVZwbnZXdVF3?=
 =?utf-8?B?L253VkNxUldrQk5FNWJzQU12aWVVZ1ZGZnJlMEYzMmdEYzMwNjhlR3FTRVF2?=
 =?utf-8?B?TS9RNzBQN3hFQlRGY0x4WXoyUm9USlVPR29mZ0VXbGFzSmpNZ2dGU2hXZEJj?=
 =?utf-8?B?QjZ4RDN1c1AvRlU1Q0JldXhJMTEwUlYzYzNvOFV5bW1sem9hWktWSUpnRnM3?=
 =?utf-8?B?Uk01ZFVYMjdKSVR2NWw0UXRLVjIxSExMaGE5Qy9UVUNrYUFvb1dQM3ZndVJp?=
 =?utf-8?B?M0FROFlUT0NNU3NmSXM5T3NXWERXZWpsUGJlZUNFYUJ5MjdRUEF1aG5IM3Rl?=
 =?utf-8?B?bFc1aVdSeW9DblA0bURFODM0U21jN0hyQU80bXYxTTFNeDNDUk00OUlMS2F5?=
 =?utf-8?B?N2V5YWJieXZSTG82WENlUWQ2SGhlUnBPSXczaXpKMmNDK3NtbVZzNnE5UkFM?=
 =?utf-8?B?YnJ0aXJKeCtmOU9hK2FNV1RSWFE2N09QN2F1eDFjUWk5bGpXQjFnenVTYS90?=
 =?utf-8?B?b1VvTGUrU3dIbmZNbm5oVm9sTXVuZGphV1VxUXJna3o0bGIzTE84VE9lanNT?=
 =?utf-8?B?U24zWitoMWNZR1Azelgyc2dUOEl0dkh0UEQ3RWV0clE5REFPcU9RZCtGSFFB?=
 =?utf-8?B?UG1rekt2OTR0RjNQenhRclJlT0tkcS9ZY3ZNWGh3aHFiTEdhd2xtNE5WWFVl?=
 =?utf-8?B?bXdob2I0YnZwZGpuVWcyTG9aQk40bjhZTXFranhDSE9ubmJGcDlIVzBxWG13?=
 =?utf-8?B?R0dtT0RXeWJmelY0R3dxTTVUSnhyWTdpeEQ3dU90MzRPOGJ6K2xXeElrZmla?=
 =?utf-8?B?NlpsMkdHUmRSemEvWE92WEgvYzN1VzBoa0pncXAwSGpONklHbDdiMWEydWpR?=
 =?utf-8?B?ZFVHSlFtS21hQmw1Q201TXUyUFEyYjk0VER1TjM4Q3gzYko5UUhub3JyVzMv?=
 =?utf-8?B?aGtnMzhiZGF1eTFSVTFlcC9sV3o4WDF4NzZ0U0pDczJsTDhlRDFGSUlIa01Y?=
 =?utf-8?B?aUdPRzRVQnNmekE5bzRmMW5MTFJBNTRRNXZibTlzL04rUDlZaUEwRTBVSlpE?=
 =?utf-8?B?SjB6UVo5WjZmTWhUZDZzNU5HMjRhTmc5YTY4OU9EbDBaSlllS2ZzUGdnZ3g4?=
 =?utf-8?B?U0JhdmtUaGJydDgyS0xJOU11UDhYUXl5TTVxMDdsTkRqZm1VNE1ETko1RDho?=
 =?utf-8?B?Y25IaFl5YUFOL2NXd2IyMFNMTUxJVi9LZHVYZ3EwU1VtOUpycEVVcmdjMDhv?=
 =?utf-8?B?ZFM2Q3hDWEVNYlFFZ2pZR1ZiaGZwVFIzekVSMG9CWjlLV21KT05heU5pK3V2?=
 =?utf-8?B?c2Ivem1pSXlRb2pUY280ckkzUTVTbUw1U3ZDL29DcXF1L0ZSdTE4ajJwQWtH?=
 =?utf-8?B?NFZ0VjJ1NVF1RHhIWnNTVTJKdCs2d0NaNUpCemxnbVFsQzI0UXdqQy92Vlda?=
 =?utf-8?B?bHJtblYzZUlHVHhPUzArTmNHSDFrQThQR1JyQTM2Y3hWVzdRTTBqZnhVWGdY?=
 =?utf-8?B?UzM3bHhNNk5DNkZySE4rZFpKREh5bzhYMHdlRXdpc3N2Z2hvbmVJSmNydjNW?=
 =?utf-8?B?MG13VmwrbHlNb2tzbXlwTTlBRmsraVJJN1lXcVl5azduM25aNEc3NkhuNFJa?=
 =?utf-8?B?V1g3T25sNUREd1RqREovNnJaYXl1Q0hHTWJ5bTd5SUxLU0Z6LzFvVkxKT2t1?=
 =?utf-8?B?SlVlYjRBcDFXS2VUS2RxWndhYXQ3cjhqbUJlUFhMQm44VVg0ME5qbHVUWlY0?=
 =?utf-8?B?MjFEMmFKWUw1RUFoQ09FcVpLUHlkajlmdHF1RlBsWnpnL2lBNHI3VTg0ZDNQ?=
 =?utf-8?B?bjZyeUR5Z1d3V3dmR0s0NnFwaEZpekVVa1Y3dFFLSE1lYkp1TUI0MzJpeUJ6?=
 =?utf-8?B?YWJMbjVqVE9WekYvMEN3WE5uL2UzOVkxbFY0MCtib1hWanpiNUt2MDdEYVdt?=
 =?utf-8?Q?Y0XimW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDlnM1V2RGVVZTFQZVJFdFZ6Rm9lNjI1OGZHSThWQjE2NGtuSDNtRnVBeDlx?=
 =?utf-8?B?QkF1TEtZLzJpck5WTm5mNlB0cWJoV002WW55WmI5b2Y2Z1d2Ym5xb09hb1Iy?=
 =?utf-8?B?amFiNFJlVmFDdm9WeStmc1BNWVdlcmFGUnVobUxSUDVZTWIxRVplRzRKaCtN?=
 =?utf-8?B?ZTQ5dHhQOUVOdk9sV0M0R2tyUFV4dFl4cklwbTRhWElBVEZTVlBPUDFVVEFi?=
 =?utf-8?B?REpXeW1uNVJVSkVYNWJFMGFpNEpuaDlBQ0tGR0g2VnVUMCtqb2E0WUpVa3Nh?=
 =?utf-8?B?VE90RlhmNVRYTE5qWW82MTgxd0xCRnV0dHJkTlpHVi9HTURZOW5CSGg2QVFG?=
 =?utf-8?B?ekFsdnUvdnJDZE50bnRteEM5YWxsVjZnZEFjLy9uZHpGYWJtRk55amZTS0Ns?=
 =?utf-8?B?NkpZUVNUYmdlcnJZV0FZWHVTU1VERFY3aFVta3hiTERvQThBaHczRjNFeG1Q?=
 =?utf-8?B?amxBVWFOUEdZVGhIb1YwNkd6YXBrb0FmaUNVdGx1ajdCUFlsU2VFbmRvWFhC?=
 =?utf-8?B?VnVCTjl5MzVjSlpMTk1VU0xuRkRIYjdPMitoMkM2M1Y4aHRwZnlBalByRnA3?=
 =?utf-8?B?Uy9oY0hMaDV0UTI1YzhpZEpZY0lId2hiN1JhalJyMFBkM1VRemdmVHNuRE5s?=
 =?utf-8?B?WlNQZWs3KytIMm9sWm4xQlozSzdJUldFclkxODFMT1FrRnZaaDN2NWhtejZ3?=
 =?utf-8?B?bXZkeGs0dEJtM25Lalk2VWxBVVp2bkNXWXdxQi93SjVDVTd4ZTlsbnpQZjFO?=
 =?utf-8?B?ZlA1OFplMFQ2elpDZTlmYmhjVlgzMWlrTEVxRTFpZUJWcnMvZDB1RDJzRVBK?=
 =?utf-8?B?WlJjRGdjZVdrU3NIRURTcGhnN2xTL2wzM0txOVFZZmhmaUVPZ0JOOG1PcXRt?=
 =?utf-8?B?NkVwR1ZyRTUxeWlCTEoxcG5PVFlaMGt6Q3cvSzdqeXNvN25udGZTSjRnZmFp?=
 =?utf-8?B?K1NTV2RUczVPYkdvVFYrRjY1d3lPM0dCMkFCNFdodHFGeWNQcVpnUmNHQmJV?=
 =?utf-8?B?Nkc0V0tFZUZrVk8zVFRtalVGOTcwYVhIVUxEbkNETnRka1R2QjJpOWlNK2xt?=
 =?utf-8?B?V0hiNnFBWTlNOC9YaWpVY0NZOWNqb0dldE1JUTIyRG9IY09xdXcwU3UyUlRk?=
 =?utf-8?B?UDhVRnlLVFo3aWlLaEx1bTVES0RyYk4xdTR4RStrakVVNDRQalhHazZPcEpT?=
 =?utf-8?B?NWlJejgxWTZ0dnBiR2ZTM3EycjVMdTJwV2FiZ3JvWTVUeVdPMUIxdjZtRzVJ?=
 =?utf-8?B?NVN1OFBEY2VDQ2NINU9FdDR3ek16UUgvdEdOMldidWNxVlNlM3NmQjkzOTNw?=
 =?utf-8?B?UjNld1FTOWlybkVpbmk1dGU3ODVScG01ZkJRSFp1bjM3NTZvWjAzZnlwQW1V?=
 =?utf-8?B?RmdhSWlXSHYvUE5vemxSYXYwS2UvWE90Ny85UXlrQytRZkV0aThvbHVRdCtm?=
 =?utf-8?B?enV5a2tzR1lKbmxTN25kRUZkS0FwYVR6VitPaTNURkRZR2dTYXBHaVlIaVl5?=
 =?utf-8?B?cVo2dkF3VDJaUHhVNlhmQStIWUhYekZtdktEdWwzS1Erd0lZd3JudGRONnpx?=
 =?utf-8?B?eEhCcTVsNXhSd2pCbjlESERTRmFFSUtYajh4T3FvcUFqVTI4cnpFcVZ1emla?=
 =?utf-8?B?K3F0eWpoZEh1RTlYUzI3MGtiMFJrSy9aUjRUMG1NS25FL1l1ZUp4RDhUWThM?=
 =?utf-8?B?MTdKaGF2dWNrWFZxMU5qYkVzQ0xLcTQvUjdRRm5JV2R5RkQyYllybk8ybHdj?=
 =?utf-8?B?bktKWEtpSTRPcjZOcWI1dmY4bW5SU2NXTlZlMlgzSXZBd1VVY2VzeHJHemRD?=
 =?utf-8?B?ZWZRV212T0oxY2hicDk3eWVjUlpGdExsREtQZCszMEZpT3B5MTVsbW52NW5X?=
 =?utf-8?B?KzN2RkxqU0V4UzBpR21NVEpFblR6MHA3ZUFUczlTSWxMQjNaMjBNQjFSazBZ?=
 =?utf-8?B?bDJIWWRnTEVnN2FxWkg3ZXBOUVZOa1REdnh2d2hRZWhDYTJyb0lOM28ybUlG?=
 =?utf-8?B?MU45ZC8wMG0xNVBzTm85VmdieFNTcU9kcmh2WFNYRTZzUXAyRFM5OStkaUd1?=
 =?utf-8?B?SFBpLzIzc1dwaTRYYmpCc1IzRzAzNEFsVlpxZ0RlSkVwMjRkdUlDNUJzS0lr?=
 =?utf-8?Q?zbDbz1fdoQPwSv0WAqD69dUdv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddda24b-a866-49f6-6965-08de1d5b07bd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:36:34.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SygSFzycoNMUkvoOfSLgTCKK/qR2QCgHsBLggJK7Ad1xAGkK9IRA4jsDZyZGzHTB7OZVZGPSkBPGgTP41ctM4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10989

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


