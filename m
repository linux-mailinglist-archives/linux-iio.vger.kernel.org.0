Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0316D1BDCAD
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgD2Mtg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 08:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgD2Mtg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Apr 2020 08:49:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D52621D7E;
        Wed, 29 Apr 2020 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588164575;
        bh=3TPpJC53ymK37dZLXDXOfPIIzQw46+VQdVgo7v80E9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0aZzGHv6mH0BcgdxOn+uYVz2RvCaR1PMEVYKmLouOMFvZ/Tiy5I2+NaOA2IPzxi2Y
         TMUaSGI45uJQrha9eDb3dc/AdSkaryRftgCE5Ga2Q0ppLJc+QiipFVuPigInGP4V+j
         eNI3DzHG3UvKuVYIPGufUmdrkUGfE7fWIkkkH68M=
Date:   Wed, 29 Apr 2020 13:49:33 +0100
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
Message-ID: <20200429124933.GJ4201@sirena.org.uk>
References: <754706C925201D4896E92CCAD6B38E4401F0F733E3@PTW-EX-37.PEGA.CORP.PEGATRON>
 <20200428113033.GE5677@sirena.org.uk>
 <C84B7899-1FC4-43CC-9FAE-8FECE09E8D4E@pegatroncorp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Content-Disposition: inline
In-Reply-To: <C84B7899-1FC4-43CC-9FAE-8FECE09E8D4E@pegatroncorp.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:27:45PM +0000, Leslie Hsia(=E5=A4=8F=E9=82=A6=E9=
=80=B2_Pegatron) wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> but he thought that this is an amplifier driver,
> and we should put it into /sound/doc/codecs/,
> so would you please give me an advice about the driver belongs to which s=
ubsystem?
> Jonathan, what do you think?

A quick google suggests that this is an audio amplifier so I'd expect it
to be in the audio subsystem.  If it were in IIO it wouldn't work with
most userspace audio software...

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pd9wACgkQJNaLcl1U
h9Dmowf5AUjajPkm6TWy/REW/DuKZSQCtdknps1+z1SiiWRwRHW62I0Gm+iPaTxW
xFhA6o1UEc+eTbN8mezdskc3OH4v75Lto2hW2TXM+hepuh6n1LdP4RdK0b2H3nAG
CYgwGKhgvoO7QM0keDx9h70fIsUHDMQyAObfX6MBbQyivF2Cbhp+FTFNy2P3cV/b
adrf5QeWLVu/Mq6TR2A3m/31NJYDnarVTKnfSGaRJmxyJtvvqI22vC9SMGg4a/07
1YwQxGjtPu0RSrJpfE99oR+2zoQUbAXDw7jjqOChK4RrmO5AfoqlHRYFkFzNYZFY
fo0cEugpdQBCm6l4SvIWJRaeYZC5yw==
=Boc5
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
