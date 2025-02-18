Return-Path: <linux-iio+bounces-15746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93CA3A5AA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 19:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAFE81697BE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638D71EB5C4;
	Tue, 18 Feb 2025 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dLaLMVeY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16412356CE
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903503; cv=none; b=dNcuWa3riFaXXENvPskUyWrAGrco+5XRYFZGgrfKMv5KTicYFfMjCbAabOkr72f/cl+1wXnoWWs+9RoFLyYe3PFulow0trx6uZ2j4GedSeTyhpki/CwPHIXK2pYzxS4s40MxuCB0zcai29YmBQ91/ZAgSbjkW8olnUPj/y2vIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903503; c=relaxed/simple;
	bh=JgC+G8ktSpz9khYBXPEB3Dhnohq+QNNcX3cLh+JMWuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7mq3qKJOUlVFB2fVbM1w6dcLsxAFI3zcO7TA5l2oEqqI2yuFRCJFuu63hVFoDpQvr00d8Q6RjOLQy7PxxLt+4xtmbsRNnsFna/wR38vK+2sM880zhve1Tctsu2Fr7In39ltnTPJs6S6vZnUpcikigEu0FZvBCTIVp+rvnP5U1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dLaLMVeY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso16296935e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739903499; x=1740508299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddVYotV8Z3I4+l1sq9NABsbVhAoFcE9SbB2JMpNwSnM=;
        b=dLaLMVeYE7SoqKixZ8VxvveR4+h5HUTRbgZhALYqsglCd9CY8/NRgmDjkdBqiSHryS
         9r0rStPBjQRMumo9RMPucv/03drmjToFTn6avL5vBvJs1/LEqgbQD3hI067kjgn2W+i2
         hx/8zrWMO6WKAsamvzixDF87MxYuMwgx4MEbYSdMe6rvnmK6ucGXWynqFxZAw5UAfhY1
         aEty64GSO6G8NfYxBFAgMFR2vSq88E7ecei4RIv3LZnjJQW3L0rQylZaverYkKWoVOCR
         4Dt/eGlpAgCaSiShywxQaYr2J6pe211XxFfNEVm9PJsesB1DUSGDyMqFk1j956CMKHA/
         /KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739903499; x=1740508299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddVYotV8Z3I4+l1sq9NABsbVhAoFcE9SbB2JMpNwSnM=;
        b=xUqj3H2UFTUJyiPJ+9+PSXxFzEAaGEQBD77KRv2843oaeL7dfbX+Q1UT4B1ZLgT043
         Ilg6jGMGJ5O4sNiMGrgtUVfoML9GGhZePWzNPQMHM+DE8hTwkP2P8sGUoW7LwjEXksou
         cSN1NSZrOtiubgRCOjUuIEaR62HHRdSmooUHLteSd/EKpfaCkJfvSCUIQlN6LS9gisgT
         lAghJAY2af6VRivs7PGkUEqr9HJLNAGOP1TS9rESmoH4V0c7wyObZOiIH2vVnnJGo/60
         25CAomz6Irod3xy01f+meBARVKekBqg8PB8D3/jTdyfAQCUpP7D8mcSgYvJs0PRdSjjr
         8qzw==
X-Gm-Message-State: AOJu0YwKpCEpTktrVtSF9HiTxK/iTgenUH0rIsAhTAjUBr75dJckn1/M
	0uuixaSAFdkt9q28VHPmnyegyIsqjRKizUgTtigsj1XLOXYOWh+iC8XC3JCQu6g=
X-Gm-Gg: ASbGnct2k07QwiVlKK2ibpmVuE4RgYcOv+GVCzXtwy5MLIWKe0IgpNwiOi99ctDR4lW
	ati1R6rZ5b43HpL9Vl2qEQp4uicr87EpLPsg5SsS1hTsQwDGNrCgazuL2Uweytzii/YHWncQDcB
	Fm4lErPincbWP7B9tEOK8UZVmJpc+gpbtZfeODVPz+6YtkwUy+lowP5VFwpFBCauqzuQRNyvpaU
	PLGHr8AvTgsJfNpjFdD9XpcYPxgH1wE3b8pBJq8uKzSbpNDTPg2SYITXu3qFlzO7yuTczdowXyN
	0UCHXnajodGlADVGC20ucHmeAtE2MmfXtF+82KE2bHtZNPZ6ikKK0agsEg==
X-Google-Smtp-Source: AGHT+IHsDXubScbtfd8GgSoO6cX+WZ3NdPewfCRB5+VEvsg2COHHD6x2qxQCztnGJkft2EjJlaCvAA==
X-Received: by 2002:a05:600c:1c90:b0:439:96b2:e8f with SMTP id 5b1f17b1804b1-43999ddb0f4mr6856055e9.28.1739903499086;
        Tue, 18 Feb 2025 10:31:39 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fc885sm157248675e9.9.2025.02.18.10.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 10:31:38 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 6/6] iio: adc: ad7124: Implement system calibration
Date: Tue, 18 Feb 2025 19:31:13 +0100
Message-ID:  <5ee955a72e6f5226233053a883e8897ae325b568.1739902968.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5115; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JgC+G8ktSpz9khYBXPEB3Dhnohq+QNNcX3cLh+JMWuo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBntNH6YlQqmjoWyzpLG78F/iWSxk4acEItxrcoy Ye4d51L4QeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ7TR+gAKCRCPgPtYfRL+ Ttn0CACffqcnR6BmWr7uHcHMsKfK/izbwMcrt32VQ4iiDTuj6l82dz+tdf2k6plZ0kI7FZwykN/ eqNC6micBPzUN9cLHcpD+RE8G9R7x9ubcg31399LnvClASMZvxjnvMEgZWUbJ+wgoTsh7VebUIX 1enAyyZmQKUG3xSRr4r7OuzIcI9U0IR1Qpa0NQfYFJqr2YoiFEYlyp5BQ6IE9FNboml3oOSSd1L bl4sITgJ/pi6txT+jJpjpO2qF1TlATwZietHacZR6ORgwjr2Nb6Dh13/MJLZVjAmOxXEwnihaoe 73tuF/owcabz3r7++o0MB0I2Zh7lkcvWOCqyc1zGugpvmJsA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Allow triggering both zero-scale and full-scale calibration via sysfs in
the same way as it's done for ad7173.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 141 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 124 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5c2e5a518af3..ad14503e9797 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -4,6 +4,9 @@
  *
  * Copyright 2018 Analog Devices Inc.
  */
+
+#define DEBUG
+
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
@@ -181,6 +184,7 @@ struct ad7124_channel {
 	struct ad7124_channel_config cfg;
 	unsigned int ain;
 	unsigned int slot;
+	u8 syscalib_mode;
 };
 
 struct ad7124_state {
@@ -202,23 +206,6 @@ struct ad7124_state {
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
@@ -903,6 +890,126 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
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
+	mode = ch->syscalib_mode;
+	if (sys_calib) {
+		if (mode == AD7124_SYSCALIB_ZERO_SCALE) {
+			ch->cfg.calibration_offset = 0x800000;
+
+			ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_ZERO,
+					      chan->address);
+			if (ret < 0)
+				return ret;
+
+			ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3,
+					     &ch->cfg.calibration_offset);
+			if (ret < 0)
+				return ret;
+
+			dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
+				chan->channel, ch->cfg.calibration_offset);
+		} else {
+			ch->cfg.calibration_gain = st->gain_default;
+
+			ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_FULL,
+					      chan->address);
+			if (ret < 0)
+				return ret;
+
+			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3,
+					     &ch->cfg.calibration_gain);
+			if (ret < 0)
+				return ret;
+
+			dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
+				chan->channel, ch->cfg.calibration_gain);
+		}
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


