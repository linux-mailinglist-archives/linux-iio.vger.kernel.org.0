Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68910149B3E
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jan 2020 16:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAZPFz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jan 2020 10:05:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41585 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZPFz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jan 2020 10:05:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so4401260lfp.8
        for <linux-iio@vger.kernel.org>; Sun, 26 Jan 2020 07:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RHTE3nUb5dfPevjsWD1iLezxvXfZXjeHjK9RsRGLMU=;
        b=nDfWJs/DHHcdQ78FJWwCKFIzFckSaf1JdgHXG5c7veYmpNleLMzAsxp/rn7tJm2ie0
         jPy9ku4xKj2itbbOvHvrL3Eals8SMZid0kjvrKqqmWta8yrp0gqYHJLpJfHAlXKz2wLZ
         jE/qtnjDfClb8o7nXGHdDlA/TrRkaWJTRIlHQkXRlIFN0M717I91I80niUr2dSNp6xOr
         2QhncGWKA5zlg/gnzjxSvHB7gHFxSSOnSywbbcNdRa8fC1aBEV/KC13Vqjnc4AZUFjeK
         XKQCEqBny+RWYvLEhDphLTrh2uJSpfEP+eFO3/67apS44GOLjlHd3pCRdPArvjFVCLpq
         icPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RHTE3nUb5dfPevjsWD1iLezxvXfZXjeHjK9RsRGLMU=;
        b=IiX6i64str3vc/UDYZTy4p0BrwuuOpMYxi7I+jkSmOjTQXWNoK4K10zWOxPmnibdhW
         1OJwCYRvvDtkWdcjUdpBZEgp5wKyZrSpAeBlWDHfCXo5NmGRMdbiObVwkv5f5BhAYBpn
         txReMIx2EEz6rysI9MquY0ZPFN3Wu8vStAEASqtGLLlgCCbbGnw+QfBnO4AvuSfFzOcr
         80s+gSH7J/V62NOtV9NT6LWUBkQrrUMq0cfMiaDHVuC+zCxFYQ3tr9qOuh8Wz6ZonzPC
         jlqQrOGW+VvXimNyXOSUvY5aw6lVqJijLYw6Qyk7VEZuHXhvy8f2R7ji6a6SjRg7tHQu
         rYmg==
X-Gm-Message-State: APjAAAU7TLh85E+9jH+p2PgH67ITM5OhpyqMFuPWfaGRwCb1pPdFvjL3
        YUZZl3DwTzgxj1ff29WAPynOOQ==
X-Google-Smtp-Source: APXvYqxg6PLPDQ9mjIyqvHGAgo2AyQkQ7ZmShfE1zgLEnjgc2RLw7tCmB4qFkRsL6xY6Kn/2LN7/xA==
X-Received: by 2002:a19:3f51:: with SMTP id m78mr5726542lfa.70.1580051152251;
        Sun, 26 Jan 2020 07:05:52 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id l12sm6635870lji.52.2020.01.26.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 07:05:51 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2 v6] iio: light: Add DT bindings for GP2AP002
Date:   Sun, 26 Jan 2020 16:05:47 +0100
Message-Id: <20200126150548.9168-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds device tree bindings for the GP2AP002 light
and proximity sensor.

As with other early proximity sensors (~2010) the light
sensor and proximity sensors were combined into a single
component.

Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Minkyu Kang <mk7.kang@samsung.com>
Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: Jonathan Bakker <xc-racer2@live.ca>
Cc: Oskar Andero <oskar.andero@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Resending with v6 of the driver.
ChangeLog v4->v5:
- Collected Rob's Reviewed-by tag.
ChangeLog v3->v4:
- Resend with the changes in the main patch.
ChangeLog v1->v3:
- Drop the maxitems on the supplies, it is already 1
- Drop quotes around "alsout"
- Limit the sharp hysteresis to 8 bits as it should be
- Use /bits/ 8 in the example so it is correct
---
 .../bindings/iio/light/sharp,gp2ap002.yaml    | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
new file mode 100644
index 000000000000..12aa16f24772
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/sharp,gp2ap002.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp GP2AP002A00F and GP2AP002S00F proximity and ambient light sensors
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  Proximity and ambient light sensor with IR LED for the proximity
+  sensing and an analog output for light intensity. The ambient light
+  sensor output is not available on the GP2AP002S00F variant.
+
+properties:
+  compatible:
+    enum:
+      - sharp,gp2ap002a00f
+      - sharp,gp2ap002s00f
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: an interrupt for proximity, usually a GPIO line
+
+  vdd-supply:
+    description: VDD power supply a phandle to a regulator
+
+  vio-supply:
+    description: VIO power supply a phandle to a regulator
+
+  io-channels:
+    maxItems: 1
+    description: ALSOUT ADC channel to read the ambient light
+
+  io-channel-names:
+    const: alsout
+
+  sharp,proximity-far-hysteresis:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      Hysteresis setting for "far" object detection, this setting is
+      device-unique and adjust the optical setting for proximity detection
+      of a "far away" object in front of the sensor.
+
+  sharp,proximity-close-hysteresis:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: |
+      Hysteresis setting for "close" object detection, this setting is
+      device-unique and adjust the optical setting for proximity detection
+      of a "close" object in front of the sensor.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - sharp,proximity-far-hysteresis
+  - sharp,proximity-close-hysteresis
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      light-sensor@44 {
+        compatible = "sharp,gp2ap002a00f";
+        reg = <0x44>;
+        interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&vdd_regulator>;
+        vio-supply = <&vio_regulator>;
+        io-channels = <&adc_channel>;
+        io-channel-names = "alsout";
+        sharp,proximity-far-hysteresis = /bits/ 8 <0x2f>;
+        sharp,proximity-close-hysteresis = /bits/ 8 <0x0f>;
+      };
+    };
+
+...
-- 
2.21.1

