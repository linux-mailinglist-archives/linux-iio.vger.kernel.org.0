Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09CB3D072C
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhGUC0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhGUC00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:26 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B4EC061762;
        Tue, 20 Jul 2021 20:07:04 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h9so322377qvs.0;
        Tue, 20 Jul 2021 20:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUoCjxVUE34s1+eP3pk70mRzAMWsM0v+FDRsaXLy0ew=;
        b=O+4oPdsTBvXGRKuCjChd/jvK/2guiWMgnD0KnXzOxTTNHJ0a0g96YeOnzvaXVB2zTS
         3NVJXeXOcyXtbIczvSmDhW1IVpOYh65QFek85KLh+OIlWbIOm5BOmjyM/I0271dELFZY
         6Uqyx9p9RRF/1mp5oKa2wPKjZDe/f8omgihf9JGZ+gHry/zLdJSnWV4vovMwj65YnRsr
         YBrHwffVZw1/PlGxEHGVo5hyvqoormKeDjxePVbODkQ67/8j1Gv+BeCeDZ5mUTJCydRY
         CmxlI/MkNKuw0BcjWgDcWIoLkO8mjgI4OjKLIK0eq+PcyulXKnDwQx7kSEnkTri0W5Gf
         tMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUoCjxVUE34s1+eP3pk70mRzAMWsM0v+FDRsaXLy0ew=;
        b=WdQmArVV5tqfpKwY+Z+dLaeA8GLZ1E/77yep0s/Mu4Ra4gQi4w+RRzXOXwmdtNbxcF
         qlOxMoZ/PtsL6WHGcvWPhCzedrrF3xQv0hwC5TtdzzZtYALB+h5jQruZapG4mD4MTLZP
         1AmTex0lwX2Mqvg3LHFa/FxkPYUfRRNsWBGyepsQ7aFZG0Yd6PQn4LjSt1RuK/u2zTQJ
         RNiddk4Iw/zY+GMMM2UbASg+b2eUe5murd8sxaZ2/Oc+DaQgMiKoV7w4jbZlNvdXbOms
         Wu4ets85OOBdJ9rHAw0YlLIFFnLep09ntkZYfhg7mcKvxvp2p3I22dchHgaLrIsUceBf
         6BCg==
X-Gm-Message-State: AOAM533v3+nDEzuOMzZzLBVizFQjD3UlBmHWf4iP4nIqrHwstlgTuLsf
        cO9NkpgdOaZWxBUXLT+GB60=
X-Google-Smtp-Source: ABdhPJxFvDK5NKxP4rXDqntI8iCputgTr+LprXy/hDbz61H6MJhqhY/teQ0KkpDziI0tjStQS09obQ==
X-Received: by 2002:ad4:5b86:: with SMTP id 6mr33667089qvp.17.1626836823490;
        Tue, 20 Jul 2021 20:07:03 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:03 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 04/13] iio: afe: rescale: expose scale processing function
Date:   Tue, 20 Jul 2021 23:06:04 -0400
Message-Id: <20210721030613.3105327-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
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

