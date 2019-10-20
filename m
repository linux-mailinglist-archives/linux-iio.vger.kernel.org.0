Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C1DDE8B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2019 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfJTNG7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Oct 2019 09:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfJTNG7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Oct 2019 09:06:59 -0400
Received: from earth.universe (tmo-104-243.customers.d1-online.com [80.187.104.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 882BE2067B;
        Sun, 20 Oct 2019 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571576817;
        bh=oZ/tCXN46wWDbtlNZpSxk1mF1pRGA4CJ6tTda5S5f6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZunv8JRcySEroBV74Ej9lS+jm593RT4Qj9WgzVynS4yGXGKxBsOXuVeJ7JcDUz42
         Y5hip4NoZhye79laJFxa74aclzZPQk7Ugn6qvo6pxSyWIy/6Dw9J4e+kgePxLjz4j8
         n45s5aQzvnzEHNgBDFI23l5ZbQeZSLUqw9lEbkik=
Received: by earth.universe (Postfix, from userid 1000)
        id B87003C09B1; Sun, 20 Oct 2019 15:06:44 +0200 (CEST)
Date:   Sun, 20 Oct 2019 15:06:44 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: tsl4030: Use false / true instead of 0 / 1
 with booleans
Message-ID: <20191020130644.jyd3zdnmxcgksdbs@earth.universe>
References: <20191013163754.2044672-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mje3bmkeypnnqewu"
Content-Disposition: inline
In-Reply-To: <20191013163754.2044672-1-jic23@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--mje3bmkeypnnqewu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 13, 2019 at 05:37:54PM +0100, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Suggestion from coccinelle / coccicheck
>=20
> CHECK   drivers/iio/adc/twl4030-madc.c
> drivers/iio/adc/twl4030-madc.c:524:6-15: WARNING: Comparison of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:655:1-43: WARNING: Assignment of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:659:2-44: WARNING: Assignment of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:664:1-43: WARNING: Assignment of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:498:2-34: WARNING: Assignment of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:510:2-19: WARNING: Assignment of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:511:2-11: WARNING: Assignment of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:531:2-19: WARNING: Assignment of 0/1 to bo=
ol variable
> drivers/iio/adc/twl4030-madc.c:532:2-11: WARNING: Assignment of 0/1 to bo=
ol variable
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> ---

Apart from the typo in the patch subject (tsl4030 vs twl4030):

Reviewed-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/iio/adc/twl4030-madc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-mad=
c.c
> index 55c5119fe575..472b08f37fea 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -495,7 +495,7 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(=
int irq, void *_madc)
>  		ret =3D twl4030_madc_disable_irq(madc, i);
>  		if (ret < 0)
>  			dev_dbg(madc->dev, "Disable interrupt failed %d\n", i);
> -		madc->requests[i].result_pending =3D 1;
> +		madc->requests[i].result_pending =3D true;
>  	}
>  	for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>  		r =3D &madc->requests[i];
> @@ -507,8 +507,8 @@ static irqreturn_t twl4030_madc_threaded_irq_handler(=
int irq, void *_madc)
>  		len =3D twl4030_madc_read_channels(madc, method->rbase,
>  						 r->channels, r->rbuf, r->raw);
>  		/* Free request */
> -		r->result_pending =3D 0;
> -		r->active =3D 0;
> +		r->result_pending =3D false;
> +		r->active =3D false;
>  	}
>  	mutex_unlock(&madc->lock);
> =20
> @@ -521,15 +521,15 @@ static irqreturn_t twl4030_madc_threaded_irq_handle=
r(int irq, void *_madc)
>  	 */
>  	for (i =3D 0; i < TWL4030_MADC_NUM_METHODS; i++) {
>  		r =3D &madc->requests[i];
> -		if (r->active =3D=3D 0)
> +		if (!r->active)
>  			continue;
>  		method =3D &twl4030_conversion_methods[r->method];
>  		/* Read results */
>  		len =3D twl4030_madc_read_channels(madc, method->rbase,
>  						 r->channels, r->rbuf, r->raw);
>  		/* Free request */
> -		r->result_pending =3D 0;
> -		r->active =3D 0;
> +		r->result_pending =3D false;
> +		r->active =3D false;
>  	}
>  	mutex_unlock(&madc->lock);
> =20
> @@ -652,16 +652,16 @@ static int twl4030_madc_conversion(struct twl4030_m=
adc_request *req)
>  	ret =3D twl4030_madc_start_conversion(twl4030_madc, req->method);
>  	if (ret < 0)
>  		goto out;
> -	twl4030_madc->requests[req->method].active =3D 1;
> +	twl4030_madc->requests[req->method].active =3D true;
>  	/* Wait until conversion is ready (ctrl register returns EOC) */
>  	ret =3D twl4030_madc_wait_conversion_ready(twl4030_madc, 5, method->ctr=
l);
>  	if (ret) {
> -		twl4030_madc->requests[req->method].active =3D 0;
> +		twl4030_madc->requests[req->method].active =3D false;
>  		goto out;
>  	}
>  	ret =3D twl4030_madc_read_channels(twl4030_madc, method->rbase,
>  					 req->channels, req->rbuf, req->raw);
> -	twl4030_madc->requests[req->method].active =3D 0;
> +	twl4030_madc->requests[req->method].active =3D false;
> =20
>  out:
>  	mutex_unlock(&twl4030_madc->lock);
> --=20
> 2.23.0
>=20

--mje3bmkeypnnqewu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2sW+QACgkQ2O7X88g7
+pqAQg/+OeRYrBeUhvITIH3Pv2Wc15lCezURU7zX+qvMCPJ5vzWauViU1XNOvtWJ
OYrWjaTsG9SXgTlT+4NSEYpGs4kDJWH4cxJmZ4Bi99tu+TKJtrwWqFN86OmBNHvd
skVThhrUtolP87A7NV4msqXrRD5W/ZN/TDoGzRnwujkqmIXKCyeZZyNDYesyXF8I
Qy6W+73gSeNcN/CMiI3OmL17wjMtz7TbrENZVSWsprFkJCVvTbfReMlexJtKJukd
3zggg+VcfoHxp4buATfcqX15+wFjxdbwZIukBXqWQrq/ZNisFZpEUzq9T7cWfeCa
GRz4jradz4rZI3QvMm2/914DfcMErcaMoL/1MAG2WziUim3VYuwauEbATE58YbsE
Er9iDv+amI6DPoNY9u+izXqgICEfnSLrHjoaqgzKtXAPnoook6fOFel4hqYEvg2Y
mx6HevX3zadfwVyyj9EGuqsYSWJyGRiZ9GBtOOk1437I9u/adlM/Q70usnPHkvt8
Jd+x9CkOll9aAEipYQsbvsaPILDjImCqHCoa987L6wsJHu45bWXGxYhjHkO8em+t
CR7GbOskOk7NZHyNw4ZmEQHTd6wacIpgShAqagAufhfyeERWD/9oi8Cv1w4s9i5E
eSmUlYW6eylOpSM2pecw9b0URMwW5j5awdqQ6TKy1eIvLFlh5KU=
=Kcqr
-----END PGP SIGNATURE-----

--mje3bmkeypnnqewu--
