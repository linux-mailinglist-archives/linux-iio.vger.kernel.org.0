Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E247A961B
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjIUQ6S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIUQ6P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 12:58:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA94CDD
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 09:57:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so520019666b.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695315444; x=1695920244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC6Tj/wZ71OdWmHfRNe2x49Rd8CoFCC05cRR7nhn858=;
        b=VZC9fWPW5q8m+e8zs0ascBTBE6Tlllvli5xRhvIiHNFlbDnTlENQjidpcFCicIcHio
         bj5Et7zcJ/GOyXIdS9MhhtkGwICvmn2xjFhE8q3AUkbTUPMvVWO4q5+b55NxohCqbCtI
         ps5IW66PAIQicLcSEJM5FihMJ+QxroW5f3ICguaIh6Sj2MmPMlat0e9BNfrMt5RVoq5b
         9hl3KMP4Nb3qTIc1VA56ATq6ZP4Cgnmv5iJ1n2oq9z1lvzGD0cqz9ZW0d/8ktfZdC7zG
         hK8WYGy0qC/y0aknNsHKsb3s9j3CvsS59OIrhjNfuLYYHBoXihGxN9Mf9Ys8wm7zGeU3
         Zgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315444; x=1695920244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC6Tj/wZ71OdWmHfRNe2x49Rd8CoFCC05cRR7nhn858=;
        b=wGZcZ9/k4RPzR5kMbrVAQZlGmb4FUe/rKO6fv6s7kUOLe2JFujXBhwfAi3aZZrBW7v
         74Fb/nHY4OKzAyV5w5KQYQXQf0/G6WC+y/7qxd69Afoy4NKZwJUwskgzeatBVtKO/trS
         ZgBZ64J1sW7m+A0o052qU/cOKKth7l3GTVt/yPz80jiH0WA7XEKqIuk0Fes0Ae/SouDn
         naKFvLXygYNLP7ddUCGNbW06btXn8+p6Vw5N86s/Npt0LCFZQ+r5RsJmf2SsI7K1iOef
         WotpkZVZVhdaimroBvv56vaBfXtSoNZPJHIevdhr+29YsbWI4M7Z/2/l4Ful1Qnyvjxx
         xvGw==
X-Gm-Message-State: AOJu0YwcTaFVuLUN0LCsM4C9mS3Hqd/Kxpku11ZICvc00X3VSOdjcQHa
        LpAe3ON9isbuKMUFA31F4p5El7Rc38GosIyDqHvs9MDO
X-Google-Smtp-Source: AGHT+IF4+sS/mDwYhthmKF77V0j/XEIKbvBHYAVm/9YBijGkzsfCBsc9F5TNf9h81eIYvejG3U+XtA==
X-Received: by 2002:adf:e641:0:b0:31f:ffe3:b957 with SMTP id b1-20020adfe641000000b0031fffe3b957mr4444516wrn.31.1695306156350;
        Thu, 21 Sep 2023 07:22:36 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:36 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [v2 05/19] staging: iio: resolver: ad2s1210: fix probe
Date:   Thu, 21 Sep 2023 09:19:33 -0500
Message-Id: <20230921141947.57784-8-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This fixes a number of issues in the ad2s1210_probe() function:
- Move call to ad2s1210_setup_gpios() after `st->sdev = spi;`. This
  fixes use of this pointer before it is initialized.
- Check return value on ad2s1210_initial().
- Move devm_iio_device_register() to the end to avoid race of
  registering before fully initialized.
- Remove call to spi_setup(). Note: MODE_3 was incorrect, it should be
  MODE_1 but we can let the device tree select this.
- Change default value for fclkin. This is an external oscillator, not
  the SPI bus clock. (Will use device tree to get the correct value
  in a future patch. For now, using the eval board value.)
- Remove spi_set_drvdata().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0bdd5a30d45d..9c7f76114360 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -3,6 +3,7 @@
  * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
+ * Copyright (C) 2023 BayLibre, SAS
  */
 #include <linux/types.h>
 #include <linux/mutex.h>
@@ -657,12 +658,8 @@ static int ad2s1210_probe(struct spi_device *spi)
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	ret = ad2s1210_setup_gpios(st);
-	if (ret < 0)
-		return ret;
 
-	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
@@ -671,22 +668,25 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
+	ret = ad2s1210_setup_clocks(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad2s1210_setup_gpios(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad2s1210_initial(st);
+	if (ret < 0)
+		return ret;
+
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ad2s1210_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	st->fclkin = spi->max_speed_hz;
-	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
-	ad2s1210_initial(st);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad2s1210_of_match[] = {
-- 
2.34.1

