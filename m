Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824DBFB6F5
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2019 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfKMSBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Nov 2019 13:01:02 -0500
Received: from sauhun.de ([88.99.104.3]:59180 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfKMSBC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Nov 2019 13:01:02 -0500
Received: from localhost (p54B337BB.dip0.t-ipconnect.de [84.179.55.187])
        by pokefinder.org (Postfix) with ESMTPSA id 6D8812C040C;
        Wed, 13 Nov 2019 19:01:00 +0100 (CET)
Date:   Wed, 13 Nov 2019 19:00:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Fix too short conversion time delay
Message-ID: <20191113180057.GA2764@ninjato>
References: <20191113092133.23723-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20191113092133.23723-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> According to the datasheet, the typical ADC conversion time is 2 ms, but
> no minimum or maximum values are provided.

That sentence makes me want to increase the delay to 4ms.

Maybe we can ask someone at Analog in parallel? I recently found this
patch from an Analog developer in my inbox "[RESEND PATCH] drm: bridge:
adv7511: Fix low refresh rate register for ADV7533/5" Or do you guys
know a better contact?


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3MRNUACgkQFA3kzBSg
KbYvLA//QC2khOniuIXDDEiySNx0++QypYnYPbaNT1FsIp8gPDnwhbhC/WAf/3qY
6Nbb3lWwkcILTs8seOJ2VBKLGYM97cFU0dFCv/YJiU2l/JAftQ5ZKwtnkaxBjyVX
KA4CId2zw4c9pGgBXhFdqBazd4gDThNtGgLVz1adactW7+7eU3PWFKv6HXxXM2W4
Rs1tjtYEmFRA5TVn8n5Rozn//chlgoYKPTCEv1igdW87U/AeLh4zrZY5Y3qDjSLg
Pp43uiOZa1bZ9+3KQw8bSbV1T64fxhzQGE4ARUb0OQym5LhL4ARjHUYY/HBHU5CH
0U7RHGoA3rowtSI7t8wn9Y71MeZB6kbXdJhdHL1OyTJkqxKLFm4wxJYAKdOsHRfk
U1vqvrmODrwz51yoCxzXGum9OV2bDnc1K2fESWAvJe2oNAJGbDJgDIsP1J+nFbqn
CCugzMdpPIH0vFrqmZCSKHd1588o4YdNL+LiP+eRGqzPFPFJhpkdP5ABI6qEg5sL
dQPUbA21wQFYF1Lvmxz06/oRVJ9lpjJiGKRQtpjuju4Zk7x7TAw+DE0KdioVuyDn
bKhIew+2Dq6fLY143Ulk6I5xJ4stfdjX5kEKoOyf29xvI0pZDwL3VmysN/dGU+bd
xpYu3BkMP4VhQwvlKOe4OAlzTbb8y+V9EJabXgSfJi3ZDO9rM0Y=
=W4r0
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
