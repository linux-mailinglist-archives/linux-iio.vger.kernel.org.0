Return-Path: <linux-iio+bounces-7838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03193B10F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E5C1C2110D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A44158853;
	Wed, 24 Jul 2024 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="JabA8/NH"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011641E488;
	Wed, 24 Jul 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825518; cv=fail; b=VZATLtHE1Q+JovRA8mLVb4zDG12cg7BZNee6rc1hK31YzY1iDV3VYaJ+YouByK/pt2COhd/FwGUUn0J2yWCjzlqClhSoDghgDeHR6WJU24JLRpubeYA80REI5CdoYZ5TqU2sMuJyEjvoQXpX5+JThRVOvjNA+PqFRhFESR7MlOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825518; c=relaxed/simple;
	bh=gA0p82bVwMM/pTK+6ymmbNwkxX/28quSf2FLvFsNPm0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qZgm2CBzx9PX98MOoyajaviYERV4LLvpRF7u8R4esAEx/mLg3cIJc2/6moftnpJzVXVChQhS+k2xPWZG9f8bSr2ovamAYRYb9ObQRnYzHB5RSPadp9CvlgvD4snwz4r2S8SWs/jRTRLhDt1qS5ZixMR0OCYWWv88JPQbhXXmZts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=JabA8/NH; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCQlHZR/U7BALcf1J3MEHGkHmC2TkkhOElvvWnYRzDIHzW9SbR+xTm4xPzH9Chxlhfv3iuVaxhsnEMASiYlbyAPBipH7bp3TqE9jmAacOVogIJQvuPwL6VzPIZPQruLKrWl8fpgM1Ue85uZjzbBvOJr8GrEGeZM+fJTXywIBeavnVjVR20JwmPytmV7xlOttg14zE2TBDVauHk6oIaMQF5rPDa0MlRGLCGIGE9lyL7h/R7nUANe82bx86ef3NZkuki7slywEPJKA0Oesa1vMtqzIJRrv6GnMx4dn6TXOmN9cSdKOA5mT2ZVycxRJ777jl8YsNgWdUxut9EdvkakUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGHhaeuvPh/AOjyHJ9XkDvJA5lgc6bzSeYprYivfPnI=;
 b=hmeRwz1/LyaoiISm5BPJPB/NnDIOhJe52dzvn0PqYjqCx4n2+3PUXvXvRTSfNF2qAFBAZ5sb2XJlaPbfuWb+w2NR++Y7JpcJ2QG2auA186kL5/sr4Oveo7aIeIMijksKkR0Pt/3JYfcj7P6TyMbuT5GMHYF0lcRQqVhS6xuFhSZQG4S2fFKaME4ovkSv5q25OOcyVuQOAV/uLW3YBwSVi+a4oRdnZvhWx75jDuZSK2BGEjCuhIIVtXQkuUZ6HL0M9+U5ZQx/vKKYX4umUFhR6UaLnq2H7IpKRGWey00jyVjCK95qT5S/ZcHNMX5C2muRUjVDyECJLZWUjPtXMVHJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGHhaeuvPh/AOjyHJ9XkDvJA5lgc6bzSeYprYivfPnI=;
 b=JabA8/NHkD7P5b2fw9FGkD4nyhGQkS09H6lkT575f5vGNlY7qbSBPFm3jXgBFlIAkvOHFaMPOret0evV1ZMqTelVGfaoGjNJHYhUiEseCtn2/V6m4yT/eCcKcfZagaHOf2s063p/uh0D3OY9Pd0GljtxAI2czs3zlSmJnXjaEoUAwVHmR6AyaB1GYrWnwp3ixoeOu3D7ADPoNBhiVImzSIed9U1p4tEPOToAO8EtvL2uC15odWhrK2hHFM+BOitrS7UzuJg7yiPbzd3T5NMCrYH0JACF7h/xR880NR7NPX4cTLWxmHc5WVd1GWR1ujwNO9ZA5OTmCNCc51GoY0R8mA==
Received: from DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) by DU0PR10MB7609.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 12:51:50 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::39) by DUZPR01CA0058.outlook.office365.com
 (2603:10a6:10:469::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Wed, 24 Jul 2024 12:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 12:51:50 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Jul
 2024 14:51:37 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 14:51:37 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Date: Wed, 24 Jul 2024 14:51:15 +0200
Message-ID: <20240724125115.10110-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|DU0PR10MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: bd97b422-0300-4fdf-950e-08dcabdf62e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmUrR2JFWDhNN2VFajlVUDNtTkpKZThoZHlUeVVpSFg4d252bC9CemRHUCt4?=
 =?utf-8?B?TU1wdkFFSVA0d0J3SWlHb2NYRFozb0RaL0FGWGNtTWZwUFl4N1o4bDRUa1hi?=
 =?utf-8?B?V0ZaakprTG1VYm54enczdExwRi90dmdNY1JEOHczNUUxVjZrdmhuQmQrR2FG?=
 =?utf-8?B?L3JlZEcrSGJkbnE0V2YyQVQ1ZEtCbjhsVWRhVTFGTnJCYllQaFJ1YlVhNjNL?=
 =?utf-8?B?WGtqYjNWWXllSnlBN204U1RxeW9Db004RGxLYi9rSFpHS3hjR0pOaHRVajBU?=
 =?utf-8?B?d01LczZIbmNMRTk5T0RycHFOdFVVN29iZm8waU5WdWdybVB5NjVpZ0V4blJV?=
 =?utf-8?B?K2EzWFZXdzY4eFI4OGFRQ29xOGprWlIyWFJ3VmZXWDZvL00xU0Y0MUNnbjRM?=
 =?utf-8?B?VkxleHBISjIwVG1LS04xTklCczBZSERmU2NkamRVZm0rUlUyblBtM2ErVjgz?=
 =?utf-8?B?Tk9abzVVNWdvYkhGSmprcS9uUDU1d052dlBLczlacjZBZlR2UU9IdTlYamtG?=
 =?utf-8?B?bjJEbERpSUgwM0Y5TjlmUDVUUU9zditmYVZwRDBKQnprRlNycWJ5MkZiZ2Fh?=
 =?utf-8?B?RHhrajJETW0zZXk3dHlpR3FOMWo2OURnQlFNVXM1cjZqYzZpTHdKNFQxT3o5?=
 =?utf-8?B?MU5FQ2haTVhjUnBtSmlWVXQzK2wvVkFocUtRa05ZV2JuVm5PaHhLWGtka0Fq?=
 =?utf-8?B?cm9OczhncE5POGFPNFVYd0xYZmliRkZwamxOKy9KODMvRUVNT0pLRnFuNWdo?=
 =?utf-8?B?ZDVDZXlCMFh6ZitCbjZOMnRFQ0w5Q1ZQYUZuMXhWM0UwdHdtWHdhNzZoNlpZ?=
 =?utf-8?B?MlZabzBqejRubWZkcFBUSXhjayt2YUtTVkhnOU5uNWpIazBlQkpxQ0lQMTZI?=
 =?utf-8?B?VlQzU0NPM3hFRmZaNVZuR1dQUFZiMnYzTUI2K3RWbm1QMkFlUUx4VGZDU3dT?=
 =?utf-8?B?bWovSDNBa0Fyd2l0K09mR2UvcEk1WEtCS1dWZ25BTW5FVzh3T052Q0c2RjQ2?=
 =?utf-8?B?Nmt6VlhMZmpRWXRFZ1BXMzdNNzNqMXMwTWNqM09KUEpkaXRzMWJLNmtYRkE1?=
 =?utf-8?B?NUQySGo0eVZmREdBNWRnWmtySkhMcVdVaGJ1WEh2RC82VlB5QWk0TDk2aTNu?=
 =?utf-8?B?Z1IzVEtNR1ZPMWlwcDhyQlZ6TDk4NW5OWHd3RHBQYzJkQnlXaDJ3VFk3bURQ?=
 =?utf-8?B?ME9rczFybDR4WTQweEkyaHg3QkhseWEwQTcwOHN3MnUwUUNPTWpDcXVPckhO?=
 =?utf-8?B?NTIzTWhERXhIbEs2dHNSMXEvVGk0dkhzdWtCVE56akROVFlKQ1djS2RXQllI?=
 =?utf-8?B?akJ2SmNWZE1halRlYldiWFk1V2NrNCtGdWVDYjdyN3VtZjdVYm1sUkRhTlBu?=
 =?utf-8?B?blZBQkVIQkt0ZTJTSDh5d1R4SEpGRHY0ZWp0Q1BPTkpobkFrUmJ6dDlRcGJl?=
 =?utf-8?B?ZGl2TUdvemcxKzJOd2Ewa0FUWGp3Wi9qTHNKY2I1b3BNSTFOZUZFVldhV1JQ?=
 =?utf-8?B?UWNVT2RNbWpnQmtOUkZOVGE1Ujc4N0VxOXFVOWxGSUU4NkRHT2FvM1RiK0E2?=
 =?utf-8?B?Qy9TZlFYZnJUSjNCaTA3T3dQMEkwbEcxREpLckRWQWtrcmlKT3p1TkRsZ3VM?=
 =?utf-8?B?ZkdmdkwvcW1td09mRFdsM0N2SzQ4Wld5S29qbFlsVEZ5cGQ4bFp4VlFtRStz?=
 =?utf-8?B?cDJCMnNabjMvci80SzlTRXA4d2xKdktLV1dGVnhUamlCT0ZHYTBKdkJzb3U3?=
 =?utf-8?B?YTBxdWVUTldUTENGTUZqc2dzaXMxWEpMU1pmSzhud1ZxNmY2WHRGMzBNb0dR?=
 =?utf-8?B?MnJNcXQzSi82Z3dmck10QU5WcjJYSDAyN0pTalkvMlYxNHVQaFRPNWxiSG9l?=
 =?utf-8?B?UVh0aXBobktkMnNUblJJMzJJMDAxdjZjMXVKd1ZWMExHMWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 12:51:50.4362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd97b422-0300-4fdf-950e-08dcabdf62e9
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7609

From: "Shen Jianping (ME-SE/EAD2)" <she2rt@LR-C-0008DVM.rt.de.bosch.com>

dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Signed-off-by: Shen Jianping (ME-SE/EAD2) <she2rt@LR-C-0008DVM.rt.de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi240.yaml        | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
new file mode 100644
index 00000000000..5e89d85d867
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch SMI240 IMU
+
+maintainers:
+  - Jianping Shen <Jianping.Shen@de.bosch.com>
+
+description: |
+  The SMI240 is a combined three axis angular rate and three axis acceleration sensor module
+  with a measurement range of +/-300°/s and up to 16g. SMI240 does not support interrupt. 
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
+        spi@0 {
+            compatible = "bosch,smi240";            
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.34.1


