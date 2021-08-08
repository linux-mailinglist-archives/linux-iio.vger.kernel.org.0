Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344403E3D0C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhHHWnb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 18:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhHHWna (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Aug 2021 18:43:30 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE4C061760;
        Sun,  8 Aug 2021 15:43:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t3so15135356qkg.11;
        Sun, 08 Aug 2021 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=vTFyKBZtE4p6QZp0zf2/O8GhhOFM8wvzzgm8TxWWZ4o=;
        b=XvVE57LTu96PyAIv4Okh02uuqxHGLVhDegkDON9rMxnTeYqo5m5lFn7Ce+fn2osyPs
         zwymISmnwXUozgfC8twzeowMlx39m/nNikzxrenj6A0XHA8Umm9nSLTN6RZE9fiJBKpH
         U4lswXBu/tzmFdNZ02YQXmtXXEg+GgFsp4z8r4N1ypRo/iC9cu0IFL3UzomsZ3hlA7fT
         hNHgl10VzQ8SC/KWHDa60Vy9JNYLo334yOsAEmOnNd+OiXAyLjrXOl/LmBDTi4dsB8S8
         Mord7yhIJhtDoj6nvLeTTN7/8V1f5GNRg2u8KsUKD1c+wUNYnQCw28WeKmbkEiK2MXwF
         eiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=vTFyKBZtE4p6QZp0zf2/O8GhhOFM8wvzzgm8TxWWZ4o=;
        b=fBbgUA+Pq5XhVeMvQkmk8Qj0HqC0aYRU7LyN8mlGvPdus0iqIEseP6Gl3QOdrEq5jB
         Nv9G3rk38EyG2DhUaB6yLYFHOzzb1jMLUNuzU2F3HP0LvEdENs9wofvqD+RmiUUdWcm1
         ozaimhCQpJfTIujdszoFwYQCyjRTcQGgAx8TbdDQtBjQCLF8fPhenlGZyckR5c7O0qm2
         KtCYAPAj68BnuAQjY7Wl52R5k705R5P8068Iab11cJnXv63W9F0c0ja4yO2aCl8NOEF3
         uHVPmjTHGh7sahWa5D0DFeCLv36/SyDFE7aSUUiuwydaYPQl6CtzHSwZdY4hVat+8Xsm
         W3Zw==
X-Gm-Message-State: AOAM5302J7HY4rjye2MJ30QdVaI9aQw6ZT3IPWNzS+Akk7x83I/8+WkN
        hnlG2FO8uJObXMa18so6aYw=
X-Google-Smtp-Source: ABdhPJxytbatI3EriAAVU/ovFJvCAroYdHf9I6PUg3fQZnjStXX9aumf3PkjR3zDJJNIK+K1+z/sLg==
X-Received: by 2002:a05:620a:12c3:: with SMTP id e3mr3704275qkl.122.1628462589749;
        Sun, 08 Aug 2021 15:43:09 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f15sm965848qte.5.2021.08.08.15.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 15:43:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 08 Aug 2021 18:43:08 -0400
Message-Id: <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-4-liambeguin@gmail.com>
 <20210808173630.5c384a4b@jic23-huawei>
In-Reply-To: <20210808173630.5c384a4b@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun Aug 8, 2021 at 12:36 PM EDT, Jonathan Cameron wrote:
> On Sat, 7 Aug 2021 21:56:57 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Add support for selecting a custom reference voltage from the
> > devicetree. If an external source is used, a vref regulator should be
> > defined in the devicetree.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
>
> Hi Liam, I'm not sure the parsing of the child nodes will work if using
> an external reference. See below.
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/ad7949.c | 140 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 122 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 3f94ae639a44..14a7c79d637e 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -35,7 +35,11 @@
> > =20
> >  /* REF: reference/buffer selection */
> >  #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> > -#define AD7949_CFG_VAL_REF_EXT_BUF		7
> > +#define AD7949_CFG_VAL_REF_EXT_TEMP_BUF		3
> > +#define AD7949_CFG_VAL_REF_EXT_TEMP		2
> > +#define AD7949_CFG_VAL_REF_INT_4096		1
> > +#define AD7949_CFG_VAL_REF_INT_2500		0
> > +#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
> > =20
> >  /* SEQ: channel sequencer. Allows for scanning channels */
> >  #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> > @@ -60,6 +64,14 @@ static const struct ad7949_adc_spec ad7949_adc_spec[=
] =3D {
> >  	[ID_AD7689] =3D { .num_channels =3D 8, .resolution =3D 16 },
> >  };
> > =20
> > +/**
> > + * struct ad7949_channel - ADC Channel parameters
> > + * @refsel: reference selection
> > + */
> > +struct ad7949_channel {
> > +	u32 refsel;
> > +};
> > +
> >  /**
> >   * struct ad7949_adc_chip - AD ADC chip
> >   * @lock: protects write sequences
> > @@ -78,6 +90,7 @@ struct ad7949_adc_chip {
> >  	struct regulator *vref;
> >  	struct iio_dev *indio_dev;
> >  	struct spi_device *spi;
> > +	struct ad7949_channel *channels;
> >  	u8 resolution;
> >  	u8 bits_per_word;
> >  	u16 cfg;
> > @@ -136,6 +149,7 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
> >  	int ret;
> >  	int i;
> >  	struct spi_message msg;
> > +	struct ad7949_channel *ad7949_chan =3D &ad7949_adc->channels[channel]=
;
> >  	struct spi_transfer tx[] =3D {
> >  		{
> >  			.len =3D 2,
> > @@ -156,8 +170,9 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
> >  	 */
> >  	for (i =3D 0; i < 2; i++) {
> >  		ret =3D ad7949_spi_write_cfg(ad7949_adc,
> > -					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
> > -					   AD7949_CFG_BIT_INX);
> > +					   FIELD_PREP(AD7949_CFG_BIT_INX, channel) |
> > +					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan->refsel),
> > +					   AD7949_CFG_BIT_INX | AD7949_CFG_BIT_REF);
> >  		if (ret)
> >  			return ret;
> >  		if (channel =3D=3D ad7949_adc->current_channel)
> > @@ -225,6 +240,7 @@ static int ad7949_spi_read_raw(struct iio_dev *indi=
o_dev,
> >  			   int *val, int *val2, long mask)
> >  {
> >  	struct ad7949_adc_chip *ad7949_adc =3D iio_priv(indio_dev);
> > +	struct ad7949_channel *ad7949_chan =3D &ad7949_adc->channels[chan->ch=
annel];
> >  	int ret;
> > =20
> >  	if (!val)
> > @@ -242,12 +258,26 @@ static int ad7949_spi_read_raw(struct iio_dev *in=
dio_dev,
> >  		return IIO_VAL_INT;
> > =20
> >  	case IIO_CHAN_INFO_SCALE:
> > -		ret =3D regulator_get_voltage(ad7949_adc->vref);
> > -		if (ret < 0)
> > -			return ret;
> > +		switch (ad7949_chan->refsel) {
> > +		case AD7949_CFG_VAL_REF_INT_2500:
> > +			*val =3D 2500;
> > +			break;
> > +		case AD7949_CFG_VAL_REF_INT_4096:
> > +			*val =3D 4096;
> > +			break;
> > +		case AD7949_CFG_VAL_REF_EXT_TEMP:
> > +		case AD7949_CFG_VAL_REF_EXT_TEMP_BUF:
> > +			ret =3D regulator_get_voltage(ad7949_adc->vref);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			/* convert value back to mV */
> > +			*val =3D ret / 1000;
> > +			break;
> > +		}
> > =20
> > -		*val =3D ret / 5000;
> > -		return IIO_VAL_INT;
> > +		*val2 =3D (1 << ad7949_adc->resolution) - 1;
> > +		return IIO_VAL_FRACTIONAL;
> >  	}
> > =20
> >  	return -EINVAL;
> > @@ -286,7 +316,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *=
ad7949_adc)
> >  		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
> >  		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
> >  		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
> > -		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
> > +		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->channels[0].refsel) |
> >  		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
> >  		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
> > =20
> > @@ -302,14 +332,24 @@ static int ad7949_spi_init(struct ad7949_adc_chip=
 *ad7949_adc)
> >  	return ret;
> >  }
> > =20
> > +static void ad7949_disable_reg(void *reg)
> > +{
> > +	regulator_disable(reg);
> > +}
> > +
> >  static int ad7949_spi_probe(struct spi_device *spi)
> >  {
> >  	u32 spi_ctrl_mask =3D spi->controller->bits_per_word_mask;
> >  	struct device *dev =3D &spi->dev;
> >  	const struct ad7949_adc_spec *spec;
> >  	struct ad7949_adc_chip *ad7949_adc;
> > +	struct ad7949_channel *ad7949_chan;
> > +	struct fwnode_handle *child;
> >  	struct iio_dev *indio_dev;
> > +	int mode;
> > +	u32 tmp;
> >  	int ret;
> > +	int i;
> > =20
> >  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
> >  	if (!indio_dev) {
> > @@ -343,16 +383,82 @@ static int ad7949_spi_probe(struct spi_device *sp=
i)
> >  		return -EINVAL;
> >  	}
> > =20
> > -	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> > +	/* Setup external voltage ref, buffered? */
> > +	ad7949_adc->vref =3D devm_regulator_get_optional(dev, "vrefin");
> >  	if (IS_ERR(ad7949_adc->vref)) {
> > -		dev_err(dev, "fail to request regulator\n");
> > -		return PTR_ERR(ad7949_adc->vref);
> > +		ret =3D PTR_ERR(ad7949_adc->vref);
> > +		if (ret !=3D -ENODEV)
> > +			return ret;
> > +		/* unbuffered? */
> > +		ad7949_adc->vref =3D devm_regulator_get_optional(dev, "vref");
> > +		if (IS_ERR(ad7949_adc->vref)) {
> > +			ret =3D PTR_ERR(ad7949_adc->vref);
> > +			if (ret !=3D -ENODEV)
> > +				return ret;
> > +			/* Internal then */
> > +			mode =3D AD7949_CFG_VAL_REF_INT_4096;
> > +		} else {
> > +			mode =3D AD7949_CFG_VAL_REF_EXT_TEMP;
> > +		}
> > +	} else {
> > +		mode =3D AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
> >  	}
> > =20
> > -	ret =3D regulator_enable(ad7949_adc->vref);
> > -	if (ret < 0) {
> > -		dev_err(dev, "fail to enable regulator\n");
> > -		return ret;
> > +	if (mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> > +		ret =3D regulator_enable(ad7949_adc->vref);
> > +		if (ret < 0) {
> > +			dev_err(dev, "fail to enable regulator\n");
> > +			return ret;
> > +		}
> > +
> > +		ret =3D devm_add_action_or_reset(dev, ad7949_disable_reg,
> > +					       ad7949_adc->vref);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ad7949_adc->channels =3D devm_kcalloc(dev, spec->num_channels,
> > +					    sizeof(*ad7949_adc->channels),
> > +					    GFP_KERNEL);
> > +	if (!ad7949_adc->channels) {
> > +		dev_err(dev, "unable to allocate ADC channels\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Initialize all channel structures */
> > +	for (i =3D 0; i < spec->num_channels; i++)
> > +		ad7949_adc->channels[i].refsel =3D mode;
> > +
> > +	/* Read channel specific information form the devicetree */
> > +	device_for_each_child_node(dev, child) {
> > +		ret =3D fwnode_property_read_u32(child, "reg", &i);
> > +		if (ret) {
> > +			dev_err(dev, "missing reg property in %pfw\n", child);
> > +			fwnode_handle_put(child);
> > +			return ret;
> > +		}
> > +
> > +		ad7949_chan =3D &ad7949_adc->channels[i];
> > +
> > +		ret =3D fwnode_property_read_u32(child, "adi,internal-ref-microvolt"=
, &tmp);
> > +		if (ret < 0 && ret !=3D -EINVAL) {
> > +			dev_err(dev, "invalid internal reference in %pfw\n", child);
> > +			fwnode_handle_put(child);
> > +			return ret;
> > +		}

Hi Jonathan,

>
> So if we are using external voltage, then we'd not expect this to exist.
> ret !=3D -EINVAL should deal with that. However, we then hit the followin=
g
> switch
> and temp isn't set to an appropriate value so we get the error.
>
> Am I missing something?

You're right that using an external reference, will cause this to fail.
My apologies, I've done a poor job of testing the last two revisions of
this patch. I'll do better.

Since a regulator is also required when we're using an external source,
I'll add a check for that. Something like this:

	ret =3D fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp=
);
	if (ret =3D=3D -EINVAL && mode & AD7949_CFG_VAL_REF_EXTERNAL) {
		continue;
	} else if (ret < 0) {
		dev_err(dev, "invalid voltage reference in %pfw\n", child);
		fwnode_handle_put(child);
		return ret;
	}

Given that we can now have a different scale for each channel based on
the vref source, should BIT(IIO_CHAN_INFO_SCALE) be moved to
.info_mask_separate in the channel definition?

Thanks,
Liam

>
> > +
> > +		switch (tmp) {
> > +		case 2500000:
> > +			ad7949_chan->refsel =3D AD7949_CFG_VAL_REF_INT_2500;
> > +			break;
> > +		case 4096000:
> > +			ad7949_chan->refsel =3D AD7949_CFG_VAL_REF_INT_4096;
> > +			break;
> > +		default:
> > +			dev_err(dev, "unsupported internal voltage reference\n");
> > +			fwnode_handle_put(child);
> > +			return -EINVAL;
> > +		}
> >  	}
> > =20
> >  	mutex_init(&ad7949_adc->lock);
> > @@ -373,7 +479,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > =20
> >  err:
> >  	mutex_destroy(&ad7949_adc->lock);
> > -	regulator_disable(ad7949_adc->vref);
> > =20
> >  	return ret;
> >  }
> > @@ -385,7 +490,6 @@ static int ad7949_spi_remove(struct spi_device *spi=
)
> > =20
> >  	iio_device_unregister(indio_dev);
> >  	mutex_destroy(&ad7949_adc->lock);
> > -	regulator_disable(ad7949_adc->vref);
> > =20
> >  	return 0;
> >  }

