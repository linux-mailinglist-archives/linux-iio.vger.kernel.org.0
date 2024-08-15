Return-Path: <linux-iio+bounces-8499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A49953727
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC38B262A9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 15:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FEE1B0123;
	Thu, 15 Aug 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="e3gwgMGw"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE81A76B7;
	Thu, 15 Aug 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735587; cv=fail; b=mABCjAlWrOohC1tmC8af158tUS0FOD1d86ZyrOBMt/LdibnDqX29qyeEkbhob6gMEYs1ktGVCOKB313c+6m4Rp5eXwZu9Q9cd8tQMLPqK5ltr2RuX4xJcJm97Rur3aFhLHIc4k9HumFMptGXAfu9tOnxQ9t/2GpyQmbJeVQKa+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735587; c=relaxed/simple;
	bh=0TOaM5HJ7DgBFJ6iHuhvU7IpEaEwtwybrvrqvRafUAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzhXaaO9kB+a+8/TvtOjkoU4eVkK/lyS9aWXO3xXuN6wJ1RvvFkJ939NpafJYY525R/lu2d4QecbW8a2/MmeFjAsY0ziJqh7td6rSEkJinUEZXUMmtzawhC579ob0oxTrZUXuPyXrJyPKT5Z+LGFSqXKhVzeECALV9NFw4LXaqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=e3gwgMGw; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu+Bx2fz99Ahacn8FT8422EAVXH/ZrRwrWFBrbGli80K/XpkL2MhlGSpXgfpu6N0za8WlMAOYRcav11Jpe6D+KBh1OvioPVPLuAVWkomlecnECP7pMPXNgZG1aIQxkn8bUvGoVYOT1A6hnfc82ucbf2jZegrqbfyR/KENJuLGCgWlwPD2qeZDupi/ZnSIMkF19LcN8a5UR8Hyd3dh+VCgqDZiSSUD5vVs7BPYRRKpAPjMh/hktg2LDZzkX0XePB7GpdQJej2fCex+azGSSTPZBuL/x9Ix+puT0DDyvztx6QshGbdIUNP4qq1yNll47l622r1ZCQWlcGQkcQSb/R9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjUnBqheD2L7Xxk3dtPkVxYoKpFGiKz2TY08P/WNjj0=;
 b=Uz3wLRAkjpjS6qYLXnHruF1OteX9vZA3Y7JhDWA6CQk+MXscXgqng8oCZ+0q5e0X3fjQUc7QfeWF1yk/EXlZM47JLrSR5s6sOsY4KPvkM/C8lOHBJRt2SMJqS0lb28vcfjJVfjlT5I/NS9H50Lu7M/8rXsw7HqDT1YP0O5yR+BaHqGL7HMOxgHr1SNmty3vo2tIlTIePEH/F5v4CQUAEUxxY2+qTPN5wB7uFOZFuzwGhJlw8MSv8oUHqEZOFSZa37JxX+yAaitubprDcEpdLoeXG1WzDqlScdqkWw9FQ5ti3F1/jJc+bPD8TJXX02A+/BIIal/UMENKx5Lbt5Bb3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjUnBqheD2L7Xxk3dtPkVxYoKpFGiKz2TY08P/WNjj0=;
 b=e3gwgMGwL3QBh1099ON6Ev/4xto3zrhCGMpLgBG73w+jHfGBC+sV8tXdOA8TMPn+8Kz7QrpyreRAllRYZhXURiJS+NVgwRDsQNeMeTCA5ODLWCOW2aH0910tS7avyTSoVAETfRUNOKxcCfCReFdsmHEwW++pN1Rt+3cpcZFsmQ3XBhp7RdIXWSq+YjKa3f8XXMRfPT8WVfiUl55MWy3Q1J28IlWqmrf2tuEZYPYL4+u4Ra1yBxj/MI2+k0HNKMIKiDsJ6H5ZlGNYT+PEDDoKKVPLnNgsFGs/02s69AhMKycXbceM2eJVLPcidT+nz6to6BNpRpjkfGBpSJbMus37Xw==
Received: from AS4P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::17)
 by AS8PR10MB6390.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 15:26:21 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::15) by AS4P191CA0026.outlook.office365.com
 (2603:10a6:20b:5d9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Thu, 15 Aug 2024 15:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 15:26:21 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 17:26:05 +0200
Received: from LR-C-0008DVM.rt.de.bosch.com (10.139.217.196) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 17:26:05 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: smi240: devicetree binding
Date: Thu, 15 Aug 2024 17:25:44 +0200
Message-ID: <20240815152545.7705-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815152545.7705-1-Jianping.Shen@de.bosch.com>
References: <20240815152545.7705-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|AS8PR10MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b040a2-dd48-40e4-5f77-08dcbd3e9dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STdXZ3psSjhLOWFjUnI1VEw0MXVhODlkRytERDZIczJmOGxqZjhpRng2NDAy?=
 =?utf-8?B?Y0ZXK1VUWW9MK2dxc2lab1hvd3hLVUpMNS8vUnpFamh0TVh2WTUwa0lRMDRC?=
 =?utf-8?B?UVdScVNxcVMvMzkxMXJ2dUFOZmdheFN0SUhaeHMrKzd1WldEZmFUazhLME95?=
 =?utf-8?B?anphT0FRRHpKdTY0aUxXMFR4YmhKaDNJU1RNQlI3RWw0bzNzcGNnYnNJZldk?=
 =?utf-8?B?OHQzL0NhbEtmTk5YalNPSldwQTFqZDZWcndyMlJreVAyT0dUbDM2NkRuenVE?=
 =?utf-8?B?NlMzOFJCU2xnVTVHZkhnbk9KaHFnbk9BOXhpcEhFaFZLc0NEc2ZrWTlFaFNp?=
 =?utf-8?B?WElYSjEzaDlDVUdhWDB3bjJKTHhsVkZnMUhiajlOaVF2UnNxYzVZUWFnTUdJ?=
 =?utf-8?B?azFxdnBpQmVURU45R1BMUDZ1QytZcXEwaDZjcDQ4M2pHNlBHdlBGTGxZOCtq?=
 =?utf-8?B?cHlYcVBjYkVPTG02U2ZNVFRGSUl0Wks2ZGRHU1k0UXc1ZDRpY25VM2llSjdt?=
 =?utf-8?B?L21Zclc2QllGVHFjeG5RbXpMY0c4SXRhOVRiVlZwQ1dxcE1yQUlaMEZvNjht?=
 =?utf-8?B?WWMyN0xBelU3MTVrem9oTTJOb1NEcXRxQk40OXRLYnMwOWh5enhla1RaQysx?=
 =?utf-8?B?WnBSbktKMlNQbGdFTmd0VUpUd2hxNVl2eE04eVNxSTNDK1ZYUzdTUGZRaSto?=
 =?utf-8?B?dkdHNHpGb2dJVVh3OGNIbllFeFROOUYwbWR1eGNxMlV2dDNUOHoxRlp4VGJC?=
 =?utf-8?B?aFRIL0U4VXQ2TlYwYVU4QkVOQWhrSjJya1VPdzNKdGRCeHg5TVRCMW80dnh5?=
 =?utf-8?B?Y3BJK1dtVDhLQjZSSGE1MDBzSTExbUxobXBGOTJIU1pTaUtnRFgrdGJFNGp3?=
 =?utf-8?B?TEtkUWFiZWRsaytJL1piNXVWM1NmbVhwRzc0QmhlN2hWdGZJTXNVbXp2UzY0?=
 =?utf-8?B?MDArcllkbEwxRmdxSGVVL1UyN2ZqSitGcERpQ0tJSnZwY0lqRGd5enZaeVRP?=
 =?utf-8?B?NHlDcGg2SVBnbXZpOHdUMEYzc2dmcmFwdzZJcGFQWVoxVERubzViRTRqajNW?=
 =?utf-8?B?Ull1eFQ1bWM4K1BkK2JTNS90eGJFTVBCaTNoVW50SzUwR3lFR3NxRlNEYkhS?=
 =?utf-8?B?UjFLa245UGJNa2g2QkFOMmR2WnNkKzRaODVOZzZ6MDg4NjBnYlNxNCtpaVVE?=
 =?utf-8?B?cFdyeTlvdXlYK3dTRlFLN3JmcjVsQ0k0WUFtWlRtS0FNVCswd0hOSU5lb2o5?=
 =?utf-8?B?M1JXT3Vzcmt0bGdDT0dYb211SUs0Znl3QVNjWVNhbzdLaGlhamtUS2xjcGpF?=
 =?utf-8?B?NldOVnhZOC8yQ0dueVRRcERZVjdXWUlUbGk3bGMyMU1BOGNyVXh0TUxHdkRm?=
 =?utf-8?B?eFBKcHRLT1NOSmRTdHNabGpVcytxdDJ0dWdrNVFlbm84a0gyRkpLcEZQRHZ5?=
 =?utf-8?B?azBSV0MycUtEbDN3bFR3R2U4WlBSZEI3MlBBSVRsdkNRbDBnZEtrakJzOGZI?=
 =?utf-8?B?Y2dWaG1rNGhxUHJvaXdkVllQWG1TdnVoaGh5dmh6VlVEWmIrOFFJVGxWNU9S?=
 =?utf-8?B?NFhzUDVNczhYV3hIY0tDT1g2cWNZd2RxclRJdjR1T09nbU1XbldHVk1CYkdy?=
 =?utf-8?B?VHlkWnJJNXR0U2s1QUNZVUFMbmpQd1hIdjN6RkRvY3pldkVPbEcxZXFoSDVB?=
 =?utf-8?B?Smw3d1BCS3BCZ2dvTW5pUHlReWJYU2JVUVVyNXNKbDNITW9qeEZBZkRWTFNa?=
 =?utf-8?B?ckxRU0xvUm1pMEZwdzFNN0poVmFHeGtZREJOdVplK1RDampHWXU3Mnh5NlZI?=
 =?utf-8?B?ZU5MUmpvMjlYQjBhNkVFRUNVTDMxUHZGOXJxUWlBQ2txK3drTHFRODF2Nllx?=
 =?utf-8?B?dlo5bHhTaGF5MTM1TkRtSHIzaERBU0Fab2pUZTAxTTRGU3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:26:21.1001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b040a2-dd48-40e4-5f77-08dcbd3e9dba
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6390

From: Shen Jianping <Jianping.Shen@de.bosch.com>

dt-bindings: iio: imu: smi240: add sensor dt-binding
Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
---

Notes:
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


