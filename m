Return-Path: <linux-iio+bounces-14922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09BA25B04
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9019A161E86
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853F205E22;
	Mon,  3 Feb 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqbpWd0o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F211205E0B;
	Mon,  3 Feb 2025 13:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589610; cv=none; b=UK7JBoEu5QSk/3dZSAvuSdvDgf+HeQZpLIKXjjED2UKMxW/s/c5UlWg0/xvsE3Y90PhZkvdgJqW6FQdAeAzEePTFPm9GspImEXq+kPz2bmfiJuTge3GpbopYnLagAt5BVIBsQjOBq1farEa3kGR92aFK+fTVKMV9kGfZXa45x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589610; c=relaxed/simple;
	bh=kna1IzPp9+FFg8snV8OIddg5ZTgElsgJNQUgna/ReGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYE91s7xBO4GqRX/kRhvXF4DXcHX/XaQVjdPPZnFWhi5RgdDqFulIE50mEyhyBhHmoVouMp3UabAQ2G7mMMBYG/cx4Jms5aQsE96P9I38Xck7NCDgbryKcz2HDZpnBZjtaP/zPY6Nt7L2unHlmL8tZGj2i1e47cRWGVJouRe2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqbpWd0o; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2690555f8f.0;
        Mon, 03 Feb 2025 05:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738589607; x=1739194407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkGtKnQR8FMDN7zTR8dWAWu6oB7iPHR5T7d4Y8iu/9k=;
        b=gqbpWd0oVOEAk8RM3EOaGPCn/KXtWZYRZdgXiIUN5OSRCv1F9uvH9LNbJ5RoXD+0TU
         XkUbYgL0Icj+rg5uB3qNLbdVPuzSifsFOaDzhr/JEeqd+lAIjHRXhjnxNF3WxScIlRSD
         nAd8GGPprLUaJGFJdIzInWPgj5wqqLPkjnbtmiDFovcHs6HvLpi2EtUPGzgbnTRZ7sZ5
         HcKnW8RZaD7QEmFJvqI/ariqFKGcdYPmukO8fkYK0w2cgZQD5THTNR7IM1lDGvrssHDg
         rgtOK+qbb6p1U+ph/nebcwl4GxfEm+4dvartX9IqosdpdLt5p2/EoDl4RnzrZ1vI56TY
         qZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738589607; x=1739194407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkGtKnQR8FMDN7zTR8dWAWu6oB7iPHR5T7d4Y8iu/9k=;
        b=hXG7zVpRhhZoigfqABegsWathRrjmhH8+oG36BuKEoN7cu9OYzlC/y0xa6kPNhrdBW
         ah2gTnmrFXX6PSK8mvtYmrjlkqys64AZSSIxPaCN3UHDvC5CIP5Doqu5vc64HkFUQ1m0
         DzbRLlgQUK3sKz0rVKJzkY9O7IZtNDxfm1M7Ab7o3je7OKcDNCa1OWL78m/YWdriiap5
         rRfQFklJHLDzh1rPeGBJB1WEe/Ahl/N6Ih9M4DsEw/xTVSXOZe6LGOt8rT6hPEK10xH+
         +iyFxrheu9dO4vIhYGx66HioV32HmRti6yk2wiWYG9FO6v+AtqUj7E4LumOQrfTWja9W
         C1PA==
X-Forwarded-Encrypted: i=1; AJvYcCUNEXovOreo72pOqSJmxE6BXiCjSjroQLEccN8mthO75hkdE4BFo20fJ51hstmzAlAKCQmCaA9MEOAT@vger.kernel.org, AJvYcCVCmFRwjw/4VYWrOml/tXaeKsmVIXxoFKDF2LPx+gJ+L3c7H8t9lN9hzhqxDOfV8WQLJJYaZSpDzpeUEDtz@vger.kernel.org, AJvYcCWnZTt3Sbq9oDPsOJmbL7hxRkMtGuGYOUwZp4T5bZB6xy2GztyGOOZiH8RDaCsihQmnTASPuwge9zko@vger.kernel.org, AJvYcCXxeEYgrTbEXxdB4caNLLfUHZDSt6N0kV+JiBtU3QVoC4vZEV0qHLGxJAKUWayA6de3WdX+HXxi7JTw@vger.kernel.org
X-Gm-Message-State: AOJu0YybXrO2fYHJY6/BlqX99yK4nxVyAxJ+7Yi8E4EqTGvAS4NrbPit
	k9EOyASf4yzNLEjEOnw2g2iLGO3AgZFAWpYaq65Fz7nupUP19ELm
X-Gm-Gg: ASbGncu2/xx8pdcuGgc13cdSIzFwRhbjOErVKQGySvmvBC8pwShpLK7VYm7vK+Lefta
	PMCHsRTQA0/E5Z4k/LpufCa3llSxpz893gGHIuMt51LhQ6USpgETEgirdUvcVSnCJTTX22r8GyK
	jolTaNJqj13O5V/Tjljlaw44w4bOt/3z1MSbsblZ/7/Yo6I468NCZBlvxRXNH7r5cuEx07eJvgM
	sEQbLkZq8UW58P9Abelg2l3IenpZAzlq6ks19nnXBEPIVGR/l2uHp0PL6leOLG+nEQzqjoaZ3Ke
	a+QQvsRvIMQ=
X-Google-Smtp-Source: AGHT+IGKsHXACuy7Y8v51UIMNF83vpxGB05NzXnzVy9RrFcVrn4Fz+D3uCpDbP/t20yLCWjvtlfs7g==
X-Received: by 2002:a5d:64cc:0:b0:38a:906e:16c3 with SMTP id ffacd0b85a97d-38c5a98d5c3mr14268847f8f.13.1738589606724;
        Mon, 03 Feb 2025 05:33:26 -0800 (PST)
Received: from spiri.. ([82.77.155.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1d1d03sm12970190f8f.99.2025.02.03.05.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 05:33:26 -0800 (PST)
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
Subject: [PATCH v4 3/3] docs: iio: add AD7191
Date: Mon,  3 Feb 2025 15:31:28 +0200
Message-ID: <20250203133254.313106-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203133254.313106-1-alisa.roman@analog.com>
References: <20250203133254.313106-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for AD7191 driver.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 Documentation/iio/ad7191.rst | 250 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 2 files changed, 251 insertions(+)
 create mode 100644 Documentation/iio/ad7191.rst

diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
new file mode 100644
index 000000000000..b55f3c13e45a
--- /dev/null
+++ b/Documentation/iio/ad7191.rst
@@ -0,0 +1,250 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==============
+AD7191 driver
+==============
+
+Device driver for Analog Devices AD7191 ADC.
+
+==================
+Supported devices
+==================
+
+* `AD7191 <https://www.analog.com/AD7191>`_
+
+The AD7191 is a high precision, low noise, 24-bit Σ-Δ ADC with integrated PGA.
+It features two differential input channels, an internal temperature sensor, and
+configurable sampling rates.
+
+=====================
+Device Configuration
+=====================
+
+--------------------
+Pin Configuration
+--------------------
+
+The driver supports both pin-strapped and GPIO-controlled configurations for ODR
+(Output Data Rate) and PGA (Programmable Gain Amplifier) settings. These
+configurations are mutually exclusive - you must use either pin-strapped or GPIO
+control for each setting, not both.
+
+^^^^^^^^^^^^^^^^^^^^
+ODR Configuration
+^^^^^^^^^^^^^^^^^^^^
+
+The ODR can be configured either through GPIO control or pin-strapping:
+
+- When using GPIO control, specify the "odr-gpios" property in the device tree
+- For pin-strapped configuration, specify the "adi,odr-value" property in the
+  device tree
+
+Available ODR settings:
+
+  - 120 Hz (ODR1=0, ODR2=0)
+  - 60 Hz (ODR1=0, ODR2=1)
+  - 50 Hz (ODR1=1, ODR2=0)
+  - 10 Hz (ODR1=1, ODR2=1)
+
+^^^^^^^^^^^^^^^^^^^
+PGA Configuration
+^^^^^^^^^^^^^^^^^^^
+
+The PGA can be configured either through GPIO control or pin-strapping:
+
+- When using GPIO control, specify the "pga-gpios" property in the device tree
+- For pin-strapped configuration, specify the "adi,pga-value" property in the
+  device tree
+
+Available PGA gain settings:
+
+  - 1x (PGA1=0, PGA2=0)
+  - 8x (PGA1=0, PGA2=1)
+  - 64x (PGA1=1, PGA2=0)
+  - 128x (PGA1=1, PGA2=1)
+
+--------------------
+Clock Configuration
+--------------------
+
+The AD7191 supports both internal and external clock sources:
+
+- When CLKSEL pin is tied LOW: Uses internal 4.92MHz clock (no clock property
+  needed)
+- When CLKSEL pin is tied HIGH: Requires external clock source
+  - Can be a crystal between MCLK1 and MCLK2 pins
+  - Or a CMOS-compatible clock driving MCLK2 pin
+  - Must specify the "clocks" property in device tree when using external clock
+
+--------------------------
+SPI Interface Requirements
+--------------------------
+
+The AD7191 has specific SPI interface requirements:
+
+- The DOUT/RDY output is dual-purpose and requires SPI bus locking
+- DOUT/RDY must be connected to an interrupt-capable GPIO
+- The SPI controller's chip select must be connected to the PDOWN pin of the ADC
+- When CS (PDOWN) is high, the device powers down and resets internal circuitry
+- SPI mode 3 operation (CPOL=1, CPHA=1) is required
+
+-------------------------
+Power Supply Requirements
+-------------------------
+
+The device requires the following power supplies:
+
+- AVdd: Analog power supply
+- DVdd: Digital power supply
+- Vref: Reference voltage supply (external)
+
+All power supplies must be specified in the device tree.
+
+===================
+Device Attributes
+===================
+
+The AD7191 provides several attributes through the IIO sysfs interface:
+
+-----------------------------------
+Voltage Input Differential Channels
+-----------------------------------
+
++-------------------+----------------------------------------------------------+
+| Attribute         | Description                                              |
++===================+==========================================================+
+| raw               | Raw ADC output value                                     |
++-------------------+----------------------------------------------------------+
+| scale             | Scale factor to convert raw value to voltage             |
++-------------------+----------------------------------------------------------+
+| offset            | Voltage offset                                           |
++-------------------+----------------------------------------------------------+
+| sampling_frequency| Current sampling frequency setting                       |
++-------------------+----------------------------------------------------------+
+
+--------------------
+Temperature Sensor
+--------------------
+
++-------------------+----------------------------------------------------------+
+| Attribute         | Description                                              |
++===================+==========================================================+
+| raw               | Raw temperature sensor output value                      |
++-------------------+----------------------------------------------------------+
+| scale             | Scale factor to convert raw value to temperature         |
++-------------------+----------------------------------------------------------+
+| offset            | Temperature calibration offset                           |
++-------------------+----------------------------------------------------------+
+
+--------------------
+Available Attributes
+--------------------
+
+The following attributes show available configuration options:
+
+- sampling_frequency_available: List of supported sampling frequencies
+- scale_available: List of supported scale factors (based on PGA settings)
+
+=====================
+Channel Configuration
+=====================
+
+The device provides three channels:
+
+1. Temperature Sensor
+   - 24-bit unsigned
+   - Internal temperature measurement
+   - Temperature in millidegrees Celsius
+
+2. Differential Input (AIN1-AIN2)
+   - 24-bit unsigned
+   - Differential voltage measurement
+   - Configurable gain via PGA
+
+3. Differential Input (AIN3-AIN4)
+   - 24-bit unsigned
+   - Differential voltage measurement
+   - Configurable gain via PGA
+
+=====================
+Device Tree Bindings
+=====================
+
+-------------------
+Required Properties
+-------------------
+
+- compatible: Should be "adi,ad7191"
+- reg: SPI chip select number
+- spi-max-frequency: Maximum SPI clock frequency
+- spi-cpol: Must be present (set to 1)
+- spi-cpha: Must be present (set to 1)
+- interrupts: Interrupt mapping for DOUT/RDY pin
+- avdd-supply: Analog power supply
+- dvdd-supply: Digital power supply
+- vref-supply: Reference voltage supply
+- temp-gpios: GPIO for temperature channel selection
+- chan-gpios: GPIO for input channel selection
+
+-------------------
+Optional Properties
+-------------------
+
+- clocks: Required when using external clock (CLKSEL=1), must be absent for
+  internal clock
+- adi,odr-value: Pin-strapped ODR configuration (120, 60, 50, or 10)
+- adi,pga-value: Pin-strapped PGA configuration (1, 8, 64, or 128)
+- odr-gpios: GPIOs for ODR control (mutually exclusive with adi,odr-value)
+- pga-gpios: GPIOs for PGA control (mutually exclusive with adi,pga-value)
+
+-------------------
+Example Device Tree
+-------------------
+
+.. code-block:: dts
+
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ad7191@0 {
+            compatible = "adi,ad7191";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+
+            /* Required SPI mode 3 */
+            spi-cpol;
+            spi-cpha;
+
+            /* Interrupt for DOUT/RDY pin */
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+
+            /* Power supplies */
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            vref-supply = <&vref>;
+
+            /* Optional external clock */
+            clocks = <&ad7191_mclk>;
+
+            /* Configuration - either use GPIO control or pin-strapped values */
+            adi,pga-value = <1>;
+            odr-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>,
+                       <&gpio 24 GPIO_ACTIVE_HIGH>;
+
+            /* Required GPIO controls */
+            temp-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+            chan-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+================
+Buffer Support
+================
+
+This driver supports IIO triggered buffers. See Documentation/iio/iio_devbuf.rst
+for more information about IIO triggered buffers.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 5710f5b9e958..9235f38f47a1 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -20,6 +20,7 @@ Industrial I/O Kernel Drivers
 
    ad4000
    ad4695
+   ad7191
    ad7380
    ad7606
    ad7625
-- 
2.43.0


