Return-Path: <linux-iio+bounces-15523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74AEA35D94
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A316B054
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C72641F0;
	Fri, 14 Feb 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lf164Ph0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453B2641F3
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535803; cv=none; b=gsUZxM5/q+8QsN0lKZwf0xXJ6mxZ++9fbBJFl29zgRqlXJyMtPakJ56p0J+OcFCqSOSklglr6nuVYY7XzP/3KizdZ0Y/u0kIUyLqzm7Ffxb8dnu5vPdzQYeHIfQ6lhMUP+gt+LwX6ku8BIZfagsLAYRPNAMZEpcL3+FTe9b60lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535803; c=relaxed/simple;
	bh=hLiMZnuu+3C1+GXOKrJYlOPcy9O1KcJ4GWq7/HNkeVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oT6p1QI4qwrWfghYFnyOtN82p5DBhkxwXbmWT0kvQc8V37PIOPmQMR5F4eyZMTQV5624oQ8T8XyM/SXSxyMbF5iif2cxhamRRsfboZc1VyskLWuJWNONShRsWJsz9vVVbFKpFFpKLmjTPBrrEMo8aRFKpWIe9vTwR7c72GU+i+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Lf164Ph0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so624063f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2025 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739535799; x=1740140599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wsvYUn1m2oa3GrMllWdEUhN26YtAgD7V53pe75Koy0=;
        b=Lf164Ph0151nUn4EIIEZMqIa9wnJ2VZ6dxPr8nc7fe4LqYQjnL1/GyUlZ1Xb5greAF
         rWA9MXOLkIokLJVHB3gvDdSZNK2FHoxZNJv+e1P8UwAJuZDfHr9O/uLIlguxnHWKJ2f5
         NM6WYEkCOx5escV5s9ihTfA2+qvdiNhNrDKjsgn+kQkWOJuzP3MkYciqxomy4Ph1lv5+
         BTy1GqI5TBVcBF4raytOXaWvgIYsiOHKOhzNZmRHgKS20giC+FvP2Td1Thlu52pDuAfX
         I9D4AoHBEANOlCNYQg6r8Aq5T3XoTEQkVmVMNRgIeqZiBkJ86sNtPv2L4o+PQIgRswXZ
         kXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535799; x=1740140599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wsvYUn1m2oa3GrMllWdEUhN26YtAgD7V53pe75Koy0=;
        b=ARSPuD1D2Lgu/Y/RD5rXBsL7LXYBgic4OKmoSXXG4QJTx5jTeboih5JU5wvQmmauZp
         oJmQBWjeI9EY37a8ew2EqTIdCFGb3WOZcwv2WB4nXcmTLJth7E8BrWk21aq97jRoTUjx
         RUvxHjkIhIiMNFt052zEtXDBmTU6OcQhUlDOE67zBVBXhHL7smS7JLtlF1IKYx8bSA24
         qTgXTKjSzlY7ip2lm74+Oi0ldk25jzgqOUPwUbr2VCGJwg5ft4sMMPAT9L0JZv8TRGg6
         VDJb89DTSUswjLZk4mYjrqr5I2BlP349QMJpKZIuWtucPHwA98NYPcs0AN7x6D9PnDuX
         nptg==
X-Forwarded-Encrypted: i=1; AJvYcCX87INZauEYi0cDkYvLK05HJveIZqECr50dmvky6qoMEL07VLRYlTsaIr60xgBmf8+VCeAvQnRNi+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHIB1kUkcS3/VngDrgWbsZpquL+3YdQh1qfIooqA+zhmGWqxo
	G6UbcYP8XL8NIa+vLoFJDgHMHC74A6hFY7/DaT9EG7vqHG3yFAq/3jcXamB/kOs=
X-Gm-Gg: ASbGncsasWiRenFpgr9uj5qLQ2i3+vIUsywz1sfeXqSohJKRJ8MdyS9/vghr17jY+ky
	XLf+D4w3cZAltD6G3OwGlsBM4WxM4sxS2klpstT9RQ4+vXvTrgZBkbU+So964bMD8WnRFjXywKS
	gfz1TWl7ZKwZyUlT49vccQ3jPxZ5wQED1i523JuLWcYDmgdPKfagr1in6i11Z5INVizMUzDxwfJ
	CrbiUEjIzXvZgdq95JsKQEBi20hqFzUSWF1ib36kMtr61en5jUvmSHgJ4qRNY7NVRUVqx5M1tuQ
	lmvOsOtQx6lLhm6mOPHQ2GzMo5p0N74A2RL5sjNQxJRKyaQnQ5EICXrHXcHr6cdElVgLb5iM
X-Google-Smtp-Source: AGHT+IEDQWC5tiIRz+2R7TgH92zpBtRkZ3QohO4W65JuSWaGXT5oTXw9QVJsqMSAksmdsVyR8mmEPw==
X-Received: by 2002:adf:f28d:0:b0:38d:d8b2:cf0a with SMTP id ffacd0b85a97d-38dea288854mr10774854f8f.31.1739535799285;
        Fri, 14 Feb 2025 04:23:19 -0800 (PST)
Received: from [127.0.0.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm4424654f8f.85.2025.02.14.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:23:18 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Fri, 14 Feb 2025 13:22:36 +0100
Subject: [PATCH v4 6/6] docs: iio: ad4030: add documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-eblanc-ad4630_v1-v4-6-135dd66cab6a@baylibre.com>
References: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.2

This adds a new page to document how to use the ad4030 ADC driver

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 Documentation/iio/ad4030.rst | 181 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 183 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
new file mode 100644
index 0000000000000000000000000000000000000000..41ce5ca5c710c46a0995d1b127fa1c10fca4c1eb
--- /dev/null
+++ b/Documentation/iio/ad4030.rst
@@ -0,0 +1,181 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD4030 driver
+=============
+
+ADC driver for Analog Devices Inc. AD4030 and similar devices. The module name
+is ``ad4030``.
+
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD4030-24 <https://www.analog.com/AD4030-24>`_
+* `AD4032-24 <https://www.analog.com/AD4032-24>`_
+* `AD4630-16 <https://www.analog.com/AD4630-16>`_
+* `AD4630-24 <https://www.analog.com/AD4630-24>`_
+* `AD4632-16 <https://www.analog.com/AD4632-16>`_
+* `AD4632-24 <https://www.analog.com/AD4632-24>`_
+
+IIO channels
+============
+
+Each "hardware" channel as described in the datasheet is split in 2 IIO
+channels:
+
+- One channel for the differential data
+- One channel for the common byte.
+
+The possible IIO channels depending on the numbers of "hardware" channel are:
+
++------------------------------------+------------------------------------+
+| 1 channel ADC                      | 2 channels ADC                     |
++====================================+====================================+
+| - voltage0-voltage1 (differential) | - voltage0-voltage1 (differential) |
+| - voltage2 (common-mode)           | - voltage2-voltage3 (differential) |
+|                                    | - voltage4 (common-mode)           |
+|                                    | - voltage5 (common-mode)           |
++------------------------------------+------------------------------------+
+
+Labels
+------
+
+For ease of use, the IIO channels provide a label. For a differential channel,
+the label is ``differentialN`` where ``N`` is the "hardware" channel id. For a
+common-mode channel, the label is ``common-modeN`` where ``N`` is the
+"hardware" channel id.
+
+The possible labels are:
+
++-----------------+-----------------+
+| 1 channel ADC   | 2 channels ADC  |
++=================+=================+
+| - differential0 | - differential0 |
+| - common-mode0  | - differential1 |
+|                 | - common-mode0  |
+|                 | - common-mode1  |
++-----------------+-----------------+
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+The driver currently supports the following SPI wiring configurations:
+
+One lane mode
+^^^^^^^^^^^^^
+
+In this mode, each channel has its own SDO line to send the conversion results.
+At the moment this mode can only be used on AD4030 which has one channel so only
+one SDO line is used.
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |     ADC     |         |     HOST    |
+    |             |         |             |
+    |         CNV |<--------| CNV         |
+    |          CS |<--------| CS          |
+    |         SDI |<--------| SDO         |
+    |        SDO0 |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+Interleaved mode
+^^^^^^^^^^^^^^^^
+
+In this mode, both channels conversion results are bit interleaved one SDO line.
+As such the wiring is the same as `One lane mode`_.
+
+SPI Clock mode
+--------------
+
+Only the SPI clocking mode is supported.
+
+Output modes
+------------
+
+There are more exposed IIO channels than channels as describe in the devices
+datasheet. This is due to the `Differential data + common-mode`_ encoding
+2 types of information in one conversion result. As such a "device" channel
+provides 2 IIO channels, one for the differential data and one for the common
+byte.
+
+Differential data
+^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Only differential channels are enabled in a buffered read
+- Oversampling attribute is set to 1
+
+Differential data + common-mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Differential and common-mode channels are enabled in a buffered read
+- Oversampling attribute is set to 1
+
+For the 24-bits chips, this mode is also available with 16-bits differential
+data but is not selectable yet.
+
+Averaged differential data
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This mode is selected when:
+
+- Only differential channels are selected enabled in a buffered read
+- Oversampling attribute is greater than 1
+
+Digital Gain and Offset
+-----------------------
+
+Each differential data channel has a 16-bits unsigned configurable hardware
+gain applied to it. By default it's equal to 1. Note that applying gain can
+cause numerical saturation.
+
+Each differential data channel has a signed configurable hardware offset.
+For the ADCs ending in ``-24``, the gain is encoded on 24-bits.
+Likewise, the ADCs ending in ``-16`` have a gain encoded on 16-bits. Note that
+applying an offset can cause numerical saturation.
+
+The final differential data returned by the ADC is computed by first applying
+the gain, then the offset.
+
+The gain is controlled by the ``calibscale`` IIO attribute while the offset is
+controlled by the ``calibbias`` attribute.
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
+Reset
+-----
+
+Both hardware and software reset are supported. The driver looks first at the
+device tree to see if the ``reset-gpio`` is populated.
+If not present, the driver will fallback to a software reset by wiring to the
+device's registers.
+
+Unimplemented features
+----------------------
+
+- ``BUSY`` indication
+- Additional wiring modes
+- Additional clock modes
+- Differential data 16-bits + common-mode for 24-bits chips
+- Overrange events
+- Test patterns
+
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 5710f5b9e9582befb6dfa9d72c4fae8cae8ddeb7..2d334be2b7f29a82916a03d808bc0cb38e5a2252 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -19,6 +19,7 @@ Industrial I/O Kernel Drivers
    :maxdepth: 1
 
    ad4000
+   ad4030
    ad4695
    ad7380
    ad7606
diff --git a/MAINTAINERS b/MAINTAINERS
index bfb739c2f5f4ef9182c9789c797e63a93ab08080..364cfc6e8cc6f99b32319e5344c66b2b578bc5d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1314,6 +1314,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
 ANALOG DEVICES INC AD4130 DRIVER

-- 
2.47.2


