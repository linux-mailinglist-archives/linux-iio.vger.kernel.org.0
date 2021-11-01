Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B090441411
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 08:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhKAHVO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhKAHVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 03:21:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53495C061714
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 00:18:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so3903389pjf.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 00:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+dPilqKxL4QBcFGEUfJ9SV7PFgsCTF0dGGnItgMuKA=;
        b=KTn+v+oFC9DT+HmcBoXZLw7o+WHeca6CmSa5sTGvm/YigbU5X5kFOYkHI9q47yxzOa
         GASICwtwss2Cej6QgxS97ZOj3BgQmE0dncPgJoCuP7xrTHY9dAwOoh7ralyt8bvf9NXU
         Itzscar3hC3rq2tJw62yM66h/XYUVdpPEOLbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+dPilqKxL4QBcFGEUfJ9SV7PFgsCTF0dGGnItgMuKA=;
        b=U4U/ppVRQvmRn0tqkGnq+3bY3sKBrJWz083xyasq3/8J0xgEd/se/NiITKvMEUeXtY
         lp05AaSHxFmbpWG3oHXZ/7Dj7KgOcKjV7ZL03MVibvRr/RmtrnfmF9eHyTBbitooz4H8
         aJj860y2744XI6Lcu6xcdd9W6rmyl6jIN7JIJsr04+Sg3yWOdtSVUj6DcRg1SlRu6Plk
         zct7CJn3iwrQJdtEYZboCbNqxWDWjYuClzKWVfVy8zrWpIN/H43iEIkEwwCBYiO5Z9wO
         ouYwhZ1+DD/qUjI8eCYLSe6Zlz1QG/s0kpWUDex61IFKKT13EM0o4NGE1Y0sWcSaVpE7
         JtWg==
X-Gm-Message-State: AOAM531j/a51XMWYTcpXw9JgyzPu6fnNSj3HDsoWF3C6YaBp5QkQfKOu
        Atqt7n4Rh/hzCvu73FGkJrsKoQ==
X-Google-Smtp-Source: ABdhPJyis17bjENsD7PiyE3WRhJKA/WLk6ywmDd/5rCTdImV/jE0hF6P54vL0a8TiyMOkJjsZBqrtA==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr35595386pjb.40.1635751117783;
        Mon, 01 Nov 2021 00:18:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3f65:b35d:616a:31bd])
        by smtp.gmail.com with UTF8SMTPSA id y9sm8154356pjt.27.2021.11.01.00.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 00:18:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/4] iio: Use scan_type shift and realbits when processing raw data
Date:   Mon,  1 Nov 2021 00:18:19 -0700
Message-Id: <20211101071822.522178-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211101071822.522178-1-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When user space application read iio buffer though libiio, data is
converted (see iio_channel_convert()) using the _type sysfs parameter.
In particular, scan_type.shift and scan_type.realbits are used to shift
and tell on how many bits signed elements are encoded on.

When reading elements directly using the raw sysfs attributes, the same
rules for shifting and signing should apply.

Use channel definition as root of trust and replace constant with
them for the simple cases.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/accel/bma220_spi.c     | 3 ++-
 drivers/iio/accel/kxcjk-1013.c     | 3 ++-
 drivers/iio/accel/mma7455_core.c   | 3 ++-
 drivers/iio/accel/sca3000.c        | 5 +++--
 drivers/iio/accel/stk8312.c        | 2 +-
 drivers/iio/accel/stk8ba50.c       | 3 ++-
 drivers/iio/adc/ad7266.c           | 3 ++-
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 drivers/iio/adc/ti-adc12138.c      | 3 ++-
 drivers/iio/magnetometer/mag3110.c | 6 ++++--
 10 files changed, 22 insertions(+), 12 deletions(-)

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
 
diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index c6b75308148aa..938eb6bda73b3 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -730,8 +730,9 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
-			*val = sign_extend32(*val, 12);
+			*val = (be16_to_cpup((__be16 *)st->rx) >>
+					chan->scan_type.shift) & 0x1FFF;
+			*val = sign_extend32(*val, chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
 			ret = sca3000_read_data_short(st,
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
-- 
2.33.1.1089.g2158813163f-goog

