Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A49325DD0
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 08:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBZG7c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 01:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhBZG7X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 01:59:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E95C061574;
        Thu, 25 Feb 2021 22:58:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id v200so5654038pfc.0;
        Thu, 25 Feb 2021 22:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Fjv+Mg1IirWBDNHEKw5akbiHL4HaXzu4m92i4TVus8=;
        b=uuQUzmsZzBHr6oJXZHn3KJjD6zPx24UHtm1jYJjHO2T5lAZwaWzzF3deH+To9oQOvv
         MRt0s7BI1/Gc4bprjWeQncOEKU3KJwotP8z2MBF6DOyYsHq+93qg7YA2n2gvLPv4wrV7
         uZpgy5oDHsfys2RadBQSt8jq2uyUC6ybYAReiQXNAta4QXXD8LbDFdH+WTKlCC8XlK+F
         Axe0XJ6WA/cgixAjP12FLOHLxzxjQSrcOWDe+T/h5OtNdtkC9OF/oNCs0gkpVS9gRB/C
         FyLzOKlDRoS9YhRhijHpEWq5zm0NNDOULaDBk/bjUadzGmbobz3SMsqHZOF9gqFGtTBS
         cfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Fjv+Mg1IirWBDNHEKw5akbiHL4HaXzu4m92i4TVus8=;
        b=IbhkJxOulWqW4VPu8WMrp1wdqYUw1fVwJ9cMe82pU2ayG2Xq0QJ5GyFVrnE3Cw3S1k
         Ak+St+y6No2Xzd6hWZzm6nMjBML1nK9A413CH1lIHptHjHi6VVIj6/2J+pofPBe8KN0k
         qabi4LCxDL3pjkVSgQoc6gboBzGbfNaZnb/ot+7h1vBn1iiLA/Yve+cVUxYggN9ojtkW
         v2kvt/7NYcFWCHe3UrPnVXZ+UGTy/P1m0g+gT/ObqmsNSftk8YOTzX1AL7e+UPcWBPTY
         9DLARLQzQeCG3IfGaXnOHbwIHSwOVNQ1o7Jbz946AsWlmdLM0LeHKEa+CgdgnaYqCFwB
         oN5A==
X-Gm-Message-State: AOAM530Y1dX83WxVdEZXEjg8FXFFholU5a4KzPpDxZ2N8cfk4a4NgRGJ
        v2kdMW4wielL3GeAc+W53tA=
X-Google-Smtp-Source: ABdhPJwZTjVfJEYyJR7dc7yd/1oHzucRgSSV9m6dclvd77VfundjDQL9uafKAPGuggW8eBCWtA4VNA==
X-Received: by 2002:a63:490d:: with SMTP id w13mr1678390pga.314.1614322722709;
        Thu, 25 Feb 2021 22:58:42 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id b18sm8529406pfi.173.2021.02.25.22.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 22:58:41 -0800 (PST)
Date:   Fri, 26 Feb 2021 15:58:36 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <YDicHHebw9scA7to@shinobu>
References: <YCjlPhEtyH+vfSi4@shinobu>
 <20210215091737.fx6dwiz7tt56wbkr@pengutronix.de>
 <YDMMJJ985Zq9oEOv@shinobu>
 <20210223100656.efbshsh5bz66uhj5@pengutronix.de>
 <20210223174516.wjlh7hnrd5qe5s6w@pengutronix.de>
 <YDW7Hihg0gGQh8UR@shinobu>
 <20210224073506.GA24260@pengutronix.de>
 <YDYKF7zdyjZX30gX@shinobu>
 <YDYMRVgC3BrjISKU@shinobu>
 <20210226064601.io6tznddikhcmvb3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pis9j1JpD2v1lmaJ"
Content-Disposition: inline
In-Reply-To: <20210226064601.io6tznddikhcmvb3@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Pis9j1JpD2v1lmaJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 07:46:01AM +0100, Oleksij Rempel wrote:
> On Wed, Feb 24, 2021 at 05:20:21PM +0900, William Breathitt Gray wrote:
> > On Wed, Feb 24, 2021 at 05:11:03PM +0900, William Breathitt Gray wrote:
> > > On Wed, Feb 24, 2021 at 08:35:06AM +0100, Oleksij Rempel wrote:
> > > > On Wed, Feb 24, 2021 at 11:34:06AM +0900, William Breathitt Gray wr=
ote:
> > > > > Alternatively, we can take a more generic approach: ignore the GP=
IO
> > > > > names and focus solely on the IRQ lines; because the GPIO lines w=
ill
> > > > > always be tied to respective IRQ lines here, using the IRQ as the=
 basis
> > > > > of the name should always be valid. The "name" member of the stru=
ct
> > > > > irq_chip can work for this. I haven't tested this, but I think so=
mething
> > > > > like this would work:
> > > > >=20
> > > > > 	cnt_signals[0].name =3D irq_get_chip(priv->irq)->name;
> > > >=20
> > > > ok, i'll take a look at it.
> > >=20
> > > If that doesn't work, then use devm_kasprintf() to generate the name
> > > based on the IRQ line number. The idea here is that the user should be
> > > able to identify that the Signal component for this Count is the
> > > respective IRQ.
> > >=20
> > > William Breathitt Gray
> >=20
> > I realized that these irq_chip names are often just the device name
> > which isn't very useful either. :-(
> >=20
> > In that case, I suppose we really are just left with generating the name
> > based on the IRQ line number then. This should be fine then:
> >=20
> > 	cnt_signals[0].name =3D devm_kasprintf(dev, GFP_KERNEL, "IRQ %d",
> > 					     priv->irq);
> > 	if (!cnt_signals[0].name)
> > 		return -ENOMEM;
> >=20
> > I think this would make it clear to the user that this Signal is the
> > respective IRQ (whether sourced from GPIO or not).
>=20
> ack, with one correction. cnt_signals should be allocated, otherwise
> this value will be set per driver not per device.
>=20
> Regards,
> Oleksij
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Yes you're right, cnt_signals will need to be allocated then because
these will be different per device.

Thanks,

William Breathitt Gray

--Pis9j1JpD2v1lmaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA4nBwACgkQhvpINdm7
VJKExg//b27mkhYXkMNHzSL6sQeEllxjr3OIkBcSDhPQAzVH5SGVTO1q4Oqeo2YZ
FXLwk3LeKc/gewbqqnE/cBOgWT7iySRUp8ppBtjarqr54ftpKjtV4zaLGzeveoHB
wZpu1FzOr0FZs85CO3xJVzPALZtqdOtSgXkOn4fV3Ee6Oz4DQuHND5Jlqm0gkyFV
FRedDngp7sCN3s8k5y7V/yvaQlrkrNqyn9lqY+hYc+F/uSfg5ODSZlicNPe/L0+8
bPqy2fV0bRr7iCgCadlAMZn9fmv0yPMcrvW5QMbcQaSP9KJZe9oXaE+ockD1mKY8
OlvFMaimQYe2PHVCCIRTqea8YGbB1BUZLMvFKSDG4OvB2yqZWIqWq0vxmcOjhSwN
RIdzDVbvfpGOZDpAizW1Upe3ctgy35Bff7QYob8kHkL8CdxLeNhkteTHWUvJjzMN
qrk0jfboNVNt9BCTP9cpj2kxFet4d4541KFijLqPoQas2+x8qRM0htG1ZpWP5Cve
beR5A8HOd7NXZzYiy42fIO510ySfUvs3iX5YHh1gZRcBYnd8j9sO3ojbQmkyKQ79
U2EUPEVwws3OIfcd6/jMc2QwWtzTsSHq3OU/SP762nv2IO+/P5Il6NYS1cSOAMC8
3xl7WlDVnmvxjQQ6QXR97qgrC4ufBtekqdH3+wqV00MYnxNb9DU=
=MF5Y
-----END PGP SIGNATURE-----

--Pis9j1JpD2v1lmaJ--
