Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC951F0F8C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 22:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgFGUYS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 16:24:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53638 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUYS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 16:24:18 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 44C241C0BD2; Sun,  7 Jun 2020 22:24:15 +0200 (CEST)
Date:   Sun, 7 Jun 2020 22:24:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com
Subject: Re: [PATCH v3 0/7] Support inhibiting input devices
Message-ID: <20200607202414.GB13138@amd>
References: <20200604072853.GP89269@dtor-ws>
 <20200605173335.13753-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20200605173335.13753-1-andrzej.p@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-06-05 19:33:28, Andrzej Pietrasiewicz wrote:
> Userspace might want to implement a policy to temporarily disregard input
> from certain devices.

Wow, you certainly cc a lot of lists.

> An example use case is a convertible laptop, whose keyboard can be folded
> under the screen to create tablet-like experience. The user then must hold
> the laptop in such a way that it is difficult to avoid pressing the keybo=
ard
> keys. It is therefore desirable to temporarily disregard input from the
> keyboard, until it is folded back. This obviously is a policy which should
> be kept out of the kernel, but the kernel must provide suitable means to
> implement such a policy.
>=20
> Due to interactions with suspend/resume, a helper has been added for driv=
ers
> to decide if the device is being used or not (PATCH 1/7) and it has been
> applied to relevant drivers (PATCH 2,4,5,6/7).

But is that a right way to implement it?

We want this for cellphones, too -- touchscreen should be disabled
while the device is locked in the pocket -- but we really want the
touchscreen hardware to be powered down in that case (because it keeps
SoC busy and eats a _lot_ of electricity).

But simplistic "receive an event and then drop it if device is
inhibited" does not allow that...

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7dTO4ACgkQMOfwapXb+vKNuACgw3cpx7Z15Nm3EAs8yyTuu1RS
DsYAn1yorcZKMbA2oKpOoVakbRalRIie
=Dt1J
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
