Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F64387521
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 11:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbhERJbD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 05:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbhERJbC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 05:31:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4638C061573
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 02:29:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i9so13092965lfe.13
        for <linux-iio@vger.kernel.org>; Tue, 18 May 2021 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPHZBTEJiLrGu25r8+NeThUWUSS4gXYfw5o17+dbPL8=;
        b=dUuFWOypglnl5B0YIcZYIhpftlFaKhiP52oThd3T9d1GUZITlmdDXHCJbiOUnwqH5f
         Ja+ITsNuaG2wu+HrEQT3T9P879Cf5gW5tdvlRKxPyYSmNYF7w+f1EBaUTUykNwctGl4U
         R44yG4WR4fJG2xz9qLav5QmjpLq/rdWKHL1xCxo7F4cfsiq3eGAlTlTyb3yx9Sd0Rjor
         hr+9V1zDsMLNc9/nFxHU2RpCBIhbguc+BBzOTEOpI55luv6QWwono3+9+Z9p2ErKUOhh
         d7Z0b8yPfXJ0gyagE5gzlxT8PVnuJ7jENB4zKqAusgvurQA5kOiU4QALRhC5iY+WrME/
         AeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FPHZBTEJiLrGu25r8+NeThUWUSS4gXYfw5o17+dbPL8=;
        b=SXmQCSe/B9UYjfYS4VWFm8hOpSnE7F9O399uU59grMY9AS4YvjqnGX9f88dmcTiuOr
         +aYaVxBUJS5Vau7QjeFbahEV9s6f2TapG2ZfERJ1reXjKDz1F+Mz0E5680tByOwPmuk6
         cnZg/QsJ8zHG8WREprovvkOKYbghxUq+I4p7nM4liOrH3bNmxm0BKR32p02yIJY0dqg5
         nanszA5Uqr9s0o8kzVkFqImvma6StvPZ4elP5zno/+C7SB+kBX7+2uifzUTkAH2WARbm
         0+C5sCjTjRWkRkud/0A3V2fOMW5tSzKzYfa0XLo/p4q6lrjjCuMfemtI2Kc7DL6TjBF5
         eCAA==
X-Gm-Message-State: AOAM533HyLyxxygxw7/PX9HLLt8M9An7TNzQCUhidALpyQudw92e7TPS
        XTz4ouoXbrHI0HXTfLl6A7eb+KoJJ89CrA==
X-Google-Smtp-Source: ABdhPJxa6C+nRQHKIBv/sjbIucjOC9pGZZ7T0MwzZDItP6HkaPNCStxhN6g3Q/QI8EPfrmqFBeCViQ==
X-Received: by 2002:a05:6512:3c8:: with SMTP id w8mr3609919lfp.63.1621330183321;
        Tue, 18 May 2021 02:29:43 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id h10sm3247795ljl.11.2021.05.18.02.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:29:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v3] iio: afe: iio-rescale: Support processed channels
Date:   Tue, 18 May 2021 11:27:41 +0200
Message-Id: <20210518092741.403080-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
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
ChangeLog v2->v3:
- Reverse logic on raw+rescale vs processed channels.
- Make sure to not announce .read_avail() when using a processed
  channel.
ChangeLog v1->v2:
- Deny calls to .read_avail() for processed channels, and
  insert a comment.
- Move an assignment of IIO_VAL_FRACTIONAL down to the end
  of the block for better readability.
---
 drivers/iio/afe/iio-rescale.c | 41 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e42ea2b1707d..774eb3044edd 100644
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
@@ -130,16 +148,27 @@ static int rescale_configure_channel(struct device *dev,
 	chan->ext_info = rescale->ext_info;
 	chan->type = rescale->cfg->type;
 
-	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
-	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_err(dev, "source channel does not support raw/scale\n");
+	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
+	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
+		dev_info(dev, "using raw+scale source channel\n");
+	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
+		dev_info(dev, "using processed channel\n");
+		rescale->chan_processed = true;
+	} else {
+		dev_err(dev, "source channel is not supported\n");
 		return -EINVAL;
 	}
 
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
-	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
+	/*
+	 * Using .read_avail() is fringe to begin with and makes no sense
+	 * whatsoever for processed channels, so we make sure that this cannot
+	 * be called on a processed channel.
+	 */
+	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW) &&
+	    !rescale->chan_processed)
 		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
 
 	return 0;
-- 
2.31.1

