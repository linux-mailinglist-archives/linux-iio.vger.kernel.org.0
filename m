Return-Path: <linux-iio+bounces-22170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC8B17FE5
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 12:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9963B1C207F5
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52422F764;
	Fri,  1 Aug 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4v8yWo8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944C21A449;
	Fri,  1 Aug 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042817; cv=none; b=G4ffVBUlt2VT44SOKiTOxxMtjBPhzy3lVwNaa5gX2ub8jNEC8ovV6hml+xNkcFf8tFOWOxAq5bGOspbzMqsNwERbXSFONNDz8qb4gReADUWxyqd44S+H4VXaPUP0HEOqZjZbRr+cpL/PUpjoS8SRZu+dQjXaXwDt8V55ItI8CxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042817; c=relaxed/simple;
	bh=AiXXDsJLgqtSU2ewiyyLc7OPZvErRgBqxSaPuCEetrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sjPHwAqepuWCTifC1zM4ok9H4ol7kRgl4Qn39l0oz7R4hJGn7Vmd72dDN7Kn99mHGwnXwxVSMBqEgLFCNYHi5l8XldSVqcQf+Ydn6lNMTWUTzLTLo7VVkB1ESvZCdX5ZeIeDyPYv2vRxJMoo58XBR3EPgQHt9+/PNer039oLlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4v8yWo8; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55b88369530so2134193e87.0;
        Fri, 01 Aug 2025 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754042814; x=1754647614; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsjFcXR/K6tYD3ygTtAo3HB6BBj5oT7HaqfDEoyfNNU=;
        b=I4v8yWo8OOeuB6R5f1WFVEbPSGeiIuMCQELX5ZJP8cJ/3alOU9ueBi9ypMEnQrwWpB
         X7yaSFDRhVLQNJ4EJIPgAu3r5SBDlBLqUJ5jMbDHPMfbJ0RtYtRMjH82qeKTnyazQfJf
         8DvLVHDVwbWxfbM781Ur2pmyLvhZO3TZQUIMnwU6QlkgB4aLM9cQN0dqbx88yZENBKrC
         T6HirMCJo+i2gowGiAJ3w69eM9SFFEqNVOyn/CLLY2Ui39b938R7gpZDyu/S6VBihcHz
         SuC2p09KW5D1HAQuTNVOvim675ZhcBbDH08cHyCoOJ0wOZVGC+CcYRapw/lFn2nbVLiZ
         JfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754042814; x=1754647614;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsjFcXR/K6tYD3ygTtAo3HB6BBj5oT7HaqfDEoyfNNU=;
        b=nwINO52CvgSA5xI07wtbr3oM06AGkUAXUJz96QhbxceOYy2k7oO1w5bnwfMWpcS1bx
         7ZbmABv04voILe6ELvxcCtfIV8ZCJ0Yz/UN1TcUFd2NLv6OueP9ifoSq2WbCqFUzeGJJ
         spDIEOU90AEHVed8AFKLMbDl/Arnz3SNcVZJTcKBu9BH9SpoLjZ8OgUlzM92biUVvBLF
         xYrPL3AiOf4pBOsgteqXUVu4kPbG+uqRH23cAi7c2viljrBFHB2YmcdmtFRSswV7qUvP
         qT60hhWH7+o/6KpTOgtQ+kRGz8Ere3g0IaSszsTe2YWFJm4YwH4Yo4y9W/+lVEjsk0cG
         j6gA==
X-Forwarded-Encrypted: i=1; AJvYcCV28GJO24pz1/I8xKR6adA0EmpUeew2B51ma1hNmMgx5YLejFfLimhKh6zr+n3WpOJadJvya/W+QGR/Na9v@vger.kernel.org, AJvYcCXxaMNS2rWSnw7Fa0re3ew9KCTTi31UGzUG38ebqRRcGVhrkPQfhjOzIwyRc7/RI7VhJ5EcFSZu5JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmR1ABuVtPDOvVmSwEQNoZBApe62GZT2cIP0RSH4R28FJkhqH7
	PC+3F2SYPyIcxkDYSHvenHpjptXwCHXXuTRg9+uzGx0ZMzU0x7751RaT
X-Gm-Gg: ASbGncvDGVZpEx9vUTWdYgCi6VOcxRImwH7schHi/NVgLLo6RbTk3DgjvkLo2a0fMxJ
	mGtDcSDBgwb2YQN/u0uEoDYWD8MUSzSSKCWadbNDlZ6EtQoxTp5UgNFKqE1ltK9AkPWHXAwvkyD
	Bdc0c1+2xrH/Rm2JGx4q7gIxDQWWrHvQeaKruN1xwE/d9VV0gw/tfa/vUz15ofzLJz4qC0J4X4A
	/kan9Fx6C0S7oGWH7hy6JdF37LTuxXeAUaFscNOjHqGKAXkHG8z+zybdRgkrvrIdg4nJWJsYlNo
	5X3dWpeIhU4CxNATH6043yrc8GpS/epb+ektbf71emmiS8dNmMZGDQHiP2vZpGcwCWT/m75zKCJ
	LZYsSx1nmAag/G1BivBpAjs3/RFXKtQewHTSv3N8=
X-Google-Smtp-Source: AGHT+IGrR0xATxmANxS8S0vHPaBN7ij8nOfH5JIWFBL3hIb1Ys8Kq38HkH3qmwGqC3Mq9lyXDvVoTw==
X-Received: by 2002:a05:6512:6d2:b0:55b:8253:2cbe with SMTP id 2adb3069b0e04-55b82532e68mr2806070e87.42.1754042813482;
        Fri, 01 Aug 2025 03:06:53 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabce5sm534912e87.151.2025.08.01.03.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:06:52 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:06:46 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] iio: adc: ad7476: Simplifications
Message-ID: <cover.1754041258.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L3+jy49W10dGVlHs"
Content-Disposition: inline


--L3+jy49W10dGVlHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This series suggests some simplifications to the ad7476 ADC. It is
currently 100% untested, and shouldn't be merged as is. I'd like to hear
opinions on these changes before adding support to the ROHM BD79105 ADC.

Intention of the patch 1 is pretty trivial. I'd just like to hear if
people think the enum + ID table approach is preferred over direct
pointers to IC specific structs in SPI device's driver_data.

Real reason for the RFC version is the patch 2. It aims to clear the
supply handling logic. I did also an alternate version which requires
the names of the regulators to be provided in the chip_data:
https://github.com/M-Vaittinen/linux/commit/cf5b3078feb17f9a0069b2c7c86f6d9=
80e879356

I believe the version in the link --^
is clearer, but it can potentially help people to add issues with supply
enable ordering.

I can't still say if the patch 2 contained in this series is better, or
if the one behind the link is better way to go. So, RFC it is :)

Matti Vaittinen (2):
  iio: adc: ad7476: Simplify chip type detection
  iio: adc: ad7476: Simplify scale handling

 drivers/iio/adc/ad7476.c | 376 +++++++++++++++++----------------------
 1 file changed, 164 insertions(+), 212 deletions(-)

--=20
2.50.1


--L3+jy49W10dGVlHs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiMkaEACgkQeFA3/03a
ocVK+wgAwVKLZ5Xg42CySmvSdrKIeJC7WvP+UomAsYTfxu2Gf2hJc2ncv3ZhiskJ
OOqFwrrgzdBMti01jee/HEapEtTPdSzshkCDn56txvgkmXp1DyJ2PkG5DNqomeKU
UX4W5fmxCWhgqVfBAUg6VyQS0Lncag8sv1XYwYMDXhUNiJpTGbhpCiXCEXvZCT2w
0T4xhEDdpv62DnRzEjhwtWE3XlXgpo3lGP/hWfpppR2e1+DZreBFI8wsmMymUgk9
WB5z84cqFlkWazjo8niHIdXF0XDpHqHJHQGWvNeqtQjaW+ZAF80Y85iQP0KK4I1G
tUCAJtuAhDn+W6d/lW35eoGvUa+d6g==
=OJN4
-----END PGP SIGNATURE-----

--L3+jy49W10dGVlHs--

