Return-Path: <linux-iio+bounces-9737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC497EBA3
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 14:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219DA1F21CC6
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4C11993B7;
	Mon, 23 Sep 2024 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="slznwYBK"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8013B7BD;
	Mon, 23 Sep 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095258; cv=fail; b=S223SrWYODSauKImFB2zRTE+Pu0FdyREkTO9kt131QZgEm+nPke/SSZ6jv8Ebtt8gWkPWTD3pyDPxnrzBpaz0yak6K/PjEwcIwrfGXnmd2Y7v1w3JvtxY+t4R/mw3lqv6qGZ41HztoVxUDi7BvZV3wkEo0klSBGI3uWj2Qjt5lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095258; c=relaxed/simple;
	bh=Ssd/8UAGu7KN3UPkq4A0vpHmzXq9pQBl/b8vBAU57uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oL/f58BHjtp9JpFpt+dSEUVZNN+MFGkuSNBBg8xI1iYeKvicGpljT1gPR9H1B+rNtlXDA78z82a9haswruYxDwimj+wnkYLB/6lncM1C6icwgbKsapH2UJkiRqE+9lx+bCyyOPokn41he3K1LSfaMYxvV3tRIonFlVwqUfF0Kgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=slznwYBK; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXjmV4qgNoI/b/c/Uoiklt5N717XNt27RCENV2oYaRPjpLNnA+z7PB1o0hm13rBtosc4wNLD/htRgBOLMHSpuH3+/IqXVo6jw7Fj5zgaPy/g88dUT1weefUKeSTaBy78m/e2cH38oLviOX+1FcrDnYHK6JQ0NZrXmLKZXGRVAVnmtBSZgJesC/VBa0/2hEDMqllQaXKJxJIdEAWI6T7w4MnXHjHatFibaqhVA2lgkJWhYqvI9nBXRX6vGgiUP9J2bvsbQSvDLvBkGJ8a1GkKh8u5Smz86suiJ++fuED0F0XrzuuwDM51XrnQVYknEVDlIUtARopOnFs75FhWoaSZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WEXVP/5HzeyB1dvLgThCvPsnkBRL1Wtx1l62Qj1A0c=;
 b=FRAdqtyoeDYZHXOG02QGTd/6luH5lzQCmunFBRJSv+WhEd8FcAECbeI12Ti550kJ/qq9dOEmEJ4kD2g6vjULDRiwNxn0zKdF38oCka9qoayqbQHDAnIK72l8muo0CW6DfbAdvR2mxXEpN4IZsJR77gA6UfnhL0JVg32aTfPCp5RTWcVWqQN1LLq5N0+DDfS66n1l3qFIYr7FaDt4Rd+O8ysNqEizlgNKi9RAvGfg3zuj0hx7UfZwggo54OTi921GP6Sfa3UdBYgHrqEEKdMGrk5NENagnf/Q/5PmBfibyYCyBpo0plFMGdajyrB/gxaiJd7NsZ3K8TcKsthbOnlQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=temperror action=none header.from=de.bosch.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WEXVP/5HzeyB1dvLgThCvPsnkBRL1Wtx1l62Qj1A0c=;
 b=slznwYBKyDT6rMIkVFfERBhHto5GUfzS1JiOdeFrqLy9qpreAen2KuRvJ9THx46IdYlUN/wNjKgeMjBpkv27Yk/dnJiOcj39QzUt1JxyaiXr6R0iSGQFo1+szHz4O6ZKATZhyM0LEJ0HpZ0GaMmuxj308r7GUBskHyV6Jrt+pBi4Kr6cnCuD0F+9zwwPjIkHzkzLls/M3l0xUgrmfdYRybyS4dkrWHJEWANgd1Zeut9Pa1BHnP28y2Nydgv01CabXH1/s42juiJ89KxAyv7e7az8Fa37k2a/pCF4eMrg8tCZ1KJwgy5dB1uvmhygAr18wp3lwjvQKlYkPgYzCgzMKg==
Received: from DB3PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:8:1::49) by
 DB9PR10MB5644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Mon, 23 Sep 2024 12:40:47 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::5f) by DB3PR06CA0036.outlook.office365.com
 (2603:10a6:8:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Mon, 23 Sep 2024 12:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 139.15.153.205) smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=de.bosch.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of de.bosch.com: DNS Timeout)
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 12:40:45 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 14:40:31 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 14:40:31 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v8 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Date: Mon, 23 Sep 2024 14:40:16 +0200
Message-ID: <20240923124017.43867-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|DB9PR10MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c37c3a-c842-4d7d-ed77-08dcdbccf1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUhHY2QvMXd2bGN2QytuUDY5blMyMHFBUE81ZlM5TXpkc0RnQno0TTc1WFdL?=
 =?utf-8?B?OFluMmxaNlZiNkZaV21oaE80ZlhidjREdktSaEdlVk1DclJGekpYREhmVE5v?=
 =?utf-8?B?Y1l2dWFRajVLWm5RR0tybmpnTXVDRXUvb2hxcktDck8zREZsR2JzNEJXays5?=
 =?utf-8?B?aDVXWk5VVDJxNXhHejdyZjhzbDBEcVBWUXBCVSt6QkFTRXZ3Zmd5M1l3Y1lz?=
 =?utf-8?B?YkQxcVFFTzRRM0ZhcGtSS2hkLzdUZ1FEblV4L0RmY1VWMjkzVkVlRHVvMGtZ?=
 =?utf-8?B?MnlmcVZXYWJHeHM3VVE0KzBSYlc2VDIrOExrakU0TGNEQVM4YWcvVlF4RkF3?=
 =?utf-8?B?dXRwekpHblNNeGh0T3FkUEx6ZVFXVHBKbUZFWUE3dTBzYnYxS3lRdVRBenRN?=
 =?utf-8?B?bm82Q2NJdGhkSVAzaU9vT2RremhMRFFlc1pBOHRoTTRKY1gyZHc4cUk4Qmxv?=
 =?utf-8?B?VElmc2hia1ZvRkQ0enJqTGZlNmdsNnljOVVtT0Jjbnh6WHFVZnQ5SFpjdm1a?=
 =?utf-8?B?bVhkTEhzZFdPNDhkNHJlcStyMGZjWHozWGxKeTNJYk8zcmROTWhhdjFsMGNB?=
 =?utf-8?B?UWROVWRKeU10aU9KTGNDQ0hDVTBtcmhiTmU3Qk5PZlU4VXNnRVNYdE1UVnFX?=
 =?utf-8?B?bExTaWxKb1pDMSs5aS9qdHFhMHdNWHg1WFJJWGVJNUNzYmRuanZtek5wN0J5?=
 =?utf-8?B?NG1BVG1nYSs1eldkbHRtQmtHdGM0OEJjNmE4S1Y2QjhjcThlSENnWU1teU15?=
 =?utf-8?B?V1Zqbzk4a21HSWUramVEeXUxWnlUNnkrMzZDUkF4Tk1rUU1sKzNqRW55Q3FJ?=
 =?utf-8?B?RDNsd0xsdXN3WTFvRlVDWHcwckdPcFdDRm5tTFROMnNCc1NxZ0hkYndqY3Jt?=
 =?utf-8?B?bnVsRHU3eDBsdm1MRCtoQ09lTHFYWGtHTmlTK2tZRlpyK3lxK0k2MFlkVGZS?=
 =?utf-8?B?aldZY1Z4UXBKZlhUUjR0V2JWeGNnR2h3bU43bUlvTDFKOVlZN00yZWVsOGVx?=
 =?utf-8?B?WlMrQUhCMHMzL0l4WmxMM1JlWHFFdWhCNUhRaHN1Q2dadk42M1FoT3d2a25z?=
 =?utf-8?B?eGVRNzZNc1dpc3VROGQ0dXhncUFsMXQ2b0VRSTlKa0ZLVlg1TnFQWkR3MTdW?=
 =?utf-8?B?NzlyR2tFa0hLZWRsaEhJYllHMERqamZCSVZoK0tQUVRpTUJocVM2MkFsNzdQ?=
 =?utf-8?B?TENqTWtKVWVpYlZ3Znk5RVRCTWJTenF5UDFQN2NxY0R2T2htVHA3WXNHUWVs?=
 =?utf-8?B?U0FURUo5T1l4cGZhZ3FxRUpFanVWTXJYU1I3czRsRDV2eDFjSk5sWmN0VFBD?=
 =?utf-8?B?SEd4Zk43RTd5bE9EY21FRDUxYlgzb0w2OFNteWIrdzJ2SjY1NFJvSU1zcUpi?=
 =?utf-8?B?YmlvQ3VNeWM4d2Q4Y3VmbWs0blNEVllrK1ozVGxyZ2x6a3FSeHhyTnVWTEdm?=
 =?utf-8?B?UVd2UVNJeGF3a1BlK2w2NWVBYjFKZlFQYjJKK1VNNGJ6T0h2VXNITVNuMEcz?=
 =?utf-8?B?ak5jYWI3OWtwNzNZL0VUbEpGTm9SMDc0T3l1YndRdHhNM3lBRlZFUEovVm1W?=
 =?utf-8?B?elJpRlNOOHNFNFBXSmhUWlJDTVlQaURNcHJ2VDd1STgzbmdCdWQ2M3JYVWV5?=
 =?utf-8?B?c0U3RUpuSU1IYmY4SnVrUGhQWTF2Mnh6cUYya2dqL2RLV2l6OS9LaU5pY1Jv?=
 =?utf-8?B?aitXWml6bitKV1o4VkNJa3BkT244Qm9WK2Y0TW05NDdxcHJhQkJyQVF0aWp5?=
 =?utf-8?B?RzBKRlpFT1Urcyt2U1RjeXFNb3VBc0ZWYUFNNm1GSUs4cjV3c1VSNHY1R0RL?=
 =?utf-8?B?QitqSnIySE9wRXNNamhwWUJORWwyVWJGV1hCOEZSTHh0d2ppZ3p3VUl6WDRK?=
 =?utf-8?B?ME1uNkJQZ252VG1nUjQ0TGtMMFB5UVNZYTZPSUorVVJoenc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:40:45.3742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c37c3a-c842-4d7d-ed77-08dcdbccf1b3
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5644

From: Shen Jianping <Jianping.Shen@de.bosch.com>

add devicetree binding for Bosch imu smi240.
The smi240 is a combined three axis angular rate and
three axis acceleration sensor module.

* The smi240 requires VDD and VDDIO
* Provides only spi interface.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


