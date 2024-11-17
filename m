Return-Path: <linux-iio+bounces-12363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4409D0529
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8710B22401
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FD1DE89C;
	Sun, 17 Nov 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGw6QPiS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AB1DE4DA;
	Sun, 17 Nov 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868120; cv=none; b=f9meixw2RiFVjsnFpPPZcJdt3NO1uC74L8fCz+Kj9i9vgtJLKM6A7xw+OlVRGW56/Dkvk1QQ/Vh2KP/AlzYFyqj1afVBEtV8aa+jd0GXuJ/ZDrgLf75LvA6b79Fx6cdwI3ShV68ER6pLVHswdB2niJU3v8iAQL7ZmEdRUI/PNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868120; c=relaxed/simple;
	bh=6/0DwltEUb1r+bPdI+XsZRMVxWyPtCMYqzrHqPidDLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C64I8qGMGcAz9I2BCSTA3GLBsydUVlzMi66GefCdEbLO6jiwbMmu9gyishVrgn4Cs3OWpiXDBEwjio22QIpD9y5UTTuWVX5USyCAtOA6/+PVLWevffSRPruRIGm5bRBMRUkS77/16OsU+Wgw/HtMID1wQmt2kBl3R6GDwZicU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGw6QPiS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38242100504so60980f8f.1;
        Sun, 17 Nov 2024 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868117; x=1732472917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0jDVowXCEL7M7LDBhaoZbZ0uKb3vpVkttp/faRKS9w=;
        b=lGw6QPiSw8Nlab3TqiBOdrxi7hYvkPUiG8WaET1LGM50kctCzd+GEigGw9+2+9k9vI
         cOIujhFVW8TkSWcz0TRTRgc1CHyYhuPTqQZftAMemt2j/AjXhv6OaUGFz2BOPbEreHEC
         P9OXkMC8+UHaDuNWe1wfMiYXW3Z26wK8Y4OFfZQ9qBP0ZuUZZMaPzMQJMECywz7ajwLy
         oH6NrockvEwkM1i96zm4QtAELzjzb7ZbbZ8TWRIix91x/pi5WOayGEx4romGJ9jdDM0M
         HAdms/nt5pPj+STwOUuKEIcH8axKHmD2VBCyxryGfD8shPyOUBzvdmabOkcy1wkue+m4
         Uo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868117; x=1732472917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0jDVowXCEL7M7LDBhaoZbZ0uKb3vpVkttp/faRKS9w=;
        b=ZqyjKJYnmf60/F5Eixzez0r8GKFUT6P6lHajpw517BD1Zsnzr5xNfVC6AX8zyJtvf1
         smxpdpjD0/TTtzludjDd74gYsqktGiSA7F5cWDrt0D/WQkt6G6wnKRqzxkF8j6EyG57s
         cFN4ammztQa/EairgPFFKg/LQXxG/aFfJ0tl6TB8+Gaoidg/P/Qm1QhtpafDWKlrSkmW
         lGJ/EzTu0DN1FE5dTzbbUUlQDudmktjZ90fmWmw7fZntJKNwuiT3rChxKdrMzzaj4xM5
         SDFBSezeZnk70ADBSr2xBQyZEbZFO/S/aaEU8grSfkoTNJ/xRBY04u4OLZwNkolFiEAP
         V+RA==
X-Forwarded-Encrypted: i=1; AJvYcCUcr3438M+YVXEMcYpLDgvkbKoILFO0MwzGD5PvnR8ayRpLzHOJm0VuL7Vpu7dzh3YeEUueDfRzWwZDLpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdNcDEVAZvYEhDj5sjjAyC0dl8Vw06jzbShz5VMcQeCHxc1sY
	m2d90Bpa2SFHJwLr95EAXMEzU28blUIIH9nA0aAECjuLNrqW/yeU
X-Google-Smtp-Source: AGHT+IFPk2sLRl6XUuJUTITQ+rjKOPPRT9AhnCwgKB21M2FrzSP6gkJC4XF45wUN3a9IEq5LJW9p0g==
X-Received: by 2002:a5d:6c69:0:b0:37d:54d0:1f15 with SMTP id ffacd0b85a97d-38225a04715mr3045657f8f.7.1731868116592;
        Sun, 17 Nov 2024 10:28:36 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:36 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 20/22] iio: accel: adxl345: use FIFO with watermark IRQ
Date: Sun, 17 Nov 2024 18:26:49 +0000
Message-Id: <20241117182651.115056-21-l.rubusch@gmail.com>
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
index f7b937fb16..07c336211f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -870,6 +870,45 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
2.39.5


