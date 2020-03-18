Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB4189D25
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 14:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgCRNhk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 09:37:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35673 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCRNhi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 09:37:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so3408719wmi.0;
        Wed, 18 Mar 2020 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3t2fRa2PJe34Peod55apFClQDGZv5u9o9GW8ycI9VA=;
        b=Z1MxHCUG7EwfhY5eR75sRxLc8oEd2odfeRlFX++H4ApBql1MNNQrNqBv15ybNQSkLz
         L80V4D+N8TgqpHHO1AnZH7QLUN0XJFPIps1LS9Z/5aSn90pTwD71vTiiGgLMiwOhaVNl
         H6KuXqn7fg5NYPzpwFtmE1dt2MWwqpWhg1DQN5c+m/urPTBlZmOix2qsbGdQsnS7OaIy
         qqd2TZMAalB7UNZR8fp9Yxm1lNKG2VAF7lP33Y2y2AAoDf+luGeuq4hwPWS6ePamcxvn
         MfJ0oYEyCyaQJgoEPVl9Q25JtSRTLjEQ959l1MwSdAdZwU3eWa4acbKAYfe5b5ZrdPYO
         ZnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3t2fRa2PJe34Peod55apFClQDGZv5u9o9GW8ycI9VA=;
        b=bsesBzSpT3TVhFg4hZwPZxL8BOLrZbOPlAd1hudk+H/yXK23BzetDqK23n+rT9Cefs
         zbI/6T+0zREc+/WLgLeHreN4USq1C08DMjq0dyW4xANLLamJGSEO3/9mzIaH3JPcu5zr
         ZGtxkWS1+KP1IZQbe+QwmM97Q3OD2yEYZ5X0Y2B/NhouRY7YJIZoawFz2EhB4fI4rfkh
         ecnj6pBQwrL3fNno4DL7b8uHmpRE3ndckk39KyI5WljJbcxGHDY4lA7QAlVix1MFZfjA
         B1IzRf1YCozqdR91IcAkR/qRgUo2sBYk+n4K8jZ77O6pZuxT+LXMHFouXWwzFdKqbZjl
         kPbw==
X-Gm-Message-State: ANhLgQ0Fn2V5JmCqtvYQbGrx7g7vxFolb9DCxsE5pZxi+qY1d5u/NYfQ
        F5M0hWfca45wwLSHGPkvLOVNnLaM
X-Google-Smtp-Source: ADFU+vsrTPl1ovbosq+edlNKHjrEkZ9r0ThJJa6t2k7mvNxZguILmAK3mlj2yvPd/auY3dYqb3bXeA==
X-Received: by 2002:a1c:23c8:: with SMTP id j191mr3719141wmj.117.1584538656208;
        Wed, 18 Mar 2020 06:37:36 -0700 (PDT)
Received: from saturn.lan ([188.26.73.247])
        by smtp.gmail.com with ESMTPSA id f15sm9444002wru.83.2020.03.18.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:37:35 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
X-Google-Original-From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, renatogeh@gmail.com, lars@metafoo.de,
        jic23@kernel.org, mircea.caprioru@analog.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/5] iio: adc: ad7791: define/use own IIO channel macros
Date:   Wed, 18 Mar 2020 15:40:39 +0200
Message-Id: <20200318134042.30133-3-alexandru.ardelean@analog.com>
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
 drivers/iio/adc/ad7791.c | 62 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index abb239392631..ba22808507d0 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -64,25 +64,73 @@
 #define AD7791_MODE_SEL_MASK		(0x3 << 6)
 #define AD7791_MODE_SEL(x)		((x) << 6)
 
+#define __AD7991_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
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
+#define AD7991_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7991_CHANNEL(_si, _channel, _channel, _address, _bits, \
+		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7991_CHANNEL(_si, _channel, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7991_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		 BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7991_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+	_storagebits, _shift) \
+	__AD7991_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
+		_storagebits, _shift, NULL, IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
+#define AD7991_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
+	_shift) \
+	__AD7991_CHANNEL(_si, _channel, -1, _address, _bits, \
+		_storagebits, _shift, "supply", IIO_VOLTAGE, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ))
+
 #define DECLARE_AD7787_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
+	AD7991_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0), \
-	AD_SD_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
+	AD7991_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0), \
+	AD7991_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
+	AD7991_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
 		(bits), (storagebits), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7791_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
-	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
+	AD7991_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
+	AD7991_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
 		(bits), (storagebits), 0), \
-	AD_SD_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
+	AD7991_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
 		(bits), (storagebits), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(3), \
 }
-- 
2.20.1

