Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC82B39DF19
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhFGOtf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFGOte (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:49:34 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523BC061787;
        Mon,  7 Jun 2021 07:47:34 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f70so1675758qke.13;
        Mon, 07 Jun 2021 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k0QcvidbL1EkpC0ADnabrDOPyyFA7QVFwo89YZJrlhw=;
        b=PYU9eVNS6qk+kagcYVWqTePLz24howwjBgj5kwdzhiRq0xHmO0G7JI9Ayn8L0ivo5J
         LW3p2h/sqv9l0MRtDd4Dj/cgcYFZJ1BADX65Er2shytNDJjYgmZ5ZT3xu0UrmpC/ipGq
         49MGfO2qcJATrR53dGb4dUU1hxc4AR+5SdM4yj5NKHkq221qnh5bmYoCVWUsySOgeLJA
         9hSJCJpeSRVMVivXCzwezwPN0+Mkr3zMx0g4Muw+iA+2ckrHY+blrZ8U/2o9rhjSaT6T
         vN07xIGstTXxtuyCyDPpztS0My7J2sJcoLkVkHEX2G/SC0VWqtKXI05GNC8E4dYZtYF1
         N1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k0QcvidbL1EkpC0ADnabrDOPyyFA7QVFwo89YZJrlhw=;
        b=djLWAHekvUKCoPcrrF+5Z5csgytSMEf3NHUMfcNBc6/NEbV4XcAMG1Cvmpxv4z/WgS
         w1Mpdjvf6OlndgZIsKQAXim7qOvxM5B8QadKnLmhISa96VH8dYq7LDPeqE9oKLSEca9Q
         LWcu8URRa93tvPUBV1kLVbp4QftSooCjiJUrPkmcFWkKP0RiFND3OgeThjwjdsYUGWwI
         +xTt+vbm05Ux5XC+cucnpTnfBIS8ZGYqtwbUeUgMcIqN1g66aX2dkXaJr3Pu+dl50n4H
         sjCWndE+jT3Bkgi+/6cnh4L4NS0z384atBjF7xwt8Uglf3FzZAD9juAlQnIXtKCq+Vox
         8x1w==
X-Gm-Message-State: AOAM533kDjPGgV1cSI+U3c/h00Jde8jckh7fqHI3xyMJaWwN5VYzPNIH
        /QeIUTo70vl6abDc31yEBSE=
X-Google-Smtp-Source: ABdhPJzUrNsbhEpscMTaVIHpgl7rINAj7Xj0ErbZgeHBwWFVD1Rhp4X5I7CERLYfAv/uCxeiZk5iQg==
X-Received: by 2002:a37:e312:: with SMTP id y18mr16543582qki.39.1623077254100;
        Mon, 07 Jun 2021 07:47:34 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:33 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 6/8] iio: afe: rescale: add offset support
Date:   Mon,  7 Jun 2021 10:47:16 -0400
Message-Id: <20210607144718.1724413-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
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
 drivers/iio/afe/iio-rescale.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e34148d39b39..3d445c76dbb2 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -32,6 +32,7 @@ struct rescale {
 	bool chan_processed;
 	s32 numerator;
 	s32 denominator;
+	s32 offset;
 };
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
@@ -86,6 +87,10 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EOPNOTSUPP;
 		}
+	case IIO_CHAN_INFO_OFFSET:
+		*val = rescale->offset;
+
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -165,6 +170,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+	    chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -329,6 +337,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
-- 
2.30.1.489.g328c10930387

