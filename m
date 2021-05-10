Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16A8378E4E
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhEJNIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351154AbhEJNDB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 09:03:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22997C06135B
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n2so16577819wrm.0
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTtM8kn0b31ydFMuKcSxWx1slW1FxaHCCrR/H73UctY=;
        b=LHKpD4K7L3yMnf/0qkqYPZlHo1Iv43BC0Y/5hfj8VDitT4zG2XpsvDSy9WZGcvFBoN
         scWULjOPOqFzE9VEEaghG8BSr63T48185JWYatD9lwT5Tabi/ea8oHnOrDAuJxlpGiVp
         zx5c5w52kW0B2Z6de3DcIvFFFCYNnFPJpCYHPI1o2A0kQ6WDOcTYMUDAPmwRr/NcntjY
         B/4FPE19LT4dQWAXm3Lq5wKLr4xsXXRF9VzCcCXO4xliz71DrE10x/RuyOFh0shQfK8k
         eZB7GSMeOGRgQn/GhF/XqUG6+sIvlxncihU3NZA3BQwrkmOOEx/P1+jZkP32crJsk/jS
         eg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTtM8kn0b31ydFMuKcSxWx1slW1FxaHCCrR/H73UctY=;
        b=qO1/01O494vg1VUnORmPT9lIB9MnNf3qqxpEtMxUqT5IA/Y0yK9fwmI4OfrVc8/qlH
         HpJGaAjKuJHFn3Yn0MjKNdBRfeRPVuo4dALVjds3dnskUOzeUUr5VdgQyhygHdwUskFn
         vIFwyOm9lUVlcZsTeXZzdTdBuqAqKrW5a9ZFEfCJNPLlf7D8nBIA8wBouX7VdNem+WCq
         TmGerEB+4nEL58G1sBDqHdj8p5LxaYbmiIE3V0AAovLEe9rCQTGqOUYOx6XFc4boEUQE
         ggTriwI4UO1kjveYsOuFs3OYcckmvJVwEWh0k1ajpSD3vGRQcWF/BV/n4a1g15kg66Dz
         El7g==
X-Gm-Message-State: AOAM530J63Ctoj+Ue048JlyHsVKA3y5V/OfNjEzYsuFjBaTa8920Rj5O
        XqSrAKQnWyAVFJNE8ECT6YPtfVR2tAGy8Q==
X-Google-Smtp-Source: ABdhPJx7nw6CdyOwxLfeUaUqmfXJzdw2+rOPfuaY1dj6Wj3aDI7IpLr4XpOxQ3VTe2HMNSMJEmPG2g==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr29647958wri.27.1620651356709;
        Mon, 10 May 2021 05:55:56 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n2sm23134329wmb.32.2021.05.10.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 05:55:56 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 06/11] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
Date:   Mon, 10 May 2021 15:55:18 +0300
Message-Id: <20210510125523.1271237-7-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510125523.1271237-1-aardelean@deviqon.com>
References: <20210510125523.1271237-1-aardelean@deviqon.com>
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/adc/ad7192.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 2671581d761f..5b3c46213bd4 100644
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

