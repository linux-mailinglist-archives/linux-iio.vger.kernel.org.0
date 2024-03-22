Return-Path: <linux-iio+bounces-3684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B748874A0
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 22:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56057283BC6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 21:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728281AD1;
	Fri, 22 Mar 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="grXDyUPk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F5811E0
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711144346; cv=none; b=GqjgRDO7Ky9XP/YdFALEYITrGoBxFuc7Aw4BhhKCbXxv/fntB6DtxushR+1jnh572xwSic/2WSOxccBXPIMcE+m8if9+pjZn1TeQmpxojtJPY4Q0vygacapNSuUvrH7pd6/swXQjmx1b4LG3oNojrQtV+bvP73PEJs08ZcdKTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711144346; c=relaxed/simple;
	bh=05yOjqGVHPu+OFaxcjpZYk3lFnQvrC2NngC+2ZecgJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiVjuSFX2R7g7DcCtAooiR+QSTb1CmSlQhtaPcPH38TcMEl3cOJ26+pTBYWsYW4w/o6uZPkYYjbLzyHtYYKS2jmZacJQxoUG2GGaN0Rq6OLasNi5Hh39Owcw4OgSqbv8WtCQxIFmNJfj+UEzVmf9ljbZmXKy66Wx4ff0QaggAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=grXDyUPk; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c36f882372so1569388b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711144343; x=1711749143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxA/Vj3a1BgHptKDUbOtB0zHeYp5zxSd/aJ7ZP3EJ40=;
        b=grXDyUPk3uH8va4jmUwKxaBBVHbCBSF/L9XPnc3ylreDYg/oqWsDqLzoMLk4GCc5yn
         zobKSHQF0k65s6WayqE+ERAWVZilVkli07BwyHfvSmMH7ifdEAyKRQTwTlIbqXBk+wGf
         N1oF87RCGZvMHwgAkEB0OIngjv617ks91SYjod015Z9lPyRVFrgZd6Mnvt5xoLL9pZ0B
         9oWyQ9sox0BfU9LjJwGdtepsTxE/lLCwRNcfilgmRUiQMOCzJPhii/js4ugsJ0bRynjm
         Ipcuv75TuFcW5ADB71KDA6g9v5ycAPmAStDO/cn+VbjwBbZVW5EzeDTjD2SwALAKoJd0
         5m2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711144343; x=1711749143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxA/Vj3a1BgHptKDUbOtB0zHeYp5zxSd/aJ7ZP3EJ40=;
        b=AzJg/ZlN6KtpOEzvLzpOU9SBSqFrDX8E6yBfxvIA7AgCr9j6g/kqtvrZR6xFF+aEc3
         Lk0RMsH6XhulDB88gQoN8kyVIQGKZQN0t3gOywQzDEsI7I+/hiuV3MyxjtNpjSiEq7SD
         LYhom+7WMN2O9Y3pY5jeOnEmEX8jqecKjpbBkxscC/YBA2Qufa4QkZmP8C4TZ26dvbpO
         S+9bmmfZn/Q3hdB1tOJKB3WgjKuUu3EUVgAOsFDSd2VkgNwTS4qLUTSY+y/YeWZ9gQe7
         62ZEahGO+VLEHumMC7bNj0KMJbCqSfs9RROjGvPZCeJ7OkDZdc1gD1UrB0pAZcj/s4+Z
         IKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK329qkAhds9qbyAZIYesYa+98Fr9B9LTnQZFhb8Xqi+HKAl6q/bk2L0nCPRDOfZlQP0dtHkhFvCjmlRaDeTsWBhlnsfvOvwMT
X-Gm-Message-State: AOJu0YzkfPdarL0nP1nFw+UfZoBtDgnq2YSgVq0uj19V2bLUdlgy0brU
	b46imjntj4VH3LHostfvXZesbSjqS1GNYMvqvS79wBh12sVIcjMJwCSr/h7zuIw=
X-Google-Smtp-Source: AGHT+IF9jLEGsmmVZyjG76/9Vg4P6LNP2wulUQuXmR2Xd3nKIeY6vq9I6/k9tkbh4klRzwi7oAO5gQ==
X-Received: by 2002:a05:6808:2395:b0:3c2:d5a:2733 with SMTP id bp21-20020a056808239500b003c20d5a2733mr1114677oib.52.1711144342985;
        Fri, 22 Mar 2024 14:52:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id x20-20020a544014000000b003c37b3571d3sm88254oie.8.2024.03.22.14.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:52:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] docs: iio: new docs for ad7944 driver
Date: Fri, 22 Mar 2024 16:52:14 -0500
Message-ID: <20240322-mainline-ad7944-doc-v2-2-0923d35d5596@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
References: <20240322-mainline-ad7944-doc-v2-0-0923d35d5596@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new page to document how to use the ad7944 ADC driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/iio/ad7944.rst | 130 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 132 insertions(+)

diff --git a/Documentation/iio/ad7944.rst b/Documentation/iio/ad7944.rst
new file mode 100644
index 000000000000..f418ab1288ae
--- /dev/null
+++ b/Documentation/iio/ad7944.rst
@@ -0,0 +1,130 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD7944 driver
+=============
+
+ADC driver for Analog Devices Inc. AD7944 and similar devices. The module name
+is ``ad7944``.
+
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7944 <https://www.analog.com/AD7944>`_
+* `AD7985 <https://www.analog.com/AD7985>`_
+* `AD7986 <https://www.analog.com/AD7986>`_
+
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+The driver currently supports two of the many possible SPI wiring configurations.
+
+CS mode, 3-wire, without busy indicator
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                         +-------------+
+                    +--------------------| CS          |
+                    v                    |             |
+    VIO   +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD7944   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
+
+To select this mode in the device tree, set the ``adi,spi-mode`` property to
+``"single"`` and omit the ``cnv-gpios`` property.
+
+CS mode, 4-wire, without busy indicator
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                         +-------------+
+     +-----------------------------------| CS          |
+     |                                   |             |
+     |              +--------------------| GPIO        |
+     |              v                    |             |
+     |    +--------------------+         |     HOST    |
+     |    |        CNV         |         |             |
+     +--->| SDI   AD7944   SDO |-------->| SDI         |
+          |        SCK         |         |             |
+          +--------------------+         |             |
+                    ^                    |             |
+                    +--------------------| SCLK        |
+                                         +-------------+
+
+To select this mode in the device tree, omit the ``adi,spi-mode`` property and
+provide the ``cnv-gpios`` property.
+
+Reference voltage
+-----------------
+
+All 3 possible reference voltage sources are supported:
+
+- Internal reference
+- External 1.2V reference and internal buffer
+- External reference
+
+The source is determined by the device tree. If ``ref-supply`` is present, then
+the external reference is used. If ``refin-supply`` is present, then the internal
+buffer is used. If neither is present, then the internal reference is used.
+
+Unimplemented features
+----------------------
+
+- ``BUSY`` indication
+- ``TURBO`` mode
+- Daisy chain mode
+
+
+Device attributes
+=================
+
+There are two types of ADCs in this family, pseudo-differential and fully
+differential. The channel name is different depending on the type of ADC.
+
+Pseudo-differential ADCs
+------------------------
+
+AD7944 and AD7985 are pseudo-differential ADCs and have the following attributes:
+
++---------------------------------------+--------------------------------------------------------------+
+| Attribute                             | Description                                                  |
++=======================================+==============================================================+
+| ``in_voltage0_raw``                   | Raw ADC voltage value (*IN+* referenced to ground sense).    |
++---------------------------------------+--------------------------------------------------------------+
+| ``in_voltage0_scale``                 | Scale factor to convert raw value to mV.                     |
++---------------------------------------+--------------------------------------------------------------+
+
+Fully-differential ADCs
+-----------------------
+
+AD7986 is a fully-differential ADC and has the following attributes:
+
++---------------------------------------+--------------------------------------------------------------+
+| Attribute                             | Description                                                  |
++=======================================+==============================================================+
+| ``in_voltage0-voltage1_raw``          | Raw ADC voltage value (*IN+* - *IN-*).                       |
++---------------------------------------+--------------------------------------------------------------+
+| ``in_voltage0-voltage1_scale``        | Scale factor to convert raw value to mV.                     |
++---------------------------------------+--------------------------------------------------------------+
+
+
+Device buffers
+==============
+
+This driver supports IIO triggered buffers.
+
+See :doc:`iio_devbuf` for more information.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 30b09eefe75e..fb6f9d743211 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -16,6 +16,7 @@ Industrial I/O Kernel Drivers
 .. toctree::
    :maxdepth: 1
 
+   ad7944
    adis16475
    bno055
    ep93xx_adc
diff --git a/MAINTAINERS b/MAINTAINERS
index fb2377bad376..40813d9ec38f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -448,6 +448,7 @@ R:	David Lechner <dlechner@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
+F:	Documentation/iio/ad7944.rst
 F:	drivers/iio/adc/ad7944.c
 
 ADAFRUIT MINI I2C GAMEPAD

-- 
2.43.2


