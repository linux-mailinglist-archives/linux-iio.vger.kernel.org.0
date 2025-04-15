Return-Path: <linux-iio+bounces-18132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C80A89F68
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 15:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A303BF296
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE581297A60;
	Tue, 15 Apr 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u08LAllH"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027D2820B0;
	Tue, 15 Apr 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723653; cv=none; b=NQbukTZhS7f0sGJZkuHK3EvFQ5+U6Ks78YInOe7Yk/AlUyNBKGACX1KZaRj10emUeglpGpRfgk3bM6oO7C20wTlrBm30+pjGVgvw//NSVUamTM5p1dfuujD3KwiB03WZxJDyC/8FBMlRTJYO0oLEsvgFVraezkeAtiQrsz1RM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723653; c=relaxed/simple;
	bh=xZRvVk5qzUx/BSBKzSNc1vMSD4GWcEGpcr1tfcGLHmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pg6j0VHqtShUvmiVF5VYUbDX50aaNt5IBdZjeWiEj/VZ6Ds3MwyJman9BF02+aKouCzmP5mt7dGa7nw0e6TudpfXRZBxPg/96NaHCQX73koc0DRgYYYQg36A43dJUXZDWv5mkI6LYg9qpTNe5KEr39AWODwIbEdsAvBwT09U5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=u08LAllH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744723652; x=1776259652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xZRvVk5qzUx/BSBKzSNc1vMSD4GWcEGpcr1tfcGLHmU=;
  b=u08LAllHVXZU5ZadnLBpf981BYcuQDuahIaVssLZ9hMbgXs8Jb8FVoZx
   OL1fc9vkhRRasYgn7iaS/9AC51MY2T9VjE69dxVjzg0Wp9kzLe9JelZ/s
   apGbWNcA+dysmjjXQNBCeCJ3klMUSzC1ka+Lcsbw2AWu5mlQDcGEgyR91
   q+iQd60RfzxbUt6G3Z/IsLxvyNcEKiTdKb3iVbe4Dh0SloGYihlL9+OZ2
   8nxoQMqGihVTIycWCvG3U/WeiVbco+X14TxD31GFaxsKnWfeEIP6yfd/2
   2OQaQkfiQ5GfXyo0/2hLb0PumVxL7B142AFh4kFZ5I1Nsaz81C9YmS+TQ
   w==;
X-CSE-ConnectionGUID: FN4IPNwESQaGizKyN6d47Q==
X-CSE-MsgGUID: V4DD7CvSTzCKsqBNaCUQUw==
X-IronPort-AV: E=Sophos;i="6.15,213,1739862000"; 
   d="scan'208";a="40495080"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Apr 2025 06:27:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 15 Apr 2025 06:27:01 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 15 Apr 2025 06:26:59 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>
CC: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<victor.duicu@microchip.com>, <marius.cristea@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: iio: temperature: add support for MCP998X
Date: Tue, 15 Apr 2025 16:26:22 +0300
Message-ID: <20250415132623.14913-2-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250415132623.14913-1-victor.duicu@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This is the devicetree schema for Microchip MCP998X/33 and
MCP998XD/33D Multichannel Automotive Temperature Monitor Family.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 .../iio/temperature/microchip,mcp9982.yaml    | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
new file mode 100644
index 000000000000..8cbf897d1278
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
@@ -0,0 +1,182 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family
+
+maintainers:
+  - Victor Duicu <victor.duicu@microchip.com>
+
+description: |
+  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire multichannel
+  automotive temperature monitor.
+  The datasheet can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp9933
+      - microchip,mcp9933D
+      - microchip,mcp9982
+      - microchip,mcp9982D
+      - microchip,mcp9983
+      - microchip,mcp9983D
+      - microchip,mcp9984
+      - microchip,mcp9984D
+      - microchip,mcp9985
+      - microchip,mcp9985D
+
+  reg:
+    maxItems: 1
+    
+  interrupts:
+    maxItems: 2
+    
+  interrupt-names:
+    description: |
+      ALERT1 indicates a HIGH or LOW limit was exceeded.
+      ALERT2 indicates a THERM limit was exceeded.
+    items:
+      - const: ALERT1
+      - const: ALERT2
+    
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,temp-hysteresis:
+    description: |
+      Value of temperature limit hysteresis.
+      Omit this tag to set the default value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    
+  microchip,extended-temp-range:
+    description: |
+      Set the chip to work in the extended temperature range -64 degrees C to 191.875 degrees C.
+      Omit this tag to set the default range 0 degrees C to 127.875 degrees C
+    type: boolean
+    
+  microchip,beta-channel1:
+    description: |
+      The beta compensation factor for external channel 1 can be set
+      by the user, or can be set automatically by the chip.
+      If one wants to enable beta autodetection, omit this tag.
+      Please consult the documentation if one wants to set a specific beta.
+      If anti-parallel diode operation is enabled, the default value is set
+      and can't be changed.
+    type: boolean
+    
+  microchip,beta-channel2:
+    description: |
+      The beta compensation factor for external channel 2 can be set
+      by the user, or can be set automatically by the chip.
+      If one wants to enable beta autodetection, omit this tag.
+      Please consult the documentation if one wants to set a specific beta.
+      If anti-parallel diode operation is enabled, the default value is set
+      and can't be changed.
+    type: boolean
+    
+  microchip,apdd-state:
+    description: |
+      Enable anti-parallel diode mode operation.
+      Omit this tag to disable anti-parallel diode mode by default.
+    type: boolean
+    
+  microchip,recd12:
+    description: |
+      Enable resistance error correction for external channels 1 and 2.
+      Not all chips support resistance error correction on external
+      channels 1 and 2, please consult the documentation.
+      Omit this tag to disable REC for channels 1 and 2 by default.
+    type: boolean
+    
+  microchip,recd34:
+    description: |
+      Enable resistance error correction for external channels 3 and 4.
+      Not all chips support resistance error correction on external
+      channels 3 and 4, please consult the documentation.
+      Omit this tag to disable REC for channels 3 and 4 by default.
+    type: boolean
+    
+  label:
+    description: Unique name to identify which device this is.
+    
+  vdd-supply: true
+ 
+patternProperties:
+  "^channel@[1-4]+$":
+    description: |
+      Represents the external temperature channels to which a remote diode is
+      connected.
+    type: object
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+      
+      microchip,ideality-factor:
+        description: |
+          Each channel has an ideality factor.
+          Beta compensation and resistance error correction automatically correct
+          for most ideality error. So ideality factor does not need to be adjusted in general.
+          Omit this tag in order to set the default value.
+          Please consult the documentation if one wants to set a specific ideality value.
+        $ref: /schemas/types.yaml#/definitions/uint32
+      
+      label:
+        description: Unique name to identify which channel this is.
+    
+    required:
+      - reg
+    
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        
+        temperature-sensor@4c {
+            compatible = "microchip,mcp9985";
+            reg = <0x4c>;
+            
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            label = "temperature-sensor";
+            
+            microchip,temp-hysteresis = <10>;
+            microchip,extended-temp-range;
+            microchip,apdd-state;
+            microchip,recd12;
+            microchip,recd34;
+            vdd-supply = <&vdd>;
+            
+            channel@1{
+                reg = <0x1>;
+                label = "CPU Temperature";
+            };
+            
+            channel@2{
+                reg = <0x2>;
+                label = "GPU Temperature";
+            };
+        };
+    };
+
+...
-- 
2.45.2


