Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88BD23FF8D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHIRie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgHIRie (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:38:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B514206C0;
        Sun,  9 Aug 2020 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596994713;
        bh=t3aXDjPFkS5flTgLCGZ6PWJVub//2txcZuljs3Dr98w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b1uz4IrfpvTx9hmC0oOPOMz4iCQObmkaN4aLA4MUkERwHkLqq1alfWgE1IVpEmwWq
         xxCZ4uXk2X4jyRlWS/MgST5lvGxWX0iYxSLKHSVgWulwCIKiDGxxnJGZrq/owu67IW
         DjxpW4jA0mWbqqvBF10tLsPDRivq/Y3sabLw3giA=
Date:   Sun, 9 Aug 2020 18:38:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH v3 26/27] iio:adc:ina2xx Fix timestamp alignment issue.
Message-ID: <20200809183829.63f673d3@archlinux>
In-Reply-To: <20200722155103.979802-27-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-27-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:51:02 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 32 byte array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak apart from previous readings. The explicit alignment
> isn't technically needed here, but it reduced fragility and avoids
> cut and paste into drivers where it will be needed.
>=20
> If we want this in older stables will need manual backport due to
> driver reworks.
>=20
> Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monito=
rs")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>
> Cc: Marc Titinger <mtitinger@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ina2xx-adc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 5ed63e874292..b573ec60a8b8 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -146,6 +146,11 @@ struct ina2xx_chip_info {
>  	int range_vbus; /* Bus voltage maximum in V */
>  	int pga_gain_vshunt; /* Shunt voltage PGA gain */
>  	bool allow_async_readout;
> +	/* data buffer needs space for channel data and timestamp */
> +	struct {
> +		u16 chan[4];
> +		u64 ts __aligned(8);
> +	} scan;
>  };
> =20
>  static const struct ina2xx_config ina2xx_config[] =3D {
> @@ -738,8 +743,6 @@ static int ina2xx_conversion_ready(struct iio_dev *in=
dio_dev)
>  static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  {
>  	struct ina2xx_chip_info *chip =3D iio_priv(indio_dev);
> -	/* data buffer needs space for channel data and timestap */
> -	unsigned short data[4 + sizeof(s64)/sizeof(short)];
>  	int bit, ret, i =3D 0;
>  	s64 time;
> =20
> @@ -758,10 +761,10 @@ static int ina2xx_work_buffer(struct iio_dev *indio=
_dev)
>  		if (ret < 0)
>  			return ret;
> =20
> -		data[i++] =3D val;
> +		chip->scan.chan[i++] =3D val;
>  	}
> =20
> -	iio_push_to_buffers_with_timestamp(indio_dev, data, time);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &chip->scan, time);
> =20
>  	return 0;
>  };

