Return-Path: <linux-iio+bounces-27237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35631CD1FBB
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C90F03036DAC
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 21:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762263451D7;
	Fri, 19 Dec 2025 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q8fmSvkM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FD342505
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180015; cv=none; b=S7qLzuFE54E8ipZjHoIZxN+qYpi0Ap6xyyR7wXEby/m+oCrip1tgHpGj1zrTMrPIq8djsm4JA7ZS0vVpZCDyRXbVvX+EwY9LFMXAY7iSpM/6QwiekFgaIYeqXjQaC1po4Ql0tEulAqtR6RwM4gkDehqd9JGyGKVi0hxpPgdoYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180015; c=relaxed/simple;
	bh=dmKDx1Fv/D9g60Hrpe80FFHumuzs/k3EreCFMwZe2ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npGAAfmk8Y3zXwPNepvVBwyRB12hWpymq47IU8VFZ9DRuNpgOoYKxNyuiuZRlg8iAj+LTz2VUgDAbFM3xCaO2twoF4ri0u90GdpFfW3nLDo3f/N4bgIxW7my9fIf4ux1kasoeNT1zt+6nY9GgSDASF0dF2JugwRBhbbtxEIL7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q8fmSvkM; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c77fc7c11bso2308260a34.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180011; x=1766784811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovFocDuZESoFfLXGTE37+Y+HD9mVmqzpjLno5vNVGiU=;
        b=Q8fmSvkMRFxx5bWlYmkVUrNu4W7uwJ7aVDTySM9z74Q0BiNno/TJqLpaXzqVvYxLVd
         +gVTyNjDJzEt81uwjXchuXpdZes7ty7oJoAmSOooQfaPuh+9CvgNfkZo3UTfZhrd6yqC
         M6wUCc5wct7EcHE3OG0aFJKG08QEKDNHR5F4Ab19yJduFRtDzpC/BsEOJqUeVJptObSf
         d+yDdgLa6dtAyoWpayuMyW5EXThbjK0lcIlC3H3Cnf4wfKh+gousY1EXK9lX+xQzA0+6
         T2PCTzoGX1llP4iWDYFFZXyDtOjTTypFhh+2EOx2vlAlH7qBtMMa52yoL/j2Z39k3vYe
         WtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180011; x=1766784811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ovFocDuZESoFfLXGTE37+Y+HD9mVmqzpjLno5vNVGiU=;
        b=JGUz+TtaquqWnIi4OkWo7rfk3AV6pdUZz3zbCrTjU6xbzMN7a1SPFQf3Ru2H69vdbc
         8W6IEcdX1KC5gXGi0Jy4ZhfOw80I5iACw1V8prn2nJ33p1YiMEne4rF3xiTCNGvLdKBu
         QqDESOM0LfWiVBd2n5p8CpEN6QSIevMiiAj3O58YMZ77jKueStz0MQlCSxZSxTMArmw7
         xSc2HU2mgMjnQMNzp44YF6HvhLGqyWGmr3+7vTwDDPbTScBTA+s753DoSnS9gk6eSqvz
         4jXgWjQGqdwedPD1wMKAGTMCwtFDCx2sIDARBuo6m741buMLug6LZwuZvKUXYvq+d1QH
         JCDw==
X-Forwarded-Encrypted: i=1; AJvYcCVWkvsphniM2Gi2rIqYbLTTQw1QVQQerVVfnuPkd+TJSgiONr0OotIRWz4LOgghYpkpG0CI3FMABaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpXK2iFFP3eCecgcSSm0F16vevXZ/+iNWys1k8rHx0nFLEAFe
	XZ1epl89Z9lZGHQ2p/bcc1COEKmaefJgBL8CUhJv51gY2kkG53kK2a2KLk23F7BtEa0=
X-Gm-Gg: AY/fxX5CVUmCUNM0bFa4MJGsOmjWFaEge7h8Uu/vtQSFgGrwJ56denhQkLYX3qyiFBy
	2CcGO6QfB0sMC0mcmMFekmRDSA9UeRAphHRsONs7/xK6MfwrUVpi5BfNeJco/N/FhrL3GuCxIgC
	ZK3uDdtXktEavpYmpATRLnIeEWOXOaR298VTARqtGi+CXe52sdwZ/3bebA1Ylqq1axN8Wx3Cgzj
	yEpyEXqyCof+yFPqgvnnntntEppzrmlrJFWLVKNy/H9ZvRXpbcqnOQwcAh7YbZp6scKIMUgdVAW
	/FkphBJM+h4hyrWOGmbP+q/XPmhGlSFIOCjg2KLejOu+8fayWtviMqSsZnKwpNx7BZ9Ml+Lug4m
	vrZAgcrlKxwL1ZAclOmo67KrLvQq7gGiTawsHduHo90o+AEwsb3S1NGA0gdTOCrKE+LR1J0ZQMZ
	3O2z6KI+OUuwDaqA==
X-Google-Smtp-Source: AGHT+IE4mrII5d5kc6to1lNBrT3gGh5165SAEtgCvCvMjJA/KpQ8Ag5b2i5DItbp06iIzxckkFNigg==
X-Received: by 2002:a05:6830:314c:b0:7c7:6a56:cfb5 with SMTP id 46e09a7af769-7cc65e3a826mr2355580a34.11.1766180010938;
        Fri, 19 Dec 2025 13:33:30 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:30 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Dec 2025 15:32:11 -0600
Subject: [PATCH v4 3/9] spi: support controllers with multiple data lanes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-spi-add-multi-bus-support-v4-3-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8962; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dmKDx1Fv/D9g60Hrpe80FFHumuzs/k3EreCFMwZe2ow=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpRcR495+H4JkgnbUmwE4Y5sb4jQHQpBE3pTlSD
 1CYxR4c2riJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUXEeAAKCRDCzCAB/wGP
 wBbgB/9iwCruGaJtA9pANY7KaVwhRBTGFCuuG6Q5kJXLFVp7vxsztqYZCxSY+uojU5VntK08fPh
 jUbKXDq/xkOU/zFmxmRM2a3lJU5q646qWmVabVL7P4r2SMwi9Ja29S47gyA/VaoBjPyyh+YN7Za
 XV4RXzMNYl/ac3So5Rfci7CH+02DO99+U4+oC9wxe/EY3F0frIT5RHOsgZmb78laHQXaHd+1XiW
 9I76hLvMNHEfjaL6N7zLeOCxRmW9Fc5wAK7ZNU0CCyAont47zgRr9xUoR9MuX7SrXuylt3jPtcl
 YSR4XbxemwIHFIQjwdQs6lTgZS2WzqgSkyPEFJlmrw11RTn3
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for SPI controllers with multiple physical SPI data lanes.
(A data lane in this context means lines connected to a serializer, so a
controller with two data lanes would have two serializers in a single
controller).

This is common in the type of controller that can be used with parallel
flash memories, but can be used for general purpose SPI as well.

To indicate support, a controller just needs to set ctlr->num_data_lanes
to something greater than 1. Peripherals indicate which lane they are
connected to via device tree (ACPI support can be added if needed).

The spi-{tx,rx}-bus-width DT properties can now be arrays. The length of
the array indicates the number of data lanes, and each element indicates
the bus width of that lane. For now, we restrict all lanes to have the
same bus width to keep things simple. Support for an optional controller
lane mapping property is also implemented.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
- Update for changes in devicetree bindings.
- Don't put new fields in the middle of CS fields.
- Dropped acks since this was a significant rework.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

This patch has been seen in a different series [1] by Sean before:

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-4-sean.anderson@linux.dev/

Changes:
* Use u8 array instead of bitfield so that the order of the mapping is
  preserved. (Now looks very much like chip select mapping.)
* Added doc strings for added fields.
* Tweaked the comments.
---
 drivers/spi/spi.c       | 114 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  22 ++++++++++
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e25df9990f82..9caa22583b8f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2370,7 +2370,52 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_CS_HIGH;
 
 	/* Device DUAL/QUAD mode */
-	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
+
+	rc = of_property_read_u32_array(nc, "spi-tx-lane-map", spi->tx_lane_map,
+					ARRAY_SIZE(spi->tx_lane_map));
+	if (rc == -EINVAL) {
+		/* Default lane map */
+		for (idx = 0; idx < ARRAY_SIZE(spi->tx_lane_map); idx++)
+			spi->tx_lane_map[idx] = idx;
+	} else if (rc < 0) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-tx-lane-map property: %d\n", rc);
+		return rc;
+	}
+
+	rc = of_property_count_u32_elems(nc, "spi-tx-bus-width");
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-tx-bus-width property: %d\n", rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is not present. */
+		spi->num_tx_lanes = 1;
+	} else {
+		u32 first_value;
+
+		spi->num_tx_lanes = rc;
+
+		for (idx = 0; idx < spi->num_tx_lanes; idx++) {
+			of_property_read_u32_index(nc, "spi-tx-bus-width", idx,
+						   &value);
+
+			/*
+			 * For now, we only support all lanes having the same
+			 * width so we can keep using the existing mode flags.
+			 */
+			if (!idx)
+				first_value = value;
+			else if (first_value != value) {
+				dev_err(&ctlr->dev,
+					"spi-tx-bus-width has inconsistent values: first %d vs later %d\n",
+					first_value, value);
+				return -EINVAL;
+			}
+		}
+
 		switch (value) {
 		case 0:
 			spi->mode |= SPI_NO_TX;
@@ -2394,7 +2439,61 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
-	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
+	for (idx = 0; idx < spi->num_tx_lanes; idx++) {
+		if (spi->tx_lane_map[idx] >= spi->controller->num_data_lanes) {
+			dev_err(&ctlr->dev,
+				"spi-tx-lane-map has invalid value %d (num_data_lanes=%d)\n",
+				spi->tx_lane_map[idx],
+				spi->controller->num_data_lanes);
+			return -EINVAL;
+		}
+	}
+
+	rc = of_property_read_u32_array(nc, "spi-rx-lane-map", spi->rx_lane_map,
+					ARRAY_SIZE(spi->rx_lane_map));
+	if (rc == -EINVAL) {
+		/* Default lane map */
+		for (idx = 0; idx < ARRAY_SIZE(spi->rx_lane_map); idx++)
+			spi->rx_lane_map[idx] = idx;
+	} else if (rc < 0) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-rx-lane-map property: %d\n", rc);
+		return rc;
+	}
+
+	rc = of_property_count_u32_elems(nc, "spi-rx-bus-width");
+	if (rc < 0 && rc != -EINVAL) {
+		dev_err(&ctlr->dev,
+			"failed to read spi-rx-bus-width property: %d\n", rc);
+		return rc;
+	}
+
+	if (rc == -EINVAL) {
+		/* Default when property is not present. */
+		spi->num_rx_lanes = 1;
+	} else {
+		u32 first_value;
+
+		spi->num_rx_lanes = rc;
+
+		for (idx = 0; idx < spi->num_rx_lanes; idx++) {
+			of_property_read_u32_index(nc, "spi-rx-bus-width", idx,
+						   &value);
+
+			/*
+			 * For now, we only support all lanes having the same
+			 * width so we can keep using the existing mode flags.
+			 */
+			if (!idx)
+				first_value = value;
+			else if (first_value != value) {
+				dev_err(&ctlr->dev,
+					"spi-rx-bus-width has inconsistent values: first %d vs later %d\n",
+					first_value, value);
+				return -EINVAL;
+			}
+		}
+
 		switch (value) {
 		case 0:
 			spi->mode |= SPI_NO_RX;
@@ -2418,6 +2517,16 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
+	for (idx = 0; idx < spi->num_rx_lanes; idx++) {
+		if (spi->rx_lane_map[idx] >= spi->controller->num_data_lanes) {
+			dev_err(&ctlr->dev,
+				"spi-rx-lane-map has invalid value %d (num_data_lanes=%d)\n",
+				spi->rx_lane_map[idx],
+				spi->controller->num_data_lanes);
+			return -EINVAL;
+		}
+	}
+
 	if (spi_controller_is_target(ctlr)) {
 		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
@@ -3066,6 +3175,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	mutex_init(&ctlr->add_lock);
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = 1;
+	ctlr->num_data_lanes = 1;
 	ctlr->target = target;
 	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
 		ctlr->dev.class = &spi_target_class;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cb2c2df31089..7aff60ab257e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,9 @@
 /* Max no. of CS supported per spi device */
 #define SPI_DEVICE_CS_CNT_MAX 4
 
+/* Max no. of data lanes supported per spi device */
+#define SPI_DEVICE_DATA_LANE_CNT_MAX 8
+
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -174,6 +177,10 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  * @cs_gpiod: Array of GPIO descriptors of the corresponding chipselect lines
  *	(optional, NULL when not using a GPIO line)
+ * @tx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
+ * @num_tx_lanes: Number of transmit lanes wired up.
+ * @rx_lane_map: Map of peripheral lanes (index) to controller lanes (value).
+ * @num_rx_lanes: Number of receive lanes wired up.
  *
  * A @spi_device is used to interchange data between an SPI target device
  * (usually a discrete chip) and CPU memory.
@@ -242,6 +249,12 @@ struct spi_device {
 
 	struct gpio_desc	*cs_gpiod[SPI_DEVICE_CS_CNT_MAX];	/* Chip select gpio desc */
 
+	/* Multi-lane SPI controller support. */
+	u32			tx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	u32			num_tx_lanes;
+	u32			rx_lane_map[SPI_DEVICE_DATA_LANE_CNT_MAX];
+	u32			num_rx_lanes;
+
 	/*
 	 * Likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -401,6 +414,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  *	SPI targets, and are numbered from zero to num_chipselects.
  *	each target has a chipselect signal, but it's common that not
  *	every chipselect is connected to a target.
+ * @num_data_lanes: Number of data lanes supported by this controller. Default is 1.
  * @dma_alignment: SPI controller constraint on DMA buffers alignment.
  * @mode_bits: flags understood by this controller driver
  * @buswidth_override_bits: flags to override for this controller driver
@@ -576,6 +590,14 @@ struct spi_controller {
 	 */
 	u16			num_chipselect;
 
+	/*
+	 * Some specialized SPI controllers can have more than one physical
+	 * data lane interface per controller (each having it's own serializer).
+	 * This specifies the number of data lanes in that case. Other
+	 * controllers do not need to set this (defaults to 1).
+	 */
+	u16			num_data_lanes;
+
 	/* Some SPI controllers pose alignment requirements on DMAable
 	 * buffers; let protocol drivers know about these requirements.
 	 */

-- 
2.43.0


