Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F86172853
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 20:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgB0TIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 14:08:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42535 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgB0TIo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Feb 2020 14:08:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so164573pgs.9
        for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2020 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition
         :user-agent;
        bh=BtSXeZZG078wnCEEoj9UIGoTZq0u5AKoQ6dDna+jf3E=;
        b=OP6EEU7kngtHB0u59q3A+hbqGViWpnZehPYRtQtPTGRVe3zaPQZIKS1XBFDQ//Av4S
         v2oZj8gVzzkExdjKk/nigWzInxas+W7PF6G9ukFynJp2InCazYi33sTYvP2YprdrfOa4
         ArAQS4XdVZVZHoQ4fDjATxqngCjNPS1Uphl4bBE2URv1cFahwgp80BmQc7wL1E7a5AQT
         rTgWtKPMSvh96ksjqlogPKQrGrAuOl+WZmEUM0HLAW0oOcOSAhHgIuv7u09UzvCHdv7V
         q1jw5KnEydDi4IHtgaXRVpedZ8NhWKxmMYD4sgKOYWCBmrDNDo26djV619Qo+m0fyC2t
         2grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition:user-agent;
        bh=BtSXeZZG078wnCEEoj9UIGoTZq0u5AKoQ6dDna+jf3E=;
        b=PnWXrgJf8Dx1U9Rr0hgBv1Su1maifrUjrwOZF7xcQ3sXYHPNS930SJzt5I8wU2jGaY
         nanxRScArB8DV6uDhh96tS+FPASMSN2XqHXCfzMhPHt+ekRc3G8zEX3hFcyIhgdSL8mz
         HJn7DpDU7YEEB0PILV933eX//Q6a7y/qYf4AsoSx2fs7BHvGk7fZz9vxS76JTbjHWDGP
         b7DgC6TH5O245wBl07yYe+ddJ1K02X/GfWUt98Yk0iaM3kfSwnuHpH7L6JFnMVM7xciP
         N0Qi3DCFF+H1uwzLRW3YEaAeEK6cG4GTpjg8e0C+q3D1dCCpO6CkEDBH+nUseagdJBW8
         JvXQ==
X-Gm-Message-State: APjAAAX98I2tzVah8CBLqcI1IEQqada8j9DcyYu/UWDog77v+nfT9q20
        RgFeZvuol7GCzzLbd25c61EiCjv8uAU=
X-Google-Smtp-Source: APXvYqyj6I0dGQbzUo585wDHjBZaAUHj9Rn0ypu6w/61ZSPLy7HyXFacfQaAyoJ6Vi75LzGRMg4XQQ==
X-Received: by 2002:a62:d45d:: with SMTP id u29mr420020pfl.133.1582830522589;
        Thu, 27 Feb 2020 11:08:42 -0800 (PST)
Received: from SARKAR ([49.207.57.206])
        by smtp.gmail.com with ESMTPSA id d14sm8427406pfq.117.2020.02.27.11.08.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:08:41 -0800 (PST)
Message-ID: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
X-Google-Original-Message-ID: <20200227190837.GA20264@rohitsarkar5398@gmail.com>
Date:   Fri, 28 Feb 2020 00:38:37 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: adc: max1363: replace mlock with own lock
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

Changes from v1:
Fix indentation.
Add a mutex_init() in the probe function.

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

