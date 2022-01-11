Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF348AA79
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jan 2022 10:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbiAKJ1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jan 2022 04:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiAKJ1H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jan 2022 04:27:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176CFC06173F;
        Tue, 11 Jan 2022 01:27:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so4102878pjj.2;
        Tue, 11 Jan 2022 01:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RnrvrJkvlEcIW0KrLo5+Hx92jacwfIHDnl17hEYK+tg=;
        b=nQ7Yg9ndO0zLyaLnODd9RBK60kS5Y/Bm9NG6fjQieH+MMuLGr2lDZPtqc1xSCsfESa
         4PyO4rZF6eFEwSaFWg0h6OynoksFqDJWhmOpSAz5Aybyz/jJgCcgZvzGfc6sr/9+eKZW
         T1B5VhsockOMlrRzXnBKJH2VPAQxiMXAtudrRTKhZiN8hUiCEqDnin+06nXUZkfzvvrg
         Ja7h35GnHIy+LqVBEWwk73oaoexIPJ7lFVHSpj3aT3W2ga9Tybla36cypqIjVANDmzKK
         SOHglkHtsCWzmrxul7YaLRsHNbDvuxtulSw/r0JB2k5XIu+t9EzeomDN0fSSZR3X97+3
         Ge6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RnrvrJkvlEcIW0KrLo5+Hx92jacwfIHDnl17hEYK+tg=;
        b=2gmSZfDaIjXxpMAKCCBod37OLmH6DbZPrOez9PZXnJIrK/FCggTx889fV9w1vG32rX
         VEggxLH2MV9QxeGUqw78VA/OMxVPJJg6Imv2OwOZBEjLEyTY+1Rr7eq0o5r5M2ufap3a
         rWe3+3YsWTIvXUZChvyNd9tAQTtVtZEzVVTgFiH+4uB5pTSy2PY1X4WRxEi2lsjEdA+M
         WvROkPPb+MHrrFsh8Iu6wnq1e6F8n5bbqZcOSaPq+9FvV0Qc3v3H9PHROqLkzPw2zvPF
         Qhpo39PEWJfcf6d1E+FWwIQzv90jgck3XOrIruLYeFLD6ew9s0JAPf4LATDKq2wTsHen
         ySXw==
X-Gm-Message-State: AOAM532Eq/ye27SxFpIm/R3uJUbupy6l+90/orQeqDfVuAcr+7slEkUl
        /wOq85r9NDSVRg6JAnZB/a4=
X-Google-Smtp-Source: ABdhPJxWsrFXNR3dboBCJLCOmXevLXmXsxuz0hahaF1QYANTDFchy3IZXVy9uIP3+MpbwIikvTN5VQ==
X-Received: by 2002:a17:902:aa88:b0:149:1ce6:7509 with SMTP id d8-20020a170902aa8800b001491ce67509mr3477479plr.70.1641893226621;
        Tue, 11 Jan 2022 01:27:06 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id 185sm9383905pfe.26.2022.01.11.01.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 01:27:05 -0800 (PST)
Date:   Tue, 11 Jan 2022 18:27:00 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: fix an IS_ERR() vs NULL bug
Message-ID: <Yd1NZGX99f1VS12P@shinobu>
References: <20220111072500.GI11243@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rU5RcWBW4arINIzg"
Content-Disposition: inline
In-Reply-To: <20220111072500.GI11243@kili>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--rU5RcWBW4arINIzg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 11, 2022 at 10:25:00AM +0300, Dan Carpenter wrote:
> There are 8 callers for devm_counter_alloc() and they all check for NULL
> instead of error pointers.  I think NULL is the better thing to return
> for allocation functions so update counter_alloc() and devm_counter_alloc=
()
> to return NULL instead of error pointers.
>=20
> Fixes: c18e2760308e ("counter: Provide alternative counter registration f=
unctions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hi Dan,

Thank you for catching this bug. I do request a minor adjustment to this
patch for the sake of matching the format of the rest of the code in
this file: please remove the goto err_alloc_ch and simply exit early
with a return NULL.

> ---
>  drivers/counter/counter-core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 7e0957eea094..0abb28cd3d16 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -90,10 +90,8 @@ struct counter_device *counter_alloc(size_t sizeof_pri=
v)
>  	int err;
> =20
>  	ch =3D kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
> -	if (!ch) {
> -		err =3D -ENOMEM;
> +	if (!ch)
>  		goto err_alloc_ch;

So return NULL here.

> -	}
> =20
>  	counter =3D &ch->counter;
>  	dev =3D &counter->dev;
> @@ -125,7 +123,7 @@ struct counter_device *counter_alloc(size_t sizeof_pr=
iv)
>  	kfree(ch);
>  err_alloc_ch:

Remove this label.

Thank you,

William Breathitt Gray

> =20
> -	return ERR_PTR(err);
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(counter_alloc);
> =20
> @@ -208,12 +206,12 @@ struct counter_device *devm_counter_alloc(struct de=
vice *dev, size_t sizeof_priv
>  	int err;
> =20
>  	counter =3D counter_alloc(sizeof_priv);
> -	if (IS_ERR(counter))
> -		return counter;
> +	if (!counter)
> +		return NULL;
> =20
>  	err =3D devm_add_action_or_reset(dev, devm_counter_put, counter);
>  	if (err < 0)
> -		return ERR_PTR(err);
> +		return NULL;
> =20
>  	return counter;
>  }
> --=20
> 2.20.1
>=20

--rU5RcWBW4arINIzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHdTVMACgkQhvpINdm7
VJI1Cw//THPXjHgrq1EgFLuYovdpx1lV21VjJVJa3ejxlvL5eh6rT3B4r2qFbl90
t4KDsI/c2KFOpDQxASi9YbR/Uok4jJEWnwYNWG82CK0kGAssS6PiZ4TyA5NzB+JJ
tPGte/3u53KukNT+t7BNNoh6xPpmB32OmdDDpZNbXhbwz/wWpJA2+j6LqMHXG2ex
crNrJrdt1Kswq7+vKp18htuaHlVHJdlPi01+kH4lKD7PX7sNfd0AnVCZOhJ0WRxi
In/I6OHLum3yr3t18BTpval8aY3eTouxrOfltW9VNvZTcJmGh0gq7n567Sniv855
mIcFNvbvIcIlXbal0lXJwJz3NSQZNNA2mbAmkrkgy5MbMp0qc4JQXNaj6L0DoWZo
ZyBmptweH8ZwduQrJU7fCpxetmGe8FKWTb4+d156d6cPBzRuvfbJnYlZ6Zh8kffr
R4q1roEz3SiIl7ZgwrXAThWhR7TxXepgKe65nYlW1qCmKlBOXqXI8hMIOZKUnAfb
XEYbfq80v670q7zEs26xok1jdtXW8eKa7Q/L0ydr5LoumQp1kNjBEnQen2b+sCt7
kXU+VgYq2XQSwo2HOyRbEjVoZm4WfvKaTogXsPK4GrNntb2sbFKziDPPO8AbrAr9
uwQJKQS586UiUFUU4A78xQUvlzDionj6ech2mVjvrBRGWKxNgQ0=
=EV+i
-----END PGP SIGNATURE-----

--rU5RcWBW4arINIzg--
