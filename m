Return-Path: <linux-iio+bounces-25771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E22B9C2629A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03A8D4F4B9B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D972F7AC9;
	Fri, 31 Oct 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/8V8clm"
X-Original-To: linux-iio@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2C2ED866;
	Fri, 31 Oct 2025 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928828; cv=fail; b=QnEfhzZcdKtFQhfF49v2SqgisrAbL5Euq9zACac0tV8+nG7VLSWr3UU30ujbeUfeQtC+dqAG2I97cagwcVARpEDYq6WYJl5otzthbBw977zQ/R+ce8GOIzE45mmF3n2bNGH2ZQ6qzvqoeVARrfzx/thtHUHgeFsgcGo+3iWyDTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928828; c=relaxed/simple;
	bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HLdd5a+oPY7ZMV34R7YF7rs+VPfzWp06pL/rlpPqE08A37UQm4mzXBV0bkBqFl1CbUG1jegEoGlNSL3fQsWvD6uW3k3z0i7+Ye7DY22yobGtk1y1A4329qZqzI0ivracECj7qzwDwxw0v/m+DwWoC6H3+GPhi4lQS2In128Et3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V/8V8clm; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KITGEZnYSQCewc3dpVhdBkOk7ObKqxRifDGZT5hdambk8E+oL8NH3jteSkDG1TZZ5kf9Nkw6+VWwTwyfMunKwgLd6xv0J3/qqAnuw4Ei6sNq0X/MAMufiA8gBLSZtkwNwLOpd29dHf/JVNu3DYLjWkS3AkOxWWO2pR/KHDSAfkcvIvawjAPNm25SJVGEQgkpagdOmPaLDxS8h743+HsDIefTutIqyavhCI4tFb7GICVt8EzxSHIBFTzDTSKUWqGnoY/clYzBSmdHlqCFZg3hEpApakBXae4Cm1IHyBul2B+Sr1hKaDUpqT+Sti3kJrT7FjieIXGmjKXLJmVBFSKE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=VilCPOqvrHAB8poybLyzvTEZe5dVjB+03Hgs3JTVzI8QR4G33nXm4ECn6FF4HdYplQ7qKaZNMk7kXFO/is/XV88xJpnG9q9JzlJCAgyEvuzBzzakRbtC6iin3L6d3oqekSF6LsMN68VGP/LKHmUIRnYwKr0fkVUEbtoH57DThUzpS9YcqPzOT2UT5hiTVwcoyibH2bNevalmvf19pyYYkmqrr8b9Ym67FluZS1ZdrCe5SnWv4MTYYmit74ot0Nyi9wUzQREUrNswo9T4dc+ZW9Pk5Ym1VfjEnFdUdclLeoCIdTT++xj4y3EZrO3oFzrFzNB1PFgCB54rM9GRf9SAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUJtg6/074SxlRYEqw9eCoiPjPvZ4vpTSDaRi9s0Zxc=;
 b=V/8V8clmkMu4XnyqCzA0IJCHRipJ7HqYYh9G5HtX2j6StV9ygWlb2grALx0ssBFn98J1Hj/btJYmZK2XmEtBXGok7+4jAgqTdB2TGN4i7dfjDyvOaZLw1YHrpdfVW8okR87WIHzLHZVxYz199Q6wxAS5rGZsX/yRvdNBXAUvviFsQH+rtLtCo/brf+JFxuMApOzvQwiaPWdMJOBLGnsSOZ4NQJsbKHqWLWWmP6lVwsAD0ImgqGJxGf+NXRI2XpbFCCCW1Sv3fu7h58aUsNNmDHIfotr1LgOHEB/+ischtDE2gkwth/VRMvx8zggtmiDh7MvwvocFJjQkIKoXzj7s5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB11533.eurprd04.prod.outlook.com (2603:10a6:10:5e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 16:39:56 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 16:39:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 31 Oct 2025 12:39:15 -0400
Subject: [PATCH v9 3/6] i3c: master: svc: Replace bool rnw with union for
 HDR support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-i3c_ddr-v9-3-f1e523ebaf78@nxp.com>
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
 linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761928780; l=3017;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HH693NU8kzd+Iv3hWINyPBycptPq4xE1Q1XbUVwF0WQ=;
 b=E40IWE4gX2ImcipX64jzF3h2G8CADhcB6ZjBOBvbDKaZtXoo58e8q2wCsK4WqTyz61zQXtH+o
 qTTFfISLy20AZBNmecuG7unS9nFYbzVgz2AlxZWEOJWIzmg/ItQOXNd
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
X-MS-Office365-Filtering-Correlation-Id: 25c0effb-26c8-4fcc-06bd-08de189c1fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1hwKy9nQzJYMXoweTlrOTdBcG5QUklJSVU2MW4rOHVUQzNjUjNVRDRHRXZX?=
 =?utf-8?B?SjUxUVJWeE5Ld2c1amdPQ0ZhOHZKU0VjRmN4SzBFcVk2R1lhWEJRYTQ2Ynl2?=
 =?utf-8?B?YVBwa0k5VDNWRTJTUGp5dkFmUkZrV2ZWWjk1TWlWRkFscytWMUgxYUZGMlhK?=
 =?utf-8?B?MlZKdE5IQ0M4L012MU9rRWN1LzAzeFNiWDJwdlF1S2JyTUVjbGpuUkRmdVg1?=
 =?utf-8?B?b1BieHB5M1IwR0dPazRDOHhYc1M2Wm9DMUJoeEY2ZEdQbDhNbmg0Nm9OZ2FH?=
 =?utf-8?B?bGFkUUVoVmFUbHpFWmlTTy91ZEh3VXZvTWd6aVZ6azY3Y0RTR0I0N1FoK05F?=
 =?utf-8?B?R1VaOXZTZmY3OFNhU0E2ampYR0NWVnNsZDlqdDZkMWtVRllNMnFmZjFyaVZ2?=
 =?utf-8?B?dEt0clZ1TmJGcnNXVkZDME1Pd25Qd0lGVmtlT1d5YlM1aGhvdUlDZDRFMXFt?=
 =?utf-8?B?UDEzRWsxcnNETUhJSjM4VmZFU0t6dHJtREx1RkhVKzJxOWZ4b2dNdzVpMmlv?=
 =?utf-8?B?ZU5yVGRJcFk0aXdra1VNUzRQK0xGUy90SFIwczBmQkJjUHQ0TGdxVHVNdGZJ?=
 =?utf-8?B?R29kOGdzUXhQUkZad2NQTHloNDNJcVlxbCtLU3dIY1dUbTVFSDZJSklyenVK?=
 =?utf-8?B?Y1JUak1wZ2RUMVc5SzREZHdCL1o3SW0xemUxYS91eTNDSTZORHhEbHp2a1lj?=
 =?utf-8?B?MTNwV1A4YjJvNHNmejRibVdNWUZEd1Q1bVlqb3pZK3BvMGV1cEFCMDU3U21W?=
 =?utf-8?B?bXV0M0xvVVphWjgxNUczTnp5akx1V2hybUlwYVhDZjJGVEFDN2VGeXNxSCtO?=
 =?utf-8?B?OUdiNVoyWWlPZWViMGFTa1lhUzh6VlFSUEVnQkptYmVsOVdnc1NIOXVidHlN?=
 =?utf-8?B?MHBPU2J6QXI0Umg0djl0Ry9xVkY0RHpmTVlCOGkwS0ttUGphWElldUc2RUx3?=
 =?utf-8?B?elRNc00rYmlxWnV1di80Z1NKZlB5aTJqVDBwL3VaQnZDNE5tNVd0Y2pJRnVr?=
 =?utf-8?B?cWFVVFNtWmZ0YVJjRTBPR3hOL25xYjRYRldDb0FpeG9ITTRsMHNHVFBWalNP?=
 =?utf-8?B?eFRLZ1pVYkJXbnYxN1B4ODJ2MU44VVlxRnlFcm9wc3JBU3pud01vRE1XWmpJ?=
 =?utf-8?B?RjgwREZwVllxc1dkb2EyNFZPN0pGZWtYZDdEQVQvNzJpd3d2c0NyOFp0dlRD?=
 =?utf-8?B?dTBna0FBaGk2UzZieTZ2TWRra0pCa1owTktwbER5V3ZTMGxDVVlOZmh6bVNx?=
 =?utf-8?B?RmlYY1RnYWxOZWYycy9mdGMxdDRxY3JLaGhJS0p2Zjd5M1R4QkZySHB6RllY?=
 =?utf-8?B?Q2Ixd1o3V2ZJUzF0UFVSSUVqSzg0VTAzZXA1Z001K2RZMFNvMGNwTkFsSUN1?=
 =?utf-8?B?Wnc1a1gyc084NHVBaHVtSGhjVktabTZDY2lqTkNya3BGRGJUa1JnZUVTMlp6?=
 =?utf-8?B?eFl3VVVZZjM1TGx0QkxLMVBPZmUxblUzNDVsK1pUVFRhK2NTQWJsMFliR3Ru?=
 =?utf-8?B?dHU1bm9Na3YxRVd5WGs3NWJHZ0NIM0dId3BtSThySVkrVjdQS1J2WEI4SnI0?=
 =?utf-8?B?eHYzM0pZRzdDUFE5OXdibFovMjQwMm5vbnBzdmRERDNwZ0Nwd05SNkRkdjdj?=
 =?utf-8?B?UVR3TDM3R3RkSDFCMnhUWDNzSGdzUFNoY0NkMStCUFhvemtTZndtZ0VlN0Rz?=
 =?utf-8?B?ZU04c0tnN2RwSWE1dUx2ejVRSGx2VGU0UDRPUmQrZFVXSjVqa1lrUnlYcUlu?=
 =?utf-8?B?aTJLM0prcGhyOTdEeVZteHdleEhweStYNWtudDNIekhiVkRvUWdZelFmc2Ux?=
 =?utf-8?B?K3p3ajNDcXdINVJkTlgyNGRBTjNOSmgxb1RmWWsrVzNKVjMxN29VTTF3SG5F?=
 =?utf-8?B?Z3pxQmpVNml6QVJBZy9tVjZIR01kNERsZWpSaC9XU0Z0K2RZRnMvWUlwQ25t?=
 =?utf-8?B?dWVQMTdyMXl2Yjg4Q1pidG9nVXgyNXBlcU5CanVMdmhoT3ZJanhaS1RFWTlO?=
 =?utf-8?B?S3g5bGwzd2E5TXY3ZmFGYXZFb2IxRGR4U1psaU1PM3ZpVGxxdVNSbzNhTXJU?=
 =?utf-8?Q?q1YL+D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVBtdHFmdFRLQ1pmN3RoaTloSHIxY2UwRDJyNjl0THJFREFDV210UGluRTZt?=
 =?utf-8?B?TFppcWxCLzdlNlY0cThiM1Bid0FmdDIrejRMTFQ5cTg0OXRzcTBNR2JhajUy?=
 =?utf-8?B?UlRRRzFuTWJkVVdLcnpFUkppWlYzb3lncVY2OURnVnhqYW1tMTJDRktxajMz?=
 =?utf-8?B?ZVkrQnc4a2dTVzFKUG9tQzNWQ3pXdzlQOG12M0pGZUJlTWZsTTN4Nk5hcmVI?=
 =?utf-8?B?MTZkUEdneEJOb3JyVnRGdklEdnFtYU5pZ3lac3ZodWZlMi9mZWpjYlJWNWlG?=
 =?utf-8?B?SmtPMHd3WGw4SXJwQkVJeTNmdk9Bb25lcUZKUVVVL21sSFJTd0IzVXNVanBI?=
 =?utf-8?B?U2VxdFVTaHF0cGNEOUd5NXVNZGFNSGplazNpUWcwWmg1djZjMFdHVWlXdVVk?=
 =?utf-8?B?M0FqS1pkN0p6UEZzd01Kemo2VzZhUm1HaDFMdjlIbTVWckxGQ2xkUUtDUm5z?=
 =?utf-8?B?aVR1cHd4ckFQRDZ5T1VSTlEzVkgrcUQ2QkxsTVN2ellYWTlwU2k0MURRUW1R?=
 =?utf-8?B?a0xadWI0Q0pLVGNmUDZ1M0hzREk4MWQydVFSU002Z0xNVkVUdkZQTzZWYmVh?=
 =?utf-8?B?bm1vQTh3a1pocVNhckppdjgreUg0N2RaOFk3M014VVd1QUpzR3hSTWdvL1c4?=
 =?utf-8?B?em9uWlZkTStMVzdQbHNMM1I1eExleWZYYVI4QW0raEhpcVNvSE9hUjlJcHdr?=
 =?utf-8?B?ZTFuNXdCeW5TdDRkTGNmdGZwaXJ5ckdOa3J1REZhWjRMUTRVN3FRckJYeHZx?=
 =?utf-8?B?bXJneVR5WnhSYUtZTjl3L0wyZ0JWMDBNNEkyQnR3cm1HM3AxZ2JkR0IyQ2U4?=
 =?utf-8?B?WmxveHEzVFJ2dmE0RG5BejNkNTRNK1UwQXJnZW10OTVlaGFtY0hPVkY1eEg3?=
 =?utf-8?B?YS8xM0czKzZNN01kNTYwZkNzS0Z2eW5XQW5aNXhYT21yU1N6VU91Z1ZoZ0x5?=
 =?utf-8?B?d0dkUDNmRzdVVUdSWTFFWkRIVkg1dTFwa0tSa3AvTmxFSTFpbmlwM2VOOXk3?=
 =?utf-8?B?Y0Jyei9JQmpyMmVpN3pPTVhDenRvT2J0dGJJUy9BZ1pMcUs4d240U09QUnRh?=
 =?utf-8?B?VUJMQ0g2Y1dqdndDSjM2YlJoZ0tJTDMxcUgzR3MvR29pMFArT2loYkVGUGh3?=
 =?utf-8?B?UitYT1BEV3dQd2xJcDlVYmcxYnpjRDFOZEQwNGtmcFcyQXdaSGZuNmFrYnhL?=
 =?utf-8?B?S1VPdzZNR2hjTkNUNTBVOWY4Tkl0N1p4QzRMYllxSWJtbUg2Wnl6bkxMYzdz?=
 =?utf-8?B?VDlMTjFXbS94NFdseXkvK3lNb2NZTkJoQnNHR1BmdXJ2NW5SQ1g2djdlMHFx?=
 =?utf-8?B?bWlTc3k4RVRQd0VEMmVrUTI5c0plQ3pyNWJmRUIzTjliTEdseVdsRG9hUFVs?=
 =?utf-8?B?N01SVWMvVEVrWTM0RXd1THFSd0lLcy9NdTR5RXU1ZUhPL1U2eEhUK1ZpV0F0?=
 =?utf-8?B?UHVub0xQNHowMnJPUXBhZFJMeC9PcEwwY2dnVFZzOSsvSFJ5bDFnYUJrQWhB?=
 =?utf-8?B?aHRkT2oxMHBNRGNyUTh6bE9Ycm0vRk9HdDNhMzlDdWxLYkxKZENTMlZYUjYw?=
 =?utf-8?B?NDVNUDVNSUZDdkVha0ozaHdIQ09iWENvUzUxVVlNSWxsM1EvdTZFMmVXa3Yz?=
 =?utf-8?B?OEk5a0l4YWhDSG9ITTduTk1xZzZTTVQyTHR4Z2p4eW11NG1yMjRIZlBnVE9q?=
 =?utf-8?B?TDFYWXBpWHpjbjlIcUpLT0FqTHNQY2ZubnQ4TDZrckRWMU5CLzJWUVF3eTc5?=
 =?utf-8?B?R2FoNUVEbk0xNW9QZVBOcVhPdW41d1gwYzErYjlJemdHYW5VZ1U3OFF0NFJR?=
 =?utf-8?B?TmU0YzN3VFp5aWU4ZmhWUXpwM3lCb2NPZTBORm9OVXBCSGtPYUc0T0JzdlZk?=
 =?utf-8?B?VldDNHo3WGhjdlJTVm5BR2ZrNjZ2aVRKZ0lRa09Fa0F3K0hrUkxxd0d0bVgx?=
 =?utf-8?B?SWtFdDJGdldlaU5kblAwdVdtSk93KzROYXN3S2F6NHBuRlB1a3dZSVJFdVpx?=
 =?utf-8?B?eXB3bXBpWTV5Nk5WelN3VzB1dTNGd1M3NTNwZmRFODRVeVJZYkt3NUczNUtM?=
 =?utf-8?B?dnkyb2d1K2tFdHp1bDZYeDBycVI5dDRMWFdvbWNtT1VPM0NOMmpmak5JY3lY?=
 =?utf-8?Q?OO8o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c0effb-26c8-4fcc-06bd-08de189c1fd0
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:39:56.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7N98a7TWpwJOtkCrxl1SyIzCxy+O4JymITWJG6uupDiInFSBc1MPqB80iL34Xuax+M4nP8YcB0l1jzUCjjj+ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11533

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


