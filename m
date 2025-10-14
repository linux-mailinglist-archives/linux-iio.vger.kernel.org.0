Return-Path: <linux-iio+bounces-25052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5177EBDAA83
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834E0192663F
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB93303CB4;
	Tue, 14 Oct 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PqFf90tQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3030276F;
	Tue, 14 Oct 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460036; cv=fail; b=iKaCcuEULHn2pnzX13UcuqGyNd93MIbnpVOCA/38zhpRff0lBWvfDrhAXQH5BKPZfSysV8uIm/G5HFqTWIPNxOgmCdI9656R51JlDofMsqg6A7db13wuiL8Vz3pZ/c8UXZfMT399L7OUGJ1ZBencl19/3QFpX91b743yg179Cqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460036; c=relaxed/simple;
	bh=qctcZM2Yjo6P7Pibi2HaShPT1XpRoM1zFJIIdP5KFJQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=giIcJKdWd7Nj6Kdr4rhg6fbdMSRNjogAsCdIUB8KX1zBz/av43jz66iqVcqbi7ZcMmJZOCseN9/zVPrFU6blOhYQK9vHn/V7Q9E11ycq+9bsJpgubCK7HUsIZXG7Tqp+5Pt68ZGY0sjfeSEJ0g1G7TNtxSSop9x630ds0Xuix7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PqFf90tQ; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiPK70/ix1kFaSavpX68kGf6eTrg14oARtKtUEngFQESvFsZedn7iZIXkel+cYximGtgbyVVfNLRI54/201QTaKZSRmx9lpV5m3H5lIrFgl08LxYj4rJQEG5X1vCpemqsos+yzQXCCJPtswB+Sm1eHPSbN5gOUHPSQRrrBYEMoSqlauRbateBt3N/pjHrgWJOAbYC3Rpbrg9OjIv2STOlOBh7gw7D75+lkMHKAZHDemgCftO9xYzxvsmMQRQ5r0Lm4x65PyowlhkHMDC9SO/5SlweMsx5WuWhTa6vfMVHp1vvNSa8bSRkFc1xTlY5VKRulxkDB/ItJpXaQzons3TCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwMemhnfg0G/7Zg23/aJ0GAA/p2UuXKSs05JuqLA/Ds=;
 b=sEXKvuwufLKIVQywifHe/hnhEeXoDaj43DO4qBDUx6dB5+QhIzonjr8jVTWCOCCtnU4SxUVdUjridKrWw04k0nDZ+/KCo+jnmfwp+YK+mxxYFiMRpf7m/m6LVb0NUnIbQBpXmTGKetJ8fuUrS5X511y3BwA8wA549oijf7IPxBJAtdhU78poui5SJFYP4QEyRT+8rOi8GsawhCxqycV3I9wOu7Mv2P8QwKZ06YGzPOlP3dOhyNwqHLRkaL8Y31L1vouJ4i9cwI0MjJd6+tvxQZJZnMoePdwdFPUjPaOo31IY9qeQtaCvcnDMLd35B8sMI2b2Eq2ecs7v2Z8Zq1Je9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwMemhnfg0G/7Zg23/aJ0GAA/p2UuXKSs05JuqLA/Ds=;
 b=PqFf90tQFOTx4WjIrvz7AJct8/ksPufH38/c6jdyZpHJzkXNoCrKhBLItrPli69NUW5G5eaw1+Madr2VCIFpjG8krPAiEoof8MoYVJ1m0dhVXRzxWtwhWmMoR9kXdgWA4KQ9zV+Nyh+kt7UDYA/8vzX4F5OmLRBQ8oST78CePhLyP5jfqM4ZJqLFGwTNmuB5/iCIAZtHp29C12fwUEFcziTfZhaHiIH+xV83+9LVtSdk1djBujTyWilneOD9hJb0155/jYmRE/BPAF3zFDEnPE9uxhGMIPMmysGJ0WjlkO8jp7em7lEd0Y1sWkDre/MsVfv0kgDAWW9rVzKsl3hfXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10946.eurprd04.prod.outlook.com (2603:10a6:150:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:40:31 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:40:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 12:40:02 -0400
Subject: [PATCH v6 3/5] i3c: master: svc: Add basic HDR mode support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-i3c_ddr-v6-3-3afe49773107@nxp.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
In-Reply-To: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Carlos Song <carlos.song@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760460014; l=7659;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qctcZM2Yjo6P7Pibi2HaShPT1XpRoM1zFJIIdP5KFJQ=;
 b=ZrnA8E6neGRO5QJ+ISyoL1XgjDlIKaZWX9to7kIaQ3NhhBgqQY22XMcdBTgYkwJUqgRE2bZRb
 8uIXxB4N94sDJ59DlEmc1FIWa59LcWIOg2gsxVE2GQVTny8IwvwM65r
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 92914a31-1f20-433c-1a87-08de0b4063ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnY5OFZDSGNJV0RHUUtTeGhNY1JPVU5Rak90cHg0ckM2Yk9xbGdKNVplVDNW?=
 =?utf-8?B?Q0hwaGRkWnBkK3ZKWEVKTzFNOU5wSEFiOENsa2lCN1pqaEs4NnluS1M4alZ6?=
 =?utf-8?B?UzFDMmJSSEZLSSsvQno0WndMdmp5NVpjTXg2ZWFlQU5lUXFDcmwwZE13T1dY?=
 =?utf-8?B?UDJVaFNxNlRLYmNYTTJaMm9hZTBuUzJiN1g5RHF6cDhaRHVYRDdyYkpxb0d1?=
 =?utf-8?B?N3ArSzRoU1FnVlNmQmp5bm9maU9WeDZrcTRqdDZjM3h5UU1YeUtIZTkxY2ZQ?=
 =?utf-8?B?WVZDRCtWNzVCUkwyWWI0UnJZa1pUZy8xNHc3SGloUi96a01ZR3Vqdlg3NHJ4?=
 =?utf-8?B?V2VhVUMrclFqdUxBWEUzRGZRM3B1cnZmckphaklsaUFJMXQyTDd5cG9sSU41?=
 =?utf-8?B?OExOWlAxbFJ5dHJKRzU4V0JzdExlLy9vUkNocDY0eGJkSEc3Q3M2ZVhzbGhC?=
 =?utf-8?B?VDFOSDA2T2lzekJZbml0TmQreE9yZGZiM1o5ME00RStucHhETGo4SEVqNy82?=
 =?utf-8?B?RlJ5KzVMOGt0eHp4WmFGUyt1dGpiNThtdWR3emZlcW4rdmlqU09BaWxKUm9i?=
 =?utf-8?B?NktUYkN3TFQvUzZCL0M2emo4d3ExSTF5NlFxeUJURWxwYlpqQTgyVXNlWTVl?=
 =?utf-8?B?WldRZkpFaWdzUWg0eTl3Z0lCTllTbzlaVWhpZGtCTG5XTmV1VVk5MkllY1ZJ?=
 =?utf-8?B?N0w0dFA4dnJpMnhjbW9idHplaCtKeDFkNjY4TGk4d2xOTVFLODBzM3g3SzRy?=
 =?utf-8?B?YnU4NnZWY3lGUDNqSlp5Q1NaQU82WDBOaEk4Y1FRV2Q5SERaVkY0NEIwV0dO?=
 =?utf-8?B?cFlTREVjUUk1VHh2dGdGZGZBOFF4b0Urd2xBUzdlQ3JqWjNFVnVBN2Y2ZlZs?=
 =?utf-8?B?cC9UdFhJR0RwUSt5U3JuaWMxbjZ3UDdZUk1wYjh5OFFaL0NhS1Y1VGhlWE1i?=
 =?utf-8?B?WnFISDI5NVhPcHc3azRONGRnMHBlRmdkMW04dGNvV3ZBYUFBalZvTnljaU9D?=
 =?utf-8?B?c2NObTVvdUczQk84T0ZsazdheU52ZWxpU3FnbWNzZ2RtMm9HUEhFcW5Va1R0?=
 =?utf-8?B?QnhaTGR3NnBsVW5TbXdrYzVsU3lsMklRNVJvbUNjQS80UVV5NDcvNGw2eCt3?=
 =?utf-8?B?NWM3M2duTGhKaEozU0k4RFhOVEw4ejZlbjg0bGwwNzBScDhhdjByckVTMEMz?=
 =?utf-8?B?WWxvWk1VYVU4UkRIdzFjTXVwUHVqUGx5OHBUY2lTTFZQeWRlQWJrRVpIaXZX?=
 =?utf-8?B?WlkvQnFiODh1OVdML0ZvOUNGMWlpd1J4Nlpya296M1RGVGthNnVkeTU2dGVj?=
 =?utf-8?B?ZlI4bUZHc2JHV2EvZXhHUCtIWHN6RXFsZ3VraDFOSUV4b0svVEo3QmVyQVlu?=
 =?utf-8?B?Q2g4ajhWR29OUGVIZnBzTXV0L21iNkZXdEo0eC82UWhjWWU5Ynk5YmpBNlg1?=
 =?utf-8?B?dFo4dDJITUkyWWNDTTF2cytteEpBNUxaMEI4citQallPRURTSllsNk0ra2pq?=
 =?utf-8?B?emFYNzEra1o5YmRYUDVhckVOZkJwZUI5Y3ZPQVllcUYvNFEwU0ZzTmNyeU81?=
 =?utf-8?B?MHRMcks5UncvdjIzV29CK1piZGE0dUtsL3NtVnh0UllodFVLUnIwWTRlZkNU?=
 =?utf-8?B?c2NCK3BSNHE0L0tqRVo3c1F3UlFPVEVyU3VDNk92SE5IWFlBbnVKMno1R2lq?=
 =?utf-8?B?TkZjR0Y4QlNISVhDa0IvcnZma2dlVnVmSGdjMzIrVzRPQ0N1VTB6MUNQZSt1?=
 =?utf-8?B?eDV6dzdGQ2xuN0RWNTZTMXNONTdmSEFTMzd0cUxaRmkya2ZURzcxNEpqamt3?=
 =?utf-8?B?N0o4a3VMWGZyOUJTREZNdFBCZGgrY1ZiZDhBMVNDd2V5Nmw1S0hETjI2YXJR?=
 =?utf-8?B?MVB4b2lDb2xYMHE4RnFCWUJ6MUtKOHBOZTZEWko4RStudVJqK3cxNkpBdVpx?=
 =?utf-8?B?aFZFbTBlc1Iza0s4N1FHSzgxTU94UjU3K3haUDVLWUQ1dmpaUDJMUk5oRmVi?=
 =?utf-8?B?UUZ6d3VyaktuMDJyMGd1UlhPSURJSGFTeDNIbDB2R2k2Smp1OWtmNmZtKzZ2?=
 =?utf-8?Q?xaazWe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0dTQ3RMMSt4ckZIZWdCd2dkYzBtUUNLUHFtUnpidlAwVnZvUEZhUHR0a3d1?=
 =?utf-8?B?YU1yUlFlN0hhbVhEMENybTJhb05LL1NEV1IwVXdQZGYvUms1Nm5FSVpxejEy?=
 =?utf-8?B?Rm1JcHdEcUV5V3l1eFNRNVdCTjNIK3dUSTdPdnd4cFRzL2MzZlFzSHdaa2E1?=
 =?utf-8?B?UkQwTmZDSmthQldDVS9ka1FXbTRYdVJRL0Q1MHhNREdDbHgyMmh3MEJ0YStJ?=
 =?utf-8?B?T2hjd0JKV0JPN2VtRXdtQjdxYXZheEdITkYzSmFVdzJoaGgxanRhaWd2eENJ?=
 =?utf-8?B?RnprbTkydnFWRjM5ZG9mNndELzZkMUdCY0F2aDdiUFhWNGRDODF1c2MwMUda?=
 =?utf-8?B?R3FVRUtVUGw5WVFJeDU2VjNHYVZsSlBOb2pSN0dDcm9kcUdtd0NDeDc1ZUpx?=
 =?utf-8?B?bzRCN3puRDk5SHdEWWVXN2tkcFdIbE8rbXdpeC9DekFVTUxQanN5RmtIemJ3?=
 =?utf-8?B?Y25IdE0rbUtobGlEOU1HQlp2RnY5bk5KUWJpdGY2QnM2ak1lNFlVckFWaDRx?=
 =?utf-8?B?UXVPemoyRHRkMkpVN2ZVYUgzUlZvT2EzQ1JLTm8yUE1PcWd0ZDYrMDlyZUtz?=
 =?utf-8?B?QW5QZkJFdlNCMnpQbG9BdUlSRkgyVXIvQVhIbjV0cDhhR2NJRWJqR09TZWNy?=
 =?utf-8?B?ZWJqaVlHOEt4TjFqeEhUM0dSa3FrS1EwVDVHblVZbEpZSkx6Si9NZ2lrYktX?=
 =?utf-8?B?citvSlYwVnh2L2p2QktWQ2tRc0hNeFo2MWlENTFqNUErY2puM0l2amV5dith?=
 =?utf-8?B?VjZDSXhHK0JTeDNLMlBibWtYKzREQmZvSy9BNk0xNkZYQ1lnZ01iNStHeTRt?=
 =?utf-8?B?QzNGTEZiZzZmZTV5eTNKR0pOeEx1czlneVdzUFB2M1JPdW1SUll0YUp5NlM0?=
 =?utf-8?B?bnl2NzNnZzNYY3JJbVpLL3l3SjB5V3JERGc2dFRTcnlsWVF1UWlsdjE4VG9K?=
 =?utf-8?B?aCtoV0VCWG1IKzZCTkVGRDNaQUxXRmhkVlBnRXB3Q0x0NW44VC8raDlUaVJo?=
 =?utf-8?B?MkZVVkVmazZoaXlZSkprU045Y0xjQWxrVGI5Zk9uYTIyL3Nwb3hmNFJjbjlV?=
 =?utf-8?B?Nkw2VFdyQVJCb25rZTlHL21TUHE5eXIyNm91bFV6bzlCSCs3SjZGOTRqQ0RM?=
 =?utf-8?B?eXRKM0hTU1BJRkVkOU1STWp4V2RveVl5ZzN5dDJGMWxHS0JZcTNHRUo4Si8r?=
 =?utf-8?B?NEFnMFA0cFRwb2V3MHh4MkJ3TzJxVCtRVmcxd2dJcE9obENBbXBiYlRaTmY4?=
 =?utf-8?B?eWdIdk1FWWhmd05oVkVFR09Gb3pEcDNaSElqeEUwU0ZjS2JheEd5VVlKT1dP?=
 =?utf-8?B?bDNweW93TkpzNU1RUk44T3RKcVVQMXVVYkVGZnVSalk1aVJBWEZ4S2JCWmV4?=
 =?utf-8?B?T1JPcHlaRHBGaC93c0wxQ3YyazZYYnpvNTVkUDYzZElPSnltTkNadG5uTjIx?=
 =?utf-8?B?SUZhaDZqTUhUb1JsVW9odFZmT2tVR0g1RFloTWxlODRiZ3ZjbUY1Yk5vMTVu?=
 =?utf-8?B?Q3llN0szTk16OXczc1RUeXVnUkgvRC9hK01EWnNIUDlZcGFTdWFwQkZrd29u?=
 =?utf-8?B?c21CUEMyenJQOXFCdWVPNmd2cUc5T0NUdGg0NFpyZ2Z6TkZqam5CVzR2d0ti?=
 =?utf-8?B?N1dFSklsVWE3UUx2TDVMRmNjd3AvV3hDa1RrNm1EaDg2VXA0QTdVU0RsZGxo?=
 =?utf-8?B?aklENWhGV1RLNUpoN3NpRmxEOWFiN24va3h3aEUrSGg4QUE1WkIrUWdNTDZV?=
 =?utf-8?B?S3dqakp2eW9VdnF3WEE4MWRqZlFva3RuM0t2QVhCbHlPL25hZWV4Nks2c29J?=
 =?utf-8?B?UVRLM0Y5YWhqaWZHS2FBRDlNNStYb3BaY244UVJaQkVvcTZYa0dCMC92UUp6?=
 =?utf-8?B?Y1dFa1MxRnhPRFV4QnJhTXgxMnAxNHlrc25YNmxKTDdkYUZZYkxaS1htSzlk?=
 =?utf-8?B?T08ySGcxN0QrVUViZEpYWFVMaWdpZU9xWjBlbWZzNEcxd3F1aWI0WmJneXhw?=
 =?utf-8?B?QXpwL0RCTWJGWmp3MWtEYW4vZ0JsUEJKS05LakZqaFJBd0NJVW5OeVM4cUw5?=
 =?utf-8?B?SVFzdWpWVDZpenJ4emdIK2NzWnhtUFByME5sc1hnSzB3L2R2M24xTkhuU1RK?=
 =?utf-8?Q?ME2dhHfK0QSNVKku/Nr0UtDR1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92914a31-1f20-433c-1a87-08de0b4063ab
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:40:31.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX0JwnVv4dY9mBWEc/BN1GHLif0m5xtJ3dO6ixlAimTCVnFmsV16aoHJnVZiyQWXefrn3BHz2LujpGhTneSwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10946

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
 drivers/i3c/master/svc-i3c-master.c | 77 +++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 956172dc9d5f1f54d76b4c2917f2d9cf3bd21a85..f25c9ed561290d2a33046855b84702eb310590b0 100644
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
@@ -389,7 +392,17 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *master,
 
 static bool svc_cmd_is_read(u32 rnw_cmd, u32 type)
 {
-	return rnw_cmd;
+	return (type == SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_cmd;
+}
+
+static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
+{
+	u32 reg = 0;
+
+	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
+	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
+			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
+	udelay(1);
 }
 
 static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
@@ -780,6 +793,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	info.dyn_addr = ret;
 
+	info.hdr_cap = I3C_CCC_HDR_MODE(I3C_HDR_DDR);
+
 	writel(SVC_MDYNADDR_VALID | SVC_MDYNADDR_ADDR(info.dyn_addr),
 	       master->regs + SVC_I3C_MDYNADDR);
 
@@ -1293,6 +1308,16 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	/* clean SVC_I3C_MINT_IBIWON w1c bits */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
+	if (xfer_type == SVC_I3C_MCTRL_TYPE_DDR) {
+		/* DDR command need prefill into FIFO */
+		writel(rnw_cmd, master->regs + SVC_I3C_MWDATAB);
+		if (!rnw) {
+			/* write data also need prefill into FIFO */
+			ret = svc_i3c_master_write(master, out, xfer_len);
+		if (ret)
+			goto emit_stop;
+		}
+	}
 
 	while (retry--) {
 		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
@@ -1386,7 +1411,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
-	else
+	else if (xfer_type != SVC_I3C_MCTRL_TYPE_DDR)
 		ret = svc_i3c_master_write(master, out, xfer_len);
 	if (ret < 0)
 		goto emit_stop;
@@ -1399,10 +1424,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
@@ -1412,7 +1446,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
 
@@ -1459,6 +1497,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc_i3c_master *master,
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
@@ -1648,9 +1691,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
@@ -1658,19 +1700,32 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
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
@@ -1869,7 +1924,7 @@ static const struct i3c_master_controller_ops svc_i3c_master_ops = {
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


