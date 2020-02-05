Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635B21527FD
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgBEJEd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 04:04:33 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:41521 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgBEJEd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 04:04:33 -0500
Received: by mail-lf1-f54.google.com with SMTP id m30so914915lfp.8
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2020 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYMn6cE/WNoeqN62ZAAmhI4wYArwEEHlXYPNuMr1nyE=;
        b=HwpIHsvOP3yoYXzkZoGYK+cFPYTN231QiTNPhYjhYIG4fM4bUZZZf//q50chXLtgKg
         s9PZevA3iIKRhqB9aEv5KsY8dODcXCirCHIZ1BwE6NiPuw5MqkhHkx1Wgaa70NowJWvV
         TZRC8vGwzt6Pq2b1/QCCZftlt5LUO/SaH7w3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYMn6cE/WNoeqN62ZAAmhI4wYArwEEHlXYPNuMr1nyE=;
        b=IYFc9IjZ+eahffP627Nfd0/GCMGKFhi3gpudNjtmwwDjw8TmzYzMFJa0FIrT/V17Ur
         m3HlNuuRJMlUXq5lNHJOiyXOmzq48fSslpsjs2BBIbc1P/Bb6S4ZLtOcRCdjGjnr1RkK
         isU55eVWtSn4RTvQhbTEDKGaxGKQHDtbaWoa60Vvb9emZxIEpQL6LOWzR/EeFzPmefUl
         xmsbGSzBQakwgyV1ROaV84PpJ/67/8CkVJh06RyVt/931nxb8awyIBApRIY4N6eNHH7n
         gWwST3NnVNAoME0TXzgk9GGH3noyqivEmH/QnKsIRsUCR9o4z5ghIM+0Z6MVLNKoQt2R
         Rk8Q==
X-Gm-Message-State: APjAAAWZ1muxVZu2gTjBWzrD5e77zRXle12G0w+ALtYDSRgc1/LGmIZ8
        4WUeIiUI23u1pht8ZqvblsuUasVGms0=
X-Google-Smtp-Source: APXvYqyRbCvRTJL4VuUw/f2qieTsfUb6oHtln//sIMhg4KPQptgJ0rPo863FlLm0um1EEvfTa/RBkg==
X-Received: by 2002:ac2:44a2:: with SMTP id c2mr17214630lfm.105.1580893469075;
        Wed, 05 Feb 2020 01:04:29 -0800 (PST)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id k25sm12684009lji.42.2020.02.05.01.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:04:28 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: iio: chemical: consolidate atlas-sensor docs
Date:   Wed,  5 Feb 2020 11:04:21 +0200
Message-Id: <20200205090421.18339-4-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205090421.18339-1-matt.ranostay@konsulko.com>
References: <20200205090421.18339-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since Atlas Scientific device support only varies from the compatible
string is ideal all the respective docs are merged into a single doc
named atlas,sensor.yaml

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 --------
 .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 --------
 .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 --------
 .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++++++++++
 4 files changed, 53 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt b/Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
deleted file mode 100644
index f4320595b851..000000000000
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Atlas Scientific EC-SM OEM sensor
-
-http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
-
-Required properties:
-
-  - compatible: must be "atlas,ec-sm"
-  - reg: the I2C address of the sensor
-  - interrupts: the sole interrupt generated by the device
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt client
-  node bindings.
-
-Example:
-
-atlas@64 {
-	compatible = "atlas,ec-sm";
-	reg = <0x64>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 2>;
-};
diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt b/Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
deleted file mode 100644
index af1f5a9aa4da..000000000000
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Atlas Scientific ORP-SM OEM sensor
-
-https://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
-
-Required properties:
-
-  - compatible: must be "atlas,orp-sm"
-  - reg: the I2C address of the sensor
-  - interrupts: the sole interrupt generated by the device
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt client
-  node bindings.
-
-Example:
-
-atlas@66 {
-	compatible = "atlas,orp-sm";
-	reg = <0x66>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 2>;
-};
diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt b/Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
deleted file mode 100644
index 79d90f060327..000000000000
--- a/Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* Atlas Scientific pH-SM OEM sensor
-
-http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
-
-Required properties:
-
-  - compatible: must be "atlas,ph-sm"
-  - reg: the I2C address of the sensor
-  - interrupts: the sole interrupt generated by the device
-
-  Refer to interrupt-controller/interrupts.txt for generic interrupt client
-  node bindings.
-
-Example:
-
-atlas@65 {
-	compatible = "atlas,ph-sm";
-	reg = <0x65>;
-	interrupt-parent = <&gpio1>;
-	interrupts = <16 2>;
-};
diff --git a/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
new file mode 100644
index 000000000000..24aec7291100
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/atlas,sensor.yaml##
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atlas Scientific OEM sensors
+
+maintainers:
+  - Matt Ranostay <matt.ranostay@konsulko.com>
+
+description: |
+  Atlas Scientific OEM sensors connected via I2C
+
+  Datasheets:
+    http://www.atlas-scientific.com/_files/_datasheets/_oem/DO_oem_datasheet.pdf
+    http://www.atlas-scientific.com/_files/_datasheets/_oem/EC_oem_datasheet.pdf
+    http://www.atlas-scientific.com/_files/_datasheets/_oem/ORP_oem_datasheet.pdf
+    http://www.atlas-scientific.com/_files/_datasheets/_oem/pH_oem_datasheet.pdf
+
+properties:
+  compatible:
+    enum:
+      - atlas,do-sm
+      - atlas,ec-sm
+      - atlas,orp-sm
+      - atlas,ph-sm
+
+  reg:
+     maxItems: 1
+
+  interrupts:
+     maxItems: 1
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      atlas@66 {
+        compatible = "atlas,orp-sm";
+        reg = <0x66>;
+        interrupt-parent = <&gpio1>;
+        interrupts = <16 2>;
+      };
+    };
-- 
2.20.1

