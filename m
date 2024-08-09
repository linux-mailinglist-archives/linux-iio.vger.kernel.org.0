Return-Path: <linux-iio+bounces-8350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1694CF47
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 13:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EC128469B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63301922DA;
	Fri,  9 Aug 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="AlrLXCuN"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29541591F3;
	Fri,  9 Aug 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202227; cv=fail; b=aSWNaY4t8NZ+W1c0H6RAeDIqqPhsjm3jmAq4X91vpI5L/eIPNGe3tJ4iNSWxV9ypMZgMUSuohnizoL0uBYMTIExu5CZ8UyOGyid8613zKWIVhgKyOAyKPN7gpgY7lKdYeEdL/Recbg4jtBwpJN5uc2V839FHi3bZO066bz0mK8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202227; c=relaxed/simple;
	bh=M85Oq3jzwsm4CfDHf1wJxOX/F44pHwum7L8VPkjfyuw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UEpdKT4r/NbQ1tQQRY31iqnaCW9t06xncq5n5vd24lv3VHaS2kqe6DEt6WVUdAwY6Pk0Abhncq3PHiNojYNMneHrrekcHzisv+HLkSPPEN9HGlf57CEDhpYPLf9P0ZhgxjBLLwFPVKQaNmoUnl2/FM4N6ucLLSQ/jY0cqovOa2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=AlrLXCuN; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj/eicnnn9qdxfbs1tvuwekjEZwNcW7i8ctbqXZYqtkErNFHpd+cfgHifhoZRjmIPcwciHQy9p9er9Lev1DbEMHC5DDVA7VfbCZ9R6jhIkagq9d+2yqu8D7jxsG5BVDXHaQniliyZG00t+2EOt4YBaNU61QOacQ193FVqLnsN05P4CMgEWgckc+gVFYKgpn1+vLI90BXD7Tdxm03MRiaSaIcIKF79wci9XCNvE3GRFQF9sIXqwZcdFghBsmiUemX8nmlIfq+zhGUw0vEUU3Xd7GvcJpFvRbVFo93fF+fM19OdUUl49Ewt7+LbfzSMve7Y1t3hSYsax4yVS1arOIhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ljyw4niLmBBuyBsAY2VA7tTOOfymc8Rp9D0ZDFtIkZo=;
 b=KGDXsk559jnlvQj8OEFNo4m8uTbnSP69vrxFwqIFvI09VLTM3oV47NM5GG/W8AMP8vSlEyvppRr8GW0PPHn+jCbwazKwFHWNMUB5KfOsevFziTUJ0tq9s0lUuJolQM8Xa6Ohbn3N4z+OigeiqxY3ttgaRsrFt58CS+pLb3vXbI3V6blVQYUtl3CRbwYpUFBVAwhkd85VG3qsPNRMhIQ4aVs0InUvdRzYPi1TYCtH5jKjAZC+cePPqk8ug/JRa1tU07jewSYKsjHYDcpa6CpyZjxzDub4I0+vn3ZXlk/VqCwDix3Y+2VjnRc5Xk0NWgI2hcMtcnUKdq8kMDp+/AgqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ljyw4niLmBBuyBsAY2VA7tTOOfymc8Rp9D0ZDFtIkZo=;
 b=AlrLXCuN8mGC/Rpn11VK1d0Z3OdC+S5xdVih9q+ot0xrR/TFPskB9UXwqFZbi9TbWl0thcEqkUkpZSoUdLB2mvOQVFLXHKfR7gj85ji16SLiRhntINOyejXn3lUxB6CFQBkg+LzJB/SnVlneFOMjyD1Z2AwCtfzIo2SHseDp7m8JZ4QV4rAyqT519DJZgoi7/75G5YFCj2bdnQsC1dy7m70GvAVWlXwAn4MSsvYXqpZnqQcqFYhhO4Smj+hX25PZIV7J0sGdOOLKyn9GUp3fmm5HuShRligMibiPA30UocNMCR2kkvu2ocW6Y+fRpPDNdiTjDG7f9apPvUKcEBDvbA==
Received: from AM6P194CA0014.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::27)
 by AM7PR10MB3557.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 11:17:01 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:209:90:cafe::d2) by AM6P194CA0014.outlook.office365.com
 (2603:10a6:209:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Fri, 9 Aug 2024 11:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 11:17:01 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 13:16:58 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 13:16:58 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v2 0/2] iio: imu: smi240: cover-letter
Date: Fri, 9 Aug 2024 13:16:33 +0200
Message-ID: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|AM7PR10MB3557:EE_
X-MS-Office365-Filtering-Correlation-Id: a435dced-c377-4e2c-5b2d-08dcb864ca65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVUyZWFiRk1LSEkvZmRlWDJIYjk4TkxpVmhDZzFKOFB1Q0VTemhTL25XT0RE?=
 =?utf-8?B?a3RORm0yNFp4OGN4a1RWNlpQL21tNHlnb1VtcXMvTkJhOWNoSmFqUkFDVk5X?=
 =?utf-8?B?ZE1tdGVUd2ljS3hLZGx2NGV2bjZ0b0U1NWV1d1ZJUlUxNWVZNnRQRXZDNHJx?=
 =?utf-8?B?d2pRVnBPbU9XV2JqdW0rdmdkQXNiZlhQMzRMVTN5ODRuenNtcnZIaHpPdmx5?=
 =?utf-8?B?WSszd1lsSlllWDJNTXFOb3RSMGZjSjBsME0vK0ZvRWV5bSs0T0xWL2tpaUdv?=
 =?utf-8?B?L0JOR0JCUDdaUkIwNnFEM3pYYk0vL05NOVZ5K0NzSzFiQU13WmxGS1VFUHhr?=
 =?utf-8?B?ZHVsTEJ6OGtSTDRBQ1hMaWgrdUl4V3B0QlR3VmpHdmRzTTRwOWF0N3c5RW9D?=
 =?utf-8?B?R1EvTzl2YXlWdUc3NEo1dEp0a0dMVlI4enlSaFBSYlZLVFJOS3hDK1U2c2NB?=
 =?utf-8?B?WGtOcUhMTDU0MUMzRjUrdXRQWCtwa25ETEZuQXE4QjdSYU4xTnJGcHFnR2R3?=
 =?utf-8?B?ZmVVeVJnemhUbzhFb3JhZDVwc05qSE9hOU0wc2IxdWxFRGE3aUZLejZPMEVX?=
 =?utf-8?B?RUFDSEQ3bTF2R0NKbmxLMU11NkIwRWd3UmZzdHQyR2JqWll6QTlXYTRGUGht?=
 =?utf-8?B?d0Y5ajk0dVRyQ24xUllUZ3pMcEkvQnFXMS9PbWYrRlR3bXV0NUFDbGFON3NS?=
 =?utf-8?B?dFZzMkFFdkJSUHIyYm9GbU14dlZpZUpkbHI5L1c4V0pLU2hBZWQrbVhRYWFS?=
 =?utf-8?B?Mld6R0NvUzNsMTNhbmZHU0dJT09SS1V3RzAycUloSkpFeWRnYVVaa1l1dUpM?=
 =?utf-8?B?S3N6OVMvdWJ1ZjdHNXFneEJsZzU2S2NieE1QTWxrbHRheTc1K0RtK0Z5VVox?=
 =?utf-8?B?bTcwMjBqcS9kaW1HVmV0Z1UwYzZTd3pxa3cwUzVQNU41UlFmVTB2ek12Mzd5?=
 =?utf-8?B?UUpmSnJVMFJtaHB3bGlGVTJNYmE4c1ZKbG1OcnI0NXhjNnZyUTdibGJ2YkUw?=
 =?utf-8?B?MGM2OUE2K1BQYTR1SnN2cG14cThkU3B0NmcvYVV6enJ0NitSMElZUXBTY1BJ?=
 =?utf-8?B?QjZtQUdUNEZPS3owenZXRmtzNW9DQ3c3TXVjbjlXYkhrQnVaOHNnRm0wUG1p?=
 =?utf-8?B?NVYrdG9MVFp4bWVWUHNhT3BmR3ZVTnNWRWJHK0Z2L3NISWVPZ2xQcEpiS2tY?=
 =?utf-8?B?UGFGbDkrMTdPTCt3U0FzRm1MaDNsdUxmbjRoeEhibWFkVVpXKzVXU0RraTdj?=
 =?utf-8?B?WFZlaVRTQVdERnJKQm1QaTFTOUF5enpzb0U3TDhJdUlXNEZMNDl6S1diU2RH?=
 =?utf-8?B?ZDFQbllxL3R0NVZrSG85R25LSFVmdTRrN0paWXRvL3hPN0FqTXZpUUVLMEhS?=
 =?utf-8?B?RE1KN3RsQzhHVlk5aU5uK1dlMWlQVGJMWjA5R1BXaWxyc3ZtQThBZW9XWG5S?=
 =?utf-8?B?YnpUUFdlV1poV3RWZi9tanpSQkoyUnpCVmlIdXVjbVA5QXlRSWNWQ1pqbG1Y?=
 =?utf-8?B?d0FqODNWc0FMY3ozOXlVTDVQaHBMNWEwL1FvZEhwOWloTmZ5aDZrQ3J3RmRu?=
 =?utf-8?B?cU4xSVhRUHo3d1Bxd0ppQU9PblpMVjNlZExEcFpqazkweWJYaEl2RUt4VTNx?=
 =?utf-8?B?Nlg5M2pXTTZXLzI1Vi9ERUdxUlRVR0hvcFlWQUgyazlPUnRicENEdFA1dmFv?=
 =?utf-8?B?SVhsS01LT1c1bGNCZVgzNFJ3RzJtVXZTc3hVeDVza2FwQlJsRTRMRXVPdGtQ?=
 =?utf-8?B?aGx2cGVIL1NOYlQ5S3hMUFpSQXBMdUFKcncwUGtyb2JWRGF2US9KT3Fja3JQ?=
 =?utf-8?B?TG9CRVdQWWY5Mk5Wa3lDSm9rbG90dnI2dkxmeVAvQ2JXQXVQMFk4MWNtbFF5?=
 =?utf-8?B?bVlzVVp4WVpsUmQrUnM5YWxhZlZ4OURQbUdtTC83MndTa2lZdXJXMHdiSlM1?=
 =?utf-8?B?SEE1d2phSitYNEgwUXNtc1dtVFNKa3U3SXJZM3B1eVl1aFF2bDRpMlhMdC9o?=
 =?utf-8?B?REIwV2tzTSt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 11:17:01.0867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a435dced-c377-4e2c-5b2d-08dcb864ca65
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3557

From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>

This patchset adds the iio driver and the dt-binding for bosch imu smi240.
The smi240 is a combined three axis angular rate and three axis acceleration
sensor module with a measurement range of +/-300°/s and up to 16g.
smi240 does not support interrupt.

dt-bindings: v1 -> v2
    - Add more detail in description
    - Add maintainer
    - Add vdd and vddio power supply
    - Use generic node name
    - Order the properties according to DTS coding style
    
imu driver v1 -> v2
    - Use regmap for register access
    - Redefine channel for each singel axis
    - Provide triggered buffer
    - Fix findings in Kconfig
    - Remove unimportant functions

Shen Jianping (ME-SE/EAD2) (2):
  dt-bindings: iio: imu: smi240: devicetree binding
  iio: imu: smi240: imu driver

 .../bindings/iio/imu/bosch,smi240.yaml        |  51 +++
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/smi240/Kconfig                |  12 +
 drivers/iio/imu/smi240/Makefile               |   7 +
 drivers/iio/imu/smi240/smi240.h               |  30 ++
 drivers/iio/imu/smi240/smi240_core.c          | 392 ++++++++++++++++++
 drivers/iio/imu/smi240/smi240_spi.c           | 173 ++++++++
 8 files changed, 667 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
 create mode 100644 drivers/iio/imu/smi240/Kconfig
 create mode 100644 drivers/iio/imu/smi240/Makefile
 create mode 100644 drivers/iio/imu/smi240/smi240.h
 create mode 100644 drivers/iio/imu/smi240/smi240_core.c
 create mode 100644 drivers/iio/imu/smi240/smi240_spi.c

-- 
2.34.1


