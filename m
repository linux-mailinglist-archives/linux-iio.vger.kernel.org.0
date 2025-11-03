Return-Path: <linux-iio+bounces-25829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FCFC2AC51
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37163B5703
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2562EB87A;
	Mon,  3 Nov 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DhkIGDo5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B32EB845
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162475; cv=none; b=jRFDT5dB655U64ELzmbKz/E9r4bd23gvBkRnZSxcJRn+HrfzdyqPtx9e70bq2PndODrCncDBOuHXfgwKhvq6gbDjphEzaDXHzzTo3jce5A9JFazi7xNWwi6CUheRQwsOQhw4tklJgAijR9XPFv0yrU/ojUumiMVmjcan7URasEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162475; c=relaxed/simple;
	bh=i7DOvgsvt3ZQmezVkp8vi6qSNyStUcEGPJnNb6H63Pw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPg3w1MuisPwH9G26BtUHJzm+kl4RASNgZyodOuxjZThorIAFAa/ERqrbAuZ+HNRkysDsunugeRSGxOdEwU6bar5qXM9xwQoZrn0VuoNsnLS1ZnMJG0N9LCodOEP1KQWzpakAb8GnLPjOzQCXhxOCzfCsrdBQCCSMQRD/PQ3VdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DhkIGDo5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so6060381a12.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 01:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762162471; x=1762767271; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7DOvgsvt3ZQmezVkp8vi6qSNyStUcEGPJnNb6H63Pw=;
        b=DhkIGDo5S2BVh7xneec4YlTW1Nx83x4WZp0g1tx1sZZBxyNLQpgfocqgjic7rHgNMm
         qA3CTCHtKCPDpDotM8ka4ghjYAmpoxbBNqp3YTn7DiT3PEKovRh43gVFNC5eQ22qdWJ8
         8d8RPWYfcPSwr8tuFqyZE7nITz1XWDJgUjAKDzHy2r8tHhqeSY2Wxg5BW9+9Axt+nK3S
         /bH8tYobIoBsokzH5yZebNuaWRAtEjTuFXF+wO8n+eKN45kBorP669ouWWWuCZh9Pnha
         EfpS79BZv02PrVW/4UFMndCTGpPzn+V2Opbxr8L5UDhF+FDE5QztYFXlepA1FrD6qMNJ
         CYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162471; x=1762767271;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7DOvgsvt3ZQmezVkp8vi6qSNyStUcEGPJnNb6H63Pw=;
        b=l26Z8F0g+xjC0zREnrBwVMSBtEqOZvV9gtNGv0Gy+F8Kqyi0Ah5WzXEOWNqf/+t7E/
         08k5nCSJ2H+3RpOElTHjMbfa0UCTHGCwmSpCLUCwrk+rk0Vx/h3Kl/5z0iA3jZwkWbmr
         w9xnd3YUsqCcN1sJ3wz8TLGDVmdiNnFUhW+hbVd7Q9j7QRalDQp2DvHqwWshH5WpRdlZ
         IXmKrdicrSUEsJr6c+lcnk97kQnZdqLi7IXeyHjAkX8wWBLJRG59iseYlYy0glpMpWZu
         Se2RFVGhm5Um0LyiKk0Ia7ea046LqiiFyx6WVkAt4mPBXNxe/3iBN1Cp4jnKwJepccXv
         8+kA==
X-Forwarded-Encrypted: i=1; AJvYcCV+PflBkW1mqUdvau2b/adl8f+WU8mgYhg7fVE4q0K27SslaJSHMX83NzxEWAKrArw76UmHwX+G5+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDooloD74S+oxrq0DB/6zSmIgFkby0GzgiOCq8V2GWeXUBgBNr
	UwGMkKj++tCEA1k4s4tLBRdvxHTqxTOqCb2bh/NfbrZ04zERpT8Q5WN//GGMCw2ia/U=
X-Gm-Gg: ASbGnctVb1HoCa6lWakoU6GkJaU48adGjCXGvNubU/PPpdBy8MDK5Hp9eCBs9o0t3O9
	RZxx/7PVo1s6vWCwFBPkuTU/9vaGC8F00YZWe+8XfSJrF5cyPSKjT8XLYx0WcUwq11UyMK4r7Kf
	s0RsHCS8DO3SKp7k2jhynoXezqSSFw8pLsFmRjPrzk+2BUgFs2f/VDOfmtrl6hrwAZsdLVFbrtZ
	ooZPGhpCpiU/kobTYYJgSMNeNB6Pqw8WkcjbUsEZ13Pi2s3EAvvCaZ56KAX2dYPnMUjS7OhGh/7
	m2AUoZYY+4nrZR1gEFct9KPJrFWcZiK1lRbV3bGOxZITYqb75Vrz3CcK69Mvasp35o00fcLD98w
	SfTZEXCSV46Y35t6/ld/pDpAIhBPucIxgy0ZaK+ccgSohfX2Y1B7dXEEn0uO3P3wEyfDcJzn93p
	WYjuqTQMoV+mRn/kb9aDLR9X26YNRZSVkcefmbqPf/kiJtM9oxXQ==
X-Google-Smtp-Source: AGHT+IGnMLRGHhpO38MioC8H/phmYtpI9tWiHTI1pjfDUHvbCJftgf1K8ac1oy3OCTnGcK6thqrCtw==
X-Received: by 2002:a17:907:7f13:b0:b6d:5718:d43f with SMTP id a640c23a62f3a-b70705ea525mr1074949666b.39.1762162471439;
        Mon, 03 Nov 2025 01:34:31 -0800 (PST)
Received: from [10.203.83.103] (mob-176-247-82-42.net.vodafone.it. [176.247.82.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d24sm994396166b.1.2025.11.03.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:34:30 -0800 (PST)
Message-ID: <25732d2be08156b4f55e97f5306d1fd080255ae7.camel@baylibre.com>
Subject: Re: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field
 from hw struct
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lorenzo Bianconi
	 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
	=?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 03 Nov 2025 10:34:28 +0100
In-Reply-To: <CAHp75Ve2+eU2X30EvC8dOuhEo3XZBwFrUH60itEYdYdGM7HvOA@mail.gmail.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-7-flavra@baylibre.com>
	 <aQMbb6BUBHQUXX9y@smile.fi.intel.com>
	 <32a7741bc568243c8a19d691b922d9a8c2cba429.camel@baylibre.com>
	 <aQNs8VVoStUJ6YHB@smile.fi.intel.com>
	 <20251102112958.435688d5@jic23-huawei>
	 <CAHp75Ve2+eU2X30EvC8dOuhEo3XZBwFrUH60itEYdYdGM7HvOA@mail.gmail.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Zznj8JQRuN4PD+b2+6iB"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Zznj8JQRuN4PD+b2+6iB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-11-02 at 15:45 +0200, Andy Shevchenko wrote:
> On Sun, Nov 2, 2025 at 1:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> > On Thu, 30 Oct 2025 15:49:37 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Oct 30, 2025 at 12:10:08PM +0100, Francesco Lavra wrote:
> > > > On Thu, 2025-10-30 at 10:01 +0200, Andy Shevchenko wrote:
> > > > > On Thu, Oct 30, 2025 at 08:27:49AM +0100, Francesco Lavra wrote:
>=20
> ...
>=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D (data & reg->mas=
k) >> __ffs(reg->mask);
> > > > >=20
> > > > > Seems like yet another candidate for field_get() macro.
> > > >=20
> > > > FIELD_GET() can only be used with compile-time constant masks.
> > > > And apparently this is the case with u8_get_bits() too, because you
> > > > get a
> > > > "bad bitfield mask" compiler error if you try to use u8_get_bits().
> > >=20
> > > We are talking about different things.
> > > Here are the pointers to what I'm talking:
> > >=20
> > > - git grep -n -w 'field_get'
> > > -
> > > https://lore.kernel.org/linux-gpio/cover.1761588465.git.geert+renesas=
@glider.be/
> > >=20
> > True that it will be a usecase for that, but given plan is to merge
> > that through
> > a different tree in next merge window, it's not available for us yet.=
=C2=A0
> > Hence would
> > be a follow up patch next cycle.
>=20
> Yes, but we can still define them here. Dunno either with #under or
> under (namespaced) names, but still possible to use now.

OK, I will define an ST_LSM6DSX_FIELD_GET() macro.

--=-Zznj8JQRuN4PD+b2+6iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmkIdyQACgkQ7fE7c86U
Nl+4oQv/f0YDTxKPnmDQtZLAMR1rSQ09I8ZI5A77NP5H9+zOBl/32hcta/Z0ouua
Eg/D1CS3D6dzKddOtET0ZHTN6pH83uLRf45ItatUhBpdtSoBs1WGJaWMveIgixVU
Ls2WK2onK7krHRYNtjMnH0WKsWdFiU8IYRrs0vdJfOncCsAJkIjtnz+geQvMSLSi
E4q6hElEDAtd/jvTwf3WFIeRAXEgcY1nlBnSVIuETjjaNChJ+U4MasoN7L9K2cwy
wV72ImowIft5kxrj2HZRx9jwlvv3oyyt3pggFHbp2Q21YRSF8TWeypVIK6aQ0YVp
/ZIREHvhNqnZQHMl1fMiifzaW4z58bJAU6Raq7AOhG4Wa6t83ajDGZrXki2lhQrs
gYX4i68dSZ84ujA3S/JXpROnc/Udb8RyGYvYZtZXUKKXEY8irlPd0KuHFYOGcKPI
s11blc3Qfl9Omaz1II1g9pT0mdFOYqhIVzaLAu1v2EWNXi4KNkgSi6XXUaEIBjWR
sFNThTOi
=Wfrg
-----END PGP SIGNATURE-----

--=-Zznj8JQRuN4PD+b2+6iB--

