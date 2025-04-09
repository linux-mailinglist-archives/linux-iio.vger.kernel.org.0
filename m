Return-Path: <linux-iio+bounces-17892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B787AA82EEE
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 20:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802268A13D4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4F027932F;
	Wed,  9 Apr 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ho8IeVwn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B0278165
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223874; cv=none; b=p1KejTG1gJObagZQUxYEu72UWprvojU/xytSwxJ1sXCEd50fNWBiECab2ywGAAc2nk6NFoMeYR+nwXHJvHO7FLTaxNzbdsg2Eum1VyfGYcorwO/Hq+2/ydjK0dBm0nrHLKn09KG8iQNZdNos32aOX5JpYbSyQ0Hze12o4HhRj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223874; c=relaxed/simple;
	bh=op+FNBneI6h3+sV2ZZlwMqV5lcQPl5VA3Pzvyo21FgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcr5W8mbXeENoi2XwStCgV/b+QGufewF+vSS+nhEwyUmKJJ0biinCtiB4s1Yvt68fatch3AHp6GIO1YQXI4ZLGKsd1FyWPVftKl8OCd919d2zsUToADbeVm7tnyf/NzwfBspJkKAACa7SGA+FcYM2tr4A4J39BjQ+UmRJOQE1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ho8IeVwn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so5957560f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744223870; x=1744828670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7RQvOK6fXK41dO5HhHuRssJ1eoHSZj31eOEcLWUU5k=;
        b=ho8IeVwnAUCM0Ul+b1oOSQfoEDx58zPkEwM2Sfdy/nkJJFuydesxXqlbPwQQ1nT5fo
         h2BaJcusTFDcI54slJFAQ0SH4zVBgQFKAxGldx7yjn/OxKgs061iR2/jrm8j1P9s6sDn
         Jgqjty6sZ13WA87wwVYuquW/RN7GKVF9AeSRM7fjxaj50n4K7mrxgNvjGtBKG6/SF3fl
         22X0cBdwv1vB+5xk9aQDcvhZX8G8nam2Vk+Gug3eg79VHNsj1QPTsgnQIaa7h/sNVQTb
         5fl3eI5wT01chWO38kD1XWLUKd9Z0IxT4tbfra5+NjNu/vYfmbApClXVq8zdnCVrSp2U
         VS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744223870; x=1744828670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7RQvOK6fXK41dO5HhHuRssJ1eoHSZj31eOEcLWUU5k=;
        b=gbJ1pOv3mQcrloSdInq3ieuZP93gv8xAP711UwPXd4NiJ91eX6yzgezYKpM8ubPLk/
         1hX4JFdIUIX9aciM5u50BfZDrzLiUm+2S5TRTAxBj9Y94ws3dbRpXE4pMI735fUesab5
         oCmC8gpooJCGbRa5R2EifAUGG3QSOtHOWWhgPo3W01Fd5Q6vlNUGV74GMgzxM5ceOf/I
         WBFXf0hdfUN/ea96QaVzzFBzdKx/pqnb5F+8rc4hWsdiLe13Io6H3JOPF3oIontbHXB4
         XWKDJfIDbleDXJZg/lMWuRY+vODF2QzaRd5evbn9Jt9vsy5hAWxlkR+FpkFzdTamSxbJ
         VBZg==
X-Gm-Message-State: AOJu0YyNomh3wSymDk+D6Y5TEbwPfDRTm5ye4rQ8jpFbE9gPZnG2w5lN
	D+Ubpaq1j9Kays4qduC9GsI3tn/gP+kzNOlS5VW7Gw9SMSSwY5Iy3uLQOYh9JVM=
X-Gm-Gg: ASbGncsNHcmZ99ikhG4xutfVNU4KGm+PD0zMm72kK2JS167/ynFPEIDYVpsPBSQyePi
	tyESnuDzMxnHlV7i/Rh/hH/cT87jAcHpLqG8UdIY5tMlAexbUfypDoqwo+fPHwaZzq/rtHQ8pO3
	snnKgXcTyLbRcR9DLOw6Ac+Z4CUZ+OqjLAgOqiQ+0yRAv1ow3N5B4ye1SGTuDmMlQoxcisxdcXh
	VPrzS7XQ+ROEfqPdXM5YAhX8QI+CrG62EacZrF0GH4k6bJFBtcB0GSCu1bAdtDwHeDmNGZ+i1QQ
	akqfrLjcx3jG9+CBvTD8nib7MvuqLfqkItlbJXnZvKIDAOyezvwfddKGNG9MbaGb8ACeR8CeURq
	Py7zZtXGAZjQvWxIKCQ==
X-Google-Smtp-Source: AGHT+IEDHPm4LxkKIHaWsV3VkEh4vV7MWqjrpEXZp3f0HFZRY0uLOfZ60I6tOqq7efsrIH+dDqaIww==
X-Received: by 2002:a5d:64e6:0:b0:391:1923:5a91 with SMTP id ffacd0b85a97d-39d87cde0b9mr3769040f8f.55.1744223869782;
        Wed, 09 Apr 2025 11:37:49 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938a808sm2380893f8f.53.2025.04.09.11.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:37:49 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 09 Apr 2025 20:36:29 +0200
Subject: [PATCH v5 2/5] docs: iio: add documentation for ad3552r driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-wip-bl-ad3552r-fixes-v5-2-fb429c3a6515@baylibre.com>
References: <20250409-wip-bl-ad3552r-fixes-v5-0-fb429c3a6515@baylibre.com>
In-Reply-To: <20250409-wip-bl-ad3552r-fixes-v5-0-fb429c3a6515@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4317;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=8WrNMaaQ2xgbRizjN22pSBO+RAVh+prIiloygvq6/kQ=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/tk+X+8602+/US/O41hwzOpblEdNTWrf8rUAg3wf2T
 X9r91fN6ChlYRDjYpAVU2SpS4wwCb0dKqW8gHE2zBxWJpAhDFycAjCR0gSGfxpLGL2vmAQJ9eQF
 P5/wJrH5he3m0OoM6ffcd1WXM3NKT2T4n1C6kj92s4W67I6+ramztt2f8OAmc+jrkx95ivrjJ/5
 qYAcA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add documentation for ad3552r driver, needed to describe the high-speed
driver debugfs attributes and shows how the user may use them.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/iio/ad3552r.rst | 73 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |  1 +
 MAINTAINERS                   |  1 +
 3 files changed, 75 insertions(+)

diff --git a/Documentation/iio/ad3552r.rst b/Documentation/iio/ad3552r.rst
new file mode 100644
index 0000000000000000000000000000000000000000..1539c2096ed9f9344da2e5d018e77a0524792270
--- /dev/null
+++ b/Documentation/iio/ad3552r.rst
@@ -0,0 +1,73 @@
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
+specific debugfs path ``/sys/kernel/debug/iio/iio:deviceX``.
+
++-----------------------+------------------------------------------------------+
+| Debugfs device files  | Description                                          |
++-----------------------+------------------------------------------------------+
+| data_source           | The used data source, as                             |
+|                       | ``normal``, ``ramp-16bit``, etc.                        |
++-----------------------+------------------------------------------------------+
+| data_source_available | The available data sources.                          |
++-----------------------+------------------------------------------------------+
+
+Usage examples
+--------------
+
+. code-block:: bash
+	root:/sys/bus/iio/devices/iio:device0# cat data_source
+	normal
+	root:/sys/bus/iio/devices/iio:device0# echo -n ramp-16bit > data_source
+	root:/sys/bus/iio/devices/iio:device0# cat data_source
+	ramp-16bit
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
index 030d90d383411bbfe949cfff4f5bce27e3dd37c4..52d73ba42d8600632d00b7a25df9ed5bea84fa3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1306,6 +1306,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+F:	Documentation/iio/ad3552r.rst
 F:	drivers/iio/dac/ad3552r.c
 
 ANALOG DEVICES INC AD4000 DRIVER

-- 
2.49.0


