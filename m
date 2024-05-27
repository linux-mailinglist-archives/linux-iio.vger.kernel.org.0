Return-Path: <linux-iio+bounces-5369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3E8D09F7
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB641F21DD5
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9753116192F;
	Mon, 27 May 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPRqEMio"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66981607BA;
	Mon, 27 May 2024 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835102; cv=none; b=c3i5eA0JVrqxz65RN1PszsM1rQk0OxJXiw4MRvgNSREgQVa5HvpMMMBLgGDxzWNLP6k2w2wZWRUOB1rFbEYai3Zvkkktu3Nl54qqnubsO7QWdl5c9RJ8WtFCZaut0a/b4P9UOkaRhsksLzOG8TYOPEQRp6xtkMosFy8rSJTjQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835102; c=relaxed/simple;
	bh=8h3ZRg9jE+wXkQFtxydH/IDDDXBcwvRNSAmtK1noof4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGyMCMx3GhYqRpJ/+MUVOMXo7sbExZ6gZvRXZQ7H3FCMXp1GwTAFN+Pdn3IYTh9VEKLh540/4htrhk4Dwq40r89dStgTqwzK+Ihfbghgfizf7dFeJrB06VJuITR0trWBHhJqG5ARcpnWcrmiocCDVBT8sPx4iymz5cANofKXmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPRqEMio; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-529aa4e988aso61865e87.0;
        Mon, 27 May 2024 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835099; x=1717439899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPmAz60TWZ3wSMtgFHp8/duTRSijFC9UjSGJVty6+0o=;
        b=TPRqEMiofPzbGgXvwPJoevQxKMZIa66JOGxmgCKRixPC4kZYzWHELwU7RsRoixTXXA
         wlRfqlCA2ppbJVYQaxr26KFkKzKEbQucJMqfEK0tVspRWUQHhpihdKYK66E9nkFobTRk
         pvJnql/puEweU08zjIJjdBSa48z0ZMv06dsO6NAVtWnhZDfPDjkOQe8sg7+g8T4T8Ehp
         DZPNfk5bQ/yvD3mQaS9uPJn0/SFGl5HckCIAzGTplxjTDFxlTvmi03hLlo0UZKyZNN7W
         e6fG2oENNXzYT3zMc59HKlPAh8MhA/c9EKVUjcN6fD/SkvwEvmymP7iy9DR7ENJJVh7s
         GcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835099; x=1717439899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPmAz60TWZ3wSMtgFHp8/duTRSijFC9UjSGJVty6+0o=;
        b=DLdHqe8MMBp7r/QRQqL4zxEQzKjFAxPrY7x2GBBTDf+Cxf2x5AcplT6PEgauUl4YyH
         uLZMmDnf2naWhAsz3QBvAv18BE23B1InWVptVQRlgUcPkp9Sg/Xial1AfpUw5TGGwT1T
         qz0ID1nYVL6JRrk4i2UyUmaVRhBi45ZEdRleJrpKwbYqXvVUKVV2MY1djIlUdvLf/ghz
         0oOCbkuv2ogW/x3vSNowgoLGM0kCVDWhtD78ljkr16L32NQMsr6bwDOmIzII9NtLSuo5
         bNAF45jXr5/OZsYXvtY8AHZC1R3rp36tN1exEJ5STohQom+yMpHHIFneO9Ox9gFEx7/G
         BV6w==
X-Forwarded-Encrypted: i=1; AJvYcCUuLQJ+kBWzZLnQUOP1nXmjBAX88tyBrTd9TClG1TZSZUXDI0tn1m24HMvA0rJ+Bd8l44Rk9/9WJE1ns4zpWLy2RAWhD8tus8KnlkVhUyGAtko8Usl15WNE/P+HqFHN2FgU4B09/y/9
X-Gm-Message-State: AOJu0YyHx0lJxKD1qJMkiqbofqLW1HRZ4BLgyZ797KJAmIBX/5iIXG+C
	m6flBlLNW21It+RH1aSQigjr3LwxCk/Uy6R/Sfj63g9pUFHQsnX8
X-Google-Smtp-Source: AGHT+IE6dWkVBZU8rST46PJ+hOEJ+EjGd8INABvR+NoEKiyuqatG5TvDevFHfouDDk077DqIkN/Qgw==
X-Received: by 2002:ac2:5ec6:0:b0:51e:147d:bd2d with SMTP id 2adb3069b0e04-52964eac421mr5664708e87.39.1716835098789;
        Mon, 27 May 2024 11:38:18 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:18 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 06/17] iio: chemical: bme680: Add mutexes to guard read/write to device
Date: Mon, 27 May 2024 20:37:54 +0200
Message-Id: <20240527183805.311501-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
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

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 8b42c4716412..2ef3fc7effc6 100644
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
@@ -806,6 +808,8 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
@@ -850,6 +854,8 @@ static int bme680_write_raw(struct iio_dev *indio_dev,
 {
 	struct bme680_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	if (val2 != 0)
 		return -EINVAL;
 
@@ -946,6 +952,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		name = bme680_match_acpi_device(dev);
 
 	data = iio_priv(indio_dev);
+	mutex_init(&data->lock);
 	dev_set_drvdata(dev, indio_dev);
 	data->regmap = regmap;
 	indio_dev->name = name;
-- 
2.25.1


