Return-Path: <linux-iio+bounces-22883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80EB29771
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 05:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5048A196640A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 03:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A825E44D;
	Mon, 18 Aug 2025 03:51:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE12165E9
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489074; cv=none; b=Lgu3CAJGlqil8Xd96VaNJVrvKg7lJKRGtsWWMoWV+n+b4+X/TATkN8ICB2JWPXwFJebIlmQFXXGsbArkjc/f7cQeJQM+xF+kfEdSy5VhMSbefnRbV7fldbAGFtRR9psMcQ0DiNauUUeeKKgNBaCjFX90bYWP69WIMBqbdkJ50M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489074; c=relaxed/simple;
	bh=JL5xCHpQCcJpzvx9mIQ8qVBGrr2i7VZITlYSrf/FptM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxhtZCTKQ3ukWnTScCPwYqFdaozETscBTZmrj0NWqLFWNwJWhJcuh6H3DWlbtbg3e+G5D3nyiL0AKwRcX3K7GXRl+Fg2ajaLnS54Bgt76yEkM/QiUuLQ8eVlhQJYNsWV8+YScugK3xZ9nkf084R6W/ZiuwaWfdJb/aQsgRfiWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: Ben Collins <bcollins@watter.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
Date: Sun, 17 Aug 2025 23:50:49 -0400
Message-Id: <20250818035053.32626-2-bcollins@watter.com>
In-Reply-To: <20250818035053.32626-1-bcollins@watter.com>
References: <20250818035053.32626-1-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The mcp9600 driver supports the mcp9601 chip, but complains about not
recognizing the device id on probe. A separate patch...

	iio: mcp9600: Recognize chip id for mcp9601

...addresses this. This patch updates the dt-bindings for this chip to
reflect the change to allow explicitly setting microchip,mcp9601 as
the expected chip type.

The mcp9601 also supports features not found on the mcp9600, so this
will also allow the driver to differentiate the support of these
features.

In addition, the thermocouple-type needs a default of 3 (k-type). The
driver doesn't support this, yet. A later patch in this series adds it:

	iio: mcp9600: Add support for thermocouple-type

Lastly, the open/short circuit functionality is dependent on mcp9601
chipsset. Add constraints for this and a new property, microchip,vsense,
enables this feature since it depends on the chip being wired
properly.

Passed dt_binding_check.

Signed-off-by: Ben Collins <bcollins@watter.com>
---
 .../iio/temperature/microchip,mcp9600.yaml    | 69 +++++++++++++++----
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
index d2cafa38a5442..1caeb6526fd20 100644
--- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Microchip MCP9600 thermocouple EMF converter
+title: Microchip MCP9600 and similar thermocouple EMF converters
 
 maintainers:
   - Andrew Hepp <andrew.hepp@ahepp.dev>
@@ -14,29 +14,30 @@ description:
 
 properties:
   compatible:
-    const: microchip,mcp9600
+    oneOf:
+      - const: microchip,mcp9600
+      - items:
+          - const: microchip,mcp9600
+          - const: microchip,mcp9601
 
   reg:
     maxItems: 1
 
   interrupts:
     minItems: 1
-    maxItems: 6
+    maxItems: 4
 
   interrupt-names:
     minItems: 1
-    maxItems: 6
     items:
-      enum:
-        - open-circuit
-        - short-circuit
-        - alert1
-        - alert2
-        - alert3
-        - alert4
+      - const: alert1
+      - const: alert2
+      - const: alert3
+      - const: alert4
 
   thermocouple-type:
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 3
     description:
       Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
       Use defines in dt-bindings/iio/temperature/thermocouple.h.
@@ -44,6 +45,33 @@ properties:
 
   vdd-supply: true
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,mcp9601
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 6
+        interrupt-names:
+          items:
+            - const: alert1
+            - const: alert2
+            - const: alert3
+            - const: alert4
+            - const: open-circuit
+            - const: short-circuit
+        microchip,vsense:
+          default: false
+          description:
+            This flag indicates that the chip has been wired with VSENSE to
+            enable open and short circuit detect. By default, this is false,
+            since there's no way to detect that the chip is wired correctly.
+          type: boolean
+
 required:
   - compatible
   - reg
@@ -62,9 +90,24 @@ examples:
             compatible = "microchip,mcp9600";
             reg = <0x60>;
             interrupt-parent = <&gpio>;
-            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-            interrupt-names = "open-circuit";
+            interrupts = <25 IRQ_TYPE_EDGE_RISIN>;
+            interrupt-names = "alert1";
             thermocouple-type = <THERMOCOUPLE_TYPE_K>;
             vdd-supply = <&vdd>;
         };
     };
+  - |
+    #include <dt-bindings/iio/temperature/thermocouple.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@60 {
+            compatible = "microchip,mcp9601", "microchip,mcp9600";
+            microchip,vsense;
+            reg = <0x62>;
+            interrupt-parent = <&gpio>;
+            vdd-supply = <&vdd>;
+        };
+    };
-- 
2.39.5


