Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843A7413DB9
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 00:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhIUWxT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 18:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhIUWxT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 18:53:19 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB2C061574;
        Tue, 21 Sep 2021 15:51:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w8so609896pgf.5;
        Tue, 21 Sep 2021 15:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h2gJkMznnqLd0f275Uxw8g80e9XhRkNfCJioibCTvdk=;
        b=P6b3nH0kQ9tt/5pXMy8BamVhnNQysrMOTir+ZsZb1vz22oj/kaB8Zgxot3PDcg5/l+
         FpP443q0Nt8o4W+5yn5cgYPf5i/XGXIlbn5jyrKk9p5sC5dBd9WBQhn2hYh7vLDH2ZGU
         tZo6skM82sW8rQPIkjOXqc8v1KmE+r2eFbhMLXXUFJymPdE00tZWHvVi8b1JcrzvjHpL
         H9VuutQE5JYcdhkgZ3mrjHoyhS6b5RCyuWZVA7YpTXPldQ8Dttik6GDnjqbYMWsFD8iT
         i7kodXAonlOEX/zBa4ap9WrETIOKLyAYYzyZCgQShtm3UFn2foiZ2Xb82mQTGn22ojnC
         gvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h2gJkMznnqLd0f275Uxw8g80e9XhRkNfCJioibCTvdk=;
        b=MBKaOUfkuLeGvn/PFVe5f8iW6pLUt9C9XZGpqxn6rYQV8OBUKHSbAjF1F+PWtpmAd3
         pEedX8xQhyFiarYYLx0j2C/TXXZ30mTY07aehWrhr4wnw4lmIE1/7tQjXQO7GSSIWvYv
         r3oq+ZFNBm1uldqjqnTrzWE6Obq4wQhv9yQZKA4t1W1Qklt+qkZLvJZCp9+hKQUP/QaL
         v572r92s+2EsUSQzWl55uJD6x8TK9IOd1dn1ved9eBBy3cXr6qn8fmeiZwGCtoNx5mPe
         XWeOBrwgteiP1JKTJAwhCSdMECcg7pX07sumttHniCA8Sf56Bc/4JzMDmya1xgMa50dg
         AFQg==
X-Gm-Message-State: AOAM531Ca6naIm47VpFiiDj7t0mQwMUXspsDhdvh46abs1d95yn/ptYD
        bGVcoHJrytsuZCiSjarkMitqRbNR2C8=
X-Google-Smtp-Source: ABdhPJw1lu3BRdyyMsZL9sqwjLiGh2sfa87bthmMAD3D+B6UgiBsaFdLiyBTn+FHowwVCAmXmpxc/A==
X-Received: by 2002:a63:4a18:: with SMTP id x24mr30009819pga.209.1632264709849;
        Tue, 21 Sep 2021 15:51:49 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id c12sm167350pfc.161.2021.09.21.15.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:51:49 -0700 (PDT)
Date:   Wed, 22 Sep 2021 07:51:45 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Tim Gardner <tim.gardner@canonical.com>
Cc:     linux-iio@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3][next] counter: Add default statement to switch() in
 quad8_function_read()
Message-ID: <YUpiAcEKGyS5z6+t@shinobu>
References: <YUkpBU8mN4yrDfu5@shinobu>
 <20210921133749.15461-1-tim.gardner@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytAU70V02QRLitKB"
Content-Disposition: inline
In-Reply-To: <20210921133749.15461-1-tim.gardner@canonical.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ytAU70V02QRLitKB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2021 at 07:37:49AM -0600, Tim Gardner wrote:
> Coverity complains of a possible use of an uninitialized variable in
> quad8_action_read().
>=20
> CID 119643 (#1 of 1): Uninitialized scalar variable (UNINIT)
> 4. uninit_use: Using uninitialized value function.
> 346        switch (function) {
>=20
> The call to quad8_function_read() could theoretically return without assi=
gning
> a value to '*function', thus causing the use of an ininitialized variable
> 'function' in quad8_action_read().
>=20
> Fix this by adding a default statement to the switch in quad8_function_re=
ad()
> and setting a return error code.
>=20
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

Thank you for noticing the mutex. Although this case is simple, I'd
still prefer for this function to return early when an error is found
rather than hold a return value until the end. Please adjust the default
case to unlock the mutex directly and return immediately with -EINVAL.
With that change feel free to add my Ack-by line:

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> v2 - Add the correct Cc's
> v3 - Add comment to the default switch statement. Also noticed v2 would h=
ave
>      returned with a lock held. Fix that by returning a variable return c=
ode.
> ---
>  drivers/counter/104-quad-8.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index c587f295d720..7faca6b760e7 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -201,6 +201,7 @@ static int quad8_function_read(struct counter_device =
*counter,
>  {
>  	struct quad8 *const priv =3D counter->priv;
>  	const int id =3D count->id;
> +	int ret =3D 0;
> =20
>  	mutex_lock(&priv->lock);
> =20
> @@ -215,13 +216,16 @@ static int quad8_function_read(struct counter_devic=
e *counter,
>  		case 2:
>  			*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
>  			break;
> +		default:
> +			/* should never reach this path */
> +			ret =3D -EINVAL;
>  		}
>  	else
>  		*function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
> =20
>  	mutex_unlock(&priv->lock);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int quad8_function_write(struct counter_device *counter,
> --=20
> 2.33.0
>=20

--ytAU70V02QRLitKB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFKYfcACgkQhvpINdm7
VJJZrRAA60Ff+szRe99ZKTDxt0AcZNihM7K886lJg4m70pR5SvwXYOhtNIwy2UmN
ICNmtQ9QJutArvLmsjmO4jd3JhSulI9t5YQ5ckhZ86fZXCWJNdEClpp/5ZB0SZDg
oAgP81hUdSstCHRCOm9VEthgHWLRpGz3rmk08cCBsj+ApvRwWt/1fb4zrOhb7cH6
Rr9pn8onvb87okFNOzRZGKcAAZvQCv76DQBOdDDS5+ZuTXzUJTnCEaoNieI2MV/m
VJ1FuTEDWhMY7mqQ+ZOw5ZGpecyzBzGinwXtTjZdPuFRWWDJ2Eb7vNvZYjv2s+yV
76Mxe1wICz+f+h2Ac/5Mbl55G7IXZ3ADeovQ3F1pJNzbZanPPfJwNcAOtq3MlaIl
1E/A0vOJNPO0QcRWwZmCM3bjah5VyShE2VSLZA8+OpedA4EwwaH+U6Cf/4HAkfL8
tmVbiXVDHkdo/sLDQIoBQXPwRln0uA6f/I3G/glFoxLbR7UW8Cnw/RVbr+xUL7gy
aA4YCacFtO/nM858Qngqcd1eP3sXQp7I8pK0qGwmlQxKFRX+f+arvx+ZLBlGeRSV
OK6xSkZKYMLcn5ZQO9MCVswEEBpZQ3tq2diTsB8F6Y56i3/AwTtV/iQ0u4UCN1bq
Us3Ub9CNV9qBNBsOz6qsTqq7BvFEADcASeEwnYkVTLa1eyHwgEI=
=h4Fv
-----END PGP SIGNATURE-----

--ytAU70V02QRLitKB--
