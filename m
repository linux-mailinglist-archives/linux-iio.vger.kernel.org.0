Return-Path: <linux-iio+bounces-23326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F7B38008
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD77D7A6A5F
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16085346A1D;
	Wed, 27 Aug 2025 10:39:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DA2E7BC2;
	Wed, 27 Aug 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291197; cv=none; b=Q1SEICwBpPzriZc3BO5qgF6xJEejTAD8QTi7zcruoIirs+PHf7Fp6EjBh3QCpNgj+sBPps+mkVsKdpod7s0uMWQggyg1x37b5yBdOARVE/aznDt6s7fe2/TusRYcFrRPTBjskPlrLMJnt7h28p1QJdlK4AMAlq8+2mqxQ7Fejo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291197; c=relaxed/simple;
	bh=zBmVuPfQ17g0wz1YO7aJ9V+BH64lrAFeAK281DXwkdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UWbZtTyVQhZ2R4oOElG7qfyiyR90IaYqjHASzpBojqAFx2dnz5e3/jmwp46Ms2KddCjKhEtcvVXn/JtxiJUWV9EDYGIIzYAAsAFuwerURcoQtW1ROPHmfJa/FjDerCj2EUkSaX+lPP4KnSsd3twuymkerKB9us8T5Eyg0Z1aHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C210020150C;
	Wed, 27 Aug 2025 12:31:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 85DD7201512;
	Wed, 27 Aug 2025 12:31:21 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A1B831800086;
	Wed, 27 Aug 2025 18:31:19 +0800 (+08)
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
	devicetree@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jonathan.cameron@huawei.com,
	akpm@linux-foundation.org,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: temperature: Add NXP P3T175x support
Date: Wed, 27 Aug 2025 16:01:04 +0530
Message-Id: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
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

Add bindings for the NXP P3T175x (P3T1750/P3T1755) temperature
sensor, supporting both I2C & I3C interfaces.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
Changes in v2 (addressed review comments from Krzysztof Kozlowski):
 - Dropped nxp,alert-active-high: unnecessary as polarity handling is implicit in driver.
 - Retained nxp,interrupt-mode: required to program TM(thermostat mode) bit; enables interrupt
   (latched) mode. If not present in DT entry comparator mode is set as default.
 - Retained nxp,fault-queue: This needs to be configured during device initialization.
   This property configures the hardware fault queue length. Defines how many consecutive faults
   are required before ALERT/IBI is asserted, preventing false triggers in noisy environments.
 - The `reg` property remains required to satisfy `dt_binding_check`.
 - Fixed YAML formatting, line wrapping, and examples.
 - Changed compatibles from nxp,p3t1755 to nxp,p3t1755-iio and nxp,p3t1750 to nxp,p3t1750-iio
   as reported by kernel test robot.

 .../bindings/iio/temperature/nxp,p3t1755.yaml | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
new file mode 100644
index 000000000000..4eb6fc5cb247
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
@@ -0,0 +1,97 @@
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
+  P3T175x (P3T1750/P3T1755) is a digital temperature sensor with a range of -40°C to
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
+      - nxp,p3t1750-iio
+      - nxp,p3t1755-iio
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
+    true
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
+            compatible = "nxp,p3t1755-iio";
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
-- 
2.25.1


