Return-Path: <linux-iio+bounces-5951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ECE8FF6B7
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F09B1F25E13
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26319AD57;
	Thu,  6 Jun 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaVjqnJ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F819AA54;
	Thu,  6 Jun 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709043; cv=none; b=uVXoOdmML4eMJhGB9wL/LoBbjPq08AEDf3xNs2okEYpKfplfC5rKyMQcGpaThbjlksfSztISjceolLoV/MtKBNaQ7qeqIyFUSSZ2bdnJqHB8IySGhuOql0AZDjfx0csAiW14QhyLqtB2uJsFX0ZtEzlZw1FRW2QCjFSsVlf7CCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709043; c=relaxed/simple;
	bh=g9twr9QrxCTTdu0zJBHxxTeAILNtpGb898errfNyCCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qu+TzW5xlzV418uFa+CeFy94KRFMDVXM9lxs3yz2koBUbR2pf5aeMlmWiBoeIzu2zI1P4MXm2coKk2e/lHPHis4jXysLVWtYSQxTPF8Vo7ZDeiK0zrHc+Fqaz1QE0rV3tXygTW6kd5N+YsL7Hapx+q33dozMl7cMvHbtcjQhl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaVjqnJ6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso144248266b.0;
        Thu, 06 Jun 2024 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709040; x=1718313840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OSdOUMA3z39M416e40JdCwmRgGwxEfBXKuQ8gzxx2k=;
        b=eaVjqnJ6DiT7ZJLMD1jsZTLRtsCWSDu5DS8/uJCemZnqIrMlIDxFvLVw1iBdj2dIR4
         MSc7u2HcHXaDGlMRBun1FH8Dj0NicNCD1vnS/eaWBvVkSUiEukTCcAuqTthsnz6nL87R
         kmqskfOw6SYZwpzIeehl2jedmidvVwMh6zspVjy/OZetVBRpsgj1rnF1Qd9/n6nZPgKn
         g2o8sl/7kS9ewqOMWDVPO2tPh1okuFtfe9Gt+YIdvsLQvS8If5ps3VDGViLbT1/yGDdF
         YZ1l+hfqyyJCNexh3bqpXAGJDF4rJi1f3as2xugEStb/IRQkwlijWs5JSlV605G9Kfej
         lJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709040; x=1718313840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OSdOUMA3z39M416e40JdCwmRgGwxEfBXKuQ8gzxx2k=;
        b=Nv0XUPUO4RBTuLSmQWHget9myf1Q8y1nkeZn8Uh6XdoV8RIoGLTJbVcZVScnH1vOQz
         J6kXrN2N9PdnASI4q6J/HTRyz4yt2ix6A0DL3YRO5HnCqXxV4H2JC4N11h8tiNEppVNe
         2VaJysRpbRFAhOyjiVep5nWW5uEWeE7xcvKFJF1jxSdOzlKeoffUru5W/qkXgGMQgWj8
         E4vJ+WuNizBjC40nwxPPPAqNspI3kbrzfc+catLiGerh33c4Apoe2GQHzRe9oCdJ4iZn
         q93aAQWbez5y5Lcx6RnreKs3xwdQ48OzX1FXo6uVBcNVrWiP1YPPmoNWFvIw6NDkPZuh
         AVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZgE3oz5sGK3PGeRFstbykjT2vhzd0ZtnbqU5zkJkKUEGsp1B+QeNU+sN2a5XquzsjnxETtxZwVL8Xwh/t+1eYjB8uwYTtE2FFYRMFEJeRrucpPqcdhc8RYQhStC5ODoEi/8FS7s1k
X-Gm-Message-State: AOJu0YxPfEnTEm2gXblk7QSflc3tK1G/TQn571e+kyVfFplkHLjf/Ccp
	q5u5XLwZQ0/2semUPFRCs14VML8revbXNPDAuwG3Ivb+fhIFWnJ5
X-Google-Smtp-Source: AGHT+IEL0DUXlsnNtajjJkmgaI2vl2OIpOI/Uk/FYocQS41twowjsfd9VxqfXNypbDGodNM9BXdBxg==
X-Received: by 2002:a17:906:557:b0:a68:ce70:61f7 with SMTP id a640c23a62f3a-a6cd5bdc179mr45214066b.17.1717709039705;
        Thu, 06 Jun 2024 14:23:59 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:23:59 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 06/19] iio: chemical: bme680: Fix read/write ops to device by adding mutexes
Date: Thu,  6 Jun 2024 23:22:58 +0200
Message-Id: <20240606212313.207550-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mutexes in the {read/write}_raw() functions of the device to
guard the read/write of data from/to the device. This is necessary
because for any operation other than temperature, multiple reads
need to take place from the device. Even though regmap has a locking
by itself, it won't protect us from multiple applications trying to
read at the same time temperature and pressure since the pressure
reading includes an internal temperature reading and there is nothing
to ensure that this temperature+pressure reading will happen
sequentially without any other operation interfering in the meantime.

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 66177f7e94a8..92359032254a 100644
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
+	struct mutex lock;
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


