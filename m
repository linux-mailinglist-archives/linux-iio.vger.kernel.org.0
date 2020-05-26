Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA11E1C89
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 09:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgEZHwh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 03:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgEZHwh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 03:52:37 -0400
Received: from localhost (unknown [151.48.148.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C063420776;
        Tue, 26 May 2020 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590479556;
        bh=AifSerfqz073RNCBrNqnnbcnsc2XfSSlPfQgof4KSyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8fXBdI1RUIH8NDfL3m84zZgEBrAV0IJXbcozZeUuqFkQQDHi7px6uMwPa64jcCOt
         ehMgAlZbTIx1J5jV3vlQvnRwcZpnzE1ShmnicDZrPy7cHL/HBm/d/KB4xRzp8EfRu9
         H/JzgqluLhzcQlJXmJeaENg91pIxC4F1oO6tVWTM=
Date:   Tue, 26 May 2020 09:52:30 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 10/25] iio:humidity:hts221 Fix alignment and data leak
 issues
Message-ID: <20200526075230.GA339643@localhost.localdomain>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-11-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20200525170628.503283-11-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.
> This data is allocated with kzalloc so no data can leak
> apart from previous readings.
>=20
> Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo =
device")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>

Hi Jonathan,

I guess you can drop HTS221_DATA_SIZE now since it seems no longer used.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/humidity/hts221.h        | 5 +++++
>  drivers/iio/humidity/hts221_buffer.c | 9 +++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 7c650df77556..6ad579ca9cef 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -39,6 +39,11 @@ struct hts221_hw {
> =20
>  	bool enabled;
>  	u8 odr;
> +	/* Ensure natural alignment of timestamp */
> +	struct {
> +		__le16 channels[2];
> +		s64 ts;
> +	} scan;
>  };
> =20
>  extern const struct dev_pm_ops hts221_pm_ops;
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/=
hts221_buffer.c
> index 21c6c160462d..59ede9860185 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -160,7 +160,6 @@ static const struct iio_buffer_setup_ops hts221_buffe=
r_ops =3D {
> =20
>  static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
>  {
> -	u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
>  	struct iio_poll_func *pf =3D p;
>  	struct iio_dev *iio_dev =3D pf->indio_dev;
>  	struct hts221_hw *hw =3D iio_priv(iio_dev);
> @@ -170,18 +169,20 @@ static irqreturn_t hts221_buffer_handler_thread(int=
 irq, void *p)
>  	/* humidity data */
>  	ch =3D &iio_dev->channels[HTS221_SENSOR_H];
>  	err =3D regmap_bulk_read(hw->regmap, ch->address,
> -			       buffer, HTS221_DATA_SIZE);
> +			       &hw->scan.channels[0],
> +			       sizeof(hw->scan.channels[0]));
>  	if (err < 0)
>  		goto out;
> =20
>  	/* temperature data */
>  	ch =3D &iio_dev->channels[HTS221_SENSOR_T];
>  	err =3D regmap_bulk_read(hw->regmap, ch->address,
> -			       buffer + HTS221_DATA_SIZE, HTS221_DATA_SIZE);
> +			       &hw->scan.channels[1],
> +			       sizeof(hw->scan.channels[1]));
>  	if (err < 0)
>  		goto out;
> =20
> -	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
> +	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
>  					   iio_get_time_ns(iio_dev));
> =20
>  out:
> --=20
> 2.26.2
>=20

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXszKvAAKCRA6cBh0uS2t
rJ2KAP0cN11RgdgvizvVYCpW+k4beelKu1CQOymmq108Tib0dgD+NjAd2YYUjbf5
0J2ZzjMqHn/GswvdMSTE1bNFrUub4gk=
=pYGL
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
