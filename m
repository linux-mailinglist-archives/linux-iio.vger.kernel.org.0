Return-Path: <linux-iio+bounces-1546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F582A14C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 20:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6351C22677
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 19:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB534EB37;
	Wed, 10 Jan 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YdUX1Pq7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5BB4EB3B
	for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59898a3db56so599540eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2024 11:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916272; x=1705521072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGJNLPLyI0esp3kiyP6ekV4MJE/CQ1txcBdZozy1qY4=;
        b=YdUX1Pq76By7xCBv/J0TNuqf+K4DeKMAjdxNFoln4YpV3JPYDimyHzZ9OKy0jWvPnv
         I9g5aFG2jnjg+0Ieg7J7KYEi77+9tGnr2EPFGJGj+ywmm0YYVDUeYUZCWOPErIzQOiCp
         ZXPcya2G/X44xaT0h8x4CSnCaryhgiO3diTTJJb3qcVenWhDiHySWTVb9ngvTmEkrnYT
         X8bsHNWnEie8hosmA2b0pmo4cLhPpkAquYaHubQu5kWkHYQyQDvGFDV1Cm9TE2Z6h4th
         GtP1YCNc2pZCZNMsWVH4QuLdJ88MvzSEEhda/L7k4sZKX180Ajiwm5VeOBTYa8tXLmsP
         iCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916272; x=1705521072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGJNLPLyI0esp3kiyP6ekV4MJE/CQ1txcBdZozy1qY4=;
        b=pOByUU0Gt6gngJYeKyoX3Fj8oWeNwmT25QpIT+Xhwmj4hqz4OOGu2/+lOTLMqkvOUN
         s7P/iJ6uKfrtbzpdlp+zmSl7yKcvRttoH0dhKnqvmKVGZZno2s3zVZn61v36Mqeir9cR
         R/QuInukF+qyDlMe7VbdedpaqcECYq5sT6MK8q0HyYQ9ZVsQCV+EaHeRsd8TTidN3A1f
         AW7tzgLV01XvOMFdkf5nUoAYH97B5YKo4zTQasympdMTs+cHAac7qvncESHzYS1LXXZA
         j1hiekRlYRLoO1d7GD0UOLgPANVo8PQ5rBdqgDv+AZRCWLDBiVzQcXg9jRbqanwEalHb
         jjgw==
X-Gm-Message-State: AOJu0Yy4m2SwjB5VyRcUMlfLrVA9bvVYeVnE1WK2wHU9NoXZ8Fhz+Jp0
	+FVBIPugNXNnw7/c8OYLz0xzNqGf2KRNCg==
X-Google-Smtp-Source: AGHT+IFqQsQrIOCFpE4RsIKPQ3gHKMPk+6t2PPhDGvVXODesiyE6VwJfYeEefY+r+svD2MqX1koi+g==
X-Received: by 2002:a05:6820:2406:b0:598:6fb0:ba36 with SMTP id cp6-20020a056820240600b005986fb0ba36mr130528oob.1.1704916271980;
        Wed, 10 Jan 2024 11:51:11 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:11 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] spi: do not attempt to register DT nodes without @ in name
Date: Wed, 10 Jan 2024 13:49:44 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-3-e42c6a986580@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

In the DT bindings for SPI devices, it is specified that peripheral
nodes have the @ character in the node name. A SPI controller may need
to create bindings with child nodes that are not peripherals. For
example, the AXI SPI Engine bindings will use an "offloads" child node
to describe what is connected to the offload interfaces of the SPI
controller.

Without this change, the SPI controller would attempt to register all
child nodes as SPI devices. After this change, only nodes with '@' in
the name will be registered as SPI devices.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f1d66b5d5491..5be5e654284c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2379,7 +2379,9 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 	struct device_node *nc;
 
 	for_each_available_child_of_node(ctlr->dev.of_node, nc) {
-		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+		/* Only nodes with '@' in the name are peripheral nodes. */
+		if (of_node_test_and_set_flag(nc, OF_POPULATED) ||
+		    !strchr(kbasename(nc->full_name), '@'))
 			continue;
 		spi = of_register_spi_device(ctlr, nc);
 		if (IS_ERR(spi)) {

-- 
2.43.0


