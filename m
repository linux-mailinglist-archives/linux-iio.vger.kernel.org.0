Return-Path: <linux-iio+bounces-26036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BFC41A49
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8694EEEA3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156E32B993;
	Fri,  7 Nov 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SpilTQ1A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3F30F552
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548827; cv=none; b=t+oxjCeeTMkRBGtM1dCH7o5SsXPEb86+k/OG4QTXtMU+ExW9IGErL0GFBsbV3YKuHw2+YGPCPuafYLxLm78QuSRnkTqts4WmKFDMCVvkRjWYqaZnPjuHmECZOQeRJDN+yux1CwT+KG0/ZuaxPBMCuaTB/SoCNSGcrI0A03+ZIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548827; c=relaxed/simple;
	bh=m3Yc3h8a9bxGpNVO5hyPaXHQTJt7h6UIrZKHv6/FSx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LstUFF6jm56HTq7NPmRkfjy6AQ0QuWD6xorYEC6OuCCXxJB8ZpbXdfrBrRCKc0LMLqiKio+5gcz/DHqoIZa/PGPPNZtpTTvCl5p+wuZhh+AqxEX41dZ8U+KlgGaWA6h2UuvD+SwhQzXgN3Z5/CgTU3uB/G3Xt2/GdB4ZunCny0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SpilTQ1A; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6cc44ff62so868437a34.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548825; x=1763153625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAA7nwcBe2hu8iLfmpfjWmernkFYSUEIghLY/hmXIuw=;
        b=SpilTQ1AvI3oi60Orj4oWSbcywEe/5VUwcg9zt8RP7cr+b+WmIbNMoWcmNkvJAyg1N
         pC5OExw2PKJyW0y1HhigvLYHGMTSUc34H0lAW8IueLYfSkEFOlaiX1r+PySC5i4IREM9
         4K9MajQyqVG2Zh6O7jXZpZX5EXc8blWw1q1KoUut6WV/SEA1c6EqlolNGW9jDwcRdo3Z
         2lOzC7eAl+Ok8pSFoK/4W8/oYkVx5nx4TBhgKAAsTPOMsYll45+PRkg0dFTA8ZBZ0CyG
         svhjroih5ww3qktRqXXHMEsXxNTE+7Mocv8WVFUVjQOC5/L5fIvzF469vY/AYlKjmHTr
         V92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548825; x=1763153625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sAA7nwcBe2hu8iLfmpfjWmernkFYSUEIghLY/hmXIuw=;
        b=Ab7n2nDFp2rcQv7x2mLbaasT6oSptVC9QY8DqR1o3RHhX6SR9UuR8+bHPBIjRs5QO8
         fka7qOuOWGMm1LVh3fLYBlVbv4qaglqodnt5lWllR+E+LadTU/KZuo/eRM9XXxZYoCMh
         8/WWfj+C1xPYZ/ANw8dVS/qPANehAqFhRnxz/7mLSBVu4skk7hVeqyq2mXcq5L6gQu9F
         SkMkhJZYu5qnwYWjaMGevAeT6nJtsD0yY/PnedVEAXH2GYaVoAkgpYS9nwkaumue5iuE
         nF3J8jB+cggaCK9c8UHzlWX/A3ztHG4w3NDCC/C5LK2lEQW1suBbBz3S83JRjpU94GJ/
         UjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAqH6wdmEkasMQOsIbTnFWOuJt/cFgAai7OrWaN7kiAqiuccEPMllZNVLbN5FAgc3iQE5WC2mTw9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWyua1saU5RiIJlEeGXp9yV/BtT5LwIYbiI6S3EaAC9Dj2OAO
	1dukr7ENI++vRkyRSMHfS3FlYk7JEUHVCqFSYjRr0HqVyodLNhhQ+o4ry9C3pby7sIc=
X-Gm-Gg: ASbGncti8Ya18VDLoq0wB8U4o5m6jmpflJEpbYTicnaWkyNNw6E5CtCcxFuBQ+YX0TE
	+cSXYnJDWgtRu/Ya/IBgf+akYNlsL9XChWBu2kIvnsQhvtW6uHQSGJm2qLqdHoy1CsoO+L+o1eb
	AaOc5piWfhWoIsNE661CC1R6eUYHaFoPGqynE37va+y8UTQuPDSqLdc59UYnDPmlL+3DAIb1W2P
	lRi/4XpFSfnlpKcaxgXP2P0UabGturVei7TGhM0FOyXUWAvoVuXDU8REPOaNpmaUqwzJ/S6YeBV
	VYjYIcRFsyL8cF6CrWAAKHWVC0lo/cJTtIyR75nD3B9HP0xwlq9HA8qM4b8lHhFh0scnl9k2yI4
	nPbd5htk1uocjmEnou4GFrFs1wJQt4kfo77GJVDdqRVYZiiRZhMnOUc6F1SbpTEHWEJfioSevSv
	qN6f89KfKCyA8sOIg=
X-Google-Smtp-Source: AGHT+IF8d/1sE+sJeDIqhE3oTXbrOC+yRFKYL8w+HKRi4XBXqL1nNbJTuN9vVLFIyclGu1oa0e4LxQ==
X-Received: by 2002:a05:6808:2385:b0:44f:e801:d6d6 with SMTP id 5614622812f47-4502a285033mr318173b6e.6.1762548824738;
        Fri, 07 Nov 2025 12:53:44 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Nov 2025 14:52:48 -0600
Subject: [PATCH v2 2/6] spi: Support multi-bus controllers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251107-spi-add-multi-bus-support-v2-2-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5715; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=m3Yc3h8a9bxGpNVO5hyPaXHQTJt7h6UIrZKHv6/FSx0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpDlwzXt/Qlor5kL89zft7f08lgjaumNKvt79G/
 LOpkIxYjJiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaQ5cMwAKCRDCzCAB/wGP
 wMCbCACLjmT9SKxWO2rbO7724jgTnGKqSFexnv5V2TV/GVHcCE4T9i9Smp7yteui93APAaBZPP7
 SqzRl/zSP2c+ABLaMjSIaI2g9SBQ5xYYaS8/ujxdjRMJ12OsKXgqeG7YPSw2IOyrVSvxz1dlWfF
 OJm8UdTFIOugnzxM0zeYfHS/5PcfAkZbc4NGBJQB080O2T9aqxrcqUjWExjc1IyOCAZY38/9zJC
 cthKCBD+Nupa6P7hLs8Lc1cnULcSgjEfaxELbeBbfzXhHiCykgQCTSq/1YW73VjQuFpzmm7gGyn
 TjasS0lgrz30lPVVc7WPu1DC5w8Ultbs806Jh8l55aEsLZ/3
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI controllers with multiple physical SPI data buses.
(A data bus in this context means lines connected to a serializer, so a
controller with two data buses would have two serializers in a single
controller).

This is common in the type of controller that can be used with parallel
flash memories, but can be used for general purpose SPI as well.

To indicate support, a controller just needs to set ctlr->num_data_bus
to something greater than 1. Peripherals indicate which bus they are
connected to via device tree (ACPI support can be added if needed).

Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

This patch has been seen in a different series [1] by Sean before:

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-4-sean.anderson@linux.dev/

Changes:
* Use u8 array instead of bitfield so that the order of the mapping is
  preserved. (Now looks very much like chip select mapping.)
* Added doc strings for added fields.
* Tweaked the comments.
---
 drivers/spi/spi.c       | 28 +++++++++++++++++++++++++++-
 include/linux/spi/spi.h | 17 +++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8588e8562220ff5f77977a91b869e220b400c0b2..1cc193ee81120180264047039ef035a958481ede 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2354,7 +2354,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value, cs[SPI_DEVICE_CS_CNT_MAX];
+	u32 value, buses[SPI_DEVICE_DATA_BUS_CNT_MAX], cs[SPI_DEVICE_CS_CNT_MAX];
 	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
@@ -2446,6 +2446,31 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	for (idx = 0; idx < rc; idx++)
 		spi_set_chipselect(spi, idx, cs[idx]);
 
+	rc = of_property_read_variable_u32_array(nc, "spi-data-buses", buses, 1,
+						 ARRAY_SIZE(buses));
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev, "%pOF has invalid 'spi-data-buses' property (%d)\n",
+			nc, rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is omitted. */
+		spi->num_data_bus = 1;
+	} else {
+		for (idx = 0; idx < rc; idx++) {
+			if (buses[idx] >= ctlr->num_data_bus) {
+				dev_err(&ctlr->dev,
+					"%pOF has out of range 'spi-data-buses' property (%d/%d)\n",
+					nc, buses[idx], ctlr->num_data_bus);
+				return -EINVAL;
+			}
+			spi->data_bus[idx] = buses[idx];
+		}
+
+		spi->num_data_bus = rc;
+	}
+
 	/*
 	 * By default spi->chip_select[0] will hold the physical CS number,
 	 * so set bit 0 in spi->cs_index_mask.
@@ -3064,6 +3089,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
+	ctlr->num_data_bus = 1;
 	ctlr->target = target;
 	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
 		ctlr->dev.class = &spi_target_class;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cb2c2df3108999a73b67ef4a7b0d2cb07adfc669..c314194d4e7e2b396795ece10e142118ca05f4eb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,9 @@
 /* Max no. of CS supported per spi device */
 #define SPI_DEVICE_CS_CNT_MAX 4
 
+/* Max no. of data buses supported per spi device */
+#define SPI_DEVICE_DATA_BUS_CNT_MAX 8
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -171,6 +174,9 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
  *	the corresponding physical CS for logical CS i.
  * @num_chipselect: Number of physical chipselects used.
+ * @data_bus: Array of physical data buses. This is only used with specialized
+ * controllers that support multiple data buses.
+ * @num_data_bus: Number of physical data buses used.
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
  *	(optional, NULL when not using a GPIO line)
@@ -231,6 +237,8 @@ struct spi_device {
 
 	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
 	u8			num_chipselect;
+	u8			data_bus[SPI_DEVICE_DATA_BUS_CNT_MAX];
+	u8			num_data_bus;
 
 	/*
 	 * Bit mask of the chipselect(s) that the driver need to use from
@@ -401,6 +409,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	SPI targets, and are numbered from zero to num_chipselects.
  *	each target has a chipselect signal, but it's common that not
  *	every chipselect is connected to a target.
+ * @num_data_bus: Number of data buses supported by this controller. Default is 1.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
  * @buswidth_override_bits: flags to override for this controller driver
@@ -576,6 +585,14 @@ struct spi_controller {
 	 */
 	u16			num_chipselect;
 
+	/*
+	 * Some specialized SPI controllers can have more than one physical
+	 * bus interface per controller (each having it's own serializer). This
+	 * specifies the number of buses in that case. Other controllers do not
+	 * need to set this (defaults to 1).
+	 */
+	u16			num_data_bus;
+
 	/* Some SPI controllers pose alignment requirements on DMAable
 	 * buffers; let protocol drivers know about these requirements.
 	 */

-- 
2.43.0


