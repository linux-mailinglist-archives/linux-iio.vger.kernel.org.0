Return-Path: <linux-iio+bounces-5998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF2900271
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADAAB24571
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053B19148E;
	Fri,  7 Jun 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vCJ/Wvvq"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2062.outbound.protection.outlook.com [40.92.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E019006A;
	Fri,  7 Jun 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760527; cv=fail; b=c5TIjPfuoMlOGHt4La/Dd6gELIvPwMD5QnLT7MxLUhRMWRH1XGz/IZs2zTuk/+oZq5klz+tyNJwWC9n//eOv4gzSchGKz6dHtR4sfJbWPw4Pg0eHENpFstevwIxIcIKLZRIWamvGdOohl6d+S9wsskQXg2wkdN3coreV9ZhLWSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760527; c=relaxed/simple;
	bh=0BsbJt3NtlKfq3xb4C2jyLEexeSeW3/8MupFBAfWQJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gsnsy6TDv+HLhLwFYH60rLtcPWKfVgytSG7VHaht/EQwVp+V1lu7b/Jiv03niKbV+0fBG7oNh014xSRkg1QRmlpWPMkfsH+zbQboYy3qH9sZ8MVdXqQLV3lf+axTy6js+16raZbPxYr1WMN52WtTMVvBEn8kntNwXYjSx0/WVIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vCJ/Wvvq; arc=fail smtp.client-ip=40.92.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKWxo3MRWz5Ti/JBpr9+mblNUkw8FAepzrLyP83RLb3bKE0NoIaOlqfG2ZBNg157Z7zNuAOvmo4O/GMalyrulqPNemYzGKUNfcc7gZrellY44zYD3D4yR/seM9Z05lHntYbm/BLICcImJPcl8zraL0LSfoa6YDkbDKGUqcAXv+0JCL65LbvRFK11NYUmofImGc3Xka+k+LmUOlVbkyhKmxTjBD3SWiH+qL88O9g11LxVgLO8W1lWcEncoUaGe+eh5ZHUE61gmkegdM/AdqWICGfyNYiAswwPZEII12nzuhjcR/zCNX9N3dwr5wTMiTErmM7wnlEqPzZvSoMLWsN1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qom5Sq8CLaHMZrfCQmsH50xC5Tb/THYGTWCLhlFNdCE=;
 b=HGn6gBPww8nSS36nUjQcOriHmnwuVPpQZvQKA3ZE6lERsLD5FfHjIPLEGCmoKeSaY8YgCJD9skn2/J8lIT+mdcFJ54rXBaI2qAhasNEDGvn6ZiVq8LkDCIqOZRTq3EdolFOEhd8li4eUit6wYC1RmCgfTWScVUl+sEZsKW4Cu9tcjQt3hrfWxoWTsH38zEmHyyrUfEvNKRDhl5b2wgc3nsh2R3FlaEbwCwcDVTXiYgVgL7UNhKCiniexLzmLtGMjjZZ9tAdYGFnuep2B4SXZUGrwmWdsnBJXRQt2jsBGMiC1eAcK5qkePbcJ/9qlMJOy5QmJeIor9+iyYi8+ZRMmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qom5Sq8CLaHMZrfCQmsH50xC5Tb/THYGTWCLhlFNdCE=;
 b=vCJ/Wvvq4UJJNHQbv2TdlzigVLBndG31+BS6K09xbjOnrh3Jc2YNdbR2UaeNK+wnVSRq7+IzpA4AT1IaZM1XGXkrhGOqrNdpcYci+wElstQZ+LNRTbvr4bm7rA4kfWbqO1rLUyxGlwNZLR4qaxHRpSlYIOL8QCwMRtWwWZ04MNfJnaJhLN6du3NP5hszRBL6lwMIURIRDaOJ7mxus4H4lDtzBzICVyIFVf0yduXU3SOrHJs9rRs15iSsRZV7vqCnMakWrxR4f7UdFhymOJafiv1AmpIdIuSyEg2c4jrpooHpPqIZ/ERKYJneejWlpb0mTISWFJqXf5UnpRLHYseLRQ==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 11:42:03 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7611.016; Fri, 7 Jun 2024
 11:42:03 +0000
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
Subject: [PATCH v4 1/2] dt-bindings:iio:proximity: Add hx9023s binding
Date: Fri,  7 Jun 2024 19:41:37 +0800
Message-ID:
 <SN7PR12MB810129D8180B1C9593A8E078A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607114138.390272-1-yasin.lee.x@outlook.com>
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YdmhTmVSua5jkFXuLCLskiE/MdIkj8o1mdU6Hw417f0rnSByBfbNBpD5MrcYE1ig]
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240607114138.390272-2-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0d74ef-34be-4ead-9d50-08dc86e6d995
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	3hPXl/KYIaLJXkM+TwMxc6pW8XIp5RWYWyIm282lmEA6h3JuaGi6mPpx1IsqPoWI52Wwx4aL1QeSbamjaCpz3vf5jry7FMJnD1YouzQL2cUhDc1aM1FMcceBPFpmm6b+iLdzXTDPkhjMwNxl10Pp1f6Tw07qrDKxzDHT3yGheRXOuRJrTe0L/aMhTM9ElBP1aGi/6N2FgEruC/etZ2SpRqrhUZ6D7o/yExN63kVL8DHAlv6KXiI60bJZzlX+HCMw5b34t4j7oU1tISZHnPY22zfZVggdYJ0/9hgTnBkAmPCzV5MZYUdinUbgrIfn25y/Xx436k8YAWA4otSRB0bUiW7TuDBasbRmGeLXQCYFGETmWjPFrnQqDnhhg0/6Yz1C2bzgYdI6trspb3UTT3KfD/DchlL8SgB5+76Wf0u5ngvCh6s8tbMR5tQgMrH4kNilK18z5yIhQPC9MKuGig3l+QpRngi7Yru0ZJCFuaR/ZF/7TIinm3ye3F2N86SBiKxbp5sp9hUWSaMmyE2hZERc8MPG6B+qY1iX+5SLcfkkcCx+VjQuDOszn2QQ2jTwVwWDB8s4V66WCw/J7R42fjZrj0Sh/RRWA3jMt4Pgj1ykKIj1QMAMokSs8bUXaH8FBEus1R95lUh7Itl4AAY8nMoRnwk6lHhu1va6jpFg5XUfMfYoNhVQlzuoMYEGxJS9C+B0AwUEJ7iRimm4ZtbdWBGgkg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D2pgESdFY1kD5R2H0eIT6U0AtY2scGnbAZPtwq8MV8nshhHQaIQVdokAG1g2?=
 =?us-ascii?Q?rxeplXv3KBk2bu4LteGfgYx3vs2t9HQVCKcAKh/TjSVUDiRd4S83pN4IWuku?=
 =?us-ascii?Q?g3rZyTxjFScZqeOki76nttUi3B29l4h4EV9GSd+CL6sphFCrFdu3JZJV1qPR?=
 =?us-ascii?Q?UgTkpvf5Mc/lGyqvWGWx9Jk7zojMvumutg3mxIfMkB6KHMtm6EilWPOoawuY?=
 =?us-ascii?Q?AXckaudDHVQouiN6T65faAc9Gfede5cRpguk1xfvxuS7FXgl8T7vMGGXpwdQ?=
 =?us-ascii?Q?YkA23d/4cV+vdZGlqjKw7IhcdTwsIFElg6GaJZP0uzLA2MMMsmuE4cCOy0qX?=
 =?us-ascii?Q?Lz+URJ3klWZkzDaXolI47Jhm0Cbz2HG4W3znLKoBfropPAKUceLIVjfilQAN?=
 =?us-ascii?Q?+b+wcnxCgn2agSG1hFWgEFvAxkqsHIrYT8+OkvRnuiPtLUvrVaign+EHx/4Q?=
 =?us-ascii?Q?ij+n2bA7F9dPPuU5ISxi0PmdKcbH2Rs8X6ZG1twEAtDYQIv6cg1IX+85tSES?=
 =?us-ascii?Q?66nzN47Wh7ObEJM1jNosR5vcEUEDGThp/IcRp0qNcjcEst8E91NqRtSQyaTQ?=
 =?us-ascii?Q?mhVJhoHH9DDq0+iOvxJ5sU5Xmf+DEGwAb684i76/q++flNELV2xq1dEscjSh?=
 =?us-ascii?Q?7Mi+MH5FcwhFXwxxtANebmEAuyg4nsF4yHLfC+hl8T/h3dfdQ/62yvSEMr6L?=
 =?us-ascii?Q?JSDF3qtxv1vk50bSrYYRb/DQQPUOIlkWnQQUQTx9K+jlM/dNzaSYcGPzqf6f?=
 =?us-ascii?Q?5O5EMCAAmTO8cSKhCnk26fiQBQb8gkD3i47FvM/cAQ4Vf5Qy1ZPjHWheTo0x?=
 =?us-ascii?Q?znS6uquHVX+WuBOWfY5AhTv6PE299+byVmrJOktJ/fbTGqh7LGnavrzyuUQL?=
 =?us-ascii?Q?kUJvRPvLAMpTmj2c+D9q+fj6OutPxHkqoGCgQGee/4uvIr4lN6pZO5rGcTxv?=
 =?us-ascii?Q?4dNYtQ2py7SD3KB9RB0qMtwxBrH9oF617QeK/wcgRWxt+xkkFA8RPajiibpR?=
 =?us-ascii?Q?U+8dbVjqkL/1iEJoE9Ndx0Bv3YCYxY4kl1IA0eIcMcsMCOuAgxLawNFKsKaM?=
 =?us-ascii?Q?6ur9qBRaXq56A5xB66YeN7uEv7cuBrJvWrqdS/fksD+4czUagfnewXVdxzKj?=
 =?us-ascii?Q?iv4XdJHQ0CsfSp0kcIab2fT4TsggsCLGuwMyaJJpGBUFfz6WJFWZrSSWTKis?=
 =?us-ascii?Q?djpEJtlp5A+jwj7eVcx7loajsvRuJsQe2uH4eP8uVl+ok6423tjHJsxT4qXu?=
 =?us-ascii?Q?vbIUkduy27Q3wa5LzwZvfL+5oXUpCfowTxe3h0z42pku4nivpCVg6iroUrGu?=
 =?us-ascii?Q?JpgPuChd6Pt9+I7zE4/N7vtG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0d74ef-34be-4ead-9d50-08dc86e6d995
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:42:03.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

From: Yasin Lee <yasin.lee.x@gmail.com>

A capacitive proximity sensor

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../bindings/iio/proximity/tyhx,hx9023s.yaml  | 103 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
new file mode 100644
index 000000000000..50bf2849d823
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -0,0 +1,103 @@
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
+    true
+
+  channel-in-use:
+    description: |
+      Bit flag indicating which channels are used,
+      depends on the hardware circuit design.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+patternProperties:
+  "^channel@[0-9]+$":
+    type: object
+    properties:
+      reg:
+        description: Channel register address
+        $ref: /schemas/types.yaml#/definitions/uint32
+      channel-positive:
+        description: Positive channel assignments
+        $ref: /schemas/types.yaml#/definitions/uint32
+      channel-negative:
+        description: Negative channel assignments
+        $ref: /schemas/types.yaml#/definitions/uint32
+    required:
+      - reg
+      - channel-positive
+      - channel-negative
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
+        channel-in-use = <0x1F>;
+        channel@0 {
+          reg = <0>;
+          channel-positive = <0>;
+          channel-negative = <255>;
+        };
+        channel@1 {
+          reg = <1>;
+          channel-positive = <1>;
+          channel-negative = <255>;
+        };
+        channel@2 {
+          reg = <2>;
+          channel-positive = <2>;
+          channel-negative = <255>;
+        };
+        channel@3 {
+          reg = <3>;
+          channel-positive = <3>;
+          channel-negative = <255>;
+        };
+        channel@4 {
+          reg = <4>;
+          channel-positive = <4>;
+          channel-negative = <255>;
+        };
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


