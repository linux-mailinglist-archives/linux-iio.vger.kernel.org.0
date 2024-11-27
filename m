Return-Path: <linux-iio+bounces-12741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E09DAA47
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA616775E
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5801442E8;
	Wed, 27 Nov 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xlimx/87"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AC22F19
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719620; cv=none; b=q+hhnZPEpjW2GrmIBBpKpEgcSYnzoRHUVhP46j7bSDZ5iSNUBYcpHXk2x09dYrmPI1BOkCoDJMzjLEjx8Vnnznbo51pCvLD6kG0C8kEjozJJHUW7ujpxjhzvXRa/XDBV+B7nchhKzwjwCh7AbeLFEyjpxL/7A/ehC5q9393IW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719620; c=relaxed/simple;
	bh=2HKcFo7TQCrQ4num0VNgfMdjg/saRUqyt2yVyJlKlYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKWwqzEWL++Nv78bgSVlyjoxgF/iwvsnzbrN9FH9iWxY2C/Nug/x7YR+K2JuvyJ3g5qfvC8MmwrTXtfqXbmju+CQ4/GzGkk+Z0jQIrkVZ+QLG33nCAX4FvLhtqG21dEg5wvGuypTch+l1PZMg8nqSg/NO3W4JbZ5L+ufRTnmziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xlimx/87; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434aa222d96so9239035e9.0
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719616; x=1733324416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaSD2JbxY7n+JgrJBd0cmajEwrXt3LIZm98N5Js46JA=;
        b=xlimx/87jEeY09N9ryhjUiCaZBUGKc9iS4oaMfzWzZZRE4oqTGqHxmv4lErEUzUcb3
         Lzmb6+OiLg3Y9ZJZHsMZH52IjBWX5/aN0W0WfirboCng44NRdfA4G64LANuYuyFCbgiH
         O6aCtMoj1+81TPJ6mg4KzgV6tODSRW3ah8qL9045qS/gId8nQflHfkNJgjhcu93XvoZC
         ioi/xYKOtqz6WIT7M2cwXg9My3VUfizrJZXgGigWRCGezY3oQJegMJyJYvEYtxFXTU8F
         QS9IjtwsUOkNf9I2hu+uaBJr1jZIfAcJRMfGUStvup6fu8GA2U8u0aEPZHPTRadaRwtg
         vJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719616; x=1733324416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaSD2JbxY7n+JgrJBd0cmajEwrXt3LIZm98N5Js46JA=;
        b=QBvm7+MmgKUOxttKB50vlNGwiwYwbjwBWtg36mWcKilIZtCdkYHrVif71Az2VWFMLp
         9w5bXvQDrM8R6I+ITN/n9CjYPud56S/Gy3DrIIkc7p2qM2SDkNjRmJ4SrhEf+j3rlJmd
         2xxdlTs9Grt9ERQvj5pinojtFApixZq6q5XKvW6B1Bj8APwjEBWVjRD/A/89fIBIGhqK
         Jk+B2dXW/Iq7QtBp37TnulFMNlp2ACU12Pk393hLKP4HFNqTpjx2pPZS/A81lcBfDnus
         IH1qTdgQBXCQYI67iY/Ly8/76/RYz8tBuRKebYa9nCuyNh22tMTENhJkCKPyiHnM/ycQ
         vw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlcw/9LvnkoqySQbdtcKnxEIjAFzn1mQAplYT7kFxRjmkLraRFPQPyasdt/G/MjVwk6mNFS9Pt0Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTYWUhNxC1SnK4Ig/0fGV2vDY7cgmM2uPvniyDc4vnBgN9WoF
	hz+6meldKl+VY6AdvQoSs90U7p2q2L5k3moY4CD4DozyzYmW1jC/9m3yn+kuIuY=
X-Gm-Gg: ASbGncsmF3oyweUg0YCJmuume6uulSp+f9pDGFQylYt8P+sVTq0bTR2hux/2deMLztC
	JE0xAUIFckC+vHy7I3+/gvN8InrJuL/ZpROghFf4QEs5N76MgzXNOS5+6S5N7FfAo7DiBtHiYGV
	6KFsfep69dEe0TEB6KuFGtM5CWJeTxL26PJduFuME39i2qoiyIiLW1kzMAcz+FEi7QlC/IPgPh9
	lIv5YFpZAn0bUMxLqaJJ81kGO+I21+3DjLblStbnrmhILNXilc+8JFEdtEqO1GQ2zJG9wtIUFgh
	nc/F
X-Google-Smtp-Source: AGHT+IEDmnMfYAIh7Erf5LSYpx0Oeb2Nr8EJZ9NqrpieQDGM1uY5046kpUVWn2+Zb1Jbq6fEyDiRQw==
X-Received: by 2002:a05:600c:2244:b0:434:a8ef:442e with SMTP id 5b1f17b1804b1-434a9dfbafamr36710345e9.31.1732719616347;
        Wed, 27 Nov 2024 07:00:16 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7a45d9sm23337335e9.2.2024.11.27.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:15 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v4 07/10] iio: adc: ad_sigma_delta: Store information about reset sequence length
Date: Wed, 27 Nov 2024 15:59:36 +0100
Message-ID: <20241127145929.679408-19-u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6415; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=2HKcFo7TQCrQ4num0VNgfMdjg/saRUqyt2yVyJlKlYY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPlfPehvuD7NanA5CU+zAVsKAUhDZ6URvb5T rJan46pg8iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz5QAKCRCPgPtYfRL+ TkpHB/9nd3oOYYrO7ZvheRWJP4Xjc01u355/UhXbreM+7UqilBdpuDa1VwNPD28Ci6NXhjzvuhJ V1FI1yPlP2L1vqCDtdbraMsFIDp6qYCNYzDL2EWyU4gpYVh6yLw/icYQWNO92SEK1mVqtMFeBse hRPaUEjhm45ez2scPUxFG1J22uUc2jIEbJ96kbeSRdJujYGx99ZpW//b34AOLPdTZ83BWw/Ais2 gg6fDEjg03lGYOe6lLnVuW0oq0/+vecyINwHSWZRbAQfZqqJV18FEoanhpjoy+xJu5OUlb+0k35 JrV/z3yjPoQOFhOoGdeIeRXVR8+QjvUC+biB4TUPFSvv+kFJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The various chips can be reset using a sequence of SPI transfers with
MOSI = 1. The length of such a sequence varies from chip to chip. Store
that length in struct ad_sigma_delta_info and replace the respective
parameter to ad_sd_reset() with it.

Note the ad7192 used to pass 48 as length but the documentation
specifies 40 as the required length. Assuming the latter is right.
(Using a too long sequence doesn't hurt apart from using a longer spi
transfer than necessary, so this is no relevant fix.)

The motivation for storing this information is that this is useful to
clear a pending RDY signal in the next change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c               | 3 ++-
 drivers/iio/adc/ad7173.c               | 1 +
 drivers/iio/adc/ad7192.c               | 4 +++-
 drivers/iio/adc/ad7791.c               | 1 +
 drivers/iio/adc/ad7793.c               | 3 ++-
 drivers/iio/adc/ad_sigma_delta.c       | 5 ++---
 include/linux/iio/adc/ad_sigma_delta.h | 5 +++--
 7 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 1f3342373f1c..b17c3dbeaeba 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -571,6 +571,7 @@ static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.data_reg = AD7124_DATA,
 	.num_slots = 8,
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 64,
 };
 
 static int ad7124_read_raw(struct iio_dev *indio_dev,
@@ -756,7 +757,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	unsigned int readval, timeout;
 	int ret;
 
-	ret = ad_sd_reset(&st->sd, 64);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 0702ec71aa29..2550194efee8 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -744,6 +744,7 @@ static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7173_REG_DATA,
+	.num_resetclks = 64,
 };
 
 static int ad7173_setup(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7042ddfdfc03..c4dd48edd8d9 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -361,6 +361,7 @@ static const struct ad_sigma_delta_info ad7192_sigma_delta_info = {
 	.status_ch_mask = GENMASK(3, 0),
 	.num_slots = 4,
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 40,
 };
 
 static const struct ad_sigma_delta_info ad7194_sigma_delta_info = {
@@ -373,6 +374,7 @@ static const struct ad_sigma_delta_info ad7194_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 40,
 };
 
 static const struct ad_sd_calib_data ad7192_calib_arr[8] = {
@@ -565,7 +567,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	int i, ret, id;
 
 	/* reset the serial interface */
-	ret = ad_sd_reset(&st->sd, 48);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
 	usleep_range(500, 1000); /* Wait for at least 500us */
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 86effe8501b4..c7509b911835 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -254,6 +254,7 @@ static const struct ad_sigma_delta_info ad7791_sigma_delta_info = {
 	.addr_shift = 4,
 	.read_mask = BIT(3),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 32,
 };
 
 static int ad7791_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index abebd519cafa..0767c56bb442 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -206,6 +206,7 @@ static const struct ad_sigma_delta_info ad7793_sigma_delta_info = {
 	.addr_shift = 3,
 	.read_mask = BIT(6),
 	.irq_flags = IRQF_TRIGGER_FALLING,
+	.num_resetclks = 32,
 };
 
 static const struct ad_sd_calib_data ad7793_calib_arr[6] = {
@@ -265,7 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 		return ret;
 
 	/* reset the serial interface */
-	ret = ad_sd_reset(&st->sd, 32);
+	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		goto out;
 	usleep_range(500, 2000); /* Wait for at least 500us */
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 9abde276cd17..9891346c2d73 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -178,13 +178,12 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_read_reg, IIO_AD_SIGMA_DELTA);
  * ad_sd_reset() - Reset the serial interface
  *
  * @sigma_delta: The sigma delta device
- * @reset_length: Number of SCLKs with DIN = 1
  *
  * Returns 0 on success, an error code otherwise.
  **/
-int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
-	unsigned int reset_length)
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta)
 {
+	unsigned int reset_length = sigma_delta->info->num_resetclks;
 	uint8_t *buf;
 	unsigned int size;
 	int ret;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f86eca6126b4..eef87d04eb6b 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -54,6 +54,7 @@ struct iio_dev;
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
  * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
+ * @num_resetclks: Number of SPI clk cycles with MOSI=1 to reset the chip.
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -70,6 +71,7 @@ struct ad_sigma_delta_info {
 	unsigned long irq_flags;
 	unsigned int num_slots;
 	int irq_line;
+	unsigned int num_resetclks;
 };
 
 /**
@@ -181,8 +183,7 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 int ad_sd_read_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 	unsigned int size, unsigned int *val);
 
-int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
-	unsigned int reset_length);
+int ad_sd_reset(struct ad_sigma_delta *sigma_delta);
 
 int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val);
-- 
2.45.2


