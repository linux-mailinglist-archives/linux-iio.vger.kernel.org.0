Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885FAC4397
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 00:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfJAWQQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 18:16:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43743 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJAWQQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 18:16:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id u3so11129759lfl.10
        for <linux-iio@vger.kernel.org>; Tue, 01 Oct 2019 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NcxjSm3tMgeBNVOTgE1qRIWOhl7QhTTv2DcpxEKh38=;
        b=D/CG3Rht+qku4CZEJ0QxBi4T1irjqwuI2cu9PM9+6gufZGdv3ArH5nhR3JlU3p0wIe
         q6HESRl0VRDCAlPbGRwrWPebrPhLV+huj5/SfRkiw6FmoG9aCfIkMAjZRyQX0LROXY6n
         /6OS+Xqg8ppliLk0Ujo3jEia46tI++gGgE7JWPC8MkRDhrWDMiasug5AbM4V0AnH57Z4
         6Pg19Me3KK/vg9hlBupqm0uOuHTrW1CQEQOdUZoXfqksC8EL87/nDpmlf0RpSLdXx7Ck
         g4KdZGFCmESpK7dRjNjwwjDUByh2CBazTJJ0mV5Ya8OAGblJttJ2Ull3lz3D8vaDy68c
         +u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NcxjSm3tMgeBNVOTgE1qRIWOhl7QhTTv2DcpxEKh38=;
        b=qNvHrVwQmEdAZ6rw5lPkKaZm+vMWS8UD7jbcJ/Hm9ZdDQsOtZiVgVJfTDoVWHUrODi
         nlZc/zN7qOb/p+aT7OHPUX0bWns7o29lpmpskIBAPeTu2OR66jWb2oa5WLiDP1lFLBLQ
         kgGcnYJdhL9OLn2822NGfEt/PjTelzGwMVknV0Y500eihUTNUFsh5dRl7dtqdpMC7Ksz
         QaLMmzmdf4zt/X+5NDYg2+PtgkjsCTkwnI8MrL8omvfgSsC7O60B3aRZR0YgnOmavlVc
         rAGA8tMXWO6R8n12ZGoMuTnbYIopWzIUvKoh19O2SASi/w+npPSg6JO94ZIT7O8a/o+0
         2+VA==
X-Gm-Message-State: APjAAAWBfjlvu6KsPvcYBDlP6oX41xHEwrgjtxaklYuXT92DbjbgKsMi
        WbqVB64X355aKsyCdhZxLTV1hTEtThqtNg==
X-Google-Smtp-Source: APXvYqwK/sCuED/KxO178zTnTcdCKEbcZwKd6446kBlUCFXdEdUO/lr3n+JHPK5d7VEY2/00fMNMCA==
X-Received: by 2002:a19:cc15:: with SMTP id c21mr14193lfg.64.1569968172923;
        Tue, 01 Oct 2019 15:16:12 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id z14sm4287855ljz.10.2019.10.01.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:16:11 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/7 v3] power: supply: ab8500_fg: convert to IIO ADC
Date:   Wed,  2 Oct 2019 00:13:52 +0200
Message-Id: <20191001221356.19317-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001221356.19317-1-linus.walleij@linaro.org>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
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

