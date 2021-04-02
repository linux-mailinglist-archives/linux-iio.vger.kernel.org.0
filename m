Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5623527F1
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhDBJGo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 05:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhDBJGn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 05:06:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E0C0613E6
        for <linux-iio@vger.kernel.org>; Fri,  2 Apr 2021 02:06:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso4340660pji.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Apr 2021 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mvtlGGAHp9kOCMNGrChNqKC1+qtIZe1NABT4kBjAjaE=;
        b=D9CK87ZjZ9YCUn3JucarjX1qXLcH6nl17iK7JRvdZ9ROSHJctfE1ahCLk5QgXgSxbJ
         5tJSr/tdpbCTbvLCav+v0ZtbLT6qQ3x2b/qzV3U0qDzvPLArEH8kmEDYYEVs67TUEzG7
         G2ZA5uNL4N0NdseXVyPDXryBUV1GoGY+255JevgbA6ytNuhSSMQWSgZKXPKmqm0l6bjI
         ODfIjyHqskYtxUk2OR0g64pb3BN2NVLzlQc/NXMbmDYGyOflXRd4uchOuyQ0friJ48gN
         POq8qU7ZZb9lOAOlvGDFrdHAOEZeX349PwFdkDFXaFlNz3JT3M0c3k/hPpnI8FApdbks
         6Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mvtlGGAHp9kOCMNGrChNqKC1+qtIZe1NABT4kBjAjaE=;
        b=G6/L39ZuQztdj2U1nE+uT4Js00Q1huE9gsFZw+TbCMFxt8D74HipDFYtMJ6ohELc5d
         SgqePsA5KFglbG65SSq+85VjwqeMOxeaBjkDciP87NvvyCa1FFSeou6A5q/YxTknR107
         xBTZWRtSsd920u2BGRQdLtimBLoTv8Zg0k/y6bd74TjfRaZ3vEJo90lCQVZM15N2bAe3
         59QYpmv6kKTw+/SuDbNXsikAJh+XO0cM3AuPOl6eJzaZ+LDoDO5qvEP8qDbSagpsExB/
         wTg2wtgX9faWcNnQU3j91nYeHZq0R78wST+EqsMlbyX38CoL8Zd33SsngsNzdO/Fmxrw
         4YtA==
X-Gm-Message-State: AOAM533Elk0onVBOQsB/wUakPaLyStleB1dCRKTX1jVv7eEImP+wziER
        XhMt+34qUuzWKo+SjYsR7Qfv99WLwzw=
X-Google-Smtp-Source: ABdhPJyjJwop2GXj95WqbIssGPmpVy/Ceseoe24gn47DXJKHckrwoyHVJrlHKfd9kWDxQXZBq3CByA==
X-Received: by 2002:a17:90a:6089:: with SMTP id z9mr13226731pji.211.1617354402042;
        Fri, 02 Apr 2021 02:06:42 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id fs9sm7423692pjb.40.2021.04.02.02.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:06:40 -0700 (PDT)
Date:   Fri, 2 Apr 2021 18:06:36 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan.Cameron@huawei.com,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 1/2] counter: Add support for Quadrature x4 with swapped
 inputs
Message-ID: <YGbenIXlQpHXs1R3@shinobu>
References: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sjnPXEpedJuI/uHJ"
Content-Disposition: inline
In-Reply-To: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--sjnPXEpedJuI/uHJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2021 at 06:32:27PM +0300, Jarkko Nikula wrote:
> Some Quadrature Encoders can swap phase inputs A and B internally. This
> new function will allow drivers to configure input swap mode.
>=20
> This was implemented by Felipe Balbi while he was working at Intel.
>=20
> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

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

--sjnPXEpedJuI/uHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBm3pIACgkQhvpINdm7
VJJA2xAAnw6xdQIa1B+9GKXeeszuWFurDkphup64/hPv5/gjn4B5qMResl/G8u3S
zk5XCPCWnkxt3r9FJ+C5lo4vJcV4xKVlLHQ/cwYIV4N0NpLLa0if6IVyA+nvmH2b
mG8z9736+KXFpQJ8mp9fhWNXLv4M+xzKwwdIsuYKV5mfSI3w3p0czV7jE2PXDgsZ
Li3jGEBOoG3umVklaXbETImiud7TydDRRGiajFqOnSj5ylMqHZpPssgvB09IfvEN
TWkAQRaEnXJ0t0umwg7zA3lY3GYmydvXX/GuJJ7U+LjK1MPG83b3I2RhuCM/U5Ig
B5Tm9FWbZQycXlW+PM9Dxmkt7PW1divKIG+TNi6BtCoDi1e58YHBK1vH7IRWKovt
NNnhpxrA6sfvgokRXf7QAc5Yp2Ian7MkU5JEFmV1mKtTYwfbAh4WwknE7H06MWll
BMeDEsGzhw5Z+bX9fBiIuM+hg6/F5mUv0Cz7QJlwRprhC7LR3AK5Z8vb1HvirJrl
oQO6BJYqKNzNU/k1Ol37zaq4d0voaNHtD1nbD24AkkdIFHK1GTgtjxscdUAMgVuc
9UMD6nsdj+I/XxXLypHdzy6QW8ECknW0eC0XALJi88rA8k+BYUXfXXiC1OH8JQEZ
RocVZ5wMOXzdhF08mlBd0XDYjEpf4v/NT+ANWUdb4LJ2y1Jf1vE=
=X1OZ
-----END PGP SIGNATURE-----

--sjnPXEpedJuI/uHJ--
