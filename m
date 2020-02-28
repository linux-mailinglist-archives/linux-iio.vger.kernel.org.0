Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD1173F9F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 19:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgB1Sbt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 13:31:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37992 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgB1Sbt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Feb 2020 13:31:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so1937879pgn.5
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2020 10:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:reply-to:mime-version
         :content-disposition:user-agent;
        bh=gmGyQxnVAVVxV33L/QOv1iLUkzX1QfV4mm+fS1MmZPU=;
        b=nlOxxslMFWUi529Rn+fYte4/gXMIeTmh4sBRUk5qksZmd7hkpBweTwjNFSJ5mmela0
         37H1Y1N1HiSZ5Id2kkuyAlo2MVRasVU7ufSKJG7i12efh3LT6jhQugl7wcFUngKy1TXB
         qfIpZxZI/tCAIxc8eFXDyGhirpW2GwDr8JNpf7/nOJ/spD2ommvHspE8Kr5aWAj9b6fc
         CmEccG/4Rro4mHlObV5+avn9Cz0t1mbwrtb+giZspKI7GVDkD/KclgZ1GhZdCw52x+Im
         t319FCbNsHJnsrD+O/szxV2d6k+e9y7Lv/I5xpq3Q4i27Kwxh8IAFP7S2GKEycx7aE8u
         Dhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:reply-to
         :mime-version:content-disposition:user-agent;
        bh=gmGyQxnVAVVxV33L/QOv1iLUkzX1QfV4mm+fS1MmZPU=;
        b=k3TA1Ot2YDrdr1wl4mRqu5QNWOE+K3kjuGPUmS7hsm6NPndZAwQ+xxFFo1SNuOMFgL
         BCjazD4fYt1IFAfcG8ro661uwFfo9D5LNdLgjlR+v4v/j95z5AE2pml/57FJnUPuTpsP
         7L1DDQgezqfZvM9tyQ4/Nz+PV7wnw3yFXr9l5JXqmGYRYGR5899PXM6HvM7ckea+LEp6
         3xgVQEsBkAb4d7Fh/cpH8dVs2GCmak4vXABvVD8bn6DAScc1ms8i2riWZYDscgoKYKJP
         p2fX/BwYp/dtU1GU/hAZ/55GcP7YesoHwaL3h0PjBCvOER1a5PMIn33u9ZMuBRF8945l
         K7MQ==
X-Gm-Message-State: APjAAAUPe+xWorlO5XiIdJmu4CzBTcQD9sqXzsJykjzx65CKo5uFUlff
        PYXLQONYy4Bn+lw+JCzah6I=
X-Google-Smtp-Source: APXvYqwS44NTspUUdN8I5hMKWt2V2vHrCp3wVHFbaLgE8G6BZslqw0/yBuHsmTSP+4NJ/CDMik3aGA==
X-Received: by 2002:a63:af53:: with SMTP id s19mr5699792pgo.175.1582914706498;
        Fri, 28 Feb 2020 10:31:46 -0800 (PST)
Received: from SARKAR ([2401:4900:3314:1957:399a:a833:fab3:83b])
        by smtp.gmail.com with ESMTPSA id b15sm11874734pft.58.2020.02.28.10.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 10:31:45 -0800 (PST)
Message-ID: <5e595c91.1c69fb81.6beb1.f7b0@mx.google.com>
X-Google-Original-Message-ID: <20200228183137.GA22782@rohitsarkar5398@gmail.com>
Date:   Sat, 29 Feb 2020 00:01:37 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     rohitsarkar5398@gmail.com, jic23@kernel.org,
        alexandru.Ardelean@analog.com
Subject: [PATCH v2] iio: adc: max1363: replace mlock with own lock
Reply-To: 519965df20014e135acc9cc9c4674bbba8d76f1a.camel@analog.com
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
 drivers/iio/adc/max1363.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..198094ad79a1 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -169,6 +169,7 @@ struct max1363_state {
 	const struct max1363_mode	*current_mode;
 	u32				requestedmask;
 	struct regulator		*reg;
+	struct mutex			lock;
 
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
@@ -1587,6 +1588,7 @@ static int max1363_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
 	st->reg = devm_regulator_get(&client->dev, "vcc");
 	if (IS_ERR(st->reg)) {
 		ret = PTR_ERR(st->reg);
-- 
2.23.0.385.gbc12974a89

