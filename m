Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B531D6C8D
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 21:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgEQTtm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 15:49:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57993 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgEQTtl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 15:49:41 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 972F31BF206;
        Sun, 17 May 2020 19:49:36 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 6/7] dt-bindings: input: Add docs for ADC driven joystick.
Date:   Sun, 17 May 2020 21:49:03 +0200
Message-Id: <20200517194904.34758-6-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517194904.34758-1-contact@artur-rojek.eu>
References: <20200517194904.34758-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for the adc-joystick driver, used to provide support
for joysticks connected over ADC.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

 Changes:

 v2: - Add `reg` property to axis subnode in order to enumerate the axes,
     - rename `linux,abs-code` property to `linux,code`,
     - drop `linux,` prefix from the remaining properties of axis subnode

 v3: no change

 v4: - remove "bindings" from the unique identifier string,
     - replace `|` with `>` for all description properties,
     - specify the number of items for `io-channels`,
     - correct the regex pattern of `axis` property,
     - specify the value range of `reg` property for each axis,
     - put `abs-range` properties under `allOf` 

 v5: add `a-f` to the regex pattern of `axis` property

 v6-v7: no change

 .../bindings/input/adc-joystick.yaml          | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml

diff --git a/Documentation/devicetree/bindings/input/adc-joystick.yaml b/Documentation/devicetree/bindings/input/adc-joystick.yaml
new file mode 100644
index 000000000000..054406bbd22b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/adc-joystick.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019-2020 Artur Rojek
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/input/adc-joystick.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ADC attached joystick
+
+maintainers:
+  - Artur Rojek <contact@artur-rojek.eu>
+
+description: >
+  Bindings for joystick devices connected to ADC controllers supporting
+  the Industrial I/O subsystem.
+
+properties:
+  compatible:
+    const: adc-joystick
+
+  io-channels:
+    minItems: 1
+    maxItems: 1024
+    description: >
+      List of phandle and IIO specifier pairs.
+      Each pair defines one ADC channel to which a joystick axis is connected.
+      See Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - io-channels
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+patternProperties:
+  "^axis@[0-9a-f]+$":
+    type: object
+    description: >
+      Represents a joystick axis bound to the given ADC channel.
+      For each entry in the io-channels list, one axis subnode with a matching
+      reg property must be specified.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1023
+        description: Index of an io-channels list entry bound to this axis.
+
+      linux,code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: EV_ABS specific event code generated by the axis.
+
+      abs-range:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+          - items:
+              - description: minimum value
+              - description: maximum value
+        description: >
+          Minimum and maximum values produced by the axis.
+          For an ABS_X axis this will be the left-most and right-most
+          inclination of the joystick. If min > max, it is left to userspace to
+          treat the axis as inverted.
+          This property is interpreted as two signed 32 bit values.
+
+      abs-fuzz:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: >
+          Amount of noise in the input value.
+          Omitting this property indicates the axis is precise.
+
+      abs-flat:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: >
+          Axial "deadzone", or area around the center position, where the axis
+          is considered to be at rest.
+          Omitting this property indicates the axis always returns to exactly
+          the center position.
+
+    required:
+      - reg
+      - linux,code
+      - abs-range
+
+    additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adc/ingenic,adc.h>
+    #include <dt-bindings/input/input.h>
+
+    joystick: adc-joystick {
+      compatible = "adc-joystick";
+      io-channels = <&adc INGENIC_ADC_TOUCH_XP>,
+                    <&adc INGENIC_ADC_TOUCH_YP>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      axis@0 {
+              reg = <0>;
+              linux,code = <ABS_X>;
+              abs-range = <3300 0>;
+              abs-fuzz = <4>;
+              abs-flat = <200>;
+      };
+      axis@1 {
+              reg = <1>;
+              linux,code = <ABS_Y>;
+              abs-range = <0 3300>;
+              abs-fuzz = <4>;
+              abs-flat = <200>;
+      };
+    };
-- 
2.26.2

