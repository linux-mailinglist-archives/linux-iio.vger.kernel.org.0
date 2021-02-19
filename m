Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFDA31F615
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSIwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 03:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhBSIw1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 03:52:27 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEAC061756;
        Fri, 19 Feb 2021 00:51:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z68so3439821pgz.0;
        Fri, 19 Feb 2021 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZX/0vn+4d0GadCfE6C+zcMHKBe8kMLF0TT0FFLEZWko=;
        b=gp4UIalZOAkD+9D6/YZrYAsj+BWkWdjYpymhbfYsJdSc12qD46kAFL5uvCxfrFjTbW
         NcDYnMQx1ZWnR3ySqHQa3vtiWKgIcZVF3XZJd9w4bkUwiOdkKPZoLlLMmOW2vIDLKfzb
         7zjfoWmNZG7CeLrWRX09+llAZjfJqGUvPME8IT+n631hYDJmWqsMDAvgJSUKgioqBMOT
         /tI+Jdo3RCp3jQ4QioB0NrgHMFA9A8XPPgvDv9Ey+E4FLGUribU3P8NorDCvTXkE9wyx
         1Je/Gw/CDt2XdROS6IEmxswI4ITvAXcHy9uCGGxcdokOtjn7yP4hUSA9rOFvAZFnsTgp
         I22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZX/0vn+4d0GadCfE6C+zcMHKBe8kMLF0TT0FFLEZWko=;
        b=UREsU149zeudQUZay8akY0MNFnp/TgpZNYhTdIcRKaHs4P3jWsf1C3BSfzoFU3iJ7K
         uSYvLAakIMWGDYhijckqxf0RuU1kb42O/MQuXgBt5KRL+jRfsXlaN6RAVJVECpX6CFCW
         XP+BMEDlwvfmk60ZaHGY5A1TMfAApqLXvrxH16pvuTjpImIvMoiTpm//j4sjamVPrXM2
         hN1Bzf3clDHPtq4201AXQUf+Y1aeJYMsyn/dBvxk0dPVMB7ILl44/EuB3QJfNPsQze3h
         QawF/0sR+OIvAbAiLOwqhyQSDC/XrzsUyjb4HvHRiqRWDOecelOJJWcpgXaRAWukBDDy
         20Gw==
X-Gm-Message-State: AOAM531lvrPIfC3M8Sgu0uaPefKf4/77aB+97xONpiFIQTWi4zc9IpUO
        pPi50GaJpo+LN7liBaOVqg4=
X-Google-Smtp-Source: ABdhPJz1tkjQ5wEB6PWfTQeIvZWmVYTed76QBMR8Bc1Hd5itPLBAQDEmnH8GyFqWxdto3uAN+Stk0g==
X-Received: by 2002:a63:ca45:: with SMTP id o5mr7730598pgi.48.1613724706449;
        Fri, 19 Feb 2021 00:51:46 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id u20sm8301896pjy.36.2021.02.19.00.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 00:51:45 -0800 (PST)
Date:   Fri, 19 Feb 2021 17:51:37 +0900
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
Message-ID: <YC98GTwzwt+pkzMO@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <c9b55d1cff6acac692a7853b0a25777ecf017b12.1613131238.git.vilhelm.gray@gmail.com>
 <20210214180913.05bd3498@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z+ATVKzf56OJTET9"
Content-Disposition: inline
In-Reply-To: <20210214180913.05bd3498@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Z+ATVKzf56OJTET9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2021 at 06:09:13PM +0000, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:43 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > The Generic Counter chrdev interface expects users to supply extension
> > IDs in order to select extensions for requests. In order for users to
> > know what extension ID belongs to which extension this information must
> > be exposed. The extension*_name attribute provides a way for users to
> > discover what extension ID belongs to which extension by reading the
> > respective extension name for an extension ID.
> >=20
> > Cc: David Lechner <david@lechnology.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-counter |  9 ++++
> >  drivers/counter/counter-sysfs.c             | 51 +++++++++++++++++----
> >  2 files changed, 50 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentatio=
n/ABI/testing/sysfs-bus-counter
> > index 6353f0a2f8f8..847e96f19d19 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-counter
> > +++ b/Documentation/ABI/testing/sysfs-bus-counter
> > @@ -100,6 +100,15 @@ Description:
> >  		Read-only attribute that indicates whether excessive noise is
> >  		present at the channel Y counter inputs.
> > =20
> > +What:		/sys/bus/counter/devices/counterX/countY/extensionZ_name
> > +What:		/sys/bus/counter/devices/counterX/extensionZ_name
> > +What:		/sys/bus/counter/devices/counterX/signalY/extensionZ_name
> > +KernelVersion:	5.13
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Read-only attribute that indicates the component name of
> > +		Extension Z.
>=20
> Good to say what form this takes.

Do you mean a description like this: "Read-only string attribute that
indicates the component name of Extension Z"?

William Breathitt Gray

--Z+ATVKzf56OJTET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAvfBkACgkQhvpINdm7
VJIzrRAAiZ+eMLbJ0vaW9ezjJpkSnHfiyB5JKIbYfzn7RticBncbdaXLrFHbq9y/
cWxBrgijMQ9h2SwX8gW+ovh6u7cfCW+FFvLtS9UAb9jiM/jTangdAASyMmjLTFDb
04zodzHmS88tT+Wd5AQICiAR3MRAglHfyED3Utq2DSDvSkgB6vMo3JfuVrdQaKaS
haOt0+djMIYtjoqk6HuvokA3Fwq4SBh2Ey8miBy9TXedsiMpeEMv7BO/rOoMIyJH
OsKqnvQVR0OncdCYzWL1ENnu8NQo/4GIgDrwHTQXMTYXune1u8oM8vAkLXeJ8tlU
TLUBRTjQaHt5E5Qz+vyxYsahSyZ6G/qDJ4oDRApSpfHhXuZmF4a1yqzzWOoFviuh
kqubzCcDzYb5svEbp1T5N9Wqi1Q4By8r2Y3JQA6kt4Y0YGqlRZP5uMbwS0kvplYS
AMqnslpxOWbEBQgxpjEHhAP3iB1yHmopGBvBWJX4X2oTOslVK9tv3BpRXIHDOCz4
1+cxy4DNAS0KdskIv0jOhEfbyPzEYi7n424aA+Mhgs0LSgkDjCXw4WqPmJX2CS+Q
pCgwMJfgqW61pZBeMfv6HaqKw1DKzESf1DUrqgWry1zvdO43xozbqdvat8iAJO/N
UIm9sFwsQDTAym3cvbPuNCePtvb0rqN7Wo4QnZfOBHBa+9Oifgc=
=Rifk
-----END PGP SIGNATURE-----

--Z+ATVKzf56OJTET9--
