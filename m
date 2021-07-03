Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C283BA9EF
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 20:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhGCSGL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhGCSGK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 14:06:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB20C061764
        for <linux-iio@vger.kernel.org>; Sat,  3 Jul 2021 11:03:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c28so970635lfp.11
        for <linux-iio@vger.kernel.org>; Sat, 03 Jul 2021 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkG7FoGck9kTQYYCK9VBgV6NTpLq1d+LGAixBAuDGEQ=;
        b=Mgw4GqLUtxNo3IQGhg1g7nl0lJmGt/3FvFengwHC591qG1nvPVoix8DbTBifbHU/KP
         d+jqx5eaGYQt4HrKXz6Fla3i3Ho0JylSwWUz7cdsdpLUVR28U5Ug7IkkcCZbqyTvlsv0
         QkHvN9j+NeVl3T/TPY6g7mAF89RPV8u2/FVFyCZlttQewCgA79j8ONXYutDrSSJZHQTJ
         jOtRSR0bOxtnlNaP3nFyrDpjkpnifD7PcdOR5dIs637HqJYfMw6rc8VDRw0GU1XuCcrd
         Vt4J4F/XDAG2ST5s2DIspOzuGbWZDO0ZxtgpP6nksLwy4umZ8SR787uzJN15EnXsUUf+
         /Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkG7FoGck9kTQYYCK9VBgV6NTpLq1d+LGAixBAuDGEQ=;
        b=C9BKgiqxKyMzGi7h4fFCJTEYxUzP5LrLx8zywHxGOQVQz8eSQgovpCwdKe5j6Scq3Z
         VYaiS4E6ZJOMSucISXsXsvRUww/AU95AeRXNGr2YGZPU+LkVOiCPOUgglr+nzCcoEBDU
         Avk9njjop3rIz8d6WKUycWKn8wom1A5vblhknwSvX3ejTI5v76eRsSjRU42+oZzT+AIo
         7WnhXDXiF3EUBxOdTD7K+Ttu90NrfIEdr7ZjHyzQfMUq634Cb2LULrEPB3SocVKAx5aC
         fSwJX2rjhaGCdqmjFEVQ6xR4pLLet6HXhJGK/aao2w9O3uN624nv0tHGvzQoZaqzV9mU
         XR/Q==
X-Gm-Message-State: AOAM531ryjx+BIROVnDdyo7J3UWCU3L1NdKlD9rsOmZLWWGNpdxdLLJL
        3ljmRph7rSuS1N/OLM94r+KbFg==
X-Google-Smtp-Source: ABdhPJy7bqqI0Hue0UbrUieyCUVG0NR1+PQEG/tbPWotbqHgrLAdPgsRYqPzlP3zL6h7KACLfeMUSg==
X-Received: by 2002:a05:6512:1582:: with SMTP id bp2mr4192696lfb.483.1625335414009;
        Sat, 03 Jul 2021 11:03:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm594232lfg.148.2021.07.03.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 11:03:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH] hwmon: (ntc_thermistor): Use library interpolation
Date:   Sat,  3 Jul 2021 20:01:31 +0200
Message-Id: <20210703180131.4036589-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The kernel has a helper function for linear interpolation so
use it. It incidentally makes the code easier to read as well.

Cc: Peter Rosin <peda@axentia.se>
Cc: Chris Lesiak <chris.lesiak@licor.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/hwmon/ntc_thermistor.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 8587189c7f15..61bd0e074ec9 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/fixp-arith.h>
 
 #include <linux/platform_data/ntc_thermistor.h>
 
@@ -557,10 +558,12 @@ static int get_temp_mc(struct ntc_data *data, unsigned int ohm)
 		/* Unable to use linear approximation */
 		temp = data->comp[low].temp_c * 1000;
 	} else {
-		temp = data->comp[low].temp_c * 1000 +
-			((data->comp[high].temp_c - data->comp[low].temp_c) *
-			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
-			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
+		temp = fixp_linear_interpolate(data->comp[low].ohm,
+					       data->comp[low].temp_c,
+					       data->comp[high].ohm,
+					       data->comp[high].temp_c,
+					       ohm);
+		temp *= 1000;
 	}
 	return temp;
 }
-- 
2.31.1

