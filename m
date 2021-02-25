Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6776325A38
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 00:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBYXdu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Feb 2021 18:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYXds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2021 18:33:48 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02CC06174A;
        Thu, 25 Feb 2021 15:33:08 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id ba1so4112987plb.1;
        Thu, 25 Feb 2021 15:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bryi5nIeAqPN6gv7PQEAJOmSmh8foFZDgMCzK44/Hyg=;
        b=iqG/f6sZQa2houoo+VxHHF5MXsX3q6ya/wwhRKCc0jn/JbAnFB2nwn6AcRC+SMb8by
         TtrQtNyfQLBdLC/7ipEnKQMfykNO7XppSRejPMrIAI42mzlddkR4Va38kmWC/dOZB9Q3
         yQW81DF+qMabSjoY3OIDOsEtdv9q8R5ISUZ9OWeos27i6/ounQu/uOVvTXEUVN5hmqY6
         d7ndpm/Mvctmq5r6ewk5IAPWvqhsrbrcnnwAI4QZ2AVAD6mAjTOtd1//QPmJGUZkOJ+N
         a5X290eJgasRN/rkCxp055Hbb+DIQOTEEP2DFwWZomTMZQIT6OT5ZWNwn0wLIwQHwHVL
         oT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bryi5nIeAqPN6gv7PQEAJOmSmh8foFZDgMCzK44/Hyg=;
        b=J087Ub/HpD7cPBBLovCtld2t0eORHAAStXqEN5VTgqMIbcwZQIpWr4AvXUmArEJmLh
         rZtlx3iC3zehRm3asbgef1i2oUN0rbnwI4bmLCMC+KBdi8d8WpK2b7LuA6gWqd6qG4Ug
         5WCu7SbFAg1NwHpq607Ny8JPBQTtcyaFDe4YcB8T6g3+5hgl67ywcFWERNZiLznNoJ8a
         HnIywQxQdhsjGLMHPESihNZ1hf1sCglJmYJ8IRnJo28hzFsyfY9j4eh098CmBk13wQFQ
         3D5N2dU2aiBXtJ+Rz/zlkbSJgWWbQzyYiAAkk7C+AU1Eutr1fx+3G4WMc9IlLRoPt6Uf
         a02g==
X-Gm-Message-State: AOAM532Lvcg3ftEKAHLJ+wv9UrAkBUboTltUZcSW9I8f54MK3c7rvxlk
        fpkxkyseffJmeX5539CuDGI=
X-Google-Smtp-Source: ABdhPJxMEOKq3iRqEYUSu0q+taLEkz0dkFYCzdzEkJXmSR/VAt/A+73uvo8HhMqtFBoeA3pTOYRZhQ==
X-Received: by 2002:a17:902:c407:b029:e3:cfa7:e300 with SMTP id k7-20020a170902c407b02900e3cfa7e300mr203101plk.49.1614295988431;
        Thu, 25 Feb 2021 15:33:08 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id 8sm7577762pfp.171.2021.02.25.15.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 15:33:07 -0800 (PST)
Date:   Fri, 26 Feb 2021 08:32:59 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 19/22] counter: Implement extension*_name sysfs
 attributes
Message-ID: <YDgzq6t5YRm6cFvO@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <c9b55d1cff6acac692a7853b0a25777ecf017b12.1613131238.git.vilhelm.gray@gmail.com>
 <20210214180913.05bd3498@archlinux>
 <YC98GTwzwt+pkzMO@shinobu>
 <20210221140507.0a5ef57f@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5C8206GHyZn93ao"
Content-Disposition: inline
In-Reply-To: <20210221140507.0a5ef57f@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--g5C8206GHyZn93ao
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 21, 2021 at 02:05:07PM +0000, Jonathan Cameron wrote:
> On Fri, 19 Feb 2021 17:51:37 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Sun, Feb 14, 2021 at 06:09:13PM +0000, Jonathan Cameron wrote:
> > > On Fri, 12 Feb 2021 21:13:43 +0900
> > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >  =20
> > > > The Generic Counter chrdev interface expects users to supply extens=
ion
> > > > IDs in order to select extensions for requests. In order for users =
to
> > > > know what extension ID belongs to which extension this information =
must
> > > > be exposed. The extension*_name attribute provides a way for users =
to
> > > > discover what extension ID belongs to which extension by reading the
> > > > respective extension name for an extension ID.
> > > >=20
> > > > Cc: David Lechner <david@lechnology.com>
> > > > Cc: Gwendal Grignou <gwendal@chromium.org>
> > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-counter |  9 ++++
> > > >  drivers/counter/counter-sysfs.c             | 51 +++++++++++++++++=
----
> > > >  2 files changed, 50 insertions(+), 10 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Document=
ation/ABI/testing/sysfs-bus-counter
> > > > index 6353f0a2f8f8..847e96f19d19 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > > > @@ -100,6 +100,15 @@ Description:
> > > >  		Read-only attribute that indicates whether excessive noise is
> > > >  		present at the channel Y counter inputs.
> > > > =20
> > > > +What:		/sys/bus/counter/devices/counterX/countY/extensionZ_name
> > > > +What:		/sys/bus/counter/devices/counterX/extensionZ_name
> > > > +What:		/sys/bus/counter/devices/counterX/signalY/extensionZ_name
> > > > +KernelVersion:	5.13
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Read-only attribute that indicates the component name of
> > > > +		Extension Z. =20
> > >=20
> > > Good to say what form this takes. =20
> >=20
> > Do you mean a description like this: "Read-only string attribute that
> > indicates the component name of Extension Z"?
>=20
> My expectation would be that the possible strings are tightly constrained
> (perhaps via review). So I'd like to see what they are and a brief descri=
ption
> of what each one means.
>=20
> Jonathan

Okay I see what you mean now. These names will match the sysfs attribute
filenames. So for example, if Extension 9 of Count 2 of Counter device
is /sys/bus/counter/devices/counter4/count2/ceiling, then the attribute
/sys/bus/counter/devices/counter4/count2/extension9_name will hold a
value of "ceiling".

The idea is that the user walks down through each extension*_name to
find sysfs attribute name for the Extension that they want. When they
find the desired Extension name in say sysfs attribute extension9_name,
then they know 9 is the ID number for that Extension.

There is an alternative design I was considering: instead of
extension*_name attributes, we could have each Extension sysfs attribute
have a matching *_extension_id attribute which provides the respective
Extension ID. So for example, using the same Extension as before:
/sys/bus/counter/devices/counter4/count2/ceiling_extension_id will hold
a value of 9.

Do you think this alternative design would be more intuitive to users?

William Breathitt Gray

--g5C8206GHyZn93ao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA4M6EACgkQhvpINdm7
VJIBCg/+JWYA6xMb2Q9RpprWLkpN2p4IE7zL9kEZE+WzE6aHG1+usGMbF3AQMIO9
LqssPDGtbchunSQk7RHkT8OMuUXIRaiIl1tE1Lefh+Tylaf4+VLbJo1t+I21MmLr
LZDV8vnQnwFjhZhPgfOJo+dnOY1SldnRcZzfER607uWOb3xtVpHsdpWaS+IMwt6e
Yn0Qe8URcv05YGrw4N2re9HtNU01hwlMTyKst7pNyY15MRwmPI7c9sBWC8nWKaCZ
butQTV3VGDUA3VZ/DVwo0aOZ8HFbWsOpZKGII2IGNIvVgXBCKrkIw1W9wX9mHi4t
s5uuIW0XBys3SzaxqV/zzV2jtQy/TexhjLMBELX+4M4WMeAbAGoHUA337QoI3EP1
Z0b28249Cax2iddXR90cisXqYMd8F/9fCaMzgR3lQF/pC3wB9LCk9JhCPaogtRRC
ZleiZZA3/cgnYFiUlOcb4mfQGlxOSk2fs/EoXdfKVbmuxaHddiqFZJxImv0TnrWg
Gag0WcYipOglgAQyJUwP36FBerkcqUc463KF7BtSp3in5YMPhR5xgOxS3nlK2rKO
ySKzH/JjLsIQ1vaKb/Z42sPNJ+7XANxp+Wuoz2kKwHWevljJybwJG+AAIwMlyrqc
osUnIPljV010+LeG2LU9AS7tdrN3l49nDY6XS4ITC3HXeTHIzuo=
=IeB7
-----END PGP SIGNATURE-----

--g5C8206GHyZn93ao--
