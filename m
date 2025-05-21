Return-Path: <linux-iio+bounces-19760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B3ABE7A6
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B83A7B7907
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6C26B2D3;
	Tue, 20 May 2025 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6UJslnb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A752673BF;
	Tue, 20 May 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781454; cv=none; b=bpT5sN3Qgq9FnG5tD9qYz8GQf3MAGkEv5EHnnlfT5jomjBCX6ZRzEVLeUezoS2vqI83bGd1W3CE0eiCabXRqTdtKFBtiM3yXZS4OYqTU7Fg2GHm8fVhMRgx0DRhVygafy94MSG5+o3VXGS9ysE3z11+gUUSR+p4du4zxM37lrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781454; c=relaxed/simple;
	bh=h8H53WstQAHtKB7BqisUydwF30h1NlWHqWKS0j9d0QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trwxpYIOeLAm4zmDW7w3RcHQM2eeogvWbReiycSmdJvdAeL2P4m9SUesouiiTIRKzOu9JFKW+Km5S0xxxpnol0jWZRyWLvuVnbm8qn3m10ObH4CJVx9u11v6XVywNkwnUJKt7zpDGPhD4nEj2QWrdynZKV1VCbYHRHatKRQ4DdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6UJslnb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a361c8a830so690402f8f.0;
        Tue, 20 May 2025 15:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781450; x=1748386250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgqBxuRnRBCBlpgOJitYe+JYUaYesgoujNN7Mj4ZDPA=;
        b=g6UJslnbp8hn+eIZ+6OBvLLuvpgyPVtPcV8/gLIfDTT+gUjT/PjG+8fozBtUTvugRO
         IUFLibXkp5IyuFgWB7qatlG4X2ttE3Wvt/yEHuvxIPUutHjgm8fbNpCZQBxm7epvp6Dd
         NAuKvvZMmTG4mnfq/42iu3nK0myGrOSVVA1jLGBGmR6nev0Nc/kMjeL4TvyQTE8hjTWy
         27Fjyc9BdSj+lqMFoTpTc/PzxcO1Q4QfV7gL+Nn8//7UcLIvrW3Wx0MyiuBjmtP8B6GI
         ianlAaACi10fBxt0MbtvIYQ3Hrw6j9qwvD7AvO8R3bXEaKMPpqdtVblz9Glaz9oddhcs
         2akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781450; x=1748386250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgqBxuRnRBCBlpgOJitYe+JYUaYesgoujNN7Mj4ZDPA=;
        b=AgrkdtKDsoa17xcBLYZbbG5xYVp6aQj+qrZk7XplwEXttGfzgie6RSPJsPicZ7QiyZ
         DHkFIFtNWPTVuzHkZ6+7Ps3TPzuIy0xUNewimxgOAHy8RpprdQiJNALvqEsfTCygLO+1
         VxK7dGw6tPyoasg651Cm8LA/zJP6le2c7lNbY+vt7/HZCmZItwLEDoqwZqXbcBi6gJtL
         naPFh4cR3O2tmzFs03gd84CN+IjROkvctMnivIBOPNCii1cCHAgUHhfFZAOGg1O1wuzP
         bzsCc6hTdjWK5B0edZuC66YPg+u1mSAAnVbKF3pCA2HN11aHQtB0t5HWJMzcgmCuXRR+
         Fjww==
X-Forwarded-Encrypted: i=1; AJvYcCUhKP89ns8DN5zSH/XXAWmB0OmZAuOLu5VBUbx1LJfocpkX2sy2OmHmGAEcOnVb57jskX8nEYI+Q3A=@vger.kernel.org, AJvYcCVDjboxbOpsERGZUT4r8YwbnFirre+FZJK3r9z/Yn0gISnXohYBYypGq7QyWGe5P7tKSw+x4v1uPqzdePq2@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKJ05rKeoMtKBFuvx03ACsZPkh5yDpHMK+508ppXMm+a8WyJW
	Ia3NekFRsAP5K5YWGXFqMUdgkjzJguk0TuMKrtLz5rp3hDJ8wEaB45yJ
X-Gm-Gg: ASbGnculd/4l6fwSNp87r1kT6ZCggQrYwfTX7j5W6fq3sG9LOj4ll+FhAIWFCT/d7bg
	ZdQix91rPysZ7iJu6YO8ivscT2jnehCKd2e5c3jrycw1z6m+lIUorTYaUO522vDHKw/DChQ0R1Z
	2Bndgtbl8s9tfKkX9O+UlMQ2p2zcIj7DqzV6eInwiIMjmHx8s9VGrnpIg65ZYwHpz1eh+nJ8YNq
	2g1I8lHcqXuFT/6XfTg/9ISS5zBkrYjWxhWErkVHEXuipPAGOX1rt4QBm3J59w22WaaiKy0RL64
	7RBLCbqkJC6Tfj0WX3sKdUDongXOZUkPz7sOi+zdNX7OHAFCoPHLWAr8P09K7Tz/hc3wzPfbjnG
	3m8HQqtUHpe24j20iC0n6aA==
X-Google-Smtp-Source: AGHT+IFZWkOLTMpe0Rj7vle3YfkxL6BFvV+5p7cLKDL/YHH1BkvaOgfAZtFa1Vjfpd0zhglBmFtixw==
X-Received: by 2002:a05:6000:1445:b0:3a3:7be3:d0f3 with SMTP id ffacd0b85a97d-3a37be3d3eamr1224286f8f.14.1747781450175;
        Tue, 20 May 2025 15:50:50 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:49 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] docs: iio: add ADXL313 accelerometer
Date: Tue, 20 May 2025 22:50:07 +0000
Message-Id: <20250520225007.10990-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Add documentation for the ADXL313 accelerometer driver.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/iio/adxl313.rst | 196 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 197 insertions(+)
 create mode 100644 Documentation/iio/adxl313.rst

diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
new file mode 100644
index 000000000000..8c4e2d141594
--- /dev/null
+++ b/Documentation/iio/adxl313.rst
@@ -0,0 +1,196 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ADXL313 driver
+===============
+
+This driver supports Analog Device's ADXL313 on SPI/I2C bus.
+
+1. Supported devices
+====================
+
+* `ADXL313 <https://www.analog.com/ADXL313>`_
+
+The ADXL313is a low noise density, low power, 3-axis accelerometer with
+selectable measurement ranges. The ADXL313 supports the ±0.5 g, ±1 g, ±2 g and
+±4 g ranges.
+
+2. Device attributes
+====================
+
+Accelerometer measurements are always provided.
+
+Temperature data are also provided. This data can be used to monitor the
+internal system temperature or to improve the temperature stability of the
+device via calibration.
+
+Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+where X is the IIO index of the device. Under these folders reside a set of
+device files, depending on the characteristics and features of the hardware
+device in questions. These files are consistently generalized and documented in
+the IIO ABI documentation.
+
+The following tables show the adxl313 related device files, found in the
+specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
+
++---------------------------------------------------+----------------------------------------------------------+
+| 3-Axis Accelerometer related device files         | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_scale                                    | Scale for the accelerometer channels.                    |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibbias                              | Calibration offset for the X-axis accelerometer channel. |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_x_raw                                    | Raw X-axis accelerometer channel value.                  |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_y_calibbias                              | y-axis acceleration offset correction                    |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_y_raw                                    | Raw Y-axis accelerometer channel value.                  |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_z_calibbias                              | Calibration offset for the Z-axis accelerometer channel. |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_z_raw                                    | Raw Z-axis accelerometer channel value.                  |
++---------------------------------------------------+----------------------------------------------------------+
+
++---------------------------------------+----------------------------------------------+
+| Miscellaneous device files            | Description                                  |
++---------------------------------------+----------------------------------------------+
+| name                                  | Name of the IIO device.                      |
++---------------------------------------+----------------------------------------------+
+| in_accel_sampling_frequency           | Currently selected sample rate.              |
++---------------------------------------+----------------------------------------------+
+| in_accel_sampling_frequency_available | Available sampling frequency configurations. |
++---------------------------------------+----------------------------------------------+
+
+Channels processed values
+-------------------------
+
+A channel value can be read from its _raw attribute. The value returned is the
+raw value as reported by the devices. To get the processed value of the channel,
+apply the following formula:
+
+.. code-block:: bash
+
+        processed value = (_raw + _offset) * _scale
+
+Where _offset and _scale are device attributes. If no _offset attribute is
+present, simply assume its value is 0.
+
+The ADXL313 driver offers data for a single types of channels, the table below
+shows the measurement units for the processed value, which are defined by the
+IIO framework:
+
++-------------------------------------+---------------------------+
+| Channel type                        | Measurement unit          |
++-------------------------------------+---------------------------+
+| Acceleration on X, Y, and Z axis    | Meters per Second squared |
++-------------------------------------+---------------------------+
+
+Usage examples
+--------------
+
+Show device name:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat name
+        adxl313
+
+Show accelerometer channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
+        2
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
+        -57
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
+        2
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
+        0.009576806
+
+- X-axis acceleration = in_accel_x_raw * in_accel_scale = 0.0191536 m/s^2
+- Y-axis acceleration = in_accel_y_raw * in_accel_scale = -0.5458779 m/s^2
+- Z-axis acceleration = in_accel_z_raw * in_accel_scale = 0.0191536 m/s^2
+
+Set calibration offset for accelerometer channels. Note, the calibration will be
+rounded according to the graduation of LSB units:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo 50 > in_accel_x_calibbias
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        48
+
+Set sampling frequency:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_sampling_frequency
+        100.000000
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_sampling_frequency_available
+        6.250000 12.500000 25.000000 50.000000 100.000000 200.000000 400.000000 800.000000 1600.000000 3200.000000
+
+        root:/sys/bus/iio/devices/iio:device0> echo 400 > in_accel_sampling_frequency
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_sampling_frequency
+        400.000000
+
+3. Device buffers
+=================
+
+This driver supports IIO buffers.
+
+All devices support retrieving the raw acceleration measurements using buffers.
+
+Usage examples
+--------------
+
+Select channels for buffer read:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_accel_x_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_accel_y_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_accel_z_en
+
+Set the number of samples to be stored in the buffer:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 10 > buffer/length
+
+Enable buffer readings:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > buffer/enable
+
+Obtain buffered data:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> hexdump -C /dev/iio\:device0
+        ...
+        000000d0  01 fc 31 00 c7 ff 03 fc  31 00 c7 ff 04 fc 33 00  |..1.....1.....3.|
+        000000e0  c8 ff 03 fc 32 00 c5 ff  ff fc 32 00 c7 ff 0a fc  |....2.....2.....|
+        000000f0  30 00 c8 ff 06 fc 33 00  c7 ff 01 fc 2f 00 c8 ff  |0.....3...../...|
+        00000100  02 fc 32 00 c6 ff 04 fc  33 00 c8 ff 05 fc 33 00  |..2.....3.....3.|
+        00000110  ca ff 02 fc 31 00 c7 ff  02 fc 30 00 c9 ff 09 fc  |....1.....0.....|
+        00000120  35 00 c9 ff 08 fc 35 00  c8 ff 02 fc 31 00 c5 ff  |5.....5.....1...|
+        00000130  03 fc 32 00 c7 ff 04 fc  32 00 c7 ff 02 fc 31 00  |..2.....2.....1.|
+        00000140  c7 ff 08 fc 30 00 c7 ff  02 fc 32 00 c5 ff ff fc  |....0.....2.....|
+        00000150  31 00 c5 ff 04 fc 31 00  c8 ff 03 fc 32 00 c8 ff  |1.....1.....2...|
+        00000160  01 fc 31 00 c7 ff 05 fc  31 00 c3 ff 04 fc 31 00  |..1.....1.....1.|
+        00000170  c5 ff 04 fc 30 00 c7 ff  03 fc 31 00 c9 ff 03 fc  |....0.....1.....|
+        ...
+
+See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+data is structured.
+
+4. IIO Interfacing Tools
+========================
+
+See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+interfacing tools.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 2d6afc5a8ed5..c106402a91f7 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -31,6 +31,7 @@ Industrial I/O Kernel Drivers
    adis16475
    adis16480
    adis16550
+   adxl313
    adxl380
    bno055
    ep93xx_adc
-- 
2.39.5


