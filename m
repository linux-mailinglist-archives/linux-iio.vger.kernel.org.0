Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A6C33393B
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 10:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCJJwT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 04:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhCJJvr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Mar 2021 04:51:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A0C061760
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 01:51:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id dm26so27016269edb.12
        for <linux-iio@vger.kernel.org>; Wed, 10 Mar 2021 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBIxLdWqLnaTc/HNSK6FC9gib04yK5F64uC+VAu1FBc=;
        b=MSo18LFoB3yv54bsMl2QvxGIX+lA2zh3asnEdxzGM5LfyCL6fsQ0E0pcyK2NWxPMEM
         Kvo/olQLRlSTCgzO/34AYq1Cw9x1u0JGL7sR+2cURgpk4zfljK/7VXp1wTCgaoAoDM4B
         kJUba0MspCUKqRNov/dSW+DYR6uaB+zDQ/hDvLAWcXjHxYWqVQ296j1ld/D8Px+LhJ8Y
         3PQXu40MaR5keFXFs0cflmaL8Wl01y4HNB0ypLbx2PdE/nSbtw/c+5C4bnvNfQ5XZHMG
         sw+DLP11U4LMaqbV06dJY2hYzS0wJMKc89i5W09HEqUh5dytPuHH/w3rBns5W/zfUGmI
         Aqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zBIxLdWqLnaTc/HNSK6FC9gib04yK5F64uC+VAu1FBc=;
        b=t3jJjXoXC89HOt8qC4YxQx1tIwtV1dlQWUPY0BU9JdbABgrAY0Mx1sHbVIBUV+tL4t
         QMPxzOBPYuTz5fnBhExvnzUq9ePluOcMWO4HHyQReRCK/L8IW82FKGcG2iIvakwkagnA
         zhZBxG+18nJUSI3XrXD19nlnFOlmHrl9NayTegHlCIVc7nMvc82FEszj5G3gR9x8UjuR
         nbR1SzF4Xc+MjXDmkQIvHE8+xrZqedQhpkEY/pBopz2tTWdHz5wLzPJpjsRp6+8Aqa8w
         NBYvqugtRa7uE+GWZxS6FlRYmnfNchsuiF/nhQtL6jY0lCVpU0J6sT2Ck2RDdzG0a8y0
         ADSA==
X-Gm-Message-State: AOAM531ghUf//BYxzeEpDVrcLnYAVZ5Ex1XRBZMOmtexGC9c8F+Y+Pn6
        AysNERtvQWxH56dvQrKwYY+Bq6H4vlsHQwqK
X-Google-Smtp-Source: ABdhPJwDNyIPf4nWh3MzECZMM0ZIqB4OEA7e3uSknGcoFvDB4e9weZbbP/OighJ/kFTBiV/nun3hIg==
X-Received: by 2002:aa7:d74b:: with SMTP id a11mr2301036eds.92.1615369905860;
        Wed, 10 Mar 2021 01:51:45 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id s20sm8921807ejj.38.2021.03.10.01.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:51:45 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux@deviqon.com, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] staging: iio: ad9834: convert to device-managed functions in probe
Date:   Wed, 10 Mar 2021 11:51:31 +0200
Message-Id: <20210310095131.47476-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change converts the driver to use device-managed functions in the
probe function. For the clock and regulator disable, some
devm_add_action_or_reset() calls are required, and then
devm_iio_device_register() function can be used register the IIO device.

The final aim here would be for IIO to export only the device-managed
functions of it's API. That's a long way to go and this a small step in
that direction.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/staging/iio/frequency/ad9834.c | 64 +++++++++++++-------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 262c3590e64e..b063cfd0e0e1 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -390,6 +390,20 @@ static const struct iio_info ad9833_info = {
 	.attrs = &ad9833_attribute_group,
 };
 
+static void ad9834_disable_reg(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
+static void ad9834_disable_clk(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
 static int ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_state *st;
@@ -407,26 +421,33 @@ static int ad9834_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_reg, reg);
+	if (ret)
+		return ret;
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev) {
 		ret = -ENOMEM;
-		goto error_disable_reg;
+		return ret;
 	}
-	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->mclk = devm_clk_get(&spi->dev, NULL);
 	if (IS_ERR(st->mclk)) {
 		ret = PTR_ERR(st->mclk);
-		goto error_disable_reg;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(st->mclk);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable master clock\n");
-		goto error_disable_reg;
+		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_clk, st->mclk);
+	if (ret)
+		return ret;
+
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
 	st->reg = reg;
@@ -470,48 +491,26 @@ static int ad9834_probe(struct spi_device *spi)
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-		goto error_clock_unprepare;
+		return ret;
 	}
 
 	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, 1000000);
 	if (ret)
-		goto error_clock_unprepare;
+		return ret;
 
 	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, 5000000);
 	if (ret)
-		goto error_clock_unprepare;
+		return ret;
 
 	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, 512);
 	if (ret)
-		goto error_clock_unprepare;
+		return ret;
 
 	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, 1024);
 	if (ret)
-		goto error_clock_unprepare;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_clock_unprepare;
-
-	return 0;
-error_clock_unprepare:
-	clk_disable_unprepare(st->mclk);
-error_disable_reg:
-	regulator_disable(reg);
-
-	return ret;
-}
-
-static int ad9834_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad9834_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(st->mclk);
-	regulator_disable(st->reg);
+		return ret;
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad9834_id[] = {
@@ -539,7 +538,6 @@ static struct spi_driver ad9834_driver = {
 		.of_match_table = ad9834_of_match
 	},
 	.probe		= ad9834_probe,
-	.remove		= ad9834_remove,
 	.id_table	= ad9834_id,
 };
 module_spi_driver(ad9834_driver);
-- 
2.29.2

