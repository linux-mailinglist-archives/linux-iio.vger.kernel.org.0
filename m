Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5199736780C
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 05:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhDVDji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 23:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDVDjh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 23:39:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C6BC06174A;
        Wed, 21 Apr 2021 20:39:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d27so13092676lfv.9;
        Wed, 21 Apr 2021 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP8GAy3QUOP5pLm9gOH29FVZqOy2Igp9fnVns6wgjaQ=;
        b=q2egpGUSEu94r+86jOd+OpqUGzK04O0I5fLB1WqbUDu4FxKzKOLeNJl/cA8xtXCi9K
         YFtt2A4TvrycsV4F3OzOqK8NJkcgvkZBBy5TQFU5NU2/21poX5HlJ0QLnTv0k+br9QtW
         A9Ujl6KgRCUFKARf/f3J+ToDtStEVJrlx0IZG1vH88Hiy8rCjGxp//iC52VHvVbndJIA
         tm/vnOW18Hu07u4vujtHNC4334a/uRXI772JvEknw3zq1R3vHfP9k8qADlCzdtTSQ3sd
         HLcd9FEqxhiil27JUVEGgFozkhg1EEJmGCexyQvmXVs+GrKv6FAjVcEb80bGe89RHg7P
         hRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP8GAy3QUOP5pLm9gOH29FVZqOy2Igp9fnVns6wgjaQ=;
        b=JryrgV+vmn/nqOAMO5meGTHk/zfFn6lfDu4VL2A1svIJzuRSjNZrW7ALlGmrgp3Y/I
         Ud529mFi7abhDQeQFRE0h/EtS3tTL23XfyPZCBENEJqoMDPCynC6uCkyariIixtw7zzW
         2cmurbFQOXkCiTYV2G08DhaXvqv5w7Xr0G/Wjr1ryAUTgGekMvnJQrdn0IJXk04ck5zU
         G06LbngNgxK19IeOWQKh1srmIgnGX+ETRk9jNDBRfHrIMT9HkvMiHlIZUokAzGtYALYJ
         cwhEZb79gSvEo8k4tf8ayEnDrmPpV2o4guCukks928JW62HZZ8edUN05R7N5CqmTAb7e
         T58g==
X-Gm-Message-State: AOAM531HWnHk8xNdkiZHUget5zHjAbCl61yEIvdt2gZGYTcww2nnKn4l
        3+PZNICyz82lslF/5fpEt60=
X-Google-Smtp-Source: ABdhPJy7tt36a/JJ5Zw/e7o7Xg8ZqCkUztIp7TaFICnS93exvuEpR0l1kPDyAywNvxkEtpHnTPPjCQ==
X-Received: by 2002:ac2:5313:: with SMTP id c19mr928963lfh.654.1619062742072;
        Wed, 21 Apr 2021 20:39:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.gmail.com with ESMTPSA id u21sm134227lfc.68.2021.04.21.20.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 20:39:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: gyro: mpu3050: Fix reported temperature value
Date:   Thu, 22 Apr 2021 06:38:41 +0300
Message-Id: <20210422033841.22211-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The raw temperature value is a 16-bit signed integer. The sign casting
is missing in the code, which results in a wrong temperature reported
by userspace tools, fix it.

Cc: stable@vger.kernel.org
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Datasheet: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Asus TF201
Reported-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Andy Shevchenko <Andy.Shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Replaced "signed 16bit integer" wording with "16-bit signed integer",
      replaced "Link" tag with the "Datasheet" and added "Fixes" tag as was
      suggested by Andy Shevchenko.

    - Added r-b from Andy Shevchenko and Linus Walleij.

 drivers/iio/gyro/mpu3050-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ac90be03332a..ce9d1d3687f5 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -272,7 +272,16 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			/* The temperature scaling is (x+23000)/280 Celsius */
+			/*
+			 * The temperature scaling is (x+23000)/280 Celsius,
+			 * where 23000 includes room temperature offset of
+			 * +35C, 280 is the precision scale and x is the 16-bit
+			 * signed integer which corresponds to the temperature
+			 * range of -40C..85C.
+			 *
+			 * Temperature value itself represents temperature of
+			 * the sensor die.
+			 */
 			*val = 23000;
 			return IIO_VAL_INT;
 		default:
@@ -329,7 +338,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 				goto out_read_raw_unlock;
 			}
 
-			*val = be16_to_cpu(raw_val);
+			*val = (s16)be16_to_cpu(raw_val);
 			ret = IIO_VAL_INT;
 
 			goto out_read_raw_unlock;
-- 
2.30.2

