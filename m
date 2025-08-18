Return-Path: <linux-iio+bounces-22943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1870B2B075
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910E35656C9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCA0272807;
	Mon, 18 Aug 2025 18:32:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2E2652B0;
	Mon, 18 Aug 2025 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541953; cv=none; b=rv89Y3Fa29aW9A+0AuA8Yir2aGTRX+jvj9N9WgrPweUzZ7GoMkkxgusGi6Yms143maq2BSu8E2q4951FvReTHICvclwotybCdG8NsUsJ98rgj5oX0DqnLk9qYMRAxH0MBJ9XTldyfIiwwP4H9/mKK6TF2eJluvrS2gavvX03Px4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541953; c=relaxed/simple;
	bh=04rUiRnzldCIjyPYAIClUR+pVbQQ203qGVqhTFqmibo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kk3oFfQpuPJAE1CB9/btPiueZHKqCayBrwuFkfCe4WzNvSiMf2TJ4gDl/+DoPRrlAhyKGMv+fqRstHG7C+crWzTYLBgoB6vUkysSIVP+2dShmx2bhzhYdGu9OFubg1/gAYvZ10qk8EBCqLIeay424r+hXnF/wCCEKKl8LboIEkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
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
Subject: [PATCH 2/6] dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
Date: Mon, 18 Aug 2025 14:32:10 -0400
Message-Id: <20250818183214.380847-3-bcollins@kernel.org>
In-Reply-To: <20250818183214.380847-1-bcollins@kernel.org>
References: <20250818183214.380847-1-bcollins@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ben Collins <bcollins@watter.com>

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
---
 .../iio/temperature/microchip,mcp9600.yaml    | 60 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
index 57b387a1accc..c22edb4ab852 100644
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
@@ -34,6 +38,8 @@ properties:
         - alert2
         - alert3
         - alert4
+        - open-circuit
+        - short-circuit
 
   thermocouple-type:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -43,8 +49,37 @@ properties:
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
@@ -64,8 +99,27 @@ examples:
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
+            compatible = "microchip,mcp9601",
+                         "microchip,mcp9600";
+            microchip,vsense;
+            reg = <0x62>;
+            interrupt-parent = <&gpio>;
+            interrupts = <22 IRQ_TYPE_EDGE_RISING
+                          23 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "open-circuit", "short-circuit";
+            vdd-supply = <&vdd>;
+        };
+    };
-- 
2.39.5


