Return-Path: <linux-iio+bounces-24153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B37B596D5
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BB61C0047A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE02DBF49;
	Tue, 16 Sep 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O6HGM9oy"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F230DED1;
	Tue, 16 Sep 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027669; cv=none; b=RrCy8L3w1HgPXHyAiTKtH9t+1NLALhLM8ot/2oI2UoJR3Hg59G2hVQgIy236eBdjudEwpY5aooHRCIOMjIqzSR/oYtft0Qol+a6ltyEGbpAmLmQxM6lhidUkmuINMA2f54/xuYJrv7LZY3XGdIBApuuhTrmCOeM1FLWkXxjs8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027669; c=relaxed/simple;
	bh=NekGZ/TJk2bUyJAbVQXKhs5+X29//U0b6CQSNzRcAag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpmCcJyMKYArcbh7xfIbMpyfN/CCUF8Qa3g13jg4YZrCTAS7IQuNBxo5i3RIvjz9LCaEXLURsh1cnrRe7gP0eOm9JtiMmp7WTDoqKyuWVbIrxbaasHbieUzaaYvWmcALbcYpW3yK19dYO2wlOHOO2M9LUt14nXJFjIcug/3+Eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O6HGM9oy; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20210438CD;
	Tue, 16 Sep 2025 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1758027656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lsTXAG6Le7jfwPw8fCHtBvAmtuldYhNt7bYvfMHo5/o=;
	b=O6HGM9oyGEpvSVZKWBBT1rs8ljIeqF28OI1kU533aRUKP02k0+/LiPpECRhpo65deWG8J+
	Bug2yiO3GV3j+gRw47Z51NrNi7dZrmBDITJRoPDvdp/p0OexiOJr9nrWyOHXLwIvjEKaNf
	/B4crwxtqZt0V0o4JLI7s2K2k2zhfJVzkz7+FcjZ2utGgRq2RkdcImOo5UivAzbkkH3xiv
	SBQ3DGTUTxz4A3vSoZnSdO4qylG9lAV0fgXc9J6gxha3+QGvzOoKOtxbWNKeCchv8B/Jzo
	hthA7ec4sGzA8TEBqY6CfFX5QFtlDGRyHdBd/jlRyBMsrh3cOgFA4g3zm0rOLw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: add processed write API
Date: Tue, 16 Sep 2025 15:00:55 +0200
Message-ID: <2991837.mvXUDI8C0e@fw-rgant>
In-Reply-To: <ecdce9fe-dcb0-46e0-8913-d733040a74c5@sirena.org.uk>
References:
 <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
 <ecdce9fe-dcb0-46e0-8913-d733040a74c5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12936211.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvr
 hhnvghlrdhorhhgpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughlvggthhhnvghrsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehnuhhnohdrshgrsegrnhgrlhhoghdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart12936211.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] iio: add processed write API
Date: Tue, 16 Sep 2025 15:00:55 +0200
Message-ID: <2991837.mvXUDI8C0e@fw-rgant>
In-Reply-To: <ecdce9fe-dcb0-46e0-8913-d733040a74c5@sirena.org.uk>
MIME-Version: 1.0

Hello Mark,

On Tuesday, 16 September 2025 13:19:10 CEST Mark Brown wrote:
> On Tue, Sep 16, 2025 at 12:24:07PM +0200, Romain Gantois wrote:
> > Add a function to allow IIO consumers to write a processed value to a
> > channel.
> 
> This seems unrelated to the rest of the series?

This adds the iio_write_channel_processed_scale() function which is used in 
patch 4/4 of this series in the set_current_limit() callback.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart12936211.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjJX4cACgkQKCYAIARz
eA5NJQ/8DvPi0TKf7fCZ66bFuc6NjYki9zvm4iIqQ37SOLLCQtn14xuksGSRTE5d
6LXBr7xd5FGXXscibp+3bmaAVT/conVqWlvZAK2E9YuHgy9XpRI6+uL7eHYExWPx
JCM03kDLNpnVingh6hJ9nklSrI0SM8/N0yBZsUy20RweqZ3c1mtHg140rLsmO1D1
xHYnO904RckRuwYu7dVggUfo5kEIfJjuqET1D/jzZNkfv+pZ8O0yfCM9lRnWkaHV
FRJQfARnHpUzaN+GQPIn/Id8Q2tR9AgnEaCbNTFXyl6YL/7eoP0bMhAc3kvpEE8M
CWFF0GJtAS/VA+wzMDgAhbWAT0s5cxF+NFDNW4uaMEUSZI4fkp7qd1JQ/eFSJqFe
kbOnhEbOewYuM1JzvfAAuzN0L27QzhVCTMx0FZBSwca3O9WZxyeyFxar5qSB1UnA
Cc/aqO2Zp1Mn0pMfNKPRztMMpl9uPVzmj/o06BkGyAwRERQO/SMqqBT5/5HrLcy3
axgBmQfUUfrb0+m2tnxu3qjhG8ThK9UWOCrpr//5+6+89gvLWUJ+NLI2Np/rnZOh
njstOmh1cno7xGqhqRcjQ+OR2Z8CRrJtCu4KbQ8wzztyKcBeV4AZ+0LHyMrBb69v
97IE/KF3wgeqOtfqbJ3sYomJpFlxymyePHvkat9jCP0zB3mrI/A=
=H2yd
-----END PGP SIGNATURE-----

--nextPart12936211.O9o76ZdvQC--




