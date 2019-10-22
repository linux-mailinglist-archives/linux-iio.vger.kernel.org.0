Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209A7E04A0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfJVNL0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 09:11:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40781 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbfJVNLY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 09:11:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so10634407pfb.7;
        Tue, 22 Oct 2019 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wx2HYWwlccBZe9F7TCrEPqIRliFBD3jD76Ss0J71NWg=;
        b=mjSlWjFEnTjEmGr3MXAqZC3scwFZ+ySu2S1C5ZhGJLvdzupNcnNZc31y6yqoNlcP/c
         8u1tI4HtwPDU9t20Y2WAIQAwW/FPJmtZqX7YJ4BTesmPalcSI2mVoPyaD8kTrCMh69zo
         e1e2UEZCffMrFpCBYNRO0wtvTZ6dgoolVOn9Hb4fwekT/jaf5Z8tOVTuyLi3jtCBWhjk
         b2JSPCIyj1LIjsqLeDyo2guNJUVyQiO5V0NyL1IthssyBmTDo/zRy+s7QXRyYZ1jmO2f
         HEcNdErrbmJaokvVz6YoT/LsuyAKAK+p6e5MtFk0NHgZWiCUzk9SVquMIbELrSOxOQf/
         AvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wx2HYWwlccBZe9F7TCrEPqIRliFBD3jD76Ss0J71NWg=;
        b=kCE9mEo0MR5Wc6rd4kPLFg+zUX+/97st52JG4MOMeIfFqlUMf8weXzZjpLaiKoZH7r
         9s41+GB8BFb2h1I252dy5N51F46gCv3jVrsLb2R5Nu/mG5bsEoFqXT5qxjCmy25YJZMh
         8Z+675SBJ7Jhin25a2XHYsrlX2a+Xg3I1B6nGak12tWeD734nGRRZsXUlCjBH7YoP+tR
         ejXmxyg2xOyyPRgcITGR7J/eiOUViDCMuyO8EsanCU1xvP0naq5mv1vaqvQtj6CYTsSx
         NQq2KkKPJbf+sJzK1nay2zuKGTPrN55TfVijU5v5s7Nf1RzLHyrfPE8IkL90t2sdnSaK
         Sjxg==
X-Gm-Message-State: APjAAAWNy0urq1bq0vL5HUUOoP5yXy/nTX7UfRZFO4nxg4+hqi/gyv1X
        +04OTpb5TuBt7LB8m4QeU4M=
X-Google-Smtp-Source: APXvYqzDOnm4YsAZLzrjepNDDeRv2eyTwK0AKhVwbNOsMzrvCHIO44bHP4nQPn4icPGrlphY024Uug==
X-Received: by 2002:a63:1c03:: with SMTP id c3mr3623236pgc.198.1571749883749;
        Tue, 22 Oct 2019 06:11:23 -0700 (PDT)
Received: from localhost.localdomain ([106.51.109.161])
        by smtp.gmail.com with ESMTPSA id v68sm19517839pfv.47.2019.10.22.06.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 06:11:23 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v5 2/3] dt-bindings: iio: light: add veml6030 ALS bindings
Date:   Tue, 22 Oct 2019 18:41:13 +0530
Message-Id: <1571749873-8964-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This commit adds device tree bindings for veml6030 ambient
light sensor.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
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

