Return-Path: <linux-iio+bounces-7877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8227293C181
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364E41F21B38
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0F199E94;
	Thu, 25 Jul 2024 12:13:46 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AE16D9C9;
	Thu, 25 Jul 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909626; cv=none; b=dg2SwOS4JnQyJP6D4IbTAXH/889f9xnX7+6cAhRJpAAEERxuqLjvNoodm/1lh8I23gil9F1WUmUr99vCpkGXCRTrEKXtHQDcZxV+3R0whM4rnHaFhyTeyJj2HBbxmauYraXLiKIpYbMPFRPpHJ0UNDtXxRLcz5LNLxuywGuDhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909626; c=relaxed/simple;
	bh=m5e9TIa4Rv+lGzA62+FY/shT+D+UUzwMmOQWuWnwWNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi1csD35WnlrvWXREE9fSLVDkqOJzl9J7KVannnDfBy+J5xQBAtsJPfzu4KSfVD4Mqh40CqZ7x3+2GLJFTx7GK0uedkqQt9Y329+Dx7JGYnq5KauqcAaZaTokosJgZ/sEdbXM5bfltelIs7hRH6GlGuzy+w/yev636T/6RlO5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0774214|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.235398-0.000975642-0.763626;FP=7422250752312972538|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032065106;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.YZXAPKu_1721909609;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YZXAPKu_1721909609)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 20:13:32 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	waqar.hameed@axis.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com
Subject: [PATCH V4 1/2] dt-bindings: iio: aw9610x: Add bindings for aw9610x sensor
Date: Thu, 25 Jul 2024 12:12:51 +0000
Message-ID: <20240725121252.865836-2-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240725121252.865836-1-wangshuaijie@awinic.com>
References: <20240725121252.865836-1-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shuaijie wang <wangshuaijie@awinic.com>

Add device tree bindings for aw9610x proximity sensor.

Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
---
 .../iio/proximity/awinic,aw9610x.yaml         | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml
new file mode 100644
index 000000000000..8071fd3f1fea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/awinic,aw9610x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic's AW9610X capacitive proximity sensor
+
+maintainers:
+  - Wang Shuaijie <wangshuaijie@awinic.com>
+
+description: |
+  Awinic's AW9610X proximity sensor.
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
+        };
+    };
-- 
2.45.1


