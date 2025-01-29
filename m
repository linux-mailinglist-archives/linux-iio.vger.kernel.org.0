Return-Path: <linux-iio+bounces-14707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9293A21F2B
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB531640E9
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0F1DB14C;
	Wed, 29 Jan 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPdrDj8y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCD8F4A;
	Wed, 29 Jan 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161075; cv=none; b=PCQTOy69sNx3FMtAf060cGnm3OcSSlSAnQRGNRxpYGOSsYWEOLs+Ei09Z8J2cTBtdwBQdmtT8Mdm2ScQ2BllB4De332341zrRLnDUGGLW9x3jnr457XnrMvUfzvm+DhKjhFJZoEsjiT7NpNaHOVIQnCLAju52N9SeXAcapXeMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161075; c=relaxed/simple;
	bh=Fo90SaeZhasbeAjJ9YIq87O2EtCcDwtrPHzIZFQ9Jw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGwZ63TvXePTkR6CI0FqzpprBR4P4/2+IfiUnW5hv18nlHWfquSMB81KuaE5VMppF0fyMd2+u4+wyowXTuD41JE/+Vnm9E3Ccyaamc66CatAxjtKVlmH9ISerirA7NCTsW6KHJhdN7YWZX7ne1EoA+Z3lacmhCY57Fz959J6wWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPdrDj8y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3863494591bso3826392f8f.1;
        Wed, 29 Jan 2025 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738161072; x=1738765872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Arh+LszaYkY8vSwXzfQ+AiSZZWglguutyt8KlEEVcIQ=;
        b=kPdrDj8yGtxulu6VHnwaWHPgZ0VziqWiWD/L3vfAm09L6iiNbaV14FzFiJdkMu554T
         +B2jH4OJCKO35FXV9lNgHfCjK582BglJetwm7JvKx9qZ1EBxyy9gGlQPtYP0V1sOr7gC
         NVRN6uec0v6Bc2IhdfyCAutwPA/Cnzv5gG8df9xE6cQMARmhaI62WGsTx2j/DbVPx1MW
         DXo4ZFrZYBDtdzOCYcSD7pK+d/zX2Z1rLug9hVMVxpChPRQHJv9yySIEeSJfIwAdiQc7
         ptXD1NravuiMwbJYrKvK9clO7EntumaQy/aOUteeqY42iIqmeGotnOJQxAyXng+K4HUa
         rbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161072; x=1738765872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Arh+LszaYkY8vSwXzfQ+AiSZZWglguutyt8KlEEVcIQ=;
        b=SbZvftEgPNt1MssddDznMLN5en2d18DhLC4EkKVPt+4pjSR7wkSUbYBWC363qi3IyE
         EzQRPnoccXJhPS8kiQCNdiRP7FudG5JS7BQLeTyTcbK7AN+bMoPE+K6sPaH6S0s9cqUR
         iRl/Fr0eEiF1sSXFvSuCWrV2Wj/Ony1Vebs9j1cH1kYmxoestT7BhNzPnHEDA6xUJxwp
         wxgjRaDDntVy3/AUNCNPwvffei5vxMIKERCh97n9gaShu/u5HxFG7wvrdXPo6MBnE3NN
         HWvK46Go7O0v4msDB2GeYXLOiLL41XwHR4YSqcLGNa/j658Vc+r3tRCONt0p4xL3UTdR
         7tJg==
X-Forwarded-Encrypted: i=1; AJvYcCU1W9Vq/3Hjl9OFoctwzplXxKI3O7Z3C/s2/Idgg18fAKoR+fuLcE+6P3NjodK+WVfg4azUeOEMO5RW@vger.kernel.org, AJvYcCVYlvZsAnDNgWc4x5H+3lZAMCE3gxtbWixw5xe/wiFk3hKQk6gpvXhkCNKCz4/60Q+lh7RzsBzAmkn3@vger.kernel.org, AJvYcCW5IC52WQlsfY0F//0UBvkDe873dpn1uU6B4PMCNexhD0iooiEtFs4DYxwYwhbQUXA8h8K/0GqEgxtR@vger.kernel.org, AJvYcCWmaLhAQTCUXQx8lwFza/TOIdyBKzdbEMfRd3J690BmO81RDZqGfhRMjsnh08KI24Bxgj2H9GyG2m76+vSC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SWfFQTuFGlsi+C2NklyNeSKzLcpj3F8QdB1rf4w/PAgB0sHv
	lzIdoncwXjxwd7yUMauUF251Ownze5QFfETNdrWP72d9mmKEf09O
X-Gm-Gg: ASbGncta74JElVL4oMeDYFq9RG1OqChPt71BxCbYqHHcIMwK0LrEZ7KheT9uLHowiYE
	+srOYWLxGznZyannjG14vfTiyowlZuX2nYwOrAapZoQXKFW4pKFsnrj0r1ZtH2XuKRnH0kmg8dT
	4VDBmUCzxZ6+N0p43IRCPLOQu7coploDEvmsn9De/PS5v7gxG0qgytHpunoPuwh/Gtl6yn+oG0e
	plqNdHN61qyw60YUpnL4Ri28KI42I0Is6gj4bn09x64moxqF9ggciObWGG7nzC5fnLIi5unShd0
	i/N3K4AIUMc=
X-Google-Smtp-Source: AGHT+IE2vzo2GEbrD8ydc7jFLD8zH9qeSj2LfRN4HMMJwxI57dSfDa6JmSy+RLaCwOhgV81+faJMcA==
X-Received: by 2002:a05:6000:1449:b0:38a:88ac:ed10 with SMTP id ffacd0b85a97d-38c51973c01mr3262379f8f.25.1738161071382;
        Wed, 29 Jan 2025 06:31:11 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188c28sm17596201f8f.54.2025.01.29.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:31:11 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: add AD7191
Date: Wed, 29 Jan 2025 16:29:02 +0200
Message-ID: <20250129143054.225322-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129143054.225322-1-alisa.roman@analog.com>
References: <20250129143054.225322-1-alisa.roman@analog.com>
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
---
 .../bindings/iio/adc/adi,ad7191.yaml          | 149 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
new file mode 100644
index 000000000000..ac14096ba76c
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
+    description: |
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
+    description: |
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
+    description: |
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


