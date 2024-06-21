Return-Path: <linux-iio+bounces-6696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D868A913026
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32CC1C239F1
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E6917D345;
	Fri, 21 Jun 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q64kclxz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D217C7B6
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007929; cv=none; b=AuM1a8J9JuIDolDEijzWYMkI7czhnsbZMtpboPXgAXY+H9nzKqkUqH0KyDv/Hx3aPiGQzLmJqK0lQkCCrV0+GkLPHvIv1s5tEzf6q3M5WdOOtbOJJczio9FLgs1XzaLBnQsTY97l1zJhw4yK3sCpAr6IouWGrVCXUiFSXmLw4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007929; c=relaxed/simple;
	bh=CcbNgyVwV5vKSCeUsrgyuEfUik5bQgu+/dXklWHWjMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1YWfBQLhZz0fVzfGAGrZZbBsmMbgC4eVJ3HylJVwSZwPaePS8FjbwFRE4KeMRuW54uOcALOUWklO7RQSVozHrtYTiQ9G9OT93MDkjx2KmMj3zLNEEk1wRUwAcfzXl3pb4aV3aPFZ0IZw3AHrHdQm+izrWXeDVbQ/sidQmhD6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q64kclxz; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c1d42d4470so617977eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007926; x=1719612726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PD+YDF/bIrSJ5as8z+S1ghdz1Anzvn+XbfX57fqHPgE=;
        b=Q64kclxzabbRvObs89ZdGByVGmalFethJ2NP7Bm00yUF7u7MnEtLTXVetgjyNN6Qpi
         uzK3vNjdlXBkLOK1SoXsdgf3oOSmLEzCfeMPPfJhI5tyJK3ySmdVeNaUKHUg8U3/zwsx
         tFvDNeVnlESkz/u7fRq5vIqK01+r4A4qELwE4jbU45qpg4ikabvTSHrKlIQSlCx2nS9S
         yQKVNDUqUvQEg5QvTudX4hUebSjJnrkHk+5haHm7bX6fwWEtxWsBDv5BRPOQypgpN3Bl
         m5PCmC5NvOLryyY5d5lMOTCskskBkB12lKPVvoRr6T+7qT+zjfEVU5XospGQjN750G45
         UmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007926; x=1719612726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PD+YDF/bIrSJ5as8z+S1ghdz1Anzvn+XbfX57fqHPgE=;
        b=vMSz3w2LM72mRfGNYNJSbgXpzuwA7oX488SsBwnDziL19mmeByt0Bg8RoeFJe2rVIM
         eA/j17v61zzzkdu9hdJAiu0JCKbAyMOVfcoUO0F0LrnGMr+XyDcwwyUbertIHvZeKRN8
         PMtg2OIPz6fcQZH3Lu42I9rHzdYElfzE//6SVtrg3nrVDt/kslr5buzJyx6LOX3LNKA6
         ZGRBAXIDvtti3t1q2tDW8lYKn2keo/nYe5oK9USuuthWqXcwR1qQd4kfqY1eI6p7OArq
         ueLkT8JiqDinmRkbnUBOt5jryQePBqt+/qjkF3a3A5rnH/iTRVb0OuOBeK3yK+JxdfX/
         4GeA==
X-Forwarded-Encrypted: i=1; AJvYcCWUN84gLjAWaj/hFOK6PVdgasRH4Cqp5DzZsuZHfGBCW3bMo9vvj4VI6yObfNhobaR3qgk86zuPnyUqnVcQrHItZd2IBMcRZHsp
X-Gm-Message-State: AOJu0YyMcDIJzU5KztRtqRaOypDsSCrjcs5E+vj2SUJf6UwkBgSX7Fw+
	lgtDrAyf3pvUI7hISnvcg/Qdu2YJ3zFC8lU1ea6s8Ekune6XCDzTMAoyIMUknK4=
X-Google-Smtp-Source: AGHT+IG8VExe3m+Cltyn4mwfelEWS/KdStFcap+oMybDTEkuUDcJh0MBpt38tdnWmKzNqDCnxsogbA==
X-Received: by 2002:a4a:dcd7:0:b0:5ba:ffcb:c756 with SMTP id 006d021491bc7-5c1b8b70a91mr8440535eaf.1.1719007926083;
        Fri, 21 Jun 2024 15:12:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] iio: adc: hx711: use dev_err_probe()
Date: Fri, 21 Jun 2024 17:11:51 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-4-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use dev_err_probe() to simplify error returns in the probe function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8461b1fe6bad..b3372ccff7d5 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -464,10 +464,8 @@ static int hx711_probe(struct platform_device *pdev)
 	int i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx711_data));
-	if (!indio_dev) {
-		dev_err(dev, "failed to allocate IIO device\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate IIO device\n");
 
 	hx711_data = iio_priv(indio_dev);
 	hx711_data->dev = dev;
@@ -479,22 +477,18 @@ static int hx711_probe(struct platform_device *pdev)
 	 * in the driver it is an output
 	 */
 	hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
-	if (IS_ERR(hx711_data->gpiod_pd_sck)) {
-		dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
-					PTR_ERR(hx711_data->gpiod_pd_sck));
-		return PTR_ERR(hx711_data->gpiod_pd_sck);
-	}
+	if (IS_ERR(hx711_data->gpiod_pd_sck))
+		return dev_err_probe(dev, PTR_ERR(hx711_data->gpiod_pd_sck),
+				     "failed to get sck-gpiod\n");
 
 	/*
 	 * DOUT stands for serial data output of HX711
 	 * for the driver it is an input
 	 */
 	hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_IN);
-	if (IS_ERR(hx711_data->gpiod_dout)) {
-		dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
-					PTR_ERR(hx711_data->gpiod_dout));
-		return PTR_ERR(hx711_data->gpiod_dout);
-	}
+	if (IS_ERR(hx711_data->gpiod_dout))
+		return dev_err_probe(dev, PTR_ERR(hx711_data->gpiod_dout),
+				     "failed to get dout-gpiod\n");
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
 	if (ret < 0)
@@ -548,16 +542,13 @@ static int hx711_probe(struct platform_device *pdev)
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      hx711_trigger, NULL);
-	if (ret < 0) {
-		dev_err(dev, "setup of iio triggered buffer failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "setup of iio triggered buffer failed\n");
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "Couldn't register the device\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Couldn't register the device\n");
 
 	return 0;
 }

-- 
2.45.2


