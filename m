Return-Path: <linux-iio+bounces-24835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B9BC297D
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB653BD674
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BDA23D7F5;
	Tue,  7 Oct 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pod/7Wit"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAC23C8C7;
	Tue,  7 Oct 2025 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867608; cv=fail; b=sZc2kc4JacC3rMI2O8e/BL1nPCCFYsDx4LtoCb22DplR4Wghm1eOKEHaqBc2YbVEbWN4WHlYZpTEqry6UeZfpLMXCjNaPCr0/u3mQSapG9Nyf5XjNv+KLnYAxaCXjK9Fz8d3lV88PUMPNa+Y0ZK8tcwut21df/Sryi2ckW+hiKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867608; c=relaxed/simple;
	bh=qJi9xaVFOFE0ps52evCjiEaC3wuX9Z7sbGxZDDCymlM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tmciPG+wsg9t3863C7Xh9KSVfQje2eueuRyjxyaJxeNktJ9Bb4Q8kZ5I/X5FXvpt3Xpojz0ZLlHFu2pst8Yls2/si8ynbXFvS+g4kS3JQiScKWHAz5Jcbf5HiYzRCJj0GFYOSCXyVfP+6CrE6vYEXY3Ye0I0xZMXIbrDVNGT2fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pod/7Wit; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/N9U7EkYt8jtPTmuJHyQgBETP6oqsPr7QKEgUvCfNIZSblVTIIoZmS6JWXvq/qHacagtoYi4PWSxOuKvXX4n0LwzVPfkymuNt9erqRkfmnLEfnjh8gl6nFJu0SMk6KgW5rRip7ZC2kZPvQk7Rt+jmbeR7v/kbCaET65gBigI/MeiJaHR9h31IxK1rKsJ0o4qLAq5nAXMPG78hfzK9UJlS2CMS8aoBEnLRTk2t31+kOvkHImi/d64zmKr8NrV9gEH+6ZfnqswCbR6i2Sdg+/aeOwvGyNsVw9M7l8wYnM7PAAKIwq0y+9p7zT5tzUp6lEPsUZI9pqPD/DBlke3nRs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmW+Zr2VF7bUYa9194XE3pZUvXT59ae8F3BoukpVsr4=;
 b=QYlSBN7IXaCMStOz5GV+q5ZAVrRnXCVfdcr7A+jCej9pC62FvGAQTyjEBUewprl/Ajt1hqwbaP4TOpxePI6plioblYJSKLHp9wWmFfvoB1h0uvtXPYbzji7p7fgGdSeEx/xJruvafy7ZYOqaH+3z6ms8ROKRX2YOLx7OZMs828VJM8lHlirHDQx+hwO0PD8l8kBzsKglXjDmtFvyExOR+uiPAKXFuYLz4gjyIMkSDQPyccwzT1TTICNe+ad+K8y3JrZXQk9BdwoudKKYUNZowwLZpaYmkagLsSzXf6J9RxPd4qxHupc3kfVD4jy3zJ11HelwlaFlQwxf77mDR+WSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmW+Zr2VF7bUYa9194XE3pZUvXT59ae8F3BoukpVsr4=;
 b=Pod/7WitC/W8UsmmmBHPYN+ZuW0IXcg2HDqXF3HE8g64T9Y1HTAMezI0DMeFFfr6t9xfo3qr3fVPqIG7rdIoTd9CO4Jw3mlAG9G0pp+22zN7BgCawS03U7ex8+2Ut+gwRzArhnLTZYV6gCgieepW/G1Ew7a0gMKstLmGoOz9bkG6p53TrUGR1Yrt3O/lBwvvPvu3jNhDtFKSY4I0wz6oA4+OMmXxjf/wWUBK4kDlqVgeOL79Kl/VJaXLsFahqIbmvAybfQhImnfqCq4W29fhTacPO9QdlsxR4KNS4MFlHC0yMELD45fYr+BbUtce6apLWYM8Um8U20xQ7+ptgb1Quw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:06:44 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:06:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 07 Oct 2025 16:06:13 -0400
Subject: [PATCH v5 1/5] i3c: Add HDR API support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-i3c_ddr-v5-1-444184f7725e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759867595; l=10203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qJi9xaVFOFE0ps52evCjiEaC3wuX9Z7sbGxZDDCymlM=;
 b=Fmj38dJwB6v4A5DblyfniTFKOst11eoX1JYiLg5BuYn2RWosZ7Sm9saMuH1YKYJ7WAtMnJHms
 vwcqAFt470lCDwK47ahMpMD4Q0h2LWMNKz6DzZBoSplcBOGS+BN0YDp
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
X-MS-Office365-Filtering-Correlation-Id: 8b9786de-9b33-4246-9685-08de05dd09a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXVFN3JTalRnbGx3TzBkVGJSdXVlUnM0MDdqR1RuMjZyUlQ4RThOL0daYjNz?=
 =?utf-8?B?L2FZQnV5YlgrcGc5YmM3ZWFlVXY2a09pS3dJMFBxcU50b2Vpd09yWlVmZDFD?=
 =?utf-8?B?ZnVNNnRkS041UHc2d0Q4SHNQTmk4Yk5TMkwxMXk2TFJkTFUrQk5zN0t3bmpt?=
 =?utf-8?B?bDdJbnEzSm9POTNCeit2cXU4bTVMa0hFMnluS2ZpVTBMbDdLSVQwQnBCci81?=
 =?utf-8?B?RzRVNHpUWnBZODVmNGg5M3FGQ2J2ZjRmczJRRFRxb2gwdkUxaTduOXIyZG5t?=
 =?utf-8?B?VzI1L3I1S0F6WDdlZno5eGY1c21HbkxPaDkzb042S1RHbFA4MmtIcCtiM1hH?=
 =?utf-8?B?UFBRaGJQWEU3dFlJQ1gxYzBEcWxOZ0ltUjdGZ3o0ak1TdHJsNlpWMEI3cWh4?=
 =?utf-8?B?VGgwUitWZlJhNHd4Vk1ENE5ybEh3VU83MnU5ell3NlRDVitBeE1YM3p5OHBI?=
 =?utf-8?B?SHNMRVFjR3dLOHdVd2VIUkt4NDhQS3pxdjR6Uy9xV1hxdjlNVGtnbGtQbk1Y?=
 =?utf-8?B?c3JaTGdqSHdUTi9BY3N6ZFBIUVBxV1JkNmJ4YzVmRmgyWDVxcUw1eC8xKzBm?=
 =?utf-8?B?M3lyV2U3YW8zeVhFYU1VYUdORElxb2xOREYvWWlvVVZObVM4VWZVOTJZOVlu?=
 =?utf-8?B?bVBsL05yYmpIM3ZnVlNzYis5Nko2NWswRDhoc0p3VDNTdlh5bnJ0M3hkRTJC?=
 =?utf-8?B?dUFGRGFqcjZHdnYzTWNnMU5nNzNCaWo3emNFVzZRNWFITjJiRGhjWWlZdFJt?=
 =?utf-8?B?VWg2UEZ6bjM4cnM5bzJtQ1ZvTUpuRzRpZVZwaWkrUkpteHgydjZJcnpsenRn?=
 =?utf-8?B?QTAvZmJyaGczSm5zRUJIdHUxbkFvTHB3R1NCTU1zOGhwc0dPcXdoVFRoWXA4?=
 =?utf-8?B?UVJGWnhRWTNrSzJqNE50NC8yODZiOHYrTkZLeFpxRWFpdG1PRU4zUWN4VFpK?=
 =?utf-8?B?MWFVL014U0tVNTc4OTJLVFMxYzVVay9xeHFJVUZSeSt4OVdoVHBaSjRvaE0x?=
 =?utf-8?B?Q1l4aGVKUmt4T0tYVzVKODY0NVB6WEJneVdKbEJHRS83aUkzTE95c0VkSGhE?=
 =?utf-8?B?dmhPSThHNmVuUm9TOUlSMHJRZmpQYTN4cUtpZWNPWGhwSm1UcGJnSXF1VkEw?=
 =?utf-8?B?THM4NHJiNkFnRHJRbDlRdW0rSk9OdkttdjIxbmNLUDR1aVZvR0R1MkVDOW56?=
 =?utf-8?B?aUlDZGc0NmVwWWw3dG5kc05hdktqWk9oL0tTclNqODR3a3JQSTk3d3JDUXha?=
 =?utf-8?B?NWMwcXQ1dERXVEN5d0pweWR4eWNFM3F5dDZVb01UZ0hXeTRxZkhEbjdKYm5B?=
 =?utf-8?B?MThrLzZNRUNSejg2QUxhK09Gdkw5eWl2N3FTY2dWSlFHYzIrTVl0UXZvUm9T?=
 =?utf-8?B?cmxDaWFxb0tLNGprdHJEQmFYcVpaL3dmSHhYMGwxMSsrNG1RUU9YOG5FMWxa?=
 =?utf-8?B?RlNaSEVITXRaSTRXZnZhS1d0cHhldVNXT051UHBBc09naHpzNWNOVGRSWTRC?=
 =?utf-8?B?WHdXRXVsOGo2bHBoZmt2SVlyZVZWYmpOazAxazFuTlN6bUEyalhsM0xKNWN3?=
 =?utf-8?B?aUM4MFcyM1BLSWFNN0dVT0VsZUZyeS9pR1R1T2RtM0taUlQ0cStlcE0rT1J3?=
 =?utf-8?B?d3IwR0RRS2RWb2hWdEsyMDRxRURsVnRTR2M4Y05PcmJseldsUWdYZWlrSnow?=
 =?utf-8?B?Wm44bVZ1ZG8zVjA3Q2JwSFVEWTNqMklQZjdGMi9WYS9MQi9EQ0hMRTMwbnZ2?=
 =?utf-8?B?cnVabTNRT1hzKzVjcE11UlRrODJYeU1pWVZzdENoK2JYUW9OMWxSckIyWTh1?=
 =?utf-8?B?eWl6QTZpOE1FNTdLSlc3aEpZa3drMzJaazBpYk14VmhsZ1M4ZjFlQWFMTmp3?=
 =?utf-8?B?dkxOK1d1NE85WExaUjRxMWFmcXJuQmdnVzY3cVVPL3pqaG1udHVVaEtXaGpZ?=
 =?utf-8?B?Ylp3YlIxamdYKzhIWVJqZXFUUW5XMWtWMEN6cFlZbnFCSnJIdXpiN3l0VWV1?=
 =?utf-8?B?Qkp1aGRMeWlDZVZWV05wa2tKZmN6NGhJS09VWHMrMWduZ0J6dDd6STNzVEpt?=
 =?utf-8?Q?sBH2pS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnkrUkhSKzFPLzUzUTFubDNPTnhVaU1Qc1E0bnNmOHJoeUV4SEVIUm01YWdD?=
 =?utf-8?B?dko2NyttdjcvaUljRGJ5bVdDZnZDcTZCUmNwbGdhbWcwZnNDbjJBRE1meVZE?=
 =?utf-8?B?ZzJYK1owZXE5RU4zQW03dXRCZ0pYckFPNXpabUJFVEpZUHU1U1pTNWVnVjVw?=
 =?utf-8?B?UFN0VUhHaWdUaE0yWWFZM0g2VTVMU1hlUEpjaU1OUzJiWE1pTHNrTnFPc2p2?=
 =?utf-8?B?Wm1hZGtJVHdkaE5Id3dzN1EzY1FjdHppOVYwZHN6bjhhMm5kNTVBOUJqRUEv?=
 =?utf-8?B?SGI3ZlQ0T0V2cTlPTnVBYjJuYlZSUjFmcWhqYmNiU0xwQlArK2h3aVUrVFBB?=
 =?utf-8?B?QVdKSXEyVy9SaFVkQ0dXY0h3UHhoYlFqT3Z0MTdoMVhydWxHWmUvSUhHczJL?=
 =?utf-8?B?RnlmZFltTzBORTRMdFRjWjU1VTJIZ3J1UXJjRjlDdGVvVDdqdDlnZUpTaHJY?=
 =?utf-8?B?dldrbEF1a0FSd1J6S25UdkFKbHgxakN5bGhLaTlqZWhXbFJrQzhiZjZlQlNV?=
 =?utf-8?B?azFHbUFvOWhTU0J6UFVxS3BaNEt3Z2g0YWVrQS96L3ZVbWZnRU01WHJKNTV0?=
 =?utf-8?B?U3pkSWlLN1VwdG5XbDYrdDMvY2VKQm1ENDQrczZoZ3ZwYnJHUTFVaUhCOVZR?=
 =?utf-8?B?QS9BVWVPb0lCV1V1VDZpZG52WmtHRU5DUXZLOHhubSt2UGp4bklTSkJXY3kz?=
 =?utf-8?B?OVVzUk1rRnVScEIzZENjNGpyVlZhOC9nWWtpTk9yQW9IRmdZc0xJYXJaaWVi?=
 =?utf-8?B?TUJMN3haZ2FOUVMrRUVyeDJYVlBkSmhrVURMSktEUWo4eWJyTjEzVEhKTTZk?=
 =?utf-8?B?SlJQUG1wZ09lYkhpeDZBSjdOQ1RrWjFJTjhzVW1uNjdYSjBld2VjQVR3ajlH?=
 =?utf-8?B?aWYyUEZJdVZXU3RnL3J2RDAxb0dDM2dBUjZFdkZ2d1F5YnVMYWdUeE9FTEIz?=
 =?utf-8?B?MFlSODhqMUNvUHJYcWRTU2crbnpVeDJEakU1bFhvenVLRDVWRU9SZVI2T0xI?=
 =?utf-8?B?QWNBOTRmc0M5TmdjNjM2T0Vsc2JEbXBtSk52YzdlV2lia1I3Q2NibjFBOVFy?=
 =?utf-8?B?ZzlsL3ZCYmFMVi84K3NjQzJTVFBLaWo2eDkreTBSdittZDhmemtmdmhCVk5n?=
 =?utf-8?B?ZGgwZHFHK1RiTE5jVjY4Qk1KSGg0bEk5ZW1hOUV3VjJtKzNzWjluN0Z1ejZn?=
 =?utf-8?B?V3BKZVpPTUswVnVYOVpTbVo5SE84YmFuT21iQWJGTkRhMVVNWWN0TlJhYXp2?=
 =?utf-8?B?eVNVZTJUdG1pNjBhRjk4Yk55SUQwZkF4bCs0ak10c2thbXJ4bVNNSk42RkhY?=
 =?utf-8?B?NTJaV2xreTBSUVZKNUNWanMyRDJmSFVVRjE1N2FoTCtJbEVGS2c4eGxJcHhO?=
 =?utf-8?B?Z0poREpoMkczdndXTUh5VEFoSUpoeC9qODh0TTA4blVEbWpmYUlWMWRmRHgw?=
 =?utf-8?B?dlhpZEx5REYvSC85bm01MUdzclZvbVVTY3FBUDMrbWJVekJqaUZUclFjb3ZR?=
 =?utf-8?B?Z0JWT2cxeE9yV3p1dnNpMDRweFRNNlpKbUpUSlZpck9MZWJ6R1hhQkVINWlF?=
 =?utf-8?B?WVFWMnJ4MDNXS2dWeUJvUVJPeVkwbUlUUURySVptcDJmVEdZT0ZCNzhHQWtq?=
 =?utf-8?B?UUUrRDgvRUgwVlJpRGFybUFPbWVqTTBYWTNRTVI0SnowcDVPdk9uRzR0ZURs?=
 =?utf-8?B?TWY4a0FTOVhSMWQ0SjVheVRvT1VYRlF1N2lLUzhqU05ncU1sank1QVJNZE5T?=
 =?utf-8?B?Nm5CWnlNdU5BbGVOTHpSL0tMakdaalp0b2wzK1hBdzUycFVobWdvZ05YQlJ6?=
 =?utf-8?B?b0lrK3hvN3JTdC8ybm80VnJkLytoMG1PZHNGMHB4dDNWcWJ6bzFtcDFTR1hn?=
 =?utf-8?B?YTRyOTJiN21XZGtIbmoxTVl1YnUrMWpubHozN0llMXo5bHhmYlpNTENEVm5F?=
 =?utf-8?B?VWJYY2IyV1dVcytuemErcE1KdFh0NWtQaUdwb3VMdjZlTElURXAxcVp6WVB3?=
 =?utf-8?B?S2RITUtUdFkrTE82dkI5Sm94L3ZDVTl6R3FPRGdIbG9hQnR1VHpCZmZZelVP?=
 =?utf-8?B?QzluNDF1SHpvQmFYWG0yYklLUytVYWRKalpzYzhId3Nha1VSV1FSS2pkOVpp?=
 =?utf-8?Q?sBW/pZvJU3rQkloEGkqffUG2J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9786de-9b33-4246-9685-08de05dd09a3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:06:44.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cJkuOkSXuQYcPhFYzcb2fZ9fnBpQhgn6pBg0HVwrq2fF/bUWzubBb7EzEbwjZtYLuXpJ6U7IyHsgcrdIhTWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424

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
 drivers/i3c/master.c       | 19 +++++++++++++++----
 include/linux/i3c/device.h | 34 ++++++++++++++++++++++++++--------
 include/linux/i3c/master.h |  4 ++++
 5 files changed, 68 insertions(+), 22 deletions(-)

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
index 0d857cc68cc5d473db733b12ffcec0c1c28d9def..f8d68b9d6474cbc56640a643db3c2c4cd95dd26b 100644
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
index 2ef898a8fd8065032b68c97c52dcb12e771525a4..f5f44bd4f48391e76ae1c605693ad3959cf59806 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2749,10 +2749,13 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	if (!ops || !ops->bus_init ||
 	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
 		return -EINVAL;
 
+	if (!ops->priv_xfers && !ops->i3c_xfers)
+		return -EINVAL;
+
 	if (ops->request_ibi &&
 	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
 	     !ops->recycle_ibi_slot))
@@ -2942,9 +2945,8 @@ int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
 						dev->boardinfo->init_dyn_addr);
 }
 
-int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
-				 struct i3c_priv_xfer *xfers,
-				 int nxfers)
+int i3c_dev_do_xfers_locked(struct i3c_dev_desc *dev, struct i3c_xfer *xfers,
+			    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *master;
 
@@ -2955,9 +2957,18 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
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
index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..563e63f6dd99a95d66bd80aff0b760c231b487a9 100644
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
+enum i3c_xfer_mode {
+	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
 	I3C_HDR_DDR,
 	I3C_HDR_TSP,
 	I3C_HDR_TSL,
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
index 043f5c7ff398ff631f1eea6acfc54a2e871016d8..ef1363122066215983d37c8e3ce062f3eefe48ae 100644
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


