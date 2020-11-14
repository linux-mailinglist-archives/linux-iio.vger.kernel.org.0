Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F2D2B314E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 23:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKNW7L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 17:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgKNW7L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Nov 2020 17:59:11 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BB3C0613D1;
        Sat, 14 Nov 2020 14:59:10 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id b16so9839144qtb.6;
        Sat, 14 Nov 2020 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZJV4itcrkzo0iqqlIyzwiAWmUlMWobk9rPKCYueitq4=;
        b=NpPw9VlTVt8vCy/GNWXCZV8JbNSV7GH4dGw1Mm1f5Up+kz+oWR564W88dXxqZFN86j
         GhAJ81Gw7xptZSGp0I9Dy2zqK+iEMFT6VRqYuzBcp4ky+kP6xhXLZRpWM4BzdoDnjBG2
         zZ2qta7/baXDQCIbO711u4YQNlM3846FkmJNGcyx6meo8pOGUEQF/mHGQ2N/UBAZz8js
         FVgb965DXSPc15a/9kYMqBv+czkmfO6KTLmW0ejqcndIMrOPleq9AOyYsc/HWXyhybq8
         AnhMxFbeTpnwLYZyvV6oln+zpBTwslGAWMOZsn4SP4FtMZPtWlRbgke0I/uDN9nGvJVa
         KThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZJV4itcrkzo0iqqlIyzwiAWmUlMWobk9rPKCYueitq4=;
        b=mPLCcqwF7Ftqla/+fZKuTvS5N60C4CZs+deUPEBkN2Ofm9LK5hbB94WhESjzTwKpef
         bl14a6ufbHUbvzV2sLiJ8GpnJ6nvrUH+Y5coq01cKdMDTog/+dntqZi0+hMM1vJgdDAj
         NO0IH1DeAn9WOJHthzLdiZyhythGXb7H2Q6TD2Q96Fi8UpEHSa20F0PcUFtcNDig0A65
         XY/BeAP1c/R1DEd1X8/zFFqgTyFEZQvJyJeY5kHs+1wd4qw/ae6FzE7K39JTaCvYZ/j/
         Xt/YFOBuQ5p4YYHm3WPYeNy2wAuQNYNf7TueAFFCVsG0IU2Jn01ocigxDZyim+FP8Zg8
         jRng==
X-Gm-Message-State: AOAM5327rUimNArt+qgQvUU5aIWfVbwBeNaoVMUhWYud1IjHPqLNMrQK
        Vq1os56lXq3SxoOf2r9FB8A=
X-Google-Smtp-Source: ABdhPJyFwsjl87sgx0iBIp7qQbUS+rVsGz/N1pgHSjdcO5CPXSFU8viOv3ofHohCg5ggBMTmuJ63bw==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr8304427qth.123.1605394749978;
        Sat, 14 Nov 2020 14:59:09 -0800 (PST)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id 9sm9995356qkm.81.2020.11.14.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 14:59:09 -0800 (PST)
Date:   Sat, 14 Nov 2020 17:58:28 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix CMR value check
Message-ID: <X7BhFOA9uPAUluv0@shinobu>
References: <20201111163807.10201-1-vilhelm.gray@gmail.com>
 <20201114224827.GQ4556@piout.net>
 <20201114225113.GR4556@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LF/5iLACl9VFrJcf"
Content-Disposition: inline
In-Reply-To: <20201114225113.GR4556@piout.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LF/5iLACl9VFrJcf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2020 at 11:51:13PM +0100, Alexandre Belloni wrote:
> On 14/11/2020 23:48:28+0100, Alexandre Belloni wrote:
> > On 11/11/2020 11:38:07-0500, William Breathitt Gray wrote:
> > > The ATMEL_TC_ETRGEDG_* defines are not masks but rather possible valu=
es
> > > for CMR. This patch fixes the action_get() callback to properly check
> > > for these values rather than mask them.
> > >=20
> > > Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> > > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >=20
> > > ---
> > >  drivers/counter/microchip-tcb-capture.c | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counte=
r/microchip-tcb-capture.c
> > > index 039c54a78aa5..142b389fc9db 100644
> > > --- a/drivers/counter/microchip-tcb-capture.c
> > > +++ b/drivers/counter/microchip-tcb-capture.c
> > > @@ -183,16 +183,20 @@ static int mchp_tc_count_action_get(struct coun=
ter_device *counter,
> > > =20
> > >  	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr=
);
> > > =20
> > > -	*action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> > > -
> > > -	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> > > +	switch (cmr & ATMEL_TC_ETRGEDG_BOTH) {
>=20
> BTW, this could be simply ATMEL_TC_ETRGEDG which is the mask.

You're right, let me resubmit this patch with that change since it'll be
much clearer.

By the way, microchip-tcb-capture.c is missing a MAINTAINERS entry. Is
Kamel the maintainer of this driver? I'd like to get a proper entry
added so we have a point of contact in case of future bugs and changes.

Thanks,

William Breathitt Gray

--LF/5iLACl9VFrJcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+wYPUACgkQhvpINdm7
VJJI+hAA6HMTVn7T0kWkHIRa+CGFPliJYVMVECIiMeMVFSzfB8b//RWxSoYUY8Cr
Oj1fCgZT/pddPB9kcvLkycgFrUJN1dO3MHvYtChn67moUIK2WdIRYXVKUNlpyOy0
cIzSznULfJYcqHYVROIaIjgBpLtQiBhsG857kqSxCni4UOWMjWHPnNU+XXPAy79U
ORp0XAgViBrGpT1cD9z3mXO9TdIP49fm2An2rORC5Eu8UPMk+cpBKekhk+VwURUj
H2T3Q61EwxH2iicDHip7rRzSlKQEDvXghIWYCzlLhJ99V+sOBaZD7qbO+FflOjJp
T9z0+q3tuXhSrwQ6mWvISLVOddf2q2HcgnW2W45TUO4jyxlVXwIKWpwTsF+PKjBF
tMYlrojud53CGe+jqA83baBEUw1k81Fioo5Tr7jjaIu3jRBN/clzIx4ontwU7rY8
et4OidOH/10ozD9ABffQOoOTDz/2jD6Ub+iQGNnCAVcOZJD8l29LjOIr1AldmeM/
7ssqDXHI6f8FKxZDjjfcKlhFhEGrribZZ8/r1YdpkZgQkZ+35nH4gN9W2WOGZkrP
lLd0z1o1ygkkhm/uQ0FDIKes4qoGPzwCV4u4d1BqW+DOTo5JX1pFZhXivqhkbVtw
ux5Y7OIEeHjXQ+9xf6IToefeJ30zrGHI4tWgrI8bhnV0nY4geUw=
=1W7P
-----END PGP SIGNATURE-----

--LF/5iLACl9VFrJcf--
