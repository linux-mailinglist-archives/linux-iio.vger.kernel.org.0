Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5242D1ADC56
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 13:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgDQLkj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730450AbgDQLki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 07:40:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E590C061A0F
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2020 04:40:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so1704240ljd.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2020 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UUxeiU31CzkmS+D9kh8cZkO8ytha7iuen+sgkO4OnY=;
        b=lNuayNOQkdyF/kCTgE2m+wG3o6YYQ8w38+844DdyNJcsqAr1JH8gru1wBf1yIgGOQR
         EpbEgcE0N7p03hrsKgRj/nIr1ZPjXbtzAD626zPr+oSSs47P/RrrJInNZQ4GZkqwKq/u
         AsKqZsCELGh4e5jkxy3QA98UffOiD8DaWjjMh0aKpwKpywSa5BAHzDSOMYjKe4O6VynY
         rC2OvwEGQa5huLEoufGGU44UbQnq6fQ5ZfMmiu3GkBscWjtU+oECGBuWZWrogpD8B3an
         qhGYoNoa8OE2KWBxZawfd0QX0q9APvs/MUSh9IN1v4qMOd/DX+U6JDR3+Yc54EDxJb2n
         0+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UUxeiU31CzkmS+D9kh8cZkO8ytha7iuen+sgkO4OnY=;
        b=X2lo+vQKYC9PiOpdj8STWulZrymwikQqBNW4FH51l72CAvcB3kCqyaSN4a+qXg5W1N
         8Z8e0RPLGSon/jq9iAHcgrzc1GQKdrmTJC0mrkYC8MbNQ/1l1DV/OSPEdFB9Mrw0Iqg6
         Qkf+NgWOMyvAl4j9WZS3WT6sgKsx1Wnd68NEqHOG+WGQhawANPl7+xoGieVEbSJjnfOj
         fEg8OlS+ezeDjTitXtdMMJ9cgnOtTW2pdoq66+Vm5LMQwrwQAwZst9QHOqZ0vr9MSWhO
         8gIcCg5IAHiKV0i/+z9notQaMUzVypuhvKFQsfdXTxIsGpe4mQS0M8PudSVOkokv6NMk
         eayA==
X-Gm-Message-State: AGi0PuZQ/7N/j3hvFW6HkGVuNJjqI1wVmR2WnsuO4APNFN/xLmkoNgzk
        m9c37PB/vxq0xmlTiBGMXdG+pg==
X-Google-Smtp-Source: APiQypIYIKjq+pDIm0Sirg3ppl9xyUeRT7jEFhK9hvdu8eD+MQ1/PK+QKeCnrKcTI00+zIH3+TdcKQ==
X-Received: by 2002:a2e:3c08:: with SMTP id j8mr1900415lja.243.1587123636541;
        Fri, 17 Apr 2020 04:40:36 -0700 (PDT)
Received: from localhost.bredbandsbolaget (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id 78sm16256618ljf.76.2020.04.17.04.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 04:40:35 -0700 (PDT)
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
Subject: [PATCH 2/3 v3] iio: magnetometer: ak8974: Break out measurement
Date:   Fri, 17 Apr 2020 13:40:19 +0200
Message-Id: <20200417114020.31291-2-linus.walleij@linaro.org>
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

This breaks out the measurement code to its own function
so we can handle this without swirling it up with the
big switch() statement inside ak8974_read_raw().

Keep a local s16 helper variable for the signed value
coming out of the measurement before assigning it to the
integer *val. The local variable makes the code easier
to read and the compiler will optimize it if possible.

Cc: Nick Reitemeyer <nick.reitemeyer@web.de>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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
 drivers/iio/magnetometer/ak8974.c | 68 +++++++++++++++++++------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index f22b40ef5661..b8dbea119a67 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -554,47 +554,63 @@ static int ak8974_detect(struct ak8974 *ak8974)
 	return 0;
 }
 
+static int ak8974_measure_channel(struct ak8974 *ak8974, unsigned long address,
+				  int *val)
+{
+	__le16 hw_values[3];
+	int ret;
+	s16 outval;
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
+	outval = (s16)le16_to_cpu(hw_values[address]);
+	*val = outval;
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

