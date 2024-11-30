Return-Path: <linux-iio+bounces-12872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335779DF254
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFF5281373
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681061A726F;
	Sat, 30 Nov 2024 17:43:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302021A7065;
	Sat, 30 Nov 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988597; cv=none; b=UTYIKfS1MhYC38GkItoh9p0CDAO5Orl4HNrWFxGmgZWkrgdbxtEeHRxN7ZTR7f26idIW4Y+NXBzK2PAhvZE+a+Ry/cS/xxPKvmOMUDvrAJhoLhoek4+jVaYm4TetdbaA0E+Y0MZJoSXm8iZEoKBk5j9C7NkAY4wmPGxIbiBQPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988597; c=relaxed/simple;
	bh=Wm6XP7cVL41gO6GEWXOVppiFUK4g6UCCE4p5Ba9uUF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTJ+fhM9zZjUOIlrKfWu/Oeg+dTpZnKEVSBHIIHAUzhB/YwPDdvkIsCbIcol0LqpEu+IHBd9/WWyKYvJBQ+wTNkzPwisAzYpHztXY26LHCx8AFjjj/iUAOJ9cZeG7AQIlDCPg89yVL6O0pUSNHvl1lfH50S8lAkbfj8sgrrYPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 7B20D1F0003D;
	Sat, 30 Nov 2024 17:43:13 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 08E4EA66A43; Sat, 30 Nov 2024 17:43:12 +0000 (UTC)
X-Spam-Level: *
Received: from localhost.localdomain (unknown [192.168.1.64])
	by laika.paulk.fr (Postfix) with ESMTP id 27947A66AC6;
	Sat, 30 Nov 2024 17:42:44 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH 1/2] dt-bindings: iio: Add AMS TCS3430 color sensor bindings
Date: Sat, 30 Nov 2024 18:42:38 +0100
Message-ID: <20241130174239.3298414-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMS TCS3430 is a XYZ tristimulus color sensor.

It requires a VDD power supply and can optionally support an interrupt.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
---
 .../bindings/iio/light/ams,tcs3430.yaml       | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
new file mode 100644
index 000000000000..7ecdd86932e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ams,tcs3430.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS TCS3430 XYZ tristimulus color sensor
+
+maintainers:
+  - Paul Kocialkowski <paulk@sys-base.io>
+
+description: |
+  The device supports both interrupt-driven and interrupt-less operation,
+  depending on whether an interrupt property is present in the device-tree.
+
+properties:
+  compatible:
+    const: ams,tcs3430
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: The interrupt is detected on a low level.
+
+  vdd-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+          compatible = "ams,tcs3430";
+            reg = <0x39>;
+            interrupt-parent = <&pio>;
+            interrupts = <0 8 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&reg_vcc_io>;
+        };
+    };
+...
-- 
2.47.0


