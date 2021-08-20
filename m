Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC93F3475
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhHTTSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbhHTTSf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:35 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C5CC061575;
        Fri, 20 Aug 2021 12:17:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f7so6064054qvt.8;
        Fri, 20 Aug 2021 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbEAz7/Cn9UDWRCP1DwPP6+dnbZoJceTj6XSahw11p4=;
        b=XYv927Zim0gEqw3UikaJc9a4bkZATd1rwl5sOil5pmbXur0ohiUO7flmDCt0I8NIh2
         KApqTzpkEvqTdLaK09oZVAeY/950B1qOh4w0tx4yM98Gj62jXN3YYxZJsgfYFErOifRZ
         gXt6+5v0VpLbwnrmzSn7doLX8LVs52ekTL2/r9Kqui5WG5d9iBEaen25CvIRES8ojqMG
         VbmfsTGRmKe+6iE4t01vyaVUtAitEhPQIUvwrwfYX2bfk98P8CXNM5NOMN5YVwc1GRC7
         +VzlGr6yzM9tpe0xB56Ii17uYKCbyGuMxFd/pYLqLn79+pvQHJ9nRGbYc8egOHirak7O
         K+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbEAz7/Cn9UDWRCP1DwPP6+dnbZoJceTj6XSahw11p4=;
        b=riWmyaPTieOMyWIUbEldtN3qJZbvlQ/XiNDEK8KEQn1Rug2DaOUXSp9hNlX9hZ+zVP
         alHwtqcKntbD/Ld1NyB4OCT4EMmfd+agOeOIXJgpMR2Y4+inEo8UauV+yJkZppGv20XC
         hFAF8kKibn9+eZG1wJ5/Xy5Gnn0uIrY+L4yRj3gg/vk/wdBhza9yyb+7X5MRBewdTrLt
         /O2TpwfVrMH/fxixZLleTiyJ8SoJ5BKaawFPbxH/7ewEbLMPZds/M9A7yAqKNESRmJIi
         6+sp0S4FQsUamgB1Zfd2H2uLDPP5VeV0Tlg9UpqIzeuvAO143bxcBnzf40vBRHbYcKsz
         otMA==
X-Gm-Message-State: AOAM530W1N/iKGBgrUK+QCP7Bi56YGR/8RMo/YST0YJKM1A+jJgob8as
        UBTYvpPtiMFjeRNwf0QS2kY=
X-Google-Smtp-Source: ABdhPJzqizUHKUEKZ915iXKdoKInFkk/CNjGZ+KsaApHlkAcLvGANBZrGnLj8Rk7CT5r3Jv/pDhM+Q==
X-Received: by 2002:a05:6214:e4e:: with SMTP id o14mr21604222qvc.46.1629487076351;
        Fri, 20 Aug 2021 12:17:56 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:55 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 04/14] iio: afe: rescale: expose scale processing function
Date:   Fri, 20 Aug 2021 15:17:04 -0400
Message-Id: <20210820191714.69898-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

In preparation for the addition of kunit tests, expose the logic
responsible for combining channel scales.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c   | 65 ++++++++++++++-------------------
 include/linux/iio/afe/rescale.h | 30 +++++++++++++++
 2 files changed, 58 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/iio/afe/rescale.h

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..d0669fd8eac5 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -11,35 +11,46 @@
 #include <linux/gcd.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/afe/rescale.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-struct rescale;
-
-struct rescale_cfg {
-	enum iio_chan_type type;
-	int (*props)(struct device *dev, struct rescale *rescale);
-};
+int rescale_process_scale(struct rescale *rescale, int scale_type,
+			  int *val, int *val2)
+{
+	unsigned long long tmp;
 
-struct rescale {
-	const struct rescale_cfg *cfg;
-	struct iio_channel *source;
-	struct iio_chan_spec chan;
-	struct iio_chan_spec_ext_info *ext_info;
-	bool chan_processed;
-	s32 numerator;
-	s32 denominator;
-};
+	switch (scale_type) {
+	case IIO_VAL_FRACTIONAL:
+		*val *= rescale->numerator;
+		*val2 *= rescale->denominator;
+		return scale_type;
+	case IIO_VAL_INT:
+		*val *= rescale->numerator;
+		if (rescale->denominator == 1)
+			return scale_type;
+		*val2 = rescale->denominator;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = *val * 1000000000LL;
+		do_div(tmp, rescale->denominator);
+		tmp *= rescale->numerator;
+		do_div(tmp, 1000000000LL);
+		*val = tmp;
+		return scale_type;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
 	int ret;
 
 	switch (mask) {
@@ -65,27 +76,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		} else {
 			ret = iio_read_channel_scale(rescale->source, val, val2);
 		}
-		switch (ret) {
-		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
-			return ret;
-		case IIO_VAL_INT:
-			*val *= rescale->numerator;
-			if (rescale->denominator == 1)
-				return ret;
-			*val2 = rescale->denominator;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_VAL_FRACTIONAL_LOG2:
-			tmp = *val * 1000000000LL;
-			do_div(tmp, rescale->denominator);
-			tmp *= rescale->numerator;
-			do_div(tmp, 1000000000LL);
-			*val = tmp;
-			return ret;
-		default:
-			return -EOPNOTSUPP;
-		}
+		return rescale_process_scale(rescale, ret, val, val2);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
new file mode 100644
index 000000000000..14d4ee1227c6
--- /dev/null
+++ b/include/linux/iio/afe/rescale.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
+ */
+
+#ifndef __IIO_RESCALE_H__
+#define __IIO_RESCALE_H__
+
+#include <linux/iio/iio.h>
+
+struct rescale;
+
+struct rescale_cfg {
+	enum iio_chan_type type;
+	int (*props)(struct device *dev, struct rescale *rescale);
+};
+
+struct rescale {
+	const struct rescale_cfg *cfg;
+	struct iio_channel *source;
+	struct iio_chan_spec chan;
+	struct iio_chan_spec_ext_info *ext_info;
+	bool chan_processed;
+	s32 numerator;
+	s32 denominator;
+};
+
+int rescale_process_scale(struct rescale *rescale, int scale_type,
+			  int *val, int *val2);
+#endif /* __IIO_RESCALE_H__ */
-- 
2.32.0.452.g940fe202adcb

