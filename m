Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278BF10E74
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 23:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfEAVRo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 17:17:44 -0400
Received: from da1vs03.rockwellcollins.com ([205.175.227.47]:2639 "EHLO
        da1vs03.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfEAVRo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 17:17:44 -0400
Received: from ofwda1n02.rockwellcollins.com (HELO crulimr01.rockwellcollins.com) ([205.175.227.14])
  by da1vs03.rockwellcollins.com with ESMTP; 01 May 2019 16:17:44 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by crulimr01.rockwellcollins.com (Postfix) with ESMTP id 5121560100;
        Wed,  1 May 2019 16:17:43 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH 3/6] iio: ad7949: Support configuration read-back
Date:   Wed,  1 May 2019 16:17:00 -0500
Message-Id: <1556745423-11368-3-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
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
 drivers/iio/adc/ad7949.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 1c49eed298d8..1d75fff698d1 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -55,6 +55,7 @@ struct ad7949_adc_spec {
  * @iio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @ref_sel: selected reference voltage source
+ * @cfg_readback: whether reads will include configuration data
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
@@ -66,6 +67,7 @@ struct ad7949_adc_chip {
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
 	enum ad7949_ref_sel ref_sel;
+	bool cfg_readback;
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
@@ -256,7 +258,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 	adc_config |= ((ad7949_adc->current_channel & 0x07) << 7);
 	adc_config |= (1 << 6);
 	adc_config |= (ad7949_adc->ref_sel << 3);
-	adc_config |= 1;
+	adc_config |= (ad7949_adc->cfg_readback ? 0 : 1);
 
 	ret = ad7949_spi_write_cfg(ad7949_adc, adc_config, AD7949_MASK_TOTAL);
 
@@ -302,6 +304,10 @@ static int ad7949_spi_probe(struct spi_device *spi)
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

