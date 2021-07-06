Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7572A3BDB21
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhGFQMp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhGFQMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:39 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7AC0613DB;
        Tue,  6 Jul 2021 09:09:55 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id w5so9967525qvu.10;
        Tue, 06 Jul 2021 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D81pHYY9yUEhsRTAhZj3nTjKb2wFBFB7qiFvu4YjemA=;
        b=rW5rzAYGnvHaDagYm5Qp14n0N9osr/o0qshDyXcyYoaL22KUx5DtsvrZ0V1jRIDF5b
         Ucm76w7h3PjsPPwD/Wl8Msak/8BV5yFyMYMhXJoihnkKuD37wDy7rxP8KjskpERSs4fQ
         LaBNBRda7mXgnepvctO4uBvQfAKOFEpu6qvIgh59uktBphxzSUFSbdTXN/7jVxYZ1lX6
         cejtN3sY9pOnjd4SHM7eoQ3S0JA08tZs8JDmadd1kGGZRMEp5aLtxxVdqU9HBsdK/4qr
         Q+WNbuqR4nViCgyNxm+jX/hD6FCFMiqNcmS6OtU+naOw2jM8jMhe6e42BY0irGRD3X7i
         sAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D81pHYY9yUEhsRTAhZj3nTjKb2wFBFB7qiFvu4YjemA=;
        b=MKX6AZlgzDIWquR3ymM61bDHJtLmiYktkjmNLD2dsAoVvUNzngKrRQlm0cybMzUmxU
         QIfZWMDGTZjgGAALogSAxhFDkoWokmemE34qtsidy4JFI5tjzwXrplY2bUqPMZwyGg//
         udunwTIp9zpYxO4iuYiMAhyWCbdP8VYSMUqj/FBSlIK3BDKELuKRN3H6EjiCuzqIuCSw
         ynHHAEsxsE/Cx2f2qCUpf6PnlnZV+YkozUlEg9oh7tgh8l9SVKewnVfhMkuOT/aLh7UQ
         +CZ8c5+BS2ysO9fRk/vXuKp3jBZc8D/FryiJmD6t/XqsCTFAR8SSu+dvCFZmVrPjkvX8
         K6fw==
X-Gm-Message-State: AOAM533e1+b66w1nJzF5nP+2b4W4zJrtE6SwMa81o6cZyuVb6LAFUY63
        gCW/viEZhYQNLUWvcWtDicU=
X-Google-Smtp-Source: ABdhPJwZbp0uikDx06Z9stzIw6EGbH+gVsvGovd2mRn8vq2DHMfULg62s274VF9kUkyKNtjNtchBrA==
X-Received: by 2002:a05:6214:d49:: with SMTP id 9mr19301224qvr.30.1625587794889;
        Tue, 06 Jul 2021 09:09:54 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:54 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 06/10] iio: afe: rescale: add offset support
Date:   Tue,  6 Jul 2021 12:09:38 -0400
Message-Id: <20210706160942.3181474-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

This is a preparatory change required for the addition of temperature
sensing front ends.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 1d0e24145d87..7b241e0d8638 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -32,6 +32,7 @@ struct rescale {
 	bool chan_processed;
 	s32 numerator;
 	s32 denominator;
+	s32 offset;
 };
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
@@ -39,6 +40,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
+	int scale, scale2;
+	int schan_off = 0;
 	s64 tmp, tmp2;
 	u32 factor;
 	int ret;
@@ -100,6 +103,71 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
 			return -EOPNOTSUPP;
 		}
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * Processed channels are scaled 1-to-1 and source offset is
+		 * already taken into account.
+		 *
+		 * In other cases, real world measurement are expressed as:
+		 *
+		 *	schan_scale * (raw + schan_offset)
+		 *
+		 * Given that the rescaler parameters are applied recursively:
+		 *
+		 *	rescaler_scale * (schan_scale * (raw + schan_offset) +
+		 *		rescaler_offset)
+		 *
+		 * Or,
+		 *
+		 *	(rescaler_scale * schan_scale) * (raw +
+		 *		(schan_offset +	rescaler_offset / schan_scale)
+		 *
+		 * Thus, reusing the original expression the parameters exposed
+		 * to userspace are:
+		 *
+		 *	scale = schan_scale * rescaler_scale
+		 *	offset = schan_offset + rescaler_offset / schan_scale
+		 */
+		if (rescale->chan_processed) {
+			*val = rescale->offset;
+			return IIO_VAL_INT;
+		}
+
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_OFFSET)) {
+			ret = iio_read_channel_offset(rescale->source,
+						      &schan_off, NULL);
+			if (ret != IIO_VAL_INT)
+				return ret < 0 ? ret : -EOPNOTSUPP;
+		}
+
+		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
+		switch (ret) {
+		case IIO_VAL_FRACTIONAL:
+			tmp = (s64)rescale->offset * scale2;
+			*val = div_s64(tmp, scale) + schan_off;
+			return IIO_VAL_INT;
+		case IIO_VAL_INT:
+			*val = div_s64(rescale->offset, scale) + schan_off;
+			return IIO_VAL_INT;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			tmp = (s64)rescale->offset * (1 << scale2);
+			*val = div_s64(tmp, scale) + schan_off;
+			return IIO_VAL_INT;
+		case IIO_VAL_INT_PLUS_NANO:
+			tmp = (s64)rescale->offset * 1000000000UL;
+			tmp2 = ((s64)scale * 1000000000UL) + scale2;
+			*val = div_s64(tmp, tmp2) + schan_off;
+			return IIO_VAL_INT;
+		case IIO_VAL_INT_PLUS_MICRO:
+			tmp = (s64)rescale->offset * 1000000UL;
+			tmp2 = ((s64)scale * 1000000UL) + scale2;
+			*val = div_s64(tmp, tmp2) + schan_off;
+			return IIO_VAL_INT;
+		default:
+			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
+			return -EOPNOTSUPP;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -176,6 +244,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+	    chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -340,6 +411,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
-- 
2.30.1.489.g328c10930387

