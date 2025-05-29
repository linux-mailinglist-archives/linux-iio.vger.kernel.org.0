Return-Path: <linux-iio+bounces-20005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE103AC7B2A
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 11:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2F11BC2F4D
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C921D5A9;
	Thu, 29 May 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TqkvzByg"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8021D3C6;
	Thu, 29 May 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511445; cv=none; b=tziXm0sqPuD/6ldyd3igTjt5wp/be60kWgaGmPH0pHMH2qMX1xyh2/2DEY5uz3dKmQqEYPPJLZPhEwbhW1dIWjqOJid95sJfFzDB9fnZCoKt4hFRA5sYWXZRvFudj7fSciyVWeFJwgqWYWB5FYKHQ8WaRAkXOhvUdkNKLxCMVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511445; c=relaxed/simple;
	bh=ckcjcH5RN/vq5cZGzMfcO+kL0Om01F9qrfIsIyveExg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZd4KdjxkZTG5WfrygoL/pDE3O37T0CE0r0ye00C15pHrb/8JxkDk3yPOEQDqpu2AmrLhMyituuwQ9xzHkAlxOR93aoAa7+f186slm2E3cWDQHFIuz/sudeL2xt6WejCUt0IrCKGe21cjeWhQGWw/R/wNSndjlFFdPC2Rz9mIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TqkvzByg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748511444; x=1780047444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ckcjcH5RN/vq5cZGzMfcO+kL0Om01F9qrfIsIyveExg=;
  b=TqkvzByg3C0XolW4zGtvLjURC6kVykCx/FJHjRo6yxwfcoRh+3DiLVXv
   bn5628/SmmeArBbzqK3mw1zxwnGGjI/Q/6N79B8p76brKmiTIyaYZqhkQ
   FTwb6uwHbzgsvUBuXkflAYW9YLYQrMEdJTrXFWS82zd+rcNRvYSCZKjDX
   4ax3NhlaMmK2HYjhqWHg9Bzbq3EJvtiYrlbqjzQZ/rd2jyNGvNygue4Wc
   88fe1CshtoCPC+n5GEp5P0QbyNPG81xOuPZjjfG4Rhz5tYEcbj+RTLk/2
   rxTj6SXOq7uW+B3fmNT4meUjGbXXQhVuHrBoMAKvLoU36kpGC1vAD7IIr
   Q==;
X-CSE-ConnectionGUID: xzbXPh2ETCSQJkZQFVVmZQ==
X-CSE-MsgGUID: 7oJeWaJASmKo+9VV4kG2Cg==
X-IronPort-AV: E=Sophos;i="6.15,192,1739862000"; 
   d="scan'208";a="42753030"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 May 2025 02:37:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 29 May 2025 02:36:46 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 29 May 2025 02:36:43 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: temperature: add support for MCP998X
Date: Thu, 29 May 2025 12:36:27 +0300
Message-ID: <20250529093628.15042-2-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250529093628.15042-1-victor.duicu@microchip.com>
References: <20250529093628.15042-1-victor.duicu@microchip.com>
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
 .../iio/temperature/microchip,mcp9982.yaml    | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
new file mode 100644
index 000000000000..249470c8953b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
@@ -0,0 +1,174 @@
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
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      alert1 indicates a HIGH or LOW limit was exceeded.
+      alert2 indicates a THERM limit was exceeded.
+    items:
+      - const: alert1
+      - const: alert2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,apdd-state:
+    description:
+      Enable anti-parallel diode mode operation.
+      MCP9984/84D/85/85D and MCP9933/33D support reading two external diodes
+      in anti-parallel connection on the same set of pins.
+      Omit this tag to disable anti-parallel diode mode.
+    type: boolean
+
+  microchip,recd12:
+    description:
+      Enable resistance error correction for external channels 1 and 2.
+      Omit this tag to disable REC for channels 1 and 2.
+    type: boolean
+
+  microchip,recd34:
+    description:
+      Enable resistance error correction for external channels 3 and 4.
+      Omit this tag to disable REC for channels 3 and 4.
+    type: boolean
+
+  label:
+    description: Unique name to identify which device this is.
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
+          Omit this tag in order to set the default value.
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
+              - microchip,mcp9982
+              - microchip,mcp9982d
+              - microchip,mcp9983
+              - microchip,mcp9983d
+    then:
+      properties:
+        microchip,apdd-state: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp9982
+              - microchip,mcp9982d
+              - microchip,mcp9933
+              - microchip,mcp9933d
+    then:
+      properties:
+        microchip,recd34: false
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
+            microchip,apdd-state;
+            microchip,recd12;
+            microchip,recd34;
+            vdd-supply = <&vdd>;
+
+            channel@1 {
+                reg = <0x1>;
+                label = "CPU Temperature";
+            };
+
+            channel@2 {
+                reg = <0x2>;
+                label = "GPU Temperature";
+            };
+        };
+    };
+
+...
-- 
2.48.1


