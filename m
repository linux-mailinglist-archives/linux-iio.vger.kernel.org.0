Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21D522EC24
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 14:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgG0M2o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 08:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgG0M2o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 08:28:44 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE1C061794;
        Mon, 27 Jul 2020 05:28:43 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y11so4356580qvl.4;
        Mon, 27 Jul 2020 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3FUvNO9QMUZaqN3Ipima2yOyS4OGa1w1vhSOjtrsS1U=;
        b=DxmNZ/hV1l3c8QXSHzQXkUZb/Z9d8DjaC5EUiIhS2y9OI2/ktcJGAK2KAqBVxQt4p6
         81KhwXm/Vu44aYbx6GkGtJjuqeiXR4AzEQWVeT75oFfLLvGlZUs8JM6AEcghDwd5p9CD
         Zj6MV27gDND0M/j8NLRLnzqLg/bTFdEhaB5kEuXWNBHGa73VPjlsKmUhRROCc0oRoFOk
         ecd4ynSApNINne2CB958m1OApG6aN01iRL2k/o4w/ZU5zBxI7PqVvQw9LCWReT7a/3dU
         86CHsj1nqyNFNRkrIhhuWyyGl5W3/2/v/rOOr5QpBj+sz17OdrBMeG4hBeg3k5DvbhhZ
         NS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3FUvNO9QMUZaqN3Ipima2yOyS4OGa1w1vhSOjtrsS1U=;
        b=Bs1jmqmrLkWi+8+44NCHip1SnRG8xsDhA9xGnG5OkbXRJofHdqr8S3EJCGffxOh/Qv
         TnRC69FYj5lV4sVA38AfmTsijsABavjDdOubDzq6eDiF5JiyjfNi7Y5fyjyouSK+n5OR
         kC7wuJE/3jowB5V33EUmgj2mbQyn9XmKfZfx9oVIM8AsxN7yuvL7i8kwIJr9Pb68hg8t
         J+Fd0MHVTC0a7cVr4p9Uz3MDjcaYW51LQTyn1pkJd7VXrGEYr9H05TARTPNZSJniVVIL
         eS1K4OIEKuNkvX6NRs3yDhMx1z3/MZ/FkgtL38U8iTMEwsrqGJ/pW5OWd+orJJMeDZOo
         OMVg==
X-Gm-Message-State: AOAM530NEQpPKzxETWo7zI5pLBay1MyS5L5CHaPog5SxOsYUnP711W1U
        wBkloSJV545wMIIlZadKdW59f3yoAUE=
X-Google-Smtp-Source: ABdhPJwsgPOCQNSWkS+36B2kABD5Q2ICEbCWIF6UhfzJQDJA1Mn7bb1dc8mUMJFkAgUkEk4CClKRDg==
X-Received: by 2002:a0c:fe91:: with SMTP id d17mr10227579qvs.156.1595852922163;
        Mon, 27 Jul 2020 05:28:42 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id s5sm19024320qke.120.2020.07.27.05.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 05:28:41 -0700 (PDT)
Date:   Mon, 27 Jul 2020 08:28:25 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: check the correct
 variable
Message-ID: <20200727122825.GA5614@shinobu>
References: <20200727112316.GG389488@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20200727112316.GG389488@mwanda>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 02:23:16PM +0300, Dan Carpenter wrote:
> This should be testing "regmap" instead of "priv->regmap".  The
> "priv->regmap" variable is always zero so it's not an error pointer.
>=20
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> The commit 106b104137fd ("counter: Add microchip TCB capture counter")
> doesn't use the correct patch prefix.  This is a common mistake for the
> the first commit which adds the driver.  There is no kernel wide
> standard for patch prefixes so it's difficult for people sending fixes
> to know the correct prefix should be.
>=20
>  drivers/counter/microchip-tcb-capture.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index f7b7743ddb94..b7b252c5addf 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -320,8 +320,8 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  	}
> =20
>  	regmap =3D syscon_node_to_regmap(np->parent);
> -	if (IS_ERR(priv->regmap))
> -		return PTR_ERR(priv->regmap);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> =20
>  	/* max. channels number is 2 when in QDEC mode */
>  	priv->num_channels =3D of_property_count_u32_elems(np, "reg");
> --=20
> 2.27.0
>=20

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8eyEoACgkQhvpINdm7
VJK0WA/+NeMk3F3w6l1WBuWUgdRiZ7HzmFUqDleCv9qgVbPynOPQH7yYrf3TcsBd
8KoRrfJLXGRwlzZr1B9kGGbQF4C9lve8Zt3yzq4nlZkvt0IoKgfIUza0L/1thbmC
cN7YXZQMshUEQd+aMQ2jn0efwxTyN3dPfV97u8nGeiA6ZIdaH8R1c+myrgN/CgXF
+cOiATSqcTr8Zb+1baIaxlI0vIH80/P8Aid47nhe5hzJMUb3ZBuoUTVdZz9f3mXf
Ljx1PlUIr90YtPuQ6x88K/7jGtN3iJg3Y7xl9vkulvJm2ABYGQUaJVjasG+8e5vb
Z2+8eyV6MaL9Hd94yXudmljFdoxF0ecqrc8qJstnD+A9h45+jB3CqLw7HrEYziUn
UMRQefVumrlSxUENNBbW5iHdBZXzsxkNXXJYJbPCE/TEc0Dj4glogqqFsLjOjLw7
zsWSbqmG5Oa8pVFUiRespqL+DIgGDrOMhQ6NJVITLJmI0pkNbPHGSDXBtrVgoT3v
mPjzP5DihRxhLMR0jvX0Zz7M8fhB7G++tBb/RgBG0vfbGBiGgp1e0EB58WbHAuXp
+Ldvsb9HcRftlyHOFygBfrFCRzmAq3V/fPvZOWhqYD2mZDJpG4DbtmC0dc0eKFJ/
oO6tL9pL92d0qikvfC52qBJwEVYmbvFi9HRB+DDegisA/c5YskY=
=sSZ0
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
