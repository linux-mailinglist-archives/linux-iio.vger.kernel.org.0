Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA223B8B89
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 03:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhGABDf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Jun 2021 21:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhGABDX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jun 2021 21:03:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFCC061756;
        Wed, 30 Jun 2021 18:00:52 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q16so4438454qke.10;
        Wed, 30 Jun 2021 18:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=816EyhVOKf76HumLoBV1Mqb1SVwEpqWr1yvDp2TFTUA=;
        b=sfzQfscnADhErtx2+cWwR9oMC4WjegDil8fd2qjxXOQc1s3Lsx9MW0CjZ7x+1sgEev
         cfummlR85/udX/Hdbat3Plua/nhmv/qMPs8PLNgjCV1b9efWYUEGg6b7mtBE430HVsHV
         lPcifbfiUgvKqEXI+TqvDBzE8mD0+DpE/zPCugSumDtjT/GQXJNABZeKf2rZCbxDbUsB
         x666Q1zzs3bLThwEq2SOwGRx+nJoupnbG87Cc4bvV2muRNL8S8o7Dr2MU95mfJGZM89A
         hhXm7nmKmNbh6rq65IV5msf24AWkhMzAShrg/wWT8CGOaftUiJAtZsj57bOubaywg2Nb
         RQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=816EyhVOKf76HumLoBV1Mqb1SVwEpqWr1yvDp2TFTUA=;
        b=IZ4ZOs9yk7iIxzPk1cb8LMKZhp0WdoJ9oIjskbsfPjwPf6I/Ic37zWxosSZTHSLyY+
         Go8lJus2LXTJaWuxo/59HX9KedKcBpuQloqSVOl0CrVk5sNgR4M9dkD5iOK23udoC9VD
         sdl+zx9EAXWBdmiVWP8W/fuxyx+9YUoOoA98RQmZWUvBJr69IOJuqpuRKdJKpAiyAMZw
         pu7k3nx4+VNwmMo3dP+coo77l8SjDoRYA+C3yu1y831ISEIMnxFHYhmWqJwmbQRdVPTO
         n6oGZZab6Y3lmW6tY7H8kNeD2S+1cp34QEtqVdisVcF3ops019AUfSg6RDPjC2C+tFwx
         wM3A==
X-Gm-Message-State: AOAM530oqhTDE+FrLN5Q+AdW8GGuj693ufGPb/rE+kHMYvRPI1QiQXfy
        F8m55tanBB/w/RkqxnR0I3M=
X-Google-Smtp-Source: ABdhPJxuCjqJRtqYqYf+Qteteb3wkAPIeVePbauryi4RpigmPWLKoGu/Pv+tvJWVW8ULSaviJENp6g==
X-Received: by 2002:a37:44cc:: with SMTP id r195mr39106574qka.478.1625101251990;
        Wed, 30 Jun 2021 18:00:51 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l127sm14087782qkc.64.2021.06.30.18.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 18:00:51 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 06/10] iio: afe: rescale: add offset support
Date:   Wed, 30 Jun 2021 21:00:30 -0400
Message-Id: <20210701010034.303088-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210701010034.303088-1-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
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
 drivers/iio/afe/iio-rescale.c | 63 +++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 8f79c582519c..c8750286c308 100644
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
@@ -99,6 +102,62 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
 			return -EOPNOTSUPP;
 		}
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * Processed channels are scaled 1-to-1 and source offset is
+		 * already taken into account.
+		 *
+		 * In other cases, the final offset value is defined by:
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
+			if (ret < 0)
+				return ret;
+			else if (ret != IIO_VAL_INT)
+				return -EOPNOTSUPP;
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
+			factor = gcd(tmp, tmp2);
+			tmp /= factor;
+			tmp2 /= factor;
+			*val = div_s64(tmp, tmp2) + schan_off;
+			return IIO_VAL_INT;
+		case IIO_VAL_INT_PLUS_MICRO:
+			tmp = (s64)rescale->offset * 1000000UL;
+			tmp2 = ((s64)scale * 1000000UL) + scale2;
+			factor = gcd(tmp, tmp2);
+			tmp /= factor;
+			tmp2 /= factor;
+			*val = div_s64(tmp, tmp2) + schan_off;
+			return IIO_VAL_INT;
+		default:
+			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
+			return -EOPNOTSUPP;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -175,6 +234,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+	    chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -339,6 +401,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
-- 
2.30.1.489.g328c10930387

