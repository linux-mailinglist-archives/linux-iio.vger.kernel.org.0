Return-Path: <linux-iio+bounces-21278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98DBAF660B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454981C211AB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD08309A6B;
	Wed,  2 Jul 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iel2kQnM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158C2F6F86;
	Wed,  2 Jul 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497717; cv=none; b=qV36ivUhtKelfm1B61y0ya/Y1/mGFBVOtisHBTSi5c0YscL1bdaQciZsN8clqlz1nQgeRE8QGUDzxymsLqcBbxBq+8KB8reEylvu4B4SIvIDV48T7377ITcoyOwKJF6tC0pN0Qvo5erhdjbjzZVK6AGxpbsIDM5qN44Pi3ZiMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497717; c=relaxed/simple;
	bh=jkBbAhmMyc0MVV9hyhNL21f7zsQ0Ubyu8peDPdVynZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3mCtZBbqR6q+CAClgKscHRm5JVY0bayFleh7GtBZ4cx0Eh0o5hU53BxSzYGqeZxXzsILCCVqoWbmmLNTrKqfyqlQYapyHos9lxUeQJxJ15I+ksGTawcF7Bp9VNkU3UcNgETYi8enyPMznFXhdbrqT6iHHPkl/Z4giG97M2Cb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iel2kQnM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-606c6bb1d03so1171402a12.1;
        Wed, 02 Jul 2025 16:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497713; x=1752102513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVBwNL6M5w5Yn3pFicOPIVN6N33/P4g9gmRLRuIsmOM=;
        b=Iel2kQnMvhwk7ebEEFkoXegIe1V5hT9go+MxQf+6HKxhVdS4hkForUCFrGbBicmsd9
         eDjzeF60VW+MAfx8jEV6rlIClD4Mv94V9WsRAu6Slkc6brDHqInjTlrrueDH5sy0deaO
         8Y4ep6DZapYwvkLZBKv5oB5QEP2fLtHE4hyfpoRhYH6oDWufVG5GfIgefqV065GH+Pla
         XFc3yA2ZdPUR1AEMMyuU0q5KwigDZwChwdCLqbqC8kjG8EvN7of8CsJ8dZekC1ZIlvBS
         V8fqmym97wvEsgWlSP+sglEOanzZE1OOgUWGTz+1soCZSSDfFB+anZU3IDRLyboRl+Bs
         l1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497713; x=1752102513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVBwNL6M5w5Yn3pFicOPIVN6N33/P4g9gmRLRuIsmOM=;
        b=Iu1xqsSGWfn2MViBkmMR9EfdCsLx1M3vFEVcHezcehynRu9Hy8o8Lgtajvc3IU0mP2
         8u0wk+sD0AWagxkk6NtOTh6/40mvw4OM1LpVyYWS5YJGudnD9BgV3cU/6vug/URU1wlX
         QrAU7ccx6aVHQ2T1UzROF93GrJY6448PAS9ex6YuvpvI+DQ4TM57hzVV0URiHao+uNHR
         aqI6i0S7JuT7fcW97s2HR2RK5SrA/sq/4pxhDbTqX4LL0+bk1YVYsIsuCqdareA0zOdk
         a9wnKZDTFRRsWz7Rvg9KyL0O2t+n61j0S+z7mRimaD5+zwjkIcrab6uBn/cSr7vhyLM4
         lxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDqbJAAODfrdjt9XTyX7rGPSvbqURWA/al0e8ncSacY50a8TdEPVmUDMyEiDwoFN15BGjVuXrtNpuUG7Y+@vger.kernel.org, AJvYcCUVq+7Hl+/D0c/LlfxuEnADuiTLp2918MmDKiWE7mKUfVIiF2X46iK2MjU2bk3xYKP7pv0MaJdtBPEz@vger.kernel.org, AJvYcCVF/ANGzv/hb5zS6DB9OyIb7BNAo/gM6+Hd1ZnFgRDMV+sYago6JkHiJGY+Hs6hTOi/vCrf6sBulN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmSG3F8jems+uJrNf4f8pZwfHICY02CN7t/QjkgrDB1yDPpTU
	tdZibKq+NP010RBiPd5vbOlOKQN5w3Ut7CZtI+FN5UZee15M9fuPMPtz
X-Gm-Gg: ASbGnctItdoilG+PbmZcaJpHyam0wFAxwF0JGrWdMlhvpQwEXCo71x4PoJPLaaKI9PO
	tuYp29Fqvpn6Sts0qWPnsqbmhyBSxB/fdlD3JB7ysaGsGCZBAtFOEsObJg7wSXqickp1XRaCiU4
	jSq6M2YDHsIoQL2wgmLPpCXqwWvk3xB6vka51w/1hHtkb5Gm5dAb326RIeH0InoAJD0ZvheJ3HE
	k6NqfW+9j6GtLFC4NL8fUBl6y8fid51MI62zbsb4tbwsZAst5ObDlilGH3qM6wQsEXiaePxA1/k
	ztSKpJtsd+wG+QjhEOB9J85r6EdC+OabEWQlcWvryINiGwLJWiWx5MqR0qALabfD5uh0w/cDuHc
	mYnKTxN4oxrACCOD6WlYUA6s3AIzdykZ8
X-Google-Smtp-Source: AGHT+IEpv3HHtORLiwaicK/Hll0VtR5UFuFah+y3+rr4z8H2KVvW5KE6CfAyqZLCfiM/b7L9QwRwUg==
X-Received: by 2002:a17:907:3d8c:b0:ae0:ba0e:ae59 with SMTP id a640c23a62f3a-ae3e2587026mr6383966b.7.1751497713121;
        Wed, 02 Jul 2025 16:08:33 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:32 -0700 (PDT)
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
Subject: [PATCH v7 8/8] docs: iio: add ADXL313 accelerometer
Date: Wed,  2 Jul 2025 23:08:19 +0000
Message-Id: <20250702230819.19353-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
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


