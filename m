Return-Path: <linux-iio+bounces-12279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A337E9C95E5
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FED7B266A6
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D181BD517;
	Thu, 14 Nov 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyLyteaL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9491BC9EE;
	Thu, 14 Nov 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625830; cv=none; b=nwUIcpNS8uaZVjztbRp/FcyUxtzwsMvoOQwbNmqhPHc+m5rH9ggjglhsyS6IETd59PQGd7Ala+q7gZu9sD7i99RG6PtJuErT6EJwBEjEDiRbF5GPBfV/xrnAreck/KHY3tyaDvRhx1CBAK4XKtg6U1zjLbAgeITKbZVjk+b8fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625830; c=relaxed/simple;
	bh=ev2Wu/gXNSjSOij9PQO/6WznPrulhD2PnlcIqOoQrTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTE1jz3iQ0k7NXX8zNVKamnW/RQo7WMhyoSGsKri4PJdGofIK2VbnBsX0rAyeuTMTRzoE8CTGbDm6KPXbDq0T8DUx5vWw2be/0lKCWHJl+2Vz52L/ZOPouidV8JHVygKmi+2dE0aeUFclQHXOHO5AIYmGEOlc+chR+QbVfey++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyLyteaL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so625735e9.3;
        Thu, 14 Nov 2024 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625826; x=1732230626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIqKzIejoyfItsKpIgyA1dC0uX/NO9YX2lqUdNJFK/Y=;
        b=fyLyteaLJ9juT/+PmM06MrY9QsWdG1vLWHLSiJomtb5EaV6aH+qiQqisrUKBN7Winr
         tohCe7Y13igiokE4rOvoIJHmTGdD02gIQDVslpSMZmETdRtiDoajfVKK+af7PZ+73q7Q
         XGzOYCB51zdBhBYD9c9qaBjdMc5xW8QqJ/HypxbWPQVqYja0Xjnt0ABdbeeC/ufthQ6I
         2+CTzcf/ofLQe+tMWSC1txmh23IGgq6P/0Trux2f/l7WOz1tStXERXN5TSm5g3SzuaZE
         Uar/meJAAF/TqqL3sNJLGq2gSggJ7qgya7YQqw6L3Q2o7pk7yrehLH1tCr6Y/MuUbtcI
         oYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625826; x=1732230626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIqKzIejoyfItsKpIgyA1dC0uX/NO9YX2lqUdNJFK/Y=;
        b=hPk4AJfiMA8Nr6uryZbheWtEBZGWDmWYwAamQVkMgKeuDE9yjrcNtbodknS+zcEk+G
         dxaKT1FlHCq1qNQ5gaBn1mjbdu22/qZ7fVZl57XY52jEgOKifosujbX/h5nn/ZuSACVI
         QrJgvgxy/16GPdT5EG204s4Jw6H5MIVYUJfmzYfkCeqiqtjRgGJPOfT51u32tkebfgWh
         kM+hu+Dx6JzPDtxXvjRq4/I8B8eahePWJaZPVKz7ixlLjq+YTaifNJHrKQaH4LyKJ1hu
         OZzbk63Av7/Z1XuyO8+t4ngXOeepYMiODGnOy4HgWcqgi+G0wbG88VNJTavpOZmMxttp
         ti7w==
X-Forwarded-Encrypted: i=1; AJvYcCU/yN0bEq13gx12PF5lCkDrfZrIxxR4Tw0sai+vxL+Os+dKwAVq8X5zilJ0TfAtdaMy0Kvo0nOepyXafbu8@vger.kernel.org, AJvYcCXZiIS9iOnc6IBJDOHlF2ceUQ2IZM6PuCiOJwKZVVc1YMGV3QWcaqnVMxIX21E3tGZJAoEApCOKFIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/x8rnPJQNEM6Cwu5JgaUz/0TVuEIaQQweDGtuM9Zlg9igXah
	ZZBj2/LvcLMvSWe1CmWEwr6aoG/mqL2E+mytRZAJc1xXsRUrcD82
X-Google-Smtp-Source: AGHT+IEyRmOqna4BTj63MSyNIFOcJGxI/aFIyTftVp+alwqZ6kJ7NbhPXKooO/CAyfDaLlfkwOz1Ew==
X-Received: by 2002:a05:600c:1991:b0:42c:ba83:3efa with SMTP id 5b1f17b1804b1-432df6841femr1834715e9.0.1731625825488;
        Thu, 14 Nov 2024 15:10:25 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:25 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 11/22] iio: accel: adxl345: import adxl345 general data
Date: Thu, 14 Nov 2024 23:09:51 +0000
Message-Id: <20241114231002.98595-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use struct adxl34x_platform_data from the included public header of the
input driver for ADXL34x with the following argumentation for this
approach:

- The iio driver for the ADXL34x covers features also implemented in
  the older input driver. The iio driver will implement the same
  features but can also benefit from including the common header and
  struct adxl34x_platform_data. Once complete, the input driver could
  be faded out.

- The fields in the input driver are identical to the fields the IIO
  implementation will need. Including the header over reimplementing,
  avoids a duplication of almost identical headers in IIO and iio.

- The header for the input driver is public. It provides a public
  interface for adxl34x related implementation and is not private to
  the input system.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 949847fad2..57ecf33d60 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -16,6 +16,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+#include <linux/input/adxl34x.h>
+
 #include "adxl345.h"
 
 /* ADXL345 register map */
@@ -126,10 +128,15 @@
  */
 #define ADXL34x_FIFO_SIZE  33
 
+static const struct adxl34x_platform_data adxl345_default_init = {
+	.tap_axis_control = ADXL_TAP_X_EN | ADXL_TAP_Y_EN | ADXL_TAP_Z_EN,
+};
+
 struct adxl34x_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	struct adxl34x_platform_data data;  /* watermark, fifo_mode, etc */
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
 };
@@ -329,6 +336,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	const struct adxl34x_platform_data *data;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -344,6 +352,16 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 
 	st->fifo_delay = fifo_delay_default;
+	data = dev_get_platdata(dev);
+	if (!data) {
+		dev_dbg(dev, "No platform data: Using default initialization\n");
+		data = &adxl345_default_init;
+	}
+	st->data = *data;
+
+	/* some reasonable pre-initialization */
+	st->data.act_axis_control = 0xFF;
+
 	st->intio = ADXL345_INT1;
 
 	indio_dev->name = st->info->name;
-- 
2.39.2


