Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A823D3E47
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 19:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhGWQd4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 12:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGWQdz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Jul 2021 12:33:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A46A960EAF;
        Fri, 23 Jul 2021 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627060469;
        bh=CYlpIedcz47SMki4XJaCg60Cl6KIGEWKSosuQM3Da5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYTpV6vr47MGtABBYcSiDYzO8bV0M74JyBnuTlcKTdYNO0dRbD2LXkAAhPy8Xm5BU
         0ltitCpD2RVzy2y5Ah7KfrmLZUw1hzTHseWj3+GFpiTH0pfXI2qzw7dEqAAbPjb/ng
         cu9gLDlEU4bTL+jDrdn15dhsq7zud4srBnx6t/c3wu61IujDJuE9fAn4bdG+QxdNDD
         01iYQ9caSh9ow3XrIaQ2mcFwzu2keOCxXp1t7KlCeCbQitDsjv7DEjsKSLM9WZMBRu
         IloX3G0vnS3G8UbhTQ2xMy9p31cKHOduXge6fQ368UR3fYN3NBd6EqOKEWciz94gC/
         81iraSVD2HgYg==
Date:   Fri, 23 Jul 2021 18:14:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <20210723171422.GK5221@sirena.org.uk>
References: <20210722062155.32998-1-puranjay12@gmail.com>
 <20210722062155.32998-3-puranjay12@gmail.com>
 <20210723181022.000032bd@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="++alDQ2ROsODg1x+"
Content-Disposition: inline
In-Reply-To: <20210723181022.000032bd@Huawei.com>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--++alDQ2ROsODg1x+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2021 at 06:10:22PM +0100, Jonathan Cameron wrote:

> @Mark.  This has come up a few times recently.  Are we now safe to assume
> that regmap will always copy data when used with SPI and hence we no
> longer need to ensure DMA safe buffers?  =20

Only for single register I/O, I'd not assume that for things like raw
I/O.

Note that my name is spelt Mark.

--++alDQ2ROsODg1x+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD6+O0ACgkQJNaLcl1U
h9CqMgf9G6rh8/mDkku74x+s5FbZRx5bRl6DTaQU9k2ZoYnD7/AvmvmvbTCqouTE
WggjQ3Xvayj6Lwjzbz95WXm/Ovc7bbnXHHWWrZecG4Q+WX7VhcwSKsslzILp686q
4XDUpWkZYJTozBB4rkTIzaqzINC0egM3NjTZ/HASh055ttt9xXUVc6QE3Gi0b1hB
PMH+1jHZIIW/OVJ8PKbFLS49QQTnTFe+2psoV54N39vEC2bCo6dtaP2qkICzkpY2
TEMZwHOdRrIfhAkTzpjaysV63VcJ3Beku5Azp2BVrW3oyoqWpGKQ38jK8inGYKGz
xwUU6LfgYze0IJaRrn6sslRfaLc3+Q==
=yk9t
-----END PGP SIGNATURE-----

--++alDQ2ROsODg1x+--
