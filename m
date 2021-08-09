Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D63E4DD0
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 22:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhHIUbo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbhHIUbo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 16:31:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E790C061796
        for <linux-iio@vger.kernel.org>; Mon,  9 Aug 2021 13:31:23 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t68so19878540qkf.8
        for <linux-iio@vger.kernel.org>; Mon, 09 Aug 2021 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0crufBEbb7bwUYGFHe/PY2sI2ksvT1RDAXbAY/4UTA=;
        b=vuJLZd+6jPp+a2i4GAYbqBqJ8h9L/vTYtErH6rjm5bRuInIFYrGtoxbfZaDJVo6R25
         cI7PwVEEplgCMCqI8Lnp3KDJAIQKIbjgv3S9xLKREcZF0PTnxeeTgwxE/9xgM+y3cK2V
         i2/G4JL2GDrpcObxNgP8N1LaBLy6uoEmWd83bO9j/jqr8kIxMDwgaVBJMDJAdaNzAJIX
         6bnKUhxb5xdbIBsXkJXPVsnItDNfTRxvPLJr9Q2kK8VncR7MqN3KtlRABi3tyFgPc9mn
         R1VLE+i0AqhC2FIYkN1sKohOdQQKCsa2ccniorkPmoLZNgBOpXag+wLW+qjzAHe7fgYV
         bubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0crufBEbb7bwUYGFHe/PY2sI2ksvT1RDAXbAY/4UTA=;
        b=MbaWg7RQRKqPRnXzS+1AfhKL1IUlILTEzTeJMcQicNIO6afDj53uGi35r8IK+PE/kM
         Mw7OIldTtOu8OPFu+CS+pQ20GFgzNa/ZqVhDWXOvNB0jI1EYRGOtCkVgVH//P0c3pU0V
         1f2LDYKGTONMM34tNgE+fjO8swfX4Ods+o+ap0GZJco5L6O58g/v0s4Xg350K691WnAR
         S0VqZJFHWy+j7xXjfCRkIzcMhGgsDHQKtMKBzDVZD57oeZeIgTcwYHT5O3PUMSB5nRRN
         3xnKUXf6TZrCHvUXQeG0tlyOCmDArrk0N78qwaUL2NZ1kVahSU4HF1oi2fUwHl40yRDR
         d8zg==
X-Gm-Message-State: AOAM530W6zhe0xzVK16G+BNu3cpxcCR4knDV8lfzaLMumJS37Ps8jCY6
        SwcshGn6YLxQQlNos4mHX9Q/MA==
X-Google-Smtp-Source: ABdhPJyBnilKYM7Xy7CjBLb1V7xuprkCAxFb8QY/z7ygSbU1qmDJPwxozjhaAYTkJrXu5HF+A1ufpA==
X-Received: by 2002:a05:620a:102f:: with SMTP id a15mr21986768qkk.128.1628541082446;
        Mon, 09 Aug 2021 13:31:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:ae81:895b:5885:9710:df81:62bf])
        by smtp.gmail.com with ESMTPSA id d10sm2508909qkk.0.2021.08.09.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 13:31:22 -0700 (PDT)
From:   =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        marex@denx.de, marek.vasut@gmail.com,
        =?UTF-8?q?Th=C3=A9o=20Bor=C3=A9m=20Fabris?= <theobf@usp.br>
Subject: [PATCH v2] iio: pressure: hp03: update device probe to register with devm functions
Date:   Mon,  9 Aug 2021 17:30:14 -0300
Message-Id: <20210809203014.10955-1-theobf@usp.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update device probe to register resources with device-managed functions.
Further, get rid of device-specific remove callback which is no longer
needed.

Signed-off-by: Théo Borém Fabris <theobf@usp.br>
---
Changelog:
V1 -> V2: Tiny cleanup

 drivers/iio/pressure/hp03.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index e40b1d7dc12..9538118c964 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -242,47 +242,26 @@ static int hp03_probe(struct i2c_client *client,
 	 * which has it's dedicated I2C address and contains
 	 * the calibration constants for the sensor.
 	 */
-	priv->eeprom_client = i2c_new_dummy_device(client->adapter, HP03_EEPROM_ADDR);
+	priv->eeprom_client = devm_i2c_new_dummy_device(dev, client->adapter,
+							HP03_EEPROM_ADDR);
 	if (IS_ERR(priv->eeprom_client)) {
 		dev_err(dev, "New EEPROM I2C device failed\n");
 		return PTR_ERR(priv->eeprom_client);
 	}
 
-	priv->eeprom_regmap = regmap_init_i2c(priv->eeprom_client,
-					      &hp03_regmap_config);
+	priv->eeprom_regmap = devm_regmap_init_i2c(priv->eeprom_client,
+						   &hp03_regmap_config);
 	if (IS_ERR(priv->eeprom_regmap)) {
 		dev_err(dev, "Failed to allocate EEPROM regmap\n");
-		ret = PTR_ERR(priv->eeprom_regmap);
-		goto err_cleanup_eeprom_client;
+		return PTR_ERR(priv->eeprom_regmap);
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
 		dev_err(dev, "Failed to register IIO device\n");
-		goto err_cleanup_eeprom_regmap;
+		return ret;
 	}
 
-	i2c_set_clientdata(client, indio_dev);
-
-	return 0;
-
-err_cleanup_eeprom_regmap:
-	regmap_exit(priv->eeprom_regmap);
-
-err_cleanup_eeprom_client:
-	i2c_unregister_device(priv->eeprom_client);
-	return ret;
-}
-
-static int hp03_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct hp03_priv *priv = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	regmap_exit(priv->eeprom_regmap);
-	i2c_unregister_device(priv->eeprom_client);
-
 	return 0;
 }
 
@@ -304,7 +283,6 @@ static struct i2c_driver hp03_driver = {
 		.of_match_table = hp03_of_match,
 	},
 	.probe		= hp03_probe,
-	.remove		= hp03_remove,
 	.id_table	= hp03_id,
 };
 module_i2c_driver(hp03_driver);
-- 
2.20.1

