Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66F386DC2
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 01:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhEQXkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 19:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbhEQXkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 19:40:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F7C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:38:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a2so11249068lfc.9
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dfYSzKVBAdi2ps5q+TR9Wlw4r6ze7XJcF8+xEewP07s=;
        b=x+s94XDTjXLCyhWGu7XxGYjMKxGZs1zwFJ609GKwyLz+LFqdRmbrJ81Wvrr8M/zzNI
         m9YOKSbhu3ZUyYzbUG3s4lu1N0jWx86d8KPssAbS2lcwI1BFw3neisNf15IpkSOpavz0
         fM5ghyn9K5X0rDowAJUe6/1ZT7Sg+Wru2/VQC/qOjoP29YRha8v9NHL87X+fyMc0qet9
         4da1PXijou4cV6bFxlcirdgcpeplLoG/XfRyHtavKsM3w3K+IROTtLD8TFc2VZqxjhe/
         ToQXfgbEzsoT4nb22viJjqlmV8FhkzfgMzXgWhXbgNHpFiCyT/7iYqGWpORZOQzBEQVU
         obZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dfYSzKVBAdi2ps5q+TR9Wlw4r6ze7XJcF8+xEewP07s=;
        b=jH7/Rp8TdujXBCciLBrjDGMd/y6m1Fu45keOY8j8jBqkLgZoJ1Ud/eD43NqWY+PvPZ
         xVqNSdn4UR763n8zqSbI4v3JzKRI9NWSo4IPQv0yD9QN/8lP0Jgm90C7GCBQbrv+YqqL
         x4EvTtLarR5ehSIAkhOd3BgDU6qC0ezgwIXmPVRrvKN0+2J+xxleg7TqZIEZoC6oP//F
         twgVbmm6UkKzww/HseCRmqaJRvFtFWor2PAs0BWw9P2un+FfuNwaPmhv2iDaAkXgVBwD
         V89juQ8d2f5stbMNRQ9jYtWBVDH0g4bUOfW7rBhUOo8NvEbnewBOVt2hd+SW9euS4NLu
         rSEg==
X-Gm-Message-State: AOAM5323JIL7qhTt16LXHFT/lt/HhaiN2peDydIrEgDqy11m2deRH+7Z
        AfOgiBIZ0mJD6tt38g6RGwn1vQ==
X-Google-Smtp-Source: ABdhPJzAehTHbNZ8IefWSgeoCaGQtZLZiqaVK5vSr9xwB/G4Fc1ydVht41SLOXWQQD+uu5hdk3Nw8A==
X-Received: by 2002:ac2:5dd5:: with SMTP id x21mr1764412lfq.503.1621294730542;
        Mon, 17 May 2021 16:38:50 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id r10sm168425lfe.110.2021.05.17.16.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:38:50 -0700 (PDT)
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
Subject: [PATCH 5/5 v2] iio: gyro: st_gyro: Support mount matrix
Date:   Tue, 18 May 2021 01:33:22 +0200
Message-Id: <20210517233322.383043-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517233322.383043-1-linus.walleij@linaro.org>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to read and present the mounting matrix on ST gyroscopes.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch because why not.
---
 drivers/iio/gyro/st_gyro_core.c | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index c8aa051995d3..bf06a531bed3 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -37,19 +37,36 @@
 #define ST_GYRO_FS_AVL_500DPS			500
 #define ST_GYRO_FS_AVL_2000DPS			2000
 
+static const struct iio_mount_matrix *
+st_gyro_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct st_sensor_data *gdata = iio_priv(indio_dev);
+
+	return &gdata->mount_matrix;
+}
+
+static const struct iio_chan_spec_ext_info st_gyro_mount_matrix_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_gyro_get_mount_matrix),
+	{ },
+};
+
 static const struct iio_chan_spec st_gyro_16bit_channels[] = {
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ANGL_VEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
-			ST_GYRO_DEFAULT_OUT_X_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			ST_GYRO_DEFAULT_OUT_X_L_ADDR,
+			st_gyro_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ANGL_VEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
-			ST_GYRO_DEFAULT_OUT_Y_L_ADDR),
-	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			ST_GYRO_DEFAULT_OUT_Y_L_ADDR,
+			st_gyro_mount_matrix_ext_info),
+	ST_SENSORS_LSM_CHANNELS_EXT(IIO_ANGL_VEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
 			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
-			ST_GYRO_DEFAULT_OUT_Z_L_ADDR),
+			ST_GYRO_DEFAULT_OUT_Z_L_ADDR,
+			st_gyro_mount_matrix_ext_info),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
@@ -478,6 +495,11 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = gdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
+	err = iio_read_mount_matrix(gdata->dev, "mount-matrix",
+				    &gdata->mount_matrix);
+	if (err)
+		goto st_gyro_power_off;
+
 	gdata->current_fullscale = &gdata->sensor_settings->fs.fs_avl[0];
 	gdata->odr = gdata->sensor_settings->odr.odr_avl[0].hz;
 
-- 
2.31.1

