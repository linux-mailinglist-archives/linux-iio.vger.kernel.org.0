Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11251ADC59
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgDQLkl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730452AbgDQLkk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 07:40:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C232C061A0C
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2020 04:40:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so1704337ljd.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2020 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhmDZCtu+Fm5vZMBowuSgHazmx5rDHZk1tmwfRDitKM=;
        b=RZZaRpi8gWQG1wgvVw1SjeDt3fBJO6IUbms7KYFA8QlZ+s13bCT4KAmqdwUPZ8lHbi
         Z01grjlVT7k1mQ9HEPW0ku2V5alXNwL+tDnSAGW59v0Tdq/nx/5Po8aBXKkUU8c/rkNB
         5Snc4xw+oca1QtdnO82t5oHFoRJggPJssl7le2A1J31e4Yo8BhuoRMIa1BMeBGSSEM71
         oM/WzyREzsyjY/94NwA/c/bGcdFjUxmlmymo4+9qPTTsHqoqqYpDpAyhFGzZTQ16iVlw
         6c5IeXyme4+HP0B1wSN5iPMD9vK9Nc+hOQEiRVOPiJbGzC1nX0FDxKpR0OeVH1Oic9Pc
         3ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhmDZCtu+Fm5vZMBowuSgHazmx5rDHZk1tmwfRDitKM=;
        b=WfoKog5gMgoNTL0030Ea4q8rSaCj+KHQ5TVmhyG3kNGSjIrnse+mrhQR14D9qbZa/y
         Eh6Ni+yoqNcbaW1eoZ+5l/9g85hTqcJW22UdtlKFlKiaedw0+u+CgjbCXpcD/dU9NNGS
         uKxasBj7QLSTBVFPcnFpCOTlDIUNCHeIBHg0X03dcbr/SKAMEVeN+1RBlQt+ibXubra5
         1VFRdoy1caj6eiCqAlqyxGK3UMl6mbsnWVnrR9/buOLjgImnoE0CaIh0QIsxezH8Dvzt
         xMyZc8j2Z4erbkE9yEMXOjTN+5cmAI8hjf4VIuYh7dyUHqjnkJ13Z62ZZAOTy5Kf41ka
         fBuw==
X-Gm-Message-State: AGi0PuYEHLkIqEPxXM9K+XYHLPeTKPrYOlVxZsaqWbV+APNmTqWJbX1v
        rNLO716Qa8file20B+uBW86xmQ==
X-Google-Smtp-Source: APiQypJTFnI7d2Jl1UvXuhJNx+Zk9Xzq51U1c3/EqRmHjG0E42ZwxGFDGbja412Z8LwUAU4UPGhYpQ==
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr1720176lja.250.1587123638595;
        Fri, 17 Apr 2020 04:40:38 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id 78sm16256618ljf.76.2020.04.17.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 04:40:38 -0700 (PDT)
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
Subject: [PATCH 3/3 v3] iio: magnetometer: ak8974: Provide scaling
Date:   Fri, 17 Apr 2020 13:40:20 +0200
Message-Id: <20200417114020.31291-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200417114020.31291-1-linus.walleij@linaro.org>
References: <20200417114020.31291-1-linus.walleij@linaro.org>
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
index b8dbea119a67..f8410ac34316 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -608,6 +608,48 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
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
+			*val = 12 * 2;
+			/*
+			 * 12 bits are used
+			 * [ -2048 .. 2047 ] (manual page 20)
+			 * [ 0xf800 .. 0x07ff ]
+			 */
+			*val2 = 4096;
+			return IIO_VAL_FRACTIONAL;
+		case AK8974_WHOAMI_VALUE_HSCDTD008A:
+			/*
+			 * The datasheet for HSCDTF008A, page 3 specifies the
+			 * range of the sensor as +/- 2.4 mT per axis, which
+			 * corresponds to +/- 2400 uT = +/- 24 Gauss.
+			 */
+			*val = 24 * 2;
+			/*
+			 * 15 bits are used (set up in CTRL4)
+			 * [ -16384 .. 16383 ] (manual page 24)
+			 * [ 0xc000 .. 0x3fff ]
+			 */
+			*val2 = 32768;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			/* GUESSING +/- 12 Gauss */
+			*val = 12 * 2;
+			/* GUESSING 12 bits ADC */
+			*val2 = 4096;
+			return IIO_VAL_FRACTIONAL;
+		}
+		break;
+	default:
+		/* Unknown request */
+		break;
 	}
 
 	return -EINVAL;
@@ -672,7 +714,8 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
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

