Return-Path: <linux-iio+bounces-25179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B11BE7580
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235031893752
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD02C2D24A9;
	Fri, 17 Oct 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="a7/OjAeo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987712D4B71
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691822; cv=none; b=Z4Xza5I4vD4y3ooDNU9h0VfiYl1kl2Fiibn0SXVxzFA75GG9LSj6VXixIrNIxNK2jjj4QDPV59WahiFJrYbmBU+t3CuH1GM5sWAJE5F/F7U/QNp2QKpmV0ZORuExkTI4nCR/p6vV7gsUgKW/2rNo7iSPYiiOwkcG+LVGHLJNCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691822; c=relaxed/simple;
	bh=o0euswfbAFBhsCKZA32krNWdrQ5q8hFRTdiPW3SpL6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxmRyT27eetmqt9h376NPNeslgG9BF2iGpye9OAHf3b0HbjgjOtwLw9H5p9EsvonCMnC2NkZI9Qrw/KgkUcHplguw6TH2LREYh3lsmxdk/EBUdVGoGffJ7ycnHcHVu+6FiLvIxXwqZ2RgH00awvGFPfZHloD7ZOoh0kSzWNw/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=a7/OjAeo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=o0eu
	swfbAFBhsCKZA32krNWdrQ5q8hFRTdiPW3SpL6M=; b=a7/OjAeobmnub/WrEJ3v
	wzSQcS6J8Tlasu1hooHVYi1E509a9XaZaxln5eOqF/YOUwQfoDJDzQ/gsoaQE0Tn
	e9XzNuwrhZTAH5U6vy/W1SiqNzimuYNEiNSXPdLZqfpFEkQRF7MRjrcspKJi5r78
	5JppnQ3jdDEealFCOYBSMRrET9Kg2mDrRfQynR7qNYXpQL73ZcC2IPdRk9QKFDg9
	2LalSTxGR5SkgWZonZK9RlmG+f8vqBQleBPY/G7e56nJsOQwrm9BJtORMeoEVa46
	Aecs2CKfquHBJ3VOX988b+LLPL9MEWuElXyxtzvxPfX+54D4XPiARbUSUh2z+F5q
	BA==
Received: (qmail 4160496 invoked from network); 17 Oct 2025 11:03:33 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Oct 2025 11:03:33 +0200
X-UD-Smtp-Session: l3s3148p1@ngAaAldBwrUgAwDPXwQHAL/S9V79e5yL
Date: Fri, 17 Oct 2025 11:03:33 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aPIGZQfUzT_X4swp@shikoro>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com>
 <aPHiAObA61OVf8mY@ninjato>
 <20251017093649.2d5549e4@bootlin.com>
 <CAMuHMdV0As4XKG0P0y+pJpTT82Bq8qpq2rHufeX4_q0j-eOPPA@mail.gmail.com>
 <20251017095936.71cb318b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RPf07tWMtjOA6ssA"
Content-Disposition: inline
In-Reply-To: <20251017095936.71cb318b@bootlin.com>


--RPf07tWMtjOA6ssA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The specific RZN1_ADC_NO_CHANNEL value looks good to me meaning "No channel
> to use".

I think I have an even better idea, will respond to the original patch
for context.


--RPf07tWMtjOA6ssA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjyBmEACgkQFA3kzBSg
KbbQSQ/9HkuWz2hGzN7v2g3+mUylDo+w2oeqfNFBwpPHIUpNNcw00wE0VOGY0pZr
DbwNw6CIDqX9lA6CsJZm2GUy86A/faJKvBq1z+ebEg8FjR1Qe98r2DvdahUvSdKG
GBfndc0jC9ZLgOfkxiUQFHnqfmGND+AmPWkZWrVTfG9JczQUM5FhG9wHNRocmiSa
K2DweznSlBOjdlclQJLn24lyXxOYedDMjV6UqOX8id5wlq3K0Ip+yv8UkgoALWne
PexFqyxPPZ/JqPoidZiPc/aoEG/gscDcRNMyJUzqRhf9gc1WzMmLR/WVq9GZVPWx
jbQMKNwm5a23ZHwAI34cgEwPPCbLL5W94ro3zKVN6c6PcuXhGE6WYVOPHQMlhd8+
1KyXldwzSIET9Dl4pap8NiPH8d4+g0K8z5mj/70qqAi+VROQzK42cag8nvlfD7sj
Gk01LSfCLOKDCVL4oLBN9mwDyuNYQsFnuzE45EgX4ihgsbHLcKV6sME791i5pY7k
tYl+WJSaRzUTfYXg+WaaZoLyqe5YVeXfDNFM8RLLRXk2OO3fkjXX0raltNjaDdHe
ilpKMhj5UTNG40jeq65MZpPipOohPxffnmMDojgPe6a9D8MAkTuIKGcnHFKLE8xK
M+TFqNSfYKy/Cahg48JUJW4ZTH0oVNvECKNvkxOXM6Px2O0rjO8=
=mzqA
-----END PGP SIGNATURE-----

--RPf07tWMtjOA6ssA--

