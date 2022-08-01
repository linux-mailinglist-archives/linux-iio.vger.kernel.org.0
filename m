Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2F587343
	for <lists+linux-iio@lfdr.de>; Mon,  1 Aug 2022 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbiHAV02 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Aug 2022 17:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiHAVZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Aug 2022 17:25:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AD48CB4
        for <linux-iio@vger.kernel.org>; Mon,  1 Aug 2022 14:24:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r128-20020a1c4486000000b003a3a22178beso37365wma.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Aug 2022 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kR3Ri+u8MrlBR31H9vhYMnYhYm+SNLRNtOs1Gp5xhCw=;
        b=xh8Gu6CxZR+eHCxOmg5DvWBOkqxPXW8WLgkpaNchDUH5lQyH7yxJcrq5lgw85+W7VH
         RIbvm50Fu7/2MYWwdSa19QbfmT6UphVTPkuOnjmQGh3SZkccXDK4vW80VyV7h3WRJTSo
         VQutQv0Y4cr81PHha3zpny1JbqRcIXXcbBXk/sx6YgKgp0aDX2oULlAeBZX0yFw8dkcP
         xBf3RXZBss3INtEoO4bZQWBYSslKyoxDehwFDEeWsXMgaTemsPEqdW8Xl43of9/Gsxtq
         AqoL+V/lNNNQEePgCMo/Ux/avVQ1Dah5/+B4qr/uS3PjTQ/cpLcOJ9iqk8CBHCrVLvtt
         xJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kR3Ri+u8MrlBR31H9vhYMnYhYm+SNLRNtOs1Gp5xhCw=;
        b=je8yIsN02s9svI8vEIBqysKogRkEvoqx7uklVLKKL/NjEF9/AqhtRcAgVv6fdq7kCj
         P6KDcqw62RFpIr4DQKnqvn3G98vKF7vH8SDskRlId55o1BzFmYX6sugb32A5Tw2DDUnH
         KJbHijtp6ygqgByBmxhZIJn/YLZrPqTtYF82Tpm3+p3aXuGXbinbUDijx53FU8dquzKA
         NBsA5+HWCFLD+mAklmF7Zrmcz9As9i4WuD/Xf0Wpq9AP7NVN9KxIma3n7LRbyqCw0gb3
         9QUKWBYCGo/GK3mXMI8od0bGAd7wti4THxeLjJZs/YlHTLxC9UEtjQIeXy6KZDwVwBHg
         gR9w==
X-Gm-Message-State: AJIora/++Tr/2XynDf7bn/S90G6SbJti8TWmGN4646lbjNAy4Xtz9p26
        gVJhjUU9MW4DVoa6elUwy/GVyA==
X-Google-Smtp-Source: AGRyM1uV5KV0eIULjdt945RlfJzhs3wIx8I+n5plQIxUxm/0jmON2cpIRB7uDxXgLbFNdilwVjimiQ==
X-Received: by 2002:a7b:c8da:0:b0:3a2:ffd2:8059 with SMTP id f26-20020a7bc8da000000b003a2ffd28059mr12277872wml.169.1659389049153;
        Mon, 01 Aug 2022 14:24:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:24:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v4 27/32] iio/drivers/sun4i_gpadc: Switch to new of thermal API
Date:   Mon,  1 Aug 2022 23:22:39 +0200
Message-Id: <20220801212244.1124867-28-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..13d1e937357c 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -412,9 +412,9 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_get_temp(void *data, int *temp)
+static int sun4i_gpadc_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sun4i_gpadc_iio *info = data;
+	struct sun4i_gpadc_iio *info = tz->devdata;
 	int val, scale, offset;
 
 	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
@@ -428,7 +428,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+static const struct thermal_zone_device_ops sun4i_ts_tz_ops = {
 	.get_temp = &sun4i_gpadc_get_temp,
 };
 
@@ -637,9 +637,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
+		info->tzd = thermal_of_zone_register(info->sensor_device,
+						     0, info,
+						     &sun4i_ts_tz_ops);
 		/*
 		 * Do not fail driver probing when failing to register in
 		 * thermal because no thermal DT node is found.
-- 
2.25.1

