Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6513C5E22
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhGLOTH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 10:19:07 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59329 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234096AbhGLOTH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 10:19:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C84BC3200201;
        Mon, 12 Jul 2021 10:16:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 12 Jul 2021 10:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=EhduHFsmhI3bAtiYlHPBwe1TCZw
        2kv8/ursYm7UjZ3I=; b=0qbjMceehlxcXrARJUFXnFx0tKsmq7G6M+Q1kX498HQ
        8ob/5a9K5dNJ1s7oOJ3kuLaL1b674VrhfSLQTPSxkIILO+wykpHaiOBmrp+ki9Q+
        RzSsHFtlThSkd535SVe21GTL3TJloW4iytYWDR2Ud6E0X7IEUpLqr9lIfKexE0Oc
        2uoL68xPGgIzXGSHncB0vHU+mUhOIGgYHXnUvFHfZMkr16NouIrVCM2MhsmprYPb
        jySAzyP8EDKIVGawRLm0J4z4HYc30i5jcbz0/JM6tRrMs6XTX7NfWLiOEBtjwEHH
        HYnz2QtqPTux0mAYJyB3VwocI8771BIH1tbQHSQP2lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EhduHF
        smhI3bAtiYlHPBwe1TCZw2kv8/ursYm7UjZ3I=; b=NAs5kvZ4tsN7DKxsi9+LNF
        3hJta6mohwDc0ANf2DmwHab0hPDr42rR1Ko+KGCwEI1bcJJPFqFuxkpEmOyze4K7
        JZ+RQFOaFhSk/BeCrdZX5skYWaAa5ndqjNZ2KbYgZG8L54YFH0yF0jvQdmOaIM54
        bxF1rvZ759kdfGrHyoTT8YyGKjR7fh8kId2f/K2PwXTXy+i312anSf37oj03HMwX
        Y1ZKepjy97IZTxyqmB4psEOQBCScd9NBYrTc5waF/8P83VIsFaAi1vxw9LjuG9lM
        ZUg0qRUgnp7ibeUn9tKPzWcq3hctad0s+3Mtr3lRCVsC5S4K1PzsLjg+RCa63zrw
        ==
X-ME-Sender: <xms:sE7sYP47Ezn7aNpKgoPrso-Y0ej-EomKH5MH5ZoRTTgMFHzdEujjag>
    <xme:sE7sYE7bNG-Sf7huhUVOga2cuqVwznHdLaRjbdpIwUzaCCZ6kfH2w9Hi6hOnnaWeu
    asuMy45K9_ARjvpUNc>
X-ME-Received: <xmr:sE7sYGfM0Z1O3GqdjwaRPza2KgOxW3nx_fiv-77T39qHIzvMhMnIbEbH35yF1T3TN4IQPXuIruGPbFgtP0ld3iGDenmh6Z7TXKCJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeevveefffduveeitdegtefhhfetueffteefffdvheevvdehteethedvleffgfej
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sE7sYAL-z7UUwuxG63YSj7vbhsQ-Kupd-W0K7kBfe4KSmGSIFxJh0A>
    <xmx:sE7sYDK34Gl7L94cSt0pD-5H2lgRhZpH_Qq0DfZ1dDzv6zHd4khhVA>
    <xmx:sE7sYJyIQ7j4-7wqmaPAM4BZJlu-n18V6lZUAtcUCyi-92F8bVQdRg>
    <xmx:sU7sYArV4zdfiyAE6bHOQYco5tXQu2v8TFioDj1HrPFpnC_n1rhn3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jul 2021 10:16:16 -0400 (EDT)
Date:   Mon, 12 Jul 2021 16:16:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
Message-ID: <20210712141613.66hw4glnkqlw3n4d@gilmour>
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
 <20210712130444.bois24oukqmxpg27@gilmour>
 <20210712145639.00004604@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5isiugqzuchgniqi"
Content-Disposition: inline
In-Reply-To: <20210712145639.00004604@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--5isiugqzuchgniqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 12, 2021 at 02:56:39PM +0100, Jonathan Cameron wrote:
> On Mon, 12 Jul 2021 15:04:44 +0200
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > Hi,
> >=20
> > On Mon, Apr 12, 2021 at 02:23:31PM +0200, Linus Walleij wrote:
> > > This adjusts the ST Sensor bindings with the more fine-grained
> > > syntax checks that were proposed late in the last kernel cycle
> > > and colliding with parallel work.
> > >=20
> > > Cc: devicetree@vger.kernel.org
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org> =20
> >=20
> > I'm not really sure of how I supposed to fix this, but this creates an
> > issue on the Pinephone
> > (arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts) that has a
> > LIS3MDL with only the DRDY pin routed and thus only has a single
> > interrupt in the DT.
> >=20
> > One of the if condition in that patch enforces that there's two
> > interrupts for the LIS3MDL, but it's not really clear to me why after
> > looking at the datasheet?
>=20
> It shouldn't be enforcing that 2 are specified rather that 2 'might' be
> specified.

But then you don't need that condition at all, it's already what is
being enforced by the main schema here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/iio/st,st-sensors.yaml#n90

> maxItems is set, but not minItems.=20

Yeah, and if one is missing the other is added with the value of the
other.

What the schema enforces currently is that (for the common part) the
interrupt list can be between 1 and 2 and then for a specific set of
compatibles (including the LIS3MDL) it has to be exactly 2.

Even the common part looks weird though, it says that it can handle up
to three interrupts but has maxItems: 2?

> Driver wise, at the moment it looks like we only handle one interrupt.
> So to handle selection when two are possible and either 1 or 2 might
> be wired up we need to add interrupt names (with default order so we
> don't break anything before adding them to the binding).
>=20
> Would that work for this device?

I don't know the LIS3MDL to comment whether it makes sense or not, but
it looks like it's a single sensor so I'm not really sure why we'd need
more than one interrupt

Maxime

--5isiugqzuchgniqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYOxOrQAKCRDj7w1vZxhR
xSCkAQDl0y5evD98R/vLpA3l7eRBIY00atuGYp7leVAgZ/tdZAEAqzuRIYnb1aL5
P25O+Q+de5HRnpqm1a9WH4ZsCcXWAg8=
=Jx+B
-----END PGP SIGNATURE-----

--5isiugqzuchgniqi--
