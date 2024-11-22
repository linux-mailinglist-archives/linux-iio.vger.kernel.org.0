Return-Path: <linux-iio+bounces-12487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D709D5E30
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F46280E99
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD21DEFC6;
	Fri, 22 Nov 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G/TUwdHw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7B1DED78
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275249; cv=none; b=jkBD2G6kCAqfSw4v/QcxAvqDHfBJqxYyM/7z1WfRWlSTJ/Xnp5ZVE/QMZiy8ihO83ZjTu4z4dCyK2Pe8I8vI5ZbhbKPu/vNxohirqZuoMw7Ky4J/qKi6p2PKsi0Kqha+2zISD8PXx5Og6Ed2l+Va+TiPL6Lskc8zSQmVi+lsa2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275249; c=relaxed/simple;
	bh=48hHZ3ITVE+qUGX+Ga935RVOjvTMw3NoTRENrWrh6/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZQ1we6ppWj33F+lN30FRCN57/5Z6CbzgxdERlfLgbvPhN1SUpIEcNRTUx18xDrmdDvOrhn8SGbWVOSSMsyhBGSWlr8d5p4IH6aQUNn4m5qNy2T8o5L4V4TBLFckBlpNXIKrXMAySJY0ZH3puBU2sN23GooyNCbKgZFshXclcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G/TUwdHw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382296631f1so1429446f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275245; x=1732880045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw+XKMtL3Q3Cd70Vw4Qo2UJMMMB6RtRXXTsPhQJMeRM=;
        b=G/TUwdHwOfytLsygv0L+WmSCQUllhZNcDQlPWtqYq1dOKZ2mF6XjK+nCldqedskg8v
         12RAQcyS2ulC14xh21KwK4tn8YxvchZK617NwT5vpYC1pL2www1OXSLXRZ9aWNbydqfY
         ehw/Lf7py7/e9wGFpHpvZUvS+vyL3BjMrIxPkF1Pda4BE0OGypgP4a8Qjep2FQgwMkKT
         7IXCy8xwnTJzrTBKoCN2qCeNaw7Oy0R5vO3ZABAb4LjLKS3O2yp7Gd7JLgmRd0h1MlKr
         FW7tX4xIibZeYZfROTEhR8J2hffE1ffj2O2qq/KPv3eCA/ikBzXOeNLwfdzmDWxByid7
         mjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275245; x=1732880045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw+XKMtL3Q3Cd70Vw4Qo2UJMMMB6RtRXXTsPhQJMeRM=;
        b=nm5UxT7npXkVVmc6PU4C4azVrkxgPAQjia7fxt2+9V4WDjX3jqPPWZzfLfWxILx/FT
         ZPVCgHHKBIUCi2sFAvOHSu1g0vTf1Z/N5vf1/3wkCs2qB4afglAmkM8bg1wPxOUw3lng
         IRixK7SV9IZTV233QfhcdP+zbltC9KMcfjLiOYwA8iKzuZ6tamWwKCk88mfBr9sUnSUe
         qkugjAouqYhqrXL3uUyg9EghPvW6JdvuvhiEWjd61G1rsVc8lKojfDLmn5lvSetyopP7
         OiUTPhVSXXpEIsJXKf+GiRQiM6J/0tmROY2lk0D/Il+7F0iYJ3F8MUOIGguCY9oEzts7
         Uj7g==
X-Forwarded-Encrypted: i=1; AJvYcCXtRVnuRyP6TQjlCYkmb6/6ipnaW4eCzOg0OXomGORUmq7ED3euvbcK7Ovyt9zqh0pMxbofBUvUGXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweP34K8Hbd/aUlHdl33SuJW+POGc1B/kmofLuqGa1C6AydDLw3
	HFT6rknZ9bcRmEHwu63qt39Ps+kPvX62g5YX5jgo2vN6a7XcZi3ukw1NJ/xsXxw=
X-Gm-Gg: ASbGncuPGoKH50QY0tQrUK1v1+oe1oB9kOTSGfXTh76kcLpcZr185YCWUXyeHXmrZIw
	wfV6jPgEvjxGi9gPyF+aF/qSxaoLBWZrVHCvcImcSP2jLN7HMt7gMozjhPEUKH3Hofh8urBnQLY
	veDIXwa6EjCig+N5QKCaViMvKdVR8dA5IhIFEXkRY92RmVLrfeqiwZZcxfPtwCUszXUqh5iietG
	xD+p1xAaZT9/Lhy/fdvv89PEeWsEV6D3hmBSQ9wo8ot3jQH155ETQDVv4unfFl77NTBuUeODo+/
	D4c=
X-Google-Smtp-Source: AGHT+IFa4d7Kbh/5GfubDYzrQkWpLUJKSOSweVzhkWVHQyh1xt9MLBYXIM9DmTByv375NNT1uu/ceQ==
X-Received: by 2002:a5d:64ce:0:b0:382:40ef:431c with SMTP id ffacd0b85a97d-38260bcb023mr1826615f8f.37.1732275245552;
        Fri, 22 Nov 2024 03:34:05 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe91a6sm2178755f8f.86.2024.11.22.03.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:34:05 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 06/10] iio: adc: ad_sigma_delta: Fix a race condition
Date: Fri, 22 Nov 2024 12:33:25 +0100
Message-ID: <20241122113322.242875-18-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5522; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=48hHZ3ITVE+qUGX+Ga935RVOjvTMw3NoTRENrWrh6/E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwRaiSQuzz2pfzW8/2nunBfhnszmeW9rcEvK 9W5iiWoWH+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsEQAKCRCPgPtYfRL+ ToC6B/9LAt0lzH4PQkywNBOU+eav3Ic0JjMmL3dstfjgSzfQtG98c/RFzPSuc301O1uNi298Tpd xMKFNPmsKegqLQPWpGHL/VZdlQhW9pQcnOS+lZhrKn5/g07Am5AU3pGkk65eMNM0gt6HlaQOQVO AHJlY/2LOVv4kWQbiRwbcDx5a8AMRgHcMS0ct1DbE4VszFCFbum/Kgo1E7iX6TxlScqNknC9U+C Zk5w1MG8Uu1FE2f8rPCMLPJMDN8k6n5KCNVPUMUz09VLxGTX7FT7hIUTsCd7KuOpQRob0djLbuZ HuXUDbw6ZOHluWrUzxzAO5+E+PfmqCGQvXrCmllUr2a1FT8C
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad_sigma_delta driver helper uses irq_disable_nosync(). With that
one it is possible that the irq handler still runs after the
irq_disable_nosync() function call returns. Also to properly synchronize
irq disabling in the different threads proper locking is needed and
because it's unclear if the irq handler's irq_disable_nosync() call
comes first or the one in the enabler's error path, all code locations
that disable the irq must check for .irq_dis first to ensure there is
exactly one disable per enable.

So add a spinlock to the struct ad_sigma_delta and use it to synchronize
irq enabling and disabling. Also only act in the irq handler if the irq
is still enabled.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 57 ++++++++++++++++----------
 include/linux/iio/adc/ad_sigma_delta.h |  1 +
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 5e7e5cb908d8..fd3560beb56b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -202,6 +202,27 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
 
+static bool ad_sd_disable_irq(struct ad_sigma_delta *sigma_delta)
+{
+	guard(spinlock_irqsave)(&sigma_delta->irq_lock);
+
+	if (!sigma_delta->irq_dis) {
+		sigma_delta->irq_dis = true;
+		disable_irq_nosync(sigma_delta->irq_line);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static void ad_sd_enable_irq(struct ad_sigma_delta *sigma_delta)
+{
+	guard(spinlock_irqsave)(&sigma_delta->irq_lock);
+
+	sigma_delta->irq_dis = false;
+	enable_irq(sigma_delta->irq_line);
+}
+
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
@@ -221,12 +242,10 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	if (ret < 0)
 		goto out;
 
-	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->irq_line);
+	ad_sd_enable_irq(sigma_delta);
 	time_left = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
 	if (time_left == 0) {
-		sigma_delta->irq_dis = true;
-		disable_irq_nosync(sigma_delta->irq_line);
+		ad_sd_disable_irq(sigma_delta);
 		ret = -EIO;
 	} else {
 		ret = 0;
@@ -294,8 +313,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
 
-	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->irq_line);
+	ad_sd_enable_irq(sigma_delta);
 	ret = wait_for_completion_interruptible_timeout(
 			&sigma_delta->completion, HZ);
 
@@ -314,10 +332,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		&raw_sample);
 
 out:
-	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->irq_line);
-		sigma_delta->irq_dis = true;
-	}
+	ad_sd_disable_irq(sigma_delta);
 
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
@@ -396,8 +411,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_unlock;
 
-	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->irq_line);
+	ad_sd_enable_irq(sigma_delta);
 
 	return 0;
 
@@ -414,10 +428,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 	reinit_completion(&sigma_delta->completion);
 	wait_for_completion_timeout(&sigma_delta->completion, HZ);
 
-	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->irq_line);
-		sigma_delta->irq_dis = true;
-	}
+	ad_sd_disable_irq(sigma_delta);
 
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
@@ -516,8 +527,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 irq_handled:
 	iio_trigger_notify_done(indio_dev->trig);
-	sigma_delta->irq_dis = false;
-	enable_irq(sigma_delta->irq_line);
+	ad_sd_enable_irq(sigma_delta);
 
 	return IRQ_HANDLED;
 }
@@ -550,12 +560,13 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 	 *
 	 * So read the MOSI line as GPIO (if available) and only trigger the irq
 	 * if the line is active.
+	 *
+	 * Also as only disable_irq_nosync() is used to disable the irq, only
+	 * act if the irq wasn't disabled before.
 	 */
-
-	if (!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) {
+	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
+	    ad_sd_disable_irq(sigma_delta)) {
 		complete(&sigma_delta->completion);
-		disable_irq_nosync(irq);
-		sigma_delta->irq_dis = true;
 		iio_trigger_poll(sigma_delta->trig);
 
 		return IRQ_HANDLED;
@@ -691,6 +702,8 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 		}
 	}
 
+	spin_lock_init(&sigma_delta->irq_lock);
+
 	if (info->irq_line)
 		sigma_delta->irq_line = info->irq_line;
 	else
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 866b4c21794b..b3e4d89f2d06 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -85,6 +85,7 @@ struct ad_sigma_delta {
 
 /* private: */
 	struct completion	completion;
+	spinlock_t		irq_lock; /* protects .irq_dis and irq en/disable state */
 	bool			irq_dis;
 
 	bool			bus_locked;
-- 
2.45.2


