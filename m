Return-Path: <linux-iio+bounces-21651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BDDB04D53
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 03:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664094A5896
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393A1E1DEC;
	Tue, 15 Jul 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="llDcbHTG"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274F1DE2A5
	for <linux-iio@vger.kernel.org>; Tue, 15 Jul 2025 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542442; cv=none; b=tc06kWnxlrlik1dB920PjSFWkJ7XrnKbMP+oJsQ0Gi0UznzFknJ7jR9YeHO/VypNnaMORoh9QL9oDprP90RXk4EDVF5YS/VwurRhCvDIAqbGH6lZ5TDJILbpO/f6lNaeHkPveS9C3UAqiZN3BJWfCWVbZFS0AqPRspgi6678liA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542442; c=relaxed/simple;
	bh=zxAZttHG0QzJMVGOZzzjcVjrFxXQX8clSrfk6A+vAFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QIsajybubLN96l65azPexTLLThlatwVVhzCiDeB9/AlE4JhfPKoq59bl6pOwenkcgcBNAtxp+tAgKC9anHjsHLPvYruFMqXMQHVoqKcRdSZYR8exeXQoGIYxvWsynVsAkY5nJg5UmmT1qQFfen/RY9vnlCDbxwF5TDl0CCv1ZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=llDcbHTG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752542439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VS38gXY125VgWZkbqT/5MOqt89JO36iRPEiIvNaRM0g=;
	b=llDcbHTGljqytCUrdfVtc37JD1mVxeDvOKIATE87BQiq4mOURFbxwqoTH3njU1rbMhhh3w
	WYFeQdtUYuQ6/9iUGA7UgyizDdSgpI01wgc+rlv8/ykNaQRuwUw3vQqLUIKGGlmPiNarh9
	gG5kYxp/zquFVmGBXGp/Sk702LEZLog=
From: Sean Anderson <sean.anderson@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 4/7] hwmon: iio: Refactor scale calculation into helper
Date: Mon, 14 Jul 2025 21:20:20 -0400
Message-Id: <20250715012023.2050178-5-sean.anderson@linux.dev>
In-Reply-To: <20250715012023.2050178-1-sean.anderson@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a function to determine the scale parameter, since it will soon be
used in several places.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/hwmon/iio_hwmon.c | 40 ++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index e376d4cde5ad..bba8919377eb 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -44,6 +44,30 @@ static ssize_t iio_hwmon_read_label(struct device *dev,
 	return iio_read_channel_label(chan, buf);
 }
 
+/**
+ * iio_hwmon_scale() - Look up the scaling factor for a channel
+ * @chan: Channel to get the scale of
+ *
+ * Determine the scale to use with @chan in the case where IIO and HWMON use
+ * different units.
+ *
+ * Return: scale of @chan
+ */
+static int iio_hwmon_scale(struct iio_channel *chan)
+{
+	enum iio_chan_type type;
+	int ret;
+
+	ret = iio_get_channel_type(chan, &type);
+	if (ret < 0)
+		return ret;
+
+	/* mili-Watts to micro-Watts conversion */
+	if (type == IIO_POWER)
+		return 1000;
+	return 1;
+}
+
 /*
  * Assumes that IIO and hwmon operate in the same base units.
  * This is supposed to be true, but needs verification for
@@ -53,22 +77,16 @@ static ssize_t iio_hwmon_read_val(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	int result;
-	int ret;
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	struct iio_hwmon_state *state = dev_get_drvdata(dev);
 	struct iio_channel *chan = &state->channels[sattr->index];
-	enum iio_chan_type type;
+	int ret, result, scale;
 
-	ret = iio_get_channel_type(chan, &type);
-	if (ret < 0)
-		return ret;
+	scale = iio_hwmon_scale(chan);
+	if (scale < 0)
+		return scale;
 
-	if (type == IIO_POWER)
-		/* mili-Watts to micro-Watts conversion */
-		ret = iio_read_channel_processed_scale(chan, &result, 1000);
-	else
-		ret = iio_read_channel_processed(chan, &result);
+	ret = iio_read_channel_processed_scale(chan, &result, scale);
 	if (ret < 0)
 		return ret;
 
-- 
2.35.1.1320.gc452695387.dirty


