Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A3421E9A
	for <lists+linux-iio@lfdr.de>; Tue,  5 Oct 2021 08:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhJEGEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Oct 2021 02:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhJEGEu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Oct 2021 02:04:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292BDC061745;
        Mon,  4 Oct 2021 23:03:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so1121762pjb.5;
        Mon, 04 Oct 2021 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzef1HFOeoLXJqleO1fOGlTyje30IPeXbt3r58qE+Ak=;
        b=nco9rgRDk+B1nKQ6FVfecmPR8A9HPl0WOoBwaDBnOtyXpcRV9i8Vq4j2P2r/MYVSCw
         WLULzsM7w10YQghnw648fJBgsTS6x0VhyrFx8kXXQvaZrsEx66klq9vHVeAMulA4lKq3
         DggvOnbCryglThNVuITBjfBtcS1sMlxyTMDDcuBbJvDUhJ/NLk1Ix+p7AwDoPwO4khzi
         MPzVPGKHdfTZQE3Sq8rbaTPfRNKdsTA4e62AIolGDjbCDNoze5bPfJiWG7chhFZpDZZk
         dchSnLVYeW1aKoWEnGDt/tHXk2Lg1YqtSjzt97tmu2rBLhTN17S+V6ydolJpd6bqlDZG
         VxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzef1HFOeoLXJqleO1fOGlTyje30IPeXbt3r58qE+Ak=;
        b=gJqymrElQG44Fg14gq4T6QxW4NcmEkoOP7ggoe4iZ+pfMlTVZzsrvwQ5V5ESARVb9x
         7GjZTGAGMcKEvkCUjpYTfRgAE6crtK+eDnLbHXg5l6PqVjN1RiKEzDZConwyWHwBu46r
         6wR0jZkjgm9vqTz7l3GLeVoS7o5ObvqoLEoPaLP1QwQ4DiSCUACdPl9tKeaSe/X04pEH
         lFz0W0d/Zimchn4fd2ldWHU8PlgJLWkd4zYOrlkBtyTHHnIpDuu01UhPveFNbHpAQhm8
         8ux9Lj9Oy+iVmguSweOZoPec8oaT+/wB6TpurX6s7ew9dH8QZ57Wpzt3lA5xbrbOFHrN
         WRRA==
X-Gm-Message-State: AOAM530bcVuZjmHQNchkV+7WvwkOK9HQ9ezLZ0VTwZr55tO5s1wLpx7K
        /1Syc24ajPQL6UlddERFpuY=
X-Google-Smtp-Source: ABdhPJzFK1EgWaKR+WJonporhyi5eFBQxv/m/L1aR8uouKq16OFCvh2H1cwfgYqnxP4l9X7zJIw4lw==
X-Received: by 2002:a17:90a:1912:: with SMTP id 18mr1713453pjg.24.1633413779728;
        Mon, 04 Oct 2021 23:02:59 -0700 (PDT)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id q2sm732470pjo.27.2021.10.04.23.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 23:02:58 -0700 (PDT)
Date:   Tue, 5 Oct 2021 15:02:52 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH -next] counter: fix docum. build problems after filename
 change
Message-ID: <YVvqjOYTo1+zd4bn@shinobu>
References: <20211005055157.22937-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oYq9vOgAm50vohTR"
Content-Disposition: inline
In-Reply-To: <20211005055157.22937-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oYq9vOgAm50vohTR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 04, 2021 at 10:51:57PM -0700, Randy Dunlap wrote:
> Fix documentation build warnings due to a source file being
> renamed.
>=20
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-ve=
rsion 1.8.5 -export ../drivers/counter/counter.c' failed with return code 2
>=20
> Error: Cannot open file ../drivers/counter/counter.c
>=20
> Fixes: d70e46af7531 ("counter: Internalize sysfs interface code")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  Documentation/driver-api/generic-counter.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-next-20211001.orig/Documentation/driver-api/generic-counter.rst
> +++ linux-next-20211001/Documentation/driver-api/generic-counter.rst
> @@ -247,7 +247,7 @@ for defining a counter device.
>  .. kernel-doc:: include/linux/counter.h
>     :internal:
> =20
> -.. kernel-doc:: drivers/counter/counter.c
> +.. kernel-doc:: drivers/counter/counter-core.c
>     :export:
> =20
>  Driver Implementation

--oYq9vOgAm50vohTR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFb6n8ACgkQhvpINdm7
VJJW0hAAtQNwKIOaXA8JY3+v3CljlOYzoY9Qq5Yf/4iOieRlXLc2GYupzfaEi1j+
0SriM/MPX9If/0dThJvES6OldkY969jdR45bB02v7yWfHiIcr7bNRrvQ+RUFqXdk
iJOfKTrJtT9c2jM2sBxC2IeJHUjMYceEhTV9VfyB9C+Vmw35jAHVu2eBzv/i/5y4
9838IiCj/HUKOgpeC0MskqdI2QuHYCxzExo+hTSZOloOUGWboMLht07N+s2nxF75
AdIcwf2HK7DGweoFmIJ+iP29lQpQewb9KPpxB8K3uOvy892cRdUA9Ue9F42BkxN2
FOdaf7524JunHU3BZs7iAVP2IPIL9DM7X2dgA2XR46f2zoG/3laa6igik5fLsaSW
+d2fBOePZePNcIIo2kNJuTQx763y4IDni0HGntHmIfEVYVdhvwNmBFVwW2ZLcTMa
xqiZaLJ66wBmtNioCjXnN7Tte68hA2VS6eSw0YNriJGVWqeuSQsFGcR/tZry641t
4ALvJ/L9hGQiFRezpuZI7pOsG/zRNtKrFdB7fyxeDWdc3vWzvWYcrUPINOB3TW53
13HOFjzu1pbWNp0tORfqFihz11eU4n6TKM1Rhzuqkw1GnLIr54euBCnYTep8ZcFu
g4mfuZ65nP0QIuNsgFs8+j9vwT6v0AWdr7FbLwmUsae1L747ks4=
=vtw7
-----END PGP SIGNATURE-----

--oYq9vOgAm50vohTR--
