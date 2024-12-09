Return-Path: <linux-iio+bounces-13276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035889E8F11
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 10:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED0718843BB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF302163AD;
	Mon,  9 Dec 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c2AuZ7py"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02A883CD2
	for <linux-iio@vger.kernel.org>; Mon,  9 Dec 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737654; cv=none; b=fS05Rv9fZGh15svI56Eqce38NkK85iWuw3peQuESSRfpBaFnugFue5FF6vi0/j+D7Wdedv19CIRiVyF4txRK5IdNPqfDAd4CbylBG+A+Nbr7ITW033NyS/iYPDPOhFnhj2cktPPKQYUG08aUB41If25a7oWwKm0JpgIQ1h6axdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737654; c=relaxed/simple;
	bh=K07jIvgxnq4fQSz9W1GmPP+8H2Q8eQ52r646fgKHgi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pupy7Ih2C9IZ4vX0i9vQnG8TgAz7t/YqYzBx2nDKkPyndn/lqF9ugsSeA/MpagKFav4Ul3SLn5hfTlWY5XX+U+U72SvSZpfocyf34F7QHp3PCf5OLVwYfDxhTQN8J4//00ohXRrfeao/vpaulEmO+1X6hvUhaIqc3iwpn/FEQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c2AuZ7py; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a83c6b01so26809965e9.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Dec 2024 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733737651; x=1734342451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=go7aKeAGNa+zmvwqLwnt7aZLIGXrLJCVtHxrDJr3aos=;
        b=c2AuZ7pyC+34u2SnRX5rQCjfLwvgCC0xGuHk3QRDJa2iMKdwYEEuMzTx8wldCWC7Tr
         Tw358cBl3LyhW+1PrN0UHquFogstsmHzEE7MztXD5a6K/wYiQ20weWQtiWSgQwxmCGK7
         OBbnTynhO+bVWqZP+S3svQbcDCIHN3nM11rq4Nr490qKlt8eKKdGaTZ7zLP9BXBMxIH8
         eSK/NFfgrCIM/20qohzdWyrXGLF01Q9/VSzsjJUbkrYWoyiBbQQuTHSvTw4NSz2XcyAi
         R8KYXGRVVNxo19Pkv/vf+zAwabzOzuCFTLaqN1Km5AQJO8AwLmUUeV1Ssf9TeXlDEK4M
         +O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737651; x=1734342451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=go7aKeAGNa+zmvwqLwnt7aZLIGXrLJCVtHxrDJr3aos=;
        b=CUJakctBd45UB/2j+GIESyjjg7d3AiOOeWNKG35ytip2tXhkvwSYnj6gyYfBJLuIaY
         95AgqZJw0Az0D+lSZvxZXxSQm4XQvX2qjuyTDX4HUFm1G7cbZioB5GyI10nCdFVVHPvi
         /ZjMfBREqYwbnGz776tSZ4IWuj2g0anLGt4/L4igY1hJEnMh19F74e/L+6ftlGruBx8k
         5F0s1rNo/ZV/cDJGM7snA9scMOz6bkLK9Yf1xNfHJU15uxRp3veHtw+sx5OiPxW+cvAD
         pj8VdnnuOvN0YujUWuFaXF+/BdnCLUKl8/KV5SB8pQ9YT2jsxWhM0K+mJWHW1s/FS4YT
         AMYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYGfIvecdbG0K6SaPwbpVJDL/VaPctLEFdJxanwd6RGViLiXjnxj+rgFujq4QqGyp9DAJ0PHISQcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgBFlz4CALFbhRnctzdAde+oGlvH+jo+wdxvrAPVMTN9P2y7j
	UZmkgNt2F7RKrHDFSLceEqxxRaXB70D0BdpmIpd6Jt69vKn73vWxYmZz/jtaOIQ=
X-Gm-Gg: ASbGncsKEDtwNVpXb+e9WgTfJrosEiBU4q8F0Dg2HYlRwLOcDSd3V+DQzdY4TR0j4jx
	5+EpDq/9h2P1JhDTaMkV+hEoI5UKxNjW3U7w3eiscoIe+GjE3kZAOdP0MRuCcaNAOKX+4pD7U9k
	d/9Guj724JfSKWk5Vq5QLS+mSdOwvdffij7d3fLMl+QbpP24F7pv8HvkdsCGjuUkOJA8k1bYtDV
	Ci9DWNgigOE7ElDtJ+0MJKIwYu7ynNrSusLF1lm8eFZNVIX22j1MuiaVcW9Wys6vcsQ1o33eCpF
	SmRM
X-Google-Smtp-Source: AGHT+IHRecFQQNLyXbxBQpttqJ1lAcmZD8yh3DpftERm3jw/gVyJso6ESDoowKCKRbH4kTl6gHb7TA==
X-Received: by 2002:a05:600c:1909:b0:434:f5c0:328d with SMTP id 5b1f17b1804b1-434f5c03dbemr25258975e9.23.1733737650959;
        Mon, 09 Dec 2024 01:47:30 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f55733d2sm43949695e9.40.2024.12.09.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:47:30 -0800 (PST)
Date: Mon, 9 Dec 2024 10:47:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
Message-ID: <roit3rdw6a2wv65fpq7xuullbreyz463nch2n2xmjop3b2saoe@pbhm4kahmgsj>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
 <20241208124427.3b90701e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbp3kdig7cnyz7vt"
Content-Disposition: inline
In-Reply-To: <20241208124427.3b90701e@jic23-huawei>


--xbp3kdig7cnyz7vt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
MIME-Version: 1.0

Hello Jonathan,

On Sun, Dec 08, 2024 at 12:44:27PM +0000, Jonathan Cameron wrote:
> Given the mix of fixes and other material (kind of fixes, but also kind
> of new functionality), I've queued this for the next merge window in my
> togreg branch.  If you think there are particular patches that need to
> go sooner then I can handle them in a split fashion, but that does add
> risk that the whole lot might no land depending on timings (particularly
> given it's coming into vacation season).

So you tend to not backport the rdy-gpios patches (i.e.

	dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications of a gpio for irq line
	iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO

)? I personally would want to have these backported, too, but I can
understand that you might decide that in a different way.

Cherry picking

	iio: adc: ad_sigma_delta: Fix a race condition
	iio: adc: ad_sigma_delta: Check for previous ready signals

isn't trivial without the rdy-gpios, but they could be reworked. Tell me
if you want a helping hand (or an eye judging your backport).

Best regards
Uwe

--xbp3kdig7cnyz7vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdWvK4ACgkQj4D7WH0S
/k4rbgf+L7dAqJHvnZ5OSYdnxIwrzdSmn41lQWkFfGmQO6Cgtged8IHTYN98llcX
vkTEFuut3s3M6sa3LNLHttuArX66zzuUIplUDtMoKI7yYI8cnjLs1OOrXSGceQik
GF5K2BRC9ZMn/A/2Nh4F+Tj37N2VSTcbAILJ8dy4DjfNYO+DD0B5EFKBXNzkcCf6
DhJhuS3IKX0YDAQkcuOW0wlJOdN7Z9V0VeKO0xvQfhgn8tGF7kwPm3pWCz/VAa5z
WCa1+f6OFoheffeUGZ3wtn4O/KZd1DudoaANAaWbZcRW5i7IJQW1h3HLCOlXCsx2
kXaV2TVxb1ImZq+7L8pIAcaMSaIdbw==
=3hfE
-----END PGP SIGNATURE-----

--xbp3kdig7cnyz7vt--

