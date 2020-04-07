Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1161C1A1229
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 18:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDGQxk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 12:53:40 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35654 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGQxk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Apr 2020 12:53:40 -0400
Received: by mail-qv1-f65.google.com with SMTP id q73so2177587qvq.2;
        Tue, 07 Apr 2020 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3VppNLHFrOcwWwbhA0a42eUvrzhWAyV8lp0TArcKUI=;
        b=gTMYjS8VCusWzzR0ujkxGvuNVHTf97jQDDyMXbcKUdhzfmqh8hJapcfDJXCqvVpZpH
         y2GtAqJX+ZTq7ILnqzyqwMPlBeZG6qYiFEZmMWMuGYCZvqaf8ejN8sL87Ju22j+VgjrR
         7fCs7WafEs77ZB3k+dcLzdVHRizOUpzywpcDREzNQROl8lHJ9z+GEBgRCqavav/TuGky
         ZAaAHWX/8hTFesdNvVB1CQkMJA6ugBJl2tgreshtXqx2bPI3VZOk1Rb5QEF3zVPNm1qz
         3aOHzWfcR4WTQ425t7EDeNinHx4272hmXhvbdNIAl5S7wVj0DQcw65lp+JH2cTVw7hKv
         IsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3VppNLHFrOcwWwbhA0a42eUvrzhWAyV8lp0TArcKUI=;
        b=cNNPwgD/+0BNF4UaEO3tNKpSiqITwrsSZh10QMqZYFwDLQYLqX2roNcwE2D0Oylz4C
         igR7f80kbNL9oP+epYLXbr6JB00u9i6AAZecnHKWoucDKt5vU541ifE/Fe4IhZSI2ke6
         rh64gWF0+a7SrfWgB8Wx1A046+swmWYA77IvDDJltVy3cvxQh8pCFWpayQ1KUK3gyLFB
         cix07Ftaw8bSEJGPSj0gooimWWSHrfxhwNH7kXO57LsafKBewCLfDCt12jkx7BogYmry
         vFebt3XtmsjD1/adFslTluDOGZyfWYfTVeAYEl1vliGQM9ur0ACAg5yMP21sK2ibVUYU
         ey/g==
X-Gm-Message-State: AGi0PuadIbbPDNrVfz4oy3+BEPsOkl2mmIEk3WAQnyugTPbejP1A/pv7
        V0b/QDhCIHHmYhbT18vbCP0=
X-Google-Smtp-Source: APiQypK11F/M1pHTJnN84IWOLfEDHscNiF0dxYg4qZy2tkh6lY/465HRjDB4R4Bn3/EpZJUuWGcf6w==
X-Received: by 2002:ad4:496b:: with SMTP id p11mr3140242qvy.202.1586278418655;
        Tue, 07 Apr 2020 09:53:38 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id m127sm13463453qke.64.2020.04.07.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 09:53:37 -0700 (PDT)
Date:   Tue, 7 Apr 2020 12:53:35 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: at91: add atmel tcb capabilities
Message-ID: <20200407165335.GF5578@icarus>
References: <20200406155320.1291701-1-kamel.bouhara@bootlin.com>
 <20200406155320.1291701-2-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20200406155320.1291701-2-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 05:53:18PM +0200, Kamel Bouhara wrote:
> Some atmel socs have extra tcb capabilities that allow using a generic
> clock source or enabling a quadrature decoder.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  include/soc/at91/atmel_tcb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> index fbf5474f4484..6b9c9bec982e 100644
> --- a/include/soc/at91/atmel_tcb.h
> +++ b/include/soc/at91/atmel_tcb.h
> @@ -39,7 +39,8 @@ struct clk;
>   */
>  struct atmel_tcb_config {
>  	size_t	counter_width;
> -	unsigned int has_gclk:1;

Hi Kamel,

I'm having trouble applying this patch, so I think we have different
bases. Specifically, I'm not sure where this has_gclk member was
introduced. It doesn't look like it's in the testing branch of the IIO
tree yet.

What branch did you base your patches on?

Thanks,

William Breathitt Gray

> +	bool	has_gclk;
> +	bool	has_qdec;
>  };
> =20
>  /**
> --=20
> 2.25.0
>=20

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6MsA8ACgkQhvpINdm7
VJI7/g/8DlUdnaSLPC9O0tau43LweVzguxsRZUbsgEYcyNqguZF+ZmPWMospskNI
LqRF7nWh6hVXjz9EarWDGKT+EEw2ykfJnkc+9UYnDseXC8lcphprTyTQxRg1Q0ol
Ot9jb1uHhPWE5hOQqrwwP84ec43wjUryFER//0NmpJZEPGjCEiJK7oqjJahLN12v
ooL6gDIB3iGV8QBIfANVUxwBV00pnsFAxtQMZ7euZew+qN9nxxUA1DmfTlW7tO7p
te+ZW9WwEb2qhE1KhxBv3rcul1kxGSj2gA0MufqW7MsKEQN+iZiZorXy7p9ZbSG5
L2NgwY/HnIT6yyoOZZ+c25yhfL+suFW2o9s0C16CqTOmmMXoqLevPTllgNSVxkod
mZ73s9+JOrhGr9qjwqyLOWo4gGvIzaxfwbeTpgVcq0rLcdinDFLH09eorvDogeWv
QfMZSrR30ATakNbdJcglA6Kf7q6CNxvELc9P5aSxeujLTwezP+Cy6Ea61eSIeR60
dvxyttF09iBzTKr0VjqFJ19geMFS4RExoN2Vu4w03RqyTihcDQHJnNF8hO4l/mpl
t/lKLh06mUEB7LFNwh1AisIO+l/EKiPmDGb1cuefI9v92k2Nof32QfvhAmmYDl1g
0OMxLl/WMd563XzCDKRLPqm7IIgjEtJEg7uU2YHiaSNk3p2t3TA=
=66eq
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
