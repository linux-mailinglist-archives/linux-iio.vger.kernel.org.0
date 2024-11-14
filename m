Return-Path: <linux-iio+bounces-12290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B229C95FB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D27281EFC
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA01C578C;
	Thu, 14 Nov 2024 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ejp+WL1A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4571C4A1A;
	Thu, 14 Nov 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625848; cv=none; b=pkzjs0+6NvigDITStLYJQQEiyRPuU51nMiwurxmaPoAoKbsvgtMdcIpqFGyQeDzuJEp/58WURV3B84ZoKDnFLDW49KFF6dQyjp52sisqC/2Ed94VZbyEeMlc65xP+E7iagt1Eu5XZk9akefLxVmDUvNL8sUSep5TXassmonNyjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625848; c=relaxed/simple;
	bh=XVBaT7tI4WC3TxeQZRnASdggvZWpWUDYexXxWgAysew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2zoMDbLPiYaXyIAon9AlaW0+9t+6qe69PoSqKqSbOikrm1HXEPTdtqXPL54WRhuifjMmgPJX1PllP3E5JioXvzN2YhVJnnKK0fMRzjt20SF4o20Kr9HQuZhQqetsJii2si3JL7Lt5Os1KWmcSSRmw+BnC+kAf7HA32eW9SJEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ejp+WL1A; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3821ae348e3so97513f8f.1;
        Thu, 14 Nov 2024 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625844; x=1732230644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76W9ZF4PZtMV17rjIpg8P7SpS5XYC97O8Bnuf6JYvP4=;
        b=Ejp+WL1AMtpsEjGWpN5jMhfwB/CDkjfAnrl0XP/qSKza0UnpTWjEVrmaY5jW2RnNuT
         T4XBjdfWD69QYWkC2ibUPnnxO0SKQGyYMsR/G9IvkaHY7v9SYem5ncCdK06QMZa+ZV46
         OzCtHLfclvfsz2pEKW87r083u3uDC5hQNhhxi7zqTS3H5iXoO7cx2aGqAvujLijycNkD
         AcTRMBWsrLgXq0UJo/NtSnaYCVvYpeifTgOdApnkNUZMwcDv7aeAOosBI8dHAUdmFpMh
         tAbDjFLJyx5qnyOv1EcopFusHPlGb6w/zT+JQfomoaE47Q7tU/ov17P1/tfs7AciLLw8
         hbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625844; x=1732230644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76W9ZF4PZtMV17rjIpg8P7SpS5XYC97O8Bnuf6JYvP4=;
        b=L/gAxQZnGSwqpTPjuj/c7gpdsZ7iiaQykff95s0slyceDNHsEs8tlLrJJ+jIJlAaAc
         8qpuInpSdk8FrkcXFqUiRNv2boN1vA22F7RA+UO5/oQVgXY0lbL8k5VUhBIH69BdTzBE
         YnRxzCXqprT7+Rq24muA37eIyTN1Mm9+D8iC9URKDr7TCLpFbaMEtbl0mOana535G8RN
         wgh+FD01PmIlJOYxtM3D2RJGdzM+P3Wro1iay24wZfzd/B0pbJTrwBuG76qPhlgEcAwG
         0oO/kcr/R1z6S5BKMZelc/e3UTZaF9remMigpoN80HaqZfl4hyeHCL5YPbM4+snkgkJ2
         LkjA==
X-Forwarded-Encrypted: i=1; AJvYcCVdeTc1Pq8Wor/2cCteo0kwgiprYbE/M1ZzfIJ9oCtmyWR9X1LYG9PaL331DcQZ7UolARvtDwZw7V4=@vger.kernel.org, AJvYcCX9TdDh9cv6ejHE2vltnQXEdyci2mduMws0NyOhZg8mw35ivfpjYjsyEB8naxApY0qSpLa/CKzoh/jBnVi+@vger.kernel.org
X-Gm-Message-State: AOJu0YxlBwGI4kFIg5tq0a1DbCTrp744/NL8bL1/2vjnv7jDtJ68xj34
	2e1NOADHfahjelwevKIJEeY6N/nvOyc0WYsrH4yI61e/LsEGluJwGklS53Uq
X-Google-Smtp-Source: AGHT+IEXex+1ImFX1NZKJrs9laoUabfJkQRS5OoHyNocpuHjQladGWpksvee4OXA8i0s3JZQ6az7LQ==
X-Received: by 2002:a05:600c:a44:b0:42c:b870:c52e with SMTP id 5b1f17b1804b1-432df722ad4mr1689025e9.1.1731625844422;
        Thu, 14 Nov 2024 15:10:44 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:44 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 22/22] iio: accel: adxl345: add debug printout
Date: Thu, 14 Nov 2024 23:10:02 +0000
Message-Id: <20241114231002.98595-23-l.rubusch@gmail.com>
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

Add debug prints to allow to debug the sensor based on dynamic debug.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8025dfeb84..e416a50dd0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -26,6 +26,9 @@
 
 #include "adxl345.h"
 
+/* debugging registers */
+#define DEBUG_ADXL345 0
+
 /* ADXL345 register map */
 #define ADXL345_REG_DEVID		0x00 /* r    Device ID */
 #define ADXL345_REG_THRESH_TAP	0x1D /* r/w  Tap Threshold */
@@ -181,6 +184,78 @@ static const struct iio_chan_spec adxl34x_channels[] = {
 	ADXL34x_CHANNEL(2, chan_z, Z),
 };
 
+/*
+ * Debugging
+ */
+
+__maybe_unused
+static void adxl345_debug_registers(const char *func, struct adxl34x_state *st)
+{
+#if DEBUG_ADXL345 == 1
+	struct regmap *regmap = st->regmap;
+	unsigned int regval = 0;
+
+	regmap_read(regmap, ADXL345_REG_THRESH_TAP, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_THRESH_TAP\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_DUR, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_DUR\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_LATENT, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_LATENT\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_WINDOW, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_WINDOW\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_ACT_TAP_STATUS\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_POWER_CTL, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_POWER_CTL\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_INT_ENABLE, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_INT_ENABLE\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_INT_MAP, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_INT_MAP\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_INT_SOURCE, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_INT_SOURCE\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_FIFO_CTL, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_FIFO_CTL\n",
+			func, 0xff & regval);
+
+	regmap_read(regmap, ADXL345_REG_FIFO_STATUS, &regval);
+	pr_debug("%s(): DEBUG - 0x%02X\t- ADXL345_REG_FIFO_STATUS\n",
+			func, 0xff & regval);
+# endif
+}
+
+__maybe_unused
+static void adxl345_debug_fifo(const char *func, s16 *fifo_buf, int entries_line)
+{
+#if DEBUG_ADXL345 == 1
+	s16 xval, yval, zval;
+
+	xval = fifo_buf[0 + entries_line];
+	yval = fifo_buf[1 + entries_line];
+	zval = fifo_buf[2 + entries_line];
+
+	pr_debug("%s(): FIFO[%d] - x=%d, y=%d, z=%d\n",
+		func, entries_line/3, xval, yval, zval);
+#endif
+}
+
 static int adxl345_set_interrupts(struct adxl34x_state *st)
 {
 	int ret;
@@ -513,6 +588,8 @@ static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries
 	size_t count, ndirs = 3;
 	int i, ret;
 
+	pr_debug("%s(): fifo_entries = %d\n", __func__, fifo_entries);
+
 	count = 2 * ndirs; /* 2 byte per direction */
 	for (i = 0; i < fifo_entries; i++) {
 		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
@@ -522,6 +599,7 @@ static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries
 			return -EFAULT;
 		}
 	}
+	adxl345_debug_registers(__func__, st);
 
 	return 0;
 }
@@ -639,6 +717,7 @@ static int adxl345_push_fifo_data(struct iio_dev *indio_dev,
 		if (st->fifo_delay && (fifo_entries > 1))
 			udelay(3);
 
+		adxl345_debug_fifo(__func__, st->fifo_buf, i);
 		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
 	}
 
@@ -666,6 +745,7 @@ static int adxl345_trig_dready(struct iio_trigger *trig, bool state)
 			 __func__, st->int_map);
 	}
 
+	adxl345_debug_registers(__func__, st);
 	return 0;
 }
 
@@ -697,6 +777,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 	int fifo_entries;
 	int ret;
 
+	pr_debug("%s(): IRQ caught!\n", __func__);
 	ret = adxl345_get_status(st, &int_stat);
 	if (ret < 0)
 		goto err;
@@ -731,6 +812,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 
 	goto done;
 err:
+	pr_debug("%s(): error termination\n", __func__);
 	iio_trigger_notify_done(indio_dev->trig);
 	adxl345_set_measure_en(st, false);
 	adxl345_empty_fifo(st);
@@ -738,6 +820,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 	return IRQ_NONE;
 
 done:
+	pr_debug("%s(): regular termination\n", __func__);
 	return IRQ_HANDLED;
 }
 
@@ -788,6 +871,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
 
+	dev_dbg(dev, "irq '%d'\n", irq);
+	if (!irq) /* fall back to bypass mode w/o IRQ */
+		dev_dbg(dev, "no IRQ, FIFO mode will stay in BYPASS_MODE\n");
 	st->irq = irq;
 	st->info = device_get_match_data(dev);
 	if (!st->info)
@@ -815,7 +901,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->channels = adxl34x_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);
 
+	dev_dbg(dev, "setting up indio_dev ok\n");
+
 	if (setup) {
+		dev_dbg(dev, "setup() was provided\n");
+
 		/* Perform optional initial bus specific configuration */
 		ret = setup(dev, st->regmap);
 		if (ret)
@@ -830,6 +920,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					     "Failed to set data range\n");
 
 	} else {
+		dev_dbg(dev, "No setup() provided\n");
+
 		/* Enable full-resolution mode (init all data_format bits) */
 		ret = regmap_write(st->regmap, ADXL345_REG_DATA_FORMAT,
 				   ADXL345_DATA_FORMAT_FULL_RES);
@@ -838,6 +930,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					     "Failed to set data range\n");
 	}
 
+	dev_dbg(dev, "Retrieving DEVID\n");
 	ret = regmap_read(st->regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
@@ -845,7 +938,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (regval != ADXL345_DEVID)
 		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
 				     regval, ADXL345_DEVID);
+	dev_dbg(dev, "Retrieving DEVID ok\n");
 
+	dev_dbg(dev, "Registering power down function\n");
 	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
-- 
2.39.2


