Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B691A7CEC7
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 22:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfGaUhr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 16:37:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52250 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfGaUhr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2019 16:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f8zgVGeJDIycQcvkIadKAWE4jNOD7aBA1sv5eo5/l2Q=; b=Fo4hgxN3HVjwMzMGY2TUs4nJk
        cYu5gBnxRALeeciuagRuGTeUesgj1mimsQykYiW1FAdV1oM3wAnq9yRimGHqQysqyzNi1rQ3ACukp
        vYGcU2hR5CrMFdGLmmtsrnirZeyRYdOWP3DBo1fOOy+Ovre+VB8+uoagIh7GPnYlxLWEk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsvLV-0003HI-JJ; Wed, 31 Jul 2019 20:37:13 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C34E02742C99; Wed, 31 Jul 2019 21:37:12 +0100 (BST)
Date:   Wed, 31 Jul 2019 21:37:12 +0100
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
Message-ID: <20190731203712.GJ4369@sirena.org.uk>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <20190731141734.1fa9ce64@lwn.net>
 <20190731202007.GI4369@sirena.org.uk>
 <20190731172613.32d65ad8@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline
In-Reply-To: <20190731172613.32d65ad8@coco.lan>
X-Cookie: FEELINGS are cascading over me!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2019 at 05:26:13PM -0300, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > There were outstanding questions about where it was going to get moved
> > to but if I read the diff correctly it looks like it didn't actually get
> > moved in the end?

> Yeah, it doesn't have the move. My understanding from our discussions
> is that we didn't reach a conclusion.

Yes, that was my understanding too which was why I was surprised to see
this going in.  This is OK then, I'd have acked it.

> In any case, I can send a separate patch with the move part once
> we reach an agreement about what's the best way to proceed (or you
> can do it directly, if you prefer so).

I'm not likely to do anything without someone sending patches, I'm not
clear on the utility of the move with the current division of the
manuals.  I don't know if it makes sense to have an embedded developer's
manual as well?

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1B+/cACgkQJNaLcl1U
h9Ccawf2NvrLW0ujC5HwkDxagYC2dfnUGm4OOyP/LcS7ufD9vxwdAh08IDJFyHJv
4skkK8AdqWOxNms4e9NRiQE51vul7GMBtbp3YezYEiaaB3tMTrWe2rHSEp10OQmH
5WnnpB7KKnUS3UBTwvFRzI1mGWz+klXpzy50z3hsX9UXUArVoqyDRtSY0YDF3+7k
UNhXw0y2taeDMGRzZnOTDxQkejK13T42Oo79xbzylHww8x1vVqV2s4xLTqn2zaN4
W0DIoJIGec2Ewe6JPUio9xvsURtWmWOet6jFLRZO9oiO6uJqrvQde50F6siwwFgY
JMTn2OFfPMPUZVF4ugqAE7qxQaHM
=etK7
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
