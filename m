Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C6522FB2
	for <lists+linux-iio@lfdr.de>; Wed, 11 May 2022 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiEKJn4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiEKJmN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 05:42:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000DFB7F0;
        Wed, 11 May 2022 02:41:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 60F9E1F4411E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652262082;
        bh=efQV6wOQ/+4sLk2YyItzck+550O5spxUnUdwhl8aHLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz8pEFlCI2uILd21k+6Mc+/GVk3PUXTQ2f6u/3yc25pGdeCpU1XKJ2tMMbA0UBZuR
         F97jAu3ihGkCNx+ohIRsTEFB5WF514XVKu4rS3XEHslzQzDXjH/r8fg0gcHNde72eC
         c8LKgUbOZTEAt9ZNxMdOUI9I+rspx9bihUhsqeKRRUvKhF5CIzgTBinGhUXpkf01BY
         fgxBqABbd8i8iL8EAausTb65T5HmTTsJVS8xnZtzyQ/8Hedfgwl60hvlN+Gp9tBUxk
         2R4kegYykdHI/q2f+zfBmqnh2Onymiwjlqf9winN4T0v0hDLGMS2KAZJ8AcqSw8vA0
         IIDtZOMaeK+PA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v4 2/3] dt-bindings: Document ltrf216a light sensor bindings
Date:   Wed, 11 May 2022 15:10:23 +0530
Message-Id: <20220511094024.175994-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511094024.175994-1-shreeya.patel@collabora.com>
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree bindings for ltrf216a ambient light sensor.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v3
  - Fix indentation in the example section

Changes in v2
  - Take over the maintainership for the bindings
  - Add interrupt and power supply property in DT bindings


 .../bindings/iio/light/liteon,ltrf216a.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
new file mode 100644
index 000000000000..1389639cd7fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
@@ -0,0 +1,51 @@
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
+    oneOf:
+      - const: liteon,ltrf216a
+      - const: ltr,ltrf216a
+        deprecated: true
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

