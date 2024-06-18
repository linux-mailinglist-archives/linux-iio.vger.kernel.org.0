Return-Path: <linux-iio+bounces-6497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CC90D4E3
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DC528E29B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8B1AC233;
	Tue, 18 Jun 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ohKtDfAW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA81AB906
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719363; cv=none; b=fsR8oC84bMVZ3MJ5pMTy9OoqBY4GDCPgnAglxZ47GjZ2OYkpHpxUhb2+eUs1uQFL+hhji/iHo0GI/p2hz8kqfhNbVTRlAHxbZCXSteayb/sPvcfLE+Zjsh6B1rbZXYq2E6ycieWivzy9y+r/40VHsNzdsbUPUdLw7CIB1FtydCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719363; c=relaxed/simple;
	bh=QmIv781VGnh+ryUYXx1F6xEK9035NP0/VEuO/oa1M9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhAM9DQLl4BrAXI7AKEzp1mHnNkZIXcMNmGUE5qCkB4nAXz1HrUzwkjsjFTw8+7kQ57NlbxxTNTAon6aa4htFmLnzUjA/v5yTfNLUmZXdYdMxnQfoIg1ltkvtLVbLzdf12/W21rwEgoBmQ0bk/YXIxr1fcIP1yxGqC9CAaJ7iyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ohKtDfAW; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c525257feso7085182e87.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719358; x=1719324158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iI4ADRyyzg0pZX/pPb/PmIK3doCtooaUT1uP9pqm4FQ=;
        b=ohKtDfAWXiBKfE+4MAHaz94DbyynxLd/BJICDyyhmBA8gD0M4xYqBXpVmUNHUGeKWw
         DwT+gqU4bqqakAFMpG1vXkgMA3YJP/luCFOrYwC1nzQjSS/UUuXdSf2f6risr73DPEvz
         zOA+0KdRPZ8ubD+fgzRlhuRmB2kSRLeT1W+4xG57WnUkRaFomzQjALT2CNw5o0a5nz5x
         EX5ov+NKAykBjBlq9tD0Ff+xBHuFOxdv3L2QKrydl8003kJyoZUF9SND0hGk/7siknwJ
         tZx+0d97LU9niYpjuMexauD347ecvnZRpSYx3T1GtFuUi/qHuq6G9cBJSrqMgczbrZWM
         82Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719358; x=1719324158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iI4ADRyyzg0pZX/pPb/PmIK3doCtooaUT1uP9pqm4FQ=;
        b=UXE22VBs6fNNO1T6OQJ0DYgMWliDqDlHfx46YVvcJT0LWPKH9Sm81h9S3KgYGhL/MH
         BvcBNmF0d0O9t/V+0QGr5up04O4pC2F8ZKdVvmilnv9sbkrCieZ11rBkkHmMLbQgwLnY
         vpTq1rUM+7kV5lViw22wfeD2RQH4mypxAaKfeOrM/7asAimP/tViLZSwnHZSr55YJxuq
         3o1e7fGkjQdk1mW/OACAjgHRnKiog4MFA3SvU86KY4sPy3lzBq0ZJRPQqf6MsQIgQ50s
         I7T8BLq1HFiSCBY/xtPzCfcb6iJqVK3Fyk5ExjWL6L8GOgEs5kmfSgFyloSQZuAKea6W
         gB9w==
X-Gm-Message-State: AOJu0YznymKltMOAOZl4qIPYQ8PJkhoDMJfqt5RqNt0AyqnNcLzPloLd
	8cp9V2xvqGT6TNxGsXDABhsj8QmtNtzh7zcuNMJPixrsOTBwP7qI1TE11zc65Fk=
X-Google-Smtp-Source: AGHT+IHBu4z952wNs7NhOwlF6llGWnDm5ZPTxh7b2obRWVw6BiFyuLwn+c+TGhzkzw2h3HLjRG9iow==
X-Received: by 2002:ac2:58c8:0:b0:52c:9e25:978d with SMTP id 2adb3069b0e04-52ca6e8fe35mr7316607e87.45.1718719358335;
        Tue, 18 Jun 2024 07:02:38 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:38 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:39 +0000
Subject: [PATCH 7/9] iio: adc: ad7606: switch mutexes to scoped_guard
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-7-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Switching to scoped_guard simplifies the code and avoids to take care to
unlock the mutex in case of premature return.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 71 ++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3a417595294f..e3426287edf6 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -69,19 +69,18 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
-	if (readval) {
-		ret = st->bops->reg_read(st, reg);
-		if (ret < 0)
-			goto err_unlock;
-		*readval = ret;
-		ret = 0;
-	} else {
-		ret = st->bops->reg_write(st, reg, writeval);
+	scoped_guard(mutex, &st->lock) {
+		if (readval) {
+			ret = st->bops->reg_read(st, reg);
+			if (ret < 0)
+				return ret;
+			*readval = ret;
+			return 0;
+		} else {
+			return st->bops->reg_write(st, reg, writeval);
+		}
 	}
-err_unlock:
-	mutex_unlock(&st->lock);
-	return ret;
+	unreachable();
 }
 
 static int ad7606_read_samples(struct ad7606_state *st)
@@ -124,18 +123,18 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 	struct ad7606_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	scoped_guard(mutex, &st->lock) {
+		ret = ad7606_read_samples(st);
+		if (ret)
+			goto error_ret;
 
-	ret = ad7606_read_samples(st);
-	if (ret == 0)
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
 						   iio_get_time_ns(indio_dev));
-
-	iio_trigger_notify_done(indio_dev->trig);
-	/* The rising edge of the CONVST signal starts a new conversion. */
-	gpiod_set_value(st->gpio_convst, 1);
-
-	mutex_unlock(&st->lock);
+error_ret:
+		iio_trigger_notify_done(indio_dev->trig);
+		/* The rising edge of the CONVST signal starts a new conversion. */
+		gpiod_set_value(st->gpio_convst, 1);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -259,17 +258,15 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&st->lock);
-		i = find_closest(val2, st->scale_avail, st->num_scales);
-		if (st->sw_mode_en)
-			ch = chan->address;
-		ret = st->write_scale(indio_dev, ch, i);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
+		scoped_guard(mutex, &st->lock) {
+			i = find_closest(val2, st->scale_avail, st->num_scales);
+			if (st->sw_mode_en)
+				ch = chan->address;
+			ret = st->write_scale(indio_dev, ch, i);
+			if (ret < 0)
+				return ret;
+			st->range[ch] = i;
 		}
-		st->range[ch] = i;
-		mutex_unlock(&st->lock);
 
 		return 0;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -277,14 +274,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
-		mutex_lock(&st->lock);
-		ret = st->write_os(indio_dev, i);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
+		scoped_guard(mutex, &st->lock) {
+			ret = st->write_os(indio_dev, i);
+			if (ret < 0)
+				return ret;
+			st->oversampling = st->oversampling_avail[i];
 		}
-		st->oversampling = st->oversampling_avail[i];
-		mutex_unlock(&st->lock);
 
 		return 0;
 	default:

-- 
2.34.1


