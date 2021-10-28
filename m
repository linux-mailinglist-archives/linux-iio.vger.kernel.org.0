Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA943DB5C
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 08:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhJ1GoV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhJ1GoU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 02:44:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157CC061570;
        Wed, 27 Oct 2021 23:41:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v193so5046635pfc.4;
        Wed, 27 Oct 2021 23:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AcoyO3fMqMwG0fK4IuG40aw/93zEYFu7HuO/R5EsPcY=;
        b=CQJqNLMiJnWlBD6YwI+cWcf93Yw5P0fsrKsluED401WI4v6CNT6LO3B8lRFoqHORCO
         F/QDRRQJgkW2u38bl+P/A8auuP34FZADO/rBq51Rv5EzorLvBipDwpj11HnT+24wWwmh
         d0hIIwn9Dx/W/MSb4lrzh6iKPlO8hOof/XoNPBqxcouNGBsyaCyaUbPb3be8/xaz+PhW
         b2uY5ohSoTGCmOnkmu5LC9+rzHTDt55u40zln3hmKA8+0+yDymRL5RrVWLueJMmnmz9O
         UP7RFaGHfaubxnK+jN4c5GpAXXNWelOJHcARRFvMYSE3gvzmJrptdjMPBOtgQC36IECh
         pzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AcoyO3fMqMwG0fK4IuG40aw/93zEYFu7HuO/R5EsPcY=;
        b=MozAYLo+7eN6a8N7z2U1v2rBIAmN6qzGnIZG1lA59aT12aNi/bd18QOrrCdewQmVuV
         DzJBqWAkLTooTdXLQo6Vu0v1f/Yr1DAnUHtxiSuxaBpqSZTKZVVesvB3A6afI2ByeVNX
         jk3rN7pf+q5anIatRRdU+y/qXMJ6YFsgcWerMZeMtev+Agf3IKR610z2mqAz8+61UD73
         V9B/mZH3nr9Qfk40/zlB/kz+V4yxL3M4c5HZ802PsgnZi9c1A+bY7Xq5EQFXOjDbmC1E
         YLKBLvjC8f6vDRcod91InSgY+aKtcJecVdVbaZWshN0EfmCUM3v5yDV8ASGSLIpeSE21
         X+/Q==
X-Gm-Message-State: AOAM532vCGwSEHe96mueSs6vgn7M062VZHtR5i3Mni3z95y6pybHwhCy
        WjWa127H27pWPGU7X/mGYOs=
X-Google-Smtp-Source: ABdhPJyKkpTBK+phBesVI50fNl6X8PpBFxn5Sxs2Ss8oYZ/ndNAat+QhQzkV1hEBDGOWjxk+ZyywDQ==
X-Received: by 2002:a65:6187:: with SMTP id c7mr1863381pgv.317.1635403313838;
        Wed, 27 Oct 2021 23:41:53 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s7sm2206150pfu.139.2021.10.27.23.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 23:41:53 -0700 (PDT)
Date:   Thu, 28 Oct 2021 15:41:48 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] counter/ti-eqep: implement over/underflow events
Message-ID: <YXpGLMjXImwEVJGY@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-2-david@lechnology.com>
 <YXZZCn9O4xSTHMx5@shinobu>
 <1d9f37b9-8600-1d8c-09ff-b9d9cc592b26@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpqsm0+SpoU9L8kM"
Content-Disposition: inline
In-Reply-To: <1d9f37b9-8600-1d8c-09ff-b9d9cc592b26@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--fpqsm0+SpoU9L8kM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 10:23:13AM -0500, David Lechner wrote:
> On 10/25/21 2:13 AM, William Breathitt Gray wrote:
> > On Sat, Oct 16, 2021 at 08:33:36PM -0500, David Lechner wrote:
> >> @@ -260,11 +333,17 @@ static int ti_eqep_position_ceiling_write(struct=
 counter_device *counter,
> >>   					  u64 ceiling)
> >>   {
> >>   	struct ti_eqep_cnt *priv =3D counter->priv;
> >> +	u32 qposmax =3D ceiling;
> >>  =20
> >> -	if (ceiling !=3D (u32)ceiling)
> >> +	/* ensure that value fits in 32-bit register */
> >> +	if (qposmax !=3D ceiling)
> >>   		return -ERANGE;
> >>  =20
> >> -	regmap_write(priv->regmap32, QPOSMAX, ceiling);
> >> +	/* protect against infinite overflow interrupts */
> >> +	if (qposmax =3D=3D 0)
> >> +		return -EINVAL;
> >=20
> > Would you be able to explain this scenario a bit further? My expectation
> > would be that an overflow event would only occur if the position
> > increased past the ceiling (i.e. increased to greater than 0). Of
> > course, running the device with a ceiling of 0 effectively guarantees
> > overflow eventss with every movement, but I would expect a stationary
> > device to sit with a position of 0 and thus no overflow events.
> >=20
>=20
> This is just the way the hardware works. I discovered this the first
> time I enabled interrupts. Even if you clear the interrupt, it is
> triggered again immediately when QPOSMAX =3D=3D 0.

For this device, does an overflow event occur once the count value
increases to equal the ceiling value, or once the count value increases
past the ceiling value?

The Counter interface defines ceiling as an inclusive upper limit (count
value is capable of reaching ceiling) and defines COUNTER_EVENT_OVERFLOW
as occuring when the count value increases past ceiling. I want to make
sure the ceiling extension and COUNTER_EVENT_OVERFLOW events for this
driver are behaving as expected of the Counter interface.

Let's use a non-zero example to be clear. Suppose we set ceiling equal
to 10. If count is currently at 9 and increases by 1, count should
become 10 and no COUNTER_EVENT_OVERFLOW event is expected to trigger; if
count is 10 and further increases, count should _not_ become 11 (staying
at 10 or starting over at the floor) but a COUNTER_EVENT_OVERFLOW event
does trigger. Does the driver behave like this currently?

William Breathitt Gray

--fpqsm0+SpoU9L8kM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF6RiEACgkQhvpINdm7
VJJsdg//XNpg5+MylMoEuMbf267Io3LNZosnfL/H1diyxxoXDG5hF6YiRftwfYZ/
KzYj9bpxmEpKwFpLUFfFCnfdSGfL+kpHRaPINCk5ov2jFRoiPZGGE+tmf03oemlo
OxMP68ly/NoFQS5egtQiGEHabi5h3eIdu0Ky6N23WboRZs2UIPVg6zq3aXVMIxW/
CfDrQd8dpDhW7Uj+WNO7jABBkanWs9n5paYRz5EDH1T+HQtBJjlYtpbyC4VxYo3B
TGCrbjg7+nbafnqw/51krl/Gul9EqwrE4S5+uqbr4UVQJijUybhutD3tMSe6jKBD
mzEabKLDLWKHTjRqpPgf8YlEec8jTAvxddCCuoo3H8yqi1jvdn0oMcWPiYYBkPLB
j9rhYQgF8qe/CAThxbo1pypbXRPdPOr3HLannovCyMLo9kLi/AS+fU9Z1lF77SFb
YZjKLNy5AeFeatP3Pve0aNBxoK3MRMIB+ollCNcYBZridF1S95JUGciiB3sz2H7e
Qrb7EUxP2yLT31HuPHKYMGbOin5S31pSJxirNyRzbwNsGsKU04DdOCRrhkM0hnhM
aFKy7BEAumwibahHy2jKfzrVbM+jKpRpLV91RuOfry568jIHwP/sDZ68f+f30tCg
th+q84IGmtjDR1UtKRGZb6baAmMXW4r6nE5ktKRnq1GbgvxgOAc=
=VDA4
-----END PGP SIGNATURE-----

--fpqsm0+SpoU9L8kM--
