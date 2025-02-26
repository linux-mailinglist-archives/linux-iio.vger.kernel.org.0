Return-Path: <linux-iio+bounces-16089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF170A45DF9
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 12:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007B4164BC9
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9100121B9CC;
	Wed, 26 Feb 2025 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp2uqaXJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAA21B1B5;
	Wed, 26 Feb 2025 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570933; cv=none; b=uk+TEi9yVY9bUA63DW19jCo4ak6OqA0vj1raegK9x6TzvC+tNOc6FICa8dYCO5H15oBKcfNM2aDiSu831LVV3FFHRkYuBF9BVQ44l7rKjQPznprAHAWPB9AxqCwuwv7Ssw961gu9csF5rbgPDbJFPqltwYf+vLZCV5j3cb78Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570933; c=relaxed/simple;
	bh=ZyTCDcvCoCYjEz648JgmVC6yah+h5lTbG9kfqNpnpc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ+IOs8jlWis5K4j3wMxxloqtrtCbMNqAZphSD++bK+0GtjytcZn1dY1T5eTLsDS8B63m6DTjJ17cB7jSqlhqp9IFD6UG12PxzCYeOu75NBLF6KtA9cBHGmEfVvo6kU0iruOk3ZoO19BCbioLKmItZDU/YWI2jHnC/K3j7E0oRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp2uqaXJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1042440966b.3;
        Wed, 26 Feb 2025 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740570930; x=1741175730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoYmQOJmVtXvCcymYXBKkBhd18GkxtX64lyEjld0J3Q=;
        b=hp2uqaXJyg2WdAhB7fQf3+yMIw3nAhPft9UpKwVte6HTPCmaA4spXQomEeA64d6ejZ
         vyPaSWpMYhFrtmxxWF1HxS/SoccR4Lf+MV/z/pGe9pFkjU5MES7eBWFe2MyATE/2I0P+
         XH3yY04bBzeQ5kFB8g1xtpUa5UWAix0ds3Q9Kqv/gD3Wly45tS+rV7B4dCHzagY9Legz
         2hnT73jh/GD+bDhJD7fDhCE7m5gstV8dMGfv6EDuWSjKoWcoPMUFYUhPZvldwQ/2evtK
         y0lax/BU1rdGQJWSk3AxpgYI/zG90nd4frR1tg7DYeOt9hQr/xcG407Ag1dMOZPqF606
         6kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570930; x=1741175730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoYmQOJmVtXvCcymYXBKkBhd18GkxtX64lyEjld0J3Q=;
        b=ZEuwke/wXTrt1mm/bJJ3hr44R2KmUM0OXltg7YsS64rWc2gz0IUpF5aMrJG9LFNODI
         MEKYRtAIhOP2pzZA3MFdWYX52KVYFExDr6ZuB9CtC/V8AqB5gNIsG2HJNrfkZ3sqvpeU
         mV5akx4dpiCFy1lyOSlLIEkOaBHPLeJmeQ3vsXW2Kqhf5JBpf2Q0XkTFTzVipy+FGwy6
         Adue/4dbhFAYT50iMmFh6TL3oEGLEZNlsvXbEr0HGTaLZBYG8+xqvmrIXt5/425sw/bG
         SaHaMnSN1tipMnHvL6rrVVIQ6PeCODzMHno9P/t+GYvGNqQHa8MB4F6DGhWrsvkauYMa
         MuWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWriPMyUQgKNY+WC58t1WZuFStwOY4ev2cVjYnNn54BboVkG71+62jd9j79zOfEepBq3sEcMe2wprQQK6u@vger.kernel.org, AJvYcCUjXB/yFAaZZnQTOOhPFIBxI5KHEOtDKCYd51rMNGnZrAe/yigyqc7ulo3KU+90zB64juGxJOpBG1f5@vger.kernel.org, AJvYcCW3qOLPFLwN3HVmbfOAcRaGWoFtQ1dP/8mwD2qzvNRCvSVHNWtSMHxfzmu6CdF6ALUUcNlg0VqqZXAQ@vger.kernel.org, AJvYcCWaKnW1G1Fiv8or1kwS9EVL2j1R4Y6cqWPemJm4QNykwj7vPRo10AuEU6zTSW1mrzGrBLagOXA/nWW7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dhWxbjWgCb7dxKxC3s/7VVdeJh2XjdZCXfXFQQpWGQ8ummBg
	LHotq8OhWsFgx2CR4zG9okX1TWa8LH+x4D1wdptGCrUSczMx/zf6
X-Gm-Gg: ASbGncvQyACumbFbyLR/xa4EvAEKgKODdsUTnuk0+kJQkQQopIlzPJpfuZ9TfFprDWN
	ydEbUpTvkxr6jg1C6alCxIx1ldTp9BiX6ExyqfJW/FqfB3sDmFxwCi6WtS3ouuoWA0IA4L1v8rP
	WHs9NNVofxnnaYCmRKjcO0tvyqfcXV3uKtJWfi23HgdluhxDpZpPY2sVJzBFYxkPa8WCROlEQeo
	z5Eorkgmk5rHrfllTgt0aVyoHI5+j153ZFyiOO5InRgderZQleywze+CwFKCtCLPNfIuL1XBSf9
	dRHJwzas7fxofSQsKEmtfg==
X-Google-Smtp-Source: AGHT+IGdzibyZrwpMvNp1JtjO5oRB7qmq9XwIDCluCLntfy5cP5VMc5RaDCBVEV6fuZPcCeEYMn9JA==
X-Received: by 2002:a17:906:31cf:b0:ab6:ef33:402 with SMTP id a640c23a62f3a-abc0d9e4ef5mr1998554866b.18.1740570929642;
        Wed, 26 Feb 2025 03:55:29 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205e53fsm307822366b.159.2025.02.26.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:55:29 -0800 (PST)
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
Subject: [PATCH v5 3/3] docs: iio: add AD7191
Date: Wed, 26 Feb 2025 13:53:42 +0200
Message-ID: <20250226115451.249361-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115451.249361-1-alisa.roman@analog.com>
References: <20250226115451.249361-1-alisa.roman@analog.com>
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
 Documentation/iio/ad7191.rst | 129 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 131 insertions(+)
 create mode 100644 Documentation/iio/ad7191.rst

diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
new file mode 100644
index 000000000000..6ab615ea457b
--- /dev/null
+++ b/Documentation/iio/ad7191.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD7191 driver
+=============
+
+Device driver for Analog Devices AD7191 ADC.
+
+=================
+Supported devices
+=================
+
+* `AD7191 <https://www.analog.com/AD7191>`_
+
+The AD7191 is a high precision, low noise, 24-bit Σ-Δ ADC with integrated PGA.
+It features two differential input channels, an internal temperature sensor, and
+configurable sampling rates.
+
+==========
+Devicetree
+==========
+
+-----------------
+Pin Configuration
+-----------------
+
+The driver supports both pin-strapped and GPIO-controlled configurations for ODR
+(Output Data Rate) and PGA (Programmable Gain Amplifier) settings. These
+configurations are mutually exclusive - you must use either pin-strapped or GPIO
+control for each setting, not both.
+
+^^^^^^^^^^^^^^^^^
+ODR Configuration
+^^^^^^^^^^^^^^^^^
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
+^^^^^^^^^^^^^^^^^
+PGA Configuration
+^^^^^^^^^^^^^^^^^
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
+-------------------
+Clock Configuration
+-------------------
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
+==============
+Buffer Support
+==============
+
+This driver supports IIO triggered buffers. See Documentation/iio/iio_devbuf.rst
+for more information about IIO triggered buffers.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 2d334be2b7f2..edc984a38b3b 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -21,6 +21,7 @@ Industrial I/O Kernel Drivers
    ad4000
    ad4030
    ad4695
+   ad7191
    ad7380
    ad7606
    ad7625
diff --git a/MAINTAINERS b/MAINTAINERS
index 87c491975ced..0547a3bb528c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1352,6 +1352,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
+F:	Documentation/iio/ad7191.rst
 F:	drivers/iio/adc/ad7191.c
 
 ANALOG DEVICES INC AD7192 DRIVER
-- 
2.43.0


