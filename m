Return-Path: <linux-iio+bounces-15694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32CA38648
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BBC3BB079
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3246F22371E;
	Mon, 17 Feb 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0YpIQLn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBCF21D5BF
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801927; cv=none; b=J24LJ/nyNvt4FGhHyu8zFfWyf+EVQZzyZhyCL9wmS9vlwqDZFK5cqbrf50BaXRR+DQmbfvGj+HswaMRm5FKQBt0zvoNFo6xGrmvnd/ZwXBCi+wZu85BOCDiZpxOzfd9WjwEO5dwzaC+6xmkytNriEfLbZkGxISaXRrm60MG9Dys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801927; c=relaxed/simple;
	bh=BRqVFy02hcCLoHII0OjVK/AIjoqIVapILIqhErLJdXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzyVBnEuDS1VyjQnx6zOpM1JgbeAPeCDDrTMVXwWrkR5YCUkT2cMzebtOwOgZ6tIQ1RUJqFiIiesfHolXzEw3NnmCDAtgg/pyd0pALa/z2MSEc87C7S+VxypeatlurcZ6Cz3p0bYJ843MQzx1iXRYcR22xmNU7DPRUysqh6I6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0YpIQLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78300C4CED1;
	Mon, 17 Feb 2025 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801927;
	bh=BRqVFy02hcCLoHII0OjVK/AIjoqIVapILIqhErLJdXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0YpIQLnFXTw1BdLLxhxz/xJneg9/CPoppeW/ukv/CmWDCTUz3c9ZQtG5C4jUd6VG
	 mvL71qZbOBy8GvQl22+nz5n1c09PSwBIZ1bRQF4Uchr2kReJa+KEDIPNIF+vamYfeM
	 lwUfyGXAGcfovOLJfO8cAu2UsZUUXKgwcPlS39LvsvUcDUgBKmqDs+e3WU5YB/1lLa
	 D/LNduUDKvgMslLJUs7nc2d4Zuc3mNzNeGMID4aTVP9ZF4zk/fhYC5OPEhpCAlwa5k
	 y+ujT9mEMnh1XeP72O+n9d6sVCKHRAxDa0Y5Go7Eg7Bc0ThEbqGMOAz9f4OLPq5mYc
	 BWjTbskhGNXuw==
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
Subject: [PATCH 21/29] iio: adc: at91-sama5d2: Move claim of direct mode up a level and use guard()
Date: Mon, 17 Feb 2025 14:16:21 +0000
Message-ID: <20250217141630.897334-22-jic23@kernel.org>
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

Move iio_device_claim_direct_mode() up one layer in the call stack,
and use guard() for scope based unlocking to simplify error handling
by allowing direct returns.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 42 +++++++++++++++---------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 8e5aaf15a921..70d3dbb39b25 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -1814,19 +1815,10 @@ static int at91_adc_read_info_locked(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan, int *val)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
-	ret = at91_adc_read_info_raw(indio_dev, chan, val);
-	mutex_unlock(&st->lock);
 
-	iio_device_release_direct_mode(indio_dev);
+	guard(mutex)(&st->lock);
 
-	return ret;
+	return at91_adc_read_info_raw(indio_dev, chan, val);
 }
 
 static void at91_adc_temp_sensor_configure(struct at91_adc_state *st,
@@ -1871,14 +1863,11 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
 	u32 tmp;
 	int ret, vbg, vtemp;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = pm_runtime_resume_and_get(st->dev);
 	if (ret < 0)
-		goto unlock;
+		return ret;
 
 	at91_adc_temp_sensor_configure(st, true);
 
@@ -1900,9 +1889,6 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
 	at91_adc_temp_sensor_configure(st, false);
 	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
-unlock:
-	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -1924,10 +1910,17 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return at91_adc_read_info_locked(indio_dev, chan, val);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = at91_adc_read_info_locked(indio_dev, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uv / 1000;
@@ -1939,7 +1932,14 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->type != IIO_TEMP)
 			return -EINVAL;
-		return at91_adc_read_temp(indio_dev, chan, val);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = at91_adc_read_temp(indio_dev, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = at91_adc_get_sample_freq(st);
-- 
2.48.1


