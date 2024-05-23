Return-Path: <linux-iio+bounces-5242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E938CDD7D
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 01:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF6AB22D5F
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 23:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B431129E7A;
	Thu, 23 May 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yPKHXuml"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C9128362;
	Thu, 23 May 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506193; cv=none; b=HGlo9nlIJ7VK463pjWz5+oLK24u+lvPIdynj6GW9GbIyPIopr7l2x3Wh4wyMU8klAK0aaC8/p+mYrDBC+uAr8qMwawko5v1UWR1Xskzg56bO9AjxfrPCew1ZQrCEYefvDarcjXgwhakEuPQ7w7/qu12kAKcTBUCWhpJig+Mpr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506193; c=relaxed/simple;
	bh=NGu570RHFGceiey1igTao25OUDYzi+gWESyBkc7sHMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIGlifBqMbx4nFJrNNFeWOoTUIrwl4qjeQ/3Ejzm/jWRRjapqqv22w0Pf6LoTGkh9O75G5muieFM0Y1Hn3S4MHQpnjwBuRA/81fswG/tNlOiw6Khx6aWeOkA34h9gNKDcOCyUorA8nDisHVcRuMm0zeUPu6vV94jcM1DoHNdADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yPKHXuml; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGZN117075;
	Thu, 23 May 2024 18:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716506116;
	bh=5kbdjIH/ML8iAwsZorBTaSmYVbL7B/CuMu+J8qO8tbw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yPKHXumlaY/2MYgecu1nB0JiT3JAR5RZDi4tICk/JlYHfXkwo6KK9LLia/ey7MZiZ
	 Rtg58MDos3COKSXzXyhcv40207wSP1JMYddtnycno19sFZnrPo94ueiB8irE0vHm1F
	 h8JozC0GfWmr1jdCbJMT9AvlfT09PubNUjgXxPbg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NNFGjk022501
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 18:15:16 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 18:15:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 18:15:16 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NNFGqM008143;
	Thu, 23 May 2024 18:15:16 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep compatible
Date: Thu, 23 May 2024 18:15:10 -0500
Message-ID: <20240523231516.545085-3-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523231516.545085-1-jm@ti.com>
References: <20240523231516.545085-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add new compatible ti,am62-eqep for TI K3 devices. If a device
uses this compatible, require power-domains property.

Since there is only one functional and interface clock for eqep,
clock-names is not really required. The clock-name also changed
for TI K3 SoCs so make clock-names optional for the new compatible
since there is only one clock that is routed to the IP.

While we are here, add an example using ti,am62-eqep compatible.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Fix eqep binding for new compatible, require
 power-domains for new compatible
---
 .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
index 85f1ff83afe72..c4bb0231f166a 100644
--- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
+++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
@@ -11,7 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    const: ti,am3352-eqep
+    enum:
+      - ti,am3352-eqep
+      - ti,am62-eqep
 
   reg:
     maxItems: 1
@@ -21,19 +23,43 @@ properties:
     maxItems: 1
 
   clocks:
-    description: The clock that determines the SYSCLKOUT rate for the eQEP
-      peripheral.
+    description: The functional and interface clock that determines the clock
+      rate for the eQEP peripheral.
     maxItems: 1
 
   clock-names:
-    const: sysclkout
+    enum:
+      - sysclkout
+      - fck
+
+  power-domains:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am3352-eqep
+    then:
+      required:
+        - clock-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am62-eqep
+    then:
+      required:
+        - power-domains
 
 required:
   - compatible
   - reg
   - interrupts
   - clocks
-  - clock-names
 
 additionalProperties: false
 
@@ -47,4 +73,21 @@ examples:
         interrupts = <79>;
     };
 
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        eqep1: counter@23210000 {
+          compatible = "ti,am62-eqep";
+          reg = <0x00 0x23210000 0x00 0x100>;
+          power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
+          clocks = <&k3_clks 60 0>;
+          interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
+          status = "disabled";
+        };
+    };
 ...
-- 
2.45.1


