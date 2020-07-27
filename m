Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9991122F388
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgG0PMX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgG0PMW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 11:12:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC44C061794;
        Mon, 27 Jul 2020 08:12:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so12434373qtn.7;
        Mon, 27 Jul 2020 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X4J0mdqOUubW75zyAvJVccO1ekW4o9Bw0SMRiamJdPk=;
        b=LynZjyVTrLYd2FLziJlYmudzoIByx3iMjU7668pCOugH2fHkwRh2vVUoa9nfrKvQmd
         82Gur4Mpa9c2t7RGHxEdO0MLoad8hBHQY8UOixfKLPvmDGkJ3AewJkuQ3lfFEdzjILs4
         /u9M6fZ22X9x57LizflLSGwgsR+MyTkYvbkj+VCqVO98PBaQXLqsE0hl+jxMnRdLNmHQ
         ZdQHIn9DgzeVIcF6hQH8M5/PC8YVCmCOOZBxP4cCgkFepyVi9jZeLqTjF3iOURn/tMmK
         AwSXG9fwoeV3UoYeGB1RuAeWyVczLNVqfHtESihwZVoemz7LniKSeY8hJo53zWKwukWE
         qyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4J0mdqOUubW75zyAvJVccO1ekW4o9Bw0SMRiamJdPk=;
        b=KM4kaTGoo5S18J7V5nqb3CBZYvmgyYzJ7aAWzQizBlsmI3W4guggD8k0gsVNzVWOC4
         dxoGSZ3srwqa0dS/tyR4b9eKG/V9T1WjlrtAlGGShzzmak7e6u4WRKpUfMs1TJq0+osN
         Je6qTtrDqZFOpO+fs7IvybAO8gE49oI+AU4kj4Xr6G+vzMbMcyS6cNfcAHGMAndnOyTE
         sWlrSd5p4iEKCIV+++hhz51taNRc78htORjs4uBApm2aQLNvrLRpzK2OkPgTmWCm8dM/
         2I7oIAndVLOtihKmI52mHqKgylT1xtank+xSjzgM8z/nKk1TW6kmLavO5YL67CjfG1Di
         oN9Q==
X-Gm-Message-State: AOAM532PKXQYw273nQewYE3bx9TtGG6pElVSRAuwX/CbjevdDUJtyuLo
        Jf40jOMN98U4Cpj7pZQ6blt9EHd0v7U=
X-Google-Smtp-Source: ABdhPJyjY99144szoJG7BGTtEhT/lSRkjjVAd8wD9LaqbwFMg2+rQgHaCAtzQk7tU+Zx8WFjfcdYVg==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr21210357qtj.83.1595862741775;
        Mon, 27 Jul 2020 08:12:21 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id n90sm14390831qte.21.2020.07.27.08.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:12:20 -0700 (PDT)
Date:   Mon, 27 Jul 2020 11:12:18 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Colin King <colin.king@canonical.com>
Cc:     linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] counter: microchip-tcb-capture: remove
 ATMEL_TC_ETRGEDG_NONE bit check
Message-ID: <20200727151218.GB4636@shinobu>
References: <20200727140600.112562-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20200727140600.112562-1-colin.king@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 03:06:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The macro ATMEL_TC_ETRGEDG_NONE is defined as 0 << 8 which is zero and
> hence the check cmr & ATMEL_TC_ETRGEDG_NONE can never be true. Since
> *action is already assigned MCHP_TC_SYNAPSE_ACTION_NONE then this check
> and set is redundant dead code and can be removed.
>=20
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/counter/microchip-tcb-capture.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index f7b7743ddb94..119640d6d6ab 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -185,9 +185,7 @@ static int mchp_tc_count_action_get(struct counter_de=
vice *counter,
> =20
>  	*action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> =20
> -	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> -		*action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> -	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
> +	if (cmr & ATMEL_TC_ETRGEDG_RISING)
>  		*action =3D MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
>  	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
>  		*action =3D MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
> --=20
> 2.27.0

The CMR value should be explictly checked for an ATMEL_TC_ETRGEDG_NONE
state; this code shouldn't default to a value, but rather return an
error if no valid can be determined.

I think this would be better implemented as a switch statement instead,
with a default case that returns such an error code.

William Breathitt Gray

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8e7tIACgkQhvpINdm7
VJI/rQ/9GVUNrwXP6cEnZ8x/0QRBrTI2+5bpLlNR8Ry19oHOaOQ9YrEYHPZpH2Er
oQMIifA4RhdRhAfK+MKB2AKnVEPQNo9js5P1t9ElJiWZz2rY/s/+HzBLTsgC/zKQ
srLyiPvLAmzBrqle48n0f8k+Cbk3jzSnaUwO5rra4x9l1LsZ6HJd4zp6Z2zrJJjJ
DaFh/H255+LAPFw2yHRvcEMOtddYb9a2rzQit4sWm3KyoJdVB5RgfkzfDc3VtOgp
d0A8h3F6n3kVbpjQsd/09wyIASCNNQ0iDO0oxyBz8xjrxWBgL2lEV+4drFXospDV
nTZuUoKYQ3fhBbMbqjZ0UMc8OiGk2gl+5XXr5Z2arhg0OO0yJdfLlh0utoincYB9
oPrO633Kp9JpSQUbfUdTubmSIbOfxB53kSJ0IJwFyZLf58DotYPhCRql+HnvxC+0
rnnm2gjc0tD9UdLFjSIVZ/51S1Guc9/Xut1dMkhZKFPcTc8rvqHZ4tNMCOAH5q6P
9mip7wQ3+If01vXM/ILQInGErkwwT8frthe94QjjCuWiUui9GReK6AVdiBIqzF9w
Xxvv58KRj3eQdU3gDzJjyCq1lANA4lnoyA439iIuSwSEMTipyvTWmTnWN2xV70Vg
ozrbA/SubCzfH6tWSNg2Bu5U74gB6j3Z8A0fZtqkvRQ2xW+lZF8=
=2+lp
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
