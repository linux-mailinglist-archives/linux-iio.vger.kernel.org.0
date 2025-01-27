Return-Path: <linux-iio+bounces-14628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16736A1D946
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F673A5502
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F61547E1;
	Mon, 27 Jan 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="afYcZp18"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79213D52E;
	Mon, 27 Jan 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990876; cv=none; b=NLIx4PId/OxWB86BhDXB2inTOhqeslPNAszHj4p/G2AlbCaTZsB0iL7hBI1bl+593GeuB0xlkDs4K8ybtt3OzV0OtFaZQLRYnaopm4EM6qz4hqE+VVT8YoZhsCz5b9h/VSyBhfXL4jgcpjTlnpRw/o63lF/V9x11JFv9OIQ3iXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990876; c=relaxed/simple;
	bh=jjM/5Uz6DFaSbBgUvq7x8+hU5Ld3Z7DS9aLn2ILcJ+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9tqpDY+7UHEeXnRK/bhQO3J5VblZ5xOSRus7jKKl9N6IPdX5QJk9V1J7ehJPRYtnXHmkiAk3LBZigiIFI1dLO6RQ/OEcxLsdxfeCEXhuKuxqjEuohZx+symTH36BsckXqyq+WkWSueGyN/KMvcVg/eH3qq2wU6egLpsFKaG86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=afYcZp18; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWCLX005764;
	Mon, 27 Jan 2025 10:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QZGEf
	SCQwD/dzes1/T8tHDkFW4eQl27flM8Ly0S0Rp0=; b=afYcZp18H4IhzWqkkWs61
	8BkcD0b4jV3IBmVO6/oKUeAxjpvw5iEck7/DKXs8dtwAIxVluSDXdqw0PaDs+iag
	+KCQPxIAgRj0JEDg7ty6+f82a5S9UhwBI/U7QHoBDgjtaoJl4RP5Sm7G/5BBmP0f
	mgwfMBFCUGKWqTNBU4cJXNVaQXAsy3jXalOKbXO8hQqbLnkLhU6HM2dZ1TjvZoMx
	LxIn93zLqVCc7TcL2s6+hZB5m6uinS6QQeBF8SAsD11CHbi9ABDBbxxp+OtuCc95
	MsiSfmbnYsy6X1l5TL1rBbaR/aZnP3ckd1udRd/QLRcH8nXrgdkp64jFupdmJJvu
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:14:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFEJFO011116
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:14:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:14:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:14:19 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFE8MQ008462;
	Mon, 27 Jan 2025 10:14:11 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 14/16] iio: adc: ad7768-1: add support for Synchronization over SPI
Date: Mon, 27 Jan 2025 12:14:08 -0300
Message-ID: <2d3c69d92a9688f4a20bd6de70f694482501f61c.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: gLuwNPe-ZQ33LUD6N_lP-bnCXPhZQVg6
X-Proofpoint-GUID: gLuwNPe-ZQ33LUD6N_lP-bnCXPhZQVg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

The synchronization method using GPIO requires the generated pulse to be
truly synchronous with the base MCLK signal. When it is not possible to
do that in hardware, the datasheet recommends using synchronization over
SPI, where the generated pulse is already synchronous with MCLK. This
requires the SYNC_OUT pin to be connected to SYNC_IN pin. In
multidevices setup, the SYNC_OUT from other devices can be used as
synchronization source.

Use trigger-sources property to enable device synchronization over SPI
for single and multiple devices.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* Synchronization via SPI is enabled when the Sync GPIO is not defined.
* now trigger-sources property indicates the synchronization provider or
  main device. The main device will be used to drive the SYNC_IN when
  requested (via GPIO or SPI).
---
 drivers/iio/adc/ad7768-1.c | 81 ++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 7686556c7808..01ccbe0aa708 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -193,6 +193,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 
 struct ad7768_state {
 	struct spi_device *spi;
+	struct spi_device *sync_source_spi;
 	struct regmap *regmap;
 	struct regulator *vref;
 	struct mutex lock;
@@ -206,6 +207,7 @@ struct ad7768_state {
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
+	bool en_spi_sync;
 	const char *labels[ARRAY_SIZE(ad7768_channels)];
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -264,6 +266,21 @@ static int ad7768_spi_reg_write(void *context,
 	return spi_write(st->spi, st->data.d8, 2);
 }
 
+static int ad7768_send_sync_pulse(struct ad7768_state *st)
+{
+	if (st->en_spi_sync) {
+		st->data.d8[0] = AD7768_WR_FLAG_MSK(AD7768_REG_SYNC_RESET);
+		st->data.d8[1] = 0x00;
+
+		return spi_write(st->sync_source_spi, st->data.d8, 2);
+	} else if (st->gpio_sync_in) {
+		gpiod_set_value_cansleep(st->gpio_sync_in, 1);
+		gpiod_set_value_cansleep(st->gpio_sync_in, 0);
+	}
+
+	return 0;
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -348,10 +365,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
 		return ret;
 
 	/* A sync-in pulse is required every time the filter dec rate changes */
-	gpiod_set_value(st->gpio_sync_in, 1);
-	gpiod_set_value(st->gpio_sync_in, 0);
-
-	return 0;
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -638,6 +652,58 @@ static const struct iio_info ad7768_info = {
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
+static int ad7768_parse_trigger_sources(struct device *dev, struct ad7768_state *st)
+{
+	struct fwnode_reference_args args;
+	int ret;
+
+	/*
+	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin to synchronize
+	 * one or more devices:
+	 * 1. Using a GPIO to directly drive the SYNC_IN pin.
+	 * 2. Using a SPI command, where the SYNC_OUT pin generates a synchronization pulse
+	 *    that loops back to the SYNC_IN pin.
+	 *
+	 * In multi-device setups, the SYNC_IN pin can also be driven by the SYNC_OUT pin of
+	 * another device. To support this, we use the "trigger-source" property to get a
+	 * reference to the "main" device responsible for generating the synchronization pulse.
+	 * In a single-device setup, the "trigger-source" property should reference the device's
+	 * own node.
+	 */
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "trigger-sources",
+						 "#trigger-source-cells", 0, 0, &args);
+	if (ret) {
+		dev_err(dev, "Failed to get trigger-sources reference: %d\n", ret);
+		return ret;
+	}
+
+	st->gpio_sync_in = devm_gpiod_get_optional(args.fwnode->dev, "adi,sync-in",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_sync_in))
+		return PTR_ERR(st->gpio_sync_in);
+
+	/*
+	 * If the SYNC_IN GPIO is not defined, fall back to synchronization over SPI.
+	 * Use the trigger-source reference to identify the main SPI device for generating
+	 * the synchronization pulse.
+	 */
+	if (!st->gpio_sync_in) {
+		st->sync_source_spi = to_spi_device(args.fwnode->dev);
+		if (!st->sync_source_spi) {
+			dev_err(dev,
+				"Synchronization setup failed. GPIO is undefined and trigger-source reference is invalid\n");
+			return -EINVAL;
+		}
+
+		st->en_spi_sync = true;
+	}
+
+	/* Release the fwnode reference after use */
+	fwnode_handle_put(args.fwnode);
+
+	return 0;
+}
+
 static int ad7768_setup(struct iio_dev *indio_dev)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
@@ -668,10 +734,9 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
-					  GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_sync_in))
-		return PTR_ERR(st->gpio_sync_in);
+	ret = ad7768_parse_trigger_sources(&st->spi->dev, st);
+	if (ret)
+		return ret;
 
 	/* Only create a Chip GPIO if flagged for it */
 	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
-- 
2.34.1


