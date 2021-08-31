Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9B3FCA6D
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhHaO45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbhHaO45 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 10:56:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C351C061575;
        Tue, 31 Aug 2021 07:56:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n18so16955034pgm.12;
        Tue, 31 Aug 2021 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RNp457MB/vxzZEKURYpzK+PHbxVwBG4M79IfgemcDRc=;
        b=eDsC58O1F1Nbv6+V1Y+NmGiEg8L5nkeOfNp4pqRuRjW5yD2qP/D438x3rsBdqHp+Ne
         mYQ/J3/KTItVLEzfPnLOrzVA8PhmXuHLWRPKC3w2FAM36tA5ewbByMTkDuAgYw2fQbd4
         uAfNEmItehTal7iBkNM2BRB7DIEmV3hjSt8wd1lfIGyoz7R0CqCEJOyuqq4yCnxDRi0N
         DApe4eCo/ZmMhhlCAUAsifJjSATsOn+aROaN6EixUPgU/lMY5YqK9kauVzQ5ORW3QEoW
         Ogt4DRQRFOVR+Cajo37IbcJKB0JXivAge9CaLFNZiIVYvEanhlmrVdiSaUD0j8tY/GmI
         MCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNp457MB/vxzZEKURYpzK+PHbxVwBG4M79IfgemcDRc=;
        b=hajqoawOzzGf7xZCQWbk48Avp4Qwmq9uQe+AjYYvL6riKKvweO7UrWXinN5nflmw1B
         FR4Tv6ylmdH6lAkrnbovY7acJU3tJn8NUt0oPUY1J1g1p89TCEiUOfgK+CoGCHEnRApP
         qGM9NCXuDek1frKx1nvY5qsMKAS9262qaqQUptn80W4ZRSoh5SGUbWukfB7qfVxhbdW7
         ehXrh0YGz6zxDHF4tLCwhI1Mj/VXEnHuzIu8ivbZVp0J+Sk2VeStJz93p6TCqt0xnVuM
         SQrR1Cc2w3Lm7g+vebb4hStOD3kYQe+4nQYWgtr1rmk7GfwrNQm07FpwOmxrjSwsy4aK
         3ESw==
X-Gm-Message-State: AOAM53284M9ENH+hCsrgwSee1WkWByq7R4WsiXV2e5OwyTDQWtUHXr9/
        bCZo9k1rOH329xqWIbrer4Y=
X-Google-Smtp-Source: ABdhPJz6KuDG5RnjA5Rj0MKW+mijQXIj5E4Xtn0IdEcRtNDO4gG1DjkmYZUvENNfmmXrcxL4yaIB7g==
X-Received: by 2002:a63:230f:: with SMTP id j15mr939761pgj.9.1630421761139;
        Tue, 31 Aug 2021 07:56:01 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id z17sm10544496pfa.125.2021.08.31.07.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:56:00 -0700 (PDT)
Date:   Tue, 31 Aug 2021 23:55:53 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        david@lechnology.com, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, alexandre.belloni@bootlin.com,
        mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kernel@pengutronix.de, fabrice.gasnier@st.com,
        syednwaris@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com
Subject: Re: [Linux-stm32] [PATCH v16 03/14] counter: Internalize sysfs
 interface code
Message-ID: <YS5C+cr1TRhqkCkU@shinobu>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
 <c68b4a1ffb195c1a2f65e8dd5ad7b7c14e79c6ef.1630031207.git.vilhelm.gray@gmail.com>
 <fcff44a7-5ac2-a510-ee9b-85ef7e2e29ef@foss.st.com>
 <YS452wJ+IHs9R0FC@shinobu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Eu0c7fx1a/C8FgI+"
Content-Disposition: inline
In-Reply-To: <YS452wJ+IHs9R0FC@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Eu0c7fx1a/C8FgI+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 31, 2021 at 11:16:59PM +0900, William Breathitt Gray wrote:
> On Tue, Aug 31, 2021 at 03:44:04PM +0200, Fabrice Gasnier wrote:
> > On 8/27/21 5:47 AM, William Breathitt Gray wrote:
> > > This is a reimplementation of the Generic Counter driver interface.
> > > There are no modifications to the Counter subsystem userspace interfa=
ce,
> > > so existing userspace applications should continue to run seamlessly.
> > >=20
> > > The purpose of this patch is to internalize the sysfs interface code
> > > among the various counter drivers into a shared module. Counter drive=
rs
> > > pass and take data natively (i.e. u8, u64, etc.) and the shared count=
er
> > > module handles the translation between the sysfs interface and the
> > > device drivers. This guarantees a standard userspace interface for all
> > > counter drivers, and helps generalize the Generic Counter driver ABI =
in
> > > order to support the Generic Counter chrdev interface (introduced in a
> > > subsequent patch) without significant changes to the existing counter
> > > drivers.
> > >=20
> > > Note, Counter device registration is the same as before: drivers
> > > populate a struct counter_device with components and callbacks, then
> > > pass the structure to the devm_counter_register function. However,
> > > what's different now is how the Counter subsystem code handles this
> > > registration internally.
> > >=20
> > > Whereas before callbacks would interact directly with sysfs data, this
> > > interaction is now abstracted and instead callbacks interact with nat=
ive
> > > C data types. The counter_comp structure forms the basis for Counter
> > > extensions.
> > >=20
> > > The counter-sysfs.c file contains the code to parse through the
> > > counter_device structure and register the requested components and
> > > extensions. Attributes are created and populated based on type, with
> > > respective translation functions to handle the mapping between sysfs =
and
> > > the counter driver callbacks.
> > >=20
> > > The translation performed for each attribute is straightforward: the
> > > attribute type and data is parsed from the counter_attribute structur=
e,
> > > the respective counter driver read/write callback is called, and sysfs
> > > I/O is handled before or after the driver read/write function is call=
ed.
> > >=20
> > > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > Cc: Patrick Havelange <patrick.havelange@essensium.com>
> > > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> > > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > > Cc: Alexandre Torgue <alexandre.torgue@st.com>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> > > Reviewed-by: David Lechner <david@lechnology.com>
> > > Tested-by: David Lechner <david@lechnology.com>
> > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > ---
> > >  MAINTAINERS                             |    1 -
> > >  drivers/counter/104-quad-8.c            |  449 +++----
> > >  drivers/counter/Makefile                |    1 +
> > >  drivers/counter/counter-core.c          |  142 +++
> > >  drivers/counter/counter-sysfs.c         |  849 +++++++++++++
> > >  drivers/counter/counter-sysfs.h         |   13 +
> > >  drivers/counter/counter.c               | 1496 ---------------------=
--
> > >  drivers/counter/ftm-quaddec.c           |   60 +-
> > >  drivers/counter/intel-qep.c             |  144 +--
> > >  drivers/counter/interrupt-cnt.c         |   62 +-
> > >  drivers/counter/microchip-tcb-capture.c |   91 +-
> > >  drivers/counter/stm32-lptimer-cnt.c     |  212 ++--
> > >  drivers/counter/stm32-timer-cnt.c       |  179 ++-
> > >  drivers/counter/ti-eqep.c               |  180 +--
> > >  include/linux/counter.h                 |  658 +++++-----
> > >  include/linux/counter_enum.h            |   45 -
> > >  16 files changed, 1949 insertions(+), 2633 deletions(-)
> > >  create mode 100644 drivers/counter/counter-core.c
> > >  create mode 100644 drivers/counter/counter-sysfs.c
> > >  create mode 100644 drivers/counter/counter-sysfs.h
> > >  delete mode 100644 drivers/counter/counter.c
> > >  delete mode 100644 include/linux/counter_enum.h
> > >=20
> >=20
> > Hi William,
> >=20
> > For the STM32 drivers, you can add my:
> > Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >=20
> > Thanks,
> > Fabrice
>=20
> Hello Fabrice,
>=20
> I noticed the stm32-lptimer-cnt.c function_write() and action_write()
> callbacks do not appear to write the desired function/action
> configuration to the device. Would you check whether the device actually
> supports this functionality or if these callbacks should be removed from
> this driver.
>=20
> Thanks,
>=20
> William Breathitt Gray

Nevermind, I see that these configurations are sent to the device via
stm32_lptim_setup() when the counter is enabled. So that setup should be
fine after all.

Thanks,

William Breathitt Gray

--Eu0c7fx1a/C8FgI+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmEuQssACgkQhvpINdm7
VJKk7xAAle4yE4cmZdHYt/2PVJ1C5dMMRKmZ3HFyB8zckzEqpV1ElqkAGevVyYSw
Vf3dKfMeCy+eOGMoOs2f5VFrSwJkqCZMx1RmdRdPZbcUu8kupH/709oaSUZ7UEeK
T/oMcnoezNeyLkiqHE7Rvln/huzcoc0pJgtDOjTI1ZsAtr7ft0X/dzAF4rxMABgh
nQ1vRTze7+K+ArLAWHZ3dC2b/j+MJN4Z3OoOk0Y2R1vB8aM+Jam2Q8b+QgBFKOyH
O7wSx8kCRBYzwGQLlEYqJgUwJKfy1E6fzX3/k16esbEKrbXSvZhFTLtPXc9QvTY5
rHoK4FQZC42vxMq5qeGY2/P4liItgmUPGuK9yk/7uDH5N8VTi4KW1tvv4k1mfe6D
RsEsBF0D3m2bek0tyo+jfvp4uPF092aY7JAqxjSLkgJphkXtztol3+bFoff/H6Je
JaSsyqgFXfrXkjmXPQNCzHub4y1lTL/uawB6UdaXC9UiBc5GB14t7LspagHF3qHc
zWIRT5I6TLoUsoV0fqLWiA+JLgmbOizzCUFxwIeOD3YfBsMT8ntBj5YJc9CEKEAA
gdjKV0CEFyCtxeddec/wTHdMX/WzMctyfEo1ePgNKTxIyBh9Xe3Z2jAeng4tlpx8
DDztX70QETwxRwXtOHRc61VJscixJ+lKhwqE9NGpvn4o9YAvI6o=
=gyQI
-----END PGP SIGNATURE-----

--Eu0c7fx1a/C8FgI+--
