Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214FB3D8248
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 00:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhG0WIi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhG0WIi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 18:08:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20AAC061757;
        Tue, 27 Jul 2021 15:08:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id m11so10721347qtx.7;
        Tue, 27 Jul 2021 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=FqgjP4iqguml1kKIXMYcQWV3+kaL7LrhLrrTN9aEmBw=;
        b=UaYs72XfZKVHysvAtBJhj9b+Fxx+R3rD44dpu272YAHk+nV+89Rf4+QNXngr9sF4z+
         +NZmdXY3dKicE65kxPxrkbpDTGkEyaTtino7kFMQ9rTQ2CnmJ52l1LgV2u7CrayNqfQJ
         p2mw6Tct5pxeUy596rNdlC5K5Md+OOOx115LvAQsBcDYQvQ+Qin4PtkD2nKAR+TMOIOa
         zw5NGD9XmTzAGxT0a4djGpFn26nSCWi1gqLJkQxeDswnJEee02U+4pE0RjHoOYBK7zBG
         peQOs7VIb3b2sAD5GR5UA6BlW6sNAKtFv8fRu/xAqbmsu+mp6MBtMnPWoz7ECaVlWqRO
         XhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=FqgjP4iqguml1kKIXMYcQWV3+kaL7LrhLrrTN9aEmBw=;
        b=cyy9p2g26LTZgByjDdHMVQA93XFlHd8u0jxyk2/EgY7eKLcjUl+Yx6PuYESOvxs321
         iNqmQbUji0413bmCag7SIzA4z3XcM9CCdbcXRkLWRRDgRlojn9VKiJIyDged8ipSzEbl
         aYjVr0Ha4I7lzyLOm0xbJYOS669kXq6S6R+fn2BrHoTE/NgrYpylBFfx8zimgjmNfcm9
         4hVeW7XIAlSCglfoeBZcRbwocorbwLOTwa1vkaDkr9uPzU+VdA6WiYZW//2rupQDhx7h
         z06fsK/8KsohAgutmh6zpBMFgfKlVw3BdEWgDgvbsPsSKrvFBjIsOhQo0er3i/4Rd5De
         xP9Q==
X-Gm-Message-State: AOAM533CD/jHRUrJ3nsEKTT1m83LBbhjLxt9Ju+vzLFZc2e63YkwvD3O
        Ep9EpJAQQYmXE08UGWV3r5o=
X-Google-Smtp-Source: ABdhPJwTeg8gO9hKJa+r2fiQjkgotG/L8qOVlnXUql468bHBu6093/s8NQwQsAeL7Xa9P37tQkjN1Q==
X-Received: by 2002:a05:622a:1a96:: with SMTP id s22mr20616548qtc.44.1627423717091;
        Tue, 27 Jul 2021 15:08:37 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q4sm2017602qtr.20.2021.07.27.15.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 15:08:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Jul 2021 18:08:35 -0400
Message-Id: <CD49K5X8V6LG.2FX8S540TRQ2S@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 3/4] iio: adc: ad7949: add support for internal vref
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210713043425.3321230-1-liambeguin@gmail.com>
 <20210713043425.3321230-4-liambeguin@gmail.com>
 <20210717183437.4d183037@jic23-huawei>
In-Reply-To: <20210717183437.4d183037@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat Jul 17, 2021 at 1:34 PM EDT, Jonathan Cameron wrote:
> On Tue, 13 Jul 2021 00:34:24 -0400
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
> Hi Liam,
>
> A few minor things inline.
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/ad7949.c | 133 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 115 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> > index 65f78751225b..8b78da7ead36 100644
> > --- a/drivers/iio/adc/ad7949.c
> > +++ b/drivers/iio/adc/ad7949.c
> > @@ -36,7 +36,11 @@
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
> > @@ -61,6 +65,14 @@ static const struct ad7949_adc_spec ad7949_adc_spec[=
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
> > @@ -138,6 +151,7 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
> >  	int i;
> >  	u8 buf8[2];
> >  	struct spi_message msg;
> > +	struct ad7949_channel ad7949_chan =3D ad7949_adc->channels[channel];
>
> Better to use a pointer rather than copying the data.
>
> >  	struct spi_transfer tx[] =3D {
> >  		{
> >  			.rx_buf =3D &ad7949_adc->buffer,
> > @@ -154,8 +168,9 @@ static int ad7949_spi_read_channel(struct ad7949_ad=
c_chip *ad7949_adc, int *val,
> >  	 */
> >  	for (i =3D 0; i < 2; i++) {
> >  		ret =3D ad7949_spi_write_cfg(ad7949_adc,
> > -					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
> > -					   AD7949_CFG_BIT_INX);
> > +					   FIELD_PREP(AD7949_CFG_BIT_INX, channel) |
> > +					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan.refsel),
> > +					   AD7949_CFG_BIT_INX | AD7949_CFG_BIT_REF);
> >  		if (ret)
> >  			return ret;
> >  		if (channel =3D=3D ad7949_adc->current_channel)
> > @@ -225,6 +240,7 @@ static int ad7949_spi_read_raw(struct iio_dev *indi=
o_dev,
> >  			   int *val, int *val2, long mask)
> >  {
> >  	struct ad7949_adc_chip *ad7949_adc =3D iio_priv(indio_dev);
> > +	struct ad7949_channel ad7949_chan =3D ad7949_adc->channels[chan->chan=
nel];
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
> > +		switch (ad7949_chan.refsel) {
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
> > +	struct device_node *child;
> >  	struct iio_dev *indio_dev;
> > +	int mode;
> > +	u32 tmp;
> >  	int ret;
> > +	int i;
> > =20
> >  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
> >  	if (!indio_dev) {
> > @@ -343,16 +383,75 @@ static int ad7949_spi_probe(struct spi_device *sp=
i)
> >  		return -EINVAL;
> >  	}
> > =20
> > -	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> > +	/* Setup external voltage ref, buffered? */
> > +	ad7949_adc->vref =3D devm_regulator_get(dev, "vrefin");
> >  	if (IS_ERR(ad7949_adc->vref)) {
> > -		dev_err(dev, "fail to request regulator\n");
> > -		return PTR_ERR(ad7949_adc->vref);
> > +		/* unbuffered? */
> > +		ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> > +		if (IS_ERR(ad7949_adc->vref)) {
> > +			/* Internal then */
> > +			mode =3D AD7949_CFG_VAL_REF_INT_4096;
> > +		}
> > +		mode =3D AD7949_CFG_VAL_REF_EXT_TEMP;
> >  	}
> > +	mode =3D AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
> > =20
> > -	ret =3D regulator_enable(ad7949_adc->vref);
> > -	if (ret < 0) {
> > -		dev_err(dev, "fail to enable regulator\n");
> > -		return ret;
> > +	if (mode > AD7949_CFG_VAL_REF_INT_4096) {
>
> Range checks on enum values are always rather messy. So
> better to explicitly match the cases that matter.
>

Understood, I'll use AD7949_CFG_VAL_REF_EXTERNAL instead.

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
> > +	for (i =3D 0; i < spec->num_channels; i++) {
> > +		ad7949_adc->channels[i].refsel =3D mode;
>
> Kernel style is no brackets when only one item in a block.
>
> > +	}
> > +
> > +	/* Read channel specific information form the devicetree */
> > +	for_each_child_of_node(dev->of_node, child) {
> > +		ret =3D of_property_read_u32(child, "reg", &i);
> > +		if (ret) {
> > +			dev_err(dev, "missing reg property in child: %s\n",
> > +				child->full_name);
> > +			of_node_put(child);
> > +			return ret;
> > +		}
> > +
> > +		ad7949_chan =3D &ad7949_adc->channels[i];
> > +
> > +		ret =3D of_property_read_u32(child, "adi,internal-ref-mv", &tmp);
>
> Preference for generic device firmware properties not of_* specific
> ones.
>
> I think there is nothing stopping this driver being probed from ACPI via
> PRP0001
> before this change. Note you'll also need fwnode_for_each_child_node()
> above.
>

will do.

> > +		if (ret < 0 && ret !=3D -EINVAL) {
> > +			of_node_put(child);
> > +			return ret;
> > +		}
> > +
> > +		switch (tmp) {
> > +		case 2500:
> > +			ad7949_chan->refsel =3D AD7949_CFG_VAL_REF_INT_2500;
> > +			break;
> > +		case 4096:
> > +			ad7949_chan->refsel =3D AD7949_CFG_VAL_REF_INT_4096;
> > +			break;
> > +		default:
> > +			dev_err(dev, "unsupported internal voltage reference\n");
> > +			of_node_put(child);
> > +			return -EINVAL;
> > +		}
> >  	}
> > =20
> >  	mutex_init(&ad7949_adc->lock);
> > @@ -373,7 +472,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
> > =20
> >  err:
> >  	mutex_destroy(&ad7949_adc->lock);
> > -	regulator_disable(ad7949_adc->vref);
> > =20
> >  	return ret;
> >  }
> > @@ -385,7 +483,6 @@ static int ad7949_spi_remove(struct spi_device *spi=
)
> > =20
> >  	iio_device_unregister(indio_dev);
> >  	mutex_destroy(&ad7949_adc->lock);
> > -	regulator_disable(ad7949_adc->vref);
>
> Given mutex_destroy is mostly pointless (and definitely is here) that
> leaves us with just iio_device_register(). Hence if you could do
> a follow up patch finishing conversion of this to entirely devm managed
> that would be a nice addition to this series (or separate patch is fine
> as well).
>

Sure, I'll add that cleanup in the next revision.

Thanks,
Liam

> > =20
> >  	return 0;
> >  }

