Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E998C37D369
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbhELSWA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350514AbhELRvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB81C06138A
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:49:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k10so5028940ejj.8
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=qg7B+p/EdpaiT5gvz8IazDMbbMPiWk9AJUJJLOX5vNYzliT7X3pyFCTYphE+eWpyFT
         pnzyX3hL1IquBRjvIKYFWfDQErVLkvyNwtHGDP+R7WDY1LMzeJEj+2ngyLkN9Ei1QkR6
         P8Wp/EABTMd4H97FmKQ7DGN6Y4GTrP6cmbyWCjJkE1qs1x6APee0qKsGJDPWBwXjZ4Uh
         wA5iPLULgRq1vosVtyEaXwnWyL6kxoC+ANXj3lF3BUAMCfjeViP3tJrVfEQ6d2PPn+qK
         WYPsLEICOvDN+XcdTDWeRTV7GG1opmSMRv5NcVu+bTeKvUdlKCs5fBCxxvzsDi+n5gEZ
         GwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=T/+s80zSNmvScPUiXrzws+UPvnoLBZKrAGMneYXqQ5v2qhWbrJDUsI1WDt/1p4eMXN
         U4GervRLEdZY/QkFQcOH7PH5eUcSNLI0nXj1iQMvAaR3v5VPqu3emkJdhczrhbO7zTFd
         /92llostO5TVTNJ4BdKUbzAz774Wp2uxnYUobsI+uxqpik1NWwrFxYvpFkoEYtqKg5VF
         kSRcgJaPlhIhOllxsjWRUGcbH7kNtwg34WEjRQyxkCcWwciXK+D87Bx451bo9tlDR96a
         FF5DyTRrSCh8N3PaLC6dKBzwdH19zipwGXvKgF0qk6/U9iadDvoqHxHRBmq34v77qDjj
         JRHA==
X-Gm-Message-State: AOAM5314PwxzBcmAJ5RqKXXmROPzGKL6vz/nxoLmssOLH3XG5ZNbvwZX
        lvh5VJlFlVVJVUWRv56smrsmMAHetCjP6g==
X-Google-Smtp-Source: ABdhPJwRM2YdDAwUgqdu+As6vFNfWcxNjZJd+2LpncXGnTaKBSs/Qj0AxhzAn8V71kWgDJbc4EfQng==
X-Received: by 2002:a17:906:7c45:: with SMTP id g5mr37981556ejp.368.1620841796574;
        Wed, 12 May 2021 10:49:56 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:49:56 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 01/12] iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
Date:   Wed, 12 May 2021 20:49:03 +0300
Message-Id: <20210512174914.10549-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
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

