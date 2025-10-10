Return-Path: <linux-iio+bounces-24897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53075BCC625
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 11:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807E54FA208
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64742BE647;
	Fri, 10 Oct 2025 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fVreBwo8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036A2C21D0
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089170; cv=none; b=S7cDBojIg6dj2WUE6yGf937kKBjyjXYQR71BehmkoG4bX+CKMVsTrcNxqXxVMnj7OF8rjtcWtoAgry3CXb4AtLolZk/9cf2KoyUrmDUvN5eLqSPHmF2iu6B5n0Vv4f9RIW6G697mrDq+01lXmlGaprDP0wLSodHJhGotCBupl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089170; c=relaxed/simple;
	bh=jwwLTlSIOxZ+tS+AqgvoMGh/OzcO2GPaaZEphPQEDy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHbeSGsjKhHjoc95iGXRsm++AWo1uaL/28C9bocm9bBxA/Sgd8BEcx9CZGh88V2XOzHNCWnHcXGSZOImDG+zDWcAqfWy9agaOHleNbKnAMOklTP52YAU9MoAahLzvryANVqzOayUBOfqMaQqrUUWcjUdnnnAGciiHGG4mbEZYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fVreBwo8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jwwL
	TlSIOxZ+tS+AqgvoMGh/OzcO2GPaaZEphPQEDy4=; b=fVreBwo8cTB+vDD7ObkK
	rKIazpVaUWNqzhxZbVZdBPQjo+3UWjZ/81t4/KPCbWgFOan4Jjql4e6gPBelvIZO
	/PcvVkAN3ZdZBIg9pHQqH1m2ezr1/FzholWqbGFx6ShANJoE6MYwRvLzcHsUR4ek
	Bn95MRbYl3fuJkr5ojVqxyvz1OavNrT3TJP15E0I56QDVj3PQR8QDYHoivVmhwDx
	gCVBNLFe2/y1G0Pyl39GNT0w/+rcLYM7FIYj4YYPnBOiH/8yimYPcVzIWVkRJYXf
	mOpYUJoqdVkWqSP5sSdxi83Fh6qOPQQFd/8So060ssQzcHdRzxGpnO7MaCDnVxMM
	Bg==
Received: (qmail 1417896 invoked from network); 10 Oct 2025 11:39:07 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Oct 2025 11:39:07 +0200
X-UD-Smtp-Session: l3s3148p1@st9jsMpAXpggAwDPXwQHAL/S9V79e5yL
Date: Fri, 10 Oct 2025 11:39:07 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/2] another 'interrupts-extended' replacement needed?
Message-ID: <aOjUO9BV3UlhEhL7@shikoro>
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
 <20251009203509.GA3296392-robh@kernel.org>
 <CAL_JsqKYqw0podCR7rQefg5c1-1-Z5xN9H7zGVrZzCTunmdRUw@mail.gmail.com>
 <aOgtdqUKePXIjRNs@shikoro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9UNNoxyP/HyoHDGQ"
Content-Disposition: inline
In-Reply-To: <aOgtdqUKePXIjRNs@shikoro>


--9UNNoxyP/HyoHDGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So, even after your fix, the above dependency needs to stay in this
> binding document? Did I get this right?

Keeping the dependency and using your improved dt-schema makes all
warnings go away. Thank you!


--9UNNoxyP/HyoHDGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmjo1DcACgkQFA3kzBSg
KbYICBAApXpu5AJZn0mTIwQkX/gJe/nQvO7+2KegYhn5U9OZcB0yoy0RtkdKzCzM
lfLm5J3Uu9g1oN3zHbty0v/bOdX0h42dB7JjRriofERnEtB4tv49bUSL0ufpDO/b
aPyXd6VRYruY5oI4u8gAiHnjGiIVxZZDabupK6guhuRXroRT7jYNONFmBprpgOt+
SVSk7CojO4QY7OpoyNG0HvPJpp3wK2pL3glWijgTCUIWl2JBjn9ddd07gIufTrRg
9GXQYi5cY0o90qeaT7kq0+sr0Q5p899/0JUFnx3cfBvUxZ7oVRI1V5nRIJHLKdsu
F8GmuCkqv6nAuLLLQgOHQaocyozt0fpqWRgFGjutnOJFkeYRubgUFJqSXe+EJbeQ
WGTuogqllEixI0BZSUHEgns5EfL57RXUaDAaQJMqxWWXtO4sGu6x0IpTrsS6BKZJ
ZOepcrEZmwYlNA3DuAj1fZzYMmw8CaHaKCpyZFzcPwcIUzwUbjaTKuSVkX51eXvf
I8r35XSpJF9R2eVcVt9FO09AAqEAaCY0XxGGwjvaO+cykGfOaUjQNJk7pDJifdJX
UpqlfQFRU7fWzqJjnEULfKOX0sXU8eEwQFOZ7FGs4FKrg4MFJ56Q8B4LHIELDQBG
aFyR5mU2H3Unj6vZFPBtX+9Dztm2oWVifZqP0xy6G/CLsoyZKZM=
=zW6y
-----END PGP SIGNATURE-----

--9UNNoxyP/HyoHDGQ--

