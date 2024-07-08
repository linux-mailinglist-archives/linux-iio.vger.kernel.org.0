Return-Path: <linux-iio+bounces-7430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B85292A06A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0631F21707
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5E78C9D;
	Mon,  8 Jul 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yEiMQMwQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26678C83;
	Mon,  8 Jul 2024 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435377; cv=none; b=JFsQIgn3Ir6PMdoI8zWH6hBf14kOpaBI9n2ROqHEaXfq3S9lz6h6BrsdceLyQEZ3dq74rd7n3UkWCu+1kxOYGnnU/MhqIYsT9unQoCKXAUUxCJ9qZzt0H1LLJL1OjaB8KghbyrwdyF2M92OHH/7TGs40WyRN4gBTedDS5AwS810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435377; c=relaxed/simple;
	bh=vCeUQmPgqxtukThWhADI+8vHRpRJykLckYM30EHepIo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxXB9jPoOF31o+yJRwAajbpjDXO5WqYEUbW0fgsHk48Mz+LisQolHCV50EOf4MJTrLZBZkEkSrgQ7cXlOCXwlrWAasmU6WzMfETkIUJAJN6Pg6kfi3iUd8Jc179+kpVvnknxKyTSx7C1DJ1KTce8KHdzAdmL3jA30zjsacuy6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yEiMQMwQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4686bAlr028878;
	Mon, 8 Jul 2024 06:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3Owtc
	XWWSQ+Z8Fs/suyn40ABnNTiUpkXm7sco3k4P78=; b=yEiMQMwQniYks0T2PH6Bx
	RvKVFVOilr+zYBCvgzNIOcprFWA2DuO95nQNQZUcpHUH9ceER30Ny6vrYW7GFnqg
	pH4zd63kU3RBZaQiZejjHD/5L2RfB0Ra510xNwNNkqE8x9wF7PsPNzU0A2Qxed46
	2iK2e5qRxINBrhb6vlggD3PQ72GkqYlE5MYzsDOdTSm5+GxbG6aVn/OK+DPCKTnE
	rAcPKhUOYF+wjhG4t9WdcfUnk7EufiATJlCOvBB1jMLUDuAh1vjt4cQUd0EEHxRD
	86GWxsaeArCDgD45/AmQG1Xl19lcaXGvHjulx1zN0QRV0qy+hU9UcbD398LdsbdZ
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4072u1ngt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 06:42:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 468AgYcZ001265
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jul 2024 06:42:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 8 Jul 2024
 06:42:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 Jul 2024 06:42:33 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 468AfZLK008375;
	Mon, 8 Jul 2024 06:42:28 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jun Yan
	<jerrysteve1101@gmail.com>,
        Alexander Sverdlin
	<alexander.sverdlin@siemens.com>,
        Mario Limonciello
	<mario.limonciello@amd.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v5 3/3] docs: iio: add documentation for adxl380 driver
Date: Mon, 8 Jul 2024 13:40:13 +0300
Message-ID: <20240708104114.29894-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708104114.29894-1-antoniu.miclaus@analog.com>
References: <20240708104114.29894-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SGxlw3je1rznkUdjcQxLkC75vPMJbGWW
X-Proofpoint-ORIG-GUID: SGxlw3je1rznkUdjcQxLkC75vPMJbGWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_05,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080083

Add documentation for adxl380 driver which describes the driver
device files and shows how the user may use the ABI for various
scenarios (configuration, measurement, etc.).

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 Documentation/iio/adxl380.rst | 233 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 234 insertions(+)
 create mode 100644 Documentation/iio/adxl380.rst

diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
new file mode 100644
index 000000000000..376dee5fe1dd
--- /dev/null
+++ b/Documentation/iio/adxl380.rst
@@ -0,0 +1,233 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ADXL380 driver
+===============
+
+This driver supports Analog Device's ADXL380/382 on SPI/I2C bus.
+
+1. Supported devices
+====================
+
+* `ADXL380 <https://www.analog.com/ADXL380>`_
+* `ADXL382 <https://www.analog.com/ADXL382>`_
+
+The ADXL380/ADXL382 is a low noise density, low power, 3-axis accelerometer with
+selectable measurement ranges. The ADXL380 supports the ±4 g, ±8 g, and ±16 g
+ranges, and the ADXL382 supports ±15 g, ±30 g, and ±60 g ranges.
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
+The following tables show the adxl380 related device files, found in the
+specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
+
++---------------------------------------------------+----------------------------------------------------------+
+| 3-Axis Accelerometer related device files         | Description                                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_scale                                    | Scale for the accelerometer channels.                    |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_filter_high_pass_3db_frequency           | Low pass filter bandwidth.                               |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_filter_high_pass_3db_frequency_available | Available low pass filter bandwidth configurations.      |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_filter_low_pass_3db_frequency            | High pass filter bandwidth.                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_filter_low_pass_3db_frequency_available  | Available high pass filter bandwidth configurations.     |
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
++----------------------------------+--------------------------------------------+
+| Temperature sensor related files | Description                                |
++----------------------------------+--------------------------------------------+
+| in_temp_raw                      | Raw temperature channel value.             |
++----------------------------------+--------------------------------------------+
+| in_temp_offset                   | Offset for the temperature sensor channel. |
++----------------------------------+--------------------------------------------+
+| in_temp_scale                    | Scale for the temperature sensor channel.  |
++----------------------------------+--------------------------------------------+
+
++------------------------------+----------------------------------------------+
+| Miscellaneous device files   | Description                                  |
++------------------------------+----------------------------------------------+
+| name                         | Name of the IIO device.                      |
++------------------------------+----------------------------------------------+
+| sampling_frequency           | Currently selected sample rate.              |
++------------------------------+----------------------------------------------+
+| sampling_frequency_available | Available sampling frequency configurations. |
++------------------------------+----------------------------------------------+
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
+The adis16475 driver offers data for 2 types of channels, the table below shows
+the measurement units for the processed value, which are defined by the IIO
+framework:
+
++-------------------------------------+---------------------------+
+| Channel type                        | Measurement unit          |
++-------------------------------------+---------------------------+
+| Acceleration on X, Y, and Z axis    | Meters per Second squared |
++-------------------------------------+---------------------------+
+| Temperature                         | Millidegrees Celsius      |
++-------------------------------------+---------------------------+
+
+Usage examples
+--------------
+
+Show device name:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat name
+        adxl382
+
+Show accelerometer channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
+        -1771
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
+        282
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
+        -1523
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_scale
+        0.004903325
+
+- X-axis acceleration = in_accel_x_raw * in_accel_scale = −8.683788575 m/s^2
+- Y-axis acceleration = in_accel_y_raw * in_accel_scale = 1.38273765 m/s^2
+- Z-axis acceleration = in_accel_z_raw * in_accel_scale = -7.467763975 m/s^2
+
+Set calibration offset for accelerometer channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        0
+
+        root:/sys/bus/iio/devices/iio:device0> echo 50 > in_accel_x_calibbias
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_calibbias
+        50
+
+Set sampling frequency:
+
+.. code-block:: bash
+
+	root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency
+        16000
+        root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency_available
+        16000 32000 64000
+
+        root:/sys/bus/iio/devices/iio:device0> echo 32000 > sampling_frequency
+        root:/sys/bus/iio/devices/iio:device0> cat sampling_frequency
+        32000
+
+Set low pass filter bandwidth for accelerometer channels:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_pass_3db_frequency
+        32000
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_pass_3db_frequency_available
+        32000 8000 4000 2000
+
+        root:/sys/bus/iio/devices/iio:device0> echo 2000 > in_accel_filter_low_pass_3db_frequency
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_filter_low_pass_3db_frequency
+        2000
+
+3. Device buffers
+=================
+
+This driver supports IIO buffers.
+
+All devices support retrieving the raw acceleration and temperature measurements
+using buffers.
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
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > scan_elements/in_temp_en
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
+        002bc300  f7 e7 00 a8 fb c5 24 80  f7 e7 01 04 fb d6 24 80  |......$.......$.|
+        002bc310  f7 f9 00 ab fb dc 24 80  f7 c3 00 b8 fb e2 24 80  |......$.......$.|
+        002bc320  f7 fb 00 bb fb d1 24 80  f7 b1 00 5f fb d1 24 80  |......$...._..$.|
+        002bc330  f7 c4 00 c6 fb a6 24 80  f7 a6 00 68 fb f1 24 80  |......$....h..$.|
+        002bc340  f7 b8 00 a3 fb e7 24 80  f7 9a 00 b1 fb af 24 80  |......$.......$.|
+        002bc350  f7 b1 00 67 fb ee 24 80  f7 96 00 be fb 92 24 80  |...g..$.......$.|
+        002bc360  f7 ab 00 7a fc 1b 24 80  f7 b6 00 ae fb 76 24 80  |...z..$......v$.|
+        002bc370  f7 ce 00 a3 fc 02 24 80  f7 c0 00 be fb 8b 24 80  |......$.......$.|
+        002bc380  f7 c3 00 93 fb d0 24 80  f7 ce 00 d8 fb c8 24 80  |......$.......$.|
+        002bc390  f7 bd 00 c0 fb 82 24 80  f8 00 00 e8 fb db 24 80  |......$.......$.|
+        002bc3a0  f7 d8 00 d3 fb b4 24 80  f8 0b 00 e5 fb c3 24 80  |......$.......$.|
+        002bc3b0  f7 eb 00 c8 fb 92 24 80  f7 e7 00 ea fb cb 24 80  |......$.......$.|
+        002bc3c0  f7 fd 00 cb fb 94 24 80  f7 e3 00 f2 fb b8 24 80  |......$.......$.|
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
index 9cb4c50cb20d..e84957ccdb2e 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -21,5 +21,6 @@ Industrial I/O Kernel Drivers
    ad7944
    adis16475
    adis16480
+   adxl380
    bno055
    ep93xx_adc
-- 
2.45.2


