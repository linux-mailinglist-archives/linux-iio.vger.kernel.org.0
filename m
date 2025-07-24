Return-Path: <linux-iio+bounces-21931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F5B1043F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518E54E4DE8
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA8B28D821;
	Thu, 24 Jul 2025 08:40:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47F28C2A8;
	Thu, 24 Jul 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346400; cv=none; b=IHyKRp7Yk2+tPGq1ivo0eLPQ5e22bzCF/aG92EqtLl3b2yp8ZsUlafiKwa3BS4HBPGJhlRekyZ0gfnoibArAm8jsdO33NesSzmRYJkp6hJ1w4yb191KeNhy1pami1DcJfSrjCVhxGPuuyZdJpzumK1HL49iYNDWIS0YTv7nWzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346400; c=relaxed/simple;
	bh=Vpp039i32EaO96pzeZioF9cjUnLRHhBZnWZS5f9ERXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YKAQ6RY6koOgAOuuBKwOlOL/dIVDFLi9CSqNxh10Ox1D7L/UZyvwWy2tIE6DFmtIMeloEHrEpPuBzsz81FY0+t1Fx26nPHSBPTyQ/5RlQxYNqmb6+o7Jv+adKAYHer/zyzU+tssc/X0JqYIkBbmP7vysObBIqAyrjJ4n37Hy93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D15001A0432;
	Thu, 24 Jul 2025 10:39:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E2171A11B9;
	Thu, 24 Jul 2025 10:39:56 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9B1D1800093;
	Thu, 24 Jul 2025 16:39:54 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	peterz@infradead.org,
	jstephan@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com,
	carlos.song@nxp.com,
	xiaoning.wang@nxp.com,
	haibo.chen@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH 1/2] dt-bindings: iio: temperature: Add NXP P3T175x support.
Date: Thu, 24 Jul 2025 14:09:50 +0530
Message-Id: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add bindings for the NXP P3T175x (P3T1755/P3T1750)
digital temperature sensor, supporting both I2C &
I3C interfaces.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
 .../bindings/iio/temperature/nxp,p3t1755.yaml | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
new file mode 100644
index 000000000000..740eb4674b7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP P3T175x Temperature Sensor
+
+maintainers:
+  - Lakshay Piplani <lakshay.piplani@nxp.com>
+
+description: |
+  Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
+
+  P3T175x (P3T1755/P3T1750) is a digital temperature sensor with a range of -40°C to
+  +125°C and a 12-bit resolution. It supports communication over
+  both I2C and I3C interfaces.
+
+  The I2C interface supports up to 32 static addresses and provides
+  an ALERT output to signal when temperature thresholds are crossed.
+
+  The I3C interface supports In-Band interrupts (IBI) in interrupt mode,
+  allowing the device to notify the controller of threshold events without
+  dedicated alert pin.
+
+  The device supports configurable thermostat modes (interrupt or comparator),
+  fault queue length etc.
+
+properties:
+  compatible:
+    enum:
+      - nxp,p3t1755
+      - nxp,p3t1750
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+    description: |
+      In I2C mode, the device supports up to 32 static addresses.
+      In I3C mode, the 'reg' property encodes a triplet of
+      <static-address BCR PID> used for device matching.
+      Static address is optional if matching is done via PID.
+
+  nxp,interrupt-mode:
+    type: boolean
+    description: |
+      Enables interrupt mode (TM = 1), where alerts are latched until
+      cleared by a register read.
+      Required for IBI support over I3C. On I2C, both interrupt and
+      comparator mode support events.
+
+  nxp,alert-active-high:
+    type: boolean
+    description: |
+      Only applicable for I2C mode.
+      Sets the polarity of ALERT pin to active high, if true.
+      Ignored in I3C mode (which uses IBI signaling).
+
+  nxp,fault-queue:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 6]
+    description: |
+      Number of consecutive temperature limit
+      violations required before an alert is triggered.
+      valid values:- 1, 2, 4 or 6.
+      If unspecified, hardware default (2) is used.
+
+  assigned-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0x1
+    maximum: 0xff
+    description: |
+      Dynamic address to be assigned to this device. In case static address is
+      present (first cell of the reg property != 0), this address is assigned
+      through SETDASA. If static address is not present, this address is assigned
+      through SETNEWDA after assigning a temporary address via ENTDAA.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temp-sensor@48 {
+            compatible = "nxp,p3t1755";
+            reg = <0x48>;
+            nxp,interrupt-mode;
+            nxp,fault-queue = <6>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+
+  - |
+    i3c {
+      #address-cells = <3>;
+      #size-cells = <0>;
+      temp-sensor@48,236152a00 {
+        reg = <0x48 0x236 0x152a00>;
+        assigned-address = <0x50>;
+      };
+    };
+
+  - |
+    i3c {
+      #address-cells = <3>;
+      #size-cells = <0>;
+      temp-sensor@0 {
+        reg = <0x0 0x236 0x152a00>;
+        nxp,interrupt-mode;
+        nxp,fault-queue = <6>;
+      };
+    };
-- 
2.25.1


