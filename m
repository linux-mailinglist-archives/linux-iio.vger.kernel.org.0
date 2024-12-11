Return-Path: <linux-iio+bounces-13345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94239ED685
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 20:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B87188347D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907B2594AC;
	Wed, 11 Dec 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJsyB5WV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098A2594A3;
	Wed, 11 Dec 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945111; cv=none; b=SA+kOSdmbYR8HXhuHcxfyGo4styM87DF3J3c/mBXjhJ+Sovwi8NEf6HvVjFb1reNdrzRbiI2YX4qJqpKyc/KHp1q2cvuTCJnPejsUaRCRVdLXQ4ojsCoid4SLqZhStZV5Bep+jO7FTDTtzStIzRpESpOoEkoFxUdpUigKvU1xE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945111; c=relaxed/simple;
	bh=Haat11j8rd3eQKi+LMSCO8iDCcyhrGTxLa0q7wu1VhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibp/8FtKYvY7VvspHhazv5ApJVGnZ4GvGrkiu5bSs3/2JAmY6M8uCEr8OgxooSJrTa22fYABXSYQduGeIA/nEZsGC2emdDdDkJ6MkqDJOLKrSAaoM+CvxFHBA5sxjMG2pRotIGerFNNSQHH/K6UWYELLtZq6/h1+6XCm+iDjP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJsyB5WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A69C4CED2;
	Wed, 11 Dec 2024 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733945110;
	bh=Haat11j8rd3eQKi+LMSCO8iDCcyhrGTxLa0q7wu1VhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJsyB5WVlJMhN2R/9ddT4ipfFxfZQ2gd+wSKNpy819QGvLuw/WSfsg03D0k3B+6tL
	 dtrm5flUrOKS+f4Z00VRjRY+brANBYB2WL9ObNclKi6ECAYTI5u8s/iYOcE6C1Rcyn
	 bJU0jCxavHR9UwYLwGUfXlPpzrnuHu0WVA26RNjFGSJMMQ5Un9UNFwaQwqySc81m0m
	 kMfCvJvZLguQjijBInehWm5rH2DfX3A3Y7lg+0T/JnRYIe66X21jtBVmPH5QlqRIKR
	 r7pxTTVsIIzTogFyyfc+y2gjVCUwKVjTsR5TeHTbqKQDzw2HVeBhdVBmzZaDLCGb/0
	 gfoROMjymYq/g==
Date: Wed, 11 Dec 2024 19:24:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
Message-ID: <20241211192459.430fd9d3@jic23-huawei>
In-Reply-To: <roit3rdw6a2wv65fpq7xuullbreyz463nch2n2xmjop3b2saoe@pbhm4kahmgsj>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
	<20241208124427.3b90701e@jic23-huawei>
	<roit3rdw6a2wv65fpq7xuullbreyz463nch2n2xmjop3b2saoe@pbhm4kahmgsj>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2024 10:47:29 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Jonathan,
>=20
> On Sun, Dec 08, 2024 at 12:44:27PM +0000, Jonathan Cameron wrote:
> > Given the mix of fixes and other material (kind of fixes, but also kind
> > of new functionality), I've queued this for the next merge window in my
> > togreg branch.  If you think there are particular patches that need to
> > go sooner then I can handle them in a split fashion, but that does add
> > risk that the whole lot might no land depending on timings (particularly
> > given it's coming into vacation season). =20
>=20
> So you tend to not backport the rdy-gpios patches (i.e.
>=20
> 	dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications of=
 a gpio for irq line
> 	iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO
>=20
> )? I personally would want to have these backported, too, but I can
> understand that you might decide that in a different way.

Yeah. If it were tiny amount of code I might have gone the other way, but
this just got a bit too complex.=20

>=20
> Cherry picking
>=20
> 	iio: adc: ad_sigma_delta: Fix a race condition
> 	iio: adc: ad_sigma_delta: Check for previous ready signals
>=20
> isn't trivial without the rdy-gpios, but they could be reworked. Tell me
> if you want a helping hand (or an eye judging your backport).
>=20
A backport won't go anywhere until these are upstream.  At that point if you
want them, feel free to suggest backporting these and provide the code ;)

Thanks,

Jonathan

> Best regards
> Uwe


