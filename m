Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37B563788
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2019 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfGIOMe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jul 2019 10:12:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGIOMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2019 10:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V/u97jHNPmLvmTFvnXoJFWrA6FUKihtUF7vD/H2p1QU=; b=QOEmchoPQ9nmuToWmMJj/YqMf
        uTd9ny3nzPsSlzStQ0fbSOpLhpxBAyXab6JIs5f+CLQA8+u9suJKoptJFa9pV5sRyxOTHkFXvJjsq
        bqSCW43hh2n8aSGBwPYwQebVVl+HlB3R8ghUTI0urMtdApAyXEbt95/qeMJf8VZHHVaWk=;
Received: from [217.140.106.51] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hkqr7-0005ci-9l; Tue, 09 Jul 2019 14:12:29 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 56D73D02D6A; Tue,  9 Jul 2019 15:12:28 +0100 (BST)
Date:   Tue, 9 Jul 2019 15:12:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/5] drivers: spi: core: Add optional stall delay between
 cs_change transfers
Message-ID: <20190709141228.GC14859@sirena.co.uk>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
 <20190625131328.11883-2-alexandru.ardelean@analog.com>
 <20190626193438.7248d0a9@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20190626193438.7248d0a9@archlinux>
X-Cookie: Visit beautiful Vergas, Minnesota.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 07:34:38PM +0100, Jonathan Cameron wrote:
> On Tue, 25 Jun 2019 16:13:25 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>=20
> > Some devices like the ADIS16460 IMU require a stall period between
> > transfers, i.e. between when the CS is de-asserted and re-asserted. The
> > default value of 10us is not enough. This change makes the delay
> > configurable for when the next CS change goes active.

This looks like cs_change_delay.

As documented in SubmittingPatches please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0koMsACgkQJNaLcl1U
h9DKIAf/ZSDNvbMm/N+6RjKfnFdQwjyhpG6CS03BFIGfNvdDiHDfcIUOccR8kUSS
hWzTKI/7f4jlLyaWXinkVc59G60+IS1+DbO8o2PCAQ3Fpciz5/c6F7BQrLy42Xal
/icTrnVX0d/70ss5a7YT5yj67O7bItcRvbUuT8bDzHIIVzNWmXc8hMZYMTSB14DV
fLs8tnfbR0SK4zjd2smCFHGieZBZquTeBjF2ZQlA0YS232MyNNBJCtmW52KUfbVn
gBukHDwh9QkCJEAdFHknAMmcYPgBF0FXnBkMwhXKeCW9PAxHXK/PC+nqvanw4dmi
ZVeeGKO4caaGNXi5unWwFznO4RwCFQ==
=xlH7
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
