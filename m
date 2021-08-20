Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184C23F347B
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 21:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbhHTTSq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 15:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbhHTTSm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 15:18:42 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1183C0617A8;
        Fri, 20 Aug 2021 12:17:58 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d2so8309244qto.6;
        Fri, 20 Aug 2021 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ioB7MyFdDko6W35L3sW/WaIL34HomRofFmeSWyl1lGI=;
        b=UL9y8qsS7dBsQupCho7pQ6w4Iz6lyOytA5TpZjyBEbTw/ndk2cxOVnTPgXuHe4jtul
         M0X5c8fCRwSOVI8OrByCwKPuv4LYlPFeupU6J4wbio1IdNBHi2YIxaRdk1qdt7PsdWC1
         ZF4Z4XvmrMCg72UngFfvGZxvraU93EAJ3UDeGKDqg/I0x7rAhpmNwO86ZJI0uXZjlNO/
         RyxlZeIzGvcK3NVhpE8sKTrtsQ8WDkUHYGeOcAcDAAVTO59BvoMn5il8xWmqjqB3aDi9
         XUj9rzckHIcLsBmWaZqFLhz2pfQWveekltAEQIn/fMWUB1IPLxsmSWG4c+jb/MdbbUEs
         qb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ioB7MyFdDko6W35L3sW/WaIL34HomRofFmeSWyl1lGI=;
        b=DOToeY3l9D43Qmef9bQX9Mc67OqsnVuqD1pwioAX+JYklpyxlzBMoEPUqE+4uYqab+
         Lrr53QhAjKifQkLGkHZBOsWi/YhVLpYAUue0u82kkMyNoDfdn1tdJ+RtZpyPKrYaczcc
         5jspEXMbVNIKG60p4KArsV+CjA/dAWTj53cXQ3IJ5Chha5BpnmnDMtnZfMhRBG4HIjHI
         yncnrGKX0JiIQq+/7F/p1G00fofEaEXkEn84KQT7s6nLJpk0bIsEleAXSmBzuZhoa8kH
         J54EHCkZb/dTNpBFASwD6FjzLU7KpZxR4fQGkndw1Qr+F46Yrv8qyj0Cr0EROGCHQjfK
         DvDQ==
X-Gm-Message-State: AOAM532F5GsMbAZDZpUbQhxgvLiLrgW2A2ue6xjVPKOvb5W/kaMICyg9
        HWJ26xnPl7x3tMYiUsTobsU=
X-Google-Smtp-Source: ABdhPJyQjGERmpW8lhJ6SWYktwHp3k/IiN8cu3bTgu8SstvymjPGIxfpQwoJBZqgC38+VCCW924YQg==
X-Received: by 2002:ac8:7491:: with SMTP id v17mr4184111qtq.291.1629487078198;
        Fri, 20 Aug 2021 12:17:58 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id o6sm3603869qkp.111.2021.08.20.12.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:17:57 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v8 06/14] iio: afe: rescale: add offset support
Date:   Fri, 20 Aug 2021 15:17:06 -0400
Message-Id: <20210820191714.69898-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210820191714.69898-1-liambeguin@gmail.com>
References: <20210820191714.69898-1-liambeguin@gmail.com>
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
index 8488f1d83527..48a8096f68ca 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -81,11 +81,46 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
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
@@ -112,6 +147,47 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
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
@@ -188,6 +264,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -352,6 +431,7 @@ static int rescale_probe(struct platform_device *pdev)
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
2.32.0.452.g940fe202adcb

