Return-Path: <linux-iio+bounces-12176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CF39C5317
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905A4B30D56
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC5E213121;
	Tue, 12 Nov 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bbc+El5o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712AA1F7558
	for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2024 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406559; cv=none; b=rAkMi/590Pe+NOHYIN8SAG0kf+JJcFD7tfH8u5Vj9BHM09vjGToCUpRvv3Ci7j+TxzbFDZ2SbxTn567yaadXVun3j5WoB5h7/KbEUSJdzVqEC4fOcPXMIPBiKEh91i/6Z+2sawmMgTABVVC4zFRtM/yeNgeHUX/TzGhH8n91SKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406559; c=relaxed/simple;
	bh=uGuGiQIlJrIXE4iVMImssRilu1RGQ+ZOnY+Z06vrHoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb24K13aUeGpAxaTv4NiM2GNWCDPjB44Wb6Qs0jjF8TeylrQ65RM7HfFwjeFQCk47KAK0t/Od4/2+olounSxEQRxaqLEfkerxGKkTZGcAk+nsmkQc3bxrcJ/2owisbekMvjRKf/0jgtUOaP5nWquD9Srw0k1oq1e5cifd1qTqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bbc+El5o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431695fa98bso42982315e9.3
        for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2024 02:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731406556; x=1732011356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obp8yGIldYDVzI0XN70dXZCO2SHc5IgrE0mc+D/CPjg=;
        b=Bbc+El5oUdB8pUtW5r8ewApdOQ8EcPOc8Y9SArUlAPQB9BN21P6IFSKaH+ezVdOqZZ
         jvKhoTqtz9QSDzGIInBUA+kPmIfbBj+emxvuDHI2jgle+orpUVPP0QYtMauL6XWmQiQt
         1nZACWK4ySUYEmm1Hxjj+XM2RgRBbR5CCpPLO/4PzQJ2FHJnRRrCTUk5XBN9qqwThkST
         Zp0G8v3HxrX/kfRcOAwTm04rU8EH0s+MFa9nOKylb9OYjwIGCJUelw9nPuvgU7zNMD2k
         xj79uEipbdoS/wt4TnSVJQZOaSGWLih1Z1vvW2dtDo+xjrTpQVBbNmU41zW9xs2Kdwxm
         VKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731406556; x=1732011356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obp8yGIldYDVzI0XN70dXZCO2SHc5IgrE0mc+D/CPjg=;
        b=TSDnF+fSehkBqAirIwsyghDWnNE5k6aIHbVbRSuSGR1JdZ6z+b2ho0FKTLGikXM2yt
         VZi+05AiuQ7abBHYAnbN17To10ChVI/TBn5WobCOUf8mI6oOsbGIyXfdLzR/AtBX49xV
         3z7Bs/Pgscq4oarLLACAq7p0ajRghvKkVRKHOGvIn6uSJmxZtUgFq6lCmmMfhnAbqq8Z
         k5eoQHV/5syrUnWWnPPcOE/25uuNQl/s5WckiuEyDITK0tP+5rmu70XF6Q6P61KrCT14
         gGw+7DhwJUbGcVDcYud/dFsfOtBc+Yo+I+MYEiUjgmrYYobFKKCFE7gjH43IjyQ9KXy5
         PkRg==
X-Forwarded-Encrypted: i=1; AJvYcCX1De5Hpr8YtR1Eas7BC1CGtjLM7+vNhLLk0xolHCPnaBlAzmaf80Mttg9OolYK2uJz/8487ouKT4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8e+jdoDExqwKnEuCXkv/cGVxaMunLTc6wWFyAQajjy8oTwlfv
	70sNQmn7qjqHCxPCR+Uae07mcQm8YM9Q05eekGwkX/8+zfTB9DgYYBUya7RzKNg=
X-Google-Smtp-Source: AGHT+IFUtKcOxI9iGKzatyRYf8XbPC5gcQcujb8cjUFmjs/ViAYZu4pW7ViB0cQLuE4H16EQLauy0w==
X-Received: by 2002:a05:600c:3c8f:b0:431:4e25:fe42 with SMTP id 5b1f17b1804b1-432b751e28fmr122955855e9.32.1731406555816;
        Tue, 12 Nov 2024 02:15:55 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05305a4sm205703715e9.5.2024.11.12.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:15:55 -0800 (PST)
Date: Tue, 12 Nov 2024 11:15:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aren <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <4ibd5tgpt3uzbmouqdiiv5pvfxebo5qsmgn3xh6rlb73qevatv@cajznxqnlca3>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-11-aren@peacevolution.org>
 <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
 <m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>
 <ZzEPACoblmcQD9yu@surfacebook.localdomain>
 <xubjmxig4luag27ifnmqmv3x3bvzhwczwvw34kw6tssaa2d24t@ysnqh5e3g7sz>
 <ZzHSE9Nrf4YySJrq@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mx2qhhffnejmsbkn"
Content-Disposition: inline
In-Reply-To: <ZzHSE9Nrf4YySJrq@smile.fi.intel.com>


--mx2qhhffnejmsbkn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 4/6] iio: light: stk3310: use dev_err_probe where
 possible
MIME-Version: 1.0

Hello Andy, hello Aren,

On Mon, Nov 11, 2024 at 11:44:51AM +0200, Andy Shevchenko wrote:
> On Sun, Nov 10, 2024 at 04:34:30PM -0500, Aren wrote:
> > On Sun, Nov 10, 2024 at 09:52:32PM +0200, Andy Shevchenko wrote:
> > > Sun, Nov 10, 2024 at 02:14:24PM -0500, Aren kirjoitti:
>=20
> You can do it differently
>=20
> #define STK3310_REGFIELD(name)							\
> do {										\
> 	data->reg_##name =3D							\
> 		devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_##name);	\
> 	if (IS_ERR(data->reg_##name))						\
> 		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
> 				     "reg field alloc failed.\n");		\
> } while (0)
>=20
> > #define STK3310_REGFIELD(name) ({						\
> > 	data->reg_##name =3D devm_regmap_field_alloc(dev, regmap,			\
> > 						   stk3310_reg_field_##name);   \
> > 	if (IS_ERR(data->reg_##name))						\
> > 		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
> > 				     "reg field alloc failed\n");		\
> > })
>=20
> I am against unneeded use of GNU extensions.
>=20
> > > > replacing "do { } while (0)" with "({ })" and deindenting could make
> > > > enough room to clean this up the formatting of this macro though.
> > >=20
> > > do {} while (0) is C standard, ({}) is not.
> >=20
> > ({ }) is used throughout the kernel, and is documented as such[1]. I
> > don't see a reason to avoid it, if it helps readability.
>=20
> I don't see how it makes things better here, and not everybody is familia=
r with
> the concept even if it's used in the kernel here and there. Also if a too=
l is
> being used in one case it doesn't mean it's suitable for another.

Just to throw in my subjective view here: I don't expect anyone with
some base level knowledge of C will have doubts about the semantics of
({ ... }) and compared to that I find do { ... } while (0) less optimal,
because it's more verbose and when spotting the "do {" part, the
semantic only gets clear when you also see the "while (0)". Having said
that I also dislike the "do" starting on column 0, IMHO the RHS of the
#define should be intended.

So if you ask me, this is not an unneeded use of an extension. The
extension is used to improve readabilty and I blame the C standard to
not support this syntax.

While I'm in critics mode: I consider hiding a return in a macro bad
style.

Best regards
Uwe

--mx2qhhffnejmsbkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmczKtcACgkQj4D7WH0S
/k5IrAf9Egz14wVYaV3DKBPJo8fgsKBghLX7gexCzWL4+0rkjfgtP8gSFaK8OnVY
8howbIeCxwbCUSEZEtWJU36A5oaLI370Mb24KajDPQZyayedIXqF1UubYE3ZXcrA
gwbGyho7TkbsUnrXbMhkp5lr7aU6O8JdIedrSqv7FnMxfkVUVkU6Hrai52+r3b3t
k6uAvR1Yl+OD1XIq5FEeCW5tcoYEQ5rK6apeMXvdkPdg0o6ZKVjAt9vK9NVxPPpW
2CdM15ron07ikOYiBDin1ZaD3x7FdzVh8z9RiizG5q5a6fPjh5SELLbBMHeGtnaZ
5cCYi84a0NHhmndqIy6gZYPX4hhDXg==
=b8YO
-----END PGP SIGNATURE-----

--mx2qhhffnejmsbkn--

