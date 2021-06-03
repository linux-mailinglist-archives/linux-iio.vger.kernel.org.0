Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA7B39AB20
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCT5k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 15:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCT5j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 15:57:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EB63613D7;
        Thu,  3 Jun 2021 19:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622750154;
        bh=wToVNaalatmvkeF4a0pEx+2+hpUvxECj872XBgCP9ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYedhApN5twPasZy7vPD7LCJhJxr7ZHRHBXadxLjz+5AeHcWcSqwj+NDhz3C4mNcf
         as120QMw/xodKhQReqOOBnxWTP7IBLY0opEnnBEGzTMVSSlfeZlzqSeVfUH1efc8hj
         Geev6IP9x9kc2IRwGHEVYAoggynNx3CFRMhvzqmpAK78cgt/88/WBJhoKOinfOXvUY
         FVIGKlDRVTIwC6BonnXu2JyIQcTpbRdml2AqF3gJHCxltuhxvTZInPsoF1Br132YqH
         3uK6IfLATHVDt2qaZNhWd1vLYTqjD0glTqPsu0igHO0ugloRmxyA9enpeDOhrZHxJX
         IWH+//FcgUETg==
Date:   Thu, 3 Jun 2021 21:55:51 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tom Rix <trix@redhat.com>, Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] i2c: core: Add stub for i2c_verify_client() if
 !CONFIG_I2C
Message-ID: <YLkzx7TD/BFu/CAQ@kunai>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tom Rix <trix@redhat.com>, Sean Nyekjaer <sean@geanix.com>
References: <20210603165835.3594557-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dz+WGjEBIkYe/uPr"
Content-Disposition: inline
In-Reply-To: <20210603165835.3594557-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--dz+WGjEBIkYe/uPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 03, 2021 at 05:58:35PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> If I2C is not compiled, there is no way we should see a call to
> i2c_verify_client() on a device that is an i2c client. As such,
> provide a stub to return NULL to resolve an associated build failure.
>=20
> The build is failing with this link error
> ld: fxls8962af-core.o: in function `fxls8962af_fifo_transfer':
> fxls8962af-core.c: undefined reference to `i2c_verify_client'
>=20
> Reported-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 68068fad0e1c ("iio: accel: fxls8962af: fix errata bug E3 - I2C bur=
st reads")
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> Cc: Wolfram Sang <wsa@kernel.org>

Thanks for doing this!

Acked-by: Wolfram Sang <wsa@kernel.org>


--dz+WGjEBIkYe/uPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmC5M8MACgkQFA3kzBSg
KbYvYg/8CgDrnQbsrXXS+Eo2pyPEnAa26lV+3nalK9Xi66wSndm3ttLbUJgApROS
f+30mhlXngGoXj3l66pPP3kelu3gpYeA+PSkoLcoM+aEY0sOXM4jzW1M98T4yMSS
Tshfyw3LqIzemIJGz7RIQuuqdeQu80qW9DecxgtueuGu5vbHDcqbvsHePc90SUqt
CVmm+P/e7EQx+ePZfR+PVTd1qLAmz2IKemcnHQAR60mqH5J5sSO9tA9OvZS07rmP
zrUuwpMWN/qFEmkUhpg1tdGt3UB1FrzY8pfMI14uBG0FbY9iSWhEwwVcIcC0Er64
ZeLxjAICgpAS4MSQAGnNR7OYtZ2qjB3vuQo/1b4mECYWGF6utWj1If8NYh+uqP73
sjBKepOB1vFHcRfJs+wKd58WlRqs8sED+KOClO/Rs9DERqqZHbhnfXgw0MH9h2cr
WvoK3TA+LHY32I/QsE7RpjM9oQwhEYyK2g5yTIiVKj58ChzE1LQ293PLtqiF1MJU
GDm5GLXF9TPr/gUKlOsU3ftXEAgMh3A8Y64bOc8pdXKvtlkGQ00A09tUz8Z++rqQ
K//a+waeHQ+TjArEMgfNC3CZMUOfD8oZZegp8VjbmzkCXVP9cIUytBs6NJDQgDZE
8QqXOtjy1lfvaR+dT3DgmL7VacMzW5c/nsXlwA0BOn/Wws8294M=
=qY1l
-----END PGP SIGNATURE-----

--dz+WGjEBIkYe/uPr--
