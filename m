Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD053E02A6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhHDODo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 10:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbhHDODn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 10:03:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66406C0613D5;
        Wed,  4 Aug 2021 07:03:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c16so3083082plh.7;
        Wed, 04 Aug 2021 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkYno5k2Oj/w12pA+PO0ZF1OUj36pZFeWyQiTXky8BE=;
        b=XealMgmcRgizhdUBQjjsDYzxCy63fGfLMX5+r7ISKATetBwUCUBibfmParbXYwcX45
         w2vO4+sQQHDoGlddtB0Kib6qRQZYpB/ZM4JfY5G/6hFojSOSGgfQ7Ase3rO08Rm09sLh
         JP6XH0m7Z+viorg029SXksbXE0wV0c6FX3BLrXT6kq0swXpBpBhqtRAA9eeiOu0VxGwH
         VxQwSBanRdVxT3lgrV8z8bi4lnYE+wIK2S8CsJKoWIbJzEZV2UgvDtmToFcTKgyjAANb
         mi61KpzUnFk+jVdL8rhD88TOYCgNMutq7Rzu90B91Gl6TPNdymDc9exMp+AEMp2kdrDU
         y55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkYno5k2Oj/w12pA+PO0ZF1OUj36pZFeWyQiTXky8BE=;
        b=g73e5wBegwn37LHiD5pl6PdmSTkObrFzvl0O2c72DUzoFI+ewpHppNgxR9lQfBp6Dr
         bvkVB/umIv2aDdP9baaVCWwVge+K1KPH+uej6ZrmVZAErJzOjRP5zdON2a5QZMmnGZNH
         bzRk24UawihRxW6gdV6ruYEQokLKlGeSxlfKcS4+KMbGZq2mPwDBwS63aSoFfCuwZe3f
         FmANRkQ8XPRLKpt7wZzeJC9NryQopBpSOJYapPZNkK07VTWq7WSLZ8PydAorYNVehkFw
         RuviO4h2vhf/t0FevR83cK8/o5CcvzoxRjVrArnDZJNJUd0xIW5vkBkF85XfiyBg5u2T
         zQtQ==
X-Gm-Message-State: AOAM5301Vrz55Wb4eHAINooh6Vmx8F0Y9y5jSUcHD12/8b5xeg+h7liZ
        Yyyph/RYpC/acDkM6kpQ9vLHtKOnid6g4A==
X-Google-Smtp-Source: ABdhPJzb2RhgcbmCxsFaVUDxlav/rlG+eIfEzqIY9Dx8tamNSJka+Vfet8odztX8kTAGdSoo8yAItw==
X-Received: by 2002:a17:903:41c2:b029:12c:7ce7:aad7 with SMTP id u2-20020a17090341c2b029012c7ce7aad7mr1515292ple.43.1628085809910;
        Wed, 04 Aug 2021 07:03:29 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:20f:6a87:f508:aab5:2fa7:36da])
        by smtp.googlemail.com with ESMTPSA id z2sm4048408pgz.43.2021.08.04.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:03:28 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v8 1/3] dt-bindings: iio: accel: Add DT binding doc for ADXL355
Date:   Wed,  4 Aug 2021 19:33:07 +0530
Message-Id: <20210804140309.31468-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210804140309.31468-1-puranjay12@gmail.com>
References: <20210804140309.31468-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding document for ADXL355, a 3-Axis MEMS Accelerometer.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 .../bindings/iio/accel/adi,adxl355.yaml       | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
new file mode 100644
index 000000000..5da3fd5ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
+
+maintainers:
+  - Puranjay Mohan <puranjay12@gmail.com>
+
+description: |
+  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
+  both I2C & SPI interfaces
+    https://www.analog.com/en/products/adxl355.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl355
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    description: |
+      Type should be IRQ_TYPE_LEVEL_HIGH.
+      Three configurable interrupt lines exist.
+
+  interrupt-names:
+    description: Specify which interrupt line is in use.
+    items:
+      enum:
+        - INT1
+        - INT2
+        - DRDY
+    minItems: 1
+    maxItems: 3
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/gpio/gpio.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
+        i2c {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* Example for a I2C device node */
+                accelerometer@1d {
+                        compatible = "adi,adxl355";
+                        reg = <0x1d>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+                        interrupt-names = "DRDY";
+                };
+        };
+  - |
+        #include <dt-bindings/gpio/gpio.h>
+        #include <dt-bindings/interrupt-controller/irq.h>
+        spi {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                accelerometer@0 {
+                        compatible = "adi,adxl355";
+                        reg = <0>;
+                        spi-max-frequency = <1000000>;
+                        interrupt-parent = <&gpio>;
+                        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+                        interrupt-names = "DRDY";
+                };
+        };
-- 
2.30.1

