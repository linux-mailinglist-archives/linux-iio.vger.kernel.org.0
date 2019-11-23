Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AFD107CF6
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 06:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfKWFUf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 00:20:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34554 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKWFUf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2019 00:20:35 -0500
Received: by mail-qk1-f193.google.com with SMTP id b188so8280250qkg.1;
        Fri, 22 Nov 2019 21:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSJiW8z0Nr8ieUsuKFAIjeRJ7R7kZTaybvOXtSJez8Y=;
        b=lXYB2eRGlNxuE0Q92udIpIYYLqwUTkfcYVkiJ/UFbMufnWibKPiLkAjHcaFFCW4Z1T
         DPZ0hweJfKL5jW9a8x6fJjokWUgO8KiiPTKgB0J4M8dHNLGa0l6f539towW+estUsC5A
         TaR72yHkwBerFYw/wktS9eNI9xOoj8qNMwxzq4dEYPf5i1BaODO7WdsZRGWVDJFBTvvp
         cdbN3XxUlXHtYRTpEmLQbRBuK9k7XGHuBOaPUfUNDkjJDHObe4Y/84WjlKacImHOqAT3
         wGD0DePhU7oOzIeQMe1ID58w5aJVK7zXMwA+yZUE23A6CclmQAWp35WJr1Gp4Conww5V
         2ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dSJiW8z0Nr8ieUsuKFAIjeRJ7R7kZTaybvOXtSJez8Y=;
        b=t7Toz9HGe6yTmEtYCCla69zoKI2WwfJUhdLQCDV2Xxqgbdaaj4xp6HXontVloGUIXj
         JywkdGAOs0tCSSp7+EjgyMvbWJlYqOBg6n8+j06kwyyTtIFznWrEwnZMSnLfq9849pdT
         BG9n61+d4+PHt/21my1u7LltMl01oFtFCKa731kyUrVAaHwFY/w6mOEOGjliDU8Seuf9
         bCUnIEQ0FdtoQUdcu1Ivc3RsDxE7I/IQwvhvxieJCjUtOOKz8b9qSlaRaPLTIQ+syegA
         mcBiM11hRKQ4tD9souJ/JKiWg7MkzSGogyLiM2uGP7H71UY39LlGoEm8C75l8hZa7mjP
         DyWA==
X-Gm-Message-State: APjAAAXA1cx6zwABRZl4vMwWAqEUPiFOalY/zInstE/sGf3T6RrjG+hM
        YfBWnZY+7kPyu27gtFKQh5M=
X-Google-Smtp-Source: APXvYqwcdIV4A8Q6CT/LktHtIuaaggY3aC//hpkQKzpsZhjuegjpeIoGV1oucIHmJrnUVMq8ZMTfSg==
X-Received: by 2002:a05:620a:1472:: with SMTP id j18mr12346580qkl.184.1574486434275;
        Fri, 22 Nov 2019 21:20:34 -0800 (PST)
Received: from localhost.localdomain ([177.76.215.166])
        by smtp.gmail.com with ESMTPSA id e10sm145506qte.51.2019.11.22.21.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 21:20:33 -0800 (PST)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     alexandru.ardelean@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v4] dt-bindings: iio: accel: add binding documentation for ADIS16240
Date:   Sat, 23 Nov 2019 02:19:27 -0300
Message-Id: <20191123051927.5016-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add device tree binding documentation for ADIS16240.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
V4:
   - Remove spi-cpha and spi-cpol in binding example, since this driver
supports only one timing mode.
 .../bindings/iio/accel/adi,adis16240.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
new file mode 100644
index 000000000000..8e902f7c49e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADIS16240 Programmable Impact Sensor and Recorder driver
+
+maintainers:
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
+  SPI interface.
+    https://www.analog.com/en/products/adis16240.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16240
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "adi,adis16240";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.24.0

