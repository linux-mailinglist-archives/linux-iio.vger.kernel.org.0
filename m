Return-Path: <linux-iio+bounces-10727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DC9A4075
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 15:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D41EB21AF6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE61DFD9B;
	Fri, 18 Oct 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="DDZfHt6e"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB19841A84;
	Fri, 18 Oct 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259584; cv=fail; b=LI3sLmTpiKOymYq4AlanP+AddVBVDW3oONbBFkP8WQhOSX+h1QZE+Sc3v0YTAOBAbWR495JLezIMLWeM0fttWuhpFseNqN3oM670K++UDaz3AYQtcbkl1xEvqVgq3iwub/vi+3bonKcDpjqxBD9E34Q62WnP5xCFCQJmKnhqxAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259584; c=relaxed/simple;
	bh=Ssd/8UAGu7KN3UPkq4A0vpHmzXq9pQBl/b8vBAU57uQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4k2JMw7AeF+Pd1z90cyapltLFoKHxQyc2ouZ5evFD9A5WVxGd0MwLboExGvOOFda4Slt7l69plzAcImLcYA1Ko4a3g4ND95yUYqrq4NQDhXnd3lWCsjXXGLTnTuVwDk2/ubj8pDTu6hwLBexZyPsu9QirTflXgs2y6qkm4c1qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=DDZfHt6e; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du0xNTsTcAZsrRUufDhOQjaxUXB/fbNeG62R/bUTWea15QKo+bZBQA441OPEDtN8TeOicZX0iPPDaA5plykqpnyUPSBVFnHmgGsa6lS/xk69suIdQVClk7g2ErsFSnow8zg3l9+qSruoKJA33Go5+AaCwsEEAQK+hhU9HGA/CDlT2kkmrMIcBlTO9ae7JYceBrMrEOi2LzUreHGqU0kIhW671mErvN6IFcle1626XXZQViS3P+R9QGvxwVCjDEy+AAwS1a1vltm0nl8Z0so1nr2tJKu48kepmmn735x2Imx942ek3Ln6B6R9LodrFx8Lce1Tv0LrEZNYztEVhnDmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WEXVP/5HzeyB1dvLgThCvPsnkBRL1Wtx1l62Qj1A0c=;
 b=kyibsyeT7d68w0RIKkOzTFi/3EO/EqFSSVcXLiKpKFVCKujJ5NNOqZRMr0SL8Syw4PivXIpjyGX/a+CYazXkGhjglbSConETgqTdtQZSuAFqpeY9nk9PLEOiRSBmUfND5be6JzJYCnJ+0mymRxyH1RJ8xfoBxV7U0FPZLwe/tsJAijSOFZ0lYb1C1XpVBizovnHiniIdVk4WtRuAJN+1itirrk2vbD5qi0r4k08oBcEIvULzUuoPicfG+xL+dUtm57jDpur+/8o7WjqJTsI+g+GETlyAcj+/diKmrMCJGjwqW8WpV+K8/YV1shWmwJq37vXD7ssWcl6hiLW54xQnZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WEXVP/5HzeyB1dvLgThCvPsnkBRL1Wtx1l62Qj1A0c=;
 b=DDZfHt6e8flj/Af0NAZjQd+YN3/wrGnoU9ZXIP0fKlSGh9Rec5mZkW8Yn+8ewAlZs3I161l0NCBEvUavK80ht0Ijhzaz/7NtjMKORiLVYA3jOKwF3YpCi4V8lNu5a7V2+HQPsGZpd3p4TGF3pmsojav00XGu9SZAvg4qSFcJBQ0XM3NAL1Xu8S5hexObMvyePvbp1KPjGY+LrInkwo3oQAQAI5L3ezL6CJLwsoMUlG6qQTV5tv/l8MHidfu0AhOJiwzedQ19QpVFzYOpgKFhNVMJ9jdHLXaeKL5UjT7ZQ/am4337PtzGSZTGBRQ1SYIF5rjmnDuq+x8hZn4l3Qy9dg==
Received: from AS4P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::19)
 by DB8PR10MB3910.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:14a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.11; Fri, 18 Oct
 2024 13:52:57 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::cb) by AS4P191CA0023.outlook.office365.com
 (2603:10a6:20b:5d9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 13:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 13:52:57 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 15:52:55 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 15:52:55 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v9 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Date: Fri, 18 Oct 2024 15:52:33 +0200
Message-ID: <20241018135234.5446-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018135234.5446-1-Jianping.Shen@de.bosch.com>
References: <20241018135234.5446-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|DB8PR10MB3910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b22832e-bd25-4463-7c62-08dcef7c2be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmxhZDQ4VzZvc0FWb21IN3NJWEVVWWl2Y0lCb0ZxNi8weG5oTjdpRGFqTkhB?=
 =?utf-8?B?Sm85N2M2NkRkNWE3dGVEN216dU50dDBCK2J3REdBb3FvVlhJRUZicXlYUmNh?=
 =?utf-8?B?TlBjVjZuY0c1bFBWdlR4dTR1N1pxVU5qTTVmQytDYVVXTWFxR0hBUGVGMnQ1?=
 =?utf-8?B?WHVsbzVZam4xQTZlSUlSVG9mTkVmSkVBR0h5RncxTHZ1RkVoRHYrS1ZES1Bk?=
 =?utf-8?B?ZkRCdHI1d1ROa0dTWDBCSnZiT3ExY1F1KzA1bGVzektiRlByZXRNZkRWSUlV?=
 =?utf-8?B?MEdMaFdSd3JQTkFYY09NaFlxazFISks3MCtaTEg1SHJkSC9LbFZTamE3T1FZ?=
 =?utf-8?B?UTgrWTZYTkc0WE9Ha2RDK3VrNGpNTUgySVExUkhlVDNWMXJjaGpld29kRmJD?=
 =?utf-8?B?SStUUGNZcjF0R1I3ano1eXJkTnlSQnJicHZ2Vko3QXpyWkZ5bDAxZmducnJD?=
 =?utf-8?B?S3JGMFh6UUpsaUczVjRqSnN4OVdXOHNKYjYrU0V3TTRkWTR2eU44V2pNTEtJ?=
 =?utf-8?B?UEVXdTdjR005RXFzZ3FreENuK2t3UFpPSEg2K2h5aWZTWVJQdmJidWtDSW1N?=
 =?utf-8?B?aWQyQWhjSjFDVktqQ2xNTXZybFZzSnZTVWsyYlk0aE5iZ0YyYUVWUnYvcnhM?=
 =?utf-8?B?WmpMYlJGVzJJd0pWbW40MDhhNE4zcm1mQ3NyWmpXVW0rWVYwZHY2R0VicGZr?=
 =?utf-8?B?azZaYXRHNW9zVFNxRjBZZzNDQTQvUGEwZE9UdUlTOTBHMDhyL2F0YmtLNnFr?=
 =?utf-8?B?RkhlT2x5ZFBxbHl3Nkp6b3hjUFZoTHM5Nlk4dkVoVkxQRXU5ZEM1Y0lPb2lr?=
 =?utf-8?B?U1E5TDVwVVRiQm5oNlpiVmtJcmtCanN4Q05qeEpsRlhyQkdIaXE4bE5BU0hS?=
 =?utf-8?B?NFJWM3BDWlB0Z21rMnB3R2M4RkhVeUZjeDJVZG11NmtlNnZNMXN1ckR1Y1d0?=
 =?utf-8?B?a3h5TzA4TU9tc2NQYlQ3ZkZ0dkUvMXlrL0prWjBhT2hMNUR4WWlVdEYrL2gw?=
 =?utf-8?B?Q2lrOFZPSFVJUzhHdmtCUnBlUTVWemc5YW9YZktiVUpRa240eUJHM2xlOEJR?=
 =?utf-8?B?V3BZM1hyNTZVMDFRL3l4VUJpL0YyNkdSbGhYZVp0cWdzOHJvVUkzRStVaEFK?=
 =?utf-8?B?d0ZqUFQ1MDk1TndiZ0VKa29tbG5Tczl3bFkzZjU0V1MxWEJhNGMzMVRLeVJ2?=
 =?utf-8?B?SzA1SmZaSVVRM2tVNVkyUkVId05Da0gwU1lJeldwZTIxNTZDT0plWGZpcUNP?=
 =?utf-8?B?RmF6U1kwMXl6NDAzNHdKNGZYOVNUWndPTFZaNS93L1BVd3hLY2lGNStCSEZQ?=
 =?utf-8?B?cFdaZzA0dHFzODRCNHJkYVlPbVF1bDNQbmpSdDRxd01JN0p2NEhCanNWeW4y?=
 =?utf-8?B?YzZEbS93L1VUTlhSYVBHV3ZOVmNRZFpUdkwrNzFpd2tGYU5iZjJzeTlCaTJI?=
 =?utf-8?B?NTNlU3JlSHJiaHpFbGIxTURWM3JyZjRWbWMySTlPUlFSUE1MU2wvd1lTMG5t?=
 =?utf-8?B?WHliR25meGh3ak5mTW0za1hDM0tJTDBlaFJPaFNRam5NQlVSY0RORWM1OWtK?=
 =?utf-8?B?MVRaajNrcE9DKzY3TmpJN1M4eVFzRHVwd1NDVlNObkwwd3E2a0tibEF4VnQ3?=
 =?utf-8?B?V3A5NVJ0bFlHNUdhSWR6Yk1sOVNaZDJWbjZzZmlGQnFjWkhwSXBKbDFtWlNF?=
 =?utf-8?B?SkYvU3h5TWhZam1WOFB6ck1kR2NEZVI0TXJ2ZlBJT20rOWhCelNpVjdZOTUv?=
 =?utf-8?B?Zzc3Q3hmcE9ocllWS3ZJUkhhemZURjZQRSs4OHZ1NnhBamM0am9nRnphNWN6?=
 =?utf-8?B?andvQnBXYURwZnFnRURjditKZnpxelFNWXh4QURlZUl6TFFFQUlqdStEbW04?=
 =?utf-8?Q?jxUkSdx6vctj2?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 13:52:57.0847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b22832e-bd25-4463-7c62-08dcef7c2be9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3910

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


