Return-Path: <linux-iio+bounces-12361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00AF9D0525
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14E4282320
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8CB1DE4CB;
	Sun, 17 Nov 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STZ6xF92"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F461DE3A0;
	Sun, 17 Nov 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868117; cv=none; b=k/uBtUFyt7mvWgPTixxkek9tM3cvitgmhdhCjtHpS/CDPfcycEIk15swbi4THnvL2K/aRtEG9nmyK19NZ5mDke3EjhSJFz5HWdJLR+50qtDZHDh83YxPfrR25PgLD3MxFymrrU42cbZRPIntaPu94vAqpTBvWwQhWBqKv5TqwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868117; c=relaxed/simple;
	bh=Uh0ywoa2bWeGJVOO8oOQGygArU/+BUOqW+Ji8r6tx1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iR9gMtrilixYdjHEvHiB1rLOLnIryqrkWlfZF8Y5Rxzcxj5m6tqHwlPSlYd0nwXRorcBB+JNgAWiQFFKQiDpzamxpoyjVQLQ0ZJXNiUkAMRBzc4KJP814+cKz9WNZCXupSkVN18pT/IqHIFiq+Lr+Lw5OdwCxTwd9e1Ad8Wu6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STZ6xF92; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38242100504so60979f8f.1;
        Sun, 17 Nov 2024 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868114; x=1732472914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyKdvt/ICGRAgRqip6b9GeQ/e4pq/PhL8HJQ2mj2JdA=;
        b=STZ6xF92ydRJIEgynf+g5YYd1gLlDBj1SYaZvceDe9B+tWRrk+eVweAwEs7J6DDLCf
         FrImUCK2LNnTs5OltJSJEcEwiT+vYqleq717CG+5z9y0LIACyLyDqBWcr+SfoTe4G4k/
         /939Rn2RR+q691V3NG+aMRmhL1YLOLnGZisuPhtzmt9bNqXyF6j1Ij2DxW5fHfBuJld0
         XevpdwBAXexp1s2it74lqkdyljLO5iEwcF9l2Rhjm3rXsnVm2Z19iVkq5mO+N8jPWfWc
         6okycpQoAw52+Bbh0b4cYUaCQ0UoJDbja61nnIcSb5Tbcn2PsZzYrO3uNengC0I4D0NI
         vjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868114; x=1732472914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyKdvt/ICGRAgRqip6b9GeQ/e4pq/PhL8HJQ2mj2JdA=;
        b=hImjRisylzpRVkiht7bKqAiPQaFfhPsPyXVF6CQkyQPitsdyxNsqDfS0w9f2UfcMcZ
         HqZIPFNBBAGEHnKhiCaDjvdmLHloRvgH5+xPulyR6QEabBYUSuSPeLFipllgRUdFCTnI
         h/OYtRGyhAIvOAWJwWXqgBHAOPln3w8HR5O/YcWiQJ/1T8shTL7oPJBREEeRJhJv7w8L
         Y/pCG2vmy4Wt1VfDy8HR4ANNLYAAKCyqeoseFJQtM58AoRnu2r0T7GsdwPzQdOG4L7wG
         vfQNSn/RvGUxgaysObc8ATYBG1XVyR53IYawrTqrqow5hhS/4YRvQItn+uEGYZQWqGQK
         of/g==
X-Forwarded-Encrypted: i=1; AJvYcCUQbOZ+7LiuBI9lsIYLIaH+4sZtUIIy405cKH32XLXVM6cJULS0GNcC+tKWCOQdCFyDX9I7oFT3vAQZlkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9tvFldLS3L+iIsT6IwdWxNNGrrbYMjsX8fAkoLLckQtF+6OM
	i5lYuqLSP9pGcQ8Fp/w2Hu1yLa7IoR75Nm3B3cn5vE9bvWdWHP/q
X-Google-Smtp-Source: AGHT+IFZ5g4xBvWHfhoyu7iiS7c4kPCFddWHohSvEYyrOP9k4kQM3dLIHvRHlSdEfbFlSlqrnNujTg==
X-Received: by 2002:a05:6000:2ca:b0:382:42c3:83f7 with SMTP id ffacd0b85a97d-38242c385damr813764f8f.10.1731868114192;
        Sun, 17 Nov 2024 10:28:34 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:33 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 18/22] iio: accel: adxl345: start measure at buffer en/disable
Date: Sun, 17 Nov 2024 18:26:47 +0000
Message-Id: <20241117182651.115056-19-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241117182651.115056-1-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add and initialize the buffer options to use the FIFO and watermark
feature of the adxl345 sensor. In this way measure enable will happen
in at enabling the buffer.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 105 +++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index a653774db8..b57a123ac9 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -181,6 +181,28 @@ static const struct iio_chan_spec adxl34x_channels[] = {
 	ADXL34x_CHANNEL(2, chan_z, Z),
 };
 
+static int adxl345_set_interrupts(struct adxl34x_state *st)
+{
+	int ret;
+	unsigned int int_enable = st->int_map;
+	unsigned int int_map;
+
+	/* Any bits set to 0 in the INT map register send their respective
+	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
+	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+	 */
+	int_map = 0xFF & (st->intio ? st->int_map : ~st->int_map);
+	pr_debug("%s(): Setting INT_MAP 0x%02X\n", __func__, int_map);
+
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
+	if (ret)
+		return ret;
+
+	pr_debug("%s(): Setting INT_ENABLE 0x%02X\n", __func__, int_enable);
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
+	return ret;
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -330,6 +352,41 @@ static const struct attribute_group adxl345_attrs_group = {
 	.attrs = adxl345_attrs,
 };
 
+static int adxl345_set_fifo(struct adxl34x_state *st)
+{
+	struct adxl34x_platform_data *data = &st->data;
+	u8 fifo_ctl;
+	int ret;
+
+	/* FIFO should be configured while in standby mode */
+	adxl345_set_measure_en(st, false);
+
+	/* The watermark bit is set when the number of samples in FIFO
+	 * equals the value stored in the samples bits (register
+	 * FIFO_CTL). The watermark bit is cleared automatically when
+	 * FIFO is read, and the content returns to a value below the
+	 * value stored in the samples bits.
+	 */
+	fifo_ctl = 0x00 |
+		ADXL345_FIFO_CTL_SAMLPES(data->watermark) |
+		ADXL345_FIFO_CTL_TRIGGER(st->intio) |
+		ADXL345_FIFO_CTL_MODE(data->fifo_mode);
+
+	pr_debug("%s(): fifo_ctl 0x%02X\n", __func__, fifo_ctl);
+
+	/* The watermark bit is set when the number of samples in FIFO
+	 * equals the value stored in the samples bits (register
+	 * FIFO_CTL). The watermark bit is cleared automatically when
+	 * FIFO is read, and the content returns to a value below the
+	 * value stored in the samples bits.
+	 */
+	ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
+	if (ret < 0)
+		return ret;
+
+	return adxl345_set_measure_en(st, true);
+}
+
 /**
  * adxl345_get_fifo_entries() - Read number of FIFO entries into *fifo_entries.
  * @st: The initialized state instance of this driver.
@@ -416,7 +473,50 @@ static void adxl345_empty_fifo(struct adxl34x_state *st)
 	regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
 }
 
+static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	struct adxl34x_platform_data *data = &st->data;
+	int ret;
+
+	ret = adxl345_set_interrupts(st);
+	if (ret)
+		return -EINVAL;
+
+	/* Default to FIFO mode: STREAM, since it covers the general usage
+	 * and does not bypass the FIFO
+	 */
+	data->fifo_mode = ADXL_FIFO_STREAM;
+	adxl345_set_fifo(st);
+
+	return 0;
+}
+
+static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adxl34x_state *st = iio_priv(indio_dev);
+	struct adxl34x_platform_data *data = &st->data;
+	int ret;
+
+	/* Turn off interrupts */
+	st->int_map = 0x00;
+
+	ret = adxl345_set_interrupts(st);
+	if (ret) {
+		pr_warn("%s(): Failed to disable INTs\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Set FIFO mode: BYPASS, according to the situation */
+	data->fifo_mode = ADXL_FIFO_BYPASS;
+	adxl345_set_fifo(st);
+
+	return 0;
+}
+
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
+	.postenable = adxl345_buffer_postenable,
+	.predisable = adxl345_buffer_predisable,
 };
 
 static int adxl345_get_status(struct adxl34x_state *st, u8 *int_stat)
@@ -625,7 +725,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = adxl34x_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);
 
@@ -685,9 +785,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		ret = regmap_write(st->regmap, ADXL345_REG_FIFO_CTL, fifo_ctl);
 		if (ret < 0)
 			return ret;
-
-		/* Enable measurement mode */
-		adxl345_set_measure_en(st, true);
 	}
 	dev_dbg(dev, "Driver operational\n");
 	return devm_iio_device_register(dev, indio_dev);
-- 
2.39.5


