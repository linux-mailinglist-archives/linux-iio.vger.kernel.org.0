Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BDA7CE1A
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfGaUUw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 16:20:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaUUw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 16:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eSpZl/myp0wLmres0SzdL8uz08rnblNQITo3VV+tXno=; b=YYhiErzLfdL7neEK7d0phFEhA
        9rYVeR7x7t8t6paB3ZYVvcpsMo/itLyxCB2hOJT8gnOe2xOO8iAjeWRiY7cTpKhSE6/BN2x8m4rMQ
        cSB16hNa+oZ9qF3mqcbLxgvqdCuQVoTjgi1w17GQcvLfcOoOipIPzkfbVKuqdLoY5fX+c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsv4y-0003F9-G4; Wed, 31 Jul 2019 20:20:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 634FD2742C99; Wed, 31 Jul 2019 21:20:07 +0100 (BST)
Date:   Wed, 31 Jul 2019 21:20:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        samba-technical@lists.samba.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve French <sfrench@samba.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-cifs@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        Hartmut Knaack <knaack.h@gmx.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/6] ReST conversion patches not applied yet
Message-ID: <20190731202007.GI4369@sirena.org.uk>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <20190731141734.1fa9ce64@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline
In-Reply-To: <20190731141734.1fa9ce64@lwn.net>
X-Cookie: FEELINGS are cascading over me!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 02:17:34PM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > As promised, this is the rebased version of the patches that were not a=
pplied
> > from the /26 patch series because you had merge conflicts.
> >=20
> > They're all based on your docs-next branch, so should apply fine.
> >=20
> > The first one fixes all but one error with a broken reference.
> >=20
> > The only broken reference right now is due to a DT patch with was not
> > accepted (no idea why), but whose driver is upstream.

> All but 5/6 applied, thanks.

Oh, I still hadn't reviewed this version of the SPI stuff :(

There were outstanding questions about where it was going to get moved
to but if I read the diff correctly it looks like it didn't actually get
moved in the end?

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1B9/YACgkQJNaLcl1U
h9Bg/wf5AdzUWJa+NJteGVMxcv2AdvS61I9agmCR6mMbPERTL3lRkGvteyyk4FqS
OLlGCoSv8ytbJJ7mVGt28aBLCB7cHeDQGGmdf7OM3nJGun9yy4mmhOUIWxgjWRCl
SgO2qZpfOz121zfa2goqOfdNzbPOotjeuIyVJxvNH0NLLvRjjDZ1+4rXUjvMZf26
cVK4dXIu7+m0Kh6N6EFG9vmpNjbh23zfkd89kH8bMBGaOHdhj/3cRmCw2ZxK8Uiz
Z+xwRCyTI0CIegyUp0ZKheAqubruDFR7y0F9sYcI5KR+w0cDrfxYjOUgZa2JJKn7
Rdr1TAWXS/LG/aYR09ZGPHQsIsDKIw==
=V4AT
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--
