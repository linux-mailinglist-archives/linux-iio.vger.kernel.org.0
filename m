Return-Path: <linux-iio+bounces-23488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87336B3CEA7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E62048E3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114492D641C;
	Sat, 30 Aug 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdeJ8QY6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF397211290;
	Sat, 30 Aug 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756578347; cv=none; b=s9541bmGQZFdSz91C4LkGFXXguZ3H9IxRODWOFTMOBtAvjTfkd/ZkEdbRw9MEVyBUrRwreEIyONwXM361MYky/1AdjlsNZRZLJsbUk164zn/nmR1RPFXsB24dUWY4Rdtv826f+zH9Uf3/IcFsEHuOC2y8MZo9yXSymYUFk13tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756578347; c=relaxed/simple;
	bh=LP44N4DBA8yrEvcCLYAsAJr7yJlfuw9Yux44iwujOqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhcR+r0YvGnrmicP6pYTB9Qf86MAhBs788vemRbMwR3sVTdpZlbeE3Ndhn73wl3Y5RegqayZ0JVQ4d6W7AUGJ+DaDdIoR6cGNUbPYej3ucFspUy6vdpDqj4CH5KsN9fcjaf3r3gitw92q2XeKpE6RS7K5z+zUYBN4UthUKvppWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdeJ8QY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B577CC4CEEB;
	Sat, 30 Aug 2025 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756578347;
	bh=LP44N4DBA8yrEvcCLYAsAJr7yJlfuw9Yux44iwujOqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XdeJ8QY6LcDqrntB5LkNjUfQXhlfqw7ICDv8AF6IfDA+QoC7XjiVGnYMSQxu7Cbn6
	 gR3mmG0Pxf2z4GceItB+tO6DJ0FvgSCLxbLYpIL7ihmG/OdRRp6gfiPfuSiBM9ab0l
	 OL4WDvPDazTqs5oI96Q0VC4Bf/TtmjeMo5NfLDH3ohNAVIAbibBacxCDPQGJMwbWjx
	 ZNHPBfQr5+J8x+ZpPMgVY/fhRdfBia+aCBN+BCdi3Ky3augXYP/9MIf6Oo0YEhRs7N
	 Mg62kf87ODA3tnoX/Jwj4b+I8mRteBic3n6CKWKacWpWkWV9sziwfFwR1h2SWJBZpV
	 0fSRKxlmehQpw==
Date: Sat, 30 Aug 2025 19:25:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250830192538.3b508c5c@jic23-huawei>
In-Reply-To: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 17:05:00 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Implement runtime power management for the LTR390 sensor. The device
> autosuspends after 1s of idle time, reducing current consumption from
> 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the datash=
eet.
>=20
> Ensure that interrupts continue to be delivered with runtime PM.
> Since the LTR390 cannot be used as a wakeup source during runtime
> suspend, therefore increment the runtime PM refcount when enabling
> events and decrement it when disabling events or powering down.
> This prevents event loss while still allowing power savings when IRQs
> are unused.
>=20
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>

Sorry it took me a while to reply to the last email on the v1 thread.
Busy week.

I may have this all wrong though if the runtime pm disable you have
here (bit (1) of MAIN Control) restricts which other registers we can
access. Perhaps I'm missing where that is stated in the datasheet,
or maybe it's an omission and you have seen it to be the case
from experimentation?

If that isn't required a lot of the runtime pm calls in here go away.

Also, we should just read the config register to find out if the
even is enabled not bother having a separate cache of that one bit.

Jonathan


> ---
>=20
> Changes since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Andy's feedback:
> -> Check return value of pm_runtime_resume_and_get().
> -> Do not check return value of pm_runtime_put_autosuspend(). =20
>=20
> 2. Set data->irq_enabled =3D true after checking return value of pm_runti=
me_resume_and_get() only.
>=20
> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Andy's feedback:
> -> Refactor iio_info callbacks.
> -> Preserve the order of header file includes.
> -> Avoid redundant usage of pm_runtime_mark_last_busy.
> -> Dissolve the ltr390_set_power_state(data, [true|false]) function.
> -> Avoid macro usage which is internal to header file.
> -> Update changelog with reason of not using wakeup as a source =20
> capability.
>=20
> 2. David's feedback:
> -> Update Changelog with stats of power savings mentioned in datasheet.
> -> Dissolve ltr390_set_power_state() function. =20
>=20
> 3. Jonathan's feedback:
> -> Adopt the approach of increment refcount when event enable and =20
> vice-versa.

> +static int __ltr390_write_event_value(struct iio_dev *indio_dev,
>  				const struct iio_chan_spec *chan,
>  				enum iio_event_type type,
>  				enum iio_event_direction dir,
> @@ -571,22 +639,55 @@ static int ltr390_write_event_value(struct iio_dev =
*indio_dev,
>  	}
>  }
> =20
> +static int ltr390_write_event_value(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	int ret;
> +	struct ltr390_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D __ltr390_write_event_value(indio_dev, chan, type, dir,
> +					info, val, val2);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
>  static int ltr390_read_event_config(struct iio_dev *indio_dev,
>  				const struct iio_chan_spec *chan,
>  				enum iio_event_type type,
>  				enum iio_event_direction dir)
>  {
>  	struct ltr390_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
>  	int ret, status;
> =20
> +	ret =3D pm_runtime_resume_and_get(dev);
I may be misreading the datasheet but I'd kind of expect to be
able to read this register in the (slightly) powered down state.

> +	if (ret < 0) {
> +		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret =3D regmap_read(data->regmap, LTR390_INT_CFG, &status);
> +
> +	pm_runtime_put_autosuspend(dev);
> +
>  	if (ret < 0)
>  		return ret;
> -
>  	return FIELD_GET(LTR390_LS_INT_EN, status);
>  }
> =20
> -static int ltr390_write_event_config(struct iio_dev *indio_dev,
> +static int __ltr390_write_event_config(struct iio_dev *indio_dev,
>  				const struct iio_chan_spec *chan,
>  				enum iio_event_type type,
>  				enum iio_event_direction dir,
> @@ -598,7 +699,6 @@ static int ltr390_write_event_config(struct iio_dev *=
indio_dev,
>  	if (!state)
>  		return regmap_clear_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_E=
N);
> =20
> -	guard(mutex)(&data->lock);
>  	ret =3D regmap_set_bits(data->regmap, LTR390_INT_CFG, LTR390_LS_INT_EN);
>  	if (ret < 0)
>  		return ret;
> @@ -623,18 +723,60 @@ static int ltr390_write_event_config(struct iio_dev=
 *indio_dev,
>  	}
>  }
> =20
> +static int ltr390_write_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				bool state)
> +{
> +	int ret;
> +	struct ltr390_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +
> +	guard(mutex)(&data->lock);
> +
As per v1 (late) reply. I'd expect to find query the register to find
out if what we are potentially setting here is already on or not and
exit early if we aren't changing that state.

Then we don't need the data->irq_enabled, we can just use runtime pm refere=
nce
counting to ensure the right things happen.

> +	if (state && !data->irq_enabled) {
> +		ret =3D pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> +			return ret;
> +		}
> +		data->irq_enabled =3D true;
> +	}
> +
> +	ret =3D __ltr390_write_event_config(indio_dev, chan, type, dir, state);
> +
> +	if (!state && data->irq_enabled) {
> +		data->irq_enabled =3D false;
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +
>  static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
>  						unsigned int reg, unsigned int writeval,
>  						unsigned int *readval)
>  {
>  	struct ltr390_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +	int ret;
> =20
> -	guard(mutex)(&data->lock);
> +	ret =3D pm_runtime_resume_and_get(dev);

So this makes me wonder.  I'd been assuming our disable was only turning the
sensor off, not register access?  Seeing as it's controlled by a register
we can clearly access at least some.

If that's the case why do we need to runtime resume for debug register
read/write?  We shouldn't care if the sensors are reading or not. In fact
if we do turn the power on we changed the state we are debugging which is
probably not a good plan.

> +	if (ret < 0) {
> +		dev_err(dev, "runtime PM failed to resume: %d\n", ret);
> +		return ret;
> +	}
> =20
> +	guard(mutex)(&data->lock);
>  	if (readval)
> -		return regmap_read(data->regmap, reg, readval);
> +		ret =3D regmap_read(data->regmap, reg, readval);
> +	else
> +		ret =3D regmap_write(data->regmap, reg, writeval);
> =20
> -	return regmap_write(data->regmap, reg, writeval);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
>  }

