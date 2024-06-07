Return-Path: <linux-iio+bounces-6030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B2900A59
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 18:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61508B24476
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2256D19B580;
	Fri,  7 Jun 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="krdDZZk+"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E819AA5D;
	Fri,  7 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777736; cv=none; b=u8uNxsZu6OxNN/TJRbtG2feaUmzjrMtfW1oBRogQ/oC0T7knMnIUc24Vk+ng0BtRTXOsCJA+ewfjB16YN5I8vGeLmO+MmCVr2cdihtHpeBgB5ixpAVwuCZbrBc9AQg0JuP970L06G2aoZrxJDzQuoSnmwd1iBpLZ/2X9C1Sn874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777736; c=relaxed/simple;
	bh=v13/ViOAboDk7RvPyzOME/dPjIqeJIbFVdZVlzMR8m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gzt10d5bnPyL5WDchOPwRKBxx2YKvFd39JvZfd1y9I2D7UShjWgQIm/otnko/bjt8lVDCSwfJ865dV3lJheRcbADzdCaaGwz2wdg4X2tCNwcDtRee5c7utJdhqb5AfJIjqQMkWmW4ad99i8WYTFEK/RK6x+ygjR/urlGYQmGnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=krdDZZk+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457GRuwJ022356;
	Fri, 7 Jun 2024 11:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717777676;
	bh=bGY7Zuuv3RGwnT4Hrp+s+EvgozmstE7An3C3nxYuYHY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=krdDZZk+c0PM7FsTuaby3E9dulrWlwF2K8vtZlA0183V6n4K8kM6uYwbyQw43R/HM
	 YSolA9h/DO4WcrhjlaKaWl1aiv/b9fYhl6cmR1LYLrDNpG7UVZnBFo5vgZ/68o6BPd
	 gQFBhuoG1SaKi3oS76RtVpm4+kJk72M0YvtzIJB0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457GRuEG096165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 11:27:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 11:27:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 11:27:55 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457GRt1h068019;
	Fri, 7 Jun 2024 11:27:55 -0500
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
Subject: [PATCH v3 1/8] dt-bindings: counter: Add new ti,am62-eqep compatible
Date: Fri, 7 Jun 2024 11:27:48 -0500
Message-ID: <20240607162755.366144-2-jm@ti.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607162755.366144-1-jm@ti.com>
References: <20240607162755.366144-1-jm@ti.com>
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
---
Changes since v2:
- Make clock-name optional for ti,am3352-eqep compatible
 and do not allow for ti,am62-eqep compatible
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


