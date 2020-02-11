Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E438F159976
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 20:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgBKTM5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 14:12:57 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:53672 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgBKTM5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 14:12:57 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id DFA4525192;
        Tue, 11 Feb 2020 20:12:54 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/7] dt-bindings: iio: light: add support for Dyna-Image AL3010
Date:   Tue, 11 Feb 2020 20:11:56 +0100
Message-Id: <20200211191201.1049902-3-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211191201.1049902-1-david@ixit.cz>
References: <20200211191201.1049902-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
provides a multiple gain function with linear response over a dynamic
range 1216/4863/19452/77806.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v5
 - drop requirement on interrups and vdd-supply
 - s/al3010@1c/light-sensor@1c/
 - dual license also under BSD

 .../devicetree/bindings/iio/light/al3010.yaml | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/al3010.yaml b/Documentation/devicetree/bindings/iio/light/al3010.yaml
new file mode 100644
index 000000000000..fdd1e5fa9c74
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/al3010.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/al3010.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dyna-Image AL3010 sensor
+
+maintainers:
+  - David Heidelberg <david@ixit.cz>
+
+properties:
+  compatible:
+    const: dynaimage,al3010
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@1c {
+            compatible = "dynaimage,al3010";
+            reg = <0x1c>;
+            vdd-supply = <&vdd_reg>;
+            interrupts = <0 99 4>;
+        };
+    };
-- 
2.25.0

