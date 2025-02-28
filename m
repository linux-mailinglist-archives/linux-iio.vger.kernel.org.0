Return-Path: <linux-iio+bounces-16195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E9A49B99
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 15:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B475318995EF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C126FDB4;
	Fri, 28 Feb 2025 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmNIxWAS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954D26FD9F;
	Fri, 28 Feb 2025 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752039; cv=none; b=d7+wbW/rogmSon4E3dvOciooBovD5htiryVC8nuZf+Qf8oDJOzp/WEDeCnbmOra/xiL0UM+ax7LIFm7bDqAT3BwYztqA5yuzgUAouFxaWvfP59oEGL+EO1q8ZkJ5EaZGxeCFdiWge7ANXXALKYiyqX76OsrbyRdTIrARc0qZsiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752039; c=relaxed/simple;
	bh=+kMhd2o3Td9CwUSXlj1HJCe+jb1gtnNx4+5+2K79dys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwTmIXPbCDCC186IkW4HbT971Y+SGrY4DMxhbn9DQEgljRLThBT9Y6bjP5CopjnlEUXApEKob2MZ7NLJezCQ+2M7wSgKrl6ikJSi7kphsUFo7ogcWzBPMyP5H62NXZWUVz8GavKEgLhGzODGbPXtNJkmBi0+e2h6srUtYFl6Tes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmNIxWAS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so15418315e9.0;
        Fri, 28 Feb 2025 06:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740752036; x=1741356836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQn3Jl5aIqEmUh59R7uxT0+LWMvUZhWqaT8DyQNXmoA=;
        b=YmNIxWASHlg7ZfToYrmOArVy012zg2RcUzu/dd2TRNj5zJI5A6CmdEnJQTytuSbFq8
         LAP5+XVsJLal+CzvgshnSRF096dAUtS2M8qnDlBx5CwnNaGr6sFN9RquWmYp8xmexXQk
         3o5myvIMR3XkCloxNaYKA1cywExPqiTxVEzH27sBtR27diCeFL3inFGEwuWnc3L1W+gW
         cTrBvPMyo2H1QHuweQwYmBNUC1Oyq0tpstxNYgnP6Qdw0NNfbzLakzvN7JOWR3aE0B7x
         oTvCo6y4coFkKBWdTAUyNSFtCsHApjTq5bze40U+N0MWPWcRv2wIU2mjlD0emmXttpou
         4oSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752036; x=1741356836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQn3Jl5aIqEmUh59R7uxT0+LWMvUZhWqaT8DyQNXmoA=;
        b=u1Be59arxSJ+pm/Ej/QalXOvlWbyJZ3VYiwnrB4CEw/Iosbn0dwPL6fbVfHa2qGEB7
         2OhvHIvXAnL3q6H/rL6QlbGad2BfECnEfw90ZwCwlW2+dCOnDd4Yfc+vstlgSnjU4S2f
         oI1OL7LB3mBqUcBdaqYSnupJbxfkuz69Mosg0+XzNS+AYY5SSgQyMoMTp+w1ZI1NmfFQ
         +Xg5Sb2SX/X3N5oY8YtHjixUXyxs1iannikfcewdbVPaDXtp7n2sTSGjnaAMqbvuC3h0
         SUl+FRBp5iUxLXbpyo4VAEmNvIL8fmQW/98qt9m+gLt10xzDJ4XA0rBm+PMyVhXMlP0t
         piVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFt4dCS/G/V+QM+7lA4a97iHTdhMtR7noFD1txYa2W4pMTyRJM4HDYozc1V+frxngxN+NRZfzGS/lq@vger.kernel.org, AJvYcCWjUdHK1NvElbL2A+MZ6D7zPFkY2rfKSTsk8ISURurDkJNGeVJjQKGBJDyesCYVwyXeffEd8MbdQNDJ@vger.kernel.org, AJvYcCX0Lxfqak/3n9IjDAQHqGI5MnJKxAek7AwPNU56HnTgV9hbrnVf/ypBP9WlwLBoibRsyoSop5T8lJLh@vger.kernel.org, AJvYcCXnUxfi2R76oj4f+zvhTqUqFHQRzlsk/t1S+WocJ4F5kY8vajbSTUdrzaUIrtpmjkxP1rU8aEdXTixVAx7z@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyXke4QTdlFDd74scBwn8Q3+U2+2zchyOe/Q0/VtUoo/qahAM
	BAMtcvdm/uCLkfh39tGtOxXNZhuZo9gs3+bT7i727KIWaex2ild8
X-Gm-Gg: ASbGncu0spVkIeBuyTngCntuzT26F6QPl/z49x17rg6UYgcW21glN8ShBVv5+A/Ba5l
	lM2uR63qpfNQr6nRrMwhffhecHqoQky5bYkn2BTqmgCaUwDFgPvqqrkkmmrsObZEPbE5HhI5h4p
	LqWTrF6F8SaVDe3qFJfvAV2YQz+9KGeIxfclqRzXP4n3Y33sSLTPNqvYAZO3nNIW0LI5v9wY3LO
	0bxZ8Cqcb7pdpLZTmufHssYcr7Tptoj6d8Cnn/xnhBtFuTf3QuX2tk7lj29RuxY7mo1QFZk6H0b
	9f5rMPztRWGU/lmNfkaLkA==
X-Google-Smtp-Source: AGHT+IH6auimIyZBLMP16QM5jf72aIFJrYIzux01LERo0tlUCqJVVoHCKyq6NkhMvXsL3mkYczf2yw==
X-Received: by 2002:a05:600c:4ecf:b0:439:9a40:aa03 with SMTP id 5b1f17b1804b1-43ba66da2b9mr28808475e9.2.1740752035757;
        Fri, 28 Feb 2025 06:13:55 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75c6sm58221645e9.1.2025.02.28.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:13:55 -0800 (PST)
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
Subject: [PATCH v6 3/3] docs: iio: add AD7191
Date: Fri, 28 Feb 2025 16:06:02 +0200
Message-ID: <20250228141327.262488-4-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228141327.262488-1-alisa.roman@analog.com>
References: <20250228141327.262488-1-alisa.roman@analog.com>
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
 Documentation/iio/ad7191.rst | 119 +++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 121 insertions(+)
 create mode 100644 Documentation/iio/ad7191.rst

diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
new file mode 100644
index 000000000000..977d4fea14b0
--- /dev/null
+++ b/Documentation/iio/ad7191.rst
@@ -0,0 +1,119 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD7191 driver
+=============
+
+Device driver for Analog Devices AD7191 ADC.
+
+Supported devices
+=================
+
+* `AD7191 <https://www.analog.com/AD7191>`_
+
+The AD7191 is a high precision, low noise, 24-bit Σ-Δ ADC with integrated PGA.
+It features two differential input channels, an internal temperature sensor, and
+configurable sampling rates.
+
+Devicetree
+==========
+
+Pin Configuration
+-----------------
+
+The driver supports both pin-strapped and GPIO-controlled configurations for ODR
+(Output Data Rate) and PGA (Programmable Gain Amplifier) settings. These
+configurations are mutually exclusive - you must use either pin-strapped or GPIO
+control for each setting, not both.
+
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


