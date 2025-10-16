Return-Path: <linux-iio+bounces-25122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E00BE1805
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 07:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DABB4EDBAE
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790B22A1E1;
	Thu, 16 Oct 2025 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxDbqb5i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45722689C;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592045; cv=none; b=EJXkJLmwux22w6tv0Nd8mbk5HC5YcRKut1RKOaO8q338HItfipxESjZQjf4PP3Zrlmnl7yzsxMyEMXOYA41klc5OabZItn8bJYl80QfwgqF+FqCUuBEGkygWCwfKiza+PFMkE2OzTSPhL7AjwQ3LEvj3ncVZqlfsuXELufjEbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592045; c=relaxed/simple;
	bh=DHIfsIjS+xPBrZNlEi8FYuB/6cwqVGM6XBhPoR8Wgz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3AFRzm0iZhU9ViQb910KBkLmhtJJ8vU4IDBszaT/vyhxvGqgM1EJjz1APjd0jMdeszqwpmFDn8Z7U8gLYGzY8v3POnhOt83OY8RxKMfjaBBiOKfoK3hih+FY08BUHTxI5ijFkOJ3l6XYoXD2LzfJLh2vm/NcZiESM7f8PWf22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxDbqb5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDDE9C116B1;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760592044;
	bh=DHIfsIjS+xPBrZNlEi8FYuB/6cwqVGM6XBhPoR8Wgz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FxDbqb5iLHIVwH/LKGLLjmNQDDSDtu2870XN4V6J59IP2XvmuI1FVLCXZoWyEvUF8
	 bzs7sYX/z58q4ige06sq7XMu611JuOLxYl6XRU1NqGxRmma+0ZHQkeS2SMjkRy+Hqf
	 MM4flXGivtmy8/13RffztpX4o4T5C6dKdBNJuNWosfOg51W0MbnR2QLx1PG8V9ZOm6
	 fBo0Fy/UzgudAmW8cBbfWQLJVW+EGUnJFrfDmib1o/fWevyINFEUzwJf85nzc8KETY
	 avQyDHPw5NcfueXvVKTMJPepexzAX/W4YactADh8Zr8o4OwjoC2pQCRIioWlEgEjEZ
	 uT1mmzaGPcXIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1BBCCD199;
	Thu, 16 Oct 2025 05:20:44 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 16 Oct 2025 07:20:39 +0200
Subject: [PATCH v4 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-hdc3020-units-fix-v4-2-2d9e9f33c7b1@liebherr.com>
References: <20251016-hdc3020-units-fix-v4-0-2d9e9f33c7b1@liebherr.com>
In-Reply-To: <20251016-hdc3020-units-fix-v4-0-2d9e9f33c7b1@liebherr.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Chris Lesiak <chris.lesiak@licorbio.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760592043; l=8181;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Pt1owPyqLdIRddee1tPxLJWpsWGI1P4HraZXhUC0xE0=;
 b=ZzDCBgNtci+xbUKg9SnQ8tgJomzqWfj1vF8GFn587n4EfP5A94hP/VViOqZE3x8Mm3nrrJgJm
 ooVdcnk9QAFDRcYdUVT6sPHW+t7gF8QBWQMwzARXN1jY4dVrkXhPY5m
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

According to the ABI the units after application of scale and offset are
milli degree celsius for temperature thresholds and milli percent for
relative humidity thresholds. Currently the resulting units are degree
celsius for temperature thresholds and hysteresis and percent for relative
humidity thresholds and hysteresis. Change scale factor to fix this issue.

Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/iio/humidity/hdc3020.c | 69 +++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 8aa567d9aded9cab461f1f905b6b5ada721ba2f0..78b2c171c8dac2f11fcd5404497ffeba76e837f6 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -72,6 +72,9 @@
 #define HDC3020_MAX_TEMP_HYST_MICRO	164748607
 #define HDC3020_MAX_HUM_MICRO		99220264
 
+/* Divide 65535 from the datasheet by 5 to avoid overflows */
+#define HDC3020_THRESH_FRACTION		(65535 / 5)
+
 struct hdc3020_data {
 	struct i2c_client *client;
 	struct gpio_desc *reset_gpio;
@@ -376,15 +379,18 @@ static int hdc3020_thresh_get_temp(u16 thresh)
 	int temp;
 
 	/*
-	 * Get the temperature threshold from 9 LSBs, shift them to get
-	 * the truncated temperature threshold representation and
-	 * calculate the threshold according to the formula in the
-	 * datasheet. Result is degree celsius scaled by 65535.
+	 * Get the temperature threshold from 9 LSBs, shift them to get the
+	 * truncated temperature threshold representation and calculate the
+	 * threshold according to the explicit formula in the datasheet:
+	 * T(C) = -45 + (175 * temp) / 65535.
+	 * Additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is degree
+	 * celsius scaled by HDC3020_THRESH_FRACTION.
 	 */
 	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
 	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
 
-	return -2949075 + (175 * temp);
+	return -2949075 / 5 + (175 / 5 * temp);
 }
 
 static int hdc3020_thresh_get_hum(u16 thresh)
@@ -394,13 +400,16 @@ static int hdc3020_thresh_get_hum(u16 thresh)
 	/*
 	 * Get the humidity threshold from 7 MSBs, shift them to get the
 	 * truncated humidity threshold representation and calculate the
-	 * threshold according to the formula in the datasheet. Result is
-	 * percent scaled by 65535.
+	 * threshold according to the explicit formula in the datasheet:
+	 * RH(%) = 100 * hum / 65535.
+	 * Additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is percent
+	 * scaled by HDC3020_THRESH_FRACTION.
 	 */
 	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
 	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
 
-	return hum * 100;
+	return hum * 100 / 5;
 }
 
 static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
@@ -455,8 +464,8 @@ int hdc3020_thresh_clr(s64 s_thresh, s64 s_hyst, enum iio_event_direction dir)
 	else
 		s_clr = s_thresh + s_hyst;
 
-	/* Divide by 65535 to get units of micro */
-	return div_s64(s_clr, 65535);
+	/* Divide by HDC3020_THRESH_FRACTION to get units of micro */
+	return div_s64(s_clr, HDC3020_THRESH_FRACTION);
 }
 
 static int _hdc3020_write_thresh(struct hdc3020_data *data, u16 reg, u16 val)
@@ -507,7 +516,7 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 
 	clr = ret;
 	/* Scale value to include decimal part into calculations */
-	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
+	s_val = (val < 0) ? (val * 1000 - val2) : (val * 1000 + val2);
 	switch (chan->type) {
 	case IIO_TEMP:
 		switch (info) {
@@ -523,7 +532,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_temp(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Set old hysteresis */
@@ -532,16 +542,17 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_temp returns temperature
-			 * in degree celsius scaled by 65535. Scale by 1000000
-			 * to be able to subtract scaled hysteresis value.
+			 * in degree celsius scaled by HDC3020_THRESH_FRACTION.
+			 * Scale by 1000000 to be able to subtract scaled
+			 * hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			/*
 			 * Units of s_val are in micro degree celsius, scale by
-			 * 65535 to get same units as s_thresh.
+			 * HDC3020_THRESH_FRACTION to get same units as s_thresh.
 			 */
 			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * HDC3020_THRESH_FRACTION;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, HDC3020_MIN_TEMP_MICRO);
 			s_clr = min(s_clr, HDC3020_MAX_TEMP_MICRO);
@@ -565,7 +576,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_hum(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Try to set old hysteresis */
@@ -574,15 +586,16 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_hum returns relative
-			 * humidity in percent scaled by 65535. Scale by 1000000
-			 * to be able to subtract scaled hysteresis value.
+			 * humidity in percent scaled by HDC3020_THRESH_FRACTION.
+			 * Scale by 1000000 to be able to subtract scaled
+			 * hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			/*
-			 * Units of s_val are in micro percent, scale by 65535
-			 * to get same units as s_thresh.
+			 * Units of s_val are in micro percent, scale by
+			 * HDC3020_THRESH_FRACTION to get same units as s_thresh.
 			 */
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * HDC3020_THRESH_FRACTION;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, 0);
 			s_clr = min(s_clr, HDC3020_MAX_HUM_MICRO);
@@ -630,7 +643,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 		thresh = hdc3020_thresh_get_temp(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * MILLI;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -638,18 +651,18 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_temp(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * MILLI;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = HDC3020_THRESH_FRACTION;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_HUMIDITYRELATIVE:
 		thresh = hdc3020_thresh_get_hum(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * MILLI;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -657,12 +670,12 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_hum(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * MILLI;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = HDC3020_THRESH_FRACTION;
 		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EOPNOTSUPP;

-- 
2.39.5



