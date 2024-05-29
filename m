Return-Path: <linux-iio+bounces-5435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA698D35D6
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 13:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B5A1F23D1D
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE091802DE;
	Wed, 29 May 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gbmxHoSK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BC14B973
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716983760; cv=none; b=M2tF69yex4u8ZMfquYIBGQIOjG5AA8C46DQeCTFErdloj7N8+2+OcyHlTcwL9Hy2RV4d0HVBfcQFtD6Yyb5EjBcY29st6ndSrPMet3YW7hyxBTw97XTGXyBWZYAm0T7Ve6wK6fCvrBAdj1lzJWTwqZpOjUnH+4cI4jM3/sqeQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716983760; c=relaxed/simple;
	bh=wFaV86ck7QF8ggW3rB5WVf3ZtFyBTjaT7frcFvGnbMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cf6iJxl7K++dC8QW6d0jeQGMN74X/Q0qTVJJumy0q5WuPCBjdNcF4/jw1dJdvo5A6hrpyjkFtjgnDoZr9LXd8ng1CUZFeddbQZZms3bqB7nt8Sztd8JtetJyj/R/XQFjW097QbVlirY+iOh7//Xs3dE0e4QvwMeSuUb6n2G2pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gbmxHoSK; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-354f51ac110so1974635f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716983755; x=1717588555; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9FUeFgYpsWXF3MFE7xmBZbQGZ+/K1H8MVPPwiFhTR4=;
        b=gbmxHoSKnjF20jU0HewqmeiCAppoFKjki/VZ6wBPRQDipQJUGw8BB1L09ffR41Aqvf
         UmX1ZYGSBR8jwAn0Y9TbTk+XumptqrfkSyEoFZJUhq/8AERMppynjRo/um24bOPYZmku
         G+XLEYyKUxumGwIIzasQcRd3Lu8uEVpu9HhSwbOOoZRerFZeHf39P/mEdMkBmHXWP9of
         iMW2iQGjccqmtkt6vB3niHlhpFWCmry6cmyIHz6VQd5ISxjnWBWVGumIuzPJa3wKvX6p
         u3NRsKXOiv0W8WA4G0HE2yBlsGLK9rlqh70VClPu4QqRZLcvj2bcaWuVQGAjtnLl4ozJ
         rfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716983755; x=1717588555;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9FUeFgYpsWXF3MFE7xmBZbQGZ+/K1H8MVPPwiFhTR4=;
        b=puHT+hz8TJFrxM1rbfUJ8uuAbqOvd8CWoJpfqjDeJBg3h5fOc0wuqMjosj+7fE4VWD
         bR3cqmxkVkKS0p62xvsTfPnmXwrLFHVI/e3BBpmKgb1dBhfcv/pJc5/e6Uz+hp4Tdcm3
         Sb4MJ5Q7a4lVVwFYRiItH24zb671sgwPHGSVcumUu6DuP2FE+f1nIpoqYMyPG9ceCzfA
         BwfPyxoQH7/Ak/StcL9+3GtKGm9DEDkbkx4bd+WpeXynpOKqPVIVSP7B/hQMmHPioh3f
         fPueDIq63B0qs0fLzfVt9+YGhrTbUQV9v31whQtG+318ZQcEcvBBpkw3xRKN1DAH0QMh
         8YNA==
X-Gm-Message-State: AOJu0YxE5tnl8SLP/VGTCtm6Ud+Gy8WgmINwu9Qpj9yDcFWtpZg0UCgv
	YQ9NAJJyzD71zjESwLUzVdEgVljHAmKOqxJRVS5wMyheLZIPxVfk/LT8tmG/JJc=
X-Google-Smtp-Source: AGHT+IFmFZnnN8czMqY8uLukaazrDK7oBtqJXR5sTBMOCV4ypMULcy6vjSsi/NnB59THLYsQFx6A6w==
X-Received: by 2002:a5d:4089:0:b0:355:7e4:3cfb with SMTP id ffacd0b85a97d-3552f4fd798mr12389882f8f.23.1716983755303;
        Wed, 29 May 2024 04:55:55 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de7esm14482339f8f.14.2024.05.29.04.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 04:55:55 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 May 2024 13:55:52 +0200
Subject: [PATCH v2] driver: iio: add missing checks on iio_info's callback
 access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMgXV2YC/3WNwQ6CMBBEf4Xs2TW0Yqie/A/DYVu2sAlS0yKRE
 P7dSuLR45vJvFkhcRROcC1WiDxLkjBm0IcCXE9jxyhtZtClrsqzNigS0IXI6OWNiTtPr2FCorq
 yXDNzRZC3z8i53733JnMvaQpx2W9m9U1/xssf46xQYe29smSMak/mZmkZxEY+uvCAZtu2D3UCX
 9i9AAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

Some callbacks from iio_info structure are accessed without any check, so
if a driver doesn't implement them trying to access the corresponding
sysfs entries produce a kernel oops such as:

[ 2203.527791] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when execute
[...]
[ 2203.783416] Call trace:
[ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18/0x48
[ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
[ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
[ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
[ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
[ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
[ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
[ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b6eab000 00020000 00000000
[ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 00000000 00020000 00000000
[ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
[ 2203.830363] Code: bad PC value
[ 2203.832695] ---[ end trace 0000000000000000 ]---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- crop dmesg log to show only pertinent info and reduce commit message
- Link to v1: https://lore.kernel.org/r/20240529-iio-core-fix-segfault-v1-1-7ff1ba881d38@baylibre.com
---
 drivers/iio/industrialio-core.c  |  7 ++++++-
 drivers/iio/industrialio-event.c |  9 +++++++++
 drivers/iio/inkern.c             | 16 +++++++++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index fa7cc051b4c4..2f185b386949 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -758,9 +758,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 							INDIO_MAX_RAW_ELEMENTS,
 							vals, &val_len,
 							this_attr->address);
-	else
+	else if (indio_dev->info->read_raw)
 		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
 				    &vals[0], &vals[1], this_attr->address);
+	else
+		return -EINVAL;
 
 	if (ret < 0)
 		return ret;
@@ -842,6 +844,9 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	int length;
 	int type;
 
+	if (!indio_dev->info->read_avail)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
 					  &vals, &type, &length,
 					  this_attr->address);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 910c1f14abd5..a64f8fbac597 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -285,6 +285,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (!indio_dev->info->write_event_config)
+		return -EINVAL;
+
 	ret = indio_dev->info->write_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
@@ -300,6 +303,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val;
 
+	if (!indio_dev->info->read_event_config)
+		return -EINVAL;
+
 	val = indio_dev->info->read_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
@@ -318,6 +324,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	int val, val2, val_arr[2];
 	int ret;
 
+	if (!indio_dev->info->read_event_value)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 52d773261828..74f87f6ac390 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -560,9 +560,11 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 					vals, &val_len, info);
 		*val = vals[0];
 		*val2 = vals[1];
-	} else {
+	} else if (chan->indio_dev->info->read_raw) {
 		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
 					chan->channel, val, val2, info);
+	} else {
+		return -EINVAL;
 	}
 
 	return ret;
@@ -753,8 +755,10 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 	if (!iio_channel_has_available(chan->channel, info))
 		return -EINVAL;
 
-	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
-						 vals, type, length, info);
+	if (chan->indio_dev->info->read_avail)
+		return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
+							 vals, type, length, info);
+	return -EINVAL;
 }
 
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
@@ -917,8 +921,10 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
 {
-	return chan->indio_dev->info->write_raw(chan->indio_dev,
-						chan->channel, val, val2, info);
+	if (chan->indio_dev->info->write_raw)
+		return chan->indio_dev->info->write_raw(chan->indio_dev,
+							chan->channel, val, val2, info);
+	return -EINVAL;
 }
 
 int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,

---
base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
change-id: 20240528-iio-core-fix-segfault-aa74be7eee4a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


