Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3DB5BEFD7
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 00:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiITWMm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 18:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiITWMk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 18:12:40 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A9478218
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1663711956; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XA76AuXwTq3DMDU3xC0EEyRBJ8pTQWNisOVYuuxJ2w=;
        b=I10zOYUBikWkYyrfsDTLVWfwzEstqJL3d40czZJO3R8GKT0CQmsHDThOVkG9IPHEPHYwUP
        JYdkkvkSCqJx8pQXTKetIdwm7cowNfL4712guMnbLka+HTXcVZjbwV4skYWWOZUFL0Yf1D
        sqUp7DuUUMU/2B9B9c6ENzBvKtAVk/s=
Date:   Tue, 20 Sep 2022 23:12:27 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] iio: light: vcnl4000: Add ps_it attributes for
 vcnl4040
To:     =?iso-8859-1?q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        kernel@axis.com
Message-Id: <RC4JIR.84Y31Q6YBI06@crapouillou.net>
In-Reply-To: <20220920180958.2308229-4-marten.lindahl@axis.com>
References: <20220920180958.2308229-1-marten.lindahl@axis.com>
        <20220920180958.2308229-4-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi M=E5rten,

Le mar., sept. 20 2022 at 20:09:58 +0200, M=E5rten Lindahl=20
<marten.lindahl@axis.com> a =E9crit :
> Add read/write attribute for proximity integration time, and a read
> attribute for available integration times for the vcnl4040 chip.
>=20
> Signed-off-by: M=E5rten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/iio/light/vcnl4000.c | 83=20
> +++++++++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c=20
> b/drivers/iio/light/vcnl4000.c
> index 9838f0868372..7a207e48335d 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -76,6 +76,8 @@
>=20
>  #define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light=20
> sensor */
>  #define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
> +#define VCNL4040_PS_CONF2_PS_IT \
> +	(BIT(3) | BIT(2) | BIT(1)) /* Proximity integration time */

Use the GENMASK() macro.

>=20
>  /* Bit masks for interrupt registers. */
>  #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt=20
> source */
> @@ -103,6 +105,16 @@ static const int=20
> vcnl4010_prox_sampling_frequency[][2] =3D {
>  	{125, 0},
>  	{250, 0},
>  };
> +static const int vcnl4040_ps_it_times[][2] =3D {
> +	{0, 100},
> +	{0, 150},
> +	{0, 200},
> +	{0, 250},
> +	{0, 300},
> +	{0, 350},
> +	{0, 400},
> +	{0, 800},
> +};
>=20
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter=20
> pm_runtime_suspend */
>=20
> @@ -486,6 +498,49 @@ static int vcnl4000_set_pm_runtime_state(struct=20
> vcnl4000_data *data, bool on)
>  	return ret;
>  }
>=20
> +static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val,=20
> int *val2)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D (ret & VCNL4040_PS_CONF2_PS_IT) >> 1;

Use the FIELD_GET() macro.

> +
> +	if (ret >=3D ARRAY_SIZE(vcnl4040_ps_it_times))
> +		return -EINVAL;
> +
> +	*val =3D vcnl4040_ps_it_times[ret][0];
> +	*val2 =3D vcnl4040_ps_it_times[ret][1];
> +
> +	return 0;
> +}
> +
> +static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int=20
> val)
> +{
> +	unsigned int i;
> +	int ret, index =3D -1;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vcnl4040_ps_it_times); i++) {
> +		if (val =3D=3D vcnl4040_ps_it_times[i][1]) {
> +			index =3D i;
> +			break;
> +		}
> +	}
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D (ret & ~VCNL4040_PS_CONF2_PS_IT) | (index << 1);

Use the FIELD_PREP() macro.

> +
> +	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,=20
> ret);
> +}
> +
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
> @@ -533,6 +588,13 @@ static int vcnl4000_read_raw(struct iio_dev=20
> *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (chan->type !=3D IIO_PROXIMITY)
> +			return -EINVAL;
> +		ret =3D vcnl4040_read_ps_it(data, val, val2);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -554,6 +616,12 @@ static int vcnl4040_write_raw(struct iio_dev=20
> *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val !=3D 0)
> +			return -EINVAL;
> +		if (chan->type !=3D IIO_PROXIMITY)
> +			return -EINVAL;
> +		return vcnl4040_write_ps_it(data, val2);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -900,11 +968,23 @@ static const struct iio_chan_spec=20
> vcnl4040_channels[] =3D {
>  	}, {
>  		.type =3D IIO_PROXIMITY,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_ENABLE),
> +			BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_INT_TIME),
>  		.ext_info =3D vcnl4000_ext_info,
>  	}
>  };
>=20
> +static IIO_CONST_ATTR(in_proximity_integration_time_available,
> +	"0.000100 0.000150 0.000200 0.000250 0.000300 0.000350 0.000400=20
> 0.000800");

Hmm, this is not how you define a "_available" attribute.

You need to add a
.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_INT_TIME)

to your iio_chan_spec, then implement the .read_avail callback in your=20
iio_info structure.

Cheers,
-Paul

> +
> +static struct attribute *vcnl4040_attributes[] =3D {
> +	&iio_const_attr_in_proximity_integration_time_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group vcnl4040_attribute_group =3D {
> +	.attrs =3D vcnl4040_attributes,
> +};
> +
>  static const struct iio_info vcnl4000_info =3D {
>  	.read_raw =3D vcnl4000_read_raw,
>  };
> @@ -922,6 +1002,7 @@ static const struct iio_info vcnl4010_info =3D {
>  static const struct iio_info vcnl4040_info =3D {
>  	.read_raw =3D vcnl4000_read_raw,
>  	.write_raw =3D vcnl4040_write_raw,
> +	.attrs =3D &vcnl4040_attribute_group,
>  };
>=20
>  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] =3D {
> --
> 2.30.2
>=20


