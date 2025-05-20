Return-Path: <linux-iio+bounces-19756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDBBABE798
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE03B3E63
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E4264A61;
	Tue, 20 May 2025 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMJTt7uP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CD2638A3;
	Tue, 20 May 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781449; cv=none; b=c+XyniLgv1jilwcYg5/+3xB2KilJNqCTsCaaqYximy997xAzwpv3csu5yCyZna7PpvJrv/jW97MXbvT1+92Dx+Uk2yfEZ09qPMISiHq++RZoGYNo1fJHIgvlpYiJJBcp/GB22G7ZJApn+E7ycgv3kWtzcIVlfcKjdUDD/VylS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781449; c=relaxed/simple;
	bh=E8nZYtMiGIQXzmi2NZf1Z9G9XfSuee66D/J2QgUjuCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+pHsJHKLQePXHnouLSMP+9iFKZQjnACuPy034POQ/1oDYi7EMAzannDapGqBh/VBi42inrrdcV66ZaQe5CQtW/WZs5OSWGWqY06GxkveJd1T9iDSNz1VVybvs13A8H1QTL61cbKPhvQkAgNv4aHz+D0pl+ivGZK4zzdPlpLZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMJTt7uP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a361a54454so649479f8f.0;
        Tue, 20 May 2025 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781446; x=1748386246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaVT5zfa4Wh1lZnEIAwbrexrBFPYh9qTrfig/Lxs2Ak=;
        b=hMJTt7uPoKcJhOvcFueU7W8VCodSAo7QAFZy+Jn3lf8h8uP/3XzXpLhYQGnDBKu+Td
         KiiGRzyJq4LUnyKmzM+Z2CAHGCIDlAC9zNUkFCa1ZrqGm2VqBKUW1UK91kP92A0AlfDe
         9lq/PaZSMUG1ssAYzJTD9PYt6dcx7FSadggl/gpL20IFQhU+OAL8AReJWkUv6MPUffE6
         byuVrbWMZcANy2iNsbePyHa+VvX098KVMnMdJ/fVC5Cm+AQQ+DT7AOMCXlnrOcgtVS4r
         NxB9QUwphBhXV0gN+YK4u52b4FH2qOEq3M0Hoda94cemINnkV8fhs9dbtfLmmrvZ/3Ak
         jniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781446; x=1748386246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaVT5zfa4Wh1lZnEIAwbrexrBFPYh9qTrfig/Lxs2Ak=;
        b=dwMzqsypVVpRehu+VnVCxD8C5lDMBbT9H/neh4u+p3Q3KiU21bXNkBAD0K4mC4Unww
         4t3ugawQ1cYVBiGeM9e9h1+6/LoRT2GT9hKJjRNn0NEaUgM23+BbY8zbESAPbgBBTCuU
         8AcclMCJEzxQzGLbAXHvn/2WDL2WGojkD+iYIi5ZR9jFKdQwFwbrqjtHj+dVj4wngo77
         zxOwo1IB26SiUTxdGuf3NyC2LH00+6Do+ASzAo91uYY6qpKtvgKy+EXWNC0fkVTH/D64
         Tp/U0or6It4MTD/COzua2ZoQkoavFsozIeSgakv/2P8v2u13kq/r3el5/W7qbeIcbmua
         NZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYy0ttS6Qa88V0RrHXIkTw0I3TtZ7DQmhaCNUlFTDb9UgP+ue7h7j3dofDULFeCsv5+LKjQx0EcVj1LO7I@vger.kernel.org, AJvYcCXl6yn6K/0FZlUDIR+1vGdiDY4R9/sJ+16yaILLBNAT0z6DaR+9hwW0VUnIKf5Re4ae0bb0d+YQmKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL925hHg0PWzIh3J4NPSsDNmsk7CeS2kQJyYaEOEXa9oA30GP+
	xCdZLQtYXzYXSPkVuHSCGd90QpUS5FwRQrZEMbu4FmZ7+eYyxq8lQ1Ny
X-Gm-Gg: ASbGncte1RVdNnKrJIyH62Ip8q2KH62cZnCemqICCTAClGqv4/TsOWL9khipaHDKI7c
	vKfZOQg3JDoW0cHw5UE+gPe+WUMg+fp4SKYHP4Wtv63rh53RS3ChRrqrntOU8IjBF8Mj6BZVNSt
	SzEiQ4RPEYC98krScSDPgvXKh/LSmM+vWtKZQ+L2cI5MQHC3BbOdOHJwpqxk1kYBoac7jUflQqS
	+HG937yLT1rsS7oGtc2iYnAxVmoRIlSudkMPsRbE5kY2Pje3i85fRmvL7Pjqex4xS/TCn1NoT1q
	cdM00LzV74GCP2Fbc/Z1F3eZyAaLKRIbuQXJq3Edl6XAGGjjC/eCSL0hNrFavvd/thwcvHlRRFW
	tNZMYR8O+neeq1Lbw48ifAA==
X-Google-Smtp-Source: AGHT+IGQLglm5GNjJvFCgL/jLdH+vCy9udH/8YHX0ObA1O9MeTDwCFu5yjKxR0fHd2QPIp9VQYsBBA==
X-Received: by 2002:a05:6000:1862:b0:3a3:6273:7ff6 with SMTP id ffacd0b85a97d-3a362738378mr5311754f8f.11.1747781445677;
        Tue, 20 May 2025 15:50:45 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/12] iio: accel: adxl313: add FIFO watermark
Date: Tue, 20 May 2025 22:50:03 +0000
Message-Id: <20250520225007.10990-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 59 ++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 8eecd2851512..da89e13a100d 100644
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
@@ -400,6 +419,7 @@ static int adxl313_set_fifo(struct adxl313_data *data)
 		return ret;
 
 	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+			   FIELD_PREP(ADXL313_REG_FIFO_CTL_SAMPLES_MSK,	data->watermark) |
 			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK, data->fifo_mode));
 
 	return adxl313_set_measure_en(data, true);
@@ -465,6 +485,41 @@ static const struct iio_buffer_setup_ops adxl313_buffer_ops = {
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
@@ -474,6 +529,9 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
 	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
+	if (adxl313_push_event(indio_dev, int_stat))
+		goto err;
+
 	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
 		goto err;
 
@@ -498,6 +556,7 @@ static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
 };
 
-- 
2.39.5


