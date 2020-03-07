Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3593317CCC0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 09:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgCGIE6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 03:04:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33486 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGIE6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2020 03:04:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so2301723pfn.0;
        Sat, 07 Mar 2020 00:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=aBepW479p3B/E6bvG9ZQtUHEs6JGGZnu1HbF7uuB6cU=;
        b=Mbb917iUQzgGBrHr4DYFKbfxPs4ORtlwKhvVh7TnQR2AiF2eWdlE/Ljnq06UQzqM9y
         +vnWbdk768VuFM5PJFUp7e5apyoEu7cQHUyeY23G8HsfgiiKP9VHfOO0KEL+vWSronF4
         Y23a37wNd7PQEvsXOBrgcAnz8ycHbVmJBwnaS4QkMG4psPXsK5QdktbNkszaoP1KMA6Y
         8O9snngMjNy1O2GfbbgXn3FN7iXn44fVmz//X2RBpT6ft59j0UkCYW0pHOoCBMff/h3b
         DeZYpkeI9qH+C1LFOmMN7hIaZZPvm5/ILRfBzGuhY4Nuuz1fVsiYMytzxhuNEQzL3zBE
         pc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=aBepW479p3B/E6bvG9ZQtUHEs6JGGZnu1HbF7uuB6cU=;
        b=Lep8TInqYNl6dGaVcID+bQ+b2MdQU9ptIVipgLondsa+Rj5lNjOPdNFpHe+x4hzXZq
         qyNLGcHh126OMxpsNDkH5F3xAhgLTMdLi5OiQmGzRbAkCPJ2w0YcGSuhp3dnUAP4fz8i
         eUckX/sT1hkVh7PJPX44MwkXlb3rn+3RvFhEjLGgZVIMcBPq9DO9xcNSQrBF2TtcY4EX
         jeZeGQSCmQYR0RwWnQLWKquGGTTN53djs6U6wkdVFqealvVbw00nEcpa8i9vJf7EBNQX
         JxqMBFIIK0ufeUSpxjLVGuBhDePysc34zH1KKpOhUkUx8ZvZyLzYsEyrl6f/idkVSEqJ
         MxcQ==
X-Gm-Message-State: ANhLgQ2VnNTtGVmmd3LKQR0OCLJTADmqWwYKfqRSLhs//Xt29hptYLP1
        P3aK9gPrfP44mP0v6hm/EoS8UVAeAsk=
X-Google-Smtp-Source: ADFU+vufXAOy1RI3AuNchzWgWAfquQXbaJcG6cRWKAM4ZYFYDw6zUmN6pPoRmujB34JmWnpiCGdDfQ==
X-Received: by 2002:a63:f74a:: with SMTP id f10mr6853056pgk.360.1583568297127;
        Sat, 07 Mar 2020 00:04:57 -0800 (PST)
Received: from SARKAR ([43.224.157.39])
        by smtp.gmail.com with ESMTPSA id h65sm15828234pfg.12.2020.03.07.00.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 00:04:56 -0800 (PST)
Message-ID: <5e6355a8.1c69fb81.36f2c.ab37@mx.google.com>
X-Google-Original-Message-ID: <20200307080451.GA2587@rohitsarkar5398@gmail.com>
Date:   Sat, 7 Mar 2020 13:34:51 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, alexandru.ardelean@analog.com,
        dragos.bogdan@analog.com
Subject: [PATCH v4] iio: adc: max1363: replace uses of mlock
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
Changelog v3 -> v4
* Fix indentation

Changelog v2 -> v3
* use iio_device_claim_direct when switching modes
* replace mlock usage in max1363_write_event_config

Changelog v1 -> v2
* Fix indentation

 drivers/iio/adc/max1363.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..a1550c0b4c0a 100644
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

