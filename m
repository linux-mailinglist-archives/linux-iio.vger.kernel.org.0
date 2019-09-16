Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD0B3A91
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfIPMrR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 08:47:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbfIPMrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 08:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PvgI9jxttidIQAqCnbr63HWN/jzz3vy++g+rE4hD1zE=; b=OopqNWipio58W2Q9s6YRw/qHL
        qSGMr/bowmM1Kt+NRdzTWZhe8ca4uEzmb9ZqNs4PVUAbNRhC0KcFF6HD30n4WbjlW7PT23Ws327Jh
        tWYRdxUqAo1r+Ud/T+tVc1R9JmLWub/xicbzV6yaVG4jdj4Gooi+u0vvNe0medAM1dNQ8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9qPN-0004DK-GZ; Mon, 16 Sep 2019 12:47:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4DFED2741A0D; Mon, 16 Sep 2019 13:47:08 +0100 (BST)
Date:   Mon, 16 Sep 2019 13:47:08 +0100
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
Message-ID: <20190916124707.GD4352@sirena.co.uk>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
 <20190913114550.956-4-alexandru.ardelean@analog.com>
 <20190916122505.GC4352@sirena.co.uk>
 <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cd1j4nHwcOEAktEG"
Content-Disposition: inline
In-Reply-To: <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--cd1j4nHwcOEAktEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 12:37:12PM +0000, Ardelean, Alexandru wrote:

> > This breaks the build as there is a user of this interface.

> Ack.
> Jonathan pointed this out.
> There's a V3 that changes both this and it's user (in IIO).

That v3 seems to be a small subset of this series?

--cd1j4nHwcOEAktEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/hEsACgkQJNaLcl1U
h9BGGQf+KEkdqu8sl97blIC9u02sAznBDKI8WBw8hq8w1EI3irkrZZsjLo+22UTB
cUIp8bzIXq5GQ/ZbRPTG/jQOKc44E8gajZBxhWc9bFF2oNQQUy/9H5JoIgeUQspk
Nd6lo3EyKLFHLHHc2zLeYt0HK70RKJHO09MRciWmJBDWoanZC0x7wohRuvJvoNy5
nbtGX9+mdgIqsp17Z4RrDvr4hr1d8vPOHSl54jA0L8y+M+qo4Zcn9WvJ9WXybVZL
yik9wnQApavBdBrubRMqnUri/p6fvp6yGGYKJlNssskGyKB8RoNFqNWSA2YAshPi
WxdlbuP6o9Qq/Twrv5sM9fj02xApyw==
=zm0D
-----END PGP SIGNATURE-----

--cd1j4nHwcOEAktEG--
