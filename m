Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB02231E95B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 12:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhBRLye (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 06:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhBRKRC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 05:17:02 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C9FC06178C;
        Thu, 18 Feb 2021 02:16:17 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id w19so1488424qki.13;
        Thu, 18 Feb 2021 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HqYkgCpjSPW+7F/Sy105/jMqMoKMqyjH6uBkL+9+REE=;
        b=bjHLCgEvzSj1u5NBEHNFSvRURMSBA4NFzeJ0zvH7t4X/PKfX7qN1JrT6++1lT0JoWJ
         LmEcbURYbtwaqEE4L2B7KodzoBozVMmIpnDfLqFdaQcr+31EeeryX2MK/SJixTVmnsIN
         4i2LYzoQNoIzJZpEHmbGcpkw4xJcAPSWy2Wg/KDKP/LYgDrP20fk3GNMOdmEBaUaRUTW
         bjWNVnO3HUAaNZzZJXPn9miGyjJswC7r8OWuzBweHmqOgGjSuiyjU164ExByIH7agxLh
         HbwZ0wpm28/Iyn67JrpBVzb2bIEeEiGpraeSIvW0EK+CZMg8gjIsUjboZh6eYIFdcoP7
         9eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HqYkgCpjSPW+7F/Sy105/jMqMoKMqyjH6uBkL+9+REE=;
        b=ZkYxkHvISGfnLttdkrcthVqz4uXdtrYE4op78uFByOAo5xC4D5xjJQ4USEnUnPui2y
         wckuAaYHj1ePq26aKKB5LJ8mCMXuoxdsSobwOXfTyhP96PYWESZdTdPQUzIg46TrGGGK
         X4x8ddaTm/kRTTLrpzgZNHDs2TCTFomqy7SsTI+u8xigjziL/ElMxF24yCPbQxMmmNrI
         bMP49MFpQiouHQNUfIqQV4iAqPjzhqvlOcChT30gYQQLxoU3ZwjqaWYfTuqdZJ+xPHxd
         Fu1dsFKVo/O/tgX1pcbcHXa5Pana13LFCiv93L8vuPt2ojOcndPQCGlBGmy7/YqQsjlh
         MkxA==
X-Gm-Message-State: AOAM531gWxpm0oiIyrMsrnbsCqrYqnVWw82XxOufsVVRGXlcE4BtWKu2
        sdZSoFG4/kgdTzHgxwkJ180=
X-Google-Smtp-Source: ABdhPJzwf7tAcl8J6SrMTdWQ+bTkREFQjQqdIE9c2m4MIc3VhuWvChczJlBaGH4qxdL06pPohfbyHQ==
X-Received: by 2002:a37:4fd2:: with SMTP id d201mr3494806qkb.232.1613643376916;
        Thu, 18 Feb 2021 02:16:16 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id v1sm3757790qki.49.2021.02.18.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:16:15 -0800 (PST)
Date:   Thu, 18 Feb 2021 19:16:08 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
Subject: Re: [PATCH v8 21/22] counter: 104-quad-8: Replace mutex with spinlock
Message-ID: <YC4+aMA6fom7pd4F@shinobu>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <d2e72eac404ca5b7c99d8a642f2c07ebb2eb240a.1613131238.git.vilhelm.gray@gmail.com>
 <20210214181946.1d2f7e78@archlinux>
 <YCsq42hXqdRWrSEd@shinobu>
 <20210216192720.75082d22@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+eKruDaQgZ0deyTo"
Content-Disposition: inline
In-Reply-To: <20210216192720.75082d22@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--+eKruDaQgZ0deyTo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2021 at 07:27:20PM +0000, Jonathan Cameron wrote:
> On Tue, 16 Feb 2021 11:16:03 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Sun, Feb 14, 2021 at 06:19:46PM +0000, Jonathan Cameron wrote:
> > > On Fri, 12 Feb 2021 21:13:45 +0900
> > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >  =20
> > > > This patch replaces the mutex I/O lock with a spinlock. This is in
> > > > preparation for a subsequent patch adding IRQ support for 104-QUAD-8
> > > > devices; we can't sleep in an interrupt context, so we'll need to u=
se a
> > > > spinlock instead.
> > > >=20
> > > > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com> =20
> > >=20
> > > Why do these need to be raw_spin_locks?
> > > Normally only need to do that if in code related to interrupt chips e=
tc,
> > > not their use.
> > >=20
> > > Jonathan =20
> >=20
> > This lock can be taken in an interrupt context in a subsequent patch:
> > counter_push_event() called by quad8_irq_handler() can end up calling
> > the Counter component callbacks which take this lock. We can't use a
> > mutex nor a regular spinlock because those can sleep on RT setups [1]
>=20
> But on RT setups the interrupts become threads and are preemptable etc,
> so that shouldn't matter.  There are a few corner cases that cause
> trouble, but in most normal drivers you should be fine with a
> spin_lock.
>=20
> Jonathan

Thinking this over again I realize you're probably right. A simple
spin_lock should be fine for these drivers, so I'll switch over to that
instead of the raw_spin_lock for this driver and the Counter interface
code.

William Breathitt Gray

> > which would result in a deadlock due to the interrupt context here -- so
> > therefore we're left with using raw_spin_lock.
> >=20
> > [1] https://lwn.net/Articles/367219/
> >=20
> > William Breathitt Gray
>=20

--+eKruDaQgZ0deyTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAuPmcACgkQhvpINdm7
VJJlQQ//TGIj8Nm+JA1eSMPG5CK4MXy5g1jHCLnb9hf2L7kuuE6Szwnsth3IQ6Ds
QHYkyzTiZt1SIAZ/x1cJPyg7sI09H5KUo9mkh+pPqqDodvOynZVDrvCqp/nhIkKx
ued5CyWx9illXCF/Myj9ARoknDxK/k0MEEFHBhdbRaTavauIWrEN4W+tKpw0JMom
OXlssOmPeJ51evjd9YwwUUZgoVhrYneaOqx8NCC6Hv4CXIT9wQLnQsXrg6T8zKb7
FbrITR46MkXZyh5iibbDe7am8rIMYindyEjRQiMitYsOgNFYwdsnHfeNGDvKLmYB
l5bPIfyIzjnfANGKvPfXTaS3umavlkdjbOmpD0dgXoW1XqU8Jk2tsul3Ou3ooqSG
DkxRfRxVk5aRgjoONGJgZPP4kOLGZ4/BV/GABasSXmyXpZ26h/+J39kDg9AHKVH+
CHEf+RVbx3QbXO7UgBC0jK1BdpclRpwJWWgJOUWdn1SNYiTN7mEZUAQMj3AU8PGQ
q3UyIkM/Zd5te/XsfuxVa2GucgRizIRs4WYw/Njmz32gJyVMTiCrskEkFywlA4ZY
HntEfYNJop/zzyCblaLp8/0qEfqDfUg/MpUILqZEobE9+oI2gTJ8HVCLvwUVWN8g
/RgD9t6Gl8LvUZCMAOwswLcZGreYIjO7h0m8jfbUYakB3Y5bYCs=
=enNp
-----END PGP SIGNATURE-----

--+eKruDaQgZ0deyTo--
