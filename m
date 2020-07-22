Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F13229CAC
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgGVQCv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 12:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbgGVQCv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 12:02:51 -0400
Received: from localhost (unknown [151.48.143.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5114C206F5;
        Wed, 22 Jul 2020 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433770;
        bh=OBHMa7hEjMECkX5im4KqdNjDzFOzLO5IlPF9IrRd1N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFr/j+ZbLSvN8NyslzAQjWlHO/5yydzgbEGH8J0PZSdBvpOIX7Z5TFeDs6mehTawp
         gx2UyiR2KnFdPQsk0m2iYFKnnFd8qXjMUx9prXH/TtdCSzy2DZhfK074fwa0218Ly6
         DWBPhzro35a/FPP33WyukoGirASp8k40SA7qlyXM=
Date:   Wed, 22 Jul 2020 18:02:45 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 19/32] iio:imu:st_lsm6dsx Fix alignment and data leak
 issues
Message-ID: <20200722160245.GA449019@lore-desk>
References: <20200607155408.958437-1-jic23@kernel.org>
 <20200607155408.958437-20-jic23@kernel.org>
 <20200607223351.GB893522@lore-desk.lan>
 <20200722160805.2910297e@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20200722160805.2910297e@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > here we can use hw->scan[0] and drop the array on the stack
>=20
> This gets trickier because the scan can have other types of data in it.
> The timestamp doesn't match with our carefully created structure for scan=
[].
>=20
> Hence I'd rather leave this one be, or define another structure to
> accommodate it.

Hi Jonathan,

ack, I am fine with it.

Regards,
Lorenzo

>=20
> Jonathan
>=20
> >=20
> > > +	u8 tag;
> > >  	bool reset_ts =3D false;
> > >  	int i, err, read_len;
> > >  	__le16 fifo_status;
> > > --=20
> > > 2.26.2
> > >  =20
>=20

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXxhjIgAKCRA6cBh0uS2t
rANRAPsGXcYepjJyHH6nF4XE8moC/tkbNXxrt0ji5mXyKtXMawEA9en0QFrtwrzO
1fn0UpVel8ggUu19fv0BUCfrH8oFxwI=
=CKhA
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
