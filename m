Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A541E5F4
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 04:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351481AbhJACJv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 22:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhJACJv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Sep 2021 22:09:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E725EC06176A
        for <linux-iio@vger.kernel.org>; Thu, 30 Sep 2021 19:08:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so8133140pjv.5
        for <linux-iio@vger.kernel.org>; Thu, 30 Sep 2021 19:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WVRLRhzvoKVV20Ol7H+QJEsX2wP17yl5wh+OP+kaCs8=;
        b=ImYgPQO/Z0EATtIW0D0s1Q/ULFZodvL1tLgNNRxnKPXYjb0DCV1nBcZb9GBI51o8Z5
         vfdQQlaf7rodUOMRGiVLp9m0MgTQI/hu9x2QjmHICQHGOV6rF++Y7yzruuxIll31M0Gv
         d09/DCfkSWoU0F5CiJcQjtHv7WZZ9QWyby05HSERmrl6KV82ifuuIGZtKwJHXteJMxuR
         /V7R3GsCYl5n29hL07wZBLlwOxEnq5kI0NV8dBOlgsWu6AUIxAB6TZEjRvv+ML8JP7Td
         j4Pn5FOJZbu3Q6Fw2cPxqY1LWg1eCRpUYYlKoDJFMOPhdQZP5DCIXyprdUtOFY1bnz4e
         S18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVRLRhzvoKVV20Ol7H+QJEsX2wP17yl5wh+OP+kaCs8=;
        b=a/FjyKF/c8X1oFZhGWqh7nRa1G+kZ42avlio5OqXpGW7GfjsFGK6jNseyjFC6c6E8z
         mVF8zHdG9g98g1U0agBOyifAaziEZh538DI8VfdejrEAw/SYQGAUAxokJnWSDYCrMV/5
         uznAzEf6t243GP7jnykvRm1d1l6ztZrDyRb43mkbLTrLmZEZqZ57+9oyNo1Y2LhMAhIJ
         xczPLNlnxWqHs08HXjRrzvyMSPnN0dtG3ghq/dpYDIICSbcXJ4JPg3K5GISsfAfR3tZ0
         uF6iVWhJuoqecFY3/GXVX8jp1ZimoBKM7hu8yFwa2PX3dmp6dPkltL72YM56nrcOKRP2
         9cBw==
X-Gm-Message-State: AOAM532VV3kiVoBFq5fj9KqlTC2Lcz/b8UWSIifWpXi2PXB9IJcZY0sk
        aBpWf7h5PG261hbHR1sOx54cR/A/bWw=
X-Google-Smtp-Source: ABdhPJwCuEl5tXtdarlXoT8851RUXS5bLLV/S/jqmMcIuxzXNr5XXxy58dJanuKpji+OWlwYt4z3Xw==
X-Received: by 2002:a17:902:bcc6:b0:12d:bd30:bc4d with SMTP id o6-20020a170902bcc600b0012dbd30bc4dmr8393808pls.18.1633054087503;
        Thu, 30 Sep 2021 19:08:07 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id b11sm4291594pge.57.2021.09.30.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 19:08:06 -0700 (PDT)
Date:   Fri, 1 Oct 2021 11:08:02 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH] counter: microchip-tcb-capture: Tidy up a false
 kernel-doc /** marking.
Message-ID: <YVZtgkZQi3Vbqx4e@shinobu>
References: <20210930170347.101153-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xs9zZcQ8ihzl5qEf"
Content-Disposition: inline
In-Reply-To: <20210930170347.101153-1-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Xs9zZcQ8ihzl5qEf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 30, 2021 at 06:03:47PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Deals with
> W=3D1 warning This comment starts with '/**', but isn't a kernel-doc comm=
ent.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/microchip-tcb-capture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> index 79e0c84a3b81..0ab1b2716784 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2020 Microchip
>   *
>   * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
> --=20
> 2.33.0
>=20

--Xs9zZcQ8ihzl5qEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFWbW4ACgkQhvpINdm7
VJKnqQ/7BiKhAPBW5dJXlXwSpKQGKKFG8vD8pcjVVjsHGJuyjFmauWIVdN4Sj8f1
oi+cCka4gUB/1kHjkKJn8GeJtmCaKOL8KsxzScHQKkg9x/+RBMgLLn80RTiK6VAl
N5xrYLVPd8N5HedRUHnvL4JN1PzAHlrYAjlplqyxx/2ULSwyvuvAVtXzmHvpmTZZ
RE6DakFxpVyLQCD3h8WiLsyib3C1nJ3dmxGCVClnxD27jBCMnzr96eZdzXx8F8f2
TM1D6eRngBTZ+2H8f4+nF7XCm7twafXC3z64Ay8gNRxNqT/pIgg3SEsf4wWqhsfZ
RWoMvNq30YrofFnLSvoVtGqt3kvXejUJFuXVNluMC7TQOOUmRc6VscZcBIUONWfo
R4EHUYRpS3tfGBRJFRFbhPSSYyuRk5lc3E8DarQvCM4sXblmX51OytnNHnoCamee
osLE78MnNeQW6zpO/X52TCFW1BLOPGrkyQYwA/eKZ/yLAPZJwHzQxYxs70UKYBJg
cExDchW1s5/uD/ABYIpO2ZzmlXDMjQV9uPOlXoReotUGd/LDHEI5BqEckox6fzro
lFEkSg0k3xHbhk8GtHUnRjbY4efsFq5oydgaThKNEEstt08A/XIMWmCi678lb8hY
gOSxjmiVdTaZzJ8xG2hFkIQLIsgbcAAwrOXTYTp12do+ONl0skc=
=2OH0
-----END PGP SIGNATURE-----

--Xs9zZcQ8ihzl5qEf--
