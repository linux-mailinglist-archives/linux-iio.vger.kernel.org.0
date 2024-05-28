Return-Path: <linux-iio+bounces-5402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BD78D1EB1
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7982869CE
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F322171675;
	Tue, 28 May 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDof2aEY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F4171080;
	Tue, 28 May 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906289; cv=none; b=dORiqRjTWNZumOm1+7AmfSzVey5YuWj66LYb93EohRVFc44ZXxwtvwKRtkxTm8ePU3ZaE4VykWxg9W7DG5izZtuO3gYvvGkZm82jQww6llLS7aCePpP8EuKdAfKnBgNp4iUQkLbnIFSVREvPr2K5h0r4ISSmYPt1fXTJ9XliFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906289; c=relaxed/simple;
	bh=vn//0GODgno12fCvf1Etnbz7ij3jrMnLkggWXGAMBN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXifI0oWRP0oocRb3ctwve/L0riGVayjLN2qADGsbKzZRgJLYg1GU49NFc7gnDjqZGhvH/NHT7kWlFfnahfzL4s68/5e0/JMRmU+QGUceoDchQBLAwmgXWX3+DWbwN2Vn6xFrCbGnxK1VZBSfSs+lr+Heot4VB2nI2f0+oI9Jlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDof2aEY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5785199e0d6so1294342a12.2;
        Tue, 28 May 2024 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906286; x=1717511086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnf/B5fGjaLxrp8lkIx12JHDXTwkx5Q4fK1aGE3EPWM=;
        b=gDof2aEYz04PPbg6sB5HfIK0h5h8kFA2uZZK1LdNJkSDV1HPeOcxv+B0KMOBiLCxvr
         F4fbJCoOiFNbqF3i9Mu/1xcBAE+Icitqwzw71dScP9YhWZ0CKZ4fxect1RtalSzQOx00
         KUZGaVcmSju+s2XTp1rH3/+bNTK/FirGJl43IgkWIEMvUXEaqUwI92eEwSAZmb3IsBBD
         kT8vjRdhgpYIIZoI3SBMIhDXl1bkFbHLU3LcQg8OkfvmgC8eTrqzuML5Y4MBr/+Tpg4W
         Ho5cCYGEjZa0e0gztN49D+dhXLw3SXMU99U1BBzmoYRpaLow6etXc3L1ctQOQ6oMl483
         UHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906286; x=1717511086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnf/B5fGjaLxrp8lkIx12JHDXTwkx5Q4fK1aGE3EPWM=;
        b=Mrh8reYxQnsK2IvUAobv5OBHN6LuQClPYYO96aUyMbj3TfRwoRA83gdHyxKkkefPtH
         c9cm2rKFg0dfixfW/PilwX3EjhyBNLj01d1LrvUMZBLcWWl4aP3qEKDgloss4fX8BP5t
         EWLzewfpTuVBIMSjLZ+As/gvjfOk8GHfLd6QYvzRisg7nTdSciiEKzhkpVySJhkXyax7
         u4fsJB8mSivD+wBsqu6zVKCnaFxg9KBtg5gCrsPhnSn8OEWeCmYiIC8BMccG30l/g79Z
         2I65GzLEQPMs1BjuCI8NYkYyPPFoOUGnXFoXKQQMnULjwRvwxWylVg8cC9SxsSzsYmff
         t2aw==
X-Forwarded-Encrypted: i=1; AJvYcCXMuS7GfDy8l8tgcFo3GlVruedu/dBuehwXgKrZJW11Jhokl5CV0O9l+Cw857QNjLt5Hb7dFMQRjLCye/EhYglzMcFf4bHGqnAU1go464RMEa1jk40rp2QoYeLx0N0XKWcpV6S28otgRszSycJYb+f/+X5qlwxPXiZsD5Ad06CXDw==
X-Gm-Message-State: AOJu0Yy1gILCfYpkrdFS9vVEC7RTxwYDIL+iTQ8I7uQYNVfWHbZo40b2
	SR/eqGWoJlD9NIw+NEhTHXowJSL5/DUcoMRS/kWD+P7J4+O0hvcTHNzZlclKg3o=
X-Google-Smtp-Source: AGHT+IHkVBqR3tGIDFRXopvYXWllcAF6z0wYYHyBnwNH5/ZOwNGX5vleqXNFqtT6SGw+CBrDp6neEA==
X-Received: by 2002:a50:9359:0:b0:578:59a9:c6eb with SMTP id 4fb4d7f45d1cf-57859a9cd6bmr11260830a12.15.1716906285407;
        Tue, 28 May 2024 07:24:45 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:3736:ef2a:a857:c911])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7dc9efesm2495580a12.48.2024.05.28.07.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:24:44 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v2 6/6] docs: iio: add documentation for adis16480 driver
Date: Tue, 28 May 2024 17:24:09 +0300
Message-Id: <20240528142409.239187-7-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528142409.239187-1-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for adis16480 driver which describes the driver
device files and shows how the user may use the ABI for various
scenarios (configuration, measurement, etc.).

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v2:
 - explained why retrieving acceleration or gyroscope data using buffers, delta
 readings will not be available.
 - referenced iio_tools.rst in 4th chapter
 Documentation/iio/adis16480.rst | 445 ++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst     |   1 +
 2 files changed, 446 insertions(+)
 create mode 100644 Documentation/iio/adis16480.rst

diff --git a/Documentation/iio/adis16480.rst b/Documentation/iio/adis16480.rst
new file mode 100644
index 000000000000..e3cc64ddc8f6
--- /dev/null
+++ b/Documentation/iio/adis16480.rst
@@ -0,0 +1,445 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+ADIS16480 driver
+================
+
+This driver supports Analog Device's IMUs on SPI bus.
+
+1. Supported devices
+====================
+
+* `ADIS16375 <https://www.analog.com/ADIS16375>`_
+* `ADIS16480 <https://www.analog.com/ADIS16480>`_
+* `ADIS16485 <https://www.analog.com/ADIS16485>`_
+* `ADIS16488 <https://www.analog.com/ADIS16488>`_
+* `ADIS16490 <https://www.analog.com/ADIS16490>`_
+* `ADIS16495 <https://www.analog.com/ADIS16495>`_
+* `ADIS16497 <https://www.analog.com/ADIS16497>`_
+* `ADIS16545 <https://www.analog.com/ADIS16545>`_
+* `ADIS16547 <https://www.analog.com/ADIS16547>`_
+
+Each supported device is a complete inertial system that includes a triaxial
+gyroscope and a triaxial accelerometer. Each inertial sensor in device combines
+with signal conditioning that optimizes dynamic performance. The factory
+calibration characterizes each sensor for sensitivity, bias, and alignment. As
+a result, each sensor has its own dynamic compensation formulas that provide
+accurate sensor measurements.
+
+2. Device attributes
+====================
+
+Accelerometer, gyroscope measurements are always provided. Furthermore, the
+driver offers the capability to retrieve the delta angle and the delta velocity
+measurements computed by the device.
+
+The delta angle measurements represent a calculation of angular displacement
+between each sample update, while the delta velocity measurements represent a
+calculation of linear velocity change between each sample update.
+
+Finally, temperature data are provided which show a coarse measurement of
+the temperature inside of the IMU device. This data is most useful for
+monitoring relative changes in the thermal environment.
+
+ADIS16480 and ADIS16488 also provide access to barometric pressure data and
+triaxial magnetometer measurements.
+
+Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+where X is the IIO index of the device. Under these folders reside a set of
+device files, depending on the characteristics and features of the hardware
+device in questions. These files are consistently generalized and documented in
+the IIO ABI documentation.
+
+The following tables show the adis16480 related device files, found in the
+specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
+
+**Available only for ADIS16480 and ADIS16488:**
+
++------------------------------------------+---------------------------------------------------------+
+| 3-Axis Magnetometer related device files | Description                                             |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_scale                            | Scale for the magnetometer channels.                    |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_x_calibbias                      | Calibration offset for the X-axis magnetometer channel. |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_x_filter_low_pass_3db_frequency  | Bandwidth for the X-axis magnetometer channel.          |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_x_raw                            | Raw X-axis magnetometer channel value.                  |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_y_calibbias                      | Calibration offset for the Y-axis magnetometer channel. |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_y_filter_low_pass_3db_frequency  | Bandwidth for the Y-axis magnetometer channel.          |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_y_raw                            | Raw Y-axis magnetometer channel value.                  |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_z_calibbias                      | Calibration offset for the Z-axis magnetometer channel. |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_z_filter_low_pass_3db_frequency  | Bandwidth for the Z-axis magnetometer channel.          |
++------------------------------------------+---------------------------------------------------------+
+| in_magn_z_raw                            | Raw Z-axis magnetometer channel value.                  |
++------------------------------------------+---------------------------------------------------------+
+
++------------------------------------------+-----------------------------------------------------+
+| Barometric pressure sensor related files | Description                                         |
++------------------------------------------+-----------------------------------------------------+
+| in_pressure0_calibbias                   | Calibration offset for barometric pressure channel. |
++------------------------------------------+-----------------------------------------------------+
+| in_pressure0_raw                         | Raw barometric pressure channel value.              |
++------------------------------------------+-----------------------------------------------------+
+| in_pressure0_scale                       | Scale for the barometric pressure sensor channel.   |
++------------------------------------------+-----------------------------------------------------+
+
+**Available for all supported devices:**
+
++-------------------------------------------+----------------------------------------------------------+
+| 3-Axis Accelerometer related device files | Description                                              |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_scale                            | Scale for the accelerometer channels.                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibscale                     | Calibration scale for the X-axis accelerometer channel.  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_filter_low_pass_3db_frequency  | Bandwidth for the X-axis accelerometer channel.          |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_calibbias                      | Calibration offset for the Y-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_calibscale                     | Calibration scale for the Y-axis accelerometer channel.  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_filter_low_pass_3db_frequency  | Bandwidth for the Y-axis accelerometer channel.          |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_calibbias                      | Calibration offset for the Z-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_calibscale                     | Calibration scale for the Z-axis accelerometer channel.  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_filter_low_pass_3db_frequency  | Bandwidth for the Z-axis accelerometer channel.          |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_raw                            | Raw Z-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_scale                    | Scale for delta velocity channels.                       |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_x_raw                    | Raw X-axis delta velocity channel value.                 |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_y_raw                    | Raw Y-axis delta velocity channel value.                 |
++-------------------------------------------+----------------------------------------------------------+
+| in_deltavelocity_z_raw                    | Raw Z-axis delta velocity channel value.                 |
++-------------------------------------------+----------------------------------------------------------+
+
++--------------------------------------------+------------------------------------------------------+
+| 3-Axis Gyroscope related device files      | Description                                          |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_scale                           | Scale for the gyroscope channels.                    |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_x_calibbias                     | Calibration offset for the X-axis gyroscope channel. |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_x_calibscale                    | Calibration scale for the X-axis gyroscope channel.  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_x_filter_low_pass_3db_frequency | Bandwidth for the X-axis gyroscope channel.          |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_x_raw                           | Raw X-axis gyroscope channel value.                  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_y_calibbias                     | Calibration offset for the Y-axis gyroscope channel. |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_y_calibscale                    | Calibration scale for the Y-axis gyroscope channel.  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_y_filter_low_pass_3db_frequency | Bandwidth for the Y-axis gyroscope channel.          |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_y_raw                           | Raw Y-axis gyroscope channel value.                  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_z_calibbias                     | Calibration offset for the Z-axis gyroscope channel. |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_z_calibscale                    | Calibration scale for the Z-axis gyroscope channel.  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_z_filter_low_pass_3db_frequency | Bandwidth for the Z-axis gyroscope channel.          |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_z_raw                           | Raw Z-axis gyroscope channel value.                  |
++--------------------------------------------+------------------------------------------------------+
+| in_deltaangl_scale                         | Scale for delta angle channels.                      |
++--------------------------------------------+------------------------------------------------------+
+| in_deltaangl_x_raw                         | Raw X-axis delta angle channel value.                |
++--------------------------------------------+------------------------------------------------------+
+| in_deltaangl_y_raw                         | Raw Y-axis delta angle channel value.                |
++--------------------------------------------+------------------------------------------------------+
+| in_deltaangl_z_raw                         | Raw Z-axis delta angle channel value.                |
++--------------------------------------------+------------------------------------------------------+
+
++----------------------------------+-------------------------------------------+
+| Temperature sensor related files | Description                               |
++----------------------------------+-------------------------------------------+
+| in_temp0_raw                     | Raw temperature channel value.            |
++----------------------------------+-------------------------------------------+
+| in_temp0_offset                  | Offset for the temperature sensor channel.|
++----------------------------------+-------------------------------------------+
+| in_temp0_scale                   | Scale for the temperature sensor channel. |
++----------------------------------+-------------------------------------------+
+
++-------------------------------+---------------------------------------------------------+
+| Miscellaneous device files    | Description                                             |
++-------------------------------+---------------------------------------------------------+
+| name                          | Name of the IIO device.                                 |
++-------------------------------+---------------------------------------------------------+
+| sampling_frequency            | Currently selected sample rate.                         |
++-------------------------------+---------------------------------------------------------+
+
+The following table shows the adis16480 related device debug files, found in the
+specific device debug folder path ``/sys/kernel/debug/iio/iio:deviceX``.
+
++----------------------+-------------------------------------------------------------------------+
+| Debugfs device files | Description                                                             |
++----------------------+-------------------------------------------------------------------------+
+| serial_number        | The serial number of the chip in hexadecimal format.                    |
++----------------------+-------------------------------------------------------------------------+
+| product_id           | Chip specific product id (e.g. 16480, 16488, 16545, etc.).              |
++----------------------+-------------------------------------------------------------------------+
+| flash_count          | The number of flash writes performed on the device.                     |
++----------------------+-------------------------------------------------------------------------+
+| firmware_revision    | String containing the firmware revision in the following format ##.##.  |
++----------------------+-------------------------------------------------------------------------+
+| firmware_date        | String containing the firmware date in the following format mm-dd-yyyy. |
++----------------------+-------------------------------------------------------------------------+
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
+The adis16480 driver offers data for 7 types of channels, the table below shows
+the measurement units for the processed value, which are defined by the IIO
+framework:
+
++--------------------------------------+---------------------------+
+| Channel type                         | Measurement unit          |
++--------------------------------------+---------------------------+
+| Acceleration on X, Y, and Z axis     | Meters per Second squared |
++--------------------------------------+---------------------------+
+| Angular velocity on X, Y and Z axis  | Radians per second        |
++--------------------------------------+---------------------------+
+| Delta velocity on X. Y, and Z axis   | Meters per Second         |
++--------------------------------------+---------------------------+
+| Delta angle on X, Y, and Z axis      | Radians                   |
++--------------------------------------+---------------------------+
+| Temperature                          | Millidegrees Celsius      |
++--------------------------------------+---------------------------+
+| Magnetic field along X, Y and Z axis | Gauss                     |
++--------------------------------------+---------------------------+
+| Barometric pressure                  | kilo Pascal               |
++--------------------------------------+---------------------------+
+
+Usage examples
+--------------
+
+Show device name:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat name
+        adis16545-1
+
+Show accelerometer channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
+        1376728
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
+        4487621
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
+        262773792
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
+        0.000000037
+
+- X-axis acceleration = in_accel_x_raw * in_accel_scale = 0.050938936 m/s^2
+- Y-axis acceleration = in_accel_y_raw * in_accel_scale = 0.166041977 m/s^2
+- Z-axis acceleration = in_accel_z_raw * in_accel_scale = 9.722630304 m/s^2
+
+Show gyroscope channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_x_raw
+        -1041702
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_raw
+        -273013
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_z_raw
+        2745116
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_scale
+        0.000000001
+
+- X-axis angular velocity = in_anglvel_x_raw * in_anglvel_scale = −0.001041702 rad/s
+- Y-axis angular velocity = in_anglvel_y_raw * in_anglvel_scale = −0.000273013 rad/s
+- Z-axis angular velocity = in_anglvel_z_raw * in_anglvel_scale = 0.002745116 rad/s
+
+Set calibration offset for accelerometer channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo 5000 > in_accel_x_calibbias
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        5000
+
+Set calibration offset for gyroscope channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_calibbias
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo -5000 > in_anglvel_y_calibbias
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_calibbias
+        -5000
+
+Set sampling frequency:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency
+        4250.000000
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1000 > sampling_frequency
+        1062.500000
+
+Set bandwidth for accelerometer channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_filter_low_pass_3db_frequency
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo 300 > in_accel_x_filter_low_pass_3db_frequency
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_filter_low_pass_3db_frequency
+        300
+
+Show serial number:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat serial_number
+        0x000c
+
+Show product id:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat product_id
+        16545
+
+Show flash count:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat flash_count
+        88
+
+Show firmware revision:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat firmware_revision
+        1.4
+
+Show firmware date:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat firmware_date
+        09-23-2023
+
+3. Device buffers
+=================
+
+This driver supports IIO buffers.
+
+All devices support retrieving the raw acceleration, gyroscope and temperature
+measurements using buffers.
+
+The following device families also support retrieving the delta velocity, delta
+angle and temperature measurements using buffers:
+
+- ADIS16545
+- ADIS16547
+
+However, when retrieving acceleration or gyroscope data using buffers, delta
+readings will not be available and vice versa. This is because the device only
+allows to read either acceleration and gyroscope data or delta velocity and
+delta angle data at a time and switching between these two burst data selection
+modes is time consuming.
+
+Usage examples
+--------------
+
+Set device trigger in current_trigger, if not already set:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat trigger/current_trigger
+
+        root:/sys/bus/iio/devices/iio:device0> echo adis16545-1-dev0 > trigger/current_trigger
+        root:/sys/bus/iio/devices/iio:device0> cat trigger/current_trigger
+        adis16545-1-dev0
+
+Select channels for buffer read:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_deltavelocity_x_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_deltavelocity_y_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_deltavelocity_z_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_temp0_en
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
+        00006aa0  09 62 00 00 ff ff fc a4  00 00 01 69 00 03 3c 08  |.b.........i..<.|
+        00006ab0  09 61 00 00 00 00 02 96  00 00 02 8f 00 03 37 50  |.a............7P|
+        00006ac0  09 61 00 00 00 00 12 3d  00 00 0b 89 00 03 2c 0b  |.a.....=......,.|
+        00006ad0  09 61 00 00 00 00 1e dc  00 00 16 dd 00 03 25 bf  |.a............%.|
+        00006ae0  09 61 00 00 00 00 1e e3  00 00 1b bf 00 03 27 0b  |.a............'.|
+        00006af0  09 61 00 00 00 00 15 50  00 00 19 44 00 03 30 fd  |.a.....P...D..0.|
+        00006b00  09 61 00 00 00 00 09 0e  00 00 14 41 00 03 3d 7f  |.a.........A..=.|
+        00006b10  09 61 00 00 ff ff ff f0  00 00 0e bc 00 03 48 d0  |.a............H.|
+        00006b20  09 63 00 00 00 00 00 9f  00 00 0f 37 00 03 4c fe  |.c.........7..L.|
+        00006b30  09 64 00 00 00 00 0b f6  00 00 18 92 00 03 43 22  |.d............C"|
+        00006b40  09 64 00 00 00 00 18 df  00 00 22 33 00 03 33 ab  |.d........"3..3.|
+        00006b50  09 63 00 00 00 00 1e 81  00 00 26 be 00 03 29 60  |.c........&...)`|
+        00006b60  09 63 00 00 00 00 1b 13  00 00 22 2f 00 03 23 91  |.c........"/..#.|
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
index 66fa69102e3a..4c13bfa2865c 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -19,5 +19,6 @@ Industrial I/O Kernel Drivers

    ad7944
    adis16475
+   adis16480
    bno055
    ep93xx_adc
--
2.34.1


