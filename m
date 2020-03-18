Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DB2189D21
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 14:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRNhp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 09:37:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55825 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCRNhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 09:37:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 6so3390909wmi.5;
        Wed, 18 Mar 2020 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RkKSunecrdPLKcnNKxzvmnKIsOoTfTKrhAcuZUmKydQ=;
        b=RP77wtqCtz0C9CXiblsJHHFm1KESvKnIBb6foy4BlmsU/9zJhONAq8k1S3ON6ME4Y/
         LIR8gcU2aNRExxCo2fjR3YDPMmnjmusjVXaUvSduMBObyJ0GqedeE6Epn1jKIaev40Te
         5NJRcdVX7KW4lQ6JIrzJxadDxR0na/e2PION3gxi0PvB4MfW3Qcj6T90mYdZs7+ICI8Y
         UlETYbNKTGiWFthR5Hd3pU2Ipf0XINEAbBlCQLOZE+m30FcYXKLbcoTQiliHAYh+u5fW
         jBOrnChJbdMHQWkhrX847FCFeDvmWvUvG1iz5FWpIA2gec4q04jeUi8jbXsrwYA7ebRl
         42lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RkKSunecrdPLKcnNKxzvmnKIsOoTfTKrhAcuZUmKydQ=;
        b=GuRfy/kMCf3CQVtrSCVOwpLy/Z+7vAaiaK5W5AiTQircNt0HbgNfwxFKb4w6Or7fhi
         TDB/gxcWjkeaB6jio7QCXzTP8RLWHvU7T1Mmf6uL38vPBtxOCYE6J8FsrN0D1ab1tdIB
         6Duf5YEwk0Pgc19USeGGwHut0Q2Q6YGvC8B/qzVQliKjAOZWvf7RAUXCrKbCPoHwN6hc
         kMWahsYIu5YNfAYFBJnhq1sjwj2mJcV2DihxiuIBOm4KaPpKLJRBMHazSj010YkU50K1
         5Ax29jnesP3XdOXGqGEC5nBissK/+9w7dqx+6oRJn2yC2nzgTKEUUJQwGUGhgsfXC8O1
         tuDQ==
X-Gm-Message-State: ANhLgQ16aCpIAZpO2uuXRkdgRw25Av72Mxg62ACy6rr1cnCAkzec53Z1
        G+Jso9Jv7B5S47ZEoFShTatfibuE
X-Google-Smtp-Source: ADFU+vuXPQGMZO9dMLeAwWTcrRt2PozRD22INYKf21phIHVo2OKRP7l1FDC4rRmyz9r5KKEsnE8oHQ==
X-Received: by 2002:a7b:c4cd:: with SMTP id g13mr5540064wmk.151.1584538657309;
        Wed, 18 Mar 2020 06:37:37 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id f15sm9444002wru.83.2020.03.18.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:37:36 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, mircea.caprioru@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/5] iio: adc: ad7793: define/use own IIO channel macros
Date:   Wed, 18 Mar 2020 15:40:40 +0200
Message-Id: <20200318134042.30133-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318134042.30133-1-alexandru.ardelean@analog.com>
References: <20200318134042.30133-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver seems to use most of the AD_SD_*_CHANNEL. This change will move
them in the driver. The intent is that if a new part comes along which
would require tweaks per IIO channel, these should be doable in the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7793.c | 95 ++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b747db97f78a..5592ae573e6b 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -546,47 +546,94 @@ static const struct iio_info ad7797_info = {
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
+#define __AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift, _extend_name, _type, _mask_all) \
+	{ \
+		.type = (_type), \
+		.differential = (_channel2 == -1 ? 0 : 1), \
+		.indexed = 1, \
+		.channel = (_channel1), \
+		.channel2 = (_channel2), \
+		.address = (_address), \
+		.extend_name = (_extend_name), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_OFFSET), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all = _mask_all, \
+		.scan_index = (_si), \
+		.scan_type = { \
+			.sign = 'u', \
+			.realbits = (_bits), \
+			.storagebits = (_storagebits), \
+			.shift = (_shift), \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
+#define AD7793_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7793_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7793_CHANNEL(_si, _channel, _channel, _address, _bits, \
+		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7793_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
+	__AD7793_CHANNEL(_si, 0, -1, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_TEMP, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7793_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
+	_shift) \
+	__AD7793_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, "supply", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s)), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s)), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s)), \
-	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s)), \
-	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s)), \
-	AD_SD_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s)), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s)), \
+	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s)), \
+	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s)), \
+	AD7793_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s)), \
+	AD7793_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s)), \
+	AD7793_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s)), \
 	IIO_CHAN_SOFT_TIMESTAMP(6), \
 }
 
 #define DECLARE_AD7795_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0), \
+	AD7793_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7793_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0), \
+	AD7793_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(9), \
 }
 
 #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7793_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7793_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0), \
+	AD7793_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
-	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
-	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
-	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0), \
+	AD7793_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0), \
+	AD7793_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0), \
+	AD7793_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(5), \
 }
 
-- 
2.20.1

