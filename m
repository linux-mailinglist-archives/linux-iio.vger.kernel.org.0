Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C657D377920
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 00:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEIXAU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhEIXAU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 19:00:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721DC061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 15:59:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m11so4135949lfg.3
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LxAPd2ihQywuLdqe1+TQKAxDqCJ64Rh+8F6Q118rTc=;
        b=Fn+Ix9YUBDqJRriGHoBmtYD0yQUjJFG75ftp1hq8AXB3ZyPe7z1z+LOKrnx35JthDB
         YyecWCOks0aVs7vNEkF+Tdf8jKdvf6N0QnmeTV/WKJimRu6TRe2nIUp4qo+fUVgONjKl
         4d0ci6bIPOwfnpx97ech9Vwo3uXuKXxdkknY0SiQQ+9Va/jZX8sP+JuRDcgu4KWI84eU
         IMjDwQyOegqvPLK97KWnS4q9QnV+VWQ7GBFFLZsFeIbYvvkCVu3pXgBK/EiSpi1ShOe9
         mgtalePbdx9voyHGjQml3AneuCfco0RJIuG1V/jSgjCM7M+cfKm81ZsWM3aht32+Mc07
         qvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LxAPd2ihQywuLdqe1+TQKAxDqCJ64Rh+8F6Q118rTc=;
        b=Bpjkzx6gleBnS1v1BumMmCeZTvy/3gkF0uoGvMHeq4Fw6/3NvIhDYRCkDqI6A+s9eZ
         ccSF4FRZijW2TI9TWqEwjgjZrYdx5Iysn7R/mZxDNc4bDK0zXAGh2p+zT68Ji1bnh81k
         MjsUXB+1LZ+Z5pK0+w2IEdREIC57m0FtDgJBItdqskJevvUAj+B+e7Vc9K1Yb731NtFs
         xx45tQWDDYbSBdyA7J9REBroXUtBSAXpy4i1hZi4reem481AVgupmmKPazk6yADr5gRp
         cDqh4AjvvflbQgHsvRFrM3Izt2km33EkYut7SyWCWTWgpg+NO3Z63jNhroqDSlhhGu0s
         xXeg==
X-Gm-Message-State: AOAM532ONucT2NnccJXcg3bxKr5Q0dOueMZCot4UV2nbH4T1JweYko65
        7NHgk3nKZjF3V4xW42rKRM2jNw==
X-Google-Smtp-Source: ABdhPJxwJGEqHJaLAYWKbEioA/GNlmkdQWln1tC6LMXisOm8ZhynItzsqL6+7F3HKgOeMT0ffhOKTw==
X-Received: by 2002:a19:ad05:: with SMTP id t5mr14135247lfc.163.1620601154734;
        Sun, 09 May 2021 15:59:14 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id z20sm2048735lfq.218.2021.05.09.15.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 15:59:14 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v2] iio: afe: iio-rescale: Support processed channels
Date:   Mon, 10 May 2021 00:59:07 +0200
Message-Id: <20210509225907.351562-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It happens that an ADC will only provide raw or processed
voltage conversion channels. (adc/ab8500-gpadc.c).
On the Samsung GT-I9070 this is used for a light sensor
and current sense amplifier so we need to think of something.

The idea is to allow processed channels and scale them
with 1/1 and then the rescaler can modify the result
on top.

Link: https://lore.kernel.org/linux-iio/20201101232211.1194304-1-linus.walleij@linaro.org/
Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Deny calls to .read_avail() for processed channels, and
  insert a comment.
- Move an assignment of IIO_VAL_FRACTIONAL down to the end
  of the block for better readability.
---
 drivers/iio/afe/iio-rescale.c | 39 +++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e42ea2b1707d..ddbb760ae8df 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -29,6 +29,7 @@ struct rescale {
 	struct iio_channel *source;
 	struct iio_chan_spec chan;
 	struct iio_chan_spec_ext_info *ext_info;
+	bool chan_processed;
 	s32 numerator;
 	s32 denominator;
 };
@@ -43,10 +44,27 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return iio_read_channel_raw(rescale->source, val);
+		if (rescale->chan_processed)
+			/*
+			 * When only processed channels are supported, we
+			 * read the processed data and scale it by 1/1
+			 * augmented with whatever the rescaler has calculated.
+			 */
+			return iio_read_channel_processed(rescale->source, val);
+		else
+			return iio_read_channel_raw(rescale->source, val);
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_read_channel_scale(rescale->source, val, val2);
+		if (rescale->chan_processed) {
+			/*
+			 * Processed channels are scaled 1-to-1
+			 */
+			*val = 1;
+			*val2 = 1;
+			ret = IIO_VAL_FRACTIONAL;
+		} else {
+			ret = iio_read_channel_scale(rescale->source, val, val2);
+		}
 		switch (ret) {
 		case IIO_VAL_FRACTIONAL:
 			*val *= rescale->numerator;
@@ -82,6 +100,14 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		/*
+		 * Using .read_avail() is fringe to begin with and makes
+		 * no sense whatsoever for processed channels, so if called
+		 * on a processed channel, we just error out here.
+		 */
+		if (rescale->chan_processed)
+			return -EINVAL;
+
 		*type = IIO_VAL_INT;
 		return iio_read_avail_channel_raw(rescale->source,
 						  vals, length);
@@ -132,8 +158,13 @@ static int rescale_configure_channel(struct device *dev,
 
 	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
 	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_err(dev, "source channel does not support raw/scale\n");
-		return -EINVAL;
+		if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
+			dev_info(dev, "using processed channel\n");
+			rescale->chan_processed = true;
+		} else {
+			dev_err(dev, "source channel does not support raw+scale or processed data\n");
+			return -EINVAL;
+		}
 	}
 
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-- 
2.30.2

