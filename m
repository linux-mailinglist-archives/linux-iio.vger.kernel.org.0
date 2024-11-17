Return-Path: <linux-iio+bounces-12347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFC9D0509
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 19:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5457C2821EA
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578C31DC1BF;
	Sun, 17 Nov 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIHIso4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2971DBB3A;
	Sun, 17 Nov 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868102; cv=none; b=pmrGYJbOoTqea8ZOsj2dV5zaAtQHoeEvhZ0YJko5hrSOq349tkC2ccJaCfzQ0fdGc9AiW7or+8QeQhWO2TDy5e51wD78MB92rXH+7dK4u1PqYr8Enwmjm9FNPVPXF7eIyXvjp+rLj9t88XBur3oWdKiM1e4Ikp3OEy+qWj9tPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868102; c=relaxed/simple;
	bh=3g8EJa9v3KFQJgxIp7akK5FmRLEB6X6D1rMGZs8BgCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhtbK7WkG+FWQV22ybMBDQz0+bp2pre2HLZ9xuH9FHM/pJo+S18/3+2hNG4wBKxix2QCUc89WKjIM7P2uBt2H6iN2GgYjJWzsF2iRiPVT+AmxEEptz2YW6KlLKIxitcZWr7H4jlFd9b7hiTlD1j0M0qf6ouQR91YMZ9iU8PVuJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIHIso4D; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3824430afbeso58147f8f.0;
        Sun, 17 Nov 2024 10:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731868099; x=1732472899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6zP1PdamDLyXOAG7+hHqQLojtOTjSGamcL0fsR/t5E=;
        b=KIHIso4Dl5mVmCwLabgcfDdV3p93gdLyBaO8q2K+f0BswcVryhOtKE7XQPSqV/s7H1
         J6UC7lii5EwsooziBF+18QZgkW11Tm1djyZ0Nhv3iHsVs5AYTOu/CFPI/sRTq/5bv/Hc
         bDFc8DQKawago26F5ga5JaEB990INSxVreXRg7LgzFqbzdWNhl9LX4zLBq/Iu9qNMYCA
         Dzj/NEuzfwAWsGcU2hE14LwBfOW51ZmdmDc3ZAJiOHHodLo/kXhWjDG6QijVFqce/hGi
         O/dp6t5cx0qBjWYfOi1Rti8LwYjWnhUUXlKNS4kVb6wDFn/2xr2VO9jfIVtSLXnlbDo/
         4/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731868099; x=1732472899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6zP1PdamDLyXOAG7+hHqQLojtOTjSGamcL0fsR/t5E=;
        b=iltFsBLPlj8usyoedtRh7MsKUvz9hv+0og8qFWu7rUqoG3HgyqzMkvU0nhGThsshkG
         28dawU8qRtahWkihWfd/cxjBYasnkTLQEp4jnTADY3QwZbRRtaqQDwdlZA4/4Ov+IYD6
         5pC8TFK2eWVC/kAcZEvOzLCKmLMPhE6jnKi7+xCgWa9+e7IYsv/rTrxiRKD9+ShBMcZv
         x+M46K9bTObxRIYQxNjTfSOKmMW+Y0w9zzjW0bK7t1r1JG9ShPhb27g6F3gCzwVE1vOY
         O0+ilAbiNJD6YmldDw3PZhKijRX1DHCY1b97HXte/ZQp3NqH+iCJk9/sWspL2zKmqWe5
         TXSw==
X-Forwarded-Encrypted: i=1; AJvYcCX5+3G6jeR6aI6WgAeTEDGu1ZJjaA2ovIl+JVAve4LPoKYlU5RwiTGgGf64nskt2ISoooorPaZdMMUe8TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmCYsAhqYhX75WGeyl6wOjAzqc+LQ3M0VjsiotB0EXwqyUNIOD
	ODyA8ePVKSGZsaXwm5d/Ry2Bjzek6GCp/ZZGK3RCM7BoUyhruo18
X-Google-Smtp-Source: AGHT+IEUX8Mud1MCrISvzI8R5Hgm7Um+vAbFPgPYMOGMEjM0bmqIVKaDPZpgBjf4rMj7wjni65oUOg==
X-Received: by 2002:a5d:5f4b:0:b0:37c:d0d6:ab1a with SMTP id ffacd0b85a97d-38225a92b39mr3254225f8f.12.1731868098753;
        Sun, 17 Nov 2024 10:28:18 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823f72441bsm3028137f8f.101.2024.11.17.10.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 10:28:17 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 04/22] iio: accel: adxl345: rename to adxl34x_channels
Date: Sun, 17 Nov 2024 18:26:33 +0000
Message-Id: <20241117182651.115056-5-l.rubusch@gmail.com>
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

Rename the "adxl345_channels" to "adxl34x_channels". The driver
supports several Analog accelerometers equally, e.g. adxl346 and
adxl375.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 30896555a4..2b62e79248 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -33,7 +33,7 @@ struct adxl34x_state {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 }
 
-static const struct iio_chan_spec adxl345_channels[] = {
+static const struct iio_chan_spec adxl34x_channels[] = {
 	ADXL345_CHANNEL(0, X),
 	ADXL345_CHANNEL(1, Y),
 	ADXL345_CHANNEL(2, Z),
@@ -203,8 +203,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = adxl345_channels;
-	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+	indio_dev->channels = adxl34x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxl34x_channels);
 
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
-- 
2.39.5


