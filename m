Return-Path: <linux-iio+bounces-24874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E3BC9CFC
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279261883D01
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E7202976;
	Thu,  9 Oct 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="TayqbxtQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBA1F03D8;
	Thu,  9 Oct 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023985; cv=fail; b=l4nO2G5BzQJPfu/kRsHPK5I3z8p3YfZEcRlizSDBnrAhc8P2+ZbYALTecxcoZthlgzwBYfXoBcrznCXuhgPjTronNCmIhFcWey7UKjn2v75gy1CoMaxPohfIs3/fxegTLfeGWFLyx3KYyVd4xYG3zKtrfhL+23LNudWSDHbbYlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023985; c=relaxed/simple;
	bh=7elPI6oiWoPlhF6YappRCpwOzRDbrHnP7g7Am/791mY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vw/FflB47vZORtZoonps+lEIMIlyYdBoWvHgthZFDMJnyV2damoUhMUGTglORLn/rTsL3LGdFUcW1nl6B/aO275xwU+amF6ziRtkvRwHvZcuAbnjWCiMCfemCUO8NlnlS2YvglF/WATr7/ohCbobXgtaAYgtbub7SnCOWL4uW0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=TayqbxtQ; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJhiAcMO6QyevKFcMETbofmFeo6uthXTT4mFk46tx5remXRagWrJ5eRPo+c0cFDGuysI3Bbb0fPQQpqDqMKLls9ezDS9Wd5Xg1aixNB81X3SyTnzHFCIkS95VLwr8k8HtTu/kJNTbBUJdxG11b9WzXsFYBg9+OhVAMeiyUmLwvuOwdpsjRYsdfdrxOLz2iALVU4bGcfpviIejV+V0HOou/fxzaTUKbIqLC9/3vju0CaHr6BuEZg0W2FSL04ndv2FOdd/wJFxOIykhabnhwweRywSLvsY1aEqZio7tpMlXg7J47bS9QIJWPxInMEOOXdZehTim4FCUJnlzMcVuH6NTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RTJIY8bHME0NhyJ8j+UlJlOmZM6Jdi4TW5JSE9W8Xo=;
 b=I21QEwkw8rvtTNmi/W+Yp7nXwP8IKifNmSt8umY+0hPnbZK9aH4N3K2bG0qTrU7Pm/xUVXl7H98/usLvTXygEXyR3e80TcM/faoMszvE+Wc8fVrFTeNrKAe1A8iNjMN/pHF1IBq72wVxw020YjBl5JHJxoFtsGkCJbL+oLg9hDI8SxAYQU3XbUvyYLFDXFxoQQ3a0UgAEL1HgLhckDIV+Qg7YlaF5KqrK2mcphk9xmhL8ofSX5gwIn3HpH5ItI0Iabsg86DkPFRQ++eUGf2iMwI3KivM11S5ROl5gFVmEak+CXwxA4orsdh2MhK2SrReMgjXK8VS9kwYE6sM8CMn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RTJIY8bHME0NhyJ8j+UlJlOmZM6Jdi4TW5JSE9W8Xo=;
 b=TayqbxtQFpiPmwQY5tyjtLd7l+4aYtxUaRYrXOedovWy/lAjHH8BZ5cME6U5lZrZhuKS2Ez9V6nWM18igbgzoHzRyEaIh4uc15Y8t2clDibw1FaeUKVumePJupm+Ap0xrYPQxbhHMkzIrRxr5UFOcqEjP4VKXwX24gRbjuTS6SJO/wuDm19dNcDqb2nNO0NCSTSU79a0D+ypJkynIb8ZMnxJjY/19pPmGLxFP8RCFmvZPaOLmlMm/cfSpbWzQw+uEQxXXsvMGE6178Wbfixrf2T6NzzGRVU4fxdUBhjCu7pWGNy/oTQvUTksc5lZnHP/OidCIiBvZ47hPbdy+dM+2w==
Received: from AS4PR10CA0006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::6)
 by PA2PR10MB8650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 15:32:59 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::e6) by AS4PR10CA0006.outlook.office365.com
 (2603:10a6:20b:5dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 15:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Thu, 9 Oct 2025 15:32:59 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 9 Oct
 2025 17:32:48 +0200
Received: from LR-C-0008DVM.lr.de.bosch.com (10.13.188.136) by
 smtp.app.bosch.com (10.124.11.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 17:32:47 +0200
From: <Jianping.Shen@de.bosch.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jianping.Shen@de.bosch.com>, <Christian.Lorenz3@de.bosch.com>,
	<Ulrike.Frauendorf@de.bosch.com>, <Kai.Dolde@de.bosch.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: imu: smi330: Add binding
Date: Thu, 9 Oct 2025 17:31:48 +0200
Message-ID: <20251009153149.5162-2-Jianping.Shen@de.bosch.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
References: <20251009153149.5162-1-Jianping.Shen@de.bosch.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|PA2PR10MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fd54cc-80cd-491f-5e7b-08de074920a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsfEaG35f0fgbQBuSIe6t3Cb00gLDAhdsWKYD4WSIyyERgAPzlIs2ALGQ2o3?=
 =?us-ascii?Q?Kcf41ZgGwD+UQUnpECORkBq3OJ+tEtrsmOI1RCOlhD4d9C6SNAt8a+ULkVlM?=
 =?us-ascii?Q?0GA0Wdro8TxzS6+87tiO2TlRQHEnet/VSz7VUMnM7qgW4lKYT3P7Ktusk3Fc?=
 =?us-ascii?Q?2f+g/B+MFhLvn5BateclyhcPrgIMlfxRM2YqkRQv+yRNfdmPV9VURV1Oxm77?=
 =?us-ascii?Q?LxbR37s2dLuomN1NyOtQi6HiShcJ9IFyeZn46XJswrQpA1kUcLQKY1PlHMUB?=
 =?us-ascii?Q?sI7bacTVj/05i7gXIs95nkqlasG9cIPcOPhFQxfA2N1NaRwXKZ+STsj5304f?=
 =?us-ascii?Q?86MsL6+BQ7uV+KKVhbe0lXNs2phTdXoxyfxNDHYc3/E6/9z8QWxGYAhILG7t?=
 =?us-ascii?Q?Ex4Wv6A8Eheaji9TIXQKSfDKqjY8bkU4pEf23onlI5NXoO1SiW6CJiUmnLre?=
 =?us-ascii?Q?cWDNrLlY1A06aGLCHTrW4rGJwz4huqzTX+GJkvl18YYK6uibmbg6+A2GZf3g?=
 =?us-ascii?Q?BtW+aIJ3Ji8LAuEuMp83yFuO9bKrC2vyO87XlDzXjPfdvZJU/Xfmefa49Av2?=
 =?us-ascii?Q?ORadkcyMtvyNafeMPS81cveoru30ej5Q3w3DDsb86TjcBdFJgh8Jd1Q/vjlk?=
 =?us-ascii?Q?31kgOe8G+lqW7llGuomHSWXEtwLze6gYI5M1WL/3lBj7Wbuggv4S5e168Aoh?=
 =?us-ascii?Q?prMzenCggDZpXmL71ZtF3Ec6Dwjceyk2duLUyv56rHNg9Ny9z5EDYjttIHfH?=
 =?us-ascii?Q?2BxkI31k11LnbjVHrlFDUENPVWJIBe94bjeYDaXu3ezk/VEFIqmKqwgE1LVJ?=
 =?us-ascii?Q?NgeQuiGwGzpfbwuUds7lt+CU4EtZj3zjAllXRjgOwsry+yCOTzQ8GhsGQ0Ex?=
 =?us-ascii?Q?TdimglILrxXLPLFt7VdrufTgfMkzyrs70sqkTDiHLnGySMQjxDm/eL8JPOz6?=
 =?us-ascii?Q?YlPAeAJE2XTebjpJtBVMAJHJu7VkR1s9wfZYICjbjg9tnS1jpDQSL/R5Nq5P?=
 =?us-ascii?Q?RDlBeYRUt+o+Q7mpdLCXnU9ctrr913zNTq5vzMg9ccf5WIPV8R8CRvAyih4Y?=
 =?us-ascii?Q?glnetSEM7SACA5g8Wc8DS430pZHy3evSQzx3yJtN6PQiEFszql106tgDJqVy?=
 =?us-ascii?Q?vPDlu64yTx+vYrMP7EUnXWLtJosnonXi11og6cOJtf6cV5lcuNaA+HlGwXQ5?=
 =?us-ascii?Q?l0m1f3AjmFSHxftlRdSZqnIUYp9l6fW2ueeh4grM7CrsdUAdGNulqc9gubOk?=
 =?us-ascii?Q?aL1r4vrOU02pwH9+oBPNIgws/+fmmnMJ2jh/3hpPJmS3vNagdxUXwQh/gXUY?=
 =?us-ascii?Q?T7IqJlNIn/cvVbvwcHDAuhcxMfipbwiDdN4qTZx9KQHZvKg3PWFq+DszcviR?=
 =?us-ascii?Q?mRqf1yAPPmalnu7t8sNgm4vUwT+93lvY2d6ar8TmJAiUW1Lg/NYfasDLck7G?=
 =?us-ascii?Q?0CYK7Irp7p+dGnmzOVSj6vUO9YoIsQQBZm4SIZ2uN1ZgT1i2EzwQHwr15gzg?=
 =?us-ascii?Q?PZxKlleH5GyXji27uk5QSFdJhAHDxvNnIho+?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 15:32:59.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fd54cc-80cd-491f-5e7b-08de074920a7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8650

From: Jianping Shen <Jianping.Shen@de.bosch.com>

Add devicetree binding for Bosch imu smi330.
The smi330 is a combined three axis angular rate and
three axis acceleration sensor module.

Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 .../bindings/iio/imu/bosch,smi330.yaml        | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
new file mode 100644
index 00000000000..0270ca456d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi330.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,smi330.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch SMI330 6-Axis IMU
+
+maintainers:
+  - Stefan Gutmann <stefam.gutmann@de.bosch.com>
+
+description:
+  SMI330 is a 6-axis inertial measurement unit that supports acceleration and
+  gyroscopic measurements with hardware fifo buffering. Sensor also provides
+  events information such as motion, no-motion and tilt detection.
+
+properties:
+  compatible:
+    const: bosch,smi330
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
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+
+  drive-open-drain:
+    type: boolean
+    description:
+      set if the interrupt pin(s) should be configured as
+      open drain. If not set, defaults to push-pull.
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
+    // Example for I2C
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@68 {
+            compatible = "bosch,smi330";
+            reg = <0x68>;
+            vddio-supply = <&vddio>;
+            vdd-supply = <&vdd>;
+            interrupt-parent = <&gpio>;
+            interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+        };
+    };
+
+    // Example for SPI
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "bosch,smi330";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            interrupt-parent = <&gpio>;
+            interrupts = <26 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "INT1";
+        };
+    };
-- 
2.34.1


