Return-Path: <linux-iio+bounces-16004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD25A422C0
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C73178B2C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D913D52B;
	Mon, 24 Feb 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="24K4xLB+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5F13A88A
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406248; cv=none; b=p/qp2v+xSregl0ts/mO0SQejqSUlrEhZdWA4MhtqHQz3uyxupVmi+xMA95WOWyjGpPW/Nf+F76NLKnluzzNKvRw4UwPFJbBbGMn1zfuQ0ljRguBm0ZeDk5c0MvOdBH/GIvqNT3j1gxrZKfk75g3HXZ0nYbYQhDiXjgQVrM8jQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406248; c=relaxed/simple;
	bh=SRKMapFlVg3+8kF9cvHubzekV8X8++YISp0c0O7y6Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcmDzSraPQ9JBTwm9meg9hXPia4fgayPFNXmfZXnVUx5yPi2rTDtvjUPuTYo0AU6dC4RqQInwS2kVch53ynvYTARICDxWZtfunOVq9L38sA9Q1cH3bGpE6jdzJZukYlmv+sRY6p/Dhuc+bHqlXwGLaB+PN+rgL/NGSjxabr7lpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=24K4xLB+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so7182807a12.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406244; x=1741011044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E0VFJeeN3DbM9e1x+ou8SemoqItJRlOI3ariJtd6jU=;
        b=24K4xLB+k3NpmtTXSPvdYvQHGNgXLyPPAgJvAZ/KAoeUdR+rlBbaHB8o5wyyqBnrEA
         PWwwIb3ICCjVomiW1zS90lT+Hg2ZJXdcqGpKG4R6moqTUvtGebUuJlD7AAbK59DeVW1Z
         UFaQQwUP4xnSlEFAEzAoQQtdJhTtcDkltNctOUdcTc9NW2Ggge+B/jmidf+pjTtr7RKZ
         P3wgf2pCEZ3fvSaGPE/8QKP/dl1I7KhQeh1nPMlW6xF8UkkEVR+a7kehCfGCMcHISTeX
         acsYLfoyp7f1fe29E5vx/NVt4zsm4N7YgML5Zeb/3Ufhe7HANC8/umvsISI+FZ/qmicT
         t5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406244; x=1741011044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E0VFJeeN3DbM9e1x+ou8SemoqItJRlOI3ariJtd6jU=;
        b=U8RDtSp08FR+vZF3C+qBEACXgIf+keQh+Y1DPIb2aF2z/eUAa9UNrHKN+VxsLauqt+
         viJAcuiLm6xYifdbb2JOw36p9xdHQdfBaFZ1pFTmGjgeqMnhc1yq16qErDrnqgyhNQ8N
         /Ck/H5NtEnodIkj98C1ec6XemISeSYG4/UiYK6+YAmEpd9DNxM2kw8UHwUHofY4sYlot
         fJ7Eme80TexHcmih5V0c56iTixONvmYxfwEp5EdXtJtIeZYNFz0iT2Y7vPMUq0pbM1fp
         OjBKI3WjxcZGEnc7v8A/4ZZ/PNaVttxGwA1K6aFU0l/stZsailwa/5QmITJnL9WwqRYh
         gsoQ==
X-Gm-Message-State: AOJu0YzBhAcDIhNL7evw3z72kf3aJxYFZ2M6w8YaB73g2MDeWu9ZdRVf
	yJ89kJ39sQSJbpoL+JGCaUx3ZRM6bnA7bj4I0/qh8Qw3PiD7CC5cY2F3zK8cafc=
X-Gm-Gg: ASbGncts6kTdd0YrtxJh749mJeIBuvwyMjy9owzaHEz2Kl4giKF33bEsqt3F6cmWWed
	voQj/lReaU8CDngFcXyiBEJgzUgqfjE1o0PWmTtLTo/bcTWkPb0f85RJses4oRtm/NkY9VjmcvE
	r+idTtYBKin2hvFrrQIQFXcNMbybKBZugngmOTxLyV1EztvQlb4o9C6bWP2ckFbmX4hW+MTaaty
	Zib51PyMy90EKtmE8dWsT7A9CWxGCruS2bo7InMkJV44zbQ+IabTE+/SGOtSJoT+cZs8VHz5J2U
	mvoPmE1DfbDPcg8Wpyd7gZIunVgggws=
X-Google-Smtp-Source: AGHT+IF9hjXLR5IgH2ytyzjW6fpx2H3xfIANXvajOLuVYy7ECx+hR9GEOC/lf9lILFcaiMEFnBzAxA==
X-Received: by 2002:a05:6402:3592:b0:5da:105b:86c1 with SMTP id 4fb4d7f45d1cf-5e0b7236ee0mr13221532a12.23.1740406243963;
        Mon, 24 Feb 2025 06:10:43 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d48c5sm19200919a12.47.2025.02.24.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:43 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 1/7] iio: adc: ad_sigma_delta: Disable channel after calibration
Date: Mon, 24 Feb 2025 15:10:12 +0100
Message-ID:  <078cd5a78b536b368279be49a09f1c5be836db81.1740405546.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
References: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SRKMapFlVg3+8kF9cvHubzekV8X8++YISp0c0O7y6Ac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnvH3H4vN6a2TlRtaxZvfozYC6VZFqqNsueMlJH l1mjnTY1ciJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7x9xwAKCRCPgPtYfRL+ Tl81B/9KiUF0D4CAMS0JiYnnlE5qVeJ8xAKk/D/yu9bF3Yot6cnIoRl6S37rj2ATjzkEVz0pnjJ 3sbaa//bQ4Wvr+D2baANCajGdNXAtXp9/uK5jCw46jz6AQSlLcQG5LYdWpxK9pwHYdXpQB7cs6R YHcg361criw5GEKdW+E1RJOizrD0q0u7NFJb35BGhh9hdmow/52JxVt2shbSHppR5VDKrbJdaPJ vllQXUSH/bTpEInnhCD/m859cnKp69hNOCGLwCszFhRqJiKRI/fWZQK+mOVt40jd4HpdNglqUkU 7tAB4IET5EiBCV/d03DFn+ZBjgoq7aak1Zjj8p26GdXqXQUg
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


