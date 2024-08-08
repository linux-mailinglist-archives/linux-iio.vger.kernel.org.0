Return-Path: <linux-iio+bounces-8326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FE894BB2B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842D41F21BD5
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D018A940;
	Thu,  8 Aug 2024 10:34:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AC18A926;
	Thu,  8 Aug 2024 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113272; cv=none; b=kYKYJfaqS74AhYB1q1DL6Dlumq6KElLSWLsBHnNfJWA4u9+c/sYM5ilfspJWQc0qMTVbvnRPm5EfDinEOpYpTKqlogKPkyFZK7ru0e3Vc9oveYbImw9B9y5Yc5bVPynZQQmrNeyMrExwjxJTvsPoOY8DgAFRctfU8M6iuiv4aIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113272; c=relaxed/simple;
	bh=u++nyEl/jtE/VyZmRVjuxJ9+xJadg2M6a3jX/APHSNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcpBOefEi0dBMiOnmRw4Wlvt5/E0Y6BC+LfaFIf2NUKtDiOqanWl2xNpr1EttKPA9Zwr+QDYqQ5M/oDjsQLPlVY7iMsad+l51wrZLLYcSsYSVrm42E+yksamVPWk6HWj/gRhBqgqrWRWtYYSbD/Bkh5jp86MvJEVO8WJmmzlS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07756341|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.342594-0.000898024-0.656508;FP=8575172256919786746|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065106;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.YlkvC7t_1723112942;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YlkvC7t_1723112942)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 18:29:04 +0800
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
Subject: [PATCH V6 1/2] dt-bindings: iio: aw96103: Add bindings for aw96103/aw96105 sensor
Date: Thu,  8 Aug 2024 10:28:50 +0000
Message-ID: <20240808102851.4024025-2-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240808102851.4024025-1-wangshuaijie@awinic.com>
References: <20240808102851.4024025-1-wangshuaijie@awinic.com>
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
 .../iio/proximity/awinic,aw96103.yaml         | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
new file mode 100644
index 000000000000..54b5bc176d5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
@@ -0,0 +1,63 @@
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
+  vcc-supply:
+    description:
+      Optional regulator for chip, 1.7V-3.6V.
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


