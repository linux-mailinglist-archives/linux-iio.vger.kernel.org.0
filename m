Return-Path: <linux-iio+bounces-5257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A388CE2CF
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27ECE1C21AA9
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274712BF39;
	Fri, 24 May 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ1YKuZ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8212BEA7;
	Fri, 24 May 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541250; cv=none; b=oSGAnhw5Dhq6Ab/tm/ICLnEL0a515wkHngl2RxKiInXVXQIXOTXHR4wqF+ZZwcrAxzcYquyyrLxLkkSevHtEATr10NHU+v9d9lNUux9kfZwrmVIGxYgWKKLJRQLdKMx6lLIY1s4uzL5gOBcwgsBY0KXl9ZHnmHx9euHyFGa1ilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541250; c=relaxed/simple;
	bh=sSc8c1pBVmHLpkGIXCa1+lmPKQtSxtX34tneM1GexaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiBMKe/S/A9CG9lhJmKyc7FbegHCYnwiITx269v5RqPqckz0c4AZ49RgURfxcQR4FWAdWm/6Qed4oLysLc/3UAoY1gAwhvWRPfhkTHEs3w3JvZc5OScth+vjkrnpafrHCJCH/cXQ/mOrgaN5jD+aExNbeRhBYPxjxriBBYw9r/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ1YKuZ/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a626777f74eso65485666b.3;
        Fri, 24 May 2024 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541247; x=1717146047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hdBCcOjX/vYrSd+IAUroicc5YwP1SKectAPpq4Y804=;
        b=MZ1YKuZ/pCwHMA6uhYFY0Jb5gF45tqdT2FJjrlPfU1G4pb17nB6XEZF9cwUvy5PMRo
         jWLpRqPnWb4rdIbiHdqpF2gQJZvo5ufOmD3mvE011WkS+5hw1mrbzUBO9RceHKvIkj6I
         aHA/UW2yuv5xmC66S9vK6uMHBzQsLrwvvGUX0G0MVQ/KhTB88RFhjQmvqClXc9jhFpI3
         CwzKMl3LdsOaPVkH0XoAup5NbcgNICI66FL+jVrgzI0RfjIOG0za8xxuO3f8ti7b1naz
         /KSDgrG5DPIjtA6ooNrfS+4rydLHLBIHXb/aFpY4ULRzzxz6uyDjMFvwGncvd9cJ75VV
         bFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541247; x=1717146047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hdBCcOjX/vYrSd+IAUroicc5YwP1SKectAPpq4Y804=;
        b=w1Mq3xj8c6n+L/MKPVWhebTxRKieRAqAl3nz5pIkPDhRtUw0XfBD1CFw2pw4cPnIrR
         2n0bM10KaRYWJOhLvhcXHBfC71fYIa7PJbqLV/qIz1pxRzHAXdI/TFk6o5gSKwQyrU0E
         H42WSJvlNqTO7QY1I5StA5DI8YsEDJLJC0BwPsLjvHl4+TAf4Q36kkzzp7l2Dctd4sIe
         mCwxBi/dLrbqaiYeocWbQQfFAtvZCLqOmbliQJA68m/x1vXgTsKK4AbF14BY5R51xLXC
         WkeHjNdBMVFOUeFYRh4MlACBpjOFADTnyY58fD/1v1mNuYeY90kgpuE0WNWw6dM7oCKO
         6VdA==
X-Forwarded-Encrypted: i=1; AJvYcCVlzzVALRfdTvbhIKJ4Iqx/P/TE/ANW/FYFRnNBQZPO9M8cFC3t0PyGtCQXp+8v22Pwtoi1nHWL7vUoDVxXbLgRzlZ1o833PURLI/r6Lq2FPtD7XasKCrjYN7iSgdRwnz01pD+ltA==
X-Gm-Message-State: AOJu0YyJZDlH7SZMI1JospePgk4hmVr20hOSULUMVm2VNqYWwtuTZd7f
	2gS6bRbzt0O3hc1fk7dX0reQIXwf2eJIO+soz6QTSnPG1XhjrP6fSRY6hjhFyfM=
X-Google-Smtp-Source: AGHT+IGtuJ9N+hQlEnnzYSFRAy7JuCjIauSvVof1ESLPCsObe1Fe+H4UhUW/73OFR3VOgw/ql5vDpg==
X-Received: by 2002:a17:906:f889:b0:a59:a9c0:57e6 with SMTP id a640c23a62f3a-a6265157bfamr174708466b.75.1716541246945;
        Fri, 24 May 2024 02:00:46 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:46 -0700 (PDT)
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
Subject: [PATCH v4 07/10] iio: imu: adis_trigger: Allow level interrupts for FIFO readings
Date: Fri, 24 May 2024 12:00:28 +0300
Message-Id: <20240524090030.336427-8-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
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

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
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
index 8dda3cfa5773..4d4cdbe155b2 100644
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


