Return-Path: <linux-iio+bounces-23110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC7B2FE96
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0839F642EDA
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5F82D0C99;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usDwJetT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7881292910;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789853; cv=none; b=T7rsITekQQgM6HG0gn29Gc0y6W28RrUY5sJZD7iMKSBUn7KDiI7STnJahmqlMID15CjhzhHTiiKUVw8tk/ncjmtBDjmVGMM3HXhLgQM1+wLG+inmziHUmAHxjxE3aperdXlRiRKTxRNFArEw49zgjn/ritwXwJaiAK4A1/PmGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789853; c=relaxed/simple;
	bh=aEuSbKZ9Jx9rWVOikmYG8c1FFsi5NlzmC2HbXNc/aVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUItcOmYn3zScjp+tDEIG4VAVszs30nVK9rkvWe4fboW8elUU2wjb6y2u1MKUQJ+ibBoalM9wVJEPFsa38IdHNQ5B/JQMIVJ+TvD+kI3WZfFJSQyfJdnNe7rO6tShg2gPXepTTLc3BEZcFYmC4xrSmkolvAx+//7tggRvCN6Gp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usDwJetT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DC08C4CEED;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789853;
	bh=aEuSbKZ9Jx9rWVOikmYG8c1FFsi5NlzmC2HbXNc/aVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=usDwJetTlD5r05+BPKqXf59neyWJZEHvCFD1PZlaf3STV1DA3OOCKt01Y043bY0oc
	 xNP4Uox1peG7+sqqy8gmcILcj5PSwzQKsb1fctheGdwOLmavVi0DfbdJrAveU3MXOI
	 HBLYK/Ln6UsYh1IgibdqbKLcMQj2ldkT5pUvqmMsp0cwSOtzMp7kpkTwHmH4hy+4Tu
	 4z8wEMtOHsmyx6Ccwgb2mNh6GneJvT12tz983sCp/yR4txEpnb7zShjK5uZE0iKoYA
	 w9e2l7LVcI0ZpWzj1v+9mEPz5lx5v4uIzL6kB7sGElYPMizuuhUl432Lc979Pi1tFJ
	 2B16lxnX2viuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D30CCA0EF8;
	Thu, 21 Aug 2025 15:24:13 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Thu, 21 Aug 2025 17:23:55 +0200
Subject: [PATCH 2/2] iio: humditiy: hdc3020: fix units for thresholds and
 hysteresis
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-hdc3020-units-fix-v1-2-6ab0bc353c5e@liebherr.com>
References: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
In-Reply-To: <20250821-hdc3020-units-fix-v1-0-6ab0bc353c5e@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755789852; l=6554;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=s5RRuhM1n7kH5vaW9+kM6WoOD1OME6OW4rVjujM7FfY=;
 b=g31B7wJbKaVODCRVuwOaprig/4+jyJrLO+uj6n6eZdqUuf/ZGR/0FbHJ8BdtXyy0vir5Pw0Z/
 He5Lm2oKmlwDjVC1XTIbOp7PyusPjMy+flipaZo2sGZq8EB0pLk1RTM
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

According to the ABI the units after application of scale and offset are
milli degree celsius for temperature thresholds and milli percent for
relative humidity thresholds. Change scale factor to fix this issue.

Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/iio/humidity/hdc3020.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index 9de52de628e04263a2b62a512a36203d6c02c5e0..8134d32fceedd2b88d9d4ed7bc9062759045aafe 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -379,12 +379,12 @@ static int hdc3020_thresh_get_temp(u16 thresh)
 	 * Get the temperature threshold from 9 LSBs, shift them to get
 	 * the truncated temperature threshold representation and
 	 * calculate the threshold according to the formula in the
-	 * datasheet. Result is degree celsius scaled by 65535.
+	 * datasheet. Result is degree celsius scaled by 13107.
 	 */
 	temp = FIELD_GET(HDC3020_THRESH_TEMP_MASK, thresh) <<
 	       HDC3020_THRESH_TEMP_TRUNC_SHIFT;
 
-	return -2949075 + (175 * temp);
+	return -589815 + (35 * temp);
 }
 
 static int hdc3020_thresh_get_hum(u16 thresh)
@@ -395,12 +395,12 @@ static int hdc3020_thresh_get_hum(u16 thresh)
 	 * Get the humidity threshold from 7 MSBs, shift them to get the
 	 * truncated humidity threshold representation and calculate the
 	 * threshold according to the formula in the datasheet. Result is
-	 * percent scaled by 65535.
+	 * percent scaled by 13107.
 	 */
 	hum = FIELD_GET(HDC3020_THRESH_HUM_MASK, thresh) <<
 	      HDC3020_THRESH_HUM_TRUNC_SHIFT;
 
-	return hum * 100;
+	return hum * 20;
 }
 
 static u16 hdc3020_thresh_set_temp(int s_temp, u16 curr_thresh)
@@ -455,8 +455,8 @@ int hdc3020_thresh_clr(s64 s_thresh, s64 s_hyst, enum iio_event_direction dir)
 	else
 		s_clr = s_thresh + s_hyst;
 
-	/* Divide by 65535 to get units of micro */
-	return div_s64(s_clr, 65535);
+	/* Divide by 13107 to get units of micro */
+	return div_s64(s_clr, 13107);
 }
 
 static int _hdc3020_write_thresh(struct hdc3020_data *data, u16 reg, u16 val)
@@ -507,7 +507,7 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 
 	clr = ret;
 	/* Scale value to include decimal part into calculations */
-	s_val = (val < 0) ? (val * 1000000 - val2) : (val * 1000000 + val2);
+	s_val = (val < 0) ? (val * 1000 - val2) : (val * 1000 + val2);
 	switch (chan->type) {
 	case IIO_TEMP:
 		switch (info) {
@@ -523,7 +523,7 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_temp(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr), 13107);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Set old hysteresis */
@@ -532,16 +532,16 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_temp returns temperature
-			 * in degree celsius scaled by 65535. Scale by 1000000
+			 * in degree celsius scaled by 13107. Scale by 1000000
 			 * to be able to subtract scaled hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_temp(thresh) * 1000000;
 			/*
 			 * Units of s_val are in micro degree celsius, scale by
-			 * 65535 to get same units as s_thresh.
+			 * 13107 to get same units as s_thresh.
 			 */
 			s_val = min(abs(s_val), HDC3020_MAX_TEMP_HYST_MICRO);
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * 13107;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, HDC3020_MIN_TEMP_MICRO);
 			s_clr = min(s_clr, HDC3020_MAX_TEMP_MICRO);
@@ -565,7 +565,7 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 			/* Calculate old hysteresis */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			s_clr = (s64)hdc3020_thresh_get_hum(clr) * 1000000;
-			s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
+			s_hyst = div_s64(abs(s_thresh - s_clr), 13107);
 			/* Set new threshold */
 			thresh = reg_val;
 			/* Try to set old hysteresis */
@@ -574,15 +574,15 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_HYSTERESIS:
 			/*
 			 * Function hdc3020_thresh_get_hum returns relative
-			 * humidity in percent scaled by 65535. Scale by 1000000
+			 * humidity in percent scaled by 13107. Scale by 1000000
 			 * to be able to subtract scaled hysteresis value.
 			 */
 			s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
 			/*
-			 * Units of s_val are in micro percent, scale by 65535
+			 * Units of s_val are in micro percent, scale by 13107
 			 * to get same units as s_thresh.
 			 */
-			s_hyst = (s64)s_val * 65535;
+			s_hyst = (s64)s_val * 13107;
 			s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
 			s_clr = max(s_clr, 0);
 			s_clr = min(s_clr, HDC3020_MAX_HUM_MICRO);
@@ -630,7 +630,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 		thresh = hdc3020_thresh_get_temp(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * 1000;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -638,18 +638,18 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_temp(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * 1000;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = 13107;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_HUMIDITYRELATIVE:
 		thresh = hdc3020_thresh_get_hum(ret);
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			*val = thresh;
+			*val = thresh * 1000;
 			break;
 		case IIO_EV_INFO_HYSTERESIS:
 			ret = hdc3020_read_be16(data, reg_clr);
@@ -657,12 +657,12 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
 				return ret;
 
 			clr = hdc3020_thresh_get_hum(ret);
-			*val = abs(thresh - clr);
+			*val = abs(thresh - clr) * 1000;
 			break;
 		default:
 			return -EOPNOTSUPP;
 		}
-		*val2 = 65535;
+		*val2 = 13107;
 		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EOPNOTSUPP;

-- 
2.39.5



