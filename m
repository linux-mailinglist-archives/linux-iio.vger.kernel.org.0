Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673423E37D7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 03:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhHHB5u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 21:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHHB5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 21:57:50 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DDDC061760;
        Sat,  7 Aug 2021 18:57:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s11so7180817qvz.7;
        Sat, 07 Aug 2021 18:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWNxPiP1jfrKqmQ3qcfNiXA7SOGFgEh6fUX4gAfkBb8=;
        b=nZPZrtm7wM8PJoYxSnv3bWUa5GoLv0BeBJOJnHw5QP1fpjMjBCugAOa0hFokDfDW9B
         skqGLe6IWEu8mqXE//JOZdiIP3y7LG5DcQ5gCNEw3ZzmH8/YCZNrmpv7kaIacZMCJH65
         XBiAQ7yHx0REzKGLyjacXNG7kenqhp9/ZdjFi1RK86rH4+jKytFAPPc0fieDyIRwx79d
         dH6Csr84UyrmAufxw2GWsAr0eNL6/Awn/hBW6kLm83/yDRgRzxIpXMDRu6shfm3RKCse
         thbXTksBzzyBIRz6TGrhHMVqoKF6VggiPcykkSDmTZXwsV7dAt6FCIq76Po4eigAgPfj
         gCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eWNxPiP1jfrKqmQ3qcfNiXA7SOGFgEh6fUX4gAfkBb8=;
        b=muX9UUuIkT1PS2jBRUhbncbYa+cicnJqP/w52c7s+PKi58peftrOEcS3tVSR32+jk5
         SKaNDN5upTVPgAroTQUnAnVs4//Q35UDBkUGsu7dNTFTr8YtmRLer6RIBkG0tVnbVxvm
         SG6NxMDRk4/LDp0ZGhlKYXjZA1QJTlJrYk4hDD5hoQU51hVrRQ1XqrVtXanjZwQYhvM3
         KP4G3Kgh7hOkNRMZVFePAZxDobs6EpbrSmKkq6PQTtOYR2DHNn+8zdGJlVSnue2jT5vQ
         NTeTpVz9dWp2aU0NEpMU886wy8hHWZYZBi1Fl5Jb7CQPobDUUhmwz9JWxySVJ24tjv12
         s+CA==
X-Gm-Message-State: AOAM5319IBMsd9u7DRozzwg2ukxpH02bNEiajGOnpj36hMQNqjbBJfkz
        YaU0l/IzCB6UV476D7M9HKs=
X-Google-Smtp-Source: ABdhPJyn9wuwQBO0PHZ5CMZWt13+PLmSl74jjOLWO77MNEgHyyJqm2XQ6SQ7pwv8eRwp7tJ2MEO6MQ==
X-Received: by 2002:a05:6214:2ce:: with SMTP id g14mr17847863qvu.46.1628387850076;
        Sat, 07 Aug 2021 18:57:30 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id k24sm1569612qki.11.2021.08.07.18.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 18:57:29 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 0/5] AD7949 Fixes
Date:   Sat,  7 Aug 2021 21:56:54 -0400
Message-Id: <20210808015659.2955443-1-liambeguin@gmail.com>
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

V1 was base on a series[2] that seems to not have made it all the way,
and was tested on an ad7689.

[1] https://patchwork.kernel.org/project/linux-iio/list/?series=511545
[2] https://patchwork.kernel.org/project/linux-iio/list/?series=116971&state=%2A&archive=both

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
  iio: adc: ad7949: add support for internal vref
  dt-bindings: iio: adc: ad7949: add per channel reference
  iio: adc: ad7949: use devm managed functions

 .../bindings/iio/adc/adi,ad7949.yaml          |  69 ++++-
 drivers/iio/adc/ad7949.c                      | 281 ++++++++++++++----
 2 files changed, 291 insertions(+), 59 deletions(-)

Range-diff against v4:
1:  8760b368f971 ! 1:  a5c211185661 iio: adc: ad7949: define and use bitfield names
    @@ drivers/iio/adc/ad7949.c
      #define AD7949_MASK_TOTAL		GENMASK(13, 0)
     -#define AD7949_OFFSET_CHANNEL_SEL	7
     -#define AD7949_CFG_READ_BACK		0x1
    --#define AD7949_CFG_REG_SIZE_BITS	14
    -+
    + #define AD7949_CFG_REG_SIZE_BITS	14
    + 
     +/* CFG: Configuration Update */
     +#define AD7949_CFG_BIT_OVERWRITE	BIT(13)
     +
    @@ drivers/iio/adc/ad7949.c
     +
     +/* RB: Read back the CFG register */
     +#define AD7949_CFG_BIT_RBN		BIT(0)
    - 
    ++
      enum {
      	ID_AD7949 = 0,
    + 	ID_AD7682,
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
      	 */
      	for (i = 0; i < 2; i++) {
2:  7b1484f2fc4c ! 2:  df2f6df8f3d5 iio: adc: ad7949: fix spi messages on non 14-bit controllers
    @@ Commit message
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
      ## drivers/iio/adc/ad7949.c ##
    +@@
    + #include <linux/bitfield.h>
    + 
    + #define AD7949_MASK_TOTAL		GENMASK(13, 0)
    +-#define AD7949_CFG_REG_SIZE_BITS	14
    + 
    + /* CFG: Configuration Update */
    + #define AD7949_CFG_BIT_OVERWRITE	BIT(13)
     @@ drivers/iio/adc/ad7949.c: static const struct ad7949_adc_spec ad7949_adc_spec[] = {
       * @indio_dev: reference to iio structure
       * @spi: reference to spi structure
    @@ drivers/iio/adc/ad7949.c: static const struct ad7949_adc_spec ad7949_adc_spec[]
       * @cfg: copy of the configuration register
       * @current_channel: current channel in use
       * @buffer: buffer to send / receive data to / from device
    ++ * @buf8b: be16 buffer to exchange data with the device in 8-bit transfers
    +  */
    + struct ad7949_adc_chip {
    + 	struct mutex lock;
     @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
      	struct iio_dev *indio_dev;
      	struct spi_device *spi;
    @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
      	u16 cfg;
      	unsigned int current_channel;
      	u16 buffer ____cacheline_aligned;
    -@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
    ++	__be16 buf8b;
    + };
    + 
    + static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
      				u16 mask)
      {
      	int ret;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_write_cfg(struct ad7949_adc_chip
      	struct spi_message msg;
      	struct spi_transfer tx[] = {
      		{
    - 			.tx_buf = &ad7949_adc->buffer,
    +-			.tx_buf = &ad7949_adc->buffer,
      			.len = 2,
     -			.bits_per_word = bits_per_word,
     +			.bits_per_word = ad7949_adc->bits_per_word,
      		},
      	};
      
    -+	ad7949_adc->buffer = 0;
      	ad7949_adc->cfg = (val & mask) | (ad7949_adc->cfg & ~mask);
     -	ad7949_adc->buffer = ad7949_adc->cfg << shift;
     +
     +	switch (ad7949_adc->bits_per_word) {
     +	case 16:
    ++		tx[0].tx_buf = &ad7949_adc->buffer;
     +		ad7949_adc->buffer = ad7949_adc->cfg << 2;
     +		break;
     +	case 14:
    ++		tx[0].tx_buf = &ad7949_adc->buffer;
     +		ad7949_adc->buffer = ad7949_adc->cfg;
     +		break;
     +	case 8:
     +		/* Here, type is big endian as it must be sent in two transfers */
    -+		ad7949_adc->buffer = (u16)cpu_to_be16(ad7949_adc->cfg << 2);
    ++		tx[0].tx_buf = &ad7949_adc->buf8b;
    ++		ad7949_adc->buf8b = cpu_to_be16(ad7949_adc->cfg << 2);
     +		break;
     +	default:
     +		dev_err(&ad7949_adc->indio_dev->dev, "unsupported BPW\n");
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
      	struct spi_message msg;
      	struct spi_transfer tx[] = {
      		{
    - 			.rx_buf = &ad7949_adc->buffer,
    +-			.rx_buf = &ad7949_adc->buffer,
      			.len = 2,
     -			.bits_per_word = bits_per_word,
     +			.bits_per_word = ad7949_adc->bits_per_word,
      		},
      	};
      
    ++	if (ad7949_adc->bits_per_word == 8)
    ++		tx[0].rx_buf = &ad7949_adc->buf8b;
    ++	else
    ++		tx[0].rx_buf = &ad7949_adc->buffer;
    ++
    + 	/*
    + 	 * 1: write CFG for sample N and read old data (sample N-2)
    + 	 * 2: if CFG was not changed since sample N-1 then we'll get good data
    +@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
    + 	}
    + 
    + 	/* 3: write something and read actual data */
    +-	ad7949_adc->buffer = 0;
    + 	spi_message_init_with_transfers(&msg, tx, 1);
    + 	ret = spi_sync(ad7949_adc->spi, &msg);
    + 	if (ret)
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
      
      	ad7949_adc->current_channel = channel;
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
     +		break;
     +	case 8:
     +		/* Here, type is big endian as data was sent in two transfers */
    -+		*val = be16_to_cpu(ad7949_adc->buffer);
    ++		*val = be16_to_cpu(ad7949_adc->buf8b);
     +		/* Shift-out padding bits */
     +		*val >>= 16 - ad7949_adc->resolution;
     +		break;
3:  41c4ab9c5e19 ! 3:  8a33618a4f90 iio: adc: ad7949: add support for internal vref
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
     +	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[channel];
      	struct spi_transfer tx[] = {
      		{
    - 			.rx_buf = &ad7949_adc->buffer,
    + 			.len = 2,
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
      	 */
      	for (i = 0; i < 2; i++) {
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
      
     -	ad7949_adc->vref = devm_regulator_get(dev, "vref");
     +	/* Setup external voltage ref, buffered? */
    -+	ad7949_adc->vref = devm_regulator_get(dev, "vrefin");
    ++	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
      	if (IS_ERR(ad7949_adc->vref)) {
     -		dev_err(dev, "fail to request regulator\n");
     -		return PTR_ERR(ad7949_adc->vref);
    ++		ret = PTR_ERR(ad7949_adc->vref);
    ++		if (ret != -ENODEV)
    ++			return ret;
     +		/* unbuffered? */
    -+		ad7949_adc->vref = devm_regulator_get(dev, "vref");
    ++		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
     +		if (IS_ERR(ad7949_adc->vref)) {
    ++			ret = PTR_ERR(ad7949_adc->vref);
    ++			if (ret != -ENODEV)
    ++				return ret;
     +			/* Internal then */
     +			mode = AD7949_CFG_VAL_REF_INT_4096;
    ++		} else {
    ++			mode = AD7949_CFG_VAL_REF_EXT_TEMP;
     +		}
    -+		mode = AD7949_CFG_VAL_REF_EXT_TEMP;
    ++	} else {
    ++		mode = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
      	}
    -+	mode = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
      
     -	ret = regulator_enable(ad7949_adc->vref);
     -	if (ret < 0) {
4:  9cb48acbd05b ! 4:  7612ff29db6b dt-bindings: iio: adc: ad7949: add per channel reference
    @@ Commit message
         calculation.
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
    +    Reviewed-by: Rob Herring <robh@kernel.org>
     
      ## Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml ##
     @@ Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml: properties:
5:  c48eb017058c = 5:  74ee82caba57 iio: adc: ad7949: use devm managed functions

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.32.0.452.g940fe202adcb

