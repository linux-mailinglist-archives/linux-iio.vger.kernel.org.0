Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450CF3C9EA0
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 14:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhGOMcc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 08:32:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54161 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230383AbhGOMcc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 08:32:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id ED24E5C01D1;
        Thu, 15 Jul 2021 08:29:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 15 Jul 2021 08:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dVustmV+n4wGPfP4FIZ6THy5ImK
        azmYrY8ZcsClpZ4A=; b=xuhff/qda1SPFOjv6+P5CwWhvzKDm/9G1l2DxbgJZst
        O+e+u1DiNPmE8pCcknwcmwlZQkO/4/+I/QxA6zDfp55taDPTpTXGA9nPLgZh2MnQ
        fHoDIEjhkT8Hm8satsq/lahBNrpMu4WTLb4XYQKtsIN3qYK4cNZIDNjFpmVcgADK
        p2G8HIlPv/pO/D1Xf6Dny5nyiLWdZnamT84fgfrI1OHiDe9vXTptQ9HTBq8Pio0e
        7cYBiMphyWwkzBC37/YXt47PXcypD5ueXU/+uf0XDVYWkBcuoKUS7Vutsfy202P3
        l2LH9QurVuhle6m6WN/MsjXpD6xlhnWBIBJOGGdkkvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dVustm
        V+n4wGPfP4FIZ6THy5ImKazmYrY8ZcsClpZ4A=; b=QG4aHIl5BiVvf0KG0m4OSv
        ZgtCXpGT8yLcpvo04WoaOs89IZv/cYw5S/c1+WN+AJJLaaih7xFwTboeTaDw6Bz7
        1yM/+rXHWRjabRXZwEPqVSNZIfERuGj582A97UlHNvIZ/+sW6BCyHZPyvzr/xLkT
        FayAt0QzaSGoIyLz4ja51i7/3xgwzBwRovBgiBp1JgJ6FGnz/65tnDhnRhDtoD4l
        /Y+NUEWyLS04FPYIb0LYPm5fxwKcumErkgmRpESgYT8eeZJ0odWtQ9pSkXNy/Sxl
        yZfP0E3MpUlUbTvqka7I7tJnV1rjTFGHuKJESlcukztLd3Vza6FTgLaxuKFACKkA
        ==
X-ME-Sender: <xms:MirwYDDVQ_JzJqnAys-cNGeIahr1pcxNwKHymU6vyjxP884Vaa4FPg>
    <xme:MirwYJgBoYgBPMIgLOBuVi-2n_mEy4mq5VXFD8UegwdtU1I5LZ6gawf29PQFM0qZv
    U43JAZUMJ8TKSf5tik>
X-ME-Received: <xmr:MirwYOmVfBPDU6XwrtFpEZnD8abHmifU-E08Np75eyBVL2Tmu_diVK9LoX7cEMkNeSJLDX2R2kK4G_QS1ui2tyM5ewNCvYEV0jKy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeevveefffduveeitdegtefhhfetueffteefffdvheevvdehteethedvleffgfej
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MirwYFyWasAA6I5-orSPNGCYaB-gB0ggUARRNKR2Ej5ZwyyQU6R2mQ>
    <xmx:MirwYIRxjFFlzh01Jt0RKME4q8ZxkM0wvI7jFypVuat7qCBVDgKE4g>
    <xmx:MirwYIaJX4VD1aB_WQYiSF_RC7JQvpcsPRpeJdQYHdL9mKzFmY39aw>
    <xmx:MirwYNQhLp76ZlYTssJ8ftMw_IJUydDES9abws49eJ81LEiwJTQTHA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jul 2021 08:29:37 -0400 (EDT)
Date:   Thu, 15 Jul 2021 14:29:36 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
Message-ID: <20210715122936.fqbvrvgrtxafshpf@gilmour>
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
 <20210712130444.bois24oukqmxpg27@gilmour>
 <20210712145639.00004604@Huawei.com>
 <20210712141613.66hw4glnkqlw3n4d@gilmour>
 <20210712152802.00003de4@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ujshb5bzooudnr6b"
Content-Disposition: inline
In-Reply-To: <20210712152802.00003de4@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ujshb5bzooudnr6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 12, 2021 at 03:28:02PM +0100, Jonathan Cameron wrote:
> On Mon, 12 Jul 2021 16:16:13 +0200
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > On Mon, Jul 12, 2021 at 02:56:39PM +0100, Jonathan Cameron wrote:
> > > On Mon, 12 Jul 2021 15:04:44 +0200
> > > Maxime Ripard <maxime@cerno.tech> wrote:
> > >  =20
> > > > Hi,
> > > >=20
> > > > On Mon, Apr 12, 2021 at 02:23:31PM +0200, Linus Walleij wrote: =20
> > > > > This adjusts the ST Sensor bindings with the more fine-grained
> > > > > syntax checks that were proposed late in the last kernel cycle
> > > > > and colliding with parallel work.
> > > > >=20
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>   =20
> > > >=20
> > > > I'm not really sure of how I supposed to fix this, but this creates=
 an
> > > > issue on the Pinephone
> > > > (arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts) that h=
as a
> > > > LIS3MDL with only the DRDY pin routed and thus only has a single
> > > > interrupt in the DT.
> > > >=20
> > > > One of the if condition in that patch enforces that there's two
> > > > interrupts for the LIS3MDL, but it's not really clear to me why aft=
er
> > > > looking at the datasheet? =20
> > >=20
> > > It shouldn't be enforcing that 2 are specified rather that 2 'might' =
be
> > > specified. =20
> >=20
> > But then you don't need that condition at all, it's already what is
> > being enforced by the main schema here:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/iio/st,st-sensors.yaml#n90
>=20
> Good point.  I'd argue that we should drop this entry infavour or explici=
t match
> on one of the others, but perhaps that gives an error?

in an if statement, the schema under then will only be enforced if the
schema under the if is valid. In our case, if we remove the entry like
you suggested, we won't match in any if schema, so the schemas under
then will get ignored, which is what we want.

> >=20
> > > maxItems is set, but not minItems.  =20
> >=20
> > Yeah, and if one is missing the other is added with the value of the
> > other.
>=20
> Gah.  Indeed, not good and needs fixing.
>=20
> > What the schema enforces currently is that (for the common part) the
> > interrupt list can be between 1 and 2 and then for a specific set of
> > compatibles (including the LIS3MDL) it has to be exactly 2.
> >=20
> > Even the common part looks weird though, it says that it can handle up
> > to three interrupts but has maxItems: 2?
>=20
> That is indeed odd and I expect an omission on the assumption that the mi=
nItems
> from the general one would not be overridden.=20
>
> @Linus?

As far as schemas work, you can't override a schema with another. They
are all validated in isolation from each other, and they all have to be
valid if you don't want any error.

So the main, global, schema will be validated, and then the smaller
schemas under then will be (if the schemas under their respective if
clause are valid). So it's really as if it was in a separate file
entirely.

> >=20
> > > Driver wise, at the moment it looks like we only handle one interrupt.
> > > So to handle selection when two are possible and either 1 or 2 might
> > > be wired up we need to add interrupt names (with default order so we
> > > don't break anything before adding them to the binding).
> > >=20
> > > Would that work for this device? =20
> >=20
> > I don't know the LIS3MDL to comment whether it makes sense or not, but
> > it looks like it's a single sensor so I'm not really sure why we'd need
> > more than one interrupt
>=20
> Looks like they are hard wired to specific functions.  Data ready does
> what it says on the tin, but the INT line is used for threshold events.
> Depending on the application a particular device is being used for, it
> might well make sense to only wire either one of them.

Ok, I'll just remove the if clause then

Thanks!
Maxime

--ujshb5bzooudnr6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYPAqLwAKCRDj7w1vZxhR
xaouAP4y03AFhRiyZsstn02DEIiFz/OhyPgKwE2UG86d+BnfDQD/eEa8sJA1gHyc
tYWNLi4Cga2BGBXSFtjJl8nbHP14Dgc=
=mf3c
-----END PGP SIGNATURE-----

--ujshb5bzooudnr6b--
