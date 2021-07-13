Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6ABA3C696A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 06:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhGMEhm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 00:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhGMEh1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 00:37:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B86C0613E9;
        Mon, 12 Jul 2021 21:34:37 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i4so9268582qvq.10;
        Mon, 12 Jul 2021 21:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CZqXzksVbS77eyPBLtr2ilS4eBw3oQv5jyqUsYHg80=;
        b=AGI43NfjiMLoJeRKqAZZd7L5CgIG6SFR/WRBjYj7kpBcqbk4UkBhxQ+DRfkHJu06RI
         4ldC+9o0qKnGWMye8CYNmDqe0FWplYcFcE9zCtcVgI1XmKCWE+82BhJPqApD2DF9RK0Q
         p3fizjYgEOKO/i4q0ak2P8d6k/bRdC1DpL6KucfQdM8yKJKx3uWRnh+NqW/A/KFlYZlx
         Cj4hy9rvTtDWb2UzeoVReWd1ezA2xqgWt8BX7PKSSNrPmygjl9nKTdksQ2Rxes86Nlf0
         /gS07ZDAKarcM97RYKe7ewujJMpIpzOY3WLySzkOzkq0wZ7KinYEIiYJDvfk90jsPFHi
         4ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CZqXzksVbS77eyPBLtr2ilS4eBw3oQv5jyqUsYHg80=;
        b=jrTztSXgqq5j5cq1qP5MWu0HAqkV+lfaIrUxS9NCLzcerAzHL72WzizMErdN+KJXKg
         0xM1qPxfEzAnv0dP4xk+eOyvW9z8/vcyooL/NIFtqCkoTjkW4hIx+v3Gjgjjw1Psd7Hd
         1EjE9doeA+9wgua5YS+I/X841iyejIAaY3alj+2gI28qruXtps4uNwgrruPgaFjTNqRP
         BRVfKgDN2vI3H6QUdEPE3Eu9VaNyF0ylmp9seHjEXP36PgTXlJnLm/+SDIarpQBVTBtw
         Z4onCjzI4D7pt+110++RC9v7iJEHf1Z/vsMnURv4yqvMUIK98IAgRFQ6UZDEfp6Z494R
         rR2g==
X-Gm-Message-State: AOAM531zJTzNGNrbpM3rB7KA78Cres8y20YOUr/+L1iTB72gzv7BKPsj
        ibRByEt1ktTPqqTFKxMIC9Y=
X-Google-Smtp-Source: ABdhPJzwjj0MO0YvHIIACQimCCgVnL9Um1HTkF17W8F8V16KfL6277G29sj27yZ0CBfhKjW12Jpu9w==
X-Received: by 2002:ad4:4022:: with SMTP id q2mr2928703qvp.43.1626150874694;
        Mon, 12 Jul 2021 21:34:34 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x16sm7311455qkn.130.2021.07.12.21.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 21:34:34 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v3 0/4] AD7949 Fixes
Date:   Tue, 13 Jul 2021 00:34:21 -0400
Message-Id: <20210713043425.3321230-1-liambeguin@gmail.com>
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

Liam Beguin (4):
  iio: adc: ad7949: define and use bitfield names
  iio: adc: ad7949: fix spi messages on non 14-bit controllers
  iio: adc: ad7949: add support for internal vref
  dt-bindings: iio: adc: ad7949: add per channel reference

 .../bindings/iio/adc/adi,ad7949.yaml          |  71 ++++-
 drivers/iio/adc/ad7949.c                      | 243 +++++++++++++++---
 2 files changed, 280 insertions(+), 34 deletions(-)

Range-diff against v2:
1:  b8577e93229f ! 1:  8760b368f971 iio: adc: ad7949: define and use bitfield names
    @@ Commit message
     
      ## drivers/iio/adc/ad7949.c ##
     @@
    + #include <linux/module.h>
      #include <linux/regulator/consumer.h>
      #include <linux/spi/spi.h>
    ++#include <linux/bitfield.h>
      
     -#define AD7949_MASK_CHANNEL_SEL		GENMASK(9, 7)
      #define AD7949_MASK_TOTAL		GENMASK(13, 0)
     -#define AD7949_OFFSET_CHANNEL_SEL	7
     -#define AD7949_CFG_READ_BACK		0x1
    - #define AD7949_CFG_REG_SIZE_BITS	14
    - 
    -+#define AD7949_CFG_BIT_CFG		BIT(13)
    -+#define AD7949_CFG_VAL_CFG_OVERWRITE		1
    -+#define AD7949_CFG_VAL_CFG_KEEP			0
    +-#define AD7949_CFG_REG_SIZE_BITS	14
    ++
    ++/* CFG: Configuration Update */
    ++#define AD7949_CFG_BIT_OVERWRITE	BIT(13)
    ++
    ++/* INCC: Input Channel Configuration */
     +#define AD7949_CFG_BIT_INCC		GENMASK(12, 10)
     +#define AD7949_CFG_VAL_INCC_UNIPOLAR_GND	7
     +#define AD7949_CFG_VAL_INCC_UNIPOLAR_COMM	6
    @@ drivers/iio/adc/ad7949.c
     +#define AD7949_CFG_VAL_INCC_TEMP		3
     +#define AD7949_CFG_VAL_INCC_BIPOLAR		2
     +#define AD7949_CFG_VAL_INCC_BIPOLAR_DIFF	0
    ++
    ++/* INX: Input channel Selection in a binary fashion */
     +#define AD7949_CFG_BIT_INX		GENMASK(9, 7)
    -+#define AD7949_CFG_BIT_BW		BIT(6)
    -+#define AD7949_CFG_VAL_BW_FULL			1
    -+#define AD7949_CFG_VAL_BW_QUARTER		0
    ++
    ++/* BW: select bandwidth for low-pass filter. Full or Quarter */
    ++#define AD7949_CFG_BIT_BW_FULL			BIT(6)
    ++
    ++/* REF: reference/buffer selection */
     +#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
    ++#define AD7949_CFG_VAL_REF_EXT_BUF		7
    ++
    ++/* SEQ: channel sequencer. Allows for scanning channels */
     +#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
    -+#define AD7949_CFG_BIT_RBN		BIT(0)
     +
    ++/* RB: Read back the CFG register */
    ++#define AD7949_CFG_BIT_RBN		BIT(0)
    + 
      enum {
      	ID_AD7949 = 0,
    - 	ID_AD7682,
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
      	 */
      	for (i = 0; i < 2; i++) {
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7
      	ad7949_adc->current_channel = 0;
     -	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
     +
    -+	cfg = FIELD_PREP(AD7949_CFG_BIT_CFG, AD7949_CFG_VAL_CFG_OVERWRITE) |
    ++	cfg = FIELD_PREP(AD7949_CFG_BIT_OVERWRITE, 1) |
     +		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
     +		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
    -+		FIELD_PREP(AD7949_CFG_BIT_BW, AD7949_CFG_VAL_BW_FULL) |
    -+		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_REF_EXT_BUF) |
    ++		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
    ++		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
     +		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
     +		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
     +
2:  a8468391e3d0 ! 2:  a9243c834705 iio: adc: ad7949: fix spi messages on non 14-bit controllers
    @@ Commit message
     
      ## drivers/iio/adc/ad7949.c ##
     @@
    - #include <linux/module.h>
      #include <linux/regulator/consumer.h>
      #include <linux/spi/spi.h>
    -+#include <linux/bitfield.h>
    + #include <linux/bitfield.h>
    ++#include <asm/unaligned.h>
      
      #define AD7949_MASK_TOTAL		GENMASK(13, 0)
    - #define AD7949_CFG_REG_SIZE_BITS	14
    + 
     @@ drivers/iio/adc/ad7949.c: static const struct ad7949_adc_spec ad7949_adc_spec[] = {
       * @indio_dev: reference to iio structure
       * @spi: reference to spi structure
    @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
     +	u8 bits_per_word;
      	u16 cfg;
      	unsigned int current_channel;
    --	u16 buffer ____cacheline_aligned;
    -+	union {
    -+		__be16 buffer;
    -+		u8 buf8[2];
    -+	} ____cacheline_aligned;
    - };
    - 
    -+static void ad7949_set_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
    -+{
    -+	u32 adc_mask = SPI_BPW_MASK(ad7949_adc->resolution);
    -+	u32 bpw = adc_mask & ad7949_adc->spi->controller->bits_per_word_mask;
    -+
    -+	if (bpw == adc_mask)
    -+		ad7949_adc->bits_per_word = ad7949_adc->resolution;
    -+	else if (bpw == SPI_BPW_MASK(16))
    -+		ad7949_adc->bits_per_word = 16;
    -+	else
    -+		ad7949_adc->bits_per_word = 8;
    -+}
    -+
    - static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
    + 	u16 buffer ____cacheline_aligned;
    +@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
      				u16 mask)
      {
      	int ret;
     -	int bits_per_word = ad7949_adc->resolution;
     -	int shift = bits_per_word - AD7949_CFG_REG_SIZE_BITS;
    ++	u8 buf8[2];
      	struct spi_message msg;
      	struct spi_transfer tx[] = {
      		{
    @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
     +		ad7949_adc->buffer = ad7949_adc->cfg;
     +		break;
     +	case 8:
    -+	default:
     +		/* Pack 14-bit value into 2 bytes, MSB first */
    -+		ad7949_adc->buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
    -+		ad7949_adc->buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
    -+		ad7949_adc->buf8[1] = ad7949_adc->buf8[1] << 2;
    ++		buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
    ++		buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg) << 2;
    ++		memcpy(&ad7949_adc->buffer, buf8, 2);
     +		break;
    ++	default:
    ++		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
    ++		return -EINVAL;
     +	}
     +
      	spi_message_init_with_transfers(&msg, tx, 1);
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
      	int i;
     -	int bits_per_word = ad7949_adc->resolution;
     -	int mask = GENMASK(ad7949_adc->resolution - 1, 0);
    ++	u8 buf8[2];
      	struct spi_message msg;
      	struct spi_transfer tx[] = {
      		{
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
     +	case 16:
     +		*val = ad7949_adc->buffer;
     +		/* Shift-out padding bits */
    -+		if (ad7949_adc->resolution == 14)
    -+			*val = *val >> 2;
    ++		*val >>= 16 - ad7949_adc->resolution;
     +		break;
     +	case 14:
     +		*val = ad7949_adc->buffer & GENMASK(13, 0);
     +		break;
     +	case 8:
    -+	default:
    ++		memcpy(buf8, &ad7949_adc->buffer, 2);
     +		/* Convert byte array to u16, MSB first */
    -+		*val = (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];
    ++		*val = get_unaligned_be16(buf8);
     +		/* Shift-out padding bits */
    -+		if (ad7949_adc->resolution == 14)
    -+			*val = *val >> 2;
    ++		*val >>= 16 - ad7949_adc->resolution;
     +		break;
    ++	default:
    ++		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
    ++		return -EINVAL;
     +	}
      
      	return 0;
      }
    +@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
    + 
    + static int ad7949_spi_probe(struct spi_device *spi)
    + {
    ++	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
    + 	struct device *dev = &spi->dev;
    + 	const struct ad7949_adc_spec *spec;
    + 	struct ad7949_adc_chip *ad7949_adc;
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
    - 	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
      	indio_dev->num_channels = spec->num_channels;
      	ad7949_adc->resolution = spec->resolution;
    -+	ad7949_set_bits_per_word(ad7949_adc);
      
    ++	/* Set SPI bits per word */
    ++	if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
    ++		ad7949_adc->bits_per_word = ad7949_adc->resolution;
    ++	} else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
    ++		ad7949_adc->bits_per_word = 16;
    ++	} else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
    ++		ad7949_adc->bits_per_word = 8;
    ++	} else {
    ++		dev_err(dev, "unable to find common BPW with spi controller\n");
    ++		return -EINVAL;
    ++	}
    ++
      	ad7949_adc->vref = devm_regulator_get(dev, "vref");
      	if (IS_ERR(ad7949_adc->vref)) {
    + 		dev_err(dev, "fail to request regulator\n");
3:  4b0c11c9a748 < -:  ------------ iio: adc: ad7949: add support for internal vref
4:  a3b6a6ef15fd < -:  ------------ dt-bindings: iio: adc: ad7949: add adi,reference-source
-:  ------------ > 3:  bb25b7fcb0a3 iio: adc: ad7949: add support for internal vref
-:  ------------ > 4:  41e3ca4f0d52 dt-bindings: iio: adc: ad7949: add per channel reference

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

