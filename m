Return-Path: <linux-iio+bounces-24249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3378B84545
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560202A5324
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A030496C;
	Thu, 18 Sep 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tSbcXemR"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD35303CB7;
	Thu, 18 Sep 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194505; cv=none; b=Dzn2Cyt0rur85XZDFoPmGLl4InjctDIKGn5J8au1oiK++jQoCE5F3GOzq3oTPFHsqu3mQdW5saKKNZykAFdllcCHnO1wwp24EdqwvTJFjCKMh/uFsJdNVmM4TiaIM9E9olK/0HDat3+h9Ll7fnwORErlRNScSOJVsLZRg+D7BF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194505; c=relaxed/simple;
	bh=x8FUwB48CLzYSVqeSIg07rPjACWfP5KP2Bk4PQ7c9vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/kKgfn/Ke/YKI1Di/AzPxqV0Mtdn29yVDNGnwp6eICymbpc73qN3FHDDDfP8c0iAvvS0THXrBb1Y5tEwe6A0mdy8HgGv/p0mqIAhhUJ7Xm/jvcvW4uRNLETnP94yohw/48pKC7ne+YzhlInWD6MUTw5b8lHiuQp4PzXMdDTYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tSbcXemR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758194505; x=1789730505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8FUwB48CLzYSVqeSIg07rPjACWfP5KP2Bk4PQ7c9vQ=;
  b=tSbcXemR4R4GF6/XpiNj97dsyfnTNBZR4SQO3GbfQlI2ZBFSc9g3Atn7
   m/SVdNcCRbzKZSCS5QCr+d532jnm2KAOgf3/5nr4Gqj1OhTD+CjYxTeYy
   gr9lXnXmMT7dbo0WqyEjW4KIOEitFfBCFy1NORPs5wjDwK742mDHBE6AC
   fwHvT+ZLmC9YnmXptcqiyTk13Vnq25U6DM7rdswhdwD5q3V2xGUz/iKCo
   yfbf5Z2jOsrePmi5ZHgcOqDLBc4loWHYsuXe5PvCFR4D3nPfH/7xMGdap
   zKwxEb3CajdLgU9jgiVZdWpnPVibQZCEWCzEochUeSY/pyIhOlckAc3eg
   g==;
X-CSE-ConnectionGUID: MK9Bjv+SSfyA+tPYDT8xQg==
X-CSE-MsgGUID: u3Aiwfw3TCi32MQM9qtTNQ==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="278045454"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 04:21:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 04:21:06 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 04:21:03 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <marius.cristea@microchip.com>,
	<victor.duicu@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: temperature: add support for MCP998X
Date: Thu, 18 Sep 2025 14:19:36 +0300
Message-ID: <20250918111937.5150-2-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250918111937.5150-1-victor.duicu@microchip.com>
References: <20250918111937.5150-1-victor.duicu@microchip.com>
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
 .../iio/temperature/microchip,mcp9982.yaml    | 186 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
new file mode 100644
index 000000000000..5aaf9ae2b862
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
@@ -0,0 +1,186 @@
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
+    items:
+      - description: Signal coming from ALERT/THERM pin.
+      - description: Signal coming from THERM/ADDR pin.
+      - description: Signal coming from SYS_SHDN pin.
+
+  interrupt-names:
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
+          minItems: 1
+          maxItems: 4
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
+            pattern: '^.+d$'
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
+            pattern: '^microchip,mcp998(2|3)$'
+    then:
+      properties:
+        microchip,enable-anti-parallel: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: '^microchip,mcp998(2|3)d$'
+    then:
+      properties:
+        microchip,enable-anti-parallel: false
+        microchip,parasitic-res-on-channel1-2: true
+        microchip,parasitic-res-on-channel3-4: true
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: 'microchip,mcp99(33|8[4-5])d$'
+    then:
+      properties:
+        microchip,parasitic-res-on-channel1-2: true
+        microchip,parasitic-res-on-channel3-4: true
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
diff --git a/MAINTAINERS b/MAINTAINERS
index d53a536288ca..37530194c9fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16662,6 +16662,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
+MICROCHIP MCP9982 TEMPERATURE DRIVER
+M:	Victor Duicu <victor.duicu@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
+
 MICROCHIP MMC/SD/SDIO MCI DRIVER
 M:	Aubin Constans <aubin.constans@microchip.com>
 S:	Maintained
-- 
2.48.1


