Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD70A37A095
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEKHTp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhEKHTn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA2C06175F
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j10so1178388ejb.3
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=JSOSsYmFD5QmGgpDLNRQitF/l6W3zvsTNv8c9WmaXd2ytjXpPNKnrjA//1MXHMKdUE
         Azc38GcVttcldRR6C6uCuQd2x6ZjxIxzuxcSSJMhU8pbgnHZ9MGYrd9yUNMqow+IZagb
         LT9r9GzcLMwU6sFdCxUTMDbTO6uHpv39PGp4dg1sblqjLxDOaKUJavNbNu5+BIVvT8Y+
         gWWx3jnc+18uzkjZNZSWQBLI8/KNV1W/iP5/NJfPk1vNytiHBIv47S7Ndkaca5c4uCRf
         XBdptlEmuOM1mbo/G2Uj6lolKHyn0b08u8QUgkE7bk8W7yaIMDVrWWDo+DvGeG8hb3Lm
         Zivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=nBeAFzddsFcWt6Mj8gPpkULC7QKqjqi+vQBTiMgAnBbYkJ16iXK2wB/PAtirkIhYB9
         DKR0xdGqhUJ1rCiMHyJ5ty3AMg7eiXj9h1xqh0j0gqtBA2Ty+NzVNDP/F3Macbh0jmGo
         kO1sgDPKm9JPyo7xaEZVpxwXcq86XSWje1Cg3dHy1xPcRqTQ5B1tJKKO6TzGlmkL0IZj
         W6KvyTR+aUoMN2npqhJ+ccNM5nchYhLdWxzQSjZZ8JQAANO7plIKaibEntYOrYX3RZKO
         dErw4ObiG3+Rkyeg5K6u2sQD1EH8EBETYnaiDI0x2nJ1TfHFNkgiiXPNBydAWvuomZUx
         rgqg==
X-Gm-Message-State: AOAM533w2+1xMgW3G5lB+Mg/hDZhgQFmx6bLEmp8iELFfFs0RYZ/C65K
        F107CnigbAw/any9Yyt55yIQEgptkKTGFpQL
X-Google-Smtp-Source: ABdhPJzy+HvcxMAOOjEm/Ok25x2DCeZ+Ccd5ehFBwVZpAP2ETTvbrN8ygknq/Ttld5JGtMxROYL/1Q==
X-Received: by 2002:a17:906:1e0b:: with SMTP id g11mr29707544ejj.291.1620717516331;
        Tue, 11 May 2021 00:18:36 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:36 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 01/12] iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
Date:   Tue, 11 May 2021 10:18:20 +0300
Message-Id: <20210511071831.576145-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If the devm_regulator_get() call succeeded but not the regulator_enable()
then regulator_disable() would be called on a regulator that was not
enabled.

Fix this by moving regulator enabling / disabling over to
devm_ management via devm_add_action_or_reset.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7124.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9d3952b4674f..437116a07cf1 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -850,6 +850,11 @@ static int ad7124_setup(struct ad7124_state *st)
 	return ret;
 }
 
+static void ad7124_reg_disable(void *r)
+{
+	regulator_disable(r);
+}
+
 static int ad7124_probe(struct spi_device *spi)
 {
 	const struct ad7124_chip_info *info;
@@ -895,17 +900,20 @@ static int ad7124_probe(struct spi_device *spi)
 		ret = regulator_enable(st->vref[i]);
 		if (ret)
 			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
+					       st->vref[i]);
+		if (ret)
+			return ret;
 	}
 
 	st->mclk = devm_clk_get(&spi->dev, "mclk");
-	if (IS_ERR(st->mclk)) {
-		ret = PTR_ERR(st->mclk);
-		goto error_regulator_disable;
-	}
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
 
 	ret = clk_prepare_enable(st->mclk);
 	if (ret < 0)
-		goto error_regulator_disable;
+		return ret;
 
 	ret = ad7124_soft_reset(st);
 	if (ret < 0)
@@ -935,11 +943,6 @@ static int ad7124_probe(struct spi_device *spi)
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_clk_disable_unprepare:
 	clk_disable_unprepare(st->mclk);
-error_regulator_disable:
-	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
-		if (!IS_ERR_OR_NULL(st->vref[i]))
-			regulator_disable(st->vref[i]);
-	}
 
 	return ret;
 }
@@ -948,17 +951,11 @@ static int ad7124_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7124_state *st = iio_priv(indio_dev);
-	int i;
 
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 	clk_disable_unprepare(st->mclk);
 
-	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
-		if (!IS_ERR_OR_NULL(st->vref[i]))
-			regulator_disable(st->vref[i]);
-	}
-
 	return 0;
 }
 
-- 
2.31.1

