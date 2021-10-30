Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2377844087D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhJ3LVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJ3LVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:21:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17263C061570
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so9234637pjb.0
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTF4Dk4uJY/kWg2ocCOArP3eaIYo6c8QFmGwOA4pKZE=;
        b=JWYwMON8R/M8OOBp4Wz8rHA0JYau2ra97SKnHckcXFy+3BbPvgoCoKAS3uBeOzdXnZ
         kIqVO1H4j2vTKubzX8YJHyq0dY8zd6k6NxPhfUpVanPlpRCFqaQEFFar6IeElGBa/P7Y
         hWqs3FPLGNcWMHXwnv+hP7Cj+oORxhCTIhdYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTF4Dk4uJY/kWg2ocCOArP3eaIYo6c8QFmGwOA4pKZE=;
        b=NMMteKGiExa7zTndN1sLTtfUAmTdKunaAheSiDhqE7XsWhggQckNeCDQ3PlPge6EA5
         KiW1Usqyh111rYISav3B0NUuCkbJjkmWGo7Hc4MYeK/TMVoHJ23J2mz9NtcFM8syO7PI
         7tmjBCMivTvP2bkN8IsVegHZi5hqwgo5Y5Uv60aefofNDkkhxv2zXC12sMs8X9hsrkif
         XlZZuQT6VYG3hI6E2E6TjZ4+nWD+YgAvCspO5jhr1p/n7u0luETfNZsDaKbv5WMUn0El
         krJZ44fR4AD3sqsqjE7XVAhhW3whEUelv1t5P3iDhHMyjdIMRNEU5XwXB+DoGUzIVYE+
         I4YA==
X-Gm-Message-State: AOAM530/1juH6fhpda1FTvLZQrpXXW19EmBn4pKSzX5cCSDVJ1sFw1Qe
        9XpRCmMekKE6KbIuKFp51/QvdQ==
X-Google-Smtp-Source: ABdhPJwCD9glYI+PPuVcWwCrvtQv/vyHFULgdgpCpUxVcOD3E4SoR92iBAvFr8n86gPOExtX5iLRmg==
X-Received: by 2002:a17:90b:4a48:: with SMTP id lb8mr17660169pjb.236.1635592713620;
        Sat, 30 Oct 2021 04:18:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:71f1:234f:bb3d:6ccf])
        by smtp.gmail.com with UTF8SMTPSA id w21sm10423415pfu.68.2021.10.30.04.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 04:18:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/5] iio: Use .realbits to extend a small signed integer
Date:   Sat, 30 Oct 2021 04:18:23 -0700
Message-Id: <20211030111827.1494139-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211030111827.1494139-1-gwendal@chromium.org>
References: <20211030111827.1494139-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When calling sign_extend32() on a channel, use its .realbit information
to limit the number of bits to process, instead of a constant.

Changed only simple sign_extend32() calls, when .realbits was defined in
the same file. Use 'grep -r sign_extend32 $(grep -lr realbits drivers/iio/)'
to locate the files.

Some files were not processed:
gyro/fxas21002c_core.c : function parameter changes needed.
health/max30102.c: Incomplete channel definition.
health/max30100.c

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/bma220_spi.c     | 3 ++-
 drivers/iio/accel/kxcjk-1013.c     | 3 ++-
 drivers/iio/accel/mma7455_core.c   | 3 ++-
 drivers/iio/accel/stk8312.c        | 2 +-
 drivers/iio/accel/stk8ba50.c       | 3 ++-
 drivers/iio/adc/ad7266.c           | 3 ++-
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 drivers/iio/adc/ti-adc12138.c      | 3 ++-
 drivers/iio/adc/ti-ads1015.c       | 8 +++-----
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 drivers/iio/magnetometer/mag3110.c | 6 ++++--
 drivers/iio/pressure/mpl3115.c     | 7 ++++---
 drivers/iio/proximity/sx9310.c     | 3 +--
 13 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index bc4c626e454d3..812d6749b24a7 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -125,7 +125,8 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 		ret = bma220_read_reg(data->spi_device, chan->address);
 		if (ret < 0)
 			return -EINVAL;
-		*val = sign_extend32(ret >> BMA220_DATA_SHIFT, 5);
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a51fdd3c9b5b5..88cf0c276893a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -927,7 +927,8 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
-			*val = sign_extend32(ret >> 4, 11);
+			*val = sign_extend32(ret >> chan->scan_type.shift,
+					     chan->scan_type.realbits - 1);
 			ret = kxcjk1013_set_power_state(data, false);
 		}
 		mutex_unlock(&data->mutex);
diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 777c6c384b09e..e6739ba74edfa 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -134,7 +134,8 @@ static int mma7455_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		*val = sign_extend32(le16_to_cpu(data), 9);
+		*val = sign_extend32(le16_to_cpu(data),
+				     chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 43c621d0f11e4..de0cdf8c1f94c 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -355,7 +355,7 @@ static int stk8312_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			return ret;
 		}
-		*val = sign_extend32(ret, 7);
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 		ret = stk8312_set_mode(data,
 				       data->mode & (~STK8312_MODE_ACTIVE));
 		mutex_unlock(&data->lock);
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index e137a34b5c9a9..517c57ed9e949 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -227,7 +227,8 @@ static int stk8ba50_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			return -EINVAL;
 		}
-		*val = sign_extend32(ret >> STK8BA50_DATA_SHIFT, 9);
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
 		stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
 		mutex_unlock(&data->lock);
 		return IIO_VAL_INT;
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index a8ec3efd659ed..1d345d66742d8 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -159,7 +159,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
-			*val = sign_extend32(*val, 11);
+			*val = sign_extend32(*val,
+					     chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 4c922ef634f8e..92a57cf10fba4 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1586,7 +1586,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		*val = st->conversion_value;
 		ret = at91_adc_adjust_val_osr(st, val);
 		if (chan->scan_type.sign == 's')
-			*val = sign_extend32(*val, 11);
+			*val = sign_extend32(*val,
+					     chan->scan_type.realbits - 1);
 		st->conversion_done = false;
 	}
 
diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index fcd5d39dd03ea..5b5d452105393 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -239,7 +239,8 @@ static int adc12138_read_raw(struct iio_dev *iio,
 		if (ret)
 			return ret;
 
-		*value = sign_extend32(be16_to_cpu(data) >> 3, 12);
+		*value = sign_extend32(be16_to_cpu(data) >> channel->scan_type.shift,
+				       channel->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index b0352e91ac165..b92d4cd1b8238 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -464,9 +464,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->lock);
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW: {
-		int shift = chan->scan_type.shift;
-
+	case IIO_CHAN_INFO_RAW:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			break;
@@ -487,7 +485,8 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 			goto release_direct;
 		}
 
-		*val = sign_extend32(*val >> shift, 15 - shift);
+		*val = sign_extend32(*val >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
 
 		ret = ads1015_set_power_state(data, false);
 		if (ret < 0)
@@ -497,7 +496,6 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 release_direct:
 		iio_device_release_direct_mode(indio_dev);
 		break;
-	}
 	case IIO_CHAN_INFO_SCALE:
 		idx = data->channel_data[chan->address].pga;
 		*val = ads1015_fullscale_range[idx];
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 83bea5ef765da..05050709e4f8a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -943,7 +943,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 				*val = 1000;
 				break;
 			}
-			*val2 = chan->scan_type.realbits;
+			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
 			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index c96415a1aeadd..17c62d806218d 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -291,7 +291,8 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				goto release;
 			*val = sign_extend32(
-				be16_to_cpu(buffer[chan->scan_index]), 15);
+				be16_to_cpu(buffer[chan->scan_index]),
+					    chan->scan_type.realbits - 1);
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_TEMP: /* in 1 C / LSB */
@@ -306,7 +307,8 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			if (ret < 0)
 				goto release;
-			*val = sign_extend32(ret, 7);
+			*val = sign_extend32(ret,
+					     chan->scan_type.realbits - 1);
 			ret = IIO_VAL_INT;
 			break;
 		default:
diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 1eb9e7b29e050..355854f0f59d2 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -74,7 +74,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	__be32 tmp = 0;
+	__be16 tmp = 0;
 	int ret;
 
 	switch (mask) {
@@ -96,7 +96,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			if (ret < 0)
 				break;
-			*val = be32_to_cpu(tmp) >> 12;
+			*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_TEMP: /* in 0.0625 celsius / LSB */
@@ -111,7 +111,8 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			if (ret < 0)
 				break;
-			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
+			*val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
+					     chan->scan_type.realbits - 1);
 			ret = IIO_VAL_INT;
 			break;
 		default:
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index a3fdb59b06d22..31d060c1b0103 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -443,8 +443,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
 	if (ret)
 		goto out_disable_irq;
 
-	*val = sign_extend32(be16_to_cpu(rawval),
-			     chan->address == SX9310_REG_DIFF_MSB ? 11 : 15);
+	*val = sign_extend32(be16_to_cpu(rawval), chan->scan_type.realbits - 1);
 
 	ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
 	if (ret)
-- 
2.33.1.1089.g2158813163f-goog

