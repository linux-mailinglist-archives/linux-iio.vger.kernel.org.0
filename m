Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A061110277
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2019 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLCQjE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Dec 2019 11:39:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51634 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCQjE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Dec 2019 11:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Kcuy/fn6cSz/SJB4bZWplLo8InyBESqnNDB0HH+CV8=; b=su4IqbsC0yREzmmrtcBG8C4NJ
        jwHmKeSMVKlOq7kOKOB6G4d6NJpXJO5ZFZIYz5JpTgyikZR9Y9xQIqAK2Hc8hiI8azARrelzowpyb
        VYvG+AQ0HD9EuV0UESrOcdBACQFiWJC5Fuyz/H10BlOsHdtazC3MxKaVLcsJv4ju1mAAg=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1icBCN-0003Hr-DU; Tue, 03 Dec 2019 16:38:51 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id E42A5D003B4; Tue,  3 Dec 2019 16:38:50 +0000 (GMT)
Date:   Tue, 3 Dec 2019 16:38:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "rodrigorsdc@gmail.com" <rodrigorsdc@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH v4] dt-bindings: iio: accel: add binding documentation
 for ADIS16240
Message-ID: <20191203163850.GN1998@sirena.org.uk>
References: <20191123051927.5016-1-rodrigorsdc@gmail.com>
 <20191123114119.7b0c3447@archlinux>
 <a55b9c576eded8c91a985aabbba89180561ab156.camel@analog.com>
 <20191201114032.1a972dda@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline
In-Reply-To: <20191201114032.1a972dda@archlinux>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 01, 2019 at 11:40:32AM +0000, Jonathan Cameron wrote:

> +CC Mark as we probably need a more general view point on
> the question of whether SPI mode should be enforced by binding
> or in the driver.

Not sure I see the question here, I think I was missing a bit of
the conversation?  It's perfectly fine for a driver to specify a
mode, if the hardware always uses some unusual mode then there's
no sense in forcing every single DT to set the same mode.  On the
other hand if there's some configuration for the driver that was
handling some board specific configuration that there's already
some generic SPI support for setting then it seems odd to have a
custom driver specific configuration mechanism.

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mj5oACgkQJNaLcl1U
h9C/sgf/QxvazMVP9zm49jfiS4yHBJmRZeuDac6ZLwJIaSFBBjGWId42DRoQBXU+
1gZ9GH+tgeT7lGT1w+JXAky7yrNuwA0ERHAOQ1TzT0VF9DKqY+omAYwzBNC1P3A/
pldGP1I/5VsTcsJLVQemowwMzsNo4i3QTDDr07ENM5HAM4IvGVmCwJEfcCy9/q/8
fCpigQGTQRkfA12KD+KnN/87eUKwV93DB3mQ/Hgo9HvE3/BWF7Ra8TvfPCt0EKlV
NZQ4ohTyRRkuu8mwQnwJj5XhEAOa2+ueFH2WLhODhGDz58smKbv3cNASdq+t3Jg7
skZw6qsqmI38m+TAhRr33Kps+gZ8+g==
=JKhy
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--
