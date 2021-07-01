Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529473B8B8B
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhGABDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbhGABDY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F40C061756;
        Wed, 30 Jun 2021 18:00:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y9so2967717qtx.9;
        Wed, 30 Jun 2021 18:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Coq9W6UR2KbpR7gTQ+r9if/M5xvmwZcH5jkSQhQdKvw=;
        b=BlETA7j4OINrnTw7yCwkrqh4AWUihvJ71rhID+ROps8XbNfSLxfJ4LyTGgK69UlbmU
         JwohJgh4FgMdrxeRmSYhJ+eHHVAB6+uIjm24O6JVftxSulDQeqy4iqE4u8YsYHlZZ+Ey
         cBQsC/41ZberKPN1kxxqIFo9GZe0FJDxJc8/F4HIvVXskCogCyezL8+AuPdCnpFHfBR2
         Su1hLxlz1Rc2CgtR7XGkvCiqsUlPfjrU6nmLUoGC5J8JSK5CHH4X3FRO+P5ffGBrhCb8
         sBGWyz7n/e2XSadYsgCKjHQCc2tirpQD7AkdFn5v5/qOBbuxcKqZAMfHJj094XoivU21
         zZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Coq9W6UR2KbpR7gTQ+r9if/M5xvmwZcH5jkSQhQdKvw=;
        b=T1NhQCZdn4CC5E209ezvdKKiNsguKcJY7AuIB+gMJ8yS8cX+674n6128TB1aB1ZOIw
         pC8Bj5swLJwK82iWdG5Rkh/xHcppqzUeqBtBWCccGavUi5zBzL9bqJ1MCwgnKcxRF7nj
         9/tC7H5K0jYh8e1/Wy5b8WfjQW47xTkxraykKAZeMukoDG11hnOYoXkc4GeeNSWunkXx
         GpbH0/he3kKBr5pDg6a7X0KTH5qnbgQNTZTN6vjgIxkPQ4Dnnp1GlbHWm+b15p0pwuMT
         idWzIWpRd6ZJwcKf5ninz/KFLUC6m6pj7Ff4LqZqEfNyZaxP6DROWpeiwnpofAfK3IVf
         9Oyw==
X-Gm-Message-State: AOAM531aAiiW52QvmI99EN4pqDaJ675UAFbbQ9kJLm1yv7QmSGNCMhAr
        ZVuTurdRQrhcGzLhYsG4idk=
X-Google-Smtp-Source: ABdhPJxRC7JQW3cJoaRlxtkG2ljUJYhhPo3CYhBnGjizObq5MSZzOPl44GAOcZpnpNxHQ8CgEGuY/w==
X-Received: by 2002:ac8:549:: with SMTP id c9mr34582099qth.80.1625101254118;
        Wed, 30 Jun 2021 18:00:54 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:53 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 08/10] iio: afe: rescale: add temperature transducers
Date:   Wed, 30 Jun 2021 21:00:32 -0400
Message-Id: <20210701010034.303088-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

A temperature transducer is a device that converts a thermal quantity
into any other physical quantity. This patch add support for temperature
to voltage (like the LTC2997) and temperature to current (like the
AD590) linear transducers.
In both cases these are assumed to be connected to a voltage ADC.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 5d7fe8695b68..e820e9f37a7d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -377,11 +377,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_transducer_props(struct device *dev,
+					 struct rescale *rescale)
+{
+	s32 offset = 0;
+	s32 sense = 1;
+	s32 alpha;
+	s64 tmp;
+	int ret;
+
+	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
+	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
+		return ret;
+	}
+
+	rescale->numerator = 1000000;
+	rescale->denominator = alpha * sense;
+
+	tmp = (s64)offset * (s64)alpha * (s64)sense;
+	rescale->offset = div_s64(tmp, (s32)1000000);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 	TEMP_SENSE_RTD,
+	TEMP_TRANSDUCER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -401,6 +428,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -412,6 +443,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
 	{ .compatible = "temperature-sense-rtd",
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-transducer",
+	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.30.1.489.g328c10930387

