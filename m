Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9FB1E1C8F
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 09:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgEZHzM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 03:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbgEZHzL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 03:55:11 -0400
Received: from localhost (unknown [151.48.148.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E94C20776;
        Tue, 26 May 2020 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590479710;
        bh=y5zNqdCvbDYhOHn9c4krEApadyA5fQ7bXHB4C3ZZTVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvZE0GWWW7muv5o491qRsWNHVscixiC2KFFwMJVrVoF2Jp3d3dCkx8tq5h71egGaN
         k1De12+uvS2hb+qYCRs6r3Yqx9F8y+Xv7ghbR8MKh4fmHW58XSzIoCmBVDa4wwlXOa
         83i6Y8E+Y/kzDmYD8M/Pz/9PcnykC5gOEZZc2m7s=
Date:   Tue, 26 May 2020 09:55:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 04/25] iio:light:st_uvis25 Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200526075505.GB339643@localhost.localdomain>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20200525170628.503283-5-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--gatW/ieO32f1wygP
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
> moving to a suitable structure in the iio_priv()
>=20
> This data is allocated with kzalloc so no data can leak apart
> from previous readings.
>=20
> Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/light/st_uvis25.h      | 5 +++++
>  drivers/iio/light/st_uvis25_core.c | 6 +++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
> index 78bc56aad129..f7027e4c4493 100644
> --- a/drivers/iio/light/st_uvis25.h
> +++ b/drivers/iio/light/st_uvis25.h
> @@ -27,6 +27,11 @@ struct st_uvis25_hw {
>  	struct iio_trigger *trig;
>  	bool enabled;
>  	int irq;
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		u8 chan;
> +		s64 ts;
> +	} scan;
>  };
> =20
>  extern const struct dev_pm_ops st_uvis25_pm_ops;
> diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uv=
is25_core.c
> index d262c254b895..fe1f2dc970c7 100644
> --- a/drivers/iio/light/st_uvis25_core.c
> +++ b/drivers/iio/light/st_uvis25_core.c
> @@ -234,17 +234,17 @@ static const struct iio_buffer_setup_ops st_uvis25_=
buffer_ops =3D {
> =20
>  static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
>  {
> -	u8 buffer[ALIGN(sizeof(u8), sizeof(s64)) + sizeof(s64)];
>  	struct iio_poll_func *pf =3D p;
>  	struct iio_dev *iio_dev =3D pf->indio_dev;
>  	struct st_uvis25_hw *hw =3D iio_priv(iio_dev);
>  	int err;
> =20
> -	err =3D regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, (int *)buffer);
> +	err =3D regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR,
> +			  (unsigned int *)&hw->scan.chan);
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

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXszLVwAKCRA6cBh0uS2t
rIgjAQC88WTIlbVqT8qB/aLsIqQ/BYhT6aVtHV1swz5/tyPgBQD/aJqPEFkDFdwr
bknUEtZftk5Noi56EBeHkpJtwJKe8wA=
=nzck
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
