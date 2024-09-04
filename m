Return-Path: <linux-iio+bounces-9141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801C96BFA2
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B341F287C2B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47FE1DB551;
	Wed,  4 Sep 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="WSOxczsD"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723E1DA61C;
	Wed,  4 Sep 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458741; cv=fail; b=Raj3MHFxZ2sobuYtbFmblbVBuMpz7SRIZ3xn9oTszklqP9Gq27d0xigWAgy5ad0o+pIFa5QCzcklEHAEmkmV3VAwDE38LhIl6O69tI15F4VapYahL9Psgkc+MimKKRhMbSv98WRT4HLQk9XtOxBeZAKUzYQc9dxY+ra07HzHgzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458741; c=relaxed/simple;
	bh=awGSb20H0GgOK8qXu9s0V0pz412UO9cCg9Sow2gDr2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7gL0rhPI+yjCxRrcBVbejI3bHfVUqQWR1Pv4dPLheP/S2RsfiMTCnhmBZwKRXzGQnFYa/j4lJ1RrRgfYbCTZziOpYSKh1mT5er5fT0pDr4bbvi5A+nkPQfbzgeFJfaVZhCZ5kFaggVq3aNrQjdIZgkzTfjSNNi1pzJ0INN3QCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=WSOxczsD; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPr8vIPbAM8lk7FvZUQyqRv4iy8nIKK423f8pMoDwUmJCjZIT2BjOl+9rdBFDL0la7S8FCA52yZ61t5L6umbwUcBzigStpKcZhckZ3iUpKJT0wILOZA0pi0ss/JHnj1rt/d+1EUv1uDNVZBk5b3pSEWlgPhGtIrQGN45AKE8SAIDvorjPiKawodKO4fWMHMuiCstzbkAYMkraw3nk7Qa3g+x67Fkc/u8sSnje3exeAs2WMH1LN3HSxp8CWpSICyhsTBm9+v/XR/rlL8rc/WgiiZSVOEmN6VbW7BrAD8DNvhxFvLc4CPZOihSXwdpuE3CHuidvWTTQ+VWv5J3XXfApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNJy1ewDEjEWjD1DI8i5m9a5eL7j4SLy6Dnf/PRGAO0=;
 b=j3TzG5nPvTjpN+gKuI3HfQVS5tRIz0gFZW5qw73qb64hNu2hf7O/AHq9w9XlmZ/05K3378my5i2HyoWCCShkmpigqStIm2MVSsyQcF+5OyyixXx8X8H0GewEWkSRt9uVsUG9QzA+ImmkmuIlqDKMiDZGOCnAGtvGCviTYwKa0y+1Iwp+41byVzpnTXD/Cfsw8bZOb5NtLpDsA9sop68zQ7/4KNdNcKlb0PzltiSFa37IzEx5LrQ74oRwwUQldc+9EwSgp0BPqUGSS0zAz7likfALExDJs4q5vTB+oFZibM75BUm0Pskjl4q17cdM9WPoqven7Q1EM97UCHY+tB8pDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNJy1ewDEjEWjD1DI8i5m9a5eL7j4SLy6Dnf/PRGAO0=;
 b=WSOxczsDB8rkYZVkpmUK2YmPWWrqYingha3s65WYjxYbLj/jJ9Z9HbKXwwxCmButI6L0M+f/1Yu2uPE11TXmrbk5+zepYYh0R+Eyl5wVzMQ9jt9QLIeeuKklEqQ4acs4v+SX6/cgDyPgaPRSJMt8Ay8QX7BAIcwCns24P4mO+wW6ZrMPYRAzjy4NDHrXTscbzFxkU+oX+L1L4rlZrQ5moGkELtOXzzOCEX0dlpLqKjUxjOxxjHqcvTE/kvOFv4AqENv1YgREbhQ++cP4YbxzhzdxI+HgJOg/0M0U220K6XGReYx/LD3kJSK7Z8PsBCP5Zhhski0JQpAzQEhMwyziGw==
Received: from AS9PR06CA0672.eurprd06.prod.outlook.com (2603:10a6:20b:49c::18)
 by AS4PR10MB5223.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 14:05:35 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:49c:cafe::2a) by AS9PR06CA0672.outlook.office365.com
 (2603:10a6:20b:49c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 14:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 14:05:35 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Sep
 2024 16:05:19 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 16:05:19 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Date: Wed, 4 Sep 2024 16:05:05 +0200
Message-ID: <20240904140506.4741-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904140506.4741-1-Jianping.Shen@de.bosch.com>
References: <20240904140506.4741-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|AS4PR10MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 632c4367-0cb8-46a9-3676-08dccceaa5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2NRRGxuby9MM3RQUjFsbmQwVC9CYUJVemIrcFZqZ25SS0xBVWx4WWc3eDlV?=
 =?utf-8?B?M3dKeDNreURtTXJ5QzNTK21DVmN5dzZyMllqMjJtd2grdytaVGc2VWhKZzc4?=
 =?utf-8?B?ZkFVMEVuV0pPNXNPNnlwU3RTRWY4RkNZNmZTWEtzdlNoeDNiNGxYVWh1cSsz?=
 =?utf-8?B?Z2ZrR3VobnNyeU1nQTVJMzB3K01KN3dqOHRyc3dEV1FJb3NKanp1SHhlZnlQ?=
 =?utf-8?B?UEl4TmZsa2F5WmhnaGEyTU51Q0YyNkNLSkN2ekxkQTNTeGZiMXZqaEJnMGhK?=
 =?utf-8?B?N25GKzF2VE9RUSthTlFHeFdZcGdwRURGV2lLUm5HT0V3OEkyeDRjMDVDbXhF?=
 =?utf-8?B?T0hGL0dDN3hrbVc1c0ZicHdrOEMzL2p3eGttaDQ1OTE4aE1jOG9WNklLZ21r?=
 =?utf-8?B?ejl3N3lsT1EzTTYwR3BvUEVONzc4UW1LbUlKSDl6MkFWb29tZU9xaWdqbFhZ?=
 =?utf-8?B?QXlRVytsK2JiU2psME45M0RLNURhNitJeEIxYnhqaDM2UFU4d2c5T3EvMUlz?=
 =?utf-8?B?Zm1Fc2djZlpaVmliN1dPeDMwNVdQSTFYdDVEWFRsVWZDSGtpWmlvZ09NU2lx?=
 =?utf-8?B?MU50bCt5UHhhQWFkdXZ4R0MzTTNKR0t6RG1FUC9QaDBFOUR3UlhGNzArQVJr?=
 =?utf-8?B?Q1U1b3BXU3VYbHJVLzBvSnUya1liWlRXcitXelMrREV2Uk9TblJmalBZUnZF?=
 =?utf-8?B?MmhXVkhLTkM0Z0RaRjBnMDQvWkhLSXVMKzYwcW5kNTUxVlF5eU1LLzNKRmxp?=
 =?utf-8?B?dzF0WlQ1WW5kbGJGWlhjRGVNQ2MwUG5TNlNkbVFpWjIrVys4WDFsMVpNdks0?=
 =?utf-8?B?anNPbisxWFhHUkViOWM0NkhqTVcwd3lTOEtsTGdSL1BaRUh4ZEh0THc1ZkJR?=
 =?utf-8?B?NExzVUZOZVZBMVVBT3JwbmtLWHBOVERnd29ZRitSVEhxU21WUnhkMmJrY0hn?=
 =?utf-8?B?YmVoNktKeTNBVEdGS2h1VHVKRGtzTzR4VEZjYmhYZVpzbWNETU0xeGVlUnlQ?=
 =?utf-8?B?cmRpRkIvcHlZWnM1dm5jbU5qTmhodXpMVlhnVmExM1pKM3BacVFDd3c2OEdO?=
 =?utf-8?B?TTA2bDk4MEhvRVc0U1g4RWR6OSsrMmowWS9FZUhDWCtLWHdnQ1o0VlI0V1Vv?=
 =?utf-8?B?bm10cmU0UWlQc3FuRHN5NXcyZW9ieHlqMEhEUFBLbDlteU9aY1hsWUZ1bGhx?=
 =?utf-8?B?anM0dFBuSEE2QUo5OEw3em5DeDB5dHYyUVhCakxCUkV0RzRJK3lQcFZuNVJj?=
 =?utf-8?B?SFpvOVZFZWVmZlRUaktBZWhaYTduR1FZZ2U4REkyRnE2Y3hvMzA1N0RBSWdm?=
 =?utf-8?B?UnFMKzZlODJMeFRGWS9UemQrUUx6ZWFaSytFTFdha09Xak42RUF5NnhBR09E?=
 =?utf-8?B?ZjBkWFlCNnFxYm1wN1N4RWc3NEgvOTFTSTllZkkzOFVIUHpLWU5tUG5ITUlP?=
 =?utf-8?B?b3Y0TVlLSmEwTXJJWDVCWmdDUmRvdW9hN2JOQTZEaC82UlhkMTg2SWJKVzl1?=
 =?utf-8?B?cE14RldOZnB0TVdlS0ZuakUwNWM0aWZTVit2bGJJU01nbWtiZ2w1Q0t2U3Z3?=
 =?utf-8?B?NkhZTUlkVnZEYzc5NkU0bnNGRTJtOUEwTytzelF4MkZHRkFiQTlTNjRwTVRT?=
 =?utf-8?B?S0VCeXVKVUNOT1pvZWlLNWppVm5vNnJ6RlBYYmd6QUpZcXAyalByT0tZOWN5?=
 =?utf-8?B?ZllvNkxUS0tBMndXcjRBWnJyNVU1TlBiWTg3eHJlRGlTWExJVzFYZFZLaVdj?=
 =?utf-8?B?L2xNMVZFbkJzcXBQOFZIbjRHUUM5cE5RTktJWGNLMisvbzA5UUlrS240UkRs?=
 =?utf-8?B?WDl6VnVDWktERnNzWU5JSHVqd0VyZ3g0K2VpcUkwa1REWmpST3VsSEhyMGt3?=
 =?utf-8?B?Uk14d2I2NmpFYVVmNXZMR0Yyb3p5Q2VsYmpJZ0RpcVRsV3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:05:35.6163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 632c4367-0cb8-46a9-3676-08dccceaa5db
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5223

From: Shen Jianping <Jianping.Shen@de.bosch.com>

Add devicetree binding for Bosch imu smi240.
The smi240 is a combined three axis angular rate and
three axis acceleration sensor module.

* The smi240 requires VDD and VDDIO
* Provides only spi interface.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi240.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
new file mode 100644
index 00000000000..6f1fb4b892c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
@@ -0,0 +1,52 @@
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
+  The smi240 is a combined three axis angular rate and three 
+  axis acceleration sensor module with a measurement range of 
+  +/-300°/s and up to 16g.
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


