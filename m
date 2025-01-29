Return-Path: <linux-iio+bounces-14692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8158A218EE
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 09:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B6818868E8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925B81B042E;
	Wed, 29 Jan 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y4SJHcVT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CD19DF60;
	Wed, 29 Jan 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138904; cv=none; b=g3CWj5pOv3o5my+tAguRrLckXpZ7noyk0LMAuYdwlJF8YaiKczEo96kd/ZHgK1rTn8W1kgJaWLQY6hwu7xWvvVcs4SYeCaeL03n8jmNKS49JF0NBL0Mx32CTcyraH+ZarjysNIWRm6CCvrl2fuat2X6yFZoLCCTynkjtQoaHOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138904; c=relaxed/simple;
	bh=/Fk7ddLafNlxT4ibRlZeT9XK1Z4PA2evxVXXegJ+TU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8dClPODYhSlHwmJDny+sXeQi0aa3hjWFCT9vt5CWzC4UBa5BfRa4p0XvVl0Rw3UtNmYcQyGapZVaNogOw2KcolIaIGLtrKIUxHtbwjiq36J2YlXRmMYR5XCQHVyipTc20PTrymSWltJEOM/MAzAy5/8vGS5wZEY+WDpJ/PV4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y4SJHcVT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T7aHOn029515;
	Wed, 29 Jan 2025 03:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wR2Bo
	HW2UMW/HaZ7buhrLWNCWSQ9U/NzunmRPIOHTn4=; b=Y4SJHcVTzbvq8E9lbOtuQ
	OzJFxc8AVjjkpTuR3Lv1lk12/zzqkFKjGmM8NhEKHowmKZuWSIkyk6vg4faU/Qpz
	u48fj74cnBiA/pcngNmhjJeHxvJId+mTyjRX+FJI7PNts2jKG2SpO2vEoX2HvPtZ
	Ml4Jt9Gtw6ktkFxDzT8ySdoFghjyqFRz8YoeXHYDdlWLeiXixRkXzmaWfSSJHOBY
	V9/WOSSzgTF9Qp4sR0Ba+qcHwv6v5fL97haaw+rd0yvQ/GoQGb2BuSnESGKSlCK1
	IcoWvruCrpaA81dF2SJA+QFTlKWOT1gyaDr6k73qkA4CsIy9RwaItOma14lG6YTM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44fg3a84kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 03:21:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50T8LQEr028249
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jan 2025 03:21:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 29 Jan
 2025 03:21:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 29 Jan 2025 03:21:26 -0500
Received: from robi-Precision-5540.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50T8KtHM025874;
	Wed, 29 Jan 2025 03:21:17 -0500
From: Robert Budai <robert.budai@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lanzano.alex@gmail.com>,
        <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v5 6/6] docs: iio: add documentation for adis16550 driver
Date: Wed, 29 Jan 2025 10:20:46 +0200
Message-ID: <20250129082053.19077-7-robert.budai@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129082053.19077-1-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ie6rBntxNMK6_Adxv53VX_aVtl0eHvVu
X-Proofpoint-GUID: ie6rBntxNMK6_Adxv53VX_aVtl0eHvVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290067

Add documentation for adis16550 driver which describes the driver
device files and shows how the user may use the ABI for various
scenarios (configuration, measurement, etc.).

Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---
 Documentation/iio/adis16550.rst | 378 ++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst     |   1 +
 2 files changed, 379 insertions(+)
 create mode 100644 Documentation/iio/adis16550.rst

diff --git a/Documentation/iio/adis16550.rst b/Documentation/iio/adis16550.rst
new file mode 100644
index 000000000000..1ea85fb77bb8
--- /dev/null
+++ b/Documentation/iio/adis16550.rst
@@ -0,0 +1,378 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+ADIS16550 driver
+================
+
+This driver supports Analog Device's IMUs on SPI bus.
+
+1. Supported devices
+====================
+
+* `ADIS16550 <https://www.analog.com/ADIS16550>`_
+
+The ADIS16550 is a complete inertial system that includes a triaxis gyroscope
+and a triaxis accelerometer. The factory calibration characterizes each sensor for
+sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
+compensation formulas that provide accurate sensor measurements.
+
+1. Device attributes
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
+Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+where X is the IIO index of the device. Under these folders reside a set of
+device files, depending on the characteristics and features of the hardware
+device in questions. These files are consistently generalized and documented in
+the IIO ABI documentation.
+
+The following tables show the adis16550 related device files, found in the
+specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
+
++-------------------------------------------+----------------------------------------------------------+
+| 3-Axis Accelerometer related device files | Description                                              |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_scale                            | Scale for the accelerometer channels.                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_filter_low_pass_3db_frequency    | Bandwidth for the accelerometer channels.                |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibscale                     | Calibration scale for the X-axis accelerometer channel.  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_calibbias                      | Calibration offset for the Y-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_calibscale                     | Calibration scale for the Y-axis accelerometer channel.  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_calibbias                      | Calibration offset for the Z-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_calibscale                     | Calibration scale for the Z-axis accelerometer channel.  |
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
+| in_anglvel_filter_low_pass_3db_frequency   | Scale for the gyroscope channels.                    |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_x_calibbias                     | Calibration offset for the X-axis gyroscope channel. |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_x_calibscale                    | Calibration scale for the X-axis gyroscope channel.  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_x_raw                           | Raw X-axis gyroscope channel value.                  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_y_calibbias                     | Calibration offset for the Y-axis gyroscope channel. |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_y_calibscale                    | Calibration scale for the Y-axis gyroscope channel.  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_y_raw                           | Raw Y-axis gyroscope channel value.                  |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_z_calibbias                     | Calibration offset for the Z-axis gyroscope channel. |
++--------------------------------------------+------------------------------------------------------+
+| in_anglvel_z_calibscale                    | Calibration scale for the Z-axis gyroscope channel.  |
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
++----------------------------+--------------------------------------------------------------------------------+
+| Miscellaneous device files | Description                                                                    |
++----------------------------+--------------------------------------------------------------------------------+
+| name                       | Name of the IIO device.                                                        |
++----------------------------+--------------------------------------------------------------------------------+
+| sampling_frequency         | Currently selected sample rate.                                                |
++----------------------------+--------------------------------------------------------------------------------+
+| write_lock_enable          | Lock the device from further configuration. Only a reset will remove the lock. |
++----------------------------+--------------------------------------------------------------------------------+
+
+The following table shows the adis16550 related device debug files, found in the
+specific device debug folder path ``/sys/kernel/debug/iio/iio:deviceX``.
+
++----------------------+-------------------------------------------------------------------------+
+| Debugfs device files | Description                                                             |
++----------------------+-------------------------------------------------------------------------+
+| serial_number        | The serial number of the chip in hexadecimal format.                    |
++----------------------+-------------------------------------------------------------------------+
+| product_id           | Chip specific product id (16550).                                       |
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
+The adis16550 driver offers data for 5 types of channels, the table below shows
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
+
+Usage examples
+--------------
+
+Show device name:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat name
+        adis16550
+
+Show accelerometer channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
+        6903851
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
+        5650550
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
+        104873530
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
+        0.000000095
+
+- X-axis acceleration = in_accel_x_raw * in_accel_scale = 0.655865845 m/s^2
+- Y-axis acceleration = in_accel_y_raw * in_accel_scale = 0.53680225 m/s^2
+- Z-axis acceleration = in_accel_z_raw * in_accel_scale = 9.96298535 m/s^2
+
+Show gyroscope channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_x_raw
+        193309
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_y_raw
+        -763676
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_z_raw
+        -358108
+        root:/sys/bus/iio/devices/iio:device0> cat in_anglvel_scale
+        0.000000003
+
+- X-axis angular velocity = in_anglvel_x_raw * in_anglvel_scale = 0.000579927 rad/s
+- Y-axis angular velocity = in_anglvel_y_raw * in_anglvel_scale = −0.002291028 rad/s
+- Z-axis angular velocity = in_anglvel_z_raw * in_anglvel_scale = −0.001074324 rad/s
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
+        4000.000000
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1000 > sampling_frequency
+        1000.000000
+
+Set bandwidth for accelerometer channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_pass_3db_frequency
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo 100 > in_accel_filter_low_pass_3db_frequency
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_pass_3db_frequency
+        100
+
+Show serial number:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat serial_number
+        0x000000b6
+
+Show product id:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat product_id
+        16550
+
+Show flash count:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat flash_count
+        13
+
+Show firmware revision:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat firmware_revision
+        1.5
+
+Show firmware date:
+
+.. code-block:: bash
+
+        root:/sys/kernel/debug/iio/iio:device0> cat firmware_date
+        28-04-2021
+
+3. Device buffers
+=================
+
+This driver supports IIO buffers.
+
+The device supports retrieving the raw acceleration, gyroscope, delta velocity,
+delta angle and temperature measurements using buffers.
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
+        root:/sys/bus/iio/devices/iio:device0> echo adis16550-dev0 > trigger/current_trigger
+        root:/sys/bus/iio/devices/iio:device0> cat trigger/current_trigger
+        adis16550-dev0
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
+        0000cdf0  00 00 0d 2f 00 00 08 43  00 00 09 09 00 00 a4 5f  |.../...C......._|
+        0000ce00  00 00 0d 2f 00 00 07 de  00 00 08 db 00 00 a4 4b  |.../...........K|
+        0000ce10  00 00 0d 2f 00 00 07 58  00 00 08 a3 00 00 a4 55  |.../...X.......U|
+        0000ce20  00 00 0d 2f 00 00 06 d6  00 00 08 5c 00 00 a4 62  |.../.......\...b|
+        0000ce30  00 00 0d 2f 00 00 06 45  00 00 08 37 00 00 a4 47  |.../...E...7...G|
+        0000ce40  00 00 0d 2f 00 00 05 d4  00 00 08 30 00 00 a3 fa  |.../.......0....|
+        0000ce50  00 00 0d 2f 00 00 05 d0  00 00 08 12 00 00 a3 d3  |.../............|
+        0000ce60  00 00 0d 2f 00 00 05 dd  00 00 08 2e 00 00 a3 e9  |.../............|
+        0000ce70  00 00 0d 2f 00 00 05 cc  00 00 08 51 00 00 a3 d5  |.../.......Q....|
+        0000ce80  00 00 0d 2f 00 00 05 ba  00 00 08 22 00 00 a3 9a  |.../......."....|
+        0000ce90  00 00 0d 2f 00 00 05 9c  00 00 07 d9 00 00 a3 40  |.../...........@|
+        0000cea0  00 00 0d 2f 00 00 05 68  00 00 07 94 00 00 a2 e4  |.../...h........|
+        0000ceb0  00 00 0d 2f 00 00 05 25  00 00 07 8d 00 00 a2 ce  |.../...%........|
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
index 074dbbf7ba0a..2c3fa1716a69 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -26,6 +26,7 @@ Industrial I/O Kernel Drivers
    ad7944
    adis16475
    adis16480
+   adis16550
    adxl380
    bno055
    ep93xx_adc
-- 
2.43.0


