Return-Path: <linux-iio+bounces-16087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5DEA45DED
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 12:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813771681BF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DB219304;
	Wed, 26 Feb 2025 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsOdmo5x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A921505D;
	Wed, 26 Feb 2025 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570923; cv=none; b=dtT5KkiD5h3mjx1lqIzIVi75O2EZi4g0lfRaAC63BPsTLzDLOolps90Qt4UVPVUFSMpZJr7Inq8LfByfD08fdMqOsF6kr2U/JfYLtdDKCIar0hwjQqWTn7P3tAgMheMCxI2GMGDaxfJkfC4JBF5EOe0v6GsItuvoFznjmwQcCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570923; c=relaxed/simple;
	bh=sQHjhSRRKKvn2KS2pRwShOeKMhbOJsbpGQJ+gRuEUlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExyE697JR6NXcnZG3zumYLuCuOO/JOrtPdqWJ9ZJG72lBLmXIwLdmwSa2ePe0Ghs0D7VwESEvZI0EZRh+1x0DTqyO46ete/8ZLs3kg6KLltDsLB10IMrQi6MB2M1zJo3+5GOAt/6VBz8zJCZHtEKI/kzKBULyJnJZEsTX+UddK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsOdmo5x; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1353318166b.1;
        Wed, 26 Feb 2025 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740570919; x=1741175719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kyu0U6EVnwR7jmKKslxFmBDM5pJLOoJgHmbUIvRU74E=;
        b=LsOdmo5xO0/Rf78c+/E7NXsbOQ8OUM4j3fks4OQcWq0vIvzFqmNZHNPXGaMmUThQwx
         vl4Z7ZQ6a9/JH70XvnotUBChA82q91S5MGmb9n53fFBPzmhbq8/hvdkvnFodu+FV6ARj
         vltgnJRGHiuUE7b1SPgThfe4CgPLWvEJn5rxmSwShWZmJbUC82tnUXZICD7y1juwnCaI
         Ty/t3XrcseJn8gZ7CJm0X8jdQz8AJ8STOF+5le+MqEkx31KCSHkreJYu9KKR7UP1RQsf
         Ibkk9HxkwJPu3Wd60eIPKi8tFbLbFCmWRVVBqxN4GwNzydpaGzbhY8y87MrAiYuH94j1
         M06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570919; x=1741175719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kyu0U6EVnwR7jmKKslxFmBDM5pJLOoJgHmbUIvRU74E=;
        b=en1X0yFS9c4RST9VsPvDuiu8L0TE5IyS2TjO2Om0n4+qdfQa5Gqm92PYp6BFRJLA9M
         qCxSnFbu8+7WOGA+rRGxLcC4zbFZW0p0EoUVtXetdWPOoya9JpOcgMo5lTRwbnuEUSQn
         d1MoKWxwT2qYy0LwHSK6nK/JY3p8Trfudo+ddZHIfv2qK2rzuyOR0yp5LUMkeTimgICS
         EpTOx2grZWhvwtZqBtqinOuVpIbABVYv0hw4NFFrl05abqVjJQwhajP902D7WY3hHF5V
         qVU/sWmcFdjfqK9eD6H1FxMJamqZHOvyARkIQSKlTdscB2UFzYa5vpOFmpBUCMKs8r+A
         M/xw==
X-Forwarded-Encrypted: i=1; AJvYcCUGGBEtnzENp93+nfZvxI59u02h0uirygkidPrhE4jibTxFVn9qTAAL4PqeGAzY7sdjdG7nTF6Pc7AZ@vger.kernel.org, AJvYcCUMarSLRTilKeA1v8aBHDKyKOw1LcTzD1VyP0tAyQ7eFOFe67Yo4e9vaIE3byt9fZd/HT4HmYD7h5GQDAlS@vger.kernel.org, AJvYcCV0EqIdWhiVwydPvd3L2Ywuxq/TzIfoKow2rsz9UsY6nIftT6GlfbK30jLOwjINBw56eEAAm0H6slgc@vger.kernel.org, AJvYcCXk/pGDniAhJviL4KMqBKiiXVux/ltzukUGq45oSJ4pRIzJ59Wz/TPRzx8xmuc6g5is9iNoJ8B0LWuB@vger.kernel.org
X-Gm-Message-State: AOJu0YzvS1CSX8ft8lwx2X4NnDjfIi0rHN9iarp9hElNWPohUrVKEul0
	RsaGVrZqNdydYcpaHyV8NJNDC8OM2Yy1P2Gl8Szz+U/yY3ZJeNgE
X-Gm-Gg: ASbGncuXAMEEXbBUhDJizmVOGCZg88wynrO7B40+aUT1Lc1YAtsdxwH8LaF9jTcx53E
	hVL6rD6GO/+/R9XCkqF9Olds07QjCVeUUOy89Bq7AByLZgjmKUi9Fk5+O61QVrgYJU4JJqxq+WD
	0DfbCChb2uFwcEo3CGr9X9lcxLLgaFixjyCq+tW+xlIxeB/aB29IWeQG2pdEIz0SceEUbqUM3WH
	njdd3dbBGNs0br+DZ92AEYqZmoO2m0PIb+sBYED+d4fgPE3/Kh7p4YH2PIS8d8AKOa+YdUJVUa1
	+Wpt/pxe3g+S6C8VFngeyw==
X-Google-Smtp-Source: AGHT+IHMgKCAVKgixD4YV1t5wRUzshon+y0247mVhzVHMRa4J4oi72JbXDui4DfUbTxzh8tPFUgtSA==
X-Received: by 2002:a17:907:7710:b0:abb:9d27:290f with SMTP id a640c23a62f3a-abed0c66939mr709223266b.9.1740570919061;
        Wed, 26 Feb 2025 03:55:19 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205e53fsm307822366b.159.2025.02.26.03.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:55:18 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
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
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: add AD7191
Date: Wed, 26 Feb 2025 13:53:40 +0200
Message-ID: <20250226115451.249361-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115451.249361-1-alisa.roman@analog.com>
References: <20250226115451.249361-1-alisa.roman@analog.com>
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
index bd04375ab4a2..ac1f61256932 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1346,6 +1346,13 @@ W:	http://ez.analog.com/community/linux-device-drivers
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


