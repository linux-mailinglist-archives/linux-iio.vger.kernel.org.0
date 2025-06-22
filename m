Return-Path: <linux-iio+bounces-20855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FF3AE2FEA
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EC51715BD
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843101F8ACA;
	Sun, 22 Jun 2025 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCwJUIAy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F371E0489;
	Sun, 22 Jun 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595394; cv=none; b=psXKa3+D+fhA00AlCd3MITVJMHYwVZkQlrRGTdd6YqXyoAeJ+QPPNzPPq0VWZ36s+wDMqJ7vCe1kn0+U/1AR1yYsNLnQqHMFaRnkT5ONoRpVLwMYQHH2TYrATGVWn/iBYrkh74aDGuPJ5TFKvM1TzCAzsEBVmO8ltTBXOxhzQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595394; c=relaxed/simple;
	bh=jkBbAhmMyc0MVV9hyhNL21f7zsQ0Ubyu8peDPdVynZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUsI5dAP19FgDLEXbVH+VvzzZGA9kGv0DgA2oZbjnxEx/hWtvdNTK3F34LGrPh/3ib5vHc/qeiE2VSKJeYqNYgfi2KbLIbbEtcl7iq2HX//bnSnAW1dfEx6CB17GoinZwr8JIetZgevZO9uPA7MfcB0b0mp4tXG273l7513d+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCwJUIAy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6071ac68636so712909a12.3;
        Sun, 22 Jun 2025 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595390; x=1751200190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVBwNL6M5w5Yn3pFicOPIVN6N33/P4g9gmRLRuIsmOM=;
        b=HCwJUIAyZDqCEZQylFbue9UB8cKM/vrpBpFfUtSafcXd6AnqPacv4LI8i2RsySgocb
         m7tra7M7f7ketrbXmCQ9vslXo55KnomeGkGZJRAihy9flM7+zFpKEComl7B0z9/pXZhE
         DhFa2jAwVWq+NUKKUzBxe/k4JL6+x1EnSqVVJUmShjx6byIWZR02+XZhV19n3GKMb7me
         Wf+NApj08yO5iPuHANg3txqfG7Dkh45a4tWzHPDeTQUT1eyg5NgNQYLAhV5R5SJcJTh8
         CceKtZO4aQMDSPaAdad+Hsqtff8+XLriWHbFhT5INbSZgVC5t4nRq1rj7ER+0wiau5x5
         PK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595390; x=1751200190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVBwNL6M5w5Yn3pFicOPIVN6N33/P4g9gmRLRuIsmOM=;
        b=faFsgm9gtx9JrdnnYEzX83GKpyPgz53PkTkFNUjDycBBa2VFfZHN61M0RN1QQhI11j
         CU2MuXmFeztN4D6yS4EQGIxXZuTJK3EkvBbTkRoBzAm7TKnsU0GWT8meDopI8pQZBS5l
         pMmYlWoPQJ9O+LkraIg1HiIJL706UZ7zxhj1f/fcMbucgTUQpaxEIUqmK3ZH6DqKGbtz
         NjF+aUWiue0b7qEJ6ftEJXY72YGdas26iEu7IQBlfDtAGz7OF0leBwZHLGeAGDUIu2ui
         r2BywCLpJUfdqHR3sDQnX5tTjFJBdBv5PFJ0QOILcm8ztKMnEm/BbtD1RBmTnSFMDQtg
         f32g==
X-Forwarded-Encrypted: i=1; AJvYcCWDJqZQXwbTj6knghfepVqWGaeTPu3lEm++EtJV+gc1ypoua+kKv+3kLPeP0cskghYTK5Utm7Yc5P7n13is@vger.kernel.org, AJvYcCWNmikYu8/C+aJX0ZKadPajf+ZOeutYRW/UYkaCFI63oPeATAtNxjGN1pXdYEhUF15E2bTqs/KDvGA=@vger.kernel.org, AJvYcCXvBrWp5wQsX3RX9pb6ODcoc2qnE/eGuu4JOEBskHIh242K+d75wPA6ChgCpHjSi9in503ZA+KaqhZh@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8CU6+gj417WGC18/o6YpsC5C+zrv8ZusNv+GzZyZ0b+/YSTI
	8clCTFZvuzpeiU4IN5LGqrWWOzwU3HRBUzIl8AELeuVzmnosqhvoFbLt
X-Gm-Gg: ASbGncvLkCpb9Mw2QlKeIEL+eiP5TeGROhoNGPfjuDVxur/C3rn5tut0va6Ia5U+XWB
	/j5GLLJ6vDAzp8ZBs1fm/j09q8wxo7jdDpMbj7XRIjLZPglXFN5MC67ryXqVOZWq26hCYJYU6n9
	C4E2Tdo/PubPhlTavVPbkqr++YtCRieHz/baj3T56x8D1Dk3JggznCPc67Azyerv9BRhSanJLAg
	G1FawMXKxqZmof0YJhdHFoG+s0J3eEQJfcYW8Va4qCuKi0EoJ96/WuAnPQPw4dOE3JujwTN3aLK
	wxUHhIxTG4YL1s2PQQwVAse4TvopidBW4p1gd7tSfWm44CTnXMAmPP//nailtbZ++9RZz5c4EHJ
	fSCFfYCnEFp0OwuBwa5kT68vH3zrCDaYz
X-Google-Smtp-Source: AGHT+IHiVGUwTJbXhSjAreKhmm+w/wc9LHC2qTfHMwo2mrdogo8idyvtH6YcrOM1oE49YwCIoDyqJg==
X-Received: by 2002:a17:907:3ea7:b0:ad8:9b93:8579 with SMTP id a640c23a62f3a-ae05741069fmr260425566b.0.1750595389801;
        Sun, 22 Jun 2025 05:29:49 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:49 -0700 (PDT)
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
Subject: [PATCH v6 8/8] docs: iio: add ADXL313 accelerometer
Date: Sun, 22 Jun 2025 12:29:37 +0000
Message-Id: <20250622122937.156930-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622122937.156930-1-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for the ADXL313 accelerometer driver.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/iio/adxl313.rst | 289 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 290 insertions(+)
 create mode 100644 Documentation/iio/adxl313.rst

diff --git a/Documentation/iio/adxl313.rst b/Documentation/iio/adxl313.rst
new file mode 100644
index 000000000000..41b9cc37981c
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
+AC- or DC-coupled (the default) events are used similarly.
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


