Return-Path: <linux-iio+bounces-25029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1402BD1F58
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 10:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EA53C2204
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6E2ED871;
	Mon, 13 Oct 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8ub3ayt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841F2EB5C9;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343148; cv=none; b=kEisKigGGJffWhhU0v3jVUMCls9CxfhSivqulNo7l69iecuPF1RHNBK6hxGtlH999ipOn1UYfaLKGdH3FRpcSxPIkINJK/u7JGNIbAIGVapaIOBcNb6zf5xzUqVI4N5BFdPi0crL9CivVka1xk9pM0hhrnK1C5Fk3KfY03k/5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343148; c=relaxed/simple;
	bh=uc9TbbBoYFBT0JNtecrIOTnaYA/QJOvOdqjJYktmKUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a0ZHp3dkN8cVmJ3Gb9+pEXVFimaaOCQlwJa/SpwyJ9556CLNcNL4dyWKDwNkuWv9Axs728DtuUOZ2X4Q+Qv8puH2HEOcuw+JrN7+mpidHeFWtufNlu1vLHIbLz1NYAYkch90x+gHCic7oEt3Ti2c5yM6bWGVzbOr2xi7ZPs/tzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8ub3ayt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B756EC4CEFE;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760343147;
	bh=uc9TbbBoYFBT0JNtecrIOTnaYA/QJOvOdqjJYktmKUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j8ub3aytHKs27i107Y9J7l7S42qH8yrPF11b7UxxZRR+N6zysi5m0LOtCVE1MVuGB
	 so+TXMM9dHDC/0Sr526mAkeZVoKb5F59fAkyPQa7y/5oZfBybbO8G+730Jn/ryxB5D
	 FgjvHwRUiUlJuWJT11YYbh2RUdcBpJIiLX0keBsP4kRTPXXLN43umkfsZKVQER5MEi
	 9sRSD3QKjEWgTPXtGomlkpkVaaMdQYr/OcAPfRCaIWMXLADy7eiMlkZKCZVUxQc9lO
	 8tQKvW0IgdjjE+qk4U34yusVtbB3tz+78CDjD9MJfSgI78hIHdTnuqtiKmxXGJo5Xe
	 5D+LX5tluZVfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4864CCD18E;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 13 Oct 2025 10:12:26 +0200
Subject: [PATCH v3 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-hdc3020-units-fix-v3-2-b21fab32b882@liebherr.com>
References: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com>
In-Reply-To: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760343146; l=8035;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=09Znw7HXYrZNRuB0Uvu8tcuxWjL78Ijc1bgS5VcnBgQ=;
 b=huSKfbHhoOmIDf/vOkSUHYSaVPAHoL9yQyXjH9W0Dm1/HRjRxvlazCmO1nGaQZv4vOYBqioAB
 +NIYXo8d4DsA899hMXAgzMObIUpIGBlT8PJnnt+6+jkNCP+tvvNCon2
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
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/iio/humidity/hdc3020.c | 67 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 8aa567d9aded9cab461f1f905b6b5ada721ba2f0..5a978801fb09ca49c449028d046a91e0e67c38ea 100644
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
@@ -376,15 +379,17 @@ static int hdc3020_thresh_get_temp(u16 thresh)
 	int temp;
 
 	/*
-	 * Get the temperature threshold from 9 LSBs, shift them to get
-	 * the truncated temperature threshold representation and
-	 * calculate the threshold according to the formula in the
-	 * datasheet. Result is degree celsius scaled by 65535.
+	 * Get the temperature threshold from 9 LSBs, shift them to get the
+	 * truncated temperature threshold representation and calculate the
+	 * threshold according to the explicit formula in the datasheet and
+	 * additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is degree
+	 * celsius scaled by HDC3020_THRESH_FRACTION.
 	 */
 	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
 	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
 
-	return -2949075 + (175 * temp);
+	return -589815 + (35 * temp);
 }
 
 static int hdc3020_thresh_get_hum(u16 thresh)
@@ -394,13 +399,15 @@ static int hdc3020_thresh_get_hum(u16 thresh)
 	/*
 	 * Get the humidity threshold from 7 MSBs, shift them to get the
 	 * truncated humidity threshold representation and calculate the
-	 * threshold according to the formula in the datasheet. Result is
-	 * percent scaled by 65535.
+	 * threshold according to the explicit formula in the datasheet and
+	 * additionally scale by HDC3020_THRESH_FRACTION to avoid precision loss
+	 * when calculating threshold and hysteresis values. Result is percent
+	 * scaled by HDC3020_THRESH_FRACTION.
 	 */
 	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
 	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
 
-	return hum * 100;
+	return hum * 20;
 }
 
 static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
@@ -455,8 +462,8 @@ int hdc3020_thresh_clr(s64 s_thresh, s64 s_hyst, enum iio_event_direction dir)
 	else
 		s_clr = s_thresh + s_hyst;
 
-	/* Divide by 65535 to get units of micro */
-	return div_s64(s_clr, 65535);
+	/* Divide by HDC3020_THRESH_FRACTION to get units of micro */
+	return div_s64(s_clr, HDC3020_THRESH_FRACTION);
 }
 
 static int _hdc3020_write_thresh(struct hdc3020_data *data, u16 reg, u16 val)
@@ -507,7 +514,7 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 
 	clr = ret;
 	/* Scale value to include decimal part into calculations */
-	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
+	s_val = (val < 0) ? (val * 1000 - val2) : (val * 1000 + val2);
 	switch (chan->type) {
 	case IIO_TEMP:
 		switch (info) {
@@ -523,7 +530,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_temp(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Set old hysteresis */
@@ -532,16 +540,17 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
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
@@ -565,7 +574,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_hum(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr),
+					 HDC3020_THRESH_FRACTION);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Try to set old hysteresis */
@@ -574,15 +584,16 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
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
@@ -630,7 +641,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 		thresh = hdc3020_thresh_get_temp(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * MILLI;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -638,18 +649,18 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
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
@@ -657,12 +668,12 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
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



