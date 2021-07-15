Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FC3C9E84
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbhGOMYy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 08:24:54 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33507 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236901AbhGOMYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 08:24:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D907E5C0158;
        Thu, 15 Jul 2021 08:22:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Jul 2021 08:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=PDg43YNU05OfmkuqqhbhAq/PESd
        1UoKkb4yl2APa8Jk=; b=TcR2ibaCdt8O3Zp6B+r5oshUQpksUXkdIaD17qK2Jgc
        7PeeJPty7FrIWCMJOrUkqMeCv9xXlmPSWrNWDK5a7MnNavcGVKvjUUHYpmqP83jw
        ldgtoIGZb2Ew49WQzbVtVz/nvWteQPtLYjvgkx3smhDhu6Nm9CeUyubTk0dFfYev
        Qi6jgrKY0pSWicynhPaPMvRU6pjEy/CGagj61f6opWWwPOm2v6jUJWmeX+IrPeSz
        WdZDLTqKWHywUjKdM3PUNzw002bJjUXYMRIDYnZJ6d7qKs6d0JcpPenfdFZjj1z1
        wYfhCQXCHD+1YqIyxOqcpuHDSj+UwJtSaZytkFPvSQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PDg43Y
        NU05OfmkuqqhbhAq/PESd1UoKkb4yl2APa8Jk=; b=SOIDxMbuhtSNvf+gJNv283
        w4zObdevBN/1PWmuKiqUayk6mu+TAhiMWaz6TFipRWZiFajtrOJY5oMYzp65CPjy
        xK3cFQsFjsxKCBOtqctMuoRn5V6wNNSLfmmxjRFwsIpJAcXP2zdeU//xEUMNx16z
        khlbL97Hl+qxBAOpMjmr3awyuUbtQTnoEJqd125jrzgTWEAGaw/k9rcuXz1ldw/d
        +Qgjxguaj+EOAtNHuLT62UkUaLqXmrIwYMcvKYqXlVjXBUwzfRjKMHk8+qadc7y4
        ZU/p2979zdRYDjm6UCGsAuWUhL0ecnNKu00oEM/4a852m1nx+6pER9zQTuC1KIWw
        ==
X-ME-Sender: <xms:aCjwYFI8HaC74DRItn9enZe6kWdQ1AoZNbsRbmGd4CJPusymfgMRuA>
    <xme:aCjwYBJ3MnDIvYt-QsKd64xe9fxTrtjM5MH5rHYLTOm-2kVoeMBWWkpNEuyKTsH5_
    65hmJ_5FaJP1EO0DT8>
X-ME-Received: <xmr:aCjwYNs2b3ThL8ILyQn1BSgG-0XHGyMHVC6olVmGsBGMomS33K1s9HZKNtquy0y9vTtGQy9HVx7bhYVYmSISyluQXkKNT7DJ5Dca>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:aCjwYGaJaj8NRExqRSq515kc8Xk1pHz-JZnIbq_G7c5xmF13V7S63w>
    <xmx:aCjwYMboGRKtzCbY9o-y0OT0WpJ75qz6sIbd2aAvT6clrWCT-oq3rA>
    <xmx:aCjwYKCcmMcaTuAFAMxkWm88i-jv9Ig3NuuaryH8vI1XeWPEBJYS8w>
    <xmx:aCjwYM7pT4gAEVszhxjlAnW-fkXrW8MlImAe8cXwdvifaa7dgPWbEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jul 2021 08:21:59 -0400 (EDT)
Date:   Thu, 15 Jul 2021 14:21:57 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
Message-ID: <20210715122157.ws7rg67ebypzup4f@gilmour>
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
 <20210712130444.bois24oukqmxpg27@gilmour>
 <20210712145639.00004604@Huawei.com>
 <20210712141613.66hw4glnkqlw3n4d@gilmour>
 <CACRpkdZqth9kYEaCr=C88=EbhEy+r5V1vPXOPKNky5HeP7QxPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jvow46iqgknp7rle"
Content-Disposition: inline
In-Reply-To: <CACRpkdZqth9kYEaCr=C88=EbhEy+r5V1vPXOPKNky5HeP7QxPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jvow46iqgknp7rle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 2021 at 10:26:39AM +0200, Linus Walleij wrote:
> On Mon, Jul 12, 2021 at 4:16 PM Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > > maxItems is set, but not minItems.
> >
> > Yeah, and if one is missing the other is added with the value of the
> > other.
> >
> > What the schema enforces currently is that (for the common part) the
> > interrupt list can be between 1 and 2 and then for a specific set of
> > compatibles (including the LIS3MDL) it has to be exactly 2.
>=20
> maxItems is not an intuitive naming to what it does so it creates
> bugs like this :/

I mean, it's complicated. Both minItems and maxItems are required for
all the items in the schema spec. In order to reduce the boilerplate,
the tooling will add the other if one is missing, which can lead to
things like this indeed.

But the alternative is not really to just optionally use minItems, it's
to have to always specify it, in all the schemas.

> Can you fix so it works with your PinePhone DTS and send a patch?
> Perhaps also add as an example so it doesn't happen again?

Yeah, I can definitely do that, I'm not really sure what makes sense for
the driver at this point though.

> > Even the common part looks weird though, it says that it can handle up
> > to three interrupts but has maxItems: 2?
>=20
> Maybe just drop maxItems for now?

Dropping minItems and maxItems on interrupts will enforce that there's
only one interrupt, which isn't want we want either

Maxime

--jvow46iqgknp7rle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYPAoZQAKCRDj7w1vZxhR
xReKAQDu6O7p+bIwRjtIRz/tJmSwtS/GbHAUzfLQE8DmSzJhawEAtwDo0CN7ivMh
kT1F3h+oLAejsnZi2XbNhPBFrRfI3go=
=h2Ne
-----END PGP SIGNATURE-----

--jvow46iqgknp7rle--
