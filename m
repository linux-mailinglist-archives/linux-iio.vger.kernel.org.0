Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18BA3C271C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhGIQBx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 12:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhGIQBx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 12:01:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE1C0613DD;
        Fri,  9 Jul 2021 08:59:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a6so9777883qka.4;
        Fri, 09 Jul 2021 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK+I5RHS1YygozWxqvUSHNwquD7VoFu/LPzuY2ZG3Ic=;
        b=p9psLWGc2dCEc1CKGSZRT9uQF6DBiehnWK/QQlPmgaWmRgBtDdsVfFuwwG0/10up4z
         NYvWIwIkBia/bIho4rp1/+JXf3lW3MSl6GiCbh98oY+7luxhfeUKr+M7Ghyz2WAaU7uw
         Y233YXKRXvmuMUe3aNK0rlcsb7V/awZUG6BC9JZFuvo1/HYI6RN8/tyOMjWjWltAsjkD
         TBCAjwG2qHV5ygZyiBtzfCCFDnyPnLvWhYDYrlyvE3iQrhBWS2sFPKdEmTMosfb5dMBd
         INiNI1rr7ghyyLSXfazjDUy1AmyxUiZA+Blxu+TddvY0PPIK/m1g5QzvLOZb5t+iOJTv
         FrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tK+I5RHS1YygozWxqvUSHNwquD7VoFu/LPzuY2ZG3Ic=;
        b=SPr6lgIfoSUZxwyhWdoFZAqajYhgdIQOtNYGjatmt73YmwSetKvrouT/w9NGPpfD9F
         II11RFZ2wX3vqXXbBAo5DePqg+7c0pE3Cwkh3Nocub51+ObuPY/SJGAsC6lLz5vaCx1d
         V42VIV0Soc8xlcXA1FK45cjg7zrWJxhsf9o0BvUGEzqgl1F7C05/ft3rn0JBzfGtMnjE
         F34iBnFZVUg/LJaO/rQzP5DpT17Ig8wUtoTHWcoIEepEQVfRt0pncBGkAgNMAEPn9CAV
         /FQE/UkyNBNB7Rrs1x7uN3SUUdj+k3+Fk42ERrhKDovs3DtvR7NwJIRD4IKLqSVCj0YY
         LGiQ==
X-Gm-Message-State: AOAM530U/6hum4og+5khy5ZqJ3fyTDhDg3Co1Ay17UakLfoABlvALs31
        9lmUswETeacv/E6eMCkDhMU=
X-Google-Smtp-Source: ABdhPJzgP3rpJQifQUhdn0Vh3DFETPfm83LWomPhLSVlb9nNpdhh32/Oy8mFTF7Sj8xorQyIK/6QEA==
X-Received: by 2002:a37:2ec1:: with SMTP id u184mr38086189qkh.500.1625846347505;
        Fri, 09 Jul 2021 08:59:07 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x15sm2606071qkm.66.2021.07.09.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:59:07 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 0/4] AD7949 Fixes
Date:   Fri,  9 Jul 2021 11:58:52 -0400
Message-Id: <20210709155856.1732245-1-liambeguin@gmail.com>
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

This is base on a series[2] that seems to not have made it all the way,
and was tested on an ad7689.

[1] https://patchwork.kernel.org/project/linux-iio/list/?series=511545
[2] https://patchwork.kernel.org/project/linux-iio/list/?series=116971&state=%2A&archive=both

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
  dt-bindings: iio: adc: ad7949: add adi,reference-source

 .../bindings/iio/adc/adi,ad7949.yaml          |  21 ++
 drivers/iio/adc/ad7949.c                      | 201 +++++++++++++++---
 2 files changed, 192 insertions(+), 30 deletions(-)

Range-diff against v1:
-:  ------------ > 1:  b8577e93229f iio: adc: ad7949: define and use bitfield names
1:  86bab3bedcf8 ! 2:  a8468391e3d0 iio: adc: ad7949: fix spi messages on non 14-bit controllers
    @@ drivers/iio/adc/ad7949.c: struct ad7949_adc_chip {
     +		ad7949_adc->buffer = ad7949_adc->cfg;
     +		break;
     +	case 8:
    ++	default:
     +		/* Pack 14-bit value into 2 bytes, MSB first */
     +		ad7949_adc->buf8[0] = FIELD_GET(GENMASK(13, 6), ad7949_adc->cfg);
     +		ad7949_adc->buf8[1] = FIELD_GET(GENMASK(5, 0), ad7949_adc->cfg);
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_read_channel(struct ad7949_adc_c
     +		*val = ad7949_adc->buffer & GENMASK(13, 0);
     +		break;
     +	case 8:
    ++	default:
     +		/* Convert byte array to u16, MSB first */
     +		*val = (ad7949_adc->buf8[0] << 8) | ad7949_adc->buf8[1];
     +		/* Shift-out padding bits */
2:  5f4dbdd51e1f ! 3:  4b0c11c9a748 iio: adc: ad7949: add support for internal vref
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_init(struct ad7949_adc_chip *ad7
      	const struct ad7949_adc_spec *spec;
      	struct ad7949_adc_chip *ad7949_adc;
      	struct iio_dev *indio_dev;
    -@@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
    - 		return -ENOMEM;
    - 	}
    - 
    -+	indio_dev->dev.of_node = np;
    - 	indio_dev->info = &ad7949_spi_info;
    - 	indio_dev->name = spi_get_device_id(spi)->name;
    - 	indio_dev->modes = INDIO_DIRECT_MODE;
     @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
      	ad7949_adc->resolution = spec->resolution;
      	ad7949_set_bits_per_word(ad7949_adc);
    @@ drivers/iio/adc/ad7949.c: static int ad7949_spi_probe(struct spi_device *spi)
     -	if (IS_ERR(ad7949_adc->vref)) {
     -		dev_err(dev, "fail to request regulator\n");
     -		return PTR_ERR(ad7949_adc->vref);
    --	}
     +	/* Set default devicetree parameters */
     +	ad7949_adc->refsel = AD7949_REF_EXT_BUF;
     +	of_property_read_u32(np, "adi,reference-select", &ad7949_adc->refsel);
    ++	switch (ad7949_adc->refsel) {
    ++	case AD7949_REF_INT_2500:
    ++	case AD7949_REF_INT_4096:
    ++	case AD7949_REF_EXT_TEMP:
    ++	case AD7949_REF_EXT_TEMP_BUF:
    ++	case AD7949_REF_EXT:
    ++	case AD7949_REF_EXT_BUF:
    ++		break;
    ++	default:
    ++		dev_err(dev, "invalid adi,reference-select value (%d)\n",
    ++			ad7949_adc->refsel);
    ++		return -EINVAL;
    + 	}
      
     -	ret = regulator_enable(ad7949_adc->vref);
     -	if (ret < 0) {
3:  99367ba6e5f9 ! 4:  a3b6a6ef15fd dt-bindings: iio: adc: ad7949: add adi,reference-source
    @@ Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml: properties:
          const: 1
      
     +  adi,reference-select:
    -+    allOf:
    -+      - $ref: /schemas/types.yaml#/definitions/uint32
    -+      - enum: [0, 1, 2, 3, 6, 7]
    -+
    -+    default: 7
     +    description: |
     +      Select the reference voltage source to use when converting samples.
     +      Acceptable values are:
    @@ Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml: properties:
     +           disabled.
     +      - 7: Use external reference, internal buffer enabled.
     +           Internal reference and temperature sensor disabled.
    ++
    ++    $ref: /schemas/types.yaml#/definitions/uint32
    ++    enum: [0, 1, 2, 3, 6, 7]
    ++    default: 7
     +
      required:
        - compatible

base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
-- 
2.30.1.489.g328c10930387

