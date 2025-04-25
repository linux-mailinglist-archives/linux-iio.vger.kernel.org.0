Return-Path: <linux-iio+bounces-18655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78923A9CA14
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 15:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B481BC4DD5
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0CE2512D2;
	Fri, 25 Apr 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0q8zC3F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205678F2D;
	Fri, 25 Apr 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587276; cv=none; b=nO9b20Y5MpsHCf4JB0rvhmKmHqn/LxMkTgp04JyLbdBNcXcZzXIYVC6OmVObpYrqJDd/kVv7lErXqXleT+Kts5nj58suNIta/p9UAezY7C36I6dOlXvVnfXTwQVIkl9yu8Tpgqt/00GejLX7IyjCkzDa+LkwZWiAfwVMWsH4KB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587276; c=relaxed/simple;
	bh=Ze8qT0E3/sgUyXsEaVeGhRU/WrfeWGypXeSS3EiGB2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4t0I4OmqxhIUYK18znafhNtZJpdDi88clZqSpuvIZ/QctrPpSuBveLj5GxIkw5/IAIxeD/egwVDSrLPmW4u15K49rdw/c6nv45IHU6kLe82dASZiCZCi8rb/b3D2Ms2r9Xc9GF+GRuFCXhSK+1HGfLum+MqhJNEfXKL2RyLJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0q8zC3F; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so4148387a12.0;
        Fri, 25 Apr 2025 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745587272; x=1746192072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AodzOIaOmmR6najrPyYz0tHNLOSGh9B5xHTUzOChA0c=;
        b=P0q8zC3F7Xom/qlMriI7uuXddcSt01P6RlrxErf3W5mwybnM2rxzc+V7Xpvp5uVuMA
         mcDRaAxEVU+jXGBBHrdCNLkbWmYSfoYvbEnkMuuHNyZ66tq9v1PAlqsu/6WzpygSNCob
         w67XHVNsZ5kO7UDEclPXs7+v8ZyuO7s1wlhzBsu6zwG+HEluU/W9Dx+oKMG7PL9N5/FQ
         iLRAH9ivAxDx0Ogyuu/yxC7PpfWkOmGuyGFnqJ+5xd2lhgwME2RY5+6dVM+nejtFChfF
         /x/B+VhCzz5C6nQ6avaeOzZjKQVccu+H+ldvKz13C2IxUpFpoN8KXzBP2Zf2pE73Xip1
         pHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587272; x=1746192072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AodzOIaOmmR6najrPyYz0tHNLOSGh9B5xHTUzOChA0c=;
        b=k/nxU+T5YfxOCN3EksbSEl2hw0KkdKiXvRiCryxa6taaJBzFdInTJ9aaC2FU1y6QBS
         PQKp9N/zQSomCYYyHeEX19o3sC5za5m3WR3AIhVm/8BtVDp7Nf7hz0KZzlhn+tw7SA9A
         hZ9abShwttI0EOsitnDuMTJkC9bp4zHDwxkOLtiKGBmFC7vfcsrZ1naAr1zfluFy8cOM
         u/rM3ZVaRTdBvu7DpP4FbjbzbnvyTZh+vkwIm4xC8/eScCIUyPU0aoAwFN80A7TqqiD9
         u7g9fcV7fN1qfZyJ3dA0WL0hyu/Fe6pyfZ3b2XXbkbNMwDbV93eaab6RRDbU2aTvjJK9
         6uIA==
X-Forwarded-Encrypted: i=1; AJvYcCUx0HNjzcyWKx/W7CZYRrwAXoYBrMKRKwGwORuvSKOPjfuSpBFbNUFhY9Jm2Rz5+GYyNNmJB+9DWqQ=@vger.kernel.org, AJvYcCWdmIkn7uS4aQ79vbGkeJFQa4oCCCFReTiuwPv6sKFPuGI1p48dc7lW9pyPAwPV568dlxXvp4nZC8KYHA+C@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXmMAtGIU+R2epwRKPgFIGYNVBN39Za+IjO1IenYgVNjmqqF8
	XYBRNKK1i/anFI6if619gPtuarKjDli9DeMHn9NUdmGKGGmzQ4d4
X-Gm-Gg: ASbGncuD2lv2LKgoMnX6Um36qKtjjXH5bgSGVtFBf0jaOpnciTGmKb8VIXSlhWockPu
	buTXuBuOmP591pVnMbRhoYYJjU3A9Ll2GEO/DVHz1ERGuCYeKVl9N/LEfVNd19eeFLRhaZT4MYc
	8tvutQekwsfp0HFwpbNMkbvor45CRYwf8+m/B9UQ2EjAh4T/RiQQhoDun4Yzi9GwXN7wLfV6A9o
	czz5a63FpMiR8M8UgtSBhWbQKovzIEW/Gdj+IFTLN7fssFoCUP+dhqCQh+mwp2o0lrswxapFQLq
	3Pd/dmQln5mCcewwbqsiAPk9EoIiv27Pb2U=
X-Google-Smtp-Source: AGHT+IGILdO1oQfG3R/APrASPemMWyAavhfHJKlLNZZtg+rRPy7X/f4MzWs4/kaWzRju0lBGJckLKg==
X-Received: by 2002:a17:907:9809:b0:ac7:16f2:e8e5 with SMTP id a640c23a62f3a-ace714082eamr211879466b.50.1745587271873;
        Fri, 25 Apr 2025 06:21:11 -0700 (PDT)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed65410sm133823466b.126.2025.04.25.06.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:21:11 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] iio: adc: ad7192: Refactor filter config
Date: Fri, 25 Apr 2025 16:20:20 +0300
Message-ID: <20250425132051.6154-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425132051.6154-1-alisa.roman@analog.com>
References: <20250425132051.6154-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not useful for users to set the 3db filter frequency or the
oversampling value. Remove the option for these to be set by the user.

The available arrays for 3db filter frequency and oversampling value are
not removed for backward compatibility.

The available array for 3db filter frequency is dynamic now, since some
chips have 4 filter modes and others have 16.

Expose the filter mode to user, providing an intuitive way to select
filter behaviour.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 455 +++++++++++++++++++++++++--------------
 1 file changed, 288 insertions(+), 167 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 530e1d307860..1846dc4e90b0 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -165,9 +165,9 @@
 #define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
-#define AD7192_NO_SYNC_FILTER	1
-#define AD7192_SYNC3_FILTER	3
-#define AD7192_SYNC4_FILTER	4
+#define AD7192_FILTER_DIV	1024
+#define AD7192_FS_MIN		1
+#define AD7192_FS_MAX		1023
 
 /* NOTE:
  * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
@@ -182,6 +182,25 @@ enum {
 	AD7192_SYSCALIB_FULL_SCALE,
 };
 
+enum ad7192_filter_mode {
+	AD7192_FILTER_SINC4,
+	AD7192_FILTER_SINC3,
+	AD7192_FILTER_SINC4_CHOP,
+	AD7192_FILTER_SINC3_CHOP,
+	AD7192_FILTER_SINC4_AVG2,
+	AD7192_FILTER_SINC3_AVG2,
+	AD7192_FILTER_SINC4_CHOP_AVG2,
+	AD7192_FILTER_SINC3_CHOP_AVG2,
+	AD7192_FILTER_SINC4_AVG8,
+	AD7192_FILTER_SINC3_AVG8,
+	AD7192_FILTER_SINC4_CHOP_AVG8,
+	AD7192_FILTER_SINC3_CHOP_AVG8,
+	AD7192_FILTER_SINC4_AVG16,
+	AD7192_FILTER_SINC3_AVG16,
+	AD7192_FILTER_SINC4_CHOP_AVG16,
+	AD7192_FILTER_SINC3_CHOP_AVG16,
+};
+
 enum {
 	ID_AD7190,
 	ID_AD7192,
@@ -190,11 +209,24 @@ enum {
 	ID_AD7195,
 };
 
+struct ad7192_filter_config {
+	enum ad7192_filter_mode		filter_mode;
+	unsigned int			f_order;
+	u8				sinc3_en;
+	u8				chop_en;
+	u8				avg_val;
+	enum iio_available_type		samp_freq_avail_type;
+	int				samp_freq_avail_len;
+	int				samp_freq_avail[2][2];
+};
+
 struct ad7192_chip_info {
 	unsigned int			chip_id;
 	const char			*name;
 	const struct iio_chan_spec	*channels;
 	u8				num_channels;
+	const struct ad7192_filter_config	*filter_configs;
+	u8					num_filter_modes;
 	const struct ad_sigma_delta_info	*sigma_delta_info;
 	const struct iio_info		*info;
 	int (*parse_channels)(struct iio_dev *indio_dev);
@@ -210,13 +242,16 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
-	u32				filter_freq_avail[4][2];
+	u32				(*filter_freq_avail)[2];
+	u8				num_filter_modes;
 	u32				oversampling_ratio_avail[4];
 	u8				gpocon;
 	u8				clock_sel;
 	struct mutex			lock;	/* protect sensor state */
 	u8				syscalib_mode[8];
 
+	enum ad7192_filter_mode		filter_mode;
+
 	struct ad_sigma_delta		sd;
 };
 
@@ -282,7 +317,200 @@ static const struct iio_enum ad7192_syscalib_mode_enum = {
 	.get = ad7192_get_syscalib_mode
 };
 
-static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
+#define AD7192_FILTER_CONFIG(_filter_mode, _f_order, _sinc3_en, _chop_en, _avg_val)	\
+{									\
+		.filter_mode = (_filter_mode),				\
+		.f_order = (_f_order),					\
+		.sinc3_en = (_sinc3_en),				\
+		.chop_en = (_chop_en),					\
+		.avg_val = (_avg_val),					\
+		.samp_freq_avail_type = IIO_AVAIL_RANGE,		\
+		.samp_freq_avail_len = 2,		\
+		.samp_freq_avail = {					\
+			{ AD7192_INT_FREQ_MHZ,				\
+				(_f_order) * AD7192_FILTER_DIV * AD7192_FS_MAX },	\
+			{ AD7192_INT_FREQ_MHZ,				\
+				(_f_order) * AD7192_FILTER_DIV * AD7192_FS_MIN },	\
+		},							\
+}
+
+static const struct ad7192_filter_config ad7192_filter_configs[] = {
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4,		1, 0, 0, 1),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3,		1, 1, 0, 1),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP,		4, 0, 1, 1),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP,		3, 1, 1, 1),
+};
+
+static const struct ad7192_filter_config ad7192_filter_configs_avg[] = {
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4,		1, 0, 0, 1),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3,		1, 1, 0, 1),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP,		4, 0, 1, 1),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP,		3, 1, 1, 1),
+
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_AVG2,		5, 0, 0, 2),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_AVG2,		4, 1, 0, 2),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP_AVG2,	5, 0, 1, 2),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP_AVG2,	4, 1, 1, 2),
+
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_AVG8,		11, 0, 0, 8),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_AVG8,		10, 1, 0, 8),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP_AVG8,	11, 0, 1, 8),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP_AVG8,	10, 1, 1, 8),
+
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_AVG16,		19, 0, 0, 16),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_AVG16,		18, 1, 0, 16),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC4_CHOP_AVG16,	19, 0, 1, 16),
+	AD7192_FILTER_CONFIG(AD7192_FILTER_SINC3_CHOP_AVG16,	18, 1, 1, 16),
+};
+
+static const char *const ad7192_filter_modes_str[] = {
+	[AD7192_FILTER_SINC4] =			"sinc4",
+	[AD7192_FILTER_SINC3] =			"sinc3",
+	[AD7192_FILTER_SINC4_CHOP] =		"sinc4+chop",
+	[AD7192_FILTER_SINC3_CHOP] =		"sinc3+chop",
+	[AD7192_FILTER_SINC4_AVG2] =		"sinc4+avg2",
+	[AD7192_FILTER_SINC3_AVG2] =		"sinc3+avg2",
+	[AD7192_FILTER_SINC4_CHOP_AVG2] =	"sinc4+chop+avg2",
+	[AD7192_FILTER_SINC3_CHOP_AVG2] =	"sinc3+chop+avg2",
+	[AD7192_FILTER_SINC4_AVG8] =		"sinc4+avg8",
+	[AD7192_FILTER_SINC3_AVG8] =		"sinc3+avg8",
+	[AD7192_FILTER_SINC4_CHOP_AVG8] =	"sinc4+chop+avg8",
+	[AD7192_FILTER_SINC3_CHOP_AVG8] =	"sinc3+chop+avg8",
+	[AD7192_FILTER_SINC4_AVG16] =		"sinc4+avg16",
+	[AD7192_FILTER_SINC3_AVG16] =		"sinc3+avg16",
+	[AD7192_FILTER_SINC4_CHOP_AVG16] =	"sinc4+chop+avg16",
+	[AD7192_FILTER_SINC3_CHOP_AVG16] =	"sinc3+chop+avg16",
+};
+
+static int ad7192_get_f_order(struct ad7192_state *st)
+{
+	const struct ad7192_filter_config *filter_config;
+
+	filter_config = &st->chip_info->filter_configs[st->filter_mode];
+
+	return filter_config->f_order;
+}
+
+static int ad7192_compute_f_adc(struct ad7192_state *st,
+				const struct ad7192_filter_config *filter_config)
+{
+	unsigned int f_order = filter_config->f_order;
+
+	return DIV_ROUND_CLOSEST(st->fclk,
+				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+}
+
+static int ad7192_get_f_adc(struct ad7192_state *st)
+{
+	unsigned int f_order = ad7192_get_f_order(st);
+
+	return DIV_ROUND_CLOSEST(st->fclk,
+				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
+}
+
+static int ad7192_compute_3db_filter_freq(unsigned int fadc,
+					  enum ad7192_filter_mode filter_mode)
+{
+	switch (filter_mode) {
+	case AD7192_FILTER_SINC4:
+		return DIV_ROUND_CLOSEST(fadc * 230, 1024);
+	case AD7192_FILTER_SINC3:
+		return DIV_ROUND_CLOSEST(fadc * 272, 1024);
+	default:
+		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
+	}
+}
+
+static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
+{
+	unsigned int fadc;
+	enum ad7192_filter_mode filter_mode = st->filter_mode;
+
+	fadc = ad7192_get_f_adc(st);
+
+	return ad7192_compute_3db_filter_freq(fadc, filter_mode);
+}
+
+static void ad7192_update_filter_freq_avail(struct ad7192_state *st)
+{
+	unsigned int i, fadc;
+	const struct ad7192_filter_config *filter_config;
+
+	for (i = 0; i < st->num_filter_modes; i++) {
+		filter_config = &st->chip_info->filter_configs[i];
+
+		fadc = ad7192_compute_f_adc(st, filter_config);
+
+		st->filter_freq_avail[i][0] =
+			ad7192_compute_3db_filter_freq(fadc, filter_config->filter_mode);
+
+		st->filter_freq_avail[i][1] = 1000;
+	}
+}
+
+static int ad7192_set_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int val)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+	const struct ad7192_filter_config *filter_config = &st->chip_info->filter_configs[val];
+	u16 old_samp_freq, div;
+	int i, ret;
+
+	old_samp_freq = ad7192_get_f_adc(st);
+
+	st->filter_mode = val;
+
+	div = DIV_ROUND_CLOSEST(st->fclk, ad7192_get_f_order(st) * old_samp_freq);
+	if (div < AD7192_FS_MIN || div > AD7192_FS_MAX)
+		return -EINVAL;
+
+	st->mode &= ~AD7192_MODE_RATE_MASK;
+	st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
+
+	st->mode &= ~AD7192_MODE_SINC3;
+	st->mode |= FIELD_PREP(AD7192_MODE_SINC3, filter_config->sinc3_en);
+
+	st->conf &= ~AD7192_CONF_CHOP;
+	st->conf |= FIELD_PREP(AD7192_CONF_CHOP, filter_config->chop_en);
+
+	for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++) {
+		if (filter_config->avg_val != st->oversampling_ratio_avail[i])
+			continue;
+
+		st->mode &= ~AD7192_MODE_AVG_MASK;
+		st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
+	}
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+	if (ret < 0)
+		return ret;
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
+	if (ret < 0)
+		return ret;
+
+	ad7192_update_filter_freq_avail(st);
+
+	return 0;
+}
+
+static int ad7192_get_filter_mode(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+
+	return st->filter_mode;
+}
+
+static const struct iio_enum ad7192_filter_mode_enum = {
+	.items = ad7192_filter_modes_str,
+	.num_items = ARRAY_SIZE(ad7192_filter_modes_str),
+	.set = ad7192_set_filter_mode,
+	.get = ad7192_get_filter_mode,
+};
+
+static const struct iio_chan_spec_ext_info ad7192_ext_info[] = {
 	{
 		.name = "sys_calibration",
 		.write = ad7192_write_syscalib,
@@ -292,6 +520,9 @@ static const struct iio_chan_spec_ext_info ad7192_calibsys_ext_info[] = {
 		 &ad7192_syscalib_mode_enum),
 	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
 			   &ad7192_syscalib_mode_enum),
+	IIO_ENUM("filter_mode", IIO_SHARED_BY_ALL, &ad7192_filter_mode_enum),
+	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL,
+			   &ad7192_filter_mode_enum),
 	{ }
 };
 
@@ -650,15 +881,22 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	st->oversampling_ratio_avail[2] = 8;
 	st->oversampling_ratio_avail[3] = 16;
 
-	st->filter_freq_avail[0][0] = 600;
-	st->filter_freq_avail[1][0] = 800;
-	st->filter_freq_avail[2][0] = 2300;
-	st->filter_freq_avail[3][0] = 2720;
+	return 0;
+}
 
-	st->filter_freq_avail[0][1] = 1000;
-	st->filter_freq_avail[1][1] = 1000;
-	st->filter_freq_avail[2][1] = 1000;
-	st->filter_freq_avail[3][1] = 1000;
+static int ad7192_filter_setup(struct ad7192_state *st)
+{
+	unsigned int num_modes = st->chip_info->num_filter_modes;
+
+	st->filter_freq_avail = devm_kcalloc(&st->sd.spi->dev, num_modes,
+					     sizeof(*st->filter_freq_avail),
+					     GFP_KERNEL);
+	if (!st->filter_freq_avail)
+		return -ENOMEM;
+
+	st->num_filter_modes = num_modes;
+
+	ad7192_update_filter_freq_avail(st);
 
 	return 0;
 }
@@ -728,68 +966,6 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
-static int ad7192_compute_f_order(struct ad7192_state *st, bool sinc3_en, bool chop_en)
-{
-	u8 avg_factor_selected, oversampling_ratio;
-
-	avg_factor_selected = FIELD_GET(AD7192_MODE_AVG_MASK, st->mode);
-
-	if (!avg_factor_selected && !chop_en)
-		return 1;
-
-	oversampling_ratio = st->oversampling_ratio_avail[avg_factor_selected];
-
-	if (sinc3_en)
-		return AD7192_SYNC3_FILTER + oversampling_ratio - 1;
-
-	return AD7192_SYNC4_FILTER + oversampling_ratio - 1;
-}
-
-static int ad7192_get_f_order(struct ad7192_state *st)
-{
-	bool sinc3_en, chop_en;
-
-	sinc3_en = FIELD_GET(AD7192_MODE_SINC3, st->mode);
-	chop_en = FIELD_GET(AD7192_CONF_CHOP, st->conf);
-
-	return ad7192_compute_f_order(st, sinc3_en, chop_en);
-}
-
-static int ad7192_compute_f_adc(struct ad7192_state *st, bool sinc3_en,
-				bool chop_en)
-{
-	unsigned int f_order = ad7192_compute_f_order(st, sinc3_en, chop_en);
-
-	return DIV_ROUND_CLOSEST(st->fclk,
-				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
-}
-
-static int ad7192_get_f_adc(struct ad7192_state *st)
-{
-	unsigned int f_order = ad7192_get_f_order(st);
-
-	return DIV_ROUND_CLOSEST(st->fclk,
-				 f_order * FIELD_GET(AD7192_MODE_RATE_MASK, st->mode));
-}
-
-static void ad7192_update_filter_freq_avail(struct ad7192_state *st)
-{
-	unsigned int fadc;
-
-	/* Formulas for filter at page 25 of the datasheet */
-	fadc = ad7192_compute_f_adc(st, false, true);
-	st->filter_freq_avail[0][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
-
-	fadc = ad7192_compute_f_adc(st, true, true);
-	st->filter_freq_avail[1][0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
-
-	fadc = ad7192_compute_f_adc(st, false, false);
-	st->filter_freq_avail[2][0] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
-
-	fadc = ad7192_compute_f_adc(st, true, false);
-	st->filter_freq_avail[3][0] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
-}
-
 static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
@@ -822,68 +998,6 @@ static unsigned int ad7192_get_temp_scale(bool unipolar)
 	return unipolar ? 2815 * 2 : 2815;
 }
 
-static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
-				      int val, int val2)
-{
-	int i, ret, freq;
-	unsigned int diff_new, diff_old;
-	int idx = 0;
-
-	diff_old = U32_MAX;
-	freq = val * 1000 + val2;
-
-	for (i = 0; i < ARRAY_SIZE(st->filter_freq_avail); i++) {
-		diff_new = abs(freq - st->filter_freq_avail[i][0]);
-		if (diff_new < diff_old) {
-			diff_old = diff_new;
-			idx = i;
-		}
-	}
-
-	switch (idx) {
-	case 0:
-		st->mode &= ~AD7192_MODE_SINC3;
-
-		st->conf |= AD7192_CONF_CHOP;
-		break;
-	case 1:
-		st->mode |= AD7192_MODE_SINC3;
-
-		st->conf |= AD7192_CONF_CHOP;
-		break;
-	case 2:
-		st->mode &= ~AD7192_MODE_SINC3;
-
-		st->conf &= ~AD7192_CONF_CHOP;
-		break;
-	case 3:
-		st->mode |= AD7192_MODE_SINC3;
-
-		st->conf &= ~AD7192_CONF_CHOP;
-		break;
-	}
-
-	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
-	if (ret < 0)
-		return ret;
-
-	return ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
-}
-
-static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
-{
-	unsigned int fadc;
-
-	fadc = ad7192_get_f_adc(st);
-
-	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
-		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
-	if (FIELD_GET(AD7192_MODE_SINC3, st->mode))
-		return DIV_ROUND_CLOSEST(fadc * 272, 1024);
-	else
-		return DIV_ROUND_CLOSEST(fadc * 230, 1024);
-}
-
 static int ad7192_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -936,7 +1050,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);
+		*val = DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), AD7192_FILTER_DIV);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*val = ad7192_get_3db_filter_freq(st);
@@ -957,7 +1071,7 @@ static int __ad7192_write_raw(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	int i, div;
+	int i, div, ret;
 	unsigned int tmp;
 
 	guard(mutex)(&st->lock);
@@ -982,32 +1096,20 @@ static int __ad7192_write_raw(struct iio_dev *indio_dev,
 		if (!val)
 			return -EINVAL;
 
-		div = st->fclk / (val * ad7192_get_f_order(st) * 1024);
-		if (div < 1 || div > 1023)
+		div = st->fclk / (val * ad7192_get_f_order(st) * AD7192_FILTER_DIV);
+		if (div < AD7192_FS_MIN || div > AD7192_FS_MAX)
 			return -EINVAL;
 
 		st->mode &= ~AD7192_MODE_RATE_MASK;
 		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
-		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+
+		ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		if (ret)
+			return ret;
+
 		ad7192_update_filter_freq_avail(st);
-		return 0;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		return ad7192_set_3db_filter_freq(st, val, val2 / 1000);
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		for (i = 0; i < ARRAY_SIZE(st->oversampling_ratio_avail); i++) {
-			if (val != st->oversampling_ratio_avail[i])
-				continue;
 
-			tmp = st->mode;
-			st->mode &= ~AD7192_MODE_AVG_MASK;
-			st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
-			if (tmp == st->mode)
-				return 0;
-			ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
-			ad7192_update_filter_freq_avail(st);
-			return 0;
-		}
-		return -EINVAL;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1040,10 +1142,6 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -1055,6 +1153,7 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 			     long mask)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
+	const struct ad7192_filter_config *filter_config;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -1067,7 +1166,7 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*vals = (int *)st->filter_freq_avail;
 		*type = IIO_VAL_FRACTIONAL;
-		*length = ARRAY_SIZE(st->filter_freq_avail) * 2;
+		*length = st->num_filter_modes * 2;
 
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -1076,6 +1175,13 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(st->oversampling_ratio_avail);
 
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		filter_config = &st->chip_info->filter_configs[st->filter_mode];
+		*vals = (int *)filter_config->samp_freq_avail;
+		*length = filter_config->samp_freq_avail_len * 2;
+		*type = IIO_VAL_FRACTIONAL;
+
+		return filter_config->samp_freq_avail_type;
 	}
 
 	return -EINVAL;
@@ -1146,6 +1252,7 @@ static const struct iio_info ad7195_info = {
 			(_mask_all), \
 		.info_mask_shared_by_type_available = (_mask_type_av), \
 		.info_mask_shared_by_all_available = \
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
 			(_mask_all_av), \
 		.ext_info = (_ext_info), \
@@ -1160,11 +1267,11 @@ static const struct iio_info ad7195_info = {
 
 #define AD719x_DIFF_CHANNEL(_si, _channel1, _channel2, _address) \
 	__AD719x_CHANNEL(_si, _channel1, _channel2, _address, IIO_VOLTAGE, 0, \
-		BIT(IIO_CHAN_INFO_SCALE), 0, ad7192_calibsys_ext_info)
+		BIT(IIO_CHAN_INFO_SCALE), 0, ad7192_ext_info)
 
 #define AD719x_CHANNEL(_si, _channel1, _address) \
 	__AD719x_CHANNEL(_si, _channel1, -1, _address, IIO_VOLTAGE, 0, \
-		BIT(IIO_CHAN_INFO_SCALE), 0, ad7192_calibsys_ext_info)
+		BIT(IIO_CHAN_INFO_SCALE), 0, ad7192_ext_info)
 
 #define AD719x_TEMP_CHANNEL(_si, _address) \
 	__AD719x_CHANNEL(_si, 0, -1, _address, IIO_TEMP, 0, 0, 0, NULL)
@@ -1175,7 +1282,7 @@ static const struct iio_info ad7195_info = {
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
 		BIT(IIO_CHAN_INFO_SCALE), \
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
-		ad7192_calibsys_ext_info)
+		ad7192_ext_info)
 
 #define AD7193_CHANNEL(_si, _channel1, _address) \
 	AD7193_DIFF_CHANNEL(_si, _channel1, -1, _address)
@@ -1298,6 +1405,8 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.name = "ad7190",
 		.channels = ad7192_channels,
 		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.filter_configs = ad7192_filter_configs,
+		.num_filter_modes = ARRAY_SIZE(ad7192_filter_configs),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
 	},
@@ -1306,6 +1415,8 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.name = "ad7192",
 		.channels = ad7192_channels,
 		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.filter_configs = ad7192_filter_configs,
+		.num_filter_modes = ARRAY_SIZE(ad7192_filter_configs),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
 	},
@@ -1314,6 +1425,8 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.name = "ad7193",
 		.channels = ad7193_channels,
 		.num_channels = ARRAY_SIZE(ad7193_channels),
+		.filter_configs = ad7192_filter_configs_avg,
+		.num_filter_modes = ARRAY_SIZE(ad7192_filter_configs_avg),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7192_info,
 	},
@@ -1321,6 +1434,8 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.chip_id = CHIPID_AD7194,
 		.name = "ad7194",
 		.info = &ad7194_info,
+		.filter_configs = ad7192_filter_configs_avg,
+		.num_filter_modes = ARRAY_SIZE(ad7192_filter_configs_avg),
 		.sigma_delta_info = &ad7194_sigma_delta_info,
 		.parse_channels = ad7194_parse_channels,
 	},
@@ -1329,6 +1444,8 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
 		.name = "ad7195",
 		.channels = ad7192_channels,
 		.num_channels = ARRAY_SIZE(ad7192_channels),
+		.filter_configs = ad7192_filter_configs,
+		.num_filter_modes = ARRAY_SIZE(ad7192_filter_configs),
 		.sigma_delta_info = &ad7192_sigma_delta_info,
 		.info = &ad7195_info,
 	},
@@ -1433,6 +1550,10 @@ static int ad7192_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ad7192_filter_setup(st);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.43.0


