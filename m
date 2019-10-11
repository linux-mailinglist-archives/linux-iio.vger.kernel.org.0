Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F88FD39E7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2019 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfJKHSV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Oct 2019 03:18:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43055 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfJKHSU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2019 03:18:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so8730102ljj.10
        for <linux-iio@vger.kernel.org>; Fri, 11 Oct 2019 00:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AoOzbTS/I8Z0E4NBWXmSoTz61V4Js94rj8pJKVKWfg=;
        b=xbV69oJKJ+cupf0HT7FZoZZ6NV7Z6EbkEzDzgCOMtfc2yP5bEpmk98UKJpFUF+QAAb
         zCn6nDPupdIh6irBOUB9BSn/CTpYYqFN6gSEyXUzRDnf8QjCdsCUqMVS+VEatXKuo0M5
         LUC2f0yv5VmONyMZw10WdDrq1e6MnaG+R3IhnqPelNWJKlRVAAr2j6xp1usJSB9YacvQ
         BRCQmYtsyhuIQUx5Lwwe7WpVD+fEVFBAYx/wO6xX79x7zLr/AsMElVVr6eh/RwpcoelA
         GWSSwO1yDOnBQqWHDJ1r8KhvepguXy2jicBlXk/+h9V1iIAwj6y+sEn2cYuFrOQBQuh9
         5Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AoOzbTS/I8Z0E4NBWXmSoTz61V4Js94rj8pJKVKWfg=;
        b=fIb8DbhnhBguq3aOe3ljqIxghv0kBgA/SMaP1GUxo2EfrbW7PmxU2q6viVMpMnc7MP
         beDm2Kxalu/cx4l5YkeD96LlYUEmQ8z580SxKzs6KQQDkWr1rrbWlGG4R2CEM/Ci6wKE
         6fIeQx9UR6R3oNyAqkx0ILrbou/JD+8bxcIQOEPoCYp+Fmd5ur0NMI/KK5rLfMmESk7G
         EbNYu5ojU00ejHf94iYZAIWZymlbmdjlM+CMlCiNxDm/Y79ugvFJIQH96cTheMlEe5OS
         ialcSo9/1uWJaD4mqJn6kGj/t4zER7wb2Fl8VDE5CGhorlphaW5M38MFcVnL2m3pm3mZ
         6mHg==
X-Gm-Message-State: APjAAAVIu9BvC+rL9DqIl8cm3MoNuHzJ/V1mcRFBf8FoZWVwRhmhXogG
        7Gw8lzG+/lJE/wnBmr7A8Up7Vg==
X-Google-Smtp-Source: APXvYqwYsJXQkW/NEG27jlzH3t1dm91MD1ppwdonQ0/5cca2AGfVEV0cJ7b94zve8Ae0g0NfiV7rJA==
X-Received: by 2002:a2e:b4f7:: with SMTP id s23mr8045402ljm.111.1570778298644;
        Fri, 11 Oct 2019 00:18:18 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v26sm2047343lfg.27.2019.10.11.00.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:18:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/7 v4] power: supply: ab8500_fg: convert to IIO ADC
Date:   Fri, 11 Oct 2019 09:18:01 +0200
Message-Id: <20191011071805.5554-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011071805.5554-1-linus.walleij@linaro.org>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This switches the AB8500 fuel gauge driver to using
the standard IIO ADC channel lookup and conversion routines.

Acked-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- No changes just resending
ChangeLog v2->v3:
- Rebased on v5.4-rc1
ChangeLog v1->v2:
- Collected ACKs.
- Rebased on v5.3-rc5
- Fixed some whitespace issues

This will be applied along with the other changes in ARM
SoC and should not be applied to the power tree right now.
---
 drivers/power/supply/ab8500_fg.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 6fc4bc30644c..f7909dfd3b61 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -32,7 +32,7 @@
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
-#include <linux/mfd/abx500/ab8500-gpadc.h>
+#include <linux/iio/consumer.h>
 #include <linux/kernel.h>
 
 #define MILLI_TO_MICRO			1000
@@ -182,7 +182,7 @@ struct inst_curr_result_list {
  * @bat_cap:		Structure for battery capacity specific parameters
  * @avg_cap:		Average capacity filter
  * @parent:		Pointer to the struct ab8500
- * @gpadc:		Pointer to the struct gpadc
+ * @main_bat_v:		ADC channel for the main battery voltage
  * @bm:           	Platform specific battery management information
  * @fg_psy:		Structure that holds the FG specific battery properties
  * @fg_wq:		Work queue for running the FG algorithm
@@ -224,7 +224,7 @@ struct ab8500_fg {
 	struct ab8500_fg_battery_capacity bat_cap;
 	struct ab8500_fg_avg_cap avg_cap;
 	struct ab8500 *parent;
-	struct ab8500_gpadc *gpadc;
+	struct iio_channel *main_bat_v;
 	struct abx500_bm_data *bm;
 	struct power_supply *fg_psy;
 	struct workqueue_struct *fg_wq;
@@ -829,13 +829,13 @@ static void ab8500_fg_acc_cur_work(struct work_struct *work)
  */
 static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
 {
-	int vbat;
+	int vbat, ret;
 	static int prev;
 
-	vbat = ab8500_gpadc_convert(di->gpadc, MAIN_BAT_V);
-	if (vbat < 0) {
+	ret = iio_read_channel_processed(di->main_bat_v, &vbat);
+	if (ret < 0) {
 		dev_err(di->dev,
-			"%s gpadc conversion failed, using previous value\n",
+			"%s ADC conversion failed, using previous value\n",
 			__func__);
 		return prev;
 	}
@@ -3066,7 +3066,14 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* get parent data */
 	di->dev = &pdev->dev;
 	di->parent = dev_get_drvdata(pdev->dev.parent);
-	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
+
+	di->main_bat_v = devm_iio_channel_get(&pdev->dev, "main_bat_v");
+	if (IS_ERR(di->main_bat_v)) {
+		if (PTR_ERR(di->main_bat_v) == -ENODEV)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "failed to get main battery ADC channel\n");
+		return PTR_ERR(di->main_bat_v);
+	}
 
 	psy_cfg.supplied_to = supply_interface;
 	psy_cfg.num_supplicants = ARRAY_SIZE(supply_interface);
-- 
2.21.0

