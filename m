Return-Path: <linux-iio+bounces-12740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8169DAA46
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E187F167634
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C661046447;
	Wed, 27 Nov 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yDXZ6Wb2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517E2110E
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719618; cv=none; b=lRy0PajDdw91dkE6QyN5AjskbDcANV6TMbdx0qJVco6gk3ILH1DUuc6s5/pEnzbmY/3rIb7umXM0fcunrVoAgCWoFn3WEHhrNoRIGTaxBdRTi0PnfONKvpLOIxxhZ2roTaOqgmuGIcTM9XNPV/Eqgd0rhI5WU1uGTRsNkQo+7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719618; c=relaxed/simple;
	bh=/UtxUNcu7FlfgGbbbYqeI92ekworOfOuWxMulK9vmm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+UT11o1PdNcMWqOhxCN4knUU7zVHbzUERaRhDrq8K8HbatO3KK16Xf8ZuTNpwvbL4FUMnX5M7Ovo/Y+YHGWCiJtCpCegI+r+Rs3GSmFuQp56YgHdpWrkbCtTsaEDjo2rQLdAaxNmOiEY7brwZZqqVO5Znqj9LXoQY0HL6tPWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yDXZ6Wb2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so5548325e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719615; x=1733324415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aig5K0sssQgvPkFPKhN2zssbw+/Mz4FBnMCldVaVbqU=;
        b=yDXZ6Wb2AvXPXWqsNaJZIc8lRxCLPPPksKjKCf/6Cu4RD8lSItjW03Y9WKeVXaGoO0
         lQ5xBCvgmvT50vxrP0n8kvbMWKhN35xERZQHMekYIUuLnZKuIUVuHYW6hC9X2GgzRjS4
         xAvSJ0hTCNknmHf8YyIKMyr6TvhduJVJtXIr2pA3ISy5jOHn8fBi06bhYyM7+07Mrq5n
         M9q+Jj1iYiHCPIQ+6v1Skq5ilXMxMAArcRMOBJ+giyPfMevxzgvaUOk0jKmbmC0urVJh
         XMH31PWMU3e7VAvK0MtdvT5zKfCsEPY5s294BiG3eaBhd95RDIRo8bJzdr25w+PbMXFB
         Mh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719615; x=1733324415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aig5K0sssQgvPkFPKhN2zssbw+/Mz4FBnMCldVaVbqU=;
        b=Nr4O2GKyN7pdtxHuQZARcnWL78kfSjrpsJ8/11Jb+k1Z7df2tWtQI28EBoG28MATck
         yrJmP+GLmMbpnihurN6GCWlcNgMym3ypQvHnyaAoIrnR8wzcILe6zV5CcaLg6zawoJES
         y1bKnU4RBfp6QyRb9yKcaXRNmJuofE0IUobOZo4zMZ8bH8LpZA461ysU/BEYVnMJ/UYw
         SZ1lY5eryMdCisT4/DBygr+ZbNzLQIANEEAKBBG825QEjndanbVk389PGAYjBa1PYwiN
         EXraCea/pmuzsGo+9WRf3YTQUkXceiiWHSN66n2QMTBlAjS1QWOHOr0I3lnYrGynXGz4
         s6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWQCtja13+WIk0YYtMTecmLGbvlldgVMuS+9P18EvBJDt7Cc2FTFW5bBsO8hM/dqnOwhbhP7IiXoXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDP0GjuxSnA4O8hR8efmI/NdULXEBqr4yXZ3xu1I3/o9zCfLjD
	PoxiVP9JsNafniEFGLY47Me9iLtDE9cRgg44UTFBZ095R3kd+A8Ud313gFG0RG8=
X-Gm-Gg: ASbGncv9Eww4w5mz/qftzTz3GTHmyn/ECO+IQ5Bknj+L7CnHgZVtTNN7cQ7tIGnw7j5
	fFSrIt2fiwHFqcxfXRIXcZ2Fr58npyG30OUydWr5TQQdCDydR86SEliOR6KHgLkZDERgYdjw5ls
	5SbRl22PUjURsXJJ+CzfrFBT2sAbf5NW6vfDwykxxM7uG9/glQaJb09tqU0yUqsnCiviOWjFEwo
	u7n6ABomnEfsCmy+CdStZqX3IPqRMBbA5OzPqq+emtzw0Iqu93RvBPT4hPV6EnDEUzmbjieLBEE
	iU7M
X-Google-Smtp-Source: AGHT+IHVcyXgbDQ3wUIT3KKZlTmiXMDUie/dJYYTuxVbAakk4X+OJkfWnAIjanW3q4aIcou11G4e2g==
X-Received: by 2002:a7b:c85a:0:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-434a4eb786dmr64613835e9.16.1732719614880;
        Wed, 27 Nov 2024 07:00:14 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4df1sm23289425e9.39.2024.11.27.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:14 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v4 06/10] iio: adc: ad_sigma_delta: Fix a race condition
Date: Wed, 27 Nov 2024 15:59:35 +0100
Message-ID: <20241127145929.679408-18-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5630; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=/UtxUNcu7FlfgGbbbYqeI92ekworOfOuWxMulK9vmm4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPhZ1jctnT359wUzbJNDXuiikKyGWIfPGgx0 Z+4vPzq9DCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz4QAKCRCPgPtYfRL+ Tlc0CACSa3E0ocQsqmH0c2ExJYQfJWBXyAjIKxvyC3tGUO5zz0RBmJkE+tZtbQMhnfxKVnoPh// 4nMdVkUiQjyV2lEgi4fBOuWt9xS2r6j/IYj4Ay0jdzuWSSEx/oLm/64HQSOYBL16MZhmBKPOBhB VZ6gdwgJKIz+2bhAv78aiFw6zdE6Ie8FpSlESYYptEu4gNJcDSuWPyex/uH3SqPK9Khmf/ZPkjU dxHeeYickCTap4j80mQ08AF4o73PLBPjbmsE7gdhnOv0caa15drAJa7Zs2wgZ+cJyungP5Lm3+U /gVanmnqYcuYxwLZHytZtksxuvMN5tfrPuQxK5iiYD63n8j3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad_sigma_delta driver helper uses irq_disable_nosync(). With that
one it is possible that the irq handler still runs after the
irq_disable_nosync() function call returns. Also to properly synchronize
irq disabling in the different threads proper locking is needed and
because it's unclear if the irq handler's irq_disable_nosync() call
comes first or the one in the enabler's error path, all code locations
that disable the irq must check for .irq_dis first to ensure there is
exactly one disable call per enable call.

So add a spinlock to the struct ad_sigma_delta and use it to synchronize
irq enabling and disabling. Also only act in the irq handler if the irq
is still enabled.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 56 ++++++++++++++++----------
 include/linux/iio/adc/ad_sigma_delta.h |  1 +
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index a2efd2145373..9abde276cd17 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -202,6 +202,27 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
 
+static bool ad_sd_disable_irq(struct ad_sigma_delta *sigma_delta)
+{
+	guard(spinlock_irqsave)(&sigma_delta->irq_lock);
+
+	/* It's already off, return false to indicate nothing was changed */
+	if (sigma_delta->irq_dis)
+		return false;
+
+	sigma_delta->irq_dis = true;
+	disable_irq_nosync(sigma_delta->irq_line);
+	return true;
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
@@ -551,11 +561,13 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
 	 * So read the MOSI line as GPIO (if available) and only trigger the irq
 	 * if the line is active. Without such a GPIO assume this is a valid
 	 * interrupt.
+	 *
+	 * Also as disable_irq_nosync() is used to disable the irq, only act if
+	 * the irq wasn't disabled before.
 	 */
-	if (!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) {
+	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
+	    ad_sd_disable_irq(sigma_delta)) {
 		complete(&sigma_delta->completion);
-		disable_irq_nosync(irq);
-		sigma_delta->irq_dis = true;
 		iio_trigger_poll(sigma_delta->trig);
 
 		return IRQ_HANDLED;
@@ -691,6 +703,8 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 		}
 	}
 
+	spin_lock_init(&sigma_delta->irq_lock);
+
 	if (info->irq_line)
 		sigma_delta->irq_line = info->irq_line;
 	else
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 126b187d70e9..f86eca6126b4 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -86,6 +86,7 @@ struct ad_sigma_delta {
 
 /* private: */
 	struct completion	completion;
+	spinlock_t		irq_lock; /* protects .irq_dis and irq en/disable state */
 	bool			irq_dis;
 
 	bool			bus_locked;
-- 
2.45.2


