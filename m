Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE43C963A
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 05:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbhGODPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 23:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhGODPg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 23:15:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69166C06175F;
        Wed, 14 Jul 2021 20:12:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w26so3513932qto.9;
        Wed, 14 Jul 2021 20:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XNdoHouTbgL9ckwPx58TUs8FmE0xoETBwUslKZabOY=;
        b=VStE3oWYpvsH48U/xml+kuTlGevL0rwqq7bhNpygxeyrTjODYNjxTlYNCmZTLhifHh
         tG9ty2oKrLkyxpTpsDln9HEBFrPYebP36iooBhqJhcGI8OS6urG8ff7gIdY4EPcvbDr3
         EdJnS9Dr12fG9x8C03ZM9iq6L7hrj0B5GvrPYZ6PXvs3qYUd05XZnEeH172vtE/OQguO
         CMlA9QuEiOUqftYz07rKHBx+SDW1naMTfVxh3Sowc8rP7nK4nShcM3h5lTkBdtLd2k+S
         NY55jMtKPYg74cdLvq/4v5WI+DzX5tTCtpxSfnOH3rUrVfufrJsWA6rB0OPQue1rULF3
         aWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XNdoHouTbgL9ckwPx58TUs8FmE0xoETBwUslKZabOY=;
        b=VRPiNM+pDzVfCup6ufsiqFDwlC/LEpbMn4xK65d91aklnZGxNqplYr/MXI2GO/GGJC
         zmNrOc7tgUB6O9S7NfLBEN7IpdOouODSWjEQCrN8LSkum2VkiKeDDQwP9wU1ttIHOgOP
         g4wq7HCWMH+0/pJOTiwHSb9r0kJ/CcH2R9tTaDLTIxQ/ygGwZf+OaWO4utQpjwvF5nfp
         wPVCW77njOR7YEZxILzT/GiIeF/FPalXLYZaW8iXgsmORTZD0QXskHPH3cgMYvBF/18Y
         m5i8mjla61UQeZIc+/KYfo5lsWnLiz4vmQOoD57tZ1LNmdwI2bnC3G3s4emAWmoC0rdZ
         BISg==
X-Gm-Message-State: AOAM530ycBh/VKSAMUDM6bWi+gb08fuO2qM33PDc8dLnfa9MioqYpkOE
        lgKvB/Y4reqJmOHLYhk6mn9fgsHj5FYJlg==
X-Google-Smtp-Source: ABdhPJyqyiyFs5WaONEmd+FpE1TsEqkfWFQlSj9+5F0kdICDGgtVho8Oa97ge2sgqHR7056WVj/+kg==
X-Received: by 2002:ac8:7388:: with SMTP id t8mr1619255qtp.96.1626318762640;
        Wed, 14 Jul 2021 20:12:42 -0700 (PDT)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id t125sm1932847qkf.41.2021.07.14.20.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 20:12:42 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 06/10] iio: afe: rescale: add offset support
Date:   Wed, 14 Jul 2021 23:12:11 -0400
Message-Id: <20210715031215.1534938-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210715031215.1534938-1-liambeguin@gmail.com>
References: <20210715031215.1534938-1-liambeguin@gmail.com>
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
index a2b220b5ba86..4d3b44884a89 100644
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
@@ -110,6 +113,71 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
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
@@ -186,6 +254,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+	    chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -350,6 +421,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
-- 
2.30.1.489.g328c10930387

