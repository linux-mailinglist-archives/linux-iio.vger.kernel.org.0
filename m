Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED8EB15F2
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 23:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfILVkE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 17:40:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34433 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfILVkE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 17:40:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so26062734qke.1;
        Thu, 12 Sep 2019 14:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5+jAMtI1CIAC/4kswIhxg+hTT5z+UEj9oJQQaJeISg=;
        b=c16+RQYnxW6kaB0EHeYyU3adxGtPcgSkk1gXJPAcMW9cWmQKgM6GrLxoyWul4Dpcst
         W4wNft32yrnZBJ8n/THumcMc7kY6L7JeUHLgC5kBsrU/EmexYRfFzw97nQHjue+PSuoL
         IaEkXLIMj/NB2NzhtYDMTzautfhL/udKh6ZNQvCE0TCgRxQ8QXmVHD24iZFDTF+EZafA
         U+JUzkBnrSlbC+lkKHoNX8kzbCS6wFEFpsGQLKfW9e4wTb/90KjU3Igr5O6votzCyMix
         I2ZDRMlDt4Qj6pnyRrnv50vRit53anrXOvRLzD7UgQ/mdqILJklFBuETzuVzlNhl63mn
         8zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5+jAMtI1CIAC/4kswIhxg+hTT5z+UEj9oJQQaJeISg=;
        b=E3WjuIcHbCYtQypN6tWOUTIvZtQef/kUCe63ezkbgaFTKTyc9XI5L55Os9XIg4Aj2r
         O11tKiFXmGi+XrSWtqBsAcFI2PY30o9vpJ2w7lGnJJWFb5I8ERBm4KCSDmsu1GqOA/Ix
         SrRKvzNvV1SskOAbx3bC2ZQcYmtoGQBLY00+hE3Lay0y/FFMVwbNQ3sgiLJMZcKSbbPk
         JNCXJkZfnqatLleW8MYN0007dJBUHuIXiegdKnqXDOjfdQSChHHTTZZtkMXBN/30Wcsk
         tJCeVDPEx6BdGkXXVTdCDAo9wMKzqiECEgqAzGcR35KBHsvM4WalQ9wxTKSbx4xHeqWM
         nXCg==
X-Gm-Message-State: APjAAAVzXJ1938+teze0U90oKZHDU2KZad0q/tnP4KfCJbbXXXJl9caf
        dtDHSTeTMbQIosEbd9r90L4=
X-Google-Smtp-Source: APXvYqzKsEsyelFpRkqcom+4qOub5t05/y+CoXTvPvu3De/EusIO+CgjIUrZ5OJPNNgoxn3e3Io2gg==
X-Received: by 2002:a37:6554:: with SMTP id z81mr13856107qkb.107.1568324402181;
        Thu, 12 Sep 2019 14:40:02 -0700 (PDT)
Received: from localhost.localdomain (201-93-93-180.dial-up.telesp.net.br. [201.93.93.180])
        by smtp.gmail.com with ESMTPSA id v2sm9318509qtv.22.2019.09.12.14.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 14:40:01 -0700 (PDT)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v2] dt-bindings: iio: accel: add binding documentation for ADIS16240
Date:   Thu, 12 Sep 2019 18:39:29 -0300
Message-Id: <20190912213929.3664-1-rodrigorsdc@gmail.com>
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
V2:
  - Remove true constant for spi-cpha and spi-cpol
  - Add description field for spi-cpha and spi-cpol
  - Add maxItems field for spi-cpha and spi-cpol

 .../bindings/iio/accel/adi,adis16240.yaml     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
new file mode 100644
index 000000000000..4b1bd2419604
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -0,0 +1,61 @@
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
+  spi-cpha:
+    description: |
+      See Documentation/devicetree/bindings/spi/spi-controller.yaml
+    maxItems: 1
+
+  spi-cpol: |
+    description: |
+      See Documentation/devicetree/bindings/spi/spi-controller.yaml
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
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.23.0.rc1

