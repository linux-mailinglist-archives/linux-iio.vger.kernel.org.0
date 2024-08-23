Return-Path: <linux-iio+bounces-8702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49695C9A3
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7151C236FE
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6807F185B72;
	Fri, 23 Aug 2024 09:50:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-28.us.a.mail.aliyun.com (out198-28.us.a.mail.aliyun.com [47.90.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B7184521;
	Fri, 23 Aug 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406624; cv=none; b=qN7h5oQ0u7nmy1FmGQ8k/WwwDftEm6J733MdWSYEh+eQzXRg4LdogaIFEHSGOA+w9svGn19bENN3JUNKRFbM9ATDsey49TIiXoRIgyWuhoZiwxfsQ2Vyi5AQLa2SGDEzW4PkDMmgWtbRu7LR50nDFLdrTgNm4FqeK3gjhWzy/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406624; c=relaxed/simple;
	bh=gTFTfF6n925J8myKa6tcmyHBgVTz3ksgT5RIHT1Cu84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkCPPsS8FVx2LE5lKHr5KfKBo+9OTan++9fCMMteim6OcfZQTsE+lW7dT8q73/EN/E3GHNe8fNP52iFlnCRYxflclQg6NSYMcD6BjjnFNblvuyd/08yrVi9m98ZGJK4IH8eplWy4jATGpDQag8haVBDDBzJ6VmFQqprVF1e+3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.Z.nW3Ir_1724406598)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 17:50:00 +0800
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
Subject: [PATCH V8 1/2] dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
Date: Fri, 23 Aug 2024 09:49:45 +0000
Message-ID: <20240823094947.3511730-2-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240823094947.3511730-1-wangshuaijie@awinic.com>
References: <20240823094947.3511730-1-wangshuaijie@awinic.com>
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


