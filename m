Return-Path: <linux-iio+bounces-6219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3504905BDE
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 21:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2B428682A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 19:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7701383CC1;
	Wed, 12 Jun 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r74LmvTJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A6A82D93
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220106; cv=none; b=C0rnM0wEfy73zoh9dnf4uU3cJg6q0Sb5FRqs+mbgO8CvoODREPaWoWE6gs3H52DxshVuQ56qrpDB1HIdNhlF0buJCZxzlkDfglNz7VMBdqiIg5c50GvQxvq2LpDUXjE3PHfLZWqdWBNVhuw023ASHbB1/JMwVkwffj+d7lDjrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220106; c=relaxed/simple;
	bh=nYTAeIKAQnbfKWEqhRPle1j756SIOQpvdGbjJq8DHmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8i4Dm70fLC4sOJYhcHjXmLEBjoFWzvAXQ5BBUhAyjeLG7Ld7cpmYjWOA1cfwh0+KhFGxo5hjI7IuWM5HD2He/IqOimKnQ6wjGi5MISlf9+ziCRMbrqtyIk+HWZqdNYbEsgekrE7qfrh0HswH7H2Rpnbkw06s8piD1DcmTvnZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r74LmvTJ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d226aff122so62271b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718220104; x=1718824904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWjk00AKWLCCc2wBmuv0MRbs0RIV4aO29ZnuU1Z2jqM=;
        b=r74LmvTJEi786hdPB17H0FI7tI/8MNGocXBMnZ9ksdS5YT0fwHcTyuSvYITil3QlrQ
         QnakzZbNdfgxSURix0k493GYPiGEjj50jj44tofx5mwoiXHh/JD0dAbEX5LSGQ8xaCbY
         eo8tyATaWdqDpLcRIDd+jMR1XMxKDbagQ14rgPJDJ2NXDMMpiqJ4+Nrd/1d61ku2bPIe
         hlY6pWDAphNjUwfx/a6kQB25VLArjrgt5JFNKVnQbLp7Qm0CqaJ9iHZYJXSubFUol7Hl
         oLSKfDUrSvuZ87g2xCraIDiXqUJXoP9uwMUb9eV4Deu8eboSfvYO3ivPEw+1h9EtsWi9
         2LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718220104; x=1718824904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWjk00AKWLCCc2wBmuv0MRbs0RIV4aO29ZnuU1Z2jqM=;
        b=chtNFR9KrN77XGEudRrLJBId0olT/ORTAH/itLwjeXd7V3Ylb3KUvPrlsvtPWBNoAd
         W2AEdqBYq8+fmO+YA5vO+ajC2OCjJhdN5RDEE+oLcY1X4dL1EdUChLWDY8/IkUZJ+k0U
         zBCCBVccS7HVfHDhLm4472p7TvSMojqtJpwWfkOQzXre0+jwTCiS+VM2IfsGHo25AvCG
         Y4hEx/YC5nCUzkLhHzknYSBEmHgOQc0A+jrGP9lMb93IKaF0Z4FDoJzy8VQ0UgEYfVez
         H2p48APVBpAcoJuB/ziB6I8hF6Lb9fBkjeJh7BPtFjggQ8fzSXV5lWP0QiV5UFo15mqV
         z0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXv3ujzO1dDxgU+JdLayFjTt5uaOnP15FUIoKrS1GNIeCMEdvvdnsm4LliDqcQV6WubeSE8Q3WMV7P1vRRZCCBG8Dp4kcRtloCV
X-Gm-Message-State: AOJu0YxHwy/ZtVbkCDbx7mTeIMDqx8t2Qmn6SzKEN+5XZVywvkRuKKnS
	zh8fjoCJwYoXdhkhe73EJqilZaXNTC5L6gG/E28xOYMMoUOo4+LzgvDY6qBPdDA=
X-Google-Smtp-Source: AGHT+IEa/VIxRkmieNYQk4VzRYdACSw5OtAZWDJEvPLtR8gg2MekPODBwYIt5gbwQDWgBopvLz4egg==
X-Received: by 2002:a05:6808:138e:b0:3d2:29c2:9600 with SMTP id 5614622812f47-3d23e00b19fmr3371146b6e.23.1718220103587;
        Wed, 12 Jun 2024 12:21:43 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d236676bfesm648795b6e.12.2024.06.12.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 12:21:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 3/3] Documentation: iio: Document ad4695 driver
Date: Wed, 12 Jun 2024 14:20:42 -0500
Message-ID: <20240612-iio-adc-ad4695-v1-3-6a4ed251fc86@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The Analog Devices Inc. AD4695 (and similar chips) are complex ADCs that
will benefit from a detailed driver documentation.

This documents the current features supported by the driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/iio/ad4695.rst | 145 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 147 insertions(+)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
new file mode 100644
index 000000000000..6e142561524e
--- /dev/null
+++ b/Documentation/iio/ad4695.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4695 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4695 and similar devices. The module name
+is ``ad4695``.
+
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD4695 <https://www.analog.com/AD4695>`_
+* `AD4696 <https://www.analog.com/AD4696>`_
+* `AD4697 <https://www.analog.com/AD4697>`_
+* `AD4698 <https://www.analog.com/AD4698>`_
+
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+The driver currently supports the following SPI wiring configuration:
+
+4-wire mode
+^^^^^^^^^^^
+
+In this mode, CNV and CS are tied together and there is a single SDO line.
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |          CS |<-+------| CS          |
+    |         CNV |<-+      |             |
+    |     ADC     |         |     HOST    |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+To use this mode, in the device tree, omit the ``cnv-gpios`` and
+``spi-rx-bus-width`` properties.
+
+Channel configuration
+---------------------
+
+Since the chip supports multiple ways to configure each channel, this must be
+described in the device tree based on what is actually wired up to the inputs.
+
+There are three typical configurations:
+
+Single-ended where a pin is used with the ``REFGND`` pin, pseudo-differential
+where a pin is used with the ``COM`` pin and differential where two ``INx``
+pins are used as a pair
+
+Single-ended input
+^^^^^^^^^^^^^^^^^^
+
+Each ``INx`` pin can be used as a single-ended input in conjunction with the
+``REFGND`` pin. The device tree will look like this:
+
+.. code-block::
+
+    channel@2 {
+        reg = <2>;
+    };
+
+This will appear on the IIO bus as the ``voltage2`` channel. The processed value
+(*raw × scale*) will be the voltage between the ``INx`` relative to ``REFGND``.
+(Offset is always 0 when pairing with ``REFGND``.)
+
+Pseudo-differential input
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Each ``INx`` pin can be used as a pseudo-differential input in conjunction with
+the ``COM`` pin. The device tree will look like this:
+
+.. code-block::
+
+    com-supply = <&vref_div_2>;
+
+    channel@3 {
+        reg = <3>;
+        adi,pin-pairing = "com";
+        bipolar;
+    };
+
+This will appear on the IIO bus as the ``voltage3`` channel. The processed value
+(*(raw + offset) × scale*) will be the voltage measured on ``INx`` relative to
+``REFGND``. (The offset is determined by the ``com-supply`` voltage.)
+
+Differential input
+^^^^^^^^^^^^^^^^^^
+
+An even-numbered ``INx`` pin and the following odd-numbered ``INx`` pin can be
+used as a differential pair. The device tree for using ``IN0`` as the positive
+input and ``IN1`` as the negative input will look like this:
+
+.. code-block::
+
+    channel@0 {
+        reg = <0>;
+        adi,pin-pairing = "next";
+        bipolar;
+    };
+
+This will appear on the IIO bus as the ``voltage0-voltage1`` channel. The
+processed value (*raw × scale*) will be the voltage difference between the two
+pins. (Offset is always 0 for differential channels.)
+
+VCC supply
+----------
+
+The chip supports being powered by an external LDO via the ``VCC`` input or an
+internal LDO via the ``LDO_IN`` input. The driver looks at the device tree to
+determine which is being used. If ``ldo-supply`` is present, then the internal
+LDO is used. If ``vcc-supply`` is present, then the external LDO is used and
+the internal LDO is disabled.
+
+Reference voltage
+-----------------
+
+The chip supports an external reference voltage via the ``REF`` input or an
+internal buffered reference voltage via the ``REFIN`` input. The driver looks
+at the device tree to determine which is being used. If ``ref-supply`` is
+present, then the external reference voltage is used and the internal buffer is
+disabled. If ``refin-supply`` is present, then the internal buffered reference
+voltage is used.
+
+Unimplemented features
+----------------------
+
+- Additional wiring modes
+- Buffered reads
+- Threshold events
+- Oversampling
+- Gain/offset calibration
+- GPIO support
+- CRC support
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 4c13bfa2865c..df69a76bf583 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -17,6 +17,7 @@ Industrial I/O Kernel Drivers
 .. toctree::
    :maxdepth: 1
 
+   ad4695
    ad7944
    adis16475
    adis16480
diff --git a/MAINTAINERS b/MAINTAINERS
index 611b7929e650..edd1a4e8f538 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1198,6 +1198,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+F:	Documentation/iio/index.rst
 F:	drivers/iio/dac/ad3552r.c
 
 ANALOG DEVICES INC AD4130 DRIVER

-- 
2.45.2


