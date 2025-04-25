Return-Path: <linux-iio+bounces-18676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77316A9D669
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 01:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5579E6828
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C0296172;
	Fri, 25 Apr 2025 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQeGBzw2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B614822068A;
	Fri, 25 Apr 2025 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625143; cv=none; b=bKe+N6OSRmTsMs+LMkgXRPRwloSLzDi2k0xUo3RvP49C9XOzlrn4UcWefdw0Ky6DvMPUbld0JdDOMHAX8WNsIhZ3wJVL4iwtshwcpCH8A8W8VU9Cdd7ODdWpd62wDO304mmASUXRZUqlm2sZ3aRs+tM3LvpQVavqpLSBD7JGEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625143; c=relaxed/simple;
	bh=j/cxrBr4NHGqNiTHxejd44ufsehKFzMAv53Ps19t+A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2cc2cZf15u7EdvhhYAk8WaHB4+cybRSUZKuMWfntZ1PWr5fVaIvRlzX/5QEnUq52iNAasw/Mvp6Z1sCwiBYBkTbvdXKXZvXA9YMD1EMunUPsuPFC6ducoJUEl+D3jKXPIsdKIASKGTlMr7SfHXQgSwYDlEqqgJCzYurmsV8ieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQeGBzw2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so45524055ad.3;
        Fri, 25 Apr 2025 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745625141; x=1746229941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hjdHS9B4bUFnleKSq42QPui7bUV+xj5vRVa2obZrAA=;
        b=aQeGBzw207B+E/j4dSGGySjX8DiiaARGbbeyU2J4BkoVSAbZVqmTIBrXZ+Jp5zqCRu
         od5TFegtvklevmIlrn6jE2tiJNjrTAkTC2a35N8QwZiObn7ITb6cRR2HjoFfKzYD3Ktl
         frKZBOXezEJ5VxwL5QABch0/ZtU1ww+hPXKFh6vQFHKyCLuHn2gTG6eT9FykJsRhG1st
         EoHoqoL9KrEHGmyVOdhpQe6YjvXp/7T07+ZaCCVa7GvJJG4xVpAdmmXBmuvZ0ahHseqv
         KGVVMLDCFOKfmcQenDMu+izaELAMOyilyddjUDsgatD3mHhoDMJLh69JvwpVLJ/TbMC2
         8JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745625141; x=1746229941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hjdHS9B4bUFnleKSq42QPui7bUV+xj5vRVa2obZrAA=;
        b=F/U0K021MvQ7Ckn8xvwy7DEGuQkDttEwWfyWhvwt7cL3lVR2Cq/4YLtraXhDLzAKpL
         iGE2Bi3BudPstVjz4NiWen57hmOGk+resXnMfmYoo4ELx7HlMmXniU0Tsp0MbM97C/An
         DjCDsBGUPhuy/BawZ9LK2C0w6xQzvfQkRBHwhDXpAwaggBYFsS8qVVjRx60WR/MmMzXT
         KNlmq2+3+blizspdMsPO4Aezy53kQDj+QRF04uEzbXJp+zzHm2x0Qj+CZ4PgaxVqdR0I
         wcnVDKqXwRwNUzyTu2U2QeDn8hQRHuofOztkVtfO9LmShNvwtIc7NJnQSBWRxXfE3wGR
         AkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5QUCLJ5HCWpeJiHuHAyS6u90VFIhClO339I2ARXF8COj/arIph7kwMypuKpIDLu91hfZgCEE7+cg=@vger.kernel.org, AJvYcCWDbsSEVWjs6F7MthZenbyViqv5ywodEhIi4q73jPFZ2jtl35nVO1HqUQUX3RPotKgS5rkaTeI+I5H3k7rL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4AcW8mTE92wE4x1WBIMLQujZOSJ4FeyzCafyJ4n8+JHSggxXW
	IJd4prbl9GXFcgMj89Yn42MM4lBnUBUh7lWbOcZuAy285z7iAv6E
X-Gm-Gg: ASbGncu9OWtt2qyNP/+POPAIymhWdVw718h3+xp9szYNzGRJmiWDV69LQIIps9zmyqX
	3k2imXxWx63feWW9c+/MWmBqgoN1OYofpNeBEYpOSoXyTPucXCY3e9uDwLI5xHdHp9Badd3R1tz
	XIzFL62cb5ejxjPMFgw8wyhvx/WtOwz9bdsAxaFrgaYMUaSiOTRITWmtRMSMgc8AiMeRHhoHEEO
	ea5OJS7YhmUEax/8IVQ+kGCo5PpcgapiM6/qjp4XOwDflECygCmWXjZ45wNftGUjEm+SRlArNUu
	GxMYvhid5zp49ts5mSL7ud/+2pH460M0afgLW0e3yjtT
X-Google-Smtp-Source: AGHT+IGnKminEbENISTv5pcyYb2qv0lr9dnhR7UkOir4FZ2/goHcg1Qyk1h1jHQogKR4VIjh0nW6ZA==
X-Received: by 2002:a17:902:da91:b0:22c:33b2:e420 with SMTP id d9443c01a7336-22dc69f82bbmr16441835ad.7.1745625140597;
        Fri, 25 Apr 2025 16:52:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1002])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7a40sm38753485ad.147.2025.04.25.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 16:52:20 -0700 (PDT)
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
Subject: [PATCH v2] iio: accel: sca3000: remove duplicated code in sca3000_read_data()
Date: Fri, 25 Apr 2025 20:50:51 -0300
Message-ID: <20250425235130.56122-1-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicated code between sca3000_read_data() and
sca3000_read_data_short() functions.

The common behavior is centralized in just one sca3000_read_data()
function and used for every case.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
---
 drivers/iio/accel/sca3000.c | 82 ++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index aabe4491efd7..c4b1da7f8de1 100644
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
@@ -309,7 +313,7 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_STATUS_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_STATUS_ADDR, 1);
 	if (ret < 0)
 		return ret;
 
@@ -412,7 +416,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	return st->rx[0];
@@ -432,7 +436,7 @@ static int sca3000_print_rev(struct iio_dev *indio_dev)
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_REVID_ADDR, 1);
 	if (ret < 0)
 		goto error_ret;
 	dev_info(&indio_dev->dev,
@@ -575,7 +579,7 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
@@ -665,7 +669,7 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 
@@ -703,7 +707,7 @@ static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
 		mode = SCA3000_REG_MODE_MEAS_MODE_OP_2;
 	else
 		return -EINVAL;
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 
@@ -732,7 +736,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 				return -EBUSY;
 			}
 			address = sca3000_addresses[chan->address][0];
-			ret = sca3000_read_data_short(st, address, 2);
+			ret = sca3000_read_data(st, address, 2);
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
 				return ret;
@@ -742,7 +746,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 					     chan->scan_type.realbits - 1);
 		} else {
 			/* get the temperature when available */
-			ret = sca3000_read_data_short(st,
+			ret = sca3000_read_data(st,
 						      SCA3000_REG_TEMP_MSB_ADDR,
 						      2);
 			if (ret < 0) {
@@ -830,7 +834,7 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 	int len = 0, ret, val;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
@@ -969,32 +973,6 @@ static const struct attribute_group sca3000_attribute_group = {
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
@@ -1008,7 +986,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	if (val & SCA3000_REG_INT_STATUS_HALF) {
-		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
+		ret = sca3000_read_data(st, SCA3000_REG_BUF_COUNT_ADDR,
 					      1);
 		if (ret)
 			goto error_ret;
@@ -1017,7 +995,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		 * num_available is the total number of samples available
 		 * i.e. number of time points * number of channels.
 		 */
-		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
+		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR,
 					num_available * 2);
 		if (ret)
 			goto error_ret;
@@ -1060,7 +1038,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * but ensures no interrupt is missed.
 	 */
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
@@ -1121,7 +1099,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 
@@ -1164,7 +1142,7 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 
@@ -1214,7 +1192,7 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
 	}
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 	/* if off and should be on */
@@ -1287,7 +1265,7 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	if (state) {
@@ -1322,7 +1300,7 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	/* Enable the 50% full interrupt */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_unlock;
 	ret = sca3000_write_reg(st,
@@ -1353,7 +1331,7 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	/* Disable the 50% full interrupt */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto unlock;
 	ret = sca3000_write_reg(st,
@@ -1383,7 +1361,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	if (ret)
 		goto error_ret;
 
@@ -1409,7 +1387,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
@@ -1423,7 +1401,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
 	 * as that occurs in one of the example on the datasheet
 	 */
-	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
@@ -1510,7 +1488,7 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = sca3000_read_data(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-- 
2.49.0


