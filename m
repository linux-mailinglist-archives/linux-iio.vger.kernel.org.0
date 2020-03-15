Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DD185E5F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 17:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgCOQFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 12:05:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45900 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgCOQFE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 12:05:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id m15so8134862pgv.12;
        Sun, 15 Mar 2020 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=MitA4nWbAxv2Lh7BZ6wzduvIE97GrOR19fIYcH4kuLo=;
        b=kQFmNZgourj5bHr/y0oBnxmsJhuMdrMUFMXp+fvZAGK1nAzayamFm9y4Pjyv7mkCse
         xU0Egmpye0/B0SqrV8ug6u/06LTy/NC8K2f50uB5iSJYP4KWU2ij+GJZx4E2JPsJOeZ7
         PlFa4b8it4WWEZiwvn0EVuNaFN0LW1X5pwJXbOjK2d5O6Ixw/44AUVYqMVNDQShy5Q3w
         kgQibDf+hKfd9uFNXU5pOZeFPXskDkRwrsHsVxsJWcpnex1RGeZR9vD+sbTnsidUsusv
         ZYqAC/onbtwlC4rIdhzYqT5NaHaHvKRAoCGLspUR/HVGfp/abj0+PV0XzTfSyhAL8FbD
         K2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=MitA4nWbAxv2Lh7BZ6wzduvIE97GrOR19fIYcH4kuLo=;
        b=AzxEIVh7KnWontipLg48Nrt9+al38tLHfJkPSKoUKLXlvlhSH3g2/DmN+vO2omuaLh
         wgiawW7xHnYyf327gK57j55H/1CTQmemAX+lhRG3eGwJ9cpaUjZsZrBfdgaFA3Y5mJ1u
         XTNJ0tT7tSRCkSGKsSk7CbiosWSvznMHJQ+2JqgzZqUJJ18gJxhbgOPw7w2SFXA996QQ
         JTNUyKEBG8bhNn1IsgyM7C3yFF9nYQcTMw0DjBfnWUa+/N+madrjHtE3NVL3xakbFWIb
         wnpXr/fgb+pc7/bzzQGWPM3WT0vPcVgYGDMVOqFEa84Utn4F9+TUqCtRqeiQc5GdyL8e
         CXfw==
X-Gm-Message-State: ANhLgQ2xHLmttLyYmFgmAkIgLq+PtZtEWSYy0ewv0MNjXp8quZ4ecu0I
        EroXY1NmIzVpSgT0uRf23Vo=
X-Google-Smtp-Source: ADFU+vunim+VtfXcOk2KgKY+XSrtHzJhGSHmczF0btENVcRxgelZDkrvfumM3j0+XzDI/SzoZy8YnA==
X-Received: by 2002:aa7:9811:: with SMTP id e17mr23102940pfl.33.1584288302613;
        Sun, 15 Mar 2020 09:05:02 -0700 (PDT)
Received: from SARKAR ([43.224.157.36])
        by smtp.gmail.com with ESMTPSA id w27sm13459452pfq.211.2020.03.15.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 09:05:01 -0700 (PDT)
Message-ID: <5e6e522d.1c69fb81.10f54.f95c@mx.google.com>
X-Google-Original-Message-ID: <20200315160458.GA17419@rohitsarkar5398@gmail.com>
Date:   Sun, 15 Mar 2020 21:34:58 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, dragos.bogdan@analog.com
Subject: [PATCH v7] iio: adc: max1363: replace uses of mlock
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace usage indio_dev's mlock with either local lock or
iio_device_claim_direct_mode.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
Changelog v6 -> v7
* Fix failure handling logic

Changelog v5 -> v6
* Minor failure handling fixes

Changelog v4 -> v5
* Use local lock too at places where driver state needs to be protected.

Changelog v3 -> v4
* Fix indentation

Changelog v2 -> v3
* use iio_device_claim_direct when switching modes
* replace mlock usage in max1363_write_event_config

Changelog v1 -> v2
* Fix indentation

 drivers/iio/adc/max1363.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..12d72bf3f12a 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -150,6 +150,7 @@ struct max1363_chip_info {
  * @current_mode:	the scan mode of this chip
  * @requestedmask:	a valid requested set of channels
  * @reg:		supply regulator
+ * @lock		lock to ensure state is consistent
  * @monitor_on:		whether monitor mode is enabled
  * @monitor_speed:	parameter corresponding to device monitor speed setting
  * @mask_high:		bitmask for enabled high thresholds
@@ -169,6 +170,7 @@ struct max1363_state {
 	const struct max1363_mode	*current_mode;
 	u32				requestedmask;
 	struct regulator		*reg;
+	struct mutex			lock;
 
 	/* Using monitor modes and buffer at the same time is
 	   currently not supported */
@@ -364,7 +366,13 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
-	mutex_lock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+	mutex_lock(&st->lock);
+
+	if (ret < 0)
+		goto error_ret;
 	/*
 	 * If monitor mode is enabled, the method for reading a single
 	 * channel will have to be rather different and has not yet
@@ -372,7 +380,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	 *
 	 * Also, cannot read directly if buffered capture enabled.
 	 */
-	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
+	if (st->monitor_on) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -404,8 +412,10 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		data = rxbuf[0];
 	}
 	*val = data;
+
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
+	iio_device_release_direct_mode(indio_dev);
 	return ret;
 
 }
@@ -705,9 +715,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->monitor_speed = i;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -810,12 +820,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
 	int val;
 	int number = chan->channel;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	if (dir == IIO_EV_DIR_FALLING)
 		val = (1 << number) & st->mask_low;
 	else
 		val = (1 << number) & st->mask_high;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return val;
 }
@@ -962,7 +972,14 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	u16 unifiedmask;
 	int number = chan->channel;
 
-	mutex_lock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+	mutex_lock(&st->lock);
+
+	if (ret < 0)
+		goto error_ret;
+
 	unifiedmask = st->mask_low | st->mask_high;
 	if (dir == IIO_EV_DIR_FALLING) {
 
@@ -989,7 +1006,8 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -1587,6 +1605,7 @@ static int max1363_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
 	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(st->reg)) {
 		ret = PTR_ERR(st->reg);
-- 
2.23.0.385.gbc12974a89

