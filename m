Return-Path: <linux-iio+bounces-9136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE096BAE2
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E701C209B7
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC631D1749;
	Wed,  4 Sep 2024 11:36:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com [115.124.28.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21231CCB43;
	Wed,  4 Sep 2024 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449778; cv=none; b=IIhIBoT3+29IspO8FH0aUt6H637QoRr/OjawzzQ9yNqLtH68i3BihAL+93oyMkHr+YBG+yH02cSNEoyUtNZ6zDowzYnFHQ2sYk25WOF/188hWyZFoGwu/0F7+1GldrHPYIqKJvbaNtBIuAGYpZOqJgGfGTuhCSoVT6RMmJBuFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449778; c=relaxed/simple;
	bh=gTFTfF6n925J8myKa6tcmyHBgVTz3ksgT5RIHT1Cu84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0oElhPxp47HYlNz8VZ5ecWfUjDidGPQh9RZiVsHWdaixtDF/cKZDVgx5WD35jXcXeoS60fCdIM4+yn+jg27hDyEiRXCC3PlyvvQ3Rr1HTQuMWQeanRBRMQ4QDaNCvnjivIvUsk7HmOBKbAOdRdhfV4M3+c47eUFryb9HMJlGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.ZAven1w_1725449763)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 19:36:06 +0800
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
	linux-hardening@vger.kernel.org,
	andy.shevchenko@gmail.com
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V10 1/2] dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
Date: Wed,  4 Sep 2024 11:35:54 +0000
Message-ID: <20240904113555.1538635-2-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240904113555.1538635-1-wangshuaijie@awinic.com>
References: <20240904113555.1538635-1-wangshuaijie@awinic.com>
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


