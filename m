Return-Path: <linux-iio+bounces-19406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C014AB251A
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 21:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B547A2C25
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31DE231855;
	Sat, 10 May 2025 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGnRfQsI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0B19AD90;
	Sat, 10 May 2025 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746904112; cv=none; b=JJNtNBoS57bIHQicvKHWl/9gaQ7bLprIhLfVgwyUeHZk4W4UbH67H/fg1ArIXCeABsv7T/7+5WSmZtOthMbfLtMPWmh9hzKwFZIzPyLv8vLQAgZ1uv/7iEHldcNp5EYZcLXnCvbxxWmhkiRI3qvyMqZFq301PFtvssnZywV2LMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746904112; c=relaxed/simple;
	bh=EO9cYOLbvGQzW0Es1+miZLmHc5qRlhqiMENJJZB6Jd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bug2HCNOl1VqeH4ieFjSqjwutqJyv/U7/56sL4QktsZNPLPzCVQ/zOV4aQJt2Dh/yCLIlpQYTGQlF3dlni32RGb/1KNjI82vz+f+F9Qznv0nn3jhWp/gEpHt5nCBw8xGKPD7Y3F+ljQzvSRdmeRLaivVvbtRuGSDE1OWG0CP5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGnRfQsI; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5259327a93bso1084576e0c.2;
        Sat, 10 May 2025 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746904109; x=1747508909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0dTkO49Od1G8cOZBN3Rb45nLlEOmuetsbdI++B0wG8=;
        b=hGnRfQsIFp7W2VWzqTllV7NWZHrdHNGcuSWx7lKYX7pIf6zsZzJkmww1lDNx6Voa4b
         r5UNTGmaOCJh1+307z2hlCyrABhBTN6xDW3Ab4yCYtdrSuQs7ASARh4NYJzocMExghHj
         Zz5bAOY7xQf5FIFJ/N9DN6jrA7Xd0uRMq3TJKML983abVDXXG24L5hzd0nZpdAajrzOk
         TTAl0HtP9aQV1x7ue4XAJuNWu7kNVM620uyePPqzWKQK+KbHtkYayKnSscX2pBzGBqI4
         G/QB58c2kGdWE18eiwa12lql5uoJvsedlOasRk/Q9xseO4cnaS9AEh1SvyPhhIV+xv9o
         ulGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746904109; x=1747508909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0dTkO49Od1G8cOZBN3Rb45nLlEOmuetsbdI++B0wG8=;
        b=jnPbFkPAxMq+cwp1/kIcNOMk8qMuIlh2/EERawFsv6oG1AcPo3zmrX1H8ItkcN28nY
         9G7W6vWetGWefq54U2vqY0PT+mjWNvcD10W/inbaP7XA7GpQpwVucfpXsGSniMA+Eu6A
         7ugLsfCH0v7Ka83a74T0S2Xg5TPd/LULzrZ6mpEdltxohfUm9JfwcbenZJUZElfJweMh
         bOJCOr/mIk5MXSgvJygHumf+mpC+eGh64HvF+NltN78J+bZRU1gEWO5CAylakXlESZN8
         yGd65G/zNwb64MoYEDL1AeroZDwVn1esVYO0glRfgzvmjovNOE21JQmti0wlCi7cFjgH
         7Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCUkuidKpnOKDBq6/odpgue/o4iFzf7eJp56Hknfp/zum6HGm1eJJjYDDtZCP8+NHkWn1tmkGJoxR4Q=@vger.kernel.org, AJvYcCXLdhW5hlqRktFdSbf4xXDHGW9gDPAfVSgztTnW2NcrLs/tu/jvD4TES+ds3yjMSXwCJPEOytpjjSa5BQdn@vger.kernel.org
X-Gm-Message-State: AOJu0YyitvEzAB78UT0oxljfhzHdCEP8PiLVlON9oBnUT5oE51RvMAtu
	8yaLOQHgCjlbAj0SCX36eXzDOLzZYN4UWxyJfnmGRYHZt6NU7Xla
X-Gm-Gg: ASbGnctOyWXikpP/KvadiIyy7gAEj23yn0CDIg9GuXQxQGmYks1QcyZogC1CbeSfpnb
	/RC3JkkJUIk1puRs0SxmnTX+wTfTJzJ8XhulUUk2d+PpgNrdlWkNhLP9Mo9hDRIGmWjJOhbxu/B
	3NiGmTQlsZ1Z1QPE4De5wlnejM3VrfSx7H3ERzq8nHRwUH7wYpTNjz5TEXh/Gn2ZVuhiZD84GiO
	xD/nqD3jKtP3jzGSeHup/cDNc4g7Ipsw+sUCcC3kwHzpGQbWlMNPm+qHQvnNON2V6jbJqenCtr3
	ZyOHYIfUS/sslF06q8ApTWcKmROH7lWvy39rlvISYebxXoetJX1VHEM=
X-Google-Smtp-Source: AGHT+IE8yXIo4lJaHiIjNnEqVomSbbiGRASmvU2yaPjSYqCuwGLyZpx1buyJn6lqUTlm1rMK86yv8A==
X-Received: by 2002:a05:6122:3d0d:b0:529:1a6a:cc35 with SMTP id 71dfb90a1353d-52c53c86c9fmr6917613e0c.6.1746904109388;
        Sat, 10 May 2025 12:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1002])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c5376000csm3211787e0c.28.2025.05.10.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 12:08:29 -0700 (PDT)
From: Andrew Ijano <andrew.ijano@gmail.com>
X-Google-Original-From: Andrew Ijano <andrew.lopes@alumni.usp.br>
To: jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: accel: sca3000: replace usages of internal read data helpers by spi helpers
Date: Sat, 10 May 2025 16:07:09 -0300
Message-ID: <20250510190759.23921-1-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove usages of sca3000_read_data() and sca3000_read_data_short()
functions, replacing it by spi_w8r8() and spi_w8r16() helpers. Just
one case that reads large buffers is left using an internal helper.

This is an old driver that was not making full use of the newer
infrastructure.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/sca3000.c | 169 +++++++++++++++---------------------
 1 file changed, 72 insertions(+), 97 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index aabe4491efd7..7794efc35970 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -281,10 +281,11 @@ static int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val)
 	return spi_write(st->us, st->tx, 2);
 }
 
-static int sca3000_read_data_short(struct sca3000_state *st,
-				   u8 reg_address_high,
-				   int len)
+static int sca3000_read_data(struct sca3000_state *st,
+			     u8 reg_address_high,
+			     int len)
 {
+	int ret;
 	struct spi_transfer xfer[2] = {
 		{
 			.len = 1,
@@ -296,7 +297,10 @@ static int sca3000_read_data_short(struct sca3000_state *st,
 	};
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
 
-	return spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		dev_err(&st->us->dev, "problem reading register\n");
+	return ret;
 }
 
 /**
@@ -309,11 +313,11 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_STATUS_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_STATUS_ADDR));
 	if (ret < 0)
 		return ret;
 
-	return !(st->rx[0] & SCA3000_LOCKED);
+	return !(ret & SCA3000_LOCKED);
 }
 
 /**
@@ -412,10 +416,8 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
-	if (ret)
-		goto error_ret;
-	return st->rx[0];
+
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_CTRL_DATA_ADDR));
 error_ret:
 	return ret;
 }
@@ -432,13 +434,13 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_REVID_ADDR));
 	if (ret < 0)
 		goto error_ret;
 	dev_info(&indio_dev->dev,
 		 "sca3000 revision major=%lu, minor=%lu\n",
-		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
-		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
+		 ret & SCA3000_REG_REVID_MAJOR_MASK,
+		 ret & SCA3000_REG_REVID_MINOR_MASK);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -575,10 +577,10 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
-	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
+	switch (SCA3000_REG_MODE_MODE_MASK & ret) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		*base_freq = info->measurement_mode_freq;
 		break;
@@ -665,13 +667,13 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 
 	/* mask bottom 2 bits - only ones that are relevant */
-	st->rx[0] &= SCA3000_REG_MODE_MODE_MASK;
-	switch (st->rx[0]) {
+	ret &= SCA3000_REG_MODE_MODE_MASK;
+	switch (ret) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		*val = st->info->measurement_mode_3db_freq;
 		return IIO_VAL_INT;
@@ -703,14 +705,14 @@ static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
 		mode = SCA3000_REG_MODE_MEAS_MODE_OP_2;
 	else
 		return -EINVAL;
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 
-	st->rx[0] &= ~SCA3000_REG_MODE_MODE_MASK;
-	st->rx[0] |= (mode & SCA3000_REG_MODE_MODE_MASK);
+	ret &= ~SCA3000_REG_MODE_MODE_MASK;
+	ret |= (mode & SCA3000_REG_MODE_MODE_MASK);
 
-	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, st->rx[0]);
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, ret);
 }
 
 static int sca3000_read_raw(struct iio_dev *indio_dev,
@@ -722,6 +724,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	u8 address;
+	__be16 raw_val;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -732,25 +735,24 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				return -EBUSY;
 			}
 			address = sca3000_addresses[chan->address][0];
-			ret = sca3000_read_data_short(st, address, 2);
+			ret = spi_w8r16(st->us, SCA3000_READ_REG(address));
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = sign_extend32(be16_to_cpup((__be16 *)st->rx) >>
-					     chan->scan_type.shift,
+			raw_val = (__be16) ret;
+			*val = sign_extend32(be16_to_cpu(raw_val) >> chan->scan_type.shift,
 					     chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
-			ret = sca3000_read_data_short(st,
-						      SCA3000_REG_TEMP_MSB_ADDR,
-						      2);
+			ret = spi_w8r16(st->us,
+						SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
 			}
-			*val = (be16_to_cpup((__be16 *)st->rx) >>
-				chan->scan_type.shift) &
+			raw_val = (__be16) ret;
+			*val = (be16_to_cpu(raw_val) >> chan->scan_type.shift) &
 				GENMASK(chan->scan_type.realbits - 1, 0);
 		}
 		mutex_unlock(&st->lock);
@@ -827,16 +829,15 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int len = 0, ret, val;
+	int len = 0, ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
-	val = st->rx[0];
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto error_ret;
 
-	switch (val & SCA3000_REG_MODE_MODE_MASK) {
+	switch (ret & SCA3000_REG_MODE_MODE_MASK) {
 	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		len += sprintf(buf + len, "%d %d %d\n",
 			       st->info->measurement_mode_freq,
@@ -969,32 +970,6 @@ static const struct attribute_group sca3000_attribute_group = {
 	.attrs = sca3000_attributes,
 };
 
-static int sca3000_read_data(struct sca3000_state *st,
-			     u8 reg_address_high,
-			     u8 *rx,
-			     int len)
-{
-	int ret;
-	struct spi_transfer xfer[2] = {
-		{
-			.len = 1,
-			.tx_buf = st->tx,
-		}, {
-			.len = len,
-			.rx_buf = rx,
-		}
-	};
-
-	st->tx[0] = SCA3000_READ_REG(reg_address_high);
-	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
-	if (ret) {
-		dev_err(&st->us->dev, "problem reading register\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 /**
  * sca3000_ring_int_process() - ring specific interrupt handling.
  * @val: Value of the interrupt status register.
@@ -1008,16 +983,15 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
-		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
-					      1);
+		ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
 		if (ret)
 			goto error_ret;
-		num_available = st->rx[0];
+		num_available = ret;
 		/*
 		 * num_available is the total number of samples available
 		 * i.e. number of time points * number of channels.
 		 */
-		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
+		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
 					num_available * 2);
 		if (ret)
 			goto error_ret;
@@ -1060,8 +1034,8 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * but ensures no interrupt is missed.
 	 */
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
-	val = st->rx[0];
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_STATUS_ADDR));
+	val = ret;
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto done;
@@ -1121,13 +1095,13 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
 
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
-		ret = !!(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT);
+		ret = !!(ret & SCA3000_REG_MODE_FREE_FALL_DETECT);
 		break;
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
@@ -1136,7 +1110,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		 * Motion detection mode cannot run at the same time as
 		 * acceleration data being read.
 		 */
-		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		if ((ret & SCA3000_REG_MODE_MODE_MASK)
 		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
 			ret = 0;
 		} else {
@@ -1164,20 +1138,20 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 
 	/* if off and should be on */
-	if (state && !(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
+	if (state && !(ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-					 st->rx[0] | SCA3000_REG_MODE_FREE_FALL_DETECT);
+					 ret | SCA3000_REG_MODE_FREE_FALL_DETECT);
 	/* if on and should be off */
-	else if (!state && (st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
+	if (!state && (ret & SCA3000_REG_MODE_FREE_FALL_DETECT))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-					 st->rx[0] & ~SCA3000_REG_MODE_FREE_FALL_DETECT);
-	else
-		return 0;
+					 ret & ~SCA3000_REG_MODE_FREE_FALL_DETECT);
+
+	return 0;
 }
 
 static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
@@ -1214,22 +1188,22 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
 	}
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		return ret;
 	/* if off and should be on */
 	if ((st->mo_det_use_count) &&
-	    ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+	    ((ret & SCA3000_REG_MODE_MODE_MASK)
 	     != SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-			(st->rx[0] & ~SCA3000_REG_MODE_MODE_MASK)
+			(ret & ~SCA3000_REG_MODE_MODE_MASK)
 			| SCA3000_REG_MODE_MEAS_MODE_MOT_DET);
 	/* if on and should be off */
 	else if (!(st->mo_det_use_count) &&
-		 ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		 ((ret & SCA3000_REG_MODE_MODE_MASK)
 		  == SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
 		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-			st->rx[0] & SCA3000_REG_MODE_MODE_MASK);
+			ret & SCA3000_REG_MODE_MODE_MASK);
 	else
 		return 0;
 }
@@ -1287,18 +1261,18 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
 	if (state) {
 		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
 		ret = sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
-			(st->rx[0] | SCA3000_REG_MODE_RING_BUF_ENABLE));
+			(ret | SCA3000_REG_MODE_RING_BUF_ENABLE));
 	} else
 		ret = sca3000_write_reg(st,
 			SCA3000_REG_MODE_ADDR,
-			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
+			(ret & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -1322,12 +1296,12 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	/* Enable the 50% full interrupt */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_unlock;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
-				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
+				ret | SCA3000_REG_INT_MASK_RING_HALF);
 	if (ret)
 		goto error_unlock;
 
@@ -1353,12 +1327,12 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	/* Disable the 50% full interrupt */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto unlock;
 	ret = sca3000_write_reg(st,
 				SCA3000_REG_INT_MASK_ADDR,
-				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
+				ret & ~SCA3000_REG_INT_MASK_RING_HALF);
 unlock:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -1383,7 +1357,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 
@@ -1409,7 +1383,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
@@ -1423,11 +1397,11 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
 	 * as that occurs in one of the example on the datasheet
 	 */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_MODE_ADDR));
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
-				(st->rx[0] & SCA3000_MODE_PROT_MASK));
+				ret & SCA3000_MODE_PROT_MASK);
 
 error_ret:
 	mutex_unlock(&st->lock);
@@ -1510,14 +1484,15 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = spi_w8r8(st->us, SCA3000_READ_REG(SCA3000_REG_INT_MASK_ADDR));
 	if (ret)
 		goto error_ret;
+
 	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
-				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-				   SCA3000_REG_INT_MASK_RING_HALF |
-				   SCA3000_REG_INT_MASK_ALL_INTS)));
+				ret &
+				~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+				  SCA3000_REG_INT_MASK_RING_HALF |
+				  SCA3000_REG_INT_MASK_ALL_INTS));
 error_ret:
 	mutex_unlock(&st->lock);
 	return ret;
-- 
2.49.0


