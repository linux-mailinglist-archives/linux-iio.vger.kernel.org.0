Return-Path: <linux-iio+bounces-19417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12956AB25AB
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305591B60F04
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34679257AED;
	Sat, 10 May 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMrSOgBk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C77223DD4;
	Sat, 10 May 2025 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917094; cv=none; b=nMfOSSrHuGv7L27EPAnHhyADshX0cGbw1mtutl2yB7kDas6VAP22OI5kQQefF7gv9xGrACQOIdnJY+HxL7kR2LdSJSU7UR25MK1beYp8co/o3N0OVGbo1rus+WAsWL6/qslcrnwHZ2pdNLFTf0fFhUeeRjcD9XGvzs8VF+IaaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917094; c=relaxed/simple;
	bh=4Xz5KZDz24ti8L/apPYOP7xXeFRY6Hd7wsMainWv4D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVDGSBKuE5HE0wKv3Pd+U1RReRwEYZySSd4gymtA0z9fhgzgm8wuoqPFuz2/wIvT2ISlT+23+Y8a/WLJvoKPnsC/ciIMfoPPq3kLdN8yr4rjcbAqnFqZJQkg8KB+7zADzlMbf27vdLuIc+AVoNXnqNHqhFyAAz/8i0IqvcZZ/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMrSOgBk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39d73b97500so208336f8f.3;
        Sat, 10 May 2025 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917089; x=1747521889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn3R+rOQ1OKbd846716wKmytorBAFqdUEALN8Wt6YpU=;
        b=iMrSOgBkSPJ615lehA59En2ZMsutTznIbTu3Z1U62JyeXH2uw+KhE7EDJgVTMoLHXL
         41Yyw5zUOa61pbyVZQph46RwZSCM8LHBCtoocQmZ5OlKopg4jEZvbhSv39ycv8fe5x9A
         CPiMcO8NVw/D+CMvi5PvE3+/wDIP7mHv30gNx4irL1l2V4JBLQmPrPFH5MozL2zQX/Yt
         5AKcaWYE/7zK16tgbxsWKm66wKmK91E+6xIGdEt8wNRNhiF0Ex54Ne4vckXh+F8Di+/X
         GM34HNk+B4rDMSpN70bpNVUuQw7lTHsphnXmFPDf4qvkalrgzAdByzfsbiSjgTOs+p2F
         9Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917089; x=1747521889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn3R+rOQ1OKbd846716wKmytorBAFqdUEALN8Wt6YpU=;
        b=hgf/a2VsQKNXSo+CHY4O2tkOtYkNb/KbOeJhB89ZOxvbdWS/qLWZyCHPIeEg0mnTRi
         wICNgAg7j3wJ6SorzK34F1rMcAZRduKX2MixH6VmyFmyKO9ud1zI4FdPyaUxhbFfZ9/y
         SxCEng45Zv9xJuEwZkhKnjIIP8Z3eOnkeNA+85wy6y9WdVNfeRNe0r0GYHD6kSfwPUUH
         vmtZLuxTC4pUJM9Li6Pu4iglXhi3gyQNktHqv8U7x4tmQ8hs8KBXMNuwxrGNALzmB+gb
         4CNxHzSXOBLrE0F2//S3OXHzR9o+RPZhTvxY+ML91P/DB9q4fB/M/lfftqIkqoh/Y5uf
         3mwg==
X-Forwarded-Encrypted: i=1; AJvYcCXqPOOSFVj56G822uQvMSd30y9DIfkbV3KVsUGq0aBF+31VG5BnSttYH4Co8Y7VXHy8OGQaViJnhQuhpYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8X21wB92B17kqFM5nEuEbSlM5txRTqHtxm0uFjjrrW/6rXgIu
	ywWsJFIrSHzo/trBzhsZPTWkpxMoIoEitt3+Y9DlLzy1AFGHYLPI
X-Gm-Gg: ASbGncv26bbPPhYFlmPONFNV9OvWjUIy7DOtHzOrYEKYTizapulENRSngjzQjnSMtKu
	pFPSyliKqo0R2nJuQfgCnx0Zwp9GmrzuSfQlPeIioWzHmTDwkhiBaKHb+sDB4XIkRAvQejHqE3H
	Dr8BXwWWbyYbw2vP+2Q8Z3undnJB+tZZMQiW2UhOaujk5oZDe5J10kMLvK5ezUZysArOzajs5Pj
	xPLVJVDrCBUYrE/0qASQQ9XuOj2gfLocYhgm/jtx2R+87msD9KkhEEpcV2hYk4dmckeE7P8mUH0
	Tbxt80tHKDhZ4+AN8JboVRpGgmv2oR1cONKdG7oNFY870DeplZhJcy3tg4ariIa4ptzNeXuTnrk
	uN93os+Tvo2t2FDoka40YlYMKsGadkFCg
X-Google-Smtp-Source: AGHT+IF/kevzwUSv2fDMlUCfRGH7kqv2lXwdbx4pOJdPCQcSYmW7N/G1vs5Mfl3Z+UM8eRKwvvtpxg==
X-Received: by 2002:a05:6000:2ce:b0:3a0:b6c3:9b80 with SMTP id ffacd0b85a97d-3a1f64401b1mr2470222f8f.6.1746917089235;
        Sat, 10 May 2025 15:44:49 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:48 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 7/7] docs: iio: add documentation for adxl345 driver
Date: Sat, 10 May 2025 22:44:05 +0000
Message-Id: <20250510224405.17910-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250510224405.17910-1-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
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
 Documentation/iio/adxl345.rst | 458 ++++++++++++++++++++++++++++++++++
 1 file changed, 458 insertions(+)
 create mode 100644 Documentation/iio/adxl345.rst

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
new file mode 100644
index 000000000000..e21b783153a6
--- /dev/null
+++ b/Documentation/iio/adxl345.rst
@@ -0,0 +1,458 @@
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
+| in_accel_mag_freefall_en                    | Enable free-fall detection on all axis      |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_freefall_period                | Free-fall detection time in us              |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_freefall_value                 | Free-fall threshold value in 62.5/LSB       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_referenced_falling_period      | AC coupled inactivity time in seconds       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_referenced_falling_value       | AC coupled inactivity threshold in 62.5/LSB |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_referenced_rising_value        | AC coupled activity threshold in 62.5/LSB   |
++---------------------------------------------+---------------------------------------------+
+| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x_mag_referenced_rising_en         | Enable AC coupled activity on X axis        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x_mag_rising_en                    | Enable activity detection on X axis         |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axis     |
++---------------------------------------------+---------------------------------------------+
+| in_accel_x&y&z_mag_referenced_falling_en    | Enable AC coupled inactivity on all axis    |
++---------------------------------------------+---------------------------------------------+
+| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_y_mag_referenced_rising_en         | Enable AC coupled activity on Y axis        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_y_mag_rising_en                    | Enable activity detection on Y axis         |
++---------------------------------------------+---------------------------------------------+
+| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis       |
++---------------------------------------------+---------------------------------------------+
+| in_accel_z_mag_referenced_rising_en         | Enable AC coupled activity on Z axis        |
++---------------------------------------------+---------------------------------------------+
+| in_accel_z_mag_rising_en                    | Enable activity detection on Z axis         |
++---------------------------------------------+---------------------------------------------+
+
+Find a detailed description of a particular functionality in the sensor
+datasheet.
+
+Setting the **ODR** explicitly will result in estimated adjusted default values
+for the inactivity time detection, where higher frequencies shall default to
+longer wait periods, and vice versa. It is also possible to explicetly
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
+will implement its hysteresis solution by setting link bit and autosleep bit.
+The link bit serially links the activity and inactivity functions. On the other
+side, the autosleep function switches the sensor to sleep mode if the
+inactivity function is enabled. This will reduce current consumption to the
+sub-12.5Hz rate. Inactivity time can be configured between 1s and 255s. When 0
+is configured as inactivity time, the driver will define a reasonable value
+depending on a heuristic approach to optimize power consumption.
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
+Note, AC-coupling and DC-coupling are individually set for activity and/or
+inactivity detection, and cannot be set both at the same time. Enabling
+AC-coupled activity detection, and then DC-coupled activity detection will
+result in performing DC-coupled activity detection only. Hence, only the most
+recent configuration will valid.
+
+**Single tap** detection can be configured according to the datasheet by specifying
+threshold and duration. If only the single tap is in use, the single tap
+interrupt is triggered when the acceleration goes above threshold (i.e. DUR
+start) and below the threshold, as long as duration is not exceeded. If single
+tap and double tap are in use, the single tap is triggered when the doulbe tap
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
+Note, since for double tap the same duration counts, i.e. when rising above
+threshold, a consequent falling below threshold has to be within duration time.
+Also note, the suppress bit is generally set when double tap is enabled.
+
+A **free-fall** event is detected if the measurement signal on all axis goes
+below the configured threshold for a configured period of time [us]. It is then
+reissued again and again. The generated magnitude event on the IIO channel is
+actually the same to the DC-coupled inactivity event. Since both can be
+considered as magnitude events on all axis (and'd). When using
+activity/inactivity detection and free-fall detection, it is probably the best
+approach o combine AC coupled activity/inactivity detection with free-fall.
+
+In situations with DC coupled activity/inactivity and free-fall enabled,
+activity/inactivity indicate the state change of the sensor with far higher
+periods [s], than the period taken for free-fall detection [us]. Probably the
+only way would be to verify the state change to inactive of the sensor in order
+to interprete a inactivity event rather than the typically more often happening
+free-fall event.
+
+Note, that activity/inactivy, as also free-fall is recommended for 12.5 Hz ODR
+up to 400 Hz. By the datasheet, free-fall threshold is recommended between 300mg
+and 600mg (0x05 to 0x09), and free-fall time is recommended to be set between
+100ms and 350ms (0x14 to 0x46).
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
+following forumla:
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
+        root:/sys/bus/iio/devices/iio:device0> echo 6 > ./events/in_accel_mag_referenced_rising_value
+
+        ## AC coupled inactivity, threshold, [62.5/LSB]
+        root:/sys/bus/iio/devices/iio:device0> echo 4 > ./events/in_accel_mag_referenced_falling_value
+
+        ## AC coupled inactivity, time [s]
+        root:/sys/bus/iio/devices/iio:device0> echo 3 > ./events/in_accel_mag_referenced_falling_period
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
+        ## free-fall, threshold [62.5/LSB]
+        root:/sys/bus/iio/devices/iio:device0> echo 8 > ./events/in_accel_mag_freefall_value
+
+        ## free-fall, time [ms]
+        root:/sys/bus/iio/devices/iio:device0> echo 1.25 > ./events/in_accel_mag_freefall_period
+
+        ## activity, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x_mag_referenced_rising_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_y_mag_referenced_rising_en
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_z_mag_referenced_rising_en
+
+        ## inactivity, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_x\&y\&z_mag_referenced_falling_en
+
+        ## free-fall, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_mag_freefall_en
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
-- 
2.39.5


