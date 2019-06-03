Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877F433924
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFCTfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 15:35:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44298 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCTfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 15:35:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so10836992qtk.11
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Z56y5NEC2YnC4rCSfGPtPlUIecEEPpwOsxZipXMuzo=;
        b=OORORKlAlwgkC9fEn52k6O5WjKEwBVz38902L7e5Fd+vNKyM+VdeeW9aCapQeo2cAr
         fUAh+eWJnCaof0BzH0lQx29I4LbIL138MkF9w2cwm7dGhGabG/NPHSoHWlEMnVWgfzLn
         D/Mh2tHiMfjHxwfqYDmfP5ADOWhwYkaQdsU0LAL0oY9pl0bM8hXqWXCMOTPo1KQ0eurz
         DDvkTGJKOQvxmG9N00KRSBDYVxTPWWtHkjsNuwii0bkcKXfprRSxtlTMocylrfVJRKsC
         BssY+d+EreskBPYyFylv6eXsyIixslphMHyFkhZPlPeSC+BjLQJebpNGMzYe2r77fEXw
         GTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Z56y5NEC2YnC4rCSfGPtPlUIecEEPpwOsxZipXMuzo=;
        b=l3icixcjowvVgmvYoo3gtqckMZMVwl66S8PDUSdcoV0Ci/5v9gO+5pnOfl+DcmXzoX
         SHFkRALyLW1rNshEZCDlob50P2ZAz7yHeWV72YmkCfTtOBEERyPliTOs1tfSgM6sLrdb
         RVm6cHaJ8laao3WNH6Om3yrgFVJI21LgTKQ0mFyO5dvZK6yKZf6prbdLTj65sqjwEqUR
         jTH+K6epnxUq7PC85gSwQXuUwVGg3NNp+7YryRq3qcqbYbm6XQD35/MYgfDcvWqrf52h
         d2PRLikIknSbWd4dONADUnPdKjznp/iDF/gevpx2WkQB5EDpHV0bRVwRBLrT61wpjXIO
         GIYw==
X-Gm-Message-State: APjAAAXwchtgQcFCjoGixLUpCXsruw5qB/csIg170nJGn9Oejp+O6h2X
        4jRjf3oiYauOGrCSDT26ibUuPeNd
X-Google-Smtp-Source: APXvYqxuSWcDoufyo9tS5xdQyUffFTpRsm4DTjIFJx6BMCjABNTqIbP/P4BrQUwMmEmjlTxAjnuDlA==
X-Received: by 2002:a0c:e741:: with SMTP id g1mr20129836qvn.67.1559590533363;
        Mon, 03 Jun 2019 12:35:33 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id t80sm7539231qka.87.2019.06.03.12.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:35:32 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] iio: imx7d_adc: Remove unneeded 'average_en' member
Date:   Mon,  3 Jun 2019 16:34:33 -0300
Message-Id: <20190603193433.6394-4-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603193433.6394-1-festevam@gmail.com>
References: <20190603193433.6394-1-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

average_en is always true, so there is not really need for
this structure member.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/iio/adc/imx7d_adc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 46e88899ad74..26a7bbe4d534 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -101,8 +101,6 @@ struct imx7d_adc_feature {
 	enum imx7d_adc_average_num avg_num;
 
 	u32 core_time_unit;	/* impact the sample rate */
-
-	bool average_en;
 };
 
 struct imx7d_adc {
@@ -180,7 +178,6 @@ static void imx7d_adc_feature_config(struct imx7d_adc *info)
 	info->adc_feature.clk_pre_div = IMX7D_ADC_ANALOG_CLK_PRE_DIV_4;
 	info->adc_feature.avg_num = IMX7D_ADC_AVERAGE_NUM_32;
 	info->adc_feature.core_time_unit = 1;
-	info->adc_feature.average_en = true;
 }
 
 static void imx7d_adc_sample_rate_set(struct imx7d_adc *info)
@@ -241,9 +238,8 @@ static void imx7d_adc_channel_set(struct imx7d_adc *info)
 
 	/* the channel choose single conversion, and enable average mode */
 	cfg1 |= (IMX7D_REG_ADC_CH_CFG1_CHANNEL_EN |
-		 IMX7D_REG_ADC_CH_CFG1_CHANNEL_SINGLE);
-	if (info->adc_feature.average_en)
-		cfg1 |= IMX7D_REG_ADC_CH_CFG1_CHANNEL_AVG_EN;
+		 IMX7D_REG_ADC_CH_CFG1_CHANNEL_SINGLE |
+		 IMX7D_REG_ADC_CH_CFG1_CHANNEL_AVG_EN);
 
 	/*
 	 * physical channel 0 chose logical channel A
-- 
2.17.1

