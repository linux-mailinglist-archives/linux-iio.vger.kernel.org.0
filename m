Return-Path: <linux-iio+bounces-15250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E7A2EA5D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA793A6EBF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6511E32BE;
	Mon, 10 Feb 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7UeFGUy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5E31E04BD;
	Mon, 10 Feb 2025 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185299; cv=none; b=UYsx4dYvxW16SwH6PahIxcCgquWhEAvtGfuQoody18EJparJXdje/n2txUYLlg3CVICk3GyN+BdpRKHeCUu5eL7nQfaHpy/WSHuaP01gT4b+eg1SHIWHrSC+TeRgX/mpkwxp1I4E/NwLPY4I8LmHyU3+sYwgDtO22OQVMBa5yxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185299; c=relaxed/simple;
	bh=Ttjnz9CEb4H/zKxyDBnQf37YaeAwFYqFGMLzqwJ1KfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TswKaQbOTpi+8a96q0WD/EtjaFIrCLKrPpNGhzPTL/rDBvBUKPVTNl0RBYbL+ZKfONj27wnvXWg/eoDeBwkK+DnWGo3FHK0xnvlqBwyi5A5aTZb/mxFlZtdoAUJPLMjaYIO0I3/kfKZpNp5UjMvr3XFY1niZntZHyJewxkqzeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7UeFGUy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7c4350826so8205766b.3;
        Mon, 10 Feb 2025 03:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185296; x=1739790096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUUYm/3eJ6K4O4SEkRHQKdWxE/3N+ctQ4MV2sEbJtcE=;
        b=d7UeFGUyHVr4k6y9TPWO4iRmVjldfE5+6Cnm6a284Iq15KGhystkCreX0YFcGt15a1
         2/z3SYULBgYaYZha286W6lIKw0RVMAPXzKvk+6bCVw48ULvsxnPpKGZf8/PbbVmThTKn
         YXu0b0x+WLlXTNb5rTaXZI6NTelVQcRmnijUjovY8sNdViirerxPJfqdG6kVVtCP/7Ts
         xLYO3zR/2pwUpfvM8Im6FvQZ2fbuWhikampbqOYTYvdNYNXOsNSfoZaf22Iho83AIf28
         Ojt/67V3a/Pk1hyoQZsKnveScdLL1WOJNTotPLgP3VKGKVadyNYtAh2y+CCQwXsR8vml
         rS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185296; x=1739790096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUUYm/3eJ6K4O4SEkRHQKdWxE/3N+ctQ4MV2sEbJtcE=;
        b=wiMMixz15YtZwvJnDSFZyl2rPHV57+UGYuD59K8xnxhBQURQlhn4ghEkTuRO84f/vr
         I03qbKHrO/FW0auqI4q3H5shSdCuHO3jldsYygi0ZS9STX4HvjdF9L/JYMkHCZVgmfzS
         VUNPWLaUZ5RNe08J9+zRu5W+VHjrravw9Y4K2HJcxrHaMsDGph6CueIM3aAQ2nD7DbaS
         o5WNN6NEF/2hf6Q5s+/eFz85wKXNlLoGJMciuuiviLL0z+4DXZmkY2Ks1kHSYonWsedg
         NqTCndnMSuJPlI76FSjuVdkX8gV8Qhee0wutzjQefSG277U/CRnVctcy6Ogvu0FfbeOT
         Liog==
X-Forwarded-Encrypted: i=1; AJvYcCVNDpmTQINfUVR4fGAgNg34bVYDu3mECWA7/uT6mneHsToyM/aV23yD/XiL0pt7O4kL69QQysWA2cR/efI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTm+LUzuHB338TVX7WN3F2Wx09hK4FhU27NuphsBiTiM9MseW
	lAG0MvAdoknJnyw80OsJL1QpXXPbPEll3S4CWtkFl9qCjebjvYgzHz0UTQ==
X-Gm-Gg: ASbGncs95DDxfm3KGrFV0mwQiOUG2qEqDZdMpGrDnZyrLMga/XW7N0RN4mPEZGjIF2F
	VpMXAwxrzhKB9FY3Bj3siOwODeNc7qyOWVa58noekDcTFzZXf0sse1hp47UhHbNkJuFO/TBIayi
	0NXaVrVJNmshII56rxyRQTbcwHJK86VI3KQbfszrpx1vA1P+a7hGQ6b08aJyvMDLo8Y1JuR/ofr
	V+e5BpRV1Qzj5a7MxtciiNwVL9acALPjYcSvOWU07FxNsTZ5ph52HjYkeuMQAqD/wWLMUxA87VW
	00vIyvyoJZatiOKRSY0d4b3ktDqt3DYKehY8MlJ2pdjTgmk/4BOx8qgAU0UQp/b1MSE6Vw==
X-Google-Smtp-Source: AGHT+IHjj5Y0omCrE5Yx3J43H+N0Jh92ZtUKt8kOk0+UARkJyK/on6u3N4vsH4HMhh6wgTiOMl7cWQ==
X-Received: by 2002:a17:907:3f18:b0:ab7:cd83:98bb with SMTP id a640c23a62f3a-ab7cd839b0amr54944766b.5.1739185296106;
        Mon, 10 Feb 2025 03:01:36 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:35 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 03/14] iio: accel: adxl345: reorganize irq handler
Date: Mon, 10 Feb 2025 11:01:08 +0000
Message-Id: <20250210110119.260858-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize the IRQ handler. Move the overrun handling to the bottom.
Overrun leads to reset the interrupt register. This also happens at
evaluation of a particular interrupt event. First evaluate an event
if possible, then fall back to overrun handling. Additionally simplify
fetching the interrupt status function.

Both is in preparation to build interrupt handling up for the handling
of different detected events, implemented in follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  1 -
 drivers/iio/accel/adxl345_core.c | 26 +++++++++-----------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 517e494ba555..bc6d634bd85c 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -43,7 +43,6 @@
 #define ADXL345_REG_INT_ENABLE		0x2E
 #define ADXL345_REG_INT_MAP		0x2F
 #define ADXL345_REG_INT_SOURCE		0x30
-#define ADXL345_REG_INT_SOURCE_MSK	0xFF
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_XYZ_BASE		0x32
 #define ADXL345_REG_DATA_AXIS(index)				\
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 468d562de227..2928c1c0760f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -107,8 +107,7 @@ static int adxl345_set_interrupts(struct adxl345_state *st)
 	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
 	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
 	 */
-	int_map = FIELD_GET(ADXL345_REG_INT_SOURCE_MSK,
-			    st->intio ? st->int_map : ~st->int_map);
+	int_map = st->intio ? st->int_map : ~st->int_map;
 
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
 	if (ret)
@@ -404,16 +403,9 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 	.predisable = adxl345_buffer_predisable,
 };
 
-static int adxl345_get_status(struct adxl345_state *st)
+static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
 {
-	int ret;
-	unsigned int regval;
-
-	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
-	if (ret < 0)
-		return ret;
-
-	return FIELD_GET(ADXL345_REG_INT_SOURCE_MSK, regval);
+	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
 }
 
 static int adxl345_fifo_push(struct iio_dev *indio_dev,
@@ -449,14 +441,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	int int_stat;
 	int samples;
 
-	int_stat = adxl345_get_status(st);
-	if (int_stat <= 0)
+	if (adxl345_get_status(st, &int_stat))
 		return IRQ_NONE;
 
-	if (int_stat & ADXL345_INT_OVERRUN)
-		goto err;
-
-	if (int_stat & ADXL345_INT_WATERMARK) {
+	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
 			goto err;
@@ -464,6 +452,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 		if (adxl345_fifo_push(indio_dev, samples) < 0)
 			goto err;
 	}
+
+	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
+		goto err;
+
 	return IRQ_HANDLED;
 
 err:
-- 
2.39.5


