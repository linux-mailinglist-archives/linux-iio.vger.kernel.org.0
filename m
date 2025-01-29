Return-Path: <linux-iio+bounces-14709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B82A21F35
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648667A20F2
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78101DE2C4;
	Wed, 29 Jan 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAE+abt1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A01DE2AD;
	Wed, 29 Jan 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161082; cv=none; b=ARYPg5S/XOjIhUzXsN0mpk44gvZx8KWzJKtAYDWQtuK6Yyt+X0a53zpkVsrf5EeCB1FVx+9dk/twfJeP1NGNpuu7gA0qbc/mV0MfzEJ/AfOvu2wQmBS7ydQG3tCaWQZ/ytDlQ27mh7v9re8MhwIFP7990imVw7MrQKjVzoT/SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161082; c=relaxed/simple;
	bh=e3V/pWALSBlAObPG3P9mBEB4NbMxyum+9X2NBodYXQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJuabA5TCfHYBx6QWVddM62AkkJQwctirdRYZgFmgqkybsx/MAO30gAyKH/ES01XubIpcyzQmxM5D/z1snOOK1cVyi5nI9aPx7ft3hv4jQBgTB8rohODDPTjK09RbovvQSNEWp6YVzsPz7gMCpqjcQ/N/luVK9zWlZM/vFvtWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAE+abt1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385eed29d17so3632988f8f.0;
        Wed, 29 Jan 2025 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738161079; x=1738765879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miyeZJV3+QhPfUzADf8i5CBE/rWd1iwNyDv2mqJH69Y=;
        b=nAE+abt1Vo3eU5uTMgbyYyqlo+bnTUr/v4QidFXQs6o4yANWs2nl/wNwx6aAJUzKph
         /64u/kXAUb1kxN8eu73/rMwoZUA5YwnxJQSIdCuadj5VqSHBkYAtT/BIpgXHlb4cubLl
         68dnzoGSzgvogp0gs4dEsMS2aw2dQOvFTA8RSJVQ5Xqf4r8JpKTZchaV6UfDKs02Nwf3
         Y2ZRyLJLaua7+7Rmyw/9DZ12gIs6RrTtEJMkN8lWwDJ4ssXjKLx0zr5bTMaDoMzOhDVy
         VMZYTNzBs22sLTg4UGUUCg6sneqsu34o6wTLfJCxxj7/OxFnC3CkIbxaFq+t1/Tp3s/V
         DJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161079; x=1738765879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miyeZJV3+QhPfUzADf8i5CBE/rWd1iwNyDv2mqJH69Y=;
        b=pI5i6BjPtqc8BxCs4dT+0bm1o0zROo8MiWZj/qT8ia+UbWDmroPgnOYMlWmayyJq/o
         xVzqwAZoVtiaegOlLsQ0L/AkORxaMyOGnYrYj5kWU700ORkZMF+B8X0rogVvbzmvaEEc
         P8kEqA/Iygo8Mlo/qnhRzAVR6m3g44T/6IYokgdk0I+YBC5WOHHoz3l0FDexTMJDFtO2
         8UZ8T/Mo//lG7l6T+Vk5Ve1mh1VKQ338amkqMbDFf4VOMmgL758CJC7IitEmpxtocfpD
         MOgN4J/kh+MRwupucXf1pcQGto905hBxncCBVLshhAiSSDRe9e1wfPquPWlCti3SCBe1
         cUiA==
X-Forwarded-Encrypted: i=1; AJvYcCUToLsODeYdP0HxkWm6vJ9UVcdN3m2cRYSQKK/kjM77nCPS4z/9/k/Gyspte0+Xw2Mh4VGX780lnoZu@vger.kernel.org, AJvYcCV8C5dPHGSjK/G37ijXuVu7+Pq0Hl0hNFIla3NDaFrbRXBaisiTtoKR4/1+WxSd6JlZGj23MMY1eLzg@vger.kernel.org, AJvYcCW8j3+mpAqi2YlG+lLUjmcaFTGxkTRU8VCUcnDmj+v7a+WIwvoJt6O273AgYpesVFfD98cEbVONReFfAlcn@vger.kernel.org, AJvYcCWbUhyiqaVg3I0zyfhrrpW5NNzZDLQg2JwwET5qgF22UtJNmn8oWX+TV7DHPEbyXXJ7Q4vDIF37aTF+@vger.kernel.org
X-Gm-Message-State: AOJu0YyWoNUZyuHNE/7z9MsoREp7uh4vax2bT0YZkWBn8tx7nDQPTgot
	I2fNc1KNlyF4z7x6W3sNmCzrhaJb+0xCLK1Cl3zvTkYYid+GSGje
X-Gm-Gg: ASbGncuL3rhtc6Ve+YtxhQWbHvSmVFcQftD7vGpmXOSTkqoAmzdKNNE3ycKrf2Urhac
	jjK4pJuogbInWjRVNrwnP+dHgLWC9AshJwfQK/qmWl5E5HKFBfZzcj5idE0q9oGk0SNb65EHjeh
	usr/KkMiTTWeKD9j0BWvcjDWmwFqbZOmJ+6WMeoun7l8sOJRrmf76ulJisE/3INoepbVx7fGbc8
	FUngj6YHWsoqAeQStLbHP9dfJyqFnxNd93aOfglZc25hG2qmEgp5lxnKIKceX8SA2UHkrQDHEu1
	dimLALOXE1w=
X-Google-Smtp-Source: AGHT+IH9IhL6y2UynnxwOlYzrjLn3rlV7PgtakufueQxqIuJZ6QJwGeyWPM99dxqXv4dDxcaBj3kdg==
X-Received: by 2002:a05:6000:e06:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38c520b69d1mr2553095f8f.51.1738161078421;
        Wed, 29 Jan 2025 06:31:18 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188c28sm17596201f8f.54.2025.01.29.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:31:18 -0800 (PST)
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
Subject: [PATCH v3 3/3] docs: iio: add AD7191
Date: Wed, 29 Jan 2025 16:29:04 +0200
Message-ID: <20250129143054.225322-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129143054.225322-1-alisa.roman@analog.com>
References: <20250129143054.225322-1-alisa.roman@analog.com>
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
 Documentation/iio/ad7191.rst | 230 +++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)
 create mode 100644 Documentation/iio/ad7191.rst

diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
new file mode 100644
index 000000000000..78aa5fefe128
--- /dev/null
+++ b/Documentation/iio/ad7191.rst
@@ -0,0 +1,230 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==============
+AD7191 driver
+==============
+
+Device driver for Analog Devices AD7191 ADC.
+
+Supported devices
+================
+
+* `AD7191 <https://www.analog.com/AD7191>`_
+
+The AD7191 is a high precision, low noise, 24-bit Σ-Δ ADC with integrated PGA.
+It features two differential input channels, an internal temperature sensor,and
+configurable sampling rates.
+
+Device Configuration
+===================
+
+Pin Configuration
+----------------
+
+The driver supports both pin-strapped and GPIO-controlled configurations for ODR
+(Output Data Rate) and PGA (Programmable Gain Amplifier) settings. These
+configurations are mutually exclusive - you must use either pin-strapped or GPIO
+control for each setting, not both.
+
+ODR Configuration
+^^^^^^^^^^^^^^^^
+
+The ODR can be configured either through GPIO control or pin-strapping:
+
+- When using GPIO control, specify the "odr-gpios" property in the device tree
+- For pin-strapped configuration, specify the "adi,odr-value" property in the
+device tree
+
+Available ODR settings:
+  - 120 Hz (ODR1=0, ODR2=0)
+  - 60 Hz (ODR1=0, ODR2=1)
+  - 50 Hz (ODR1=1, ODR2=0)
+  - 10 Hz (ODR1=1, ODR2=1)
+
+PGA Configuration
+^^^^^^^^^^^^^^^
+
+The PGA can be configured either through GPIO control or pin-strapping:
+
+- When using GPIO control, specify the "pga-gpios" property in the device tree
+- For pin-strapped configuration, specify the "adi,pga-value" property in the
+device tree
+
+Available PGA gain settings:
+  - 1x (PGA1=0, PGA2=0)
+  - 8x (PGA1=0, PGA2=1)
+  - 64x (PGA1=1, PGA2=0)
+  - 128x (PGA1=1, PGA2=1)
+
+Clock Configuration
+-----------------
+
+The AD7191 supports both internal and external clock sources:
+
+- When CLKSEL pin is tied LOW: Uses internal 4.92MHz clock (no clock property
+needed)
+- When CLKSEL pin is tied HIGH: Requires external clock source
+  - Can be a crystal between MCLK1 and MCLK2 pins
+  - Or a CMOS-compatible clock driving MCLK2 pin
+  - Must specify the "clocks" property in device tree when using external clock
+
+SPI Interface Requirements
+------------------------
+
+The AD7191 has specific SPI interface requirements:
+
+- The DOUT/RDY output is dual-purpose and requires SPI bus locking
+- DOUT/RDY must be connected to an interrupt-capable GPIO
+- The SPI controller's chip select must be connected to the PDOWN pin of the ADC
+- When CS (PDOWN) is high, the device powers down and resets internal circuitry
+- SPI mode 3 operation (CPOL=1, CPHA=1) is required
+
+Power Supply Requirements
+-----------------------
+
+The device requires the following power supplies:
+
+- AVdd: Analog power supply
+- DVdd: Digital power supply
+- Vref: Reference voltage supply (external)
+
+All power supplies must be specified in the device tree.
+
+Device Attributes
+===============
+
+The AD7191 provides several attributes through the IIO sysfs interface:
+
+Voltage Input Differential Channels
+---------------------------------
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
+Temperature Sensor
+----------------
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
+Available Attributes
+------------------
+
+The following attributes show available configuration options:
+
+- sampling_frequency_available: List of supported sampling frequencies
+- scale_available: List of supported scale factors (based on PGA settings)
+
+Channel Configuration
+===================
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
+Device Tree Bindings
+===================
+
+Required Properties
+-----------------
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
+Optional Properties
+-----------------
+
+- clocks: Required when using external clock (CLKSEL=1), must be absent for
+internal clock
+- adi,odr-value: Pin-strapped ODR configuration (120, 60, 50, or 10)
+- adi,pga-value: Pin-strapped PGA configuration (1, 8, 64, or 128)
+- odr-gpios: GPIOs for ODR control (mutually exclusive with adi,odr-value)
+- pga-gpios: GPIOs for PGA control (mutually exclusive with adi,pga-value)
+
+Example Device Tree
+-----------------
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
+Buffer Support
+============
+
+This driver supports IIO triggered buffers. See Documentation/iio/iio_devbuf.rst
+for more information about IIO triggered buffers.
-- 
2.43.0


