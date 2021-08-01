Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95A3DCD54
	for <lists+linux-iio@lfdr.de>; Sun,  1 Aug 2021 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhHATkY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Aug 2021 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhHATkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Aug 2021 15:40:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5AC0613D3;
        Sun,  1 Aug 2021 12:40:15 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t66so14809365qkb.0;
        Sun, 01 Aug 2021 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUoCjxVUE34s1+eP3pk70mRzAMWsM0v+FDRsaXLy0ew=;
        b=QDDOb/9OIR5QbnjGLnasWpaABwJPXE0AHCUYUfFL+4gH6ZAkzkWqYQeZlasfXUww2T
         1V88mA9k579I96q7Py7KxCHOqbkSf11hYsJAic42zRSqFyDVxkeFVkQQbKuP928/JzJE
         mH9E21tp61MfIrK4Tv+EAo0eB6rcXT+TWEf4cADcqEZTb1C5VqG0gBzMSIiTSc3W3mVq
         nhD0r31jSeXx6A+tz/aFaRU0g8gZV8Un8dN/rUscuWoK62ntH0VE1dKLP3Hfh7O+9tlt
         b14hB/aq0tSdszzphrqBExqAtQ3nJRu62nyeI/EPN0+ku/C6W/7WN6x+xzOzXanonRcK
         pkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUoCjxVUE34s1+eP3pk70mRzAMWsM0v+FDRsaXLy0ew=;
        b=eOkWoJ/6xJoLAxn8O4XNfmKNiRywJ6ZQ+xbuxA3jTGlkdmZaHUT4hfAwajv0xhIcr6
         QrmsZDw51+eVZUKyeTk1dhBitdFCq3QLxRIozRSLJrJgCXLeR5VzV2nA5nP/gIam/mRB
         OR8TBFPuwSrugQIvOdV2+IQ+/vMzq5p0jnX1f+inVl11CwtYeIIBRb3/LmqgtpUYvlWB
         mu/f8ZyzBpspGoSGVR7N+7qdKLhbt0EmJsXhAFPaUCrxKmzHFKL6YTAVtWLY6CkiLO3r
         MFgvi3EkB0i8lEwNFm6GN90o/1N5q23j5mZdcps+AGJv2Nj5fNCsZhRQWTzH989VJK+Z
         GnLA==
X-Gm-Message-State: AOAM533ZoakV3uu+RrzKXSkcJjl/ro9spJzaU/j5NheyxEQNHlUEJsp7
        lKWEP8OmsKnkkM2P5PXLPJk=
X-Google-Smtp-Source: ABdhPJx9jtb7xZ3DQDx0IG0OCowA0LBaHciXzQzT6REPvulK/Hk+2niVhsK9ROrB8Y8GhDEXMfPJNg==
X-Received: by 2002:a37:90d:: with SMTP id 13mr12315643qkj.386.1627846814549;
        Sun, 01 Aug 2021 12:40:14 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f10sm3621606qto.31.2021.08.01.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:40:14 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v7 04/13] iio: afe: rescale: expose scale processing function
Date:   Sun,  1 Aug 2021 15:39:51 -0400
Message-Id: <20210801194000.3646303-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210801194000.3646303-1-liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
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
2.30.1.489.g328c10930387

