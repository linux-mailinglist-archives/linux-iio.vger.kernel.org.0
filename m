Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF1301A44
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 07:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbhAXGxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 01:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbhAXGxV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2021 01:53:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95BC061573;
        Sat, 23 Jan 2021 22:52:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j12so6375402pjy.5;
        Sat, 23 Jan 2021 22:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyjJjIjAwqBAqBYpe34f4z3YvzgZOMNZpkQlTpZrZjo=;
        b=amjcQpwaeLj47+mpTvIPl2m2jIFuGy2mpjtYqeJrGqQj8Ms03hkUPOtOoOfoX94uCo
         o9lG2QGUhsCoHTTzhy3saZ+Y2ItPWGttLcWUq6D2FAWOapo0XcOHulC3OOWhYlpSNwZv
         6dCb3cHbtos8Z735z0/lnqrn5MMSmqzBpCs+KvZZ2et7Okh+wbCkhNFe+eXGAiykVTDw
         4X1Gfm1vpa0icO0kdJNHo2TJpDRAhsTgQhwv/zAKi0AGVg5zb/m0gnWY0XuL/68ZXa+a
         HulmH4xJbHb6Ozj+Pq02UEczJVwcVI1F8/U7Q6wByfbjnd5oCx4okTlWw15qLlWGpN86
         wRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyjJjIjAwqBAqBYpe34f4z3YvzgZOMNZpkQlTpZrZjo=;
        b=r37ln5IPfVTy4/3c7PkcdBeRV7XZCUCtX9gGeVqbJi7w7jsbg6nhr++p1+98b7DOLY
         S0Ojc3MQ3yYPuiu4gQmZffPLBb9/5FF0wsHQ+o7Cb0/QDyBXe0Ah2E57o1DqW2E2p5k6
         5vfwl+kfbt8s3rfbAzmXZrBcGQzDLGX6vMLabD1MLKlpPfBrU5fY8QJuBKz11B+fX71U
         0cEj9KUMEd47MyH+m5Z9HhcK2qBNNkWyVUjrXhG566zB+K95Zlgb+DOGs+6yYIq654Cs
         QC6xcWEufqreff+jzGLuvTNSK5+U3lnw/ACV80jHiH5MuDaEjc4uDJe4VbDvQ+KZU8mx
         ZT0Q==
X-Gm-Message-State: AOAM5303ZK3KnMbRkGQ0KHQ+btcLQfB/nOR2AWuaIVOUpMRUkX03aM2r
        aloxxvJ8MlfgeqiXgXDExGI=
X-Google-Smtp-Source: ABdhPJyxkV+O/+aWYQ10BwEq4a29+MEs/T0dQE+y09aAvRy0RqIED6p/FYfCfJQKuynTReotktv6Og==
X-Received: by 2002:a17:90a:5a03:: with SMTP id b3mr2385204pjd.1.1611471160359;
        Sat, 23 Jan 2021 22:52:40 -0800 (PST)
Received: from shinobu (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id f15sm14172870pja.24.2021.01.23.22.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 22:52:39 -0800 (PST)
Date:   Sun, 24 Jan 2021 15:52:31 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, mchehab+huawei@kernel.org,
        lukas.bulwahn@gmail.com, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.torgue@st.com, fabrice.gasnier@st.com,
        olivier.moysan@st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: remove iio counter abi
Message-ID: <YA0ZL2g/qX7tigJa@shinobu>
References: <1611327803-882-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ifstk+I27HDRTTHT"
Content-Disposition: inline
In-Reply-To: <1611327803-882-1-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Ifstk+I27HDRTTHT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2021 at 04:03:23PM +0100, Fabrice Gasnier wrote:
> Currently, the STM32 LP Timer counter driver registers into both IIO and
> counter subsystems, which is redundant.
>=20
> Remove the IIO counter ABI and IIO registration from the STM32 LP Timer
> counter driver since it's been superseded by the Counter subsystem
> as discussed in [1].
>=20
> Keep only the counter subsystem related part.
> Move a part of the ABI documentation into a driver comment.
>=20
> This also removes a duplicate ABI warning
> $ scripts/get_abi.pl validate
> ...
> /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times:
>   ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100
>   ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0
>=20
> [1] https://lkml.org/lkml/2021/1/19/347
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

I'll also submit a patchset removing the IIO code from the 104-quad-8
driver and the rest of the IIO counter ABI documentation.

William Breathitt Gray

--Ifstk+I27HDRTTHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmANGRkACgkQhvpINdm7
VJJ4Iw//fPBOTOQrrg//Y+6Qf3vPDPUfv4B2MY4bu5RIja9Hw6jqw1OWFxsYLFeX
TYm4Hl3K7RSsPfeWFcCgFdp/IvSK0CMH+nHuIPcwKxsE+E0cm4ExztexpmZUR5kD
znjePAQzo9H2kYJEmQ26Vb718AzdkaWVWOVX736TT7ecZOMKngyJg2tZ6qK+9uI2
KMRoJPzqfl1O3lVAWiCMI91fNggTxinxZyKKTMq15GTirPn2ZRbX8i9Nxxepskf0
QHdze2Gz+lgwDJxOLfzohpF64DG7NcMSYvMbg9EsXTBc5gL72Fmfk2wgHhx/aeUP
5byMCFTXfAZOQWaQN4CugKhcLy8Bxv/JAXH+BEqFeIt0PoJhPvJ0X62zTBmzswXS
8jvGq8OTGwvFisJxyx4vZk8ODxWkVNwch7ItXc8/oj6NdgDfYaYUQpEKHYEvggvn
73jVfSPFxAfouk5p8Lo2aFVokJ9lRn/rl/mW6Bwq0DS3nJ8vawX/PQfGx1y3MV/o
cKE7kdq8ZPjXnijG8heeehweI6eRFuV/bcnFvN3GxlIv/hkCWdhZ0b67ZEiUz4uE
yCp/WjCBBoQbkAwvf5Q+VWuycmFHVBRJ48I+PLOGKykeJO4C2Z5eQwEAnhaGcD9O
VJ85gCrUdvzODq0fhpFWY3fXT4Xm1b0FMWtY8w2rshsQ6GToxzY=
=WMsJ
-----END PGP SIGNATURE-----

--Ifstk+I27HDRTTHT--
