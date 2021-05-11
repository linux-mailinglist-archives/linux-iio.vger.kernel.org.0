Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3716637A098
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEKHTq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhEKHTq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 03:19:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785EC061760
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gx5so28196952ejb.11
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2021 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=sw7IA3puMIZUCEHNi/9LZInTcptD0kkIuSCOJNgIf1DHv0/VOBUca/sjpXjo/3rR3u
         YuCI8JAkzMPgGtTejq3tEfvbPbTp+oxrvOfWmhH+weCE/vX51SL74NCf4972gplf4aOU
         VTwIN6FQHFxix43Z17ovCx8rdeiP9jSCnGXh2MkLnMJe2FxssXOwBmhUOyQ3L9ANuKQl
         Gvu2Iz7kKunrNZroipn1VYNjxtyEeGvJHUDiIsvPU1yva3dCY4Ai3oHuGe9qJmnWLTvb
         yReCqJAW2u6GUN4U4IZNDJOgB3Ka8BccjxvuQXqrKN3pdtugPazj3BPEDt8BASGoG6S9
         gltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkXARO+FVrewyUKtJO4CN2s0umqdJR4fAYNaOAsTCV0=;
        b=Z8hn2tJv74wXKkrJK61fp+v7UsR8unE7CAryT0DV87k0F2czArNEitJ4mPp1YEAU/x
         AOBfLeYFsridYQPaNEqqqK5ZQv+hKDgzMccnjdg+6mscSQQPEzxEgbzSu2FQbz4gE7b9
         5BPUbD4p+Ktya/SPyb2QDqj6kc1qNNGBBG7WoyRwN9BArRARr6aKP5qoz2mjikNW2aBi
         3PqniI4Z8bCuUVTqzPthG3TPAshDLs5bOZ5MnS/d5kQqlv17iSIAxA3s8pSw58JJT8Ra
         lpbCnm7BNAUaLZfhvFtWGOcO84fHwU0/YfQR/K22ABS85Y4tiuXEwjHRKGj/wocu60wy
         ZJ3A==
X-Gm-Message-State: AOAM533hRiE/qaUkZW177iVnEa08DQNqZRBKzae1YgpXzct4KcAnxGmC
        YeA0g9aP6NOt1lRuEP4OGma2HoiC+Oy7Jm3P
X-Google-Smtp-Source: ABdhPJzepc5AHcq7Rr6OJegiCXqwNOmhwBiIycp3MzqQZ6A3yUR4YpZ1jvKxntP5YyR/I5VH/UDd8g==
X-Received: by 2002:a17:906:e118:: with SMTP id gj24mr30587048ejb.205.1620717518423;
        Tue, 11 May 2021 00:18:38 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id i6sm13871558eds.83.2021.05.11.00.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:18:38 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Jonathan.Cameron@huawei.com,
        alexandru.tachici@analog.com, linux@deviqon.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 03/12] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
Date:   Tue, 11 May 2021 10:18:22 +0300
Message-Id: <20210511071831.576145-4-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511071831.576145-1-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
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

