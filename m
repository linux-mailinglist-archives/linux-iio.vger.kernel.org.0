Return-Path: <linux-iio+bounces-15698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A30DA3864A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884643BB2B3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CC52222B1;
	Mon, 17 Feb 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp9j3Y8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122C21D001
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801951; cv=none; b=S1vg35sdl/x1l7/M1bpf9aZuhvmc4gCJUDX/c+aK/YRw+tKf31z0dymJAsw8z/u01VN3Y6AlfPL/NUWPc7zXktdz/idEz0tEnGD1BJzYStv2dC0egY69ujRgpGQdPSaGVquVYoojz0r3E+d+kqSgmpo0Sz0c14jmlqMFyw0b9KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801951; c=relaxed/simple;
	bh=B5CyDv9Die3ccM0hli99tLCFwMBPQhGyVceeS7eF6Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NI5vCrxMWqVI/zKwy13BJjW/eK/Z/VJMLR6ABbAq/vpZxPy/lLqHMFbv+ypCeH6zWl9bjtsrvd9XazJ3cntEY55Lbpel2qaYSNZGu6LNruf3Srt1R/ghffBuLZzuweuZM5Fbfebx1NiPw5pq+EDDXUBNlmD7xVEMIQSOLfOpyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp9j3Y8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245FDC4CED1;
	Mon, 17 Feb 2025 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801950;
	bh=B5CyDv9Die3ccM0hli99tLCFwMBPQhGyVceeS7eF6Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qp9j3Y8cZG3P08pxvKvMo0msnD3ZaWbNSHuu/UMs6Pg4BWBBEF890ru5jsLZXhZwW
	 65lHuel5ZGwFh7yAh2dSAjV1oV8XgWgN/nWFc4Ov7zRCOFBsDWV7alEgQQb3TvSN86
	 Y1Gb2XD6jvIKHPg3ql3CHOIEOIWxwmwgTnKMtjOpd4FUS9VuRnQ6V7a87bg5fAGDed
	 TtdCaZI5psKO1YbMqOXUMeAuOPYIYcalnxGq+CDuLxfWjD4SxVsVFmq8AQy1W9w0N+
	 d78P2RFctsOE8nBulaVzOKKjW+PhKYWCAu+6FcCVyUQJbgVTEZpRc6sxOCjpjBTh0E
	 rKd1OAYQBVm8g==
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
Subject: [PATCH 25/29] iio: adc: max11410: Factor out writing of sampling frequency to simplify errro paths.
Date: Mon, 17 Feb 2025 14:16:25 +0000
Message-ID: <20250217141630.897334-26-jic23@kernel.org>
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

Introduce __max11410_write_samp_freq() helper and use guard() to avoid
need for manual unlock of the mutex. This allows direct returns and
simplifies the resulting error handling.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max11410.c | 51 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 76abafd47404..6e06c62715a8 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -507,12 +507,37 @@ static int max11410_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int __max11410_write_samp_freq(struct max11410_state *st,
+				      int val, int val2)
+{
+	int ret, i, reg_val, filter;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, MAX11410_REG_FILTER, &reg_val);
+	if (ret)
+		return ret;
+
+	filter = FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
+
+	for (i = 0; i < max11410_sampling_len[filter]; ++i) {
+		if (val == max11410_sampling_rates[filter][i][0] &&
+		    val2 == max11410_sampling_rates[filter][i][1])
+			break;
+	}
+	if (i == max11410_sampling_len[filter])
+		return -EINVAL;
+
+	return regmap_write_bits(st->regmap, MAX11410_REG_FILTER,
+				 MAX11410_FILTER_RATE_MASK, i);
+}
+
 static int max11410_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
 {
 	struct max11410_state *st = iio_priv(indio_dev);
-	int i, ret, reg_val, filter, gain;
+	int ret, gain;
 	u32 *scale_avail;
 
 	switch (mask) {
@@ -544,29 +569,7 @@ static int max11410_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		mutex_lock(&st->lock);
-
-		ret = regmap_read(st->regmap, MAX11410_REG_FILTER, &reg_val);
-		if (ret)
-			goto out;
-
-		filter = FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
-
-		for (i = 0; i < max11410_sampling_len[filter]; ++i) {
-			if (val == max11410_sampling_rates[filter][i][0] &&
-			    val2 == max11410_sampling_rates[filter][i][1])
-				break;
-		}
-		if (i == max11410_sampling_len[filter]) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ret = regmap_write_bits(st->regmap, MAX11410_REG_FILTER,
-					MAX11410_FILTER_RATE_MASK, i);
-
-out:
-		mutex_unlock(&st->lock);
+		ret = __max11410_write_samp_freq(st, val, val2);
 		iio_device_release_direct_mode(indio_dev);
 
 		return ret;
-- 
2.48.1


