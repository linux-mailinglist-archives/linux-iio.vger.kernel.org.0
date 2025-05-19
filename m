Return-Path: <linux-iio+bounces-19687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431BFABC0A8
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4063A7525
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE9286424;
	Mon, 19 May 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jujBh54R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F47286418;
	Mon, 19 May 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664794; cv=none; b=kOJ8Uiw526U5zdlzqwoZX2mtvzPfwVKBdyxNe6cROAMHRHyLRN2zEVF5elHLcC4ueWQY4pe1Yv33VZCbbUUfZghqtWEZcbwKkKG0WnaJWRF1ZKBC4nkej6Rl9wGawq7M/kGpMPd21GTpBS9KYrSdmNcR49JyRBp+SrhKch+vBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664794; c=relaxed/simple;
	bh=pCvjBnapJdnH08Ke1HT2Sckpf25UsBH+CROSCGXOrZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SC9Sgg2NmGhJ06xwM+E/iEIhAUwbt7VAvcI3Ox86f5no4fPgWPWODd5ZG/64NqqvXqak9zK3cWqHmoI2EbGFJE9LE0tF9I0zqORIqlDfqas0xddqMDSzryRUnp12lRUcMhvGhdgoAddCIUZ7OXvPD2bwP8wnqNLuEF3zspOs3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jujBh54R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7398d65476eso3546809b3a.1;
        Mon, 19 May 2025 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664793; x=1748269593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osCr06hsylKTSAoTgivd6MavyP7+iemMoVgSaaYvao4=;
        b=jujBh54RL4ZcZ2sugVNuwMrALvP7snV15eaCe6xaWPOyTSM4NrgXUSafeMRNb01glm
         4tgDLm4VxYxdy0qKkUMKDxbINm4nATzzKZWsZ081C/sBXrJmvValrEDX0liHbTRnrLBK
         PbGx9hOCGxzyCn8sBEiZIplYHjpJbLOrmlTIgiUF1F0kckAdS+jL6sKQ13NCZeP4/zAy
         9atI690/6VkVgsWokG1VKrUZAEPLJOURnIl/eqJ6UET1FRXQgXmMvDSH5jKaTs+r+RUD
         KT3iB1FFbVrlEKxcC3ImTyZlzv1JfFli+bdOpSWTNGoyJ+VLQlHiBuyeGFiPuF76NUvL
         ycJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664793; x=1748269593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osCr06hsylKTSAoTgivd6MavyP7+iemMoVgSaaYvao4=;
        b=QJOe7WcS8C0TZ9AnXuFro68UwdghZlat+t0dsviHg5PzegrtkcK+L6aQihXfAPadm3
         3nb44fQn/aGll5uEfpO1r74I5sAkjg0LONXqRUhKkVE8ZXbbOMK4WfdjtWVDydb1S3ks
         WCxtfEFtt+FJtbob7ofzd9xWdaP/WZi4VmxIcmpoHrTweXBgQGfnbTfzbQhyvXPNPx9y
         iKkIcmn/HGN3mwaWzdGDvFXlNbaymiX2ksVtfdi1wXsYObE7nJgxM8xqUsnjDxq31sz8
         xBJp/XucvXUMtoXflmZMAOHO6EiBbdKeVkENAFdAonkyBvQb4fAThBQrecfjnj2QnKW9
         c7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUHWkcQmqHMOFj9Nw6aF+Dkp7rFOgYfM5LJAHxuc0r6dYx2pGE9wgg44ms6lgf5ykW1zbJGHrkhU1l4OXwu@vger.kernel.org, AJvYcCVWlNtJW0ZmeWX9JUZNXodZYI9zxdnzUIYe8GhxnwIZZHNfXt4X+PvfXQcWJSn3ESdobaW9K+e4FSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbcYFu6OT/lPUM6S3A7yuJxr6tXHoGnlVClk5jMRWyFUefCjB5
	VDP+cQ8sZWf8O1zQIQAiBRfoleV0jlloGmDMNlcLjB2F5jDwSSUl/ahu
X-Gm-Gg: ASbGncsjJPVRHykhf+Ou6wFs50FdxI9wrS920gBBEjrwycVJir7jSK9uVlNGZfcXKo0
	JpIQ2tysV/xndGYD/jFkpAiu4XxuN+67Nu8iak06ejxZHHu1dpZ5TKwabm2+1wfdoLyMqQ5/pOS
	gVWwWwFndiyFMjREZGksYQwynbgwyoLQDUCjBuFH9ht48xsmfdC3NFBtEfOAVbJdU7TTJkc489A
	rP7KTOLI9lnKp2s9nFD0khoGjxlunxUFt5LIHVIcjGnMdFFtfAO4cNmtAH0IEwR0Rl4dcHUiGDc
	3exc9clYJZN6ZPCNT7ABhqHzNUHhBKYIhrUFHRBidZ8i4Zx0zuLCv17+7w==
X-Google-Smtp-Source: AGHT+IHlXJapKmWK6jXxCG4EqBwdhv/qvDATVlO2zy3Pd0SLOoU/tuza0cAVvKrefiK7lMbInBl8/A==
X-Received: by 2002:a05:6a00:3d01:b0:740:58d3:71a8 with SMTP id d2e1a72fcca58-742a99fabb8mr16216198b3a.1.1747664792613;
        Mon, 19 May 2025 07:26:32 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:32 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 9/9] iio: rpr0521: Use new timestamp-related APIs
Date: Mon, 19 May 2025 23:26:01 +0900
Message-ID: <20250519-timestamp-v1-9-fcb4f6c2721c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This patch is an example that helps explain the previous series.
Now there is no need to handle timestamps differently depending on whether
the consumer is attached to its own trigger or to another trigger.
And the own trigger of rpr0521 can simply pass a timestamp to consumer,
using `iio_trigger_store_time()`

Not tested since I don't have the corresponding device.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/light/rpr0521.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 92e7552f3e39..32981db18428 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -186,7 +186,6 @@ struct rpr0521_data {
 	bool pxs_dev_en;
 
 	struct iio_trigger *drdy_trigger0;
-	s64 irq_timestamp;
 
 	/* optimize runtime pm ops - enable/disable device only if needed */
 	bool als_ps_need_en;
@@ -416,7 +415,7 @@ static irqreturn_t rpr0521_drdy_irq_handler(int irq, void *private)
 	struct iio_dev *indio_dev = private;
 	struct rpr0521_data *data = iio_priv(indio_dev);
 
-	data->irq_timestamp = iio_get_time_ns(indio_dev);
+	iio_trigger_store_time(data->drdy_trigger0);
 	/*
 	 * We need to wake the thread to read the interrupt reg. It
 	 * is not possible to do that here because regmap_read takes a
@@ -446,15 +445,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 	struct rpr0521_data *data = iio_priv(indio_dev);
 	int err;
 
-	/* Use irq timestamp when reasonable. */
-	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
-		pf->timestamp = data->irq_timestamp;
-		data->irq_timestamp = 0;
-	}
-	/* Other chained trigger polls get timestamp only here. */
-	if (!pf->timestamp)
-		pf->timestamp = iio_get_time_ns(indio_dev);
-
 	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
 		data->scan.channels,
 		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */
@@ -464,7 +454,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 	else
 		dev_err(&data->client->dev,
 			"Trigger consumer can't read from sensor.\n");
-	pf->timestamp = 0;
 
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -867,8 +856,6 @@ static int rpr0521_init(struct rpr0521_data *data)
 		return ret;
 #endif
 
-	data->irq_timestamp = 0;
-
 	return 0;
 }
 
@@ -984,6 +971,9 @@ static int rpr0521_probe(struct i2c_client *client)
 			goto err_pm_disable;
 		}
 		data->drdy_trigger0->ops = &rpr0521_trigger_ops;
+		data->drdy_trigger0->early_timestamp = true;
+		data->drdy_trigger0->trig_type = IIO_TRIG_TYPE_POLL_NESTED;
+
 		indio_dev->available_scan_masks = rpr0521_available_scan_masks;
 		iio_trigger_set_drvdata(data->drdy_trigger0, indio_dev);
 
@@ -1011,10 +1001,10 @@ static int rpr0521_probe(struct i2c_client *client)
 		 */
 
 		/* Trigger consumer setup */
-		ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
+		ret = devm_iio_triggered_buffer_setup_new(indio_dev->dev.parent,
 			indio_dev,
-			iio_pollfunc_store_time,
 			rpr0521_trigger_consumer_handler,
+			true,
 			&rpr0521_buffer_setup_ops);
 		if (ret < 0) {
 			dev_err(&client->dev, "iio triggered buffer setup failed\n");

-- 
2.43.0

