Return-Path: <linux-iio+bounces-13099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4E29E4361
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84381281D5D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF72066D3;
	Wed,  4 Dec 2024 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSLCGH1E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F231202C40;
	Wed,  4 Dec 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336718; cv=none; b=F6eo1y4QerN2i5djURAqjQq3F8ZVl44ex3r1F67E6h6MK2cHPJ+YgWu2T6T3+7GThQYjg+fbiPY8q+IUrhOYlayvf+9qdCBXW1hVzUmKa7l54e3fND31jPJdjjLl+RO5b7+ZwSJsG9IIbhNxOZ+I4gTs0RwdnhOIjOBBj3B3m4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336718; c=relaxed/simple;
	bh=iLDUgU8WNcAh/t6tBH4v0q05mowuF+6hmrNXfHJwFoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lN34XVfa0HIyZuTOYmJBRKms8KbZL3O3UsWzLwcB6ri6nesXSbhHD+SGWMpETG736oWq6gI5WEn34JckIkwN8/vP52IF6g6DSArXQmIPBvfh7zDiWKN0jPTn5nv1RPD7vExzIXjo/+Ysn7uMrtPX1D5Iv/ntUiwqrtSRJFrH1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSLCGH1E; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349dea3e0dso133775e9.3;
        Wed, 04 Dec 2024 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336715; x=1733941515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgoVWnhvP406HqfDsdu4WH7uW2K8Xa/wgeBTdZ1+3jg=;
        b=hSLCGH1EajdoFhd63eFHHOeunGnprIQEROaMOHighvV4i3wO8lDMPxfJPuLu1XUN3z
         w2zBMhlQEOBH24uLnT+4mT1DOasF03CBRf2KJuSEcNAf0FpbS6x2asKbfyxqyZ1FSmLi
         +mUB+H08ACO6a9tQI/nKKJ6RRC6n+kJXcvso/rBETKZUs8Nu7NqB+/6x2QebHJzlhTOC
         IkMB8APXyV9J//Gy7stUXL/3xWUiL+dFhy8mAzO8EPbwxZbsmBRJKNSFMKVXHRiFm4V7
         7mAGVKtl97qV/gJKkXmBTrI8KgQ1Kmc96bq44V/LE30nuPcZ+ZVgauxQCUKXSuIhqvHv
         jIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336715; x=1733941515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgoVWnhvP406HqfDsdu4WH7uW2K8Xa/wgeBTdZ1+3jg=;
        b=DKbIEoMdO2A5mnMz50468iJj+FsbPr4MB5F0PZbhgC5KWqGUXTXH97ROGvm1k1oFj3
         S6shz3gSCs92f3QWEnrlR34E4Lx7+0VwUKVoDf1k4WpoToVWJWQI/5AlOO5iCOgJSUu5
         bRdiQ6kwK74XH2J74eTJVSn/03zXr285XytLM5BLMUQyEK/X/lPxUncjDi5hzOkadz5f
         UQt5Do7mtChPwsOXEi6oEL12VJBjo6ARuUiRbpjTAy+YRJf2BLs6+vvLxZmzODI+oW1K
         Sm7F3bjTUwXpkjvawFaQwRtI4eTwPJ8+eyABIJqg8sHCKrDoiJbSL5gOnQAY5BWMc6mX
         PR/w==
X-Forwarded-Encrypted: i=1; AJvYcCU1e9RZeKfSFgHiSmpUbq1P2jbR603NnhbHWU08qIcGP2cuDtNxYgjuIC8IvwDdiCqDP4qhvTxgwK0=@vger.kernel.org, AJvYcCU6ApsMBI+MJfwhqVFC/vCo7Vx5fDkUmc6QiqTUbo5qMMYp/+oUHOm2kHYeLMfuNTFdcghjF5pGnfRVAuI3@vger.kernel.org
X-Gm-Message-State: AOJu0YzapahyMqcwSJPaUmEz80xip829DOtkGtRqWbSE/FW7UA6euN6B
	ax3GKkzwi2onZFR2JS/ohQyE1zR2o6dN1vGhE3VlNcgwqY+/zenN
X-Gm-Gg: ASbGncuMe/JkGX7ZSZh0ipsou8AXLqhfyJv1WzrFPsOkUrJq1osgBI1gnyhI4ohaR33
	akNF9FMso/gl3Fw9r+c/SkP34ljcIIrLlpL6c4WB3mTGDc0hP1Ci3K2qUd3vjFZnLzDocTiSIAP
	qw8REdZf32iM30k+WnU3LQgUTdOmjejvPlCiOFEhv7ajq/OuXKxvPifMFAdqnKIA2XOwy3iibO2
	XJLU4myFA7dLZxaeBcUY26KfLVxBcJUDcJHXIQn26gQLQPeQEYey0JsKQ06ZaYaMoayUnOrFaYv
	9y6gTBNqC0pjgFUqFvjnOmR0v2e2
X-Google-Smtp-Source: AGHT+IErWUrJvfwAvRKgqHxWUC/Y/1VynWeuYejyRVU2EgvBdjZfbkBC/SO21snZhQAv58/R299m0g==
X-Received: by 2002:a05:600c:511b:b0:434:a0cb:6d24 with SMTP id 5b1f17b1804b1-434d117123emr25322285e9.3.1733336715440;
        Wed, 04 Dec 2024 10:25:15 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:15 -0800 (PST)
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
Subject: [PATCH v4 09/10] iio: accel: adxl345: prepare channel for scan_index
Date: Wed,  4 Dec 2024 18:24:50 +0000
Message-Id: <20241204182451.144381-10-l.rubusch@gmail.com>
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

Add separate fields for register and index to the channel definition.
The scan_index is set up with the kfifo in the follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 0696e908bdf..3067a70c54e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -26,21 +26,26 @@ struct adxl345_state {
 	u8 intio;
 };
 
-#define ADXL345_CHANNEL(index, axis) {					\
+#define ADXL345_CHANNEL(index, reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
-	.address = index,						\
+	.address = (reg),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = (index),				\
 }
 
+enum adxl345_chans {
+	chan_x, chan_y, chan_z,
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
-	ADXL345_CHANNEL(0, X),
-	ADXL345_CHANNEL(1, Y),
-	ADXL345_CHANNEL(2, Z),
+	ADXL345_CHANNEL(0, chan_x, X),
+	ADXL345_CHANNEL(1, chan_y, Y),
+	ADXL345_CHANNEL(2, chan_z, Z),
 };
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
-- 
2.39.2


