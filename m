Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671E313551
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfECWOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:14:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44073 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECWOE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:14:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id a26so6185362qtp.11;
        Fri, 03 May 2019 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7k8Wov7jQEYM2rfxCLHxgiTqZOyUz2SP9zMZgrjLstQ=;
        b=Bhw7KkQUjZsiqWbLEaDqz97+HBxqEteaEk12AYSCalIVlFVcTyWL0lcdvsSn1woeVQ
         3IZ+BFbtj2bFspdtExTUPbfZEEkvTg6T3V9++z29O5TOiQ+6Re43iO4pupPy9yE3zIS3
         nQLNvCghkaGekDf+dAuNdyIAWf1r8LGdrfkWb0ZVzdB1xRwxt9cIa+GEwiApuYLvYVXk
         6nR2gwKh0/xIQeIU4RadyzNjS7pZRUBnMrEUzXc+AZWlsHp15kgjqFK5ShGOSOLEJE2T
         hNCvD4268hVd2H4D1zVIjFwex02ybMk0pl6sPbFjTSQTzUNvdcEPFuAAXcQr+daLyAtb
         v0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7k8Wov7jQEYM2rfxCLHxgiTqZOyUz2SP9zMZgrjLstQ=;
        b=LakYH8oLfkrc5XuJvZihVqcIK+TNwKoHXHMppnAK6LWBESjVNFOy4R8XCj2Y0Hqj3r
         FXqiZtyG9YCTTo4XGj/hw9as2lbOA2gXbmhws0GP7ohL03IKv10f7sSAl4HjAeJWfh3B
         ydtTnf/KtyeKa2h2DQqba/LF4FYDclBc4ZIKPzHQgPLPdUBbPLnk9pgodCdbhYwmBPoR
         UBzprQfe0QStB/lmWxB7zO98NPjWg1yLWfVLs0bmT8BX3tI04bjGzMLfPnuWjDWJmi7A
         CjZsWgorNxPdjZQDJKA3TtVId1eYkyh8goH5/Q9rD24YQ2x0Ufc6QjidY77eokHrd94C
         iGZA==
X-Gm-Message-State: APjAAAX8u5hh3OOez+eKxH3lNsc4OeuL6/YGFGZjxuBZlIqI1I83oyOl
        FHh9fw/lJoqH2QEdNOLw368=
X-Google-Smtp-Source: APXvYqykYNGfLyRHcSceDFKQLfRdvTv1c51cU0Ka04/27TJyn/P9BrF/GYdVDBaKulcrLEZytrEBHQ==
X-Received: by 2002:a0c:c956:: with SMTP id v22mr10511251qvj.164.1556921642900;
        Fri, 03 May 2019 15:14:02 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s185sm1844500qkf.74.2019.05.03.15.13.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 15:14:01 -0700 (PDT)
Date:   Fri, 3 May 2019 19:13:50 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/4] staging: iio: ad7150: organize registers definition
Message-ID: <10781f40fa8a403480833e49b7356ade5af57b94.1556919363.git.melissa.srw@gmail.com>
References: <cover.1556919363.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556919363.git.melissa.srw@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the suffix REG to make the register addresses clear
and indentation to highlight field names.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 75 ++++++++++++++++----------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index dd7fcab8e19e..24601ba7db88 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -15,35 +15,34 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
-/*
- * AD7150 registers definition
- */
 
-#define AD7150_STATUS              0
-#define AD7150_STATUS_OUT1         BIT(3)
-#define AD7150_STATUS_OUT2         BIT(5)
-#define AD7150_CH1_DATA_HIGH       1
-#define AD7150_CH2_DATA_HIGH       3
-#define AD7150_CH1_AVG_HIGH        5
-#define AD7150_CH2_AVG_HIGH        7
-#define AD7150_CH1_SENSITIVITY     9
-#define AD7150_CH1_THR_HOLD_H      9
-#define AD7150_CH1_TIMEOUT         10
-#define AD7150_CH1_SETUP           11
-#define AD7150_CH2_SENSITIVITY     12
-#define AD7150_CH2_THR_HOLD_H      12
-#define AD7150_CH2_TIMEOUT         13
-#define AD7150_CH2_SETUP           14
-#define AD7150_CFG                 15
-#define AD7150_CFG_FIX             BIT(7)
-#define AD7150_PD_TIMER            16
-#define AD7150_CH1_CAPDAC          17
-#define AD7150_CH2_CAPDAC          18
-#define AD7150_SN3                 19
-#define AD7150_SN2                 20
-#define AD7150_SN1                 21
-#define AD7150_SN0                 22
-#define AD7150_ID                  23
+/* AD7150 registers */
+
+#define AD7150_STATUS_REG			0x00
+#define	 AD7150_STATUS_OUT1			BIT(3)
+#define	 AD7150_STATUS_OUT2			BIT(5)
+#define AD7150_CH1_DATA_HIGH_REG		0x01
+#define AD7150_CH2_DATA_HIGH_REG		0x03
+#define AD7150_CH1_AVG_HIGH_REG			0x05
+#define AD7150_CH2_AVG_HIGH_REG			0x07
+#define AD7150_CH1_SENSITIVITY_REG		0x09
+#define AD7150_CH1_THR_HOLD_H_REG		0x09
+#define AD7150_CH2_SENSITIVITY_REG		0x0C
+#define AD7150_CH1_TIMEOUT_REG			0x0A
+#define AD7150_CH1_SETUP_REG			0x0B
+#define AD7150_CH2_THR_HOLD_H_REG		0x0C
+#define AD7150_CH2_TIMEOUT_REG			0x0D
+#define AD7150_CH2_SETUP_REG			0x0E
+#define AD7150_CFG_REG				0x0F
+#define	 AD7150_CFG_FIX				BIT(7)
+#define AD7150_PD_TIMER_REG			0x10
+#define AD7150_CH1_CAPDAC_REG			0x11
+#define AD7150_CH2_CAPDAC_REG			0x12
+#define AD7150_SN3_REG				0x13
+#define AD7150_SN2_REG				0x14
+#define AD7150_SN1_REG				0x15
+#define AD7150_SN0_REG				0x16
+#define AD7150_ID_REG				0x17
 
 /**
  * struct ad7150_chip_info - instance specific chip data
@@ -85,12 +84,12 @@ struct ad7150_chip_info {
  */
 
 static const u8 ad7150_addresses[][6] = {
-	{ AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
-	  AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
-	  AD7150_CH1_SENSITIVITY, AD7150_CH1_TIMEOUT },
-	{ AD7150_CH2_DATA_HIGH, AD7150_CH2_AVG_HIGH,
-	  AD7150_CH2_SETUP, AD7150_CH2_THR_HOLD_H,
-	  AD7150_CH2_SENSITIVITY, AD7150_CH2_TIMEOUT },
+	{ AD7150_CH1_DATA_HIGH_REG, AD7150_CH1_AVG_HIGH_REG,
+	  AD7150_CH1_SETUP_REG, AD7150_CH1_THR_HOLD_H_REG,
+	  AD7150_CH1_SENSITIVITY_REG, AD7150_CH1_TIMEOUT_REG },
+	{ AD7150_CH2_DATA_HIGH_REG, AD7150_CH2_AVG_HIGH_REG,
+	  AD7150_CH2_SETUP_REG, AD7150_CH2_THR_HOLD_H_REG,
+	  AD7150_CH2_SENSITIVITY_REG, AD7150_CH2_TIMEOUT_REG },
 };
 
 static int ad7150_read_raw(struct iio_dev *indio_dev,
@@ -133,7 +132,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 	bool adaptive;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
 	if (ret < 0)
 		return ret;
 
@@ -229,7 +228,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 	if (event_code == chip->current_event)
 		return 0;
 	mutex_lock(&chip->state_lock);
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
 	if (ret < 0)
 		goto error_ret;
 
@@ -264,7 +263,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 
 	cfg |= (!adaptive << 7) | (thresh_type << 5);
 
-	ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
+	ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG_REG, cfg);
 	if (ret < 0)
 		goto error_ret;
 
@@ -497,7 +496,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS_REG);
 	if (ret < 0)
 		return IRQ_HANDLED;
 
-- 
2.20.1

