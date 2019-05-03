Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B3128D0
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 09:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfECH22 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 03:28:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44200 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfECH21 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 03:28:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so2301601pgv.11;
        Fri, 03 May 2019 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QLNyKddzGBEfp0X3sV4+rgzmKK42NUUFMJfNDuQuMZg=;
        b=HUBwzSUDq0jDdXV/2VzXw7i6CoA6g+3k9UoxZE+/peYTUL5RV/MWJwWTUZLI+JHg5a
         5Kl3MkEyY6LOhvGBMsibYXdsnzwZG6Dg87r5DB4jPKH9mpV8RZbqt1Phi+nw2ZFDsvyZ
         Vh8TJfGFzonSqQmdBHy7e2hPmG4Sv8ZhIpF6MjWAdm3oKKsAg+hnqi1orjTYhUK8UDv7
         oImpuPBod/YgpaKNor5Pl9V+mLc4dEkdyw1kiYsj706wTXLU+2DDbV+6vK13kVpiNomy
         CtPo/Tfi8ySWD6unN/7oqY98b1K0D6n8IHOCkat6tccm/9NoT/1dwjDh7ttlBtppF06z
         bsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QLNyKddzGBEfp0X3sV4+rgzmKK42NUUFMJfNDuQuMZg=;
        b=kBXSsqIxYd4ufuZkeMi/snzfL2oZ2tPXBVnMIrykjAnR4fCRZA3zmv9WbJQBFOgP4M
         kbfmORHQ4ISSV66QpGBdJef4j0Zg1nwIw5IHCFIEEiVCKTYjLKNka9GptF7yX3U4V9uY
         zW1F9K2taz888CvKhtGi1ZiVo1ZBIVf7AAQm3EjzUzuVzU/GPj66poNRu3P20hF3YXeF
         YAak6Fjhj8py1hcKNnFUGhxafZj6IODp65HgilyLpt2bf816lWpXujH5n6gpt/VgTeKV
         DRzPZjlwqfl+6yUL1OGRqkSncOdLxT2ezFlUBwU7aUklXcsHb1gIvVWJ3ynHn+B8v1XV
         qoTg==
X-Gm-Message-State: APjAAAVCkTPSz9ChIUhU0QCr856asVCMiM6yOJ9yI6iosvw4bjKpxMLt
        zdL7L/ZJkTPzqIy/kPPJeIA=
X-Google-Smtp-Source: APXvYqxstsfZoFavy9Cx50OVX7G6q9TfajFvKAS3Md5IR7ON1JQDSSu/k8UeT2nXNlUFGWl9cPi9qg==
X-Received: by 2002:a65:6295:: with SMTP id f21mr8626731pgv.129.1556868506538;
        Fri, 03 May 2019 00:28:26 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i3sm1594564pgl.57.2019.05.03.00.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:28:25 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/7] iio: adc: sun4i-gpadc: introduce temp_data in gpadc_data
Date:   Fri,  3 May 2019 03:28:08 -0400
Message-Id: <20190503072813.2719-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190503072813.2719-1-tiny.windzz@gmail.com>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For some SOCs, the temperature data register start address may be
different, so introduce temp_data in gpadc_data.

Also modify read temperature to support multiple sensor.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 844fd52bd22f..b41ec0d5964d 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -57,6 +57,7 @@ struct gpadc_data {
 	unsigned int	(*adc_chan_select)(unsigned int chan);
 	unsigned int	adc_chan_mask;
 	unsigned int    sensor_count;
+	unsigned int    temp_data_base;
 };
 
 static const struct gpadc_data sun4i_gpadc_data = {
@@ -67,6 +68,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
 	.sensor_count = 1,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -77,6 +79,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
 	.sensor_count = 1,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -87,6 +90,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.adc_chan_select = &sun6i_gpadc_chan_select,
 	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
 	.sensor_count = 1,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
@@ -94,6 +98,7 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
 	.sensor_count = 1,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 struct sun4i_sensor_tzd {
@@ -291,7 +296,8 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val,
 	if (info->no_irq) {
 		pm_runtime_get_sync(indio_dev->dev.parent);
 
-		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+		regmap_read(info->regmap, info->data->temp_data_base +
+			    0x4 * sensor, val);
 
 		pm_runtime_mark_last_busy(indio_dev->dev.parent);
 		pm_runtime_put_autosuspend(indio_dev->dev.parent);
-- 
2.17.1

