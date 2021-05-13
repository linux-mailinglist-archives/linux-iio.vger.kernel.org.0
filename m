Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBB37F77D
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhEMMJ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhEMMJN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 08:09:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A68DC06175F
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so6659943edt.13
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=P+SgjrmYBqQ0rZ0mFyDg1f5A/hC9oEwgxN7MfLMZ+oL42m2KNxPOEqVmqgKSFvJkzb
         lUus8kWAEbJ21EjfXNp9d4ZZlz5BHaSm8C2LruPbbj63Hx+UkamvZGpfPyfyLmZbDoxb
         yN/k5DhCepeM4vEIJpwK674t6L1PvAd9f7qyXJEdaZbigJ9TrrSEhF34j+nB1G8vG8w1
         j/ZxkVa81qFZk2F21/G0pH31Uh6wAx2eBwz743DkZ/Sju/sf7vDdpH94msnZ3Sflic+5
         ScfK87fQuydxmeFk3+1N5whe04veqv8XybEiU+nQviKgocqdMvkSo8/mbEyTGQvFaGts
         MVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=tfXnR2nFKkY6D7ory0K0flwRdyZilx6THgylrTNBUiGDbrSj4LHWT//7+YDgGY4WZ4
         wrq73feqxuIf9mf+nikmn2uDv/AkP5PM1Gn0FX4YpBTrhV6VtyQVW0ZJ214MJwb6qWG1
         knYDeCeTkpZHy4R3a9Uw88N8b81f5aYTZ7uaFLj/Pbcv5fmnAwSJ1yMXjb9rB6ecMB2R
         KD+tf0IiSgL4hMteql84FSWnoIiP5lR0zUjNU5SXb4Mg0cTrUWxdhguCx+bmwf0Fd3rK
         ChkIk57vUKQp4t0CKgut9gX3Gi15K4brq6kO07PDVTswkM4vMhTDPNOAB9VCeeRPKKeT
         etEw==
X-Gm-Message-State: AOAM532hyw3N7Aor4ZVfcTBHO/tU6XZ/i9vpAyik9/FVR8TJ88LPGXBt
        RrZB8LTBuvotV7awuLBUQtm3i94YVQtnBw==
X-Google-Smtp-Source: ABdhPJyIkT/ogJbSRjObXn+3wUE92nhhoORSTrArsHGYJUkPNOdItWFMkhsKNkU+Ba5KXYwxAIGvNQ==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr50355348eds.153.1620907681870;
        Thu, 13 May 2021 05:08:01 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id ga28sm1717809ejc.20.2021.05.13.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:08:01 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v4 03/12] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
Date:   Thu, 13 May 2021 15:07:43 +0300
Message-Id: <20210513120752.90074-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
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

