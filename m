Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66DB1385EB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2020 12:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgALLNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jan 2020 06:13:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39406 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732651AbgALLNs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jan 2020 06:13:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id l2so6847541lja.6
        for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2020 03:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lBXyzQei435C4TzmaHRwGhDla2uBHLmX41nbjZkSq8=;
        b=mH3A73cZfDv2+qpk/1a/sqnblMtq88TaTkdakE3nKsGgGDFDZzoQUH1pjR/M0twFHI
         +1GwzqzqZHpAmPbHu2OJcQACC+gsW+7aDqk7U1YdzHxQlo/OapT6ln9ZIjzmF5Y0LM6y
         F0LGa4i0AupkJqYnXmudxYbptnVS1yrEcEDBD7ht2uvdLUQghMpn3bFaQiVCSX7tcsoc
         yLRfpsYWdxqGZcU2NNKzZuJatupMygqErinwV4gCy7m/nfn7JuSeswVyY/qCZ9IT5zOe
         KXnRsxBbTFz9vH2Do1xFslcMR3wOz1dUUElj1GxAgodup67+Hu9VA6KDu5DZ2T0xZIYD
         srbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0lBXyzQei435C4TzmaHRwGhDla2uBHLmX41nbjZkSq8=;
        b=hgFmw8GB2RJsV2M/YZiOtKxD/rfkTwH9y7wfoDKTSqJ6RHtEzTykHVSMu7D70gwnia
         eStttA9DyaVOywkwMn3HEjyjj0JbitFYK89KrbsUxlatGZ8qIS9UWcHynhD5HYnYl2v4
         Cco4uz3rI3CiHGyKm3fjgylCPZT47e983ogbyK4aSeMzlt8oHvbjvOMmxUEIIedfEgfE
         2ZpPtbyViDaab+fHG28IYl4XKNnpyelM1rqK2lyh2JKZiXtlQo9XBsZlp/sUlxOxiOQL
         Tb5HxhY7ZbItL5jkVio3uF7LB+mwvmGnYwKlVT/BqWla8r5XVZFnzZyfOT/2NUWitrGg
         p99Q==
X-Gm-Message-State: APjAAAWtOvKzEwgFBzrUS+i2L5VdHg+qntOQ1kff8BCZmYejtSRMFgdE
        JU9Vqg+D+kkibQjQD1wX8WLd1g==
X-Google-Smtp-Source: APXvYqyxgKMi2Fm7zMCKS3ET+AjXq3JANMYh0URRm5aTB3P+YTJEOov0csj/+cW/HoF/odh0ezdSpA==
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr7696530ljm.58.1578827625064;
        Sun, 12 Jan 2020 03:13:45 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id i4sm4636723lji.0.2020.01.12.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 03:13:43 -0800 (PST)
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
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2 v4] iio: light: Add DT bindings for GP2AP002
Date:   Sun, 12 Jan 2020 12:13:40 +0100
Message-Id: <20200112111341.21388-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
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
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
2.21.0

