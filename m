Return-Path: <linux-iio+bounces-5869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64368FD661
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 21:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE101F26B08
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E320B14D2A6;
	Wed,  5 Jun 2024 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHzqVKED"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936A13D27F;
	Wed,  5 Jun 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615308; cv=none; b=iNDuFTHRH+Dbk/mbTaSozca9szTanQJRuaWmi5BIBraDXMLHH5DF/DNn2ZqDozt6NKotChhlSeb4oSRBZAWyAYdeIH/rFWk6yMmAqQW/JNee/VNcye/Aj0ZBpK1NQ3h+IBhEQvYi/jnecQ+FdyLGUgFAzx7zndOLBBgvbF945wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615308; c=relaxed/simple;
	bh=34jH++OQXrP76J0PqNCKdRZbZTtIGQRgpZJjuYCNtjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=O7W79fIf1NcTY10/KyNMJ5S/F5DE7qKfIkao2yejpY4WKppD1H7dGqJ5F4oZ7JOOu4kc3hyPpZaZLch7RJSbwa6bZCHyJX0B6zkdVaEQ1AdZStS3oSkLgsGAzr6+oUmmZNpUzepvNSqFJmLMeX9aV1+YW+Fq2XpH0zYCehGt2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHzqVKED; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a9a3bc083so81986a12.1;
        Wed, 05 Jun 2024 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717615305; x=1718220105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJ8ZLb0WS7TOmDBTNZ1nFs21aD7zHBqe+0fBooN+GQo=;
        b=IHzqVKEDVWvI9V5KahQzzZ8kbzJMm8qUkSANEcpB8PgbBQvyLj3ZPSx/HQUMoPeZE5
         NYpgDUqoU19g0SONw0g0hZA6z3dXzlw0sgbtH/QsfxQ0klHPUF1dQh5bbL7HB9eWPh6B
         gk+rod69GRVs3GlVxPdVwSdTV2L+B5Xs6ykk4KG/dJd/k7zSGU9tUV8MzuBAkLHRs0AJ
         HpqEiNKZZ6XhEdFLzhaahhdRie8cd7M2/v+D30kZIW9YYfT4ScQ9tZP/0qjTUOuOU1ZA
         qIuelJACXTNpCb54dYa8oAe7OqD4/86DZKB7QF8w7gvrhKiZomz91dZKGT2boxHT4r/p
         jvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615305; x=1718220105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJ8ZLb0WS7TOmDBTNZ1nFs21aD7zHBqe+0fBooN+GQo=;
        b=WRIz53MSyGJWETnTwAm/xGAdrOlBvP+F94+ov3jvbqnoouM2grqk8cAG3/rCtQWmgy
         6b01q1ou15bcmsdoyfGzJZJP0Zh8sP6YsdNklVNU2CEKaEJHHPHGxLyQsbn4j8/vYD6c
         l/Z+9CW1W9X/mJjsFbEQE4XmAG8wGveLtmQdCHqyM+Fen2Kg9hBVSU0AvCsnP4laPhCP
         7OvNzPOusqZeZe6B/AraCa7hcYNkINSM8U8SeGcz4sv2ph2aGUUT7tXX0PTMXP4ekqCz
         Ccu5uf/l9nVEWVrO8RJ3xkkUXKvS7Y9EMbchasq/yS856M/4o+iQG7obmUctpSp9icvg
         b9EA==
X-Forwarded-Encrypted: i=1; AJvYcCXMQ8cl/P5sBjVEhZU+vx1uKlh/Qm2FD1ltoTcpkHakAowlte2uYZEu42PYxIRhNqPQEElyuroijkdH6iiXg1xbXgroEQm6mHid+/X2LI3+Tb933TOd+/dIljoXirXHr51kgk63210v
X-Gm-Message-State: AOJu0YyX9S6xXGcfKNp5ck6/mBmH5ZojGfD3xa9XTbS3MWcCuXECtmOe
	Za6FjSfaD5az4uSFkHicJoTADA/IukWon30sIbq8NdidYav7r6qCMqWmWw==
X-Google-Smtp-Source: AGHT+IGrzWAciBbOpQgDDhjDGVNxOxyBVDUFSGXUhRdGBkGsjvF9vgjK8AOsdQWyjY3u8s3eyA/GsQ==
X-Received: by 2002:a50:d597:0:b0:572:a770:1371 with SMTP id 4fb4d7f45d1cf-57a8bcc6116mr2468914a12.42.1717615304652;
        Wed, 05 Jun 2024 12:21:44 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb8225sm9520029a12.24.2024.06.05.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:21:44 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: humidity: hdc3020: fix hysteresis representation
Date: Wed,  5 Jun 2024 21:21:35 +0200
Message-Id: <20240605192136.38146-1-dima.fedrau@gmail.com>
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
calculations. Hysteresis values that result in threshold clear values
that are out of limits will be truncated.

To check that the threshold clear values are correct, registers are read
out using i2ctransfer and the corresponding temperature and relative
humidity thresholds are calculated using the formulas in the datasheet.

Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---

Changes in V3:
  - Add missing changes
  - Remove math.h, already included in math64.h
  - Drop range comments
  - Fix typo devide divide
  - Add empty line before return in hdc3020_write_thresh
  - Keep hysteresis value when changing the threshold

---
 drivers/iio/humidity/hdc3020.c | 325 +++++++++++++++++++++++++--------
 1 file changed, 249 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index cdc4789213ba..cf00999b826d 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
@@ -66,8 +67,10 @@
 
 #define HDC3020_CRC8_POLYNOMIAL		0x31
 
-#define HDC3020_MIN_TEMP		-40
-#define HDC3020_MAX_TEMP		125
+#define HDC3020_MIN_TEMP_MICRO		-39872968
+#define HDC3020_MAX_TEMP_MICRO		124875639
+#define HDC3020_MAX_TEMP_HYST_MICRO	164748607
+#define HDC3020_MAX_HUM_MICRO		99220264
 
 struct hdc3020_data {
 	struct i2c_client *client;
@@ -368,6 +371,105 @@ static int hdc3020_write_raw(struct iio_dev *indio_dev,
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
+static
+int hdc3020_thresh_clr(s64 s_thresh, s64 s_hyst, enum iio_event_direction dir)
+{
+	s64 s_clr;
+
+	/*
+	 * Include directions when calculation the clear value,
+	 * since hysteresis is unsigned by definition and the
+	 * clear value is an absolute value which is signed.
+	 */
+	if (dir == IIO_EV_DIR_RISING)
+		s_clr = s_thresh - s_hyst;
+	else
+		s_clr = s_thresh + s_hyst;
+
+	/* Divide by 65535 to get units of micro */
+	return div_s64(s_clr, 65535);
+}
+
+static int _hdc3020_write_thresh(struct hdc3020_data *data, u16 reg, u16 val)
+{
+	u8 buf[5];
+
+	put_unaligned_be16(reg, buf);
+	put_unaligned_be16(val, buf + 2);
+	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
+
+	return hdc3020_write_bytes(data, buf, 5);
+}
+
 static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
@@ -376,67 +478,126 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 				int val, int val2)
 {
 	struct hdc3020_data *data = iio_priv(indio_dev);
-	u8 buf[5];
-	u64 tmp;
-	u16 reg;
-	int ret;
-
-	/* Supported temperature range is from –40 to 125 degree celsius */
-	if (val < HDC3020_MIN_TEMP || val > HDC3020_MAX_TEMP)
-		return -EINVAL;
-
-	/* Select threshold register */
-	if (info == IIO_EV_INFO_VALUE) {
-		if (dir == IIO_EV_DIR_RISING)
-			reg = HDC3020_S_T_RH_THRESH_HIGH;
-		else
-			reg = HDC3020_S_T_RH_THRESH_LOW;
+	u16 reg, reg_val, reg_thresh_rd, reg_clr_rd, reg_thresh_wr, reg_clr_wr;
+	s64 s_thresh, s_hyst, s_clr;
+	int s_val, thresh, clr, ret;
+
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
+	if (ret < 0)
+		return ret;
+
+	thresh = ret;
+	ret = hdc3020_read_be16(data, reg_clr_rd);
 	if (ret < 0)
 		return ret;
 
+	clr = ret;
+	/* Scale value to include decimal part into calculations */
+	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
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
+			s_val = max(s_val, HDC3020_MIN_TEMP_MICRO);
+			s_val = min(s_val, HDC3020_MAX_TEMP_MICRO);
+			reg = reg_thresh_wr;
+			reg_val = hdc3020_thresh_set_temp(s_val, thresh);
+			ret = _hdc3020_write_thresh(data, reg, reg_val);
+			if (ret < 0)
+				return ret;
+
+			/* Calculate old hysteresis */
+			s_thresh = (s64)hdc3020_tresh_get_temp(thresh) * 1000000;
+			s_clr = (s64)hdc3020_tresh_get_temp(clr) * 1000000;
+			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			/* Set new threshold */
+			thresh = reg_val;
+			/* Set old hysteresis */
+			s_val = s_hyst;
+			fallthrough;
+		case IIO_EV_INFO_HYSTERESIS:
+			/*
+			 * Function hdc3020_tresh_get_temp returns temperature
+			 * in degree celsius scaled by 65535. Scale by 1000000
+			 * to be able to subtract scaled hysteresis value.
+			 */
+			s_thresh = (s64)hdc3020_tresh_get_temp(thresh) * 1000000;
+			/*
+			 * Units of s_val are in micro degree celsius, scale by
+			 * 65535 to get same units as s_thresh.
+			 */
+			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
+			s_hyst = (s64)s_val * 65535;
+			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
+			s_clr = max(s_clr, HDC3020_MIN_TEMP_MICRO);
+			s_clr = min(s_clr, HDC3020_MAX_TEMP_MICRO);
+			reg = reg_clr_wr;
+			reg_val = hdc3020_thresh_set_temp(s_clr, clr);
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
+		s_val = (s_val < 0) ? 0 : min(s_val, HDC3020_MAX_HUM_MICRO);
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			reg = reg_thresh_wr;
+			reg_val = hdc3020_thresh_set_hum(s_val, thresh);
+			ret = _hdc3020_write_thresh(data, reg, reg_val);
+			if (ret < 0)
+				return ret;
+
+			/* Calculate old hysteresis */
+			s_thresh = (s64)hdc3020_tresh_get_hum(thresh) * 1000000;
+			s_clr = (s64)hdc3020_tresh_get_hum(clr) * 1000000;
+			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			/* Set new threshold */
+			thresh = reg_val;
+			/* Try to set old hysteresis */
+			s_val = min(abs(s_hyst), HDC3020_MAX_HUM_MICRO);
+			fallthrough;
+		case IIO_EV_INFO_HYSTERESIS:
+			/*
+			 * Function hdc3020_tresh_get_hum returns relative
+			 * humidity in percent scaled by 65535. Scale by 1000000
+			 * to be able to subtract scaled hysteresis value.
+			 */
+			s_thresh = (s64)hdc3020_tresh_get_hum(thresh) * 1000000;
+			/*
+			 * Units of s_val are in micro percent, scale by 65535
+			 * to get same units as s_thresh.
+			 */
+			s_hyst = (s64)s_val * 65535;
+			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
+			s_clr = max(s_clr, 0);
+			s_clr = min(s_clr, HDC3020_MAX_HUM_MICRO);
+			reg = reg_clr_wr;
+			reg_val = hdc3020_thresh_set_hum(s_clr, clr);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
-	put_unaligned_be16(reg, buf);
-	put_unaligned_be16(val, buf + 2);
-	buf[4] = crc8(hdc3020_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
-	return hdc3020_write_bytes(data, buf, 5);
+	return _hdc3020_write_thresh(data, reg, reg_val);
 }
 
 static int hdc3020_read_thresh(struct iio_dev *indio_dev,
@@ -447,48 +608,60 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
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


