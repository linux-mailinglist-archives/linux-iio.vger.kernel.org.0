Return-Path: <linux-iio+bounces-17736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7667A7D89D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 10:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B516C10B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0222A4E6;
	Mon,  7 Apr 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2geaPF+y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F89217F32
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016012; cv=none; b=UwdjVLClakycH6GTbJd8DyiBcsMVCxfhOhq5yuqbxXy26x3BinmM2yTd86dcfKF4PF0Z4Coi4lD/2+QMXNeIQBZDQSKooS4j9qJbQwBoeXPq1uKJ1QCG6yE5unCkVs78MFJ4S/zeA4F6+W16LUymADC5o2QLU6Qjb4W5UPnWwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016012; c=relaxed/simple;
	bh=F2Qod7NABbhubiuu+bmx+zE/fhm/Yo5sMggxFose+iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEqhBLuI8mt36Dw9LZGdCbXTbdsKdKL0CCVZDWRtCRwvME0jCgUfClHruHmttd9kCiO/1/kobdFZNFPpq1iVRFuS8Ax6WxsHNh10bguvzIpN9HjreIQ0y0rgP7d7p1hhnoNTxD4Ijq8Q6DJTzF7dJ09Z3TiWgwpjgXc1u39Z3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2geaPF+y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so39009895e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744016008; x=1744620808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShsE3ZcbHwYaWyOB5JwD08uVlCnOZ4Y4zX0gXgP+EjU=;
        b=2geaPF+yGXDZstuPr3nx2VOxC/kJKOPfc3bBTu36efPt3ZC/DeG6v/oxer8SCRbCjO
         qpfIh8oE22SEA7nmy3zI2TPdCUof9K4sAj3O+vKYHUK46/eYaDGIMNWAR4aEAwSz67yH
         hFeEWkbKI85FWhJB23DpGonSjHLHmkpKO+solIg+vBmDGzchhHOyW4Y58DiQ4sHyDWgG
         dg1fJ1pnxoxhdt96qXJTmzM+iGuFqCOVInd+6m2zw6wy3G3VRq598080ZXW6NebbZQWI
         Jd+/MqukXCzH8D4CTbVuc6oJeMpyAfeQGrpp9Hlmm9wJ1CD6tgsJdpCkPb3aNz4pyZQ0
         MUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016008; x=1744620808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShsE3ZcbHwYaWyOB5JwD08uVlCnOZ4Y4zX0gXgP+EjU=;
        b=bVRetlp7hy3ni7H7JexLrO5qyagko6TBMOZT+AOJld4FW/g1uvD8GXuP50csEQ2kS6
         Xn7C15zxvKRudugcGsioTNE3qFGEDwIwwyb+bLzfrtnrYdUK+lPzlE5jxXFNgqsf+UfM
         PVsGXKeay0b+9wExKrv0Z8HSK39xGVaJin4IoVs1YSP5cU/Q58NMvH/Z9wwhlCsWHQVf
         DLZzQjGM/hoJa6TB+6B9q+KavusKOrrqkZ8wzExVKlI2HE8cs1xYX/cG8xLrehSFZWQl
         qFSNSpjK83ckTLhF4vsTg1MQCm5uNrgoOi6hKH5llu37EGlVl0YAG2hOCrT2BViV0hD5
         Bkmw==
X-Gm-Message-State: AOJu0YwBYpZi3T4ovMJTJyHTRF6DrWGE88RLJFrfYOGXGFK+gcG/4gFR
	c/qyqHyAhusU/5lhIJGspyoz9jFy5ih/99YjuNHNFdY9126UJGMMUDQzKtY8nQAdwA+IltunpyO
	3
X-Gm-Gg: ASbGncsBGYcwusE4T4OmLARst9Pyx132Umxsfr0zU5bWKMbzmUex95kKd8ea8OXQ7tK
	vY5D3Jdznb+LDwEdf3NpM9wDFZmpoQW4Zjznq5LEKpKoPuReB0weJ3qRRQvpw0todT/cSLqtO4X
	hkNC7j0k4cL0HLqTsCaIKNFy6yZwrn9Ljbw70wtkcBPLGeA1+uPQYe8C1Bfr4jRGY9aKXkZnqpj
	up2+YEbnXGVebuJxxPT2xxzxm+PtaxK47DF/4yRon/dzR7CgPlkdD8mGSWrGLV8uX8a8xuKb5DN
	o8UqUsI1w6s/Dr+iB8m4L0/ubCwfqTC9HVOTP6/nUNCUjGGhjwFEHovg4kf/yO7F8oTxrGFQ93a
	qWOnHRIynCjBJzwUHrUmnKQ==
X-Google-Smtp-Source: AGHT+IGoWMikHiILCzQyxiICmyrDcYbMbBE2+CmSWIHKyocBHZuGsTfBPMzzPfYegK5uRlhusxUWRA==
X-Received: by 2002:a5d:5f4d:0:b0:391:47d8:de25 with SMTP id ffacd0b85a97d-39d0de67a0bmr10291358f8f.41.1744016008061;
        Mon, 07 Apr 2025 01:53:28 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec3174cf0sm126966995e9.0.2025.04.07.01.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:53:26 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 07 Apr 2025 10:52:04 +0200
Subject: [PATCH v3 2/5] docs: iio: add documentation for ad3552r driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-wip-bl-ad3552r-fixes-v3-2-61874065b60f@baylibre.com>
References: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
In-Reply-To: <20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4191;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=K6IzTR+F1J2B1DTGHtf/OPY+ArUlb20kadSjMscdtUE=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/PMmGaUNurFfh9PrpW37czjvWpuGTdPnVhJqgiW062
 64pOTGEdZSyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZgIMxsjw/nW1/eLhLYsZJq+
 T6ptd7TwbYOgvKmHfbXtLqhsdr3wU4CRoeWLU/0dvc4rq5jPSjU5sj98dD/BLqgw9LNyouZhOz1
 5RgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add documentation for ad3552r driver, needed to describe the high-speed
driver debugfs attributes and shows how the user may use them.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/iio/ad3552r.rst | 72 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |  1 +
 MAINTAINERS                   |  1 +
 3 files changed, 74 insertions(+)

diff --git a/Documentation/iio/ad3552r.rst b/Documentation/iio/ad3552r.rst
new file mode 100644
index 0000000000000000000000000000000000000000..2af24cfe886f1f4c1b86ac679fd19b83635b6771
--- /dev/null
+++ b/Documentation/iio/ad3552r.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==============
+AD3552R driver
+==============
+
+Device driver for Analog Devices Inc. AD35XXR series of DACs. The module name
+is ``ad3552r``.
+With the same module name, two different driver variants are available, the
+``generic spi`` variant, to be used with any classic SPI controllers, and the
+``hs`` (high speed) variant, for an ADI ``axi-dac`` (IP core) based controller
+that allows to reach the maximum sample rate supported from the DACs, using the
+DMA transfer and all the SPI lines available (D/QDSPI)..
+The high speed driver variant is intended to be used with the ``adi-axi-dac``
+backend support enabled, that is enabled by default when the driver is selected.
+
+Supported devices
+=================
+
+* `AD3541R <https://www.analog.com/en/products/ad3541r.html>`_
+* `AD3542R <https://www.analog.com/en/products/ad3542r.html>`_
+* `AD3551R <https://www.analog.com/en/products/ad3551r.html>`_
+* `AD3552R <https://www.analog.com/en/products/ad3552r.html>`_
+
+Wiring connections
+==================
+
+Generic SPI
+-----------
+Use the classic SPI S_CLK/CS/SDO/SDI connection.
+
+High speed (using axi-dac backend)
+----------------------------------
+
+::
+
+    .-----------------.                .-------.
+    |                 |--- D/QSPI -----|       |
+    |   DAC IP CORE   |--- SPI S_CLK --|  DAC  |
+    |                 |--- SPI CS -----|       |
+    |                 |--- LDAC -------|       |
+    |                 |--- RESET ------|       |
+    |_________________|                |_______|
+
+
+High speed features
+===================
+
+Device attributes
+-----------------
+
+The following table shows the ad35xxr related device debug files, found in the
+specific device debug folder path ``/sys/kernel/debug/iio/iio:deviceX``.
+
++----------------------+-------------------------------------------------------+
+| Debugfs device files | Description                                           |
++----------------------+-------------------------------------------------------+
+| data_source          | The used data source,                                 |
+|                      | as ``iio-buffer`` or ``backend-ramp-generator``.      |
++----------------------+-------------------------------------------------------+
+
+Usage examples
+--------------
+
+. code-block:: bash
+	root:/sys/bus/iio/devices/iio:device0# cat data_source
+	iio-buffer
+	root:/sys/bus/iio/devices/iio:device0# echo -n backend-ramp-generator > data_source
+	root:/sys/bus/iio/devices/iio:device0# cat data_source
+	backend-ramp-generator
+
+
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index bbb2edce8272e7483acca500d1a757bbcc11c1e0..2d6afc5a8ed54a90cd8d5723f0dc5212b8593d16 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -19,6 +19,7 @@ Industrial I/O Kernel Drivers
 .. toctree::
    :maxdepth: 1
 
+   ad3552r
    ad4000
    ad4030
    ad4695
diff --git a/MAINTAINERS b/MAINTAINERS
index 57eaab00f6cb53df52a4799eb2c1afbbd1e77a1e..52bc56a9ee22c66b90555681c4757ea4399adae1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1295,6 +1295,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+F:	Documentation/iio/ad3552r.rst
 F:	drivers/iio/dac/ad3552r.c
 
 ANALOG DEVICES INC AD4000 DRIVER

-- 
2.49.0


