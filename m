Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33F80FF418
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 17:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfKPQwt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 11:52:49 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35797 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfKPQwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Nov 2019 11:52:49 -0500
X-Originating-IP: 93.34.114.233
Received: from uno.localdomain (93-34-114-233.ip49.fastwebnet.it [93.34.114.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0C27E20002;
        Sat, 16 Nov 2019 16:52:45 +0000 (UTC)
Date:   Sat, 16 Nov 2019 17:54:44 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Make enum relations more future proof
Message-ID: <20191116165444.4fsqfrzimachyal3@uno.localdomain>
References: <20191113100938.27604-1-geert+renesas@glider.be>
 <20191114072803.GC26902@bigcity.dyn.berto.se>
 <20191116162522.1e68243c@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jl7d2nspvl7tn5qg"
Content-Disposition: inline
In-Reply-To: <20191116162522.1e68243c@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jl7d2nspvl7tn5qg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Nov 16, 2019 at 04:25:22PM +0000, Jonathan Cameron wrote:
> On Thu, 14 Nov 2019 08:28:03 +0100
> Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se> wrote:
>
> > Hi Geert,
> >
> > Looks good.
> >
> > On 2019-11-13 11:09:38 +0100, Geert Uytterhoeven wrote:
> > > The relations between enum values and array indices values are curren=
tly
> > > not enforced by the code, which makes them fragile w.r.t. future
> > > changes.
> > >
> > > Fix this by:
> > >   1. Using designated array initializers, to make sure array indices =
and
> > >      enums values match,
> > >   2. Linking max9611_csa_gain enum values to the corresponding
> > >      max9611_conf_ids enum values, as the latter is cast to the former
> > >      in max9611_read_csa_voltage().
> > >
> > > No change in generated code.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
>
> Looks good to me, but I'd like to leave a little longer for any
> feedback from Jacopo as author of the driver.

yeah, sorry I've been sloppy.. I meant to give the patches a run, but
it seems there are only syntactic changes here, which indeed make the
code more robust.

Even if not tested, please add
Acked-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

>
> Thanks,
>
> Jonathan
> >
> > > ---
> > >  drivers/iio/adc/max9611.c | 36 +++++++++++-------------------------
> > >  1 file changed, 11 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > index b0755f25356d700d..cb306ff1a5d6a0b2 100644
> > > --- a/drivers/iio/adc/max9611.c
> > > +++ b/drivers/iio/adc/max9611.c
> > > @@ -114,22 +114,17 @@ enum max9611_conf_ids {
> > >   *		      where data shall be read from
> > >   */
> > >  static const unsigned int max9611_mux_conf[][2] =3D {
> > > -	/* CONF_SENSE_1x */
> > > -	{ MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> > > -	/* CONF_SENSE_4x */
> > > -	{ MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> > > -	/* CONF_SENSE_8x */
> > > -	{ MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> > > -	/* CONF_IN_VOLT */
> > > -	{ MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> > > -	/* CONF_TEMP */
> > > -	{ MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> > > +	[CONF_SENSE_1x]	=3D { MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> > > +	[CONF_SENSE_4x]	=3D { MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> > > +	[CONF_SENSE_8x]	=3D { MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> > > +	[CONF_IN_VOLT]	=3D { MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> > > +	[CONF_TEMP]	=3D { MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> > >  };
> > >
> > >  enum max9611_csa_gain {
> > > -	CSA_GAIN_1x,
> > > -	CSA_GAIN_4x,
> > > -	CSA_GAIN_8x,
> > > +	CSA_GAIN_1x =3D CONF_SENSE_1x,
> > > +	CSA_GAIN_4x =3D CONF_SENSE_4x,
> > > +	CSA_GAIN_8x =3D CONF_SENSE_8x,
> > >  };
> > >
> > >  enum max9611_csa_gain_params {
> > > @@ -147,18 +142,9 @@ enum max9611_csa_gain_params {
> > >   * value; use this structure to retrieve the correct LSB and offset =
values.
> > >   */
> > >  static const unsigned int max9611_gain_conf[][2] =3D {
> > > -	{ /* [0] CSA_GAIN_1x */
> > > -		MAX9611_CSA_1X_LSB_nV,
> > > -		MAX9611_CSA_1X_OFFS_RAW,
> > > -	},
> > > -	{ /* [1] CSA_GAIN_4x */
> > > -		MAX9611_CSA_4X_LSB_nV,
> > > -		MAX9611_CSA_4X_OFFS_RAW,
> > > -	},
> > > -	{ /* [2] CSA_GAIN_8x */
> > > -		MAX9611_CSA_8X_LSB_nV,
> > > -		MAX9611_CSA_8X_OFFS_RAW,
> > > -	},
> > > +	[CSA_GAIN_1x] =3D { MAX9611_CSA_1X_LSB_nV, MAX9611_CSA_1X_OFFS_RAW,=
 },
> > > +	[CSA_GAIN_4x] =3D { MAX9611_CSA_4X_LSB_nV, MAX9611_CSA_4X_OFFS_RAW,=
 },
> > > +	[CSA_GAIN_8x] =3D { MAX9611_CSA_8X_LSB_nV, MAX9611_CSA_8X_OFFS_RAW,=
 },
> > >  };
> > >
> > >  enum max9611_chan_addrs {
> > > --
> > > 2.17.1
> > >
> >
>

--jl7d2nspvl7tn5qg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl3QKdAACgkQcjQGjxah
VjzvshAAucm2eLgK3WyUG1EhAxN91fVjfwgHkR+Q2dhT4R5QYgIsvVhrYlRH/MfQ
QedHq4c2DJ2N2XU7zZHt2tAV2FSbfxS4nCCjNk4ywzkqN0m91/+nDKuCoN9Lvw/M
3mO6hvWuJYn11XsvEHQHOR06rgVQSm40fobwjxG2uqTB9jVmh0ap6rLn3wUrqg0x
alT68zQH7/ngIAYGx383UVUGn2aIqbtVZ+RSebmVRQ6tWVun8rTNrJH+s7hZUV8A
6c5nh3ATQGDmgfcSi2BdxJdaiuPET+VmAbNaF25/xN+jHzr7ieU3zZ/FC41uuSgd
pIRLiUEl5gyyDIqGVX4bUBPt3/3iP4LVJVTP9eXYOEpyAeAYqsb1+/KNr+zzygOw
YjyPKeEqIzxWH2/u0FcWZdacgLVAmN4R7A2SmF3HUI1vnCd/E4Y5jLhzF1wG3P1/
WJbMa7yW4IoiIso0iMYDvk7BgkTX6wpnYo+vLsZ5jijE7ja6TOBTnYf9UmdtXabo
Fc6E+AMr08el354otO48oojoUMJOdGzpX/dDHejwCiiacWLduQmwUD7Hz22W6BrI
kJhGfsyLpV/doNOy2cqcP/7ydmwPwYxrE5tyXXfWPGfFjrnSLc0kjcC0IBYqHEUD
55qe4PwcEl3m1Ps6VBQQk7fHge846kg/iBh4DrLFNxLjWYYeK+Y=
=omju
-----END PGP SIGNATURE-----

--jl7d2nspvl7tn5qg--
