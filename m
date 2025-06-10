Return-Path: <linux-iio+bounces-20388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37653AD4550
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41CD1713FF
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB628750B;
	Tue, 10 Jun 2025 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+S9tnaK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65044285412;
	Tue, 10 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592788; cv=none; b=ZiHGgfI7Q0JnZBUehuFM9tC2gymiGzQOARKt6LzC0RjhD0/Uwtm8KahuNMuZVsORBYY6DkhD75jLEg6J7NHMg3uhFWPbbWJMY0asvBayFBZN+NKXe7ObZUy2DKrk8oIsCJ+SAemW8vims7xIqt5mjjymLgGiizGDXENI9Tf4TgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592788; c=relaxed/simple;
	bh=8vHmggxLoSxfMCfpacFahdMv3fo81otuy0QGvoZZLrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0JC3oTDu6fFh0s9cOj3cmphxjiHf8PpPok6JFrs1NZG6MMS2kuHlL4H3nC8vQRvEHbh1iiLP4LyWaYfqPs/LA5vamLEpZWuSxwzj+JnCCfaBsaD+xfY8qPmaRHIY621oImRyWwzBjXAzTNtZlOhKx0fikoyLGvO/XdyIoGttMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+S9tnaK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4eb4acf29so736555f8f.0;
        Tue, 10 Jun 2025 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592785; x=1750197585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQlnrgZ5mvFwl5ucyOyz9AjeVps6b8rGKCvnmyIQJ6Q=;
        b=W+S9tnaKabGI8injmoPnrVe93jpV0YWfuemnqxBeIsZApMOhKo0dNcfnXe8k/isw3v
         lvf7xdCpS6yzkeuIvqmc/S3VKSMYfPKGVTdPWopapV8uPa7zxiNw3Ww1ohiV6Cno1MH+
         miMo9bixKHxVVTSltPFSWNTgnH39eU9Plwpdah7nhV/ValMXpM7u61U3Z628vWJx0NST
         5H/zAuuXvOw97jESPBbF5JaM1UILgfm5UaZ+egeUV5maBMHUs/udboyXdGYyahDNbW5u
         7jqk+RUPzUDdsJqZdRRh0w4TKn2PePG3vEaTYT202MdNbHLMYfpuBOIM3QcD+Zc8CYTm
         h47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592785; x=1750197585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQlnrgZ5mvFwl5ucyOyz9AjeVps6b8rGKCvnmyIQJ6Q=;
        b=MucV3pA1K50hoPWuKdj79NJdyI8aHUQCn14rJ+EdUSqDN7KUeGopJRWV54GpXPW7rW
         MNyCb8ntqwgCoVJYKMhXyhfiEAkDH7cdN1rTTpTzf784E3FtkHmWuq0l9g5L1SHcG5+J
         aXpJTynv70wPDTZ4izgrajmH0NgDHeyHZrTyKJN7pr+WGxsYH4GHzcjYjZei86az10sP
         hc3MeN/8SRZHjy8gDK32jTN/cQSTB7/arGxokdpOf3MBV/c0rHLIaS9Y0BxeqapiU+T5
         9BVfoue2SZvGuNalbEP0QTauk6yRSxTYKIozLKlKl1eCqC2Y6vWJx5VClsX42keGK71Y
         4eSg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7EdKhuOo/sBbW+SmFbYSSmTKSG99AB5I5AaqdZfBl5guH/EHaVyEwUuXtAFVFtqA85BdSE02PO3O2uL2@vger.kernel.org, AJvYcCWGiGTSTRNoBosjnk5QgoWJcKau18x1XxEpv+EbER4Jtet7NqostH9VZztotMJQYimuKhaEUdHSo4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouthsdUxgG0AiVDaRDEArg0MdirFqcMP/HSMbHm9YSoR8/U8h
	hxfKIsMtUhMJdrIXO0u9ybp1WyudtOqde9n1rT2aY2CG2EzD4U4J519o
X-Gm-Gg: ASbGncvdzJd9AaIbE+uZHfWHKB3iMkkKstu5gKzXpy3LacH+PHaQfemAk0ECULDelVX
	Y6qLIJMXvSesoQFoKWtZd6dCiO1RV5qw9DtsHkRneJaZHbeh+em23bUUcZrmCRCrCYrJ6+AXyzW
	yUGJEXd7P0y06pW5Lg0nu9t0ob4smSx5FbZLyhct7TW0OLLxvCbeerm9VwDG4QoxKkGUCSy7s3K
	1ZTdKu0MtsG4YFmHZqSMXxbcwl/YHEKYj8DnIvnU9r3zVAofsbYC5W8Li1Q4FVd349P/f8Gcadh
	cNk/7pl26aBpj5Kx5CNYjDAUG1yTC+DJziuKQU3z3rYTT+Wo04tPCryXq8zHyjTlNzprTSTifbP
	WhLdTsS78uF8cG2+4/7cfH9H3FHyOtdN4
X-Google-Smtp-Source: AGHT+IEVotE5JhRIqghzgJ0R3Mj2ZNKwZd+LDJtLlXSc7+CSygYJpqFTOdi3cz8bCtjsMrpuzlzEYA==
X-Received: by 2002:a05:6000:26c1:b0:3a4:f8a9:ba02 with SMTP id ffacd0b85a97d-3a5586b8858mr199514f8f.1.1749592784654;
        Tue, 10 Jun 2025 14:59:44 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:43 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 02/11] iio: accel: adxl345: make data struct variable irq function local
Date: Tue, 10 Jun 2025 21:59:24 +0000
Message-Id: <20250610215933.84795-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove variable irq from the struct state and make it a function local
variable, because it is not necessary to be kept struct-wise.

This is a refactoring change and should not impact functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index d80efb68d113..07abab82d093 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -133,7 +133,6 @@ struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
 	bool fifo_delay; /* delay: delay is needed for SPI */
-	int irq;
 	u8 watermark;
 	u8 fifo_mode;
 
@@ -1119,6 +1118,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	unsigned int tap_threshold;
+	int irq;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -1203,11 +1203,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
-	if (st->irq < 0) {
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (irq < 0) {
 		intio = ADXL345_INT2;
-		st->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
-		if (st->irq < 0)
+		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (irq < 0)
 			intio = ADXL345_INT_NONE;
 	}
 
@@ -1232,7 +1232,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(dev, st->irq, NULL,
+		ret = devm_request_threaded_irq(dev, irq, NULL,
 						&adxl345_irq_handler,
 						IRQF_SHARED | IRQF_ONESHOT,
 						indio_dev->name, indio_dev);
-- 
2.39.5


