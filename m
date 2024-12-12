Return-Path: <linux-iio+bounces-13386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE89EE4FE
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 12:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4FB1886CF0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 11:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4003F211709;
	Thu, 12 Dec 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wTgJjx9n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7BC2116E9
	for <linux-iio@vger.kernel.org>; Thu, 12 Dec 2024 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002888; cv=none; b=WSEmwsTfCHWCkRmHD2af16FYB0ZF40qiZiQCP5pH6mk4EcClrr+fliv72CPkool67zes3PuI09s1cwS2svKc3KHyrfFQiFklgPgqLAlGYAgfFV6VqkmJvgt7wOREDZ3Kl/rtSm+MavSaHszLm6PBJLU4+l/lxmSfOnbxHe1Pp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002888; c=relaxed/simple;
	bh=89xjAOBL5xTMUUX8ryEwGdNDUJ1GWS/gZbozdnt2Tjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQvwyn0Rs2dffZ2+2eWLyg4wJVwXoJCpBpHu+gwlP+C+mndOHbvZDEhzfFmLN6xHSXw8oBOx7UaQkyWtepeFXQsh4UC10fTD3KpvcycsaiCWPF7rW4yqSHun9yAPMvQKXpRZF0UPUpl5UqqOAyxCvLDbU5MBpDc8m3v45BlBkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wTgJjx9n; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9ec267b879so94380166b.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Dec 2024 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734002884; x=1734607684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYL7RBgPk1N3FLm/Eu2J5KCDIOH18sdolybWTWXieCU=;
        b=wTgJjx9nIGXa3kQOzG/SSVrp+IhySCU92FhZIdySIPvktpEqJJCc1kIq4ALqfUJhUk
         kBiDJ0U4TD3uFyvXikFJT63vcR17l9Es/HHfYATFMK4OEcgbgD3OudfolRRt0CTUgJSR
         UJG408A2Pup+KA3FFeMW1uFvrNQRfGnbc9fCA50a23OHG5N1uBYFbEGYPc9I1/EL85j7
         ODHZWTujwPGzaFJVtWOqsTRYPdmvbWxGqgakcJR5rusYXNQm4nWHhYV/lvZ2i7Hz/h1o
         D/ks8rpwuL7kUysheo5uBUj8hxIgN0RM4pnCAJa2rwKmDbeJ8HJcoEtswLRt4s+7pUvE
         gT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734002884; x=1734607684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYL7RBgPk1N3FLm/Eu2J5KCDIOH18sdolybWTWXieCU=;
        b=ZCzC0OsxLRoyZ6RYdTLS1ZnVuX43R3AfezWh+FLHaheNJKIHWzTBYo/Ywq6SWENv2r
         F0EPqu4A26638KRTn9O/bbomZpCH9u+iLEZNtFjq7hJSxYhEyISf4oUaupQcKvH/VOwJ
         QL39xP6BNypnidcmsdJO6EgU1N6Ex/eXJU/zIEvWQXlGQS6bSBFquzMRpVQFqcgFD0YN
         5Y+2Jd8dGkteSVpZn/lx30G6od15BlXIQpwzpDZaZ6MXBIZnjNMP5emkLvI8nCGT7wDM
         OSG5v9Skfq00iHnQQzQQhlAEVmHO8lxZ/92p2qy8pLxAVXYrql4HCeCkwWtDKYP7u77L
         uomA==
X-Forwarded-Encrypted: i=1; AJvYcCUM0lbtGPxhfg+KayFbphxZLl0P1gBYIInQvJ3liSRprnt/Vv6TNlGrRqI4U02JiLc3+o2LJR/xSpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNB+2StMMmwX2XF9YtmJyVaRkmIXim7ZZQTlAPgtZ48+XVxDIp
	jhvmalo3DCNfct9HExQv3+6YaEsxDRy0AcuFhbk/DOrkhG8sF+WOji9sOPWCldE=
X-Gm-Gg: ASbGncs8qxauGnayOtduOjjeKTeo6/ocm6NBi+/f/MOmNxLR1kkvrdvlRTotb+7FFqA
	F5Ryogk2Rg874lp38wNH/fdrykWoASrxMX5GwX+yIPnt98w3bCEsIyAWstKMoN3QgSOXxWrMekC
	WsHIt7+IAPy3BcWc1Zk6Cu06b9pHcFdGbXMc3ohuXkn92hVEOCkaz7c8llAfUzXf2mbyAqD9a1K
	U76Sis3wsGMB9dYVtL88rOBtnunrVSQ6E2gi5zsTMPycXLGjl7O/+wOeZHYEicyQJ/rrqp6TQ01
	2g2U+EltgHs=
X-Google-Smtp-Source: AGHT+IERrMSJ23vcIa99YiXM2kH0lnU2SkZmpQWfYdYN+k93JQbtmixpp3ZDafk2Wtl2a/WEF754GA==
X-Received: by 2002:a17:907:8284:b0:aa6:6696:4072 with SMTP id a640c23a62f3a-aa6b13f4f48mr570550266b.49.1734002883770;
        Thu, 12 Dec 2024 03:28:03 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa678f0ff87sm670568166b.131.2024.12.12.03.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 03:28:03 -0800 (PST)
Date: Thu, 12 Dec 2024 12:28:02 +0100
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
Message-ID: <cfw2bybkcyzis7y2xv3xxczv7qqyk2723ccb4sqearub557orn@7nqqzeuvokmz>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
 <20241208124427.3b90701e@jic23-huawei>
 <roit3rdw6a2wv65fpq7xuullbreyz463nch2n2xmjop3b2saoe@pbhm4kahmgsj>
 <20241211192459.430fd9d3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5gdwzbbajecdoos"
Content-Disposition: inline
In-Reply-To: <20241211192459.430fd9d3@jic23-huawei>


--t5gdwzbbajecdoos
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
MIME-Version: 1.0

On Wed, Dec 11, 2024 at 07:24:59PM +0000, Jonathan Cameron wrote:
> On Mon, 9 Dec 2024 10:47:29 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > Hello Jonathan,
> >=20
> > On Sun, Dec 08, 2024 at 12:44:27PM +0000, Jonathan Cameron wrote:
> > > Given the mix of fixes and other material (kind of fixes, but also ki=
nd
> > > of new functionality), I've queued this for the next merge window in =
my
> > > togreg branch.  If you think there are particular patches that need to
> > > go sooner then I can handle them in a split fashion, but that does add
> > > risk that the whole lot might no land depending on timings (particula=
rly
> > > given it's coming into vacation season). =20
> >=20
> > So you tend to not backport the rdy-gpios patches (i.e.
> >=20
> > 	dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications =
of a gpio for irq line
> > 	iio: adc: ad_sigma_delta: Add support for reading irq status using a G=
PIO
> >=20
> > )? I personally would want to have these backported, too, but I can
> > understand that you might decide that in a different way.
>=20
> Yeah. If it were tiny amount of code I might have gone the other way, but
> this just got a bit too complex.=20

I think it is easy to see that the changes for the rdy-gpios support has
zero impact if the device has no rdy-gpio. Then
devm_gpiod_get_optional() returns NULL and !sigma_delta->rdy_gpiod is
true and so nothing changes.

Of course it's subjective if you agree this to be easy to see, and also
if that matters for the backport.
=20
> > Cherry picking
> >=20
> > 	iio: adc: ad_sigma_delta: Fix a race condition
> > 	iio: adc: ad_sigma_delta: Check for previous ready signals
> >=20
> > isn't trivial without the rdy-gpios, but they could be reworked. Tell me
> > if you want a helping hand (or an eye judging your backport).
>
> A backport won't go anywhere until these are upstream.  At that point if =
you
> want them, feel free to suggest backporting these and provide the code ;)

I've not given up hope that you agree to backport also the rdy-gpio
change yet. I won't invest the work without knowing it's used in the
end. So I'll wait until the changes are upstream and you made up your
mind. Then if the need arises, I will help.

Best regards
Uwe



--t5gdwzbbajecdoos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdayL8ACgkQj4D7WH0S
/k5hGQf+PpyoDi8UrxxeNYqTuA/h8XQ1+98XzVHslec3dyHWADzAiLErurlNMcy+
+/1oGSCtLF3MP4KUJyUnykviYhZ45WpmsP9pJLM+9beSIAUVA5l/YD2DOLPraydw
+EvSdWUHE7dwfAHGa+iinwqczkXwoMwQNe3nUJUW072EVaIKxgez7VYGf4vqrNP6
S7EcjFR4bRMmh0Ph5e9wFcQ8QUaLQPSwXiOz0UVzv8o0UXRqfTUF11RdB2oGmRId
wK0C3ZUs+NZPHWsknteznMqbFuj6gLt2u9qGbrUspp0I7aVQE+Jx8dxu0V4MG0eF
M+kd8Gf5DAfAN/1NWKNkNJIicCEZ2g==
=6iQR
-----END PGP SIGNATURE-----

--t5gdwzbbajecdoos--

