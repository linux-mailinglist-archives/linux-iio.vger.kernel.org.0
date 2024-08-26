Return-Path: <linux-iio+bounces-8806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9195F38A
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5961F21918
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA118C342;
	Mon, 26 Aug 2024 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="GBgukaNO"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9818BB84;
	Mon, 26 Aug 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681189; cv=fail; b=H+5hPQxRRUoXUpThFlvkwC3vJP8aFzgns5lHSfQCPEKY5X/zZF86Ua74na3CEQ7xWUP4/08tHmk01frY4XCCes9IA1DMxPHNMabwwwgsKQynBBqi0YollzWmAEG/6aq9VzhsrKKZtzR1Q1WdXNlKTIWT0Pr9QmJl+bXee2R9Ig0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681189; c=relaxed/simple;
	bh=SvBqDJFNC5ozGP0YfWHw3FxVs5bu78gUWdrontk+79U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWLPhSEwZqfbIZKiHX7XM6i23SnjNt0KWwRWacGwpx8i+MhC8WfuuDz7eiabHCw0u4Z5TO30AumGcy+7icIZgpTcWR5UbrNXV+ft+6p/Rm9t9XqXV3kV/olzV+zX4v7DjPr2FB4sQbgXNi11i7k7WUPRPSRzBF3dfkb+ZFY5Xz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=GBgukaNO; arc=fail smtp.client-ip=40.107.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsSxGct2aZmAYGqzGHzJ+nN3qvEplEeKqg12RG1yrEVXok7cF2fFRhMMfpJjbVLf6qiNCr51CELDKWS+dUkkmZ92zrZ5cF4ELQtlKli8klvDe+g+u8d7IGa5I4pHkowaF5f0YBpSTczLNLtJ3TWT1qBOJlKrh/fkW93Tsjx6W9T15TRbxoUm8r3Pkae3qc52IzV+XqUHYPJrtNcMs+GgqdIxFIrAWQW5j6AL+aDBqUaCOn8jilBczW68Lon/iAl7DnA3EFNn/HNrmMWelyc101URPTo4GXNBbWs47GUUma9iyFvsR4HnmGM4n43fOFdWYzLEy7QRXm/uEB4RAxXv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jQeZ0O4QK8otOa05tUXG4fSMUjoxCsgc8g8d+LF1wc=;
 b=qble4ar3mtQE3j9WcMxpZU1HAZ+wvKCniwaOH2M2hnkPX3FnMF2ZIOzlCaOuOG0SyjV0rsMZCo2aUVA+/f/LYbRxBRjatcu7gJV4XbH/jXRXBR66r+r+TH6lELviH43FdZp+rRL6qjxwHhVY6hDtdKOpSCzzCKlr8YMYOmOvbKoWtsvdo4vH1jh6agjh63wBBmFYqcf5pxQNGFoDS2k/3+hdqPm6AHMXF7LgzqPmnxZcktCBZ357H13Jtgr/Fmk0QLw46CLJzI8Lsne0MYNVwrwe1rl8zNp/89rxhAZrJ/fTV2NaIJ2u35X8L0qkuoVbuS9bnS+o9rG+BqLNgcHpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jQeZ0O4QK8otOa05tUXG4fSMUjoxCsgc8g8d+LF1wc=;
 b=GBgukaNO9UOLm8LlR53YNdxlzLxg975LYTNFgOGt80WGRp9TUXlnuNyyKRpfOxnCzimOAQaN1Srv2pf062i8F5w8+Xhmwl8LF3SoR4GBR5hTYXbQ22G2eZgkGaBgYM41ZEaJdgw5Gd/PFpK+Xn9RgpC9Lc9fFGMwEZaGB2aOzvbSdAhOLzUWPrAb+3wn5xx2mqNNam50jmGBfLSEZ8SisKZXv0KzWZJuiJb++PunYKlKgxZMKeo2cna/Px6B6oDJjNOjjEQiLTNEb9tyAgCcbZihTHkBNqa03d3DIrPMdgUfRclLawv0VaDjW/nJ7gNIDbcB5oCVxPwOfeZnqqeWzw==
Received: from AM6PR0502CA0054.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::31) by GV2PR10MB6044.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:7f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 14:06:22 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:56:cafe::b0) by AM6PR0502CA0054.outlook.office365.com
 (2603:10a6:20b:56::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 14:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 14:06:22 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:06:07 +0200
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
Subject: [PATCH v4 1/2] dt-bindings: iio: imu: smi240: devicetree binding
Date: Mon, 26 Aug 2024 16:05:44 +0200
Message-ID: <20240826140545.4085-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826140545.4085-1-Jianping.Shen@de.bosch.com>
References: <20240826140545.4085-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E1:EE_|GV2PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df89941-df7e-4104-2941-08dcc5d843ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3pMcHhBT3FxOWdhUmVtdWV4VEYyd2ttU1NiODFtVG9wVndLT2FGM3JQZEVx?=
 =?utf-8?B?ZXdlb3NndTdDbXBxOFNnUlMrTzk1cFRiOUR2aTBhTW9FQU9tNFdrMHp6dWE0?=
 =?utf-8?B?cE82Qmk4TGlkRkhVMjlGQnE4TzZNK0dZVHo4TVpjRElOOVljTEhtclY1eXBv?=
 =?utf-8?B?aHk0Rm5rSzNDUmZtN1FMM25icTQyTXhPYjdvZDZveUp5YXF1OHF0OWZzSno2?=
 =?utf-8?B?SGNsbjF6SzFqNzYvOFE2YmVtNDdVbDlENjZFMGhRQVprT1BIcytmWnpKR2lu?=
 =?utf-8?B?YjFPSTdISXhxUFVKNjlqckpUMGdFYWhrckFWZW93VzZRdGJDL1RscWFuU21s?=
 =?utf-8?B?M01iV2hXUk91bHNsR004ZkhNSnVsbUNSeFUwOHRycEN1Qnl5RjRFU3JTT1l6?=
 =?utf-8?B?RVE2dWc3bVlLbWJjS1RyMldNUEhkTGQ2bHQ5ZzJiUituanlNaDc1bWwzK25M?=
 =?utf-8?B?UTBhUEZsRmdVR2pSMFVOSS9EVUlOWWVNQWVvTG9wUTlaeFkzR2gyMjNVck1X?=
 =?utf-8?B?djRzNmV2S1hjdU90MExRWDdibjhjazZ0ajUwbmpxTkFNVUk5ZWlzSjFXV2th?=
 =?utf-8?B?NmdBV2IyUFRYK2JPWVZPb3AvTitoV1ZvMEFvcXZIWmlWUmJ0dXJYU1BTL0V4?=
 =?utf-8?B?ck9IQnk2Qno3SkZQdllRQUxtM1BHM3M1Y1AyejJUWFdQalNGcE0xTFI0NG1L?=
 =?utf-8?B?ZU1zcjBKazFIY05NaWRVWmZFNnhsaTA3NGtCdW82aTVjcHJMc1dMS0Z3ZkZq?=
 =?utf-8?B?UWc5RTl3bFRTS00vTzBKUzQrVXhZUVVwTEY5UDhqYWFqY3ZJOWZUOHhSczhX?=
 =?utf-8?B?S3ZPS0daNW9tMzN1cTZOYWhMSjFRMDhJVERTckgzeFJVV0dka0lKZit3a25N?=
 =?utf-8?B?NVpQQkNhQldqVjh3VTJwajVtQTRrSWF6cFZsQTFFRGFGZDhCZmNZeEtaeWpw?=
 =?utf-8?B?TkZNdjFlbVFMWml5R3NNWWdSdk4xeC9vMTd4d0JUZENQc1RDMkU0SnUzZ0dp?=
 =?utf-8?B?cXhtOU83MUJmRWxUdWlRaFdLcFZjazhNeEd0L1hPbm1XMktFR3pLZVlNcU5F?=
 =?utf-8?B?N092RjZhS2lKUDNOSUsxVnBIbVk0TzFmOG14M25QUTFsY2hBN1lUZnlaWjFJ?=
 =?utf-8?B?MndiT3lFcE5SYmlkMHQwR2VYQmE2T1dKa0FxQlBTRGQrdlRtR3d5SmNNSlZS?=
 =?utf-8?B?MExhWjRLSUs4YzQ4cmk5VFo0ZUR3dlorSWEydk5FSWVUcU52dzBhQmV1eDcv?=
 =?utf-8?B?SGlicWVzblMxYVVUbVhBSU82S2YvR3o2R3YzanhRM1lXaVJFU1FhdTQzZ3pw?=
 =?utf-8?B?TWVqWlByN3J1anNJTnlUNlJCWnpuOE1YTUplWUpJVE1ZdnNFSUlJeUt6dGFo?=
 =?utf-8?B?MWc2aGZST2grNmFUQmI0SlQ0RGV2QkpTejVlZUFlS05CQjU5MFZGK1AxZUZ0?=
 =?utf-8?B?M1VOZmhTYmRteVNYeFYyMEhtZzYvR0RSNTJ3KzFzbW9QbXBsYk1TMDNCUFZq?=
 =?utf-8?B?L3pEMStXRFVnNDdmWE94UjFPTER3bURQeXgwWGNwNFI5Nll5MVJtUGJNMXBs?=
 =?utf-8?B?SGJlMGRGVndsdlpNWVV5NllYSnBTU3MvNHFVREpRbkduYTBvSXRjVC9ZdmM1?=
 =?utf-8?B?dUluWlNYUXRyenVoOEQrOHVaOEdwRTRGanlIVS83RnFFam5ZT1hMWUViQ0tX?=
 =?utf-8?B?U1VmR2FuY0FqUUV4dDZIK3c3K1o5K3d1MUc5NVJzdlo2YXVBUEVXYUQzTm94?=
 =?utf-8?B?N0crdGdlR3V4TXFvUk51eHE1SDJWcHQvV0ozNHJaNGsrc0VDY1ZkZzhtb2pE?=
 =?utf-8?B?VytMODRmNS9MSkhMeWM5UU1KU1RCYytla294cVFmR2RVMTVBOGYvaURCMWth?=
 =?utf-8?B?Wm1UcUJQS0M4L3RzWWt5b1llWG5ZOWhZNkxxVW0ydEs0SkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:06:22.2341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df89941-df7e-4104-2941-08dcc5d843ef
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6044

From: Shen Jianping <Jianping.Shen@de.bosch.com>

This patch adds devicetree binding for Bosch imu smi240.
The smi240 is a combined three axis angular rate and
three axis acceleration sensor module.

* The smi240 requires VDD and VDDIO 
* Provides only spi interface.
* Does not support interrupt.

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


