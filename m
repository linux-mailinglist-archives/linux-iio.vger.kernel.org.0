Return-Path: <linux-iio+bounces-15742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB4A3A5A1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215B8188AD42
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D817A2F1;
	Tue, 18 Feb 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AjEt7VtY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82F2356AD
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903495; cv=none; b=BL3BDJt/vN9rf/MI0mZipJX+xusMF3AsSTZorKo6dP8Sa8jUqUUs5Dx4PvvUO0nkOoYpXvMZqutcRj+tYqGi2SX49kAGnTzTUfZDtLzkF6lv5bhKExbdJNDJWqNQqAfvzVx8dp5GbQVWmpahwLzSy/aNSlrJMgFNtHEFtcCE4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903495; c=relaxed/simple;
	bh=SRKMapFlVg3+8kF9cvHubzekV8X8++YISp0c0O7y6Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5Kfl+DimFSHyiZFb9UJhVq7sPzJ5/nehKI5qTs24zsehvAcSfIyNorJucsS6ueRmw6pJkbfeuX6C3sISv9/DJO3ShRVWgrvRfj15tHCXcV1gwPBr2bQJSzPQUCTCwm6poV7B0hMzGxRTlFCHQuf1tkDMiybJbHcKiQCk1D5pZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AjEt7VtY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4396f579634so21385935e9.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739903491; x=1740508291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E0VFJeeN3DbM9e1x+ou8SemoqItJRlOI3ariJtd6jU=;
        b=AjEt7VtYjUrL5IQ5cikTwSomixCebf7YmYqCi9P5n4c4aH0RbRuk+LpI2FKSbCZGVl
         Yk95YGdVX96/78WVFFYGz/v7UM6aWp95eaW3097zw0nLFYhfG5HNdQFbv4TT2WBtp719
         14WEQ0macy/WlrNwXyVH+M5JzFsGUpnZLcmGrHVp4XGa9z8peCigdyzeoVlZDUR6qWk0
         kzzKM3G8ogHqxRmO16USpSIYEYkrejapjTeUxAvj4SEDhRtx1YG2JodG+vM9QMPvYQZ1
         EozzXjX8nAGAIP8PoB5xUVZP/mca9sMPyiTQaDcankiX2VXJzGKjCE457CRVfUGmqB2z
         WmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903491; x=1740508291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E0VFJeeN3DbM9e1x+ou8SemoqItJRlOI3ariJtd6jU=;
        b=u2XhFZ2qDOoOZWGNr1GtEhxc2/QYyJlTz5QgsqHbDm7LVCrP++Rv5Ai62uM4cfOTV5
         cM0/qvIOSkDEgSqzunvjkOlyNGOZz35YrzUxBlcEQAiO/VB+1kRrDxUhn3Zs3jb8bEAw
         maFvnVgkcaN9UnrxxCptWJJ/lTI0KwWJIcRcDTObXP+G7peHzzBs7KgghbXnAHhAMaov
         OS7YfaCa3Dv1zueWX92v+mz3F3XHZfgg04m03SmwByMALMlhgAf7dSWB8AsbDuUwixoW
         +17EVdWS35dZWxNKV+kwDXQJLWxLXG20QIT6X+U7omuM5lIDtqHOJ/O7o5/IIkzCe9US
         8+3w==
X-Gm-Message-State: AOJu0YxhmOP3NnMQUrwT2SKFBEWjfk8vKnmrfq6H72imihANkkDx0MLw
	/jR4B5jILy50QTfQEuVHUEjZRXyU53yp8XaF1l1Y1zQtSZYl9bBOPcal29HYvU4=
X-Gm-Gg: ASbGncsBAYW9Sn9cw3ZBOT4mQwKHholwaqbvuyOmuMpri87TzXI/Lx57oSDMxnpt2Dv
	t+vQCPNNmF9ExRowprP15fOcN58LL1X40gU4/HZNXRqLUwe1AWm78e9PvzKYIMw7pRsfKjw1/pL
	VHVCREmWkKy8JL0kWG8EJ3nMyw86zz2aNEZ9iLG38SrCoRNLJlLI8xMuxRDZRYAOiurez9d5c7N
	dyAasDg25LQD2vM3A1S7H9vndNFpVQdkL6aUR7GssdZgGoWHuXASl1fW9fUi2FGrZVHvOw1wM3C
	wE8mDFIBVsmnV383Cs9lIc1tEYCj0wgYWTjziw/+nx40/Nemy+KhCGMUVw==
X-Google-Smtp-Source: AGHT+IHCuDRR6HhA5MTkRoYnLqzzbZ29/mVApolah24GF8ilv7v5m/UN5TeqqKbKFhbszIKiA9J5ng==
X-Received: by 2002:a05:600c:46cf:b0:439:88bb:d006 with SMTP id 5b1f17b1804b1-43999d77085mr7571885e9.6.1739903491310;
        Tue, 18 Feb 2025 10:31:31 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8443sm190404005e9.35.2025.02.18.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:31:30 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Guillaume Ranquet <granquet@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 1/6] iio: adc: ad_sigma_delta: Disable channel after calibration
Date: Tue, 18 Feb 2025 19:31:08 +0100
Message-ID:  <80c50d73f50c49b3824ba67189a23cd28136360d.1739902968.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SRKMapFlVg3+8kF9cvHubzekV8X8++YISp0c0O7y6Ac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBntNHufujNQ9FyW8URgJCo1s3b3xwvnYx6qm7Im YvQaSM106mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7TR7gAKCRCPgPtYfRL+ TkJEB/0SHGNhuZO6PdhwOwkWfXhJDO4ztFW57SW3PMOhwlbZrhUSl2DxQr3oK4iTtF7F+ZWKu01 XGCgivTjL1rL0II6kig8DECClo/ulGBXPGmGb/aT6BYNTjy3kLh0ANEWXZQDyTmXa8Zrqww1lGT bJvALezVwtmaGhNyNCdzxgIfeymSDYNXlVv9gD79inVAml1GuG/fbEN2hXq/Qi0NBx2NQHsDzUu tOT1PSdTZbRtg1MEIwhB9V+BcZL8iiKUHEK0I/jHL4CH7B/IroaDJy37kX9aUseCGmivZ8hscmk azxOX32i3zzWCzz/qx2kvq86Ii6R/uqc2e9gZZb/t2RFG7vR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The function ad_sd_calibrate() enables the channel to calibrate at
function entry but doesn't disable it on exit. This is problematic
because if two (or more) channels are calibrated in a row, the second
calibration isn't executed as intended as the first (still enabled)
channel is recalibrated and after the first irq (i.e. when the
calibration of the first channel completed) the calibration is aborted.

This currently affects ad7173 only, as the other drivers using
ad_sd_calibrate() never have more than one channel enabled at a time.

To fix this, disable the calibrated channel after calibration.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 10e635fc4fa4..fbe241b90f37 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -339,6 +339,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 out:
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
+	ad_sigma_delta_disable_one(sigma_delta, channel);
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->controller);
 
-- 
2.47.1


