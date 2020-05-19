Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF11D9164
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 09:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgESHwI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 03:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgESHwG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 03:52:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAFCC061A0C;
        Tue, 19 May 2020 00:52:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so2308564wmu.1;
        Tue, 19 May 2020 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EeNFiJ1FC5DZjuSZh9hyKMC8Zinmtds/VmAwu1z5abo=;
        b=XEAU79mZXQfRvTzivvj9o5mW0XISfJr+VlP/k89iTZp3M2LILtWn/cpe9VuWcMtRDI
         JtbzVAsUQwzFHQpap+7eSOB48Y8U/zWEXAzdecTqWICRSi4QYTrzch82hze1o9OE/ufy
         GLTcfNMZh6b/OWy5/wVDZFamRZ3p9991plplToXbjwlwcxaO8xedJDzKqLhbJjv/DA8D
         ESN8Nf3p+lAWqDdbLiVha0d0XUlvj66KA3yNUzxLB+2uJpV4s20sq5RcxPcjmCLsvzjO
         zh4fCbUpUHR1HpcbDPIv4RFD6ZESmrVgh9O5cKx+14JI9c+MsxiwdPqvZE6w9wxefRCP
         Yu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EeNFiJ1FC5DZjuSZh9hyKMC8Zinmtds/VmAwu1z5abo=;
        b=ZqCqM91fJyrs10TuMNNdhTDErIQZ/82Z30jzSyYNpqwwjEdY+2iNX4+NqOrkF+wC0f
         x0721bSqlkhjWv2zCzZcxSBytvbX8YCgJMevpVnmuDQrzr/V1PCjNCRWxaYyYhXCfwQW
         TL8J0FzaNdx6LaY7nwfnkQjT/xSljVj7GFnxcPuL8gIJidSkHkpvW1eZIC6/rolowhbX
         yuD6lZXmMhCLwm+eX5JAbVkn1prpJ723128AbzU9fb+9qSss8jg7lFgWV1jDxbrFCqTu
         4Qw0Sq7+3h+Q10MUX14ANztFZkds/I2SS1Tgo7VxDb1aYCUlQhBkBAZsBYcw5nIMlrhS
         ks4A==
X-Gm-Message-State: AOAM5335JrcX8BqzxZtMcBqasZbS3Q7y3pWPK2tvD4mTKlUH+U41y6eV
        l4+IyhtKqqWplzFVc3apMek8s4FtDB4=
X-Google-Smtp-Source: ABdhPJyWKQkQVV8QWYuBtxkoXnBwAtWQhLa5GCVcyxRYI/z/Cb4GqcUUbx1v5l09cnCmSiDunxJHMg==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr3764710wmg.126.1589874724562;
        Tue, 19 May 2020 00:52:04 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id w18sm20019697wro.33.2020.05.19.00.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 00:52:03 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 4/4] iio: imu: bmi160: added mount-matrix support
Date:   Tue, 19 May 2020 09:51:00 +0200
Message-Id: <20200519075111.6356-5-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
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

