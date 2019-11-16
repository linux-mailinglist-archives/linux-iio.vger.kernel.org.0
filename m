Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8341FF460
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKPRcp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 12:32:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfKPRcp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 12:32:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CAAB216F4;
        Sat, 16 Nov 2019 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573925564;
        bh=mpNFsfEeInlH3gh4xKrQMyoGDIZbQFulbhHFQfnpjw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kKWTAlz2Tx1YpKBdjcGZKlvPHsOOZH1COF8qrC4uewTjgaztbbjmQ+yOBrIIqmNxj
         ehVqdLmz2dsSI7muNyh9ESDFXUyOq/GEvmZVTGk+HebhlRQWhbrFXr8pJQVF665inh
         FCpiYAv/PMb5IxnQkJuke6VbHtKcpvGRKrDRjYBA=
Date:   Sat, 16 Nov 2019 17:32:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Make enum relations more future
 proof
Message-ID: <20191116173239.120b9783@archlinux>
In-Reply-To: <20191116165444.4fsqfrzimachyal3@uno.localdomain>
References: <20191113100938.27604-1-geert+renesas@glider.be>
        <20191114072803.GC26902@bigcity.dyn.berto.se>
        <20191116162522.1e68243c@archlinux>
        <20191116165444.4fsqfrzimachyal3@uno.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Nov 2019 17:54:44 +0100
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hello,
>=20
> On Sat, Nov 16, 2019 at 04:25:22PM +0000, Jonathan Cameron wrote:
> > On Thu, 14 Nov 2019 08:28:03 +0100
> > Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se> wrote:
> > =20
> > > Hi Geert,
> > >
> > > Looks good.
> > >
> > > On 2019-11-13 11:09:38 +0100, Geert Uytterhoeven wrote: =20
> > > > The relations between enum values and array indices values are curr=
ently
> > > > not enforced by the code, which makes them fragile w.r.t. future
> > > > changes.
> > > >
> > > > Fix this by:
> > > >   1. Using designated array initializers, to make sure array indice=
s and
> > > >      enums values match,
> > > >   2. Linking max9611_csa_gain enum values to the corresponding
> > > >      max9611_conf_ids enum values, as the latter is cast to the for=
mer
> > > >      in max9611_read_csa_voltage().
> > > >
> > > > No change in generated code.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be> =20
> > >
> > > Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se> =20
> >
> > Looks good to me, but I'd like to leave a little longer for any
> > feedback from Jacopo as author of the driver. =20
>=20
> yeah, sorry I've been sloppy.. I meant to give the patches a run, but
> it seems there are only syntactic changes here, which indeed make the
> code more robust.
>=20
> Even if not tested, please add
> Acked-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks!

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it.

Thanks,

J
>=20
> Thanks
>   j
>=20
> >
> > Thanks,
> >
> > Jonathan =20
> > > =20
> > > > ---
> > > >  drivers/iio/adc/max9611.c | 36 +++++++++++-------------------------
> > > >  1 file changed, 11 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > > index b0755f25356d700d..cb306ff1a5d6a0b2 100644
> > > > --- a/drivers/iio/adc/max9611.c
> > > > +++ b/drivers/iio/adc/max9611.c
> > > > @@ -114,22 +114,17 @@ enum max9611_conf_ids {
> > > >   *		      where data shall be read from
> > > >   */
> > > >  static const unsigned int max9611_mux_conf[][2] =3D {
> > > > -	/* CONF_SENSE_1x */
> > > > -	{ MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> > > > -	/* CONF_SENSE_4x */
> > > > -	{ MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> > > > -	/* CONF_SENSE_8x */
> > > > -	{ MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> > > > -	/* CONF_IN_VOLT */
> > > > -	{ MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> > > > -	/* CONF_TEMP */
> > > > -	{ MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> > > > +	[CONF_SENSE_1x]	=3D { MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA =
},
> > > > +	[CONF_SENSE_4x]	=3D { MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA =
},
> > > > +	[CONF_SENSE_8x]	=3D { MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA =
},
> > > > +	[CONF_IN_VOLT]	=3D { MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> > > > +	[CONF_TEMP]	=3D { MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> > > >  };
> > > >
> > > >  enum max9611_csa_gain {
> > > > -	CSA_GAIN_1x,
> > > > -	CSA_GAIN_4x,
> > > > -	CSA_GAIN_8x,
> > > > +	CSA_GAIN_1x =3D CONF_SENSE_1x,
> > > > +	CSA_GAIN_4x =3D CONF_SENSE_4x,
> > > > +	CSA_GAIN_8x =3D CONF_SENSE_8x,
> > > >  };
> > > >
> > > >  enum max9611_csa_gain_params {
> > > > @@ -147,18 +142,9 @@ enum max9611_csa_gain_params {
> > > >   * value; use this structure to retrieve the correct LSB and offse=
t values.
> > > >   */
> > > >  static const unsigned int max9611_gain_conf[][2] =3D {
> > > > -	{ /* [0] CSA_GAIN_1x */
> > > > -		MAX9611_CSA_1X_LSB_nV,
> > > > -		MAX9611_CSA_1X_OFFS_RAW,
> > > > -	},
> > > > -	{ /* [1] CSA_GAIN_4x */
> > > > -		MAX9611_CSA_4X_LSB_nV,
> > > > -		MAX9611_CSA_4X_OFFS_RAW,
> > > > -	},
> > > > -	{ /* [2] CSA_GAIN_8x */
> > > > -		MAX9611_CSA_8X_LSB_nV,
> > > > -		MAX9611_CSA_8X_OFFS_RAW,
> > > > -	},
> > > > +	[CSA_GAIN_1x] =3D { MAX9611_CSA_1X_LSB_nV, MAX9611_CSA_1X_OFFS_RA=
W, },
> > > > +	[CSA_GAIN_4x] =3D { MAX9611_CSA_4X_LSB_nV, MAX9611_CSA_4X_OFFS_RA=
W, },
> > > > +	[CSA_GAIN_8x] =3D { MAX9611_CSA_8X_LSB_nV, MAX9611_CSA_8X_OFFS_RA=
W, },
> > > >  };
> > > >
> > > >  enum max9611_chan_addrs {
> > > > --
> > > > 2.17.1
> > > > =20
> > > =20
> > =20

