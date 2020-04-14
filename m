Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB81A8869
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407747AbgDNSDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 14:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407740AbgDNSDk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:03:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7DA20767;
        Tue, 14 Apr 2020 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586887419;
        bh=s0vw9/h6V53cDi9aP+QP3fsdH0r5SY++04AJLWiVtjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VpUZpDw3U5FG2CIbGLaRE29UUI822ujJhQpeRf1mwwk7xJRFmYKARyrKntORlrPGN
         kmnFTwirXz0bzQs4UppgmQWR7XuuhRDp9QN6JrCB5yiOCVOuhUgqg7bvnGfDTJ8Q4p
         Xi6BBXOdO0SZtm2JfeGqVPg7BeuaaVtX+mzMnmCE=
Date:   Tue, 14 Apr 2020 19:03:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: DAC extension for ltc2634-12/10/8
Message-ID: <20200414190336.388df40d@archlinux>
In-Reply-To: <872ae273-48f5-a576-656b-5e011b7beee6@gtsys.com.hk>
References: <20200414062717.19124-1-chris.ruehl@gtsys.com.hk>
        <alpine.DEB.2.21.2004140920210.21841@vps.pmeerw.net>
        <872ae273-48f5-a576-656b-5e011b7beee6@gtsys.com.hk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020 17:49:50 +0800
Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> Hi Peter,
>=20
> good eyes!
>=20
> On 14/4/2020 3:29 pm, Peter Meerwald-Stadler wrote:
> >> This patch add support for Analog Devices (Linear Technology)
> >> LTC2634 Quad 12-/10-/8-Bit Rail-to-Rail DAC.
> >> The SPI functionality based on them from LTC2632 therefor
> >> add the definitions only and update the Kconfig. =20
> > comments below
> >    =20
> >> V2:
> >> Send the documentation fix in a extra patch
> >> Kconfig simplify the driver description, details to the help text
> >> ltc2632.txt add to this patch-set (prepare to convert to yaml)
> >>
> >> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> >> ---
> >>   .../devicetree/bindings/iio/dac/ltc2632.txt   |  8 ++-
> >>   drivers/iio/dac/Kconfig                       |  6 +-
> >>   drivers/iio/dac/ltc2632.c                     | 60 +++++++++++++++++=
++
> >>   3 files changed, 70 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/D=
ocumentation/devicetree/bindings/iio/dac/ltc2632.txt
> >> index 338c3220f01a..1ab9570cf219 100644
> >> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> >> +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> >> @@ -1,4 +1,4 @@
> >> -Linear Technology LTC2632/2636 DAC
> >> +Linear Technology LTC2632/2634/2636 DAC
> >>  =20
> >>   Required properties:
> >>    - compatible: Has to contain one of the following:
> >> @@ -8,6 +8,12 @@ Required properties:
> >>   	lltc,ltc2632-h12
> >>   	lltc,ltc2632-h10
> >>   	lltc,ltc2632-h8
> >> +	lltc,ltc2634-l12
> >> +	lltc,ltc2634-l10
> >> +	lltc,ltc2634-l8
> >> +	lltc,ltc2634-h12
> >> +	lltc,ltc2634-h10
> >> +	lltc,ltc2634-h8
> >>   	lltc,ltc2636-l12
> >>   	lltc,ltc2636-l10
> >>   	lltc,ltc2636-l8
> >> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> >> index 93744011b63f..aee13ced6ddf 100644
> >> --- a/drivers/iio/dac/Kconfig
> >> +++ b/drivers/iio/dac/Kconfig
> >> @@ -279,12 +279,12 @@ config LTC1660
> >>   	  module will be called ltc1660.
> >>  =20
> >>   config LTC2632
> >> -	tristate "Linear Technology LTC2632-12/10/8 and LTC2636-12/10/8 DAC =
spi driver"
> >> +	tristate "Linear Technology LTC2632-12/10/8 and similar DAC spi driv=
er"
> >>   	depends on SPI
> >>   	help
> >>   	  Say yes here to build support for Linear Technology
> >> -	  LTC2632-12, LTC2632-10, LTC2632-8, LTC2636-12, LTC2636-10 and
> >> -	  LTC2636-8 converters (DAC).
> >> +	  LTC2632, LTC2634 and LTC2636 DAC resolution 12/10/8 bit
> >> +	  low 0-2.5V and high 0-4,096V range converters. =20
> > this should be 0-4.096V?
> > use consistent decimal separator =20
> that call to reformat the patch indeed.
>=20
> > =20
> >>  =20
> >>   	  To compile this driver as a module, choose M here: the
> >>   	  module will be called ltc2632.
> >> diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> >> index 2a84ea654645..e939d7f81014 100644
> >> --- a/drivers/iio/dac/ltc2632.c
> >> +++ b/drivers/iio/dac/ltc2632.c
> >> @@ -54,6 +54,12 @@ enum ltc2632_supported_device_ids {
> >>   	ID_LTC2632H12,
> >>   	ID_LTC2632H10,
> >>   	ID_LTC2632H8,
> >> +	ID_LTC2634L12,
> >> +	ID_LTC2634L10,
> >> +	ID_LTC2634L8,
> >> +	ID_LTC2634H12,
> >> +	ID_LTC2634H10,
> >> +	ID_LTC2634H8,
> >>   	ID_LTC2636L12,
> >>   	ID_LTC2636L10,
> >>   	ID_LTC2636L8,
> >> @@ -236,6 +242,36 @@ static const struct ltc2632_chip_info ltc2632_chi=
p_info_tbl[] =3D {
> >>   		.num_channels	=3D 2,
> >>   		.vref_mv	=3D 4096,
> >>   	},
> >> +	[ID_LTC2634L12] =3D {
> >> +		.channels	=3D ltc2632x12_channels,
> >> +		.num_channels	=3D 4,
> >> +		.vref_mv	=3D 2500,
> >> +	},
> >> +	[ID_LTC2634L10] =3D {
> >> +		.channels	=3D ltc2632x10_channels,
> >> +		.num_channels	=3D 4,
> >> +		.vref_mv	=3D 2500,
> >> +	},
> >> +	[ID_LTC2634L8] =3D  {
> >> +		.channels	=3D ltc2632x8_channels,
> >> +		.num_channels	=3D 4,
> >> +		.vref_mv	=3D 2500,
> >> +	},
> >> +	[ID_LTC2634H12] =3D {
> >> +		.channels	=3D ltc2632x12_channels,
> >> +		.num_channels	=3D 4,
> >> +		.vref_mv	=3D 4096,
> >> +	},
> >> +	[ID_LTC2634H10] =3D {
> >> +		.channels	=3D ltc2632x10_channels,
> >> +		.num_channels	=3D 4,
> >> +		.vref_mv	=3D 4096,
> >> +	},
> >> +	[ID_LTC2634H8] =3D  {
> >> +		.channels	=3D ltc2632x8_channels,
> >> +		.num_channels	=3D 4,
> >> +		.vref_mv	=3D 4096,
> >> +	},
> >>   	[ID_LTC2636L12] =3D {
> >>   		.channels	=3D ltc2632x12_channels,
> >>   		.num_channels	=3D 8,
> >> @@ -357,6 +393,12 @@ static const struct spi_device_id ltc2632_id[] =
=3D {
> >>   	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H=
12] },
> >>   	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H=
10] },
> >>   	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8=
] },
> >> +	{ "ltc2634-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L1=
2] }, =20
> > is kernel_ulong_t the correct type here?
> >
> > i.e. guaranteed to hold a pointer value, such as uintptr_t in C?
> > it seems so, but why not use uintptr_t? =20
> I tried not to change a running system, only 'extend' the functionality o=
f the
> driver.=C2=A0 I leave this to Jonathan, to decide if we touch that cast o=
r not.
For avoidance of doubt:
1) Like Andy said
2) Any change would need to be a separate patch from this one anyway.

Jonathan

>=20
>=20
> >> +	{ "ltc2634-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L1=
0] },
> >> +	{ "ltc2634-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L8]=
 },
> >> +	{ "ltc2634-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H1=
2] },
> >> +	{ "ltc2634-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H1=
0] },
> >> +	{ "ltc2634-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H8]=
 },
> >>   	{ "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L=
12] },
> >>   	{ "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L=
10] },
> >>   	{ "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8=
] },
> >> @@ -386,6 +428,24 @@ static const struct of_device_id ltc2632_of_match=
[] =3D {
> >>   	}, {
> >>   		.compatible =3D "lltc,ltc2632-h8",
> >>   		.data =3D &ltc2632_chip_info_tbl[ID_LTC2632H8]
> >> +	}, {
> >> +		.compatible =3D "lltc,ltc2634-l12",
> >> +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2634L12]
> >> +	}, {
> >> +		.compatible =3D "lltc,ltc2634-l10",
> >> +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2634L10]
> >> +	}, {
> >> +		.compatible =3D "lltc,ltc2634-l8",
> >> +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2634L8]
> >> +	}, {
> >> +		.compatible =3D "lltc,ltc2634-h12",
> >> +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2634H12]
> >> +	}, {
> >> +		.compatible =3D "lltc,ltc2634-h10",
> >> +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2634H10]
> >> +	}, {
> >> +		.compatible =3D "lltc,ltc2634-h8",
> >> +		.data =3D &ltc2632_chip_info_tbl[ID_LTC2634H8]
> >>   	}, {
> >>   		.compatible =3D "lltc,ltc2636-l12",
> >>   		.data =3D &ltc2632_chip_info_tbl[ID_LTC2636L12]
> >> =20
>=20

