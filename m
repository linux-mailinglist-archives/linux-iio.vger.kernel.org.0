Return-Path: <linux-iio+bounces-9155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9BF96C746
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE01F263C0
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E71E5034;
	Wed,  4 Sep 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F/OCdHX5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E51E500A
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477269; cv=none; b=QxXBfJHQ7qn74Cu1KUB0E+hwRvoiUeBkPxA6Yn5RSyuFQU1gs8VNiCFyogi8jMYpSmDFCOCq6g+9Gz7JOP6EB//f6ousD/aaB7oMFi0y3bSylbSKGidvoVaMgAKsnFL8pSDbS6/8CoUNuykkR/1zr3t2923MNVIMsuCCD2EEGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477269; c=relaxed/simple;
	bh=CGZ9TfH82xYtf2SZDvwZlx08DxnCJf+sySQ8GbSU7/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXtb2u+sLioM/TnIVPmApToF+ZQ2EHflEYeITPyG7B3oQo2cZDUxifSVCgJhbZoo0bdJ40n/TYRBRgm1AuBtHRh1W5qVGEu2Fen4WKOiEhNjoyH+GFfNg/6U/HJcgfedFq+J2pj6xSqXWn/EBe2uvJcWggqK80ItiKDaCAvpKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F/OCdHX5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a80aeabb82so417834985a.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725477266; x=1726082066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSvZYoHybDPnZClgnrcppHDQUUEDcvsxsQCuR8Zqm6s=;
        b=F/OCdHX5/UUXjJwNOrsfcWrVI1cyxEHpfIRnAN8GZFhZ+98/BxGg8oKyByUvMCpAYM
         s/GR68fsxdQUlQoCLg/iW0/a7cYjU/V/qPlREfTTe+R3rFKKwiykM50G+WGhzeaK1Fqn
         bG801zoMZO7rd4v8B9LA17hIJeo2d0I1KQkq7kkklKcw9Tq+hb5r2Fsx8NTYP7QYQTsM
         FXPrSO8qGcbv7GLtkSfIJksQIRCIcMb78YP6IVm7h564SQlYFuwVkDZFceZR5y+XbttC
         eKfIFV04vFmUOZyeTj1gMiwBOSAYabc1lIc78m8XizJGRQmzeWnVk10GCOGJdXwooOQ1
         EihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477266; x=1726082066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSvZYoHybDPnZClgnrcppHDQUUEDcvsxsQCuR8Zqm6s=;
        b=XgvonwrKwdu8XiQ0wJFJ5EMrV3ydAGImFd/nPtLMrowRPLsHe5mxx+Y+/jpW/17GQo
         KMoH6WTXRDYvTAtMqv1Y98om86iTRIWim98V/fdSf39vPNFem8MPAvorq7guhz3tCrIy
         xKv0UaqOXjDYXbuyr49QYyt8bx1oNw2yF6mLBdeHTW5hrfrq56kc7WeQpEgxPPdHmWMC
         R67VZEH4zt2ymuEFu5tqJ0XIeNtOeajk75/NnwE8E/QEqmMsfh4xevfec/drOuv7/GpI
         Ukf2SMir6Lh3SkYFa7GimzAGqQgroZLAcxWjaQJPbo5bKygB9iUpJR/WBoUQ20drntA2
         H8AA==
X-Gm-Message-State: AOJu0YzxaewbUHwn3VPpPQBhLW3roum3uBhYaKnNpweMetqwTIvTdkb+
	oZWr8T34XePW9Ne1synra9T8vmd6K9D++qA7qtLOwhZ/xPFnll/K6PyTmQys9p4=
X-Google-Smtp-Source: AGHT+IHfNAVRkX0BXfCeeLgwXDETbxHr52dcf84Hv2nlOAa9aerS4GX8z0C7xywe2K8y04FTipGSaQ==
X-Received: by 2002:a05:620a:1907:b0:7a1:c431:3bc2 with SMTP id af79cd13be357-7a9788c4dc8mr1055319185a.44.1725477265888;
        Wed, 04 Sep 2024 12:14:25 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f026caesm8861085a.135.2024.09.04.12.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:14:25 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 04 Sep 2024 15:14:20 -0400
Subject: [PATCH v4 3/3] docs: iio: new docs for ad7625 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-ad7625_r1-v4-3-78bc7dfb2b35@baylibre.com>
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
In-Reply-To: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>, 
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add documentation for the AD7625/AD7626/AD7960/AD7961 ADCs.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 Documentation/iio/ad7625.rst | 91 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 2 files changed, 92 insertions(+)

diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
new file mode 100644
index 000000000000..61761e3b75c3
--- /dev/null
+++ b/Documentation/iio/ad7625.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================
+AD7625 driver
+====================
+
+ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
+devices. The module name is ``ad7625``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7625 <https://www.analog.com/AD7625>`_
+* `AD7626 <https://www.analog.com/AD7626>`_
+* `AD7960 <https://www.analog.com/AD7960>`_
+* `AD7961 <https://www.analog.com/AD7961>`_
+
+The driver requires use of the Pulsar LVDS HDL project:
+
+* `Pulsar LVDS HDL <http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html>`_
+
+To trigger conversions and enable subsequent data transfer, the devices
+require coupled PWM signals with a phase offset.
+
+Supported features
+==================
+
+Conversion control modes
+------------------------
+
+The driver currently supports one of two possible LVDS conversion control methods.
+
+Echoed-Clock interface mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                                +----------------+
+                     +xxxxxxxxxxxxxxxxxxxxxxxxxx| CNV            |
+                     X                          |                |
+                     v                          |    HOST        |
+          +----------------------------+        |                |
+          |      CNV+/CNV-   DCO+/DCO- |xxxxxxx>| CLK_IN         |
+          |                            |        |                |
+          |                            |        |                |
+          |       AD7625         D+/D- |xxxxxxx>| DATA_IN        |
+          |                            |        |                |
+          |                            |        |                |
+          |                  CLK+/CLK- |<xxxxxxx| CLK & CLK_GATE |
+          +----------------------------+        |                |
+                                                +----------------+
+
+Reference voltage
+-----------------
+
+Three possible reference voltage sources are supported:
+
+- Internal reference (only available on AD7625 and AD7626)
+- External reference and internal buffer
+- External reference
+
+The source is determined by the device tree. If ``ref-supply`` is present, then
+the external reference is used. If ``refin-supply`` is present, then the internal
+buffer is used. If neither is present, then the internal reference is used.
+
+Unimplemented features
+----------------------
+
+- Self-clocked mode
+
+
+Device attributes
+=================
+
+The AD762x is a fully-differential ADC and has the following attributes:
+
++---------------------------------------+--------------------------------------------------------------+
+| Attribute                             | Description                                                  |
++=======================================+==============================================================+
+| ``scale``                             | Scale factor to convert raw value from buffered reads to mV. |
++---------------------------------------+--------------------------------------------------------------+
+
+
+Device buffers
+==============
+
+This driver supports IIO triggered buffers.
+
+See :doc:`iio_devbuf` for more information.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f77a1c1110b..cd5a18bf5e3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1279,6 +1279,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+F:	Documentation/iio/ad7625.rst
 F:	drivers/iio/adc/ad7625.c
 
 ANALOG DEVICES INC AD7768-1 DRIVER

-- 
2.39.2


