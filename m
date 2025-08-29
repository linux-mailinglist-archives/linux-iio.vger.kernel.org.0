Return-Path: <linux-iio+bounces-23377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A45B3BDFE
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 16:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D419682C89
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48538321442;
	Fri, 29 Aug 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sua2dssM"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6383203A4;
	Fri, 29 Aug 2025 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478148; cv=none; b=YQEwt/HbSY/PVXS5RzHqKfeilcLiPJx4NSEvUxbMGljJlviextdNAzVbmgsIew8wQ+sJ6ryywW6ngrTF/d6W9XGThATMlaLOVQk41ZecsDFZWPy4gA+RVk3J/SNxx1FEg5itDZNuxvaqg6/Newv8yOYIpD07NO/A/hEJM75/+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478148; c=relaxed/simple;
	bh=ECEKYXUbuT+K/mqVZxfl7QyKAbzgOW1++njN9uMqjAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX2kzYv7b+jH7p8NjkNr0NGvuadv3rKh+NndtGJj7RrIxnxf0r+kWWsQFjtASKPc2bYhU6l/8vwxaDjUm/r3FQYblUwAOpJe8CQB8EGNFyyW72IvlDEh4eCfikIobZnesEpcHC66fD7wtVFpN3hjZ/h2OwlaDZMO6w2NzAL6ux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sua2dssM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756478146; x=1788014146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ECEKYXUbuT+K/mqVZxfl7QyKAbzgOW1++njN9uMqjAg=;
  b=sua2dssMd1F6WU1JXtSzE4Vl+7rW9GOFxdn9FYUxWoX/C3FL1O9O+F+k
   DTHhGQza+Dcbg590ijprbV5Iywa8tWISl5t0J77BSf+jMRuVn/qWeUKRY
   IK6deIGNH+kPPJK8JHd7cizJvD7AP5TtQZlW7uXTnXUzj63O1nYrF3ZM1
   5+v0w+i/y9PLD0VnK4+sH/ok7S/QWQtmD6u8mpsoSEoyFI5digM2S03er
   30l77xy1Bq75EdxxSaDCPb/k5baLHlTXNyjFE7e2n+/FexfbK9CsLj8j2
   lW9wnTtBpTbBHRs0rWb7BG9vKBNIM9EO/4G606eAaxWu3mLgeaDVXdi/D
   w==;
X-CSE-ConnectionGUID: Aijz/O6ESW2tMjdzAfi4Ew==
X-CSE-MsgGUID: +nVKjeWLSkyFuLH4nmTLVg==
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="45813889"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2025 07:35:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 29 Aug 2025 07:35:12 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 29 Aug 2025 07:35:09 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: temperature: add support for MCP998X
Date: Fri, 29 Aug 2025 17:34:46 +0300
Message-ID: <20250829143447.18893-2-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250829143447.18893-1-victor.duicu@microchip.com>
References: <20250829143447.18893-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This is the devicetree schema for Microchip MCP998X/33 and MCP998XD/33D
Multichannel Automotive Temperature Monitor Family.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 .../iio/temperature/microchip,mcp9982.yaml    | 203 ++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
new file mode 100644
index 000000000000..2f092e376fe8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive
+       Temperature Monitor Family
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
+      - microchip,mcp9933d
+      - microchip,mcp9982
+      - microchip,mcp9982d
+      - microchip,mcp9983
+      - microchip,mcp9983d
+      - microchip,mcp9984
+      - microchip,mcp9984d
+      - microchip,mcp9985
+      - microchip,mcp9985d
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      -alert-therm is used to handle a HIGH or LOW limit.
+      -therm-addr is used to handle a THERM limit on chips
+      without "D" in the name.
+      -sys-shutdown is used to handle a THERM limit on chips
+      with "D" in the name.
+    items:
+      - const: alert-therm
+      - const: therm-addr
+      - const: sys-shutdown
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,enable-anti-parallel:
+    description:
+      Enable anti-parallel diode mode operation.
+      MCP9984/84D/85/85D and MCP9933/33D support reading two external diodes
+      in anti-parallel connection on the same set of pins.
+    type: boolean
+
+  microchip,parasitic-res-on-channel1-2:
+    description:
+      Indicates that the chip and the diodes/transistors are sufficiently far
+      apart that a parasitic resistance is added to the wires, which can affect
+      the measurements. Due to the anti-parallel diode connections, channels
+      1 and 2 are affected together.
+    type: boolean
+
+  microchip,parasitic-res-on-channel3-4:
+    description:
+      Indicates that the chip and the diodes/transistors are sufficiently far
+      apart that a parasitic resistance is added to the wires, which can affect
+      the measurements. Due to the anti-parallel diode connections, channels
+      3 and 4 are affected together.
+    type: boolean
+
+  vdd-supply: true
+
+patternProperties:
+  "^channel@[1-4]$":
+    description:
+      Represents the external temperature channels to which
+      a remote diode is connected.
+    type: object
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      microchip,ideality-factor:
+        description:
+          Each channel has an ideality factor.
+          Beta compensation and resistance error correction automatically
+          correct for most ideality errors. So ideality factor does not need
+          to be adjusted in general.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        default: 18
+
+      label:
+        description: Unique name to identify which channel this is.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp9982d
+              - microchip,mcp9983d
+              - microchip,mcp9984d
+              - microchip,mcp9985d
+              - microchip,mcp9933d
+    then:
+      properties:
+        interrupts-names:
+          items:
+            - const: alert-therm
+            - const: sys-shutdown
+    else:
+      properties:
+        interrupts-names:
+          items:
+            - const: alert-therm
+            - const: therm-addr
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp9982
+              - microchip,mcp9983
+              - microchip,mcp9982d
+              - microchip,mcp9983d
+    then:
+      properties:
+        microchip,enable-anti-parallel: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp9982d
+              - microchip,mcp9983d
+              - microchip,mcp9984d
+              - microchip,mcp9985d
+              - microchip,mcp9933d
+    then:
+      properties:
+        microchip,parasitic-res-on-channel1-2: false
+        microchip,parasitic-res-on-channel3-4: false
+        microchip,ideality-factor: false
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
+            microchip,enable-anti-parallel;
+            microchip,parasitic-res-on-channel1-2;
+            microchip,parasitic-res-on-channel3-4;
+            vdd-supply = <&vdd>;
+
+            channel@1 {
+                reg = <1>;
+                label = "CPU Temperature";
+            };
+
+            channel@2 {
+                reg = <2>;
+                label = "GPU Temperature";
+            };
+        };
+    };
+
+...
-- 
2.48.1


