Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75617D59E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 19:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgCHSlS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 14:41:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34712 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCHSlS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2020 14:41:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so1992714pfj.1;
        Sun, 08 Mar 2020 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition
         :user-agent;
        bh=LUkL2Bm9LguTk5TSjJvZx4OknMnOSkCX4oPxPKE2DT0=;
        b=UxrNIrVUpPQly9uWASaPqBmeqq2fswqiF54yU6fq29VOlCkC7s0VYQsv3DLEfGP4kg
         r9MjbGYBDmY9FAsoliAeIQHOGpy6qGthYkmWbpAf9ER6enn4+RLK8XUNNfApM1/3Uk3O
         Pc1Zp0b6LM2GNHZhy5+zKOQh2Arq63HcFtnRED8DpEX/oupyw2hhpoQI73xJ0+OdlIa1
         OofjlNKUpbfiBuQU+XjXmXRXkFvVebmuWJPepzgKZDkQaSJdQW7UzFivRnDkgWvtPcQo
         jT/cTbBmKYh1aCTJrzrsjHFOLiUCuzLdE4YJNEtVwUukuryyZM/6uw8PJIwZ6N9vC/8n
         KvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition:user-agent;
        bh=LUkL2Bm9LguTk5TSjJvZx4OknMnOSkCX4oPxPKE2DT0=;
        b=Kz4m38YTjb7KnyL1ZTMF7Hh3mMDIoTzqxzgVqmV0muOtu7OzhG1EVgSNv5CKWa8Tsq
         GqBlXGn3XzySFkdxcA1o2zi444jsTaNYvrvmn5zm34z1zX+FCwB8gZOg/JkQgjFcfXd7
         PYyNYCKA7ThTDjrJYU3lDlRCI2BQse+hNwbkfBn6a2VlfUqF4LGOGFZV9JSwphJI3XAv
         Nkfz1Hnnrzh0hAnaU+iiPxQtsEHZd7W9fm8RuH3aqlY8LYJEEsr4LWsZho89QLZSFLIH
         Qn2TBoBDC0bRDPNBODm55Nf/KftuiLGImDCaDFO5r0UfHPDMPyCWZ9nna5fbvWgX2VqY
         ODZQ==
X-Gm-Message-State: ANhLgQ2RCXHEbmj0Ld6vBEDEuSNa9WXMa6gpCLkdG/u/bumTB2Nf+ktB
        VT7ccInny9g8J/zVSkHf7Ab5fTU44DU=
X-Google-Smtp-Source: ADFU+vvgjMHUB8GjD5fSVxbQZ9ZfxbDBEEmaID+ePu5DnyjVC0ZkiKRnGLJOEPjS+BkvRw/icA1alQ==
X-Received: by 2002:a65:6843:: with SMTP id q3mr13160078pgt.269.1583692875104;
        Sun, 08 Mar 2020 11:41:15 -0700 (PDT)
Received: from SARKAR ([2401:4900:16eb:14aa:399a:a833:fab3:83b])
        by smtp.gmail.com with ESMTPSA id f19sm34187749pgf.33.2020.03.08.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 11:41:14 -0700 (PDT)
Message-ID: <5e653c4a.1c69fb81.e805f.b62a@mx.google.com>
X-Google-Original-Message-ID: <20200308184106.GA7869@rohitsarkar5398@gmail.com>
Date:   Mon, 9 Mar 2020 00:11:06 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] iio: adc: max1363: replace uses of mlock
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
Changelog v4 -> v5
Use local lock too at places where driver state needs to be protected.

Changelog v3 -> v4
* Fix indentation

Changelog v2 -> v3
* use iio_device_claim_direct when switching modes
* replace mlock usage in max1363_write_event_config

Changelog v1 -> v2
* Fix indentation

 drivers/iio/adc/max1363.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..856f523e7018 100644
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
@@ -404,8 +410,10 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
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
@@ -705,9 +713,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	st->monitor_speed = i;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return 0;
 }
@@ -810,12 +818,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
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
@@ -962,7 +970,9 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 	u16 unifiedmask;
 	int number = chan->channel;
 
-	mutex_lock(&indio_dev->mlock);
+	iio_device_claim_direct_mode(indio_dev);
+	mutex_lock(&st->lock);
+
 	unifiedmask = st->mask_low | st->mask_high;
 	if (dir == IIO_EV_DIR_FALLING) {
 
@@ -989,7 +999,8 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
 
 	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -1587,6 +1598,7 @@ static int max1363_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
 	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(st->reg)) {
 		ret = PTR_ERR(st->reg);
-- 
2.23.0.385.gbc12974a89

