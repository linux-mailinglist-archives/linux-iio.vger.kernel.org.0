Return-Path: <linux-iio+bounces-5867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3D8FD649
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 21:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B06B227B2
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574913BC3B;
	Wed,  5 Jun 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFVYmlGA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633813A3EF;
	Wed,  5 Jun 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614763; cv=none; b=WIzYDy/BKYLDLimFpDsLbAXsxpbFKHWBbdNMIpGR/+8p+D/egfAnZ3ToayOLkAob38KFCjYo60vDLZ2yuIgpGcnIoiCWhgvHc+FjcFZb2em+apeVZPf+1a1BPMOYH9IigO1lQojDjCtgtjECxJ5h0TRYdz2TmSMwIPfa59L7FTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614763; c=relaxed/simple;
	bh=aUfJFJFL95vh9Nv0/EnkKS5i2CafCrBx0uJqjx8K4L0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u7uMN1ISjHXjGDe0ojkU76MlkCdLy4ZfR1dGA32PuOhMYJperRceu7sg9Lvd2VHM4dx4ATpsK9dQQvhMQnz5H3U6pmBu+pxbEAJAcaNd9fOHaLDo2M/U8SPkUC8c88Zb5zdrNLMKdnPKyJlo7PLpUs5kcNhGDvlHddGKpQt1PzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFVYmlGA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3550134ef25so122844f8f.1;
        Wed, 05 Jun 2024 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717614759; x=1718219559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buGKS569NpjCI1Fsa3L36g/SPMJvZ7911ysBqHG/82Y=;
        b=cFVYmlGA3BPu4EFiLBsN9ot3Z8gr8fvzH+lO6zAN4eGwu9qiair3EJwx3zcxdMk8vT
         pBxPHnx/KPBPATI1PjC5/nPQl0nSMQtcZJMJOpq+CANiJcPywKOf/27X8zq3p3CuxPbW
         gB5fYfIX1yuhUYJFOgTAugO5pbmi3Cm2SN4B0SJw+iBi5XVZcX9ORCM+e3c9JsBQl7Su
         QXiaUulIeDBFhTQXmEztaW5tL6vjg3ywtNfx/rnq/d8qe4lVS88Pd28QlmpU1dMGw2eS
         pr9aivhoEB4Z+QtrNFmQ6qHDbEEKrcI5g4qt9mhO+5SzHA24CBnvq2Um0X3VDQ8HpvDs
         5+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717614759; x=1718219559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buGKS569NpjCI1Fsa3L36g/SPMJvZ7911ysBqHG/82Y=;
        b=GfaLNWEOKZpT6loKLvV8Wy2PEmV0QGPk61w+dp99J2s9aUftYNf5fl5oQl0U5X3xzT
         KPPU5IaDiskl6O2kNvFpUg0K0VzFqvoNI/b66FFu7dK1xDxgO8LIGp+tnxdBt8vI8V8b
         I4AJha7PanDsOHXL8uxhUwLv5PgCGQcdg7UbE3FwEKIuP6hR45myeOAkxz46+9cIknO0
         rk+Uuj9qa/yzxL0AGpub+MpfVHX7m1aK/WG9LkKREiO8kCFgza7U2+2W9t03Rwsf3hRm
         m5IyFeqAt3juGWHrQQP3oYjYXJz2gMS9HBGuNMwv7EWNmg2LEsvh5Kl5FoSRVGEDyu/N
         /FUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+rRzusuz8i9IUPX3pEa3bFrtG7rV99bhs90LU1JUeZLkob9An8s7MqgdswCblEPL65rLjbyt7AsxeB2WfvzI07pFWQcRcLzkOwEqAHXGQ4xGLu7E3ngs+0xacBxrABYEOrgJLaqvZ
X-Gm-Message-State: AOJu0YwBaRzxoOGxIvkjGvfLU8vPdoThs3DSozs4QeQe4MlHVqTMHfpt
	ImU+3YcJeX9RBCiLfRFWil//AVZoj9LPwpkrCYBMx/4Hx4p47nC3
X-Google-Smtp-Source: AGHT+IHusKB3Srxa2EGXXNaRfreBuDEfdr19Zu6kJTM8Yc9DGkhA7W1QlWhMkc6GoqN/2nRYnis7Hw==
X-Received: by 2002:adf:f34c:0:b0:351:dea5:f808 with SMTP id ffacd0b85a97d-35e84060bd1mr2434738f8f.26.1717614758996;
        Wed, 05 Jun 2024 12:12:38 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eab85ecbsm823834166b.173.2024.06.05.12.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:12:38 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: humidity: hdc3020: fix hysteresis representation
Date: Wed,  5 Jun 2024 21:12:18 +0200
Message-Id: <20240605191219.37978-1-dima.fedrau@gmail.com>
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


