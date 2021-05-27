Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18A539241C
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 03:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhE0BMN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 21:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhE0BMM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 21:12:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E64C061574
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 18:10:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lr4-20020a17090b4b84b02901600455effdso212659pjb.5
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8RAQfWrkQr5JHMgIWf08XpFM5HT+1dg6pghuHPbWCCw=;
        b=aYvYzFWU672zVYpHAxdqdkUXGjCbuAxA3SA+ULbGbWvu8+bWSd3fchFbfnGrzPSk8D
         qpPwahxE7gvFqOeR8gRzU3v2Zg8YDXYOn1XtZ7YBzd6MhyeU6vJVM9TGbwGYV4TtZmVB
         mJ32lwnq1nasN4bXlY3DYyFcNaxPPO2fiyuaPTuVcPgTsWKmVj8/xCTS5BZvLli3ucS3
         eUjNgDfNYIX4Z8v/CjG2W8U7DGFrPpaQwmvaTeyhKMCnAvArgo1a10EPy3tNQffJipaQ
         O4DOog6G9cuJg8cdQYsbxho8EMcjZbSn5BpMspxYtD/Ng+TWrSOSZQ5o/FdjdrfGZ+F9
         lbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RAQfWrkQr5JHMgIWf08XpFM5HT+1dg6pghuHPbWCCw=;
        b=hrHq9//d+g0Vrvj7zlEvp9HK5gxcuS1yy3tyzosxSqFldmoSNLa+ZPJLZc+Y6uSzTo
         7yOXx0+8786KdpRH0Q2xV3faIpUyiT3syo2MjqG0AI3VddUvh10l5TU0CrDzPrnaLsIr
         5Ze58W7XuLMh1gMczSrbCU+KDi+79FBQob/pDAHVJSQgiwxU4HISu3Mp1wIgvCtUdld7
         dKjWBsGC/EkikBsA7vh7WoRyfiy+vtkgY0tIQvGQkPaMbK+JKJ9Bgg7cMY0HwbmPYVwc
         +fLg8v98ckgOgzkGGEfKCIE8fSc/HCzmVB1zbL7m82pdaGLeujDR+Cew243GrmakTK+0
         ViEw==
X-Gm-Message-State: AOAM532YabOCaiuAphTm6lTmPVrlpVNyl02pPIFiZb2JzmOsTxDyobtw
        3yT5yZj5pPsDwIlQpDLOpe4=
X-Google-Smtp-Source: ABdhPJyaoLUpr4z6siCkVncE8QPIYtDm82vF9MeFZlODvYN74vIQ6NWPLpxbAX06qrTc8a5WZt9itw==
X-Received: by 2002:a17:90a:564b:: with SMTP id d11mr644578pji.123.1622077839359;
        Wed, 26 May 2021 18:10:39 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o24sm237666pgl.55.2021.05.26.18.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 18:10:38 -0700 (PDT)
Date:   Thu, 27 May 2021 10:10:34 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v2 1/2] counter: Add support for Quadrature x4 with
 swapped inputs
Message-ID: <YK7xivdBniZJGENx@shinobu>
References: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eLOWDh2zCuqBEDVp"
Content-Disposition: inline
In-Reply-To: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--eLOWDh2zCuqBEDVp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 26, 2021 at 06:06:00PM +0300, Jarkko Nikula wrote:
> Some Quadrature Encoders can swap phase inputs A and B internally. This
> new function will allow drivers to configure input swap mode.
>=20
> This was implemented by Felipe Balbi while he was working at Intel.
>=20
> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

There's no change in this patch from the last revision, right?

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 4 ++++
>  drivers/counter/counter.c                   | 3 ++-
>  include/linux/counter.h                     | 3 ++-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index 566bd99fe0a5..8f1e3de88c77 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -146,6 +146,10 @@ Description:
>  			updates	the respective count. Quadrature encoding
>  			determines the direction.
> =20
> +		quadrature x4 swapped:
> +			Same as quadrature x4, however Phase A and Phase B
> +			signals are swapped.
> +
>  What:		/sys/bus/counter/devices/counterX/countY/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> index 6a683d086008..11d357245b14 100644
> --- a/drivers/counter/counter.c
> +++ b/drivers/counter/counter.c
> @@ -752,7 +752,8 @@ static const char *const counter_count_function_str[]=
 =3D {
>  	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] =3D "quadrature x1 b",
>  	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] =3D "quadrature x2 a",
>  	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] =3D "quadrature x2 b",
> -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] =3D "quadrature x4"
> +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] =3D "quadrature x4",
> +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED] =3D "quadrature x4 swapp=
ed"
>  };
> =20
>  static ssize_t counter_function_show(struct device *dev,
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 9dbd5df4cd34..c3b4d263eb22 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -170,7 +170,8 @@ enum counter_count_function {
>  	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
>  	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
>  	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED,
>  };
> =20
>  /**
> --=20
> 2.30.2
>=20

--eLOWDh2zCuqBEDVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmCu8YoACgkQhvpINdm7
VJKdgg/9FFfxYz2/zKS96ppDIBKHT2NqHilR9lIbxrUzAjMPuH2ln8lfdmF1y0X6
CFiUcsALXl6nouR++3pFLCSDzxdtK+Dy5ShFYpdD51JkrQ4iYQE07ytJJDAAa7uV
hwZPX1SzyvqQ7UTCwBz3A+OG6yzPgEqk7zqTQJpxVc+qhDkz0/AGtmvyLl+NH57W
Jxi+7Ni66EgiQvvcvsgjDcukJziqabTUHlaRauRi6jjXSWyvt49QffXsildrfdwJ
UFkcckzBMp7zp0npx2TTMb2qkGUiE2j17j6jXho+jI/0fIIlV00TzYU7j5bkawzt
MzHBh3xKy6jRdSb1MkQC+BH2VomeCnSIO3TBzNnQpcZP4iKgvrpPMsgpXdscUhf/
DycjYERd0aMsL9GyVogy8QTvexvzYWltCELUELb+aym13Rq2viCrHAoL9Pb8KINi
1spIhgWk7MDEvfirEcERJuOSIpe4+/dqx6A+n65z5LM9bQtX82RFo828nx/B7n+x
ohNJODNVttH3QzWJ/BLCGZgrKvHmLXKXM9NcBiRW5RUi6pjvQ/cp0ItmafV2Q2jd
LN2ZWmc9RrJE0BG7TU4e5COrddjTofJhRGn92BJkbwTMfYrdXxt2ub4TehxElXtl
NBjhDzjOjtImwW1ihJoNnSv09EyIbPABQO0KEX0aePn9Z6hoK2c=
=3iKR
-----END PGP SIGNATURE-----

--eLOWDh2zCuqBEDVp--
