Return-Path: <linux-iio+bounces-23242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5DB343E6
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C223AF7E4
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1632FF653;
	Mon, 25 Aug 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA5j8v/d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC62FF64C;
	Mon, 25 Aug 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131977; cv=none; b=lhMtBezhpJxlM5gVmOmC6BdRUEzSCKHY1gTWdsl+aGIhcwZVsnz4RCpTpMWiq8zOGSeibP9poilLDJY4qhPMwzWRCE0NOM4PhzoLryfzZ7q0CD5rDFHSdFT4QeejDxDn3VTT8mBiPJv+ZLnczSM8mr7DIblf3waaBAkNSqHamtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131977; c=relaxed/simple;
	bh=BVn/Lrf+nq8C1Bil6LvGOFtBUm06xHJUyJev7CoLF6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyQhQkK/exLPFN04n0zpgRKdirqgwH2Y3yQWBwZ4+IoqBfH8JnAYumy9eGRBbec6E9y8YY+N1fzQyZMUbyszKmaw+0vF0LH7oVnyFMI1nctm+widytydejBGpYrEsAb4OkqNR9nV7HF9WpL2N3xS7CxXqVX59bqifb3qOzvUkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA5j8v/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F58DC113D0;
	Mon, 25 Aug 2025 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756131977;
	bh=BVn/Lrf+nq8C1Bil6LvGOFtBUm06xHJUyJev7CoLF6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BA5j8v/dm3IduJgaWuZACJU8XMjSPVUwmQL7voySO4B4AKdPwZd9llA7wdjl/tpaS
	 kIN/8YYwXye7aN6ItDvOpHhxWSv5BVyJA9TIHd+A1Z3Hp8bygjUJMzjWbcEFJGjlso
	 20SKMg8hoTivfszZ5PaNUWFfi2x3QDXI5RZrecVdTOywCE55hDzfb4UAPGgcmL4WXP
	 LLGn0akS2caEY0XbLdUartETPgOGnWsgrKB9t2ZgcY5cLoplwjOK0wTdZ+rjBK5JqQ
	 g6YHaso9GEbxR84ZSVWYverHVBNZ3BbJc/lb+87+AkzKxpY7Uunl2NT+0tC41Dz+xe
	 14SJABLiMr5Vg==
Date: Mon, 25 Aug 2025 15:26:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
Message-ID: <20250825152608.6468c27b@jic23-huawei>
In-Reply-To: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Aug 2025 23:33:26 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Implement runtime power management for the LTR390 sensor.
> The device would now autosuspend after 1s of idle time.
> This would save the overall power consumption by the sensor.
>=20
> Ensure that interrupts continue to be delivered during
> runtime suspend by disabling the sensor only when no
> interrupts are enabled. This prevents loss of events
> while still allowing power savings when IRQs are unused.

Wrap closer to 75 chars.

Main comment that follows is that runtime pm is reference
counted.  That is you can take multiple references in different
paths at the same time and only when they are all released does
the put actually cause it to be suspended.  So for events
just grab an extra reference.  Lots of drivers do this in the
buffer enables for example - probably some in event handling
as well I just can't remember which one right now and am too lazy
to go find out.


>=20
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>=20
> Testing summary:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -> Tested on Raspberrypi 4B. Following tests were performed. =20
> 1. Verified that /sys/bus/i2c/devices/i2c-1/1-0053/power/control contains=
 =E2=80=98auto=E2=80=99 value.
> 2. Verified the /sys/bus/i2c/devices/i2c-1/1-0053/power/autosuspend_delay=
_ms contains 1000 which is assigned by the driver.
> 3. Changed the autosuspend_delay_ms value from 1000 to 2000ms and verifie=
d it.
> 	3.1 Verified through the timestamp that whatever autosuspend_delay_ms is=
 set, it is being honoured.
> 4. Verified that runtime_suspend and runtime_resume callbacks are called =
whenever any IO is done on a channel attribute.
> 	4.1 Verified that power/runtime_status first becomes active and then bec=
omes suspended.
> 	4.2 Verified that power/runtime_active_time keeps on increasing with a d=
elta of autosuspend_delay_ms.
>=20
> Interrupt Handling Verification:
> --------------------------------
> 1. Verified that when interrupts are enabled on the device, then the devi=
ce does not get put in standby mode and keeps sampling.
> 	a. As a result interrupts are delivered to the driver and are handled.
> 2. Verified that when interrupts are disabled, the device is put in stand=
by mode and stops sampling.
> 	a.Since there is no sampling, so no IRQs will be generated. They are onl=
y generated when the device is resumed due to I/O on some sysfs attribute f=
rom userspace.
>=20
>  drivers/iio/light/ltr390.c | 246 +++++++++++++++++++++++++++++--------
>  1 file changed, 193 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 2e1cf62e8201..9e2f33a401f2 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -30,6 +30,7 @@
> =20
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include <linux/unaligned.h>
> =20
> @@ -105,6 +106,7 @@ struct ltr390_data {
>  	enum ltr390_mode mode;
>  	int gain;
>  	int int_time_us;
> +	bool irq_enabled;
>  };
> =20
>  static const struct regmap_range ltr390_readable_reg_ranges[] =3D {
> @@ -154,6 +156,25 @@ static const int ltr390_samp_freq_table[][2] =3D {
>  		[7] =3D { 500, 2000 },
>  };
> =20
> +static int ltr390_set_power_state(struct ltr390_data *data, bool on)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	int ret =3D 0;
> +
> +	if (on) {
> +		ret =3D pm_runtime_resume_and_get(dev);

David touched on this.  Put the calls inline - there is no benefit to this
function as it calls one of two unrelated paths at each call site.

> +		if (ret) {
> +			dev_err(dev, "failed to resume runtime PM: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +
>  static int ltr390_register_read(struct ltr390_data *data, u8 register_ad=
dress)
>  {
>  	struct device *dev =3D &data->client->dev;
> @@ -223,61 +244,76 @@ static int ltr390_read_raw(struct iio_dev *iio_devi=
ce,
>  	struct ltr390_data *data =3D iio_priv(iio_device);
> =20
>  	guard(mutex)(&data->lock);
> +
> +	ltr390_set_power_state(data, true);
Can fail so you should check.

Wrap ltr390_register_read() in an outer function that does the powerstate
management.  Then no need to have all the gotos in here.

I am intending to see what appetite there is for a ACQUIRE() conditional
guard set of macros around autosuspend, but for now a separate wrapper func=
tion
is the cleanest path. Be careful with the locking though.


> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_UVINDEX:
>  			ret =3D ltr390_set_mode(data, LTR390_SET_UVS_MODE);
>  			if (ret < 0)
> -				return ret;
> +				goto handle_pm;
> =20
>  			ret =3D ltr390_register_read(data, LTR390_UVS_DATA);
>  			if (ret < 0)
> -				return ret;
> +				goto handle_pm;
>  			break;
> =20
>  		case IIO_LIGHT:
>  			ret =3D ltr390_set_mode(data, LTR390_SET_ALS_MODE);
>  			if (ret < 0)
> -				return ret;
> +				goto handle_pm;
> =20
>  			ret =3D ltr390_register_read(data, LTR390_ALS_DATA);
>  			if (ret < 0)
> -				return ret;
> +				goto handle_pm;
>  			break;
> =20
>  		default:
> -			return -EINVAL;
> +			ret =3D -EINVAL;
> +			goto handle_pm;
>  		}
>  		*val =3D ret;
> -		return IIO_VAL_INT;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_UVINDEX:
>  			*val =3D LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
>  			*val2 =3D ltr390_counts_per_uvi(data);
> -			return IIO_VAL_FRACTIONAL;
> +			ret =3D IIO_VAL_FRACTIONAL;
> +			break;
> =20
>  		case IIO_LIGHT:
>  			*val =3D LTR390_WINDOW_FACTOR * 6 * 100;
>  			*val2 =3D data->gain * data->int_time_us;
> -			return IIO_VAL_FRACTIONAL;
> +			ret =3D IIO_VAL_FRACTIONAL;
> +			break;
> =20
>  		default:
> -			return -EINVAL;
> +			ret =3D -EINVAL;
>  		}
> +		break;
> =20
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val =3D data->int_time_us;
> -		return IIO_VAL_INT;
> +		ret =3D IIO_VAL_INT;
> +		break;
> =20
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val =3D ltr390_get_samp_freq_or_period(data, LTR390_GET_FREQ);
> -		return IIO_VAL_INT;
> +		ret =3D IIO_VAL_INT;
> +		break;
> =20
>  	default:
> -		return -EINVAL;
> +		ret =3D -EINVAL;
>  	}
> +
> +handle_pm:
> +	ltr390_set_power_state(data, false);
> +	return ret;
>  }

> @@ -595,32 +670,43 @@ static int ltr390_write_event_config(struct iio_dev=
 *indio_dev,
>  	struct ltr390_data *data =3D iio_priv(indio_dev);
>  	int ret;
> =20
> -	if (!state)
> -		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_E=
N);
> +	ltr390_set_power_state(data, true);
> =20
>  	guard(mutex)(&data->lock);
> +
> +	if (!state) {
> +		ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_=
EN);
> +		data->irq_enabled =3D false;

Just take an extra reference to runtime pm on enable of event and put it di=
sable.
Then no need for special handling with a local flag etc.



> +static int ltr390_pm_init(struct ltr390_data *data)
> +{
> +	int ret;
> +	struct device *dev =3D &data->client->dev;
> +
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_pm_runtime_enable(dev);

devm_pm_runtime_set_active_enabled() I think would work here.

That shortens this setup enough I'd not bother with this function.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"failed to enable powermanagement\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +	return 0;
> +}
> +
>  static int ltr390_probe(struct i2c_client *client)
>  {
>  	struct ltr390_data *data;
> @@ -708,6 +820,8 @@ static int ltr390_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
> =20
> +	i2c_set_clientdata(client, indio_dev);
> +
>  	data =3D iio_priv(indio_dev);
>  	data->regmap =3D devm_regmap_init_i2c(client, &ltr390_regmap_config);
>  	if (IS_ERR(data->regmap))
> @@ -721,6 +835,8 @@ static int ltr390_probe(struct i2c_client *client)
>  	data->gain =3D 3;
>  	/* default mode for ltr390 is ALS mode */
>  	data->mode =3D LTR390_SET_ALS_MODE;
> +	/* default irq_enabled is false */
> +	data->irq_enabled =3D false;
> =20
>  	mutex_init(&data->lock);
> =20
> @@ -763,6 +879,7 @@ static int ltr390_probe(struct i2c_client *client)
>  					     "request irq (%d) failed\n", client->irq);
>  	}
> =20
> +	ltr390_pm_init(data);
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> =20
> @@ -784,7 +901,30 @@ static int ltr390_resume(struct device *dev)
>  				LTR390_SENSOR_ENABLE);
>  }
> =20
> -static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_re=
sume);
> +static int ltr390_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct ltr390_data *data =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +	if (data->irq_enabled)

As above. When you have events enabled, grab an extra reference and don't
put it until you disable the event. That way we never enter
runtime_suspend whilst they are enabled.

> +		return 0;
> +	return regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
> +				LTR390_SENSOR_ENABLE);
> +}
> +
> +static int ltr390_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct ltr390_data *data =3D iio_priv(indio_dev);
> +
> +	return regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
> +				LTR390_SENSOR_ENABLE);
> +}
> +
> +static _DEFINE_DEV_PM_OPS(ltr390_pm_ops,
> +		ltr390_suspend, ltr390_resume,
> +		ltr390_runtime_suspend, ltr390_runtime_resume, NULL);
> =20
>  static const struct i2c_device_id ltr390_id[] =3D {
>  	{ "ltr390" },
> @@ -802,7 +942,7 @@ static struct i2c_driver ltr390_driver =3D {
>  	.driver =3D {
>  		.name =3D "ltr390",
>  		.of_match_table =3D ltr390_of_table,
> -		.pm =3D pm_sleep_ptr(&ltr390_pm_ops),
> +		.pm =3D pm_ptr(&ltr390_pm_ops),
>  	},
>  	.probe =3D ltr390_probe,
>  	.id_table =3D ltr390_id,


