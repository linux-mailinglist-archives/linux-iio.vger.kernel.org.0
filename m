Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7609E1D7A0C
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERNgF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 09:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERNgE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 09:36:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28AFC061A0C;
        Mon, 18 May 2020 06:36:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so10464856wmc.2;
        Mon, 18 May 2020 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EeNFiJ1FC5DZjuSZh9hyKMC8Zinmtds/VmAwu1z5abo=;
        b=ZwMrnn+to6VQMkNjzZOwmfTwwkBqR7cX5q6nH+k6TuYBxihJ93+aqwF9C2LSPaVxcD
         1dpP9uOp5g30ttImSR5urNvNejLoJ5+HH69IYD58CI5jeWLR/RWRlVqGn4WC1rpofCtl
         x8cbxbGT0nSGSnCDXF3BgvysqAlQc1dM5JWG9l10bUFvdc/SxphI+WNyl65Lw4dDkA+W
         ho3ZU04ZRPe9pkmJJjKbL8+VwixocTfKkMbOjkBeYGU1mMZJ2EDAmtDiU1HQtBUc6fPf
         jxPlHdqMRH6Q7wN7+sAlEZbSD9xq8ZKZGQB9h1QeAffqEO59jHzXH/AmJcKbCLs14EYp
         Mp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EeNFiJ1FC5DZjuSZh9hyKMC8Zinmtds/VmAwu1z5abo=;
        b=e8euYzWSEcTzWo6qmaAAmV8dRdahdQ1ZlYVMAf8YztAe2b1pNEn5N6T9IJ56BFjG56
         lxi3eyMBsgdHTbDtrr7WzJYUvxnYWKJFFm8L/oXEkQZUB9Obtxbj0EeJAYG3sz4Bk2b9
         RvbvJZcj30k8TnUeL6+9XOlSv8BTpOevQd0jf2mh+6o3iGp4WXcnF6XZx4vQlg++FlKA
         8ESBBGvFwvWO/11q9yACKg3ikx2xJEXVYpJSJljp2BWlGWtrbP32lfDYOeArOawnmEpx
         wvqvnX2q6Yun6/gipGU+fvrnQFqeYI4OyjtIYbOliWoui0KMq7mHal/itkHPSXgFZhCS
         Zo/w==
X-Gm-Message-State: AOAM5308V6p2hhppXVtCUQeH4SYOaWoK++A65BuKT25wNQlJtUM2kSHW
        glWLp+jE0X9PHzlPYpBxChS7Ypc1bCQ=
X-Google-Smtp-Source: ABdhPJzewy/2r3VFYMjprFF3FTgffZFTtGs+QntmBmtQsjKWVhSkrgTScldbQh2bVXN3KBi0R1OTbA==
X-Received: by 2002:a1c:7f4e:: with SMTP id a75mr19045184wmd.94.1589808962216;
        Mon, 18 May 2020 06:36:02 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id l19sm17086772wmj.14.2020.05.18.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:36:01 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/4] iio: imu: bmi160: added mount-matrix support
Date:   Mon, 18 May 2020 15:33:48 +0200
Message-Id: <20200518133358.18978-5-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
References: <20200518133358.18978-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add mount-matrix binding support. As chip could have different orientations
a mount matrix support is needed to correctly translate these differences

Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160.h      |  1 +
 drivers/iio/imu/bmi160/bmi160_core.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 923c3b274fde..a82e040bd109 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -9,6 +9,7 @@ struct bmi160_data {
 	struct regmap *regmap;
 	struct iio_trigger *trig;
 	struct regulator_bulk_data supplies[2];
+	struct iio_mount_matrix orientation;
 };
 
 extern const struct regmap_config bmi160_regmap_config;
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 9bbe0d8e6720..78c8ca962359 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -110,6 +110,7 @@
 		.storagebits = 16,				\
 		.endianness = IIO_LE,				\
 	},							\
+	.ext_info = bmi160_ext_info,				\
 }
 
 /* scan indexes follow DATA register order */
@@ -265,6 +266,20 @@ static const struct  bmi160_odr_item bmi160_odr_table[] = {
 	},
 };
 
+static const struct iio_mount_matrix *
+bmi160_get_mount_matrix(const struct iio_dev *indio_dev,
+			const struct iio_chan_spec *chan)
+{
+	struct bmi160_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bmi160_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bmi160_get_mount_matrix),
+	{ }
+};
+
 static const struct iio_chan_spec bmi160_channels[] = {
 	BMI160_CHANNEL(IIO_ACCEL, X, BMI160_SCAN_ACCEL_X),
 	BMI160_CHANNEL(IIO_ACCEL, Y, BMI160_SCAN_ACCEL_Y),
@@ -840,6 +855,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
+	ret = iio_read_mount_matrix(dev, "mount-matrix",
+				    &data->orientation);
+	if (ret)
+		return ret;
+
 	ret = bmi160_chip_init(data, use_spi);
 	if (ret)
 		return ret;
-- 
2.17.1

