Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3842A246
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2019 03:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEYB0h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 21:26:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38208 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfEYB0g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2019 21:26:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id p26so7547434qkj.5;
        Fri, 24 May 2019 18:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8OIBUBVLIwFsbLa+zQqyTlt34Vav3bqNNvOJvD2I410=;
        b=UJGrFnqcp6l5BJWTfu8B+KUbrVyAkH+H8JqIJOuWvrHtGQ5HvGXDhRnWiJWYabyxrK
         1i5nEIxRZerJlG4Yd9M1GZxrY6BoV1fAQ1EI8dCCrnoY04eS/xtEoopl3ADZJTfslpi+
         bO5VjHvibrhliySex6A4OaXdUO2hbAwIwVBuUZ2P/LX1rieVORDGJQ+3lOiu5vpz4MPN
         QRoZRavM+1f4a/hqTqfsSz4+aTBZw1uOQiS225b5ZywCEorrSHw71yXamTqvEBgn/u67
         ROeAyDUXV6a6VsEB8PMzyPp8+dOJwyNYRNP5ZRwXtjrut1BPF2rP5RltisbNSz6sBRo8
         lkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8OIBUBVLIwFsbLa+zQqyTlt34Vav3bqNNvOJvD2I410=;
        b=ZebaeMgJOtAf4ftX5OfEoHyAHH2X3/5E4l0+WaRe0QMvrKuZcsD3YDNoJjtpMW5WAn
         JT/CLBxmOWbFYZFkimIKn88GGtpLcDZ2ORI2XEXIcJlnXpN6akPV4nQ1/1AYlhlpNI/1
         H54kO+R7dhuW0RfH5rzq3p/eOaEYnHQtxdCDbTJ0KECwD5R6kfcyBV4lh5t7NC6/tjlc
         b2KYcb2cRXYfepeGZzt+hgkRnhEXMyInQJCI17fedN5Lp+9HNzsodnQ6TWcp4BmXrEfs
         WatjVOunvYzgRL8Uh7Zw8cvDqXRmgmFhP+YQV64q8ApP+pQ3ipX6ql/aNQplpPBfYIc9
         ITWA==
X-Gm-Message-State: APjAAAVlbrfcJf4yaIR0rdgyolNGhbZ2fAlEkG8GKFFR/ZsKoPx921xM
        eCfJCFAFpccgUf8B1XyhMl8=
X-Google-Smtp-Source: APXvYqzgnUF0+VPIANZJs8nXgEhvO8sIa3iMc6pBx20M5ShkynUIxNVRiok76bVIjvqHSCRNLeiqBw==
X-Received: by 2002:a37:b8f:: with SMTP id 137mr49695727qkl.220.1558747595566;
        Fri, 24 May 2019 18:26:35 -0700 (PDT)
Received: from renatolg ([186.220.0.156])
        by smtp.gmail.com with ESMTPSA id v195sm1535885qka.28.2019.05.24.18.26.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 18:26:35 -0700 (PDT)
Date:   Fri, 24 May 2019 22:26:30 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Message-ID: <2426649b2d8224ae72e7706bcb8c4f2c44c581d2.1558746978.git.renatogeh@gmail.com>
References: <cover.1558746978.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1558746978.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a YAML binding for the Analog Devices AD7780/1 and
AD7170/1 analog-to-digital converters.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v2:
 - vref-supply to avdd-supply
 - remove avdd-supply from required list
 - include adc block in an spi block

 .../bindings/iio/adc/adi,ad7780.txt           | 48 ----------
 .../bindings/iio/adc/adi,ad7780.yaml          | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
deleted file mode 100644
index 440e52555349..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* Analog Devices AD7170/AD7171/AD7780/AD7781
-
-Data sheets:
-
-- AD7170:
-	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
-- AD7171:
-	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
-- AD7780:
-	* https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
-- AD7781:
-	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
-
-Required properties:
-
-- compatible: should be one of
-	* "adi,ad7170"
-	* "adi,ad7171"
-	* "adi,ad7780"
-	* "adi,ad7781"
-- reg: spi chip select number for the device
-- vref-supply: the regulator supply for the ADC reference voltage
-
-Optional properties:
-
-- powerdown-gpios:  must be the device tree identifier of the PDRST pin. If
-		    specified, it will be asserted during driver probe. As the
-		    line is active high, it should be marked GPIO_ACTIVE_HIGH.
-- adi,gain-gpios:   must be the device tree identifier of the GAIN pin. Only for
-		    the ad778x chips. If specified, it will be asserted during
-		    driver probe. As the line is active low, it should be marked
-		    GPIO_ACTIVE_LOW.
-- adi,filter-gpios: must be the device tree identifier of the FILTER pin. Only
-		    for the ad778x chips. If specified, it will be asserted
-		    during driver probe. As the line is active low, it should be
-		    marked GPIO_ACTIVE_LOW.
-
-Example:
-
-adc@0 {
-	compatible =  "adi,ad7780";
-	reg =	      <0>;
-	vref-supply = <&vdd_supply>
-
-	powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
-	adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
-	adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
new file mode 100644
index 000000000000..d1109416963c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7780.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7170/AD7171/AD7780/AD7781 analog to digital converters
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  The ad7780 is a sigma-delta analog to digital converter. This driver provides
+  reading voltage values and status bits from both the ad778x and ad717x series.
+  Its interface also allows writing on the FILTER and GAIN GPIO pins on the
+  ad778x.
+
+  Specifications on the converters can be found at:
+    AD7170:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
+    AD7171:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
+    AD7780:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
+    AD7781:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7170
+      - adi,ad7171
+      - adi,ad7780
+      - adi,ad7781
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description:
+      The regulator supply for the ADC reference voltage.
+    maxItems: 1
+
+  powerdown-gpios:
+    description:
+      Must be the device tree identifier of the PDRST pin. If
+      specified, it will be asserted during driver probe. As the
+      line is active high, it should be marked GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,gain-gpios:
+    description:
+      Must be the device tree identifier of the GAIN pin. Only for
+      the ad778x chips. If specified, it will be asserted during
+      driver probe. As the line is active low, it should be marked
+      GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  adi,filter-gpios:
+    description:
+      Must be the device tree identifier of the FILTER pin. Only
+      for the ad778x chips. If specified, it will be asserted
+      during driver probe. As the line is active low, it should be
+      marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7780";
+            reg = <0>;
+
+            avdd-supply      = <&vdd_supply>;
+            powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+            adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
+            adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+        };
+    };
-- 
2.21.0

