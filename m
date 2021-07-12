Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39CB3C5CF0
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhGLNHj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 09:07:39 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59563 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232911AbhGLNHi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 09:07:38 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 97F4A320097D;
        Mon, 12 Jul 2021 09:04:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 12 Jul 2021 09:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Rcs3Ch4ZR57Nqwcqf6oEyE4+YDq
        HFvkhQcrGpgYfg64=; b=A+gBGpjmjVGfZYJDYRTJekz/FYnEG6l1bz+xGG1rCF1
        7PSaU0HYjKKXJiRth60YbjK9FiCpvIDt0v2X+xPzcNtkRiUrwcFfxSTV1mb1kq91
        nxVvXXeYN2D/KY6/qdl6Zgx8oFZRc8zyuqYc0m4YIVBIi2qYKdnjRX370lm97nlu
        Z1jJp3ZJ/qC0yGH/z9zbLfQ6RNw6X0YSimSg2uM8FLSfBeNB3kiDietbPPNCDaxN
        7a91c5D65zjPULQNV4ru2CnW82eZEdXd1VaQ3aUtylOm/QWHAW2deHWvYxvbVh/O
        JFq9rTZrjAlNmY+u6Xh+NYDEW8CsqndKggjymgr5Hyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Rcs3Ch
        4ZR57Nqwcqf6oEyE4+YDqHFvkhQcrGpgYfg64=; b=r1kA+dExo30rjPtHSgyWKG
        gG3CrRrP5tOk7+MPdabE4XgAiAIv0HRWJ8bwIIfl5gH0o6vUKJ6oIcLQJPPxeLsP
        zy05PIEsh2L0cS7svtJ5m/rGdpFUCoCp1CKAkqcIvTBLT8qG3vVtTamQOH7/f62m
        fcIQAjQha+8G7Ml4+LeIAoGnE5KF4DESbDmrt35OxxXx9+hi1gUiIN/W4Vom0kv6
        lmsa60CSszgbCZBNjBw+ofgoe9RL5c+JDKpcfT19C9Ee9qHdf+z9v9lCzzbLT7iD
        kCyFHPant0bYm9Ofgyd61ZpUrPORiM7IbLTWlhXi63MWXO3+p7tPdYFhpQD6FLNA
        ==
X-ME-Sender: <xms:8D3sYBIJ1MXbi9Pl6V7gha_0ft0Gb8ES0s-goNYAmOzFj4LHjWnThA>
    <xme:8D3sYNIk_PvsG6OpzB-ol9A42ie8n65WuZ1BERQcAAvz-fv9qJlQW-XfNWwWhM1Pp
    OhjorV_e4zqgNArwLg>
X-ME-Received: <xmr:8D3sYJuxaNgMxFoe_-kz5KwG3Kz_gb8Ex2hJmISgrw5TQ4HSYxBFwx9l8zVt_pU-rYG7OMmo5oNiayB6--B9YVcjZrql1GvPOlEi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8D3sYCZN7J0yLlEJ_k_NR4Izs25R-EoHaZr2phOyuIDHgLNK7eAfOA>
    <xmx:8D3sYIbBONqWIhK35u0YIK-Nu4rBLwhxo19MoJJSCj77Glr5oLnxRg>
    <xmx:8D3sYGBmdwRN-ivW_fzCTrCzJ2cMdE6JTgybnZhS2GqjzFJuaYAyug>
    <xmx:8T3sYNPWfWoUOgnFFFXoxZ2WTJ_Fplyr-tUBxIkCY1kpCvxvaKocCg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jul 2021 09:04:47 -0400 (EDT)
Date:   Mon, 12 Jul 2021 15:04:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
Message-ID: <20210712130444.bois24oukqmxpg27@gilmour>
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s4is6jmvmxy6re4k"
Content-Disposition: inline
In-Reply-To: <20210412122331.1631643-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--s4is6jmvmxy6re4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 12, 2021 at 02:23:31PM +0200, Linus Walleij wrote:
> This adjusts the ST Sensor bindings with the more fine-grained
> syntax checks that were proposed late in the last kernel cycle
> and colliding with parallel work.
>=20
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'm not really sure of how I supposed to fix this, but this creates an
issue on the Pinephone
(arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts) that has a
LIS3MDL with only the DRDY pin routed and thus only has a single
interrupt in the DT.

One of the if condition in that patch enforces that there's two
interrupts for the LIS3MDL, but it's not really clear to me why after
looking at the datasheet?

Maxime

--s4is6jmvmxy6re4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYOw96AAKCRDj7w1vZxhR
xbT+AQC+p4e2mIE5uGFDLwspa2G6MWgr/Q3L79r6b4l66TT6UQD8DEsk0jRSA1yX
XdYri3VMN8H0bx1/H6HtCkltEaUCPwA=
=FQ4o
-----END PGP SIGNATURE-----

--s4is6jmvmxy6re4k--
