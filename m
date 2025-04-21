Return-Path: <linux-iio+bounces-18469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C92A958F0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354CB3A37BA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3F21D3F3;
	Mon, 21 Apr 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFRkAb65"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598C1F5828;
	Mon, 21 Apr 2025 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273219; cv=none; b=OxavmQW7OSU4LfEoTF0toXJCHE0oonzj7EHTitaBpzlHJIrLQh+dX00964cLifwfbDh4670xKLUeQyq7egoIWzC14G2q0obu3rGxu/3o1Cd6vFDbfcm39wrza6CRkcz97/k8B9FH62YLt1gNCeo4Ma69JKuTjAeyKcZW2Qcs7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273219; c=relaxed/simple;
	bh=fM3+KC/UZ31kXPGTb5S0rsSfrRmlbZY6btYAdurQouc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXsqtr7pNzWVVHatN47d8ojEBH0wIXTsW1h8A53Ub7r/vDUUK1wG7ri/1P/3yaJ/jxOk7TXtzIAI4QSfsFq5dIffgUVRJi2Z18MdyricF6++EZ9c5PVUGCB7sph/0gvxoZiC7GRlnqWlDhxolaE6iYPWAjlk3/b/RKy+ET3Dk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFRkAb65; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f4aee67d24so687119a12.0;
        Mon, 21 Apr 2025 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273216; x=1745878016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL1NluBLKnVOXTYYd19e7pbv7E9LsYXKQXHoL8wk6rg=;
        b=TFRkAb65c0eK3khgHfBQ7rPVt7FZzH2DwJONqPmGXZQ7VlAngKPugMUFVcnquB04ca
         aTIob1Hr9kBsz6TyhUjeBhlFEWVpYHHV677cMtJR7pcX8RQqCRaxcVX/8h2SqpY4+R4E
         FqIn5lruT1+v4ucX8zbmrdz88pRt0NlzlFvD8MU+YW5/BSKJJUfod1dTR9YinoO9F93q
         drRrpLDf03v/i1OAHv1oFP0IS77we9DrHUlItp/UQSs3B8wRSNUZSFxDICRI8u0er/Tc
         +YKAkCZlAMmSweSOvyvkENztK2gN+tOMjQq02ZJjD1RQ8quLe5vRV3v6MGsE0xBJHbXE
         ooIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273216; x=1745878016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL1NluBLKnVOXTYYd19e7pbv7E9LsYXKQXHoL8wk6rg=;
        b=M1D6ZKHCtaXw2BJ4/VXBI2f8mRnmnp4zRk/CLvcuCaMw6mfjJtFbrvR7StE0IOTplZ
         KITHyI5RM4noSP0CYOE49sdVCauUx5Vo7X4Rw8voipTY4X7YQRmroF6QArH3SV1PDphF
         hQbfUrZaVvBkahnCUQA/53WK8jr6hrUCKbE2VhdVsvA5RHhuk/PzINSjZmbT3mx1zRtR
         QMu4IVdVUWzL9EmY9BycvS7IbmLI7NVDl/rGyNNKS0I6Ia+J7P5AaYRZRpRTIC1lF/wN
         Z+KvUi9socMefI/EeqkBOZPrygnEo3qB/yC74Acn4geBC1MXScjO9UREEXUti8L2SzzU
         N5+w==
X-Forwarded-Encrypted: i=1; AJvYcCUAiE/QUG8peTa5jdsdNoDUVFoIncusiDhYoLHj8FoT2++zNyDyXb6M3jWSjQ4H+xS0TSqO78FEK0yfcrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtFrt+qMXbrpUjY7Bh20mE4cTVvUnRlFQnPRJpRijy33igygr
	cLP7oQftahhlAahERZsaMYcyn16rPzXkTRHNBGP2vAcefUfm3OeA
X-Gm-Gg: ASbGncsS7pRb2UWUn0wmBoH0DbWYZTQMnX8GRLqtT7ei8FaUqr7vvPKq8r253KgdUrY
	sWJztfjep2Cdf8bJvjlGpfaCzqrrKYV6Ht53k5ahOU4O1ONDYqcLMVCsbxtrkH9Xdbl/Sk+xUny
	+YelnrpvzMVeQEQGDPMdAEp5yC5BKhLSkvgAsmJCURo+VxTPHgfQEYCadKyPV0V9Rm7YeVokKU+
	YFthre/JaJHYrUmom9LIx5fTDx2i6XnFqoHEsx6a/rge7SueMxO6Xi9nkfotSdQIUe7+w2XPXbf
	uFsTMqk2R+cmkBxQu26ITp8pFK0e0EuzG0fuD2EtUAaiYffj2dpaVn9Vlu0pZKS8Gfc3OmRfXz4
	vcfNPwsMGceLRGk9XSJw=
X-Google-Smtp-Source: AGHT+IH+fRia38DTj1g36lg7EdWidY7DqmWEJrkD8mTIjY/97kotxU8uEUvUp65F/KfYxnyTWfJgjw==
X-Received: by 2002:a17:907:dab:b0:ac7:3911:250f with SMTP id a640c23a62f3a-acb74ddae97mr385152166b.14.1745273216025;
        Mon, 21 Apr 2025 15:06:56 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:06:55 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 01/11] iio: accel: adxl345: introduce adxl345_push_event function
Date: Mon, 21 Apr 2025 22:06:31 +0000
Message-Id: <20250421220641.105567-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421220641.105567-1-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the fifo handling into a separate function. This is a preparation
for a generic handling of the interrupt status register results. The
function is supposed to handle particular sensor events, and later to
forward them to the iio channel. This is needed to read out the interrupt
status register.

The function shall return occurring errors, if any, or 0 in case of
handled events or read fifo content. Thus migrate fifo read-out and push
fifo content to iio channels into this function to be built up with
additional event handling.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 1b4d9e60c87d..a98fb7fc748e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -416,6 +416,23 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int samples;
+
+	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
+		samples = adxl345_get_samples(st);
+		if (samples < 0)
+			return -EINVAL;
+
+		if (adxl345_fifo_push(indio_dev, samples) < 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * adxl345_irq_handler() - Handle irqs of the ADXL345.
  * @irq: The irq being handled.
@@ -428,19 +445,12 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int int_stat;
-	int samples;
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
-		samples = adxl345_get_samples(st);
-		if (samples < 0)
-			goto err;
-
-		if (adxl345_fifo_push(indio_dev, samples) < 0)
-			goto err;
-	}
+	if (adxl345_push_event(indio_dev, int_stat))
+		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
 		goto err;
-- 
2.39.5


