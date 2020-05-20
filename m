Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C201DBE51
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgETTsP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 15:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgETTsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 15:48:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD22C061A0E;
        Wed, 20 May 2020 12:48:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m11so4904293qka.4;
        Wed, 20 May 2020 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9GtLPWP384+mcmNAjX0iJ86SP6E9SyJL2vo8P6h15U=;
        b=Sl5Q5x/AR2Cz1CAvTwZdOUzSDcS1IoQUjBY1fsHBdcZ5ff2iJLVCx4Wpgo6pWMtppo
         Qg7bibiXvAe0J8B48njqtDUyPxTy4DEiIxugvAX4yguVlx4js6USdh9R6krQ8K0qMkb4
         GQXRXRAp7J3Eo4Fjn4o5dxvzoJDqdgAdficdKdEJT+elbKteocf+XSgjeX3HOHQDoilN
         5SVI+N1BJpSw+t0v/iI9aHQ468Qb8y4xefOE9hRmHUqdQBziUqAWiRnRv3w81Xr1ZKK6
         mxx3q0LJPp3PybZYh+BNcnfZh2oOgvhWX6+t6hIvlO20GBW/Iok4ZqsJe3PccDdaqTAz
         gM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9GtLPWP384+mcmNAjX0iJ86SP6E9SyJL2vo8P6h15U=;
        b=O7Qt2rvhoc0s51IxfywynxLjjbP8qwyjH9ycjOUKGRXFxmdiCkWLMJOiaqhroP3ibm
         BZ6kHQznw1FocKAFnJFUizxcRTY5SbU0St0y6c710bbdcAY23AGhqH/FOE08haFIQTbA
         /62o6D9ztOTdGzGLy93Rrf2yy6EASvxgjPADbT1EWt6dDkZhglaHnBLlXq91klu14sJi
         iFBgkolHFPFvpMubYuBphpO5AkYpT9mRsjDRXaSoNxADY026FYHAGcmttr8WY24H1wEv
         7f9p6P3WFhqPGzGovQqdUJq7/LyiwCG58Q2PRwAZoxSZ998LgPyhavCrJmTNFMDDSlst
         tJ3g==
X-Gm-Message-State: AOAM531XasSpPIIjpQr11kNZEOmS9x1MHvFhZY/P+UrrDVfRE5BzAe5b
        e753oHku8zGgwRj1wIjeep5R/tQFSH3Z+g==
X-Google-Smtp-Source: ABdhPJzmmfjnZ7v5lGiG7IP3kli4Yc3gZcR3wRYRHUJSWq/PIhQlU1MF8BbwpjcxK2O6dG5qUal0DA==
X-Received: by 2002:a37:7347:: with SMTP id o68mr5962002qkc.343.1590004093902;
        Wed, 20 May 2020 12:48:13 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m33sm3158419qte.17.2020.05.20.12.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:48:13 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 5/5] iio: imu: bmi160: added mount-matrix support
Date:   Wed, 20 May 2020 21:46:44 +0200
Message-Id: <20200520194656.16218-6-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
References: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
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

