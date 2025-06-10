Return-Path: <linux-iio+bounces-20397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2743BAD457E
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D350176174
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE229B777;
	Tue, 10 Jun 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnEIyQn4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394428BA95;
	Tue, 10 Jun 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592804; cv=none; b=f1RB8VpMCK/SIe0uF1UeUlBESgbR57qs83Aimgn+VxeIZeN6IoeEtAQ5wDNcMOMzj5j/go3Vxhd/rwtoRMmCdBEeKto2YBSoAzg1H5av49Syp9EA+7C8KtBE+A9vDURY+O4dzEknamLrXON/SdI3stmC5Dxey8a49J2S+ampOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592804; c=relaxed/simple;
	bh=JXp/+L4rKHxi/p+II76hnjQkQLdZkkvEl2EjQYDLvs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icWTTYzUANlhznl0huxg7wrKnxD2489djJW2Y7vQsoHSI1tfeY3Fb2WFSoZ+BTDOlb89uneHOtAkHJkDU5IITjcLd6esoRJKQwadwE3efy8NC0eu9lSjyLnZ92H7+kLhg0NK8NRz/qObbDK2+QoEbCAfyXl1ZY08+zbpsHOL44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnEIyQn4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45306433f71so2015155e9.0;
        Tue, 10 Jun 2025 14:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592797; x=1750197597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoxP6s5uxHp/o4oT/QnESDAwKlxvEu/SMGL9oOCHEqs=;
        b=MnEIyQn4OUFg++v13QXMoX+0fcsYHjw0I39gccLuJrDuVkVC/fJKHLLorJSba8KT66
         NsRHpOUL++19nYZPmtXsJv/00LIkCEQKDygUfPRPasXBceMnOnJpj5JYw51vFuaCG95s
         s4HsmC+znWa1yiJcRQZRb9DEWLaweO0zYY7rNRFqzbW2h4HmdNKydeKAdpbfsMegCgyO
         ACJikHgRmWfQrigm3j6QUXtHKY0Cipb81xqqQASuDqF3w8r8179uRRYj2raY3mCOckBM
         HO5FQa0PqYBegCBJD+fV78KAYmMdmw0vy/2XVlFphEEcMzkaxo8wWdTfx9Ja7BYc8ZTe
         okuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592797; x=1750197597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoxP6s5uxHp/o4oT/QnESDAwKlxvEu/SMGL9oOCHEqs=;
        b=Gd6z6vLQ8NrR8qsMNI5iS6qbcSyivIV4mZnZ/TCy7jrovExy/Suwign33KE2FAgmxn
         gLD4J0bP63INyMtxXPWsC3qau2EzD4HUmzXwjM7U+26c/U94g6om7h8/zx5SPaa/3Y3r
         D5qk9VSBRbjaTtYzdwYLjIa9Anuu/qyNv4NmJeQobVszOM82NU+el0M8Oc3DRjPJ4Snz
         V7Umcck4p0u3TviuXbh36/7VERShQWU80PsonnFYLcVFaDUBS7luRnc2fidHab9EKbcg
         pqVvtB/0nfzxLH0iPC9WlSqgZ6pKcEfE+SSSv/oAknxBXVqNtPHcGWasiPeugavaBVjo
         kGDg==
X-Forwarded-Encrypted: i=1; AJvYcCUIzPfegrKDh6sebDpb4leKx4LQoERPkO2wAGpby67NXmNkO+w79PQAtEwGDljr+poauvqialOiZTr5Ht58@vger.kernel.org, AJvYcCVWiJ36sdZlTyKlnnNg+Zr/lihizsM9Bv6+llvcLjW4Cj26YMN4WJsQgXr+2ejXmdnfLntubLKn3RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIG0tjdYdHbk/Ut66LYh0Q9w6NQ/DqI7Bz9JEFfEJ1ifi6wO9
	GVs1aqK+8RbpzdglQuJeopl3tOUcM57goaXyyMZjZG2Ml9qCFiGYzE4F
X-Gm-Gg: ASbGncu/1njH47BoNWuzTOr2w6MJtFMF5KrMRFWNiLYMfQ+4wUtmOKO8J//Bub2nxk5
	7bJW8XvfAecIINuxs2zjLqM3hXNVILPxg+tvnF84pu4h1ETlILxJJCp3kwNSOrLevhMOToBbJbB
	lHMV0PoHlylghk/KimKpPvgcWmhuM0jDhRx8KzzUBAm+MiseDrpkGSQLK3GlTh/PaXhoMh/HkQy
	ypKWiv/mK+xJXr23rOqHYg98hTfA/UKVu+RemPwQskHNjReQQGQUoCrZp/d1wRc8/4STATl6MgR
	s9il0EJqxyM1YFD44/KuJOxc+RLhwJI5xTAO0SXsPXxiZktxpD25oRypWNHZz+5LTkxIs2mVy7t
	8se1mgHeMutYhQkVszAwLAN5zOK+KpAwQ
X-Google-Smtp-Source: AGHT+IGwTojfGLY3oK/HaDh/HKr0Dq2Y1ed24RGPGOp9YQw7YiRKk2M4v2hJ8QJz3li8p4h9fcTExg==
X-Received: by 2002:a05:6000:40c9:b0:3a4:e667:9226 with SMTP id ffacd0b85a97d-3a558803f93mr194845f8f.10.1749592796422;
        Tue, 10 Jun 2025 14:59:56 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:55 -0700 (PDT)
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
Subject: [PATCH v9 11/11] docs: iio: add documentation for adxl345 driver
Date: Tue, 10 Jun 2025 21:59:33 +0000
Message-Id: <20250610215933.84795-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
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
 Documentation/iio/adxl345.rst | 429 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 430 insertions(+)
 create mode 100644 Documentation/iio/adxl345.rst

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
new file mode 100644
index 000000000000..2908c90dc943
--- /dev/null
+++ b/Documentation/iio/adxl345.rst
@@ -0,0 +1,429 @@
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
+Particular IIO events will be triggered by the corresponding interrupts. The
+sensor driver supports no or one active INT line, where the sensor has two
+possible INT IOs. Configure the used INT line in the devicetree. If no INT line
+is configured, the sensor falls back to FIFO bypass mode and no events are
+possible, only X, Y and Z axis measurements are possible.
+
+The following table shows the ADXL345 related device files, found in the
+specific device folder path ``/sys/bus/iio/devices/iio:deviceX/events``.
+Note, the default activity/inactivity is DC coupled. Thus only AC coupled
+activity and inactivity are mentioned explicitly.
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
+Find a detailed description of a particular functionality in the sensor
+datasheet.
+
+Setting the **ODR** explicitly will result in estimated adjusted default values
+for the inactivity time detection, where higher frequencies shall default to
+longer wait periods, and vice versa. It is also possible to explicitly
+configure inactivity wait times, if the defaulting approach does not match
+application requirements. Setting 0 here, will fall back to default setting.
+
+The **g range** configuration also tries to estimate activity and inactivity
+thresholds when switching to another g range. The default range will be
+factorized by the relation of old range divided by new range. The value never
+becomes 0 and will be at least 1 and at most 255 i.e. 62.5g/LSB according to
+the datasheet. Nevertheless activity and inactivity thresholds can be
+overwritten by explicit values.
+
+When **activity** and **inactivity** events are enabled, the driver automatically
+will implement its hysteresis solution by setting link bit and auto-sleep bit.
+The link bit serially links the activity and inactivity functions. On the other
+side, the auto-sleep function switches the sensor to sleep mode if the
+inactivity function is enabled. This will reduce current consumption to the
+sub-12.5Hz rate. Inactivity time can be configured between 1s and 255s. Aside of
+inactivity the sensor offers a free-fall detection. Free-fall detection is in
+terms of IIO the same kind of falling mag(nitude) event on all axis. In terms of
+the sensor, free-fall uses an inactivity period of 0.000s to 1.000s. The driver
+now implements the following: When an inactivity period of 1s or more is
+provided, it uses the inactivity register. This event may be linked to activity,
+use auto-sleep and can be AC-coupled or DC-coupled. When less than 1s of
+inactivity period is provided, it will behave as plain inactivity detection or
+free-fall, respectively. There won't be auto-sleep or coupling in such case.
+When 0.000s is configured as inactivity time, the driver will define a
+reasonable period of inactivity, depending on a heuristic approach to optimize
+power consumption (above 1s, so using the inactivity register).
+
+Note, using the activity register, the inactivity register, or the free-fall
+register is recommended for 12.5 Hz ODR up to 400 Hz. By the datasheet,
+free-fall threshold is recommended between 300mg and 600mg (0x05 to 0x09), and
+free-fall time is recommended to be set between 100ms and 350ms (0x14 to 0x46).
+
+In **DC-coupled** operation, the current acceleration magnitude is compared
+directly with THRESH_ACT and THRESH_INACT registers to determine whether
+activity or inactivity was detected. In AC-coupled operation for activity
+detection, the acceleration value at the start of activity detection is taken
+as a reference value. New samples are then compared to this reference value.
+Where DC-coupled is the default case detecting against the configured threshold,
+AC-coupled measurements are referenced against an internal filter depending
+on the configured threshold.
+Activity detection can be enabled on particular axis. Inactivity detection on
+the other side, is enabled or disabled on all axis.
+
+AC-coupling and DC-coupling are individually set for activity and/or
+inactivity detection, and cannot be set both at the same time. Enabling
+AC-coupled activity detection, and then DC-coupled activity detection will
+result in performing DC-coupled activity detection only. Hence, only the most
+recent configuration will valid.
+
+**Single tap** detection can be configured according to the datasheet by specifying
+threshold and duration. If only the single tap is in use, the single tap
+interrupt is triggered when the acceleration goes above threshold (i.e. DUR
+start) and below the threshold, as long as duration is not exceeded. If single
+tap and double tap are in use, the single tap is triggered when the double tap
+event has been either validated or invalidated.
+
+For **double tap** configure additionally window and latency in [us]. Latency
+starts counting when the single tap goes below threshold and is a waiting
+period, any spikes here are ignored for double tap detection. After latency,
+the window starts. Any rise above threshold, with a consequent fall below
+threshold within window time, rises a double tap signal when going below
+threshold.
+
+Double tap event detection is best described in the datasheet. After a
+single tap event was detected, a double tap event can be detected. Therefore the
+signal must match several criteria, and detection can also considered invalid
+for three reasons:
+* If the **suppress bit** is set and when still in the tap latency period, any
+measurement of acceleration spike above the tap threshold invalidates double tap
+detection immediately, i.e. during latency must not occur spikes for double tap
+detection when the suppress bit is set.
+* A double tap event is considered invalid, if acceleration lies above the
+threshold at the start of the window time for double tap.
+* Additionally, double tap detection can be considered invalid, if an
+acceleration exceeds the time limit for taps, set by duration register.
+
+Since for double tap the same duration counts, i.e. when measruements rise above
+threshold, a consequent falling below threshold has to be within duration time.
+Note here the suppress bit is generally set when double tap is enabled.
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


