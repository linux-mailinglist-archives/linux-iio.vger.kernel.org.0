Return-Path: <linux-iio+bounces-16010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA0A422B1
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 15:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E466188569F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767E154C0B;
	Mon, 24 Feb 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k3PbDNng"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640471519A8
	for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406261; cv=none; b=ixD9qPIzDfr1xgeP1PZdboiWQyAqDtXSFeVgrQ0IOdQLg72k/TOgIeZpDtNH4hyrph6O3DkB+w0IXfgalMqzYQtkodQwxK9oey8hFwjSJhvo0s+QtyYFjZIVmC9F9+ZPVGjiJBU6IkHPWIl/COEjRQJbSBNvraLMTTTxd+LMl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406261; c=relaxed/simple;
	bh=tLYHWgOgKFqKV5m8842QnAKRfItLcN1thRf9+nhSm1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ4DjpeEvo99m7wMB9qV98oh0G8KVIAtATNgxUZnBHh2yJfsgBVYNkXFaRKLHTqld0b8kxxsCqkTFFyFtX2yBdgU0BBK64n1w0Ze6cOtCjMH+ruWhogPxjUGqk9KQHpbFs3KftSxlxOPtIDh0RwX4nugSmkslbnZCPg7tF/eLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k3PbDNng; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so5873771a12.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2025 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740406258; x=1741011058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaLxO4ePLEt4WLzLvwC/0MDiuUOe4ZK6pxwDX4VliLQ=;
        b=k3PbDNngfYGNeGMC/G7ICmNvo/Qp6GweTOnht0dqQRUwMSfK4Sziym1Jdv6tMu3rvj
         F4XdtqpUsnsWv3sMgpmUvvUTa2Vh0r76vtj9nR3CRCyfmP9nvRRTqkRHSl3jO6twVqSQ
         3/o/+TyPYbSTsqXkdx0c7qeDOVPOLLEFpwszOB83mUYGXs46FAWBsYHzRDfAMXx499oV
         1WU/4kdutycN58mb2J5N+Ge0I1ltC1atgy4rw400F7ZeSBCZ/XvD98T6k7pk/Qh6u4cC
         oEQOhuJx7+y+lXSZxAJLN5cpAADuCWqyBVpU/k2cYoHvSdW0zXka5b7F9mxjmN4KiUTA
         KWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406258; x=1741011058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaLxO4ePLEt4WLzLvwC/0MDiuUOe4ZK6pxwDX4VliLQ=;
        b=uINJOd6gbPWga1ymCVdTHcjm+pOZI8cI+KYNhIzg9wL8/wzyTUSQWsVuOUihIh/42M
         243AtADgqoc8DpSzAcbBno2WkNwd3OSqqD1LXo7RmIGAsJmgLhYfGnmR/tnItlI5gdad
         WI1hMIYRQb7iNWGnbqWzlsSRWtvPtGChHXcz/pylVuQM6Duwg5/5YvQvVib6xlzUahI6
         q+MPi8ms/7jL1KoYhXijTd/2KihAHrNI1s6YJrglMj3aXuGF7vScY0m7l9Oq+w+Wgvg5
         /TvUgX/R6qRiqq3Gd8p3nJT1RVbyZdW9NpNttPYKMSk/U8gOuxQ8oEhy1WFmusZ4yovP
         yqLA==
X-Gm-Message-State: AOJu0YzodvGdSbwSxE1uljHKoawgbKVrmB027CI5l4M48Cuq9u4eQBv1
	9NsZAfZkGoZSe1K3K1/F5GZm8Xh7QZNuHsJqFEQ+bLE8g4xzrVOKJ+kQJ2qJIFI=
X-Gm-Gg: ASbGnctJ0tB1BYC2Bs3IEB7DkBf8Wrj2DwU+O4XxNdUudYJcw5d9aO9vTyB6+vMExOd
	jlqE78h9+h0xShYXi5lOPu9CwT0NYBb7sZMqHDHj4PmjFnKqmAa3z3XWQrkZKIIdwOUoJYYBp4O
	CIlolHyfyOlPpR9BJAZWucfMFkMsCJoYDLyaqctT2WJ19SwFUqgzHABnS7Vdv4oWn24ZQvSvXBx
	iNXXvslgNlySz+rRXif2XnoUa0BYCPIhl2rfYQ9XXH3/m8eLZ5xqVgk492qbweJ2TvhAmamO08e
	Sodhr4alshGd1Ki78aJA3jitYGgMBoo=
X-Google-Smtp-Source: AGHT+IE+vXitc8IJLIfaLSuM9Y5853tGT/s/2uAzpLe8iYu5v5eqmpiTXoT3k+Oj7QrkZB0euazhHA==
X-Received: by 2002:a05:6402:234f:b0:5df:b6e1:4690 with SMTP id 4fb4d7f45d1cf-5e0b7106a9cmr32554123a12.12.1740406257566;
        Mon, 24 Feb 2025 06:10:57 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb80ba68aesm1764405566b.23.2025.02.24.06.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:10:57 -0800 (PST)
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
Subject: [PATCH v3 7/7] iio: adc: ad7124: Implement system calibration
Date: Mon, 24 Feb 2025 15:10:18 +0100
Message-ID:  <6a67919839c82ecde5080127216917d67bd77f2f.1740405546.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5084; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=tLYHWgOgKFqKV5m8842QnAKRfItLcN1thRf9+nhSm1c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnvH3WYhjSQsqYMqSAccTtt25slNbbbKK8Oqw5c xDxdUl4vYuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7x91gAKCRCPgPtYfRL+ TrpQCACNpDF7cIf4azfLveHjTSSHjRTryBBoWusWZlEbKr6D5TLyEvGQ9Fb4Ok+DcoI/pNtM/Wx SQa+Mn1zU6Mm+7V/wv3h+bEK8RKl9i0PP2MYcPJspdNGdlNujCxLfh3It2ntwnWaUjoTHVFZywV +JBrDZW2OsqACf78/qmTAL6u9aCPo7cIk1eXaMYiHdq0q5tTxJXfkYUxYBYxc2L0BCILQulawoz tGTnbYkzt2RQxGR+oXqZ+3yXVucSs7EX3MsviFeuXf5K1STxnI1u7rSuxnpWdQuti6SIudtTQ8g UTOxYhZfzoFj9fFdP812G64AYFo2HWvt646mvXb4dr5muDFV
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Allow triggering both zero-scale and full-scale calibration via sysfs in
the same way as it's done for ad7173.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 140 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 382f46ff2b51..019d1d3245e7 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2018 Analog Devices Inc.
  */
+
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
@@ -181,6 +182,7 @@ struct ad7124_channel {
 	struct ad7124_channel_config cfg;
 	unsigned int ain;
 	unsigned int slot;
+	u8 syscalib_mode;
 };
 
 struct ad7124_state {
@@ -202,23 +204,6 @@ struct ad7124_state {
 	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
 };
 
-static const struct iio_chan_spec ad7124_channel_template = {
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.differential = 1,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
-	.scan_type = {
-		.sign = 'u',
-		.realbits = 24,
-		.storagebits = 32,
-		.endianness = IIO_BE,
-	},
-};
-
 static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
 	[ID_AD7124_4] = {
 		.name = "ad7124-4",
@@ -903,6 +888,127 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
+enum {
+	AD7124_SYSCALIB_ZERO_SCALE,
+	AD7124_SYSCALIB_FULL_SCALE,
+};
+
+static ssize_t ad7124_write_syscalib(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	struct ad7124_channel *ch = &st->channels[chan->channel];
+	struct device *dev = &st->sd.spi->dev;
+	bool sys_calib;
+	int ret, mode;
+
+	ret = kstrtobool(buf, &sys_calib);
+	if (ret)
+		return ret;
+
+	if (!sys_calib)
+		return len;
+
+	mode = ch->syscalib_mode;
+	if (mode == AD7124_SYSCALIB_ZERO_SCALE) {
+		ch->cfg.calibration_offset = 0x800000;
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_ZERO,
+				      chan->address);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3,
+				     &ch->cfg.calibration_offset);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
+			chan->channel, ch->cfg.calibration_offset);
+	} else {
+		ch->cfg.calibration_gain = st->gain_default;
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_FULL,
+				      chan->address);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3,
+				     &ch->cfg.calibration_gain);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
+			chan->channel, ch->cfg.calibration_gain);
+	}
+
+	return len;
+}
+
+static const char * const ad7124_syscalib_modes[] = {
+	[AD7124_SYSCALIB_ZERO_SCALE] = "zero_scale",
+	[AD7124_SYSCALIB_FULL_SCALE] = "full_scale",
+};
+
+static int ad7124_set_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int mode)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	st->channels[chan->channel].syscalib_mode = mode;
+
+	return 0;
+}
+
+static int ad7124_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	return st->channels[chan->channel].syscalib_mode;
+}
+
+static const struct iio_enum ad7124_syscalib_mode_enum = {
+	.items = ad7124_syscalib_modes,
+	.num_items = ARRAY_SIZE(ad7124_syscalib_modes),
+	.set = ad7124_set_syscalib_mode,
+	.get = ad7124_get_syscalib_mode
+};
+
+static const struct iio_chan_spec_ext_info ad7124_calibsys_ext_info[] = {
+	{
+		.name = "sys_calibration",
+		.write = ad7124_write_syscalib,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
+		 &ad7124_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
+			   &ad7124_syscalib_mode_enum),
+	{ }
+};
+
+static const struct iio_chan_spec ad7124_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+	.ext_info = ad7124_calibsys_ext_info,
+};
+
 /*
  * Input specifiers 8 - 15 are explicitly reserved for ad7124-4
  * while they are fine for ad7124-8. Values above 31 don't fit
-- 
2.47.1


