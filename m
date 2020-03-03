Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D973178426
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 21:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbgCCUih (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 15:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbgCCUig (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Mar 2020 15:38:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC9020848;
        Tue,  3 Mar 2020 20:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267915;
        bh=HMLAzVXCGhDu3668gb8GrZg+AfXo1RtVJWINWD0JTTk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ge1TETjWbpja6/DMoFoC/SngrmPvvG/MbBkye0nNNPFWtqT/wq2GBA0+8e8pwiach
         tnSC2eS6Sbo+XZhDIHF4Cq27QcAvNUUEDoRK79IeHDLVKIfD8biTnwmoiuCLTui1vF
         ruB7Ui5WswntiPk8RPanGMuEb3+DtnAeV5F4ddSQ=
Date:   Tue, 3 Mar 2020 20:38:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/5] iio: imu: adis: Add Managed device functions
Message-ID: <20200303203826.0b3d127d@archlinux>
In-Reply-To: <20200225124152.270914-2-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 13:41:48 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This patch adds support for a managed device version of
> adis_setup_buffer_and_trigger. It works exactly as the original
> one but it calls all the devm_iio_* functions to setup an iio
> buffer and trigger. Hence we do not need to care about cleaning those
> and we do not need to support a remove() callback for every driver using
> the adis library.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

A few trivial things inline.

I'm hoping the plan here is to replace all the existing non devm versions
and remove the non devm versions?

That way we don't end up with a near identical repeated block of code.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/adis_buffer.c  | 34 +++++++++++++++++++++++++++++
>  drivers/iio/imu/adis_trigger.c | 39 +++++++++++++++++++++++++++++++---
>  include/linux/iio/imu/adis.h   | 17 +++++++++++++++
>  3 files changed, 87 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 3f4dd5c00b03..296036a01d39 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -196,7 +196,41 @@ int adis_setup_buffer_and_trigger(struct adis *adis,=
 struct iio_dev *indio_dev,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);

blank line here.

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
> =20
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_adis_setup_buffer_and_trigger);
>  /**
>   * adis_cleanup_buffer_and_trigger() - Free buffer and trigger resources
>   * @adis: The adis device.
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigge=
r.c
> index 8b9cd02c0f9f..a07dcc365c18 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -27,6 +27,13 @@ static const struct iio_trigger_ops adis_trigger_ops =
=3D {
>  	.set_trigger_state =3D &adis_data_rdy_trigger_set_state,
>  };
> =20
> +static inline void adis_trigger_setup(struct adis *adis)
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
> @@ -72,7 +77,35 @@ int adis_probe_trigger(struct adis *adis, struct iio_d=
ev *indio_dev)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(adis_probe_trigger);

Blank line here would help a tiny bit on readability.

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
> =20
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
>  /**
>   * adis_remove_trigger() - Remove trigger for a adis devices
>   * @adis: The adis device
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index ac7cfd073804..741512b28aaa 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -419,11 +419,15 @@ struct adis_burst {
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
> @@ -432,6 +436,13 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
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
> @@ -443,6 +454,12 @@ static inline void adis_cleanup_buffer_and_trigger(s=
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

