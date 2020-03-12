Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A618350A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCLPez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 11:34:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41215 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgCLPez (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 11:34:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id b5so6866944qkh.8;
        Thu, 12 Mar 2020 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cXPkAifA9bHCf5i5mFzjLkwktF2MjYwgFBBl0o0owh4=;
        b=ZNsh/dlPYQECqvU/01CkKqQ1JCaio3L5WJ1N+HBwKyJIHJV1Lvqzo1K9xw5QbJvaBA
         t7QXoYPx/74pr24bN2usdLaWP8bi7ezv2bIxQxEwyxPHva+VJjI1/iQcf/6qlP8BjaIk
         hMEd/KVCqtFYsOjg7LqigAPY5+JdWaO1y/+ul8M5+/WXsbg1H6JXyOerYKqeOcW908XS
         CqQ07B+yFS6dkCjbgENxUTHR2ObcSLHkhUkhNgMlinORDokvm50mLRnp+yRUDbMX05Oo
         MDMxNJCKaUTKmEK48zFamsWPxa4nsfrdakXQsg4m89CrfeB9se0lZzWOZ3ufd34B+rRi
         putw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cXPkAifA9bHCf5i5mFzjLkwktF2MjYwgFBBl0o0owh4=;
        b=Ew5m3PCQHMkZZidz/He+EWKzggNjvvaqP8cG1rSda39vxfWzd3kptfzIbMnnVxY+g9
         /rYj8rWajTcfUL5weuzMoJt/sWDN7EE0nzGK25qQKHCkhrP5LxmqQ8p0Ag9aIZNz/PuC
         1ViDjlj97zyMUl/yyrmixBWUK8KLV3xhgjKSH1nWjdmYttQVU3mB1bXHceRaGnmM+XCP
         PXL+SnvUFDcRNZryaUWsoIgDvkdZ2yspdkQf8ku7vRD6VZHoCvCuTvCpZZqi9zXebcc/
         KO4DJ2ai8AF+GhK7+shqdQze7O5OR+8q5hm8/ES2/jp/TN+eRtA13nOTyBBY+aQdRvM+
         6D7A==
X-Gm-Message-State: ANhLgQ1SVhS/+N4yTjKuJygd3+CAv7zzLVoJgT+GJQ6iziqjMWn1eNw9
        uUrYaX6ithgEf3rZGIsYKfg=
X-Google-Smtp-Source: ADFU+vuJx50U1pclvEz7bqtZ6Jdg/uO1jKtzO2bzPAA4TOZ0qWa2qFSvulg+XPo5rDrNAxXye/ACZw==
X-Received: by 2002:a37:d13:: with SMTP id 19mr7847195qkn.404.1584027294205;
        Thu, 12 Mar 2020 08:34:54 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id o57sm7746602qtf.42.2020.03.12.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:34:52 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:34:50 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] counter: 104-quad-8: Add lock guards -
 differential encoder cable
Message-ID: <20200312153450.GB3250@icarus>
References: <20200312112517.GA32485@syed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20200312112517.GA32485@syed>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 04:55:17PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions in the 104-quad-8 counter
> driver for differential encoder cable status changes. There is no IRQ
> handling so spin_lock calls are used for protection.
>=20
> Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential Encoder
> Cable Status")
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
>=20
> Split the patch from generic driver interface and clock prescaler
> related code changes. Also, include more code statements for protection
> using spin_lock calls and remove protection from few code statements as
> they are unnecessary.
> ---

Hello Syed,

Just like in the first patch, move these comments below the "---" line.

>  drivers/counter/104-quad-8.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9dab190..1ce9660 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1153,16 +1153,22 @@ static ssize_t quad8_signal_cable_fault_read(stru=
ct counter_device *counter,
>  {
>  	const struct quad8_iio *const priv =3D counter->priv;
>  	const size_t channel_id =3D signal->id / 2;
> -	const bool disabled =3D !(priv->cable_fault_enable & BIT(channel_id));
> +	bool disabled;
>  	unsigned int status;
>  	unsigned int fault;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);

You can redeclare priv whenever you need to avoid these casts:

	struct quad8_iio *const priv =3D counter->priv;
	...
	spin_lock(&priv->lock);
	...
	spin_unlock(&priv->lock);

> +
> +	disabled =3D !(priv->cable_fault_enable & BIT(channel_id));
> +
>  	if (disabled)
>  		return -EINVAL;

This return statement can cause a deadlock. You can avoid that by
calling spin_unlock before the return:

	if (disabled) {
		spin_unlock(&priv->lock);
		return -EINVAL;
	}

Sincerely,

William Breathitt Gray

> =20
>  	/* Logic 0 =3D cable fault */
>  	status =3D inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* Mask respective channel and invert logic */
>  	fault =3D !(status & BIT(channel_id));
> =20
> @@ -1194,6 +1200,8 @@ static ssize_t quad8_signal_cable_fault_enable_writ=
e(
>  	if (ret)
>  		return ret;
> =20
> +	spin_lock(&priv->lock);
> +
>  	if (enable)
>  		priv->cable_fault_enable |=3D BIT(channel_id);
>  	else
> @@ -1204,6 +1212,8 @@ static ssize_t quad8_signal_cable_fault_enable_writ=
e(
> =20
>  	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> --=20
> 2.7.4
>=20

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5qVpkACgkQhvpINdm7
VJIXthAAxkrUmI+zv3FV4D2drUuXL2eSlo+MFgNmnsL+6QhDTMhZPLUWExwQ+0qe
rMSIvWwfK98TEWgHYKWaGhjH+vJe1AYKyZcHYPJ88265nkdrFfUPgoZdzrrN5Lz+
/P75CF24KwRlXs+PwETxpLq+FdKJRgmNg9kFw6MaqccfphJ8YJO/VxPlBuzxMHe9
Ktv9wFOq/VLtlOKLiYgNwRjDBaddUzsGtz+NqegXQFCUWaqBWNA0NQBimw9hLr5u
XIbb5wSlVumt7DtLihlutJLMVi6W37b4Nks6NX6b8L91tvagMUFYXEOwMVGatkwD
Le7fxWzEtUTnDxHOsRryvjoyTmYKqANwpxNFWBlwFCIE1JpykrDQIvv5HKhEbXv7
SHg569ZmWZ37WTh7RVKolsuI/LEolhBFpBC0TdbvAG93PxhYR+i218EZJx6wUvHg
A4fbxOEBDvR2K7r/5UJQZkaET3eWxwePZPGUfQkeCGmjaDiQjg259RlumnwZu3ok
istabnTZYqou02V83ud2JyiQDJgduWIpaKfu6APUfVfV4xFn3ObuKUaqkOXwm/Sy
UOdDlXFbuUmJM1npnAFE58IoCdpUm8vq7HjqWlPLCD65fwMKRy9kmm/EgKwoHY40
VC48mQNqLLf7DBwdgRrfim5QmQJq+SzTOcYSjuDFU23119x1Dfs=
=5G6p
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
