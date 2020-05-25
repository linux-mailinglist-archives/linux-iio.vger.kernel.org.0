Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE21E12FB
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbgEYQsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388356AbgEYQsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 12:48:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AFAC061A0E;
        Mon, 25 May 2020 09:48:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w3so12434249qkb.6;
        Mon, 25 May 2020 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9GtLPWP384+mcmNAjX0iJ86SP6E9SyJL2vo8P6h15U=;
        b=Z+Qm+xrkwzZuSGSlrTKQXiT0twvVcxnq/up4UsvHYhzQ+H9funTn43WfK2/cX1m9ox
         podQ175SNu3HfQUY513TudhxDaj4xTUMEvNocmT4pc6mfLF9y6sFhCEf0gVF/xqc+J9U
         0unBbVn5uJ1uj8i9lqOBbWaCc5HnpYy2wDNYOzhK7laCK6StaSnOZy9W/VXeTGN+csep
         qt4w/ce/rKnyVJL8TqDL8GCMMylQFjzDZa+PzJgXJf0iuJEGUlECQi4ZvzT4Hn72F9Ib
         kaR0AjHL+Im9tOhwg3qPuN468biErRC196hR3C9Er6NO9r/xIPoDT4/WdwjO5R+jjPAb
         jl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9GtLPWP384+mcmNAjX0iJ86SP6E9SyJL2vo8P6h15U=;
        b=aCjtVYeSub4JBKXTb8LbS9o4+FEWZodsKIrUk4sfPxqwdWAAmJlCAz9BfnfbrMagbU
         mTUaqaX6SDXJkPBhRjY2HxsE94/8o6pBr0QChPKR2yLFIZ0rpNWlrlvk8HA2asxgntL4
         tGKpFSZnFf18Znj+aS1XhSdZi7oMZz95qGSGFBry6vs9OnBqmc0yC2P/s2KWFs3sDkwi
         wJ7AtYjaoaSTLXHybKznOvazrJb1JxlfXmvK89f+Q2wvKoh4764vVWMCjZWcjB6diPjA
         DgnVLw/l0ReHwAQy/zNoi+LWRMGs09rEpuBT2yfoZZl0/Ne5Nfc5KOpnB5i1JQmknLQ9
         d2fg==
X-Gm-Message-State: AOAM530klxw9AX/weG9m2XFPvSXfMKI0NRBkMuM7N3xWAmoDwaO/BiKj
        wpz6y0si8N6iv+IEjhV1lbSs4snGlBY=
X-Google-Smtp-Source: ABdhPJwDgDfKD/77hasok63rccG8G1K9bWVWL3Ikd3yJjTs9h3j1Ri3lL6ZOnLjaHqEH9IjpLocJRA==
X-Received: by 2002:a37:5ce:: with SMTP id 197mr9104547qkf.334.1590425286863;
        Mon, 25 May 2020 09:48:06 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id g5sm15559618qti.87.2020.05.25.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:48:06 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 5/5] iio: imu: bmi160: added mount-matrix support
Date:   Mon, 25 May 2020 18:46:04 +0200
Message-Id: <20200525164615.14962-6-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add mount-matrix binding support. As chip could have different orientations
a mount matrix support is needed to correctly translate these differences.

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
index d3316ca02fbd..26d586daee26 100644
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
@@ -839,6 +854,11 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
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

