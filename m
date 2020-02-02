Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3EA14FC68
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgBBJeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 04:34:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgBBJeP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 04:34:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5636E2067C;
        Sun,  2 Feb 2020 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580636054;
        bh=36ErpYtvk0vO6IQK2bXB47/iGmAd+jPsmD0foXUCyU0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w0YW9PP88SoHPxqAjGjkd+xklrlTELobej4YCqjwF1OaH4PyUdoHIGByW0nIqXiCS
         71EqRlOPret+O5yxOge2ExwNpXknbuhYq3Nnp93kb1YW1JM2lxf6NfRBSaCoBVLIQU
         LoZtbch7OlfsA8S6re8LHbG92E9lKqBJ54uqRhR8=
Date:   Sun, 2 Feb 2020 09:34:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: vncl4000: Enable runtime pm for
 vcnl4200/4040
Message-ID: <20200202093408.26bc63b8@archlinux>
In-Reply-To: <237488ddf8f2707e905164c0ec81a7979f1fa9a9.1580391472.git.agx@sigxcpu.org>
References: <cover.1580391472.git.agx@sigxcpu.org>
        <237488ddf8f2707e905164c0ec81a7979f1fa9a9.1580391472.git.agx@sigxcpu.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jan 2020 14:42:36 +0100
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> This is modelled after the vcnl4035 driver. For the vcnl40{0,1,2}0
> we don't do anything since they use on demand measurement.
>=20
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
Hi Guido,

A few minor things inline, but otherwise looks good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 135 ++++++++++++++++++++++++++++++++---
>  1 file changed, 124 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 8f198383626b..1395875d9553 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -22,6 +22,7 @@
>  #include <linux/i2c.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -57,6 +58,8 @@
>  #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
>  #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement =
*/
> =20
> +#define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspe=
nd */
> +
>  enum vcnl4000_device_ids {
>  	VCNL4000,
>  	VCNL4010,
> @@ -87,6 +90,7 @@ struct vcnl4000_chip_spec {
>  	int (*init)(struct vcnl4000_data *data);
>  	int (*measure_light)(struct vcnl4000_data *data, int *val);
>  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> +	int (*set_power_state)(struct vcnl4000_data *data, bool on);
>  };
> =20
>  static const struct i2c_device_id vcnl4000_id[] =3D {
> @@ -99,6 +103,12 @@ static const struct i2c_device_id vcnl4000_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> =20
> +static int vcnl4000_set_power_state(struct vcnl4000_data *data, bool on)
> +{
> +	/* no suspend op */
> +	return 0;
> +}
> +
>  static int vcnl4000_init(struct vcnl4000_data *data)
>  {
>  	int ret, prod_id;
> @@ -127,9 +137,31 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>  	data->al_scale =3D 250000;
>  	mutex_init(&data->vcnl4000_lock);
> =20
> +	ret =3D data->chip_spec->set_power_state(data, true);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  };
> =20
> +static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
> +{
> +	u16 val =3D on ? 0 /* power on */ : 1 /* shut down */;
> +	int ret;
> +
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait at least one integration cycle before fetching data */
> +	data->vcnl4200_al.last_measurement =3D ktime_get();
> +	data->vcnl4200_ps.last_measurement =3D ktime_get();

Hmm.  Feels like these only really make sense if we are turning on?
They may do no harm in the off path, but better if the code makes
it clear they are irrelevant in that path.

No return value.

i.e. return 0;
> +}
> +
>  static int vcnl4200_init(struct vcnl4000_data *data)
>  {
>  	int ret, id;
> @@ -155,14 +187,6 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> =20
>  	data->rev =3D (ret >> 8) & 0xf;
> =20
> -	/* Set defaults and enable both channels */
> -	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, 0);
> -	if (ret < 0)
> -		return ret;
> -	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, 0);
> -	if (ret < 0)
> -		return ret;
> -
>  	data->vcnl4200_al.reg =3D VCNL4200_AL_DATA;
>  	data->vcnl4200_ps.reg =3D VCNL4200_PS_DATA;
>  	switch (id) {
> @@ -180,11 +204,13 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		data->al_scale =3D 120000;
>  		break;
>  	}
> -	data->vcnl4200_al.last_measurement =3D ktime_set(0, 0);
> -	data->vcnl4200_ps.last_measurement =3D ktime_set(0, 0);
>  	mutex_init(&data->vcnl4200_al.lock);
>  	mutex_init(&data->vcnl4200_ps.lock);
> =20
> +	ret =3D data->chip_spec->set_power_state(data, true);
> +	if (ret < 0)
> +		return ret;
> +
>  	return 0;
>  };
> =20
> @@ -291,24 +317,28 @@ static const struct vcnl4000_chip_spec vcnl4000_chi=
p_spec_cfg[] =3D {
>  		.init =3D vcnl4000_init,
>  		.measure_light =3D vcnl4000_measure_light,
>  		.measure_proximity =3D vcnl4000_measure_proximity,
> +		.set_power_state =3D vcnl4000_set_power_state,
>  	},
>  	[VCNL4010] =3D {
>  		.prod =3D "VCNL4010/4020",
>  		.init =3D vcnl4000_init,
>  		.measure_light =3D vcnl4000_measure_light,
>  		.measure_proximity =3D vcnl4000_measure_proximity,
> +		.set_power_state =3D vcnl4000_set_power_state,
>  	},
>  	[VCNL4040] =3D {
>  		.prod =3D "VCNL4040",
>  		.init =3D vcnl4200_init,
>  		.measure_light =3D vcnl4200_measure_light,
>  		.measure_proximity =3D vcnl4200_measure_proximity,
> +		.set_power_state =3D vcnl4200_set_power_state,
>  	},
>  	[VCNL4200] =3D {
>  		.prod =3D "VCNL4200",
>  		.init =3D vcnl4200_init,
>  		.measure_light =3D vcnl4200_measure_light,
>  		.measure_proximity =3D vcnl4200_measure_proximity,
> +		.set_power_state =3D vcnl4200_set_power_state,
>  	},
>  };
> =20
> @@ -323,6 +353,23 @@ static const struct iio_chan_spec vcnl4000_channels[=
] =3D {
>  	}
>  };
> =20
> +static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, boo=
l on)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	int ret;
> +
> +	if (on) {
> +		ret =3D pm_runtime_get_sync(dev);
> +		if (ret < 0)
> +			pm_runtime_put_noidle(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret =3D pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
> @@ -332,6 +379,10 @@ static int vcnl4000_read_raw(struct iio_dev *indio_d=
ev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret =3D vcnl4000_set_pm_runtime_state(data, true);
> +		if  (ret < 0)
> +			return ret;
> +
>  		switch (chan->type) {
>  		case IIO_LIGHT:
>  			ret =3D data->chip_spec->measure_light(data, val);
> @@ -346,6 +397,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_de=
v,
>  		default:
>  			ret =3D -EINVAL;
>  		}
> +		vcnl4000_set_pm_runtime_state(data, false);
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type !=3D IIO_LIGHT)
> @@ -394,7 +446,22 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	indio_dev->name =3D VCNL4000_DRV_NAME;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	ret =3D pm_runtime_set_active(&client->dev);
> +	if (ret < 0)
> +		goto fail_poweroff;
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto fail_poweroff;
> +
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4000_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(&client->dev);
> +
> +	return 0;
> +fail_poweroff:
> +	data->chip_spec->set_power_state(data, false);
> +	return ret;
>  }
> =20
>  static const struct of_device_id vcnl_4000_of_match[] =3D {
> @@ -422,13 +489,59 @@ static const struct of_device_id vcnl_4000_of_match=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
> =20
> +static int vcnl4000_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> +
> +	pm_runtime_dont_use_autosuspend(&client->dev);
> +	pm_runtime_disable(&client->dev);
> +	iio_device_unregister(indio_dev);
> +	pm_runtime_set_suspended(&client->dev);
> +
> +	return data->chip_spec->set_power_state(data, false);
> +}
> +
> +static int __maybe_unused vcnl4000_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D data->chip_spec->set_power_state(data, false);
> +
> +	return ret;

	return data->chip_spec...

> +}
> +
> +static int __maybe_unused vcnl4000_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	struct vcnl4000_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D data->chip_spec->set_power_state(data, true);
> +	if (ret < 0)
> +		return ret;

I would define the set_power_state callback to return only < 0 for error
and 0 for no error.  (already true).

then

return data->chip_spec->set_power_state(data, true);

> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops vcnl4000_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(vcnl4000_runtime_suspend,
> +			   vcnl4000_runtime_resume, NULL)
> +};
> +
>  static struct i2c_driver vcnl4000_driver =3D {
>  	.driver =3D {
>  		.name   =3D VCNL4000_DRV_NAME,
> +		.pm	=3D &vcnl4000_pm_ops,
>  		.of_match_table =3D vcnl_4000_of_match,
>  	},
>  	.probe  =3D vcnl4000_probe,
>  	.id_table =3D vcnl4000_id,
> +	.remove	=3D vcnl4000_remove,
>  };
> =20
>  module_i2c_driver(vcnl4000_driver);

