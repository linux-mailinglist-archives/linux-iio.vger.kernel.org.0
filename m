Return-Path: <linux-iio+bounces-27968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F99D3AC90
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FF8F30157BD
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1133803F2;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOTJ9sOQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E7379983;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=HqBmTJH34quv1fs9H6LCRRksToh65om5UW+lYLhTquJNhEx+4V0gsRIo9xec/2H6HpGxO1/nX9gN0V4P7SKtlBYXrQ9nkNko0bbrb4/nHY+9P4+yw4COFvRu26Bl+GEWAAt3OWQpdicRHeNjq5nCQku9k6GvKovoduzeATIWE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=tdrnZlnqOpUIGcLhTATBc1Qu8gJqQvY8iwv4Gcft5ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpjh6QLIYa3B1ig5K/U2avbk6eblR/kLnmkGPhuL/xv3UNYF1pDy1JBTL8w4PcaBq/7VFivyflKLxEe1aHDmWKIKvqMANavcWJiwdDskdQOVScEU4MVPKOGIGfb4eWGEWRpfBE5ln6UoJUfKkKIFrp2zDy8xLMVyd/kIaB8+WIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOTJ9sOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EACCC4AF10;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=tdrnZlnqOpUIGcLhTATBc1Qu8gJqQvY8iwv4Gcft5ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fOTJ9sOQjyOZkd2+vlKtd+qWZO3QoPOATFUizFtsyapY0g+eS0DRGq4bKL4JicBhr
	 L9uUA66TwIPjXbEpJCpXWbVOuXay0WuYsFqH5xQoz1YNdUEqVbzcBF9SK5qxPqcZNg
	 P5E16tiLZlXwAxVGRqX6lFOkeBXxPiynxoK/+uPdwLmsECoY3BDbvpz1lpD3m3a4bj
	 /7KBfkUdoCqhSV6jo9FUjH4A/ToA7pB1pIFLbWmld8iCvW5RFx27WD38bwBdrAAiJH
	 D5akyAlmIcFXNHTPIei5LDdooIPln4n1uDmdTwP/uCiP9Bh2C1lq1b+7pR9pHrqqJj
	 52OuUDUgRN14g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECADD29C35;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 19 Jan 2026 14:36:58 +0000
Subject: [PATCH 4/7] iio: amplifiers: ad8366: Update device support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-iio-ad8366-update-v1-4-8044e23e964a@analog.com>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
In-Reply-To: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=6539;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=bc9805wahSZeSu7sbk0f/V65J9GCdQoD3kGvDyhbmiE=;
 b=mM5gnwgmIG1mRWhg45TAPvPbCbDH9PqlezzOtKP13TkZ4XWUhU2DOA3LArVxdW1Ay5BPmoD6F
 MvDNxivUAfDDJs7q99Rs7YEyaE3qSWERD4xPbmIyL4Jj9v84aSmk+U7
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

This patch adds support for following digital step attenuators:

 * HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
 * ADRF5720: 0.5 dB LSB, 6-Bit, Digital Attenuator, 9 kHz to 40 GHz
 * ADRF5730: 0.5 dB LSB, 6-Bit, Digital Attenuator, 100 MHz to 40 GHz
 * ADRF5731: 2 dB LSB, 4-Bit, Digital Attenuator, 100 MHz to 40 GHz
 * HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
 * HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz

Additionally, copyright notice was updated with current year.

Co-developed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/Kconfig  |  6 +++
 drivers/iio/amplifiers/ad8366.c | 86 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index a8a604863eed..39d280d4d437 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -18,7 +18,13 @@ config AD8366
 	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
 	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
 	    ADL5240 Digitally controlled variable gain amplifier (VGA)
+	    ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
+	    ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
+	    ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator
+	    HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT
 	    HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
+	    HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT Digital Attenuator
+	    HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT Digital Attenuator
 	    HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 63bb9f0179eb..160a8ab0c2ee 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -5,10 +5,16 @@
  *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
  *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
  *   ADL5240 Digitally controlled variable gain amplifier (VGA)
+ *   ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 9 kHz to 40 GHz
+ *   ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
+ *   ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
+ *   HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
  *   HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
+ *   HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
+ *   HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
  *   HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
  *
- * Copyright 2012-2019 Analog Devices Inc.
+ * Copyright 2012-2026 Analog Devices Inc.
  */
 
 #include <linux/device.h>
@@ -29,7 +35,13 @@ enum ad8366_type {
 	ID_AD8366,
 	ID_ADA4961,
 	ID_ADL5240,
+	ID_ADRF5720,
+	ID_ADRF5730,
+	ID_ADRF5731,
+	ID_HMC271,
 	ID_HMC792,
+	ID_HMC1018,
+	ID_HMC1019,
 	ID_HMC1119,
 };
 
@@ -67,10 +79,34 @@ static const struct ad8366_info ad8366_infos[] = {
 		.gain_min = -11500,
 		.gain_max = 20000,
 	},
+	[ID_ADRF5720] = {
+		.gain_min = -31500,
+		.gain_max = 0,
+	},
+	[ID_ADRF5730] = {
+		.gain_min = -31500,
+		.gain_max = 0,
+	},
+	[ID_ADRF5731] = {
+		.gain_min = -30000,
+		.gain_max = 0,
+	},
+	[ID_HMC271] = {
+		.gain_min = -31000,
+		.gain_max = 0,
+	},
 	[ID_HMC792] = {
 		.gain_min = -15750,
 		.gain_max = 0,
 	},
+	[ID_HMC1018] = {
+		.gain_min = -31000,
+		.gain_max = 0,
+	},
+	[ID_HMC1019] = {
+		.gain_min = -15500,
+		.gain_max = 0,
+	},
 	[ID_HMC1119] = {
 		.gain_min = -31750,
 		.gain_max = 0,
@@ -95,9 +131,17 @@ static int ad8366_write(struct iio_dev *indio_dev,
 		st->data[0] = ch_a & 0x1F;
 		break;
 	case ID_ADL5240:
+	case ID_ADRF5720:
+	case ID_ADRF5730:
+	case ID_ADRF5731:
 		st->data[0] = (ch_a & 0x3F);
 		break;
+	case ID_HMC271:
+		st->data[0] = bitrev8(ch_a & 0x1F) >> 3;
+		break;
 	case ID_HMC792:
+	case ID_HMC1018:
+	case ID_HMC1019:
 	case ID_HMC1119:
 		st->data[0] = ch_a;
 		break;
@@ -135,9 +179,23 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 		case ID_ADL5240:
 			gain = 20000 - 31500 + code * 500;
 			break;
+		case ID_ADRF5720:
+		case ID_ADRF5730:
+			gain = -1 * code * 500;
+			break;
+		case ID_ADRF5731:
+			gain = -1 * code * 500;
+			break;
 		case ID_HMC792:
 			gain = -1 * code * 500;
 			break;
+		case ID_HMC271:
+		case ID_HMC1018:
+			gain = -31000 + code * 1000;
+			break;
+		case ID_HMC1019:
+			gain = -15500 + code * 500;
+			break;
 		case ID_HMC1119:
 			gain = -1 * code * 250;
 			break;
@@ -187,9 +245,23 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	case ID_ADL5240:
 		code = ((gain - 500 - 20000) / 500) & 0x3F;
 		break;
+	case ID_ADRF5720:
+	case ID_ADRF5730:
+		code = (abs(gain) / 500) & 0x3F;
+		break;
+	case ID_ADRF5731:
+		code = (abs(gain) / 500) & 0x3C;
+		break;
 	case ID_HMC792:
 		code = (abs(gain) / 500) & 0x3F;
 		break;
+	case ID_HMC271:
+	case ID_HMC1018:
+		code = ((gain - 1000) / 1000) & 0x1F;
+		break;
+	case ID_HMC1019:
+		code = ((gain - 500) / 500) & 0x1F;
+		break;
 	case ID_HMC1119:
 		code = (abs(gain) / 250) & 0x7F;
 		break;
@@ -275,8 +347,14 @@ static int ad8366_probe(struct spi_device *spi)
 		break;
 	case ID_ADA4961:
 	case ID_ADL5240:
+	case ID_HMC271:
 	case ID_HMC792:
 	case ID_HMC1119:
+	case ID_ADRF5720:
+	case ID_ADRF5730:
+	case ID_ADRF5731:
+	case ID_HMC1018:
+	case ID_HMC1019:
 		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
 		if (IS_ERR(st->reset_gpio)) {
 			ret = PTR_ERR(st->reset_gpio);
@@ -335,8 +413,14 @@ static void ad8366_remove(struct spi_device *spi)
 static const struct spi_device_id ad8366_id[] = {
 	{"ad8366",  ID_AD8366},
 	{"ada4961", ID_ADA4961},
+	{"adrf5720", ID_ADRF5720},
+	{"adrf5730", ID_ADRF5730},
+	{"adrf5731", ID_ADRF5731},
 	{"adl5240", ID_ADL5240},
+	{"hmc271a", ID_HMC271},
 	{"hmc792a", ID_HMC792},
+	{"hmc1018a", ID_HMC1018},
+	{"hmc1019a", ID_HMC1019},
 	{"hmc1119", ID_HMC1119},
 	{ }
 };

-- 
2.43.0



