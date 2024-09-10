Return-Path: <linux-iio+bounces-9431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450F97365B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521F0B248C6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD519007F;
	Tue, 10 Sep 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="oVYdXsQ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C418F2DB;
	Tue, 10 Sep 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968258; cv=fail; b=KXP6z4S5XzKPGs5+N183hTaEhS/3WHaqHpDEsDjgNwExC1jdlTJEhrfGXD4lbeAwhzGGmIxtTUNkHh6mnUO0EiPUCQJgv1CYUR3FzvrRiBcm/gklIioH/0JD7lxVoTD9hKlVAkm861ldMn/Thbr8hoz6OFyFV+v3OLVQID2+opo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968258; c=relaxed/simple;
	bh=vsGa8NEnYSWrJ0V5n8GhNj0/m8K2BfYwUxnoAqmU5PU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXyJHtiBQluhP7H4ymJ7mEwPy6R1FT9N4YPf5rS/VJNWBMSK26y+dFXsZEqcYQ/frG4K+LGUMPnFfV+SqlKnpSlPgFZmyTU5gnwnb8Ece0V3GJyGMmKxEy5bJFlkoZs0dr5xUDirUhrvluNU5TSMqsAEQ6peQrDoEVGOHdS55e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=oVYdXsQ/; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOS3cJKFS4W0QUdjXemGsAIkkP2ayjCa2I9lf2zKwUQTGpl9ljYoMPosQAMFvxhT9gwTzkcXv2erviMmq40RCm5dJ/jmTLfQWyNSB4Q7F4FJI+RWqBy3tn8lzBmupbImDxFuaUiQ/0Ehp95sOBVdsx6HxOd0eUu4OLiM7NnJJh/uXytSo6p0z0o6Ajx0U1eG+X5POFOK7hIjHbj9M1wPa9Pl4Ggx8/5ceMTznRI80NKzN2/KghrOC6rC57JXrStTItaKnPhFbD1F8VIhjnrOj1di1lHwPwZWL30XSO/IdioAuVHcvyONkwnQXzdeAOMSHo64liQpvt0xQ+I74XqvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJrD5DDB/QBu/xir7vph3xKfoD2i8Gjgtmi8hUjpwuU=;
 b=wz4+nvRK6+95azeddrdtb2fU/PignaWsH/Lu0NohoKzs2uwY17ijSUWxvZjDOOXlGm4NIA7X97XQiOgjkrvVT1aQIj39RFOTn7S03MynPETYFUEC+jNkgm7DhFRRegv7HOZ3HCmWDdNXXCNw+OJI+KT90QVzycQgvdWqHoj6upK2WVM6NvlVC9O2M0Z4m1jQ6lTxIzW9ULYhVe3dJXoVYPm6shUWH6gcJm6XJhhJIX7Nuv0BMNwskLyNUnHXSM4CNQnjI1VpYk7uvnW+PVfiLhaeEradmt/J3Yux1f2jzTlIrm8zpzht57vj6cCa4gdO0HTXjqSad4QV2GRLyNCxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJrD5DDB/QBu/xir7vph3xKfoD2i8Gjgtmi8hUjpwuU=;
 b=oVYdXsQ/JT1wHFtPkCdIhH/eZvxbKWeKfjVvniehv1wS7yCCYqT7VxQIpL203ohxs4ChUFenT1egiQOx0H5sxSDKqPBHWTrolLWwblJM4gA4H8l6PbeKKwObXJQYnVrggGE/WdMRhkSv6mtEeIG+iNVgwnLbGZzknYKw41RcfF7o//dEBNEWKMNbu+Y1s8HsFPASfV9u7ByVT0YNrAgTcy0s4ZQ3MqG8PftLPFlxL1GQaePtd/7Z3WVtzw9BY5Ox2Gwtc7K/WayR2WyxdV/Mek2pjlBBi/SkrybM/6Nt0+SWtTtYacmjxDfeYTiymKUDnjBlM3w5+g6qe8318KjdEg==
Received: from DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) by DB5PR10MB7890.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:48f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 11:37:30 +0000
Received: from DB5PEPF00014B96.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::6f) by DUZPR01CA0081.outlook.office365.com
 (2603:10a6:10:46a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 11:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB5PEPF00014B96.mail.protection.outlook.com (10.167.8.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 11:37:30 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 10 Sep
 2024 13:37:04 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 13:37:04 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Date: Tue, 10 Sep 2024 13:36:49 +0200
Message-ID: <20240910113650.4733-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910113650.4733-1-Jianping.Shen@de.bosch.com>
References: <20240910113650.4733-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B96:EE_|DB5PR10MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb2eb05-ad1d-4702-a18d-08dcd18cf420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWNwQ2RQTTdaWUxmUktwTEk0TDNCQlM5Q3E4clVNNU9CcFBVRlNqTjh3SXFw?=
 =?utf-8?B?b0k2YUk3TlRvckpRd0tZY2tQU09NZXFCWE5xcDZOYUlCNG1KbiswUE9KYVNV?=
 =?utf-8?B?REkwOGYvNVB5NE94TjFZMGZzQVhBWEZDMURQQ2RYNDRyTnBlejZJbUVyd0M5?=
 =?utf-8?B?aEdydk9UQVhIU2Fqc25TSFFYbGhkYWxiblpLZ3lFQmc4SStFdjFtU3grOHJG?=
 =?utf-8?B?NDIyK2ZSL1ducmhVS1hlY2x6Q3hrQ1dGeFdUTUU5Y0xhR2NpY1M3S2VBQkJk?=
 =?utf-8?B?QXRISmY4dU5ZdE5lRUxOZGtMdVBsbDgrTG5YcWpYRTk3VHJ2UXhjMytxVHhF?=
 =?utf-8?B?UUVIUE8yL0l2T1NKc2F6eGpFUEtLbTRtSXpmNitGS0V5UzlUSnRwVXRiMHph?=
 =?utf-8?B?aTBncENwNjdoOWRkQ3phdVhBR1lPUmZ3ZU1wWHMzZFZSMVorcVNvd0h5dEJJ?=
 =?utf-8?B?aDNLMEtXUFkrZWFwb3luanBtcVN2dlNYVjQrRW9leVowR24zWUx2emlMRm4x?=
 =?utf-8?B?R2RLN2dGZXRIQlpkVFJ2Wi9VdTRYWU10T0RabW5SM0V5SzVKQ3c0UXVLWFpt?=
 =?utf-8?B?VHJ5OWVtNWpabGVpTHZlWEpod1c1MGVybUIwdW55NkxmN21BNTk0Nk5uMDFv?=
 =?utf-8?B?aVlHMlRZb1FJb0RkMnV4WUZoUUFVdGxCZ2JXQ0NsY0N6WkxwRkhXTWR5VnZr?=
 =?utf-8?B?VFBqc0ExU1BLTnhSemE1eXRBOHZlbFhVMlFlaXBvTEJIeTFuVjNIVnNRdk00?=
 =?utf-8?B?OEN3eXg5cjFtRFo2TFo1UXN4VHViSC9JYmFtTlA5bnhkd3IyQkl3SS9waVNM?=
 =?utf-8?B?RzErdTNpWlR5dkh0cHd1MnR6UDNHVmlDYVVYT0pXeVV0MEU0SUdEOCtNTkRW?=
 =?utf-8?B?VEg5UU9CejAzWnNpQ3c5UGxZYkpQdytIQ0VBQjhCSHIyYzZqNGFiMnYxQkVr?=
 =?utf-8?B?aS9vVmY3SGpYeVpmWDNaaUJFSmdEZWRVcytCQTJXMGdGZnlicXBWWHVvSDU3?=
 =?utf-8?B?eHZGdzdWdDdsYk9MZ1RVNmhvYkhLZ0MxZFVsREpEenlsZ29mTnYyY2RXOTR1?=
 =?utf-8?B?cVZtVFRrVHNyNU1Ra0dmTE40MkpmeGxYNG1qamIxWlVhcXF3U0NtejUwdHM0?=
 =?utf-8?B?ZUJnQ0JEODA5V1I0SzIza3k0SXpQSjYvN3FobDRTVXFRN0ZkUkFyRHNsZ0pY?=
 =?utf-8?B?Vng3VFRna0tPTFl5c0kydWFHUXExSnc3RjMyV2Zvak5LUVl2UERFalpTSEhC?=
 =?utf-8?B?cytaUU91RXA1QUZjaGFpbGg1UGR4MGsrM0Y5bjl0UjR4TTJOVUxCbFNZNVBk?=
 =?utf-8?B?MFZIL05VVGNXK1BRSng1eVFaSmlOdVRVTk85MXdOdFZhMCtYbUJkVTQ2THFp?=
 =?utf-8?B?MGxDWlJBS1lqM1BYZnQ5WVVZZVlKMGFNUjRKakJxd1RuSTZLbkR0NzViOTUz?=
 =?utf-8?B?Q1U2K3N2Q2s3cnFlcUxuNkdtdTFBSDIzMVFZMmg2TWt1R2hnV0M1ZFpGemE1?=
 =?utf-8?B?NERvemoyMlNuQ1ZnOWlYRk1TQm5NY2pGS2RCZmRwNE42RWVyMVJtOFIzUENh?=
 =?utf-8?B?MDR1VzNsS0NQem5wRkNPc1BHYnpQM3hUSVZsN0xFT0lPaHFraXJBbktqUGFj?=
 =?utf-8?B?Smx3d2RZczJqMmkwUGVJN0NTdXRBMm9XNE9xLzZDOEkyV29XUFhpV2RxVFlr?=
 =?utf-8?B?M3F2elJLb3hTM2ZNbnI0d21STmRTWmFRaUxsVkkrazhvQmZXNVFoNkpRemJD?=
 =?utf-8?B?NzdBWEp6OUcxOXY4d2lNYVhvK0dBZ0gyWUtxQlBsL0xKWG1heTF0S05IWEFv?=
 =?utf-8?B?TmlDb3RxL0FKK0p6am9QT0l0S0ZBM0tNVDE1TVIyTmpjTEh0ZHlJTmNjNkZK?=
 =?utf-8?B?Um03R3hkUlFzYWJCZWgyMjJlSXBHcGhnc3BYODlwaWRqY3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 11:37:30.0079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb2eb05-ad1d-4702-a18d-08dcd18cf420
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7890

From: Shen Jianping <Jianping.Shen@de.bosch.com>

add devicetree binding for Bosch imu smi240.
The smi240 is a combined three axis angular rate and
three axis acceleration sensor module.

* The smi240 requires VDD and VDDIO
* Provides only spi interface.

Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi240.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
new file mode 100644
index 00000000000..58f1411728f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch smi240 imu
+
+maintainers:
+  - Jianping Shen <Jianping.Shen@de.bosch.com>
+
+description:
+  Inertial Measurement Unit with Accelerometer and Gyroscope
+  with a measurement range of +/-300°/s and up to 16g.
+  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/
+
+properties:
+  compatible:
+    const: bosch,smi240
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "bosch,smi240";
+            reg = <0>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.34.1


