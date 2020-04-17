Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDDE1ADC54
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 13:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgDQLkg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730267AbgDQLkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 07:40:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3515C061A0C
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2020 04:40:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so1695418ljg.5
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2020 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H0He4yHG3n2CBvm3pcZAtcKxqAXCDkRb8KpkQKmp+ME=;
        b=jvDTJ2cnmXDZVZh4T/nNGFNhqwhkTC1dlf24M1388+kPGcWHVDh7wOOr+q9i64O6kS
         GrYU7/tiQZm+iq2tMOYh10j7KSMqt49a63NRgFUvh1+fy0kcLBIPqq3o6GflYaIvj1Xe
         lUdhsdPhuibVNzjf5bz2yYWOYWslsYTNY/y61zmOP8M8QpuqCo3Om7N8vcVOW5kTo9Rs
         Kr12cbczbHSHbODQDPe4MdlPHhVRmW2w6d/K875NwrQXbB/dQJjzb6Z7iSloy+/v8ljO
         h4JMs3ZAFHts6ZdmfgpEZZH5De85JgsATyRnKdlYSjOqSgFglRauV2wdDzM7O+6o8Qjj
         utwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H0He4yHG3n2CBvm3pcZAtcKxqAXCDkRb8KpkQKmp+ME=;
        b=WC8ghCh2zRE/QIaIcNnpsBVQ4SzF+3kbQiQiXbTY4v4nnuD/IJMH3tbVNSChxHro0J
         13tUnOzXO7SrqA5MPIYdUiuMzm95LaR9wIMKM5pUrhg+Q9L4eBXy6hGJe52q0kmGsxhw
         ri4prQIUdhsvOqrp9NfuAgvNU0O8i2jBRnoE7DXSg8ENAHMsyCrnwPv/Xc/rtfKC59Kp
         fZMWAFGT6CdBCShWv+9xh7jznpoBKjpZrzHBUcswHitYXyy0MTGryp/ZRgRfQ0wwJWhv
         RRXYH/cp2iDz+/zosc9VaJEByvFUTQ7s9nP8F+LpckDfC2uWY1QQXfVL8sJTmDBKWuLG
         YJjg==
X-Gm-Message-State: AGi0Pubj5Ib7MDDR0DzMIVUckXKhRhbDFx98CPyU2qWU4VHHXNI6GcEi
        197H6eETDC6ldyaeClB7R+OuoQ==
X-Google-Smtp-Source: APiQypLTkcYlIOqhtOoReDuoVY7p7oF1ILEo4hsxnJnJnW0+CHuWdJdi9PlR2X6DmznNUm7a9+isIQ==
X-Received: by 2002:a2e:8752:: with SMTP id q18mr1866387ljj.72.1587123634311;
        Fri, 17 Apr 2020 04:40:34 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id 78sm16256618ljf.76.2020.04.17.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 04:40:33 -0700 (PDT)
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
Subject: [PATCH 1/3 v3] iio: magnetometer: ak8974: Correct realbits
Date:   Fri, 17 Apr 2020 13:40:18 +0200
Message-Id: <20200417114020.31291-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The original AK8974 has 16 bits of actual value, while the
HSCDTD008A has 15 bits and the AMI305 and AMI306 has 12 bits.
Correct this by providing an extra parameter to the channel
macro and define a separate set of channels for each variant
of the chip. The resolution is the actual resolution of the
internal ADC of the chip.

The values are stored in a S16 in 2's complement so all 16
bits are used for storing (no shifting needed).

The AMI305, AMI306 and HSCDTD008A valid bits are picked from
respective datasheet.

My best educated guess is that AK8974 is also 12 bits. The
AK8973 is an 8 bit and earlier version, and the sibling
drivers AMI305 and AMI306 are 12 bits, so it makes sense
to assume that the AK8974 is also 12 bits.

Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v3:
- New patch in the v3 patch set.
---
 drivers/iio/magnetometer/ak8974.c | 53 +++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index ade4ed8f67d2..f22b40ef5661 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -651,7 +651,7 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
 	{ },
 };
 
-#define AK8974_AXIS_CHANNEL(axis, index)				\
+#define AK8974_AXIS_CHANNEL(axis, index, bits)				\
 	{								\
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
@@ -662,16 +662,42 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
-			.realbits = 16,					\
+			.realbits = bits,				\
 			.storagebits = 16,				\
 			.endianness = IIO_LE				\
 		},							\
 	}
 
+/*
+ * We have no datasheet for the AK8974 but we guess that its
+ * ADC is 12 bits.
+ */
 static const struct iio_chan_spec ak8974_channels[] = {
-	AK8974_AXIS_CHANNEL(X, 0),
-	AK8974_AXIS_CHANNEL(Y, 1),
-	AK8974_AXIS_CHANNEL(Z, 2),
+	AK8974_AXIS_CHANNEL(X, 0, 12),
+	AK8974_AXIS_CHANNEL(Y, 1, 12),
+	AK8974_AXIS_CHANNEL(Z, 2, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+/*
+ * The AMI305 and AMI306 have 12 bit ADC resolution according to
+ * datasheets.
+ */
+static const struct iio_chan_spec ami30x_channels[] = {
+	AK8974_AXIS_CHANNEL(X, 0, 12),
+	AK8974_AXIS_CHANNEL(Y, 1, 12),
+	AK8974_AXIS_CHANNEL(Z, 2, 12),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+/*
+ * The HSCDTD008A has 15 bits resolution the way we set it up
+ * in CTRL4.
+ */
+static const struct iio_chan_spec hscdtd008a_channels[] = {
+	AK8974_AXIS_CHANNEL(X, 0, 15),
+	AK8974_AXIS_CHANNEL(Y, 1, 15),
+	AK8974_AXIS_CHANNEL(Z, 2, 15),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
@@ -815,8 +841,21 @@ static int ak8974_probe(struct i2c_client *i2c,
 	pm_runtime_put(&i2c->dev);
 
 	indio_dev->dev.parent = &i2c->dev;
-	indio_dev->channels = ak8974_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ak8974_channels);
+	switch (ak8974->variant) {
+	case AK8974_WHOAMI_VALUE_AMI306:
+	case AK8974_WHOAMI_VALUE_AMI305:
+		indio_dev->channels = ami30x_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ami30x_channels);
+		break;
+	case AK8974_WHOAMI_VALUE_HSCDTD008A:
+		indio_dev->channels = hscdtd008a_channels;
+		indio_dev->num_channels = ARRAY_SIZE(hscdtd008a_channels);
+		break;
+	default:
+		indio_dev->channels = ak8974_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ak8974_channels);
+		break;
+	}
 	indio_dev->info = &ak8974_info;
 	indio_dev->available_scan_masks = ak8974_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.21.1

