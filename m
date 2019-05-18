Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB33E22569
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfERWlT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:41:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37748 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfERWlT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:41:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id o7so12198124qtp.4;
        Sat, 18 May 2019 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rdPx5/YxFpSy0ERuJlDi1pCpRRi+1n/Zz/+OlelD9So=;
        b=FJCbU/zwkd1ybQFCZz+699GV78RWenKbd4yAsMu89og+U+ud/G0gBA1lLk0jhGKsHd
         /20pvQNl52SYjWHYXchRUJjluZBM2eBKpfnPvW1OozPtO56p/DzxBQFQUiVXlJU6Tgo5
         NiM5cke8s86ykQn1jl2k3Ilrvuh02qxKhkqRp9jdQC0Hrph2C8UzakGGFpmHm/jVsFCe
         YdJALjVEEwbmU5XL7oJ0Yw2bEk8leZkaPI4sCmG5F3PY7EBLqB9WfpBW2KJBu14Y9dmg
         TTGGm7pzAPSacONyQ7Iw3eoaotMknPYVxUW4nFb5E5FZUAOAP7+Tlohju3+bAr61PSN1
         kzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rdPx5/YxFpSy0ERuJlDi1pCpRRi+1n/Zz/+OlelD9So=;
        b=njOMmd3NmbHQnGCHItughQAyIbNUGNbxhJTmP2GKqVtUH/bWRQOoAW/9F1rbmJqnP4
         hsAES1BYqeEESujKbOjKP9WTBylRmgtwkO1YYmw76w4pvq/AFURy8tfKOWIZ01tEAxpY
         EUKZWCyd6Khd6oX+VA3/OD/rZpNFIwkXtVP4nxJXhR9+HHg7hx5uzBRX05cdWnQyQeRp
         LzILPFX5EZuOFvrVZ6BuNsn9T11yJd/z4YV9SPlPdh+UmLJY9IyPBuNz+p0oUtIthbHn
         7SeW5dzM7JV+lZXmpuH5VBYl7//tin5NwKMJyHekhKg8bARKOxm+KQ+ipIiNaAtEVoPH
         f6WA==
X-Gm-Message-State: APjAAAUywbJfB+jQW0amYSxUP4tlIDHh39SJbj2vnMllpfVLCtcqGfbx
        qxiN+iNJRZWG8LL/smSvkfQ=
X-Google-Smtp-Source: APXvYqzxdBO9MMb6dET4SnQAlTM0tXLawxXOprdKRncPC6Dp2iRyLxgfWrglWQjKRRXI+LF10RTPeg==
X-Received: by 2002:aed:3f9d:: with SMTP id s29mr1168876qth.337.1558219278103;
        Sat, 18 May 2019 15:41:18 -0700 (PDT)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y47sm1236580qtb.55.2019.05.18.15.41.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 15:41:17 -0700 (PDT)
Date:   Sat, 18 May 2019 19:41:12 -0300
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: add adi,ad7780.yaml binding
Message-ID: <9992a318aec777b9b7788bb40d976aa89e5963fe.1558219042.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a YAML binding for the Analog Devices AD7780/1 and
AD7170/1 analog-to-digital converters.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 .../bindings/iio/adc/adi,ad7780.txt           | 48 -----------
 .../bindings/iio/adc/adi,ad7780.yaml          | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 48 deletions(-)
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
index 000000000000..931bc4f8ec04
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
@@ -0,0 +1,85 @@
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
+    description:
+      Chip select number for the device
+    maxItems: 1
+
+  vref-supply:
+    description:
+      The regulator supply for the ADC reference voltage
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
+  - vref-supply
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    adc@0 {
+      compatible =  "adi,ad7780";
+      reg = <0>;
+      vref-supply = <&vdd_supply>;
+
+      powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+      adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
+      adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+    };
-- 
2.21.0

