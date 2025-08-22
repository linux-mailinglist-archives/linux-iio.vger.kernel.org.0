Return-Path: <linux-iio+bounces-23143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB15EB31973
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D12A21968
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D8301476;
	Fri, 22 Aug 2025 13:24:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1028BABA
	for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869054; cv=none; b=U9U23TNDhj6FP6bqQH6YKAeIscMMXvxx+nv9B/wyeSZQ7W/mpdWCu2lkFltqq/0qXn+hV5JdQTlKWsgE42zQqdIJxxQAYo+U+Ch2NLrnl1HazDv42kULtR2tj7cOXtNky0ECMD0TZnL4IgTXQGSlcxcf5k1IKqjkumuT/eY2/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869054; c=relaxed/simple;
	bh=OCBS0uYeU2CqHCKiCjnIdltLOiB5T5hlTFvVGOpiRUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wf5YXFPo0Yv6M3z/oczopjrl5kI8TyVvhw/JijasNdEkI6vfAZk+3zlBTO5yPTAS1qoDRPKdY1kViBhN3IW/oQStf2p4xp1YmTfYFgohpum/gNGrfBLwbGgnrsvbcXS/YOb/yzNBaeFCenjzXrh9NoL5BaIHfbCSy2paUg8nUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
Date: Fri, 22 Aug 2025 09:23:51 -0400
Subject: [PATCH v8 2/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-upstream-changes-v8-2-40bb1739e3e2@watter.com>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
In-Reply-To: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Migadu-Flow: FLOW_OUT

Add microchip,mcp9601 compatible in addition to the original
microchip,mcp9600 to designate support between these two chips.

The current dt-binding has open-circuit and short-circuit as interrupt
names, but these are only supported in mcp9601.

The OC and SC detection requires that mcp9601 VSENSE be wired up, which
not only enables the OC SC interrupts, but also the OC and SC status
register bits.

Add a microchip,vsense boolean to show the chip is wired for this
support.

Add constraints so this feature only applies if the mcp9601 compatible
is selected.

Signed-off-by: Ben Collins <bcollins@watter.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../iio/temperature/microchip,mcp9600.yaml         | 56 ++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
index 57b387a1accc776683500949a22ef0290fc876e8..fb3661c805934255d35f664e1018ed2ec91d05f0 100644
--- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Microchip MCP9600 thermocouple EMF converter
+title: Microchip MCP9600 and similar thermocouple EMF converters
 
 maintainers:
   - Andrew Hepp <andrew.hepp@ahepp.dev>
@@ -14,7 +14,11 @@ description:
 
 properties:
   compatible:
-    const: microchip,mcp9600
+    oneOf:
+      - const: microchip,mcp9600
+      - items:
+          - const: microchip,mcp9601
+          - const: microchip,mcp9600
 
   reg:
     maxItems: 1
@@ -43,8 +47,37 @@ properties:
       Use defines in dt-bindings/iio/temperature/thermocouple.h.
       Supported types are B, E, J, K, N, R, S, T.
 
+  microchip,vsense:
+    type: boolean
+    description:
+      This flag indicates that the chip has been wired with VSENSE to
+      enable open and short circuit detect.
+
   vdd-supply: true
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: microchip,mcp9601
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 4
+        interrupt-names:
+          minItems: 1
+          maxItems: 4
+          items:
+            enum:
+              - alert1
+              - alert2
+              - alert3
+              - alert4
+        microchip,vsense: false
+
 required:
   - compatible
   - reg
@@ -64,8 +97,25 @@ examples:
             reg = <0x60>;
             interrupt-parent = <&gpio>;
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-            interrupt-names = "open-circuit";
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
+        temperature-sensor@62 {
+            compatible = "microchip,mcp9601", "microchip,mcp9600";
+            reg = <0x62>;
+            interrupt-parent = <&gpio>;
+            interrupts = <22 IRQ_TYPE_EDGE_RISING>, <23 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "open-circuit", "short-circuit";
+            vdd-supply = <&vdd>;
+            microchip,vsense;
+        };
+    };

-- 
2.39.5


