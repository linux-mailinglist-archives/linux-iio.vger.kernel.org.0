Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A68388309
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhERXTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 19:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbhERXTm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 19:19:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF1C06175F
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o8so13436173ljp.0
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx3lmgQ8cSuRlcdsf0Gi9xlYw3cfTssfh/nNlNYFvFY=;
        b=Y2V1p5LOUqKRVJNzIZQJgDcZVlrs+lPaZ7ebpSQjcG8V2Cb5rbAAmjHPtpJIhjeqOI
         hntrk5YFsiLckFAgKFdJqmnVuXp1+zsbSGMaNMd/JwPv7tbilnx4OUOYmHRINyeC4ODi
         DQ+KCoJelcstKyJfh9ZjBrtK65R494cbTEcCOI4js5VdbydiD/egfx6ozd2IULhRD6EI
         +pK6h4N4nMoqGDhbPlHtHKq7y+vd5ouFH4kOAmTJVyYP9KreOTK3flHpOgDGRy8ZQYk4
         Dk+PxrEBdgIhxWR294n8wDdWeO1s73473LsIMHS0oAWc/XsDn24vmKJzMkLI31iKfQJq
         ffHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx3lmgQ8cSuRlcdsf0Gi9xlYw3cfTssfh/nNlNYFvFY=;
        b=krfgoJnvJlVW/ZQnLLGBwy1I1OaiQJJpf689pGQoOycsM8WCliIwEfAv0UfUIgPknH
         cUOHfLZzx+BeUgXqWNTzM3fG1hnWiizbzqgp9UXtX5v8qs4Y3aCtSJRyIYguCWG3PL4V
         6AUAHFqnrU0dEdJjfcWmj14yz8cOl9YN8QbDQkC4jbF+LeE7QVnPmslhMWrxk7DkWYHj
         RWcm52fhLtfopc5a5LTL6dOOLcluZ+H2VYKmjKxskyocTzQIVG076jcvoJd2DV+fvRWC
         ggk+Vj/kk5kRwIq1MbDRL4sNUAB+4yHzWWoDogAPwpfsLyf4FMNn76HLXd6H+j4GgzBf
         Xwmw==
X-Gm-Message-State: AOAM533tMw+HqT9E4MZ4yRk/4Jn/5Svr4aFXZ9AuSORebaURBNIARVKb
        vhz5ZgAPl8Ac1EP5BGDaEqVS1g==
X-Google-Smtp-Source: ABdhPJwCKOAqhFmA9t3SM+A3WLWhDyF5YbIZ8Z/ioXF0FBPahD5LxcR7+BKJ2DdKXLvRZ49Q3DYy2g==
X-Received: by 2002:a05:651c:2002:: with SMTP id s2mr5926867ljo.477.1621379901639;
        Tue, 18 May 2021 16:18:21 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id d10sm1666392lfi.79.2021.05.18.16.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:18:21 -0700 (PDT)
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
Subject: [PATCH 5/5 v3] iio: gyro: st_gyro: Support mount matrix
Date:   Wed, 19 May 2021 01:07:22 +0200
Message-Id: <20210518230722.522446-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518230722.522446-1-linus.walleij@linaro.org>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to read and present the mounting matrix on ST gyroscopes.

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
 drivers/iio/gyro/st_gyro_core.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index ee3f0ea96ac5..b86ee4d940d9 100644
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
+	{ }
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
 
@@ -479,6 +496,10 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	indio_dev->channels = gdata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
+	err = iio_read_mount_matrix(gdata->dev, &gdata->mount_matrix);
+	if (err)
+		return err;
+
 	gdata->current_fullscale = &gdata->sensor_settings->fs.fs_avl[0];
 	gdata->odr = gdata->sensor_settings->odr.odr_avl[0].hz;
 
-- 
2.31.1

