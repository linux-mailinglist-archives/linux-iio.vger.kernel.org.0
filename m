Return-Path: <linux-iio+bounces-14920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19DA25AFA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F3918826A4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112F4205AC4;
	Mon,  3 Feb 2025 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwg1Lq+Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D720550C;
	Mon,  3 Feb 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589604; cv=none; b=QOTABn/W2jBeKYrLW4jcCV1mhkkf7UzXLXLa+ZbF37TBNTxk0zT6HilnWQkdOHqag8Cffv0s9eUQXMPleqgiCbXF8x7+h3pFc5m/uA3t0Kehcv/czGRi63SXkhNLX2t5i2zkbVvZpk08m9KP+sl6EcLnGHd/98k1aBLfnyYuqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589604; c=relaxed/simple;
	bh=SkFjQjgJE3oZO4ezVvkZfwrgzDVnmWatD49mjqkhits=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5DV3j/0p6/V/VYeV7tT6QlMcMBGlX7lIVHX6LI/VNQz9f4mePEQLVJ78FN0XVXfwVewkbiJg0cnvsWUgCpJp6scT3bxOM/ouJFACgSwGk7vo/zxbuWAnI32EDgmg8zn5yuDyY1sCFvkYubGzUkyEdiwZl/UqW1eMCFsEQwh65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwg1Lq+Q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38be3bfb045so3613738f8f.0;
        Mon, 03 Feb 2025 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738589601; x=1739194401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WTLDIS5bYX32+4MLomiG7L53TP48mbQ9J9cSaSb0N4=;
        b=Dwg1Lq+QwpNaPTgL79Dn7LLxDkH/CGJG0DCeHsQqxOECGh8LvsYJBJfDKJeAzpIPk5
         2u3NiDwxnASdfpw2LbhblqdPt2rLesXEJV2iUJqYEK5NpwHWtPl36LNoKVHiWMXjXPnf
         WBcW3mKw1Wb/k0Bnh3RC1Mb3ZJoBZ+nAolSzLGK6uvkPuNeuMMjL5s2tF93QZnYWCbjq
         67VnWefnXsKgAdd6w281FojWBBVHDZo71MvR1n1TxfjfgeR60NwxOtaTrZQQabNmdYdv
         MJ+OXqeDd5sPi3hrx/RktkLHJT4q9GIUvXgtdWydPeguEgA2YCvF1WWPUF97Qz3bEaUM
         p7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738589601; x=1739194401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WTLDIS5bYX32+4MLomiG7L53TP48mbQ9J9cSaSb0N4=;
        b=J0TwG4Gn/anXZCg1tvH4Nxbvqngz/drlofwBt50A32plkX0kQTNHiER2sNMVkozCp9
         jE/U47BfFK8+VloGbGKac3BJCWTepD+BUU5XlkvPIoCtwZsgk08hE6IXDu+gBonjNu+Y
         uvNWqB6uIjgix7Y+7rpJBLBXhNwKnhr+A6LcGblDmwK3QYKlm1FGpxu5Xp+ctF4bb4r9
         4ZdQ5w6NG/dGvP9A55UOSeOAK7csZBLcN0lGeZnSlouGMoA5wkrXKgo0HI2kJJYCfb1d
         jPtsTs/A0OkgBx7TIz+zC5Mn7WSuqv9vk+RGLVhmW4YCtgUQ2HIX8FUuWHh8ctQI/WNV
         we2g==
X-Forwarded-Encrypted: i=1; AJvYcCVmLcS50uStJbnRfKoA76MnZGFZ0umai6zZpTX0NVcARHEwLGw9mEKZxJMtiM/hF9A9CCgRkLFWCrgw@vger.kernel.org, AJvYcCWnB36/8XE+7GyKBL9HfES/3Sc7fY58XlwbBxxZPLo0rDG8hK6fwnyf1SoKhYWQ+WS1FYdN7kOhMfkVop/N@vger.kernel.org, AJvYcCXYUshtpePV657XvL99EzapPgbcz7Y2MNc6NboJY+HX/xNzSHkwtUGLSMMC1aw4QMKH0oMR2/xjmbyB@vger.kernel.org, AJvYcCXz2m2LbpYwsN/9jdl+jCNYt27ztBZ2rDSW3oNs/arVK94r+fJfN3Br5hA7EL+hPZ8w3siJUgpVjzxT@vger.kernel.org
X-Gm-Message-State: AOJu0YxZe9V6UzR7xZmhoW6rQ3NPQaIC4EIivIz5YfZR6fSSrSFAC8XH
	5TVGx5j2RwfgK/0kAeG7hpKa7Qru01y5nGB57D4Lp6b8DT0UETAw
X-Gm-Gg: ASbGncsqT5WRuckdY4T+p9qGv/hEANKdYMmudCmeON4Dxr+eQV1OYLDMgWZMXzPSwJc
	5rRuy9KCTYmAFSvtFfyi9iCWpbfMZTdMg3VRvow4/TO7AKofIJBO9O58JxGKMPWaRl94WVPIHSJ
	JSn7VOkFRgiTWrIW4wUIZ7getXNSTRvP5Eku0qAltWPhdRPwvaiKZQXbTaq/Y4IdTWWibDqgkWw
	Mb3EYbjUXmEyrMKEHrasU8Ao9q6IltWZ907igolIx/PKRjDdEVQjPhoago9TZNb+V6WSf7PbdwW
	jbHMYpXAikM=
X-Google-Smtp-Source: AGHT+IEYQnRNGAnusL17nBNVlmKwfaaJN+R9cOrrXhtpAe25KwLzlXn/94b23fqIkKAjQ5S6ACI+9g==
X-Received: by 2002:a05:6000:1a85:b0:38a:88d0:1c9c with SMTP id ffacd0b85a97d-38c5a98f74dmr13952866f8f.17.1738589601102;
        Mon, 03 Feb 2025 05:33:21 -0800 (PST)
Received: from spiri.. ([82.77.155.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1d1d03sm12970190f8f.99.2025.02.03.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 05:33:20 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: add AD7191
Date: Mon,  3 Feb 2025 15:31:26 +0200
Message-ID: <20250203133254.313106-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203133254.313106-1-alisa.roman@analog.com>
References: <20250203133254.313106-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AD7191 is a pin-programmable, ultra-low noise 24-bit sigma-delta ADC
designed for precision bridge sensor measurements. It features two
differential analog input channels, selectable output rates,
programmable gain, internal temperature sensor and simultaneous
50Hz/60Hz rejection.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iio/adc/adi,ad7191.yaml          | 149 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
new file mode 100644
index 000000000000..801ed319ee82
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7191 ADC
+
+maintainers:
+  - Alisa-Dariana Roman <alisa.roman@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
+  found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
+  The device's PDOWN pin must be connected to the SPI controller's chip select
+  pin.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7191
+
+  reg:
+    maxItems: 1
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  clocks:
+    maxItems: 1
+    description:
+      Must be present when CLKSEL pin is tied HIGH to select external clock
+      source (either a crystal between MCLK1 and MCLK2 pins, or a
+      CMOS-compatible clock driving MCLK2 pin). Must be absent when CLKSEL pin
+      is tied LOW to use the internal 4.92MHz clock.
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply:
+    description: AVdd voltage supply
+
+  dvdd-supply:
+    description: DVdd voltage supply
+
+  vref-supply:
+    description: Vref voltage supply
+
+  odr-gpios:
+    description:
+      ODR1 and ODR2 pins for output data rate selection. Should be defined if
+      adi,odr-value is absent.
+    minItems: 2
+    maxItems: 2
+
+  adi,odr-value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should be present if ODR pins are pin-strapped. Possible values:
+      120 Hz (ODR1=0, ODR2=0)
+      60 Hz (ODR1=0, ODR2=1)
+      50 Hz (ODR1=1, ODR2=0)
+      10 Hz (ODR1=1, ODR2=1)
+      If defined, odr-gpios must be absent.
+    enum: [120, 60, 50, 10]
+
+  pga-gpios:
+    description:
+      PGA1 and PGA2 pins for gain selection. Should be defined if adi,pga-value
+      is absent.
+    minItems: 2
+    maxItems: 2
+
+  adi,pga-value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should be present if PGA pins are pin-strapped. Possible values:
+      Gain 1 (PGA1=0, PGA2=0)
+      Gain 8 (PGA1=0, PGA2=1)
+      Gain 64 (PGA1=1, PGA2=0)
+      Gain 128 (PGA1=1, PGA2=1)
+      If defined, pga-gpios must be absent.
+    enum: [1, 8, 64, 128]
+
+  temp-gpios:
+    description: TEMP pin for temperature sensor enable.
+    maxItems: 1
+
+  chan-gpios:
+    description: CHAN pin for input channel selection.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - dvdd-supply
+  - vref-supply
+  - spi-cpol
+  - spi-cpha
+  - temp-gpios
+  - chan-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - oneOf:
+      - required:
+          - adi,odr-value
+      - required:
+          - odr-gpios
+  - oneOf:
+      - required:
+          - adi,pga-value
+      - required:
+          - pga-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7191";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7191_mclk>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            vref-supply = <&vref>;
+            adi,pga-value = <1>;
+            odr-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>, <&gpio 24 GPIO_ACTIVE_HIGH>;
+            temp-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+            chan-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 98a3c1e46311..262beced3143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1302,6 +1302,13 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
 F:	drivers/iio/adc/ad7091r*
 
+ANALOG DEVICES INC AD7191 DRIVER
+M:	Alisa-Dariana Roman <alisa.roman@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
+
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alisa-Dariana Roman <alisa.roman@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0


