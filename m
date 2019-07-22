Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32570393
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfGVPVh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 11:21:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfGVPVh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 11:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GRH4LnU5ViZtMGHEsEp/vqva0F0wm21N2vWJmToWljk=; b=aUV6XEHo0PdIqX6ITKyFjeglI
        +3mE1SamSPgc0r7Wp73J1LBoDEhOyHvHoRncJBU6bGhTVaIBZtFcd6Q59mf5FZm+BqCJeCAS9gc1l
        TGxCLkFdfEzRFjYF1c1oiUGCUbwnBexh+rHqiUvKke242Pqf7Emj60FD5na2prmpR8PHg=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpa7j-0008Ob-E0; Mon, 22 Jul 2019 15:21:11 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 55D8827416F9; Mon, 22 Jul 2019 16:21:10 +0100 (BST)
Date:   Mon, 22 Jul 2019 16:21:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/22] docs: spi: convert to ReST and add it to the kABI
 bookset
Message-ID: <20190722152110.GE4756@sirena.org.uk>
References: <cover.1563792333.git.mchehab+samsung@kernel.org>
 <be171b438013f8824425595e3d637f5e7d466249.1563792334.git.mchehab+samsung@kernel.org>
 <20190722121151.GC4756@sirena.org.uk>
 <20190722101035.4f61c1bf@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <20190722101035.4f61c1bf@coco.lan>
X-Cookie: No skis take rocks like rental skis!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 10:10:35AM -0300, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > On Mon, Jul 22, 2019 at 08:07:31AM -0300, Mauro Carvalho Chehab wrote:
> > > While there's one file there with briefily describes the uAPI,
> > > the documentation was written just like most subsystems: focused
> > > on kernel developers. So, add it together with driver-api books. =20

> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.

> Sure. Do you prefer this prefixed by:

> 	spi: docs:

> Or with something else?

Anything starting with spi:

> > >  Documentation/spi/{spidev =3D> spidev.rst}      |  30 +++-- =20
> >=20
> > This is clearly a userspace focused document rather than a kernel
> > internal one.
>=20
> True. What I've been doing so far is, for all drivers that I'm converting
> with carries more than one documentation type (kABI, uABI and/or=20
> admin-guide) is to keep the directory as-is, adding them under
> this section at Documentation/index.rst:
>=20
> 	Kernel API documentation
> 	------------------------
>=20
> That's the case of media, input, hwmon, and so many other subsystems.

> Yet, you're right: this implies that there will be some things
> to be done, as the long-term documentation should be like:
>=20
> 	Documentation/admin-guide/{media, input, hwmon, spi, ...}
> 	Documentation/userspace-api/{media, input, hwmon, spi, ...}
> 	Documentation/driver-api/{media, input, hwmon, spi, ...}

> Btw, if you look at spidev file, it contains stuff for both
> userspace-api:
>=20
> 	"SPI devices have a limited userspace API, supporting basic half-duplex
> 	 read() and write() access to SPI slave devices.  Using ioctl() requests=
,"

> And for admin-guide:

> 	"For a SPI device with chipselect C on bus B, you should see:
>=20
> 	    /dev/spidevB.C ... character special device, major number 153 with
> 		a dynamically chosen minor device number. "

I think that split is higly artificial...

> So, if we're willing to move it, the best is to do on a separate patch
> with would split its contents into two files: admin-guide/spi-devices.rst=
 and=20
> userspace-api/spi-api.rst.

=2E..

> Ideally, we should split what's there at media/uapi into admin-guide
> and userspace-api, but this would mean *a lot* of efforts. Not sure
> if it is worth the effort.

Is the admin/API stuff even sensible for things that are more embedded
or desktop focused?  It feels very arbatrary and unhelpful for things
like spidev where theuser is going to be writing a program.

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl011GUACgkQJNaLcl1U
h9CZ5gf/Vsyo2s1zqSdsE+XThHziQ8cTLyZGPQXBl9NPwjRgYStFIoEqDLybvHwh
fUff37LiyFYcFrJvexN8aJBiJK8fTbbDdbqAY0K48HJIaIsQzXHyWU/PnCT6TcpZ
Pq8TgmqknTHlORqVhUTCoGa9RG7VxjrUxO+CaO6JULIzvpFNfXzuK4QoYlBx0SD/
hjYZTs7SLRtas2DgKwYDFgTgxXHe9+usm/xAKxSff8dA9MDmdGrURlhAmsLRHWpb
dqlJZiSgJYQhkM79SqXkSXCr6NMfZHmuV1ACo/9dbDkFdCxeDf424Z9WKRd45d05
P5/YE7JbpJxcV+8Q17sLnA5Xe/6JQg==
=j0gD
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
