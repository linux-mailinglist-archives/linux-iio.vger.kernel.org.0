Return-Path: <linux-iio+bounces-12422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F19D406C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 17:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C73B2F20E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 16:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32281547F5;
	Wed, 20 Nov 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="V1dlUR7y"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28D1527B1;
	Wed, 20 Nov 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120381; cv=fail; b=EiGnxrImyWgBgT7VJpbXV93ikJWElrwGCztUpBibcNFAXPhWBE+edSaulH8IyvaxRIDaxbmUfpP7/6x3QmpwIofVS/nylI9ik3dOhaqKsGVSE8k5eFxUNU21KTSVtYBI6rosNZ/r4E7zh+L3Rdatpj/9l+tqVW71hoLH+iSxTgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120381; c=relaxed/simple;
	bh=jBW9dRb2Q7fkECKRbwQaBsPqg3TX84ry26Q5ZmRVplo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYZNXkC+8wm0T5wzbKdzO8/VsHRIwIZYVO6AadQ7Kl0BdT8dvffye5ZAobJ61iM+XEnVdcx4ba0rQW3CbXFXBhy3tY/uPXaBKbplFY0MFPUTS1x1D6e1F4wZ2Nheq54kfds8Jx4i4HXyU84RgayjXAle0ZdpwCEbZo3IZGQMSoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=V1dlUR7y; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZGXu/KZhbnyrYXx/fYIofwPuyO6kDdV1K5X/uJ9AkYl4LcqgpVr7YmuWiS8+FIKRi3dZGYeiZVkRfBiOashVOJkVvQMANQCsWLwo+qZ1suSAv7mS/B7c4W4gTLBGYzsgl/iwPWgDfSQzbp9lShgaZXPGXVWn3Me0nG5vLDYP+jeCHt3epPeQDrVBJCsm+aFAkVYBs5YDioxopYuVLHU6xNNdLxz5MQuWKt6U8FDq+ySPgCIVgp4DkZOwOv7Fukz4gHek9vJdoafZjCzaOdSJ+c+EqNB1WcN1YwtnXyjWcK6agh+qlMrCfWo4SMSdl/3Imf13KrIJ5nenLg/UFYZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=PYluT0pSee+7G4V968+iKnT/Gdj/tBb6ramWXkeIzIsGZ9ndiTW17GKjVbimRQt0PWkUs1CRiixuk1I8tvAumzmLhCEdiep0E/tW3aKTck13M/rgPzSJs0QOnXke/LIhVa3kR/FJ1JRggoLl6DBJxv3NcE3EQRX7v1L/srV1rRunma5LFWWRIfdIr8rjhkdgy9rkM1wqOPdJj4/gDAwnPV3ww0MmP/TGzr3LVniMtLSiZrruFoE3rXu9lZzNouaPGgv1OWdVDFSlnXo1VlOWDdzxNSzdN7AsJFiWhfu+6SmDY03lZWq75EXAGElX38cwPc0jp5vtaRpNwg66Tx54mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb2K3oIaWi5yrqQaC9lyjmZ5eqottKylRr1oLhFtCGc=;
 b=V1dlUR7yv8+cxtUFd6i3T2JcQ5Hj41CgBNZI2LylRQnusl6gd0sL11oyCf9dTua56X211IrQYuQpjPfHSZkPKOiDIWxFRkOSuX7aRj0TPtgEot0dKUT7TLfSGI/ASHWFzqgdpYcxs5yhm5zoF/znI+8DFrDxjRSwsOkvPhM8Yps=
Received: from AM0PR05CA0078.eurprd05.prod.outlook.com (2603:10a6:208:136::18)
 by DBBPR02MB10602.eurprd02.prod.outlook.com (2603:10a6:10:52f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Wed, 20 Nov
 2024 16:32:56 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:208:136:cafe::63) by AM0PR05CA0078.outlook.office365.com
 (2603:10a6:208:136::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 16:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 16:32:56 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 17:32:53 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 17:32:52 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Nov 2024 17:32:52 +0100
Received: from pc48051-2208.se.axis.com (pc48051-2208.se.axis.com [10.96.59.31])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E0D1824B;
	Wed, 20 Nov 2024 17:32:52 +0100 (CET)
Received: by pc48051-2208.se.axis.com (Postfix, from userid 21236)
	id DEE3A18E1ECB; Wed, 20 Nov 2024 17:32:52 +0100 (CET)
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
	<kernel@axis.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
Date: Wed, 20 Nov 2024 17:32:46 +0100
Message-ID: <20241120163247.2791600-2-perdaniel.olsson@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120163247.2791600-1-perdaniel.olsson@axis.com>
References: <20241120163247.2791600-1-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|DBBPR02MB10602:EE_
X-MS-Office365-Filtering-Correlation-Id: ed567a09-9bdf-4c69-4d50-08dd0980fcf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDIha04HMMbJqE9eGZ/0G5R/8nsBa8dBcIX4nT4mYCGRSkJXtDDHTwbroGyK?=
 =?us-ascii?Q?ORPou7v4uZUzFdyuKqN9I2/OKUGaif9suEdQVn0shmMisj59edembAtV+hyy?=
 =?us-ascii?Q?B5V4HZ9Zrjwi6FPO1sHanpX7poktGXStIflhKUvb/vAinxJs9TuxmLXUVO5q?=
 =?us-ascii?Q?xMaXI+OquvjlMiZNWYyTWp7ATYL2Os3LewRgO+AtCMtZ7ADqE3IwZ2QgbzpB?=
 =?us-ascii?Q?Dd86J7eTT4fMvh9JvoPB2lmyDMzo4gDLOQUEEh6Rj6jJo45L1bnVHUdfDFdJ?=
 =?us-ascii?Q?tbd+jCBOidbI/kR+3nD9zECTQR/j2Zsd5+8HRsb1vm9AYMjEG34gyVVmcuVm?=
 =?us-ascii?Q?ftK387MPYrmm39r+um0rASFD9iarR2anEgHSL2JC0w2Ry3LZI1pS3lV+hwyq?=
 =?us-ascii?Q?9JXBtkHTQVa0mo5kf2/sv2TZPEE3iGuGnnik/2xvvG1aFynmV1C6E2Q/qLvA?=
 =?us-ascii?Q?LNrN+A5skJamQTS5XbjY0sJUn9/EOANK1G554DOu9gcyE15XzOyCcnnsIehH?=
 =?us-ascii?Q?1YeJqeJWI/39uOcw015ODGgbJa/YxZYlO5WZBgbIq15atGq57IK7r5X0iFZW?=
 =?us-ascii?Q?VQgziHbOgqBXdoDdHhLgvYQpqGtMnAO27uL1p5LcGomUdBfVKE1NboS+Cj89?=
 =?us-ascii?Q?zjthP2QTs0IY1C3qHjkfPJ6heAVnDDm80/DKwPL8Fftxqa5ZwU+s7lNjg0Fx?=
 =?us-ascii?Q?V4ZtTGK43tSWjjltPtAhLlQ/mHsYl4mBoxVkp+QkkJaw8djN+gtkfR3U7RZV?=
 =?us-ascii?Q?Sz9Bmye33I1rZ4fUQ5PhyMWHt8IjRJHnx/TQKfsnHDFYygSWz2eBoMp4o1GQ?=
 =?us-ascii?Q?fALHBIFQ5IOzak3hU1Jk75r+inWBfhd9ZFhg0qRDiXwU2EZkkYFGBaLPAr3O?=
 =?us-ascii?Q?00pxhnw2ZTE28CPSgCbuNIggngxN4YTK1gYIFW7ecoIUpXCLLeRBlIHakNd5?=
 =?us-ascii?Q?57/40a1WiRpJ6cTLi2Hu5q4banNXNMgSFtmbi2/7i7cw7xQO+fBXA5rrXdDn?=
 =?us-ascii?Q?pFWn1bOJAYz13Nlzp0GZJFpU4RtXonL5VtomcSiwGptBGTBp2QTI5+x7YJvA?=
 =?us-ascii?Q?PkQ27c7NoWZ6E9W6lXmMQq3yLQNyVnAkAH9qS0g2/LZLVfUDwTEIqPIua1DD?=
 =?us-ascii?Q?ASQj6bt3W2Z6K5lvzh5HKR6kjXq12pGdlYz+1v8bDEXSXJ9IMW+xQnF4o9Ff?=
 =?us-ascii?Q?+eyhzZPgqndoKVwF5nlsPg7HNikdRRieqM9uFU0sY4Wvjen+NzY/kQ1mSGkY?=
 =?us-ascii?Q?s9S+9ryt+UcoYZDoy+yzUAa6S29/6aRtiEA18401L+jOlVCtBY2VDFTQYpH8?=
 =?us-ascii?Q?W5lr7XcRnc8Wu3YCHf74JNbbxTa0fOpHR5/K2+sT+dNtPQyx9umP3EdFhwhz?=
 =?us-ascii?Q?CdKfdqc=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:32:56.0473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed567a09-9bdf-4c69-4d50-08dd0980fcf6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10602

Add devicetree bindings for the OPT4060 RGBW color sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 .../bindings/iio/light/ti,opt4060.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
new file mode 100644
index 000000000000..0577e27db1ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ti,opt4060.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OPT4060 RGBW Color Sensor
+
+maintainers:
+  - Per-Daniel Olsson <perdaniel.olsson@axis.com>
+
+description:
+  Texas Instrument RGBW high resolution color sensor over I2C.
+  https://www.ti.com/lit/gpn/opt4060
+
+properties:
+  compatible:
+    enum:
+      - ti,opt4060
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@44 {
+            compatible = "ti,opt4060";
+            reg = <0x44>;
+            vdd-supply = <&vdd_reg>;
+            interrupt-parent = <&gpio5>;
+            interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.39.5


