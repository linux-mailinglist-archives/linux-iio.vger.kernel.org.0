Return-Path: <linux-iio+bounces-12286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A969C95F3
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF834B2609B
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D11C3027;
	Thu, 14 Nov 2024 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m08286w5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C21C243C;
	Thu, 14 Nov 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625840; cv=none; b=eiuRf5K56SjT8llZvaIVcegpBXw/1Xxya98FBPdSNG7V+2Al0J8UvilSVGzrefrrVtJI2wAAiUC4mBAdHem0LkaWBlnquabn8TZHxmWvIG/Y8C0OqFWEVYrO6aYfy4Qzge3xN3ciISw7NbuCQJ7r5BcAK/QuhH+ZhFphQ2SOr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625840; c=relaxed/simple;
	bh=GtWePVG860SxLDAycMC+2V4CVWFP6S+iiM4qVAUho3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1FaGCi+uAhXZLQqjy+eyepOPCcpZEcsLmugLrxC9weSMXYZEDge3VDnI8hTqhvfAf3bBul7L5xsqpvaYUA0kMDugG7vyWFTgMqNX4IsMhtIL+vxl//c0qalU6LTripc672N+BzRMogzyqUzpSmnlodcTxV9lz48QSRhF+R+6ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m08286w5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d5231f71cso161242f8f.2;
        Thu, 14 Nov 2024 15:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625837; x=1732230637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP5cXLy2LL0l0G0KnSB+0lFPN9e6gBigDfbVNZI3xWY=;
        b=m08286w5ArmrWCDg1NBy+o+Q269+JDzt7B8rUXqFjexip+HIrsD/STMMfWNLwoqQ0u
         0GN7kESDfHKIl9R9a3lywiqKY4lTbvM9MDH0n87/hhu/CDjD+lRlk+VvI69iD0meI7dy
         2kHM7yteyTyXD7ZrLqIekyaRcgdVzVVnu7OSWcBM34vId2SsBlL5VGELTZ7YxNCTllAx
         YXVAA/ZTd3JES7d4kHnE4C0cbvfTmhcQs1Xx+GBXYgBcWu4goo9muaRRJe7TJFnSbj8f
         x0kbfEshJBEaZ1qb+zEvg2qVSRsZxtrEBYNkbLM8iOfq1n2ahn1tisSUj1XlfG+P/Rme
         GnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625837; x=1732230637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oP5cXLy2LL0l0G0KnSB+0lFPN9e6gBigDfbVNZI3xWY=;
        b=uSkT9ewubvwEZ1qmceCieQvdD/O7NVDMP8uJWBNNSaMzJglcOKR8YRivQi+8OGl/lQ
         9lhZxO2vpU66kPXT7QTccMc571wHE+xbtuXLKCzAI3+IIZwsPnvXyztLS8lYdZ1kk/K3
         ggjcR98fNQ+b0c7pVPR1fDbnE45LdqNBJtErq8McvEsyw9HPYnbTEtHSKcWJhBNso9o9
         9yALQ5P+uv8MYn4XC1P0OMTXp2UK/6Y3RqRnGaPvzL6Gopjhb9N0tSl54VA68HhZ/vXK
         M6Tz8zm+NUHXQGGnDDRuV7JrbH/m1KBHFxZ/CExFDCp7J1Ek9tVhEPNgMyZ2JL3JZQjj
         qiOg==
X-Forwarded-Encrypted: i=1; AJvYcCXAcUQSdQyx/AyDyyThC+Djelrtbkc4XDtuPhVTmt8zsLcVum5emzW/+AExPcABfLBepM7YhsR981SVVfLU@vger.kernel.org, AJvYcCXkz/gU4tlRUYREO0xYmMi7sETbtVBynPW2ZO10sL4eKxNvyRzdbkSPEbTO6D7bCvBa7SmSfdYhCos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwXE1UL4HPu2dvac6klNLavOvnZN7P7BGAQs/yUk+kkJ+UKomG
	uWjcSnw4ZWWi9Myg2v6efCxtcCJ9vLeU8DeAJ1ZeXnQNAd4eMvgj
X-Google-Smtp-Source: AGHT+IEid8nFGtPXGMNkKaJAjMqJogkHklne/CWbhxjp5u/iP30k9r+qlyzowRLjhI5qX8E5y5EoXg==
X-Received: by 2002:a05:600c:1c1f:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-432df790752mr1681865e9.7.1731625837305;
        Thu, 14 Nov 2024 15:10:37 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:36 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 18/22] iio: accel: adxl345: start measure at buffer en/disable
Date: Thu, 14 Nov 2024 23:09:58 +0000
Message-Id: <20241114231002.98595-19-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
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
index f686037df3..a5b2efa69e 100644
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
@@ -328,6 +350,41 @@ static const struct attribute_group adxl345_attrs_group = {
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
  * Read number of FIFO entries into *fifo_entries
  */
@@ -399,7 +456,50 @@ void adxl345_empty_fifo(struct adxl34x_state *st)
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
@@ -609,7 +709,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	indio_dev->channels = adxl34x_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);
 
@@ -669,9 +769,6 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
2.39.2


