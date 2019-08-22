Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006CE99766
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2019 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbfHVOwr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Aug 2019 10:52:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38175 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387623AbfHVOwr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2019 10:52:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3so5847414lji.5
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2019 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+e29cLfhiMjeHykdyzpXqPfw8Gd7VbkbHyhzBI+wbI=;
        b=YSblNJMLdWs4bkDSe0JBKBRFLNB81wdlh7OgRdPQN886ZHoP73mfFUPbF058E8+n5n
         6NhgnpDUgMsH/MBTZPwReZqjfTglVojNT7VJGbmmX0Y9XaMtLtcXcL+F9B6PXYzmzeX2
         LYKPBD1eVI7o/3pUgXNv6mo1xpof+eMnJBG0BvYFpy0Vcci0nwLIyq5NSVFTnV9kHXP3
         a8M3uQacc1oz12zCRK7ZoBdGJFO5y/2hduzi1Wp2hRfi8HJCGmX4gjRl/Qp1Vz0/3nA2
         zMMHW3xF/s+FhhjghER+vhewWMLRAlTj7iORAwgWbOtiysy6ZRIYqhG+dO/xe3LOHEVp
         7Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+e29cLfhiMjeHykdyzpXqPfw8Gd7VbkbHyhzBI+wbI=;
        b=NuWKcOigYHMhACZNUVjUcRTwEvpOMsQBzj6Pc1UeyknQGpvXx3B4y6D0z1eXV3Mxkf
         Yzp9qfCse8Sa5nal/2eWLLuHBFRSAscTt3jCTfKkuEyYrsF0yV3lfmaodkKD+qLpnL/O
         x7QCdZ/1Q7xJmQxPcyS2o6VRIeLvr+0sT3rlZRPImLMr1Uie05ntvMrjKol/gGME0PVo
         Payx2NGbFqVQhUV/cZFD5Q3yNDHF0CqATGJfWZcfu5gDiTTw7Ky2mSG3H62L+1UO6D21
         tflzlyhaldEEZW2U96cTKQHeq3GTWKCSkWflQIqr1BbCulLg/LxbOpQPgLrIjKAZpOPb
         +8OA==
X-Gm-Message-State: APjAAAUov9ve1UNGSLgrledwDWGKrkLjrmUfxnBiRUHR2WjK/KYYeY6w
        E+Sl/NJvI5jQIp7mQN+aSntJtQ==
X-Google-Smtp-Source: APXvYqzkiLtJ5NZut55On4TWDo5/fIEK43XCTVDmEDizpBgLfXwADApBNQpdYlxiUK6g2Fy6sghLOw==
X-Received: by 2002:a2e:914c:: with SMTP id q12mr15190255ljg.34.1566485565091;
        Thu, 22 Aug 2019 07:52:45 -0700 (PDT)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id s3sm3959374ljj.85.2019.08.22.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:52:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/8 v2] power: supply: ab8500_fg: convert to IIO ADC
Date:   Thu, 22 Aug 2019 16:52:28 +0200
Message-Id: <20190822145233.18222-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822145233.18222-1-linus.walleij@linaro.org>
References: <20190822145233.18222-1-linus.walleij@linaro.org>
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

