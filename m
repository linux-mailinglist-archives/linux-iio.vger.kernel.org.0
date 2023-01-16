Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502D866BF98
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 14:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjAPNUh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 08:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjAPNUN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 08:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D46A67
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 05:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B4B1B80E80
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 13:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CAFC433EF;
        Mon, 16 Jan 2023 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673875209;
        bh=Ng1gHYZKjsZEvTLzrrnF+gZohXBN1slI9yiqN5tU0TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaADnt2Tav00oWcLvAq/O7gura8ZMPS7a/Lr/0CDefrfvTFFkghnLB7UqeYJwXDWs
         Ajg3N8BWGWmBXDcAUm+1wfXgq8D4eXsRAD5JzwpXy7CUvBWsaC7KmM4y0VpvwVozWu
         9/cn8nXdbp9AIj5fZULc40072NCvM8eKQl/9Adn6ImOqEGho3NYIeOzJgpZibzAB3K
         cZOWTkyQUberlWoUXlQwbbOlS5/dt1ec9SUq2QogMsFPclfjlh26tk8hDvFFBzfJ0J
         d/Um40nOIHLyqTh3O8AqUY5tG9J7l3vpPNyhjy05qfnFIYdK0rEtng+8V6wO2Vd0uA
         sGIwbnk7Car3g==
Date:   Mon, 16 Jan 2023 14:20:05 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     linux-iio@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>
Subject: Re: [PATCH v2 1/2] iio: imu: st_lsm6dsx: fix naming of 'struct
 iio_info' in st_lsm6dsx_shub.c.
Message-ID: <Y8VPBcpihYfEtGVG@lore-desk>
References: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
 <1673874434-30750-2-git-send-email-Philippe.DeMuyter@macq.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cf56BVgJWWLvfPOE"
Content-Disposition: inline
In-Reply-To: <1673874434-30750-2-git-send-email-Philippe.DeMuyter@macq.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Cf56BVgJWWLvfPOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Philippe De Muyter <phdm@macqel.be>
>=20
> We need the name 'st_lsm6dsx_ext_info' for the actual 'iio_chan_spec_ext_=
info'.
> Rename the 'st_lsm6dsx_ext_info' in st_lsm6dsx_shub.c to 'st_lsm6dsx_shub=
_info'.
> For consistency, replace also 'ext' by 'shub' in 'st_lsm6dsx_ext_attribut=
es'
> and 'st_lsm6dsx_ext_attribute_group'.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index f2b64b4956a3..c1b444520d2a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -704,18 +704,18 @@ static ssize_t st_lsm6dsx_shub_scale_avail(struct d=
evice *dev,
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_shub_sampling_freq_avail);
>  static IIO_DEVICE_ATTR(in_scale_available, 0444,
>  		       st_lsm6dsx_shub_scale_avail, NULL, 0);
> -static struct attribute *st_lsm6dsx_ext_attributes[] =3D {
> +static struct attribute *st_lsm6dsx_shub_attributes[] =3D {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_scale_available.dev_attr.attr,
>  	NULL,
>  };
> =20
> -static const struct attribute_group st_lsm6dsx_ext_attribute_group =3D {
> -	.attrs =3D st_lsm6dsx_ext_attributes,
> +static const struct attribute_group st_lsm6dsx_shub_attribute_group =3D {
> +	.attrs =3D st_lsm6dsx_shub_attributes,
>  };
> =20
> -static const struct iio_info st_lsm6dsx_ext_info =3D {
> -	.attrs =3D &st_lsm6dsx_ext_attribute_group,
> +static const struct iio_info st_lsm6dsx_shub_info =3D {
> +	.attrs =3D &st_lsm6dsx_shub_attribute_group,
>  	.read_raw =3D st_lsm6dsx_shub_read_raw,
>  	.write_raw =3D st_lsm6dsx_shub_write_raw,
>  	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> @@ -737,7 +737,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  		return NULL;
> =20
>  	iio_dev->modes =3D INDIO_DIRECT_MODE;
> -	iio_dev->info =3D &st_lsm6dsx_ext_info;
> +	iio_dev->info =3D &st_lsm6dsx_shub_info;
> =20
>  	sensor =3D iio_priv(iio_dev);
>  	sensor->id =3D id;
> --=20
> 2.31.1
>=20

--Cf56BVgJWWLvfPOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8VPBQAKCRA6cBh0uS2t
rNL7AP9k6t2Jx1JNt7Iss5pe3/tRJX6evbQBN9G93dalflnzUQD/bB8eMt5KK+Z6
vyTzChDNLCPxQytBkJ4ioKxrtZUzZQQ=
=4HBV
-----END PGP SIGNATURE-----

--Cf56BVgJWWLvfPOE--
