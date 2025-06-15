Return-Path: <linux-iio+bounces-20693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C05ADA466
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0663D3B0159
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068E3284B50;
	Sun, 15 Jun 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X03PuSvB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0B26AA88;
	Sun, 15 Jun 2025 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026198; cv=none; b=fw96vOakDavTHJmjj1/jyGxotQQwjkdDxujBZgXDJ3+nk6JJhrT5MIopSe6W+1gpRyhP7Zl7sjXp1GJhWak4XpkcsQ08yLVQ+O7kg6I2aT5/OIoat5+vQIRwocMXW295GqG6liUPyRzRxW0bgVy10t+8RuTrZVuQJfUz5+dFVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026198; c=relaxed/simple;
	bh=WsfajTQgWR/cO00C+SHnb24AI3fAbG4PiwTdh6tZxV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIWczycs/mVwXc1RtXwzAPrh9hanldp07qDA3lXUT43zdGEEX5fXCZBMe+sUTJRZk46KgcNCnGTtzgSBIOUNkw5vkBSrrzlBxDEEbwKKwE3ARGR7Fkx4EmU7qQEqBMaknBN0g9lCH4yTg1ylr+6w4jNmTdngDtofqPmdYncsCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X03PuSvB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6075ca6d617so806353a12.0;
        Sun, 15 Jun 2025 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026195; x=1750630995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBUCh6MSsIltfKv0dnHBoCIz5u9pOT6OITU6c8QQY3w=;
        b=X03PuSvBtSzmTFXj9Bv+XgZTc3t0/NiXnUyLLnlTZnXLNnvH7Ne51p2r9Ug3pjZRWz
         DyT8Q/WZA9lskBMFoqIco6kIBPluRuOeNFZnPuEEiP1w+uFIRV1tVNqmdk93GZHpGb7Q
         fuv1LC4VkPgdYgLKkrsBHoFv7R+QoE7qeTUR4J+ikiG9H8NuVMasDVKGQzWTuclaitGC
         KnSoA28OBpjvzGQuwP8ufxY/LqOT4fzDtWzqNo7UBvVVQvnnuRG2713ztQcRbAIGc8Cq
         huonf8Eo1FbvWIcgR/GPD0vaV4aVY6QlGbwwerTF6xfz9IcAcccv1yCP8z3bInlh1qA0
         Vbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026195; x=1750630995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBUCh6MSsIltfKv0dnHBoCIz5u9pOT6OITU6c8QQY3w=;
        b=hOohgP4Zm9I45fyRYrW+uoICpz2CSzyZN8Hvbq8JesvFbLdYrLrOs76gAC7gSZfnZw
         UFnwlq+OXWvE0g6rnAUTV/ZghrvtqUTGPezloU+vnrYPuFRD5U28u3Xgpp/HEV2k18Kq
         +16/MpvJos4OJiDTBbYxI13A10ZHGbCIDUxpZ8iHMO6c3WprFE8d7p3qn8YWnCChDClq
         7A0SgpSwregwOQhAyRfQjFFz9XyO7ZlgttRtY8TBnXuvmOGc/m4jLV4gCpPhEw0RDQv1
         JZ2xC/rYt6jQXt3U2/GO/8A5d7pT7GRsEZjA6niDDZJUmkEJN6L0mtER9V7cs0VrP0f9
         1AuA==
X-Forwarded-Encrypted: i=1; AJvYcCVkHRpYpDBx8Fd4HRUgaDUFTbFTy8Q49/8vJVUf9pUvJXjD2kRdvRFQ0ypjp12pNAK9mDOaO1qraA/6RcsY@vger.kernel.org, AJvYcCWmqq6JPZbslv1SEwwkAl8hj2zqd9x2s2K9Jy5fJBKx3DNnmkeg648WUysYOnhtmfHZuLcKLRpzvGzy@vger.kernel.org, AJvYcCWrFV1RUt0ZUPq14r/X9Tc42mO00mzGfUu5snsq3bLTBlOE2+ya9rQcPyKE4sVAdwMuyCR+SS41L9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TUEZlE00pLxaErI3ptaynVoj08pYcXmfCBUz+pBtv6LAGfAg
	S3vvNJztEq7sIsww5RIUyzkflQxoK9WWOgEEY1dF6dgSUkQuRDzzceBR
X-Gm-Gg: ASbGncvyGHo+7RlE4rRi6BWIvqaVKslkHYU107C6iBdwb2CnxfII4xpyZBMsUpjUKIj
	8Q75oAtiFIS0yF8Y4jZvDR/4whiJDV0y4CBVOUHBkcKw4LhE/rRkzH8ORTnZBLEi77qPnx6np6t
	6AYJUBnXAhUCJTSsO0nlue8cKnF/SAjnzLBt07wvkgVpKzkxW3zbVRKUPrxWD1djRqPzBnewGn+
	SwT3Zdqnnmh1U4XHolVtK06Cs2SxBjQU0iGxf0DNy1dyNQBX34C8HNMDx3aTAemSynSL1zIPuc+
	GtGj4yQI3l4wQItGhc/D5M9uOQQsTUX0V52CaArNfkZNcAYDrgMv7oRICCaEOUmtCR4yh2iaL1d
	VAyFmD+aaJdqSs4g0XpeXV6bzhIWSfh2F
X-Google-Smtp-Source: AGHT+IGHzbbjTwNk7IiJC4hws7/ahBBcI73kBW5rdkHRxxDDMvs0h9622Ak9r9hg3k36TUriCgMMOg==
X-Received: by 2002:a17:906:c148:b0:ad8:9744:d0e2 with SMTP id a640c23a62f3a-adfad335350mr221083366b.1.1750026194401;
        Sun, 15 Jun 2025 15:23:14 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:14 -0700 (PDT)
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
Subject: [PATCH v5 8/8] docs: iio: add ADXL313 accelerometer
Date: Sun, 15 Jun 2025 22:22:58 +0000
Message-Id: <20250615222258.117771-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
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


