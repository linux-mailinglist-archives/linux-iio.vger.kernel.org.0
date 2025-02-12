Return-Path: <linux-iio+bounces-15437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4675A323FC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8DD16281F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B72209696;
	Wed, 12 Feb 2025 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ais2qnQg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB8209F2A
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 10:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357630; cv=none; b=s6gP11ZV4hcyavZn2aq97kKQZJ8ORYxJOlxskCJudvA77xx4osFlSLfAu0rqaxZJAgpHBzchueDsL5IUuddOb4NzbZMCpN+EYdLlAO+DQWdcRkGeACZ1fHLERQrLxzTPvTz7e6mbDDkAQHde6H0ZadH4F1uTWK9b3zH3toqUlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357630; c=relaxed/simple;
	bh=VdjIqxgwm2NnVzZkk+QuTGP3mNdn3OgigNCGuWhN5JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0NfVDRfGZZUYzYdOcwK75KTIJIna8duE0xvrNSxgbm149VuU3svx2RsDcOVQw2tDH2f0YKDxWAEqSnOqsbLXp/BxqXvHgmtgJNtJUTg0HSOSpiJzPrHy/DAq998nF11x1J84E0dSJy++JenhdUs7J0y3FwEQbCSOJFch+2XMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ais2qnQg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394a823036so25347655e9.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 02:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739357627; x=1739962427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5db5caX2vtPe/GnhY7FuqwYgcu6w/biIkrUinpv0GKg=;
        b=Ais2qnQgcufZZYvjUMMD+3SwMH7JMc23MQGVQVexjr+pLgxYuIPkfCh+ovkMePZiuR
         B93iabblbW2Ra+//mWs3w1BhH4q/PgxY7Ci4AoQBjV2UqcyEkZyc/dadPgFSw4vChfpF
         ASUdzSwoUl8HdyuicKhEx1OwzC36weem00FeZuwzKqsg3uDg4I2uhuBD2WyqXVdBMZeD
         V7EixLKetA/I/cSFYQI0Sp+7UYGYGLJM+7HjB/+auygGl6bcYlQcN2hkBAkGI+cepJgN
         hJt7qEZpQtFZmSJeA/Wqt3ys+6MWHwEwnGcC5gBy5LYYVKu1kIKiz34VxturZ2xqq9pN
         f9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357627; x=1739962427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5db5caX2vtPe/GnhY7FuqwYgcu6w/biIkrUinpv0GKg=;
        b=GCJcPn1zBJdMqczqUx+YujDL7E1BJO+tgK+gceFwQsDS9pMX+La8tgQWoQ3umggZse
         3Sv9JaZSKtrQhbPK01O2bUUmKUBB9tpY7HiDA+jZFJ8WGeL0ls7cA2wEw4QaBb2wsVxx
         pBNIqNkRVnZ8ED2650QIlyOtXM3r30WfaVfa18usGRt/p6b2lA60om2NWP57fM+rX11G
         y+Xc7H1e33R5t+9nh7dqi4sr2cul4/LXif/kxQhDJY+u1RU/HkfdXYRNC2lJSHsnOc4x
         xBVH+izan5qD/uAtyEDLVhIN28SD0FR4vMaiGGd6IGPGbQPrAaye+Q1XaqKItcZuqViS
         s7Cw==
X-Gm-Message-State: AOJu0YxqSP1/etaS6bBy/MV0h3jy99p/1cWKtAX+4vDpipgg+oavcXn6
	kGSt3UdASdAvxbKcl72N0HSC9DiGLOAdZ0sPWrGCXc+ZrCVMgHbQUJtm9ehr9hY=
X-Gm-Gg: ASbGncslyAE0wJnIyPUiGY0NW4fzAp59n7+yQ8f45U2w1FQHhTYdqwWqgrfc8Y+UgNj
	IhWp/X3sU4Oxkg66YZZfnUJSTyoS6VWHtpPFpEk/gO/xU4Gg1bXgZDcRV7F6cFPsf3UdqNd4Z+R
	c6sV5LYmA7kSoeT+Ex9KtV6b7gtaWYLhuqPfFbke8b7T4Mk0P1bv/4mM8yGTtw6qncI/7RKpWXI
	TwuI53uwKLL4s8EvmT6dKbKfFmI3k5RSa0JYgrJvF3TnMsVuclrzjDZZYIrcqQOc9XOGbPQhX2h
	GsnY6/xV4JDN4AdauRGTG5tGR4fRGoS21L444LMXomSXkEq7cBoqtCUko9K+ChCpNcZjIbNNSe1
	sqw==
X-Google-Smtp-Source: AGHT+IGpZK3qoR1JVQfpnMXX8Uy4rlbwm4nyScv8FnSa/xdr5cVycdWv/RHCH6CsvlHCa8tGg8vPFA==
X-Received: by 2002:a05:600c:5487:b0:439:38a1:e49 with SMTP id 5b1f17b1804b1-439581605dbmr27605365e9.6.1739357626630;
        Wed, 12 Feb 2025 02:53:46 -0800 (PST)
Received: from localhost (p200300f65f083b04d1ced5eed56c82e8.dip0.t-ipconnect.de. [2003:f6:5f08:3b04:d1ce:d5ee:d56c:82e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8443sm16006395e9.35.2025.02.12.02.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:53:46 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v1 3/3] iio: adc: ad7124: Implement calibration at probe time
Date: Wed, 12 Feb 2025 11:53:24 +0100
Message-ID: <20250212105322.10243-8-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
References: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6632; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=VdjIqxgwm2NnVzZkk+QuTGP3mNdn3OgigNCGuWhN5JQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnrH2qecNJ6C87PmjnIwhCGH3rZoWsbtpY2qb3d sboYVsU2J6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6x9qgAKCRCPgPtYfRL+ TiTaB/0c5rM1wv93b68uvHHrH32hrED8hiBb9fSMzkUtzDqt7pKJbpDs2TlRil0JJlb8fU8lt2s iafgcEEFt8tGiAj51QZB8bzGE/tjWo5x8LTTh2sKKPWLHB/MQNLnKScr/GnwM4sz111jmGqHy9n HqJ+7d/sL80J3/bdF7mScPoSttF/xRXECBOC4PpNzMaRWDXvdKcECX6JcXENp7fBrhdWql/AfMD 3k91KJQnKESNRBoxc/TAo9YLrjopC2DWuZAPv+OO8YWOz4JVUyG5BqzYIsRTHT3sImVuVldy9im znIuiwkZt9ePft5KsU3jNy7JhbNrt3iWY4in8Us0/jVtKkg1
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Use the calibration function provided by the ad_sigma_delta shim to
calibrate all channels at probe time.

For measurements with gain 1 (i.e. if CONFIG_x.PGA = 0) full-scale
calibrations are not supported and the reset default value of the GAIN
register is supposed to be used then.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 99 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index a664179918fc..6b460407d2d2 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -53,6 +53,11 @@
 #define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
 #define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
 
+#define AD7124_MODE_CAL_INT_ZERO	0x5 /* Internal Zero-Scale Calibration */
+#define AD7124_MODE_CAL_INT_FULL	0x6 /* Internal Full-Scale Calibration */
+#define AD7124_MODE_CAL_SYS_ZERO	0x7 /* System Zero-Scale Calibration */
+#define AD7124_MODE_CAL_SYS_FULL	0x8 /* System Full-Scale Calibration */
+
 /* AD7124 ID */
 #define AD7124_DEVICE_ID_MSK		GENMASK(7, 4)
 #define AD7124_DEVICE_ID_GET(x)		FIELD_GET(AD7124_DEVICE_ID_MSK, x)
@@ -162,6 +167,8 @@ struct ad7124_channel_config {
 		unsigned int odr;
 		unsigned int odr_sel_bits;
 		unsigned int filter_type;
+		unsigned int calibration_offset;
+		unsigned int calibration_gain;
 	);
 };
 
@@ -182,6 +189,12 @@ struct ad7124_state {
 	unsigned int num_channels;
 	struct mutex cfgs_lock; /* lock for configs access */
 	unsigned long cfg_slots_status; /* bitmap with slot status (1 means it is used) */
+
+	/*
+	 * Stores the power-on reset value for the GAIN(x) registers which are
+	 * needed for measurements at gain 1 (i.e. CONFIG(x).PGA == 0)
+	 */
+	unsigned int gain_default;
 	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
 };
 
@@ -355,6 +368,8 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 			    unsigned int odr;
 			    unsigned int odr_sel_bits;
 			    unsigned int filter_type;
+			    unsigned int calibration_offset;
+			    unsigned int calibration_gain;
 		     }));
 
 	for (i = 0; i < st->num_channels; i++) {
@@ -369,7 +384,9 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 		    cfg->pga_bits == cfg_aux->pga_bits &&
 		    cfg->odr == cfg_aux->odr &&
 		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
-		    cfg->filter_type == cfg_aux->filter_type)
+		    cfg->filter_type == cfg_aux->filter_type &&
+		    cfg->calibration_offset == cfg_aux->calibration_offset &&
+		    cfg->calibration_gain == cfg_aux->calibration_gain)
 			return cfg_aux;
 	}
 
@@ -425,6 +442,14 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 
 	cfg->cfg_slot = cfg_slot;
 
+	ret = ad_sd_write_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3, ch->cfg.calibration_offset);
+	if (ret)
+		return ret;
+
+	ret = ad_sd_write_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3, ch->cfg.calibration_gain);
+	if (ret)
+		return ret;
+
 	tmp = (cfg->buf_positive << 1) + cfg->buf_negative;
 	val = AD7124_CONFIG_BIPOLAR(cfg->bipolar) | AD7124_CONFIG_REF_SEL(cfg->refsel) |
 	      AD7124_CONFIG_IN_BUFF(tmp) | AD7124_CONFIG_PGA(cfg->pga_bits);
@@ -831,13 +856,22 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 			return dev_err_probe(dev, ret, "Error reading status register\n");
 
 		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
-			return 0;
+			break;
 
 		/* The AD7124 requires typically 2ms to power up and settle */
 		usleep_range(100, 2000);
 	} while (--timeout);
 
-	return dev_err_probe(dev, -EIO, "Soft reset failed\n");
+	if (readval & AD7124_STATUS_POR_FLAG_MSK)
+		return dev_err_probe(dev, -EIO, "Soft reset failed\n");
+
+	ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3, &st->gain_default);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error reading gain register\n");
+
+	dev_dbg(dev, "Reset value of GAIN register is 0x%x\n", st->gain_default);
+
+	return 0;
 }
 
 static int ad7124_check_chip_id(struct ad7124_state *st)
@@ -1050,6 +1084,61 @@ static int ad7124_setup(struct ad7124_state *st)
 	return ret;
 }
 
+static int ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->sd.spi->dev;
+	int ret, i;
+
+	for (i = 0; i < st->num_channels; i++) {
+
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+                        continue;
+
+		/*
+		 * For calibration the OFFSET register should hold its reset default
+		 * value. For the GAIN register there is no such requirement but
+		 * for gain 1 it should hold the reset default value, too. So to
+		 * simplify matters use the reset default value for both.
+		 */
+		st->channels[i].cfg.calibration_offset = 0x800000;
+		st->channels[i].cfg.calibration_gain = st->gain_default;
+
+		/*
+		 * Full scale calibration isn't supported at gain 1, so skip in
+		 * that case.
+		 */
+		if (st->channels[i].cfg.pga_bits > 0) {
+			ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_FULL, i);
+			if (ret < 0)
+				return ret;
+
+			/*
+			 * read out the resulting value of GAIN
+			 * after full-scale calibration because the next
+			 * ad_sd_calibrate() call overwrites this via
+			 * ad_sigma_delta_set_channel() -> ad7124_set_channel()
+			 * ... -> ad7124_enable_channel().
+			 */
+			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(st->channels[i].cfg.cfg_slot), 3, &st->channels[i].cfg.calibration_gain);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_ZERO, i);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(st->channels[i].cfg.cfg_slot), 3, &st->channels[i].cfg.calibration_offset);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "offset and gain for channel %d = 0x%x + 0x%x\n",
+			     i, st->channels[i].cfg.calibration_offset, st->channels[i].cfg.calibration_gain);
+	}
+
+	return 0;
+}
+
 static void ad7124_reg_disable(void *r)
 {
 	regulator_disable(r);
@@ -1128,6 +1217,10 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to setup triggers\n");
 
+	ret = ad7124_calibrate_all(st, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to register iio device\n");
-- 
2.47.1


