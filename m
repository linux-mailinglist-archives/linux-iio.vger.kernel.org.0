Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87A1170806
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 19:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZStm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 13:49:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37278 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBZStm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Feb 2020 13:49:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so104829pgl.4
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2020 10:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=g79rgAw3wYpqH9HBHiwPhB05vCaFpjg4we3jsHtDSlA=;
        b=Nu0NNRdpTm8Iez9ljN4Z7vyr4oMszCaMihPiJBbJgKueS9f9u+HNUF8H8wd7Rxs1e5
         kF5qEH5w5A5dd0lYUgdPPz34zfdtp/pbQ7aOGcIT7q+OpxvLhmEV6zxiHq1QDeN7uiwL
         D0pNU9TU+TEqSnhFspN+CS1iGtdbGCLoztRLup3ROq9jJd3aPUFpf1okO3nE9bNuC5WB
         QxeRKTB7XrPwEKI473mVXQKIP7gbYXMuvlV+RQfBufvAleqfUabZRyKL64Yfmvz42/Jr
         dH0U8jx+HcnOn6FpdHdRHQODl3blrimD4xAjUxOCK0UP+BnZ8asPSz5f47MafY6FTPyU
         nv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=g79rgAw3wYpqH9HBHiwPhB05vCaFpjg4we3jsHtDSlA=;
        b=fVNRxgpXIGRUEHfIZO6j33E3BmziX6oTp72H3djY8WpJBMts7ibPdGbFDyfFI7o6hn
         8ZHto1YElx5BdVtW/TIJfYki7AW8jCjH88HB7lT+HBiZf6qVpDucO5shIsMxIDz63C5+
         C07zkNjGOBzTsYL/cI39QGS/BP+F6IMDc1nfHY+jlCk5/kJYkCumYwKxLqhaXpXGClcE
         6MNeW+QNi/AHxLShEvG26+ZUAM0V1mQ4Rxg+W6fNp17S5e0yCja8RXKvPdMvOHy0wstq
         XVulr+uR7lU/hBz/aXT/qYw1TmBbDqfGFdb+plsOWq6jbA9FaexBduMWUiCaZJB1c/K+
         oKBg==
X-Gm-Message-State: APjAAAWi1WPJtzHUbMrHjke2C60A3SI1Qp0PQtmsjw7kQEdRYSOyl4nc
        kLHvAWVmD1Cu7SMaLzqn+zs=
X-Google-Smtp-Source: APXvYqzCYOupn6zTidM6OhaESnYoQjOUL8tp2KP585F/wu2fOE53tz9zV+oL8jlebJ0hwgp321fAUw==
X-Received: by 2002:a62:870e:: with SMTP id i14mr96734pfe.192.1582742980705;
        Wed, 26 Feb 2020 10:49:40 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id o17sm3507234pjq.1.2020.02.26.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 10:49:39 -0800 (PST)
Message-ID: <5e56bdc3.1c69fb81.c3b20.9153@mx.google.com>
X-Google-Original-Message-ID: <20200226184936.GA14461@rohitsarkar5398@gmail.com>
Date:   Thu, 27 Feb 2020 00:19:36 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     rohitsarkar5398@gmail.com, jic23@kernel.org,
        alexandru.ardelean@analog.com
Subject: [PATCH] iio: adc: max1363: replace mlock with own lock
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change replaces indio_dev's mlock with the drivers own lock. In
each case the lock is needed to protect the driver's own state.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/adc/max1363.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..b9557f957f3c 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -169,6 +169,7 @@ struct max1363_state {
 	const struct max1363_mode	*current_mode;
 	u32				requestedmask;
 	struct regulator		*reg;
+	struct mutex lock;
 
 	/* Using monitor modes and buffer at the same time is
 	   currently not supported */
@@ -364,7 +365,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 	/*
 	 * If monitor mode is enabled, the method for reading a single
 	 * channel will have to be rather different and has not yet
@@ -405,7 +406,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	}
 	*val = data;
 error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 	return ret;
 
 }
@@ -705,9 +706,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
 	if (!found)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->mlock);
 	st->monitor_speed = i;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->mlock);
 
 	return 0;
 }
@@ -810,12 +811,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
 	int val;
 	int number = chan->channel;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->mlock);
 	if (dir == IIO_EV_DIR_FALLING)
 		val = (1 << number) & st->mask_low;
 	else
 		val = (1 << number) & st->mask_high;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->mlock);
 
 	return val;
 }
-- 
2.23.0.385.gbc12974a89

