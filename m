Return-Path: <linux-iio+bounces-24845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C15BC4445
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 12:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25D104E7001
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CB2F531C;
	Wed,  8 Oct 2025 10:16:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D62571DA;
	Wed,  8 Oct 2025 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918611; cv=none; b=K4IkRm6UVIBfODkDMRCUBfvPXBFJIiB5EqZI72CryD0c3ghNfuIlQfZVRSDmDMb03yn85FgqamQBRPMwBLtblkmzfFPJxIBHs1Z/pMYUCB6P6z55WYFblyLZCQDbYX7mNT5klxF/36TXK9fDVRmm2zo8KiNV9URWg4RJCO9PFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918611; c=relaxed/simple;
	bh=2IPtvjdgiWaQWqjxzOFwilGlEykAXjknjntHxIDRHTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6yW+KGtC6Yurtr4H+D0j7Oo/zCoNHbf5ApeAYxDPl7g9iD8yIveyteqORKx5Cp3vQUaxxpzHEx3n+zWlvcdAT33VqZB5SVXNYKM/GdPb2nPv/qkwctjbahyx/hla0fwjX6TddK1eKGQ7Og8oLUbixcZvZ3LtjLtQ3gOf1VRGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1CFDC1A3A6A;
	Wed,  8 Oct 2025 12:07:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B251A1A15A4;
	Wed,  8 Oct 2025 12:07:20 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 28E771800087;
	Wed,  8 Oct 2025 18:07:19 +0800 (+08)
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
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: temperature: Add NXP P3T175x support
Date: Wed,  8 Oct 2025 15:37:12 +0530
Message-Id: <20251008100713.1198461-2-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
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

The P3T1750 and P3T1755 are functionally equivalent temperature
sensors with identical interfaces and features. The P3T1755 offers
improved accuracy(±0.5°C) in the –20°C to +85°C range, while both
maintain ±1°C accuracy across –40°C to +125°C.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
V3 -> V4: Changes since V3:
	  - Updated commit message to clarify the difference between P3T1750 and P3T1755.
V2 -> V3: Changes since V2:
          - Removed nxp,interrupt-mode and nxp,fault-queue properties from DT binding
          - Updated compatible strings:
            - nxp,p3t1750-iio → nxp,p3t1750dp
            - nxp,p3t1755-iio → nxp,p3t1755dp
V1 -> V2: Changes since V1:
          - Dropped nxp,alert-active-high
          - Fixed YAML formatting, line wrapping, and examples

 .../bindings/iio/temperature/nxp,p3t1755.yaml | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
new file mode 100644
index 000000000000..16a01fa81251
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP P3T175xDP Temperature Sensor
+
+maintainers:
+  - Lakshay Piplani <lakshay.piplani@nxp.com>
+
+description: |
+  Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
+
+  P3T175xDP (P3T1750/P3T1755) is a digital temperature sensor with a range of
+  -40°C to +125°C and a 12-bit resolution. It supports communication over both
+  I2C and I3C interfaces.
+
+  The I2C interface supports up to 32 static addresses and provides an ALERT
+  output to signal when temperature thresholds are crossed.
+
+  The I3C interface supports In-Band interrupts (IBI) in interrupt mode,
+  allowing the device to notify the controller of threshold events without
+  dedicated alert pin.
+
+properties:
+  compatible:
+    enum:
+      - nxp,p3t1750dp
+      - nxp,p3t1755dp
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
+            compatible = "nxp,p3t1755dp";
+            reg = <0x48>;
+            interrupt-parent = <&gpio2>;
+            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.25.1


