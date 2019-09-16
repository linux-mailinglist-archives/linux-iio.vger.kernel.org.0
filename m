Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0F6B3BAA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfIPNn1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 09:43:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55130 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387912AbfIPNnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 09:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z423eE0xltB3vRPrKrPJm5Vb6e31D3Z/WMIdhED2ET0=; b=tvH+odcCIft2As/zfFGQE6S56
        PH2NK9V+SzVy3MI3204Qje10JQhIAz8/XxDooZRLx63PmOrlm9tTf9JsvcBWzQ02Nq14Cd1mdP96d
        RgqFstRj6EGLt+sB1pDTD2fvgN4T97KCNVhurDhKGQqX5/8Ga2EENE6VEzFdrbhTNMAX4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9rHa-0004c7-FY; Mon, 16 Sep 2019 13:43:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id F0EF92741A0D; Mon, 16 Sep 2019 14:43:09 +0100 (BST)
Date:   Mon, 16 Sep 2019 14:43:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Message-ID: <20190916134309.GH4352@sirena.co.uk>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
 <20190913114550.956-4-alexandru.ardelean@analog.com>
 <20190916122505.GC4352@sirena.co.uk>
 <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
 <20190916124707.GD4352@sirena.co.uk>
 <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u0lqphHC8S+ob1K0"
Content-Disposition: inline
In-Reply-To: <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--u0lqphHC8S+ob1K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 01:04:42PM +0000, Ardelean, Alexandru wrote:
> On Mon, 2019-09-16 at 13:47 +0100, Mark Brown wrote:

> > That v3 seems to be a small subset of this series?

> Ack.
> V3 is the first 4 patches from this series.
> Well, patches 3 & 4 are squashed.

> I am 100% convinced that the entire series is a good idea.
> In the sense that a `struct spi_delay` may be a good idea, but at the same time, it may be un-needed.

> All I wanted to do, was to add another delay somewhere, and got lost in the rework of current delays.
> I thought about proposing just the first 4 patches [on their own], but I thought that showing the current series as-is
> now, may be a good idea as well [to gather some feedback].

I think it makes more sense to review as a whole series rather than only
a part of the conversion, it doesn't really help to only do part of it.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--u0lqphHC8S+ob1K0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/kW0ACgkQJNaLcl1U
h9AhYQf/a5Mv8ax53FhE2w2Iee+bq5bvfdkZRudCki/iqJxBUwCNKGfc62eBUwGY
qva3K4T6zi4pbX0dWNMojeJ5lQ7Viu2bnR20voTcVJhOmplIgWhH57tVxRU5bnRt
9205UV5Uc2FNDE1P60lC6Msts6I+8Rzx/a20fZ8pyXlVwOW4n0xxEkiMxYgg5mpo
BbGVM5rYkasqqmq8KjbIKWYl/XwcWDIKw8mlyAuLAq4Vh8KRGfu+kRUY3IqNzDIj
puzpCj6MJZW/8pzNfi/z6Lelkhtvmn04gEu0pMN2C1u9ILeUxixwtqQPv64qTR7I
ySxA++9//Vej3QKiuzfu/u+eDK6+WA==
=nPuT
-----END PGP SIGNATURE-----

--u0lqphHC8S+ob1K0--
