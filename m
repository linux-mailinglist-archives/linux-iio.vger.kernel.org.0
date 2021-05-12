Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBEC37B963
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 11:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhELJk1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhELJk0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 05:40:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F72C061574;
        Wed, 12 May 2021 02:39:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h7so12245993plt.1;
        Wed, 12 May 2021 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kL3PnYBjbGyIzaSUKB/SpTvmbE4guCrpRlT62MJ7G+4=;
        b=EMy33MGujBLV5IjAxdPcjQaejvbwjBPaB/AYmvUyTcAD1ljWoAGErl9e7kkMJcKHpR
         D/MCocEJmTn6AQbt1UplqXRzN/u6iNviEt+17gpcazCbRKhzsCKFxB1H6h88o68fdkcA
         W0XtZl4wAZ44QHfwA0iq5EhtHwjhaKG8UhUmx1pAh8vtZkrTjdF8URY0CvDl9tAqZQ6J
         E2IJQeCG5klAEMJAmlzAgHDGI9B/EF11yO1qHKnsJiafSzSH9U6CSvHGNN4vgITat4mU
         n/rzXirGuZK/rk6s9KYoWVfH8GXAmavWPTootzMGuGCmN3ZDjh/wZTRZHrUxwYut4+oz
         sDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kL3PnYBjbGyIzaSUKB/SpTvmbE4guCrpRlT62MJ7G+4=;
        b=aO8SnQZQvNiRDC0Gj+HxJu67eNb1FbeApn4KbRjCT458mFoUTn94n5xyRiMxSOXvGj
         ar47mQ8XNfebHCqA7se5ZMvgM/8513U6MM46xsHxm7GcLcveCyTSckB6CWBLC8YhoSJ1
         8v6mlmIcMjyfGQk782NhTfclD2l8k/2LNRBF543WPwDgy5A49xuvRjS4TvrNjgCALTrU
         NVzlcG1GggNjNv5C++0BLqdgucWy4GgGUaCrfEqNQUX38A/8w66mqqdJT0cy1x3tS4LY
         FTyNku4yEWZs1ZAjAiK0M4nsBOGgf1Dls3vbtpDzOQaw0Vwi7qHvzEQv+43B1eJm0g84
         pkqg==
X-Gm-Message-State: AOAM532L6dJ2K5ufrlIQloH6ifobCkMtdZ9clh5qd/elHSdz/Sh/ecD4
        8m7GQSW52edmZ1YbiDnVyDeO4AxGbIY=
X-Google-Smtp-Source: ABdhPJyEicVV21gtSUQ3O/5O/+Wd9hV0X9GOFi9/inbETfX1O4xT7CQYCIpFX6jOmQzT7lksJhxaww==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr38555380pjn.143.1620812359039;
        Wed, 12 May 2021 02:39:19 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j23sm16180833pfh.179.2021.05.12.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 02:39:18 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] iio: adc: Add missing MODULE_DEVICE_TABLE
Date:   Wed, 12 May 2021 17:38:44 +0800
Message-Id: <20210512093844.243245-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

MODULE_DEVICE_TABLE is used to extract the device information out of the
driver and builds a table when being compiled. If using this macro,
kernel can find the driver if available when the device is plugged in,
and then loads that driver and initializes the device.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 301cf66de695..00098caf6d9e 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -549,6 +549,7 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2731-adc", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
 
 static struct platform_driver sc27xx_adc_driver = {
 	.probe = sc27xx_adc_probe,
-- 
2.25.1

