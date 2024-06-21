Return-Path: <linux-iio+bounces-6694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76391301F
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB851F26048
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12B17C7BF;
	Fri, 21 Jun 2024 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1pXtyYya"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5F17B43C
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007927; cv=none; b=Q4JceAXU7PhtwRUIlvD/b5typ+LqLWqGuyhW+6wf/rqd7Ua9NqglLqt703/5+O4inC+Q5o0NjJZGXN58HROHpl4EAb+C29ZtIU/moB3InmCUXTm+6wqED6AilPoi2kCanS1Y65toSMJZkVma2IahviIdC8iaRc19cPn7SpGJHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007927; c=relaxed/simple;
	bh=72ifk851A+wshsZunu+4+cPq6YsaruRIFtb/gWfz2Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tB42eKoQ/18YfeLIpDWXO+M/nUISBr8vwkQLK/u+4/ecxVoncB4EjkLIwBoen9bbhobi97ZM0NtS3guk7Waz1Ld79wAmdVjH2SZ0A/7hHVY3cc36VRpPcGVrbYBEwkLenPIGpo1ushxpc6vKmFNUN3m81bL/LHz/22KgwYBt7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1pXtyYya; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c1d2f7ab69so775046eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007924; x=1719612724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA2vZ5H4zhrRVMGC41BbSeo0sgv1/DHDpLqlssCbQtI=;
        b=1pXtyYyae8kHfLqsm0MJrlVoF10LnG9A0v4nE1rxPZLXR56BRO/+KyAeMMYvHT0jLr
         WOOMPbPvxJjyN21EweQWqOB3kos3p8tOdg3ZZJyZrTRZbgTlXQ++4pCZCbFPnnAQKqa4
         iR//aHLHeiHlnoksKvsF6t40YU2oG4hoNTDs70+XO2Km79thJtsyp+oEBHdZt3b1q0lL
         nbw5H2VGhZJgCxqZObtxBUSHQ/i84gjmsWagv02/An0FKgQVSmDxER+R2djyt1EMS3rr
         vrdogpc2acDnxtxCba0G5w6YQ2KgGJBNZy0j9nZ7chfunNVnwoUiGJaF0IqQ08XIpqir
         VOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007924; x=1719612724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA2vZ5H4zhrRVMGC41BbSeo0sgv1/DHDpLqlssCbQtI=;
        b=p/ppDYpTGaAqX1FxEpnOoUCaWxu77Q92fSlNoemDYmPalpB0KBolKCIYOuOzX1J3nZ
         r5SYaC5iVScqz7p2fkwnKMndKYf1zPj5Ql5y5S59R/1MDc2rjN27aFvLu5JhTiQG7iCV
         uBQgoBDt4pDvqw14OAYPod/Nh0mdCIxyAaTgpmOBWcoKBvNhRN5miEFc2nFtFuePMS12
         T3nhNqRWjMzagRsDQHhoEVvm5YLBIXlsRz2GI7bDDbRQeNGGKaHJS8yqHYE3LH1LseLS
         i6KeQuHTnbG77GZ4fcAr7zxgBcZ1AW7tmeUcCVf3fs4GExroPKaqytS+fddmDEZ0kjLM
         LXDg==
X-Forwarded-Encrypted: i=1; AJvYcCXpyfwr0/hc8jouFe2c9rtvr6dGyEQGY95wvAgm2rCgb1L5jSndOWfhhBXOoioCzgGjQXGuXEvp8FKW1HVT6Wl0iT4QiQZHJthW
X-Gm-Message-State: AOJu0YwsTdQAsoQYSDdRlB4mQHcWsDbsyKRlKEFFlFtiv5OxUfKPmYPj
	yEJy9Mwcq16d9F0Mv+F3p8eBCEf6KBtl5HZlBxVRmCEWiEiyHpJW3gzY+gZLcpQ=
X-Google-Smtp-Source: AGHT+IGPEjYzZuYy0PUyybo/Jr5W5tkGRhnX5VFZ0jGpJucieHOIXpFu0GRrOvhhGuVkoDgVWKm7XQ==
X-Received: by 2002:a4a:7619:0:b0:5bb:288:e955 with SMTP id 006d021491bc7-5c1adc6fb4emr9863944eaf.8.1719007924414;
        Fri, 21 Jun 2024 15:12:04 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:04 -0700 (PDT)
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
Subject: [PATCH 02/10] iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
Date: Fri, 21 Jun 2024 17:11:49 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-2-49e50cd0b99a@baylibre.com>
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

Use the devm_regulator_get_enable_read_voltage() helper to simplify the
code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index fef97c1d226a..6efdc971689c 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -80,7 +80,6 @@ struct hx711_data {
 	struct device		*dev;
 	struct gpio_desc	*gpiod_pd_sck;
 	struct gpio_desc	*gpiod_dout;
-	struct regulator	*reg_avdd;
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	struct mutex		lock;
@@ -497,11 +496,7 @@ static int hx711_probe(struct platform_device *pdev)
 		return PTR_ERR(hx711_data->gpiod_dout);
 	}
 
-	hx711_data->reg_avdd = devm_regulator_get(dev, "avdd");
-	if (IS_ERR(hx711_data->reg_avdd))
-		return PTR_ERR(hx711_data->reg_avdd);
-
-	ret = regulator_enable(hx711_data->reg_avdd);
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
 	if (ret < 0)
 		return ret;
 
@@ -517,9 +512,6 @@ static int hx711_probe(struct platform_device *pdev)
 	 * approximately to fit into a 32 bit number:
 	 * 1 LSB = (AVDD * 100) / GAIN / 1678 [10^-9 mV]
 	 */
-	ret = regulator_get_voltage(hx711_data->reg_avdd);
-	if (ret < 0)
-		goto error_regulator;
 
 	/* we need 10^-9 mV */
 	ret *= 100;
@@ -559,7 +551,7 @@ static int hx711_probe(struct platform_device *pdev)
 							hx711_trigger, NULL);
 	if (ret < 0) {
 		dev_err(dev, "setup of iio triggered buffer failed\n");
-		goto error_regulator;
+		return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -573,25 +565,17 @@ static int hx711_probe(struct platform_device *pdev)
 error_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 
-error_regulator:
-	regulator_disable(hx711_data->reg_avdd);
-
 	return ret;
 }
 
 static void hx711_remove(struct platform_device *pdev)
 {
-	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
 
 	indio_dev = platform_get_drvdata(pdev);
-	hx711_data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-
 	iio_triggered_buffer_cleanup(indio_dev);
-
-	regulator_disable(hx711_data->reg_avdd);
 }
 
 static const struct of_device_id of_hx711_match[] = {

-- 
2.45.2


