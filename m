Return-Path: <linux-iio+bounces-6159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E427902470
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A10284736
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21499136E2E;
	Mon, 10 Jun 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n3aPCcTR"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AB7440B;
	Mon, 10 Jun 2024 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030848; cv=none; b=evz5tKK5kzYg2Is+v1+8rSLSQu01VT40T35vY+tvAEHos0Jmj80bnqSXPkDgKKl0rb1J63CWEr0IKYCtyy4g3uG8XazJx/iE/OZ7Qz/mMgPm+V96MlS8vqMe7Cj8yBezbXDqEaS01IEwr+n3Md4ah5ous/y/zURKn9QB9j+ibog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030848; c=relaxed/simple;
	bh=OMs5HIO9iMwqvjCnkpK7JpkCnz4FYRqCknG4vhvfXxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMv2ChoagivEtw7rdcG9QjavSIJE1XUBndmchINN/gIrTOayOCi+COOy5UJIpZ3U0iKYo1AqTHjICuPLh8O6oERfj0TRu01Vdg8boRQbMsHbxEKP8Ya3emIzLBRM+Zn73cUISuPI9j7hr2GeUxBSwluaLFPBWk6LtMGEdNwk35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n3aPCcTR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkbJj096192;
	Mon, 10 Jun 2024 09:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718030797;
	bh=ULYcdEgvqixrq+r3kLkXHhlKiFvqSQXsJbA+0Kdbv7g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=n3aPCcTRhIPWbHuDuWUV2JoGRmoxPi8000nlmHRmJiOe02+PrHQgPrmW9w/Vy+Tzg
	 fvON8BbLVa5bP27RWaDqI+a8XZOX/eBfvSSFiVI0lUKWp7Fw1AMMpYhAVBIafds7Hx
	 S7OYv8LZnwLCyk7k1yUfhQkTr4sQUnG6QTxrFJG0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AEkbxv013133
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:46:37 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:46:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:46:37 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AEkbZo096515;
	Mon, 10 Jun 2024 09:46:37 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <wbg@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        David
 Lechner <david@lechnology.com>
Subject: [PATCH v4 1/8] dt-bindings: counter: Add new ti,am62-eqep compatible
Date: Mon, 10 Jun 2024 09:46:30 -0500
Message-ID: <20240610144637.477954-2-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240610144637.477954-1-jm@ti.com>
References: <20240610144637.477954-1-jm@ti.com>
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
clock-names is not really required, so removed from required
section, make it optional for ti,am3352-eqep compatible, and
update the example.

The clock-name also changed for TI K3 SoCs so do not allow
clock-names property for the new compatible.

While we are here, add an example using ti,am62-eqep compatible.

Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
Changes since v3:
- No change
---
 .../devicetree/bindings/counter/ti-eqep.yaml  | 44 ++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
index 85f1ff83afe72..54611e06064a2 100644
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
@@ -21,19 +23,35 @@ properties:
     maxItems: 1
 
   clocks:
-    description: The clock that determines the SYSCLKOUT rate for the eQEP
-      peripheral.
+    description: The functional and interface clock that determines the clock
+      rate for the eQEP peripheral.
     maxItems: 1
 
   clock-names:
     const: sysclkout
 
+  power-domains:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,am62-eqep
+    then:
+      properties:
+        clock-names: false
+
+      required:
+        - power-domains
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
-  - clock-names
 
 additionalProperties: false
 
@@ -43,8 +61,24 @@ examples:
         compatible = "ti,am3352-eqep";
         reg = <0x180 0x80>;
         clocks = <&l4ls_gclk>;
-        clock-names = "sysclkout";
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


