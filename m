Return-Path: <linux-iio+bounces-6119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA99018A4
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A72DB20C96
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1D55886;
	Sun,  9 Jun 2024 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdJHhy5q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0045BEF;
	Sun,  9 Jun 2024 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976314; cv=none; b=C6haL08SYP5l5gK+pJk2wALgh6bzSGB7GavGb3Wav4qSMZurVwylYzVPBUKwq81EA4Qr5Mxm+QK/2uypRivTU4sMVvRHI5tg2pDipbVVj7nnfGX67tT+kymMm3J0YB4Y4DZDXalbwMc/a71Zr5roiuPsRT7ZCuI5cIAqngTsNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976314; c=relaxed/simple;
	bh=/HIExraWSYrCMoCk7nOoIvhEXeD3HpJ2VyeOWxhE7ww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlJ3NL92ADVbihr12xchdLOR+UiRYxYRYOMsUcjhqnj/p2uOYykkciPxH2Lq4yAMKmUdL4OkIxSqaz9PtSe33E5PFE9WmE4fU+xulQaTK8h034claPL5/5mCI4+mJsf+MPaIHXr7kYmKHJRk0fW4o8cRWMObZwdMo+RUyNabkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdJHhy5q; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6ef8bf500dso174193466b.0;
        Sun, 09 Jun 2024 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976311; x=1718581111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qriIk15uECH849+rrPmyWW+JdSulOHZnSzKJ2HLoQPc=;
        b=FdJHhy5qZz0dYz9CeDIv94IZ1PwKHU8v6U0j6aMRWhZYDRLc/zk2l0hyZyk3BnlzGR
         2i6numns0GStILgXJisp6kLBSnDM8LbxIOS+7MKB5sX3lFF1i1mw9G7xt0MQrX4hJ1/Q
         Mci33uNwcwG9ABTo3538A1SUqSsvylDb+/hREv5dvcfeDMxQ+vYPAiGX9cmUm0J1lGHW
         PDWIOqo855cnu4qYl4Vcx3rsPyh1iki+iEeXLAWwxDBzDszWC1UHba6YrITXsv8FA7Xv
         D8pnR127+gojB6hlpMH7y6pmUwl6sWLLgRXd6MnyP6WMlx2C9oqnWFIz90+1B/aCFhic
         4fRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976311; x=1718581111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qriIk15uECH849+rrPmyWW+JdSulOHZnSzKJ2HLoQPc=;
        b=lBZPFLJoWwsLsAOazsm9BAhOIP5vtx6oHsThPIQhiwwxdwAcbEJtLegqHNypuhqfOn
         2/b2AsOcZ7efYPZsERS3jWbEEAYcz6urNVM7oFZLJgjjKoCY7e4tE6YNmPj+EjNjA3By
         A2xQtryXtWHfqHYggVTs75B20BJdgBpUwLYbbRSChVg+yCpRVhseWfqlM1+oeOINVyQQ
         N2fCZf/1wqqo/1I0rW3uUmjVcwZEurBBU5rE/sF9out22Y1aBgqmQYplaxZRzd/BE5pK
         usMJXZRY9WyClk7eCwb36JOnQBOCRu+rCUHCeeG8gTrJBY1x0zQneTDrf9bQ2nKuIfZm
         zV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRSosD+QhwEHeGCYAQSYY3/F+dBvmmGhqDWeYHe/cUM60Uj4cDJoX7V1ozshK0WXgs1Y9ndSwWkJRDJlmII2raPgDh0u/DsFoGgkvKz5CtnQW5JfewflTcLqF9x9aI5qlR/OvB2jur
X-Gm-Message-State: AOJu0YwIrY6hfM2oD10JXXBDEnS6R8ocNPWaEsGF3F3M3uv+tq7MaVan
	YPCDzhZgxSTO7aB1Cgkc6W/u3oYrtC9DO+lSjUQgtdd5EMeTzI/i
X-Google-Smtp-Source: AGHT+IERaB+Z/GAMpTRXxjz7QRhf2zYbS0Dm69EmyxWnI5cCUibMrTiOGvazxyNdYkcPuas2JmXErA==
X-Received: by 2002:a17:906:2c16:b0:a68:a800:5f7e with SMTP id a640c23a62f3a-a6cd561f12cmr526136166b.10.1717976311357;
        Sun, 09 Jun 2024 16:38:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:30 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 01/15] iio: chemical: bme680: Fix read/write ops to device by adding mutexes
Date: Mon, 10 Jun 2024 01:38:12 +0200
Message-Id: <20240609233826.330516-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mutexes in the {read/write}_raw() functions of the device to guard the
read/write of data from/to the device. This is necessary because for any
operation other than temperature, multiple reads need to take place from
the device. Even though regmap has a locking by itself, it won't protect us
from multiple applications trying to read at the same time temperature and
pressure since the pressure reading includes an internal temperature
reading and there is nothing to ensure that this temperature+pressure
reading will happen sequentially without any other operation interfering
in the meantime.

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 500f56834b01..a6bf689833da 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -10,6 +10,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -52,6 +53,7 @@ struct bme680_calib {
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
+	struct mutex lock; /* Protect multiple serial R/W ops to device. */
 	u8 oversampling_temp;
 	u8 oversampling_press;
 	u8 oversampling_humid;
@@ -827,6 +829,8 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
@@ -871,6 +875,8 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	if (val2 != 0)
 		return -EINVAL;
 
@@ -967,6 +973,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		name = bme680_match_acpi_device(dev);
 
 	data = iio_priv(indio_dev);
+	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
 	indio_dev->name = name;
-- 
2.25.1


