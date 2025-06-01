Return-Path: <linux-iio+bounces-20108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57CAC9F9F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE33518937D8
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0D215181;
	Sun,  1 Jun 2025 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzymt3sX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644C1EF08F;
	Sun,  1 Jun 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798528; cv=none; b=O/uNlxiqExN+VdJTmZzEa/MUlKeMRnNCgMqc7+AbR/QGqxMWEisQNZhk3y4D+LQ6IUmQPHwaMd1p5TzVNpwK7v+mynIOGVPgiS/zYny4zamIE5Sqoj3vBKAlXYNQabjUxnr4nHMKbb3wFUu45ao7bFZgUK/EZiLUHOA/BQZUsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798528; c=relaxed/simple;
	bh=8g8ar4cXeCDAjuhnBvH3litFaqOrDIOGy2VHEcQ+BLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQbz40rIBwJVpdBdELESeuyk7HQRmCAtI0trnvXGQMI6R3SAZ2mtJ7d/+S+X/s9mXVH0o2iYbcapmV7A2Vtfnwyw7ry0Q01VKrdK4Y9wNA1RkzbjdIWgo3CWn82O6HB8CfLR0ERfNz+aKoEpfHgF8CjDiYQCrdgoIYXZ5t6fWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzymt3sX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a362e099cfso616425f8f.2;
        Sun, 01 Jun 2025 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798524; x=1749403324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWA6wADXu/RjEXUhFzdmubhVXmp7xexU+rNJAOzndxQ=;
        b=Dzymt3sX1Gi929vowAvTf+LtFCMHEzMIXeUm4fARxJg8m/1aUMMYKBWoftaoOPlLwl
         B3Z3eYBTac4PZKH1Bh/ImySLc84q4foB3syFxEDDqg1mTe4PYsrtxrciosB2VYXLqddg
         MxA9767PqWzQfXEn9JwU4ZebFJR709Y0paBh5HQ7pEvo7rPeb0e164N7ev1qg+vcWo7P
         VOv1Juojc+kXj5bEZpAQLwi5Y7jAlAmMc/BqVMhgTg+NVz5eDSSYKjlzIDueGWwOkRBX
         ZZQiX6DMO1LED7c3GwMO1+BLPHrb6Oc9CRpclHd/LsYFvN87HQFutCHAsh2CcveBHCfm
         /jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798524; x=1749403324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWA6wADXu/RjEXUhFzdmubhVXmp7xexU+rNJAOzndxQ=;
        b=lUR3b/YmrxtcvGVwvSeXwT7SUWzFNEQB5VfAEhYbQsHWbDNDgP3CJspwWKHZJ86TWn
         QCXvBTp8f+ZTQjeysWVxsnO7q7skXZoUHCJafhyGprO1R0fSFGYcrrYdHJEFl9lxwdw1
         PtsJWA0Wk0yg2M9aoOsZew8vdEbIwsb0/C20FW+NAMVf/PTgEQi9u+yc/zgNJfaPjAyb
         SzUOVYv+OXMWWkjXQ8rv8NekgLCk/FkR1RqMYw1V467NdJyTDNBvAgqOqSiG7hVVVGsI
         tYJoji4bQwmQ8idEKSJKlCpq0ikjfHXJ+y4qrKs5+7fqcAWDD72Pceq0UnsMfaH+DqKq
         x2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSNraCEeG7Y5BUVJ6OMQ4YThB3QPLr8b9cLzQ+VlkmJoQDLqIU7jE76csuAfuV0DuL/wNilyb6OMH+Xw0O@vger.kernel.org, AJvYcCXd7JoZDR53Y0jFDdnOYnLjuEwkpm/R6XSixTAqjkg3622i6LHhGQbGYHABqJibiFZL07cyy3xzEkTs@vger.kernel.org, AJvYcCXwGnf1aLC4fsGzCsi6PzL8NSxY2R0HZf6t6/Ms3EaqA9P5RWPFGPIu+UqO1CrD83YEJsi5q6q17YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZZujzWlO0GXXIamIY7I4Jk7jKppBQCJNHasLpMcBbajcO5Ul
	t3SUlm4uoxZ43Ni53kP/U4YkFNUfYkLQ4vVsn8j3SoSpPvlxk0B7WbuE
X-Gm-Gg: ASbGncuJ82KO39S77JD1Ck54DcXfG8nVEpkAPachQ3B+UFSpfovPyzRLC47kWgoDq7c
	+tKdznl3jW9UA79ow7lbH7qB8C+t5szJraWUDqpvqiYFjXXjHbDIWQz3vmQ7AuUhwu0VqZyQShv
	gCCdQHKCRowGHSMHLwENsRfKMvW68ZNuySPvEfJixGsqFNokfYmbpA4Hun/cZuwYPRNyRd3Pfhr
	hqEkQ3WBjZvPdEvmygsl/OrZCO9asIbrXeZFo0FVg4H0kBvKm4rUnWzsN8jHiyTu4rIiKDls8SS
	jJzRyp3/Wis3DIqnaSW/lISsQrJR03pW+EYuBQow/x9j23+q+h7kN6fTCYAU0jwSb2SkIREtxM7
	LRoB9JFvhJBoEbBc3qJA6Eg==
X-Google-Smtp-Source: AGHT+IFmhya/p+fGO5U2BjFziDYv5Gj+RHnAkaHLV5SPuDfaAwfDsWpZaED4F50eEAXYO08+SglbQg==
X-Received: by 2002:a5d:5f52:0:b0:3a4:dcfb:6f98 with SMTP id ffacd0b85a97d-3a4f8984976mr2556941f8f.14.1748798523533;
        Sun, 01 Jun 2025 10:22:03 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:22:03 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] docs: iio: add ADXL313 accelerometer
Date: Sun,  1 Jun 2025 17:21:39 +0000
Message-Id: <20250601172139.59156-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for the ADXL313 accelerometer driver.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/iio/adxl313.rst | 289 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 290 insertions(+)
 create mode 100644 Documentation/iio/adxl313.rst

diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
new file mode 100644
index 000000000000..e67171513f4a
--- /dev/null
+++ b/Documentation/iio/adxl313.rst
@@ -0,0 +1,289 @@
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
+The iio event related settings, found in ``/sys/bus/iio/devices/iio:deviceX/events``.
+
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_mag_adaptive_falling_period              | AC coupled inactivity time.                              |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_mag_adaptive_falling_value               | AC coupled inactivity threshold.                         |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_mag_adaptive_rising_value                | AC coupled activity threshold.                           |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_mag_falling_period                       | Inactivity time.                                         |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_mag_falling_value                        | Inactivity threshold.                                    |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_mag_rising_value                         | Activity threshold.                                      |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_x\&y\&z_mag_adaptive_falling_en          | Enable or disable AC coupled inactivity events.          |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_x\|y\|z_mag_adaptive_rising_en           | Enable or disable AC coupled activity events.            |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_x\&y\&z_mag_falling_en                   | Enable or disable inactivity events.                     |
++---------------------------------------------------+----------------------------------------------------------+
+| in_accel_x\|y\|z_mag_rising_en                    | Enable or disable activity events.                       |
++---------------------------------------------------+----------------------------------------------------------+
+
+The default coupling is DC coupled events. In this case the threshold will
+be in place as such, where for the AC coupled case an adaptive threshold
+(described in the datasheet) will be applied by the sensor. In general activity,
+i.e. ``ACTIVITY`` or ``ACTIVITY_AC`` and inactivity i.e. ``INACTIVITY`` or
+``INACTIVITY_AC``, will be linked with auto-sleep enabled when both are enabled.
+This means in particular ``ACTIVITY`` can also be linked to ``INACTIVITY_AC``
+and vice versa, without problem.
+
+Note here, that ``ACTIVITY`` and ``ACTIVITY_AC`` are mutually exclusive. This
+means, that the most recent configuration will be set. For instance, if
+``ACTIVITY`` is enabled, and ``ACTIVITY_AC`` will be enabled, the sensor driver
+will have ``ACTIVITY`` disabled, but ``ACTIVITY_AC`` enabled. The same is valid
+for inactivity. In case of turning off an event, it has to match to what is
+actually enabled, i.e. enabling ``ACTIVITY_AC`` and then disabling ``ACTIVITY``
+is simply ignored as it is already disabled. Or, as if it was any other not
+enabled event, too.
+
+Channels processed values
+-------------------------
+
+A channel value can be read from its _raw attribute. The value returned is the
+raw value as reported by the devices. To get the processed value of the channel,
+apply the following formula:
+
+.. code-block::
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
+The accelerometer values will be:
+
+- X-axis acceleration = in_accel_x_raw * in_accel_scale = 0.0191536 m/s^2
+- Y-axis acceleration = in_accel_y_raw * in_accel_scale = -0.5458779 m/s^2
+- Z-axis acceleration = in_accel_z_raw * in_accel_scale = 0.0191536 m/s^2
+
+Set calibration offset for accelerometer channels. Note, that the calibration
+will be rounded according to the graduation of LSB units:
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
+3. Device buffers and triggers
+==============================
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
+Enabling activity detection:
+
+.. code-block:: bash
+        root:/sys/bus/iio/devices/iio:device0> echo 1.28125 > ./events/in_accel_mag_rising_value
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x\|y\|z_mag_rising_en
+
+        root:/sys/bus/iio/devices/iio:device0> iio_event_monitor adxl313
+        Found IIO device with name adxl313 with device number 0
+        <only while moving the sensor>
+        Event: time: 1748795762298351281, type: accel(x|y|z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1748795762302653704, type: accel(x|y|z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1748795762304340726, type: accel(x|y|z), channel: 0, evtype: mag, direction: rising
+        ...
+
+Disabling activity detection:
+
+.. code-block:: bash
+        root:/sys/bus/iio/devices/iio:device0> echo 0 > ./events/in_accel_x\|y\|z_mag_rising_en
+        root:/sys/bus/iio/devices/iio:device0> iio_event_monitor adxl313
+        <nothing>
+
+Enabling inactivity detection:
+
+.. code-block:: bash
+        root:/sys/bus/iio/devices/iio:device0> echo 1.234375 > ./events/in_accel_mag_falling_value
+        root:/sys/bus/iio/devices/iio:device0> echo 5 > ./events/in_accel_mag_falling_period
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x\&y\&z_mag_falling_en
+
+        root:/sys/bus/iio/devices/iio:device0> iio_event_monitor adxl313
+        Found IIO device with name adxl313 with device number 0
+        Event: time: 1748796324115962975, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        Event: time: 1748796329329981772, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        Event: time: 1748796334543399706, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        ...
+        <every 5s now indicates inactivity>
+
+Now, enabling activity, e.g. the AC coupled counter-part ``ACTIVITY_AC``
+
+.. code-block:: bash
+        root:/sys/bus/iio/devices/iio:device0> echo 1.28125 > ./events/in_accel_mag_rising_value
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x\|y\|z_mag_rising_en
+
+        root:/sys/bus/iio/devices/iio:device0> iio_event_monitor adxl313
+        Found IIO device with name adxl313 with device number 0
+        <some activity with the sensor>
+        Event: time: 1748796880354686777, type: accel(x|y|z), channel: 0, evtype: mag_adaptive, direction: rising
+        <5s of inactivity, then>
+        Event: time: 1748796885543252017, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        <some other activity detected by accelerating the sensor>
+        Event: time: 1748796887756634678, type: accel(x|y|z), channel: 0, evtype: mag_adaptive, direction: rising
+        <again, 5s of inactivity>
+        Event: time: 1748796892964368352, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        <stays like this until next activity in auto-sleep>
+
+Note, when AC coupling is in place, the event type will be of ``mag_adaptive``.
+AC- or DC-coupled (the default) events are used similiarly.
+
+4. IIO Interfacing Tools
+========================
+
+See Documentation/iio/iio_tools.rst for the description of the available IIO
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


