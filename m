Return-Path: <linux-iio+bounces-21241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39746AF5B22
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E688163A01
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4162F531D;
	Wed,  2 Jul 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FFU+0Q3O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE12EACE5
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466478; cv=none; b=nZc4kLxipZrR26i2BFMfJ1kRnEhYStZRBNaHsJOFZHdh2mLMq15TMW2cfWP5L8/36JIBJX2VgqXoLel+JwPDot6RQ3n661nmN0rOigwSXEMOQZCc4/AFRAGMZIA6u3vbXXmx2ksFnRq4MvZKtbeVy/6zD8H649o1E4w1/Ssnqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466478; c=relaxed/simple;
	bh=01R2OLtjIiDGpQmDUeP4wuVqMIm0YMznanbsb2dAoX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ub1Ns+tC1AAI1ypi+uPH3cVg9HzUfuSQ/wY3502LCR6g/WdJxIww6NS7r3MkcyTQJ/E6I11l+TtbBysiExfDPWugt8VmewsDkwdMQp23dfd7guurKXiTrCN6AG/j/XVNQnoJsXKJMRT1HT6OQ6mdayZJXuilAxIxhSVP7WBC5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FFU+0Q3O; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40ba3c10b3bso92424b6e.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751466475; x=1752071275; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sB8dp8LL/3knt9eLNmg4+mqjhhit9Ow5MDWrwFdT9Qg=;
        b=FFU+0Q3OBw4B6Amc3ueerUithXxrJQ/fwYrggU0MZjPeRUaAeVRswPzpBhwrKhKhmC
         aY37rGaPNWtFAyzTvPA4678BpdDvoshqKDSis4zBqndGDz8TVxDqJDEZo4qp16qhI25L
         z7pFvznLriIb7ZfPxUetWi9eS+ja0gy9JT9pKBJwOx8idutMJ9ZM+PXfmAVAp1aHLZtf
         A7zEpwP4EhFXTSFZWjJBFqB5gGodF8uI82wgbhVXmCh8PQN+b2i1qoobCGoQ0DwcGoSA
         v6K9X8lV6Hc8unYrK+2nwO/uHXXmt1C5tUIxBRHEc/zfuI6Ue3bi32wkAIJudQL09oJ/
         B5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751466475; x=1752071275;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sB8dp8LL/3knt9eLNmg4+mqjhhit9Ow5MDWrwFdT9Qg=;
        b=pJXTAOi5dwCLWzTAd8Cu/s+5wg0QuOBPOZrDudXTGC9EpHgV0pQaQ6Ppqgcz87hCMn
         ioZIGN7TfVh9kZIETYcWW3xDL4upLpuPQAUMIlTTO1i4h4mXMGHNe2X2VamVfwbQnr3L
         X6/y8x3vjZY/mxleIv3ksGOLlEVe24Ql0Jm5PuPjPHuSvPsjOm0YqOubMjt50hqFRxhA
         RXtqieRzAFqcWgethDFFPGCF0UK8Vg9aJxamu6/1SEjJ7dpRLZ7VpXOqLtuCpKiRJKcT
         jiJz1acEvKM1dfcw5nzXXZFASU36d7H1d1QBrfL1lhZSNA1im3M7j9guXANhQjvFEeHp
         Hzwg==
X-Gm-Message-State: AOJu0Yxa2KtJiheYJe5gSnAdCghoWnar23+Hhv+uutpHjfVmYWE6KpZV
	nh3dXCX+wfIuQwsC2+xJjy3tqYcrIYeHOhSnPmQ/4ZchZf/iFbu+gET6OrIQETJSpwM=
X-Gm-Gg: ASbGncvghfq0pE6pu8VcEqsGpFRcZEB5yAwSnK1xalC7N6EBn9EFYqUatu0rvhAjVtK
	faT7uVazErcEVOy45aBs9JJqxmGQgW8nwbNrQN+iKPhLtKYYrKgVJ9bkTwgHMz7Wk4uBmJ5ZdkG
	qQZ4zz29xBxUrQvq0fq82g/BLNlyRULVlUFEvdi3Xswrxo5Qnl8qySTjLMybbYAqvT83g96+Raf
	lZ8yFoiIa2OWU/j55dWdyDrxRNeWOYXjkR4lSyBVy2EIcmSROyw5CYZ2YqETU8GE+aW9+zByYqY
	27Dolgri0tEt8JNzCLpQGNGLHiptDRz3kBAHgObr1CUHJ6SDR9maECIuJxpn7g54LdKC2R7EEJf
	55bI=
X-Google-Smtp-Source: AGHT+IF7a/tfS2pIRmAITRw64ldI92ye6wDigYl3F2PvfXXOUZhmxOgZJyC9XOfbzLa7xL9YJfZAKw==
X-Received: by 2002:a05:6808:201e:b0:40b:4208:8602 with SMTP id 5614622812f47-40b8853f92bmr2309678b6e.4.1751466474555;
        Wed, 02 Jul 2025 07:27:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b32406a64sm2544016b6e.27.2025.07.02.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:27:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 02 Jul 2025 09:27:45 -0500
Subject: [PATCH] iio: imu: adis16550: rework clock range test
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOBBZWgC/x2NQQrCQAwAv1JyNpBd2Vj8ingou1FDtStJq0Lp3
 116nMPMrOBiKg7nbgWTj7rWqUE4dJAfw3QX1NIYIsVEJ4qoWlFfCw5FPXBKhCbfaiPmZ80j2u7
 M4jPysQ8sTKnnAq33Nrnpb39drtv2B25XJHJ7AAAA
X-Change-ID: 20250702-iio-imu-adis16550-rework-clock-range-test-63816e60586d
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Robert Budai <robert.budai@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2106; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=01R2OLtjIiDGpQmDUeP4wuVqMIm0YMznanbsb2dAoX4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZUHiObQrIb8ZxMtFlqtUCpRQkLP6UBIRVXZ/8
 fn5mX0DneeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGVB4gAKCRDCzCAB/wGP
 wFj6B/9DkSqVjEpibp8Uk+zgXLKItCusxDXINgyuV93n/2OouYKbZxiqQm8oFAGGbYII4KdUWkq
 /UhcbH4MTbh6+PtK342/WuVX/OJvujLXI51NYw8uWmVsgVn9IsnPvrEjCmffUJae6Lpa4f1Dvqa
 rMRoGE2Ks7axA2zT84nZNOhGo8J1jzo70Yj0KPpfSpshHJDxId0ZzkA8kHo1A0lyUHFXqbZsx6i
 MsMEHn3CySL/Q0VQ01uVncwt68cAfuy+cuBJaUz/b7ICK/bzkk0XA+ocokkDnZxqJCEv/H1QUKZ
 j6gKkvnNJm6fxOzKPeMcoLwkKwaB7bQhm2qvGQ7XoaMAf1aM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Rework the clock rate range test to test if sync_mode_data != NULL
instead of testing if the for loop index variable. This makes it easier
for static analyzers to see that we aren't using an uninitialized
sync_mode_data [1].

Link: https://github.com/analogdevicesinc/linux/pull/2831/files#diff-e60c8024905ba921f6aac624cae67d6f9bd54aa5af5a27ae60a8ca21ef120ddaR950 [1]
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Here is the for loop that comes just before the if statement in the
patch so reviewers don't have to look it up:

	for (i = 0; i < st->info->num_sync; i++) {
		if (st->clk_freq_hz >= st->info->sync_mode[i].min_rate &&
		    st->clk_freq_hz <= st->info->sync_mode[i].max_rate) {
			sync_mode_data = &st->info->sync_mode[i];
			break;
		}
	}

Previously, we were using the index variable `i` to check if we hit
the break or not, but checking if sync_mode_data was assigned is a bit
more straight-forward for machines (and probably some humans too).
---
 drivers/iio/imu/adis16550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 28f0dbd0226cbea67bc6c87d892f7812f21e9304..d733daaa05bcf0b0cfd710330230c671e66feef4 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -909,7 +909,7 @@ static int adis16550_reset(struct adis *adis)
 static int adis16550_config_sync(struct adis16550 *st)
 {
 	struct device *dev = &st->adis.spi->dev;
-	const struct adis16550_sync *sync_mode_data;
+	const struct adis16550_sync *sync_mode_data = NULL;
 	struct clk *clk;
 	int ret, i;
 	u16 mode;
@@ -932,7 +932,7 @@ static int adis16550_config_sync(struct adis16550 *st)
 		}
 	}
 
-	if (i == st->info->num_sync)
+	if (!sync_mode_data)
 		return dev_err_probe(dev, -EINVAL, "Clk rate: %lu not in a valid range",
 				     st->clk_freq_hz);
 

---
base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
change-id: 20250702-iio-imu-adis16550-rework-clock-range-test-63816e60586d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


