Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8CC37D36C
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbhELSWD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350521AbhELRvK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 May 2021 13:51:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F344C06138F
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c20so845309ejm.3
        for <linux-iio@vger.kernel.org>; Wed, 12 May 2021 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=SYDiblT/FKbuA+P5DtK7LLEjtQVRy9buQ9rlNnDPTNyrJ6fCURA7APFNkba9LrMETA
         cp3y5kAVDg7FK34ik232iLoQpAG5Vp1LMM0FdeDtuaNFTN+91XFonJ9BJZWNrqPEGgPa
         h6sV98fIZv24fN/XvrB0Zl5JgWBVZ/c4dc9RYJsSoQQwzbnJnrKMF67YsAoTvYTGUFf8
         8fwD+RyHyj1pUkVk0vJC6sT4gB2u3ZhkssdBvugnvV2eK955YM7zcrQ5hJsHYwpHNaXy
         3ieX3bz92AFTz9y6vERaW/F6Sgc8Ba31m5jd1csiSZupR98LhBfDBDUd/dSSY+l7zwQU
         EoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=L+mpV0vBAl3fzm/G1318KedmzDyDmlMsmbYlbKAi9qnXRWFcmf4diCAzmiDjTepu9S
         1WxC5TbIZH0DIrVL4T/79Vw8TjAq+LG9hG/ipysvPo3f3zYcvLMDaLfy7BGXs+1DjJHH
         xGepl6Us//WPdhaXnkUdCWaNb8ocBoy/dWBZdyd8hFG93lTJ34fMSRmlauX+VcCC/fZn
         NOuaUL1gGhvMLtyOaa08W6WsKqND4q5pgoIJScMWUT4oiRQ+Du7NkdeiGAjsewshGuRo
         dbPjQLZYywhdmQg4KuxacFRqODTRrf3/2Jy3pngWwBoXACPbKaQ/4kAeA9owizYlXWrV
         a70w==
X-Gm-Message-State: AOAM531BNWiFi5RFtyYc32ffscR0MklWNXgdMtHTpOeTJQqNP9fvB9D1
        OLDclVD3eHQJUenkn+X+SBaVJy9yA5h3OA==
X-Google-Smtp-Source: ABdhPJwBLSV+hsZcozcVFIQf+ebEzlkp5nvvKcSNKrmg6v9FLDS+ICiZXI3Q+Kw2xiIZ/PF/gA6lCg==
X-Received: by 2002:a17:906:d978:: with SMTP id rp24mr39245712ejb.333.1620841798809;
        Wed, 12 May 2021 10:49:58 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id r16sm338058edq.87.2021.05.12.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:49:58 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v3 03/12] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
Date:   Wed, 12 May 2021 20:49:05 +0300
Message-Id: <20210512174914.10549-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512174914.10549-1-aardelean@deviqon.com>
References: <20210512174914.10549-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found by inspection.

If the internal clock source is being used, the driver doesn't
call clk_prepare_enable() and as such we should not call
clk_disable_unprepare()

Use the same condition to protect the disable path as is used
on the enable one.  Note this will all get simplified when
the driver moves over to a full devm_ flow, but that would make
backporting the fix harder.

Fix obviously predates move out of staging, but backporting will
become more complex (and is unlikely to happen), hence that patch
is given in the fixes tag.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/ad7192.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 2ed580521d81..d3be67aa0522 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1014,7 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
 	return 0;
 
 error_disable_clk:
-	clk_disable_unprepare(st->mclk);
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
+		clk_disable_unprepare(st->mclk);
 error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_dvdd:
@@ -1031,7 +1033,9 @@ static int ad7192_remove(struct spi_device *spi)
 	struct ad7192_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	clk_disable_unprepare(st->mclk);
+	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
+	    st->clock_sel == AD7192_CLK_EXT_MCLK2)
+		clk_disable_unprepare(st->mclk);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
 	regulator_disable(st->dvdd);
-- 
2.31.1

