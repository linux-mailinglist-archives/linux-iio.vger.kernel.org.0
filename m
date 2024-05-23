Return-Path: <linux-iio+bounces-5209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA138CD16A
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 13:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733061F21F1A
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347791487DC;
	Thu, 23 May 2024 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWqYkEuP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F61487D5;
	Thu, 23 May 2024 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464638; cv=none; b=gogQKZ4PRzJALWP+Vy3cBgZKXrwBZRgPJkkdJFbLW0+VuV2Nrb9apC8CIy5/scememOGfa4MjbuXte1pmNbdpshFyO9B/I65wXuxsloF98z+2jOf+lxwVYqPW7t+jvLkohhCbsXR9HmintArv27u3YIDHEMLufil2aWGoQPzvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464638; c=relaxed/simple;
	bh=8eh/IbYHXMhExCNEDOLqYbFG+3V36ZDcwLykBo9PtY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IkTf/wnYFOPCl9tPWGHj4l3wUaVDDvUsVNzXi/PiD7nPZhCTJHfNHo0u2pUuAW+1xseblsHC4RJAticsGT6pbc3wtyQlg0QnShvcgiQ5Nw4UBa1cr674CXF7WLjZy/+2p442al1jffPZGfU4Nop0yxNh/MUsVWyiJT/w7E+Oik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWqYkEuP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5784315b1bfso1389699a12.0;
        Thu, 23 May 2024 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716464634; x=1717069434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHqPKJDgvzsY/M90Gdigu74HJUZvVXWyG2zkex95Xvs=;
        b=IWqYkEuPa7YvEmogRbeJviBDpqcDSoKdKLOnZsjqbeRKhUzYCcgnm+jqt4EZY3jTRV
         OOdPNlU3ujeUOZDMSa8zy69P/qFKvsfO8ljThjlEty+3ARfW0u665e9WcJeAAXUBOsPh
         9xzOxLO5S1rdjHnm7L6GenYDFJSe5hLIPeC+9bKnE+zdWAus8jAXVSETC52uT2snXR9o
         Aiyge8Le+sy6ZPOvaB7jQTLilD34Qbev36cugWZ0/3iMSa8bPc98GTPQI7pnQloTaA8T
         Y9WoAZEv0L08h8d91EQg2p4g23l90YxWXiThqryWITUzOlxMXn9Q8YYBMBzoJU0RX7BT
         0VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716464634; x=1717069434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHqPKJDgvzsY/M90Gdigu74HJUZvVXWyG2zkex95Xvs=;
        b=ljPGgy08g+UgXsRf26oOhgqVplPPMYBSVozX7nKhmFHZvYr43ujGCseBFJEIPbA2sQ
         uKv2XvcHfoVjWQxWbKvsYY/t2u/mM59AGI4kqgLdMOMjCQPwATIU1hgR1OVPwcL1zx/F
         Zs+E31RCG+86NvfVnoUm+6WshTIFoa8Egk4CoJMr/VMSbKXVE/+egB7TIABjPmMpJs9K
         MF4afaNLHEERCcBJt6WPcnimPmzjSViLt9s3iIe3OBs55XhnyWdVxcqwt2XmAdSchk7O
         9UT+iajObh3sdD1H+esszob/CvHH/PS7SbZLRd0IDlAIufQ8/mDQ/GtQXFimldyubBfE
         R3hw==
X-Forwarded-Encrypted: i=1; AJvYcCWLLlDRclO10ruwW39svnaeRYnJPFDUBJ7v3XoVve3T9gLT4ihaJZVX1K2JnHBzweovuFQs0JOVflCUjJinYa9ZWKWFkp7Z7PcBnuiAQcXLbYX0IO78SZov7dpa54M13oNv8r9aCqgq
X-Gm-Message-State: AOJu0YwetliVxPJSnGle+1NC7/EmFA+RrpmzwJbrKC8QKjh0jjX3UpJL
	1TplZhi7rZLUyIu13LX8oKV2KLA7zuXzwdATEkrbZsTJxNdIa1H7
X-Google-Smtp-Source: AGHT+IE2U06VbkRX8cDoKt9JmTuRaa9xC2WZGeS86bGXmMa7XlycDKur0BgEkDQZoXE1IGAufEodZQ==
X-Received: by 2002:a50:9e2e:0:b0:574:ebf4:f786 with SMTP id 4fb4d7f45d1cf-57843ef8e9dmr1505060a12.16.1716464634026;
        Thu, 23 May 2024 04:43:54 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5783499fd06sm2536573a12.1.2024.05.23.04.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:43:53 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hdc3020: fix hysteresis representation
Date: Thu, 23 May 2024 13:43:35 +0200
Message-Id: <20240523114336.532428-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the ABI docs hysteresis values are represented as offsets to
threshold values. Current implementation represents hysteresis values as
absolute values which is wrong. Nevertheless the device stores them as
absolute values and the datasheet refers to them as clear thresholds. Fix
the reading and writing of hysteresis values by including thresholds into
calculations.

Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---

Since absolute values are used on the device, the hysteresis values are
influenced by setting thresholds. Is this behavior in line with the ABI docs ?
It can be fixed by readjusting the threshold clear value whenever setting
thresholds to have the same hysteresis value as before. See some example below:

# echo 25 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
# cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
24.727626459
# echo 5 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
# cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
5.127031357
# echo 35 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
# cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
15.381094071

Below are some corner cases tested by setting threshold and hysteresis values.
To check that the threshold clear values are correct, registers are read out by
using i2ctransfer and the corresponding temperature and relative humidity
thresholds are calculated using the formulas in the datasheet.

# echo 125 > in_temp_thresh_rising_value
# cat in_temp_thresh_rising_value
124.875638971

# echo 165 > in_temp_thresh_rising_hysteresis
# cat in_temp_thresh_rising_hysteresis
164.748607614

# echo 100 > in_humidityrelative_thresh_rising_value
# cat in_humidityrelative_thresh_rising_value
99.220263981

# echo 100 > in_humidityrelative_thresh_rising_hysteresis
# cat in_humidityrelative_thresh_rising_hysteresis
99.220263981

threshold high, temperature = 124,875638972 C, humidity = 99.220263981
# i2ctransfer -f -y 4 w2@0x44 0xe1 0x1f r3
0xff 0xf1 0xb3

threshold high clear, temperature = -39.872968643 C, humidity = 0
# i2ctransfer -f -y 4 w2@0x44 0xe1 0x14 r3
0x00 0x0f 0xaf


# echo -40 > in_temp_thresh_falling_value
# cat in_temp_thresh_falling_value
-39.872968642

# echo 165 > in_temp_thresh_falling_hysteresis
# cat in_temp_thresh_falling_hysteresis
164.406805523

# echo 0 > in_humidityrelative_thresh_falling_value 
# cat in_humidityrelative_thresh_falling_value
0.000000000

# echo 100 > in_humidityrelative_thresh_falling_hysteresis 
# cat in_humidityrelative_thresh_falling_hysteresis
99.220263981

threshold low, temperature = -39.872968643 C, humidity = 0
# i2ctransfer -f -y 4 w2@0x44 0xe1 0x02 r3
0x00 0x0f 0xaf

threshold low clear, temperature = 124,533836881 C, humidity = 99,220263981
# i2ctransfer -f -y 4 w2@0x44 0xe1 0x09 r3
0xff 0xf0 0x82

---
 drivers/iio/humidity/hdc3020.c | 292 +++++++++++++++++++++++++--------
 1 file changed, 221 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index cdc4789213ba..d41713ff1deb 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -19,6 +19,8 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
@@ -66,8 +68,10 @@
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
-#define HDC3020_MIN_TEMP		-40
-#define HDC3020_MAX_TEMP		125
+#define HDC3020_MIN_TEMP_MICRO		-39872968
+#define HDC3020_MAX_TEMP_MICRO		124875639
+#define HDC3020_MAX_TEMP_HYST_MICRO	164748607
+#define HDC3020_MAX_HUM_MICRO		99220264
 
 struct hdc3020_data {
 	struct i2c_client *client;
@@ -368,6 +372,75 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int hdc3020_tresh_get_temp(u16 thresh)
+{
+	int temp;
+
+	/*
+	 * Get the temperature threshold from 9 LSBs, shift them to get
+	 * the truncated temperature threshold representation and
+	 * calculate the threshold according to the formula in the
+	 * datasheet. Result is degree celsius scaled by 65535.
+	 */
+	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
+	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+
+	return -2949075 + (175 * temp);
+}
+
+static int hdc3020_tresh_get_hum(u16 thresh)
+{
+	int hum;
+
+	/*
+	 * Get the humidity threshold from 7 MSBs, shift them to get the
+	 * truncated humidity threshold representation and calculate the
+	 * threshold according to the formula in the datasheet. Result is
+	 * percent scaled by 65535.
+	 */
+	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
+	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
+
+	return hum * 100;
+}
+
+static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
+{
+	u64 temp;
+	u16 thresh;
+
+	/*
+	 * Calculate temperature threshold, shift it down to get the
+	 * truncated threshold representation in the 9LSBs while keeping
+	 * the current humidity threshold in the 7 MSBs.
+	 */
+	temp = (u64)(s_temp + 45000000) * 65535ULL;
+	temp = div_u64(temp, 1000000 * 175) >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
+	thresh = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, temp);
+	thresh |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, curr_thresh) <<
+		  HDC3020_THRESH_HUM_TRUNC_SHIFT);
+
+	return thresh;
+}
+
+static u16 hdc3020_thresh_set_hum(int s_hum, u16 curr_thresh)
+{
+	u64 hum;
+	u16 thresh;
+
+	/*
+	 * Calculate humidity threshold, shift it down and up to get the
+	 * truncated threshold representation in the 7MSBs while keeping
+	 * the current temperature threshold in the 9 LSBs.
+	 */
+	hum = (u64)(s_hum) * 65535ULL;
+	hum = div_u64(hum, 1000000 * 100) >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
+	thresh = FIELD_PREP(HDC3020_THRESH_HUM_MASK, hum);
+	thresh |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, curr_thresh);
+
+	return thresh;
+}
+
 static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
@@ -376,65 +449,130 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 				int val, int val2)
 {
 	struct hdc3020_data *data = iio_priv(indio_dev);
+	u16 reg, reg_val, reg_thresh_rd, reg_clr_rd, reg_thresh_wr, reg_clr_wr;
+	s64 s_thresh, s_hyst, s_clr;
+	int s_val, ret;
 	u8 buf[5];
-	u64 tmp;
-	u16 reg;
-	int ret;
-
-	/* Supported temperature range is from –40 to 125 degree celsius */
-	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
-		return -EINVAL;
 
-	/* Select threshold register */
-	if (info == IIO_EV_INFO_VALUE) {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_S_T_RH_THRESH_HIGH;
-		else
-			reg = HDC3020_S_T_RH_THRESH_LOW;
+	/* Select threshold registers */
+	if (dir == IIO_EV_DIR_RISING) {
+		reg_thresh_rd = HDC3020_R_T_RH_THRESH_HIGH;
+		reg_thresh_wr = HDC3020_S_T_RH_THRESH_HIGH;
+		reg_clr_rd = HDC3020_R_T_RH_THRESH_HIGH_CLR;
+		reg_clr_wr = HDC3020_S_T_RH_THRESH_HIGH_CLR;
 	} else {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_S_T_RH_THRESH_HIGH_CLR;
-		else
-			reg = HDC3020_S_T_RH_THRESH_LOW_CLR;
+		reg_thresh_rd = HDC3020_R_T_RH_THRESH_LOW;
+		reg_thresh_wr = HDC3020_S_T_RH_THRESH_LOW;
+		reg_clr_rd = HDC3020_R_T_RH_THRESH_LOW_CLR;
+		reg_clr_wr = HDC3020_S_T_RH_THRESH_LOW_CLR;
 	}
 
 	guard(mutex)(&data->lock);
-	ret = hdc3020_read_be16(data, reg);
+	ret = hdc3020_read_be16(data, reg_thresh_rd);
 	if (ret < 0)
 		return ret;
 
+	/* Scale value to include decimal part into calculations */
+	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
+
 	switch (chan->type) {
 	case IIO_TEMP:
-		/*
-		 * Calculate temperature threshold, shift it down to get the
-		 * truncated threshold representation in the 9LSBs while keeping
-		 * the current humidity threshold in the 7 MSBs.
-		 */
-		tmp = ((u64)(((val + 45) * MICRO) + val2)) * 65535ULL;
-		tmp = div_u64(tmp, MICRO * 175);
-		val = tmp >> HDC3020_THRESH_TEMP_TRUNC_SHIFT;
-		val = FIELD_PREP(HDC3020_THRESH_TEMP_MASK, val);
-		val |= (FIELD_GET(HDC3020_THRESH_HUM_MASK, ret) <<
-			HDC3020_THRESH_HUM_TRUNC_SHIFT);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			/* Range is from –40 to 125 degree celsius */
+			s_val = max(s_val, HDC3020_MIN_TEMP_MICRO);
+			s_val = min(s_val, HDC3020_MAX_TEMP_MICRO);
+
+			reg = reg_thresh_wr;
+			reg_val = hdc3020_thresh_set_temp(s_val, ret);
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			/*
+			 * Function hdc3020_tresh_get_temp returns temperature
+			 * in degree celsius scaled by 65535. Scale by 1000000
+			 * to be able to subtract scaled hysteresis value.
+			 */
+			s_thresh = (s64)hdc3020_tresh_get_temp(ret) * 1000000;
+			/*
+			 * Units of s_val are in micro degree celsius, scale by
+			 * 65535 to get same units as s_thresh.
+			 */
+			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
+			s_hyst = (s64)s_val * 65535;
+			/*
+			 * Include directions when calculation the clear value,
+			 * since hysteresis is unsigned by definition and the
+			 * clear value is an absolute value which is signed.
+			 */
+			if (dir == IIO_EV_DIR_RISING)
+				s_clr = s_thresh - s_hyst;
+			else
+				s_clr = s_thresh + s_hyst;
+
+			/* Devide by 65535 to get units of micro degree celsius */
+			s_val = div_s64(s_clr, 65535);
+			ret = hdc3020_read_be16(data, reg_clr_rd);
+			if (ret < 0)
+				return ret;
+
+			reg = reg_clr_wr;
+			reg_val = hdc3020_thresh_set_temp(s_val, ret);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		break;
 	case IIO_HUMIDITYRELATIVE:
-		/*
-		 * Calculate humidity threshold, shift it down and up to get the
-		 * truncated threshold representation in the 7MSBs while keeping
-		 * the current temperature threshold in the 9 LSBs.
-		 */
-		tmp = ((u64)((val * MICRO) + val2)) * 65535ULL;
-		tmp = div_u64(tmp, MICRO * 100);
-		val = tmp >> HDC3020_THRESH_HUM_TRUNC_SHIFT;
-		val = FIELD_PREP(HDC3020_THRESH_HUM_MASK, val);
-		val |= FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			/* Range is from 0 to 100 percent */
+			s_val = min(abs(s_val), HDC3020_MAX_HUM_MICRO);
+
+			reg = reg_thresh_wr;
+			reg_val = hdc3020_thresh_set_hum(s_val, ret);
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			/*
+			 * Function hdc3020_tresh_get_hum returns relative
+			 * humidity in percent scaled by 65535. Scale by 1000000
+			 * to be able to subtract scaled hysteresis value.
+			 */
+			s_thresh = (s64)hdc3020_tresh_get_hum(ret) * 1000000;
+			/*
+			 * Units of s_val are in micro percent, scale by 65535
+			 * to get same units as s_thresh.
+			 */
+			s_val = min(abs(s_val), HDC3020_MAX_HUM_MICRO);
+			s_hyst = (s64)s_val * 65535;
+			/*
+			 * Include directions when calculation the clear value,
+			 * since hysteresis is unsigned by definition and the
+			 * clear value is an absolute value which is signed.
+			 */
+			if (dir == IIO_EV_DIR_RISING)
+				s_clr = s_thresh - s_hyst;
+			else
+				s_clr = s_thresh + s_hyst;
+
+			/* Devide by 65535 to get units of micro degree percent */
+			s_val = div_s64(s_clr, 65535);
+			ret = hdc3020_read_be16(data, reg_clr_rd);
+			if (ret < 0)
+				return ret;
+
+			reg = reg_clr_wr;
+			reg_val = hdc3020_thresh_set_hum(s_val, ret);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
 	put_unaligned_be16(reg, buf);
-	put_unaligned_be16(val, buf + 2);
+	put_unaligned_be16(reg_val, buf + 2);
 	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
 	return hdc3020_write_bytes(data, buf, 5);
 }
@@ -447,48 +585,60 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 			       int *val, int *val2)
 {
 	struct hdc3020_data *data = iio_priv(indio_dev);
-	u16 reg;
-	int ret;
+	u16 reg_thresh, reg_clr;
+	int thresh, clr, ret;
 
-	/* Select threshold register */
-	if (info == IIO_EV_INFO_VALUE) {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_R_T_RH_THRESH_HIGH;
-		else
-			reg = HDC3020_R_T_RH_THRESH_LOW;
+	/* Select threshold registers */
+	if (dir == IIO_EV_DIR_RISING) {
+		reg_thresh = HDC3020_R_T_RH_THRESH_HIGH;
+		reg_clr = HDC3020_R_T_RH_THRESH_HIGH_CLR;
 	} else {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_R_T_RH_THRESH_HIGH_CLR;
-		else
-			reg = HDC3020_R_T_RH_THRESH_LOW_CLR;
+		reg_thresh = HDC3020_R_T_RH_THRESH_LOW;
+		reg_clr = HDC3020_R_T_RH_THRESH_LOW_CLR;
 	}
 
 	guard(mutex)(&data->lock);
-	ret = hdc3020_read_be16(data, reg);
+	ret = hdc3020_read_be16(data, reg_thresh);
 	if (ret < 0)
 		return ret;
 
 	switch (chan->type) {
 	case IIO_TEMP:
-		/*
-		 * Get the temperature threshold from 9 LSBs, shift them to get
-		 * the truncated temperature threshold representation and
-		 * calculate the threshold according to the formula in the
-		 * datasheet.
-		 */
-		*val = FIELD_GET(HDC3020_THRESH_TEMP_MASK, ret);
-		*val = *val << HDC3020_THRESH_TEMP_TRUNC_SHIFT;
-		*val = -2949075 + (175 * (*val));
+		thresh = hdc3020_tresh_get_temp(ret);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			*val = thresh;
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = hdc3020_read_be16(data, reg_clr);
+			if (ret < 0)
+				return ret;
+
+			clr = hdc3020_tresh_get_temp(ret);
+			*val = abs(thresh - clr);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		*val2 = 65535;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_HUMIDITYRELATIVE:
-		/*
-		 * Get the humidity threshold from 7 MSBs, shift them to get the
-		 * truncated humidity threshold representation and calculate the
-		 * threshold according to the formula in the datasheet.
-		 */
-		*val = FIELD_GET(HDC3020_THRESH_HUM_MASK, ret);
-		*val = (*val << HDC3020_THRESH_HUM_TRUNC_SHIFT) * 100;
+		thresh = hdc3020_tresh_get_hum(ret);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			*val = thresh;
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = hdc3020_read_be16(data, reg_clr);
+			if (ret < 0)
+				return ret;
+
+			clr = hdc3020_tresh_get_hum(ret);
+			*val = abs(thresh - clr);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		*val2 = 65535;
 		return IIO_VAL_FRACTIONAL;
 	default:
-- 
2.39.2


