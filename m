Return-Path: <linux-iio+bounces-19623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F57ABAFCD
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677083B9429
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9521CC74;
	Sun, 18 May 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQlQXuW+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B221C9E9;
	Sun, 18 May 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566826; cv=none; b=oVJlyQsTcllcEfNjSYl6I4XQv7c/y0/80NuB+B2NGmT8rbtdccVZuGXIdoFuzF82LLO3O0fV1yPWTm2G8BUkBswIQKojfdxH+bW4vBJIoIbM0KXtRdMQfs++R9+6JFvWY8/+nPtJuJYnV+A7Yl9VyIZxayNFDp41kTkKl7oB0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566826; c=relaxed/simple;
	bh=327tO4x0rH+X3g/gHKdNSBjruWwiNG7QvaQ0kqdk4so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIbREmOuHY2tLHXiyqxC9/moyDmcVo16UnfsqECClcVpHi7FdBaBQzDSZYLllflb890soP3XRI7Lisz0c1HNvWDsyxhsMP3BX4SXJan/SsuN2ggG4sLUvrVM+ZHmDAC9DWQ8m8fRUqzw3v5E1HarddPKw92vhwdvrx2NSw3/dUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQlQXuW+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a364d442e0so243178f8f.2;
        Sun, 18 May 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566823; x=1748171623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FihB3JscRz6ypXfgmD+ATnY4gb1bgHVZpQTtp3zZsWY=;
        b=MQlQXuW+L+WAN+iJ5ruDYD7zvi18ptnfALV34NhODqyXkTemYw4oEU+qMnbVCRmiPq
         aB0SCw+oPwkn9ilbeDsNFL7lzE4CLDTy80ln3E0bq03+WZPYu7vDaA7lmEuhDHQyQa19
         OEZcdnIpefVSb54eUpKExCIGeAV5Xit3aO60yuI042BQuIM415FgPpvRM+D9TzT5rbQr
         cPCXiSpY/D7r13EcecP2VEntjws8VEHGFGyDI8Wf1rTrceMzE+y/UmpEfUMYfMCjRnTj
         ch4vNKz3r76ktuXdvuRW2tbjIFiY7USAfvbhIXj4zl1hycaFLICS0MPY3BK/vnLgAgC7
         SSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566823; x=1748171623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FihB3JscRz6ypXfgmD+ATnY4gb1bgHVZpQTtp3zZsWY=;
        b=AfGi78mLN9uKgDo1dAP9U9m1OxlgaEjk7ftDxkUB8tw0+Zd1ACjp7aBqB6bL/iDoib
         JIQ1wSk+nPIswuBb9B/wqz6BN3uAchxQvezYTm2Wb+EShk1abszu6bFFkgcVKh2phY91
         3e9khykEk5jy+wmudzGP6R2mg7zU/donR9KNHoIprbQfZHh4kX9hm/8cVVNtOTxa0XR/
         Qnz5ExnSMn27me6bOjrnsjBc9UHxuRQoOPf2LFn3t/dvH+uUtuxxnmdYefTdTozqgwFx
         cExCeAoTblkwF7Vdd72Mpq/xJEcgwFdEJM6uWOrNHDpnIp6hWwmbgTap7vx20QLazcbK
         JLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxV0LZP6VJRVxOo8PW2yVZw8Te7/CHcoBLpG+iUPC1CJa097NkThQ2iVvpMw6vqhm59aGKx1HWc2JUV4Oc@vger.kernel.org, AJvYcCVVGKcziWXKLxREt1FvQCBS+mjeHW2ZnsJ22QoyQxwijFMCgSko3d6tPGVFHxZQ20Jo2xNYhHqMHXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUEaCd01BdRovuQep2kYIahnvdbXBaWQHpyag9wt1TlvPk+i/
	EseKyG8bGkPurrMq2ILzvsR8HpUo/RJRX6hcCo/sh0flZsSJEkJgca7y
X-Gm-Gg: ASbGnctLE1IG//49Tt30BJV0bueu7KniCZYxNtjHgFmJbQAKN8sS4jM7hpnJoHcKqNu
	BivEp2Ii8LOhhptUXcOauL5/HiyUrOdK2+/yApUbLShsZQ8iv9izksd9eNWWcRae0OQPkDQ+UlQ
	eeioGVpA+ItV+87tgCG3/ayxC5WWCjWFCYJiczdye69BDGIsquSKf3ek7eknN2X7x867V4KBPKT
	a0DWQCTlao3T56eUCcZqpIn8y/KxHWreU99+szDB9deNVrQL6GXCMu6ANHHs/OYkZruNcmljedb
	9+fEcHs7K0xQRhKMphcjtr3Lakmxd/pm7madnwG9H78Ff+JT1eAEwc9rMuudBiRKtfhxqHtsIfh
	mCcW4d7jNcP6a+VAdIeEHuw==
X-Google-Smtp-Source: AGHT+IGyB2qguCzbtpCnaCPX/5k7Qt1JztjwA4Tml+i61NSCNMP6AKS3UI+c357TG/iaEhli/Xn9Jw==
X-Received: by 2002:a05:6000:184d:b0:3a0:75ff:2d94 with SMTP id ffacd0b85a97d-3a35c80b638mr3030713f8f.1.1747566823350;
        Sun, 18 May 2025 04:13:43 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:43 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 08/12] iio: accel: adxl313: add FIFO watermark
Date: Sun, 18 May 2025 11:13:17 +0000
Message-Id: <20250518111321.75226-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FIFO watermark configuration and evaluation. Let a watermark to be
configured. Evaluate the interrupt accordingly. Read out the FIFO content
and push the values to the IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  1 +
 drivers/iio/accel/adxl313_core.c | 60 ++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 4cb1fe1f2616..9c7aedf7da7a 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -89,6 +89,7 @@ struct adxl313_data {
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
 	int irq;
+	u8 watermark;
 	u8 fifo_mode;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
 	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 574962a8f35d..0a93af89ba19 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -374,6 +374,25 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	const unsigned int fifo_mask = 0x1f, watermark_mask  = 0x02;
+	int ret;
+
+	value = min(value, ADXL313_FIFO_SIZE - 1);
+
+	ret = regmap_update_bits(data->regmap, ADXL313_REG_FIFO_CTL,
+				 fifo_mask, value);
+	if (ret)
+		return ret;
+
+	data->watermark = value;
+
+	return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				  watermark_mask, ADXL313_INT_WATERMARK);
+}
+
 static int adxl313_get_samples(struct adxl313_data *data)
 {
 	unsigned int regval = 0;
@@ -400,6 +419,8 @@ static int adxl313_set_fifo(struct adxl313_data *data)
 		return ret;
 
 	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_SAMPLES_MSK,
+				      data->watermark) |
 			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK,
 				      data->fifo_mode));
 
@@ -467,6 +488,41 @@ static const struct iio_buffer_setup_ops adxl313_buffer_ops = {
 	.predisable = adxl313_buffer_predisable,
 };
 
+static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	if (samples <= 0)
+		return -EINVAL;
+
+	ret = adxl313_fifo_transfer(data, samples);
+	if (ret)
+		return ret;
+
+	for (i = 0; i  < ADXL313_NUM_AXIS * samples; i += ADXL313_NUM_AXIS)
+		iio_push_to_buffers(indio_dev, &data->fifo_buf[i]);
+
+	return 0;
+}
+
+static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	struct adxl313_data *data =  iio_priv(indio_dev);
+	int samples;
+	int ret = -ENOENT;
+
+	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
+		samples = adxl313_get_samples(data);
+		if (samples < 0)
+			return -EINVAL;
+
+		ret = adxl313_fifo_push(indio_dev, samples);
+	}
+
+	return ret;
+}
+
 static irqreturn_t adxl313_irq_handler(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -476,6 +532,9 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
 	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
+	if (adxl313_push_event(indio_dev, int_stat))
+		goto err;
+
 	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
 		goto err;
 
@@ -500,6 +559,7 @@ static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
 };
 
-- 
2.39.5


