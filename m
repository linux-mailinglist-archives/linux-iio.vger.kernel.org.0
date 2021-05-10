Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D377378E50
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbhEJNIx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351161AbhEJNDC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15222C061360
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so16540433wrx.3
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5I8AlEC8dBHxWFP7B4nHqLuYclQwxngKCwv+MqH04xk=;
        b=sQfd4NvTRV4ixQQ86oG2ZoHxdXUfEauJV7TV36o6f3OfhJ39gNJvExCMosqH9kYn5T
         aFhsp0Ro31OhwJgSLHagc26/AxQk3KbawtB+3P27yoR6Dzccrtjhu0ErpDvgtKfOFz0h
         HiKISzMcmbpd96L7vR2Vqs1kig5TzCONiS0Uxka50YEGVLpImwy8kGEKIOF+CPHz3Zdh
         /mrRi4/UhP3qmVOnxFdx9TPITxEm0uu+oxQqqcvcEIFrstCAj/MQWR742OjVDrfa56oq
         mR4rHyLersV5LpCDWyR+QWpA2CQfeLW78k9O8EXZdDHmnlAdzB4qijY3zFNY0345NcCx
         R6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5I8AlEC8dBHxWFP7B4nHqLuYclQwxngKCwv+MqH04xk=;
        b=r6pCaIm49sAQ5kbU6fGwzzT8ra/t2dmn+wV3LQ+pJo4wMESekMzhGTGLxnRYbq8VL/
         JHlf5OwZNGuth7ukmUOj8QjfB086RjYyT61CHOh8VUpcU/fAF2kFgNj33yRMZCnpOIdN
         7O2GZajoKlp5ZxbRgWvJEx3yAXMIE+rHx5LeOaKeIPHiJELQezhW1GDSVsvuoewzGlBB
         +qqqCLqCtdPCrICqYKOvy/aT06hVV898cmem5koc2v1CnMIxL270B/NJrRacW9SZut3O
         7f3gQdeeTgRTsq9DJ1pWK+kqgVg27wbw4jpS6yQ2RS8HYtEPjjpyIVpW/WMY3aAtmQZN
         iZyA==
X-Gm-Message-State: AOAM530tmFFG9cEOwrpRvK8wn8NKd9WL3wnWsVIMagdpTlfEtSumkKWL
        w0YonK54JcB1YztH8zpr4UvdpG6Pj0sr6w==
X-Google-Smtp-Source: ABdhPJxOWtpr8Do6Tf/iovboR54hvTwbW1Gisv2RZXs4FQEfB48TuZVMAOrU8aX33X8DYta11pNbRw==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr30419014wrm.93.1620651358650;
        Mon, 10 May 2021 05:55:58 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:58 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 08/11] iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
Date:   Mon, 10 May 2021 15:55:20 +0300
Message-Id: <20210510125523.1271237-9-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

