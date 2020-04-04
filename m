Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDFF19E66F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgDDQYR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 12:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDDQYR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 12:24:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85E04206F8;
        Sat,  4 Apr 2020 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586017456;
        bh=zLzyO0vkAY8hFwapbYXloOrTstp1BoEEZ4oGP7XxZ+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v9RfM2tWuoCf6nDxriN7YBQW3h1hUdPWLHIWF5ub2d4DOWPnef1LUZw7mHyjSKDi7
         DH4hP0FaLJmn40fmR4NE8CBO89LYyJqCTY/i6nHa0dtMEi9kRvjEcc69ax3fYu8KGf
         F83euvRAi9Kgb1CNvC2AqSQtAKeC/RVEbGbXEvXI=
Date:   Sat, 4 Apr 2020 17:24:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/6] iio: imu: adis: Add Managed device functions
Message-ID: <20200404172411.07defbab@archlinux>
In-Reply-To: <20200331114811.7978-2-nuno.sa@analog.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
        <20200331114811.7978-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Mar 2020 13:48:06 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This patch adds support for a managed device version of
> adis_setup_buffer_and_trigger. It works exactly as the original
> one but it calls all the devm_iio_* functions to setup an iio
> buffer and trigger. Hence we do not need to care about cleaning those
> and we do not need to support a remove() callback for every driver using
> the adis library.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Random thought inline.  Something we could use more in IIO :)

> ---
> Changes in v2:
>  * Added blank lines for readability.
>=20
> Changes in V3:
>  * Removed unnecessary inline;
>  * Free buffer resources.
>=20
>  drivers/iio/imu/adis_buffer.c  | 45 ++++++++++++++++++++++++++++++++++
>  drivers/iio/imu/adis_trigger.c | 41 ++++++++++++++++++++++++++++---
>  include/linux/iio/imu/adis.h   | 17 +++++++++++++
>  3 files changed, 100 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 04e5e2a0fd6b..c2211ab80d8c 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -156,6 +156,14 @@ static irqreturn_t adis_trigger_handler(int irq, voi=
d *p)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void adis_buffer_cleanup(void *arg)
> +{
> +	struct adis *adis =3D arg;
> +
> +	kfree(adis->buffer);
> +	kfree(adis->xfer);
> +}
> +
>  /**
>   * adis_setup_buffer_and_trigger() - Sets up buffer and trigger for the =
adis device
>   * @adis: The adis device.
> @@ -198,6 +206,43 @@ int adis_setup_buffer_and_trigger(struct adis *adis,=
 struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
> =20
> +/**
> + * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
> + *					  the managed adis device
> + * @adis: The adis device
> + * @indio_dev: The IIO device
> + * @trigger_handler: Optional trigger handler, may be NULL.
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + *
> + * This function perfoms exactly the same as adis_setup_buffer_and_trigg=
er()
> + */
> +int
> +devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *in=
dio_dev,
> +				   irqreturn_t (*trigger_handler)(int, void *))

It occurred to me that there must be a lot of irq handling function pointers
in the kernel and it would be odd if there wasn't a type for this...

There is :) irq_handler_t=20

https://elixir.bootlin.com/linux/latest/source/include/linux/interrupt.h#L92

Not sure why I never noticed that before.  Hohum.

Jonathan


> +{
> +	int ret;
> +
> +	if (!trigger_handler)
> +		trigger_handler =3D adis_trigger_handler;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(&adis->spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (adis->spi->irq) {
> +		ret =3D devm_adis_probe_trigger(adis, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_add_action_or_reset(&adis->spi->dev, adis_buffer_cleanup,
> +					adis);
> +}
> +EXPORT_SYMBOL_GPL(devm_adis_setup_buffer_and_trigger);
> +
>  /**
>   * adis_cleanup_buffer_and_trigger() - Free buffer and trigger resources
>   * @adis: The adis device.
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigge=
r.c
> index 8b9cd02c0f9f..a36810e0b1ab 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -27,6 +27,13 @@ static const struct iio_trigger_ops adis_trigger_ops =
=3D {
>  	.set_trigger_state =3D &adis_data_rdy_trigger_set_state,
>  };
> =20
> +static void adis_trigger_setup(struct adis *adis)
> +{
> +	adis->trig->dev.parent =3D &adis->spi->dev;
> +	adis->trig->ops =3D &adis_trigger_ops;
> +	iio_trigger_set_drvdata(adis->trig, adis);
> +}
> +
>  /**
>   * adis_probe_trigger() - Sets up trigger for a adis device
>   * @adis: The adis device
> @@ -45,9 +52,7 @@ int adis_probe_trigger(struct adis *adis, struct iio_de=
v *indio_dev)
>  	if (adis->trig =3D=3D NULL)
>  		return -ENOMEM;
> =20
> -	adis->trig->dev.parent =3D &adis->spi->dev;
> -	adis->trig->ops =3D &adis_trigger_ops;
> -	iio_trigger_set_drvdata(adis->trig, adis);
> +	adis_trigger_setup(adis);
> =20
>  	ret =3D request_irq(adis->spi->irq,
>  			  &iio_trigger_generic_data_rdy_poll,
> @@ -73,6 +78,36 @@ int adis_probe_trigger(struct adis *adis, struct iio_d=
ev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(adis_probe_trigger);
> =20
> +/**
> + * devm_adis_probe_trigger() - Sets up trigger for a managed adis device
> + * @adis: The adis device
> + * @indio_dev: The IIO device
> + *
> + * Returns 0 on success or a negative error code
> + */
> +int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	adis->trig =3D devm_iio_trigger_alloc(&adis->spi->dev, "%s-dev%d",
> +					    indio_dev->name, indio_dev->id);
> +	if (!adis->trig)
> +		return -ENOMEM;
> +
> +	adis_trigger_setup(adis);
> +
> +	ret =3D devm_request_irq(&adis->spi->dev, adis->spi->irq,
> +			       &iio_trigger_generic_data_rdy_poll,
> +			       IRQF_TRIGGER_RISING,
> +			       indio_dev->name,
> +			       adis->trig);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_trigger_register(&adis->spi->dev, adis->trig);
> +}
> +EXPORT_SYMBOL_GPL(devm_adis_probe_trigger);
> +
>  /**
>   * adis_remove_trigger() - Remove trigger for a adis devices
>   * @adis: The adis device
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index dd8219138c2e..ac94c483bf2b 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -448,11 +448,15 @@ struct adis_burst {
>  	unsigned int	extra_len;
>  };
> =20
> +int
> +devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *in=
dio_dev,
> +				   irqreturn_t (*trigger_handler)(int, void *));
>  int adis_setup_buffer_and_trigger(struct adis *adis,
>  	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *));
>  void adis_cleanup_buffer_and_trigger(struct adis *adis,
>  	struct iio_dev *indio_dev);
> =20
> +int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev=
);
>  int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
>  void adis_remove_trigger(struct adis *adis);
> =20
> @@ -461,6 +465,13 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
> =20
>  #else /* CONFIG_IIO_BUFFER */
> =20
> +static inline int
> +devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *in=
dio_dev,
> +				   irqreturn_t (*trigger_handler)(int, void *))
> +{
> +	return 0;
> +}
> +
>  static inline int adis_setup_buffer_and_trigger(struct adis *adis,
>  	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *))
>  {
> @@ -472,6 +483,12 @@ static inline void adis_cleanup_buffer_and_trigger(s=
truct adis *adis,
>  {
>  }
> =20
> +static inline int devm_adis_probe_trigger(struct adis *adis,
> +					  struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +
>  static inline int adis_probe_trigger(struct adis *adis,
>  	struct iio_dev *indio_dev)
>  {

