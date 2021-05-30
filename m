Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298E6394EC4
	for <lists+linux-iio@lfdr.de>; Sun, 30 May 2021 02:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhE3BBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 May 2021 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhE3BBI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 May 2021 21:01:08 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF7C06174A;
        Sat, 29 May 2021 17:59:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j189so8019884qkf.2;
        Sat, 29 May 2021 17:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hVm9pTtY2i0FGIAWRsitMo3N5pAB6nyS8alNSxHtds=;
        b=tTexZy4YrLakNXtB0R8P3mygTszM9XOCbRMU0KudLyWCneN83W7Bo6wW/XoBcamLt2
         HqMloKHJg4hxUDy5ka3bFAtSRNA+5kaoWoxJuC6L6VtN5Pc3gw/N4TAXgMIVrCCYXIXr
         ct38/Au1nv5nPocWJg4IIK/qVPJZskSEI7lIsR7OGlC8m78OPPOe+s7AQ7TgnSLK0v8c
         d6hBbrF3QGzC5j2SVgONpHo94nyogO4J1OS3GSXUgS5xEk43Y1J8dhOGycLk16O/aDve
         /z4VdMxnaFxmTuvrg+cOddYrKydg6nLxxgQLw2MO3AdrRqOjXgjfqFS6lfkFVyyu+mku
         0+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hVm9pTtY2i0FGIAWRsitMo3N5pAB6nyS8alNSxHtds=;
        b=sq5m9cmandQQnJwgxnzWt9LDnzE/Xzf9gV9I9S5zKqwh4U2NmpTsjg2SfQmjX07iCf
         jWSqPSJNoVn09lFkOFUqrsFdmtti2MVKfuI0WqvVfnSpehYP7iPJCuHgqxyq4m7fpr1+
         3DMbBi8axjtttU6hYf32XEqRoS+IiQu4smazBtIcnDD5heOvHM3QzRV4qiopSS/HZUkP
         oxaGAROOwjkV1hY3VOobpppzTB5UW10nbPoqfjBEcRGTgYEKAus/0sIx39WRLnkegBeH
         7jiI/2DWGHlfvnka/dYleCAfZDeYYSOBDiRZ5Nu0v3Nfqrz9uHPn79whNXmO8d/pV0gT
         fIeQ==
X-Gm-Message-State: AOAM532e6mQrrEL0gd6SNykXTt/HQHbDn73kBM5xVO5yh7GJ4E/kap9u
        ISf+pcdGOuObvPgzOP+0YNE=
X-Google-Smtp-Source: ABdhPJxEfLkg2F2SR4BvCjoMfMctWceUCe0e79XTssWwYXa4+J+ROn+5rhiEvBNeuyvLwEnVpxxlEg==
X-Received: by 2002:a05:620a:745:: with SMTP id i5mr10737750qki.324.1622336370879;
        Sat, 29 May 2021 17:59:30 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id z1sm6382601qki.47.2021.05.29.17.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:59:30 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 3/9] iio: afe: rescale: use core to get processed value
Date:   Sat, 29 May 2021 20:59:11 -0400
Message-Id: <20210530005917.20953-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210530005917.20953-1-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Make use of the IIO core to compute the source channel's processed
value. This reduces duplication and will facilitate the addition of
offsets in the iio-rescale driver.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 37 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e42ea2b1707d..4d0813b274d1 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -38,36 +38,20 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return iio_read_channel_raw(rescale->source, val);
+		ret = iio_read_channel_processed(rescale->source, val);
 
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_read_channel_scale(rescale->source, val, val2);
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
+		*val = rescale->numerator;
+		if (rescale->denominator == 1)
+			return IIO_VAL_INT;
+		*val2 = rescale->denominator;
+
+		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EINVAL;
 	}
@@ -130,9 +114,8 @@ static int rescale_configure_channel(struct device *dev,
 	chan->ext_info = rescale->ext_info;
 	chan->type = rescale->cfg->type;
 
-	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
-	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_err(dev, "source channel does not support raw/scale\n");
+	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW)) {
+		dev_err(dev, "source channel does not support raw\n");
 		return -EINVAL;
 	}
 
-- 
2.30.1.489.g328c10930387

