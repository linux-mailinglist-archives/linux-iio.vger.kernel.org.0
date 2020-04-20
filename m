Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2E1B1746
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTUka (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTUka (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 16:40:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66D3C061A0E
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 13:40:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n6so8211019ljg.12
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 13:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8hZ33Ib2VrL63s5ftZNUenxJncMIHHQLe/XqYyzmzI=;
        b=H16wjBCUBkg/a/dNB/Ys7k9h2VUrW1iJOi+qUwh4Kfd3PbppfsCulmr/vXKHHemGBK
         S+Ri5Q8FD+VuJWHhUQ1bD7tYFFYZF4aEsde3S7/bnXle2Hhud2vlSl5+MZ6+1DvbrzKs
         qdH1taEtBw8Svr5lZYw98mPk5pcGe4ArKL/xxibfXwGq5BHW4KyarWGZBNiYjZz9HN7d
         qboTZ10gCS+ZXn7hcpphgyMYAv3+0UREY4tFAhmyZ1t8uwrDPiFgibvYaXKn+4aFdRdW
         SLMGPR/uL+oseyYHQspFiE5jAzrMpGxkvvOUUqjg6V7Pqv1RC1T+0uGLOMCHtsrylcUC
         YnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8hZ33Ib2VrL63s5ftZNUenxJncMIHHQLe/XqYyzmzI=;
        b=FD8iOIdUk1xBvkdcxl634oCZiiZghY0S5Pv+0OwXa+W82WjVJkPzN50mPnOOeYM43X
         a0+0dA8XNFm5eGLKbQMCV9dkcYMRa8tJWOkCKfJz96FO70iLEVS5Ewq9VqDBYgyH4iAU
         0Xk0pt8jWfO/yhzute91TYZawQ/57xNtEsrX4JFA9IccjEMQuwCoF3SVYexiUqrlNHhS
         828s6HI78ceBkD0gfxTv24RLKhXH9LTHP7a/dRyszgc083TVvqUoc0fzFtcubz1Rdb2n
         oQonYt2hei/y07yitpWARYOKEmHC3C907ekRpXABGANfkR2cpaEzYCKrrxNMNryOPyO1
         pGmA==
X-Gm-Message-State: AGi0PubYKkNvix8LrBdbp+77Wsyavten+whxslw5qrMP5SP3lCMV5oy+
        qNgxMPghKMjSbtNLyOsFe0rzEw==
X-Google-Smtp-Source: APiQypJG5gX8CWPFe3FcHCUFncJiQGKBMWb1Ts8VqTLrLqpnreTvQ6C57m4MdtCC0uNv5XzwgVggcA==
X-Received: by 2002:a2e:740c:: with SMTP id p12mr10932112ljc.11.1587415228061;
        Mon, 20 Apr 2020 13:40:28 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id y22sm336637lfg.92.2020.04.20.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:40:27 -0700 (PDT)
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
Subject: [PATCH 2/3 v4] iio: magnetometer: ak8974: Break out measurement
Date:   Mon, 20 Apr 2020 22:40:21 +0200
Message-Id: <20200420204022.18235-2-linus.walleij@linaro.org>
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

This breaks out the measurement code to its own function
so we can handle this without swirling it up with the
big switch() statement inside ak8974_read_raw().

Keep a local s16 helper variable for the signed value
coming out of the measurement before assigning it to the
integer *val. The local variable makes the code easier
to read and the compiler will optimize it if possible.

Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
Cc: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Assign the casted s16 to the int *val.
- Collect Michał's review tag.
ChangeLog v2->v3:
- Return directly from the raw read function, we
  need no goto:s as we got rid of the lock.
- Change the measurement function to return an int *
  after measurement and just pass *val
  to the function saving a local variable.
- Insert a comment explaining the explicit cast to
  (s16).
- Rename function as ak8974_measure_channel() so the
  name states exactly what is going on.
- Break out as a separate patch.
---
 drivers/iio/magnetometer/ak8974.c | 66 +++++++++++++++++++------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 7d585c3b7e1e..fb6d84b79a7a 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -554,47 +554,61 @@ static int ak8974_detect(struct ak8974 *ak8974)
 	return 0;
 }
 
+static int ak8974_measure_channel(struct ak8974 *ak8974, unsigned long address,
+				  int *val)
+{
+	__le16 hw_values[3];
+	int ret;
+
+	pm_runtime_get_sync(&ak8974->i2c->dev);
+	mutex_lock(&ak8974->lock);
+
+	/*
+	 * We read all axes and discard all but one, for optimized
+	 * reading, use the triggered buffer.
+	 */
+	ret = ak8974_trigmeas(ak8974);
+	if (ret)
+		goto out_unlock;
+	ret = ak8974_getresult(ak8974, hw_values);
+	if (ret)
+		goto out_unlock;
+	/*
+	 * This explicit cast to (s16) is necessary as the measurement
+	 * is done in 2's complement with positive and negative values.
+	 * The follwing assignment to *val will then convert the signed
+	 * s16 value to a signed int value.
+	 */
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
-	int ret = -EINVAL;
-
-	pm_runtime_get_sync(&ak8974->i2c->dev);
-	mutex_lock(&ak8974->lock);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->address > 2) {
 			dev_err(&ak8974->i2c->dev, "faulty channel address\n");
-			ret = -EIO;
-			goto out_unlock;
+			return -EIO;
 		}
-		ret = ak8974_trigmeas(ak8974);
+		ret = ak8974_measure_channel(ak8974, chan->address, val);
 		if (ret)
-			goto out_unlock;
-		ret = ak8974_getresult(ak8974, hw_values);
-		if (ret)
-			goto out_unlock;
-
-		/*
-		 * We read all axes and discard all but one, for optimized
-		 * reading, use the triggered buffer.
-		 */
-		*val = (s16)le16_to_cpu(hw_values[chan->address]);
-
-		ret = IIO_VAL_INT;
+			return ret;
+		return IIO_VAL_INT;
 	}
 
- out_unlock:
-	mutex_unlock(&ak8974->lock);
-	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
-	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
-
-	return ret;
+	return -EINVAL;
 }
 
 static void ak8974_fill_buffer(struct iio_dev *indio_dev)
-- 
2.21.1

