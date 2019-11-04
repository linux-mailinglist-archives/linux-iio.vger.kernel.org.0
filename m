Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132D4EE401
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfKDPjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:39:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45928 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDPjP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:39:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so6384132pfn.12;
        Mon, 04 Nov 2019 07:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wRiXi3NVSOM88/Q6Ai7P+k24QvUDe10KXN3yenKbQAw=;
        b=VImSXBx+W5GyUKjg8bcYRVDaL4AE7rgO1P4h5XlodVLSH4jbR2Ee8Ub5Hc0QLC4ReH
         Av0Peie49arc7Uve+WWobem/Aw1IcST+kVsecrhuw/yn/y9rH3icktLlIOEvkln77b/4
         XE2cP5MGAf5w0AcITrEDuFDmS7pvxKUg2I5okGbJu+3Kme7fNVyhXFxToCbXsvDb3V/b
         rTakzM4ndiWQYvXTDUmeN8kghqy/U70Q4q5iDduMNmvqwS2lDQ8AC3Gt1NjO2G5/a6MF
         El10322nXzguriF95d6EI1Q5N2QUInTvi0/1Cs4MFgylIysLcoW65mXicwVa4ep1at4S
         epyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wRiXi3NVSOM88/Q6Ai7P+k24QvUDe10KXN3yenKbQAw=;
        b=LQB0J7kAfvMj7LXVsjbisbbQOaJBOepxuStDVbzX33rJCGiBXSEQ7Kl3w8ulmrkwif
         lr2H3vTcwT7iGjABxTFEA6OXzyjRMKlUgRrVn+G0YHtfRX13hfLi7kU2XHiAxfAwW2O9
         5VQt8TkTcGdwp+W+OxS0z5ifeYXOpSmKTXvdU80clhaZWhmIZlALzHSA/q+0NPQn7EEY
         4RlkOM2mDHwxdLYBWZ7T6HSNyWHGaXtVpbqpJNo482WDIvCzr8lejpkebQSdKgDqINGm
         /Emwv+NusGZ75A/z5wsx6JSOcCpVS5knhZ3Z/ZI37WZVonxj9OYt9UdKZ8mbutA1+jty
         ZXkw==
X-Gm-Message-State: APjAAAUh7w0HOwBhWkJUW3TXhagLyVk0z4OXXN/QZ7gdgR1VwCOxGBaU
        BAPd9KNmddzFIuofq5ITXRw=
X-Google-Smtp-Source: APXvYqwLG6y1K658+JPXm7/pdfkuu3lWguEt4IDFN/qOqaAYdeGW+GWaVNcaeGKsew31nKrYh+psqQ==
X-Received: by 2002:a63:a452:: with SMTP id c18mr30643363pgp.188.1572881954389;
        Mon, 04 Nov 2019 07:39:14 -0800 (PST)
Received: from localhost.localdomain ([106.51.108.222])
        by smtp.gmail.com with ESMTPSA id s8sm2910003pgi.54.2019.11.04.07.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 07:39:13 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v6 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
Date:   Mon,  4 Nov 2019 21:09:00 +0530
Message-Id: <1572881940-15420-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds device tree bindings for veml6030 ambient
light sensor.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v6:
* None

Changes in v5:
* None

Changes in v4:
* Added enum in reg property
* Removed maxItems from reg property

Changes in v3:
* None

Changes in v2:
* Corrected grammatical mistake from 'is' to 'are' in description of bindings

 .../devicetree/bindings/iio/light/veml6030.yaml    | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/veml6030.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/veml6030.yaml b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
new file mode 100644
index 0000000..0ff9b11
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/veml6030.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/veml6030.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VEML6030 Ambient Light Sensor (ALS)
+
+maintainers:
+  - Rishi Gupta <gupt21@gmail.com>
+
+description: |
+  Bindings for the ambient light sensor veml6030 from Vishay
+  Semiconductors over an i2c interface.
+
+  Irrespective of whether interrupt is used or not, application
+  can get the ALS and White channel reading from IIO raw interface.
+
+  If the interrupts are used, application will receive an IIO event
+  whenever configured threshold is crossed.
+
+  Specifications about the sensor can be found at:
+    https://www.vishay.com/docs/84366/veml6030.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,veml6030
+
+  reg:
+    description:
+      I2C address of the device.
+    enum:
+      - 0x10 # ADDR pin pulled down
+      - 0x48 # ADDR pin pulled up
+
+  interrupts:
+    description:
+      interrupt mapping for IRQ. Configure with IRQ_TYPE_LEVEL_LOW.
+      Refer to interrupt-controller/interrupts.txt for generic
+      interrupt client node bindings.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@10 {
+                compatible = "vishay,veml6030";
+                reg = <0x10>;
+                interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
-- 
2.7.4

