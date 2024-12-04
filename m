Return-Path: <linux-iio+bounces-13091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C8E9E4349
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862C328177A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80111BBBE0;
	Wed,  4 Dec 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMCUHovT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34922907;
	Wed,  4 Dec 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336708; cv=none; b=uKfp8DOyVmyXBULabCcmkg+xfuw5cNgkgjLu13O/ohrLgAUzngtQB3LN0V8Uf2Ch15OPHCmtJ/0FhIARuRWVhlch0GuZeAXbaQ1jV+c2UoYkz5A7OgCjm2xGcDRCUPp4XsSfiCFHgSejIbHQ3Hnup2NBbq3109M1u3MUqGm3MCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336708; c=relaxed/simple;
	bh=UvnTsLO5ozk9S3WreBtY5lNgLOymsUczM7dGCW0Qn78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nt1H377E/t8XGCIvlZNMR6qpuot/ZvjE+FybU/hPo3c71GoEy311KInoAJ55YOFIpYnmJBpK+1N7ppMhefjI2JW/jqjpNE+gbBHmiw2DIR+rN5VzC5pawj34X2luDKIocYiHPO+cw2kmMYc2nNkJOCv+PNLdu0XjGVK2eo5ED4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMCUHovT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349d25eb5bso141555e9.0;
        Wed, 04 Dec 2024 10:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336705; x=1733941505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH7SC8VXu89oQ7d/dEv/9qfp3f8Jr/wcNDca9ETQOKY=;
        b=jMCUHovT9eZj3Sb80RBQc72zHyrQnvc0aT1+GGQMGU2mVV1ux9MvrFv2lnoUXW/FLM
         Ude22AQwULzHI1TLhAQJ+trN+3yzAKa5oO5PFLanzLRK8Q5Vjyx3LeBhKJ5++24rsHSu
         UdodAAnXQcRFoM9QwKcbiGXcLPcvhXQw59BAyU4yMq641yrYPcHbzK0vRQi8k1dLnYK9
         O8Hh8XymTebgdymbaFGWwskWuRYwOFd6Qqb6vn7IvssBlnmArQiTS7zKzN5ttiMHgzN8
         lMzwBaio3CqTLOaoVZXh8HyQtxtTU59dXiInR5RNG/rQCh5Jn/emGfKNJtG/RHkpVBWC
         GcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336705; x=1733941505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH7SC8VXu89oQ7d/dEv/9qfp3f8Jr/wcNDca9ETQOKY=;
        b=vleLYZYaqvWjrDprdUQoL5eQ34p0r3pQucnxyJKiwWPCdle0noUqNK/9P9TOWs30s3
         AZ8f7BuV2ksJXxM9Bz77MXjspXpDeT26beXRYo7weUwS9VVwHPZU3w8/80SPduZRAtwo
         U7LqJtHf7Is9qElRL/w0GlaV3D6PGjxLTkotlLm6PMrz9jrlntsMY2kxxa/q0NzxwHR7
         GjP5qfJz4ndmV1D9Rn5i+y3CVp7HQBk7zyRDycmK8Q6T9ITCqGZGmS3CmKav7D3XyDPp
         Ry5M/t6BXhD3rEvNGMqnjm2G8VUjUUzJetcMgCuGlLs9vvI2FAnd8pDwY4rjrgw8SZyp
         DeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh+WCzvrS/jhcRT3/aH4lqCdTRXx2qvKJn1/0CdZQhmUmDvHTrCQDy5oF6R+zx0V99llH/Qz+O/YLiqTZV@vger.kernel.org, AJvYcCXsrSeULna1fW8DU/7Kl6NCM/EqoiSP0z6+I0uxuOjFUI34MI+Q7k5M4dUV3p5ACsocRXzYKwaXHSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSa0FC6SOdjwDKeOhTcX6Z8QNIIaPk4Rp26dcJmNQarm4B4Dy
	PzxTozmWSOcOyiZ1LNYeEJ/2WrbhlgQy8tDVSqw+P8iAlx+8twJS
X-Gm-Gg: ASbGncvKXjZVbrTlf/vGjXfhYsF3cgKAD18Ak3OOv1e3SfGVltty11YhPCgDY5LVh+m
	YWuDy3pd4eDwYnR7Dh1Qd4F5awK0j6MuvLMRzyeka9WtYDt+xh6l0E8T0Z5V1f3eQ1FsfVogoxp
	Sz7OAlr27z9sOLi52sf1c7FPM5FcHAxhC8dQXUDzA8H3q4fYS3R5noETq7KNXZndR6lQfYkiN4u
	LFzOn+ED2R52RODhxYaW+qMto5s79f476Z0nNqKMG0eMxdA1DJzEsrxkD5evz0hvSxnQiDaM58Q
	POoLVUF8fMyUtLpRNBpBbMnuxVZ0
X-Google-Smtp-Source: AGHT+IGZBmaKjVmHGjIVdmGfKhZ87j+cZV0btRRuwh1bnwxC4RdmJmIuFEf3D92eu/EGEmuREJoRkQ==
X-Received: by 2002:a5d:6d82:0:b0:385:e8e7:d0ac with SMTP id ffacd0b85a97d-385fde34d9bmr2258021f8f.13.1733336704890;
        Wed, 04 Dec 2024 10:25:04 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:03 -0800 (PST)
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
Subject: [PATCH v4 01/10] iio: accel: adxl345: fix comment on probe
Date: Wed,  4 Dec 2024 18:24:42 +0000
Message-Id: <20241204182451.144381-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204182451.144381-1-l.rubusch@gmail.com>
References: <20241204182451.144381-1-l.rubusch@gmail.com>
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
index 006ce66c0aa..eb3ce4434a5 100644
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
2.39.2


