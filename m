Return-Path: <linux-iio+bounces-12870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3929DF24F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B971A281365
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82541A7259;
	Sat, 30 Nov 2024 17:42:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19E433BC;
	Sat, 30 Nov 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988552; cv=none; b=pTLapITWX9UdsQAmDiqWf1VazbnfBy596fn3SL+Mu6HFTUvFy0F8mt3fCgc3zVv3JX5pQFs1UTL0WQDLb7/rQ9cW/9HnvQhZP0pMwZ+922kDOKoVRoXmTNq8uQc3XZ4JKjfPg5KvUAPDVsvqelJavzCaryi4qjBB2Gl0BHHbx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988552; c=relaxed/simple;
	bh=+kfZ5SEZ8b8nXPZSgsTRPSsm0L+d6KUzmtAc0ZEjGMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gueGHOC2kPCO9Eei7JFBqvLVCx84oghoXQaG/B8wXOG0DFcaswM1FDYehx3zIBM897pSGGCQVdYGztOdSzE4QHmQ8OYl1VVo15jcZ0MNxVsVcDth1DP5DfTbOqhKl5/LahtQbivfNmDCOO+eeQGlK7WNbzNJLqyt2UJouNTn9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 0B1CB1F0004B;
	Sat, 30 Nov 2024 17:42:24 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 4BFDEA66AC7; Sat, 30 Nov 2024 17:42:24 +0000 (UTC)
X-Spam-Level: *
Received: from localhost.localdomain (unknown [192.168.1.64])
	by laika.paulk.fr (Postfix) with ESMTP id 52CB4A66AC0;
	Sat, 30 Nov 2024 17:42:22 +0000 (UTC)
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
Subject: [PATCH 1/2] dt-bindings: iio: Add TI OPT4048 color sensor bindings
Date: Sat, 30 Nov 2024 18:42:11 +0100
Message-ID: <20241130174212.3298371-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Texas Instruments OPT4048 is a XYZ tristimulus color sensor.

It requires a VDD power supply and can optionally support an interrupt.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
---
 .../bindings/iio/light/ti,opt4048.yaml        | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml
new file mode 100644
index 000000000000..e2b7472ab588
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ti,opt4048.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OPT4048 XYZ tristimulus color sensor
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
+    const: ti,opt4048
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: |
+      The interrupt is detected on a falling edge, with a low level asserted
+      for 1 us. It might be missed because of hardware interrupt debouncing
+      mechanisms due to this short time.
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
+        light-sensor@44 {
+          compatible = "ti,opt4048";
+            reg = <0x44>;
+            interrupt-parent = <&pio>;
+            interrupts = <0 8 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&reg_vcc_io>;
+        };
+    };
+...
-- 
2.47.0


