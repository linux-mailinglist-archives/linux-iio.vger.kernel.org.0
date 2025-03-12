Return-Path: <linux-iio+bounces-16747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F279A5E3C2
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 19:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9887AD1C1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A72571A7;
	Wed, 12 Mar 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VLbzl9Lr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC3226861
	for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804740; cv=none; b=glARKdbyi2Q0xPiEdWDsn6qWygjiCnYBip7eVi7tNLVRlh66zVyGwj+xiFDG7ya8tCw/DPe5D87OvSvlOFaKTeTV7gPaZOJ5pmoVGoshu/5hydTWhM/+AKByVoa6Ettiaj/GceYjAf4EVRKa5yrSoaWJgl6LwzOYJ+YPTZnfRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804740; c=relaxed/simple;
	bh=zWLWMNZKgUe9uj6V+/Q3yc9l5G30ZbTu3z3Gd3iqmsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGecqEc59bK8O9oYJps8qChq1arxdxorCyctQSnBQnvzK/wvs7aSgJk2gLC1hXa0xhLodo6llHMRzmAtjgfQrTD9d7abclu7aFXwbbZwFdpHIfWQqjxQWFH0iInN/k3wiSEzXg+7NtG4wKmgwJVRuXLBglJWXiMd6rc9BfqAywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VLbzl9Lr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso728835e9.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741804736; x=1742409536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rVMS1LO247bu3rF3RmSY8S7l1S/YDPSaye4wAOg0wU=;
        b=VLbzl9LrpfXSHTv+x4DBv3S0jnAffyHI2I0PRbkHC7tpVKl483SkavR+dFDkOqg2AH
         2m97jJm4cf1UQ4oy3/HkvAveqDHo57vG5iax3Mhv2oO4i6KREjeDWpq7boSVvb3HWtal
         cO6G+o3+RI4QhJLsxtJcQytvPp0CG+EGsfSVvr4bKx2m3zFZZ+w2Xpk+LkEQdLOg+zgO
         xAU9RqXesXNXtZWky8BTBl0Y632w59JSydhfuYDu3n6p3eJvoTkNfZTRHP98eW7GrWL5
         h9ppky5BivvGfolaontfo1u5xNB+eIOLHedp56pr/O3EYT9eg5kw1VobMiKCQ4WkY9Ig
         Ja0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741804736; x=1742409536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rVMS1LO247bu3rF3RmSY8S7l1S/YDPSaye4wAOg0wU=;
        b=gl6LLWvv5IDMUZO6cJdKFb2BkikxWjtzF5dzVzbd51JrhKJJG5Q2ONSN1WY83RAy0/
         DIk+J0hbAhMf0OSV6d4ZCyvB03VIKqgjS2WUh/pHABjsT3TGPw8/3Vvy9PQvSWTogMax
         tql7e1BKxovLP0bvbji041HKjEPgw43YDEpznjk1rn5MPmjw5zKK5xK81/EgPVq0Gdfq
         RC1ABAj4voeAHQu9aIoG0um05bScqE3oKuSejBJNvIrfszAYXzSozxQoa8WYwkKQcEDy
         2FXisBPf+hYTnRYT3fzC2IvHd1BLK756N3qIWuPkwE7ug/t1ih7J8WHTUAVc9fr+dljk
         MuTw==
X-Gm-Message-State: AOJu0YzbJunOniUEkr0aqqa8wF230mps1JTv49K3j4rrE1jYV5a0mEu4
	HRuXFx1LPvvZ+5Z8pfXVsFqmITwyuZamWYbwyC+m9C3YFOEzW9JQUTsMFX9RpaI=
X-Gm-Gg: ASbGnctBMNfn/ksCnSyEzmky3IDB/XIyovS6kt4qCRZvRcz02Ao9QI8HiKF8YBItBjX
	jgE6O6J1vtTGz/acEPfyVoy02h21SEADnBO6SyXDc9gZw0svlcqY+dh8FEipbXXTEnlryhKLqaH
	NrN94ukHlIVhFdWiGenHNAJZenMW3zEE4zbri2wCQaVUCzWAYfVrZZTAFPzNq/hEdPbAxVBbO+O
	YbXeLgdBE54bfXTglAOFA440Jcc0XjYqH5wjQRxmcMmScUF75cbRAuYq2Dz/8zHh5CaoPF6OUPm
	1uqpFY3/h/BgkLyDEYZi6zinAxatKAwAvZWkomRVdzJD39w5wmWGtbDp0FTjFCYjhSbddebebwF
	M+qdE8rBhD5Ip0q+9JM0JsA==
X-Google-Smtp-Source: AGHT+IFNgwCQdIuLTzWuEoimg/78qxLnRaYd5NveniOXwtEVeCV6PNQ3uq/anLZsLzUqHSqrhpRPZw==
X-Received: by 2002:a05:600d:d:b0:43c:e2dd:98ea with SMTP id 5b1f17b1804b1-43ce2dd9f06mr144104935e9.22.1741804736077;
        Wed, 12 Mar 2025 11:38:56 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a731019sm29847495e9.2.2025.03.12.11.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 11:38:54 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: ad7124: Make register naming consistent
Date: Wed, 12 Mar 2025 19:38:37 +0100
Message-ID:  <40a3ce4af8a1fc08b49984bc13ea678c141cb9b3.1741801853.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
References: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=16026; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=zWLWMNZKgUe9uj6V+/Q3yc9l5G30ZbTu3z3Gd3iqmsk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn0dSvEz24wnoGm4r39t6U/WfLkLNhtuk94unyM Gh3S5AQ4c2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ9HUrwAKCRCPgPtYfRL+ Tkc7B/4uA0oDX8I+t/PATsLpc8hVpJ1WPKf19t8Dnb7b8iHjprfa2fB7u3GaUkCQA8RHXc1rTQV FmcL8tVvY1vIQmJWtsmXCTh3Ew08YXRXxclMnNodL7ufhalEGbEtUXMUyP4ZBqaDL95BNwFWgg7 gsrHwo8zqI7QqMmZV+W0W8MXvF9cR2XjsPM63STghEwqv73lvQ70u2y5G+0eTzB9OUoOWZgOflt OiKY6sbb0amzi1tk5n0PvKQjZulQ/5QmzRYdsYzSbo7pfDYAQXVy6zKAvRqjD8oUPmPYaNOfigi colHYqeec/pqdfldL/IyD+3UYrm9nfD55e5Np8E/wLc9+Cqe
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Cleanup definition of register related constants:

 - Use the register and field names exactly as documented in the data
   sheet.
 - Consistently use <regname>_<bitfield> to name a register's bitfield.
 - Drop _MSK definitions and implicit FIELD_PREP calls.
 - Consistent indentation.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 174 +++++++++++++++++++--------------------
 1 file changed, 84 insertions(+), 90 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3ea81a98e455..67d49e6184f7 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -32,7 +32,7 @@
 #define AD7124_IO_CONTROL_2		0x04
 #define AD7124_ID			0x05
 #define AD7124_ERROR			0x06
-#define AD7124_ERROR_EN		0x07
+#define AD7124_ERROR_EN			0x07
 #define AD7124_MCLK_COUNT		0x08
 #define AD7124_CHANNEL(x)		(0x09 + (x))
 #define AD7124_CONFIG(x)		(0x19 + (x))
@@ -41,68 +41,58 @@
 #define AD7124_GAIN(x)			(0x31 + (x))
 
 /* AD7124_STATUS */
-#define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
+#define AD7124_STATUS_POR_FLAG			BIT(4)
 
 /* AD7124_ADC_CONTROL */
-#define AD7124_ADC_STATUS_EN_MSK	BIT(10)
-#define AD7124_ADC_STATUS_EN(x)		FIELD_PREP(AD7124_ADC_STATUS_EN_MSK, x)
-#define AD7124_ADC_CTRL_REF_EN_MSK	BIT(8)
-#define AD7124_ADC_CTRL_REF_EN(x)	FIELD_PREP(AD7124_ADC_CTRL_REF_EN_MSK, x)
-#define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
-#define AD7124_ADC_CTRL_PWR(x)		FIELD_PREP(AD7124_ADC_CTRL_PWR_MSK, x)
-#define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
-#define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
+#define AD7124_ADC_CONTROL_MODE			GENMASK(5, 2)
+#define AD7124_ADC_CONTROL_MODE_CONTINUOUS		0
+#define AD7124_ADC_CONTROL_MODE_SINGLE			1
+#define AD7124_ADC_CONTROL_MODE_STANDBY			2
+#define AD7124_ADC_CONTROL_MODE_POWERDOWN		3
+#define AD7124_ADC_CONTROL_MODE_IDLE			4
+#define AD7124_ADC_CONTROL_MODE_INT_OFFSET_CALIB	5 /* Internal Zero-Scale Calibration */
+#define AD7124_ADC_CONTROL_MODE_INT_GAIN_CALIB		6 /* Internal Full-Scale Calibration */
+#define AD7124_ADC_CONTROL_MODE_SYS_OFFSET_CALIB	7 /* System Zero-Scale Calibration */
+#define AD7124_ADC_CONTROL_MODE_SYS_GAIN_CALIB		8 /* System Full-Scale Calibration */
+#define AD7124_ADC_CONTROL_POWER_MODE		GENMASK(7, 6)
+#define AD7124_ADC_CONTROL_POWER_MODE_LOW		0
+#define AD7124_ADC_CONTROL_POWER_MODE_MID		1
+#define AD7124_ADC_CONTROL_POWER_MODE_FULL		2
+#define AD7124_ADC_CONTROL_REF_EN		BIT(8)
+#define AD7124_ADC_CONTROL_DATA_STATUS		BIT(10)
 
-#define AD7124_MODE_CAL_INT_ZERO	0x5 /* Internal Zero-Scale Calibration */
-#define AD7124_MODE_CAL_INT_FULL	0x6 /* Internal Full-Scale Calibration */
-#define AD7124_MODE_CAL_SYS_ZERO	0x7 /* System Zero-Scale Calibration */
-#define AD7124_MODE_CAL_SYS_FULL	0x8 /* System Full-Scale Calibration */
-
-/* AD7124 ID */
-#define AD7124_DEVICE_ID_MSK		GENMASK(7, 4)
-#define AD7124_DEVICE_ID_GET(x)		FIELD_GET(AD7124_DEVICE_ID_MSK, x)
-#define AD7124_SILICON_REV_MSK		GENMASK(3, 0)
-#define AD7124_SILICON_REV_GET(x)	FIELD_GET(AD7124_SILICON_REV_MSK, x)
-
-#define CHIPID_AD7124_4			0x0
-#define CHIPID_AD7124_8			0x1
+/* AD7124_ID */
+#define AD7124_ID_SILICON_REVISION		GENMASK(3, 0)
+#define AD7124_ID_DEVICE_ID			GENMASK(7, 4)
+#define AD7124_ID_DEVICE_ID_AD7124_4			0x0
+#define AD7124_ID_DEVICE_ID_AD7124_8			0x1
 
 /* AD7124_CHANNEL_X */
-#define AD7124_CHANNEL_EN_MSK		BIT(15)
-#define AD7124_CHANNEL_EN(x)		FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
-#define AD7124_CHANNEL_SETUP_MSK	GENMASK(14, 12)
-#define AD7124_CHANNEL_SETUP(x)	FIELD_PREP(AD7124_CHANNEL_SETUP_MSK, x)
-#define AD7124_CHANNEL_AINP_MSK	GENMASK(9, 5)
-#define AD7124_CHANNEL_AINP(x)		FIELD_PREP(AD7124_CHANNEL_AINP_MSK, x)
-#define AD7124_CHANNEL_AINM_MSK	GENMASK(4, 0)
-#define AD7124_CHANNEL_AINM(x)		FIELD_PREP(AD7124_CHANNEL_AINM_MSK, x)
+#define AD7124_CHANNEL_ENABLE		BIT(15)
+#define AD7124_CHANNEL_SETUP		GENMASK(14, 12)
+#define AD7124_CHANNEL_AINP		GENMASK(9, 5)
+#define AD7124_CHANNEL_AINM		GENMASK(4, 0)
+#define AD7124_CHANNEL_AINx_TEMPSENSOR		16
+#define AD7124_CHANNEL_AINx_AVSS		17
 
 /* AD7124_CONFIG_X */
-#define AD7124_CONFIG_BIPOLAR_MSK	BIT(11)
-#define AD7124_CONFIG_BIPOLAR(x)	FIELD_PREP(AD7124_CONFIG_BIPOLAR_MSK, x)
-#define AD7124_CONFIG_REF_SEL_MSK	GENMASK(4, 3)
-#define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
-#define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
-#define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
-#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(6, 5)
-#define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
+#define AD7124_CONFIG_BIPOLAR		BIT(11)
+#define AD7124_CONFIG_IN_BUFF		GENMASK(6, 5)
+#define AD7124_CONFIG_AIN_BUFP		BIT(6)
+#define AD7124_CONFIG_AIN_BUFM		BIT(5)
+#define AD7124_CONFIG_REF_SEL		GENMASK(4, 3)
+#define AD7124_CONFIG_PGA		GENMASK(2, 0)
 
 /* AD7124_FILTER_X */
-#define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
-#define AD7124_FILTER_FS(x)		FIELD_PREP(AD7124_FILTER_FS_MSK, x)
-#define AD7124_FILTER_TYPE_MSK		GENMASK(23, 21)
-#define AD7124_FILTER_TYPE_SEL(x)	FIELD_PREP(AD7124_FILTER_TYPE_MSK, x)
+#define AD7124_FILTER_FS		GENMASK(10, 0)
+#define AD7124_FILTER_FILTER		GENMASK(23, 21)
+#define AD7124_FILTER_FILTER_SINC4		0
+#define AD7124_FILTER_FILTER_SINC3		2
 
-#define AD7124_SINC3_FILTER 2
-#define AD7124_SINC4_FILTER 0
-
-#define AD7124_CONF_ADDR_OFFSET	20
 #define AD7124_MAX_CONFIGS	8
 #define AD7124_MAX_CHANNELS	16
 
 /* AD7124 input sources */
-#define AD7124_INPUT_TEMPSENSOR	16
-#define AD7124_INPUT_AVSS	17
 
 enum ad7124_ids {
 	ID_AD7124_4,
@@ -206,12 +196,12 @@ struct ad7124_state {
 static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
 	[ID_AD7124_4] = {
 		.name = "ad7124-4",
-		.chip_id = CHIPID_AD7124_4,
+		.chip_id = AD7124_ID_DEVICE_ID_AD7124_4,
 		.num_inputs = 8,
 	},
 	[ID_AD7124_8] = {
 		.name = "ad7124-8",
-		.chip_id = CHIPID_AD7124_8,
+		.chip_id = AD7124_ID_DEVICE_ID_AD7124_8,
 		.num_inputs = 16,
 	},
 };
@@ -260,8 +250,8 @@ static int ad7124_set_mode(struct ad_sigma_delta *sd,
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 
-	st->adc_control &= ~AD7124_ADC_CTRL_MODE_MSK;
-	st->adc_control |= AD7124_ADC_CTRL_MODE(mode);
+	st->adc_control &= ~AD7124_ADC_CONTROL_MODE;
+	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_MODE, mode);
 
 	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
 }
@@ -300,9 +290,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 	fadc = st->channels[channel].cfg.odr;
 
 	switch (st->channels[channel].cfg.filter_type) {
-	case AD7124_SINC3_FILTER:
+	case AD7124_FILTER_FILTER_SINC3:
 		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
-	case AD7124_SINC4_FILTER:
+	case AD7124_FILTER_FILTER_SINC4:
 		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
 	default:
 		return -EINVAL;
@@ -321,10 +311,10 @@ static void ad7124_set_3db_filter_freq(struct ad7124_state *st, unsigned int cha
 	sinc3_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 262);
 
 	if (sinc4_3db_odr > sinc3_3db_odr) {
-		new_filter = AD7124_SINC3_FILTER;
+		new_filter = AD7124_FILTER_FILTER_SINC3;
 		new_odr = sinc4_3db_odr;
 	} else {
-		new_filter = AD7124_SINC4_FILTER;
+		new_filter = AD7124_FILTER_FILTER_SINC4;
 		new_odr = sinc3_3db_odr;
 	}
 
@@ -413,8 +403,7 @@ static int ad7124_init_config_vref(struct ad7124_state *st, struct ad7124_channe
 		return 0;
 	case AD7124_INT_REF:
 		cfg->vref_mv = 2500;
-		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
-		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
+		st->adc_control |= AD7124_ADC_CONTROL_REF_EN;
 		return 0;
 	default:
 		return dev_err_probe(dev, -EINVAL, "Invalid reference %d\n", refsel);
@@ -438,18 +427,20 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	if (ret)
 		return ret;
 
-	tmp = (cfg->buf_positive << 1) + cfg->buf_negative;
-	val = AD7124_CONFIG_BIPOLAR(cfg->bipolar) | AD7124_CONFIG_REF_SEL(cfg->refsel) |
-	      AD7124_CONFIG_IN_BUFF(tmp) | AD7124_CONFIG_PGA(cfg->pga_bits);
+	val = FIELD_PREP(AD7124_CONFIG_BIPOLAR, cfg->bipolar) |
+		FIELD_PREP(AD7124_CONFIG_REF_SEL, cfg->refsel) |
+		(cfg->buf_positive ? AD7124_CONFIG_AIN_BUFP : 0) |
+		(cfg->buf_negative ? AD7124_CONFIG_AIN_BUFM : 0) |
+		FIELD_PREP(AD7124_CONFIG_PGA, cfg->pga_bits);
 
 	ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(cfg->cfg_slot), 2, val);
 	if (ret < 0)
 		return ret;
 
-	tmp = AD7124_FILTER_TYPE_SEL(cfg->filter_type) |
-	      AD7124_FILTER_FS(cfg->odr_sel_bits);
+	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
+		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);
 	return ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot),
-				     AD7124_FILTER_TYPE_MSK | AD7124_FILTER_FS_MSK,
+				     AD7124_FILTER_FILTER | AD7124_FILTER_FS,
 				     tmp, 3);
 }
 
@@ -514,7 +505,8 @@ static int ad7124_enable_channel(struct ad7124_state *st, struct ad7124_channel
 {
 	ch->cfg.live = true;
 	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(ch->nr), 2, ch->ain |
-			      AD7124_CHANNEL_SETUP(ch->cfg.cfg_slot) | AD7124_CHANNEL_EN(1));
+			       FIELD_PREP(AD7124_CHANNEL_SETUP, ch->cfg.cfg_slot) |
+			       AD7124_CHANNEL_ENABLE);
 }
 
 static int ad7124_prepare_read(struct ad7124_state *st, int address)
@@ -564,8 +556,10 @@ static int ad7124_append_status(struct ad_sigma_delta *sd, bool append)
 	unsigned int adc_control = st->adc_control;
 	int ret;
 
-	adc_control &= ~AD7124_ADC_STATUS_EN_MSK;
-	adc_control |= AD7124_ADC_STATUS_EN(append);
+	if (append)
+		adc_control |= AD7124_ADC_CONTROL_DATA_STATUS;
+	else
+		adc_control &= ~AD7124_ADC_CONTROL_DATA_STATUS;
 
 	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, adc_control);
 	if (ret < 0)
@@ -580,7 +574,7 @@ static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 
-	/* The relevant thing here is that AD7124_CHANNEL_EN_MSK is cleared. */
+	/* The relevant thing here is that AD7124_CHANNEL_ENABLE is cleared. */
 	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
 }
 
@@ -802,7 +796,7 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 		if (bit_set)
 			ret = __ad7124_set_channel(&st->sd, i);
 		else
-			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_EN_MSK,
+			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_ENABLE,
 						    0, 2);
 		if (ret < 0) {
 			mutex_unlock(&st->cfgs_lock);
@@ -843,14 +837,14 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "Error reading status register\n");
 
-		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
+		if (!(readval & AD7124_STATUS_POR_FLAG))
 			break;
 
 		/* The AD7124 requires typically 2ms to power up and settle */
 		usleep_range(100, 2000);
 	} while (--timeout);
 
-	if (readval & AD7124_STATUS_POR_FLAG_MSK)
+	if (readval & AD7124_STATUS_POR_FLAG)
 		return dev_err_probe(dev, -EIO, "Soft reset failed\n");
 
 	ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3, &st->gain_default);
@@ -872,8 +866,8 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failure to read ID register\n");
 
-	chip_id = AD7124_DEVICE_ID_GET(readval);
-	silicon_rev = AD7124_SILICON_REV_GET(readval);
+	chip_id = FIELD_GET(AD7124_ID_DEVICE_ID, readval);
+	silicon_rev = FIELD_GET(AD7124_ID_SILICON_REVISION, readval);
 
 	if (chip_id != st->chip_info->chip_id)
 		return dev_err_probe(dev, -ENODEV,
@@ -901,7 +895,7 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 	if (ch->syscalib_mode == AD7124_SYSCALIB_ZERO_SCALE) {
 		ch->cfg.calibration_offset = 0x800000;
 
-		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_ZERO,
+		ret = ad_sd_calibrate(&st->sd, AD7124_ADC_CONTROL_MODE_SYS_OFFSET_CALIB,
 				      chan->address);
 		if (ret < 0)
 			return ret;
@@ -916,7 +910,7 @@ static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan
 	} else {
 		ch->cfg.calibration_gain = st->gain_default;
 
-		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_FULL,
+		ret = ad_sd_calibrate(&st->sd, AD7124_ADC_CONTROL_MODE_SYS_GAIN_CALIB,
 				      chan->address);
 		if (ret < 0)
 			return ret;
@@ -1031,7 +1025,7 @@ static bool ad7124_valid_input_select(unsigned int ain, const struct ad7124_chip
 	if (ain >= info->num_inputs && ain < 16)
 		return false;
 
-	return ain <= FIELD_MAX(AD7124_CHANNEL_AINM_MSK);
+	return ain <= FIELD_MAX(AD7124_CHANNEL_AINM);
 }
 
 static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
@@ -1096,8 +1090,8 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 					     "diff-channels property of %pfwP contains invalid data\n", child);
 
 		st->channels[channel].nr = channel;
-		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
-						  AD7124_CHANNEL_AINM(ain[1]);
+		st->channels[channel].ain = FIELD_PREP(AD7124_CHANNEL_AINP, ain[0]) |
+			FIELD_PREP(AD7124_CHANNEL_AINM, ain[1]);
 
 		cfg = &st->channels[channel].cfg;
 		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
@@ -1123,8 +1117,8 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	if (num_channels < AD7124_MAX_CHANNELS) {
 		st->channels[num_channels] = (struct ad7124_channel) {
 			.nr = num_channels,
-			.ain = AD7124_CHANNEL_AINP(AD7124_INPUT_TEMPSENSOR) |
-				AD7124_CHANNEL_AINM(AD7124_INPUT_AVSS),
+			.ain = FIELD_PREP(AD7124_CHANNEL_AINP, AD7124_CHANNEL_AINx_TEMPSENSOR) |
+				FIELD_PREP(AD7124_CHANNEL_AINM, AD7124_CHANNEL_AINx_AVSS),
 			.cfg = {
 				.bipolar = true,
 			},
@@ -1175,11 +1169,11 @@ static int ad7124_setup(struct ad7124_state *st)
 	}
 
 	/* Set the power mode */
-	st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
-	st->adc_control |= AD7124_ADC_CTRL_PWR(power_mode);
+	st->adc_control &= ~AD7124_ADC_CONTROL_POWER_MODE;
+	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_POWER_MODE, power_mode);
 
-	st->adc_control &= ~AD7124_ADC_CTRL_MODE_MSK;
-	st->adc_control |= AD7124_ADC_CTRL_MODE(AD_SD_MODE_IDLE);
+	st->adc_control &= ~AD7124_ADC_CONTROL_MODE;
+	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_MODE, AD_SD_MODE_IDLE);
 
 	mutex_init(&st->cfgs_lock);
 	INIT_KFIFO(st->live_cfgs_fifo);
@@ -1233,7 +1227,7 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 		 * usual: first zero-scale then full-scale calibration.
 		 */
 		if (st->channels[i].cfg.pga_bits > 0) {
-			ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_FULL, i);
+			ret = ad_sd_calibrate(&st->sd, AD7124_ADC_CONTROL_MODE_INT_GAIN_CALIB, i);
 			if (ret < 0)
 				return ret;
 
@@ -1250,7 +1244,7 @@ static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio
 				return ret;
 		}
 
-		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_ZERO, i);
+		ret = ad_sd_calibrate(&st->sd, AD7124_ADC_CONTROL_MODE_INT_OFFSET_CALIB, i);
 		if (ret < 0)
 			return ret;
 
@@ -1279,9 +1273,9 @@ static int ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio_d
 	 * The resulting calibration is then also valid for high-speed, so just
 	 * restore adc_control afterwards.
 	 */
-	if (FIELD_GET(AD7124_ADC_CTRL_PWR_MSK, adc_control) >= AD7124_FULL_POWER) {
-		st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
-		st->adc_control |= AD7124_ADC_CTRL_PWR(AD7124_MID_POWER);
+	if (FIELD_GET(AD7124_ADC_CONTROL_POWER_MODE, adc_control) >= AD7124_FULL_POWER) {
+		st->adc_control &= ~AD7124_ADC_CONTROL_POWER_MODE;
+		st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_POWER_MODE, AD7124_MID_POWER);
 	}
 
 	ret = __ad7124_calibrate_all(st, indio_dev);
-- 
2.47.1


