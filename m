Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D0FADCF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 10:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKMJ4m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 04:56:42 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37319 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfKMJ4m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2019 04:56:42 -0500
X-Originating-IP: 93.34.114.233
Received: from uno.localdomain (93-34-114-233.ip49.fastwebnet.it [93.34.114.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E79A24000B;
        Wed, 13 Nov 2019 09:56:36 +0000 (UTC)
Date:   Wed, 13 Nov 2019 10:58:31 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: max9611: Fix too short conversion time delay
Message-ID: <20191113095831.ipezy2ganb7tk73i@uno.localdomain>
References: <20191113092133.23723-1-geert+renesas@glider.be>
 <20191113093828.vk5qqtlr7bs5z5fb@uno.localdomain>
 <CAMuHMdUeY62SBvzgHCMxjeDO6f_c3isbw82FKJatzny=qiDULQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4nrix7m2kjdzc3cg"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUeY62SBvzgHCMxjeDO6f_c3isbw82FKJatzny=qiDULQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--4nrix7m2kjdzc3cg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Nov 13, 2019 at 10:46:21AM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
>
> On Wed, Nov 13, 2019 at 10:36 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
> > On Wed, Nov 13, 2019 at 10:21:33AM +0100, Geert Uytterhoeven wrote:
> > > As of commit b9ddd5091160793e ("iio: adc: max9611: Fix temperature
> > > reading in probe"), max9611 initialization sometimes fails on the
> > > Salvator-X(S) development board with:
> > >
> > >     max9611 4-007f: Invalid value received from ADC 0x8000: aborting
> > >     max9611: probe of 4-007f failed with error -5
> > >
> > > The max9611 driver tests communications with the chip by reading the =
die
> > > temperature during the probe function, which returns an invalid value.
> > >
> > > According to the datasheet, the typical ADC conversion time is 2 ms, =
but
> > > no minimum or maximum values are provided.  However, the driver assum=
es
> > > a 1 ms conversion time.  Usually the usleep_range() call returns after
> > > more than 1.8 ms, hence it succeeds.  When it returns earlier, the da=
ta
> > > register may be read too early, and the previous measurement value wi=
ll
> > > be returned.  After boot, this is the temperature POR (power-on reset)
> > > value, causing the failure above.
> > >
> > > Fix this by increasing the delay from 1000-2000 =C2=B5s to 2000-2200 =
=C2=B5s.
> > >
> > > Note that this issue has always been present, but it was exposed by t=
he
> > > aformentioned commit.
> > >
> > > Fixes: 69780a3bbc0b1e7e ("iio: adc: Add Maxim max9611 ADC driver")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > This problem was exposed in v5.3.
> > >
> > > After this patch, probing of the two max9611 sensors succeeded during
> > > ca. 3000 boot cycles on Salvator-X(S) boards, equipped with various
> > > R-Car H3/M3-W/M3-N SoCs.
> > > ---
> > >  drivers/iio/adc/max9611.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > > index da073d72f649f829..b0755f25356d700d 100644
> > > --- a/drivers/iio/adc/max9611.c
> > > +++ b/drivers/iio/adc/max9611.c
> > > @@ -89,6 +89,11 @@
> > >  #define MAX9611_TEMP_SCALE_NUM               1000000
> > >  #define MAX9611_TEMP_SCALE_DIV               2083
> > >
> > > +/*
> > > + * Conversion time is 2 ms (typically)
> > > + */
> > > +#define MAX9611_CONV_TIME_US_RANGE   2000, 2200
> > > +
> >
> > Is a 20% sleep range enough or should it be slightly lengthen ?
>
> 10%?

Ehrm... yes :/

>
> This only impacts the variation, so what really happens depends on the
> rate of the hrtimer (if present).
> On R-Car Gen3, I think that uses the ARM Architectured Timer (cp15),
> which has a period of 120 ns.
>

I'm not questioning the hrtimer rate, I'm questioning what would be an
ideal interval to coalesce this with as much other delays as possible,
but I think we're good and this is really a minor thing mostly for my
personal education, as I've seen mentioned in other reviews a 20%
range is usually suggested (found no mention of that in
timers-howto.rst though)

Thanks again for fixing this
  j

> > Apart from this, thanks a lot for finding the issue root cause!
> >
> > Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

--4nrix7m2kjdzc3cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl3L08cACgkQcjQGjxah
Vjz2VBAAmVgNax3Q2EqlMa191fXpyMMKE1rVyVhEmTpY6CjHQjCAIeTsnb/POqZU
6BM6jZ2WNkpb3zHxRlRjURKkJUsupTgCZS+ifYNTraIoqXuY3PYpXPo6/lOHMGb5
/vSDaLPF5sAiy4z670Gh3trgi3JZzWl0cLKpPCrUGa+TiSO3ifD0yAqAjQN4//0M
fKoWokKRvVLsXX1ZkuryKZdDkKq9JDIjui4xDQHGo+2P4oexg7iF735msbXuyH/w
VJ43+qQYktd9+lST8JYMf/c8aMDh8NGMs3m+DKxkvBiIzVySY9k2eGMcS4VUXjy+
r4SnFpmYoxJOpMRIdOOCn3ZkCEQRmfkuLBIZUgLd8gu3yKsvfD+hSr5V89wUSvVl
QBnSXCIRKUefcUWSR9P8O+CmyF//n/EipO9+Dm4l3SPuZPPJx/3UdG6UwsqaCxdI
Yo5RXVFPP70Xae29ufeqMCN0vP8tMuqMYuBdQhbXqy0hDSCZVI2KOEnnhhy/GITr
EiDoEKcBGQuGv43zG8Dv9W/ISpVmlH/0Yvt0Y47iShVE6szWFGyWswK3sRjLuuF+
xDGxWMsAtCfeCCfM0CB2cJjTqq4TAtseep6Vprj2FPZkfUSQsjLeJChVlvtMMBDl
idDM6QYmNMJEKCtw2RdCKFJncu5hhPwAvfiFyNjOa7CWkjsI8rY=
=evql
-----END PGP SIGNATURE-----

--4nrix7m2kjdzc3cg--
