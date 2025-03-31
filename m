Return-Path: <linux-iio+bounces-17488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB98EA76D36
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 21:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863463AB66B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 19:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7021ABB1;
	Mon, 31 Mar 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="botxjJON"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A753218EB3
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447849; cv=none; b=Umet1tN9Y2V6AhhzjQ7HKTrRPhh/Me1tzr2HoPiaaq8XVQ+FYUsJbnzWuyyG3N7ntamytSrC2+A6R5+qOsqwUsvdHQu75cxlIumrdjqdRE+04WCylcLf3hABFALUoK3o/wnISvUthL2hsixkMTyyS0rkYKdA0LwTNBeixjMzxa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447849; c=relaxed/simple;
	bh=F2Qod7NABbhubiuu+bmx+zE/fhm/Yo5sMggxFose+iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPUVcx7eGlrdCZe3AYmU8yD0ijQ2eOqmFEL72kim3xQGaw6z+RanrLIRuFgAEeyqGZVthf07wMX6+BpKGZrBF2Fmh/IfkWkC0JcBaT3LthifNdE5IVYpLrqdSNSyrjmaPdQcrJz7hImocbzNG/W141I9L5T5OAlaLZ5nIpnBqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=botxjJON; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac41514a734so795392866b.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743447844; x=1744052644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShsE3ZcbHwYaWyOB5JwD08uVlCnOZ4Y4zX0gXgP+EjU=;
        b=botxjJONMq1XNSP1m+4d0W1/82YmAgXdqwQfI1o2IjiTJnnHSsODdL3lUuw0D82TKi
         Wqo5qHFN4661B/tsr2Ov+ZKS+2liC5Nc78bcJeI1QNRN5gl3+FGAfBU16iYknsZivQyZ
         i/nHL5OGr8fUA8pOEgbvNiOAVtyN/CVEgK7V2PAzNG44T/9UuxPUTdidom2AMDSC0RWS
         wltDwlg0kJquszJ8lNfqb/f7LJZOpMObuOngW+TX9tb/hmTv6RK9ZoUi3nNkVWsL2k8O
         HJmcSI3YjAKVANaF8u6Lvx7NNE1U7SJOBqTzGc4MotJYl4Egn9Wg4WXyDtLEXfmNM0BZ
         Y4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447844; x=1744052644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShsE3ZcbHwYaWyOB5JwD08uVlCnOZ4Y4zX0gXgP+EjU=;
        b=acxCNbEZ4tXWga/UeZlOzdPKcfbggsKTjO2qVYYTQy4Ps3kyvSi70vKx3BhK49/Xqv
         57sQF9Hxlyw1QvqCVLz0os3hPo0fhjaC2Z76KWWzEicw6/pA+LqoTX/CQ/E4N2HgL5FQ
         TzzdEW7udIh2BtP/0PnsYFh6wf/+lG+CJC/EJP9XyPEI1YYtg4aVXyYh2EKQqPxlJP4o
         BuHK5DZCLUKMmkbAcaz9gadZJVGcKwhMm9nr0Tj6YApORiemCcLuTf8vBKbb2tGsLPgz
         RO1G1bUOogf09/oDQjoMQUJvpInB4Wa7wudvtzv92zBcLRsyTSe0o2MuyrEUf/gcL95j
         yTGw==
X-Gm-Message-State: AOJu0Yxz+stejby9DziFKI7QE1BsPDvGcaLgvZL6S+0L06FWA9mLrOLK
	Gj7cXAMrrRab4Dp2VTd9aTEe3xj1tBhZqHvUR1Qhy5UQw4Ha4m+eLTCD5qiUsb5i0Lcr+6WYSkS
	N
X-Gm-Gg: ASbGncsriEY7GXtRskfP2UwGwFEYhym1OYI3nZZRCYUk5vC9PkCh16faPIKGkaoi8q+
	5Nf2yY2aZM+xEvOFYIHbj2ZzEziMbx9p/hSVoBk1+a2N1usXeH7XWgn7Qyx54LetsVcTGG+twag
	Z7GAZz2hc8tvV+5vUFoEQOsrMuz6RQPxJmbPaC01da0CgZ4xNZg0den+MSPccxWgA8gztErupqT
	b/9pCDu/iJd/vtYdYuwMXlkTN3NKvRYhyCosvWgBt2c9EGGNLfjblYBlGs3bOQg2acaTJlATuiJ
	G0FSUR2M0gTIwylfqWb0AlT+dyMHdxLUHvV1RQd/ItFIvmIG+beK2okG52evzUkBWSOwW/IBCw5
	m2UEvgoHczQcxzUzV/O/aL2n3hlj8
X-Google-Smtp-Source: AGHT+IGuQItt9kOHohfEdRqiYQ1qj4daUOg0M2kttNOL8REmmUJaouq4B1SoHf687sYLgKm6ciKoHQ==
X-Received: by 2002:a17:907:9708:b0:ac3:ed56:86dc with SMTP id a640c23a62f3a-ac738a4b283mr953684366b.31.1743447844447;
        Mon, 31 Mar 2025 12:04:04 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-172.pool80116.interbusiness.it. [80.116.51.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f9cfsm652288566b.122.2025.03.31.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:04:03 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 31 Mar 2025 21:02:45 +0200
Subject: [PATCH v2 2/5] docs: iio: add documentation for ad3552r driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-wip-bl-ad3552r-fixes-v2-2-cdedb430497e@baylibre.com>
References: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
In-Reply-To: <20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com>
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
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkh/9exWaIWaQl1Sgvvim+/ND1wUOxlvZZSyOOmFicU1t
 SQzA8nijlIWBjEuBlkxRZa6xAiT0NuhUsoLGGfDzGFlAhnCwMUpABNxOMnIcOvf041rRYquJ2Va
 2QpoPv3Ata/+n+W65Y7zdy7bEVgeWMbwT0+06WiWnH9pVMvMLcsmGfuk2S3fryiV9rR/jmePNr8
 UDwA=
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


