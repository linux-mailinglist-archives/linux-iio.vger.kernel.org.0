Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E53352F69
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBSrr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 14:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhDBSrr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F13BB61164;
        Fri,  2 Apr 2021 18:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389265;
        bh=uOJdjmzfcNjl5H10qT6HFOCrKm91lAWpHVnh7oG1Ybc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJySNRwDOHHGmwJe77JHpzm8h0lmF0WRp1+OvlMu2Lvse4vQmBuapvqeWGLIzv7jP
         aQZ/7DhCAixveuqQCskb+lDDf56Gx1wPa/lh7t9CREoKf11gvAmTWvoh935dMW4U1j
         18O3Jlwfz8Up0a5lVP1+dH5n2cShze2NJD6nn0xTCisrB7I2Funs03mkiW1y/VxCVZ
         4xYlJv8QkcsuhbP0B7yTvq7ixfZXhEeBk2g61zptTu0aOP5YDSEEo+l1+hFxykt99O
         s7UJenaGfOOcBcyKpb24CHsAeVgP6TXqelOVUI6AIiWgegtYn3y8bXn7Ih1el277zD
         vCBXJz8gxhlQA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/7] iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag rather than separate irq_disable()
Date:   Fri,  2 Apr 2021 19:45:39 +0100
Message-Id: <20210402184544.488862-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
References: <20210402184544.488862-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Disabling an irq before the driver has actually atempted to request it
may work, but is definitely not as clean as just requesting it as
normal but with the auto enable disabled.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 784c10deeb1a..8c98d8c9ab1f 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -778,9 +778,9 @@ static int exynos_adc_ts_init(struct exynos_adc *info)
 		return ret;
 	}
 
-	disable_irq(info->tsirq);
 	ret = request_threaded_irq(info->tsirq, NULL, exynos_ts_isr,
-				   IRQF_ONESHOT, "touchscreen", info);
+				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
+				   "touchscreen", info);
 	if (ret)
 		input_unregister_device(info->input);
 
-- 
2.31.1

