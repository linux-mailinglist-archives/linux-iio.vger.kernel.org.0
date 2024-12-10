Return-Path: <linux-iio+bounces-13312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F41449EAE9A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 11:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02632168D0E
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB52080D2;
	Tue, 10 Dec 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i1MEovWR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C9225404
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827615; cv=none; b=gNue5GM8iNZ8HIu+nH8TR1W3b7exX+hcBW/HV92JGhS9v/nPDWiemUk8J3rXQrDeGPDAL1seY7dUGMctrzi40DmkRK6nkWDYuFKWWVy6m0+ZeJYwMQWI+rGOv9JVAECXxxit8HLfWLuSn8CSQ+iMeVr1/qs5BvtuUncJ2lsZ/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827615; c=relaxed/simple;
	bh=PAZUr7a+ezpER6BWIGM0HmPI8Y0j/PqczoFzw8Wo+qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqrzIQQBpzm3V57ZRu0aXgGTxYUdTWz9rdr8cTXiC8z480Lpousq7E3t5r5vh5v656fMCw4daEuztdb6TqkXLEh/zIEn3kEadKHS4IyFbUT3XMHPuFr+uePHNc6Q7q8CKCVaJDloY/AOAcEkAy/fEeK1//G0d135p/R5SUKbio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i1MEovWR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso58655345e9.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827610; x=1734432410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zS7bDnBIXc1XbajUH0e34PDE/9IXO9owi8ldrmoQCBA=;
        b=i1MEovWRUAZFuecW/vXXw1XsSUZI2XhC8FrR56XZ+iMl33HHscygwZXVfdswQMJDhI
         PPk1KmsHpjwo2aePzmERYSyzX7hwyrAtOeQ4XbZ+xcTsgpKDVmys0ZBvDXTQTXSkdFLb
         PR1kHPJD5GPPiteSbnZhw2H9Ar9Pk3RwK49V+6vlXu/AePVOOXRREg8qmOV3y5cf7drn
         giywqa2jo79drVs/UZES+apdbdXDgvwrP03i2cfZiEEMSSoeP2MfWHe7IOMLtr5Lb3XX
         UWKwHfzhMiXuYFzO0NLiJ8BjDABeW5vR4Z4uVnSq6teUeH7KCI9NcDM701jEVKCNHpRM
         uDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827610; x=1734432410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zS7bDnBIXc1XbajUH0e34PDE/9IXO9owi8ldrmoQCBA=;
        b=WkFNiAO87JZj6cNwT5IIfiDhFZ1xh1X9LaKazkC7uqQGY2h7ZwWUuFsya4Y/Za0Vcx
         zPzmjcLFlAoG5iNYLC1G1p+nyRnboNvJ4KpFZgKB0qG4BuQHBmfFYzEdpB+tDcAQ3w5n
         ov1cJ3gOQ2u1OH1st5TNcr0jZ9W9suTLKIF/CmUK0Sc++btnwTH/1MmHzKOe3Wushtw+
         3BJAmdq31urDkM2DpDy6LgACLI/8MLJzU3xJKgtBsQ0V4S0vFR1AqmCsgQomuHczcqbJ
         tcGVVuormFRKCVhLZB1frqxljRQcK5gxTod8V3bahIhdP+JR1Psy2S6S7T5wp+C4gW+q
         UDvg==
X-Forwarded-Encrypted: i=1; AJvYcCWzRzxpeMmP1FSs4RdI4SIeaTtI0ZgFGWAjgXb2Jr+ImnZgLbFct70Dd6vy0wY0HbgPp/END/LIkpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymk/gmPuowpwIYEtyZsSZtRU2JDCkcKrftYJ8cl28HcO9YTw3b
	0VoGJPfPY4dKhs0cKbGSEc8iZj0mh/hSjo+wLYi8n19SqAH1w9wCh8p6joWtd0Y=
X-Gm-Gg: ASbGnctuVXkLiFJpfGsvP7YoI6cdqkzKfj0QnmgVriUszm/foy/UDO6uj3UUYW2P80A
	o6aVzV/ygNBRlJm9qXzHRNan4GS7dniHFemUnD+L4YK/L85kZLlStDO339qumZk4Qc/9wgfllvO
	m4EMsZWvAN5ZA+h6CC6RLtgIJGOgOUIGJBiOFGGkv1YInMmOcEVaUZLZL9xn/V9Imv9A2KiaDUT
	zivJoett6qn54H8Hrx15ga6YMzrL5X4kp7reUuqMhiVBEwQOwt6KR54IZ/IcJxkwn/mFgd3yjfR
	/w==
X-Google-Smtp-Source: AGHT+IErUWuwfo5H1WVWOPSTJH6re7psmDspkRZ3yRwkYgbYIm27zEDTEsRUDVHsRNtWWVPqtuEwww==
X-Received: by 2002:a05:600c:1c17:b0:436:18e5:6917 with SMTP id 5b1f17b1804b1-43618e56a03mr6776415e9.0.1733827610112;
        Tue, 10 Dec 2024 02:46:50 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:49 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:47 +0000
Subject: [PATCH v2 7/9] iio: adc: ad7606: change r/w_register signature
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-7-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=6288;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=PAZUr7a+ezpER6BWIGM0HmPI8Y0j/PqczoFzw8Wo+qI=;
 b=kGl0VZMMI642Noohf4u4Y7XOae6Zv5MSFH9dcnaX5h9+6gDm+tHjOm2bAAP8SwyXR0wa1nCt3
 Q2U3oJSTfsaC9ovJtp2720O1kI/dkHNn13DHvyckc/HhRdO3Xj2Mr81
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

The register read/write with IIO backend will require to claim the
direct mode, and doing so requires passing the corresponding iio_dev
structure.
So we need to modify the function signature to pass the iio_dev
structure.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 25 +++++++++++--------------
 drivers/iio/adc/ad7606.h     |  8 ++++----
 drivers/iio/adc/ad7606_spi.c | 10 +++++-----
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 2f13b9cd2ed2..bf1f84367c72 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -574,13 +574,13 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	if (readval) {
-		ret = st->bops->reg_read(st, reg);
+		ret = st->bops->reg_read(indio_dev, reg);
 		if (ret < 0)
 			return ret;
 		*readval = ret;
 		return 0;
 	} else {
-		return st->bops->reg_write(st, reg, writeval);
+		return st->bops->reg_write(indio_dev, reg, writeval);
 	}
 }
 
@@ -1148,26 +1148,26 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static int ad7606_write_mask(struct ad7606_state *st,
+static int ad7606_write_mask(struct iio_dev *indio_dev,
 			     unsigned int addr,
 			     unsigned long mask,
 			     unsigned int val)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	int readval;
 
-	readval = st->bops->reg_read(st, addr);
+	readval = st->bops->reg_read(indio_dev, addr);
 	if (readval < 0)
 		return readval;
 
 	readval &= ~mask;
 	readval |= val;
 
-	return st->bops->reg_write(st, addr, readval);
+	return st->bops->reg_write(indio_dev, addr, readval);
 }
 
 static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 {
-	struct ad7606_state *st = iio_priv(indio_dev);
 	unsigned int ch_addr, mode, ch_index;
 
 	/*
@@ -1189,23 +1189,20 @@ static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
 	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
 
-	return ad7606_write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
+	return ad7606_write_mask(indio_dev, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
 				     mode);
 }
 
 static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
 {
-	struct ad7606_state *st = iio_priv(indio_dev);
 
-	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+	return ad7606_write_mask(indio_dev, AD7616_CONFIGURATION_REGISTER,
 				     AD7616_OS_MASK, val << 2);
 }
 
 static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
 {
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	return ad7606_write_mask(st,
+	return ad7606_write_mask(indio_dev,
 				 AD7606_RANGE_CH_ADDR(ch),
 				 AD7606_RANGE_CH_MSK(ch),
 				 AD7606_RANGE_CH_MODE(ch, val));
@@ -1215,7 +1212,7 @@ static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	return st->bops->reg_write(st, AD7606_OS_MODE, val);
+	return st->bops->reg_write(indio_dev, AD7606_OS_MODE, val);
 }
 
 static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
@@ -1236,7 +1233,7 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	/* Activate Burst mode and SEQEN MODE */
-	return ad7606_write_mask(st,
+	return ad7606_write_mask(indio_dev,
 			      AD7616_CONFIGURATION_REGISTER,
 			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
 			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 7a044b499cfe..eca7ea99e24d 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -235,10 +235,10 @@ struct ad7606_bus_ops {
 	int (*iio_backend_config)(struct device *dev, struct iio_dev *indio_dev);
 	int (*read_block)(struct device *dev, int num, void *data);
 	int (*sw_mode_config)(struct iio_dev *indio_dev);
-	int (*reg_read)(struct ad7606_state *st, unsigned int addr);
-	int (*reg_write)(struct ad7606_state *st,
-				unsigned int addr,
-				unsigned int val);
+	int (*reg_read)(struct iio_dev *indio_dev, unsigned int addr);
+	int (*reg_write)(struct iio_dev *indio_dev,
+			 unsigned int addr,
+			 unsigned int val);
 	int (*update_scan_mode)(struct iio_dev *indio_dev, const unsigned long *scan_mask);
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index e08563dd1108..15bfa7a427d9 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -124,8 +124,9 @@ static int ad7606_spi_read_block18to32(struct device *dev,
 	return spi_sync_transfer(spi, &xfer, 1);
 }
 
-static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
+static int ad7606_spi_reg_read(struct iio_dev *indio_dev, unsigned int addr)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct spi_device *spi = to_spi_device(st->dev);
 	struct spi_transfer t[] = {
 		{
@@ -148,10 +149,11 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 	return be16_to_cpu(st->d16[1]);
 }
 
-static int ad7606_spi_reg_write(struct ad7606_state *st,
+static int ad7606_spi_reg_write(struct iio_dev *indio_dev,
 				unsigned int addr,
 				unsigned int val)
 {
+	struct ad7606_state *st = iio_priv(indio_dev);
 	struct spi_device *spi = to_spi_device(st->dev);
 
 	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
@@ -162,8 +164,6 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
 
 static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 {
-	struct ad7606_state *st = iio_priv(indio_dev);
-
 	/*
 	 * Scale can be configured individually for each channel
 	 * in software mode.
@@ -178,7 +178,7 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	/* Configure device spi to output on a single channel */
-	st->bops->reg_write(st,
+	st->bops->reg_write(indio_dev,
 			    AD7606_CONFIGURATION_REGISTER,
 			    AD7606_SINGLE_DOUT);
 

-- 
2.34.1


