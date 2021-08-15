Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF33ECB64
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhHOVfL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhHOVfJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 17:35:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58390C0612A9;
        Sun, 15 Aug 2021 14:33:53 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id b1so12920703qtx.0;
        Sun, 15 Aug 2021 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nc2oCNl3SgD83XJnElnCfknnwHbVSW3lQCTaQK0STF0=;
        b=m7PN5HOpIvktIsyfDZROCyzxTjEBpel2mVJxKIJ6knVAHTOu+cRQojtsqwYi9Hr2Z3
         Mh/QjrPEb+2suiLnj14smrL1ZKRCLenyKVmBmQ+ApfXHmBV3LDUmU5wujtKHVtqcVKK5
         6QijK5SW4g3RUgJV8xx+fJAfsABZR7bnDlRN6ATQ2BawJLna9Hux5ObkSyY5iuTvf8o2
         oGotEYLLU7Ab5pms0YadMmAm218HSLOAfGEXYaXvgNOAQGOQcj+PXSNSv8G/ZTbpCBEP
         Y2D9GtEDjx7kYc0wIdvizQJEZy0NcLE8QZzFtE1yPLOqWonnlEqCPs9s5wb77OoYBjqX
         IUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nc2oCNl3SgD83XJnElnCfknnwHbVSW3lQCTaQK0STF0=;
        b=EM3YR0gIbU340RouBQEGHkIjyTyTBGwtyr0uOceQ0OG0CU+3QfpiPcSbCu+fV+Efy1
         A1/zhrkapnnJO6yMuQPXvFhNRPaM4NUbE3xh4VE7UuERtS9WGHZjz+FLaki5H3bxcN6C
         3iBC7htSdz07sPvxje+G8KipKK4FmV+Sf90UBCJigE2/bwSaxwnXoPsuQEAQfiZ4//uA
         tL2YB7zneMKANNaDhe3ltECE54leyBq/PuHZBXvoLKOmiwSS/CSH7cNvL9cdsCezOzZ+
         in3tt53TJsY245NkkqF/yiQxu3KMlFEh/0ZZJ34jZGxIe/8ohjY98GAVfEsz4+dq6b9i
         S7EA==
X-Gm-Message-State: AOAM531+a6HeAcfbmAwz7YPMvAqHnSTtBb3eEsUmPOBNCksoTAfN08S+
        2uabO+n+oEncEPF7ErnYRRw=
X-Google-Smtp-Source: ABdhPJxyh2FM680qFiFxGGJowdVhLrAjSuoUtdBGGr+kxMBWBxcgPM3lHjF9q7GfGd2nKjAK42WzWg==
X-Received: by 2002:ac8:7d4c:: with SMTP id h12mr11344951qtb.257.1629063232322;
        Sun, 15 Aug 2021 14:33:52 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u19sm3870988qtx.48.2021.08.15.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 14:33:51 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 0/5] AD7949 Fixes
Date:   Sun, 15 Aug 2021 17:33:04 -0400
Message-Id: <20210815213309.2847711-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While working on another series[1] I ran into issues where my SPI
controller would fail to handle 14-bit and 16-bit SPI messages. This
addresses that issue and adds support for selecting a different voltage
reference source from the devicetree.

v1 was base on a series[2] that seems to not have made it all the way,
and was tested on an ad7689.

v6 drops support for per channel vref selection.
After switching the voltage reference, readings take a little while to
stabilize, invalidating consecutive readings.

This could've been addressed by adding more dummy cycles at the expense
of speed, but discussing the issue with colleagues more involved in
hardware design, it turns out these circuits are usually designed with a
single vref in mind.

[1] https://patchwork.kernel.org/project/linux-iio/list/?series=511545
[2] https://patchwork.kernel.org/project/linux-iio/list/?series=116971&state=%2A&archive=both

Changes since v5:
- rename defines: s/AD7949_CFG_BIT_/AD7949_CFG_MASK_/g
- rename AD7949_MASK_TOTAL to match other defines
- make vref selection global instead of per channel, and update
  dt-bindings
- reword commits 2/5, 3/5, and 4/5
- move bits_per_word configuration to struct spi_device, and switch to
  spi_{read,write}.

Changes since v4:
- fix premature deletion of define
- use separate be16 buffer for 8-bit transfers
- switch to devm_regulator_get_optional()
- fix vref setup
- apply Reviewed-by

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
  iio: adc: ad7949: add vref selection support
  dt-bindings: iio: adc: ad7949: update voltage reference bindings
  iio: adc: ad7949: use devm managed functions

 .../bindings/iio/adc/adi,ad7949.yaml          |  51 +++-
 drivers/iio/adc/ad7949.c                      | 258 +++++++++++++-----
 2 files changed, 232 insertions(+), 77 deletions(-)

Range-diff against v5:
1:  a5c211185661 ! 1:  a8d849189b6e iio: adc: ad7949: define and use bitfield names
    @@ drivers/iio/adc/ad7949.c
     +#include <linux/bitfield.h>
      
     -#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
    - #define AD7949_MASK_TOTAL		GENMASK(13, 0)
    +-#define AD7949_MASK_TOTAL		GENMASK(13, 0)
     -#define AD7949_OFFSET_CHANNEL_SEL	7
     -#define AD7949_CFG_READ_BACK		0x1
    ++#define AD7949_CFG_MASK_TOTAL		GENMASK(13, 0)
      #define AD7949_CFG_REG_SIZE_BITS	14
      
     +/* CFG: Configuration Update */
    -+#define AD7949_CFG_BIT_OVERWRITE	BIT(13)
    ++#define AD7949_CFG_MASK_OVERWRITE	BIT(13)
     +
     +/* INCC: Input Channel Configuration */
    -+#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)
    ++#define AD7949_CFG_MASK_INCC		GENMASK(12, 10)
     +#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
     +#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
     +#define AD7949_CFG_VAL_INCC_UNIPOLAR_DIFF	4
    @@ drivers/iio/adc/ad7949.c
     +#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
     +
     +/* INX: Input channel Selection in a binary fashion */
    -+#define AD7949_CFG_BIT_INX		GENMASK(9, 7)
    ++#define AD7949_CFG_MASK_INX		GENMASK(9, 7)
     +
     +/* BW: select bandwidth for low-pass filter. Full or Quarter */
    -+#define AD7949_CFG_BIT_BW_FULL			BIT(6)
    ++#define AD7949_CFG_MASK_BW_FULL		BIT(6)
     +
     +/* REF: reference/buffer selection */
    -+#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
    ++#define AD7949_CFG_MASK_REF		GENMASK(5, 3)
     +#define AD7949_CFG_VAL_REF_EXT_BUF		7
     +
     +/* SEQ: channel sequencer. Allows for scanning channels */
    -+#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
    ++#define AD7949_CFG_MASK_SEQ		GENMASK(2, 1)
     +
     +/* RB: Read back the CFG register */
    -+#define AD7949_CFG_BIT_RBN		BIT(0)
    ++#define AD7949_CFG_MASK_RBN		BIT(0)
     +
      enum {
      	ID_AD7949 = 0,
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
      		ret = ad7949_spi_write_cfg(ad7949_adc,
     -					   channel << AD7949_OFFSET_CHANNEL_SEL,
     -					   AD7949_MASK_CHANNEL_SEL);
    -+					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
    -+					   AD7949_CFG_BIT_INX);
    ++					   FIELD_PREP(AD7949_CFG_MASK_INX, channel),
    ++					   AD7949_CFG_MASK_INX);
      		if (ret)
      			return ret;
      		if (channel == ad7949_adc->current_channel)
    +@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_reg_access(struct iio_dev *indio_dev,
    + 	if (readval)
    + 		*readval = ad7949_adc->cfg;
    + 	else
    +-		ret = ad7949_spi_write_cfg(ad7949_adc,
    +-			writeval & AD7949_MASK_TOTAL, AD7949_MASK_TOTAL);
    ++		ret = ad7949_spi_write_cfg(ad7949_adc, writeval,
    ++					   AD7949_CFG_MASK_TOTAL);
    + 
    + 	return ret;
    + }
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
      {
      	int ret;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7
      	ad7949_adc->current_channel = 0;
     -	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
     +
    -+	cfg = FIELD_PREP(AD7949_CFG_BIT_OVERWRITE, 1) |
    -+		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
    -+		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
    -+		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
    -+		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
    -+		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
    -+		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
    ++	cfg = FIELD_PREP(AD7949_CFG_MASK_OVERWRITE, 1) |
    ++		FIELD_PREP(AD7949_CFG_MASK_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
    ++		FIELD_PREP(AD7949_CFG_MASK_INX, ad7949_adc->current_channel) |
    ++		FIELD_PREP(AD7949_CFG_MASK_BW_FULL, 1) |
    ++		FIELD_PREP(AD7949_CFG_MASK_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
    ++		FIELD_PREP(AD7949_CFG_MASK_SEQ, 0x0) |
    ++		FIELD_PREP(AD7949_CFG_MASK_RBN, 1);
     +
    -+	ret = ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_MASK_TOTAL);
    ++	ret = ad7949_spi_write_cfg(ad7949_adc, cfg, AD7949_CFG_MASK_TOTAL);
      
      	/*
      	 * Do two dummy conversions to apply the first configuration setting.
2:  df2f6df8f3d5 ! 2:  dfa817a7c51e iio: adc: ad7949: fix spi messages on non 14-bit controllers
    @@ Commit message
         iio: adc: ad7949: fix spi messages on non 14-bit controllers
     
         This driver supports devices with 14-bit and 16-bit sample sizes.
    -    This is not always handled properly by spi controllers and can fail. To
    -    work around this limitation, pad samples to 16-bit and split the sample
    -    into two 8-bit messages in the event that only 8-bit messages are
    -    supported by the controller.
    +    This implies different SPI transfer lengths which are not always handled
    +    properly by some SPI controllers.
    +
    +    To work around this limitation, define a big endian buffer used to split
    +    the buffer into two 8-bit messages in the event that the controller
    +    doesn't support 14-bit or 16-bit transfers.
    +    A separate buffer is introduced here to avoid performing operations on
    +    types of different endianness.
    +
    +    Since all transfers use the same bits_per_word value, move that logic to
    +    the probe function, and let transfers default to the value defined in
    +    the struct spi_device.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
    @@ drivers/iio/adc/ad7949.c
     @@
      #include <linux/bitfield.h>
      
    - #define AD7949_MASK_TOTAL		GENMASK(13, 0)
    + #define AD7949_CFG_MASK_TOTAL		GENMASK(13, 0)
     -#define AD7949_CFG_REG_SIZE_BITS	14
      
      /* CFG: Configuration Update */
    - #define AD7949_CFG_BIT_OVERWRITE	BIT(13)
    + #define AD7949_CFG_MASK_OVERWRITE	BIT(13)
     @@ drivers/iio/adc/ad7949.c: static const struct ad7949_adc_spec ad7949_adc_spec[] = {
    -  * @indio_dev: reference to iio structure
    -  * @spi: reference to spi structure
    -  * @resolution: resolution of the chip
    -+ * @bits_per_word: number of bits per SPI word
       * @cfg: copy of the configuration register
       * @current_channel: current channel in use
       * @buffer: buffer to send / receive data to / from device
    @@ drivers/iio/adc/ad7949.c: static const struct ad7949_adc_spec ad7949_adc_spec[]
      struct ad7949_adc_chip {
      	struct mutex lock;
     @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
    - 	struct iio_dev *indio_dev;
    - 	struct spi_device *spi;
    - 	u8 resolution;
    -+	u8 bits_per_word;
      	u16 cfg;
      	unsigned int current_channel;
      	u16 buffer ____cacheline_aligned;
    @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
      	int ret;
     -	int bits_per_word = ad7949_adc->resolution;
     -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
    - 	struct spi_message msg;
    - 	struct spi_transfer tx[] = {
    - 		{
    +-	struct spi_message msg;
    +-	struct spi_transfer tx[] = {
    +-		{
     -			.tx_buf = &ad7949_adc->buffer,
    - 			.len = 2,
    +-			.len = 2,
     -			.bits_per_word = bits_per_word,
    -+			.bits_per_word = ad7949_adc->bits_per_word,
    - 		},
    - 	};
    +-		},
    +-	};
      
      	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
     -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
    +-	spi_message_init_with_transfers(&msg, tx, 1);
    +-	ret = spi_sync(ad7949_adc->spi, &msg);
     +
    -+	switch (ad7949_adc->bits_per_word) {
    ++	switch (ad7949_adc->spi->bits_per_word) {
     +	case 16:
    -+		tx[0].tx_buf = &ad7949_adc->buffer;
     +		ad7949_adc->buffer = ad7949_adc->cfg << 2;
    ++		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buffer, 2);
     +		break;
     +	case 14:
    -+		tx[0].tx_buf = &ad7949_adc->buffer;
     +		ad7949_adc->buffer = ad7949_adc->cfg;
    ++		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buffer, 2);
     +		break;
     +	case 8:
     +		/* Here, type is big endian as it must be sent in two transfers */
    -+		tx[0].tx_buf = &ad7949_adc->buf8b;
     +		ad7949_adc->buf8b = cpu_to_be16(ad7949_adc->cfg << 2);
    ++		ret = spi_write(ad7949_adc->spi, &ad7949_adc->buf8b, 2);
     +		break;
     +	default:
     +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
     +		return -EINVAL;
     +	}
    -+
    - 	spi_message_init_with_transfers(&msg, tx, 1);
    - 	ret = spi_sync(ad7949_adc->spi, &msg);
      
    + 	/*
    + 	 * This delay is to avoid a new request before the required time to
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
      {
      	int ret;
      	int i;
     -	int bits_per_word = ad7949_adc->resolution;
     -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
    - 	struct spi_message msg;
    - 	struct spi_transfer tx[] = {
    - 		{
    +-	struct spi_message msg;
    +-	struct spi_transfer tx[] = {
    +-		{
     -			.rx_buf = &ad7949_adc->buffer,
    - 			.len = 2,
    +-			.len = 2,
     -			.bits_per_word = bits_per_word,
    -+			.bits_per_word = ad7949_adc->bits_per_word,
    - 		},
    - 	};
    +-		},
    +-	};
      
    -+	if (ad7949_adc->bits_per_word == 8)
    -+		tx[0].rx_buf = &ad7949_adc->buf8b;
    -+	else
    -+		tx[0].rx_buf = &ad7949_adc->buffer;
    -+
      	/*
      	 * 1: write CFG for sample N and read old data (sample N-2)
    - 	 * 2: if CFG was not changed since sample N-1 then we'll get good data
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
      	}
      
      	/* 3: write something and read actual data */
     -	ad7949_adc->buffer = 0;
    - 	spi_message_init_with_transfers(&msg, tx, 1);
    - 	ret = spi_sync(ad7949_adc->spi, &msg);
    +-	spi_message_init_with_transfers(&msg, tx, 1);
    +-	ret = spi_sync(ad7949_adc->spi, &msg);
    ++	if (ad7949_adc->spi->bits_per_word == 8)
    ++		ret = spi_read(ad7949_adc->spi, &ad7949_adc->buf8b, 2);
    ++	else
    ++		ret = spi_read(ad7949_adc->spi, &ad7949_adc->buffer, 2);
    ++
      	if (ret)
    + 		return ret;
    + 
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
      
      	ad7949_adc->current_channel = channel;
      
     -	*val = ad7949_adc->buffer & mask;
    -+	switch (ad7949_adc->bits_per_word) {
    ++	switch (ad7949_adc->spi->bits_per_word) {
     +	case 16:
     +		*val = ad7949_adc->buffer;
     +		/* Shift-out padding bits */
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
      
     +	/* Set SPI bits per word */
     +	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
    -+		ad7949_adc->bits_per_word = ad7949_adc->resolution;
    ++		spi->bits_per_word = ad7949_adc->resolution;
     +	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
    -+		ad7949_adc->bits_per_word = 16;
    ++		spi->bits_per_word = 16;
     +	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
    -+		ad7949_adc->bits_per_word = 8;
    ++		spi->bits_per_word = 8;
     +	} else {
     +		dev_err(dev, "unable to find common BPW with spi controller\n");
     +		return -EINVAL;
3:  8a33618a4f90 ! 3:  aae4f239db77 iio: adc: ad7949: add support for internal vref
    @@ Metadata
     Author: Liam Beguin <lvb@xiphos.com>
     
      ## Commit message ##
    -    iio: adc: ad7949: add support for internal vref
    +    iio: adc: ad7949: add vref selection support
     
    -    Add support for selecting a custom reference voltage from the
    -    devicetree. If an external source is used, a vref regulator should be
    -    defined in the devicetree.
    +    Add support for selecting the voltage reference from the devicetree.
    +
    +    This change is required to get valid readings with all three
    +    vref hardware configurations supported by the ADC.
    +
    +    For instance if the ADC isn't provided with an external reference,
    +    the sample request must specify an internal voltage reference to get a
    +    valid reading.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
    @@ drivers/iio/adc/ad7949.c
     @@
      
      /* REF: reference/buffer selection */
    - #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
    + #define AD7949_CFG_MASK_REF		GENMASK(5, 3)
     -#define AD7949_CFG_VAL_REF_EXT_BUF		7
     +#define AD7949_CFG_VAL_REF_EXT_TEMP_BUF		3
     +#define AD7949_CFG_VAL_REF_EXT_TEMP		2
    @@ drivers/iio/adc/ad7949.c
     +#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
      
      /* SEQ: channel sequencer. Allows for scanning channels */
    - #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
    + #define AD7949_CFG_MASK_SEQ		GENMASK(2, 1)
     @@ drivers/iio/adc/ad7949.c: static const struct ad7949_adc_spec ad7949_adc_spec[] = {
    - 	[ID_AD7689] = { .num_channels = 8, .resolution = 16 },
    - };
    - 
    -+/**
    -+ * struct ad7949_channel - ADC Channel parameters
    +  * @vref: regulator generating Vref
    +  * @indio_dev: reference to iio structure
    +  * @spi: reference to spi structure
     + * @refsel: reference selection
    -+ */
    -+struct ad7949_channel {
    -+	u32 refsel;
    -+};
    -+
    - /**
    -  * struct ad7949_adc_chip - AD ADC chip
    -  * @lock: protects write sequences
    +  * @resolution: resolution of the chip
    +  * @cfg: copy of the configuration register
    +  * @current_channel: current channel in use
     @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
      	struct regulator *vref;
      	struct iio_dev *indio_dev;
      	struct spi_device *spi;
    -+	struct ad7949_channel *channels;
    ++	u32 refsel;
      	u8 resolution;
    - 	u8 bits_per_word;
      	u16 cfg;
    -@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
    - 	int ret;
    - 	int i;
    - 	struct spi_message msg;
    -+	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[channel];
    - 	struct spi_transfer tx[] = {
    - 		{
    - 			.len = 2,
    -@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
    - 	 */
    - 	for (i = 0; i < 2; i++) {
    - 		ret = ad7949_spi_write_cfg(ad7949_adc,
    --					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
    --					   AD7949_CFG_BIT_INX);
    -+					   FIELD_PREP(AD7949_CFG_BIT_INX, channel) |
    -+					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan->refsel),
    -+					   AD7949_CFG_BIT_INX | AD7949_CFG_BIT_REF);
    - 		if (ret)
    - 			return ret;
    - 		if (channel == ad7949_adc->current_channel)
    -@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
    - 			   int *val, int *val2, long mask)
    - {
    - 	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
    -+	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[chan->channel];
    - 	int ret;
    - 
    - 	if (!val)
    + 	unsigned int current_channel;
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
      		return IIO_VAL_INT;
      
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_raw(struct iio_dev *indio_d
     -		ret = regulator_get_voltage(ad7949_adc->vref);
     -		if (ret < 0)
     -			return ret;
    -+		switch (ad7949_chan->refsel) {
    ++		switch (ad7949_adc->refsel) {
     +		case AD7949_CFG_VAL_REF_INT_2500:
     +			*val = 2500;
     +			break;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_raw(struct iio_dev *indio_d
      
      	return -EINVAL;
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
    - 		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
    - 		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
    - 		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
    --		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
    -+		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->channels[0].refsel) |
    - 		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
    - 		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
    + 		FIELD_PREP(AD7949_CFG_MASK_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
    + 		FIELD_PREP(AD7949_CFG_MASK_INX, ad7949_adc->current_channel) |
    + 		FIELD_PREP(AD7949_CFG_MASK_BW_FULL, 1) |
    +-		FIELD_PREP(AD7949_CFG_MASK_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
    ++		FIELD_PREP(AD7949_CFG_MASK_REF, ad7949_adc->refsel) |
    + 		FIELD_PREP(AD7949_CFG_MASK_SEQ, 0x0) |
    + 		FIELD_PREP(AD7949_CFG_MASK_RBN, 1);
      
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
      	return ret;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7
      static int ad7949_spi_probe(struct spi_device *spi)
      {
      	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
    - 	struct device *dev = &spi->dev;
    +@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
      	const struct ad7949_adc_spec *spec;
      	struct ad7949_adc_chip *ad7949_adc;
    -+	struct ad7949_channel *ad7949_chan;
    -+	struct fwnode_handle *child;
      	struct iio_dev *indio_dev;
    -+	int mode;
     +	u32 tmp;
      	int ret;
    -+	int i;
      
      	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
    - 	if (!indio_dev) {
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
      		return -EINVAL;
      	}
      
     -	ad7949_adc->vref = devm_regulator_get(dev, "vref");
    -+	/* Setup external voltage ref, buffered? */
    ++	/* Setup internal voltage reference */
    ++	tmp = 4096000;
    ++	ret = device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);
    ++	if (ret < 0 && ret != -EINVAL) {
    ++		dev_err(dev, "invalid value for adi,internal-ref-microvolt\n");
    ++		return ret;
    ++	}
    ++
    ++	switch (tmp) {
    ++	case 2500000:
    ++		ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_2500;
    ++		break;
    ++	case 4096000:
    ++		ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_4096;
    ++		break;
    ++	default:
    ++		dev_err(dev, "unsupported internal voltage reference\n");
    ++		return -EINVAL;
    ++	}
    ++
    ++	/* Setup external voltage reference, buffered? */
     +	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
      	if (IS_ERR(ad7949_adc->vref)) {
     -		dev_err(dev, "fail to request regulator\n");
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
     +			ret = PTR_ERR(ad7949_adc->vref);
     +			if (ret != -ENODEV)
     +				return ret;
    -+			/* Internal then */
    -+			mode = AD7949_CFG_VAL_REF_INT_4096;
     +		} else {
    -+			mode = AD7949_CFG_VAL_REF_EXT_TEMP;
    ++			ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP;
     +		}
     +	} else {
    -+		mode = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
    ++		ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
      	}
      
     -	ret = regulator_enable(ad7949_adc->vref);
     -	if (ret < 0) {
     -		dev_err(dev, "fail to enable regulator\n");
     -		return ret;
    -+	if (mode & AD7949_CFG_VAL_REF_EXTERNAL) {
    ++	if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
     +		ret = regulator_enable(ad7949_adc->vref);
     +		if (ret < 0) {
     +			dev_err(dev, "fail to enable regulator\n");
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
     +					       ad7949_adc->vref);
     +		if (ret)
     +			return ret;
    -+	}
    -+
    -+	ad7949_adc->channels = devm_kcalloc(dev, spec->num_channels,
    -+					    sizeof(*ad7949_adc->channels),
    -+					    GFP_KERNEL);
    -+	if (!ad7949_adc->channels) {
    -+		dev_err(dev, "unable to allocate ADC channels\n");
    -+		return -ENOMEM;
    -+	}
    -+
    -+	/* Initialize all channel structures */
    -+	for (i = 0; i < spec->num_channels; i++)
    -+		ad7949_adc->channels[i].refsel = mode;
    -+
    -+	/* Read channel specific information form the devicetree */
    -+	device_for_each_child_node(dev, child) {
    -+		ret = fwnode_property_read_u32(child, "reg", &i);
    -+		if (ret) {
    -+			dev_err(dev, "missing reg property in %pfw\n", child);
    -+			fwnode_handle_put(child);
    -+			return ret;
    -+		}
    -+
    -+		ad7949_chan = &ad7949_adc->channels[i];
    -+
    -+		ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
    -+		if (ret < 0 && ret != -EINVAL) {
    -+			dev_err(dev, "invalid internal reference in %pfw\n", child);
    -+			fwnode_handle_put(child);
    -+			return ret;
    -+		}
    -+
    -+		switch (tmp) {
    -+		case 2500000:
    -+			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_2500;
    -+			break;
    -+		case 4096000:
    -+			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_4096;
    -+			break;
    -+		default:
    -+			dev_err(dev, "unsupported internal voltage reference\n");
    -+			fwnode_handle_put(child);
    -+			return -EINVAL;
    -+		}
      	}
      
      	mutex_init(&ad7949_adc->lock);
4:  7612ff29db6b < -:  ------------ dt-bindings: iio: adc: ad7949: add per channel reference
-:  ------------ > 4:  b0f21366439b dt-bindings: iio: adc: ad7949: update voltage reference bindings
5:  74ee82caba57 = 5:  fb2347e306dd iio: adc: ad7949: use devm managed functions

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.32.0.452.g940fe202adcb

