Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22752A1DD9
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 13:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKAM2n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 07:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgKAM2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 07:28:41 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386BC061A47
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 04:28:39 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y184so11828943lfa.12
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 04:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOXieuuEEbc116u9FS/tLUaOZv79e9gqeLS9/EKUpZ8=;
        b=g30qIXbRJL5C/nXIrSgCkN0N2zOTkxTPyQtoJgI/5Bs7rNmuiZHb3TRDXdbcU36lLt
         9RwLjV102npps2h+YPgU367k/Rn0pSGN7FMiiuHEf4cSBw81k9fLFCqeqxVz8nKCzz3r
         C+ykdFMM6CxcUhrSaD5g3DpUtdxESdL6I70DFTNScAk0sKExnQnd4Cu+ZqvpD3JW3S6W
         +NxYG9YqjtGggmB/EXO9wF9XkXyxxdpzz4WD2AEaZ1P51qXQ8iJ2U5b/pLiOBYZRVYkG
         AYC6uGz228NN8qb85OdO4jqZSgJrQqWMtQIjhZCARRJ/l9Nroc0+qXa60WxuRw97FjEX
         7EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QOXieuuEEbc116u9FS/tLUaOZv79e9gqeLS9/EKUpZ8=;
        b=RuTmBbzbijnYj/YIAz/qxzKVGHvE16rbJyvm2bgzAMhsw1pRjgcQx6I2mB/7Tiv03I
         Uwdl+96Ez2ppqV8g/rNjWD67hliwBSO9WmXCcMVnmOtoVkZpVUkA8ONDXaoRuLz5G+wr
         3REmJrLAdTUD2+Uz5RtvSm2+sxUC1ZF/7J7i+wUnyCAx9Gu0La5obiuXU/sDzpjSBbmK
         +2/xoSle9euZEInDuL7qzIQibcc4+8XNHDE51OJCrLEOq6AqDYJ317VHe9B4cayZYnjm
         rlpZhFCiLkeBaexdYfTtUiocHQ2OG6Jw/acJCZB23y1NVjDcw5tok2jdJfNfN2FpdfKn
         b3dg==
X-Gm-Message-State: AOAM531Lb+B3dOAdp1CqXn1KBpNgJ27Y725XrZBHH/ddR1mYSLdqv9lB
        KTWAmvP2dWmvCo4miaPLSfg1Ew==
X-Google-Smtp-Source: ABdhPJzyqdJNEAfRNvG2NWx0qtUEFOzaGXj1bTk+b/YuMCYpAyGYIrwcsmKj5sur8hrKyvNbOzljWg==
X-Received: by 2002:ac2:4422:: with SMTP id w2mr3804297lfl.219.1604233717531;
        Sun, 01 Nov 2020 04:28:37 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id 190sm1480655lfk.238.2020.11.01.04.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 04:28:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] iio: accel: bmc150-accel: Add DT bindings
Date:   Sun,  1 Nov 2020 13:28:31 +0100
Message-Id: <20201101122833.1111424-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These accelerometers have bindings used in the kernel and
several device trees but no proper bindings documentation.
Add it.

Also add a compatible for the BMA222 that I am right now
adding support for in the driver.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/accel/bosch,bmc-bmi-bma.yaml | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml
new file mode 100644
index 000000000000..11b8b68aaf3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmc-bmi-bma.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bmc-bmi-bma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMCxxx, BMIxxx and BMAxxx Accelerometers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  3 axis accelerometers with varying range and I2C or SPI
+  3-wire interface.
+
+properties:
+  compatible:
+    enum:
+      - bosch,bmc150
+      - bosch,bmi055
+      - bosch,bma255
+      - bosch,bma250e
+      - bosch,bma222
+      - bosch,bma222e
+      - bosch,bma280
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix.
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
+    i2c {
+        #include <dt-bindings/interrupt-controller/irq.h>
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accelerometer@8 {
+            compatible = "bosch,bma222";
+            reg = <0x08>;
+            vddio-supply = <&vddio>;
+            vdd-supply = <&vdd>;
+            interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+  - |
+    # include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        accel@0 {
+            compatible = "bosch,bma222";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+        };
+    };
+...
-- 
2.26.2

