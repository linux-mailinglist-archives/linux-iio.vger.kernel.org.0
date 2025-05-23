Return-Path: <linux-iio+bounces-19844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D7AC2BD9
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CE7A2215B
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B7220F52;
	Fri, 23 May 2025 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsCwVbCH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F52214229;
	Fri, 23 May 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039764; cv=none; b=Wqsqxj8WR4wa4/GQYFm4qYuWxwnBCORUAFuLL9qUmtWSMoKGwHOloQzZcOSzh244GGR2xGiL1t+JcXcyTgWsOIr75sD0uVl17pTsRiBieu++yYlVKKadwi7UZNmhm/igA7nGAAakJDqkeubCw3LO73VDOqdW5XWwUZQ0MsiOGWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039764; c=relaxed/simple;
	bh=NecO3JFuEmic8BscLOiya5sL4vRhOHcoWAbe/6+zC8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDiUQo8XUONXXhIiqCHNdz1IWhJ2i9VGmXBo0Xlkb/dtdghpHRp1U20OFnsoOoUlb+9lA95wyny4eMycyFEr4yErRxEXWBJl+pLnM+jTh/dxM6DZMOOw74+Ihh5HzyAOaELLhWXmzHJNi3SmDTtXKZLFX87pgIJsDrQ0RxSO3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsCwVbCH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so359665e9.3;
        Fri, 23 May 2025 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039760; x=1748644560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQ4temf/3j9JjiJsHPN98dHVnlgwO0QkVb9NxKUEvSs=;
        b=YsCwVbCHGKS55sRUeq49GHj9r4ifml2apzZ4c96GBY45YBG5l88bV+SNyp0w0NPL3d
         yh2UPkfW1i5WRA8jshiaJuqPIuaY/NvgQWZR5EYs3BkjZQhE9/FJOTz8KYMDJ4rcdMCX
         /ehQ44LymFGjhTfFvO4AuvEHcm/GVY5DYDb40n+3y0wD7RlopA0gjaT8/ZXRJ3RWWDMw
         0E4BzFRqTGMQXa81cyhqQ7U9DP/vSSP1atVzwT1Tnj1XaiaO0uXNG1xtT/eFIxEt/qWy
         GTjHVQSTHzWVrTqokAvOmz1l5BGX0MHBftGGS2LX3JhuvcMtmQiL+N2+Nt7pAvg0F8t8
         rx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039760; x=1748644560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQ4temf/3j9JjiJsHPN98dHVnlgwO0QkVb9NxKUEvSs=;
        b=uBk3ApOerPoWU3nzT9EEMDnvVyhra/uHYhX2+sD4ZJUxOAVCMp27m/OrTq2Yr2Tyj0
         /d4kHEM4xSV8KCN1LJYMSrmmGdUb6l33DRvv8oQCnJpOemP2UmUesWvFKUbkJB9RgC0F
         +cBO/DZrohr6MGe/HhYdwWh0DeWiMaaxNzdCC2MFWC/FUaLnTtagm5ESSaS8rhxkUsjK
         bQgozfe3swjd4WaG3TB4m6HqZCuthH8rJ1sAf7tzWgfcczhpcTA2GtoCdZMwN7Gh/fl6
         KRRLvPQmd8sBcA3HsvWHTlMm5Wtw/UVikRYIq5pNp1f34/6wX8HBnI0yicch20Pe/GWV
         rwfg==
X-Forwarded-Encrypted: i=1; AJvYcCUbmQCEALKBCBWo1GDLTyDjtbZZmu26aEy7G1l4MwJKWpYL5Z9qD9rBCovyoTzoTX3S3HNXhaZqUKFjZHfv@vger.kernel.org, AJvYcCV/miq1bcmG8ctJz+QqXRKRpWm2G1Vx3/0W3ZVywnCvPUEE3j1MC1hDLJ+2HT5OsiSCh1qTEAmz0Y8=@vger.kernel.org, AJvYcCVcWL4PzVYQyxzwv+/OhI76Fsj2L/VzN6jHoNAWvZeeHzlS3F1K3/ymGR8ivYOJji6ThXT5L2DH8Ast@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cJWQPgVON9fy9mQ0mBfS37iGfQXWaVcrTE1eoOnmk2bvU2eG
	ikgCDA3JTgRwtFzTEg+JRxcADrFJB6A2z4rtqKm+u6UqYrGnxNZ/9cec
X-Gm-Gg: ASbGnctOGTYEoqJhqoB93vAswlR3pVGqO9DVW1woVNYFfJ9yVsYwC+aCxPi0iMEmQ4b
	l3gsVsNBqwUEDRLviH+LjJjYDnYbA0LLTba/p6J9TMAgBQ9vT/xhTq0l3lFJYtg1/bWI5uKGa36
	R4wvFr6SHbjooqvfawtZDEWtGBwHnSXNIzjf5AMypTvrghyJ2vl6jApZE0Pxjuh6mZRQ106mhwl
	0kOIyo8AWPF1JE4Q7MYc9mG8fpQs9kbckborQw9B/aMV+g/0e31tqscHWtFqOIpmFeTKHK3Ws9k
	Tt8Cl83yku3vte4YRA9r81c2qvflQcZtEMgEW66TpjSQImQgYwMPJb2/ENc62S8fjp13bFAG/wB
	wxVUW3FWk/qNignh4JWsAnA==
X-Google-Smtp-Source: AGHT+IF2RjTWMt91tvXX4ur7GaJKQFttqvFFTe6cxM3B0k3ztJOAsSC4Lhn3nlhtQhJDn1kAmX6YXQ==
X-Received: by 2002:a05:600c:1547:b0:439:9909:c785 with SMTP id 5b1f17b1804b1-44c935dd918mr2078895e9.7.1748039760428;
        Fri, 23 May 2025 15:36:00 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:36:00 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/12] iio: accel: adxl313: add FIFO watermark
Date: Fri, 23 May 2025 22:35:19 +0000
Message-Id: <20250523223523.35218-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 63 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 9cdad55dd350..8c68cff7569c 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -87,6 +87,7 @@ struct adxl313_data {
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
 	int irq;
+	u8 watermark;
 	u8 fifo_mode;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
 	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 1e085f0c61a0..80991cd9bd79 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -373,6 +373,25 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	const unsigned int fifo_mask = 0x1f, interrupt_mask = 0x02;
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
+				  interrupt_mask, ADXL313_INT_WATERMARK);
+}
+
 static int adxl313_get_samples(struct adxl313_data *data)
 {
 	unsigned int regval = 0;
@@ -399,6 +418,7 @@ static int adxl313_set_fifo(struct adxl313_data *data)
 		return ret;
 
 	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_SAMPLES_MSK,	data->watermark) |
 			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, data->fifo_mode));
 
 	return adxl313_set_measure_en(data, true);
@@ -471,6 +491,39 @@ static const struct iio_buffer_setup_ops adxl313_buffer_ops = {
 	.predisable = adxl313_buffer_predisable,
 };
 
+static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int i;
+	int ret;
+
+	ret = adxl313_fifo_transfer(data, samples);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ADXL313_NUM_AXIS * samples; i += ADXL313_NUM_AXIS)
+		iio_push_to_buffers(indio_dev, &data->fifo_buf[i]);
+
+	return 0;
+}
+
+static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	int samples;
+
+	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
+		samples = adxl313_get_samples(data);
+		if (samples < 0)
+			return samples;
+
+		return adxl313_fifo_push(indio_dev, samples);
+	}
+
+	/* Return error if no event data was pushed to the IIO channel. */
+	return -ENOENT;
+}
+
 static irqreturn_t adxl313_irq_handler(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -480,6 +533,15 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
 	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
+	if (adxl313_push_event(indio_dev, int_stat))
+		goto err;
+
+	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
+		goto err;
+
+	return IRQ_HANDLED;
+
+err:
 	adxl313_fifo_reset(data);
 
 	return IRQ_HANDLED;
@@ -499,6 +561,7 @@ static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
 };
 
-- 
2.39.5


