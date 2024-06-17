Return-Path: <linux-iio+bounces-6421-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9AD90BB8C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB81F22D17
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10619922F;
	Mon, 17 Jun 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CZMsFzBs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D44198E74
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654231; cv=none; b=j3wxE+LY2AeMSCK2wwea+iX47YA8tf02LL6j+vEh6h+BDkWhiiOeaN7AiW0mB4Zv+Q11HAuLoTouhR82RQXJyjd82IWrQ7Eb0ZvYDS8PtJRhfc6sypDY/vu9dvgQjkUdoilxutBry0d5LX2osoTUIDxnYU6krrrPYUdV4FMlEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654231; c=relaxed/simple;
	bh=Kj1jj1jkWY4iweELsF47z0WctpUxRHz3YErTiEr0zfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNy+GWeM5BmQkrxRX3KaYYpYfWgPnMjGrXIZNAUiHwwnNJsTxi2q7hJtQtOwmSg5Q+WNmW7Am1YU8mZfGTUIhE4g6cw7BAs8efe3JYwhO8inv8KolKnx5/vxNaP7aVQNVb6P4DN0eqGTHq+3b/2IkPYxG4e3T3QUe181/m0ddXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CZMsFzBs; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9cc681ee0so2273959b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718654228; x=1719259028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsdfiRmM6h+KvTeYNcXr8NgMjVAHZPZfcMTD3irWkFo=;
        b=CZMsFzBsfyjDQbWElqvvXMMekAAlnphEbzT95hZdSqgx082tgY13zMfIaTKj/BQnHI
         SlPCxQ4v1lxUbwb4blmn9Kx3sAfJxpig1qxqcZYkVFUzH1z4Uz6kVuRb6PXc2TXCydyJ
         YaGqpvSonuCFHha8ISy5iCnc1B0y7KV+M6rDEN9gSM/PrMO3iruSu3SJUaAl8jplIRG7
         4fV4a3fpf9zI5oOO6nwDxpJfq/4v33poVaUctAbqTEEIv21xiMLlItT2uh5CarZaFKUm
         hGSrhtXVZA8Cj42hKFN0o5GjCNb3L9LLrbPO48fQmXIoH50SFr+sgjsD6tW5HbOmvXT2
         ShAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654228; x=1719259028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsdfiRmM6h+KvTeYNcXr8NgMjVAHZPZfcMTD3irWkFo=;
        b=L7fxp146aNornMGE69D3KQurTWr59QlbW6pweNV55PV4R3PAMJpZd7W14DDm+JN8jF
         VVBkjlFdlAf1Owi5L0QdRZe/DsdQI7SIQxUze2grBbGrJZsSOyHNnDgx8YigI6OBJvL2
         hS0nWXEy7QkC5IeHSFx1yDcT1zuhjEA2/MPoY7upPawXcK1b7uG1KG21e0Gbfhe+PMmp
         Ak7uJBGVCvRc3t9weqKIcXN6eFNcnXelTsfK9E28Rw2Q5uhVpJI6KvY1YmpMA1/Psy6n
         IU7zKmRCozeUMIetJwAPaa0N3HoRDg/mpQC7N06HM0YJ5pt9DFquGI5sRh4BliH9uDok
         vaOA==
X-Forwarded-Encrypted: i=1; AJvYcCUXlSeSwwH3cl82QNGwmGLKquRm1x+PYhmX6lBh0caGjwrH6dxgK48TkiaU/yyhR4gc0IUeV7XAFqU/kCxmBiH2qqnO7aKyGP6E
X-Gm-Message-State: AOJu0YzKPSioO2G0LP3+31IuO9gzkUO8WJawAs1Irg9ONMazlRY9aEmU
	QbRQZEUD7Ca0yO1H7u/X+pmdJZ4xdBph3BjNpqd6A+kSLTGxauspyVWV5vWQ3wg=
X-Google-Smtp-Source: AGHT+IG+Mt+zjMH088t6lK+Exi2DE0g2sDRkozh5QQOxNL7x7Vy8ugOJjYJT9utaROtkRzRvX++niw==
X-Received: by 2002:a05:6808:159b:b0:3d2:16c8:64f4 with SMTP id 5614622812f47-3d24e8fa5afmr11992918b6e.24.1718654226849;
        Mon, 17 Jun 2024 12:57:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476e2fa4sm1579492b6e.52.2024.06.17.12.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:57:06 -0700 (PDT)
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
Subject: [PATCH v2 4/4] Documentation: iio: Document ad4695 driver
Date: Mon, 17 Jun 2024 14:53:15 -0500
Message-ID: <20240617-iio-adc-ad4695-v2-4-63ef6583f25d@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
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

v2 changes:
* Rework DT examples for DT bindings changes
* Add file to MAINTAINERS
---
 Documentation/iio/ad4695.rst | 153 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 155 insertions(+)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
new file mode 100644
index 000000000000..d5cde1b84d50
--- /dev/null
+++ b/Documentation/iio/ad4695.rst
@@ -0,0 +1,153 @@
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
+    channel@0 {
+        reg = <0>; /* not related to the pin number */
+        single-channel = <0>; /* IN0 */
+    };
+
+This will appear on the IIO bus as the ``voltage0`` channel. The processed value
+(*raw × scale*) will be the voltage present on the ``IN0`` pin relative to
+``REFGND``. (Offset is always 0 when pairing with ``REFGND``.)
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
+    channel@1 {
+        reg = <1>;
+        single-channel = <1>; /* IN1 */
+        common-mode-channel = <AD4695_COMMON_MODE_COM>;
+        bipolar;
+    };
+
+This will appear on the IIO bus as the ``voltage1`` channel. The processed value
+(*(raw + offset) × scale*) will be the voltage measured on the ``IN1`` pin
+relative to ``REFGND``. (The offset is determined by the ``com-supply`` voltage.)
+
+The macro comes from:
+
+.. code-block::
+
+    #include <dt-bindings/iio/adi,ad4695.h>
+
+Differential input
+^^^^^^^^^^^^^^^^^^
+
+An even-numbered ``INx`` pin and the following odd-numbered ``INx`` pin can be
+used as a differential pair. The device tree for using ``IN2`` as the positive
+input and ``IN3`` as the negative input will look like this:
+
+.. code-block::
+
+    channel@2 {
+        reg = <2>;
+        diff-channels = <2>, <3>; /* IN2, IN3 */
+        bipolar;
+    };
+
+This will appear on the IIO bus as the ``voltage2-voltage3`` channel. The
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
index e7a338a3eaaa..15f15b6013ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1217,6 +1217,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+F:	Documentation/iio/ad4695.rst
 F:	drivers/iio/adc/ad4695.c
 F:	include/dt-bindings/iio/adi,ad4695.h
 

-- 
2.45.2


