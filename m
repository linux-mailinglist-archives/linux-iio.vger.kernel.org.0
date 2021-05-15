Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE538146E
	for <lists+linux-iio@lfdr.de>; Sat, 15 May 2021 02:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhEOAEU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 20:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbhEOAEP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 20:04:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654AFC06174A
        for <linux-iio@vger.kernel.org>; Fri, 14 May 2021 17:03:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2so708336lft.4
        for <linux-iio@vger.kernel.org>; Fri, 14 May 2021 17:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JckKnX+NnE44AsOIJI4EVeqTKY9fblc7qVyw1JuauKc=;
        b=tvrpiYnR+fD48Zwzv9Csx9f8tq10dFTMenOwHlR2/ob3sclXu52ofjAE3uSumCVf/Y
         pnF8iIkvRXKkdNC5W0CfvG8ib1PbqXJNtZTmF8vTHt68RhqvZlD9kL2FpUuBQ7jEpM4E
         CMvmsShFD5cVgeEI7L4Vqr6Xpg0q9HryzWhFFUkz48elqYN9BDggHFi10tquenyxGFnY
         5ks5W0xtrFOa1tUAA9tMakkveoaOaSNv0PbUeugbUl0UCo8gDBkBs+2rWcZ0QIDDzATj
         a2Ybf1KjDeI3dZIIzE6sG842Rs880Jw/vv9GJktaj12swlWPdA/gUcQNg78yQDYDiq1b
         QIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JckKnX+NnE44AsOIJI4EVeqTKY9fblc7qVyw1JuauKc=;
        b=QDWHtsEJAHaCMjazdUPs+35qeajJsgHGbC01wh52+7L8UPveihbKm7isTTWhLRWbw7
         LqnvygDHspSodtoRQJMIMOg+uaWl9CmjBEEsmn2kByaLfgYE0DhdXXodQ6fN2WsZ+Vpn
         qOFPG+py68plMCUS36hF8cjCHkQ0mCc/BQABuxbnzriMjwVGTzhNtpRS93Y58kgfOsmS
         5iYFerCDfCHNFkCAsKGF7VjpK0fG+Pp+AQocSLeSEXw4pdlFvjASBZk8S2c0LEX0HRVF
         aqT5T0KjsVfqxNmcgWGVRsw+FsYnhQ9/phONGwUd9YvTQnWeX9vp2Mrhppja+Xsee4Ga
         eJYw==
X-Gm-Message-State: AOAM530HckkD2IjiQCj1KjEuEft6Bd2mX06B0+k26kWpVcdU5LVRYQnK
        am0UyYC8pHggLLAPqUHS7BRkmQ==
X-Google-Smtp-Source: ABdhPJx++xC0iYhYYxsmKV2OWJOaP7quwkvSVQyZho3tmvdttmG4BCtO4e2KOpvAFEhb32n/JWuSxQ==
X-Received: by 2002:ac2:5393:: with SMTP id g19mr34102461lfh.459.1621036980924;
        Fri, 14 May 2021 17:03:00 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id z26sm1048133lfg.42.2021.05.14.17.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 17:03:00 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH] iio: accel: st_sensors: Support generic mounting matrix
Date:   Sat, 15 May 2021 02:00:58 +0200
Message-Id: <20210515000058.204601-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ST accelerators support a special type of quirky
mounting matrix found in ACPI systems, but not a generic
mounting matrix such as from the device tree.

Augment the ACPI hack to be a bit more generic and
accept a mounting matrix from device properties.

This makes it possible to fix orientation on the Ux500
HREF device.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_core.c | 51 ++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 43c50167d220..cfbcf740e3cb 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1069,26 +1069,25 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #define ST_ACCEL_TRIGGER_OPS NULL
 #endif
 
-#ifdef CONFIG_ACPI
 static const struct iio_mount_matrix *
-get_mount_matrix(const struct iio_dev *indio_dev,
-		 const struct iio_chan_spec *chan)
+st_accel_get_mount_matrix(const struct iio_dev *indio_dev,
+			  const struct iio_chan_spec *chan)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
 	return adata->mount_matrix;
 }
 
-static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
+static const struct iio_chan_spec_ext_info st_accel_mount_matrix_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_accel_get_mount_matrix),
 	{ },
 };
 
+#ifdef CONFIG_ACPI
 /* Read ST-specific _ONT orientation data from ACPI and generate an
  * appropriate mount matrix.
  */
-static int apply_acpi_orientation(struct iio_dev *indio_dev,
-				  struct iio_chan_spec *channels)
+static int apply_acpi_orientation(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -1207,22 +1206,20 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
 		}
 	}
 
-	/* Expose the mount matrix via ext_info */
-	for (i = 0; i < indio_dev->num_channels; i++)
-		channels[i].ext_info = mount_matrix_ext_info;
-
 	ret = 0;
 	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
 
 out:
 	kfree(buffer.pointer);
+	dev_warn(&indio_dev->dev,
+		 "failed to apply ACPI orientation data: %d\n", ret);
+
 	return ret;
 }
 #else /* !CONFIG_ACPI */
-static int apply_acpi_orientation(struct iio_dev *indio_dev,
-				  struct iio_chan_spec *channels)
+static int apply_acpi_orientation(struct iio_dev *indio_dev)
 {
-	return 0;
+	return -EINVAL;
 }
 #endif
 
@@ -1251,6 +1248,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	struct iio_chan_spec *channels;
 	size_t channels_size;
 	int err;
+	int i;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &accel_info;
@@ -1275,9 +1273,28 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 		goto st_accel_power_off;
 	}
 
-	if (apply_acpi_orientation(indio_dev, channels))
-		dev_warn(&indio_dev->dev,
-			 "failed to apply ACPI orientation data: %d\n", err);
+	/* First try ACPI orientation then try the generic function */
+	err = apply_acpi_orientation(indio_dev);
+	if (err) {
+		adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
+						   sizeof(*adata->mount_matrix),
+						   GFP_KERNEL);
+		if (!adata->mount_matrix) {
+			err = -ENOMEM;
+			goto st_accel_power_off;
+		}
+
+		err = iio_read_mount_matrix(adata->dev, "mount-matrix",
+					    adata->mount_matrix);
+		if (err)
+			goto st_accel_power_off;
+	}
+	/*
+	 * We have at least an identity matrix, so expose the mount
+	 * matrix via ext_info
+	 */
+	for (i = 0; i < indio_dev->num_channels; i++)
+		channels[i].ext_info = st_accel_mount_matrix_ext_info;
 
 	indio_dev->channels = channels;
 	adata->current_fullscale = &adata->sensor_settings->fs.fs_avl[0];
-- 
2.31.1

