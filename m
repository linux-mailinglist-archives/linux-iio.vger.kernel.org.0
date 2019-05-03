Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAD128C1
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfECH2b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 03:28:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41534 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfECH2a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 03:28:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so2459423pfd.8;
        Fri, 03 May 2019 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whcenm+FX4qRQPz4bN0k/i1kY0g1Fng8zixTNhvTcc0=;
        b=uqQ8gcq1579BJNvE9790OgzNmqf4HWV9M7gwyiq9lHH1omarfHr1jDi+g+jksPJRTH
         H8p1NT3fu+z+GbSYqr+hhhDa1/f3ihBIoxKPQTk//no9j9Ulm/aQsZUfhFq5eG8DvAJB
         i1Ye2+kQTkhgj5DWYza7dP8/XEyVbAVhnAtmtNIZOK5NG4ql9cyjrvjbiTFjE8sUPnGj
         0L6QityL0jphNFqbOwjXQKeRwz3Zl+48b2qAaWnskTorLGa8//i4A6Jbq2L3Nhfaopbc
         XEzgDjcLWPEoZKsHy7Ef0az4f53exQ5zIRIDpsZ3tVIPHDq/YNH+GOnPS0UGSJYb2T9H
         SYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whcenm+FX4qRQPz4bN0k/i1kY0g1Fng8zixTNhvTcc0=;
        b=l/CAHqVewDcKhfkZZmmIFurRLSbIRUEG/S+dVPelC0zsto/suwjsPwH7BtMRYkDzv6
         elrAfN6YnR+foCZRRVr7rwbprhv0VKJYMC1HJ+Vi+jlyjJgJjK51YkJQFaHxTayWXGog
         vil78f6EEKJ6rIcEbO91t8j9grpABh5KUQJlDWyu94Mu+tPUssFpgXATV0UZIgAyx4wZ
         hcuGnZ8D9alFoKhQRhiHSxj4mox7j5ynO9GPORIgB0lyTDYYJTf3idO3th6QscpOUzKt
         ZTNQS9VqA1Itj8pX/vmgmrg4D/xfhs0sDEaUbb0X3OPsNnB85iZC8jSAmSXaGhGQ0htK
         t2bg==
X-Gm-Message-State: APjAAAXRD5g2/qNoA1nM2Bo3oBxJjbKyoSdUvBG5vt6haHu9ply3ZTgS
        vnWxoPv0VKohudC/ukyrWrg=
X-Google-Smtp-Source: APXvYqxWSnuIybJbjilvsuTpxUl/E3mOx1lW2LrSkVylcN9LtF+lbeVXh1tDcp13jE2vVkAUHnpftQ==
X-Received: by 2002:a63:5443:: with SMTP id e3mr8411067pgm.265.1556868509325;
        Fri, 03 May 2019 00:28:29 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id k65sm1744995pfj.141.2019.05.03.00.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:28:28 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/7] iio: adc: sun4i-gpadc: introduce gpadc_enable and gpadc_disable in gpadc_data
Date:   Fri,  3 May 2019 03:28:09 -0400
Message-Id: <20190503072813.2719-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190503072813.2719-1-tiny.windzz@gmail.com>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Different sensors may have different enable and disable functions, so
introduce enable and disable in gpadc_data to support soc specific
function.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 37 ++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index b41ec0d5964d..de6b8556a549 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -49,6 +49,8 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
 	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
 }
 
+struct sun4i_gpadc_iio;
+
 struct gpadc_data {
 	int		temp_offset;
 	int		temp_scale;
@@ -56,10 +58,15 @@ struct gpadc_data {
 	unsigned int	tp_adc_select;
 	unsigned int	(*adc_chan_select)(unsigned int chan);
 	unsigned int	adc_chan_mask;
+	int             (*gpadc_enable)(struct sun4i_gpadc_iio *info);
+	int             (*gpadc_disable)(struct sun4i_gpadc_iio *info);
 	unsigned int    sensor_count;
 	unsigned int    temp_data_base;
 };
 
+static int sun4i_gpadc_disable(struct sun4i_gpadc_iio *info);
+static int sun4i_gpadc_enable(struct sun4i_gpadc_iio *info);
+
 static const struct gpadc_data sun4i_gpadc_data = {
 	.temp_offset = -1932,
 	.temp_scale = 133,
@@ -67,6 +74,8 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.gpadc_enable = sun4i_gpadc_enable,
+	.gpadc_disable = sun4i_gpadc_disable,
 	.sensor_count = 1,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
@@ -78,6 +87,8 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.gpadc_enable = sun4i_gpadc_enable,
+	.gpadc_disable = sun4i_gpadc_disable,
 	.sensor_count = 1,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
@@ -89,6 +100,8 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun6i_gpadc_chan_select,
 	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.gpadc_enable = sun4i_gpadc_enable,
+	.gpadc_disable = sun4i_gpadc_disable,
 	.sensor_count = 1,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
@@ -97,6 +110,8 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_offset = -1662,
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
+	.gpadc_enable = sun4i_gpadc_enable,
+	.gpadc_disable = sun4i_gpadc_disable,
 	.sensor_count = 1,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
@@ -402,10 +417,8 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int sun4i_gpadc_runtime_suspend(struct device *dev)
+static int sun4i_gpadc_disable(struct sun4i_gpadc_iio *info)
 {
-	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
-
 	/* Disable the ADC on IP */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
 	/* Disable temperature sensor on IP */
@@ -414,10 +427,8 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_runtime_resume(struct device *dev)
+static int sun4i_gpadc_enable(struct sun4i_gpadc_iio *info)
 {
-	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
-
 	/* clkin = 6MHz */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
 		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
@@ -435,6 +446,20 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int sun4i_gpadc_runtime_suspend(struct device *dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+
+	return info->data->gpadc_disable(info);
+}
+
+static int sun4i_gpadc_runtime_resume(struct device *dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+
+	return info->data->gpadc_enable(info);
+}
+
 static int sun4i_gpadc_get_temp(void *data, int *temp)
 {
 	struct sun4i_sensor_tzd *tzd = data;
-- 
2.17.1

