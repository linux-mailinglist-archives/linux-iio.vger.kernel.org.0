Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1AE388306
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 01:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhERXTj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbhERXTj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 19:19:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF8C06175F
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j10so16207175lfb.12
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6DpMHKPug9B2DwYGCJdZ2qYD2R7VRxLe67GA8SNIzs=;
        b=A613ngQ/EbeIWDBDaA6YmXbFt3LA06f/swAd7ZCJCNRyILVbrJNY0yKKQBGZopXDzA
         jHPjiDvmk1fAi286LWNDzAebqdKD+DvI5LoQsSZAlZzhbr2yvdkXWNMsKbczntUoQQVv
         SnYtFtp7FluO5W/Yiw1rpjp2wfUG+mGp6eP8dFvOyq6GlFTIBs7mQot4eNxD7KjXl+rc
         6uzX7B9qvcug70o76H1Zc0Ry+U2NkCSTcBt4RefgEwGOVvmJ6wiHoMwLZq38yidkdarK
         fSV9USqwQQvsZVrRi/jUejnj1Y9on5W7BuzUtPfgb9bJn9AiDwAlBEstVe4QjCYKZSoV
         X28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6DpMHKPug9B2DwYGCJdZ2qYD2R7VRxLe67GA8SNIzs=;
        b=EihpKGd3s1lhEAH2PDLu1qk3Qt/8v4Bxy31aDYCRcWVGamh+YU9KCGhB8pY61Rt9tC
         csLhfmKH29RMzFnjd2kKOdjFP86Y9N8CnwJKI+kQog9gBIGRqLfeMpGrOlfp21TCtYxw
         4KDIDAmQYaVsanDt/za1KGnCiQiGiHogV07flx2qbPGKERjp5cJUuaIx9bfdtm1sf7Q3
         /3Swi97k72sQQ/1kLxayJ4CZ/HLtaeYW3M9pxvOqt7AuEmRRblUXZA7F9M1jyRCG0foB
         8dVsCiZCJD4kezeZY3D04tLDFR6KCeYcJ2KLhpkr9S3dwQoLbkj6bXV8wxFtzB6jP4Y7
         cZUQ==
X-Gm-Message-State: AOAM5307pWqm37wgmx5+GmKmV/pi//A570WFXH9/E4sPeA5pvT/TCBQs
        /WYUeqRIXtG6fGCZJFEyDVW7vw==
X-Google-Smtp-Source: ABdhPJwdlbXpYO+3KxlUsSBtj2Ciq6dOyJ8wgNDAIrfjWByuKUlX9sgm1I0GqukCzh0j/ITeXTFmDQ==
X-Received: by 2002:a05:6512:3156:: with SMTP id s22mr5812776lfi.362.1621379898957;
        Tue, 18 May 2021 16:18:18 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d10sm1666392lfi.79.2021.05.18.16.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:18:18 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 3/5 v3] iio: accel: st_sensors: Stop copying channels
Date:   Wed, 19 May 2021 01:07:20 +0200
Message-Id: <20210518230722.522446-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518230722.522446-1-linus.walleij@linaro.org>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The channels were copied only so that the .ext_info member should become
assignable. We now have compile-time static assignment so drop this code.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase on the other changes.
ChangeLog v1->v2:
- Improvement found by Stephan.
---
 drivers/iio/accel/st_accel_core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 9abcebf767b1..28fceac9f2f6 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1339,8 +1339,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata = dev_get_platdata(adata->dev);
-	struct iio_chan_spec *channels;
-	size_t channels_size;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1351,15 +1349,9 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 		return err;
 
 	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
+	indio_dev->channels = adata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
-	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
-	channels = devm_kmemdup(&indio_dev->dev,
-				adata->sensor_settings->ch,
-				channels_size, GFP_KERNEL);
-	if (!channels)
-		return -ENOMEM;
-
 	/*
 	 * First try specific ACPI methods to retrieve orientation then try the
 	 * generic function.
@@ -1371,7 +1363,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 			return err;
 	}
 
-	indio_dev->channels = channels;
 	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
-- 
2.31.1

