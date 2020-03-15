Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D956185E45
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 16:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgCOPtO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 11:49:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41147 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgCOPtO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 11:49:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so6707025plr.8;
        Sun, 15 Mar 2020 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=MW4ux0I+GyqaNHf8jyq7RkRLR8j0nzzH5Orr98SC3Bk=;
        b=Me4+/e8+YYinsGoU2SK5svWHv8GAj8peaX5juLZZBSz9XQEgQM7MiBRkvvBWybHB2D
         n7Hj9q85eTVQk+3LEhoaxjqyllVtOhy++9saSGX5JJHplUB+JaiU8/QmM/Kr5JtLDo5a
         5qvYLc420a8KXIMEq1z1FEySsJ6B4xLpCcbqqJ83YcQjpMc99JFwyx+yy21207MsQn6+
         yvdf1oeIpSeFenOOPOsaBloZufrhuwcjflrXG3JTSnRXkCwDWzJT0Xagq5TYqMSZn1Kr
         SEgPc9zNxklU33deENuCIDKSrXncxVjjqyg5s8cSPaomqGE0Z6HplyQvMXFTWtAp4KeO
         0c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=MW4ux0I+GyqaNHf8jyq7RkRLR8j0nzzH5Orr98SC3Bk=;
        b=BzExF8+iEsDSNoxa2M4+TIC1W6VdreXPKLciog+ldi7b5bPCYZl94PJ3vH+WJgnSHp
         pyZPhvULDaYujVnKDr3CD+F8oZrTrmNihWcRnePQ9uw1+RMrWHuF3azFUVo4HEiAO8Or
         toC86fIcoAS2G/J66z5NnpHIb7aBMYvlqCpe95PIRknEGWI2scV/+lT0F52HGyYFlOQe
         Nrs3B/3MHayONrxSDdNgHyjB4sbDg/p/I6mHEiTgEJF6deTgQ0SsU5JO3mc12G3XOhRd
         dAdUFTKe5oziU2Ug1rRqdklnErKWfG+xFA17zso9R9wXGtmFcXeAqWawGf8ermme668i
         Ta/A==
X-Gm-Message-State: ANhLgQ1zI42wpWDqLJdSwZ4SdZlUqaZbU7NfD9lDuMqR/Wmw1h1EiW9p
        dERqy+CgY0K/7SLr9ImS/7A=
X-Google-Smtp-Source: ADFU+vv1rsv8/m0NLGEdrFxI7EBc6wqekLEehzriT+4p/HaNUef8fr7huWQZZnIFL7dAo7+gn5LFnQ==
X-Received: by 2002:a17:90a:a40f:: with SMTP id y15mr8345690pjp.143.1584287352875;
        Sun, 15 Mar 2020 08:49:12 -0700 (PDT)
Received: from SARKAR ([43.224.157.36])
        by smtp.gmail.com with ESMTPSA id 144sm11473016pfx.184.2020.03.15.08.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 08:49:12 -0700 (PDT)
Message-ID: <5e6e4e78.1c69fb81.511f5.83ac@mx.google.com>
X-Google-Original-Message-ID: <20200315154908.GA15864@rohitsarkar5398@gmail.com>
Date:   Sun, 15 Mar 2020 21:19:08 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, dragos.bogdan@analog.com
Subject: [PATCH v6] iio: adc: max1363: replace uses of mlock
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

 drivers/iio/adc/max1363.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..647c99ae9fbe 100644
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
@@ -364,7 +366,11 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
-	mutex_lock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	mutex_lock(&st->lock);
+
+	if (ret < 0)
+		goto error_ret;
 	/*
 	 * If monitor mode is enabled, the method for reading a single
 	 * channel will have to be rather different and has not yet
@@ -372,7 +378,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	 *
 	 * Also, cannot read directly if buffered capture enabled.
 	 */
-	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
+	if (st->monitor_on) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -404,8 +410,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		data = rxbuf[0];
 	}
 	*val = data;
+
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 
 }
@@ -705,9 +712,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->monitor_speed = i;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -810,12 +817,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
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
@@ -962,7 +969,12 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	u16 unifiedmask;
 	int number = chan->channel;
 
-	mutex_lock(&indio_dev->mlock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	mutex_lock(&st->lock);
+
+	if (ret < 0)
+		goto error_ret;
+
 	unifiedmask = st->mask_low | st->mask_high;
 	if (dir == IIO_EV_DIR_FALLING) {
 
@@ -989,7 +1001,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret;
 }
@@ -1587,6 +1599,7 @@ static int max1363_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
 	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(st->reg)) {
 		ret = PTR_ERR(st->reg);
-- 
2.23.0.385.gbc12974a89

