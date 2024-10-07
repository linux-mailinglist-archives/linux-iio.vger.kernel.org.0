Return-Path: <linux-iio+bounces-10282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E69930F6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9579D1F22652
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E521D8DF0;
	Mon,  7 Oct 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTwxfOOi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8037D1D89FF;
	Mon,  7 Oct 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314421; cv=none; b=dZYpXvufwcY8FFWY22C9IB2U/Vbc9rVm+PTQHfF9rzosF9ZwB99RU2NJgVw26YPUwHmHAkkDRRedoo6M+cqydLZkmHSwNSwKJm5hrTRmhycbAnaoAAUKWCYLEWKtJI5+hldCA86K6fu12m4I+xH4zgT59F5vsOb2kK2YQXOdBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314421; c=relaxed/simple;
	bh=y8fpYG9T60OwQP0aXJxzsXaodmkYPpmnD99lrwUmUdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjW+DPHhDO6Jw44Elo7q7yJUnR+PgqBMKHNPFscjGaDBrI2dQbuKqpHnideGAeZq+TuwUWksYm/TuB9+L3K5uoVSiYvvFjdVKdPaQmYaS+w0ugClpZsHlO6+RgKdtUU0pOE6ZhWbgTuHwew7GZP1QEQUD/eqlkWA5fjeDGI9zVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTwxfOOi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b0b5cdb57so41329215ad.1;
        Mon, 07 Oct 2024 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314418; x=1728919218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6Q3pN7n5lzASa1iAB1h9SmIQ5Uey3Y3s1sa+1tGPWk=;
        b=TTwxfOOi9EU8i+irNiRRVyRKys2hw9Ae0eTQhx2HaUuJyvTp6JvA200nTuf6215xqK
         vRVWUz6fJna1It/lTi9OcSh0oTiAvkcIhxLfGTdjON7XOhp64swCLG0Q9m4SmZI0P44u
         jAStrWTT6lrZVb1gyN1Ts4xpW45/z6t/bNIFzP3uaB7RUtonnV8LaPp2INbhTnaduZpc
         YuxrwWSG8lF+VwPS5EgTUbKHDkt98TmUHA9UJUR2pktqFpFYiFItNKtrSt7RIhCvFw4b
         LcEt19BFvNerqrZtlMmBISv6RGMWACq/EZitei/HGNcmwagWV4nfrb+EcC3Pq/WlrHSC
         87RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314418; x=1728919218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6Q3pN7n5lzASa1iAB1h9SmIQ5Uey3Y3s1sa+1tGPWk=;
        b=xKJrJ+ZlF2/bSJcqMv12R1ulTC8xs9XVy/Q8zPtlaNvpUmB4ppjohX1rqi0rI/FZLp
         JhAQVyQikwMGXi1LB9dGGWkWptbVOt/spaK8yqeiR7Iq8cGeJA+i3mvqXDxULRwG13RD
         4+DSm0vu3QaDax6Oub/AezsA02WX8A3coey4+yN6qntaPTz9dSEAonOACOu0coxAhOjI
         rls3RoRifmhzseNy1LmPIndPAhv6WNknqXU7qqfj6ZbDF/7ZQS5OpWEW9+MsuR9nqgyS
         ehWdN7fxummeY8CXYongQHN8ep1vlPNqXOUK+E4PvpismKetRLxkUyxONtS7qxAq5kGw
         vyrg==
X-Forwarded-Encrypted: i=1; AJvYcCVYk8F3eScqU3Mbg2iwLRHmKeqrdQhuMMSLHEoln0uiBKGicO0cZbNdwu9LqBuQL3khV/nktPjKsEH1jOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwluVOXyf5vjsOUB1/zwaGD3/LV8leQz8docsdWXZ5KsMoFXEL
	cTHkwBhl2t6Y7sqytMBQfDbhje3vfNZqq1Obe8uafGf6RLQQHULHk43gB0D9XQk=
X-Google-Smtp-Source: AGHT+IGP30QjcEuP6lWtQgkymsNYOcb0WCuG8oqw5rvdNOtuthT3T4Y6C+jpxhDkdvQ472jsadiBUw==
X-Received: by 2002:a17:902:d50d:b0:205:59b7:69c2 with SMTP id d9443c01a7336-20bff3912e8mr144356195ad.7.1728314418218;
        Mon, 07 Oct 2024 08:20:18 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c138b1395sm41000755ad.3.2024.10.07.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:20:17 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 2/3] iio: light: vl6180: Added Interrupt support for single shot access
Date: Mon,  7 Oct 2024 20:49:46 +0530
Message-ID: <20241007151947.58828-3-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007151947.58828-1-abhashkumarjha123@gmail.com>
References: <20241007151947.58828-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupts are serviced in the `vl6180_measure` function when the
irq_handler signals that the reading is complete. We now can read
asynchronously if `client->irq` is set.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 54 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 67aa2f101..a747501b0 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -86,6 +86,7 @@
 struct vl6180_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	struct completion completion;
 	unsigned int als_gain_milli;
 	unsigned int als_it_ms;
 	unsigned int als_meas_rate;
@@ -211,29 +212,38 @@ static int vl6180_write_word(struct i2c_client *client, u16 cmd, u16 val)
 static int vl6180_measure(struct vl6180_data *data, int addr)
 {
 	struct i2c_client *client = data->client;
+	unsigned long time_left;
 	int tries = 20, ret;
 	u16 value;
 
 	mutex_lock(&data->lock);
+	reinit_completion(&data->completion);
+
 	/* Start single shot measurement */
 	ret = vl6180_write_byte(client,
 		vl6180_chan_regs_table[addr].start_reg, VL6180_STARTSTOP);
 	if (ret < 0)
 		goto fail;
 
-	while (tries--) {
-		ret = vl6180_read_byte(client, VL6180_INTR_STATUS);
-		if (ret < 0)
-			goto fail;
-
-		if (ret & vl6180_chan_regs_table[addr].drdy_mask)
-			break;
-		msleep(20);
-	}
+	if (client->irq) {
+		time_left = wait_for_completion_timeout(&data->completion, HZ / 10);
+		if (time_left == 0)
+			return -ETIMEDOUT;
+	} else {
+		while (tries--) {
+			ret = vl6180_read_byte(client, VL6180_INTR_STATUS);
+			if (ret < 0)
+				goto fail;
+
+			if (ret & vl6180_chan_regs_table[addr].drdy_mask)
+				break;
+			msleep(20);
+		}
 
-	if (tries < 0) {
-		ret = -EIO;
-		goto fail;
+		if (tries < 0) {
+			ret = -EIO;
+			goto fail;
+		}
 	}
 
 	/* Read result value from appropriate registers */
@@ -484,6 +494,15 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static irqreturn_t vl6180_threaded_irq(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct vl6180_data *data = iio_priv(indio_dev);
+
+	complete(&data->completion);
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info vl6180_info = {
 	.read_raw = vl6180_read_raw,
 	.write_raw = vl6180_write_raw,
@@ -583,6 +602,17 @@ static int vl6180_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, vl6180_threaded_irq,
+						IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return dev_err_probe(&client->dev, ret, "devm_request_irq error \n");
+
+		init_completion(&data->completion);
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.43.0


