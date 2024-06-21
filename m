Return-Path: <linux-iio+bounces-6695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823F913022
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8965D1C237D9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E217C7DE;
	Fri, 21 Jun 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HUlHdQfs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639317C23D
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007927; cv=none; b=BIXk4pyPD5jVDiBw9VUjY7qOq1AcrwuaL8inP9B/vzK6L+Ha7sbYwL5az2lq5pEgfrAi7Kr1gtq5ysfvhGawSJnXu2p6eW95+zRHw/MSdfOIbfqNga35EGnkZgLxA6qMMhVlfCNsLEwKLjEIQPA+8QKgCtc6y2R3A+s7gS9Vb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007927; c=relaxed/simple;
	bh=eHaw5nWHJd8mueamkfUEqSM5JDcu9mmRoW0cSKrcZN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOptCsHY/jwrMJ/NFy7HW/RbF0zVNg/UWzFsmj554VIzm+iT1Ccu/GUtYu7quxW9QBgSwHkmK00Es1aG6I71NlGjNS3QaAOtFEyA3GHsAqEE7e1UQS7cvyyQwb8e4pQHFG5ZyWqtt8LztIPukR5EOvMlOqqVV/He/qkw+I5IYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HUlHdQfs; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c1b27e0a34so1177555eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007925; x=1719612725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqnA463lWGmo1DkYd27gIKH1c3eeWL6q+1Fm9JrS/t8=;
        b=HUlHdQfsKCS1ekYyBvCyuTL7A2SsloE6Lbr1jRjYJ++3qHZwl/zi/uq1i2sy7lpseR
         RwOg2lyZIiIhgZ+QTmSq5BDO0y2XAQbEWaitKSRvXMkkwyFuOziT0FafIeqMFRsvttFk
         5ajwfmasK37qTFYlOiIFuHwn7N878r4oIIlN1soRMxxgKiVV3nXTxu/fFEaAqfjnsz5s
         YV1MJTB1qeGhhTvMLDxQhyC4aY7msMy+rJEzl1uVevM7frsfR//ne6IIk1AVZbUS/al3
         TazxJwqQf6YPx7qKUWSLYktaYcYZ89U9ICxYKJgrcG77OLG4QCxfrDT8BsSY1MFzyipD
         c7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007925; x=1719612725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqnA463lWGmo1DkYd27gIKH1c3eeWL6q+1Fm9JrS/t8=;
        b=E3h5WKkapr8dQ2F1Q+EuWGDv6Mz2u+IJA2cjkFxvMlZ+soiy2Zd2AeiVKFAdJfOJw+
         9LtieLUGKWIbs92MJ2v94Z95UJoIFa0PcQ705aKxmOrJV7Lwe9cPrAzYKAo65FzolCKV
         7gxgA/CRW1VfV70u1mGxVqIHBeqFKSHRt+puWHF07wKkiwio7gFK9XZN2+BDfjTYYm5o
         bfUR5eJAcrNGJgE3SU7vAtRluUi9l8+U7VNlDzR9freJR0s77K6u7oSws1QghiMIgd62
         z5oLbybodSnZa3Vqx+qGhK0viYyeGBjnxgfj6DyUBU+Lhkf1+rF1O6HcNog6BRHXEzVz
         gn8g==
X-Forwarded-Encrypted: i=1; AJvYcCVDLaTBHjvLCaeUudP0RcRIdIXQC3QTlOP8DX0e2Xl0k+bsYgfr1INtMYhaKaDUwSkGnzwJlKYYz+/4rdz+7kdcmV1G2QUdflQT
X-Gm-Message-State: AOJu0Yxg4+9TokFp5f/WRGFar/HKn9dOGGZnnOm0HVsU4J/To9BzQHc0
	e+mbab8vcYTh6EeMH6SeD6MduMzIcpEzHUDWkpAE4Fkb6bqTLhdz/YNKNZ8IDlc=
X-Google-Smtp-Source: AGHT+IGyOuPixSMNWTrgJ93EOZnRr5Mc7Ev97HbXaH84J6/Bv30RS8z/PVagDiDtAkY5vq1kH6S7MA==
X-Received: by 2002:a4a:6251:0:b0:5bf:aa53:2de7 with SMTP id 006d021491bc7-5c1adbca083mr9462944eaf.5.1719007925247;
        Fri, 21 Jun 2024 15:12:05 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.04
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
Subject: [PATCH 03/10] iio: adc: hx711: remove hx711_remove()
Date: Fri, 21 Jun 2024 17:11:50 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-3-49e50cd0b99a@baylibre.com>
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

By using a few more devm_ functions, we can remove the hx711_remove()
function in the hx711 driver.

platform_set_drvdata() is also removed since there are no more
callers of platform_get_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/hx711.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 6efdc971689c..8461b1fe6bad 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -539,43 +539,27 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->data_ready_delay_ns =
 				1000000000 / hx711_data->clock_frequency;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	indio_dev->name = "hx711";
 	indio_dev->info = &hx711_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = hx711_chan_spec;
 	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
 
-	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
-							hx711_trigger, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      hx711_trigger, NULL);
 	if (ret < 0) {
 		dev_err(dev, "setup of iio triggered buffer failed\n");
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret < 0) {
 		dev_err(dev, "Couldn't register the device\n");
-		goto error_buffer;
+		return ret;
 	}
 
 	return 0;
-
-error_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static void hx711_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev;
-
-	indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 }
 
 static const struct of_device_id of_hx711_match[] = {
@@ -587,7 +571,6 @@ MODULE_DEVICE_TABLE(of, of_hx711_match);
 
 static struct platform_driver hx711_driver = {
 	.probe		= hx711_probe,
-	.remove_new	= hx711_remove,
 	.driver		= {
 		.name		= "hx711-gpio",
 		.of_match_table	= of_hx711_match,

-- 
2.45.2


