Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC6F2C0C48
	for <lists+linux-iio@lfdr.de>; Mon, 23 Nov 2020 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgKWNwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 08:52:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730801AbgKWNwV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Nov 2020 08:52:21 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37DCF206F1;
        Mon, 23 Nov 2020 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606139540;
        bh=boR4AkcrEEwH8YMVfzi8MbbJuQfQ+H1mW665VtBRB8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kd3Wj26oXt4JkqWcLdAI/UrZXil01vAUiLm/nvJCnf8AVE7PYeYDduM+1uDwVfIpJ
         XMpuhEG6GQIXDG/ob3aJ3qfwUCCfdfURursriDpm1NXI6ZiG2GOvsKA/1Bq91lbH5p
         3f/h/EfCIfR5S4zs1qxj9Me8X10eUbu88dyBiqx0=
Date:   Mon, 23 Nov 2020 13:51:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: stm32: dfsdm: add stm32_adfsdm_dummy_cb()
 callback
Message-ID: <20201123135157.GF6322@sirena.org.uk>
References: <20201121161457.957-1-nuno.sa@analog.com>
 <20201121161457.957-2-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <20201121161457.957-2-nuno.sa@analog.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2020 at 05:14:56PM +0100, Nuno S=E1 wrote:
> From: Olivier Moysan <olivier.moysan@st.com>
>=20
> Adapt STM32 DFSDM driver to a change in iio_channel_get_all_cb() API.
> The callback pointer becomes a requested parameter of this API,
> so add a dummy callback to be given as parameter of this function.
> However, the stm32_dfsdm_get_buff_cb() API is still used instead,
> to optimize DMA transfers.

Acked-by: Mark Brown <broonie@kernel.org>

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+7vnwACgkQJNaLcl1U
h9AvSAf/WFgrIuqIQDUIs360km6F5GwWucfjOP8gILvJEZDQP4/3Xv4CapLrxp8q
hAQg8uPm5B03L0l7jdvlQXgbHfNn2QT//ZoPQAq4JLFk4nKy1KreuVrCWlTIvk1i
JViW06D8pOIW9hB8SQ6IGCaOO/rU+jUTjVtXEi6gWaCCcBLvBdt+YHX6WZdb7mef
vNIvjCUNfH8NOd2GFqktNJ2aQ7AVIYK31vry9J/lUdl/+m1g/8oirvKKgwyauu3m
8Q/qXGi7NWciyLvoDyWmOfnxuOIPED4Xt7THFt/Q8Stj/JXGbklrY5IdJxV4pINT
DwLj/DSU8UP7+SPTZ5VXzamcUgFtUg==
=qkiq
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
