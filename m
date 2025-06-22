Return-Path: <linux-iio+bounces-20880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1040EAE30A8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E217A64A4
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889EF20C487;
	Sun, 22 Jun 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZWKHnTQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4C4201000;
	Sun, 22 Jun 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607426; cv=none; b=jtDUEZBnzQjeRZoCqo+T6R3h5g/i7WTSxlnpaklnWO5frXmaMa6Lu9IkinezStI/j17AzSLJpfbVWBWzCsDBWwJD/yGnNdSCxIBQ/WE/llq297g9SDiwayDcoNjIps7LU59M3NF/M6JZvD6p8oVlHHd5OCchKrNg/EJtDJhVYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607426; c=relaxed/simple;
	bh=L0i1qY41Z5lFOGjmot818iJl0CIgBGpA94zMKQ2Ieo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0dNcdXpLCwagntzJeI+hR5zj5A3SNkkniNmvm9geWjecIK0DqexWZNvuQVvDSelBG7Yp/T9bVKpmIOo0+qQ4Dslv72Lu6bcMxEvIWv2kgPSTh5WVrR3dMzltEWMiepmujRzkoLKZWzlJjjqFYUgz0/b7NzrfxTAVVB1QmYT5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZWKHnTQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6071ac68636so730432a12.3;
        Sun, 22 Jun 2025 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607422; x=1751212222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFbA4nZrhIjOTRXo2cWFm3BgeSdAuZKyGSQo86/VIng=;
        b=LZWKHnTQSPtvO7UVxNGyw48ATrEx0a6RJp7H/5Lb754EDUqfQetZIj9pM+9vNDkJYs
         6VpkhSigMvq/0rQDs5RncF7Vgnn8f+rdAGlnOR4O41ODYXo1LkqM91dBSlX5hjpWf+sX
         4DdEND2ee5W1p/vBftjsy66DhxYbyfHGJPHZeNwsILtm1iRznRjzI1aczLTYqbda1fUu
         cPFYD3zcagFLvZM/0Vmz0gBDoZtV+m2init3dvNbVsvq3fTzKRYiEEoOl6dC5hmhqKyq
         Tbxo/npTFw6F7T6MqV+8CwQwsmGMruBeX4ny7jQ6/62/Su4x8AYo92Fqp7jCHdfPfbMA
         tYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607422; x=1751212222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFbA4nZrhIjOTRXo2cWFm3BgeSdAuZKyGSQo86/VIng=;
        b=ZsgAok4ndvF4uCNUN8+fD8/djbbgQiRH6CwHUownwpTbcNFFmcuhRKB1PN18U7j7Z5
         TDYjfOAl7FYaVTZtITcuNIFUjLQs74E+ALxjKWjyj8VYdyzPfinQwp2YoJ3aX6PqUUlK
         zvvcd2UW7gQ1Q/47H9O7PRa5om5OpSJt/ijs1oaOPb5L3wo4+utvhc9kQwR0PGXhg9+i
         pN2ggzu7qGBn2nkcbeGi/E5A1yygsx7PwRQfW+igt9DxqFTyDQDium8/RBu8WJhHCK35
         na8kfmJCbbYfBe8L6JcfcaWasC76wJWKuE9CFKa7HD5w15hZ7veSwybNlG3IVv/OFcJ6
         OrPw==
X-Forwarded-Encrypted: i=1; AJvYcCUqqOoFO207RxN9gsIWYeqjsToVf7TbI6T4WxBtPWOzQ2cC8CCWDKRYyE3YusGMhpKYsq1fVnvHizM=@vger.kernel.org, AJvYcCWws9QQc/1RrvNL1X8AvldL10g59lwctpapNAWVmeyloCmG8W2XIBOSp9F0F2y0LoLJeKqdWQ/M6IPXRXbi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51DxZjzEpH7cDyOkOFSosutCFmfFnZLPvPi+a6L/OPWLbIf3e
	HAh+h3L+7gP4VhZkHwH9qHBH4uf1GrMwbUUIao/qeKQoljrovgl+iD03
X-Gm-Gg: ASbGncuLpI2GIf/zAJNr0uFJiOdSbKod1DfuGpl1vZVkeARKwIOEGxamgprlDxO0O0q
	1sv+b/n9WQ3zAOG35RXxai3UXwYNNclkPE2+Co4gFm0bkr4EDWRE74CSnYQIDEjmV+fZzysA841
	fCtuALjWsovjAN6AnAD7rTGmSC6T+H8uh6nEug/LaeOsf+5Ef73hydOMU+TOVTnrQcQFZsxqFvs
	Bp5PQKVoY9QPWsA8gyxw2OZjuMl0kxkwHWJlnY/jtI6p1qImTXhakUMXZLDxnYfvVSnLLIx0Th3
	dZaAyNhTLUO5mA34z6stNqztk1BmkxRyCb9gI7K+ucKl2yj57Jlmt0jE8pX3ug4HCgFTqB7JmDY
	0p7mEbOIfgn/rdzQmXTwneMC6wjyoWLX6
X-Google-Smtp-Source: AGHT+IE2OJEy9k8zipk3u+wGBjOqMS3jnIP3IdhK9pcG/1Hy8h2gaTthzrK+P7y2VRP8GLKGZJAIoQ==
X-Received: by 2002:a17:907:97ca:b0:ad8:87d1:fec4 with SMTP id a640c23a62f3a-ae057927a02mr324379166b.7.1750607421825;
        Sun, 22 Jun 2025 08:50:21 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:21 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v10 7/7] docs: iio: add documentation for adxl345 driver
Date: Sun, 22 Jun 2025 15:50:10 +0000
Message-Id: <20250622155010.164451-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622155010.164451-1-l.rubusch@gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The documentation describes the ADXL345 driver, IIO interface,
interface usage and configuration.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/iio/adxl345.rst | 443 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 444 insertions(+)
 create mode 100644 Documentation/iio/adxl345.rst

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
new file mode 100644
index 000000000000..c5525267ea12
--- /dev/null
+++ b/Documentation/iio/adxl345.rst
@@ -0,0 +1,443 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ADXL345 driver
+===============
+
+This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
+
+1. Supported Devices
+====================
+
+* `ADXL345 <https://www.analog.com/ADXL345>`_
+* `ADXL375 <https://www.analog.com/ADXL375>`_
+
+The ADXL345 is a generic purpose low power, 3-axis accelerometer with selectable
+measurement ranges. The ADXL345 supports the ±2 g, ±4 g, ±8 g, and ±16 g ranges.
+
+2. Device Attributes
+====================
+
+Each IIO device, has a device folder under ``/sys/bus/iio/devices/iio:deviceX``,
+where X is the IIO index of the device. Under these folders reside a set of
+device files, depending on the characteristics and features of the hardware
+device in questions. These files are consistently generalized and documented in
+the IIO ABI documentation.
+
+The following table shows the ADXL345 related device files, found in the
+specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
+
++-------------------------------------------+----------------------------------------------------------+
+| 3-Axis Accelerometer related device files | Description                                              |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_sampling_frequency               | Currently selected sample rate.                          |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_sampling_frequency_available     | Available sampling frequency configurations.             |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_scale                            | Scale/range for the accelerometer channels.              |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_scale_available                  | Available scale ranges for the accelerometer channel.    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_calibbias                      | y-axis acceleration offset correction                    |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_calibbias                      | Calibration offset for the Z-axis accelerometer channel. |
++-------------------------------------------+----------------------------------------------------------+
+| in_accel_z_raw                            | Raw Z-axis accelerometer channel value.                  |
++-------------------------------------------+----------------------------------------------------------+
+
+Channel Processed Values
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
++-------------------------------------+---------------------------+
+| Channel type                        | Measurement unit          |
++-------------------------------------+---------------------------+
+| Acceleration on X, Y, and Z axis    | Meters per second squared |
++-------------------------------------+---------------------------+
+
+Sensor Events
+-------------
+
+Specific IIO events are triggered by their corresponding interrupts. The sensor
+driver supports either none or a single active interrupt (INT) line, selectable
+from the two available options: INT1 or INT2. The active INT line should be
+specified in the device tree. If no INT line is configured, the sensor defaults
+to FIFO bypass mode, where event detection is disabled and only X, Y, and Z axis
+measurements are available.
+
+The table below lists the ADXL345-related device files located in the
+device-specific path: ``/sys/bus/iio/devices/iio:deviceX/events``.
+Note that activity and inactivity detection are DC-coupled by default;
+therefore, only the AC-coupled activity and inactivity events are explicitly
+listed.
+
++---------------------------------------------+---------------------------------------------+
+| Event handle                                | Description                                 |
++---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_doubletap_en               | Enable double tap detection on all axis     |
++---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                   |
++---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latent in [us]                   |
++---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
++---------------------------------------------+---------------------------------------------+
+| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_rising_en                      | Enable activity detection on X axis         |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axis     |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axis    |
++---------------------------------------------+---------------------------------------------+
+| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis       |
++---------------------------------------------+---------------------------------------------+
+
+Please refer to the sensor's datasheet for a detailed description of this
+functionality.
+
+Manually setting the **ODR** will cause the driver to estimate default values
+for inactivity detection timing, where higher ODR values correspond to longer
+default wait times, and lower ODR values to shorter ones. If these defaults do
+not meet your application’s needs, you can explicitly configure the inactivity
+wait time. Setting this value to 0 will revert to the default behavior.
+
+When changing the **g range** configuration, the driver attempts to estimate
+appropriate activity and inactivity thresholds by scaling the default values
+based on the ratio of the previous range to the new one. The resulting threshold
+will never be zero and will always fall between 1 and 255, corresponding to up
+to 62.5 g/LSB as specified in the datasheet. However, you can override these
+estimated thresholds by setting explicit values.
+
+When **activity** and **inactivity** events are enabled, the driver
+automatically manages hysteresis behavior by setting the **link** and
+**auto-sleep** bits. The link bit connects the activity and inactivity
+functions, so that one follows the other. The auto-sleep function puts the
+sensor into sleep mode when inactivity is detected, reducing power consumption
+to the sub-12.5 Hz rate.
+
+The inactivity time is configurable between 1 and 255 seconds. In addition to
+inactivity detection, the sensor also supports free-fall detection, which, from
+the IIO perspective, is treated as a fall in magnitude across all axes. In
+sensor terms, free-fall is defined using an inactivity period ranging from 0.000
+to 1.000 seconds.
+
+The driver behaves as follows:
+* If the configured inactivity period is 1 second or more, the driver uses the
+  sensor's inactivity register. This allows the event to be linked with
+  activity detection, use auto-sleep, and be either AC- or DC-coupled.
+
+* If the inactivity period is less than 1 second, the event is treated as plain
+  inactivity or free-fall detection. In this case, auto-sleep and coupling
+  (AC/DC) are not applied.
+
+* If an inactivity time of 0 seconds is configured, the driver selects a
+  heuristically determined default period (greater than 1 second) to optimize
+  power consumption. This also uses the inactivity register.
+
+Note: It is recommended to use the activity, inactivity, or free-fall registers
+when operating with an ODR between 12.5 Hz and 400 Hz. According to the
+datasheet, the recommended free-fall threshold is between 300 mg and 600 mg
+(register values 0x05 to 0x09), and the suggested free-fall time ranges from
+100 ms to 350 ms (register values 0x14 to 0x46).
+
+In DC-coupled mode, the current acceleration magnitude is directly compared to
+the values in the THRESH_ACT and THRESH_INACT registers to determine activity or
+inactivity. In contrast, AC-coupled activity detection uses the acceleration
+value at the start of detection as a reference point, and subsequent samples are
+compared against this reference. While DC-coupling is the default mode-comparing
+live values to fixed thresholds-AC-coupling relies on an internal filter
+relative to the configured threshold.
+
+AC and DC coupling modes are configured separately for activity and inactivity
+detection, but only one mode can be active at a time for each. For example, if
+AC-coupled activity detection is enabled and then DC-coupled mode is set, only
+DC-coupled activity detection will be active. In other words, only the most
+recent configuration is applied.
+
+**Single tap** detection can be configured per the datasheet by setting the
+threshold and duration parameters. When only single tap detection is enabled,
+the single tap interrupt triggers as soon as the acceleration exceeds the
+threshold (marking the start of the duration) and then falls below it, provided
+the duration limit is not exceeded. If both single tap and double tap detections
+are enabled, the single tap interrupt is triggered only after the double tap
+event has been either confirmed or dismissed.
+
+To configure **double tap** detection, you must also set the window and latency
+parameters in microseconds (µs). The latency period begins once the single tap
+signal drops below the threshold and acts as a waiting time during which any
+spikes are ignored for double tap detection. After the latency period ends, the
+detection window starts. If the acceleration rises above the threshold and then
+falls below it again within this window, a double tap event is triggered upon
+the fall below the threshold.
+
+Double tap event detection is thoroughly explained in the datasheet. After a
+single tap event is detected, a double tap event may follow, provided the signal
+meets certain criteria. However, double tap detection can be invalidated for
+three reasons:
+
+* If the **suppress bit** is set, any acceleration spike above the tap
+  threshold during the tap latency period immediately invalidates the double tap
+  detection. In other words, no spikes are allowed during latency when the
+  suppress bit is active.
+
+* The double tap event is invalid if the acceleration is above the threshold at
+  the start of the double tap window.
+
+* Double tap detection is also invalidated if the acceleration duration exceeds
+  the limit set by the duration register.
+
+For double tap detection, the same duration applies as for single tap: the
+acceleration must rise above the threshold and then fall below it within the
+specified duration. Note that the suppress bit is typically enabled when double
+tap detection is active.
+
+Usage Examples
+--------------
+
+Show device name:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat name
+        adxl345
+
+Show accelerometer channels value:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_x_raw
+        -1
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_y_raw
+        2
+        root:/sys/bus/iio/devices/iio:device0> cat in_accel_z_raw
+        -253
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
+Given the 13-bit full resolution, the available ranges are calculated by the
+following formula:
+
+.. code-block:: bash
+
+        (g * 2 * 9.80665) / (2^(resolution) - 1) * 100; for g := 2|4|8|16
+
+Scale range configuration:
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_scale
+        0.478899
+        root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_scale_available
+        0.478899 0.957798 1.915595 3.831190
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1.915595 > ./in_accel_scale
+        root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_scale
+        1.915595
+
+Set output data rate (ODR):
+
+.. code-block:: bash
+
+        root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_sampling_frequency
+        200.000000
+
+        root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_sampling_frequency_available
+        0.097000 0.195000 0.390000 0.781000 1.562000 3.125000 6.250000 12.500000 25.000000 50.000000 100.000000 200.000000 400.000000 800.000000 1600.000000 3200.000000
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1.562000 > ./in_accel_sampling_frequency
+        root:/sys/bus/iio/devices/iio:device0> cat ./in_accel_sampling_frequency
+        1.562000
+
+Configure one or several events:
+
+.. code-block:: bash
+
+        root:> cd /sys/bus/iio/devices/iio:device0
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./buffer0/in_accel_x_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./buffer0/in_accel_y_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./buffer0/in_accel_z_en
+
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./scan_elements/in_accel_x_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./scan_elements/in_accel_y_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./scan_elements/in_accel_z_en
+
+        root:/sys/bus/iio/devices/iio:device0> echo 14   > ./in_accel_x_calibbias
+        root:/sys/bus/iio/devices/iio:device0> echo 2    > ./in_accel_y_calibbias
+        root:/sys/bus/iio/devices/iio:device0> echo -250 > ./in_accel_z_calibbias
+
+        root:/sys/bus/iio/devices/iio:device0> echo 24 > ./buffer0/length
+
+        ## AC coupled activity, threshold [62.5/LSB]
+        root:/sys/bus/iio/devices/iio:device0> echo 6 > ./events/in_accel_mag_adaptive_rising_value
+
+        ## AC coupled inactivity, threshold, [62.5/LSB]
+        root:/sys/bus/iio/devices/iio:device0> echo 4 > ./events/in_accel_mag_adaptive_falling_value
+
+        ## AC coupled inactivity, time [s]
+        root:/sys/bus/iio/devices/iio:device0> echo 3 > ./events/in_accel_mag_adaptive_falling_period
+
+        ## singletap, threshold
+        root:/sys/bus/iio/devices/iio:device0> echo 35 > ./events/in_accel_gesture_singletap_value
+
+        ## singletap, duration [us]
+        root:/sys/bus/iio/devices/iio:device0> echo 0.001875  > ./events/in_accel_gesture_singletap_timeout
+
+        ## doubletap, window [us]
+        root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_reset_timeout
+
+        ## doubletap, latent [us]
+        root:/sys/bus/iio/devices/iio:device0> echo 0.025 > ./events/in_accel_gesture_doubletap_tap2_min_delay
+
+        ## AC coupled activity, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_mag_adaptive_rising_en
+
+        ## AC coupled inactivity, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x\&y\&z_mag_adaptive_falling_en
+
+        ## singletap, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x_gesture_singletap_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_y_gesture_singletap_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_z_gesture_singletap_en
+
+        ## doubletap, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_gesture_doubletap_en
+
+Verify incoming events:
+
+.. code-block:: bash
+
+        root:# iio_event_monitor adxl345
+        Found IIO device with name adxl345 with device number 0
+        Event: time: 1739063415957073383, type: accel(z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1739063415963770218, type: accel(z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1739063416002563061, type: accel(z), channel: 0, evtype: gesture, direction: singletap
+        Event: time: 1739063426271128739, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        Event: time: 1739063436539080713, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        Event: time: 1739063438357970381, type: accel(z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1739063446726161586, type: accel(z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1739063446727892670, type: accel(z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1739063446743019768, type: accel(z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1739063446744650696, type: accel(z), channel: 0, evtype: mag, direction: rising
+        Event: time: 1739063446763559386, type: accel(z), channel: 0, evtype: gesture, direction: singletap
+        Event: time: 1739063448818126480, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        ...
+
+Activity and inactivity belong together and indicate state changes as follows
+
+.. code-block:: bash
+
+        root:# iio_event_monitor adxl345
+        Found IIO device with name adxl345 with device number 0
+        Event: time: 1744648001133946293, type: accel(x), channel: 0, evtype: mag, direction: rising
+          <after inactivity time elapsed>
+        Event: time: 1744648057724775499, type: accel(x&y&z), channel: 0, evtype: mag, direction: falling
+        ...
+
+3. Device Buffers
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
+        root:> iio_readdev -b 16 -s 1024 adxl345 | hexdump -d
+        WARNING: High-speed mode not enabled
+        0000000   00003   00012   00013   00005   00010   00011   00005   00011
+        0000010   00013   00004   00012   00011   00003   00012   00014   00007
+        0000020   00011   00013   00004   00013   00014   00003   00012   00013
+        0000030   00004   00012   00013   00005   00011   00011   00005   00012
+        0000040   00014   00005   00012   00014   00004   00010   00012   00004
+        0000050   00013   00011   00003   00011   00012   00005   00011   00013
+        0000060   00003   00012   00012   00003   00012   00012   00004   00012
+        0000070   00012   00003   00013   00013   00003   00013   00012   00005
+        0000080   00012   00013   00003   00011   00012   00005   00012   00013
+        0000090   00003   00013   00011   00005   00013   00014   00003   00012
+        00000a0   00012   00003   00012   00013   00004   00012   00015   00004
+        00000b0   00014   00011   00003   00014   00013   00004   00012   00011
+        00000c0   00004   00012   00013   00004   00014   00011   00004   00013
+        00000d0   00012   00002   00014   00012   00005   00012   00013   00005
+        00000e0   00013   00013   00003   00013   00013   00005   00012   00013
+        00000f0   00004   00014   00015   00005   00012   00011   00005   00012
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
index 2d6afc5a8ed5..c333720c1c9f 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -32,6 +32,7 @@ Industrial I/O Kernel Drivers
    adis16480
    adis16550
    adxl380
+   adxl345
    bno055
    ep93xx_adc
    opt4060
-- 
2.39.5


