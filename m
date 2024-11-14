Return-Path: <linux-iio+bounces-12288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 601339C95F7
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DC0B26F4D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53BD1C4A0B;
	Thu, 14 Nov 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+iMx7xM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74521C3F0E;
	Thu, 14 Nov 2024 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625844; cv=none; b=PNdGgUPR1pjGj0PWwTHv4n9M2XHhVOBuhAB+Z35fLGag3UkUTsPU3YeH134bo8NE/Fojid36maIydPiPtBlebVlPvLvbiTlvQ5dIFrtoPHUey1PIf9IUiKb2H+/9JuiqOLB6suep9jwPB0JFUMgD2cNqSdf6RduW7QggnIhqUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625844; c=relaxed/simple;
	bh=EBs8YAdk/98rJPrf092AW2M34oEylWTxPcS/4zaMr5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KK7ovjQ4pth0uOQ9OXfHGA/ooWxk6Gt7BPDa/hqLEKvYlrAuGCXgXcJHRdJV/fo7V7G7YCa+gg6QrO0Sxr+jfS1YuoczW+T2kG+/jdjBHG1smZs7QIoEue/8S890n3dfChGpGhzW7CWoOSlsqKQrW7ee8TGoODSau8sHfd1l9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+iMx7xM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-432d796a57eso1407675e9.1;
        Thu, 14 Nov 2024 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625841; x=1732230641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNm2QdDqnaGddIKwK+pE7qQtuDe8fNMcfOP3pPhPlIU=;
        b=U+iMx7xMkgtgQDEAh6aqrKeGZHuh9xjUV739vMo07Flco52w2FWcNKh/hVWGolchjA
         JnRcCH5M8AuOgMPA04yvTnWXTWfm8NYTbDr/33SZwk/GrH8tau0lj0CExvkKR/I+/IEQ
         Ecl5SC8zL9DhiB7gXYXh9YU1c/AC5lu3IVuvhL9rASR0Wqb1UhGk7Bmk6VYJtQbLy+ff
         N+e4Tc0aQKkeBDcnDSvafvKz3N9qk2zAnbuyrunOxTxfxaa4xVpENJFzNqBLAL+R+vKn
         QyUanyYE2lwmVOgcXBWAM+0ht8bHf3gx3SXbvDUYd5uC0jeXJcZvTJuw2t/icEyHSicI
         XFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625841; x=1732230641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNm2QdDqnaGddIKwK+pE7qQtuDe8fNMcfOP3pPhPlIU=;
        b=jhF9nrOBmEAd/jhk3+mTJSOmyKjUpLf8vgGZnNEJw/xdnOMg0F3eJR+OyQVpQui5bI
         HyFfy/QBvYogLPyYPJOX/Hee+FH6Sov7ltJjnrt7WwQjL2zfjNh3prKBGRNRwOO0kAv+
         3C+AzGFpejirmCogixvXQQMvPftUQNYWOoVvXjkTFqxzjdpBRTmiwQHGjFzKeCD/P+WX
         RN9H2Dq7+1DyPxP01hW1u00DpzvxWxwaUVJLODm2VJpcWs2WVfPCYIYHO05sXaR/cyZv
         w8ClD7dMOuoeTTCL5QOi2BN/Tv0ymE//I1gtmGwAIhP5HAPBHZ9Wjl5zC+LFw/PLefI8
         Sx/A==
X-Forwarded-Encrypted: i=1; AJvYcCUMazfyI96Jpgn3vgWRsMfjbcUObkwKanzliBdLmm3kU8iJsZvQFFxFJooH6Ut2Al+NxP728+l7wv8RZ80a@vger.kernel.org, AJvYcCXU3YLCa6ySduRjGFRbZhAyJZLr0FhFBHrevA2x85Hlvz9X2IhSFECz46q3D5EwKICLqUGJNaPmxE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jBBh0YoIpyL9kTZowOpM19nb8cp4diT4RIW9vFsivP5GqoT4
	QGp2YyXXY7rXEGarfqpNMdjQHT+a8d7nm/QADRWnb9FFiV6EJw73
X-Google-Smtp-Source: AGHT+IGlqVBkjFRciP+03ZxqOA1xBt4bW8kF15JLb2JJhrTY/r23RcNX8Ead8XF9s9jCj/PkD2V0rA==
X-Received: by 2002:a05:600c:4f02:b0:42c:bfd6:9d2f with SMTP id 5b1f17b1804b1-432df71d75fmr1683445e9.1.1731625841202;
        Thu, 14 Nov 2024 15:10:41 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:40 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 20/22] iio: accel: adxl345: use FIFO with watermark IRQ
Date: Thu, 14 Nov 2024 23:10:00 +0000
Message-Id: <20241114231002.98595-21-l.rubusch@gmail.com>
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

Enable the watermark feature of the adxl345 sensor. The feature uses a
FIFO to be configured by the IIO fifo sysfs handles. The sensor
configures the FIFO to streaming mode for measurements, or bypass for
configuration. The sensor issues an interrupt on the configured line to
signal several signals (data available, overrun or watermark reached).
The setup allows for extension of further features based on the
interrupt handler and the FIFO setup.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c99b8176f0..ab39fd8eb5 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -854,6 +854,45 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return dev_err_probe(dev, ret, "Failed to setup triggered buffer\n");
 
+		dev_dbg(dev, "IRQ: allocating data ready trigger\n");
+		st->trig_dready = devm_iio_trigger_alloc(dev,
+							 "%s-dev%d-dready",
+							 indio_dev->name,
+							 iio_device_id(indio_dev));
+		if (!st->trig_dready)
+			return dev_err_probe(dev, -ENOMEM,
+					     "Failed to setup triggered buffer\n");
+		dev_dbg(dev, "IRQ: allocating data ready trigger ok\n");
+
+		st->trig_dready->ops = &adxl34x_trig_dready_ops;
+		dev_dbg(dev, "IRQ: Setting data ready trigger ops ok\n");
+
+		iio_trigger_set_drvdata(st->trig_dready, indio_dev);
+		dev_dbg(dev, "IRQ: Setting up data ready trigger as driver data ok\n");
+
+		ret = devm_iio_trigger_register(dev, st->trig_dready);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to register dready trigger\n");
+		dev_dbg(dev, "Registering data ready trigger ok\n");
+
+		indio_dev->trig = iio_trigger_get(st->trig_dready);
+
+		dev_dbg(dev, "Requesting threaded IRQ, indio_dev->name '%s'\n",
+			indio_dev->name);
+
+		ret = devm_request_threaded_irq(dev, st->irq,
+						iio_trigger_generic_data_rdy_poll,
+						NULL,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+						indio_dev->name, st->trig_dready);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to request IRQ handler\n");
+		dev_dbg(dev, "Requesting threaded IRQ handler ok\n");
+
+		/* Cleanup */
+		adxl345_empty_fifo(st);
+
 	} else { /* Initialization to prepare for FIFO_BYPASS mode (fallback) */
 
 		/* The following defaults to 0x00, anyway */
-- 
2.39.2


