Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE091B1743
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDTUk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDTUk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 16:40:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D84FC061A0C
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 13:40:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k28so9194612lfe.10
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dug/S9RxcVtJcdC7Ie/848Ex7Mkp2l4OqdGz3YQ9qH0=;
        b=YvDlyCEzKawDYecvvgnqs+hhm4igZHsu1HexOQADd4dtUiPk2XQVs7xoiDdA4Lby3r
         wmmC1bifHQR387A/BkUUO4AEBvdf2u9+xrCt4nHrhpwUcO8NTo66jW3rtHYfQ1xUOUwM
         sMTlwS5nfSsKZb7eKnd5+elHOMjfir16KuADks97WZhlpmm3KyNfF3pSGmfOPBbuWzqE
         oR6TTUE48GlFf4QBKvHOxdvW+IyXuuOZPER91r3sFFL4AgyafqASqagurh/oaUAzZbDJ
         e9SQhT2l3Myuml4Y2a4vhKFbG4gJADJwVTX4LlPLGCNpkJAq4QjWdvUE8LA0CVs6W3Xw
         p+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dug/S9RxcVtJcdC7Ie/848Ex7Mkp2l4OqdGz3YQ9qH0=;
        b=ri15rAV9hna6RxH+K+b8UNmDe5AVj7eiFLqjTLdhD8P6eLMU2Vmb8/czlAYCbl2+yT
         BitepZM8fsLI0uKw1HWMWVQ3toUtBJtidPUb+XNcTFJCgv4AH07Ng6VHzJHzROl6lVY1
         P0IScFuxKeoAFeWCQfk6+6grujpYB6xfT5RDVqQsjsoxr9oxTD5Li077LIYNAwZdABi9
         V8RoqJbeuwY2j+KQtjst0808zyOF6CdfKhMKSuBsiEAWI2Wtkb7umLHcd/6fe+o1XWtk
         kU80CzLkpK+suDTCxN1LoK3rn2xldFrp/mrYZelEkvYNb8d95c2/RNGsE2xa2COsrYS5
         aNKA==
X-Gm-Message-State: AGi0PubvZI64Zz78IcMjiehHZdH4eAEBy9GG1U+tjH0+UXg9ktu1qTva
        cnZbQDlf4M78X7iRzt0D32GeHQ==
X-Google-Smtp-Source: APiQypKAfSimA+/MIssEjbUzkMgrhs/yQHmvoV0pLp03d2obBPlE8h/TNmnUjsf4uAKA3mhFP3G2XA==
X-Received: by 2002:ac2:5395:: with SMTP id g21mr11614880lfh.61.1587415225588;
        Mon, 20 Apr 2020 13:40:25 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id y22sm336637lfg.92.2020.04.20.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:40:24 -0700 (PDT)
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
Subject: [PATCH 1/3 v4] iio: magnetometer: ak8974: Correct realbits
Date:   Mon, 20 Apr 2020 22:40:20 +0200
Message-Id: <20200420204022.18235-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The HSCDTD008A has 15 bits of actual ADC valie, and the
AMI305 and AMI306 has 12 bits.

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
ChangeLog v3->v4:
- Create two sets of channels for 12 or 16 bit mode.
ChangeLog v1->v3:
- New patch in the v3 patch set.
---
 drivers/iio/magnetometer/ak8974.c | 45 +++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index ade4ed8f67d2..7d585c3b7e1e 100644
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
@@ -662,16 +662,32 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
-			.realbits = 16,					\
+			.realbits = bits,				\
 			.storagebits = 16,				\
 			.endianness = IIO_LE				\
 		},							\
 	}
 
-static const struct iio_chan_spec ak8974_channels[] = {
-	AK8974_AXIS_CHANNEL(X, 0),
-	AK8974_AXIS_CHANNEL(Y, 1),
-	AK8974_AXIS_CHANNEL(Z, 2),
+/*
+ * We have no datasheet for the AK8974 but we guess that its
+ * ADC is 12 bits. The AMI305 and AMI306 certainly has 12bit
+ * ADC.
+ */
+static const struct iio_chan_spec ak8974_12_bits_channels[] = {
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
+static const struct iio_chan_spec ak8974_15_bits_channels[] = {
+	AK8974_AXIS_CHANNEL(X, 0, 15),
+	AK8974_AXIS_CHANNEL(Y, 1, 15),
+	AK8974_AXIS_CHANNEL(Z, 2, 15),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
@@ -815,8 +831,21 @@ static int ak8974_probe(struct i2c_client *i2c,
 	pm_runtime_put(&i2c->dev);
 
 	indio_dev->dev.parent = &i2c->dev;
-	indio_dev->channels = ak8974_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ak8974_channels);
+	switch (ak8974->variant) {
+	case AK8974_WHOAMI_VALUE_AMI306:
+	case AK8974_WHOAMI_VALUE_AMI305:
+		indio_dev->channels = ak8974_12_bits_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ak8974_12_bits_channels);
+		break;
+	case AK8974_WHOAMI_VALUE_HSCDTD008A:
+		indio_dev->channels = ak8974_15_bits_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ak8974_15_bits_channels);
+		break;
+	default:
+		indio_dev->channels = ak8974_12_bits_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ak8974_12_bits_channels);
+		break;
+	}
 	indio_dev->info = &ak8974_info;
 	indio_dev->available_scan_masks = ak8974_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.21.1

