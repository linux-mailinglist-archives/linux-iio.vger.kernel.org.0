Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A062A2252
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgKAXWU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 18:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgKAXWU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 18:22:20 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699EC0617A6
        for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2020 15:22:18 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id t13so12957351ljk.12
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 15:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWKUUz0aQ9yMG5g7ViUKtA1/0fhBRnqKMspTZX/3WTc=;
        b=v32QmhR9P/1XHG6HF7M5Qi+6rnVH2vJszdFbQiI1znSLkvARi83YLGNBpOo0WJrenC
         HP+lNMvDRy6v2+zUKybCdJFN3L97Of3NkbdhDXlCKXTHfhHUyy6jyO9wobjhO1Q8Ntil
         niyoF7sIR6YKUmxVKXo18+AUPnnz2xrEs51SuTbEByOVHx0gMAlRAR005ChbrYD8UTQq
         6JSXk61G2Pb4W8CnE4uZl9l5ZDu/I2MoevtXtfoSshlXmzT0L/POzrEZNj/7R9sAQtKa
         QyXrNvxZB5G+0MpW5kkCqR+7IoCFdxDsxjpr7fdLM8mHywY1dk6nuRFC7q9dQCR1uWf+
         E0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWKUUz0aQ9yMG5g7ViUKtA1/0fhBRnqKMspTZX/3WTc=;
        b=HF372UoCZSX1tku/BHQJsZwfqT4vhqXk5Crb7D9IiBh2yKc3GLrk6C5qNTB0HQldnb
         j8c8p9YDBkwgAqNN1S0ZQih9E5cWTkY82+6RKloQGQ5F00ROlKErrGpGRnvBuj3NxxhI
         J6/tDr8vv0eyLNoI4Puw//oCiA6iXo1ioE/3putvk6UYYXz/XL5idJ2lYU69xiJxc6K0
         2nk1XKlLa23Nsk6Gc/pgQutz1yOCHC/XTnRxiZT41pX27l1D5pry5HB6DTeGO8P4J+9P
         6NsdP1spSsIvb+kJvUZe+6gmAYCcW98cl75kVVDab7syWc/cMZ8qLiwZEF2SDlb0q0Kq
         lyig==
X-Gm-Message-State: AOAM530CJ2R6KyqZSldQN8bLr7rZdoZCdY+wgS5x1qmRnQWsyhEjTClo
        0+3/xTTVHcR+ObcjP4d1W8uNCw==
X-Google-Smtp-Source: ABdhPJzJ5VzhxgNm9xt7B7qlNmZiRllzYG9Rl4lTnVcUxkkMs8UeZY6i5oN6yrYJzec+EUEgcxNS0A==
X-Received: by 2002:a05:651c:33c:: with SMTP id b28mr5783751ljp.365.1604272936617;
        Sun, 01 Nov 2020 15:22:16 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id g22sm1813178lfh.31.2020.11.01.15.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 15:22:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH]  iio: afe: iio-rescale: Support processed channels
Date:   Mon,  2 Nov 2020 00:22:11 +0100
Message-Id: <20201101232211.1194304-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
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

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/afe/iio-rescale.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e42ea2b1707d..ea90034cb257 100644
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
+			ret = IIO_VAL_FRACTIONAL;
+			*val = 1;
+			*val2 = 1;
+		} else {
+			ret = iio_read_channel_scale(rescale->source, val, val2);
+		}
 		switch (ret) {
 		case IIO_VAL_FRACTIONAL:
 			*val *= rescale->numerator;
@@ -132,8 +150,13 @@ static int rescale_configure_channel(struct device *dev,
 
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
2.26.2

