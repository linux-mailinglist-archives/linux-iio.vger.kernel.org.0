Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E37A69BC2
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 21:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfGOT4F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 15:56:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45375 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbfGOT4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jul 2019 15:56:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so8203723pgp.12
        for <linux-iio@vger.kernel.org>; Mon, 15 Jul 2019 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LcjZDPgdL7DrGBvMmJVL7aqjwkNf4gUG0/jK3NFbFQU=;
        b=hrf+T3xib0rwcl64f3eIU+EwrwfrXUdPQ26av7rw/B4o18aGkqFo6P01Iofzv92Mpc
         OQrSZ8JoDrEcf9yyDqvPS7vCZY8J8b33Fr3K6WW9GMF+DC9uVHy+2HFlBuzSTjEkA5Jr
         vc7SiXyV7bLfQ1MSgA0w5g8PEK4KpdsZgP7RpOzjcaIc+Lkr5WHyYJnlbAQLKBVSklY0
         qO4rOrNL4eAi2YZTbdrmLj0aNZmY9QiJnPJQ718NoAeMh/zSaeslzjjD6x9qA77pSbEu
         7sW3stgc1yfa1PUQAZuqVpiUWO9X1jSb3oZWnK9o62qaKIjJmPbY2WsIEcvihUIjfPm2
         NtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LcjZDPgdL7DrGBvMmJVL7aqjwkNf4gUG0/jK3NFbFQU=;
        b=DJe9oIBNQtpFy/UTb6DT3NdMb9dlgVLd6TYGLpGIwpPYZdxGsSxT40xYLm6LpU79dZ
         DtRvG/LDEaPmK9Xu4X8XgIGv8SpqlstKrddWiDTDK44nQQBlqduts9eOskmgPP3PfsNT
         pKvpwn/N4ejSMXOmJCoc79KA6FmzafVGGer/TKyyUMxIY3UOYAMmpOU04AZ613l9wKgV
         jOJbjurFFMiwwmY6LfTUsewjyKk0Eyr0d2r2NmfGwM2w7M1PkF45f60k0bMBapoUepOT
         W8C8V4IsY//ioTOe+B7f5PORXhsg0wkAZKqmef4wRcZvWYe9gjlukY3fx5CZY7wCFbFG
         lUhA==
X-Gm-Message-State: APjAAAWx6tqk9spHS+in507A+x66clQXzlbUmLjzbDhIKV3xkeuMAbX3
        Mj5F9gd37BHFx96V2bmVhmPl4Q==
X-Google-Smtp-Source: APXvYqxB9Cq3Zi+SN8ixEnppL8O5MrNd4YnvwkmIbrtsv5YUv51Z4sqECdVIJlbifY1uB8cDY1vtBg==
X-Received: by 2002:a63:f118:: with SMTP id f24mr29576121pgi.322.1563220563511;
        Mon, 15 Jul 2019 12:56:03 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id i6sm18347978pgi.40.2019.07.15.12.56.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 12:56:02 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:55:57 -0700
From:   Benson Leung <bleung@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Always release lock when
 returning from _read()
Message-ID: <20190715195557.GA29926@google.com>
References: <20190715191017.98488-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20190715191017.98488-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Mon, Jul 15, 2019 at 12:10:17PM -0700, Matthias Kaehlcke wrote:
> Before doing any actual work cros_ec_accel_legacy_read() acquires
> a mutex, which is released at the end of the function. However for
> 'calibbias' channels the function returns directly, without releasing
> the lock. The next attempt to acquire the lock blocks forever. Instead
> of an explicit return statement use the common return path, which
> releases the lock.
>=20
> Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel=
/cros_ec_accel_legacy.c
> index 46bb2e421bb9..27ca4a64dddf 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -206,7 +206,8 @@ static int cros_ec_accel_legacy_read(struct iio_dev *=
indio_dev,
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		/* Calibration not supported. */
>  		*val =3D 0;
> -		return IIO_VAL_INT;
> +		ret =3D IIO_VAL_INT;
> +		break;

The value of ret is not used below this. It seems to be only used in
case IIO_CHAN_INFO_RAW. In fact, with your change,
there's no return value at all and we just reach the end of
cros_ec_accel_legacy_read.

>  	default:
>  		return -EINVAL;
>  	}
> --=20
> 2.22.0.510.g264f2c817a-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXSzaTQAKCRBzbaomhzOw
wk+uAQC2kr7TrcEA7sZDr1CfCnwy7ezLa1KBU1fssk52WQk7rgD+Nq9rH2+JjQUQ
TbnpM4wbsH86aDwIx3uwf6xGtfGxnAc=
=C/Ao
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
