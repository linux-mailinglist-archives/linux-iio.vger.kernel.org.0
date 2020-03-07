Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4756417CC56
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 06:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgCGFqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 00:46:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39714 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGFqE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 00:46:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id w65so1624977pfb.6
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2020 21:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=7aBlp/loUoW6JxlpuDNAhYu/ntHRyYTg9jgRlxbIjNA=;
        b=kDv8z9uUjYd5J1/05pMjjrtgPAkuEHq1x3PllCL5DuMjt6c+KGp7QFz9QodCiviObw
         3tMELZsjutDQlKs68DjOqGdI2GQvjLc1Lk2BbIFSy5cP+9Tc5GXuxp7UTol90sNPYT4H
         DmLpVb6B/oWFIAjBkKFahani7pr/7UNyIZNOntG9HbQeVsKxaf47Q3muae/et3M4JZBl
         V5ao/Og8GY6OW5xV9vfXN2gIYwxkQTqUdlwzy28qSUGKK4I3FpsHE6gYCvu+cycj+Xs2
         NjPcRZWOMe3SM59rLXYL+hj5sLy/IjOxWmxdbbpKoaB89D01musmFjEWuXNLHGabfVEu
         5zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=7aBlp/loUoW6JxlpuDNAhYu/ntHRyYTg9jgRlxbIjNA=;
        b=m5zKvof929xqvPWyfrp5RK+3VJLOxl1/ppvIEpuGvya6kquh8j1Y/KN78Po0EGWUCG
         vaysBDopZIFQ5GsQvzP03Luq7cTQyLS3SUb8T2zSEt+7GWvB96R1nq30dawwuf2ugWTZ
         Oa4nORJvYbk0BF/V9uezrV4RMHmNCBaNsUMwPIzKCnMo9CKAuZG2j08ZAcKqPsv+OLaZ
         jE9nWnSQIO5H/6AcsurPiG18nmSbfLcj6b68kZ+SKwYqd44Bl4DtviEuq1GZa8E3+MBj
         yOazCa8Pf37Dbq+dBnAilxj0iLrgxf1jxLfw9nFLPhPzVyr+PeCHlOyV22wDGqjM0vl2
         QMxQ==
X-Gm-Message-State: ANhLgQ2Ej1RNZ9SyMonxccDJ8eYwkmf11UMcYyz3Do5bchUw7CZ0Q8Sd
        GBSs0uC0Jm0iyHk4fa1Wyqw=
X-Google-Smtp-Source: ADFU+vvX+KGNvcO1GBUrre7hOII22F6YGcptG/1ZReiIPTGLFoEQkp88MFMAQ5uz5va0E0Kjjrtolw==
X-Received: by 2002:a63:d245:: with SMTP id t5mr6333778pgi.84.1583559962782;
        Fri, 06 Mar 2020 21:46:02 -0800 (PST)
Received: from SARKAR ([43.224.157.39])
        by smtp.gmail.com with ESMTPSA id x19sm14123117pfc.144.2020.03.06.21.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 21:46:01 -0800 (PST)
Message-ID: <5e633519.1c69fb81.ec43c.6809@mx.google.com>
X-Google-Original-Message-ID: <20200307054558.GA32207@rohitsarkar5398@gmail.com>
Date:   Sat, 7 Mar 2020 11:15:58 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        jonathon.cameron@huawei.com, alexandru.ardelean@analog.com
Subject: [PATCH v3] iio: adc: max1363: replace uses of mlock
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
 drivers/iio/adc/max1363.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..d26f68d23250 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -150,6 +150,7 @@ struct max1363_chip_info {
  * @current_mode:	the scan mode of this chip
  * @requestedmask:	a valid requested set of channels
  * @reg:		supply regulator
+ * @lock            lock to ensure state is consistent
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
@@ -364,7 +366,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
-	mutex_lock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret < 0)
+		goto error_ret;
 	/*
 	 * If monitor mode is enabled, the method for reading a single
 	 * channel will have to be rather different and has not yet
@@ -372,7 +376,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	 *
 	 * Also, cannot read directly if buffered capture enabled.
 	 */
-	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
+	if (st->monitor_on) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -404,8 +408,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		data = rxbuf[0];
 	}
 	*val = data;
+
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	iio_device_release_direct_mode(indio_dev);
 	return ret;
 
 }
@@ -705,9 +710,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->monitor_speed = i;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -810,12 +815,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
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
@@ -962,7 +967,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	u16 unifiedmask;
 	int number = chan->channel;
 
-	mutex_lock(&indio_dev->mlock);
+	iio_device_claim_direct_mode(indio_dev);
 	unifiedmask = st->mask_low | st->mask_high;
 	if (dir == IIO_EV_DIR_FALLING) {
 
@@ -989,7 +994,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	iio_device_release_direct_mode(indio_dev);	
 
 	return ret;
 }
@@ -1587,6 +1592,7 @@ static int max1363_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
 	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(st->reg)) {
 		ret = PTR_ERR(st->reg);
-- 
2.23.0.385.gbc12974a89

