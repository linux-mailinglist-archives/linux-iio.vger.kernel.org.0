Return-Path: <linux-iio+bounces-5333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24568D04F9
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8051F21A19
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A6176FBD;
	Mon, 27 May 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM2I+4yu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B59175549;
	Mon, 27 May 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819994; cv=none; b=gnW3fns8ItnmW95KopZdRqfEWf86g0eK1257E5bPLnj+KQdZPjGUmKVliLixmgFYrAqotZWvvi0PzTB+jjeH/Dg31pFhKrJ+xczsWoOG6ePGb85MyKIhyBc+vymMMHEtz6fxSkwrfe3dxB61oM99tC2DqAVW9SheLWWlpvME25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819994; c=relaxed/simple;
	bh=yh+TasERANMix+jpMiSplpGWjBHeYhWj8AW2OgwJrV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOxnEHiirpjieYGKwMIH++jIFIlYq0zxcX7nI4PvXYrP21j91F02UVfjvTmznq4k1/N806B6WqrtbsEyKR8rgKldrQywbmOrQ7JJP6xJUe0PLX6b5db+ZDFW9xrCZgmmr37nuKnYBebnl6VN/Cuc3c1wnFbrQh9mUDv5Pl09cbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM2I+4yu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420180b5898so79655695e9.2;
        Mon, 27 May 2024 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819991; x=1717424791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIjddxmJKzBwWGsefndtkFyAnes9Qkvcjr4RnjfZePM=;
        b=AM2I+4yu9gYZ4CeNFJqGEMhTihoTVSCg1xfUZdgwXnvjf9wb1qUp3eKlaIboondUWN
         b1lcbduBtFIprSEigEeahn5xNpYvGmkK2I1kXksT93dXOTc/OLkYqqURaaEmgLRWv4zi
         ILlZnHE3SzHwsgg1zfyymMEThvjc9kHtgHeLgC9U+mGsJtWPhG7qt6934a33g6idZsGv
         Fo0bwjhMPDwGHPI2MK/GGjZdETm7o9968n7CDxrROo63bt5gB8s1aMzbRQmzhgXRJhKR
         N+C73uQd9TfdnK2Qup/7C8vNxfA+uMZRK+rpWLNXP+WX33PwJ6BC5AN+5QGr3wGqXVlE
         ZReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819991; x=1717424791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIjddxmJKzBwWGsefndtkFyAnes9Qkvcjr4RnjfZePM=;
        b=ayuMjX24hsyLhyp1NQEl93pwoFUb0az188Y/tISTve3+GFhYHKoNzu3ISoxa9pGkIg
         onot0iRoUnJwzEVqYThv65n5BiV5QYWNVEJPu3gll9s3QLDJKIRtRYQUpwWkBG6qV0a4
         ofX53Zwp1LeIZmM6NlZbJSitniqgxGu50XW+IavIqYullXXu2WUqqUmO6LzMxcOZJwCT
         nO0eEhvNhNgf9jggSwjhS5gKN+3D42lDAdfX0vfA48/W94vHO0I9K2GcvgU3eWevAbvR
         D8ORvfATtw6lHO3+UJZAs/XwaeS4ZO639hBN1b8JXFr1Tl7pbSnmdSw64x0ERRMCLDg6
         PO0w==
X-Forwarded-Encrypted: i=1; AJvYcCVE3OKFybwwMP746ULukg451SmDb2DrlcjXCdnWKReuilUNrjQb5N6MyloHq5IYGCLTxB78eT+5V97HE22J5TelIVk9ZIxNPvL7frocqV9awxdEsr4ePjhbeTJ6OL+XKy2ZJdrnew==
X-Gm-Message-State: AOJu0YzXt4PQeKsCzsx5jZn3WTT33kG4u3Y0atwrOPUBOWz0IvK501xX
	1OI+ThvViDgLLnpZ509LsKiXCakG1Mxt+L6UwCi3O5DEWC42ujjSLxD0ftnoi9Q=
X-Google-Smtp-Source: AGHT+IFdN7ZzYBSrQIaG1yeKUiwdpLje5ykW/ZJOly9c74eRPSzKiYz8urudK1fCTmBi1GCruxtYcA==
X-Received: by 2002:a05:600c:1c02:b0:418:e88b:92c3 with SMTP id 5b1f17b1804b1-421089ccf5amr68780655e9.2.1716819991355;
        Mon, 27 May 2024 07:26:31 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:30 -0700 (PDT)
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
Subject: [PATCH v5 6/9] iio: imu: adis_trigger: Allow level interrupts for FIFO readings
Date: Mon, 27 May 2024 17:26:15 +0300
Message-Id: <20240527142618.275897-7-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, adis library allows configuration only for edge interrupts,
needed for data ready sampling.
This patch removes the restriction for level interrupts for devices
which have FIFO support.
Furthermore, in case of devices which have FIFO support,
devm_request_threaded_irq is used for interrupt allocation, to avoid
flooding the processor with the FIFO watermark level interrupt, which
is active until enough data has been read from the FIFO.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v5
 drivers/iio/imu/adis_trigger.c | 37 ++++++++++++++++++++++++----------
 include/linux/iio/imu/adis.h   |  1 +
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index f890bf842db8..a8740b043cfe 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -34,17 +34,24 @@ static int adis_validate_irq_flag(struct adis *adis)
 	if (adis->data->unmasked_drdy)
 		adis->irq_flag |= IRQF_NO_AUTOEN;
 	/*
-	 * Typically this devices have data ready either on the rising edge or
-	 * on the falling edge of the data ready pin. This checks enforces that
-	 * one of those is set in the drivers... It defaults to
-	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
-	 * don't support changing the pin polarity.
+	 * Typically adis devices without FIFO have data ready either on the
+	 * rising edge or on the falling edge of the data ready pin.
+	 * IMU devices with FIFO support have the watermark pin level driven
+	 * either high or low when the FIFO is filled with the desired number
+	 * of samples.
+	 * It defaults to IRQF_TRIGGER_RISING for backward compatibility with
+	 * devices that don't support changing the pin polarity.
 	 */
 	if (direction == IRQF_TRIGGER_NONE) {
 		adis->irq_flag |= IRQF_TRIGGER_RISING;
 		return 0;
 	} else if (direction != IRQF_TRIGGER_RISING &&
-		   direction != IRQF_TRIGGER_FALLING) {
+		   direction != IRQF_TRIGGER_FALLING && !adis->data->has_fifo) {
+		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
+			adis->irq_flag);
+		return -EINVAL;
+	} else if (direction != IRQF_TRIGGER_HIGH &&
+		   direction != IRQF_TRIGGER_LOW && adis->data->has_fifo) {
 		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
 			adis->irq_flag);
 		return -EINVAL;
@@ -77,11 +84,19 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	if (ret)
 		return ret;

-	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       adis->irq_flag,
-			       indio_dev->name,
-			       adis->trig);
+	if (adis->data->has_fifo)
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

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 0fe3a2f63033..4bb0a53cf7ea 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -85,6 +85,7 @@ struct adis_data {
 	bool unmasked_drdy;

 	bool has_paging;
+	bool has_fifo;

 	unsigned int burst_reg_cmd;
 	unsigned int burst_len;
--
2.34.1


