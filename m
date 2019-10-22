Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E16DFC69
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 05:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbfJVD6F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 23:58:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41853 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387622AbfJVD6F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 23:58:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so9093310pga.8;
        Mon, 21 Oct 2019 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BaNyuTZ9xZGCK+4Egv9biOsBgdoj0woSIqvrJTdjdjQ=;
        b=PTJghDlg6E5A5wsoFIIS0ySgavhfR2Tcu+7LLO8gb8MZGewkRfg9NImdeBb5nFTVLT
         PxLltZ5e7m5AkJEGIIh+zSctZhMEw/JTV96VtfGm19rMFN0aT0zR1v5/vzCHFmFHqNJK
         IttEoB2mP7xeixTMsTduV1uPoDm4AGxaO2HcgMemyjaAhDMR7khgfqQmKYMkwLH1pOWf
         hZ+ikJTYObWJW8gh8s3uCjzKt4iz5ToAdqQYWAJOxbFEiwrhJbISu0eDuJhpFg0O0V0q
         vysR2JqrI/C4qby9pwE/1Zz2tNlEIQZcnYlKZq8g98HPCozg+YuyeRttgp3DgR3aVMup
         GF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BaNyuTZ9xZGCK+4Egv9biOsBgdoj0woSIqvrJTdjdjQ=;
        b=mlm4WR7sUndn87eItrlsxp+4sdxoF5J80i1uYPtqz5rtkV2nwUjUPk6sZI5qbrgtDC
         E2w2+ZaILsOyqGL57rdXyJjru1CO7E5SXiTe97kX/h0DJrP0H+y+mOtPTMvsPSgmSwG5
         kQ1bbJle6PBE8DISpSp0NMYBEwb7KC7rSSz5T0FaiQP7ZkOgih7ssKnV4mH4PkFUvhnN
         0MUM/ZSYDgTpge5gaOolAGYhE0iBWz2QvBKPG2KkUqTyNiUCF4weTvtefb4oe+0rg4ue
         emlqrxI2oH3jVdd8NjcITk34p3PCxyZrmBszKQKTSjjDsXIzjNgwFzUub7k9kU3UNAAa
         scVQ==
X-Gm-Message-State: APjAAAXdfM9rHh4ixTUuX9KJn+6Wff1oItW1GOl1/h4zCUx1Qx5kPAyA
        lVIOo/krdpF0Pcf0CJIxVGhf0R4nwJU=
X-Google-Smtp-Source: APXvYqwaCUKII8ZVe5027XgiaDQWf5de5Sd7a98ULANGsvFULZkL75o9CAB9WzaB+QT8nqv9ALBIjA==
X-Received: by 2002:a17:90a:f491:: with SMTP id bx17mr1973898pjb.106.1571716683269;
        Mon, 21 Oct 2019 20:58:03 -0700 (PDT)
Received: from localhost.localdomain ([106.51.104.0])
        by smtp.gmail.com with ESMTPSA id q42sm18305370pja.16.2019.10.21.20.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 20:58:02 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
Date:   Tue, 22 Oct 2019 09:27:51 +0530
Message-Id: <1571716671-22974-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAL_JsqLoVf4QCYJE_Bak+httr6_bT=iP63waNNiUHz1+PdLhPg@mail.gmail.com>
References: <CAL_JsqLoVf4QCYJE_Bak+httr6_bT=iP63waNNiUHz1+PdLhPg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds device tree bindings for veml6030 ambient
light sensor.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
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

