Return-Path: <linux-iio+bounces-13045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1A49E2E06
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25794B38711
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C920898C;
	Tue,  3 Dec 2024 20:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mID2fzOG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF62500DF;
	Tue,  3 Dec 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259187; cv=none; b=OXvtc81vB4IGfGPkOzOKoMpUadNLBOhM3rgrO9y4F+6sbpxclj8qrsaSgIfZSA1mLzuZ38iYYEnfW2Pi8x1TV1POcthfGa/mHbReYiRDMV2bn/MUrEnwr/gVO5YW1sARdepWYSQ6y7IiF/WSIix34NKBUKGrY2VlNcodCiw8p/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259187; c=relaxed/simple;
	bh=7vOYvY5TbPZmGbexNGwjy2JQ7ZwrhWQ6zfBBqyni0HA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhPyfWawy9cmwP9A0pANQ6ivKfHmvu3nOtqSs23J+yo9dKHqISUN1+qOiryok6XGyw98vWJx327DaMUpkAZ1Vrcgqbq4/e/XujFjvoEgxffdWPmVCi6HJRLGjCqCIVm0+qQeKFydvS7o1Hdlc9vNDMGlPlCzuqocZ8b4OMLR8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mID2fzOG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e971a2a0so195374f8f.1;
        Tue, 03 Dec 2024 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259184; x=1733863984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlNuitTZFZCo2sl0s4Qjh5ZaAlabXpVfXzg958L8UNc=;
        b=mID2fzOGZZYvzMHCau65MIhrmnfVP8hZ9KkH02BmsbjJCLLWSOA9vnTggffvQTqqsl
         nEUAUv0IRi83YZKKbltU3RH6p1Yp2lQDAeaSpqPDvkTUVoWdb4eAkOzXKNQou/vh1mcd
         ZP+K5HV0szpo41KnhChgftzz7VkplUF3QyQC7FADObM0L12a6wbst3d2mVHel75RawjN
         2i1KBMGd6yEnMlYts40muPWeuPL147Y665FldMOFVbn7kklgApsnb6ZVZmdP7FQtf1Bs
         bf2u7lC2Wljt9nputg55zKXEzKgWPHDMTi/cQpUUaI/z/GJjvrhdO4C1juwB3/1zdTDI
         puvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259184; x=1733863984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlNuitTZFZCo2sl0s4Qjh5ZaAlabXpVfXzg958L8UNc=;
        b=dcCN/I/8t0S9S5b1nyhz1yrfkNGmNT6Mk0EpaUAj3zlS/CNP9IZk0Cqc9gaNKLT5Tv
         c+7vyIf7tEiQE0VNjy0fNf4G3QhoEc/2NNiBoCUi5o4j6EkWXtWibwGrGKo4wpCC/cgV
         /Z+DSR4zs2F3i/FgWI0j9bh6fe59MWR96nz+tF4HxEOBcw60UmFaLVCknkVvYo3mOcgS
         NU5Pwj85qVZgXZfLulInStkOu7MCaKD9Oef168Obw04uhr3dQc09C9ZnnrUFTF0mrDhZ
         Aj6z5VgBDsbB23zMifMf4YdSLqEpoKQJfZLKuX9PEwpwoyoSEBLEX1AOzdxbWAKR8tPA
         ky4g==
X-Forwarded-Encrypted: i=1; AJvYcCVkhWCU1irR9wOxAgcubchprDqnMKdqx7O3QHXhLdAxWVJQxksBCxAWuF99xgCdfqyuxn38QT1CDf92AMjl@vger.kernel.org, AJvYcCXTaNakvtcri5qtRAPbZj3SQjrVS1tGDkSXsLFX7r9wkuL7TlhN+kpqmkO6PNx543Hw9KGIxxzuCNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68UWYP57FP9aREIH/hadCRJhUj4a5t32CJH3jTB2b2udvOFbS
	aUKgaJ7uss2Y1QepqUwUWs7U3tZIej9zUixZLZMlKGnO3Vf0Udiu
X-Gm-Gg: ASbGncu6DTWy99KwX1TsP9EOvk8CP5nnZgxe0+LaTJyx4Yq3k8Qnhxup/DLoYfHyrPM
	nyqrVv5ANKgG70o9S37phpOiM2UHWWyfsW8/ntPasRnzwEu1M5p7BOVVgOgeKFRsWfHhSc5Yp4s
	EQ+Nk9JtLgtV7JPfcjBAqWIUiCgWV+roL0ULIdcnRetbB8wtU11VBZ6vGR58uvkLlGIeMQmz6Lx
	gtSc5zaXKlr8SM+jPnR+1L3LAjIAo/R32tuvytOD0v+7mc9ty4ivsbELBEAoxIazSg9dBzf9JB2
	7R95VknW0yuBhXssACFI9N79r5Ie
X-Google-Smtp-Source: AGHT+IFyDkmUF3rc6sE3VH83woRWDaACftxSHJ1QZYWXQFmOur5Gk92I5nHz/okccLD6kp2HiQPeEQ==
X-Received: by 2002:a05:600c:138a:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-434d22fb82amr11161225e9.7.1733259183955;
        Tue, 03 Dec 2024 12:53:03 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:03 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 01/10] iio: accel: adxl345: fix comment on probe
Date: Tue,  3 Dec 2024 20:52:32 +0000
Message-Id: <20241203205241.48077-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203205241.48077-1-l.rubusch@gmail.com>
References: <20241203205241.48077-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix comment on the probe function. Add covered sensors and fix typo.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b1efab0f640..cf73d7052e9 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -169,8 +169,7 @@ static void adxl345_powerdown(void *regmap)
 }
 
 /**
- * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
- *                        also covers the adlx375 accelerometer
+ * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
  * @setup:	Setup routine to be executed right before the standard device
-- 
2.39.5


