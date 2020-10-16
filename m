Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2ED290DA7
	for <lists+linux-iio@lfdr.de>; Sat, 17 Oct 2020 00:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395323AbgJPWVN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393329AbgJPWVN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 18:21:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CEC061755;
        Fri, 16 Oct 2020 15:21:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b69so3168878qkg.8;
        Fri, 16 Oct 2020 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O7Ki5yLyDW5bHzqqXKXGudG5u4i/kM6RUsvTxp8H1SY=;
        b=jtBIlWKoYCOzeoI1dcsdf/HvkUqhm2Czybn35TsFLBUo4MVyq0yYtkiaxBF2e/Djro
         7b61GgWaIJjcuwEawZjVj2YTmRwtAgDvXaDdBlsEhFHk6eyvxfr3JdB+79iXtfC1D2QE
         J2rigelsUXk18YAWkTErd3GjkQTS6WBusXgbiSN+qC+hA1gpGWYDtyKuDpuS8DIg3ynm
         BC8z5QpUSiGSX2zzSOJaz2V4Nk5SAwM+a07yDIdcRLMlNO3rcxNkA96HvpR8EAU+3PPo
         nSl6unw25hEjAF28/dtrUszfDLLYjtdaJ2aGbsrdG2s8QovGa/khhMPUobkxObWVoHkh
         a3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O7Ki5yLyDW5bHzqqXKXGudG5u4i/kM6RUsvTxp8H1SY=;
        b=G/M6GGaFcj1yL6PXa8kQOpr8DEFDMaW+YvniVoKMbhZejK7YKZs4xwKM6/Ef6WbmOU
         goe9F/uTwj8bSH+Je1Hnzy0w82Ga7X+Z9zBf5kjgA/zzjKzv35JSeWAvB+zRNWqup2I9
         dyyVhZKIMHebzJWdF3lcFCGXVINBK8exyhSYjuOthpchg2itnPH4vJtqm0pfdzSuuIWI
         AHPRIC/s30SV4mmL8owU1pPsp7kAu0eyFnABWg0svA+WwKRqnCZ65E1Su7tLVFknwl9M
         kJPZTFjxg85vqmmOui0r+TRgrSeQgYr0LOmxYnADfpDYfh/LR/UbPHZ+3/kr+F42eSLE
         KB0w==
X-Gm-Message-State: AOAM530ZrR5hGgLm+O906mKfevtqrQ27QLOBhus+EHAm4KeHXdKDSIct
        VZeMp1lYhFU1E/y2tKKlIXg=
X-Google-Smtp-Source: ABdhPJzzg3hVag6HEoQtrz63wQ73ybp/JYTa/ceccEOOGHaw0ljOEmTVlNLsxvX1D0wXXa1DPQoDaw==
X-Received: by 2002:a37:a68b:: with SMTP id p133mr5798884qke.272.1602886871877;
        Fri, 16 Oct 2020 15:21:11 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id t2sm1560498qti.25.2020.10.16.15.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:21:10 -0700 (PDT)
Date:   Fri, 16 Oct 2020 18:20:55 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter/ti-eqep: Fix regmap max_register
Message-ID: <20201016222055.GA3096@shinobu>
References: <20201016195838.536791-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20201016195838.536791-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 02:58:37PM -0500, David Lechner wrote:
> The values given were the offset of the register after the last
> register instead of the actual last register in each range. Fix
> by using the correct last register of each range.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/ti-eqep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index fe2c6bb22133..e60aec225541 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -798,7 +798,7 @@ static const struct regmap_config ti_eqep_regmap32_co=
nfig =3D {
>  	.reg_bits =3D 32,
>  	.val_bits =3D 32,
>  	.reg_stride =3D 4,
> -	.max_register =3D 0x24,
> +	.max_register =3D QUPRD,
>  };
> =20
>  static const struct regmap_config ti_eqep_regmap16_config =3D {
> @@ -806,7 +806,7 @@ static const struct regmap_config ti_eqep_regmap16_co=
nfig =3D {
>  	.reg_bits =3D 16,
>  	.val_bits =3D 16,
>  	.reg_stride =3D 2,
> -	.max_register =3D 0x1e,
> +	.max_register =3D QCPRDLAT,
>  };
> =20
>  static int ti_eqep_probe(struct platform_device *pdev)
> --=20
> 2.25.1
>=20

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+KHLsACgkQhvpINdm7
VJI/tRAAus8eLf0DQ9Qd+d6jLOqy+/9Bf0ejNocl8csHlOPb4zPS7E5J1+UKiSch
rFbYJhjGZ6dQ5xdWNhfrzOktYfNUszFYamBYxuHdXX8kcnbpcrrQkOz81njRXOJ4
4Eztm/uTyyzCmqk1omrTExZUkkQzOvY7zAGZs8qBXKMUNkbHWlSgIGOeAP9yH2Fn
3UiL8FvZsuDA7ju0DAOby2jV10u9sZOAx90m06Jo73e9/ka5VWUtnq4D8Y64DdG8
d+60gkas14wXqzfYYXHqiNcepXsHNfFJYCjksPVMDjUQztjXDAAqJxFIKmD8EU1X
AKYZNWWPAwWyahqkagdVuG+qF/WcWv3DwriV/wR9XJ6Tt2kbfBEFwsPvyVvUZ7WO
Cv2XNii8ofSbEEyAlFsTwgX/KLeJa4VfigrvMs7wS+3u9cZLvU1rB6d3EAwdZADs
mjyFhBMmohrdVoP2wRjR8C6GySIUGdmxkGm1Ii8WR7qGoOr2zH2KcSTV+HHMTyzX
hhDGV4Mk0Tl1L5NXIIvzZtXVt7axS5mzG+38ip7K+55ZoyPW2h5YVLzrQrgjy6MF
s5b4+Jv/TZINDgmZ40EGbr82q4SMLzk6QyIrssww3iSW3ioonSpsrZvmsACuIUqS
LMEYKu3bNNZQRozX6qhpUtcJOIRvPy2VWJRXefiV1B5Xjse7Oec=
=thQP
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
