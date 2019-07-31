Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4167D05F
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfGaV4M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 17:56:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42876 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfGaV4M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 17:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K/tOdg0rARIHNKt8myQdNk7juboEm6U9R00/FeIUiBE=; b=dAQCdVcqawi/p92YlttDZTR93
        BKyG7tTLWgF7ROCBKJ78mPeMReOpPz03DvX3MgsE3fL4jZKpXbSgEfnsqgHzMIJoSh2RNJNUt/7Vs
        W4pmxcdPzOCef23B1cmjFfttX03YC386eRlZje3tRqBKZnkd81Qs+16ww3Bey4vn/dVho=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hswZ4-0003OG-Ci; Wed, 31 Jul 2019 21:55:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1A3322742C6C; Wed, 31 Jul 2019 22:55:17 +0100 (BST)
Date:   Wed, 31 Jul 2019 22:55:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <20190731215516.GM4369@sirena.org.uk>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <20190731141734.1fa9ce64@lwn.net>
 <20190731202007.GI4369@sirena.org.uk>
 <20190731172613.32d65ad8@coco.lan>
 <20190731203712.GJ4369@sirena.org.uk>
 <20190731182729.01c98cd3@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Content-Disposition: inline
In-Reply-To: <20190731182729.01c98cd3@coco.lan>
X-Cookie: FEELINGS are cascading over me!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 06:27:29PM -0300, Mauro Carvalho Chehab wrote:

> Meanwhile, if someone needs something that it is at the wrong book, he
> can just use some search tool to seek what he needs, no matter on
> what book the relevant information is stored.

OTOH it might be weird for the intended audience of the book.

> Mark Brown <broonie@kernel.org> escreveu:

> > I don't know if it makes sense to have an embedded developer's
> > manual as well?

> Yeah, that's a good question.=20

> Jon is planning todo a documentation track at LPC. One of the things
> that should be discussed, IMO, is how we'll organize the books.

I'll be at Plumbers, not sure what the schedule's looking like yet
though.

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1CDkQACgkQJNaLcl1U
h9DmyQf8CbO6RT3vDVCTbWB0f/yKJ/A87r+D9XnXG94SH0Vqj3KAl/HFsPpl4gyU
1t9Uo9ZtFC8lSFh29z5fxpIzNkfsanBjnTrJS1lxOvU+DgmoTfXV5+2xa3rel1E0
oOzMumEUJLWQmAQIaSzObUMvLTHaHZXE9UwveI9WkjfE0k7lsrK4vKzotxGDUk1a
6B/LdVb+NH3ME369z6GL2hpH6SkNc0jCRYj4PcGud8PTKBqHim7kBI3AeE51lFUV
Dsr7zD6gH+cbj/GXdXApIDJvlR8bH6LLM/dakss84cM6CvJoD/pd4z9fn2kmUkVY
5tMO7f2i3x9slM6yQ78bDwGSrn8XIg==
=1tp/
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--
