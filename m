Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD84386DC1
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 01:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhEQXkI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbhEQXkH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 19:40:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E89DC061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:38:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z13so11298908lft.1
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ns0IeTXIw3KSjl4Ix5g2K8C3nNLeIG8gC2PZ6mGVwaE=;
        b=h76lCMFB0fwGQEiFoBjnk+nh8kzMCpD20iyPbp0TOKo7YQZzJp3IXibjPqHAP+GznE
         Jp6QYUmAxrDSh7faWZlECaQjJG7Z858mlVIrEDgxq3ahJE9SAA0nzFuJibyhvLSoAxbw
         PQsy+Mi1/1rIdo6/32tsgvRAn1sNe4PAIFx+RejvXneTy0fDaO+VjF17HSlPmz4KU2K7
         PHbBbLEpvVEMAS0BvZklhuvBysrD0KewzONiZMtlrhuSJj7SZDoec6nFgM9ZJ0C72OIG
         GZRIkzY5uUxu2C6jXu2ryDC4MGKAWl605eonKKcLuI++lyZ7JVC1cSyIOCfG/Zh3xkpL
         fhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ns0IeTXIw3KSjl4Ix5g2K8C3nNLeIG8gC2PZ6mGVwaE=;
        b=ZPxP/SvTXqrkf8VNWioIPyFStyY4cHccD9lBdfxUEQiW85t28jOGifa/bHZcrh5tPU
         /Dk2ZNR4N+42AdsRR8STXCssrWDXvknev8Hg/0CY0xVhDI/Tl5YB7sela3khGnbEpGNk
         zQ5VzYTXxtd2o2B5JzDs6bxGSEfMSXsJCLIi/WDgx2m/oQD7HxY7O42V/8wE8T+HVoul
         v1X6JGWYihcHCBafXVzHisHVZ3+coszMUycNDa/tt3BwoQmSSx6I0VuhoUcu4WLWXSkI
         Sk+IjHkJHUt20EtQTRlxBV8XX2fF2Jx6vUNbPr2BrJx6iY8Ufs2+ppIdZ5D1GQkteRVb
         sQhQ==
X-Gm-Message-State: AOAM532olKR1V4A1EbZyPRCjDcR5d+2m+lTaEAFbYwZsD73zdC9PYHq8
        WavDKi2p5IE56uGV/LzRpVrI/w==
X-Google-Smtp-Source: ABdhPJxPdMYFgqSS9vptOlUmpiVPp8/iWXjiIN5pLUQEXl+KzNTBvpxU9SAEYr0TVP2Fapnp6e1aSg==
X-Received: by 2002:ac2:546b:: with SMTP id e11mr1646748lfn.395.1621294729132;
        Mon, 17 May 2021 16:38:49 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r10sm168425lfe.110.2021.05.17.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:38:48 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 4/5 v2] iio: magnetometer: st_magn: Support mount matrix
Date:   Tue, 18 May 2021 01:33:21 +0200
Message-Id: <20210517233322.383043-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517233322.383043-1-linus.walleij@linaro.org>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to read and present the mounting matrix on ST magnetometers.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch because why not.
---
 drivers/iio/magnetometer/st_magn_core.c | 64 ++++++++++++++++++-------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 71faebd07feb..fa587975cb85 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -53,51 +53,74 @@
 #define ST_MAGN_3_OUT_Y_L_ADDR			0x6a
 #define ST_MAGN_3_OUT_Z_L_ADDR			0x6c
 
+static const struct iio_mount_matrix *
+st_magn_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	return &mdata->mount_matrix;
+}
+
+static const struct iio_chan_spec_ext_info st_magn_mount_matrix_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_magn_get_mount_matrix),
+	{ },
+};
+
 static const struct iio_chan_spec st_magn_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_BE, 16, 16,
-			ST_MAGN_DEFAULT_OUT_X_H_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			ST_MAGN_DEFAULT_OUT_X_H_ADDR,
+			st_magn_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_BE, 16, 16,
-			ST_MAGN_DEFAULT_OUT_Y_H_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			ST_MAGN_DEFAULT_OUT_Y_H_ADDR,
+			st_magn_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_BE, 16, 16,
-			ST_MAGN_DEFAULT_OUT_Z_H_ADDR),
+			ST_MAGN_DEFAULT_OUT_Z_H_ADDR,
+			st_magn_mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
-			ST_MAGN_2_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			ST_MAGN_2_OUT_X_L_ADDR,
+			st_magn_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
-			ST_MAGN_2_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			ST_MAGN_2_OUT_Y_L_ADDR,
+			st_magn_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
-			ST_MAGN_2_OUT_Z_L_ADDR),
+			ST_MAGN_2_OUT_Z_L_ADDR,
+			st_magn_mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 static const struct iio_chan_spec st_magn_3_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
-			ST_MAGN_3_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			ST_MAGN_3_OUT_X_L_ADDR,
+			st_magn_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
-			ST_MAGN_3_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			ST_MAGN_3_OUT_Y_L_ADDR,
+			st_magn_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
-			ST_MAGN_3_OUT_Z_L_ADDR),
+			ST_MAGN_3_OUT_Z_L_ADDR,
+			st_magn_mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
@@ -507,6 +530,11 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = mdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
+	err = iio_read_mount_matrix(mdata->dev, "mount-matrix",
+				    &mdata->mount_matrix);
+	if (err)
+		goto st_magn_power_off;
+
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-- 
2.31.1

