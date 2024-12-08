Return-Path: <linux-iio+bounces-13211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9669E850A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9651884BD9
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE24148FF5;
	Sun,  8 Dec 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRbKU1Ri"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422881487F4;
	Sun,  8 Dec 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661738; cv=none; b=LtbNa8qhwcjAYMAv1HyiaaSimFebJTjASkpkTMnBHBoAgrmoAVdSlc1fHbVEJ/DhWL2OmKaXPVLlEc625//mme4W/H7Sq5dnTWhod6c4ZNUH27ynbBIcP8zNWoy83eq9qiG1HtFeW+wVTQMuMxOWz0zd53e2SkzKivd0hdKQebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661738; c=relaxed/simple;
	bh=d0u31iHPiEIcxf1CG9IRdtuH2RYGlHSNqH3idUYJxIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puOtmBXS11moDn4U7cwezqF6Z1PlTU90T1B01zml+Uddy4KJHvYSlgQCHvHHBvDcLnu1uPSqQAnTMoW0Q3NBoGe5bBwJEDBnuKxBupI3VhMFDAiaA/PMxDD5COZnsmRcPRQ+D7y3KS8T7XlLtrat+Xco8GGBLvD61KBjDzFNFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRbKU1Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893EAC4CED2;
	Sun,  8 Dec 2024 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733661737;
	bh=d0u31iHPiEIcxf1CG9IRdtuH2RYGlHSNqH3idUYJxIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TRbKU1RiDZqYBXsAUQ2kBRmkrgsO2mN/qkd4FwedLfCmMhBLAncZ/WI02xSgrPF5R
	 gKQz/RKKmCXx5pE0Q07Xw0zdxPnWw5aAHwEaYCA7KVOdJjKUGhAb4hwhh1iqj57SjC
	 1n01acqY91E58R+0pbVaSpe+LGfhPIM1zXaNxLTVcNZCcsgZEPpf5Y3iFh1ghZG7p1
	 z116ZoaW29Jkwr/JKlUR4OslRBapCrGie7prnDvOyszdSboLsS+bbpVtK1lxdCEIIy
	 6jZC/pqwxOne74TVPgzSDUsCO7RCPrLD6fIp2QjqzT7U8fo3NB9JAEsA7TtZuZjjFt
	 jUP9nTIAU5EBA==
Date: Sun, 8 Dec 2024 12:42:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 06/10] iio: adc: ad_sigma_delta: Fix a race condition
Message-ID: <20241208124205.5b297fa4@jic23-huawei>
In-Reply-To: <9e6def47e2e773e0e15b7a2c29d22629b53d91b1.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
	<9e6def47e2e773e0e15b7a2c29d22629b53d91b1.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  6 Dec 2024 18:28:38 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> The ad_sigma_delta driver helper uses irq_disable_nosync(). With that
> one it is possible that the irq handler still runs after the
> irq_disable_nosync() function call returns. Also to properly synchronize
> irq disabling in the different threads proper locking is needed and
> because it's unclear if the irq handler's irq_disable_nosync() call
> comes first or the one in the enabler's error path, all code locations
> that disable the irq must check for .irq_dis first to ensure there is
> exactly one disable call per enable call.
>=20
> So add a spinlock to the struct ad_sigma_delta and use it to synchronize
> irq enabling and disabling. Also only act in the irq handler if the irq
> is still enabled.
>=20
> Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta device=
s")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

=46rom sparse.

drivers/iio/adc/ad_sigma_delta.c:205:13: warning: context imbalance in 'ad_=
sd_disable_irq' - wrong count at exit
drivers/iio/adc/ad_sigma_delta.c:218:13: warning: context imbalance in 'ad_=
sd_enable_irq' - wrong count at exit

I saw your discussion with Linus on this...

https://lore.kernel.org/all/CAHk-=3DwiVDZejo_1BhOaR33qb=3Dpny7sWnYtP4JUbRTX=
kXCkW6jA@mail.gmail.com/

So I guess we just treat that as a false positive and move on.

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 56 ++++++++++++++++----------
>  include/linux/iio/adc/ad_sigma_delta.h |  1 +
>  2 files changed, 36 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_=
delta.c
> index ff20fa61c293..a4c31baa9c9e 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -202,6 +202,27 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
>  }
>  EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
> =20
> +static bool ad_sd_disable_irq(struct ad_sigma_delta *sigma_delta)
> +{
> +	guard(spinlock_irqsave)(&sigma_delta->irq_lock);
> +
> +	/* It's already off, return false to indicate nothing was changed */
> +	if (sigma_delta->irq_dis)
> +		return false;
> +
> +	sigma_delta->irq_dis =3D true;
> +	disable_irq_nosync(sigma_delta->irq_line);
> +	return true;
> +}
> +
> +static void ad_sd_enable_irq(struct ad_sigma_delta *sigma_delta)
> +{
> +	guard(spinlock_irqsave)(&sigma_delta->irq_lock);
> +
> +	sigma_delta->irq_dis =3D false;
> +	enable_irq(sigma_delta->irq_line);
> +}
> +
>  int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  	unsigned int mode, unsigned int channel)
>  {
> @@ -221,12 +242,10 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_de=
lta,
>  	if (ret < 0)
>  		goto out;
> =20
> -	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->irq_line);
> +	ad_sd_enable_irq(sigma_delta);
>  	time_left =3D wait_for_completion_timeout(&sigma_delta->completion, 2 *=
 HZ);
>  	if (time_left =3D=3D 0) {
> -		sigma_delta->irq_dis =3D true;
> -		disable_irq_nosync(sigma_delta->irq_line);
> +		ad_sd_disable_irq(sigma_delta);
>  		ret =3D -EIO;
>  	} else {
>  		ret =3D 0;
> @@ -294,8 +313,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *=
indio_dev,
> =20
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
> =20
> -	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->irq_line);
> +	ad_sd_enable_irq(sigma_delta);
>  	ret =3D wait_for_completion_interruptible_timeout(
>  			&sigma_delta->completion, HZ);
> =20
> @@ -314,10 +332,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev =
*indio_dev,
>  		&raw_sample);
> =20
>  out:
> -	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->irq_line);
> -		sigma_delta->irq_dis =3D true;
> -	}
> +	ad_sd_disable_irq(sigma_delta);
> =20
>  	sigma_delta->keep_cs_asserted =3D false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> @@ -396,8 +411,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *in=
dio_dev)
>  	if (ret)
>  		goto err_unlock;
> =20
> -	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->irq_line);
> +	ad_sd_enable_irq(sigma_delta);
> =20
>  	return 0;
> =20
> @@ -414,10 +428,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *=
indio_dev)
>  	reinit_completion(&sigma_delta->completion);
>  	wait_for_completion_timeout(&sigma_delta->completion, HZ);
> =20
> -	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->irq_line);
> -		sigma_delta->irq_dis =3D true;
> -	}
> +	ad_sd_disable_irq(sigma_delta);
> =20
>  	sigma_delta->keep_cs_asserted =3D false;
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> @@ -516,8 +527,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, voi=
d *p)
> =20
>  irq_handled:
>  	iio_trigger_notify_done(indio_dev->trig);
> -	sigma_delta->irq_dis =3D false;
> -	enable_irq(sigma_delta->irq_line);
> +	ad_sd_enable_irq(sigma_delta);
> =20
>  	return IRQ_HANDLED;
>  }
> @@ -551,11 +561,13 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq=
, void *private)
>  	 * So read the MOSI line as GPIO (if available) and only trigger the irq
>  	 * if the line is active. Without such a GPIO assume this is a valid
>  	 * interrupt.
> +	 *
> +	 * Also as disable_irq_nosync() is used to disable the irq, only act if
> +	 * the irq wasn't disabled before.
>  	 */
> -	if (!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod))=
 {
> +	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)=
) &&
> +	    ad_sd_disable_irq(sigma_delta)) {
>  		complete(&sigma_delta->completion);
> -		disable_irq_nosync(irq);
> -		sigma_delta->irq_dis =3D true;
>  		iio_trigger_poll(sigma_delta->trig);
> =20
>  		return IRQ_HANDLED;
> @@ -691,6 +703,8 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, st=
ruct iio_dev *indio_dev,
>  		}
>  	}
> =20
> +	spin_lock_init(&sigma_delta->irq_lock);
> +
>  	if (info->irq_line)
>  		sigma_delta->irq_line =3D info->irq_line;
>  	else
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/a=
dc/ad_sigma_delta.h
> index 126b187d70e9..f86eca6126b4 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -86,6 +86,7 @@ struct ad_sigma_delta {
> =20
>  /* private: */
>  	struct completion	completion;
> +	spinlock_t		irq_lock; /* protects .irq_dis and irq en/disable state */
>  	bool			irq_dis;
> =20
>  	bool			bus_locked;


