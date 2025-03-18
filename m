Return-Path: <linux-iio+bounces-17067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF1A6808F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9167A9A85
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E77121A438;
	Tue, 18 Mar 2025 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu9hrKU0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868D217647;
	Tue, 18 Mar 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339352; cv=none; b=JiEYBtnfmLPP6urlS9Y8TEv50nsbAhmt4KUJMsshMJce7epR3W6FjaqViO9OtkU7D+ze3f4vrfkiw3PYS46Hhos+CAHgxMxY+Fs120oXyUP6aHs2N6TaMYNtNG/jwU41s1DrzNgqHinu/3mrOwUIVXfaFlDzruaTxU1t5Nnt5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339352; c=relaxed/simple;
	bh=J+gxOK9BmXWp+MSs2VJ9oOXAZgisi21PoNI0mvLG0p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhNrIqYAiX6M2g9hDbO9WeN7O0FT5UIIcBE9rR1YqKYQSJrhb9W7000Ph9GWFmdfrfRsX2ToLHAFs1Ky5c8HJuH+FutIndx9GdGt+Q7VvqOz6dN8f9O45UBemaBuKzMY7mGDGpjbgnIa6THFuxyQ3wK4Fv7nQMcH9BTz3fYnvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu9hrKU0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912622c9c0so974611f8f.3;
        Tue, 18 Mar 2025 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339348; x=1742944148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v27Lnlqr3GEvQfW7w8hZ2MQ04yP2vRncP9MW1QBJDBo=;
        b=mu9hrKU043hBbDKsyeNZju7gHGCJDtFj69zHwQhA1Gr0HQIqSLAor8JxW+mitTjoGA
         qXEaCq0GLWNlauEXOTtOzR6Q9dJmprYRm/eTHH6qQVnUZ35Z0pxAgZUJSzjqWGa/BZmw
         +2fr3EYboQ4N9KlDbUNxS51XWqH1mJAZhi23wI0VQ4T5MMFbH2lPcRz2aN1+GdZS/zNt
         +ld9OYBt3CKhBB72vMXBIgNYiKOhBTEswSd02bStqxxxOrr09FX0RQvZ4ZmjJSKgmKLt
         Rz5dvSs+xK8YdlQ2067kqSH/AeDV8A2i/hQneuKAksBvBvleUtDXxFIxoiabC3nEKGvp
         8Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339348; x=1742944148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v27Lnlqr3GEvQfW7w8hZ2MQ04yP2vRncP9MW1QBJDBo=;
        b=kJWDmDYgtUEZ48Fspbl00uselwE6IQXBuvWtEJifrn/NWTZWqeBOOM2bl6RWGg9BTm
         DazY8QZBUp1NICk1WjPthOtNZ19Y713K9yTa2S+DSCsccIMO3IRiA5jDNz+Ld793iNN7
         mMPL5SpHNBPg+tV0+TY3DgIjn2jW9kwjnhF/7+PYfe34/KTOE2b9hRYEjpG8hmWmPA9a
         wu8uMVfKvVw4xhUx8b4uR4xIpFDNMn8od2bRkSRIMNe5do4qZ/v6A2VAyijhTdSGgomC
         eZ5jx5Lp+/HM4hWtE5mCzIw2ayQQCNHggfcDmlXWaOkY7utJDXdSkbGlzZY8NJ/z5BEr
         MO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd8Km+NaXAD1k1refxZNGsGxM1T42e6HLpjcKbb2CPWexQo0n0Bs4usFqa+h5Lzawnaj40t7OJ9O+IL78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1onkO4JtFki3SFQ3+v1AVpfBTvctV4y8oeY+EYF+IwnYkGMV+
	JLoP5zLxch2PuFxqfNb+TiU4sasKN+QMD+Kja0D8e43QHVOsGS2E
X-Gm-Gg: ASbGncuy9++UKh5EeOxzHaXzWS0X2VpOvEhT6dXARtjXkKmglRjCONY0QFASoe9Pzf6
	KE7zHXdlk313tpXREU+AJyAmiYlLfOg7uDD3gNnm2VdYv82ZFuuHkK0KHPzAPEKOLBFw33HRwSG
	Wimn7uRPACi91siFRAUUFtIVbkSrfMyYD8qZ/H4mpFjerhT/SLFSGJRWocHTmYV/8azLBDx57NN
	tveKW+a2lIVFyudUxiWogQypzyqWBE31NyWWr5oe7jwSSNRLWmAe9xGhIpjmQROjsRPk8pbYI3g
	YadKH+tXs/6B0h803UcCHd/lkqSldiSsgMtJkn+WEqtrhObuU+yZZvWvkNZHeJfzvwnNlbRySrD
	7LwWEvhBC/riNRwSflA1NPek=
X-Google-Smtp-Source: AGHT+IGTtMtxOyij+GGKSngUqHx9Rsujxs1eXlbYqiBISFC7AJYW2SM+68JLvrRt9XcxuXh9gbLAoQ==
X-Received: by 2002:a05:600c:3503:b0:43d:2318:ed7f with SMTP id 5b1f17b1804b1-43d436c8322mr1186375e9.0.1742339347702;
        Tue, 18 Mar 2025 16:09:07 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:09:07 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 11/11] docs: iio: add documentation for adxl345 driver
Date: Tue, 18 Mar 2025 23:08:43 +0000
Message-Id: <20250318230843.76068-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318230843.76068-1-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
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
 Documentation/iio/adxl345.rst | 416 ++++++++++++++++++++++++++++++++++
 1 file changed, 416 insertions(+)
 create mode 100644 Documentation/iio/adxl345.rst

diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
new file mode 100644
index 000000000000..683121c1a435
--- /dev/null
+++ b/Documentation/iio/adxl345.rst
@@ -0,0 +1,416 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+ADXL345 driver
+===============
+
+This driver supports Analog Device's ADXL345/375 on SPI/I2C bus.
+
+1. Supported devices
+====================
+
+* `ADXL345 <https://www.analog.com/ADXL345>`_
+* `ADXL375 <https://www.analog.com/ADXL375>`_
+
+The ADXL345 is a generic purpose low power, 3-axis accelerometer with selectable
+measurement ranges. The ADXL345 supports the ±2 g, ±4 g, ±8 g, and ±16 g ranges.
+
+2. Device attributes
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
+Channel processed values
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
+Sensor events
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
+
++---------------------------------------------+-----------------------------------------+
+| Event handle                                | Description                             |
++---------------------------------------------+-----------------------------------------+
+| in_accel_gesture_doubletap_en               | Enable double tap detection on all axis |
++---------------------------------------------+-----------------------------------------+
+| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]               |
++---------------------------------------------+-----------------------------------------+
+| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latent in [us]               |
++---------------------------------------------+-----------------------------------------+
+| in_accel_gesture_singletap_timeout          | Single tap duration in [us]             |
++---------------------------------------------+-----------------------------------------+
+| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB  |
++---------------------------------------------+-----------------------------------------+
+| in_accel_mag_falling_en                     | Enable free fall detection              |
++---------------------------------------------+-----------------------------------------+
+| in_accel_mag_falling_period                 | Free fall time in [us]                  |
++---------------------------------------------+-----------------------------------------+
+| in_accel_mag_falling_value                  | Free fall threshold value in 62.5/LSB   |
++---------------------------------------------+-----------------------------------------+
+| in_accel_mag_referenced_falling_en          | Set 1 to AC-coupled inactivity, 0 for DC|
++---------------------------------------------+-----------------------------------------+
+| in_accel_mag_referenced_rising_en           | Set 1 to AC-coupled activity, 0 for DC  |
++---------------------------------------------+-----------------------------------------+
+| in_accel_x_thresh_falling_en                | Enable inactivity detection on X axis   |
++---------------------------------------------+-----------------------------------------+
+| in_accel_y_thresh_falling_en                | Enable inactivity detection on Y axis   |
++---------------------------------------------+-----------------------------------------+
+| in_accel_z_thresh_falling_en                | Enable inactivity detection on Z axis   |
++---------------------------------------------+-----------------------------------------+
+| in_accel_thresh_falling_period              | Inactivity time in seconds              |
++---------------------------------------------+-----------------------------------------+
+| in_accel_thresh_falling_value               | Inactivity threshold value in 62.5/LSB  |
++---------------------------------------------+-----------------------------------------+
+| in_accel_x_thresh_rising_en                 | Enable activity detection on X axis     |
++---------------------------------------------+-----------------------------------------+
+| in_accel_y_thresh_rising_en                 | Enable activity detection on Y axis     |
++---------------------------------------------+-----------------------------------------+
+| in_accel_z_thresh_rising_en                 | Enable activity detection on Z axis     |
++---------------------------------------------+-----------------------------------------+
+| in_accel_thresh_rising_value                | Activity threshold value in 62.5/LSB    |
++---------------------------------------------+-----------------------------------------+
+| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis   |
++---------------------------------------------+-----------------------------------------+
+| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis   |
++---------------------------------------------+-----------------------------------------+
+| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis   |
++---------------------------------------------+-----------------------------------------+
+
+Find a detailed description of a particular functionality in the sensor
+datasheet.
+
+Setting the ODR explicitly will result in estimated adjusted default values
+for the inactivity time detection, where higher frequencies shall default to
+longer wait periods, and vice versa. It is also possible to explicetly
+configure inactivity wait times, if the defaulting approach does not match
+application requirements. Setting 0 here, will fall back to default setting.
+
+The g range configuration also tries to estimate activity and inactivity
+thresholds when switching to another g range. The default range will be
+factorized by the relation of old range divided by new range. The value never
+becomes 0 and will be at least 1 and at most 255 i.e. 62.5g/LSB according to
+the datasheet. Nevertheless activity and inactivity thresholds can be
+overwritten by explicit values.
+
+When activity and inactivity events are both enabled, the driver automatically
+will implement its hysteresis solution by setting link bit and autosleep bit.
+The link bit serially links the activity and inactivity functions. On the other
+side, the autosleep function switches the sensor to sleep mode if the
+inactivity function is enabled. This will reduce current consumption to the
+sub-12.5Hz rate.
+
+In dc-coupled operation, the current acceleration magnitude is compared
+directly with THRESH_ACT and THRESH_INACT registers to determine whether
+activity or inactivity was detected. In ac-coupled operation for activity
+detection, the acceleration value at the start of activity detection is taken
+as a reference value. New samples are then compared to this reference value.
+Note, ac-coupling and dc-coupling are individually set for activity and/or
+inactivity detection. Activity and inactivity detection are dependent on the
+direction, i.e. the x/y/z axis where this driver generally enables all
+directions. Also, the direction settings are particular to activity and
+inactivity detection, respectively.
+
+Single tap detection can be configured according to the datasheet by specifying
+threshold and duration. If only the single tap is in use, the single tap
+interrupt is triggered when the acceleration goes above threshold (i.e. DUR
+start) and below the threshold, as long as duration is not exceeded. If single
+tap and double tap are in use, the single tap is triggered when the doulbe tap
+event has been either validated or invalidated.
+
+For double tap configure additionally window and latency in [us]. Latency
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
+* If the suppress bit is set and when still in the tap latency period, any
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
+A free fall event will be detected if the signal goes below the configured
+threshold, for the configured time [us].
+
+Note, that activity/inactivy, as also freefall is recommended for 12.5 Hz ODR
+up to 400 Hz.
+
+Usage examples
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
+        ## activity, threshold [62.5/LSB]
+        root:/sys/bus/iio/devices/iio:device0> echo 6 > ./events/in_accel_thresh_rising_value
+
+        ## inactivity, threshold, [62.5/LSB]
+        root:/sys/bus/iio/devices/iio:device0> echo 4 > ./events/in_accel_thresh_falling_value
+
+        ## inactivity, time [s]
+        root:/sys/bus/iio/devices/iio:device0> echo 3 > ./events/in_accel_thresh_falling_period
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
+        ## freefall, threshold [62.5/LSB]
+        root:/sys/bus/iio/devices/iio:device0> echo 8 > ./events/in_accel_mag_falling_value
+
+        ## freefall, time [ms]
+        root:/sys/bus/iio/devices/iio:device0> echo 1.25 > ./events/in_accel_mag_falling_period
+
+        ## activity, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_thresh_rising_en
+
+        ## inactivity, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_thresh_falling_en
+
+        ## freefall, enable
+        root:/sys/bus/iio/devices/iio:device0> echo 1 > ./events/in_accel_mag_falling_en
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
+        Event: time: 1739063415957073383, type: accel(z), channel: 0, evtype: thresh, direction: rising
+        Event: time: 1739063415963770218, type: accel(z), channel: 0, evtype: thresh, direction: rising
+        Event: time: 1739063416002563061, type: accel(z), channel: 0, evtype: gesture, direction: singletap
+        Event: time: 1739063426271128739, type: accel(x|y|z), channel: 0, evtype: thresh, direction: falling
+        Event: time: 1739063436539080713, type: accel(x|y|z), channel: 0, evtype: thresh, direction: falling
+        Event: time: 1739063438357970381, type: accel(z), channel: 0, evtype: thresh, direction: rising
+        Event: time: 1739063446726161586, type: accel(z), channel: 0, evtype: thresh, direction: rising
+        Event: time: 1739063446727892670, type: accel(z), channel: 0, evtype: thresh, direction: rising
+        Event: time: 1739063446743019768, type: accel(z), channel: 0, evtype: thresh, direction: rising
+        Event: time: 1739063446744650696, type: accel(z), channel: 0, evtype: thresh, direction: rising
+        Event: time: 1739063446763559386, type: accel(z), channel: 0, evtype: gesture, direction: singletap
+        Event: time: 1739063448818126480, type: accel(x|y|z), channel: 0, evtype: thresh, direction: falling
+        ...
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


