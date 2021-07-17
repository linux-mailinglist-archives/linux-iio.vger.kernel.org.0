Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28E33CC6DD
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhGQXkq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 19:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhGQXkc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jul 2021 19:40:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C0C061764;
        Sat, 17 Jul 2021 16:37:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f9so16497264wrq.11;
        Sat, 17 Jul 2021 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XT3dSBF1T+xb0vIDoCrx2w6ZTm5g1KZ+GveMuxTzekE=;
        b=CtXz2OYi/GCxjfmSsp1YKE9LnoDSnkeBX/+cM0CqBTWLFyQ6l+6dF7g0GALhl5vFip
         bB1RIaGem2FXKgNiq5DFd/DPWKamLAy953PR8qpNsuuHn+CCMqud62IDqI2tgLVcNVJL
         pqiUeR/+krg7X5p1lecyAvFwM5jkR75NGg6E5w+CQb1NJ9sbUYwh+ep4qbz61fVvxMJp
         TcSgS/GtSGwi5iDDi8i26O8rXG9dnoxKH7P/myimGPxHn9jsUFuERMigxDKxjx9wQWSW
         v8eZgG05pDqFZaqWIbBJC5A9z6GV2VeemXuFYPhFjx3Pr9A3KDKuqhML1I7a9D5eavp+
         fGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XT3dSBF1T+xb0vIDoCrx2w6ZTm5g1KZ+GveMuxTzekE=;
        b=hzbXrzU3BQhDC+1ScPbhWHiKhEG/YrZexMXJkxL7iQFEMX/WESQnpYKpVCk2dYyVwQ
         yYy1rSyz0J06A1cAeAJ0FNsfoBxNjkjiRZ3qOrd/L7vyRv2Uctdf68qm3KeXIpzkNr9A
         wzc6pp+av0JlVgXVlMlGsG+5BG0eEBPdc6VIgWhxbd9NriiCqFUoFKba2Fqh4rxUQPdn
         ngXfFr1gSB7dsXhXHxrJEtbYL/mGkFGdwm4nCF8hlHJtCzt6rKMhyv1CILA9upMaiLnb
         xS3NHMEf+aUDgkA+D2PsnKFeb387ZfNyKBb+6hbrnXp2w4jeigt21lKDzuv4pvvn2ujk
         QFuQ==
X-Gm-Message-State: AOAM533P8fsNpJGCjpm4DODj3q8JJbJKwDiYv70owT1/CzAN0QNyEtcC
        ZMRxIuEt2JQRPVwNGGLyJzo65fqa/yY=
X-Google-Smtp-Source: ABdhPJyMHQezFPPUSmeL1JZrcqZFIjqXhH77/GR5QaHIt7RRb8WSy+hK7rcUeEv/o/KOCoaagS0qRw==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr21346802wrt.193.1626565052070;
        Sat, 17 Jul 2021 16:37:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7602-4e00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7602:4e00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id q7sm12347527wmq.33.2021.07.17.16.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 16:37:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] iio: adc: meson-saradc: Fix indentation of arguments after a line-break
Date:   Sun, 18 Jul 2021 01:37:18 +0200
Message-Id: <20210717233718.332267-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
References: <20210717233718.332267-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Align the function arguments after a line-break with the opening
parenthesis on the previous line. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index b4e16f2e957f..705d5e11a54b 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -497,8 +497,8 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
 	if (priv->param->has_bl30_integration) {
 		/* prevent BL30 from using the SAR ADC while we are using it */
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
-				MESON_SAR_ADC_DELAY_KERNEL_BUSY,
-				MESON_SAR_ADC_DELAY_KERNEL_BUSY);
+				   MESON_SAR_ADC_DELAY_KERNEL_BUSY,
+				   MESON_SAR_ADC_DELAY_KERNEL_BUSY);
 
 		/*
 		 * wait until BL30 releases it's lock (so we can use the SAR
@@ -525,7 +525,7 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
 	if (priv->param->has_bl30_integration)
 		/* allow BL30 to use the SAR ADC again */
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
-				MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
+				   MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
 
 	mutex_unlock(&indio_dev->mlock);
 }
@@ -791,7 +791,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 	 * on the vendor driver), which we don't support at the moment.
 	 */
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
-			MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL, 0);
+			   MESON_SAR_ADC_REG0_ADC_TEMP_SEN_SEL, 0);
 
 	/* disable all channels by default */
 	regmap_write(priv->regmap, MESON_SAR_ADC_CHAN_LIST, 0x0);
-- 
2.32.0

