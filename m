Return-Path: <linux-iio+bounces-13377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B59EDAF7
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF07168947
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755321F63E0;
	Wed, 11 Dec 2024 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDFQpqEI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BA1F63C5;
	Wed, 11 Dec 2024 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958432; cv=none; b=UOfqSr2o1vKQEmWZmscWpQ9Q+bx4FmEgFqZOON7GT7vkkaz3koD8kJ3qp4ryXRDFx841lqOChddgBfpyhUG2YBAZcze7l5SDbcjtghr+0nUZATys0nP0CMeHqWgutBWrcKQXhuwIQUJ1TbLfCLxZMd7Aq4ocRmc6Nrt3jdl/BmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958432; c=relaxed/simple;
	bh=ObTa3JazhoAQcFMklvFSOpfm1xZr71KI3SPq9H9WPvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlxCsk8qFLkS+JL9SE3KhVouggsklvGeqr0jqnXkV+i5QXNHKFVx513QnbYTPwLiBZbBZxKQGWn6/o1ufv94w0SgD0RP84zI8lsXYQb7J1FPrxG40gXlIDVhgOGPwhO0ooryV/tgn0TBl7VsBa+upLOMlq1qy55fUez9O7sxKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDFQpqEI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa659775dd5so63088666b.0;
        Wed, 11 Dec 2024 15:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958429; x=1734563229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNZ2uE9KrjIGOERXYlwpOGPZIPht42dZVF0Un6tFn/A=;
        b=SDFQpqEIlQuVMORJW+FyWk3Lb1QEQnbwV6jZzRelocUXINx7nJocfQXEFpwx7GBWaA
         u+p7k+3xviug8vSXxST9/kRWavq2naoTCqKQykGGmNbkwCzRM8o0WxRxE0ZiFi3BhiN4
         XwM5LFcFSPQidYh12Bli603aCbCfPkRzy9vE1nXYCcAuY4ELIkdFfLi0zpUokyech+5l
         Txw5YWKsaUAcbtQNJC7VgC5IBpW5cQzMt1wUVandc6zUeEIEkzb7L87e3j/U2jGslz74
         l5Cffe6D6UrfQ+u/Ldr0KIgWjx8ySYZ+t+929Z0Prj5/5CIh+M94DDNW6KGb5kTCOZ/3
         R2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958429; x=1734563229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNZ2uE9KrjIGOERXYlwpOGPZIPht42dZVF0Un6tFn/A=;
        b=Y5AmpIAANx9TRXgUdYfJxiZm51fubGg4FstlvC9O7MRq61UOXg590HBh2eSQ7rXt4Q
         PgLCkdUf2a2KYOFmf+xoi8pUGyTjdkotGmDpupLalqbp/b+bc36Im+M7qvdhluJkk+vt
         ghDKOpR3wOYS0oUwNLmTCFWxV/skCwjMk6ymDTZylGwgNu2yQkdT+K10K5fbqVESNsf+
         2ulZgztpKFo1Lf56IDevTJCG2c1q1WoZyNz9XCuyiiWKzS5KbdJvTzua/q4cVICePPYb
         lhSdOXHBzzFZkz3kDycOMbHO1JnvK1gZIjYxj7F5l1WgKkzvPfNidAQchyqY8W03IZyP
         3SyA==
X-Forwarded-Encrypted: i=1; AJvYcCW1qfXr9vEJOSpmVXPbXc1pB1rhnEH5pm3lRIaJcDHXstON7r38g6OSQLwxXlNLbrS1qLLaAGU5lKC6Ptuc@vger.kernel.org, AJvYcCW2ppjxmdFXhtKzk+RTOR/SW5XUePUdHfJpUP53cut2k+EkLD0figbXRNbii4kiwtlvC1KbQ/h9d80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvaMrU+Oh1tLoHAivSbkB5QqfMz61udgIBIpKQ8tQ0Xa9sshA6
	/0we/e16HgaaBjc1uEJ8rUoAJL3XCWDtGBXXMzGHPSzUzKOXu446
X-Gm-Gg: ASbGncuMU1d646RLNZH2f9tHAVbZnaV5S6g0Ir2FCFd2yxXS82i6NUCLFJ7RDFx1uAD
	n0OOzvo1kaocPv8QDy5CTHymgDhqWZkyR9Tls/gBYIpxexyjDoJXIyPQcHtkEzjwzOgK1QwHeK3
	Y5QqOo/eQixu/WgfMXAOzUmaHydrqjM13NZCzBoKwRzNe90Gz/KtT8GqJoKeVpFRToVTZ1QPY/S
	SIrNuwgAJeywSZzrITlhkjJZILNZl9U12cyMWfnrPQvAxfLite/7pqj9AOuzw3XhxcyUEJmcOoe
	cN0zZo3QEXe2nRb3YtmxXJheKn3U+dtf
X-Google-Smtp-Source: AGHT+IER1MdtZVLMQ2vYkNkJUhFmq/aDJi3GLKO4MHNDAmOZdIEWQmMpJy6tfS7sJKI4Qf+4QXDusw==
X-Received: by 2002:a17:907:1c1f:b0:a9a:1a17:e1cc with SMTP id a640c23a62f3a-aa6b0f3f19bmr165729666b.0.1733958428638;
        Wed, 11 Dec 2024 15:07:08 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:07:07 -0800 (PST)
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
Subject: [PATCH v6 6/7] iio: accel: adxl345: initialize FIFO delay value for SPI
Date: Wed, 11 Dec 2024 23:06:47 +0000
Message-Id: <20241211230648.205806-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211230648.205806-1-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the possibility to delay FIFO access when SPI is used. According to
the datasheet this is needed for the adxl345. When initialization
happens over SPI the need for delay is to be signalized, and the delay
will be used.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  1 +
 drivers/iio/accel/adxl345_core.c | 12 ++++++++++++
 drivers/iio/accel/adxl345_i2c.c  |  2 +-
 drivers/iio/accel/adxl345_spi.c  |  7 +++++--
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 9c73474c6..3c2e12452 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -128,6 +128,7 @@ struct adxl345_chip_info {
 };
 
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       bool fifo_delay_default,
 		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index fb3b45d99..fc4f89f22 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -26,6 +26,7 @@ struct adxl345_state {
 	int irq;
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
+	bool fifo_delay; /* delay: delay is needed for SPI */
 	u8 intio;
 };
 
@@ -197,12 +198,21 @@ static const struct iio_info adxl345_info = {
  * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
  * @regmap:	Regmap instance for the device
+ * @fifo_delay_default: Using FIFO with SPI needs delay
  * @setup:	Setup routine to be executed right before the standard device
  *		setup
  *
+ * For SPI operation greater than 1.6 MHz, it is necessary to deassert the CS
+ * pin to ensure a total delay of 5 us; otherwise, the delay is not sufficient.
+ * The total delay necessary for 5 MHz operation is at most 3.4 us. This is not
+ * a concern when using I2C mode because the communication rate is low enough
+ * to ensure a sufficient delay between FIFO reads.
+ * Ref: "Retrieving Data from FIFO", p. 21 of 36, Data Sheet ADXL345 Rev. G
+ *
  * Return: 0 on success, negative errno on error
  */
 int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       bool fifo_delay_default,
 		       int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl345_state *st;
@@ -225,6 +235,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (!st->info)
 		return -ENODEV;
 
+	st->fifo_delay = fifo_delay_default;
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index 4065b8f7c..28d997c58 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap, NULL);
+	return adxl345_core_probe(&client->dev, regmap, false, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 61fd9a6f5..e03915ece 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -12,6 +12,7 @@
 #include "adxl345.h"
 
 #define ADXL345_MAX_SPI_FREQ_HZ		5000000
+#define ADXL345_MAX_FREQ_NO_FIFO_DELAY	1500000
 
 static const struct regmap_config adxl345_spi_regmap_config = {
 	.reg_bits = 8,
@@ -28,6 +29,7 @@ static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
 static int adxl345_spi_probe(struct spi_device *spi)
 {
 	struct regmap *regmap;
+	bool needs_delay;
 
 	/* Bail out if max_speed_hz exceeds 5 MHz */
 	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
@@ -38,10 +40,11 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
+	needs_delay = spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY;
 	if (spi->mode & SPI_3WIRE)
-		return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
+		return adxl345_core_probe(&spi->dev, regmap, needs_delay, adxl345_spi_setup);
 	else
-		return adxl345_core_probe(&spi->dev, regmap, NULL);
+		return adxl345_core_probe(&spi->dev, regmap, needs_delay, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.39.5


