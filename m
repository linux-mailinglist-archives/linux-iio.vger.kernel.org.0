Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BECD1CACF6
	for <lists+linux-iio@lfdr.de>; Fri,  8 May 2020 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgEHM5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 May 2020 08:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbgEHM5t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 May 2020 08:57:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040F42054F;
        Fri,  8 May 2020 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942669;
        bh=48NqrDGnrzppujpNDFRQjW7iHDemvgNPr206uvHmtdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSYuM++ubZ3ockKq+n3h6a2DVmUvWRNVWl0SoP8sbObUsreMUAATV9FMCSRJDyv9c
         OjR/Kp0y75wcpwGzOwboHeAnxoeANCLQuWXR/uMt3uTSdvbo0RSDjh/Ry9fRtdH95N
         5zEm6vufOL9EPVf0rZdO+nr2INz3Wmi1JYdrDoLo=
Date:   Fri, 8 May 2020 13:57:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad5933: rework probe to use devm_ function
 variants
Message-ID: <20200508125746.GH4820@sirena.org.uk>
References: <20200428093128.60747-1-alexandru.ardelean@analog.com>
 <20200502192542.63cc25a2@archlinux>
 <20200507095016.GC9365@kadam>
 <20200508134307.0000233a@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
In-Reply-To: <20200508134307.0000233a@Huawei.com>
X-Cookie: Give him an evasive answer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 01:43:07PM +0100, Jonathan Cameron wrote:
> Dan Carpenter <dan.carpenter@oracle.com> wrote:

> > It feels like we should just make a devm_ version of regulator_enable().
> > Or potentially this is more complicated than it seems, but in that case
> > probably adding devm_add_action_or_reset() is more complicated than it
> > seems as well.

> It has been a while since that was last proposed.   At the time the
> counter argument was that you should almost always be doing some form
> of PM and hence the regulator shouldn't have the same lifetime as the
> driver.   Reality is that a lot of simple drivers either don't do
> PM or have elected to not turn the regulator off so as to retain state
> etc.

Same issue as before - I fear it's far too error prone in conjunction
with runtime PM, and if the driver really is just doing an enable and
disable at probe and remove then that seems fairly trivial anyway.  I
am constantly finding abuses of things like regulator_get_optional()
(which we do actually need) in drivers and it's not like I can review
all the users, I don't have much confidence in this stuff especially
when practically speaking few regulators ever change state at runtime so
issues don't manifest so often.

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl61V0oACgkQJNaLcl1U
h9C8yAf+PavksgqAsWThGDHNhdDBAGYyMuu+VSKMkNo1+NN5f/Pso4SPcBnIVTuo
Me4WbVrl2pnpJ6KPtKyAzfg/AqKVX15JpL3rhHikzjN+7HSV5sslQVNkdl4UuGB4
edt3kNZyDsfLLBhhs3FF9gW9TgeZsMPN5f0mJZrMGF6cTvgM5c1k1JxWBXKDRGZw
pDYq3nCPDt2yELv7N2jvV14CgitA/fgpxKQ7D4ejbzR7XBryPrCV29LCjKNfBAHS
y8N0uQYduMFAJ9/TKJm8NgYQsiEW6iRbxXBoBOTT4hsEaroUnBqHTTOR/PyGt3zO
rRTPM1hsbuFXjh9PajDXpUgLlSAv7w==
=mxsy
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
