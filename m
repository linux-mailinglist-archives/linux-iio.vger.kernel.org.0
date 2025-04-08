Return-Path: <linux-iio+bounces-17821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF95A80C27
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 15:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD0A1BC6753
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F36194AEC;
	Tue,  8 Apr 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VJkIhmkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EFF18DF6E
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118509; cv=none; b=EryVoq9No0UnI/DY0ZZVSK8+OAUZcRJIRh0PFgNrLG1+t6xBJ+zCE4zW/6KcWXZ5290CYHsAsFhTWn5lMAbYZlp4pB1kLTT3mlj+x2rrDSW3q3ECM4tNBTKAco/SSYTcYGftZW7R1X/nTUZZVqE/LGW/0FgsDwtsb0UgnheiZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118509; c=relaxed/simple;
	bh=1f2ORhQnCwIA+vAauaj5gMrmjw5ftywlnpxsP4DFxBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4dkJJRIlSpBFwhiFQfrX53gu2HoMuzFl3V2Ut3xq5pE4gEeGkyf1bc5LNpRW3Kwv58VSIr0I0GgJS5on1RqPEyYpcW0sr80qtuwggOtir1bGjbKu6kVeLRGArafKOgwDNyw2qadFyCVSufOUYitoH9G/ANqczx1yxqx3dFKrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VJkIhmkr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af9a7717163so5443625a12.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744118506; x=1744723306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBMedxIRcduDKw7aQGzJyKbd0gCx+fXHKyRmhGK2uL0=;
        b=VJkIhmkr1JuKkS5OKE7i8g5jBDi2wdQaovjgfjI7zBThuT92YlgHKEU6M1T1RS9I4L
         HT2u+mXjXh2XCSU/LTFFfcPV5IeDKtU81xhOzHGwZo8Bm37m6ElzVBlpPLrHCyULgMsf
         P3ObywUw1YMqsLtDPcLGBVQ34Pv1sk0OpLKzZ53l2d+8SWudlf63wAJ2S3fcR/ZpM2b4
         i54ZCKqFhT3AWhHfqgK1X1EmcEOm5N0kz+t0YwTgue00EVB4gvrkO8r0Z2iexT51B9FG
         hgaudn4aA/sjW31Lu4ln/msEL1o5Wq7gP6zWpc4oWCUzXkcw6vZtrrd3NoPK7Q+lhtyV
         GwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118506; x=1744723306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBMedxIRcduDKw7aQGzJyKbd0gCx+fXHKyRmhGK2uL0=;
        b=XX5TUpngNzkBL5aW+hllyRiAKhyHKCj7Cg4gNW8KsBCJQbcD8qNdqv7akfarfiHfq2
         c0sZ3epetThA2296D/yL7PqxgxYTVitq5XDzRJhaowIp+VfSib6MUEJY0xcmPtHJdRf8
         In3JKX6rQhRO6BTAoxmkyqs0GaKLSpqQmyiJdQB7P6rg27e9gn2bs6KeBhv8OzwtpeI2
         FJZ2+q8L6UHsIxb1xAwcWUwK9kK58iLz9k9kS1XfQqlE4X8l+r6PLKrxdZaygna4uKCM
         DS86KfY0YFCUq5fcksUPFLyigcDB7kS+HKrgpmoEPJZPMVtjajOz7Q3Hv1FTSF9C4CtO
         EPCw==
X-Forwarded-Encrypted: i=1; AJvYcCXBi1WSzuRFI9COwcHqa0AR1hggrY18FHsji9F6QBNNUd+icvcJN3dQOIzJoznGZf5wg/qh/B9Vq4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLfNBUWYJyy4XhG2ohCHVVRRbxBom5lqPE7nVyshSBqHSmZS+
	SBnOhD3odZGkMHYBK0Ahbm62LdIL9E4WHEAg5JVNBnFav9a79gtfqeuV1QvivXE=
X-Gm-Gg: ASbGnct/ur2JoB612Hgq8t7Aql87+pCB1mT9QeZO4YzmS+JRULTzZI89yiqrgalukPO
	TcpvQNxIO3ZXPOshQkHcLvJ0j5HTFW+tGyvF2nR2Wwp+0dAk5zr90X9FPRc4mf1qzWXPrzKo7XV
	jRD+PCds/mmCOgqPJkTHbNl1lvmnjlXGKt7CtzLQ/mSipYeLQxI/5MqFIhpgxRAXpyU7rcY7qXa
	kbGWZnzMGDrzXq5Xe6PL8oXx7vVLcOEl4ftgdXepHYjrGC6n4j/HYEhb8jG9M/6dZfyONwd1hJg
	oipKQHsKh4E1ZajP2pYIfscPjrdb4D8sEd0dz/gMYY0BT+oOye1CXogW0dwAJls92JoQeXmtKJt
	TR3sZqEn9iJKN3TS/2w==
X-Google-Smtp-Source: AGHT+IGU8wqxXXdo3uP6Ez8JcqYHNpyf2rOeLVTK47Bx7uv7gOIQjN5EyJt2RE44IQY7Wi5j5hJJkw==
X-Received: by 2002:a05:6a21:3103:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-20113d552f6mr22419600637.36.1744118506504;
        Tue, 08 Apr 2025 06:21:46 -0700 (PDT)
Received: from dev-linux.. (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc41af71sm7439565a12.75.2025.04.08.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:21:46 -0700 (PDT)
From: Sukrut Bellary <sbellary@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Sukrut Bellary <sbellary@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution devices support
Date: Tue,  8 Apr 2025 06:21:20 -0700
Message-Id: <20250408132120.836461-3-sbellary@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408132120.836461-1-sbellary@baylibre.com>
References: <20250408132120.836461-1-sbellary@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adcxx4s communicates with a host processor via an SPI/Microwire Bus
interface. The device family responds with 12-bit data, of which the LSB
bits are transmitted by the lower resolution devices as 0.
The unavailable bits are 0 in LSB.
Shift is calculated per resolution and used in scaling and
raw data read.

Lets reuse the driver to support the family of devices with name
ADC<bb><c>S<sss>, where
* bb is the resolution in number of bits (8, 10, 12)
* c is the number of channels (1, 2, 4, 8)
* sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
and 101 for 1 MSPS)

Complete datasheets are available at TI's website here:
https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf

Tested only with ti-adc102s051 on BegalePlay SBC.
https://www.beagleboard.org/boards/beagleplay

Co-developed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
---
Changes in v3: 
        - used be16_to_cpu() for the endian conversion.
        - used config index enum while setting up the adc128_config[]

- Link to v2: 
        https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/

Changes in v2:
        - Arranged of_device_id and spi_device_id in numeric order.
        - Used enum to index into adc128_config.
        - Reorder adc128_config in alphabetical.
        - Include channel resolution information.
        - Shift is calculated per resolution and used in scaling and 
        raw data read.

- Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
---
 drivers/iio/adc/ti-adc128s052.c | 149 ++++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index a456ea78462f..d4b76fd85abd 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -7,6 +7,22 @@
  * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
  * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
+ *
+ * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
+ * interface. This driver supports the whole family of devices with a name
+ * ADC<bb><c>S<sss>, where
+ * bb is the resolution in number of bits (8, 10, 12)
+ * c is the number of channels (1, 2, 4, 8)
+ * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
+ * and 101 for 1 MSPS)
+ *
+ * Complete datasheets are available at TI's website here:
+ *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
+ *
+ * 8, 10, and 12 bits converters send 12-bit data with
+ * unavailable bits set to 0 in LSB.
+ * Shift is calculated per resolution and used in scaling and
+ * raw data read.
  */
 
 #include <linux/err.h>
@@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
 	if (ret < 0)
 		return ret;
 
-	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
+	return be16_to_cpu(*((__be16 *)adc->buffer));
 }
 
 static int adc128_read_raw(struct iio_dev *indio_dev,
@@ -70,7 +86,8 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		*val = ret;
+		*val = (ret >> channel->scan_type.shift) &
+			GENMASK(channel->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -80,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		*val = ret / 1000;
-		*val2 = 12;
+		*val2 = channel->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
 	default:
@@ -89,24 +106,34 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
 
 }
 
-#define ADC128_VOLTAGE_CHANNEL(num)	\
-	{ \
-		.type = IIO_VOLTAGE, \
-		.indexed = 1, \
-		.channel = (num), \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
+#define _ADC128_VOLTAGE_CHANNEL(num, real_bits, store_bits)		\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (num),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = (num),					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = (real_bits),			\
+			.storagebits = (store_bits),			\
+			.shift = (12 - real_bits),			\
+		},							\
 	}
 
-static const struct iio_chan_spec adc128s052_channels[] = {
-	ADC128_VOLTAGE_CHANNEL(0),
-	ADC128_VOLTAGE_CHANNEL(1),
-	ADC128_VOLTAGE_CHANNEL(2),
-	ADC128_VOLTAGE_CHANNEL(3),
-	ADC128_VOLTAGE_CHANNEL(4),
-	ADC128_VOLTAGE_CHANNEL(5),
-	ADC128_VOLTAGE_CHANNEL(6),
-	ADC128_VOLTAGE_CHANNEL(7),
+#define ADC082_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 8, 16)
+#define ADC102_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 10, 16)
+#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12, 16)
+
+static const struct iio_chan_spec adc082s021_channels[] = {
+	ADC082_VOLTAGE_CHANNEL(0),
+	ADC082_VOLTAGE_CHANNEL(1),
+};
+
+static const struct iio_chan_spec adc102s021_channels[] = {
+	ADC102_VOLTAGE_CHANNEL(0),
+	ADC102_VOLTAGE_CHANNEL(1),
 };
 
 static const struct iio_chan_spec adc122s021_channels[] = {
@@ -121,10 +148,46 @@ static const struct iio_chan_spec adc124s021_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(3),
 };
 
+static const struct iio_chan_spec adc128s052_channels[] = {
+	ADC128_VOLTAGE_CHANNEL(0),
+	ADC128_VOLTAGE_CHANNEL(1),
+	ADC128_VOLTAGE_CHANNEL(2),
+	ADC128_VOLTAGE_CHANNEL(3),
+	ADC128_VOLTAGE_CHANNEL(4),
+	ADC128_VOLTAGE_CHANNEL(5),
+	ADC128_VOLTAGE_CHANNEL(6),
+	ADC128_VOLTAGE_CHANNEL(7),
+};
+
+enum adc128_configuration_index {
+	ADC128_CONFIG_INDEX_082S,
+	ADC128_CONFIG_INDEX_102S,
+	ADC128_CONFIG_INDEX_122S,
+	ADC128_CONFIG_INDEX_124S,
+	ADC128_CONFIG_INDEX_128S,
+};
+
 static const struct adc128_configuration adc128_config[] = {
-	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
-	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
-	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
+	[ADC128_CONFIG_INDEX_082S] = {
+		.channels = adc082s021_channels,
+		.num_channels = ARRAY_SIZE(adc082s021_channels)
+	},
+	[ADC128_CONFIG_INDEX_102S] = {
+		.channels = adc102s021_channels,
+		.num_channels = ARRAY_SIZE(adc102s021_channels)
+	},
+	[ADC128_CONFIG_INDEX_122S] = {
+		.channels = adc122s021_channels,
+		.num_channels = ARRAY_SIZE(adc122s021_channels)
+	},
+	[ADC128_CONFIG_INDEX_124S] = {
+		.channels = adc124s021_channels,
+		.num_channels = ARRAY_SIZE(adc124s021_channels)
+	},
+	[ADC128_CONFIG_INDEX_128S] = {
+		.channels = adc128s052_channels,
+		.num_channels = ARRAY_SIZE(adc128s052_channels)
+	},
 };
 
 static const struct iio_info adc128_info = {
@@ -177,31 +240,43 @@ static int adc128_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id adc128_of_match[] = {
-	{ .compatible = "ti,adc128s052", .data = &adc128_config[0] },
-	{ .compatible = "ti,adc122s021", .data = &adc128_config[1] },
-	{ .compatible = "ti,adc122s051", .data = &adc128_config[1] },
-	{ .compatible = "ti,adc122s101", .data = &adc128_config[1] },
-	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
-	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
-	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
+	{ .compatible = "ti,adc082s021", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ .compatible = "ti,adc082s051", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ .compatible = "ti,adc082s101", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ .compatible = "ti,adc102s021", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ .compatible = "ti,adc102s051", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ .compatible = "ti,adc102s101", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ .compatible = "ti,adc122s021", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ .compatible = "ti,adc122s051", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ .compatible = "ti,adc122s101", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ .compatible = "ti,adc124s021", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ .compatible = "ti,adc124s051", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ .compatible = "ti,adc124s101", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ .compatible = "ti,adc128s052", .data = &adc128_config[ADC128_CONFIG_INDEX_128S] },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
 static const struct spi_device_id adc128_id[] = {
-	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
-	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
-	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
-	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
-	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
+	{ "adc082s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ "adc082s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ "adc082s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
+	{ "adc102s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ "adc102s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ "adc102s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
+	{ "adc122s021",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ "adc122s051",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ "adc122s101",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
+	{ "adc124s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ "adc124s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ "adc124s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
+	{ "adc128s052", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_128S] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
 static const struct acpi_device_id adc128_acpi_match[] = {
-	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
+	{ "AANT1280", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
-- 
2.34.1


