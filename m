Return-Path: <linux-iio+bounces-8352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448594CF4E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 13:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA57282466
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECED194088;
	Fri,  9 Aug 2024 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="JO8ccHsR"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0335E191F65;
	Fri,  9 Aug 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202236; cv=fail; b=ulTqCornaMXUZlbyQeX/EoqlJiIzQBTI2Mr3JjAJ7TN++wH8ZE9YxHOOoADymH0dey4OZD2sNbWvZhzLjzIcf5vnRwIy1veTUp719beR21QWn65JG3UFjNrsH5ecyU31ORdurVBphLe7Fw3Kzo7o0gHupjUf3xDU+lyucLf86j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202236; c=relaxed/simple;
	bh=B9pVNoIguCPjyjGps2EzPCtJRA4yLSCC2NnqXDGrPrY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4rQKaU5QMKY5BrFFrneQhoUykyPiR2aITF60R0ItL8pL0FffhqHjW9bXhe153KwNXGHqtZZBdGJk/5eBA0ItIauNiPNB1RMv23PDBW3PLSCTf6TMHhrMH7TdWaYtqrmBfSkrkSC8IoZ2ink5gGr01PRHKOFM1aMYqapMo2+C7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=JO8ccHsR; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXVvmdUaEpiToiWivyPHKpwtPTAb+c2BwCbdA9PfZ/A3ymZzfDmrUAtll68HxjwpaeAZImSP6SROgqdzm8cebs0cW10FC3hj4gprf+QQQNmySpR912lMS9WjKb6eEq3x5NXJX8TtAcEpWN06Ms/Zuqr9DKRGqlgcGnZeK83R0zQmfuDTIAaoGyP0ok1dYdH/lHp67W813hh4ErJK00Klz9O7Zece0bq34GQcMCMIXPJG7LygnFcLrRlOef+OrUaeTW5sWOjCIwo0xIVHc3Sbrvq3hjyUyMMEqdc8SYz5IBwURoPsvHgcmP7DpefLq9d3EmgUw68y470jcbrIUCHYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bEu+OCPYwJ+m+dfMHCjIaoyxgMh/sQ2wIIsADFi/z4=;
 b=iDnlcPdJ012Z7v9aRxQv0c+PxDA0jzSHLnCqYhh6C+Gkz99/c2nAgp083cgFTQi2v/DphSXAELDuWPZnC+zPZvMmGVwSP/avMrqVC1/lRc/Vtxrd03pD4FbD7oFrEeeZwD6ZprDpKbHwr5MxpWBSERlSkFykO0fuJGHSjvF/AzMUf7jCqFd50W3dFz/N6DwbyP+pAgbz6/5e61hW+CNYRPbLvRvz2Krdgo2lNlf4gx+H6JORfdjZkvKutDYN1bwKjlia95ixMzlpi9qwmFsAy9R+0d6QJm21vsWgY+7UPIn+wErRx6/ntvnuYZUb1nToxHncqGuNqYzPb00HkZ1MSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bEu+OCPYwJ+m+dfMHCjIaoyxgMh/sQ2wIIsADFi/z4=;
 b=JO8ccHsR5i8fAsefpB/i/MkDFPptLbYfYjR9e+IkB/O1n9mcw6KqyvdUStwJu8P9uo6/8eZgGONx3TpnKL8Ge4tX4z47kutli//KX0rZEMRM3qN+c7UsEgvCk2JWiVY0maz+1NRnLVR+xeHl/11B+kvOKnjTGun6siJC94hKLxvO8L5otyBMhbAhqL9GMN7DSaNlO5kp/Iz/OzJz+HXyvSiSObUNkbwd+w/UyQhZOwb5dDXoTCHNTIkvlNoQOadoqg8OJLAODbN9rqrexAPke3qPkinrwz88nE+7U2jCYSW2TIRzkvkFxqyLxVW/q1GOcQ2IjMH4SIJs2ZSS2vzPdw==
Received: from DU7P250CA0026.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::9) by
 GV2PR10MB6718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Fri, 9 Aug 2024 11:17:10 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::c8) by DU7P250CA0026.outlook.office365.com
 (2603:10a6:10:54f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Fri, 9 Aug 2024 11:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 11:17:09 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 13:16:59 +0200
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
Subject: [PATCH v2 1/2] dt-bindings: iio: imu: smi240: devicetree binding
Date: Fri, 9 Aug 2024 13:16:34 +0200
Message-ID: <20240809111635.106588-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|GV2PR10MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca85a10-f5c8-4d60-df4d-08dcb864cfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTlVbU4yNncxVW9keEwvVzYvNGRjNGpxOWRERFFxZWkrWkF3elN5ZlhxMHUr?=
 =?utf-8?B?WUFNVHV2MTcxQjVTUUhBS1BmdGM2TWFLYlNjVnl5TFMwMThvQ1VtNS8yai94?=
 =?utf-8?B?WElNaWxEOXJIWlcwbUhNM05DZ2RtdEE4dS93Nnd3YjRzVlFsUnRMRExYWjlQ?=
 =?utf-8?B?MU4xUVFGcUIramVETHhnSmpqS2k5N2pDVldjeFU2bk5zNGd1a3p1U2RjMGha?=
 =?utf-8?B?K0RwSndLNGNPVVpFK2xTZWE1U2RFYjZwMUpmbWd1bUJhUEVhUFRJWUhRSzB6?=
 =?utf-8?B?aFRWb2N5Q1FlYW44YWFuUDkwQzlxcUVlUDRSMVRzRTlaS2RPUXQ5Ry9FdFhK?=
 =?utf-8?B?dHdOODhoL0JkRXF6eUw3QkJiTlFrYlREd3d0QUp0cTMwMTM2SHZYOGwxM0E2?=
 =?utf-8?B?bDdpbnNJa01XeXFBV1dVdDVZdEU4Z3JvN1NGTCthRHFEZFJLeExPcnllY3Jx?=
 =?utf-8?B?ZUdjdGhlU0NKSkJ4VG5DS05XZHhzd1JxN051YklhV052b3ZSamFhUk13OFF6?=
 =?utf-8?B?clM3a21mcVlzRFY2b0l6dVJSRWpJNmJaRjZ6U2RmWDF1aHJmUDFxZk0wZXFz?=
 =?utf-8?B?VHJlekprSVp4emRQbmZqRVZ1VDY5bEVqMTFmVkEzb3NycHFtY2ZEWWxwRm5Z?=
 =?utf-8?B?T3JhRkRoUTF2SWJid05wbnE1cHo4MDhBbDIzTFpROEZTS3JhbnAxVmJEbytp?=
 =?utf-8?B?QzFLNmpmYnBHSGVaS05SN1lQMnFncFQ2R2lqS2pCOS9WU3pSRDZaS3RBREdB?=
 =?utf-8?B?S3FnTjdtQ0lpajhFRnhaZGE5ajRtQ2M2d0gyUUJTVkRvTmo1OHlWV3g3emlp?=
 =?utf-8?B?UDVrT3J3YmgvdDB4S3U5aFlIY2dGMVVKUysrak40MytURmVGYTRGMk54SEVH?=
 =?utf-8?B?VFRUVWZKekM5R095cjRCdHpKOTNjYlZUMktuT1BPV0xnL0JmZnRGdTkwWk9m?=
 =?utf-8?B?bTkvUGhrd2pFR2EzOXF5STRaMmJBbndacyt6Q0pHSURRSjRLdk9sWGU0aDMw?=
 =?utf-8?B?SHlsN2dpNjFLalNadlRSY2hBaWZJempjdUoyZEk5aUJSdDJEVTVQVWs5WlM5?=
 =?utf-8?B?VE4wSjZWTEFzTHJGNGNyMkdzOUhwNzMyY0I2eEwzRncvbHRZaGtVcW9MUGVt?=
 =?utf-8?B?TG1sbVRBbW9oclBSMWFMRXd4SWtOa2toSzV2WWVNcXRmcTg1d3VRYzFjMU5U?=
 =?utf-8?B?NXN2cGZ6Q1l2d2ZrZEVrUGg4aUZaWWFzRWJnMEcwcCs2ZE04SU8rSmFzUlBW?=
 =?utf-8?B?UHkveWFSTjAwYWJIN2hGQkN6TU9uSkM1eFo0VXVMRnNxMmROSUdxdTVXV29L?=
 =?utf-8?B?NFhwSDdTcDlFRUJwSGdVZFJGSGNtcFBJdStCQ2JUYm83YktaMmtkY2Z4a2dM?=
 =?utf-8?B?MFJFOU0wRnQ0cS84YXJ6NkNvRFBpN3ROVlZKU3p5MXNmZWJZUExwTGY4SGtF?=
 =?utf-8?B?Z0NvNnFCUnhJVzdZZWlpUVRPQktUbVhZcmt6T2JMRWxtdUtoQVRjelJKbmh1?=
 =?utf-8?B?Q3BhU0VmN2V2QVo2MHg0ZTJmbDNRb3JqY3R3aU4yaWxtcHpTdGo1WXFQdlF3?=
 =?utf-8?B?Y0N3YjJSRVhLN1hoM2l6aW1iYUEwZUJzZ09URDcrV1E4d29IeGEvWkY0Zzhp?=
 =?utf-8?B?TjBxU2R1M2oyaUpyTEJWeExUZ2xIK3hDRXcvREFkWWFvcWRMOEVtaTVIRUxx?=
 =?utf-8?B?LzY3VkZCeHpWcjhOVFlPVmdENVo0SU9aTTdYY3Q4V3VlekZGL09IWjBCdWJq?=
 =?utf-8?B?TGdBcDEybmNybjRZN29VTHFxNlYzbVIzU2JHM3dHbHNVY1h5NVZpVm5HVjB1?=
 =?utf-8?B?d0JDdHJzNTJVd01HdW01YWlHTm5SOGNIUFR2RHRoNzJ3TDFzWWxmOUFHVDRm?=
 =?utf-8?B?MlZsRUVnaUtUdWZaZVFIRHcza0E3NDVPelYvVlBvb2cxMmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 11:17:09.9848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca85a10-f5c8-4d60-df4d-08dcb864cfb7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6718

From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>

dt-bindings: iio: imu: smi240: dt-binding improvements
Signed-off-by: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>
---

Notes:
    v1 -> v2
    - Add more detail in description
    - Add maintainer
    - Add vdd and vddio power supply
    - Use generic node name
    - Order the properties according to DTS coding style

 .../bindings/iio/imu/bosch,smi240.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
new file mode 100644
index 00000000000..0529e67de26
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
+  The smi240 is a combined three axis angular rate and three 
+  axis acceleration sensor module with a measurement range of 
+  +/-300°/s and up to 16g. smi240 does not support interrupt.
+  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/
+
+properties:
+  compatible:
+    const: bosch,smi240
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
+  vddio-supply:
+    description: provide VDD IO power to the sensor.
+
+required:
+  - compatible
+  - reg
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
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.34.1


