Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B84449BE8
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 19:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhKHSq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 13:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhKHSq1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 13:46:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF32C061570;
        Mon,  8 Nov 2021 10:43:42 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c4so28613049wrd.9;
        Mon, 08 Nov 2021 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AECqjXUOlQIaqVTgqXTbNrajr1LzTMHmuALf+lg3R0o=;
        b=HEX/q4WnveWKbxNvyzPSCFJKKoi9sWpgEg0Yf5lgt1FiS91N22e+hNgVeM6+hAH7fS
         ZGTT0I6UJpDeXMX9FPxGruV4NiKP6Whnfdf7uZvXBuYHs9Qzb4o0UOuRspAoVo1Q7vZ6
         81iP4Wkz5zhG2njPX8e+b2P4kk7N8ihsvznNXxeFicvrlqU4dbWZO0SgiRYm0ppBPaZb
         hEk4vQ8psY4DPVORi5okR3/pljAkR81fJuiU+1JcIbN2XwmIgdxEwALoYs1Lpe/tKI8A
         hkJIZzY5W3t8j1CsTcpDiihmPbxL4INEeglwJBoBc8/EnblsI1lmMX6RLWE1Uf24QDhF
         HL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AECqjXUOlQIaqVTgqXTbNrajr1LzTMHmuALf+lg3R0o=;
        b=RhbwFu0Kdwsg9IyN1mWTZmYKhYm66UhChZz4/LYvMfsakv6yibsQDxhtABJ4F4i+4w
         bfhTgJZLcPFpx8kxf9Why3xmoPYzO/WoeHtHKw1JGt3S4OoEWYvexJCnXmohs2n92AUI
         F7KKK+jW99g2wb8uDTWIHoAqLComnFICOuunh/pjTm6NEjpw0BKjdpU0YjUTsWfY8R3u
         Dk7e2D7mcF1LHkInzyfTxcU4ORev9Z5dAOAqeIGAuD8Xsn366mh+EXDAFFh0Nmx+zkq1
         H6r3rebUn7N8BMd70A51uypJctzsDHNo8uL8PuwSFE/dGz9QxORwTEQqDBFVito/wdYP
         pPlQ==
X-Gm-Message-State: AOAM530r3rzCvz22WsqwL53WVE3YNXT1csOgKF0//DwYiMyWO5Kr1j/T
        q/hJZAOzGX0+YvfmQxSutZ1gmj3uh2g=
X-Google-Smtp-Source: ABdhPJzLelMamgBP6pCSNNSaXpk9TSUYIsKGpui9MjUinYZlecfNcuzecMBThLhaVU6At4zTjnXIKA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr1597325wrm.280.1636397021176;
        Mon, 08 Nov 2021 10:43:41 -0800 (PST)
Received: from localhost.localdomain ([87.74.52.248])
        by smtp.googlemail.com with ESMTPSA id y12sm17671862wrn.73.2021.11.08.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:43:40 -0800 (PST)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Iain Hunter <drhunter95@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] add binding for iio adc driver for TI ADS1018
Date:   Mon,  8 Nov 2021 18:43:09 +0000
Message-Id: <20211108184327.439460-1-drhunter95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Add a new binding for new IIO ADS1018 driver.

Signed-off-by: Iain Hunter <drhunter95@gmail.com>
---
 .../bindings/iio/adc/ti,ads1018.yaml          | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
new file mode 100644
index 000000000000..ba0fdfba2c45
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1018 4 channel SPI analog to digital converter
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+description: |
+  Datasheet at: https://www.ti.com/lit/gpn/ads1018
+  Supports both single ended and differential channels.
+
+properties:
+  compatible:
+    const: ti,ads1018
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@[0-7]+$":
+    type: object
+    description:
+      Child nodes needed for each channel that the platform uses.
+
+    properties:
+      reg:
+        description: |
+          0: Voltage over AIN0 and AIN1.
+          1: Voltage over AIN0 and AIN3.
+          2: Voltage over AIN1 and AIN3.
+          3: Voltage over AIN2 and AIN3.
+          4: Voltage over AIN0 and GND.
+          5: Voltage over AIN1 and GND.
+          6: Voltage over AIN2 and GND.
+          7: Voltage over AIN3 and GND.
+        items:
+          - minimum: 0
+            maximum: 7
+
+      ti,gain:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 5
+        description: |
+          pga is the programmable gain amplifier (values are full scale)
+          0: +/- 6.144 V
+          1: +/- 4.096 V
+          2: +/- 2.048 V (default)
+          3: +/- 1.024 V
+          4: +/- 0.512 V
+          5: +/- 0.256 V
+
+      ti,datarate:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 6
+        description: |
+          Data acquisition rate in samples per second
+          0: 128
+          1: 250
+          2: 490
+          3: 920
+          4: 1600 (default)
+          5: 2400
+          6: 3300
+
+    required:
+      - reg
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1 {
+            compatible = "ti,ads1018";
+            reg = <0x1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@4 {
+              reg = <4>;
+              ti,gain = <3>;
+              ti,datarate = <5>;
+            };
+        };
+    };
+...
-- 
2.25.1

