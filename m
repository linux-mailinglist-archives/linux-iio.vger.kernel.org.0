Return-Path: <linux-iio+bounces-5421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA338D2BD9
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 06:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6131C226D0
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 04:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C419A15B562;
	Wed, 29 May 2024 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QfH1FtYd"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2105.outbound.protection.outlook.com [40.92.41.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F515B54B;
	Wed, 29 May 2024 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716958708; cv=fail; b=eI/wEVgX0kZnDsRlfr8StSPdjqNa24xc3xdOWp66FUARVL6+aSrXh6a5yrYN2PJt8AVSSfshMYIWzIhHdWusByHO62Oj9FhFBe+Z5820SdvH9Gqna1W7fgDDdPoCmwsWPckOVNBHQonsa0VucyXA30lw3Dk7w8nrxJff9CWQ4a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716958708; c=relaxed/simple;
	bh=9e9pTLLY/UDthbKJtzxSbdaChNpKE7iOc+7gpLwzfK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWS+kD9MS1kaU28WCdMlKwS1qJo08XP7WbLeGNU5aVeZKcP8hTOaGWAhA4LubL12K+Pv7Z97FP+TPIQqYjuFQ6+qN+Gtz90oFfcMpTipAg4zgAErPaBlEoltOTIleIj1RkBJVji89KVov7xIHrZzAAUqBVw2bX8QzeGnE7H4Pbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QfH1FtYd; arc=fail smtp.client-ip=40.92.41.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ9Z3V1UDvJRShfUUsw3Rfieyof4EPPO6a4ZMoa70sJFQ0/rgtwwuBtkrkynPT5h4cglfizM0tJuT0f8mNo+h+AwRDgPs1OPZWBcUq80BwQVh7c1av5Vm11FhYTz2BGH/GNBdY/OEyMcaak5w6B3UGU29gsi95WlGVBxfmtATXVc7kG4Vi1BurseVFlNEJsiMjswmir1sAUiFS6BUqImL9Ll2zNCS2AEB3ClVyg+VxJAAHRSfVquEe0eBXjNVFlfAR7VLVuJ7mLEYV0rmpV0CEZNZ3G94hoI0T2J4uR8hHfijqHJkpbLQ28D0sY+zGp9KrixxMJ+65BPqNmVZGUKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ07shtW09OWwejVKIc/qBHVefafNtW5O/gzO8bqUsQ=;
 b=hqDdOTjibGdkNZmzr5tTHfHoLdfAATH3eL9r0dthZZxXD2IdVz2H1m2460yowsypyM2UHkDf3qLkKL5k6LpxywaKPxGAwJ2sunWc9L4X5StAvzMRmuVCnITjNtR74IPHHKyIcBDvoknjE2SHoB3n9P2WFCZcDCQzK3NoJm1/Od1oUCjRhlkNB27MkHChfT6MAoU9jSeLo0k3Dz5WqCxe8pAN9F7r6Ci+KUQ63ZMthkLCtsRiH/Pm0tRY5uIh4me5Zl2UjwjxT/IEXdmKiXn1b+MuvkNaPuKeMziQbuf5pjFCFQ5spRwRAlHoyKvW8qp0fc46NXeKaH+crdjElceo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ07shtW09OWwejVKIc/qBHVefafNtW5O/gzO8bqUsQ=;
 b=QfH1FtYdGK1pPVVmHpFkHK1y/UxqX6B+b7NWSy3eY5Vi2n0g0TxrT7ywiH07ogm1YMncABtrKNp9fSZpdBPOV59MKTlSVayvEKnEt8MTv6ZhD83yB9rB3NvbP+1e2IEkC3QucCphO/Zx+LNypM2qDaGQHJULtMJjtW4pCeL8jkg2t62WtACKoIy0cN8gGpx9mzPyAS5kijGAX+Ua+eE4DUo6WadYdWFbObBWhwlwrzIMbdEeBTCg9OPSZdsXuQCmxyc0jxekmZEXdzj+Cqu/Wiln7lYAA3ZVHvekoivzVkGWb7WttSiC4PwfN3E/2n3iXTTtLGIQQnlZCfySJSv3pw==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 04:58:25 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 04:58:24 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
To: jic23@kernel.org
Cc: andy.shevchenko@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.a@analog.com,
	swboyd@chromium.org,
	u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: [PATCH v3 1/2] dt-bindings:iio:proximity: Add hx9023s binding
Date: Wed, 29 May 2024 12:57:48 +0800
Message-ID:
 <SN7PR12MB8101FD306CBFC84DDF3D2466A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529045749.530039-1-yasin.lee.x@outlook.com>
References: <20240519162438.17af0ff8@jic23-huawei>
 <20240529045749.530039-1-yasin.lee.x@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wpShcs/z9FAZqT2auF1PlqaZ71uJy698RQa83WO2Vjs6ApptuB7TqpJDuMo/jpJe]
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240529045749.530039-2-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: ad40b3d3-1544-4054-2c8e-08dc7f9bf88b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	kC0+BBPeUC802AXapl3SzSe40w8WGXTnPl7yvc/akl9W/ZL9aq1MamOMZl5bteZojiBqKDTWuXjgLmojScmg315NzVElaFyJH5xcQsd/5wC3ZU/9gn+XQniEWllFiypsbbIAZUVU9CQllyJ1ukSJyWQPpWIhqd9opQlnoP/Qsdd4pbklFXSmxUKcI3NEkulTfQ14Yu2Q57Q9RSacMIv2EANnBr8Q/efb8erqupWkmaMddBaDz2G68HTs3AzNMRu6qeKNRq0PRS1LUNNGHPjujoaZCA4ofPRxXHpca16/a7sWKrl6YK/D1BFayLeI5aeRKjuoYNNDJ3o7H/rWwBxGksYjAkSmngXFz9pz5RIYQfuTVQqpHCcrr83IVHw0ezx/HEEpe0EW8HB+RVsXpHmQ5yI5QkODkiB1NEod76LTlpQJoQF04x50o6BMHdHrQqNdA2gyKxCOBs/6ZPc6GYjFF4B36qHC72pL1rnD/sUEKXhluam0J/asQcSdluCYPi6OdlcoWW3RSa6j9X0T5DtawI6s/d96jyaqALTxzM+X3tHlZcSRXglpFrwhny6FDtlp+7XPzUlQYDtLEi8ySFK6lBwxnzDPaxkLAhdI3Fqnj18W/Bnj2aXkYHwDxS0+ZyHTfg262LaFFuV5DmXha3d+U3IP0+Von7vLWBxEhdkFb7Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DY7U/7m3W6a4MKp4HwidIv2g8FO2DLzoeqCVhZ/Wk6+iMsdPwHJkqTKS686H?=
 =?us-ascii?Q?dFxQcwCGnSuKTy3O/d/A8+V1KakOcPJG6/qG9zdyIuO9XT1lqcTH1WIkC2Rx?=
 =?us-ascii?Q?eWolfhUGppJF2wJfvdMpHHFb11xauVZxEdpMR7i0rDApz/bIIPMibyDgI4g7?=
 =?us-ascii?Q?vvHdcTwuCCaKliT6rNNEesBXAA1m4uiZz1Iw3Awq3Lm2XEf8BbF6VfjNUoy8?=
 =?us-ascii?Q?gsbdEAGXMfjboSL0Q0Kk6/Mtgze57wFBxZeW5n5vqPdD/BfkEUAWS7bf6Rtv?=
 =?us-ascii?Q?Y/6Pf3zCiVbH0XhnoAYow4dAV+8ZUXnWbDdXye4CwxcTlKdV3kCwd/slOJwo?=
 =?us-ascii?Q?morYnNCWioRn0Zn9N1QxVVioJ/fHnPoFXP49zmaTJO3A7lFqk1SL7WwXzLwC?=
 =?us-ascii?Q?VWLfeSqtWYk6mDCTKuXPeRLo08Wym7D2M2GarOE4BstiIVS7Hy+RBucoLz1T?=
 =?us-ascii?Q?DWH50T5VFK4c1ovLE7WR9euThUVHpEIC6d+LdVmizRWDSG6/VO6Kry7YrdOV?=
 =?us-ascii?Q?Ihz3jaTMPQ8TXqb01kc3silFIcXLoJuKZvw6w0luak4mETt+9mB2ByqVAXRw?=
 =?us-ascii?Q?SytBVdwq+sDT2cIZuc506s8ahUHfkT2vu278gyCZfrHnrj6m5iL5mksDoeak?=
 =?us-ascii?Q?t4lFGEhVzfB3i4CcU/zRsgVdfl9JXmWyyVK3acu5GSx8SyMUM1pjShoYu8BG?=
 =?us-ascii?Q?hJV2khGD1okDFYpMHUsYhx8+7PMDgvo5d1RcvXoRpNQpbq1e4norqe9qCSZM?=
 =?us-ascii?Q?0cU2gFmQGIeD65xmV20A0OsJ+34WG3sLEleES8LF6fxtrQDcMDt7iEwQEvMC?=
 =?us-ascii?Q?P88N0TcjnVOKK1Bbw5UCnmsfbYMSu0hr6ytT+zKyQXW7zhkhn6QUfdx8uB0p?=
 =?us-ascii?Q?TkDTtOVBD+zCcu2bfsJBQsB2JpH0OOeAzg8DwUSHOSEeD9U7gXsH/vizWMYI?=
 =?us-ascii?Q?wrJ/0j+Hh7dhCCukqcOnH5p+JmNzP8NMxod55XWrCu+vTvML0EPbYh/69EZF?=
 =?us-ascii?Q?OkhtqNIGtYmOUgdOYMY2tA9AyFcmSnan9LokBVgcwent1ss/emeROvgX5sPJ?=
 =?us-ascii?Q?4vVeqZ3ctmfO9C0c9bsH7zTPfrLLvqcsbu5FdE2FeG1e6ZtOW5cMJaih1L1w?=
 =?us-ascii?Q?Wp2qSSlMqBmgB8xGpB4pAbzyMYcJfDJxIxjpG/eTowCdfVALBFIsd/yauGJT?=
 =?us-ascii?Q?e/RYV/csiCCZ1w2T503JJVqGvsQO4WPIlPduBDcDcDZvXYmKfMZDodyKObqg?=
 =?us-ascii?Q?1jr3bqpFPVN0DwBWEVofLPpzU53egfT9hjdMSgSg8J+lfRpSQ9ILJmyKZ0bb?=
 =?us-ascii?Q?Pq8ZjD1/UJLa9eXOF6DPJ2d/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad40b3d3-1544-4054-2c8e-08dc7f9bf88b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 04:58:24.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

From: Yasin Lee <yasin.lee.x@gmail.com>

A capacitive proximity sensor

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml  | 106 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
new file mode 100644
index 000000000000..ba4d7343bb30
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TYHX HX9023S capacitive proximity sensor
+
+maintainers:
+  - Yasin Lee <yasin.lee.x@gmail.com>
+
+description: |
+  TYHX HX9023S proximity sensor
+
+allOf:
+  - $ref: /schemas/iio/iio.yaml#
+
+properties:
+  compatible:
+    const: tyhx,hx9023s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Generated by device to announce preceding read request has finished
+      and data is available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+  accuracy:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Accuracy level of the sensor
+
+  channel-used-flag:
+    description: Bit flag indicating which channels are used
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  odr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Set ODR for all channenls.
+
+  integration-sample:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Set Integration number and Sample number for each channenl.
+
+  osr:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Set number of OSR for each channenl.
+
+  avg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Set number of AVG for each channenl.
+
+  lp-alpha:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Set lp-alpha for each channenl.
+
+  cs-position:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Position of the CS pins.
+      Indicates the corresponding bit for each CS pin in the register.
+
+  channel-positive:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Positive channel assignments. Use 255 for not connected
+
+  channel-negative:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Negative channel assignments. Use 255 for not connected
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      hx9023s@2a {
+        compatible = "tyhx,hx9023s";
+        reg = <0x2a>;
+        interrupt-parent = <&pio>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&pp1800_prox>;
+        accuracy = <16>;
+        channel-used-flag = <0x1F>;
+        odr = <0x17>;
+        integration-sample = <0x0065>;
+        osr = <0x4 0x4 0x4 0x0 0x0>;
+        avg = <0x3 0x3 0x3 0x0 0x0>;
+        lp-alpha = <0x8 0x8 0x8 0x8 0x2>;
+        cs-position = <0 2 4 6 8>;
+        channel-positive = <0 1 2 3 4>;
+        channel-negative = <255 255 255 255 255>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..e2224eea9ab9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1507,6 +1507,8 @@ patternProperties:
     description: Turing Machines, Inc.
   "^tyan,.*":
     description: Tyan Computer Corporation
+  "^tyhx,.*":
+    description: NanjingTianyihexin Electronics Ltd.
   "^u-blox,.*":
     description: u-blox
   "^u-boot,.*":
-- 
2.25.1


