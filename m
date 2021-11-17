Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A844543FC
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 10:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhKQJot (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 04:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhKQJol (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 04:44:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C1C06121D;
        Wed, 17 Nov 2021 01:41:28 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4240124wml.1;
        Wed, 17 Nov 2021 01:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpV9K7y9xbwVeUZlIBpQM+FwHcFAhfT6/Op5MFxhjjE=;
        b=Ah+gaxAKVXxQYTpyery0Fvw4CYxf+yrRdZeHrkWPgxVQ3m6zCLe5kaXtHHC8uSiVsA
         P59ptQ5LGo7lZwnwZpUM+rwU/OF4VTArUWuNHxVMk2wRfHCzVSZMg3DD7bxrRtSkMdWa
         hCd9iFKkiYHzc5E9oy2dJ3ZCIhsr/XOoiuJb3ioOlj+5Pfiz7WIfmBQvVYinFU6WXgo4
         c3ugHldx8ceRsa9oy7QMzo7Yf1rb+j0FZCH9MoUuAWYglkjDotQhuMYbzvHkb1AssgON
         1h8Aer7AZE4CpB9s+Sgmxtk7A5NCvTctfkl1Q3rb3Qo3Pwk1whDdn/B0OX0F2mm73ry8
         zTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpV9K7y9xbwVeUZlIBpQM+FwHcFAhfT6/Op5MFxhjjE=;
        b=x/oWYu5lxQISvjZhp9F70bGHdgOoRHLeE7wuXwq5G0gAXjrYl0Rte+qjMYXMfrD3bz
         lwh8Gpu5ug4YlAFXXWXhL+nBxFpFTPwhO4IIBUWQbhJ3u7n6pC1s8h9Kxyd9brLkNWGx
         gNJy4j9nFp8D1ACPyMYSsFO0720UFHYuL10tToHHGdl8MDKxxZcYtKt1voEjov0gEgUY
         kTzDq++OkPozUzAJdHZI5nTF2Xm7iYresqXF42GqDABS9P34HrxnMxdz//aOZsFmvzJJ
         OqmblH5zP45K/c8je3q9ZpQrmY+6ZB57Xs9yeeiinrEqrdMoiUQqVw1Bk9E8/2Qxt+2S
         BF0g==
X-Gm-Message-State: AOAM533vWemUKGEEDy8CGp5NKXxPyxCmR6qhsuUreB/voAmPiCy5CP+c
        P1xE9O+hjkbpgLzQAiX0ntk=
X-Google-Smtp-Source: ABdhPJy6bQUEjNtHPqm4RaCwaeXGt2ZQXoRtN0pm6epuTa7oGmyQdGgpt8AZfNxEqhMsjay91G4vuA==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr15728874wmh.60.1637142087270;
        Wed, 17 Nov 2021 01:41:27 -0800 (PST)
Received: from localhost.localdomain ([87.75.40.14])
        by smtp.googlemail.com with ESMTPSA id l26sm5694314wms.15.2021.11.17.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:41:26 -0800 (PST)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Iain Hunter <drhunter95@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Add binding for IIO ADS1018
Date:   Wed, 17 Nov 2021 09:40:48 +0000
Message-Id: <20211117094109.402397-1-drhunter95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v3 has me as suggested maintainer per Daniel's feedback and corrected id

Signed-off-by: Iain Hunter <drhunter95@gmail.com>
---
 .../bindings/iio/adc/ti,ads1018.yaml          | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
new file mode 100644
index 000000000000..14345bfb71dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1018 4 channel I2C analog to digital converter
+
+maintainers:
+  - Iain Hunter <iain@hunterembedded.co.uk>
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

