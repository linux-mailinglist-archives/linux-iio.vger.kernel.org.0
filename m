Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF827A4CF7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 03:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfIBBAV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Sep 2019 21:00:21 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45874 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfIBBAV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Sep 2019 21:00:21 -0400
Received: by mail-qt1-f170.google.com with SMTP id r15so8370356qtn.12;
        Sun, 01 Sep 2019 18:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbN9dMceHRAhTLhaXtwrk+A1KGKWi1prunglCL36fl8=;
        b=bnrTgwkC6UhrhkrQLCi2AQC8sYS3I7/XAIOHwgUmATrN8IAW5vPrEOaBom81Or5CfZ
         6LVIB4DlVm7VWuafWaxPlfxij6gJKr3656qjUD6swWKF0oc9WrfCRw0XXuSHmFj391Nm
         Vin+pZquB9w3mCDWUnsqVQDR9AOdGsC98McuxofNMLCPozlmhWwtGvUwFM99M+Zckl+V
         5UsrwBQ36QddfjUKCoaNuECOEJQ8T3rpw4mqiUEVBxS4aSs5NNRWWIhUyuSvSZ6okNjC
         EIuQgxCP49pTFzVzZDBLTPH93z1uXjj7msS2IXqAGELOlW7gnqveWhWWX9HNQyovMj10
         aPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GbN9dMceHRAhTLhaXtwrk+A1KGKWi1prunglCL36fl8=;
        b=tfrlhX4JDwPqIUpGUbwE7LAdw6V0iL0b+fTeSvig43diJ7CRZVGn5YQ5aFGzXlOgh8
         XRdJYgeEHzXguML/jF1bi5xxvmaJm2w4NEiytfXgkE+3+n3xcNh+Sd7Gi8R6h4rGY7ue
         XXycatDOgFrwmmRy7Y2qUVz3J21yupyimhF3lypMuI8fW+Oy9iq/sfcwJUaGETFHoNp4
         Q5mWM3LIwRupNhjguDme1EqTJay7ehOAx3wvQtGF2JUdhcEWrGACvu81TCQvMNISUkbc
         qaCJgBKWfdow4g+UNykY0dy7Sg8l+aqJXBiJd2u7nMnniMrN5jd6/CU7OY2sKgNBn1jf
         Y/3A==
X-Gm-Message-State: APjAAAVsOrlFAnXipORsS8ZsPCGiK3FrUdTbtl0hHqBxT7Ezx0chbOVK
        YZHG/ttz1ogQ0k9rZ2Ze+efSUXCmqfo=
X-Google-Smtp-Source: APXvYqzkkdk3Ma+GnEDImvy2cLI7nwu7lecDAVldinsUzgbUCkazIC/lGGlV81qxlSDl8JciNj0aEQ==
X-Received: by 2002:ac8:905:: with SMTP id t5mr15782556qth.109.1567386020334;
        Sun, 01 Sep 2019 18:00:20 -0700 (PDT)
Received: from localhost.localdomain (201-93-54-168.dial-up.telesp.net.br. [201.93.54.168])
        by smtp.gmail.com with ESMTPSA id f22sm5596588qkk.45.2019.09.01.18.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 18:00:19 -0700 (PDT)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        alexandru.ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: accel: add binding documentation for ADIS16240
Date:   Sun,  1 Sep 2019 21:59:37 -0300
Message-Id: <20190902005938.7734-1-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch add device tree binding documentation for ADIS16240.

Signed-off-by: Rodrigo Ribeiro Carvalho <rodrigorsdc@gmail.com>
---
I have doubt about what maintainer I may to put in that documentation. I
put Alexandru as maintainer because he reviewed my last patch on this
driver, so I think that he is a good candidate.
 .../bindings/iio/accel/adi,adis16240.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
new file mode 100644
index 000000000000..08019b51611c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -0,0 +1,55 @@
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
+  spi-cpha: true
+
+  spi-cpol: true
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
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.23.0.rc1

