Return-Path: <linux-iio+bounces-16009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE0BA422EB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7D33B9EA4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA91547E9;
	Mon, 24 Feb 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rCYcd7Ig"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1BF1519A5
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406259; cv=none; b=cskwFmMLaAESfgDLAtPJVYS8esqqX5Ssdw6HN/9mGfPFqDqZhJyF+JtV1w73vvxpZN2JTKi2dPDDTZBlOu2pOazVPkn48SFjrfP4XD3JkAcwHVShetguCRccrnWZD+FC/G82nlhRiTR7osqTZ46T8LegYoztUPvCdK9WSC75wUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406259; c=relaxed/simple;
	bh=jqr9EwXfZY3b+14dJHqEdl3sytYGW0GVhd2OmY7oUBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXFKXwMcdq6d2fJtNNjfDg688lvK6cGGtKj1Zxxe/uqL2vJCsJDNrqx4NBiosPlfb9bpeLG1iQYI6A5fU78xMtLakdO9+mHLvkt8xs1o0z5cSHTonP9IBL6cCEW4v7GvYtnKT9UgGYwmH1Q3Ol9/o3Dn4yhBmHSnUOzBy+c6C+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rCYcd7Ig; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso686183766b.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406255; x=1741011055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQozffwnOCsYFoqS8k7yOzUIgAbpTEtaLUGEzpJWOM8=;
        b=rCYcd7Ig/MivcN9fa7nUW33Tr2VY2J1YaALZ4L+JqMjxND7gDcJRIwC6eCMKM8FTgl
         UhKa/xW5lKrmKNpebuqOUhNIRmJKCsEP4hGmq28qVu60270l1P1viz/rZZCsVRyEvajT
         d98SuIfz+kgRs1OTtP/KCOZVm6n0BJwmdEC3+Iic8qHxLfbHywBTeenUe7OumLjw9iO3
         JSzziENreL6wX7mo+XTwsKrHUIE8VpPenLlDmvGmwUkS7dU0ltg/qEyxl5613VQqddsP
         3cPzcIzZ5YGXrf0Pq2SarSNvzPQC7crQfAYPZLQdNNWA4kI2o2ireuw1WyW66VC8N+xJ
         kV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406255; x=1741011055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQozffwnOCsYFoqS8k7yOzUIgAbpTEtaLUGEzpJWOM8=;
        b=k/e05FkDQ4U7i/c8X60m3VAj2CyvhoNzoJwhHTQBYTT6OGCxdGXBiQVD5PP1VkZKx1
         UeghXWS02wEzKHZ0cx2CYaglqFtf74YZaSlmHWnHGyEvBneuh7BWZIBwyJHhYfg53BIC
         SLuhmfsjcRnpR35Ok2p425wx2BLX6nIdTj3XXu6VQypktsT01S8N7UAx2WltA+o2Ibm5
         bgG9K5fL+oyBeM1YsM5ymH3QkP+2u6mkQmt9FByURay7gmpRKXkjyTY9uhNWo6+KZyXE
         98gqADhF0UBB1Nv8i1xMPbMNLULssDqRLN7NWgIquNmreAlZzFsUMDpki6M66YwUu49s
         UkMQ==
X-Gm-Message-State: AOJu0Yz38fyzWuXF27GIwScHHRQaF9URNgblGP8NGtn7diy/RcUqkK10
	VFggjPtCNOlVTbGkGEZGP3HtJvgyx/LQXoV0LGpEMJd4lTWXjDf8T7b+PJeeix4=
X-Gm-Gg: ASbGncsfyFY9X2WjH5DwAHde5z1ZKQrupg5Pa/SLo7aJ0RG8jNjO//QfaLS9Vwgdv8l
	J62myNskF5ZIaTQr5+zYtsctktrObGPaqTBGcTcvPwEgjhDMGh+hornLYudPgkaFWu08vDBQ5vL
	i2FzNsGPV4ZH8U/qJInDbUeuhsKpguIRgs2OoiIBRVk6je2FmQIiWHkAZIh8pD2InER0qw+BYEx
	iDWOONC92pUQWDEoqytW3fVK3/VF0/jgIIX5BHeKKC+pw7MqZFfAa2RUgDx7DJC8n0EN2pdb1nF
	A8LhgCFv4BVNKnzudHI+1CW46cw6VBI=
X-Google-Smtp-Source: AGHT+IFi1NtP0KfFAdRz9V0mOEspeZlLIrmEHghRdbLA8GrZXPM3Ny2IwN7IRxxODoh1hmS1tsdAqQ==
X-Received: by 2002:a17:906:310b:b0:ab7:da56:af95 with SMTP id a640c23a62f3a-abc0d97c68cmr1175026866b.2.1740406255327;
        Mon, 24 Feb 2025 06:10:55 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbeb38e05dsm964484866b.90.2025.02.24.06.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:55 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 6/7] iio: adc: ad7124: Implement internal calibration at probe time
Date: Mon, 24 Feb 2025 15:10:17 +0100
Message-ID:  <46c4a445363fa41458d60faf961f860ab8032027.1740405546.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
References: <cover.1740405546.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7681; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=jqr9EwXfZY3b+14dJHqEdl3sytYGW0GVhd2OmY7oUBw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnvH3UjHQsB3G4k4lCa0JignuAcXrIby2nGIvoM nDSMbRjes+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7x91AAKCRCPgPtYfRL+ TvhbB/9UDBKBsf/WxuZo8aV3H3Rivy7BfEA3rO7Mv0MZ/5UA0LoTuTZwq14ZLYbbM5HrNWL8Shg vyJmLWbIIhm4faScWxfigwQk8fjWIBtz1PR/ADi3D2UrFC96nPaEiOir5XqdK9ku0MUDLNfIkzh R+iE3hmYV0Wb3iEkfTwUK7VVyG2QL8kDa9txSB8GigQiZ8K0x7STBBkAGG7hbnimI/hEOUUCVJd G+20U5kGW9y0OiwUQxV42S8/pzv3yGsEyvkr5alitfecGKyddD7N2jUc6OH6w2HxQEdFXyDSR7f 258+DqHcvoQ7pdOuLntilT+msTPxt8HZaqOQr8fdmtplYVV+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Use the calibration function provided by the ad_sigma_delta shim to
calibrate all channels at probe time.

For measurements with gain 1 (i.e. if CONFIG_x.PGA = 0) full-scale
calibrations are not supported and the reset default value of the GAIN
register is supposed to be used then.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 129 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index de90ecb5f630..382f46ff2b51 100644
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
@@ -166,6 +171,8 @@ struct ad7124_channel_config {
 		unsigned int odr;
 		unsigned int odr_sel_bits;
 		unsigned int filter_type;
+		unsigned int calibration_offset;
+		unsigned int calibration_gain;
 	);
 };
 
@@ -186,6 +193,12 @@ struct ad7124_state {
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
 
@@ -359,6 +372,8 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 				     unsigned int odr;
 				     unsigned int odr_sel_bits;
 				     unsigned int filter_type;
+				     unsigned int calibration_offset;
+				     unsigned int calibration_gain;
 			     }));
 
 	for (i = 0; i < st->num_channels; i++) {
@@ -373,7 +388,9 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 		    cfg->pga_bits == cfg_aux->pga_bits &&
 		    cfg->odr == cfg_aux->odr &&
 		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
-		    cfg->filter_type == cfg_aux->filter_type)
+		    cfg->filter_type == cfg_aux->filter_type &&
+		    cfg->calibration_offset == cfg_aux->calibration_offset &&
+		    cfg->calibration_gain == cfg_aux->calibration_gain)
 			return cfg_aux;
 	}
 
@@ -429,6 +446,14 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 
 	cfg->cfg_slot = cfg_slot;
 
+	ret = ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg->cfg_slot), 3, cfg->calibration_offset);
+	if (ret)
+		return ret;
+
+	ret = ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg->cfg_slot), 3, cfg->calibration_gain);
+	if (ret)
+		return ret;
+
 	tmp = (cfg->buf_positive << 1) + cfg->buf_negative;
 	val = AD7124_CONFIG_BIPOLAR(cfg->bipolar) | AD7124_CONFIG_REF_SEL(cfg->refsel) |
 	      AD7124_CONFIG_IN_BUFF(tmp) | AD7124_CONFIG_PGA(cfg->pga_bits);
@@ -835,13 +860,22 @@ static int ad7124_soft_reset(struct ad7124_state *st)
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
@@ -1054,6 +1088,91 @@ static int ad7124_setup(struct ad7124_state *st)
 	return ret;
 }
 
+static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->sd.spi->dev;
+	int ret, i;
+
+	for (i = 0; i < st->num_channels; i++) {
+
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
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
+		 * Full-scale calibration isn't supported at gain 1, so skip in
+		 * that case. Note that untypically full-scale calibration has
+		 * to happen before zero-scale calibration. This only applies to
+		 * the internal calibration. For system calibration it's as
+		 * usual: first zero-scale then full-scale calibration.
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
+			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(st->channels[i].cfg.cfg_slot), 3,
+					     &st->channels[i].cfg.calibration_gain);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_ZERO, i);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(st->channels[i].cfg.cfg_slot), 3,
+				     &st->channels[i].cfg.calibration_offset);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "offset and gain for channel %d = 0x%x + 0x%x\n", i,
+			st->channels[i].cfg.calibration_offset,
+			st->channels[i].cfg.calibration_gain);
+	}
+
+	return 0;
+}
+
+static int ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	unsigned int adc_control = st->adc_control;
+
+	/*
+	 * Calibration isn't supported at full power, so speed down a bit.
+	 * Setting .adc_control is enough here because the control register is
+	 * written as part of ad_sd_calibrate() -> ad_sigma_delta_set_mode().
+	 * The resulting calibration is then also valid for high-speed, so just
+	 * restore adc_control afterwards.
+	 */
+	if (FIELD_GET(AD7124_ADC_CTRL_PWR_MSK, adc_control) >= AD7124_FULL_POWER) {
+		st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
+		st->adc_control |= AD7124_ADC_CTRL_PWR(AD7124_MID_POWER);
+	}
+
+	ret = __ad7124_calibrate_all(st, indio_dev);
+
+	st->adc_control = adc_control;
+
+	return ret;
+}
+
 static void ad7124_reg_disable(void *r)
 {
 	regulator_disable(r);
@@ -1132,6 +1251,10 @@ static int ad7124_probe(struct spi_device *spi)
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


