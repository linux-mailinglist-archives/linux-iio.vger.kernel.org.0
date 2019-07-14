Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCBA67F52
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfGNOgs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 10:36:48 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59963 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfGNOgs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jul 2019 10:36:48 -0400
X-Originating-IP: 126.159.224.182
Received: from uno.localdomain (softbank126159224182.bbtec.net [126.159.224.182])
        (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5ACC81BF206;
        Sun, 14 Jul 2019 14:36:40 +0000 (UTC)
Date:   Sun, 14 Jul 2019 16:37:56 +0200
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
Message-ID: <20190714143756.2hqmncnbx7nftj7w@uno.localdomain>
References: <cover.1562734889.git.joe@perches.com>
 <2929234bd4ecec41c0d012edc52416ef80f3e368.1562734889.git.joe@perches.com>
 <20190714125403.0789dc9e@archlinux>
 <b3744e64b22de98bfe8885f76811d4fc7e41b8eb.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e2dafb6smz57535e"
Content-Disposition: inline
In-Reply-To: <b3744e64b22de98bfe8885f76811d4fc7e41b8eb.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--e2dafb6smz57535e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Joe, Jonathan,

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
>
> This mask is used in an init function called from a probe.
>
> I don't have this hardware but it looks as if it could
> never have worked so I doubt the driver and the hardware
> have ever been tested.
>

Ups, this is embarassing! Thanks for noticing

I actually tested the device before sending the driver of course

> Does anyone have this device in actual use?
>

The driver is currently in use in Renesas Gen3 Salvator boards:
arch/arm64/boot/dts/renesas/salvator-common.dtsi:466

I might need some time before I can actually test and tell what's
happening though. It might work by pure chance. Fortunately the mask
is only used for validation of the temperature reading at probe time,
and I can tell this passes (we would have noticed otherwise, Salvator
is one of the reference Gen3 platforms for upstream development).

As said I might need some time before I can test this, but the change
is indeed correct.

Thanks
   j

>
> 	regval = ret & MAX9611_TEMP_MASK;
>
> 	if ((regval > MAX9611_TEMP_MAX_POS &&
> 	     regval < MAX9611_TEMP_MIN_NEG) ||
> 	     regval > MAX9611_TEMP_MAX_NEG) {
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

--e2dafb6smz57535e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl0rPkQACgkQcjQGjxah
Vjx/tg/+Na7MQuV44rg4baxabcBZgnsryXWGW3tX+2T0nGYUopagAj+md9VGP2hq
bK476Vtnqk+x2vFyzZpuB2UlWzOqR25lxnQX9zD+7VxbqmugTtPhKDuE5W4uUMjz
RX62qX4bSKqQ3roiGpPrOWsKbjVj083AVVovUMbHGnnnAd0WWuefyzolZF0SU5YC
FniBmRsug+8e7pOYP22Ni5Cet9X05QuQaTrrc2OxTdNruDNcFGVUYt/b4kl2ExC+
HiO+eoDcBkmgr0WYzGFcpQ07gGz7KEOebYI1k/yrI1deyIlflFL8fJejDcuzpgrA
13Hpdq1RFlqI5eE3bP76AQlbWtCbwreXvMAzte4pPzv0JtZ3EnbAiWE1m8PrzspU
76utkkJIr7jpSI14KflN11FgRMCfw2onknsRl2pZDHdPcCCrbKE7i/9T2znveLo/
LF3sUHcncbV5WtioP8vZQOvpgU0HwG+qFV43sYXFlOCnCQPO55EukvNX6BEaCMjr
zBCMCqn7X6fw4jh8ubP9Xw4ZNqHDR39fH5Y2k4cSs85WZA6SqDJAzWKtjDTEu4ht
8Jwvtq9ZN3vrj/mgqO0Njuip3dboEMw7xfGbZ7RwSOg6WraQ70AS0WmrMOZNaPjb
2iyftvch5psoWYG7c0ZCfzm1Lq1uxZLeSt8RqtaqkFrB6flWT1I=
=TLNj
-----END PGP SIGNATURE-----

--e2dafb6smz57535e--
