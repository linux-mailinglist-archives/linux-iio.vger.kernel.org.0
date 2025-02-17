Return-Path: <linux-iio+bounces-15682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02171A38633
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082683B6768
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A7224B0D;
	Mon, 17 Feb 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC7S8lJ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3609F224B08
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801864; cv=none; b=MEqx1eq3THM8cJHULoJGtg5QhJojqgVWxGS23BgHIig+OF/U+00gM0qo7KNHrM2hUMoESPEfvtZxJ81Us/mhvRJpViscKJqnWl5h8vQUm/QcKFMO0TkvcZ0bUaUj1BF4Af5oSUUfxCD3WB+Ed2uX3UQCJiDaQ5e/vKAzqBlJWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801864; c=relaxed/simple;
	bh=xKNHcZuBJ1ZmkupmaDblXHFlvC1oQtH9NRZ8n7AsC6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm/se+ktQjSx1BJdtG0kz2sMcNTuP4o6AhKfVRJHWfrCehByxXJWgH4eyk9LWp9ba9MyifvOO3eSC/EveWfeTcOs9DugbUZji4YJ1Kn/AJQSUzK0DunQt4xjZix3rC6tJwhA6zHIHcCHNTuQ/OqCK+4p5iLWRkD1Hj/UN3pKrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC7S8lJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3C1C4CED1;
	Mon, 17 Feb 2025 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801864;
	bh=xKNHcZuBJ1ZmkupmaDblXHFlvC1oQtH9NRZ8n7AsC6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IC7S8lJ/lTHLgppe0QZ3MDn4xvWu7mm+5gRABQhnfFcFZo0hNVJPYnqkAU3f+j24W
	 5/27p5jmnV28YORjTFB93b5ShI4P2WAB+NZMCKJcSHbwOQMfo0GFz7fvHofrhvDCiN
	 kcLsMnmk5tubKH5OCv2DkM0QIBiKnytMKAFbgZ+gNq0c9ywdnfSya1pQqJK3Y8Gsa/
	 QCGXpLQUQ5+yHDtBFzBaJ5YHIlPJ2h4pKaGF0q1S63LaNqCMuIMSyre+LqK4zwkso7
	 x67jQmZlnJK+nmtBoLgIWMzOI789I0ri+tnES95HYqjauzPthDFN2zDdyl0JEYEAFj
	 5Kk8xNxrCsE1Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/29] iio: adc: ad7192: Factor out core of ad7192_write_raw() to simplify error handling.
Date: Mon, 17 Feb 2025 14:16:10 +0000
Message-ID: <20250217141630.897334-11-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Factor out everything under the lock, use guard() for the mutex to
avoid need to manually unlock, and switch sense of matching checks
in loops to reduce indent.

There are some functional changes in here as well as the code
no longer updates the filter_freq_available if no change has
been made to the oversampling ratio.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 111 ++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index e96a5ae92375..785429900da8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -7,6 +7,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
@@ -945,80 +946,82 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int ad7192_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long mask)
+static int __ad7192_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val,
+			      int val2,
+			      long mask)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	int ret, i, div;
+	int i, div;
 	unsigned int tmp;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-			if (val2 == st->scale_avail[i][1]) {
-				ret = 0;
-				tmp = st->conf;
-				st->conf &= ~AD7192_CONF_GAIN_MASK;
-				st->conf |= FIELD_PREP(AD7192_CONF_GAIN_MASK, i);
-				if (tmp == st->conf)
-					break;
-				ad_sd_write_reg(&st->sd, AD7192_REG_CONF,
-						3, st->conf);
-				ad7192_calibrate_all(st);
-				break;
-			}
-		break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (!val) {
-			ret = -EINVAL;
-			break;
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+			if (val2 != st->scale_avail[i][1])
+				continue;
+
+			tmp = st->conf;
+			st->conf &= ~AD7192_CONF_GAIN_MASK;
+			st->conf |= FIELD_PREP(AD7192_CONF_GAIN_MASK, i);
+			if (tmp == st->conf)
+				return 0;
+			ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
+			ad7192_calibrate_all(st);
+			return 0;
 		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!val)
+			return -EINVAL;
 
 		div = st->fclk / (val * ad7192_get_f_order(st) * 1024);
-		if (div < 1 || div > 1023) {
-			ret = -EINVAL;
-			break;
-		}
+		if (div < 1 || div > 1023)
+			return -EINVAL;
 
 		st->mode &= ~AD7192_MODE_RATE_MASK;
 		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
 		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 		ad7192_update_filter_freq_avail(st);
-		break;
+		return 0;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
-		break;
+		return ad7192_set_3db_filter_freq(st, val, val2 / 1000);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++)
-			if (val == st->oversampling_ratio_avail[i]) {
-				ret = 0;
-				tmp = st->mode;
-				st->mode &= ~AD7192_MODE_AVG_MASK;
-				st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
-				if (tmp == st->mode)
-					break;
-				ad_sd_write_reg(&st->sd, AD7192_REG_MODE,
-						3, st->mode);
-				break;
-			}
-		ad7192_update_filter_freq_avail(st);
-		break;
+		for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++) {
+			if (val != st->oversampling_ratio_avail[i])
+				continue;
+
+			tmp = st->mode;
+			st->mode &= ~AD7192_MODE_AVG_MASK;
+			st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
+			if (tmp == st->mode)
+				return 0;
+			ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+			ad7192_update_filter_freq_avail(st);
+			return 0;
+		}
+		return -EINVAL;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
+}
+
+static int ad7192_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
-	mutex_unlock(&st->lock);
+	ret = __ad7192_write_raw(indio_dev, chan, val, val2, mask);
 
 	iio_device_release_direct_mode(indio_dev);
 
-- 
2.48.1


