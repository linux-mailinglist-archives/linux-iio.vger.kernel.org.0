Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D22B3945
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 21:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKOU5v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 15:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbgKOU5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2020 15:57:50 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECC9C0613D1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 12:57:50 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so22268947lfj.6
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2020 12:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rnKSl2qWRJgBLP6TH3NnZE7MB45PnhqQS5bgJdVEwCM=;
        b=XmuYY5Cce3uA3+VhP/7nIKX1vqsNH5OspAPfISjwov42gA8Fxo9SWOEtvc3v7GGfml
         UNio5RHf7w54jU/Htuh/j2Y4OqQyfzrUJBRgSE3ecEDVPHf26OFd3sMC1jGSQbWN9lXr
         g3Wb5U865C1Y75f0FS7zmLh+xYm29k0aBvnHKm18QwaAz2wZ6AJqdLuLOiA+lqPzpAup
         5JXv5JD0TNIR8cP5vLuZNKuClA5yfYSytlhXvkNk9wGCqnjXrThuEFs6CaIsPoiDI+ZT
         IUEMAlLaTGiySkNYnAl12mDJtjmdZHjcNYeahUYcAPJONtQUQhKp9rC2XA1xbaWuf021
         i6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rnKSl2qWRJgBLP6TH3NnZE7MB45PnhqQS5bgJdVEwCM=;
        b=W42nadL42nmJziKjqiw5mYxtehBQMSfClxCif9MRnTVj3NyHLbf1eE5aycFRe8qVyU
         wJtmti9fznan7xxQ8cwVJreEjhCKPAVDiRdwk65hcF4TtijZfe06gvqw3ZI7XEUnMhli
         +hHyKvD/odjjmBIjezFpX/DKX7KNky0qvc+Y416gheC6p3hlghnX4vxSG83IACOFFXEf
         DGqCuT+vVJn/ZzGEVFBJZ84xcTYLxzL+bPsxx/P5Q66JjMcTvaqOUGi946gApP3EBCsB
         9g8PW6t14CqmJfw3Jl5o1ADqGvCnEU+YkGEB6A1ijH51ZDGwG9l1ZfJqL061lQqg36yS
         zoDQ==
X-Gm-Message-State: AOAM530YgMddvYJAkD5rsXfTNXcX4YXWb01KyRea5Qu2J5xi98uu4Upp
        dhiGKPcyMhi4qmftA1Wx97rSVQ==
X-Google-Smtp-Source: ABdhPJzWyKwRViQzrAR3T3FBG60ThpuwSDbwrc+oohthCx5+lVFooJiiIV3EntQBkqDY19UR0mdQTg==
X-Received: by 2002:ac2:52b2:: with SMTP id r18mr4090972lfm.50.1605473868740;
        Sun, 15 Nov 2020 12:57:48 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j4sm2458779lfk.275.2020.11.15.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:57:48 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3 v3] iio: accel: bmc150-accel: Add DT bindings
Date:   Sun, 15 Nov 2020 21:57:43 +0100
Message-Id: <20201115205745.618455-1-linus.walleij@linaro.org>
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
ChangeLog v2->v3:
- Fix up an include directive in the example to be
  outside of the I2C node.
ChangeLog v1->v2:
- Rename to simply bosch,bma255.yaml after one of the
  common accelerometers.
- Specify that the SPI uses a 4-wire interface.
- Specify maximum SPI clock frequency to 10MHz. (Checked
  all the datasheets.)
---
 .../bindings/iio/accel/bosch,bma255.yaml      | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
new file mode 100644
index 000000000000..6eef3480ea8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/bosch,bma255.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BMA255 and Similar Accelerometers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  3 axis accelerometers with varying range and I2C or SPI
+  4-wire interface.
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
+  spi-max-frequency:
+    maximum: 10000000
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

