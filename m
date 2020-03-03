Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC6178432
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 21:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbgCCUkv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 15:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729681AbgCCUkv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Mar 2020 15:40:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424AF20848;
        Tue,  3 Mar 2020 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583268050;
        bh=a5nfcX73QbvjFRQnPto+rWfMP4FTO3469EjUA9I/mp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ia2LMR4knzbJOc3ZcWX0FULw0WUZiwmQVl/s7npgzxQtU1v279jihV+Zj5rxc9pzC
         2LsNWGuxex++ISzDqTE7/N+qlymnPyYvjauXWaNTmeJoJpIV3P+dIaaMXSrYU+8OHy
         I8cH2JRr/p5OHdJCj9ALgB+chGbj4vqeETLke7Lw=
Date:   Tue, 3 Mar 2020 20:40:41 +0000
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
Subject: Re: [PATCH 2/5] iio: imu: adis: Add irq mask variable
Message-ID: <20200303204041.36a1bc6a@archlinux>
In-Reply-To: <20200225124152.270914-3-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
        <20200225124152.270914-3-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 13:41:49 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> There are some ADIS devices that can configure the data ready pin
> polarity. Hence, we cannot hardcode our IRQ mask as IRQF_TRIGGER_RISING
> since we might want to have it as IRQF_TRIGGER_FALLING.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Missing docs for the addition to struct adis.

Otherwise, looks good to me.

thanks,

Jonathan

> ---
>  drivers/iio/imu/adis_trigger.c | 26 ++++++++++++++++++++++++--
>  include/linux/iio/imu/adis.h   |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigge=
r.c
> index a07dcc365c18..ae5a4f66752f 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -34,6 +34,20 @@ static inline void adis_trigger_setup(struct adis *adi=
s)
>  	iio_trigger_set_drvdata(adis->trig, adis);
>  }
> =20
> +static inline int __adis_validate_irq_mask(struct adis *adis)
> +{
> +	if (!adis->irq_mask) {
> +		adis->irq_mask =3D IRQF_TRIGGER_RISING;
> +		return 0;
> +	} else if (adis->irq_mask !=3D IRQF_TRIGGER_RISING &&
> +		   adis->irq_mask !=3D IRQF_TRIGGER_FALLING) {
> +		dev_err(&adis->spi->dev, "Invalid IRQ mask:%08lx\n",
> +			adis->irq_mask);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>  /**
>   * adis_probe_trigger() - Sets up trigger for a adis device
>   * @adis: The adis device
> @@ -54,9 +68,13 @@ int adis_probe_trigger(struct adis *adis, struct iio_d=
ev *indio_dev)
> =20
>  	adis_trigger_setup(adis);
> =20
> +	ret =3D __adis_validate_irq_mask(adis);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D request_irq(adis->spi->irq,
>  			  &iio_trigger_generic_data_rdy_poll,
> -			  IRQF_TRIGGER_RISING,
> +			  adis->irq_mask,
>  			  indio_dev->name,
>  			  adis->trig);
>  	if (ret)
> @@ -95,9 +113,13 @@ int devm_adis_probe_trigger(struct adis *adis, struct=
 iio_dev *indio_dev)
> =20
>  	adis_trigger_setup(adis);
> =20
> +	ret =3D __adis_validate_irq_mask(adis);
> +	if (ret)
> +		return ret;
> +
>  	ret =3D devm_request_irq(&adis->spi->dev, adis->spi->irq,
>  			       &iio_trigger_generic_data_rdy_poll,
> -			       IRQF_TRIGGER_RISING,
> +			       adis->irq_mask,
>  			       indio_dev->name,
>  			       adis->trig);
>  	if (ret)
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 741512b28aaa..b4c35d137e2a 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -84,6 +84,7 @@ struct adis {
>  	struct spi_message	msg;
>  	struct spi_transfer	*xfer;
>  	unsigned int		current_page;
> +	unsigned long		irq_mask;

This structure has kernel-doc. Please add this new element.

>  	void			*buffer;
> =20
>  	uint8_t			tx[10] ____cacheline_aligned;

