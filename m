Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88436388308
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbhERXTm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 19:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237815AbhERXTl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 19:19:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19DBC061573
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v6so13381485ljj.5
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NT9lSKqcdBNrHqx/ATx0OFLN8Pf5dT94VJOZFcZGaAk=;
        b=xMEbnwYx3irdpYjyRIV5XvS3xqbKos+0U3pT58/ooRoFbTkebOZnjr93Tf5L2PM9Jk
         fnzjAsixXVsp+mJnNP+f9QjaU/HdJ3Bu+nN5RCsWSvnNwedk8YR3JQZfYVVGSNs/gyfP
         5XWAbVUiHFwCkEtGqyYLcc1iGHAM/ahlcyRlyIXAmTAg4YCTEfxyJIWVRDYwyGBG+556
         3ZTJK+GjNbREPplJyFvAAlna4ZWr3rG7HHQ2jH8Ng/7xAOoStB0zfqpMPMJiBWxYgr9e
         Y+WxQNrXVCEKpGM+3NMzG6Spy+iU2Reo3eJFBZqFpsTcxjLQyFx6hpKWgiB3Het2DKXp
         XoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NT9lSKqcdBNrHqx/ATx0OFLN8Pf5dT94VJOZFcZGaAk=;
        b=OHiLELXZ//G+ewAqq5u1kQSyIae6GKrzquVjFZhKLdlOGKHsaqKh17n4a7BTbdAgZF
         pUDpHsZ9W6BkYun7t1J50+tK1ww2jt8gpsHpc/oqkRiai7/392I1/IVHkEAQKCxjQjP0
         8Af29ylhNU/jKzBF4FnYXiY1HVTcAkFmU/K/5CGmqlR8pbgCf/97hBj1DlZA6jS6Qd1D
         AVqvMVp7Vgp4iW8Gw4f/uHYXJtfOYwcku9ktOZwhs7T+SmqEE4iPIbfRx7TN7w+ShAQj
         9s1RbzbP1DeWO3GTkz8zzE3Ls8rQHKCShKli9Gw01eJZlIxoxXPD76G94emNQFJTdOE4
         ucFw==
X-Gm-Message-State: AOAM531TbfbP8DYp0z1Vee98xSsdahWkFrbGCCKBnz6wXo5ZrWNEgjvP
        /n+12gq2IOdd/Nh8Bj6S2SFjXA==
X-Google-Smtp-Source: ABdhPJy8ewM+NcUHSYM0+vt/Pzq9tLDvNYcrbUVe/8zryPGesSljLqNC5UP9c+7Qg2C1hXuv4rP9xQ==
X-Received: by 2002:a05:651c:333:: with SMTP id b19mr5739860ljp.61.1621379900322;
        Tue, 18 May 2021 16:18:20 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d10sm1666392lfi.79.2021.05.18.16.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:18:20 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/5 v3] iio: magnetometer: st_magn: Support mount matrix
Date:   Wed, 19 May 2021 01:07:21 +0200
Message-Id: <20210518230722.522446-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518230722.522446-1-linus.walleij@linaro.org>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to read and present the mounting matrix on ST magnetometers.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase on Andy's patches and mount-matrix generalization
- Drop surplus comma.
ChangeLog v1->v2:
- New patch because why not.
---
 drivers/iio/magnetometer/st_magn_core.c | 63 ++++++++++++++++++-------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 1596faa74da9..0048c3cd36ee 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -59,51 +59,74 @@
 #define ST_MAGN_4_OUT_Y_L_ADDR			0x0a
 #define ST_MAGN_4_OUT_Z_L_ADDR			0x0c
 
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
+	{ }
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
 
@@ -607,6 +630,10 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = mdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
+	err = iio_read_mount_matrix(mdata->dev, &mdata->mount_matrix);
+	if (err)
+		return err;
+
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-- 
2.31.1

