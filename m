Return-Path: <linux-iio+bounces-12365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCAF9D052D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901F02823F1
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699C91DED64;
	Sun, 17 Nov 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWM8h8r6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652291DE89E;
	Sun, 17 Nov 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868122; cv=none; b=AYCSeGs0V+HAdp7nnnmqrmHwpURcPpHDCb5y3A7ZVACwqUG/KQiUTuyo877ZF1rPdgwlrRL8X7EWqjeC5w2bjUkisHRrM6jZ8H5fApLjn9V0UDNS0VtlsEkcXDL3NHj88++2hpyXCMjrU5/Zu+HnUJCemd9mic8BGkm1f/Fp7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868122; c=relaxed/simple;
	bh=6Ty7UcqFwwj0IBvnQHFNDu2DWSapIAHbAbAfG2L6040=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yot/fPXtF855EuUGuZkcl577qv52g8A23MPBSDHkkOOuFgz3F8hFA2pU8tVzWTEO3wSJKBw7Eq+gn14dmaZHknqhLkCQMCSeemNgXxYHYxLu5zcshjKwe3tkn/N8f8AM9Vk0H0gYKaeDs7anuVUb6J/othF90AhrcozqgxkInjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWM8h8r6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38231f84d8fso94689f8f.3;
        Sun, 17 Nov 2024 10:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868119; x=1732472919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7SMjsKTJF3XXwC0PuuMPNue9a73DWC0gkHNPCwn8EQ=;
        b=FWM8h8r6phdNw/oj0pP8xt+zWBjXgtbdUZFrViVQo4NJIgF74pe+XcgyEFK3L37zg6
         PTZXUWM7+Z/nGS+/2LQR+BnZYq5fYPTAmc50M/e3wAMfgPCyTA5oYMabBdacvbB2GtBE
         qImh1eeFaFSeHryKwPnMWL5tG8459As3EYXK9oqhNjrZgf/df4UEhFGJuwirua+a0jrz
         FAu8e+9tXEBeHn/Umdq8+ZZPkZ/e3wmnj/7cOSb930VXUfVgOH6B2eytqsJQ7LSAwWtx
         n5xcoOd3O6132jlmPKAagQ6szq3FvnfHdX/ItMooULlAOsjgLuzKIsRsXXMJVdcN1lH2
         E5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868119; x=1732472919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7SMjsKTJF3XXwC0PuuMPNue9a73DWC0gkHNPCwn8EQ=;
        b=BWB4yzLp5iXPv4XOBtkS/uVTWZPa2OeCbHe0qJud5mndgB3qj5mjPYh9wUJa2+4ho6
         nkG0zg3H47QfQ4Gce1qoBSQ1FLTWIRfyo8KJkIzfTa8eCEk80aCwhrhNgu3n2vCSQ6LE
         gjlxqXLHz3QQj9HeEPvJ30K4V3LUAF+N4OvBM8EAFm4DSwhBdf/qGZml8w6uAQ5lrexS
         VrBByIzSOPVU2C9ebU+1MnB5JSQYIJuW++OyF6Le/njZpNtYtQ4hJBSB0jmamsfZ+EIl
         k8LopkryNtMaxO4FTiod6j4P5oXUI8KVeLckAKg/ZOlJwRZIICHnr8iYkpu/8slrVX/t
         lSYw==
X-Forwarded-Encrypted: i=1; AJvYcCWuXCGMAWG4ArYHOeYN6kUYRfUrZ9HGyDISQ15nxpoqdZ270SospKGt+M7fED1EmGb/SxaKrqH1zgqIBOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLY7GLw3Lm2iumxWt8CxVrSTzXp70yg+KuyqXFYbqGJPmGb8GA
	IeBYMJ/RiY3d/wnvHKxfpXNZWTAMouVbNhY4pgjYMZJYZ6UsMaD0
X-Gm-Gg: ASbGncs/tJJ+32HXP6oepRaTnxPsHqNn+537xq1kdhTZu5FgXY3M13yFmNm/OHhIjNt
	xnag+SSTlJrfHyI8+LLugUaEk41kdKcBRkHZBLaFlg3173xi5sm8xdvtBgLzsZvK7iNTs4l+BIm
	hvh2e/bxbmij82gaNuvmvFXWC8faCY9DC9ymQzTQ0TazziYAa8WFakSBroF9bM5THI0HSPYDqsb
	TJe3ZxRPWJt/fM95UMdv491emtcrUAX8xhIw692d0sZBAazxJmE10ulzH9H4ku9uYbDyKF1Smg6
	xLqPmbScuofTnG4Zx6VbdRlhM4pn
X-Google-Smtp-Source: AGHT+IEyBBba2byhxuVdMC2GpE3Mg1u1KL7/jzRwgbHm2Q9MfsRkPxNlfOIAUepCyr3VLaD50PKJFg==
X-Received: by 2002:a5d:47cc:0:b0:37d:3a04:62ec with SMTP id ffacd0b85a97d-38225a3959bmr3630275f8f.8.1731868118589;
        Sun, 17 Nov 2024 10:28:38 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:38 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 22/22] iio: accel: adxl345: add debug printout
Date: Sun, 17 Nov 2024 18:26:51 +0000
Message-Id: <20241117182651.115056-23-l.rubusch@gmail.com>
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

Add debug prints to allow to debug the sensor based on dynamic debug.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 95 ++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c79f0f5e3b..8d2166a057 100644
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
@@ -528,6 +603,8 @@ static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries
 	size_t count, ndirs = 3;
 	int i, ret;
 
+	pr_debug("%s(): fifo_entries = %d\n", __func__, fifo_entries);
+
 	count = 2 * ndirs; /* 2 byte per direction */
 	for (i = 0; i < fifo_entries; i++) {
 		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
@@ -537,6 +614,7 @@ static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries
 			return -EFAULT;
 		}
 	}
+	adxl345_debug_registers(__func__, st);
 
 	return 0;
 }
@@ -656,6 +734,7 @@ static int adxl345_push_fifo_data(struct iio_dev *indio_dev,
 		if (st->fifo_delay && (fifo_entries > 1))
 			udelay(3);
 
+		adxl345_debug_fifo(__func__, st->fifo_buf, i);
 		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
 	}
 
@@ -683,6 +762,7 @@ static int adxl345_trig_dready(struct iio_trigger *trig, bool state)
 			 __func__, st->int_map);
 	}
 
+	adxl345_debug_registers(__func__, st);
 	return 0;
 }
 
@@ -713,6 +793,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 	int fifo_entries;
 	int ret;
 
+	pr_debug("%s(): IRQ caught!\n", __func__);
 	ret = adxl345_get_status(st, &int_stat);
 	if (ret < 0)
 		goto err;
@@ -747,6 +828,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 
 	goto done;
 err:
+	pr_debug("%s(): error termination\n", __func__);
 	iio_trigger_notify_done(indio_dev->trig);
 	adxl345_set_measure_en(st, false);
 	adxl345_empty_fifo(st);
@@ -754,6 +836,7 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 	return IRQ_NONE;
 
 done:
+	pr_debug("%s(): regular termination\n", __func__);
 	return IRQ_HANDLED;
 }
 
@@ -804,6 +887,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st = iio_priv(indio_dev);
 	st->regmap = regmap;
 
+	dev_dbg(dev, "irq '%d'\n", irq);
+	if (!irq) /* fall back to bypass mode w/o IRQ */
+		dev_dbg(dev, "no IRQ, FIFO mode will stay in BYPASS_MODE\n");
 	st->irq = irq;
 	st->info = device_get_match_data(dev);
 	if (!st->info)
@@ -831,7 +917,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
@@ -846,6 +936,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					     "Failed to set data range\n");
 
 	} else {
+		dev_dbg(dev, "No setup() provided\n");
+
 		/* Enable full-resolution mode (init all data_format bits) */
 		ret = regmap_write(st->regmap, ADXL345_REG_DATA_FORMAT,
 				   ADXL345_DATA_FORMAT_FULL_RES);
@@ -854,6 +946,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					     "Failed to set data range\n");
 	}
 
+	dev_dbg(dev, "Retrieving DEVID\n");
 	ret = regmap_read(st->regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
@@ -861,7 +954,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (regval != ADXL345_DEVID)
 		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
 				     regval, ADXL345_DEVID);
+	dev_dbg(dev, "Retrieving DEVID ok\n");
 
+	dev_dbg(dev, "Registering power down function\n");
 	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
-- 
2.39.5


