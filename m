Return-Path: <linux-iio+bounces-15747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996BA3A5AB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FD816879F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDF1EB5CB;
	Tue, 18 Feb 2025 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tC73i3ph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27516A956
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903503; cv=none; b=d5q3dTpAFwKWhfJLO3HftY9fhc9YK11DJpQ4C5HPu8VCdEQYeICntEv+a8hz46m3Py/HHsezcMKZOCZvf2vuhYsGZJ19BMOQH/loo+TsQ6vAtep0aQIbfqFql/lGE9s06Uh8e+vUsfqfoe2mF9XlFBDwskasw/4MgsvLbeFy1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903503; c=relaxed/simple;
	bh=bh9Ae+Puh++8+ZziqOs2YTU4CdRWpVST7UY4xjlMsaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2aDfkpZT3VwTsRX2nsGizNj2V1ZiZMOA55VT1m09ssEcUFSYVihHGgPST0cVZ7kNVa86QMV2AxROVEmy0J0wuhHIlFCmHWFOHpZJf7Cc9eP0Qwo56Rkgm/UrvakKkZwX35X926IGY4dupAH2kcb9H2rEecPGM3GqBEArJC7f8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tC73i3ph; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4398738217aso21948545e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739903498; x=1740508298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q6rA4PW4xhQvgSK7RXfXFXZ77NM6TpWaF1FcRaZNSs=;
        b=tC73i3ph6mNg7l0tQmESwV8BSuQK2KlGGqCvdg927glNXFkVrdWaYj+rWJ4Rhd/GyF
         yKGSlhdyeDxUOcihFvjX/0ayztMmMb0TwQ3P/nhS0xq1I5D4cqJLOBBK/g+eja4+19gI
         Nd3etN5f24zx6KlK/0FaxW2Xf1y0PSsytkPn22BM4h+Dcnj5jjBH/lEjr8XgHg4MQYzV
         DkVNxoxIHCwSkevOLmr5gUckZgNYrwOdxjcgdb+Ec02gU8NnKs6aqmkr56gm6el296Zw
         oK7XF0O0O55HyQTUi/9gQlY75XDAO0rmq3ANLh6th5AA8CxjvQV4aX+RMK5ahUV9Ftlb
         KbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903498; x=1740508298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q6rA4PW4xhQvgSK7RXfXFXZ77NM6TpWaF1FcRaZNSs=;
        b=GYsFH5O2HsqtYD+5UmEaBAH6iOTqt1x9JxkAZGsb5dlqvhY8+st6wVo/Imv2XFSCn1
         o5oeHEQXcHYikMrvyQ6V4PNIRl5dHwsxW5cu3orgcomTSgAXEH7zmMGURuGVCGiatQWa
         +g2Vsy1q65uVmMmZbW4ttAu9o+Bpo+kKSUqmqk7TtTUpnUKuti8N+RyJELarHg/L9YRR
         d458PU0nHdM2v1pqaJ7ND3Z5FqwkPiYMpyQnjVfFFZ1eddvIGbUv7JdDcU/laVu0/qhl
         j12uSHU+WCRBKWdGVDQU2Y6PH5W0wdet/8PknllJ335AyqNhMYCmS+mEkIB73IEpVZ5G
         450g==
X-Gm-Message-State: AOJu0Yzy/fdrFP0kdz/xopegQphuf08lorjcJNYV1xfHKcdvk05XPDJZ
	2pJ/D3ppsEjYq41n+S4YtkM+Mfrslf87n2e/a7MESpAF7hHythFtaNH97Y7Sdbs=
X-Gm-Gg: ASbGncvOKDg2yz+eOpf77L79UmVU+AyJPEO7sG48jInkguYPMsOdWrihC8r2zkykZEw
	Viyr7DS46LZ1oU8qNvNl9zwozcb1BZJxwKzntCUFeX4klAYNjPQn9n81dzAGScUCGZ+jCHRMzT2
	P5c1HGZXq5u37+hoN0lDrw8E4HZCjN0KzQsMNd4PB4CkDWwMk1jaAgeLumRYClxc2GxWW+JCK6x
	biPALsxfN1sTbmO7swT5R/oOhrhHZjbazu7FNXLTha6wIAYG81vhgvS+KZVhlnaqTSpSLIFQQEy
	6qmd/WuRbaAl+fQoJBzv6Tk0N3nA11X1KjySxe9bYU6vaDdvhVl6wGBZVA==
X-Google-Smtp-Source: AGHT+IEl0/mGENo946sOLsFHkDGUDqwR8RlISS873tQzXmjU++7COqGIM4FUctpeCq+bPbKFJaFOhw==
X-Received: by 2002:a05:600c:46cf:b0:439:88bb:d002 with SMTP id 5b1f17b1804b1-43999dd1e04mr7217895e9.23.1739903497596;
        Tue, 18 Feb 2025 10:31:37 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8443sm190406875e9.35.2025.02.18.10.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:31:37 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 5/6] iio: adc: ad7124: Implement internal calibration at probe time
Date: Tue, 18 Feb 2025 19:31:12 +0100
Message-ID:  <deef14543f8f5ff34076e69d90711bbe719c4d12.1739902968.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
References: <cover.1739902968.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7389; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=bh9Ae+Puh++8+ZziqOs2YTU4CdRWpVST7UY4xjlMsaI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBntNH4Mwn3Xkmgry2fxDG/At/PW21qKqMLob/km +wiZPEj4PWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7TR+AAKCRCPgPtYfRL+ TuBXB/4xQUwTA5hHdbYFXcNzV3KgqisE6dPkZZnOK35UlgnjwsfXQlPzH+d/7Wx5aNJNgPZlc3a iQDddVcqczjibCmSPCvQz7AJqZTX6V8MuToUp/JgSkjDQwvZwP3+TTx+XTzbk+ox6usIRw3/igl aWK72PELtM17JAixd951O+Z9GCcpTiTTxwoBpsSC4p/T2PGGanIcQuLk3+MD6Pgp9VDUAtVTfPm b9ltKwMjHqXmQlTl6F0SkjAMp6tx78lIlp0EDDYXVGC2jI9Kti+JmAaodSWUfP//kZ1pFWrKQWU nxqeXlD20iJPgdhOgb9kjFxYb/m87VTCO8uGv61Oofp17Q8g
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Use the calibration function provided by the ad_sigma_delta shim to
calibrate all channels at probe time.

For measurements with gain 1 (i.e. if CONFIG_x.PGA = 0) full-scale
calibrations are not supported and the reset default value of the GAIN
register is supposed to be used then.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 119 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 4f253c4831fa..5c2e5a518af3 100644
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
@@ -1054,6 +1088,81 @@ static int ad7124_setup(struct ad7124_state *st)
 	return ret;
 }
 
+static int ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->sd.spi->dev;
+	int ret, i;
+	unsigned int adc_control = st->adc_control;
+
+	/*
+	 * Calibration isn't supported at full power, so speed down a bit.
+	 * Setting .adc_control is enough here because the control register is
+	 * written as part of ad_sd_calibrate() -> ad_sigma_delta_set_mode().
+	 */
+	if (FIELD_GET(AD7124_ADC_CTRL_PWR_MSK, adc_control) >= AD7124_FULL_POWER) {
+		st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
+		st->adc_control |= AD7124_ADC_CTRL_PWR(AD7124_MID_POWER);
+	}
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
+				goto out;
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
+				goto out;
+		}
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_ZERO, i);
+		if (ret < 0)
+			goto out;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(st->channels[i].cfg.cfg_slot), 3,
+				     &st->channels[i].cfg.calibration_offset);
+		if (ret < 0)
+			goto out;
+
+		dev_dbg(dev, "offset and gain for channel %d = 0x%x + 0x%x\n", i,
+			st->channels[i].cfg.calibration_offset,
+			st->channels[i].cfg.calibration_gain);
+	}
+
+out:
+	st->adc_control = adc_control;
+
+	return ret;
+}
+
 static void ad7124_reg_disable(void *r)
 {
 	regulator_disable(r);
@@ -1132,6 +1241,10 @@ static int ad7124_probe(struct spi_device *spi)
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


