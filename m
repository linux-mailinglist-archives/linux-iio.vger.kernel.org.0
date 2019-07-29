Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E914E79B81
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 23:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfG2VvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 17:51:01 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60255 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfG2VvA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 17:51:00 -0400
X-Originating-IP: 37.176.111.81
Received: from uno.localdomain (mob-37-176-111-81.net.vodafone.it [37.176.111.81])
        (Authenticated sender: jacopo@jmondi.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 9443C20005;
        Mon, 29 Jul 2019 21:50:56 +0000 (UTC)
Date:   Mon, 29 Jul 2019 23:52:14 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/12] iio: adc: max9611: Fix misuse of GENMASK macro
Message-ID: <20190729215214.eueitve4tfxmqer3@uno.localdomain>
References: <cover.1562734889.git.joe@perches.com>
 <2929234bd4ecec41c0d012edc52416ef80f3e368.1562734889.git.joe@perches.com>
 <20190714125403.0789dc9e@archlinux>
 <b3744e64b22de98bfe8885f76811d4fc7e41b8eb.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bspti6iz3s7zaaw6"
Content-Disposition: inline
In-Reply-To: <b3744e64b22de98bfe8885f76811d4fc7e41b8eb.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bspti6iz3s7zaaw6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,
  so I finally run some test and...

On Sun, Jul 14, 2019 at 05:19:32AM -0700, Joe Perches wrote:
> On Sun, 2019-07-14 at 12:54 +0100, Jonathan Cameron wrote:
> > On Tue,  9 Jul 2019 22:04:17 -0700
> > Joe Perches <joe@perches.com> wrote:
> >
> > > Arguments are supposed to be ordered high then low.
> > >
> > > Signed-off-by: Joe Perches <joe@perches.com>
> >
> > Applied to the fixes-togreg branch of iio.git and marked for
> > stable etc.

I don't see it in v5.3-rc2, has it been collected or are we still in
time for an additional fix?

>
> This mask is used in an init function called from a probe.
>
> I don't have this hardware but it looks as if it could
> never have worked so I doubt the driver and the hardware
> have ever been tested.
>
> Does anyone have this device in actual use?

Because it turns out this is 2 times embarrassing. The mask definition
is indeed wrong, as Joe reported and fixed, but also this line
>
> 	regval = ret & MAX9611_TEMP_MASK;

is very wrong as regval is read as:
        ret = max9611_read_single(max9611, CONF_TEMP, &regval);

So that should actually be:
        regval &= MAX9611_TEMP_MASK;
not
 	regval = ret & MAX9611_TEMP_MASK;
Ups...

Yes, it worked by chance, as regval was always 0, which is in the
range of acceptable temperatures :/

>
> 	if ((regval > MAX9611_TEMP_MAX_POS &&
> 	     regval < MAX9611_TEMP_MIN_NEG) ||
> 	     regval > MAX9611_TEMP_MAX_NEG) {

Also reading this condition and how I had defined the temperature
calculation formula makes me wonder if this it totally correct, but
for the moment:

1) if Joe's patch has been collected, I can send an additional patch to
fix how regval is computed.
2) If Joe's patch still have to be collected, the regval computation
might be fixed there.

Sorry for taking so long to get back to you and thanks for noticing.

Thanks
  j

> 		dev_err(max9611->dev,
> 			"Invalid value received from ADC 0x%4x: aborting\n",
> 			regval);
> 		return -EIO;
> 	}
>
>
> > Thanks,
> >
> > Jonathan
> >
> > > ---
> > >  drivers/iio/adc/max9611.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > index 917223d5ff5b..0e3c6529fc4c 100644
> > > --- a/drivers/iio/adc/max9611.c
> > > +++ b/drivers/iio/adc/max9611.c
> > > @@ -83,7 +83,7 @@
> > >  #define MAX9611_TEMP_MAX_POS		0x7f80
> > >  #define MAX9611_TEMP_MAX_NEG		0xff80
> > >  #define MAX9611_TEMP_MIN_NEG		0xd980
> > > -#define MAX9611_TEMP_MASK		GENMASK(7, 15)
> > > +#define MAX9611_TEMP_MASK		GENMASK(15, 7)
> > >  #define MAX9611_TEMP_SHIFT		0x07
> > >  #define MAX9611_TEMP_RAW(_r)		((_r) >> MAX9611_TEMP_SHIFT)
> > >  #define MAX9611_TEMP_SCALE_NUM		1000000
>

--bspti6iz3s7zaaw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl0/aogACgkQcjQGjxah
VjyVXBAAjXySZDbxeeH6TCp5TWOwWLpebJjJ99v++lJUK4A6ohVeqyyGbyZt7ak6
ADGJEjNkeh1ilm/DXcyCCqTQ7w4loj6RsYPK5AHPT2jYaCf43VIkHArYg20SKtYI
5nREJc2RYXpmOk+2s3oaosA4RgL6WV2shsLF/OYGubvdDWhGfRlAlPAZTtNG/siv
GLidkma6RAbi1iqQUw4hsI7LJTmFn6F1T4wkiRx0SejBkLqHmLnrtvFjsWH1hgXW
k9urqsRYR9Io3wVBvMOiKcQUVrfneOW6wo2KMYMVhNfxwUtKU6NWyWUzfgGpk8Hl
jDG1FoRs3u86e3gTsN+yT4JSZuOjsPovuGOo7NO0MepRRGbfHqFJRBBL7Z9T04pL
QySWlgMZvVQIi40uI/QHLmgm0ztzl19Ez/rJm6fYVSyBE8VKtLCkySI+pmiL8OWl
JcjfMMq2KgElToxFfSF+CuU0Qe6hn8ye/boKsnuWfz9Vk7em07uPGaCDTe+gD4RR
c3pQLaGO16FhSQygRDpiO9/3K9OsGUDCDPrkOoCi5nDqXjmBD4Uu2OEJvch86rku
bmnyJ4ejXzsStjpUUbsNP1AmLT8yPxMA+SvZ8nrUIvfeKkEbD4Mff61ndJP52BX/
g1yN+rSGk8OWRoB++9TUqmHr5EXxgLyJI0hJ9+B+chlgmvapGCM=
=5EgF
-----END PGP SIGNATURE-----

--bspti6iz3s7zaaw6--
