Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2859C56B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Aug 2022 19:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbiHVRuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Aug 2022 13:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiHVRu3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2022 13:50:29 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31243334;
        Mon, 22 Aug 2022 10:50:25 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 9D2385FD08;
        Mon, 22 Aug 2022 20:50:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1661190623;
        bh=Bbi+SLMOoMKYhDWFHxpCLS4LEv2765hs3myRdLHQvxg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=UgsOE/O8nCNLPzV43cidnHc26K96WwDpVFoAruLcWk4ryJQCsv/nVWcDl7B5mQZ5K
         +vH19qmZJWv+EWgGvlZJGIxqegF7+Kr3M1wl04icAXHIAjEUdhR6aMpZ2HxsfuZ4r5
         2VEn8JDq1qOz9fLd2HFlysQiheeT4Us1i93msWn2bZo2YiLPswZyKdMw47BjRta0N6
         bMEru++h2EXjan8t2Ag52FcJhCTHUr9n6/6vR+YL7xykSpK6ApmpKpmRyUCPYFVSHL
         IB6F5yNLx9+uEXd3b2NQ0t+zqDtIb3LWD/JsfKE3FyIgW5yCCPgrL+dBN/ZMzpY0q/
         4wfu5pt1BeG3Q==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 22 Aug 2022 20:50:23 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 4/4] dt-bindings: iio: accel: add dt-binding schema for
 msa311 accel driver
Thread-Topic: [PATCH v7 4/4] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Thread-Index: AQHYtk+F13PQfMP5o0WfLzEsST84kA==
Date:   Mon, 22 Aug 2022 17:49:26 +0000
Message-ID: <20220822175011.2886-5-ddrokosov@sberdevices.ru>
References: <20220822175011.2886-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220822175011.2886-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/22 15:25:00 #20153291
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce devicetree binding json-schema for MSA311 tri-axial,
low-g accelerometer driver.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/accel/memsensing,msa311.yaml | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,=
msa311.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.=
yaml b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
new file mode 100644
index 000000000000..23528dcaa073
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MEMSensing digital 3-Axis accelerometer
+
+maintainers:
+  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
+
+description: |
+  MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
+  sensitivity consumer applications. It has dynamical user selectable full
+  scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurement=
s
+  with output data rates from 1Hz to 1000Hz.
+  Datasheet can be found at following URL
+  https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
+
+properties:
+  compatible:
+    const: memsensing,msa311
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
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
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        accelerometer@62 {
+            compatible =3D "memsensing,msa311";
+            reg =3D <0x62>;
+            interrupt-parent =3D <&gpio_intc>;
+            interrupts =3D <29 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply =3D <&vcc_5v>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 010e7d854bf7..4b76052e81cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12996,6 +12996,7 @@ MEMSENSING MICROSYSTEMS MSA311 DRIVER
 M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
 F:	drivers/iio/accel/msa311.c
=20
 MEN A21 WATCHDOG DRIVER
--=20
2.36.0
