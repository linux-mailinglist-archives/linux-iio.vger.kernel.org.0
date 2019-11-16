Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167D2FF36C
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 17:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfKPQZd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 11:25:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbfKPQZ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 11:25:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E3C821844;
        Sat, 16 Nov 2019 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573921527;
        bh=tKlAqIyvgm/BFvXM2Gzz+MPd2tkf5PYpf/ev0HUdeHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UODgzqzWaywxJGPpgNbLnK2smJSPt5HlG68zONKsKA6sF6efou8n7XUF5B3SbdvI3
         mXBluCOmsPqBSm86Ungf7+VXXrrHRydQ6DLHZOW2wyl0J2u95J7OEGZOp9s415P9wY
         7DhWKJkwoFFSIHF4oxNnBLfH9qPOzu3SRgMv2NO4=
Date:   Sat, 16 Nov 2019 16:25:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund@ragnatech.se>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Make enum relations more future
 proof
Message-ID: <20191116162522.1e68243c@archlinux>
In-Reply-To: <20191114072803.GC26902@bigcity.dyn.berto.se>
References: <20191113100938.27604-1-geert+renesas@glider.be>
        <20191114072803.GC26902@bigcity.dyn.berto.se>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 08:28:03 +0100
Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se> wrote:

> Hi Geert,
>=20
> Looks good.
>=20
> On 2019-11-13 11:09:38 +0100, Geert Uytterhoeven wrote:
> > The relations between enum values and array indices values are currently
> > not enforced by the code, which makes them fragile w.r.t. future
> > changes.
> >=20
> > Fix this by:
> >   1. Using designated array initializers, to make sure array indices and
> >      enums values match,
> >   2. Linking max9611_csa_gain enum values to the corresponding
> >      max9611_conf_ids enum values, as the latter is cast to the former
> >      in max9611_read_csa_voltage().
> >=20
> > No change in generated code.
> >=20
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be> =20
>=20
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

Looks good to me, but I'd like to leave a little longer for any
feedback from Jacopo as author of the driver.

Thanks,

Jonathan
>=20
> > ---
> >  drivers/iio/adc/max9611.c | 36 +++++++++++-------------------------
> >  1 file changed, 11 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index b0755f25356d700d..cb306ff1a5d6a0b2 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -114,22 +114,17 @@ enum max9611_conf_ids {
> >   *		      where data shall be read from
> >   */
> >  static const unsigned int max9611_mux_conf[][2] =3D {
> > -	/* CONF_SENSE_1x */
> > -	{ MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> > -	/* CONF_SENSE_4x */
> > -	{ MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> > -	/* CONF_SENSE_8x */
> > -	{ MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> > -	/* CONF_IN_VOLT */
> > -	{ MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> > -	/* CONF_TEMP */
> > -	{ MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> > +	[CONF_SENSE_1x]	=3D { MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> > +	[CONF_SENSE_4x]	=3D { MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> > +	[CONF_SENSE_8x]	=3D { MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> > +	[CONF_IN_VOLT]	=3D { MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> > +	[CONF_TEMP]	=3D { MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> >  };
> > =20
> >  enum max9611_csa_gain {
> > -	CSA_GAIN_1x,
> > -	CSA_GAIN_4x,
> > -	CSA_GAIN_8x,
> > +	CSA_GAIN_1x =3D CONF_SENSE_1x,
> > +	CSA_GAIN_4x =3D CONF_SENSE_4x,
> > +	CSA_GAIN_8x =3D CONF_SENSE_8x,
> >  };
> > =20
> >  enum max9611_csa_gain_params {
> > @@ -147,18 +142,9 @@ enum max9611_csa_gain_params {
> >   * value; use this structure to retrieve the correct LSB and offset va=
lues.
> >   */
> >  static const unsigned int max9611_gain_conf[][2] =3D {
> > -	{ /* [0] CSA_GAIN_1x */
> > -		MAX9611_CSA_1X_LSB_nV,
> > -		MAX9611_CSA_1X_OFFS_RAW,
> > -	},
> > -	{ /* [1] CSA_GAIN_4x */
> > -		MAX9611_CSA_4X_LSB_nV,
> > -		MAX9611_CSA_4X_OFFS_RAW,
> > -	},
> > -	{ /* [2] CSA_GAIN_8x */
> > -		MAX9611_CSA_8X_LSB_nV,
> > -		MAX9611_CSA_8X_OFFS_RAW,
> > -	},
> > +	[CSA_GAIN_1x] =3D { MAX9611_CSA_1X_LSB_nV, MAX9611_CSA_1X_OFFS_RAW, },
> > +	[CSA_GAIN_4x] =3D { MAX9611_CSA_4X_LSB_nV, MAX9611_CSA_4X_OFFS_RAW, },
> > +	[CSA_GAIN_8x] =3D { MAX9611_CSA_8X_LSB_nV, MAX9611_CSA_8X_OFFS_RAW, },
> >  };
> > =20
> >  enum max9611_chan_addrs {
> > --=20
> > 2.17.1
> >  =20
>=20

