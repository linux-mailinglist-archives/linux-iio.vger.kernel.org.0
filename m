Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BCA44AD3
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2019 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFMSia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Jun 2019 14:38:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47416 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSia (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jun 2019 14:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N5gjGcYoQZZl5JqrcxsUv1o4lauQ728+0lZMR0CyIYo=; b=KVerzfWIuvgOGWj2T9+4xZwpz
        SPEygCiZ+IwCDwxWi17byi9WoJLv220Lg9VWaSRDHpxJj35cTBKSsOHyrT8B5/wBxWgYb7B4XC+A6
        JDIpMtJIdmhAVNRQpM/uq6kXhytOSAYEaafiQJFdlJOVWY5vQIiZ4q2DPgcrBqy5aNDb4=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hbUcB-0005Oc-Il; Thu, 13 Jun 2019 18:38:23 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 0726D440046; Thu, 13 Jun 2019 19:38:22 +0100 (BST)
Date:   Thu, 13 Jun 2019 19:38:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH v2 0/3] Add ST lsm6dso i3c support
Message-ID: <20190613183822.GS5316@sirena.org.uk>
References: <cover.1559831663.git.vitor.soares@synopsys.com>
 <13D59CF9CEBAF94592A12E8AE55501350AABEAF3@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Sa0i77dkqaUxqYg"
Content-Disposition: inline
In-Reply-To: <13D59CF9CEBAF94592A12E8AE55501350AABEAF3@DE02WEMBXB.internal.synopsys.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--1Sa0i77dkqaUxqYg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 11:42:50AM +0000, Vitor Soares wrote:

> Since the regmap-i3c.c was already applied in:
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git=20
> tags/regmap-i3c

> I wonder what is clean way to submit this patch set?

Just mention in the cover letter that it depends on that tag, the point
with the tag is to allow other trees to pull it in if they need it.

--1Sa0i77dkqaUxqYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CmB4ACgkQJNaLcl1U
h9DdLAf6A5rVHIcRFaF0D/uW7cFQ1G2BO4pg7pNoyrzr8oOHuBBi48aBuLG2UETF
9QXMIPL3tXBf1d+zYcAadqM1mmZJ1Rhqb9KmRSMVrHj14gmHJ0t/9WOiwA3kCpdJ
ka0ybLtuSwRilY6jyol7h6sMsaIhn32Ua4tWwBBpiPvsIxGYwZE0sdvmG0racV5p
rjEVIJhfPrRIfH4+C9g9W3EwzhfAiyolf+8+r7SgoQCrAiNTCQjc8Kyg8iGLObbj
ORZwz4GDHk0FJq0ntnYhN317EQflHz3NXyqPkNpEzVtYTvNmnLkk1TZpvPvPbAQD
fP8ERKAe0E5wwy+9AKHTlB+iWfqLVQ==
=DRFp
-----END PGP SIGNATURE-----

--1Sa0i77dkqaUxqYg--
