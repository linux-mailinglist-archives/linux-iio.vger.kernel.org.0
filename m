Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC98137A0A8
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhEKHUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhEKHUA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:20:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A50C06175F
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g14so21647092edy.6
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3CIlvHXWAL8LnevCxF+tYL0znrNNdyr/u/1pI8y5A4=;
        b=Q9Yiffs7kIWaAJUdImwXQl9bJZ1qt4xfgG0/itKjN+yhbkCyz9xeY8zuKsx1CIL/26
         Ay3g0lYtsmKIOXiyfqUGI8Y73XqWMxjZ6Z6tDlQed1WkioOQinFLnu1tZqgKi5KhAtZ9
         KPWKls3sJbJ7Nzxn1qc4oMgnYq3U0V0ZgkYHLtVqCT/qvukxM63g8TMlF4nHqKXmmiT8
         m8MVULZVk3uleKYK2ZfTyEX8073xzNKEh2CVG5cItGExTW7LVLuNfNm1bZK43cYn+YBL
         XsAVfvwxPEDHm7U8li8rW7bA4AlrSB3RbO+bHjDUk46npg/ZStDCFhYvBu6MBg5JBYC2
         k7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3CIlvHXWAL8LnevCxF+tYL0znrNNdyr/u/1pI8y5A4=;
        b=QDomDMMAX2G6Jgk2vDfGZvxDgBXe/Iort9yFfzjWHPUbfhW5ReCqdhHI/8tAX/m9A6
         mDjHKzEkqAJuLn487uWklTgQQ695UGJbONbDX++4lr0knrSzSrAdoapm7vec3Mb/HhF5
         waPFscqGR1fl0hPJ0kKNqKQNksXYXPK4DfaWdAM0oszx2eFrdueyehneTVEfZhmeodXU
         MDUj1KHIKH3H1LDwHaYk4U6npnyWSh/aIiUDIdWtK3TKoevyaFeN+vapLxroetdki2QW
         BzT3BAMuHrVHVyH2zx/FpqsCnsG7ssmY2KE/T7bNxT84N9j3QPJwgP5VyJPwaogNjxsD
         JoUg==
X-Gm-Message-State: AOAM5325UJqA9mBsEbhfrMtIaYj7kItFNy8s6ttlIHuX41flfytD6jme
        76MfB8+Uf2fnoWwWdUVyUC01mDcugT+6U2Lx
X-Google-Smtp-Source: ABdhPJzrVgKabMEuxuqxzVqkTcIeHZTJS/kbU5P6vyScgM3T66gl5Quj3ZOKSgGv6P31BqbA4JVqLA==
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr3834454edt.246.1620717526111;
        Tue, 11 May 2021 00:18:46 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:45 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 11/12] iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop remove()
Date:   Tue, 11 May 2021 10:18:30 +0300
Message-Id: <20210511071831.576145-12-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As not many steps were not already devm_ managed, use
devm_add_action_or_reset() to handle the rest.

This also uses the new devm_ad_sd_setup_buffer_and_trigger() function.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7124.c | 48 +++++++++++++---------------------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index a27db78ea13e..e45c600fccc0 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -862,6 +862,11 @@ static void ad7124_reg_disable(void *r)
 	regulator_disable(r);
 }
 
+static void ad7124_clk_disable(void *c)
+{
+	clk_disable_unprepare(c);
+}
+
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -883,8 +888,6 @@ static int ad7124_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7124_info;
@@ -922,48 +925,28 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7124_clk_disable, st->mclk);
+	if (ret)
+		return ret;
+
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
+		return ret;
 
 	ret = ad7124_check_chip_id(st);
 	if (ret)
-		goto error_clk_disable_unprepare;
+		return ret;
 
 	ret = ad7124_setup(st);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
+		return ret;
 
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret < 0)
-		goto error_clk_disable_unprepare;
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to register iio device\n");
-		goto error_remove_trigger;
-	}
-
-	return 0;
-
-error_remove_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_clk_disable_unprepare:
-	clk_disable_unprepare(st->mclk);
-
-	return ret;
-}
-
-static int ad7124_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7124_state *st = iio_priv(indio_dev);
+		return ret;
 
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-	clk_disable_unprepare(st->mclk);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 
-	return 0;
 }
 
 static const struct of_device_id ad7124_of_match[] = {
@@ -981,7 +964,6 @@ static struct spi_driver ad71124_driver = {
 		.of_match_table = ad7124_of_match,
 	},
 	.probe = ad7124_probe,
-	.remove	= ad7124_remove,
 };
 module_spi_driver(ad71124_driver);
 
-- 
2.31.1

