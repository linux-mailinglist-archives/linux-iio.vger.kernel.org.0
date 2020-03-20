Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24718CF12
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCTNgX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 09:36:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34876 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCTNgX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 09:36:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id d8so6817121qka.2;
        Fri, 20 Mar 2020 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAaqZAS5QdKHQm7mABpa6xtK7LMiTx17PY74wDx219A=;
        b=S9Ev3VL26xZdYuEU7ArhabK/4jZdJmdCtHDiDeRYm/0fjrYGaWy8zRErRCXqHiYXdB
         SRrUhGM+B4JJp9/r3LnCq7bIiaWMW5Hiqdve1mMvN49FfOWA7S8ytrSPVlU4C3jp8cJr
         fUY4iD32EbEPn26/JpdpN93RD4bNtFsoq9dk/h1I7K2qKdqBJKMKMYjYQPnWb2YxxML6
         vGbky50bEHxOdgllXdhfM8VpriH1mPXS3dTmr96NRV0gfxpmwQp554hEzsjyGWOHscee
         GOVE9n1OJpjHQ2RtMR6igSZl/RYvEYDKxZ64fqBCQr//FeVuJiJZQ5Y5/aM28H4ueuGb
         I6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAaqZAS5QdKHQm7mABpa6xtK7LMiTx17PY74wDx219A=;
        b=fwI2XP8TCiEy2t6HTkAT+xeOignFlS1gvTtiesdKaEXfcS6O8biPI6onRZszfbtuye
         bd7kujhFC/cQtXsQFBn05+RYwB9N9LXkO4XS77NrJEaVcT/Z6VsYiFeGZqGgw8ysWZpU
         pDSxT/+P2BRUXh5shL6EkZm2eI3gDDkiX29X4Zwb88EmquTtFvwEQR/j5cp0iTW16cSp
         2z95fCyxhsl9udKf6kKxuSVfyZvCpE5t8r5zLr0kkAUEwG8q3rFb47M0z2Azq/2H1vMn
         lTeEstQ/m+4zMj3cNbPYtmoSQS6v6lS6g4A+IvlRaoxu7nfkPUaEa08BjwWCQ3URWcqj
         gPyQ==
X-Gm-Message-State: ANhLgQ2o1k96zGT8HeJWqwoVVSU2xxVOYca48f/8/cxfGjt5szN9mKnl
        v9pEV4JERA5qOQgp9MzB1+Y=
X-Google-Smtp-Source: ADFU+vtAugl+ePC/AUXZBJVeq0uKaR00hPJZ/K3gm/9I4G9cHuFLhjtiG5MwPebWbY/CKyWXdYaqeg==
X-Received: by 2002:a37:9f8f:: with SMTP id i137mr7850454qke.68.1584711382340;
        Fri, 20 Mar 2020 06:36:22 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id p126sm4224430qkd.108.2020.03.20.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:36:19 -0700 (PDT)
Date:   Fri, 20 Mar 2020 09:36:00 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] MAINTAINERS: Add Syed Nayyar Waris to ACCES
 104-QUAD-8 driver
Message-ID: <20200320133522.GA3223@icarus>
References: <20200320081257.GA5818@syed.domain.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <20200320081257.GA5818@syed.domain.name>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 01:42:58PM +0530, Syed Nayyar Waris wrote:
> Add Syed Nayyar Waris as a co-maintainer for the ACCES 104-QUAD-8
> counter driver.
>=20
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fa40c3..55c7794 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -276,6 +276,7 @@ F:	drivers/gpio/gpio-104-idio-16.c
> =20
>  ACCES 104-QUAD-8 DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> +M:	Syed Nayyar Waris <syednwaris@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> --=20
> 2.7.4

The 104-QUAD-8 driver is getting large so having another set of eyes on
it is much appreciated. Thanks!

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl50xsAACgkQhvpINdm7
VJLrVxAAvF8/G83XHAM7Cli5BrA4052ZSapSdiXX2KfmFiTNUrAV1YWkTB1ifjDx
/vvofJXDQlRhR8N5uKbS7Ga/6jE42zFsfDv6PFC8WJc71pJ/plw75obmxbnExqSt
tQBVpjP/ITY74c5buBhZ/v/gdBjlm6xZoqVyYzdSGCkFXZZ0nB0N+SEbGaMLPz5O
Y+G8A7fsVHSaV4GHoQuUsormxJIHcB0T0fpDPqWcwgBwv2r7s8/JcSRiUgzBgP7Z
xyXU4BYiynKzUnzBH+hiK4Ubgpn5Y9KfHZpBMpVkEuedj9Jx2ZYbETIp2qrAmAM9
nP7F44nkkNqZ5dtWmf+M6XpGwI5/7iz/UlWuZvoyPL8lks+gX22XXNfAinQTGFhj
okxV8yREBh+QBQ72NeWkg7VGlSjiT5ktjUDl6Jg+sv1XdT0M2xSNN3/ECEn5vLhi
vr8PoYA1jpMYWySk0CJJdk1bKhJdRzgJL34GjdsgDIKNTKjuPKbkMwbRBpxRuLNH
gZubpNmdtIgJCNFWoWKZu0DiKKMkwMNWO0lTNK4HMexAKfeQcd2hSXZDXkrohBIk
//7mEYpfR8Apuj8QdXR5HJmhWcC5pyt8SV0tyiOzTB4/hdSjf24wlRLoRaumVA5d
IFyLTQ6oNvOQOl/4aMO3GFdDJg0GOMFUv2qbhBOdCMZqG5B1w8k=
=/Hg4
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
