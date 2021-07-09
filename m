Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079403C263F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 16:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhGIOv7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhGIOv7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 10:51:59 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E5C0613DD;
        Fri,  9 Jul 2021 07:49:14 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j14so4626742qvu.6;
        Fri, 09 Jul 2021 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=S5FnNN/ilVQc8VhlQdbYMm8szHMxHYg08Uof2Apu8X0=;
        b=nV/UEXDxaHzCi2A8P9gqYbbuD1ZfphVOfR0HBzimNZf+RgYC8z3zac+7d1ZOmPeLJq
         KetdSQ7Q+Lorre4mGg/a/4K7jDO4z408tc5SxzpgHh0uyij0VBDzUbcMDMyHTfOlojeY
         LePmlqEd5sKoPc3Pzp9v1VzbDQincSz8q0Ny4IsCGDVtAdeeEvn59Qx6+O2rdaWbKgSz
         exUvJXiXd2QPo7SlXgdNPzJWNrsvK5yBXL0GkLCvbdcW/qNZJcUrK5yxEa3WH3qFTLOm
         iFB9ja23Jqybk3xhE6N+RmrYsm28UDOF9wmWbM0RyrkdUzFxI4ynDlp88JrX+qMVuZk4
         jNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=S5FnNN/ilVQc8VhlQdbYMm8szHMxHYg08Uof2Apu8X0=;
        b=FzxZzcYgi+WWE4NVUGa8+AdS5XNo8s+bp0tKyyMTMOwilO+qKAUzzIFAFfItLkxIk3
         4mlXSX7IEUOxyYshAxNZNb3tApS1+2nM4upbIqnaEar+3LRx4cVl/yx+zTtR3jLV3E/y
         zipxuezD5dzPS3qfuqOaGNr2Ra+NvtD+HAI2oy7ka9BpPCKxecrZpPU5vXzBzM6v/f0N
         bOJ7DGLXdlKuHwJDlLjBhXgpDGQpmxNAFrIaPd0BY4c6x4VpDpa31jiJB56bYVNLznBE
         yuiV5qb9+gGwaDbcUN3NzHYzazeIx3ayktfSGeFUC1I4V9OoGNWawmaZM1czVBtv8rO6
         Q8Ew==
X-Gm-Message-State: AOAM531QK6hf1lfKo7FFeb+UYRyfJpdlhXZuIUCEj80s3WUQIf/iVGU6
        sj/6Y3F/PXU2il34UkbVbt4=
X-Google-Smtp-Source: ABdhPJwp8A8F/KqcCE3EpZc6hQ5UuF4QCOeJfrKSZpSKK2WcOFlQ7g7uz1JaV7LI5drRMtBNiJ+ARw==
X-Received: by 2002:a05:6214:2a4a:: with SMTP id jf10mr36869107qvb.13.1625842153816;
        Fri, 09 Jul 2021 07:49:13 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id w2sm2550197qkm.65.2021.07.09.07.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 07:49:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jul 2021 10:49:12 -0400
Message-Id: <CCOOXXRLLCT3.1HI9ZOJ2UT9W1@shaak>
Subject: RE: [PATCH v1 3/4] iio: adc: ad7949: add support for internal vref
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
 <20210708235618.1541335-4-liambeguin@gmail.com>
 <PH0PR03MB636680DD9F9530464FEBB7C399189@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB636680DD9F9530464FEBB7C399189@PH0PR03MB6366.namprd03.prod.outlook.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri Jul 9, 2021 at 4:23 AM EDT, Sa, Nuno wrote:
> > From: Liam Beguin <liambeguin@gmail.com>
> > Sent: Friday, July 9, 2021 1:56 AM
> > To: liambeguin@gmail.com; lars@metafoo.de; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; jic23@kernel.org; charles-
> > antoine.couret@essensium.com
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; robh+dt@kernel.org
> > Subject: [PATCH v1 3/4] iio: adc: ad7949: add support for internal vref
> >=20
> > [External]
> >=20
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Add support for selecting a custom reference voltage from the
> > devicetree. If an external source is used, a vref regulator should be
> > defined in the devicetree.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/adc/ad7949.c | 84
> > +++++++++++++++++++++++++++++++++-------
> >  1 file changed, 69 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index bbc6b56330a3..3c1293922d2e 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -31,6 +31,7 @@
> >  #define AD7949_CFG_VAL_BW_FULL			1
> >  #define AD7949_CFG_VAL_BW_QUARTER		0
> >  #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> > +#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
> >  #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> >  #define AD7949_CFG_BIT_RBN		BIT(0)
> >=20
> > @@ -40,6 +41,33 @@ enum {
> >  	ID_AD7689,
> >  };
> >=20
> > +/**
> > + * enum ad7949_ref - Reference selection
> > + *
> > + * AD7949_REF_INT_2500:     Internal reference and temperature
> > sensor enabled.
> > + *                          Vref=3D2.5V, buffered output
> > + * AD7949_REF_INT_4096:     Internal reference and temperature
> > sensor enabled.
> > + *                          Vref=3D4.096V, buffered output
> > + * AD7949_REF_EXT_TEMP:     Use external reference, temperature
> > sensor enabled.
> > + *                          Internal buffer disabled
> > + * AD7949_REF_EXT_TEMP_BUF: Use external reference, internal
> > buffer and
> > + *                          temperature sensor enabled.
> > + * AD7949_REF_RSRV_4:       Do not use
> > + * AD7949_REF_RSRV_5:       Do not use
> > + * AD7949_REF_EXT:          Use external reference, internal buffer an=
d
> > + *                          temperature sensor disabled.
> > + * AD7949_REF_EXT_BUF:      Use external reference, internal buffer
> > enabled.
> > + *                          Internal reference and temperature sensor =
disabled.
> > + */
> > +enum ad7949_ref {
> > +	AD7949_REF_INT_2500 =3D 0,
> > +	AD7949_REF_INT_4096,
> > +	AD7949_REF_EXT_TEMP,
> > +	AD7949_REF_EXT_TEMP_BUF,
> > +	AD7949_REF_EXT =3D 6,
> > +	AD7949_REF_EXT_BUF,
> > +};
> > +
> >  struct ad7949_adc_spec {
> >  	u8 num_channels;
> >  	u8 resolution;
> > @@ -55,6 +83,7 @@ static const struct ad7949_adc_spec
> > ad7949_adc_spec[] =3D {
> >   * struct ad7949_adc_chip - AD ADC chip
> >   * @lock: protects write sequences
> >   * @vref: regulator generating Vref
> > + * @refsel: reference selection
> >   * @indio_dev: reference to iio structure
> >   * @spi: reference to spi structure
> >   * @resolution: resolution of the chip
> > @@ -66,6 +95,7 @@ static const struct ad7949_adc_spec
> > ad7949_adc_spec[] =3D {
> >  struct ad7949_adc_chip {
> >  	struct mutex lock;
> >  	struct regulator *vref;
> > +	enum ad7949_ref refsel;
> >  	struct iio_dev *indio_dev;
> >  	struct spi_device *spi;
> >  	u8 resolution;
> > @@ -241,12 +271,28 @@ static int ad7949_spi_read_raw(struct iio_dev
> > *indio_dev,
> >  		return IIO_VAL_INT;
> >=20
> >  	case IIO_CHAN_INFO_SCALE:
> > -		ret =3D regulator_get_voltage(ad7949_adc->vref);
> > -		if (ret < 0)
> > -			return ret;
> > +		switch (ad7949_adc->refsel) {
> > +		case AD7949_REF_INT_2500:
> > +			*val =3D 2500;
> > +			break;
> > +		case AD7949_REF_INT_4096:
> > +			*val =3D 4096;
> > +			break;
> > +		case AD7949_REF_EXT_TEMP:
> > +		case AD7949_REF_EXT_TEMP_BUF:
> > +		case AD7949_REF_EXT:
> > +		case AD7949_REF_EXT_BUF:
> > +			ret =3D regulator_get_voltage(ad7949_adc-
> > >vref);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			/* convert value back to mV */
> > +			*val =3D ret / 1000;
> > +			break;
> > +		}
> >=20
> > -		*val =3D ret / 5000;
> > -		return IIO_VAL_INT;
> > +		*val2 =3D (1 << ad7949_adc->resolution) - 1;
> > +		return IIO_VAL_FRACTIONAL;
> >  	}
> >=20
> >  	return -EINVAL;
> > @@ -285,7 +331,7 @@ static int ad7949_spi_init(struct
> > ad7949_adc_chip *ad7949_adc)
> >  		FIELD_PREP(AD7949_CFG_BIT_INCC,
> > AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
> >  		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc-
> > >current_channel) |
> >  		FIELD_PREP(AD7949_CFG_BIT_BW,
> > AD7949_CFG_VAL_BW_FULL) |
> > -		FIELD_PREP(AD7949_CFG_BIT_REF,
> > AD7949_REF_EXT_BUF) |
> > +		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc-
> > >refsel) |
> >  		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
> >  		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
> >=20
> > @@ -304,6 +350,7 @@ static int ad7949_spi_init(struct
> > ad7949_adc_chip *ad7949_adc)
> >  static int ad7949_spi_probe(struct spi_device *spi)
> >  {
> >  	struct device *dev =3D &spi->dev;
> > +	struct device_node *np =3D dev->of_node;
> >  	const struct ad7949_adc_spec *spec;
> >  	struct ad7949_adc_chip *ad7949_adc;
> >  	struct iio_dev *indio_dev;
> > @@ -315,6 +362,7 @@ static int ad7949_spi_probe(struct spi_device
> > *spi)
> >  		return -ENOMEM;
> >  	}
> >=20
> > +	indio_dev->dev.of_node =3D np;
>
> Why doing this? The IIO core will do it for us at register time.

Sorry about that, will drop.

>
> >  	indio_dev->info =3D &ad7949_spi_info;
> >  	indio_dev->name =3D spi_get_device_id(spi)->name;
> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > @@ -330,16 +378,22 @@ static int ad7949_spi_probe(struct spi_device
> > *spi)
> >  	ad7949_adc->resolution =3D spec->resolution;
> >  	ad7949_set_bits_per_word(ad7949_adc);
> >=20
> > -	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> > -	if (IS_ERR(ad7949_adc->vref)) {
> > -		dev_err(dev, "fail to request regulator\n");
> > -		return PTR_ERR(ad7949_adc->vref);
> > -	}
> > +	/* Set default devicetree parameters */
> > +	ad7949_adc->refsel =3D AD7949_REF_EXT_BUF;
> > +	of_property_read_u32(np, "adi,reference-select",
> > &ad7949_adc->refsel);
>
> In case the property is given, we should make sure we get a valid
> value and error out if not...
>

I thought it would be handled later on when processing the sample, but
it's not really and it's better to fail early. I'll add that to v2.

Thanks,
Liam

> - Nuno S=C3=A1
> > -	ret =3D regulator_enable(ad7949_adc->vref);
> > -	if (ret < 0) {
> > -		dev_err(dev, "fail to enable regulator\n");
> > -		return ret;
> > +	if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
> > +		ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> > +		if (IS_ERR(ad7949_adc->vref)) {
> > +			dev_err(dev, "fail to request regulator\n");
> > +			return PTR_ERR(ad7949_adc->vref);
> > +		}
> > +
> > +		ret =3D regulator_enable(ad7949_adc->vref);
> > +		if (ret < 0) {
> > +			dev_err(dev, "fail to enable regulator\n");
> > +			return ret;
> > +		}
> >  	}
> >=20
> >  	mutex_init(&ad7949_adc->lock);
> > --
> > 2.30.1.489.g328c10930387

