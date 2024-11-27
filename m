Return-Path: <linux-iio+bounces-12742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A519DAA48
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DB228168E
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE1F49641;
	Wed, 27 Nov 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HFsMx7CP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7D1E1041
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719621; cv=none; b=RYJ03/uM8SpUnD07TdjG8Mx+mkR67jKyI9j38vdWBfEhc2ABm1/wxk929fu+DgYVyQ69l3iaHwMY9o/3eV+sRHLpWfMj9a6gEPaOAubussI0naKCbF/sqhLdiinOw0zob7agltKbNeEVtWmiE3mh7aVxZCfd2EGo/mO/BiFcDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719621; c=relaxed/simple;
	bh=XOnp+zMNl2112dcr6t0bRq9UBNGqYsZvMxbCUkajCRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvQlYbLJOUPgBA16uLa/+G54kUbk9YCQ4woUCUFjnTd48u4UH9NVBpBNEWdXleVorm8wDlzQfcCh337iISGB/CspTvWaiwoctVIQaZd8bTZIstNpfAaEVed/iuZB/HBuk4AJPV4rrgDO1r/MSKr8JzFaPHJeUZRI60qb0gc5+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HFsMx7CP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so26804185e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719618; x=1733324418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xjbyqC0IEz1wor4H0WJlxb93JVQsScZqDo+jLntdmQ=;
        b=HFsMx7CPhVxOcR97xYlvOR9n4iHiU5lGKB1RxWwr1wB4oy7Djpbvb1e4jzpe4UIh9O
         tyT5LrzXxoxpNqgm3cGYbVqETzFZKABnb09NWA2GbkdiY4TZ1oY83OZwAG6SA1nlqGcs
         b/Cm+GUfjwgMB1zNs9dQy8xfJ89kCFbpwH5oN9hqsyF00uNDv8ap90AbQ3srH/5NJGqF
         dMovr9Tiym7oDZ6z4BlmbjB2lf+HmlzzTwQ28GFwEoGAodMgR1obJHsY1XsYp3Abq/Ee
         VbbGVRdLa+L/vJZnTPknDpaBgRL7xud++08h12+h8/eRaDvLy2NyFD93ICegz+ilPBxe
         s3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719618; x=1733324418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xjbyqC0IEz1wor4H0WJlxb93JVQsScZqDo+jLntdmQ=;
        b=XddCzwEugEfD0F9saXZL5QDhTIITieM6vXlXZBTD47Uy434yY1eAW8iLAk5OOHHMb9
         zjlRpWYHwjkzEnuFyjnpAf0iMIyjOhMP9e3f/TFSP8P7lqARN/MiwjWXwwe6NGhT7Ag+
         uekCOLn4WcIBHrRb4CvJmvqf+M1Jek6DRd32s/hl5YF0Pi8vy+qqrBHV1Ku20zN3zo2N
         P06yfY9yRd56J1IRhAzIgc7fPlnNHwLMqmex9IsGq18bQ6iJdEkwzA03RsWKlG+gL2iw
         8iPDIB1geN12C5ngLfoOniNbIdVYLHr58b+PzKNirqk0H9fp8KeKIWhn2XBC4///Yn9I
         9FhA==
X-Forwarded-Encrypted: i=1; AJvYcCXI8waKMst0ARhH6YTdjHV3zKf1ITGUs4mQNuO/cwGoQ7U+NvXC9V8Yfgt90UtUsFKsr53knln3zns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAavGFiSKUyx9tSK91Syc7Rhe1zbze57LIoTWpvl5fKpMcg7eg
	OAWA0muXP0BVxK8c6BJoy/sJ502TFNoeJoq/IMHhZK+C4CyC5UcCgaYnXd5kwTM=
X-Gm-Gg: ASbGncs6OApLFI6G1lBtbc9UeyAHK2FGipV55gVC4mXwAIFel6MoiPkJ/25kwxytySj
	W7dCkJi853/4N5gtJaKcV5qapar0MmH+XXf7crsyuP1/qAQo9RjMjGSbKOQpwSoBgW9247XF2ye
	/+wwYSh0vF3iHVhl9imS9/Cb/zQDExRz2bdBubiUz7X7NiQ4t7Ri2DCSTRVtJPIFJTEEufnkDYk
	tKZyDEvXdcGT6MD6o5xjgH/8q26fZbVmG+To8xTNDrLQod8KfAVovnqNd5G4xpA6rTTREVUAa2S
	5iBM
X-Google-Smtp-Source: AGHT+IHJRDTrOjqwpoS5LZ7sWn9/h0f3B3JZFqZGpHqNIUxHGaVVSGM+/UgcLO46GTxOsXzdTPP9Pg==
X-Received: by 2002:a05:600c:4e8b:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-434a9df1f34mr30459855e9.27.1732719617868;
        Wed, 27 Nov 2024 07:00:17 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe98asm16384441f8f.39.2024.11.27.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:17 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 08/10] iio: adc: ad_sigma_delta: Check for previous ready signals
Date: Wed, 27 Nov 2024 15:59:37 +0100
Message-ID: <20241127145929.679408-20-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4634; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=XOnp+zMNl2112dcr6t0bRq9UBNGqYsZvMxbCUkajCRE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPneMJMUFU7EF1rUfVxKnzsAm/GrW45ts0nD xRMoS6/5XKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz5wAKCRCPgPtYfRL+ TrOtCACZ0QKMUI9R6nRj3E5ETGz2mqilAV14a7aA2NdorFLJ2tFdbfPO19aKaqhLgWZpzNw2iBg 37aNgtGzLK5OIgclmPc7XcMbhiOsMI+BRdmzxBkYbL2XiCxpus6cFZU92SfXhoNXiDr9L29ZeGP UkNtNXs0bas4CMZVMx4nS3+B5hmVVjlP4CTX3RsvwJSMnR7pILVt9zmf1zNRTo9e1MFYkM7nKMa 4Drz67+UcAxHiBSKa+YbaNk/owE0SNyQaTT4YTiBcotdgvw3DQN7cHFWgPDIpBW+inG8/gbv/lI +ptgk9LNpM6m7y4XIkHCaHUo8vWMCMiJ2nA1+GwWFSriFZaL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

It can happen if a previous conversion was aborted the ADC pulls down
the ̅R̅D̅Y line but the event wasn't handled before. In that case enabling
the irq might immediately fire (depending on the irq controller's
capabilities) and even with a rdy-gpio isn't identified as an unrelated
one.

To cure that problem check for a pending event before the measurement is
started and clear it if needed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 9891346c2d73..164a4d0b571d 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -29,8 +29,11 @@
 #define AD_SD_COMM_CHAN_MASK	0x3
 
 #define AD_SD_REG_COMM		0x00
+#define AD_SD_REG_STATUS	0x00
 #define AD_SD_REG_DATA		0x03
 
+#define AD_SD_REG_STATUS_RDY	0x80
+
 /**
  * ad_sd_set_comm() - Set communications register
  *
@@ -222,6 +225,80 @@ static void ad_sd_enable_irq(struct ad_sigma_delta *sigma_delta)
 	enable_irq(sigma_delta->irq_line);
 }
 
+/* Called with `sigma_delta->bus_locked == true` only.  */
+static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta)
+{
+	bool pending_event;
+	unsigned int data_read_len = BITS_TO_BYTES(sigma_delta->info->num_resetclks);
+	u8 data[9];
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = data,
+			.len = 1,
+		}, {
+			.tx_buf = data + 1,
+			.len = data_read_len,
+		}
+	};
+	struct spi_message m;
+
+	/*
+	 * read RDY pin (if possible) or status register to check if there is an
+	 * old event.
+	 */
+	if (sigma_delta->rdy_gpiod) {
+		pending_event = gpiod_get_value(sigma_delta->rdy_gpiod);
+	} else {
+		int ret;
+		unsigned status_reg;
+
+		ret = ad_sd_read_reg(sigma_delta, AD_SD_REG_STATUS, 1, &status_reg);
+		if (ret)
+			return ret;
+
+		pending_event = !(status_reg & AD_SD_REG_STATUS_RDY);
+	}
+
+	if (!pending_event)
+		return 0;
+
+	/*
+	 * In general the size of the data register is unknown. It varies from
+	 * device to device, might be one byte longer if CONTROL.DATA_STATUS is
+	 * set and even varies on some devices depending on which input is
+	 * selected. So send one byte to start reading the data register and
+	 * then just clock for some bytes with DIN (aka MOSI) high to not
+	 * confuse the register access state machine after the data register was
+	 * completely read. Note however that the sequence length must be
+	 * shorter than the reset procedure.
+	 */
+
+	/* Oh, back out instead of overflowing data[] */
+	if (data_read_len > sizeof(data) - 1)
+		return -EINVAL;
+
+	spi_message_init(&m);
+	if (sigma_delta->info->has_registers) {
+		unsigned int data_reg = sigma_delta->info->data_reg ?: AD_SD_REG_DATA;
+
+		data[0] = data_reg << sigma_delta->info->addr_shift;
+		data[0] |= sigma_delta->info->read_mask;
+		data[0] |= sigma_delta->comm;
+		spi_message_add_tail(&t[0], &m);
+	}
+
+	/*
+	 * The first transferred byte is part of the real data register,
+	 * so this doesn't need to be 0xff. In the remaining
+	 * `data_read_len - 1` bytes are less than $num_resetclks ones.
+	 */
+	data[1] = 0x00;
+	memset(data + 2, 0xff, data_read_len - 1);
+	spi_message_add_tail(&t[1], &m);
+
+	return spi_sync_locked(sigma_delta->spi, &m);
+}
+
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
@@ -237,6 +314,10 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
 
+	ret = ad_sigma_delta_clear_pending_event(sigma_delta);
+	if (ret)
+		return ret;
+
 	ret = ad_sigma_delta_set_mode(sigma_delta, mode);
 	if (ret < 0)
 		goto out;
@@ -310,6 +391,10 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	sigma_delta->keep_cs_asserted = true;
 	reinit_completion(&sigma_delta->completion);
 
+	ret = ad_sigma_delta_clear_pending_event(sigma_delta);
+	if (ret)
+		return ret;
+
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
 
 	ad_sd_enable_irq(sigma_delta);
@@ -406,6 +491,10 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	sigma_delta->bus_locked = true;
 	sigma_delta->keep_cs_asserted = true;
 
+	ret = ad_sigma_delta_clear_pending_event(sigma_delta);
+	if (ret)
+		return ret;
+
 	ret = ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_CONTINUOUS);
 	if (ret)
 		goto err_unlock;
-- 
2.45.2


