Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111D8128D3
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfECH2f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 03:28:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37767 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfECH2c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 03:28:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so2468451pfi.4;
        Fri, 03 May 2019 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gVZ2hqRXWtLcmOTx5ox6LNbjK3xqtyJ5f5GpEMyudKg=;
        b=g73z3cy3M5ok9jIYuhXWrFWMx1XV6tg1I96a9U9izJ/ZS0IWD229f2w8WplFIuQ1QR
         z2sE3omVPJOieDsXIilbDHaJGWfHRJXc7IXO6oqkUVAkyliKINFiJ/EDxuIMwRj+fDzP
         vQyy6nPLc18A4IlRduGPKz7ckOUAyTMyzTgf7nhGwuxYzDcoOsPD4gtVuTTyt9sK5Up+
         BCExGq0YQSE3V1KBUnH/EPE6w0kk6n14uhBps4LblIH6UJOfo8KaN6/poYqlHUhKi3ut
         7xtfpZt4Zf6rClEiUyDiAU2bs8MVV5G6/85BgWR7fUoaPIcLvWZdOAucVHkkC5AWFquy
         Tc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gVZ2hqRXWtLcmOTx5ox6LNbjK3xqtyJ5f5GpEMyudKg=;
        b=nCrSVoQUggjfMlCHdEQsYK8oCs9zUNOzw4tokheUzCnfj1aLCvgLeeyRWSbmu0Aojx
         RBJoH20FHxBamiWFoC9cCrrRrQ+1alzjPQ23SG/mIaGuC7qVu15VT02DNcjibTdWnitV
         S9dsQNpd9K9giTOrwugB5dnY6Qd3p57VoajZuFG/uO2Xo0c/hVJKYEsGNr9AVYinJ5dM
         KbJn0YkPoPOaDNzGhdTMeAqUpOGkhvzDp4dYl8Ic74LVdPHRyiMuQ2Jncd/2IRQ86hnB
         AVj4wnR8kWtUMQLx0tJQTn3yQ7mHibo6tm0dTE1QPdZUhNdnXhtdVaiiYVTA76kIJTzD
         GDdQ==
X-Gm-Message-State: APjAAAVltKFrZgYym3JSXMN1CIjbuWyAQ+e8CXPXi36BB8P7vly6rNYU
        QXSow+ur6AZardxxey8oJts=
X-Google-Smtp-Source: APXvYqxYc5VWDFUgbHShXTIGD8SRCAC8A5n0VEfy+lTVDjkOMeSveLaECAOjNbh8qqWfEAyLHZWVdQ==
X-Received: by 2002:a62:4602:: with SMTP id t2mr8912629pfa.26.1556868511886;
        Fri, 03 May 2019 00:28:31 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q5sm1877338pfb.51.2019.05.03.00.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:28:31 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/7] iio: adc: sun4i-gpadc-iio: support clocks and reset
Date:   Fri,  3 May 2019 03:28:10 -0400
Message-Id: <20190503072813.2719-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190503072813.2719-1-tiny.windzz@gmail.com>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

H6 has bus clock and a reset, so introduce something in
gpadc_data/sun4i_gpadc_iio and adds the process of the
clocks and resets.

This is pre-work for supprt it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 32 +++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index de6b8556a549..f24eb76d65c0 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -22,6 +22,7 @@
  * shutdown for not being used.
  */
 
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -31,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/delay.h>
 
@@ -52,6 +54,8 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
 struct sun4i_gpadc_iio;
 
 struct gpadc_data {
+	bool            has_bus_clk;
+	bool            has_bus_rst;
 	int		temp_offset;
 	int		temp_scale;
 	unsigned int	tp_mode_en;
@@ -140,6 +144,8 @@ struct sun4i_gpadc_iio {
 	struct mutex			mutex;
 	struct sun4i_sensor_tzd         tzds[MAX_SENSOR_COUNT];
 	struct device			*sensor_device;
+	struct clk                      *bus_clk;
+	struct reset_control            *reset;
 };
 
 #define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
@@ -564,14 +570,36 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					     &sun4i_gpadc_regmap_config);
+	if (info->data->has_bus_clk)
+		info->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus",
+							 base,
+						&sun4i_gpadc_regmap_config);
+	else
+		info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+						&sun4i_gpadc_regmap_config);
+
 	if (IS_ERR(info->regmap)) {
 		ret = PTR_ERR(info->regmap);
 		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
 		return ret;
 	}
 
+	if (info->data->has_bus_rst) {
+		info->reset = devm_reset_control_get(&pdev->dev, "bus");
+		if (IS_ERR(info->reset)) {
+			ret = PTR_ERR(info->reset);
+			return ret;
+		}
+	}
+
+	if (info->data->has_bus_clk) {
+		info->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(info->bus_clk)) {
+			ret = PTR_ERR(info->bus_clk);
+			return ret;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_THERMAL_OF))
 		info->sensor_device = &pdev->dev;
 
-- 
2.17.1

