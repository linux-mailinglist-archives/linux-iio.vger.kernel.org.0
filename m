Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1E1A8D7D
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391806AbgDNVRY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391804AbgDNVRX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 17:17:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B57AC061A0E
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 14:17:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so952267lfe.4
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwAf4ho0Hk/eAsLeunOdmjEnguHzBR1GIBSNGQh+jaY=;
        b=msdBzsV8vqCPSuv6oor6cuEXMkIeeiGEnzPiZpL6dIpj1Ws85dnmts4jLCVzvFQBN/
         S95ZgVWVpxWXRFjwF5mz2AuR0x6gwIiyzuwvJcgxkm4OQAH+j7nCQ62xQsZVm76C8ZF2
         W0O7pR4frGWiJ+zLrS54lI7PnD1cvzUHJfohN6xI8SuNjs4F2GzZwhMslGJ9jOlPIaZt
         aM+rcozY2duWlQlMLSR9acajS/MK/C41Cj++EHAWnSAaEAj5nRSswlQ+J2u6FT7vAz86
         JOhNVj9VHZUs/fvPyy1fYvuMM5/vlWWL+1/9exh9+PzOHEtbTSOCh3s8AiM2ZoJmyqP5
         X53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwAf4ho0Hk/eAsLeunOdmjEnguHzBR1GIBSNGQh+jaY=;
        b=hrzFPhSTvM9+TdZuNzxrwl2cHABZtaIduwNwygKdh3PC2jlyKrNimhRp9oiwDs5Y7/
         yQl9R0TZBsuuVMbSfAcDTELUHcxrHwiKydM0amEp/2eh56Osl9/rkZgron/BXV8yNG1n
         ikLx8FtiTgXLNWq+UP2e89jK6Bp+cKKjVl/6xGRPy0LObklFw2PzmVPePcwOZvZ530pr
         GLgAiPHMyossT5jGwqA6r07Qt0bhljcjCx2hDWEu/9eUDHt7n6hp/RQ9ssaHchpxF8fV
         gh6iZ2Ghl8e5e+j64LMWoORHd8KC4YDIXNvlpEVlJsOUbz1ljIb5di8Pn45VeQ8fr+4T
         jStA==
X-Gm-Message-State: AGi0Pubr42AFPk5vPfC2+LIYdCjCUDCLEZ5O9GvKRnehRltEmIIz7hUe
        ms9cz8NriTM8C1xCQpHUToCo3w==
X-Google-Smtp-Source: APiQypLTDCmAGE8KJZbMw7A3RMPDy3PqlJdGj5Pcm+G0jHa0wmrtUD2B7ZL+z8Hxro5U+pyfzxPFqw==
X-Received: by 2002:a19:2d1d:: with SMTP id k29mr1024146lfj.46.1586899041441;
        Tue, 14 Apr 2020 14:17:21 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id s10sm10041245ljp.87.2020.04.14.14.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:17:20 -0700 (PDT)
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
Subject: [PATCH] iio: magnetometer: ak8974: Provide scaling
Date:   Tue, 14 Apr 2020 23:17:17 +0200
Message-Id: <20200414211717.11472-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The manual for the HSCDTD008A gives us a scaling for the
three axis as +/- 2.4mT per axis.

When I implement this the biggest axis indicates 0.59 Gauss
which is a reasonable measurement for the earths magnetic
which is in the range of 0.25 to 0.65 Gauss on the surface
according to Wikipedia.

Since the raw read function is now also used for scaling
we need to break out a function that takes the locks and
runtime PM so we don't get too hairy goto:s.

Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch is based on top of Nick's patches for the
HSCDTD008A support.
---
 drivers/iio/magnetometer/ak8974.c | 66 +++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index ade4ed8f67d2..effcdd93e650 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -554,46 +554,69 @@ static int ak8974_detect(struct ak8974 *ak8974)
 	return 0;
 }
 
+static int ak8974_measure(struct ak8974 *ak8974, unsigned long address, s16 *val)
+{
+	__le16 hw_values[3];
+	int ret;
+
+	pm_runtime_get_sync(&ak8974->i2c->dev);
+	mutex_lock(&ak8974->lock);
+
+	ret = ak8974_trigmeas(ak8974);
+	if (ret)
+		goto out_unlock;
+	ret = ak8974_getresult(ak8974, hw_values);
+	if (ret)
+		goto out_unlock;
+	*val = (s16)le16_to_cpu(hw_values[address]);
+out_unlock:
+	mutex_unlock(&ak8974->lock);
+	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
+	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
+
+	return ret;
+}
+
 static int ak8974_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2,
 			   long mask)
 {
 	struct ak8974 *ak8974 = iio_priv(indio_dev);
-	__le16 hw_values[3];
 	int ret = -EINVAL;
-
-	pm_runtime_get_sync(&ak8974->i2c->dev);
-	mutex_lock(&ak8974->lock);
+	s16 outval;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->address > 2) {
 			dev_err(&ak8974->i2c->dev, "faulty channel address\n");
 			ret = -EIO;
-			goto out_unlock;
+			goto out_err_read;
 		}
-		ret = ak8974_trigmeas(ak8974);
-		if (ret)
-			goto out_unlock;
-		ret = ak8974_getresult(ak8974, hw_values);
-		if (ret)
-			goto out_unlock;
-
 		/*
 		 * We read all axes and discard all but one, for optimized
 		 * reading, use the triggered buffer.
 		 */
-		*val = (s16)le16_to_cpu(hw_values[chan->address]);
-
+		ret = ak8974_measure(ak8974, chan->address, &outval);
+		if (ret)
+			goto out_err_read;
+		*val = outval;
 		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * The datasheet for HSCDTF008A, page 3 specifies the
+		 * range of the sensor as +/- 2.4 mT per axis, which corresponds
+		 * to +/- 2400 uT = +/- 24 Gauss. So 0x7fff is 24 Gauss and
+		 * 0xffff is -24 Gauss. To account for the one missing value if
+		 * we multiply by 1/S16_MAX, instead multiply with 2/U16_MAX.
+		 */
+		*val = 24 * 2;
+		*val2 = U16_MAX;
+		ret = IIO_VAL_FRACTIONAL;
+		break;
 	}
-
- out_unlock:
-	mutex_unlock(&ak8974->lock);
-	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
-	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
-
+out_err_read:
 	return ret;
 }
 
@@ -656,7 +679,8 @@ static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
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

