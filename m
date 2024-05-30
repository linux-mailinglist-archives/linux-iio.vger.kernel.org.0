Return-Path: <linux-iio+bounces-5485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842D8D486A
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B936C1C2313B
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5618396B;
	Thu, 30 May 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b0bPaOlA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961C15350D
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060974; cv=none; b=BGu3/ucrBrYPIdt744lAFen4c9q4YCrWIqMB1HGwnknGx7EIB2HK3qjKzAap4Ahwg9duxX4Ave1NIivzoRf8PJP6VqHOPljAlIuR2aFj2vEsyWU7OZf0/71dm2nGjVzetBHLC9vMWior7+Z4JNw5ygIvmkKmd2OUArv2wyhxG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060974; c=relaxed/simple;
	bh=JV3aKpYhDOlbBNSDs90ahSNr2A5Jetll0JejNM/sBOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H12Zs3prL4opRAjoY1oUpoo1ztq5VvB0CiH+rmPPmU1cEhrn19bnvEgYOs/gx4s/JDLfj2KLpBPJ3GMUaPT9JwpXmSzQ2R8j8HgUxHn/ofLg0ENNmHSBmyC+onks0cPV+R0DhZB3Wojz7fb/UzI0tWmbSa1RBRlTaYb5tthiyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b0bPaOlA; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-52b03d66861so665876e87.1
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717060969; x=1717665769; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXLwljYVk+zejltvUJt8Jdl0RUmYGHhrK4wK721fWFY=;
        b=b0bPaOlAICyC2grEskArwp3xbkkH6Z13g6Z6+3u0OTS+XgOeqO6QL0vQQ6yeugoD9Z
         JRh2Y4jW67dZJbanAsSLSYPn+ppQCsGvbp7wzVrwrBgUgpTdtCuozOtOljOfSQPmwZHz
         xj0FxZ3jd9IXdMLvYE5L8jSxKkyinxAFwqGgUsm6F2XJ0GOcVT+5mwguVKCz8SNKun8L
         iNzTX23HHg3DA7ypAnwQ9nwQYF8ZT8qXRAZf8nIh721UErqucStJ3HoCha7go1HrpGbp
         64IOaN+O/Z9xU3REn1nNlyQ87Gz59UdOKfk3ZdVsCgJZRWMnzFAQsw2S+Oe1qj/wze5R
         cazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060969; x=1717665769;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXLwljYVk+zejltvUJt8Jdl0RUmYGHhrK4wK721fWFY=;
        b=XPmpUcCY4bU1lOFj5cwnOMvcUkBwPbVUl3jcz9JLzRsEcRvwSRoOcHeKgDE8w4KK8F
         /K0dX3lyzWYJkYborbKtYfz3psh9jrV0R9KczPMEnDgBOmgQoaHPk9MrZx/s54HsUZlA
         35BcxRtJ58c5P6zA957CikPOI8aDzKpEn1ZdSlM6iMwL/sw8OH+lN8dXFeypE626aTRb
         fM/bIxwZKNHfCixRXYhWNznRl+cNaKXAJ+NOp1r+nWVsxRFpMU6wj3qv/SnHtznDHkx0
         hoF+4bunC4+X5tINgKiFMi6kRK6/8YhNTYVKBCY5zucoe78ufQtKPbj6iyFdxgg47r3P
         lQcw==
X-Gm-Message-State: AOJu0YzPw6fzVSpP2kRC6k6m/KcrVb0+3zX4mQz86Y+fSs0Qqd1VQUzC
	SjOSIfUALLDTR5JVDXe4AMvNuCxEWSFrI0u/Nzq4vk1OvOHDuP5VG1HA06nKnoc=
X-Google-Smtp-Source: AGHT+IHKehsC9VVT2rC8wDwhqgEhT1FB5Ptp52tC8P5RpVAwgkr36TvRuGBKSA8S9g9LIT+AI6mstA==
X-Received: by 2002:a19:8c55:0:b0:529:a389:f6a6 with SMTP id 2adb3069b0e04-52b7d490f38mr931451e87.67.1717060969075;
        Thu, 30 May 2024 02:22:49 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3558889fb57sm17163176f8f.114.2024.05.30.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:22:48 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 30 May 2024 11:22:46 +0200
Subject: [PATCH v3] driver: iio: add missing checks on iio_info's callback
 access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-iio-core-fix-segfault-v3-1-8b7cd2a03773@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGVFWGYC/43NwQ6CMAyA4VcxO1vDBsj05HsYDx100ASZ2XCRE
 N7dQeLFxMTj36ZfZxHIMwVx3s3CU+TAbkiR73ei7nBoCbhJLVSmiqxUGpgd1M4TWH5BoNbisx8
 BsSoMVURUoEi3D09pv7nXW+qOw+j8tL2Jcp1+xNMPMUqQUFkrDWotm1xfDE49G0+H2t3Fikb1F
 6RWyJRYWjzqMrdf0LIsbwKpLUYGAQAA
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
Changes in v3:
- Use local variable in inkern.c to reduce long lines
- Pick up Nuno reviewed-by tag
- Link to v2: https://lore.kernel.org/r/20240529-iio-core-fix-segfault-v2-1-7b5a5fa6853f@baylibre.com

Changes in v2:
- crop dmesg log to show only pertinent info and reduce commit message
- Link to v1: https://lore.kernel.org/r/20240529-iio-core-fix-segfault-v1-1-7ff1ba881d38@baylibre.com
---
 drivers/iio/industrialio-core.c  |  7 ++++++-
 drivers/iio/industrialio-event.c |  9 +++++++++
 drivers/iio/inkern.c             | 32 ++++++++++++++++++++++----------
 3 files changed, 37 insertions(+), 11 deletions(-)

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
index 52d773261828..77cf1f22df31 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -543,6 +543,7 @@ EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 			    enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
 	int unused;
 	int vals[INDIO_MAX_RAW_ELEMENTS];
 	int ret;
@@ -554,15 +555,18 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 	if (!iio_channel_has_info(chan->channel, info))
 		return -EINVAL;
 
-	if (chan->indio_dev->info->read_raw_multi) {
-		ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
-					chan->channel, INDIO_MAX_RAW_ELEMENTS,
-					vals, &val_len, info);
+	if (iio_info->read_raw_multi) {
+		ret = iio_info->read_raw_multi(chan->indio_dev,
+					       chan->channel,
+					       INDIO_MAX_RAW_ELEMENTS,
+					       vals, &val_len, info);
 		*val = vals[0];
 		*val2 = vals[1];
+	} else if (iio_info->read_raw) {
+		ret = iio_info->read_raw(chan->indio_dev,
+					 chan->channel, val, val2, info);
 	} else {
-		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
-					chan->channel, val, val2, info);
+		return -EINVAL;
 	}
 
 	return ret;
@@ -750,11 +754,15 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 				  const int **vals, int *type, int *length,
 				  enum iio_chan_info_enum info)
 {
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
 	if (!iio_channel_has_available(chan->channel, info))
 		return -EINVAL;
 
-	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
-						 vals, type, length, info);
+	if (iio_info->read_avail)
+		return iio_info->read_avail(chan->indio_dev, chan->channel,
+					    vals, type, length, info);
+	return -EINVAL;
 }
 
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
@@ -917,8 +925,12 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
 {
-	return chan->indio_dev->info->write_raw(chan->indio_dev,
-						chan->channel, val, val2, info);
+	const struct iio_info *iio_info = chan->indio_dev->info;
+
+	if (iio_info->write_raw)
+		return iio_info->write_raw(chan->indio_dev,
+					   chan->channel, val, val2, info);
+	return -EINVAL;
 }
 
 int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,

---
base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
change-id: 20240528-iio-core-fix-segfault-aa74be7eee4a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


