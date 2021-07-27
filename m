Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17983D83F6
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 01:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhG0X3Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 19:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhG0X3X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 19:29:23 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E502C061757;
        Tue, 27 Jul 2021 16:29:22 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id k13so67803qth.10;
        Tue, 27 Jul 2021 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLdEL+wRSToed9K2smos0CopwYuBTygZqCulDZfuGts=;
        b=RADw+8RKT5s7uLu3VjWDOlOritahyiSL3/f0E3XOlg7r7HEepvbFiiVa9UHYNRDUwB
         i2dpwsZ8yzQo2giesv87rrbf+x8exG3D519YkjPhhd1F984Fn+cPkYTe+vVkWEgRmRIu
         rV5iFf4Z2vUvEsi8oiaokcLVeEA3qWy2a3le+J5NY6gGkTnkLheL0/a683Cg1+lPczxL
         mvFcROuHma9IK1SLyy1r0/5N4p4mhtct5fXYafbVKlFKA4lNjxoFWGdlZGMJHbuvYqsm
         eKxDswdKlX79oF5/7I3qqt7Ok9zx+ou6gEykx4e/oYMQKZNd66aC/V6agHS9JzhUTNyT
         iIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLdEL+wRSToed9K2smos0CopwYuBTygZqCulDZfuGts=;
        b=llSOyR4HVyaZ9rkPJOPg+kLNJYjjPOfYOH91qyv8Ke5wgkeV7KyvYzp0XY5fvyfWYP
         U9+7IAresYr68JHQS6L/8/Qzsmn3d+QyF68VW6ZMKHKzyy/g8Hk3scPG2VPiqlHD6qeh
         RFUXemKem08HNQPZ8b+be3ObgaFZWhRLl4kbWcWt65m03YCCxl/lfNXKIrrcdQwpbdLt
         hvb9DV82Q7or14CktDaY5hmkm2L9mNkPIXFRKUDOFqhY05AqmL3MO2ePMtItLQbtKhrM
         z4NHlwm/0Of4WYND/cvFcJZnG3srGz+mFb/OegXyj3cDqzq88ACwYjssEZ+TQO3V+QEe
         xQIA==
X-Gm-Message-State: AOAM533fPJXZgTskzlfcQ5Nd7ggaeNuNNxVAYTwBa+9S4fImSDCaZtvc
        rOeilWFOn1WcVfxdRKU2/vgLZEFkM37H/A==
X-Google-Smtp-Source: ABdhPJzt9Nou8KT7d0dsDWdEe1WVW32ovzi8nL3CCVoFpgfyUdpecm3l4qiakrXOFerEIJxHLRZJkA==
X-Received: by 2002:ac8:65cc:: with SMTP id t12mr22013215qto.30.1627428561327;
        Tue, 27 Jul 2021 16:29:21 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p188sm2380514qka.114.2021.07.27.16.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:29:20 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 0/5] AD7949 Fixes
Date:   Tue, 27 Jul 2021 19:29:01 -0400
Message-Id: <20210727232906.980769-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While working on another series[1] I ran into issues where my SPI
controller would fail to handle 14-bit and 16-bit SPI messages. This
addresses that issue and adds support for selecting a different voltage
reference source from the devicetree.

V1 was base on a series[2] that seems to not have made it all the way,
and was tested on an ad7689.

[1] https://patchwork.kernel.org/project/linux-iio/list/?series=511545
[2] https://patchwork.kernel.org/project/linux-iio/list/?series=116971&state=%2A&archive=both

Changes since v3:
- use cpu_to_be16 and be16_to_cpu instead of manual conversion
- use pointers to channel structures instead of copies
- switch to generic device firmware property API
- use standard unit suffix names (mV to microvolt)
- switch to devm_iio_device_register() for additional cleanup

Changes since v2:
- add comments to ambiguous register names
- fix be16 definition of the adc buffer
- fix BPW logic
- rework vref support
  - support per channel vref selection
  - infer reference select value based on DT parameters
  - update dt-binding

Changes since v1:
- add default case in read/write size cases
- drop of_node change as the core already takes care of it
- check dt user input in probe
- move description at the top of dt-binding definition
- drop AllOf block in dt-binding

Thanks for your time,
Liam

Liam Beguin (5):
  iio: adc: ad7949: define and use bitfield names
  iio: adc: ad7949: fix spi messages on non 14-bit controllers
  iio: adc: ad7949: add support for internal vref
  dt-bindings: iio: adc: ad7949: add per channel reference
  iio: adc: ad7949: use devm managed functions

 .../bindings/iio/adc/adi,ad7949.yaml          |  69 ++++-
 drivers/iio/adc/ad7949.c                      | 261 ++++++++++++++----
 2 files changed, 274 insertions(+), 56 deletions(-)

Range-diff against v3:
-:  ------------ > 1:  8760b368f971 iio: adc: ad7949: define and use bitfield names
1:  a9243c834705 ! 2:  7b1484f2fc4c iio: adc: ad7949: fix spi messages on non 14-bit controllers
    @@ Commit message
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
      ## drivers/iio/adc/ad7949.c ##
    -@@
    - #include <linux/regulator/consumer.h>
    - #include <linux/spi/spi.h>
    - #include <linux/bitfield.h>
    -+#include <asm/unaligned.h>
    - 
    - #define AD7949_MASK_TOTAL		GENMASK(13, 0)
    - 
     @@ drivers/iio/adc/ad7949.c: static const struct ad7949_adc_spec ad7949_adc_spec[] = {
       * @indio_dev: reference to iio structure
       * @spi: reference to spi structure
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_write_cfg(struct ad7949_adc_chip
      	int ret;
     -	int bits_per_word = ad7949_adc->resolution;
     -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
    -+	u8 buf8[2];
      	struct spi_message msg;
      	struct spi_transfer tx[] = {
      		{
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_write_cfg(struct ad7949_adc_chip
     +		ad7949_adc->buffer = ad7949_adc->cfg;
     +		break;
     +	case 8:
    -+		/* Pack 14-bit value into 2 bytes, MSB first */
    -+		buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
    -+		buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg) << 2;
    -+		memcpy(&ad7949_adc->buffer, buf8, 2);
    ++		/* Here, type is big endian as it must be sent in two transfers */
    ++		ad7949_adc->buffer = (u16)cpu_to_be16(ad7949_adc->cfg << 2);
     +		break;
     +	default:
     +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
      	int i;
     -	int bits_per_word = ad7949_adc->resolution;
     -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
    -+	u8 buf8[2];
      	struct spi_message msg;
      	struct spi_transfer tx[] = {
      		{
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
     +		*val = ad7949_adc->buffer & GENMASK(13, 0);
     +		break;
     +	case 8:
    -+		memcpy(buf8, &ad7949_adc->buffer, 2);
    -+		/* Convert byte array to u16, MSB first */
    -+		*val = get_unaligned_be16(buf8);
    ++		/* Here, type is big endian as data was sent in two transfers */
    ++		*val = be16_to_cpu(ad7949_adc->buffer);
     +		/* Shift-out padding bits */
     +		*val >>= 16 - ad7949_adc->resolution;
     +		break;
2:  bb25b7fcb0a3 ! 3:  41c4ab9c5e19 iio: adc: ad7949: add support for internal vref
    @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
      	u8 bits_per_word;
      	u16 cfg;
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
    + 	int ret;
      	int i;
    - 	u8 buf8[2];
      	struct spi_message msg;
    -+	struct ad7949_channel ad7949_chan = ad7949_adc->channels[channel];
    ++	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[channel];
      	struct spi_transfer tx[] = {
      		{
      			.rx_buf = &ad7949_adc->buffer,
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
     -					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
     -					   AD7949_CFG_BIT_INX);
     +					   FIELD_PREP(AD7949_CFG_BIT_INX, channel) |
    -+					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan.refsel),
    ++					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan->refsel),
     +					   AD7949_CFG_BIT_INX | AD7949_CFG_BIT_REF);
      		if (ret)
      			return ret;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_raw(struct iio_dev *indio_d
      			   int *val, int *val2, long mask)
      {
      	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
    -+	struct ad7949_channel ad7949_chan = ad7949_adc->channels[chan->channel];
    ++	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[chan->channel];
      	int ret;
      
      	if (!val)
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_raw(struct iio_dev *indio_d
     -		ret = regulator_get_voltage(ad7949_adc->vref);
     -		if (ret < 0)
     -			return ret;
    -+		switch (ad7949_chan.refsel) {
    ++		switch (ad7949_chan->refsel) {
     +		case AD7949_CFG_VAL_REF_INT_2500:
     +			*val = 2500;
     +			break;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7
      	const struct ad7949_adc_spec *spec;
      	struct ad7949_adc_chip *ad7949_adc;
     +	struct ad7949_channel *ad7949_chan;
    -+	struct device_node *child;
    ++	struct fwnode_handle *child;
      	struct iio_dev *indio_dev;
     +	int mode;
     +	u32 tmp;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
     -	if (ret < 0) {
     -		dev_err(dev, "fail to enable regulator\n");
     -		return ret;
    -+	if (mode > AD7949_CFG_VAL_REF_INT_4096) {
    ++	if (mode & AD7949_CFG_VAL_REF_EXTERNAL) {
     +		ret = regulator_enable(ad7949_adc->vref);
     +		if (ret < 0) {
     +			dev_err(dev, "fail to enable regulator\n");
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
     +	}
     +
     +	/* Initialize all channel structures */
    -+	for (i = 0; i < spec->num_channels; i++) {
    ++	for (i = 0; i < spec->num_channels; i++)
     +		ad7949_adc->channels[i].refsel = mode;
    -+	}
     +
     +	/* Read channel specific information form the devicetree */
    -+	for_each_child_of_node(dev->of_node, child) {
    -+		ret = of_property_read_u32(child, "reg", &i);
    ++	device_for_each_child_node(dev, child) {
    ++		ret = fwnode_property_read_u32(child, "reg", &i);
     +		if (ret) {
    -+			dev_err(dev, "missing reg property in child: %s\n",
    -+				child->full_name);
    -+			of_node_put(child);
    ++			dev_err(dev, "missing reg property in %pfw\n", child);
    ++			fwnode_handle_put(child);
     +			return ret;
     +		}
     +
     +		ad7949_chan = &ad7949_adc->channels[i];
     +
    -+		ret = of_property_read_u32(child, "adi,internal-ref-mv", &tmp);
    ++		ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
     +		if (ret < 0 && ret != -EINVAL) {
    -+			of_node_put(child);
    ++			dev_err(dev, "invalid internal reference in %pfw\n", child);
    ++			fwnode_handle_put(child);
     +			return ret;
     +		}
     +
     +		switch (tmp) {
    -+		case 2500:
    ++		case 2500000:
     +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_2500;
     +			break;
    -+		case 4096:
    ++		case 4096000:
     +			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_4096;
     +			break;
     +		default:
     +			dev_err(dev, "unsupported internal voltage reference\n");
    -+			of_node_put(child);
    ++			fwnode_handle_put(child);
     +			return -EINVAL;
     +		}
      	}
3:  41e3ca4f0d52 ! 4:  9cb48acbd05b dt-bindings: iio: adc: ad7949: add per channel reference
    @@ Commit message
     
         Add bindings documentation describing per channel reference voltage
         selection.
    -    This adds the adi,internal-ref-mv property, and child nodes for each
    -    channel. This is required to properly configure the ADC sample request
    -    based on which reference source should be used for the calculation.
    +    This adds the adi,internal-ref-microvolt property, and child nodes for
    +    each channel. This is required to properly configure the ADC sample
    +    request based on which reference source should be used for the
    +    calculation.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
    @@ Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml: properties:
     +
     +  '#size-cells':
     +    const: 0
    -+
     +
      required:
        - compatible
    @@ Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml: properties:
     +          minimum: 0
     +          maximum: 7
     +
    -+      adi,internal-ref-mv:
    ++      adi,internal-ref-microvolt:
     +        description: |
    -+          Internal reference voltage selection in millivolts.
    ++          Internal reference voltage selection in microvolts.
     +
     +          If no internal reference is specified, the channel will default to the
     +          external reference defined by vrefin-supply (or vref-supply).
    @@ Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml: properties:
     +          If no supplies are defined, the reference selection will default to
     +          4096mV internal reference.
     +
    -+        $ref: /schemas/types.yaml#/definitions/uint32
    -+        enum: [2500, 4096]
    -+        default: 4096
    ++        enum: [2500000, 4096000]
    ++        default: 4096000
     +
     +    required:
     +      - reg
    @@ Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml: examples:
     +            vrefin-supply = <&vdd_supply>;
     +
     +            channel@0 {
    -+                adi,internal-ref-mv = <4096>;
    ++                adi,internal-ref-microvolt = <4096000>;
     +                reg = <0>;
     +            };
     +
     +            channel@1 {
    -+                adi,internal-ref-mv = <2500>;
    ++                adi,internal-ref-microvolt = <2500000>;
     +                reg = <1>;
     +            };
     +
-:  ------------ > 5:  c48eb017058c iio: adc: ad7949: use devm managed functions

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

