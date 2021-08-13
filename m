Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4604F3EB9A6
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbhHMQAh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 12:00:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57626 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbhHMQAg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 12:00:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8B2581F44986
Received: by earth.universe (Postfix, from userid 1000)
        id 647943C0C99; Fri, 13 Aug 2021 18:00:06 +0200 (CEST)
Date:   Fri, 13 Aug 2021 18:00:06 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 0/2] mfd: rn5t618: Extend ADC support
Message-ID: <20210813160006.r4anec2g5vv73mao@earth.universe>
References: <20210712212111.18896-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2n5xgpexbbwyfdgu"
Content-Disposition: inline
In-Reply-To: <20210712212111.18896-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--2n5xgpexbbwyfdgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 12, 2021 at 11:21:09PM +0200, Andreas Kemnade wrote:
> Add iio map to make voltage_now related channels accessible to power
> driver.
>=20
> Changes in v3:
> - use scale functions
> - add acks
>=20
> Changes in v2:
> - use iio_map instead of devicetree to allow mapping which does not
>   block future extension by devicetree.

Thanks, queued.

-- Sebastian

> *** BLURB HERE ***

:)

> Andreas Kemnade (2):
>   iio: adc: rn5t618: Add iio map
>   power: supply: rn5t618: Add voltage_now property
>=20
>  drivers/iio/adc/rn5t618-adc.c        | 23 +++++++++++++++++
>  drivers/power/supply/Kconfig         |  2 ++
>  drivers/power/supply/rn5t618_power.c | 38 ++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>=20
> --=20
> 2.30.2
>=20

--2n5xgpexbbwyfdgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWlwYACgkQ2O7X88g7
+ppMJA/7B8DgrZ1oaXrWqWSByzip+PLtC1Xov6eDVPZC6o/sGihnJcYewrhCR10x
fwRV3sY/aj4/M1vOoiJF3CHHSg57gzLx8cNXi+a7tz5KY/cHcg2NCx4E9J4zffNy
d1i6rmRYhuDCxvGAvko0kz59nW1UwDEd5NLl+QaFPazoKnwPgTlOPSMR3NfFGWFm
FbJyt6Q2ZfiGptfyXBeNFEyfLbg0nIEE34RNbClhhKz+37kt91wgDvTFvieEGAxd
cQGL/wKoBWfytjZc5kDN4o/SZRQSRQXdv6ercuj+3yvVcRASnqlR43wo75vTOsZZ
MBFLOSFei0e7KOY2yAov4zKlOvJj4Y3CfdqkU3GgQI6qxzh1crzqOfnmb8oItVPE
jOVVKmb43ctd1w6dSTvqEq6lZTuQma8kSfq9EdUdzHfKjpqhFClY3c5+KK2QYcQR
+DMNUJGRIge9JrXk3E3b6PpFA/xjsjJ/Of1qJ7+Ap2I5eogd75idaGhh3wDxmH6J
Ps3U0pSV3QtXV/6bHn+tX2AEXvdl1PdemDCDJVoLByuzBUDqaL43qubwDdjlE+Ex
cfGBNsaoK4FQgh13H9ILibQQxsyxGK611XGDrM0l493Ly9K3ln1I6Gcmg3PRWBUn
13sphZ9c/wgAR6PRiMml7SmboBA9173iUgK2Qnt/rKIKDAxGCHU=
=F8VB
-----END PGP SIGNATURE-----

--2n5xgpexbbwyfdgu--
