Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020211BBC69
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD1Lah (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 07:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgD1Lag (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Apr 2020 07:30:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99138206A1;
        Tue, 28 Apr 2020 11:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588073436;
        bh=bmn/QeL07kN6ZF+drWtdbMskzMxoYTgWWIqxwCRdXf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXN7mTggzYM5iyN9EKtU2t26wDOabguc6BJyfL9I9ZktUFES2RtQ9TuYb3oSdKyGJ
         h9SKy7kOhvpYLmygqhauu4Ndgh/XXWktuuTitkA5oIm7y+SidIvmVZ/jNqIM4m5+sV
         /8R2NSjfbzEFBH4knAeFN8+52tqfm+s60t0W5LpM=
Date:   Tue, 28 Apr 2020 12:30:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Leslie =?utf-8?B?SHNpYSjlpI/pgqbpgLJfUGVnYXRyb24p?= 
        <Leslie_Hsia@pegatroncorp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hermes =?utf-8?B?SHNpZWgo6Kyd5pe75YqtX1BlZ2F0cm9uKQ==?= 
        <Hermes_Hsieh@pegatroncorp.com>,
        "jesse.sung@canonical.com" <jesse.sung@canonical.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] subsystem: Amplifier driver for TAS5805M,Texas
 instruments
Message-ID: <20200428113033.GE5677@sirena.org.uk>
References: <754706C925201D4896E92CCAD6B38E4401F0F733E3@PTW-EX-37.PEGA.CORP.PEGATRON>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline
In-Reply-To: <754706C925201D4896E92CCAD6B38E4401F0F733E3@PTW-EX-37.PEGA.CORP.PEGATRON>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 10:43:18AM +0000, Leslie Hsia(=E5=A4=8F=E9=82=A6=E9=
=80=B2_Pegatron) wrote:
>   *   Author: Leslie Hsia
>   *   Amplifier driver for TAS5805M, initial the amplifier and set the so=
und parameter.
>   *   Signed-off-by: Leslie Hsia <Leslie_Hsia@pegatroncorp.com<mailto:Les=
lie_Hsia@pegatroncorp.com>>

Please follow the patch submission process that is described in
Documentation/process/submitting-patches.rst in the kernel source.  Take
a look at other submissions on the list and follow a similar process.
There also appear to be both IIO and ASoC drivers in there which is at
best a bit weird.

Having done a quick scan through your code it doesn't actually seem to
integrate with the subsystem at all (there's no
snd_soc_register_codec())=20

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oE9gACgkQJNaLcl1U
h9CBNwf9GnZKlT7pJP/Ffhe6NYK62tVJxbnR+kIljUUaRAdSQyXtO0R54DP6U890
CZoGgcrPIG+TYwY+mFJ29DaTKGVWGlkoXsEQi4kECGmKLKTH3lfY698eXGqJM4WZ
TplTUGDbl1n08WOpqdLeX1XdEXM+LHqBAAG7KmNgk/MYFFnVN0QMADONgtAW/6SW
vfyMttbzzRAOYGZ5wUsnL6+O1qShCElLKOzhcIj+3XDD+rt+iejwrq0hd1CUndWY
Zd7ENnySP+KAtk4pYfr0UbjNzdSbKDnQgLEiRFNoCHizBF/+28O0PslkVKSgAjpQ
2TGhh2N0R+7r03DW5Kpuj7U6xxPZvQ==
=n/8D
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--
