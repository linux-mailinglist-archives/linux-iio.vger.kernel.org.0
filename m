Return-Path: <linux-iio+bounces-15690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAC3A38623
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C91175B4F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EC1225780;
	Mon, 17 Feb 2025 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaS5ivl7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817E22577B
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801905; cv=none; b=ddpsB5V17Ap84NdcYxxexlSNVRyGiKuSngrv3gWNxYL0+qJBxpPBEpNiKryinoI2zXTSYwlDRV1hwaUMUbSW1tse4vf628F9yR9XhyBH+lxCp5Y+qU5fjs6ScMk42s0tYTWKyx19L9tXnNJArB8nvJ0xYoKngADFr2lE36Ycz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801905; c=relaxed/simple;
	bh=WWNb3nfsft5MkZwLVad99p7ezmIpcWmZxijMoIaWjIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrEE4M5YSCzd6pINyFToeVr41tPDCKdqUIcuoR7FMLCdu+KpV35xNaFKYJ6J+II+QNclCIRM7+vIgni0OPewB79vOVWjfSATYWuUgJZImpaERGm01ZgFIDhZzw8NX7Oh4g2C0Hzeuv0pqK7B4Gdgm/ATeGnzT/wgQISNQaZF0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaS5ivl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C50C4CED1;
	Mon, 17 Feb 2025 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801904;
	bh=WWNb3nfsft5MkZwLVad99p7ezmIpcWmZxijMoIaWjIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaS5ivl7iuOxTDyFy5V1xfn+WRrws8xNyhvWBYcqTkj+RWRkMIQIcYjoOHooHW+4k
	 Fb0m7t89Q+CAE5O5O8JikIi9h3zmwiSDxYEp+JmrFj/roQoJK1HBWX0UGjywCrIc/i
	 f9TKp9U29AGURuaLmS92fAJ1ORCUCVJ83u91YxyfZtR2ilQr9u1VD10OHmnDxnEtqM
	 SBKRhoo9q27bY7FLi3xiMjwBxmc5FlxrZffblIS/Nex0JBAmr9tiWdLPPfu+o3xq3k
	 gDgn9fp0KCKHTG657CV7/e+i2wAgcuphwh2Xf1D/xIq4DGbiWYYTIQpft0uMpvHZ3E
	 EHstgMvI0wGGg==
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
Subject: [PATCH 17/29] iio: adc: ad7793: Factor out core of ad7793_write_raw() to simplify error handling
Date: Mon, 17 Feb 2025 14:16:17 +0000
Message-ID: <20250217141630.897334-18-jic23@kernel.org>
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

Factor out everything under the direct mode claim allowing direct returns
in error paths.  Switch sense of matching in the loop and use a continue
to reduce code indent and improve readability.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7793.c | 79 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 1b50d9643a63..861a3e44e5ad 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -462,64 +462,69 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int ad7793_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+static int __ad7793_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
-	int ret, i;
+	int i;
 	unsigned int tmp;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-			if (val2 == st->scale_avail[i][1]) {
-				ret = 0;
-				tmp = st->conf;
-				st->conf &= ~AD7793_CONF_GAIN(-1);
-				st->conf |= AD7793_CONF_GAIN(i);
-
-				if (tmp == st->conf)
-					break;
-
-				ad_sd_write_reg(&st->sd, AD7793_REG_CONF,
-						sizeof(st->conf), st->conf);
-				ad7793_calibrate_all(st);
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
+			st->conf &= ~AD7793_CONF_GAIN(-1);
+			st->conf |= AD7793_CONF_GAIN(i);
+
+			if (tmp == st->conf)
+				return 0;
+
+			ad_sd_write_reg(&st->sd, AD7793_REG_CONF,
+					sizeof(st->conf), st->conf);
+			ad7793_calibrate_all(st);
+
+			return 0;
 		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!val)
+			return -EINVAL;
 
 		for (i = 0; i < 16; i++)
 			if (val == st->chip_info->sample_freq_avail[i])
 				break;
 
-		if (i == 16) {
-			ret = -EINVAL;
-			break;
-		}
+		if (i == 16)
+			return -EINVAL;
 
 		st->mode &= ~AD7793_MODE_RATE(-1);
 		st->mode |= AD7793_MODE_RATE(i);
 		ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode),
 				st->mode);
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
+}
+
+static int ad7793_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = __ad7793_write_raw(indio_dev, chan, val, val2, mask);
 
 	iio_device_release_direct_mode(indio_dev);
+
 	return ret;
 }
 
-- 
2.48.1


