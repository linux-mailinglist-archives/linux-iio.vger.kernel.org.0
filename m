Return-Path: <linux-iio+bounces-7531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2292F99F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 13:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33C71C22056
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262015EFC4;
	Fri, 12 Jul 2024 11:37:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1141422D0;
	Fri, 12 Jul 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720784262; cv=none; b=R6iM1aKuo5OFtIuh73i/0RHmJTfdNrjKcZ5nvmpNa+aPR18Dp/wmikXQTJwLPSl1KHRH5ER9YfpTxJaNgmOyX2JCghXXJ+7iGA/pkiK3VugKJ5cljtn0KC7K3dZ4MikRqvb6nLw2DOey/qF3+Y9i/5Bk8fxezgsWB33Q373gkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720784262; c=relaxed/simple;
	bh=kGkxw6mKbQlTWnL7jHOxa8Fs6bpUivRXuJuxan8ou1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tI+299Uu3MiFvldUsBEjfLvBhpiVKnUWuXxY46EzO9aABn1LT/4wtFsTN3XHKgurKB/H6wfqwAWAxHzkLg2hqSU/piCK3OzdJ8NzFqf8Qzt2IBfFxpsZkLpEAp1+OymEnkUz1iOyxkFv2ng4tCpWuo+XB2v3HOdgVQGNfoShboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436264|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.455054-0.000424186-0.544521;FP=7453663783424890238|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033070021168;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.YOU1nyH_1720783933;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YOU1nyH_1720783933)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 19:32:15 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	waqar.hameed@axis.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wangshuaijie@awinic.com,
	liweilei@awinic.com,
	kangjiajun@awinic.com
Subject: [PATCH V3 1/2] dt-bindings: iio: Add YAML to Awinic proximity sensor
Date: Fri, 12 Jul 2024 11:31:59 +0000
Message-ID: <20240712113200.2468249-2-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712113200.2468249-1-wangshuaijie@awinic.com>
References: <20240712113200.2468249-1-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: shuaijie wang <wangshuaijie@awinic.com>

Add the awinic,aw96xxx.yaml file to adapt to the awinic proximity sensor driver.
Addressing the issues raised in the previous version.
1. Add a description about the hardware device.
2. Remove inappropriate configuration items.
3. Modify the formatting issues.

Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
---
 .../iio/proximity/awinic,aw96xxx.yaml         | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
new file mode 100644
index 000000000000..459cb1644d3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/awinic,aw96xxx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic's AW96XXX capacitive proximity sensor
+
+maintainers:
+  - Shuaijie Wang <wangshuaijie@awinic.com>
+
+description: |
+  Awinic's AW96XXX proximity sensor.
+  The specific absorption rate (SAR) is a metric that measures
+  the degree of absorption of electromagnetic radiation emitted by wireless
+  devices, such as mobile phones and tablets, by human tissue.
+  In mobile phone applications, the proximity sensor is primarily used to detect
+  the proximity of the human body to the phone. When the phone approaches the human body,
+  it will actively reduce the transmit power of the antenna to keep the SAR within a safe
+  range. Therefore, we also refer to the proximity sensor as a SAR sensor.
+
+properties:
+  compatible:
+    enum:
+      - awinic,aw96103
+      - awinic,aw96105
+      - awinic,aw96303
+      - awinic,aw96305
+      - awinic,aw96308
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
+  awinic,sar-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Set the number of the SAR(Specific Absorption Rate) sensor.
+      It is set to 0 if one awinic sar chip is used.
+      If two awinic sar chips are used, awinic,sar-label in the first
+      awinic-sar should be set to 0 and awinic,sar-label in the second
+      awinic-sar should be set to 1.
+      In an application where a device utilizes multiple proximity sensors,
+      it is used to retrieve the names of the register configuration files
+      that the drivers need to load. For example: aw963xx_reg_0.bin/aw963xx_reg_1.bin
+
+  awinic,regulator-power-supply:
+    description:
+      Choose if you want to use a regulator to power the chip. Then the
+      vccX-supply has to be set.
+
+  vcc0-supply:
+    description:
+      Optional regulator for chip, 1.7V-3.6V.
+      If two awinic sar chips are used, the first regulator
+      should set the ID to vcc0-supply and the second regulator
+      should set the ID to vcc1-supply.
+
+  awinic,channel-use-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The mask of channels used.
+      Configure according to the specific chip channel used.
+      Bit[31:0] Each bit represents a channel.
+      If the customer uses ch0 and ch2, then channel_use_mask=<0x05>
+      For a 3-channel chip, the maximum value is 0x07;
+      For a 5-channel chip, the maximum value is 0x1F;
+      For a 8-channel chip, the maximum value is 0xFF;
+
+  awinic,monitor-esd:
+    type: boolean
+    description:
+      Choose if you want to monitor ESD.
+
+  awinic,pin-set-inter-pull-up:
+    type: boolean
+    description:
+      Choose if you want to set the interrupt pin to internal pull-up.
+
+  awinic,using-pm-ops:
+    type: boolean
+    description:
+      Choose if you want to change the chip mode on suppend and resume.
+
+  awinic,use-plug-cail:
+    type: boolean
+    description:
+      Choose If you want to perform calibration when plugging and unplugging the charger.
+
+  awinic,irq-mux:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [2, 5]
+    description:
+      You only need to set this configuration item if you are using AW96308 adn AW96305BFOR.
+      If CS2 is used as the interrupt pin, this item should be set to 2.
+      If CS5 is used as the interrupt pin, this item should be set to 5.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - awinic,sar-num
+  - awinic,channel-use-mask
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
+            compatible = "awinic,aw96308";
+            reg = <0x12>;
+            interrupt-parent = <&gpio>;
+            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+            awinic,sar-num = <0>;
+            awinic,channel-use-mask = <0xff>;
+            awinic,irq-mux = <2>;
+        };
+    };
-- 
2.45.1


