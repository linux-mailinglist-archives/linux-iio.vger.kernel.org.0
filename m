Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC001B1749
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDTUkc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDTUkb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 16:40:31 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A6C061A0E
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 13:40:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z26so11556062ljz.11
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+vHbHPDXWO2KyltN0oHVXvvCaxZJYvjk+daKL1jRQg=;
        b=lL8jv7BBJcgAWWxjqfmxHRuLc+LEc6KifjaVt0NvzrW9XZ67F7gG6qO2AjNiXbdFpu
         i5R3j01rDHt3z/mceb/zxyE+RTNmpew/NZi2IjxAOHV0JbfC36r2aMFXWEEJWkciZqGV
         6evOJSpnQQTkJu3hq1hVYu2dqI67VFEkXMafccqLz8uOrTiJZFpek6kT9N3seaV3BiEB
         1+WbQVJabXkGx2E3Fr+O0M3r/Joy40EdyD69kvmS673ENldpiVXJtc8TS1E6+Bo9qP87
         cWbxyLGtrirnQNvBTp5v5A0OgvzMOR+yiLyDwIG+KBy07PAeDdmc5RNCrl2sR3QynQpc
         fzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+vHbHPDXWO2KyltN0oHVXvvCaxZJYvjk+daKL1jRQg=;
        b=Slt7mjhiyMDOoVZQ6ahkrES5c/2upXM+CJUCYl9vJdixmNcUI58iMocPDkzdQ2F2II
         PjWiwx2R+6TCMcGBwui+e0c/fM55uXrMRdlXRp23/TwuBtIqJagmEBjPWkZyNQOtouuZ
         iXQZPIJQ9yYIC0zpgOG7h7oB1p3znlN4oRP7eCOcolcvzHZyJB62wsWjlTGQZX441Tt3
         Hm0OjrEJIWlPn/mkJssIKkT3hVyjjXEcqVB38fP1sc2nhm7gasEbEdSC+53UscyrYn/o
         H6zR88Yfjcatj/MkLhW1mB3OpA172RcaT3SQFxtGnH6AA3W5rdkdPSDFxB5fwFxcw6P7
         4bPw==
X-Gm-Message-State: AGi0PuYqCS5/VCLlJhisAzFcQvlZ/w2wBAA5CWKCxWd00Q1793N1fYvf
        1dlgnTDIbj/xBB4obv/GvhcMvg==
X-Google-Smtp-Source: APiQypI9l0uGHPWRg+ZpH8uWLlpt6agKj6OmqGdfFjnStlaksoKJ229ep147HVuklcXe+j8SZfp1xw==
X-Received: by 2002:a2e:b0ca:: with SMTP id g10mr11485118ljl.169.1587415229894;
        Mon, 20 Apr 2020 13:40:29 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id y22sm336637lfg.92.2020.04.20.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:40:29 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/3 v4] iio: magnetometer: ak8974: Provide scaling
Date:   Mon, 20 Apr 2020 22:40:22 +0200
Message-Id: <20200420204022.18235-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420204022.18235-1-linus.walleij@linaro.org>
References: <20200420204022.18235-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The manual for the HSCDTD008A gives us a scaling for the
three axis as +/- 2.4mT (24 Gauss) per axis.

The manual for the AMI305 and AMI306 gives us a scaling
for the three axis as +/- 12 Gauss per axis.

Tests with the HSCDTD008A sensor, cat the raw values:
$ cat in_magn_*_raw
raw
45
189
-19

The scaling factor in in_magn_*_scale is 0.001464843,
which gives:
0.065 Gauss
0.277 Gauss
-0.027 Gauss

The earths magnetic field is in the range of 0.25 to 0.65
Gauss on the surface according to Wikipedia, so these
seem like reasonable values.

Again we are guessing that the AK8974 has a 12 bit ADC,
based on the similarity with AMI305 and AMI306.

Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Do not multiply the range with 2, instead divide by
  two in divisor and dividend. (Thus it becomes 2^11
  and 2^14 respectively.)
- Use the IIO_VAL_FRACTIONAL_LOG2 trick and pass 2^11
  or 2^14 as range.
ChangeLog v2->v3:
- Scale the 2.4mT/24Gauss to 15 bits for the HSCDTD008A.
- Scale the 12 Gauss to 12 bits for the AMI305/AMI306
- Use 12 bits for the other variants.
- Return directly in the raw read function.
ChangeLog v1->v2:
- Split out the measurement refactoring.
---
 drivers/iio/magnetometer/ak8974.c | 45 ++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index fb6d84b79a7a..2d500be9da40 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -606,6 +606,48 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (ak8974->variant) {
+		case AK8974_WHOAMI_VALUE_AMI306:
+		case AK8974_WHOAMI_VALUE_AMI305:
+			/*
+			 * The datasheet for AMI305 and AMI306, page 6
+			 * specifies the range of the sensor to be
+			 * +/- 12 Gauss.
+			 */
+			*val = 12;
+			/*
+			 * 12 bits are used, +/- 2^11
+			 * [ -2048 .. 2047 ] (manual page 20)
+			 * [ 0xf800 .. 0x07ff ]
+			 */
+			*val2 = 11;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case AK8974_WHOAMI_VALUE_HSCDTD008A:
+			/*
+			 * The datasheet for HSCDTF008A, page 3 specifies the
+			 * range of the sensor as +/- 2.4 mT per axis, which
+			 * corresponds to +/- 2400 uT = +/- 24 Gauss.
+			 */
+			*val = 24;
+			/*
+			 * 15 bits are used (set up in CTRL4), +/- 2^14
+			 * [ -16384 .. 16383 ] (manual page 24)
+			 * [ 0xc000 .. 0x3fff ]
+			 */
+			*val2 = 14;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			/* GUESSING +/- 12 Gauss */
+			*val = 12;
+			/* GUESSING 12 bits ADC +/- 2^11 */
+			*val2 = 11;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		}
+		break;
+	default:
+		/* Unknown request */
+		break;
 	}
 
 	return -EINVAL;
@@ -670,7 +712,8 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			BIT(IIO_CHAN_INFO_SCALE),			\
 		.ext_info = ak8974_ext_info,				\
 		.address = index,					\
 		.scan_index = index,					\
-- 
2.21.1

