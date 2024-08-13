Return-Path: <linux-iio+bounces-8432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3694FD4E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 07:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC37282AD2
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 05:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92222381C7;
	Tue, 13 Aug 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="QhFGWnWA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310828DA5
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527659; cv=none; b=YiI61eAr9zMbzjfESwQF9ayhwsWPUk5JAqbgiFEepkfiExywuYiqLC22J3951OCY51dyvVQnTWd0S2gDIah6TPWiH5vgabq+igi6+k9eXVlbGO0B8QS7z3gH/xAFi1AIAedfpmKM6CVwEooFMtTJhyKOSiXVCFV0OvLkfUquLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527659; c=relaxed/simple;
	bh=+Sl9js/FAvukhdw5pD5G5fro6DzgQKGz+ecKiCcQwqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fh5uAwSKrBbT3C82vRAsLz43++mDj1RZrhqfniiiPwdEdqMbj0W7+tf/K5KRdtuksCwJfPvivAC0OnVjx2qST+aiQEKtXEIiakV9/Wx0j/Zw1RxTFBsIAbrUaJiDDFFe47wbZ2HGusftwmwY1wyhNqF3Saa3ZsjXHOdHk22u65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=QhFGWnWA; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202408130540533d9c99f68ca363c30e
        for <linux-iio@vger.kernel.org>;
        Tue, 13 Aug 2024 07:40:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mrt4p7/B6H9XYp1wTap2ACfGRhZiMZXU+/jlyXlj66w=;
 b=QhFGWnWAN6Y4QoLtKfwKnqfnzPRm1nabQAN3+FjUDNJ25utXlcFw0N16i1gviVU+M6+obx
 VeXTtUyZ1mBjV+a6ksVhybo6heKZXlyE5j90/mvDbhiCPPWl+R0Fx2JWSqwgOCZsOjNxqdrX
 g1UpzTYE7uzDbWQ92aV5K8OQrZCa3z5g3fXKmUI0wn05Sj4qLBwaHT5ajriDmJm9Q6mauKAL
 dQbc7A8v18JOJH8/vnNWy5QcDHE6GwZMW9fS1ZuTHVKFwvG2DG7ZtkDvXNHWOA7vQH4PQjwr
 1w+OOFIO2pOFiiq00TqX6cZVa3ZilYtxe6nm6InQVpXv2P7sibF6q33Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Date: Tue, 13 Aug 2024 07:40:41 +0200
Message-ID: <f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723527641.git.jan.kiszka@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Chao Zeng <chao.zeng@siemens.com>

Add the binding document for the everlight pm16d17 sensor.

Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
---
 .../iio/proximity/everlight,pm16d17.yaml      | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml
new file mode 100644
index 000000000000..fadc3075181a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/everlight,pm16d17.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Everlight PM-16D17 Ambient Light & Proximity Sensor
+
+maintainers:
+  - Chao Zeng <chao.zeng@siemens.com>
+
+description: |
+  This sensor uses standard I2C interface. Interrupt function is not covered.
+  Datasheet: https://en.everlight.com/sensor/category-proximity_sensor/digital_proximity_sensor/
+
+properties:
+  compatible:
+    enum:
+      - everlight,pm16d17
+
+  reg:
+    maxItems: 1
+
+  ps-gain:
+    description: Receiver gain of proximity sensor
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+    default: 1
+
+  ps-itime:
+    description: Conversion time for proximity sensor [ms]
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - "0.4"
+      - "0.8"
+      - "1.6"
+      - "3.2"
+      - "6.3"
+      - "12.6"
+      - "25.2"
+    default: "0.4"
+
+  ps-wtime:
+    description: Waiting time for proximity sensor [ms]
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - "12.5"
+      - "25"
+      - "50"
+      - "100"
+      - "200"
+      - "400"
+      - "800"
+      - "1600"
+    default: "12.5"
+
+  ps-ir-led-pulse-count:
+    description: IR LED drive pulse count
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 256
+    default: 1
+
+  ps-offset-cancel:
+    description: |
+      When PS offset cancel function is enabled, the result of subtracting any
+      value specified by the PS offset cancel register from the internal PS
+      output data is written to the PS output data register.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    maximum: 65535
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lightsensor: pm16d17@44 {
+            compatible = "everlight,pm16d17";
+            reg = <0x44>;
+
+            ps-gain = <1>;
+            ps-itime = "0.4";
+            ps-wtime = "12.5";
+            ps-ir-led-pulse-count = <1>;
+            ps-offset-cancel = <280>;
+        };
+    };
-- 
2.43.0


