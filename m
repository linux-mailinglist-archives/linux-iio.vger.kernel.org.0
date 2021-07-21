Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9243D0728
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jul 2021 05:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhGUC0l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 22:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhGUC02 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 22:26:28 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D40BC061762;
        Tue, 20 Jul 2021 20:07:06 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z25so997092qto.12;
        Tue, 20 Jul 2021 20:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYrh4kaa4Okjc79DXSnbAcrxZZJ0CDhm5w5KA6D2OhM=;
        b=Sx9OkTxPKPPDLdIBE6qOVMDwShaNhmBM6IZbVRkWVJIgJtYCJP86doprveTqXzSkXa
         gym2uSap8ZaKIMjgBT849hP5HK5czDTcc3z62RC22axHH8jW/iI7IyiUqRw9MdUm7nY5
         KbP16XrM1bfk7gvua/Nmnzsl/z3tNUmGeqCuD2R9R5bZPr6mTsX3xbTkrt256iM+Ln0O
         pS+FmVSDpoxQDiOqBSZmASehcOIR5THBAcypNjnVjgZrrWw+Mer9sGzjdAuwnwlkQY3Q
         4v2THuxUzFFnjcMmKrfqz3qSWOT0fvMBpy7c1laa/4ZJOq26aE7PZIMVh3HKpusJz8E9
         f20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYrh4kaa4Okjc79DXSnbAcrxZZJ0CDhm5w5KA6D2OhM=;
        b=r13vGe+O3StLoAvW/Sb7AseYHgn1GZcN4TCQDBhmHEoh+NyMTYuj1wfMANu7Nw3KJA
         uhoEKCIVY6NyvUB3sVg0fsrKpkeKyc/2HqH0u6UZMwlhYZ7s2v2J2Hs3KUchrZoSwMZh
         j3Asl+Q76BCfgZOs7cqX276iozTSiEATQbC1sw5L5Wn/O5yBV2UoxdBYgYpZDa6Glxtl
         r9VNo5rpwH/28aIrqJoSGLO1wG54jiT8ep76XuU59HSXBkkG10CpdMOYY2BgV3dd/mQm
         KA3W1L5bclFVxvEooNc2xdoO5Vn0xqevWcq5ek+4MiojnUhtrZgpBLF+P+lH0WfAyj79
         N2XA==
X-Gm-Message-State: AOAM533HadcfP0WVQc84w0a4Ixg86gQjgF4iPo81Y8ibB4+bMaVvi7xl
        Iva+LmiUignmTjGjgPxCqY0=
X-Google-Smtp-Source: ABdhPJytsST9J8qOzA8XJUYzfR7Lku2lI9p5Wqnumlj7ulsKCqRvnsOEXFXuPWUJPxaqfIhh5g2hGw==
X-Received: by 2002:ac8:76da:: with SMTP id q26mr16774969qtr.183.1626836825368;
        Tue, 20 Jul 2021 20:07:05 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g76sm10561024qke.127.2021.07.20.20.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 20:07:05 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 06/13] iio: afe: rescale: add offset support
Date:   Tue, 20 Jul 2021 23:06:06 -0400
Message-Id: <20210721030613.3105327-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210721030613.3105327-1-liambeguin@gmail.com>
References: <20210721030613.3105327-1-liambeguin@gmail.com>
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
 drivers/iio/afe/iio-rescale.c   | 80 +++++++++++++++++++++++++++++++++
 include/linux/iio/afe/rescale.h |  4 ++
 2 files changed, 84 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 2b73047365cc..6f6a711ae3ae 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -60,11 +60,46 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 	}
 }
 
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2)
+{
+	s64 tmp, tmp2;
+
+	switch (scale_type) {
+	case IIO_VAL_FRACTIONAL:
+		tmp = (s64)rescale->offset * scale2;
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT:
+		*val = div_s64(rescale->offset, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = (s64)rescale->offset * (1 << scale2);
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_NANO:
+		tmp = (s64)rescale->offset * 1000000000;
+		tmp2 = ((s64)scale * 1000000000L) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_MICRO:
+		tmp = (s64)rescale->offset * 1000000L;
+		tmp2 = ((s64)scale * 1000000L) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
+	int scale, scale2;
+	int schan_off = 0;
 	int ret;
 
 	switch (mask) {
@@ -91,6 +126,47 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			ret = iio_read_channel_scale(rescale->source, val, val2);
 		}
 		return rescale_process_scale(rescale, ret, val, val2);
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
+		return rescale_process_offset(rescale, ret, scale, scale2,
+					      schan_off, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -167,6 +243,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -331,6 +410,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
index 14d4ee1227c6..b152ac487403 100644
--- a/include/linux/iio/afe/rescale.h
+++ b/include/linux/iio/afe/rescale.h
@@ -23,8 +23,12 @@ struct rescale {
 	bool chan_processed;
 	s32 numerator;
 	s32 denominator;
+	s32 offset;
 };
 
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2);
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2);
 #endif /* __IIO_RESCALE_H__ */
-- 
2.30.1.489.g328c10930387

