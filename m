Return-Path: <linux-iio+bounces-13657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C59F7F14
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6E7A3160
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CE5228C9B;
	Thu, 19 Dec 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OtC1yFTF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E122759A
	for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624689; cv=none; b=N2i2V6Gz+sXdoogclSl3F6t845gsT2Pfcq6fbs7hYLR22ov+yBW5FlY7T8oZrM4ffX/ZnXN8hIdgNlb5M1Jbk0mhao0NOJsPDkJt9zyfP2r3s8v3ZIvm7Sr4f6bZGFXcvlu8Jhmp637I+e22kCG/RNB8SaSyl+/QWKlklcEDqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624689; c=relaxed/simple;
	bh=zWOvwvrdigN7/ppfzVhOc7SzEMU1Mc9EbFfMrGrgct0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVXnSbLgYAVHmiDA8iYboIHYVnoYcp4P4iPIH/AKJWy/IFIlLdK+YqHERs+S5kmDw61lNv+yg5H7DnjXjQz2yuHnmSUl5ONrgZxq/gdgHeqn2vyn8Uu9WcbocXxjwvs9rRbk2AuxAZXlEaKXhfjVvJUvcjV7eesoYnXl6t9JM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OtC1yFTF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso6478265e9.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734624684; x=1735229484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxiJBsOqmSFhgi06hbE4Mj+rDXoNs/kuFfLnrTaWi+c=;
        b=OtC1yFTF3ulj0dean8GtbccQa2ZU0JXP40HnyUogWz9YYpDGkOod7beELASmg/X4V/
         7gGlkSFd9vO0AmAqIXs3ldj3hi/HRYXSyIWU+2vyx79Bw4b9RcQNCW7i/iNj1c4L5qoR
         13fP4PYbdDiXv4OYzr0m1nLyXb9gaDPQ9kKOr82NLHEGtGZBC6og/OdHNcN57xVPlovL
         VOMwGfZTXwQW37UuQtKqcabQ4HUJb3F1UOwb2L8QgVMZwk6b7xpR5jKVbE84FBu1vm6y
         rgZaAAFlUDprQAfyAuJpxIwDCkV9+nkhBLN5EBudMpKKlg5j6ge1QacWwdnABEFiAiH0
         iOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734624684; x=1735229484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxiJBsOqmSFhgi06hbE4Mj+rDXoNs/kuFfLnrTaWi+c=;
        b=Pcygit+eK+MwiraW511VlDxxT8+56oq7zBEvlvAhTqe821+6ftIsEXAJDQVULvicin
         /XzmBwcPA7W2h/wQyK2ylQ2AgCgOnGbL4vcmpB++mceJmU/HOpPmebRVwGY4s20kqXvM
         +nMtbaJE2/+gFeOeksjpF7RsimwAPb/WI+crjbYMPh5N/TxB0ddi9p623sa3fcMAux8M
         fsLPwooz+9NOsDgdyTDyc4AYObONXyXXlsvFIvehOgO2mWpmPqhDe9QwZb8WyBGhDUzv
         0e9fCp0qtW+j5EYLLaLGz7Jmk2H0dHrtpfxBjFR1bZe5zWPkqqpHuLK+WYHzm3JaSJ+D
         +g1A==
X-Forwarded-Encrypted: i=1; AJvYcCX60puVHNppuuxLBnx0OKQDONpKqBPnf5h7odTL7FfCn7BZ46yW+dDxGh2UnUE78lagT2xt3LP1kcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Lm6OlWCuqMFrlnSC/TUc8g6ALoBhEYS6QDHo9cBPReYsJ5VN
	FiDAKGZpFXox/+V/AABj/ICGc/jWkz/vA2xy0ykQsxIFG+Nu0J6MK4qS1z+QbXYNcpahVeLpw33
	3
X-Gm-Gg: ASbGncsHBRcSFw90J6cJ50cHolg4qF1jCV/AyGPIUkyIfdcBWHAF5cgWBpHjw8GDBMO
	kGKRBlMYl7eYG+YgACGxaptAWor+ITA6Z3ZBRItDeTy+ViYPJHI6d3Dsq8n1VrZudCtJIv/uRSn
	2wmEOqR3eYDZNNS8plMPG4bEfK3zUinovS0vnovwuqfe3wvCqyU/eDXESN9kf/A0N8KEJtMYpxx
	EwRutZwcc9EMSSOqmX/lPfdhS2oYasWaf7csBZJlmLwEZnAehmlG/Y1HQS+qyEgod4vbHRxjEvj
	UWJxO1FMv3QKUgHtPl5SxViAVtCiulEe53CW0A==
X-Google-Smtp-Source: AGHT+IHLyxgXsGBh7VWTjWO2474ZNgAkNamew7ozR8yb7Wb8A5RhvA0MhRdXr9U4P2j7f4qV5zZvkg==
X-Received: by 2002:a05:600c:746:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-4365c770940mr36033175e9.6.1734624684227;
        Thu, 19 Dec 2024 08:11:24 -0800 (PST)
Received: from [127.0.0.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b295sm57526225e9.33.2024.12.19.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 08:11:23 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 19 Dec 2024 17:10:41 +0100
Subject: [PATCH v2 6/6] docs: iio: ad4030: add documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-eblanc-ad4630_v1-v2-6-f36e55907bf5@baylibre.com>
References: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
In-Reply-To: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
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
index 074dbbf7ba0a087ab117efaf3d69fc559fc00fa5..982ac1bd9dfd7bfd54bfbf87d6258e6249edf799 100644
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
index 943c48fc0a75f475049758cf3791ba6d19748a63..775e7487de2309f7e7d89c9362bc4fa9a25d3095 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1282,6 +1282,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+F:	Documentation/iio/ad4030.rst
 F:	drivers/iio/adc/ad4030.c
 
 ANALOG DEVICES INC AD4130 DRIVER

-- 
2.47.0


