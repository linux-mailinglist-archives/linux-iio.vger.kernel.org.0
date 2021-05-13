Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5383F37F77B
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhEMMJ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbhEMMJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F954C061574
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f1so8475281edt.4
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=ZtQbTSVXvj17YhFLNO51WDqUQAYNykjDQQIXPE/wLAnfnWto5f2bBUTK1tno1fOl2v
         OEdbJ7iY64YXKEnXGoBYrYmytA6Q+Y4FqyR2MfU5bTHdIoQvasQYkl9WU9aKMTiDne/r
         VSmfeNjCjYhVUrQtOCs/q+jmaS/NhDkUt+99M99/habPt7mjEYkmhDvtVG9FYChATwKP
         TpUBB+aFh2TD7FxbQbTAp4Le27VQmrPtKJ/+IjlBrllqw+UXgKNFAe1GMx58jE2h6N/h
         nuzeMm72jSFkK2MECoJuqBhgmigaoDGDseXXlg25TYPbNfhixWCncm3LdNk+ajJunVce
         75Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URnNCU/Gt3uzfVjqFnT5ZArbKyWbTbXjKVLfJMYugCE=;
        b=VnAnwj5VfSWkULKLY2F5mTbOIKHI7RLPmapuQZnl7wHjXnwjeHS/pvQqCTRUIAQtDq
         P05y3uQeMdcW9lippMqWVVY7emlmlm/Y4h62yCtTz3O2VeJs4NhWKatrcZBTr3VbLBxD
         VHZE6OssQlXoK4MnZWuBXNP+5jU5iujjS/aajIQpAvoA68ayyc853vtBpVb8IIgAjgFW
         B4qwC8pT2pIXlOgh8o87Ex2atEQoJyQMrXOF/i2cGEj+ye7koekZuh7DvriyxQ6mCXUW
         kGFN/6JfJNhcYUPhQ+1Hbcx1TLd3WGyiaHNxClEhT9KbyJYYd+FMDFZF5vFf+mBMTZXA
         bWtw==
X-Gm-Message-State: AOAM531TdJFFJgLhU9i26LsC5DKy+kcMOz2A52UpMTkxDdBFVHq2piFy
        xcU++Xt5RjjR01sx/TB2Cl9yrHUTXOX/NA==
X-Google-Smtp-Source: ABdhPJysLfVEVIwQJvqmYYgFXiCP+neyXUG/tx8+hsPaCnWRLO/JSZAYs2l9y5M7G/cA2WFVeKuZ0Q==
X-Received: by 2002:aa7:d893:: with SMTP id u19mr5066675edq.258.1620907679648;
        Thu, 13 May 2021 05:07:59 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:07:59 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 01/12] iio: adc: ad7124: Fix missbalanced regulator enable / disable on error.
Date:   Thu, 13 May 2021 15:07:41 +0300
Message-Id: <20210513120752.90074-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

