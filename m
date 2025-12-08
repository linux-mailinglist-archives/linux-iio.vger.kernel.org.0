Return-Path: <linux-iio+bounces-26932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E362CCAC89C
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 09:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E237E301693F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C312DE71D;
	Mon,  8 Dec 2025 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gvLXw6RV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5B283FE5
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765183496; cv=none; b=KbdwlXOa3ZH/1xQivvXLqoCmNZ+LhqYnZyqT2mgXWgvmCF1/+NyxIASxNlrj3UIaZHaeyDRkYUpI+D0y/LVeTaTkf4lNJ804aRB03THu3t0BmSDM8kTeORF/EpnOHnU9FxaeW5aU9ty1netnIox+uQBj3/Rs66qxDYNLqqoyQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765183496; c=relaxed/simple;
	bh=kWRdMZaH+wUT3pzOG0/0aFX7s6tpPe3ahHYctMxAYSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJs/QQe78upOUmWMI3V6zOQI5Um63/izjHNC0MFBnTIn54fxZdsYCerdvLN2ZwAXgW/FWE3vxgPTIGM2y6LbLRDWAKZGxU4KLEtwrw3nTDGQTFsJh/u+KXZwNma1lVd9KTws7WaRnUKzfjQzx7cf4gKBeu2eCph7ovhdLPsx710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gvLXw6RV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 727991A201B;
	Mon,  8 Dec 2025 08:44:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 459E960707;
	Mon,  8 Dec 2025 08:44:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDA74102F0D51;
	Mon,  8 Dec 2025 09:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765183491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wI/saBzHr0art8Jr1iPwJ6TnIGwv/Y+DTIw9MrZoH9c=;
	b=gvLXw6RVX3JaEO7wp4kyEixx2fqauQCEsr+xKhSGCUB0VaCR9jzZzvTDROjSCa2fckckgw
	/BKRYr0/emt3kHUZpwyZ9tyZIq9bUHK9W10kntULisTcolywafPWcZ6pa4onUSDyxO5bL2
	SE15rNEbZpvjTPpVV1TPKgGT5RRNRGoE5NA7RFGoRJHdtU+Z4eiHL9CMXG3WQ6I+Uu7PQT
	d+2lX6hT949MSkHfeVP60zc/tQJDsefKKsVfBewqgpNl3IR5C+vEa0HU/UKZTgzQRHte41
	Zp1c4qmpAAsK+Di9ib1DDt7obIpoxmvxGUWG81AHv9iUpd0cCvsWoz9rnzsaIQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: add processed write API
Date: Mon, 08 Dec 2025 09:44:48 +0100
Message-ID: <1942442.tdWV9SEqCh@fw-rgant>
In-Reply-To: <20251207185216.7498ab0f@jic23-huawei>
References:
 <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
 <20251124-ltm8054-driver-v4-3-107a8a814abe@bootlin.com>
 <20251207185216.7498ab0f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2247736.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2247736.irdbgypaU6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 3/6] iio: add processed write API
Date: Mon, 08 Dec 2025 09:44:48 +0100
Message-ID: <1942442.tdWV9SEqCh@fw-rgant>
In-Reply-To: <20251207185216.7498ab0f@jic23-huawei>
MIME-Version: 1.0

Hello Jonathan,

On Sunday, 7 December 2025 19:52:16 CET Jonathan Cameron wrote:
> On Mon, 24 Nov 2025 15:48:07 +0100
> 
> Romain Gantois <romain.gantois@bootlin.com> wrote:
> > Add a function to allow IIO consumers to write a processed value to a
> > channel.
> > 
> > Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> 
> I'm lazy so I'll just ask the question rather than try to find an answer.
> Is there any existing consumer of DAC channels that can use this?

I'm currently considering upstreaming an extension of iio-rescale which 
supports writing to the channel. This could be used to represent some frontend 
to a DAC output e.g. an OpAmp inverter, which would be useful for my regulator 
use case. At first glance, this looks like it could require this processed 
write API, but I'm not 100% sure yet.

> It might be easier to land as a refactor than with the new driver and
> reduce what is in the more controversial patch for the regulator.

Agreed. For now, I'll be sidelining the regulator driver and focusing on 
upstreaming support for IIO channels with analog front ends, so that there is 
at least a way for userspace to directly write the require current/voltage 
levels to an IIO channel.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2247736.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmk2kAAACgkQKCYAIARz
eA6/Qg/9H4pLU8q6pbEShwviA88fd3WpheF5SQVoZwALsusFB28qQPgrfazn6lmB
OSnmJafQDjyStAKhQFVqrPzFgO3FkmIkblbn1lDuVAa9jOy8Ym+mm+rppnsimDVL
lYiyDi5qJCObJUpB3yfeBhWVfdyL5KVGSzE1FEDa9YqcLuuwyfjbKCX8WAjAhpdr
xtszs9lS+ondcG59YHEn2qlvnyddibIKAnKM4xH523i6mGc5Y+P4a2fNYESiYeFE
4l+lFYI+shC+bZB/gjJoNav/8CzGqvCR4bKhvVr7kwIdGJtXeGALPO6HgCfghijH
73yILJviJ3ms++W/PGnfFeZHbsVsILBThf7nH1E9ugSm8X5UU67GT8P5i1CKyJqU
ABLCiaVuz+gOZ4fC2udX+jdqok+QKYTHM0MU89V/kgut9ZWUXqj6MSSLW2jgwaXu
JHQiAlrvoyQvrt8C+TkNziXqe5vBvDwrrEW9qSKxfnXVu0QahDWt69l8fXRf4hdo
05D7QWBy8sj4iHJ4wBBSjxbL17ObolfX2Ksi7MNGh0n3fqUP9MogpAA+v+5pKMFb
o44lEqqH+oo9YztceggQ4QJ3tHfVk2XUxbjDhljfbbm6XtmtnSyigRMzq7PXPc4X
WMOb8vOrovwxfb6xoVUccqnDnXiO7xxKazmyhL9o8tMnYsqi/A4=
=v5F0
-----END PGP SIGNATURE-----

--nextPart2247736.irdbgypaU6--




