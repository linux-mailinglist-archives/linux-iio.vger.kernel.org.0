Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE7854CA4F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348258AbiFONw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 09:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348783AbiFONwR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 09:52:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7810B42ECD;
        Wed, 15 Jun 2022 06:52:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:3153:7fbd:8a7b:29b6:89fb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95C9D6601701;
        Wed, 15 Jun 2022 14:52:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655301131;
        bh=QUTXABH3CkTe9Tc4dfSRbwc2hLqrKcMp56oypcCi9Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRFg5WJ6AKKP3ngACoj3B7mOmiWGZuKDNHChMnqiVw7RjWzg4xkp/neHxJmRCqAET
         M00xA/+9bdpThcupXpEmrb7/QDsXbE+wg0AvOSlmFCgfUtTSPjKqpkLmbrKuClcMLG
         9s0Jh4fV9qVJHHDojtEgWtSq+S2k2yjIY/BwApP+VrdT4Lu4yqMn5hFo8P6UZtN9t9
         By8FYoZn5oIZ/5JNv4DcfhSJnz70Rmw99g4ny6xJGr+vxiG/15nD8C5sXAMWymDMSV
         exg70nvEGaIscHtM41To7xB9XtJEJiXbNBVIiqYSU3LAGERApsJRYZZUr5VBK5/pIr
         oBGjFc7fcgiGg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v6 1/2] dt-bindings: Document ltrf216a light sensor bindings
Date:   Wed, 15 Jun 2022 19:21:29 +0530
Message-Id: <20220615135130.227236-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615135130.227236-1-shreeya.patel@collabora.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree bindings for ltrf216a ambient light sensor.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v5
  - Remove deprecated string 'ltr' from the bindings.

Changes in v3
  - Fix indentation in the example section

Changes in v2
  - Take over the maintainership for the bindings
  - Add interrupt and power supply property in DT bindings

 .../bindings/iio/light/liteon,ltrf216a.yaml   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
new file mode 100644
index 000000000000..f256ff2e744c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LTRF216A Ambient Light Sensor
+
+maintainers:
+  - Shreeya Patel <shreeya.patel@collabora.com>
+
+description:
+  Ambient light sensing with an i2c interface.
+
+properties:
+  compatible:
+    const:
+      - liteon,ltrf216a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
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
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@53 {
+            compatible = "liteon,ltrf216a";
+            reg = <0x53>;
+            vdd-supply = <&vdd_regulator>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
-- 
2.30.2

