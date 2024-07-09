Return-Path: <linux-iio+bounces-7473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914792BE26
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 17:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CEDB220C3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68DD19D070;
	Tue,  9 Jul 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0hKce5KB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE715DBB9
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538244; cv=none; b=MwZjl8Bdeb5jjmQfFb7Do84+eW6Q7HVQkEa4wHNcPSiNgm4yfrRYWpDtS/s5Q3pos/WlruJh2n56uJ4HEUrqtPPqXOfvUCRK1X3gc+xqNBwIxxP5ERNjPy4qwYntq2+clsljdsK970CEwTehFa+sANhB1gAEz9ClBn8nwiYP/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538244; c=relaxed/simple;
	bh=BCey8AjMDfbjzwQFHrvi0uMaH8wJW0n3OaUZ9Y71v7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CCHQm+Cf8VtEW01tgEzhT0TGffo3RSOhs6I+18A66xMKk9Hq2t4LDzxsYb5SogHszpxGcIPp6YtBrkXXyfSm4VHznWwmdtDv/bUhwagVxoDXaHuUPCo+YNyQz2gFrcZ/DxugQbhpLcbtcBlKOm5XLgzLbGIV3aQrHppPd910e9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0hKce5KB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso12545795e9.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jul 2024 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720538240; x=1721143040; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mErFL1epJxVxgpYVvgXNP62u9HODdDh0QCDRMnvCKHU=;
        b=0hKce5KBpXqqazhQiTig7wbHvtDGHc/2Bdr/7sYrifPQBDjwIDLcEvnYZWYGCAqCLa
         u7DOdzJuas9g+v2MaBbgKMBG68uBjKjQm/pNANRlz2blKEJfKsowsY8EV7XzTPnYwO3A
         PiKSDUJie82NDr0JOeHRxainWs/XhpsIGgVtLNCJPj0Lhuxl7oLPMqcCwLzjvOgHlwz1
         VDOjfE1pN12sofDRKWHTnwWFIbKmAWG4uinHogqO4JdWYXUenvkkF9NVjoWzkQlBe/pN
         XWctHiIcZxsBdIJf0KuMzovOGsi/3aSSZ3g+6BITjh7A6BxO9Hq6LU3ctWvKWO3O9kJ0
         9Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538240; x=1721143040;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mErFL1epJxVxgpYVvgXNP62u9HODdDh0QCDRMnvCKHU=;
        b=Xp0tIvqC3HejkPTKz7rJTpwo85p1xERcg1RiHUKRNcSyOudZz/anD1du300WyA3OJd
         UreBioOqTQBN6RtTAp/M8WSXw0H+r1qfa7Qa5VCGms63lA6FIy3ew7DUhP5fykuc2TbW
         deD0MLt0VjxA9JLfAOu5z56wsuHMx/cyHmz0y4D8UI349KFe05yQVG9u7sGHv2I4c3KW
         CJUvZ9ENBZ71gj8vka3w+y+6B1gBpzFHdhuQevGz7xlezAAg1NSMXiOdKshiWn5Er0xF
         8K/ILnDzPOo68DWozenYsDPILf2moDYuWMR8UHcnEXkzUKZzaF8oI+TwsYODjX8kDbAy
         iGUw==
X-Gm-Message-State: AOJu0YwfVR6DNDptNG2JIZogX7JmV9ydtoqhiVEzG1S8J5mZbJs5f8KU
	udQKSlnheb+Tjsdf5Jqj4BPKK7F1L2o3YAcMBlU6Q5foXjcWrX1COp+6/RKPQOQ=
X-Google-Smtp-Source: AGHT+IGO8IFelHe4URymH4IAhQMKvxoHwu0bXEJPBXJYAOlwVaTPiFX9+Pdz/EPx7ZEpXu27qHvcuw==
X-Received: by 2002:adf:fbcb:0:b0:366:eb61:b45 with SMTP id ffacd0b85a97d-367cea46c00mr1914596f8f.1.1720538240165;
        Tue, 09 Jul 2024 08:17:20 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde890f6sm2827768f8f.53.2024.07.09.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:17:19 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 09 Jul 2024 17:16:46 +0200
Subject: [PATCH] docs: iio: new docs for ad7380 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-ad7380-add-docs-v1-1-458ced3dfcc5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAF1UjWYC/x2MQQqAIBAAvxJ7TjCztL4SHcTdai8aChGIf086D
 XOYKZApMWVYuwKJHs4cQ5Oh78BfLpwkGJuDkkpLI61waEYrG1Bg9Flo5Ra1zDR5HKFVd6KD3/+
 47bV+qC5xiWEAAAA=
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

This adds a new page to document how to use the ad7380 ADC driver.

Credit: this docs is based on ad7944 docs.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This commit adds documentation page for ad738x ADC family
---
 Documentation/iio/ad7380.rst | 88 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst  |  1 +
 MAINTAINERS                  |  1 +
 3 files changed, 90 insertions(+)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
new file mode 100644
index 000000000000..061cd632b5df
--- /dev/null
+++ b/Documentation/iio/ad7380.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=============
+AD7380 driver
+=============
+
+ADC driver for Analog Devices Inc. AD7380 and similar devices. The module name
+is ``ad7380``.
+
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7380 <https://www.analog.com/en/products/ad7380.html>`_
+* `AD7381 <https://www.analog.com/en/products/ad7381.html>`_
+* `AD7383 <https://www.analog.com/en/products/ad7383.html>`_
+* `AD7384 <https://www.analog.com/en/products/ad7384.html>`_
+* `AD7380-4 <https://www.analog.com/en/products/ad7380-4.html>`_
+* `AD7381-4 <https://www.analog.com/en/products/ad7381-4.html>`_
+* `AD7383-4 <https://www.analog.com/en/products/ad7383-4.html>`_
+* `AD7384-4 <https://www.analog.com/en/products/ad7384-4.html>`_
+
+
+Supported features
+==================
+
+SPI wiring modes
+----------------
+
+ad738x ADCs can output data on several SDO lines (1/2/4). The driver currently
+supports only 1 SDO line.
+
+Reference voltage
+-----------------
+
+2 possible reference voltage sources are supported:
+
+- Internal reference (2.5V)
+- External reference (2.5V to 3.3V)
+
+The source is determined by the device tree. If ``refio-supply`` is present,
+then the external reference is used, else the internal reference is used.
+
+Oversampling and resolution boost
+---------------------------------
+
+This family supports 2 types of oversampling: normal average and rolling
+average. Only normal average is supported by the driver, as rolling average can
+be achieved by processing a captured data buffer. The following ratios are
+available: 1 (oversampling disabled)/2/4/8/16/32.
+
+When the on-chip oversampling function is enabled the performance of the ADC can
+exceed the default resolution. To accommodate the performance boost achievable,
+it is possible to enable an additional two bits of resolution. Because the
+resolution boost feature can only be enabled when oversampling is enabled and
+oversampling is not as useful without the resolution boost, the driver
+automatically enables the resolution boost if and only if oversampling is
+enabled.
+
+Since the resolution boost feature causes 16-bit chips to now have 18-bit data
+which means the storagebits has to change from 16 to 32 bits, we use the new
+ext_scan_type feature to allow changing the scan_type at runtime. Unfortunately
+libiio does not support it. So when enabling or disabling oversampling, user
+must restart iiod using the following command:
+
+.. code-block:: bash
+
+	root:~# systemctl restart iiod
+
+
+Unimplemented features
+----------------------
+
+- 2/4 SDO lines
+- Rolling average oversampling
+- Power down mode
+- CRC indication
+- Alert
+
+
+Device buffers
+==============
+
+This driver supports IIO triggered buffers.
+
+See :doc:`iio_devbuf` for more information.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 9cb4c50cb20d..b0385a9ee5a7 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -18,6 +18,7 @@ Industrial I/O Kernel Drivers
 .. toctree::
    :maxdepth: 1
 
+   ad7380
    ad7944
    adis16475
    adis16480
diff --git a/MAINTAINERS b/MAINTAINERS
index 06ecfa64a39a..40cf58c2f884 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,6 +447,7 @@ S:	Supported
 W:	https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad738x
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+F:	Documentation/iio/ad7380.rst
 F:	drivers/iio/adc/ad7380.c
 
 AD7877 TOUCHSCREEN DRIVER

---
base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
change-id: 20240708-ad7380-add-docs-42a9296e5cd3

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


