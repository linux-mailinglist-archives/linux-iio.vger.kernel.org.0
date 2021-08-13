Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15AF3EBDA1
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhHMUvw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbhHMUvv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 16:51:51 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396BC061756;
        Fri, 13 Aug 2021 13:51:15 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kl2so5946148qvb.11;
        Fri, 13 Aug 2021 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=7g/KdHhl7CS6T5OBa6g8TkNzM1/tqu3FO11Xigc3mGw=;
        b=kueDmQZjgvfoUDRPTku0jTwPVXn5tZXBCeXFQyaBzLMAllFJPzOrY03q0cRVvQ+tu8
         zuh7lqOXF96GfKOwQ5gUe3xS7yHqW3T9x/a1eVb7RQ4sAKjAMvXir7B86Tpw1GNcGAWz
         lbpi88PN+v+YjC2LKpxECVZaGXVPttXjXA2o2tpu+KX3Wa8Xe7DiEAsCc3FP0TgLMYh/
         neBCV93SAUdwwlRo16EU25vS/VhZfzuDCtrAo3JEuCOkULcbLfSlh4LoZgmXjtCpRcGO
         WLq2n7QceEabkIse2wxIo8O+kVUjcS9MmFfNqhojDM0byB7bGCWNmcJbVHbJT/AHKTNH
         ewOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=7g/KdHhl7CS6T5OBa6g8TkNzM1/tqu3FO11Xigc3mGw=;
        b=H0MIU276H9hjlNXIusStlcMzm31/8ldH+wt9jCQzVS1fkkcXqzZXKh4yjJCCgJz0bT
         w6cVEbSAFngraxdS/CpQ/OyL03ne5FQIUWucW4IZCG60nVE3caRSHQeGihC/9Z3BlMCr
         kENL4kxHb5i5GfzVR0Eo+oRMQV4gHp3BdD+4ezkpdQGXx3f++CdmhsagK44qmSCQs8CL
         duUVgsfCzGm+J1N2rIJSbh1AmyoL7Bk1c/dLnlXV76ZwtTMY5xVa6uIuTKtIP6IbY6zG
         YE9A3scfH9wlAhE/tZ6/gptBC24lKUtkTVa9GdY6vf2PoCW3pZ1/Fv4xZorjlM2XodZb
         JWZQ==
X-Gm-Message-State: AOAM532Xao1GQw9OL7TTLcpY9b6OpjHFltkMfOBqvcB5yJpBeYuoJI6+
        wqhbVWzSL/hUPqLEIEqcFf8=
X-Google-Smtp-Source: ABdhPJwgWMH/JWR7vwDIAAdrPRtNgn0jqFLRKnViGpWktPNTXJOxSJWQjUe0gp/ZFaghMLmQNgremA==
X-Received: by 2002:ad4:4b0d:: with SMTP id r13mr4546832qvw.7.1628887875102;
        Fri, 13 Aug 2021 13:51:15 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id i67sm1635515qkd.90.2021.08.13.13.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 13:51:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 13 Aug 2021 16:51:12 -0400
Message-Id: <CDIOK6DFUNE0.2P8L2AL8MDAK1@shaak>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-4-liambeguin@gmail.com>
 <20210808173630.5c384a4b@jic23-huawei> <CDEHT583QT0A.2QAXX9AC2FMLO@shaak>
 <20210809204253.357f97b2@jic23-huawei>
In-Reply-To: <20210809204253.357f97b2@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Aug 9, 2021 at 3:42 PM EDT, Jonathan Cameron wrote:
> ...
> > +
> > > >  static int ad7949_spi_probe(struct spi_device *spi)
> > > >  {
> > > >  	u32 spi_ctrl_mask =3D spi->controller->bits_per_word_mask;
> > > >  	struct device *dev =3D &spi->dev;
> > > >  	const struct ad7949_adc_spec *spec;
> > > >  	struct ad7949_adc_chip *ad7949_adc;
> > > > +	struct ad7949_channel *ad7949_chan;
> > > > +	struct fwnode_handle *child;
> > > >  	struct iio_dev *indio_dev;
> > > > +	int mode;
> > > > +	u32 tmp;
> > > >  	int ret;
> > > > +	int i;
> > > > =20
> > > >  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
> > > >  	if (!indio_dev) {
> > > > @@ -343,16 +383,82 @@ static int ad7949_spi_probe(struct spi_device=
 *spi)
> > > >  		return -EINVAL;
> > > >  	}
> > > > =20
> > > > -	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> > > > +	/* Setup external voltage ref, buffered? */
> > > > +	ad7949_adc->vref =3D devm_regulator_get_optional(dev, "vrefin");
> > > >  	if (IS_ERR(ad7949_adc->vref)) {
> > > > -		dev_err(dev, "fail to request regulator\n");
> > > > -		return PTR_ERR(ad7949_adc->vref);
> > > > +		ret =3D PTR_ERR(ad7949_adc->vref);
> > > > +		if (ret !=3D -ENODEV)
> > > > +			return ret;
> > > > +		/* unbuffered? */
> > > > +		ad7949_adc->vref =3D devm_regulator_get_optional(dev, "vref");
> > > > +		if (IS_ERR(ad7949_adc->vref)) {
> > > > +			ret =3D PTR_ERR(ad7949_adc->vref);
> > > > +			if (ret !=3D -ENODEV)
> > > > +				return ret;
> > > > +			/* Internal then */
> > > > +			mode =3D AD7949_CFG_VAL_REF_INT_4096;
> > > > +		} else {
> > > > +			mode =3D AD7949_CFG_VAL_REF_EXT_TEMP;
> > > > +		}
> > > > +	} else {
> > > > +		mode =3D AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
> > > >  	}
> > > > =20
> > > > -	ret =3D regulator_enable(ad7949_adc->vref);
> > > > -	if (ret < 0) {
> > > > -		dev_err(dev, "fail to enable regulator\n");
> > > > -		return ret;
> > > > +	if (mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> > > > +		ret =3D regulator_enable(ad7949_adc->vref);
> > > > +		if (ret < 0) {
> > > > +			dev_err(dev, "fail to enable regulator\n");
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		ret =3D devm_add_action_or_reset(dev, ad7949_disable_reg,
> > > > +					       ad7949_adc->vref);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > > +	ad7949_adc->channels =3D devm_kcalloc(dev, spec->num_channels,
> > > > +					    sizeof(*ad7949_adc->channels),
> > > > +					    GFP_KERNEL);
> > > > +	if (!ad7949_adc->channels) {
> > > > +		dev_err(dev, "unable to allocate ADC channels\n");
> > > > +		return -ENOMEM;
> > > > +	}
> > > > +
> > > > +	/* Initialize all channel structures */
> > > > +	for (i =3D 0; i < spec->num_channels; i++)
> > > > +		ad7949_adc->channels[i].refsel =3D mode;
> > > > +
> > > > +	/* Read channel specific information form the devicetree */
> > > > +	device_for_each_child_node(dev, child) {
> > > > +		ret =3D fwnode_property_read_u32(child, "reg", &i);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "missing reg property in %pfw\n", child);
> > > > +			fwnode_handle_put(child);
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		ad7949_chan =3D &ad7949_adc->channels[i];
> > > > +
> > > > +		ret =3D fwnode_property_read_u32(child, "adi,internal-ref-microv=
olt", &tmp);
> > > > +		if (ret < 0 && ret !=3D -EINVAL) {
> > > > +			dev_err(dev, "invalid internal reference in %pfw\n", child);
> > > > +			fwnode_handle_put(child);
> > > > +			return ret;
> > > > +		} =20
> >=20
> > Hi Jonathan,
> >=20
> > >
> > > So if we are using external voltage, then we'd not expect this to exi=
st.
> > > ret !=3D -EINVAL should deal with that. However, we then hit the foll=
owing
> > > switch
> > > and temp isn't set to an appropriate value so we get the error.
> > >
> > > Am I missing something? =20
> >=20
> > You're right that using an external reference, will cause this to fail.
> > My apologies, I've done a poor job of testing the last two revisions of
> > this patch. I'll do better.
> >=20
> > Since a regulator is also required when we're using an external source,
> > I'll add a check for that. Something like this:
> >=20
> > 	ret =3D fwnode_property_read_u32(child, "adi,internal-ref-microvolt", =
&tmp);
> > 	if (ret =3D=3D -EINVAL && mode & AD7949_CFG_VAL_REF_EXTERNAL) {
> > 		continue;
> > 	} else if (ret < 0) {
> > 		dev_err(dev, "invalid voltage reference in %pfw\n", child);
> > 		fwnode_handle_put(child);
> > 		return ret;
> > 	}
>
> Makes sense.

Hi Jonathan,

After getting access to another setup to run more tests, I noticed
that setting the reference per channel isn't really feasible.

It take a little while for the reference to be updated internally even
though the request is sent out properly, and reading channels in a
sequence returns bad values.

I'll resend this without the per-channel configuration and make
adi,internal-ref-microvolt a global parameter.

Sorry about that,
Liam

>
> >=20
> > Given that we can now have a different scale for each channel based on
> > the vref source, should BIT(IIO_CHAN_INFO_SCALE) be moved to
> > .info_mask_separate in the channel definition?
> Yes, good point.
>
> Hopefully no one will notice the ABI change *crosses fingers*.
>
> Jonathan
>
> >=20
> > Thanks,
> > Liam
> >=20
> > > =20
> > > > +
> > > > +		switch (tmp) {
> > > > +		case 2500000:
> > > > +			ad7949_chan->refsel =3D AD7949_CFG_VAL_REF_INT_2500;
> > > > +			break;
> > > > +		case 4096000:
> > > > +			ad7949_chan->refsel =3D AD7949_CFG_VAL_REF_INT_4096;
> > > > +			break;
> > > > +		default:
> > > > +			dev_err(dev, "unsupported internal voltage reference\n");
> > > > +			fwnode_handle_put(child);
> > > > +			return -EINVAL;
> > > > +		}
> > > >  	}
> > > > =20
> > > >  	mutex_init(&ad7949_adc->lock);
> > > > @@ -373,7 +479,6 @@ static int ad7949_spi_probe(struct spi_device *=
spi)
> > > > =20
> > > >  err:
> > > >  	mutex_destroy(&ad7949_adc->lock);
> > > > -	regulator_disable(ad7949_adc->vref);
> > > > =20
> > > >  	return ret;
> > > >  }
> > > > @@ -385,7 +490,6 @@ static int ad7949_spi_remove(struct spi_device =
*spi)
> > > > =20
> > > >  	iio_device_unregister(indio_dev);
> > > >  	mutex_destroy(&ad7949_adc->lock);
> > > > -	regulator_disable(ad7949_adc->vref);
> > > > =20
> > > >  	return 0;
> > > >  } =20
> >=20

