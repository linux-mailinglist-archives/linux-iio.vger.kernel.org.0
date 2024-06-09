Return-Path: <linux-iio+bounces-6116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61B90185D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FED280FC3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEDA50280;
	Sun,  9 Jun 2024 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rabZRwXH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F94D9EA
	for <linux-iio@vger.kernel.org>; Sun,  9 Jun 2024 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717969786; cv=none; b=HT0ApvFBc0ZHe/8nV/d72BV88O7zVV2azibE2QSOfJ/dejh/KgLHrfyKpgyAAEC1Rqv9T37ZQFinEjx2IOOWfFhJn/vFRt3UHryaw1lVSR69SG4jZKtF36JYBenpVh6aos++LwPdhInx4dpCS76yUA3LlfWyAZ+52r6AEnEcqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717969786; c=relaxed/simple;
	bh=Wb5tJLwBJPwzazeELAb8uvSHdP56hHLRltr2/XlSHSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cti3suapGLlc6w5X+z0H5TpV3j0zvOzgVOg0wWZ4cShcFHXIGoWvmzY/3Jzp9VKMioaXBlCvVO6/Ohapv+wcRPIjh2isE3YqDRdmDZHa5Frz3z0CIDl/3MBBZ521+gC2TQvSsT3kvr2DCFaFGhotqldDYstmi7I7laijwzpJA6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rabZRwXH; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24ca03ad307so2195922fac.3
        for <linux-iio@vger.kernel.org>; Sun, 09 Jun 2024 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717969782; x=1718574582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CQJe0UtQ1jQuwlm6OXR6xFOyW/tArUIKSUvJlcl/w7U=;
        b=rabZRwXHy85Sn36ZB1LlV6hLNa2kcoDvzjpOccwxuMVkwKs9N3OEIHzO7/78s/el2f
         AprKOB0i2vjKNFbvMalwnwmAjnkkUpVaLz2uRMAL5EIzELSJzmUHspw6qLmV9CISsL1g
         JAlCWJsL4cY9W7VAj4217HInI+75xr2l+3u93U8r70m0gDsk8mDMe03H2J0IzEGOHtEF
         Je0ghLYZXHGDMy9mSFLZuYSGYDjyxDm33woIzh7XTVCybxYfG4iX/XTrv1izwcPmx4xH
         bFO2OwXftLE17MBdB4gypMj7YuASK6UZOSS0AfjMxdS/E6/tspUwZ7D2y1ZAQxzaDFH1
         AZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717969782; x=1718574582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQJe0UtQ1jQuwlm6OXR6xFOyW/tArUIKSUvJlcl/w7U=;
        b=LyDg5ercj3+HSF3IltgfJwnA3Z/WUmqe5WRY85vIEz/2DbQQmKwvxLGSyVR3xbrh4o
         fqBrO7AbprXqIKT0LE/zBkW6q2i9NPHngXI/JNqRSckmollB020CglZppPlFuNesJ0iP
         NgdX7N4QJm7rEIEhkFueIT8LLCrYP9sHAGShGnlQm6ppIeVW7hPofLU5PmXkqTdnZaWr
         a/j+PH0J1XLnEeiTferzVBPB0zwiVbrRRZH2ECtHna12RqEa1QpyNq41onJCqOfXvmsK
         xE1KhHmjcOfAG9FzkgjnkicIDyQtV6e7x5Z4/E1C2KSuZtnXo0BMyehxTaBXroOBBaxN
         RRWg==
X-Forwarded-Encrypted: i=1; AJvYcCUbFUmH4s9yV+hFqxzMx2JnSqistKyHVV4pyuSm8+BuhvcajiTsBJPRFqPpW9H0+Ax2NB11VtU7odrcBMi7N/RVODX0qKyZFrJH
X-Gm-Message-State: AOJu0YwAZMdhzdBgQ5BvwBJnF9AtXABV9Muq9HkFAIgXlQr5/VgtZKo7
	T3fdFitHlLtccBDwfvHAdu+SNODGEnYL9tdbWitqXaX/fo5g4/gcR77Y/Nc3KDxSqeBAYCDWguT
	6
X-Google-Smtp-Source: AGHT+IFuCnK66haNuwyuMMntgL1WgOirTGuhY53m78kqAJKqjZ1hfEIGQuKJGYDqtVpGZ054SjIqfw==
X-Received: by 2002:a05:6870:219e:b0:24c:59f7:e840 with SMTP id 586e51a60fabf-254644e9773mr8646820fac.17.1717969781951;
        Sun, 09 Jun 2024 14:49:41 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2544812e3cbsm1965073fac.55.2024.06.09.14.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 14:49:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] counter: ti-eqep: implement over/underflow events
Date: Sun,  9 Jun 2024 16:49:33 -0500
Message-ID: <20240609-counter-ti-eqep-over-under-events-v1-1-74fe1632f5ab@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds support to the TI eQEP counter driver for subscribing to
overflow and underflow events using the counter chrdev interface.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is split out from a series that was sent a few years back [1] that
I never finished, so I'm calling it v2. This was tested on a BeagleBone
Blue using LEGO MINDSTORMS EV3 motors and this script[2].

[1]: https://lore.kernel.org/linux-iio/20211017013343.3385923-2-david@lechnology.com/
[2]: https://github.com/dlech/linux-counter-ti-eqep-python/blob/3745b0840736248d8e60cc675a0f43558fcbb2af/test.py

v2 changes:
* Only clear interrupts that were handled.
* Don't set default QPOSMAX value.
* Don't error when setting QPOSMAX to 0.
* Use regmap_write() when appropriate.
* Validate watch channel.
* Use counter_priv().
---
 drivers/counter/ti-eqep.c | 106 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 072b11fd6b32..9f4ca219385c 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitops.h>
 #include <linux/counter.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -67,6 +68,44 @@
 #define QEPCTL_UTE		BIT(1)
 #define QEPCTL_WDE		BIT(0)
 
+#define QEINT_UTO		BIT(11)
+#define QEINT_IEL		BIT(10)
+#define QEINT_SEL		BIT(9)
+#define QEINT_PCM		BIT(8)
+#define QEINT_PCR		BIT(7)
+#define QEINT_PCO		BIT(6)
+#define QEINT_PCU		BIT(5)
+#define QEINT_WTO		BIT(4)
+#define QEINT_QDC		BIT(3)
+#define QEINT_PHE		BIT(2)
+#define QEINT_PCE		BIT(1)
+
+#define QFLG_UTO		BIT(11)
+#define QFLG_IEL		BIT(10)
+#define QFLG_SEL		BIT(9)
+#define QFLG_PCM		BIT(8)
+#define QFLG_PCR		BIT(7)
+#define QFLG_PCO		BIT(6)
+#define QFLG_PCU		BIT(5)
+#define QFLG_WTO		BIT(4)
+#define QFLG_QDC		BIT(3)
+#define QFLG_PHE		BIT(2)
+#define QFLG_PCE		BIT(1)
+#define QFLG_INT		BIT(0)
+
+#define QCLR_UTO		BIT(11)
+#define QCLR_IEL		BIT(10)
+#define QCLR_SEL		BIT(9)
+#define QCLR_PCM		BIT(8)
+#define QCLR_PCR		BIT(7)
+#define QCLR_PCO		BIT(6)
+#define QCLR_PCU		BIT(5)
+#define QCLR_WTO		BIT(4)
+#define QCLR_QDC		BIT(3)
+#define QCLR_PHE		BIT(2)
+#define QCLR_PCE		BIT(1)
+#define QCLR_INT		BIT(0)
+
 /* EQEP Inputs */
 enum {
 	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
@@ -238,12 +277,49 @@ static int ti_eqep_action_read(struct counter_device *counter,
 	}
 }
 
+static int ti_eqep_events_configure(struct counter_device *counter)
+{
+	struct ti_eqep_cnt *priv = counter_priv(counter);
+	struct counter_event_node *event_node;
+	u32 qeint = 0;
+
+	list_for_each_entry(event_node, &counter->events_list, l) {
+		switch (event_node->event) {
+		case COUNTER_EVENT_OVERFLOW:
+			qeint |= QEINT_PCO;
+			break;
+		case COUNTER_EVENT_UNDERFLOW:
+			qeint |= QEINT_PCU;
+			break;
+		}
+	}
+
+	return regmap_write(priv->regmap16, QEINT, qeint);
+}
+
+static int ti_eqep_watch_validate(struct counter_device *counter,
+				  const struct counter_watch *watch)
+{
+	switch (watch->event) {
+	case COUNTER_EVENT_OVERFLOW:
+	case COUNTER_EVENT_UNDERFLOW:
+		if (watch->channel != 0)
+			return -EINVAL;
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct counter_ops ti_eqep_counter_ops = {
 	.count_read	= ti_eqep_count_read,
 	.count_write	= ti_eqep_count_write,
 	.function_read	= ti_eqep_function_read,
 	.function_write	= ti_eqep_function_write,
 	.action_read	= ti_eqep_action_read,
+	.events_configure = ti_eqep_events_configure,
+	.watch_validate	= ti_eqep_watch_validate,
 };
 
 static int ti_eqep_position_ceiling_read(struct counter_device *counter,
@@ -354,6 +430,25 @@ static struct counter_count ti_eqep_counts[] = {
 	},
 };
 
+static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
+{
+	struct counter_device *counter = dev_id;
+	struct ti_eqep_cnt *priv = counter_priv(counter);
+	u32 qflg;
+
+	regmap_read(priv->regmap16, QFLG, &qflg);
+
+	if (qflg & QFLG_PCO)
+		counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
+
+	if (qflg & QFLG_PCU)
+		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
+
+	regmap_write(priv->regmap16, QCLR, qflg);
+
+	return IRQ_HANDLED;
+}
+
 static const struct regmap_config ti_eqep_regmap32_config = {
 	.name = "32-bit",
 	.reg_bits = 32,
@@ -376,7 +471,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	struct counter_device *counter;
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
-	int err;
+	int err, irq;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
 	if (!counter)
@@ -397,6 +492,15 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap16))
 		return PTR_ERR(priv->regmap16);
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_threaded_irq(dev, irq, NULL, ti_eqep_irq_handler,
+					IRQF_ONESHOT, dev_name(dev), counter);
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to request IRQ\n");
+
 	counter->name = dev_name(dev);
 	counter->parent = dev;
 	counter->ops = &ti_eqep_counter_ops;

---
base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
change-id: 20240609-counter-ti-eqep-over-under-events-8e7ace53d35a

