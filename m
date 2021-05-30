Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F428394EC8
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhE3BBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhE3BBL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FAC061574;
        Sat, 29 May 2021 17:59:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j189so8019916qkf.2;
        Sat, 29 May 2021 17:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlSUd8hLaQ5pXUy/E5mVG/A68UWC8P1PCn0hYHkKFIk=;
        b=A+FgbGJozU7aXXrBHhVe+n+45sSRYoMC23Z6HNY4dCcDBYEjE2s7lqkODBMwR/oXgq
         CdYcCljGwvR+pFGrCOz0r2tdMvpc7lN/pkH3GIb/SnKd9VbdIDdSvviuqprud7et3yR/
         qWrX/FTTyqIaLz5PUttZeh5LBkdin2Cf7tlR+4eylB5xhKoHTgT0hbSZQxjkYoHf+BtM
         scWlBCqEYijJ8vIFj3FKcMdofrbdZJzxlNkR5XIQ0CVy9VnPcLLItqw6GQ9pTe1MMUBc
         WekbkN/8oOZrlgzD3M58P33VxWgq+/FK++8hGuJHnTQ0D6BOBImjMK0ehL+RYV+Gu2Lv
         qquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlSUd8hLaQ5pXUy/E5mVG/A68UWC8P1PCn0hYHkKFIk=;
        b=HsEXDgrSzXLvnx075t/z/mTRV8xU61X5jKVmx/D6I1iaazoiN5pL06uekBr4StaCWo
         QWVK7bS/wwyrdC6+JE9eM87Fzj9JhpqN2BROTkk5BNg0CTFRaTdD+L4aBxVMRl6RaaHq
         1stoJMlYYSNYf6skNPuSlk1AhGNzJVIUGu0egr/Jmpx/1cdRZ2p8BmJXh/Ul3o/ArYKw
         wr5X1QkfG5MPhB58CMv7idxik1fqzAGw8Nkt6WvnV66UcWu8CWa0cBTfjdDdLUox3qYv
         wH9Y42oY1e2yLLuMhZS64AOvv+bAYpPDK+WOs0xMSfoIisZG4xezqcrmYN6M3R9bz9os
         yHYg==
X-Gm-Message-State: AOAM5309mC3IvW+xJ3XED942Eu9vUuu2HYo2jZednwPrfAVNsEE5l18h
        2s2/aw1gA2TYUo5rrLl9tdP2dJI58H3PmQ==
X-Google-Smtp-Source: ABdhPJzFKdhiDHhxoTFlkGy/XivhwSTACmBJNp4u4GvdLGnDGRgHZcUKNgGdh+FSji4RQ3+P9jVLLA==
X-Received: by 2002:a37:b6c4:: with SMTP id g187mr10648500qkf.491.1622336371987;
        Sat, 29 May 2021 17:59:31 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:31 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 4/9] iio: afe: rescale: add offset support
Date:   Sat, 29 May 2021 20:59:12 -0400
Message-Id: <20210530005917.20953-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

This is a preparatory change required for the addition of temperature
sensing front ends.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 4d0813b274d1..3bd1f11f21db 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -31,6 +31,7 @@ struct rescale {
 	struct iio_chan_spec_ext_info *ext_info;
 	s32 numerator;
 	s32 denominator;
+	s32 offset;
 };
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
@@ -52,6 +53,10 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		*val2 = rescale->denominator;
 
 		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = rescale->offset;
+
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -119,8 +124,10 @@ static int rescale_configure_channel(struct device *dev,
 		return -EINVAL;
 	}
 
-	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE);
+	chan->info_mask_separate =
+		BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET);
 
 	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
 		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
@@ -280,6 +287,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
-- 
2.30.1.489.g328c10930387

