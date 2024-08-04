Return-Path: <linux-iio+bounces-8236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E422E946F4D
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 16:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F3E1C211D2
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4705589A;
	Sun,  4 Aug 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egql+PYo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0F61FDA;
	Sun,  4 Aug 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722781431; cv=none; b=bvBOXQ1o6hXswVa5tDCJS72in1U3RUYuhHkeDL0DviryJEf8ZtJ1I2dD+bij5krkZQMZD0kAkYP6PoK0FFEpD038ukYEJ7CMtp4iVy2IfVSuVyyEACK657QDQM/bavMp7DKRwV/zzX7Fh4hNf3OQReS/eBkmDo7YJ1BDVJ7js2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722781431; c=relaxed/simple;
	bh=RgvFY5hMdtkZMQD226LXln+PQFCch/QPC/FIkEkOe8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv9gBSTCAfPd5tih3nqdEYycZdjsbPPHBt1+IDXmPGiP5hNkd9GuSjvJCcnsdwLHn/kSRpfT2N0XhcIIH9/pqI9JCNPnBdFlr1/vwwApm8Dh1nQRevJ5ayGjmGe1O3srdYHV9bB13HaDwIZbicnM08RoYIFJ0tYmrD5LwyjU1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Egql+PYo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd69e44596so34070845ad.1;
        Sun, 04 Aug 2024 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722781429; x=1723386229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIV9l5apoDFp6zNENoVkKZFaD01MLNp+jT9vLQjnNaY=;
        b=Egql+PYo4KF9rcKQu7dnJ5yiqb57tosPgIibOf7o8jtOv8PAcfCvY/yNWUayo7cuaX
         syBxvQTX9ydLXqUxZXUw793/UN5wQQjHaABAMqsJ0/OyaZ/apLqebw/4o4q2cgVXynYh
         j5hIb/BwrEW4LA1PQt+BNVB2GIpESdj1U/2UgWoiTk1B3gysEC/sBrR4vk8d5f2v7d8U
         Sjs+PJAZCLLl8aTO5vwSq7wwiuQNwbs83TL4tVkL/rCLR15FYqscA6cdL5wXSVloQpQ2
         7OKPiY+9PdWN8CVis2UdKndUPBWhSBJCi2SsVsIw26SVxeCikKsO5evEoy1TLJRTUJD7
         nydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722781429; x=1723386229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIV9l5apoDFp6zNENoVkKZFaD01MLNp+jT9vLQjnNaY=;
        b=fDvmLHO3s3alTg0oMlFMUgug8ajERSOT1Xl701Ro8iPbByoyYfShtKRrnPSz6WWzjj
         qetgpfsTfecvAvdM69fMfuK1reUGWXElHi5TfxjobKfW/mnRafdrmL1gI/2wyyhFxRJb
         qU3UXLZ6oRtFG2JOYhBArl6aAQs6SDXKHbC/s6VJ9cHPlOiSBHi5QOn0LaA0G4b5O3kn
         W+ydBNjMWFbWmEUZWll8AYjjOlaW0sDX8K/izaGzjRP/urJBomno3tGy1roO2z2Vt1NP
         Hy1qFcTxiSSq1ZsGoBPrGxCqud/QvIHRYFClOQLyp/1DIfLOD2h8QB/qwgulB2gJWXdK
         Fw0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXauAl9gWxpqEUF0u2zTt8BAEAqdxfbDDoKG9EDa0yCUrfnDKqw67zmZJgz+jaWxoL85WGkzsFxdlZ480AkwhhXWlYOB55wzrDITpeP
X-Gm-Message-State: AOJu0Ywd+ns7UQkkHZQQjRuMBLO2MSPBjI6ngZdcjUDunYV4rgu+TtfT
	cCDaXTVTcvu+zCOZl5m+qSwMuOMaXH9ejuQuiE+sioAYgaZBJ0XE59rA3f3f8gYBvg==
X-Google-Smtp-Source: AGHT+IGVArPprnGaLw7XRoCwgJNlyx0zXN5NSuIIJxQ+BD/dgvExuk9FGM4ahOTCGxFwWLB7Ed+N2A==
X-Received: by 2002:a17:902:d4c1:b0:1f7:3a70:9e71 with SMTP id d9443c01a7336-1ff57bae470mr152223105ad.13.1722781428922;
        Sun, 04 Aug 2024 07:23:48 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff59293a90sm49735375ad.235.2024.08.04.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:23:48 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v7 2/2] iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
Date: Sun,  4 Aug 2024 19:53:21 +0530
Message-ID: <20240804142321.54586-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804142321.54586-1-abhashkumarjha123@gmail.com>
References: <20240804142321.54586-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

counts_per_uvi depends on the current value of gain and resolution.
Hence, we cannot use the hardcoded value 96.
The `counts_per_uvi` function gives the count based on the current gain
and resolution (integration time).

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 16e06f2ab..7e58b50f3 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -46,6 +46,8 @@
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
+#define LTR390_FRACTIONAL_PRECISION 100
+
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -125,6 +127,14 @@ static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
 	return 0;
 }
 
+static int ltr390_counts_per_uvi(struct ltr390_data *data)
+{
+	const int orig_gain = 18;
+	const int orig_int_time = 400;
+
+	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -164,8 +174,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_UVINDEX:
-			*val = LTR390_WINDOW_FACTOR;
-			*val2 = LTR390_COUNTS_PER_UVI;
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_LIGHT:
-- 
2.43.0


