Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35E3BAF56
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhGDWYz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 18:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDWYz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jul 2021 18:24:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D93C061574
        for <linux-iio@vger.kernel.org>; Sun,  4 Jul 2021 15:22:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n14so28957136lfu.8
        for <linux-iio@vger.kernel.org>; Sun, 04 Jul 2021 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIgfPGD+tV2hDnlwBMsRnKbGLk72fe5p5gonuG9NrgY=;
        b=LYIInXvk1g7Vho38azwq9nH+uJyZTZApog+bPZC/4wMuv/B9KOAbde8qpxl9g35usA
         T/vNrUnP6ksQmxTPtjg4LQvSOb1Z7SmnnRRJS9pyC2sZCkSKoI9PyTs4M535LEFhvd+K
         kBOvVYc9fD4zcKHlb4zFaUNflP/OBQCCwnLi/Tgho2PmAA+F3Wk36lCmndouk4f2mmiE
         s13IBG4bY1w9KhrDPzZwuXrV6jAnrLx/yXb/RdGm4cBhVgZzJwCCnZhDCeYPc6VwrGUT
         AM3LXthTK63RjfAWZRG/eEzYcSug3aYhwC36H6bpYqorSRu59lWtwmEb+4aoxH3ueIEe
         UdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIgfPGD+tV2hDnlwBMsRnKbGLk72fe5p5gonuG9NrgY=;
        b=MtlWCrid8/pfpwEox62Ectekzh7gCweBFKxLkd8VZaIVb/QQ59uH2T7H6AiFKVozAF
         MeiIfzWiQ+1Ek7Zka7WGYlG2eGD86z8jluY+oFDWgE5YL6U/9Z2bZZ5xjf8iF4wcWvfn
         NrxN6awg2TDCsAYSLlJv6dCsMwhqz7uIn6arEkz7LmJtzhTB4Rh0rHPaq5MO51+y8RXb
         jFNz6dKApJgDqNQ8Wmc+wD9kcFNxQnLO76O+V7csSgfVkGGHKg1TWxJGNW9CBt7KsLWi
         /eMaHFhCuONHxtPnCdonTYg+JfBJkkuHtWd1J8NmhAzym2caWKWG96Ew7VTsLMklDm54
         By7A==
X-Gm-Message-State: AOAM530wlzH5rEfmHmS4cuQDDKPJa3WN+FllPvmurWR1+q4aue5eUzch
        WFolaFZ50q463XQWY4PL2czBXg==
X-Google-Smtp-Source: ABdhPJxb+Tq3/1EIUgPHv+xFFi9Goby3bmNcjLuba3bawuP5/4FpLMNXCx5ngBT6RTp//BiHDKnsSw==
X-Received: by 2002:ac2:4208:: with SMTP id y8mr8014856lfh.27.1625437336900;
        Sun, 04 Jul 2021 15:22:16 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id k2sm897495lfb.214.2021.07.04.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:22:16 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2] hwmon: (ntc_thermistor): Use library interpolation
Date:   Mon,  5 Jul 2021 00:20:14 +0200
Message-Id: <20210704222014.12058-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The kernel has a helper function for linear interpolation so
use it. It incidentally makes the code easier to read as well.

Tested on the ST-Ericsson HREFv60plus hardware reference design
with two thermistors forming a thermal zone.

Cc: Peter Rosin <peda@axentia.se>
Cc: Chris Lesiak <chris.lesiak@licor.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop the check for low == high as the linear interpolation
  library function does this for us.
- Multiply the temperatures in the table with 1000 *before*
  interpolating instead of *after* so we increase precision
  in the interpolation.
---
 drivers/hwmon/ntc_thermistor.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 8587189c7f15..4c26db6738f9 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/fixp-arith.h>
 
 #include <linux/platform_data/ntc_thermistor.h>
 
@@ -553,15 +554,16 @@ static int get_temp_mc(struct ntc_data *data, unsigned int ohm)
 	int temp;
 
 	lookup_comp(data, ohm, &low, &high);
-	if (low == high) {
-		/* Unable to use linear approximation */
-		temp = data->comp[low].temp_c * 1000;
-	} else {
-		temp = data->comp[low].temp_c * 1000 +
-			((data->comp[high].temp_c - data->comp[low].temp_c) *
-			 1000 * ((int)ohm - (int)data->comp[low].ohm)) /
-			((int)data->comp[high].ohm - (int)data->comp[low].ohm);
-	}
+	/*
+	 * First multiplying the table temperatures with 1000 to get to
+	 * millicentigrades (which is what we want) and then interpolating
+	 * will give the best precision.
+	 */
+	temp = fixp_linear_interpolate(data->comp[low].ohm,
+				       data->comp[low].temp_c * 1000,
+				       data->comp[high].ohm,
+				       data->comp[high].temp_c * 1000,
+				       ohm);
 	return temp;
 }
 
-- 
2.31.1

