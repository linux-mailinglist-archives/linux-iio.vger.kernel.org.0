Return-Path: <linux-iio+bounces-2803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3764285AE8D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 23:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E2528503D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 22:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098AC56B76;
	Mon, 19 Feb 2024 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W+6Fy/Tf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170C54FA8
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382101; cv=none; b=T/tiYVmrE9ZK5X9zRR0UbR4suDUs1Nyj7w5hFBCV7HrYo6AJBIO/Kw1HFeLMWzQzRvMMXS5iAvyvlrDO/quDWGSFEyNrS6NcowPwXweO44zCGwkNSOMFDrvU2WSiVbqDCtHOy4Ct9a3z4JFXzS9b17805CiFBx04mVMxuGf8ENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382101; c=relaxed/simple;
	bh=ha0zApPrKXA3SwGVUgjy23s32EsrJI2UFXFPZrDIckk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pD4oYz15pkN+NiBjzqCl4a6l+NVBzmw5+hSe39bqD8OfhLIwIVXYzd4bczxT3EiaDlZLIoB4XMzNq0ATW4HHyXOJMeJ2f0QSyvtYwcbr5ax5nWHjUWscwW2LKwnJ9ebGZng+DV4ZkJkzdezG6g/zLLajIULpGEZPaYB5jJpsNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W+6Fy/Tf; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2edb28554so1450599a34.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708382099; x=1708986899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiEnyHrsiH+BHrvR4qpLSBhsawzqJKIHbW1KRtu4mJg=;
        b=W+6Fy/TfrSv1+iMfwiiv2OlGyCMpy/mRk2YFAnCsXFBUNS1uieUojpJwUXgyKk0wzK
         VZ6JUp7kC8SzHDZDdO8g/xakacMuyjd4LtSlmNbP3vK2lXD7TRyjVZnAEvasK1/ESpqg
         OrabYAMTJdFlCdJ8QMjv4U3SvU2ZwH57XD2oUXtCJ10XQROuk0n2mARelqfIQoENCvpS
         NFqxQkKlZFt08J5f+tghI8lBTjZ2Y9q7sGlO+ABZZq0FYVsVNyxHxeUhtafQOXMplfhJ
         dEnUi8VKmeVtFABxUeHKW3WVyxHFolu6c+yt+SOQDoGjuuEe/4gtBSUtT6/xjcYgalek
         HNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708382099; x=1708986899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiEnyHrsiH+BHrvR4qpLSBhsawzqJKIHbW1KRtu4mJg=;
        b=uLVgAQEM5esQC1Kan3mP0zHqBOX2MwYXWMflNO14UFKK8SvoWfpG7biKhsc743fl8y
         tn+4WhDJQYa7NA04wc8qiPs18dk8qYPzxqFRnsvQn4BbEN8sT66VggvhAk4PU8gFzMTq
         bJkYuC0a8/uDxHnBWbRVnim3l2QTRVPnmpxW/sjvqpWyQ9ZbISgp50IUyywiNJXWzvtd
         zowFoZX933s1xgaES9TFZBo7Cnx477wMm0PNLpgEfakBix2ZxMrsaT7CgDXtTTf4E3mf
         1qzD7QgSl+/YSwRcgviIy1TVyNNFrvu6EN6LS+SqVp6M+s/XvHKS4psGnpoZl+oORb4N
         Rsog==
X-Forwarded-Encrypted: i=1; AJvYcCUV7zb7fLhVFCDgUESzDLqUPeFwkhuxruw1Qgd3p44BSqSaiKr3dvY7Gx3wQMaK8CPDa+enC9+5hPFBkR6PjTANupJU3NDDyYQh
X-Gm-Message-State: AOJu0YwQuxEx59M73QJXysILFEJn28daa2uDxT7JQvOQTFyx5+YVC8H9
	gA3i2X9bg6F5rnpoAYRNBAb03VyJCvHADP+1/MU7whBEZWz6afYUeKvn2dhHJdI=
X-Google-Smtp-Source: AGHT+IHGLW0jWfaSjhHMOVF9xvUXiSSL99uSISV2aKB6gkc+n1TPuLNFLEUSx9bHBGaXBwNUybqK9g==
X-Received: by 2002:a9d:7a97:0:b0:6e2:d93f:376 with SMTP id l23-20020a9d7a97000000b006e2d93f0376mr13724839otn.8.1708382099209;
        Mon, 19 Feb 2024 14:34:59 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id h25-20020a9d6419000000b006e45a5f0a70sm171776otl.49.2024.02.19.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:34:58 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 3/5] spi: stm32: move splitting transfers to optimize_message
Date: Mon, 19 Feb 2024 16:33:20 -0600
Message-ID: <20240219-mainline-spi-precook-message-v2-3-4a762c6701b9@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Since splitting transfers was moved to spi_optimize_message() in the
core SPI code, we now need to use the optimize_message callback in the
STM32 SPI driver to ensure that the operation is only performed once
when spi_optimize_message() is used by peripheral drivers explicitly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes: none

 drivers/spi/spi-stm32.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index c32e57bb38bd..e4e7ddb7524a 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1118,6 +1118,21 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int stm32_spi_optimize_message(struct spi_message *msg)
+{
+	struct spi_controller *ctrl = msg->spi->controller;
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
+
+	/* On STM32H7, messages should not exceed a maximum size set
+	 * later via the set_number_of_data function. In order to
+	 * ensure that, split large messages into several messages
+	 */
+	if (spi->cfg->set_number_of_data)
+		return spi_split_transfers_maxwords(ctrl, msg, spi->t_size_max);
+
+	return 0;
+}
+
 /**
  * stm32_spi_prepare_msg - set up the controller to transfer a single message
  * @ctrl: controller interface
@@ -1163,18 +1178,6 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 		!!(spi_dev->mode & SPI_LSB_FIRST),
 		!!(spi_dev->mode & SPI_CS_HIGH));
 
-	/* On STM32H7, messages should not exceed a maximum size setted
-	 * afterward via the set_number_of_data function. In order to
-	 * ensure that, split large messages into several messages
-	 */
-	if (spi->cfg->set_number_of_data) {
-		int ret;
-
-		ret = spi_split_transfers_maxwords(ctrl, msg, spi->t_size_max);
-		if (ret)
-			return ret;
-	}
-
 	spin_lock_irqsave(&spi->lock, flags);
 
 	/* CPOL, CPHA and LSB FIRST bits have common register */
@@ -2180,6 +2183,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	ctrl->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
 	ctrl->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
 	ctrl->use_gpio_descriptors = true;
+	ctrl->optimize_message = stm32_spi_optimize_message;
 	ctrl->prepare_message = stm32_spi_prepare_msg;
 	ctrl->transfer_one = stm32_spi_transfer_one;
 	ctrl->unprepare_message = stm32_spi_unprepare_msg;

-- 
2.43.2


