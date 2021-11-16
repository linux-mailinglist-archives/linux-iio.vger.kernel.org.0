Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24072453694
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 17:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhKPQCa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbhKPQCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 11:02:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B931CC061767;
        Tue, 16 Nov 2021 07:59:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b12so38584424wrh.4;
        Tue, 16 Nov 2021 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9naSO5r8tQZJvBK4TMPDYz6tlDwHC4XzxH7Ok+hs3N0=;
        b=im56I/I3rNGeFIuG/hbOWptU7uBt56fr502x72sNSv9QV1KWjvTqVtyhDwXHezl5Uc
         i0oluNPhwgGg7xdlucKDQJTdnqjFCBGZm93PZm9/VkOLIeg9rs/Lmu1SOVcsFqpD03fz
         6l73AUMNradKV2xf8hfdZ56UsIqlMvci8ZE444tVeQD28GBi2ALerXudrrmTZnYWlnbM
         fI8qKezzwjI26GRuQqlG74SewAast6MxAsHo/p3DkUJpv1nPl4zEY/5a3wRtnDuUHsoC
         YP3AwY4zKD6Xdjg5Qu+T9E6arkiKCsW5pQwz9cBbyzy+uGcJeiOqPg+kClGzwL3z6aCl
         Xbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9naSO5r8tQZJvBK4TMPDYz6tlDwHC4XzxH7Ok+hs3N0=;
        b=OcXRwP9V0yXBI8aatB2opdz5FQre1iKAkd6aNV2MKh5NRcV5uEB9L9/9noeUgaJ5si
         vpFmCAwJ9ObtMenyv3UCBhP68GAwGqklfNkfR48uaoBiZMtICvJLAOAGPC7EwDdBDbR+
         syb+uv+y8KQmg4OvFvz4z8CvXHevDbaOVceCuLWojfbfyCXopXotlRFBCFvcLPGOSEZ5
         lSJFqfAFDo/9rWYIN4ujXf4OBVDxrRyqMaGAavBDft6gndgKoK0KDyT/ur9on4XrP6RN
         ozvUEua0NfXPF85N/Bvy8pQRt5+wBPSSApETwiOaS9zG6wI64QNzeeLUQMqJAGVm9XZM
         lCCA==
X-Gm-Message-State: AOAM530HZq5MzFsTBPJKaoh+MdN3wTe+24BO55FPsSrJF3K3POfx2WuM
        kjNsMuAo8bmLcpnz8G5sm1Y=
X-Google-Smtp-Source: ABdhPJxxbHh6aw+ynme2nbX81ydqgm8JRSXnAUANc3S0WflysKuwlLlXTvqS8npcaPMd6OcCQUSxgw==
X-Received: by 2002:adf:e810:: with SMTP id o16mr10725300wrm.359.1637078359314;
        Tue, 16 Nov 2021 07:59:19 -0800 (PST)
Received: from localhost.localdomain ([87.75.40.14])
        by smtp.googlemail.com with ESMTPSA id g124sm2327650wme.28.2021.11.16.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:59:19 -0800 (PST)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Iain Hunter <drhunter95@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Add binding for IIO ADS1018
Date:   Tue, 16 Nov 2021 15:58:58 +0000
Message-Id: <20211116155917.304294-1-drhunter95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v2 has me as suggested maintainer per Daniel's feedback.

Signed-off-by: Iain Hunter <drhunter95@gmail.com>
---
 .../bindings/iio/adc/ti,ads1018.yaml          | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
new file mode 100644
index 000000000000..bd7421f882a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1015.yaml#
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

