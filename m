Return-Path: <linux-iio+bounces-5082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8C8C81B6
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7A81F218E5
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8BA364AA;
	Fri, 17 May 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbLOXQ7E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007D2C6B9;
	Fri, 17 May 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932086; cv=none; b=Sk3WGtSnWXYy2fVJvJHruuemg0excYSFJiUCOuCDEsOkvXl67xBAriss5iZux03JxO13n6XAzGN9FaMdqBE1iBHzF9znp45/KFmIXXwndJzHx6ldv1HPk2QL1VIDrEJQrJCbCDei0j4D/U/6UVJl4XbW1fOpaCECAD06xvN86pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932086; c=relaxed/simple;
	bh=gaBUrEFUVynj2sCVorwDcz41asBIy8HZEKPMsGjdOlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EncLXU3iILF51F8FMuor88k1d+GEAo10M4YAjLg82YD3OjrynvsYCCnhiXdJum2SNJQEGkR7zTRuPk8KXHqCYvn3RWfOVx6zzI3HzohRpTAQZUy0SO2xdRHnhBIf/QLayV4U8CrFH5yRcae+Ibj71+D79ZGwFUymUplqDoADnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbLOXQ7E; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso17068321fa.2;
        Fri, 17 May 2024 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932082; x=1716536882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOo+pbvRtWZONom15kwmr0KzPQ/8pIzCsgN9MAmxo9k=;
        b=hbLOXQ7E6as724TlhQIoYK1xnSFY5+5esF/hLm2y9LRSKFaI5QaOD6BmtbONpyRG/v
         eZYpYN/GlXZAiQUm7zyU8WCRvZJPpXQ/nVcoF3Jfud8ayGk6b+WgyO2qO5RalPI1XXrX
         PCFjxpZlsVYGI2puExwpamFX5HqwDAZq5jlz14qAgwFvHtpB2t9YBcC7dz5eyEb6YkPY
         G6fBy/T+PQDEr6dQ6p25qQC688FMVyhJpe6mZ4ROPpq+4Lm1q0XDfIrV3I/eC/ZSmuL5
         EG2E2BrZLzp0jSeXVcpTOm8y0A/aXuLUbEQvT3M+XN4P7BAnrKPu5mQnw8fzYUU+UkdQ
         9MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932082; x=1716536882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOo+pbvRtWZONom15kwmr0KzPQ/8pIzCsgN9MAmxo9k=;
        b=rnL+OOeDttrTR+LR/onXo2fglKOLHivJtngoPLozICRbAv8MUOWxKQ8gLJsFgdnpkp
         3n5q0jJKkONo6fv5k5arhAFevZKvIrZ6zooa9aE5d/8H67RQ9/a6/KGWKpbzH3NLOtnK
         c/ruQPjs4OrVuNfX6zmb8IZHt07gaiB9AD+vOnXxbczTRsiJWOQ9aYbFPahT1CFuwjgU
         n6D96BnXl55pqJO72/tq+X7s9SYaB895FxGh0s29cvvT1dkvTU3epBbUjeEJqZD4uJ6O
         g+WbrBjWs0g6VnsLeUfCa8AFDKl3DKusRM6gIUiQz26tUzEkbrAdGlGUCBOzeXy8cRkQ
         ORkA==
X-Forwarded-Encrypted: i=1; AJvYcCUKf1WEGSDPK9T0N4l7fCAFl5V/pakOb3Kqq2Y3HlDJnalGpZCrJNx0IVt00/k+gZqphgGnkJ/nu2eAsjU//CGTicAPhow70a2KO8GT0MTTuSf5j2BCcZZzA3aLhaME+5R9oI6iww==
X-Gm-Message-State: AOJu0Yy/FfiRdlC6xSx/nTSEXt92CXu0vhNVMUHMcfYFQLg2i7ZcCvpI
	07WFtG4fLxhsiRbrBxV25j4btfELU0kFH+WTxGCrNibZEzC9Z+gY4JrvqDRlAGc=
X-Google-Smtp-Source: AGHT+IGqBfCCz5oZGn2uraZaY9GVMlIUEGVItJ03FgXFFJlZip/rfOtXOLWw2Bs5ZdFp7lrJYTm/ww==
X-Received: by 2002:a2e:a54c:0:b0:2e1:f5d3:a6a4 with SMTP id 38308e7fff4ca-2e51fe589e9mr165062831fa.23.1715932082021;
        Fri, 17 May 2024 00:48:02 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:48:01 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v3 7/9] iio: imu: adis_trigger: Allow level interrupts
Date: Fri, 17 May 2024 10:47:48 +0300
Message-Id: <20240517074750.87376-8-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, adis library allows configuration only for edge interrupts,
needed for data ready sampling.
This patch removes the restriction for level interrupts, which are
needed to handle FIFO watermark interrupts.
Furthermore, in case of level interrupts, devm_request_threaded_irq is
used for interrupt allocation, to avoid blocking the processor while
retrieving the FIFO samples.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v3:
 - new patch
 drivers/iio/imu/adis_trigger.c | 39 ++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index f890bf842db8..becf1f558b4e 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -34,21 +34,16 @@ static int adis_validate_irq_flag(struct adis *adis)
 	if (adis->data->unmasked_drdy)
 		adis->irq_flag |= IRQF_NO_AUTOEN;
 	/*
-	 * Typically this devices have data ready either on the rising edge or
-	 * on the falling edge of the data ready pin. This checks enforces that
-	 * one of those is set in the drivers... It defaults to
-	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
-	 * don't support changing the pin polarity.
+	 * Typically adis devices without fifo have data ready either on the
+	 * rising edge or on the falling edge of the data ready pin.
+	 * IMU devices with fifo support have the watermark pin level driven
+	 * either high or low when the fifo is filled with the desired number
+	 * of samples.
+	 * It defaults to IRQF_TRIGGER_RISING for backward compatibility with
+	 * devices that don't support changing the pin polarity.
 	 */
-	if (direction == IRQF_TRIGGER_NONE) {
+	if (direction == IRQF_TRIGGER_NONE)
 		adis->irq_flag |= IRQF_TRIGGER_RISING;
-		return 0;
-	} else if (direction != IRQF_TRIGGER_RISING &&
-		   direction != IRQF_TRIGGER_FALLING) {
-		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
-			adis->irq_flag);
-		return -EINVAL;
-	}

 	return 0;
 }
@@ -77,11 +72,19 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	if (ret)
 		return ret;

-	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       adis->irq_flag,
-			       indio_dev->name,
-			       adis->trig);
+	if (adis->irq_flag & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
+		ret = devm_request_threaded_irq(&adis->spi->dev, adis->spi->irq,
+						NULL,
+						&iio_trigger_generic_data_rdy_poll,
+						adis->irq_flag | IRQF_ONESHOT,
+						indio_dev->name,
+						adis->trig);
+	else
+		ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
+				       &iio_trigger_generic_data_rdy_poll,
+				       adis->irq_flag,
+				       indio_dev->name,
+				       adis->trig);
 	if (ret)
 		return ret;

--
2.34.1


