Return-Path: <linux-iio+bounces-8805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9C95F387
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509401F220EC
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169BA18BB9D;
	Mon, 26 Aug 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="fiVoq31y"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE9189503;
	Mon, 26 Aug 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681188; cv=fail; b=qZUPCl5SgLqztE+Y55WBxnWQSlX/PBYWMdp+EVKzQqSRj7ew5/eY5iUXrM1ihYYbN/uZF/92G3sLosaWt5GWX+SAAuCSTuqvBMDR770jCFpjpf/4xu6Ha0RExlwQf67ZAco28Z2oeVPLWm1Q3x4GN2R5JwRqLngYYikdjCHThXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681188; c=relaxed/simple;
	bh=lbF7/aAv8pigl7HT2mN7ltFyH6DvpORxnVDrb8jHTmQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dADDhVo9fwiLZdc4hYa422k4GEAQS03hMo031/UOxEHLkyBmnAtcNm09AmH7RQBIZ/jjhp7PxTf6dLMeR/ah/WO9MLAEGZJ71pWq3BslQcCLlsc9RIp/dTZKulT0woICJ3gKbY3Cm2aruTV253b6hORIw/1D9NTBiNZBJ+l8JVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=fiVoq31y; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZqcfbrof/uB6yP+9ohdttzNt7gZPbjJN93rJN28d0IjMxKSOCIBukJfqaswlo33elmm5HxalVi7N9M8HSRrZn4Zr4HS2fyttTQeFGRhOdvX+EVUsp1dnmScFsuP07KTVVAd1MA43y1ik1Vk//+6lVCy/NPyT7VCABXDFX4sl8aRIL3JdRsl42Uib/8l974tXJLgxgcsHZBoHZ71YcInvUh6Hc0ncCT1ELSfvJJ4k8WotXC7R4smCcRHm3rrP2hMO7uSb6ExkkqMQQ2P9ia9sfL9kBmFbSpbdBiTMSrquWNvK1+wQd823ov9EhMycTuxuPGelB6vnJCYrwK+Hrhb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGcKb4AzdQGzK+jNs/jRiBVKZ0nA5fKuLSCtGL9Wgc0=;
 b=avs/aaGFy5uw2ZhP/es5IydpMSFSU1Jh54r398pp7brGBFlONmNsRwT1VN6CFRr5oRC3mSfEEpcaiaxaCoz5GWVM5Hgf+dc4IsrUgSb9byS1xKtSDTJq5A12a5hX0+A8KPmxQomOdvMhxjBUFbQthsfaaQJRrNOgqR3SklWY1q0kbD+krQGE6dM7r88TGkPvGMve6iy8al5kqTj+zt51zbRYMu5IvDCW3rooZt9d5yn+tZOaSshz3VnvaroEhD4OLphuqlrNQYiF5Fo7sPeDubLIHZAOtbjvOD0OED1zN1QpjQowUNGrWdPcLWDu/SJDpZqjf3gr7vFp0Z9d0DGvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGcKb4AzdQGzK+jNs/jRiBVKZ0nA5fKuLSCtGL9Wgc0=;
 b=fiVoq31yS8YaEEjwpVx+Wj50lfleLiXh0xDF8Q2cRKHpzMfCU5YMzPm+DTotwQCArNWT1xuW9vICkYJG2wxfgFwMqrzZHlbgVurFlYAENc5CddEmSrHWsCcrnrCxMPxaLz1VGuKlPm3y29PuoF8WqOdobjZ0WO0M73Bb2lCfoTAOCRpg4kJTIdIYNvSqwCRCVRygh7AByHeRWt3W4qzwLD9Lj3xdFrNnzqHf5HJq817vW6Jz8Ir+o//nNV0sEd1sahsw5W1Ay9BizwmmDop3pKgF7YhIhVOzRycZlECqG1P2UdgT6OBpqrnx7Gd7e5ECBWiXyj2ccfyFu3xC0xq3Yw==
Received: from AS4P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::19)
 by PAVPR10MB7090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 14:06:22 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::cb) by AS4P195CA0029.outlook.office365.com
 (2603:10a6:20b:5d6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 14:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 14:06:22 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:06:06 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 16:06:06 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v4 0/2] iio: imu: smi240: add bosch smi240 driver
Date: Mon, 26 Aug 2024 16:05:43 +0200
Message-ID: <20240826140545.4085-1-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|PAVPR10MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8584a7-5c7f-4210-7926-08dcc5d843d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0JES1RvZWR4a1pDKzkyN1N1MHJDUDdxVkFzTVA2c0FldGMxdlFNYmhyQktu?=
 =?utf-8?B?Q0Ryc3J4dkwycWR5TktkbVdBUkZac2hwd3VwT0FCejV2WmkzNCtVTWxkd3hq?=
 =?utf-8?B?Z2pMWEhIZUdmWVpPSm1DeGJST2hBS01pTnpNRUI4MlY3RTU2b3hadG5TbFFm?=
 =?utf-8?B?QmFEaCtQTWlzV1ZVdnQydWFvVk13aDBURG1CbkF1Z3V0ZGhrZkVhYjVldjNt?=
 =?utf-8?B?bVdEZXNTQ3pEa3FrenBVWlNpc00rMnA0M1poTytoTmZoL2pEamlneUZRRkRM?=
 =?utf-8?B?ekJJU2RqNzVJT1NrWTdTTThOdEVxK3JhMUlCRmI0UmdXdENvT0VOS0xtVlhS?=
 =?utf-8?B?aW9VSGsvV2kya2k1RmZwNW11Nm9WS0hpaHcxS1lvMWZzMkpBR09TYktyOW9U?=
 =?utf-8?B?alNWNGR3VDdDc0kyU1BDVW9DN2pzVXpVNlNIYzZUT3NqR2lObkpETENmU1pr?=
 =?utf-8?B?RDZmTjhETE8vT2pqUldnLzlHOVBrVXZ6QWVBK004QmdMK1JwRTYzTG44QWho?=
 =?utf-8?B?NStNVUJJbUxYZHVjbDhQTjlxYzAwQ1poWUwydm9lTjhUNXE4NnRQQmRyMTJ4?=
 =?utf-8?B?TmRjVXhTTzNEckQxaEN3OHJ1MkJ0QWVsZnYyK3l0V3J5RDRhYVlmWEtBUkpw?=
 =?utf-8?B?RVBZYzR3S0p2bXlidzVBL29PdmJFZmNOUHBaN1NkZ1BvVzVmSS83SUtZSVgz?=
 =?utf-8?B?ay9BZUlMOHJwZmNNWGZULzVhWm13dnpGSUdicUVZRVpwSnAvZ3pta0Z4L2Rk?=
 =?utf-8?B?WU5lYWxYbVBYM3NyVkE5VWZGMGVtSTVtSUdaTGI0cVRmTitjbjhjZkRrYUcx?=
 =?utf-8?B?V3kvSkF4K2NISTJFQmJtUXVSazFoa3MzR3lJeUFNR0o3MndEYWxrRkhOM0J6?=
 =?utf-8?B?b0hGV1pnS1E5RTRuOTZ6bk9HS2c1YTlCQmkzbk5hbnZtdzZ6VE1nTE82cENB?=
 =?utf-8?B?VHZTcjl2cXlEb3k2bXRSbTRjQlBXNm12VDVCZnZ0dmoyNjVyTURCUGhPMElZ?=
 =?utf-8?B?akliNGxtOCtpYkZVNzZBdFFjeSsva2wvTys2TldYL1RXMzlabSt4VlV0WGQ2?=
 =?utf-8?B?NVZ2T1o5N0N1WXhpaVdyT2NaR2JhZHVZWXNkbE5kN0pWai9XOHV3VTVUQ1VM?=
 =?utf-8?B?ZzlHc2N0VGNBVDB5dnM0YXZmUy8xSXJrWktlU3pqRFdtb29yS0xGMlZxNlZz?=
 =?utf-8?B?TlVwbUtydkRwc0JTZis5aXNIMi9WdlZBc0cwTGNkWmdBK0dtU0h6T0FNeDZQ?=
 =?utf-8?B?VGd5UXFLVS9QWnNIUWMwL2ppa2x6dzVoNWpENDVyQkhmY1ZSdm51REhWUDRB?=
 =?utf-8?B?VFZjVkk5MlF2ZUJwa2FYMTlBeUgrR0tjcHJsNFVaMytVM1dGUVV1V2ZJd3N3?=
 =?utf-8?B?M1lIYTlRVzYzS2NiWlI0eVpVeUNVUFc0YzRYRm12c3QrYXZtRWpsRzh4WURl?=
 =?utf-8?B?NmRYdnY0OGdIOC9oWng2eGY3ZHY5VnFHMjE3b3g5c2VkYmtwcmJLRDJVQllh?=
 =?utf-8?B?aHlKZXI5MEo4TGFLc3B3TFphUEJIRHZpWmthVmVDWjBGK0hIY2g1anlRNTBS?=
 =?utf-8?B?eTlySHF1M2tyRm1BT2tqbWxSU1dYV1FrRVhFQ1BEY21zblV6SmtMWU1uSXBm?=
 =?utf-8?B?SmJNMkN6TFdoZloxQWIrOTlHRHNhakJ3dWdoSHNjbFZUWEdTU0czbVZsRE9x?=
 =?utf-8?B?TXNEMG0raWdNYk5UN3YrT0VWQUlHcHR2ZGVvUGxYazduem5PbG1kT0xPMCsw?=
 =?utf-8?B?UUVTZVpTWnAreWNnbTN6bVlMcFRmMG51YUU1dGRPOFlXbHhIS3h5RmhDTGdi?=
 =?utf-8?B?eEI3ZkhhZ21Gc3g1WEtjRno1L1JqenBYeEhjbmFtS2lHQ2U2UkZRZlovRlFo?=
 =?utf-8?B?OFo4K1l0dzdIRHhHcFhhTGovYTQrTUtlaU9pSm05UGRwUHBjQUI3MEFsZnVt?=
 =?utf-8?Q?8oVxHTNgj9m4NkZvFs+tHE9oKm3/A4u0?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:06:22.0789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8584a7-5c7f-4210-7926-08dcc5d843d7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7090

From: Shen Jianping <Jianping.Shen@de.bosch.com>

This patchset adds the iio driver for bosch imu smi240. The smi240
is a combined three axis angular rate and three axis acceleration
sensor module with a measurement range of +/-300°/s and up to 16g.
Smi240 does not support interrupt. This driver provides raw data
access for each axis through sysfs, and tiggered buffer for
continuous sampling. A synchronous acc and gyro sampling can be
triggered by setting the capture bit in spi read command.

dt-bindings: 
v1 -> v2
    - Add more detail in description
    - Add maintainer
    - Add vdd and vddio power supply
    - Use generic node name
    - Order the properties according to DTS coding style
 v2 -> v3   
    - improve description
    - improve supply definition
    - make supply definition as required
    - add supply definition in example
v3 -> v4
    - no changes

imu driver:
v1 -> v2
    - Use regmap for register access
    - Redefine channel for each singel axis
    - Provide triggered buffer
    - Fix findings in Kconfig
    - Remove unimportant functions
v2 -> v3
    - Use enum für capture mode
    - Using spi default init value instead manual init 
    - remove duplicated module declaration
    - Fix code to avoid warning
v3 -> v4
    - Use DMA safe buffer
    - Use channel info instead of custom ABI
    - Fix other findings

Shen Jianping (2):
  dt-bindings: iio: imu: smi240: devicetree binding
  iio: imu: smi240: imu driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  52 +++
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi240/Kconfig                |  12 +
 drivers/iio/imu/smi240/Makefile               |   7 +
 drivers/iio/imu/smi240/smi240.h               |  35 ++
 drivers/iio/imu/smi240/smi240_core.c          | 385 ++++++++++++++++++
 drivers/iio/imu/smi240/smi240_spi.c           | 172 ++++++++
 8 files changed, 665 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240/Kconfig
 create mode 100644 drivers/iio/imu/smi240/Makefile
 create mode 100644 drivers/iio/imu/smi240/smi240.h
 create mode 100644 drivers/iio/imu/smi240/smi240_core.c
 create mode 100644 drivers/iio/imu/smi240/smi240_spi.c

-- 
2.34.1


