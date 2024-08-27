Return-Path: <linux-iio+bounces-8824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E13960404
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 10:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187751F2363C
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2024 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F4198A2A;
	Tue, 27 Aug 2024 08:08:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-6.us.a.mail.aliyun.com (out198-6.us.a.mail.aliyun.com [47.90.198.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDB1EA90;
	Tue, 27 Aug 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746111; cv=none; b=k4NK51SXoEMXJYJyEdg3yN43Sma9vNsDkkSCw4l8icR7XSG/iV6SciB3S0ToFE0zfSri/AQF0wYsVg1uVtbAuamRoM+SVIeGZOLPcs7108xhH2fnlxlaZ9F1LS11pJ5ngw/amkC37+j2XOU7qzAiO0tzkp9M1pDsmVnWZI2ccGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746111; c=relaxed/simple;
	bh=gTFTfF6n925J8myKa6tcmyHBgVTz3ksgT5RIHT1Cu84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HazDfsrbZ/sTet9hlm7j2kV4SPBBpOaat3bXJR+jHW1C/qLVMwheJzNLSu8Bp7m4zML/7d7RUsbq8bZ6sv08TFTcitu28hPs9DOAAwH4S0OrP3zEUBPqT/QcUyajf72AMvpziY6XXDTPbGBTMR1nvElasy6WkWJPzQNVIUpE5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.Z3WL9h-_1724745762)
          by smtp.aliyun-inc.com;
          Tue, 27 Aug 2024 16:02:44 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V9 1/2] dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
Date: Tue, 27 Aug 2024 08:02:28 +0000
Message-ID: <20240827080229.1431784-2-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240827080229.1431784-1-wangshuaijie@awinic.com>
References: <20240827080229.1431784-1-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shuaijie wang <wangshuaijie@awinic.com>

Add device tree bindings for aw96103/aw96105 proximity sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
---
 .../iio/proximity/awinic,aw96103.yaml         | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
new file mode 100644
index 000000000000..7a83ceced11c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/awinic,aw96103.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic's AW96103 capacitive proximity sensor and similar
+
+maintainers:
+  - Wang Shuaijie <wangshuaijie@awinic.com>
+
+description: |
+  Awinic's AW96103/AW96105 proximity sensor.
+  The specific absorption rate (SAR) is a metric that measures
+  the degree of absorption of electromagnetic radiation emitted by
+  wireless devices, such as mobile phones and tablets, by human tissue.
+  In mobile phone applications, the proximity sensor is primarily
+  used to detect the proximity of the human body to the phone. When the
+  phone approaches the human body, it will actively reduce the transmit
+  power of the antenna to keep the SAR within a safe range. Therefore,
+  we also refer to the proximity sensor as a SAR sensor.
+
+properties:
+  compatible:
+    enum:
+      - awinic,aw96103
+      - awinic,aw96105
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Generated by the device to announce that a close/far
+      proximity event has happened.
+    maxItems: 1
+
+  vcc-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        proximity@12 {
+            compatible = "awinic,aw96103";
+            reg = <0x12>;
+            interrupt-parent = <&gpio>;
+            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+            vcc-supply = <&pp1800_prox>;
+        };
+    };
-- 
2.45.1


