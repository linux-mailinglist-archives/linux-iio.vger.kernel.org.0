Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36391183520
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 16:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCLPkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 11:40:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36522 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCLPkR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 11:40:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so4702710qtb.3;
        Thu, 12 Mar 2020 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qRfo0Jsmmm4U/AhlW7P8NwoHLU4zuGZhE4eLNUQ2+QI=;
        b=bjKtfUCHe7SshAJRfRiHKJiAOfWCuYds+BUm2Ic7P4PVr5vYd9Rfa+cckPqDCC55+t
         yD6FJBJQGxVdDsr6mWvB+jCljsNaGyJiaiUqfAcvSKwn4RTUKiRjl+2D0kUjaSZYZ/XY
         zVZJ3Uc9oi0ZS4ATivBPNftm6zmtD5s5kjajFlUfOdy7PQrQMgGKmW6ZvrTjRCiXOinL
         YQPjJ5mN+yo8u+2bMHHlH82i8vT5gLndH2JADfxHybOavy5KLgWCeegi49dDuXqxVpWB
         3zovnESyVUNyTYwiZHhbez7gDkl8Yy8lFKI4QLGkPa2TFmA2VluQUaqD3AQSWwWBySja
         OVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRfo0Jsmmm4U/AhlW7P8NwoHLU4zuGZhE4eLNUQ2+QI=;
        b=JVeySvgZZ9bWW25ThEEhTktpnKX9x+tdBbuVW6xhifVAadIQlunMOfdUkgTJAetx2r
         Gr24XRKOU+aJX7Flaff/3td0tx8iSJJMxmNI8Z59yp0VfRFM1lsE/ZRyIRMKcqH8DSGy
         7HX0XueMe6EyPawnmPdxukThPr3ReX0STHkXMJARdtIBdvgAvfm7Ku97N1TwkEQR4pFF
         smFQ+oT8Slbvt4lih9kT/Gvm5FxhG+83X5xWWSdnBzvHFTS2+IrnGvu5FZFurWm7QVw/
         iRuA+6WuutXmoeWbyVbnk8ibMcdTlZg7xcppQrFb5Zu4rXsYRxUVKscK3FdC2J3BN5EP
         vOpw==
X-Gm-Message-State: ANhLgQ12KYteB8STBvarPonsmuU1pVcFqpT74huvRGs3H/kA2t7LWN6b
        so2pA8idKc+N/PGvIPpH3s0=
X-Google-Smtp-Source: ADFU+vuALdIRhw3biMmdUsl4H0a9RZFcaeD0dOk9rZJZpV9ei6j1RatB2nqDB4oeJ3UmG5ksN9LQAA==
X-Received: by 2002:aed:23aa:: with SMTP id j39mr7813677qtc.42.1584027615696;
        Thu, 12 Mar 2020 08:40:15 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id m92sm1254388qtd.94.2020.03.12.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:40:14 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:40:12 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] counter: 104-quad-8: Add lock guards for filter
 clock prescaler
Message-ID: <20200312154012.GC3250@icarus>
References: <20200312112552.GA32509@syed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20200312112552.GA32509@syed>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 04:55:52PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions in the 104-quad-8 counter
> driver for filter clock prescaler related changes. There is no IRQ
> handling so used spin_lock calls for protection.
>=20
> Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock
> Prescaler")
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
>=20
> Split the patch from generic interface and differential encoder cable
> status changes. Also, include more code statements for protection using
> spin_lock calls and remove protection from few code statements which are
> unnecessary.
> ---

Hello Syed,

Remove the review comments from the commit message and I think this
patch is all right. You can also extend the Fixes line so that it
doesn't wrap around. Add the following Signed-off-by line underneath
yours and it'll remind me that I've already reviewed this patch when you
submit v4 of your patchset:

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Thank you,

William Breathitt Gray

>  drivers/counter/104-quad-8.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9dab190..58615e4 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -1230,6 +1230,8 @@ static ssize_t quad8_signal_fck_prescaler_write(str=
uct counter_device *counter,
>  	if (ret)
>  		return ret;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->fck_prescaler[channel_id] =3D prescaler;
> =20
>  	/* Reset Byte Pointer */
> @@ -1240,6 +1242,8 @@ static ssize_t quad8_signal_fck_prescaler_write(str=
uct counter_device *counter,
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
>  	     base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> --=20
> 2.7.4
>=20

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5qV9wACgkQhvpINdm7
VJJBLRAA4oZHQ9p7kGoPTgepRi+sfHPlW3qm1lBDpWC5bo41G/pPHv3zy3p2/t6b
AKKX4/+mE0M43M3APYnYD0tkzl8ZuT29lrnNyOHXink235ljEgysOYeynr+6Ju9n
Guo7v40BLF+IamooDvrJYIZiwRkcPocV9K7CUAEHz61PDGHqkPvItnf8hzwh1TFa
5JBkL3uufkMiH1SRvfx1eyGqphToHZH/Eu+2FalWfKyp2fueUmwohmqh6Ju6cP4p
vAgRs3R7XNmEjRAjV2iGYF4kkcfOy5kMEhSHMzXZQVcQvJ2ENOAiU2VIyifRAhSy
ZMCGBYxUjIl4n72+hDXoL+WyegKI/wOpYqseNV6xKfxUU8asaclaZIGclXWTWqz7
kkbehOjVppgxRHdFjfmjBnZh5uYQVYCNt/pZFy8Hqrd2h/JMXc39DPGTxZi0p47p
7Apl1oWC/nuRHy0Irx8jJk/juw1xhOxRTcZmlrqeMTKsQKQn1IAVC9Y1vTdEWQDS
pbnMORAdzQFUzqs+vtlDOXOipmATgpURIL96Dh5z84qRM4pTm2uvkhQ7ypsVY7nS
coOJIX0xMwDZVdhHqd540hClHYbJgqCt/59CiqcHS0LWCKv+OHOgJU9WP5HzioUs
kEjK9qre3JFwlgb5NyZ9nzZfT1FuNCzvpaaD/CU5wZFE2xBl8ys=
=cfwF
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
