Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6242711FDD
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2019 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEBQOo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 May 2019 12:14:44 -0400
Received: from ch3vs02.rockwellcollins.com ([205.175.226.29]:50354 "EHLO
        ch3vs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfEBQOn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 May 2019 12:14:43 -0400
Received: from ofwch3n02.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.226.14])
  by ch3vs02.rockwellcollins.com with ESMTP; 02 May 2019 11:14:43 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 1755920079;
        Thu,  2 May 2019 11:14:43 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH v2 3/6] iio: ad7949: Support configuration read-back
Date:   Thu,  2 May 2019 11:14:29 -0500
Message-Id: <1556813672-49861-3-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adds device tree parameter to set the configuration read-back bit
in the configuration register to tell the AD7949 to include the value of
the configuration register at the time the current sample was acquired
when reading from the part.

Further work must be done to make read-back information available to
consumer.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
	V2: Add some defines to reduce use of magic numbers.
---
 drivers/iio/adc/ad7949.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index afc1361af5fb..7820e1097787 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -69,6 +69,7 @@ struct ad7949_adc_spec {
  * @iio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @ref_sel: selected reference voltage source
+ * @cfg_readback: whether reads will include configuration data
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
@@ -80,6 +81,7 @@ struct ad7949_adc_chip {
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
 	enum ad7949_ref_sel ref_sel;
+	bool cfg_readback;
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
@@ -283,7 +285,11 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 			AD7949_CFG_REF_SEL_MASK;
 	adc_config |= (AD7949_CFG_SEQ_DISABLED << AD7949_CFG_SEQ_SHIFT) &
 			AD7949_CFG_SEQ_MASK;
-	adc_config |= AD7949_CFG_READBACK_DIS;
+
+	if (ad7949_adc->cfg_readback)
+		adc_config |= AD7949_CFG_READBACK_EN;
+	else
+		adc_config |= AD7949_CFG_READBACK_DIS;
 
 	ret = ad7949_spi_write_cfg(ad7949_adc,
 			adc_config,
@@ -331,6 +337,10 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	indio_dev->num_channels = spec->num_channels;
 	ad7949_adc->resolution = spec->resolution;
 
+	ad7949_adc->cfg_readback = of_property_read_bool(
+			ad7949_adc->indio_dev->dev.of_node,
+			"adi,cfg-readback");
+
 	ret = of_property_read_u32(ad7949_adc->indio_dev->dev.of_node,
 			"adi,reference-select",
 			&temp);
-- 
1.9.1

