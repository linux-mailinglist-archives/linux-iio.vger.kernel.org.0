Return-Path: <linux-iio+bounces-27875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F9ED38573
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 429CD3195A50
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA53A1E8826;
	Fri, 16 Jan 2026 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uwc0EGsu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55133C532
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590416; cv=none; b=ZLJaW0CgizQjSeORVQBeoJlyMo6c2oATdCl07DXkbCe3WwLGJmLUXNP4POQKQ7a0RDm6TXhjL0omwMfxY3cdtfkgv1aRi5cvRBX9kYHsOhKP1l9nWn3aoZWNzsmRwN6+4XGKThtayButtDDAZ/Gs8kGZcRxOePatNY9QmOM/0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590416; c=relaxed/simple;
	bh=1z+9kva+4+7bFF1Q4JdYsrxPZWF20FdvonCIErMrVF8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2ii4GqhQfAryrd0sRYYhi7RweicHMJx9qDQHR0XsrLcV1wBZQoJeiNzMyyZqwFL+J/TSZCvYHoms6VF408HYq5cPHIdotoKgscXojjRJ9F2UoN9bXVBPtowtONsmYlr2nB9DNl7+HITHANx213mjNAeOmIVwb1HfZMCWVfLAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uwc0EGsu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so426624366b.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768590412; x=1769195212; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1z+9kva+4+7bFF1Q4JdYsrxPZWF20FdvonCIErMrVF8=;
        b=uwc0EGsuYgqC4fluOsojCe7tDu6A1y1pA9Xf5CR/v4o9n3ebz9MKTObhR14BuFUA/d
         8mpRi+tkE1Vs23ChEI1G1yjOw6i07LxNerYewygzwzoByf3kGMt4pVUPCSj9+Rc83MYE
         9PMLVa5PBtTxZagdCcNPOCkSBFsovwffrLq4yxfG5QDeoSbPtlUYtj+OXbAj0B5ZSpHA
         ++5u6A9+2qyo4+CG1XN4jp6MSKH4qQLe3OQ7mQWwMwli5ZGbBicol6nkOmdrSlluXHc9
         JAxQUcGsF0VCFsvMdsMCv3ZUd66tlZV8MLE6ZAcsVvpB27MF4r5nTfwnBJS1LLXpX2pN
         OVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768590412; x=1769195212;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z+9kva+4+7bFF1Q4JdYsrxPZWF20FdvonCIErMrVF8=;
        b=w05qLpVVArybN2ypuWB+5LRZZqz74qQ7o3/SWFRcqVaA+gFkNDyJ8SKfAu3mogJoAl
         jdm+M9Zpb7kFGleh+7BEFBk+HKuCBVPPPPUbML4l/MPWmh9B0c2XJaLOHJWVkM0RB1SG
         dPZWJZIDthUoPBhBwAUI+amWa1rHHZo+mj8wAPgYEyi3dmOH5D029sV+HdqbdOsfHc5W
         Qo3aSuaKYegzMERRHHZKo/mhgRHL/wa4dtGRSmQapvhVQHIefpeoOtvf4eX1nMS8QWyh
         Y8PkxWTU+/oMVNiECkoebFUpRhDMWxhvtYe97vat8sj0xWMHey8NKqAzS1IzexX34ocF
         kDUw==
X-Forwarded-Encrypted: i=1; AJvYcCXV29Uc1DFMwPKX/JmV0mz0mf388vwm0HCjPVjx2c3efpNEB7cPvbjl7V/O/BY9c9Xs6ab/GnhhAxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUdUEbKwmJMkGMSJsi85NZrf2DcynT3cgZvYfyBDk0AA+3df0
	+06Ge7MsFtNWtKbAlHSROnM55MlbYpVC+6QazUPLY/nCMteOXzw8wfml2ICpiSaS6l4=
X-Gm-Gg: AY/fxX4nl8OIKkoZaMxFf1Vz8foTfzfEERJoGjhlQECzzFlHzPGtDehpGbnRm5lFQQF
	1swcxSHW5UNUJuvOQpSCSdYQg2Aqj1DLIa/X7mziHU+LCFkRKrG6rTbIqBJSh1F+KBkLmkq8el4
	TDsZP1jAlp9p8fNqgve1pY7zffjA5zeLHrjlgdF1JJ8XZv83yV+AnJp2TMDSNTvR23HCB/rCjTw
	kI0ckh9LkmlM1KLi6Aeo6FcAYwoSvdNUq2D+M4xCEnB3gEKK3Ap8y8Rix3k08RoERgXkD7gJMYE
	Hxzg8AIUo24lgzKg0EbaljScnxXJxqAJjh2lxRr3DCEnJLvg9RdWFGr21Z0kfmmK6fS/C3LWesG
	IqWoyuaIGuyB7XuC+ZDPXE8vkJlXaDjTsdwppoMkEqgF/o6wqoDzaqrOSmOov147Y3O19yA==
X-Received: by 2002:a17:906:fe4d:b0:b73:9368:ad5e with SMTP id a640c23a62f3a-b8792fc4bb1mr346391766b.34.1768590412328;
        Fri, 16 Jan 2026 11:06:52 -0800 (PST)
Received: from [10.203.83.189] ([151.47.40.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fb973sm304359866b.53.2026.01.16.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:06:51 -0800 (PST)
Message-ID: <bb80803ccd2d3d920f7a53b578ac09093bf29074.camel@baylibre.com>
Subject: Re: [PATCH 1/3] iio: imu: st_lsm6dsx: set buffer sampling frequency
 for accelerometer only
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 16 Jan 2026 20:06:46 +0100
In-Reply-To: <20260116180341.6c0556cd@jic23-huawei>
References: <20260109181528.154127-1-flavra@baylibre.com>
	 <20260109181528.154127-2-flavra@baylibre.com>
	 <20260111161857.4f8b4c35@jic23-huawei>
	 <2ba028f8a6239c821da80ff487b9df5536e58169.camel@baylibre.com>
	 <20260116180341.6c0556cd@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-/eBKoYvDQGax51Lnk/S/"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-/eBKoYvDQGax51Lnk/S/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-16 at 18:03 +0000, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 18:10:32 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > On Sun, 2026-01-11 at 16:18 +0000, Jonathan Cameron wrote:
> > > On Fri,=C2=A0 9 Jan 2026 19:15:26 +0100
> > > Francesco Lavra <flavra@baylibre.com> wrote:
> > > =C2=A0=20
> > > > The st_lsm6dsx_hwfifo_odr_store() function, which is called when
> > > > userspace
> > > > writes the buffer sampling frequency sysfs attribute, calls
> > > > st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> > > > `sensor->id`; since this array is only 2 entries long, an access
> > > > for
> > > > any
> > > > sensor type other than accelerometer or gyroscope is an out-of-
> > > > bounds
> > > > access.
> > > >=20
> > > > To prevent userspace from triggering an out-of-bounds array access,
> > > > and
> > > > to
> > > > support the only use case for which FIFO sampling frequency values
> > > > different from the sensor sampling frequency may be needed (which
> > > > is
> > > > for
> > > > keeping FIFO data rate low while sampling acceleration data at high
> > > > rates
> > > > for accurate event detection), do not create the buffer sampling
> > > > frequency
> > > > attribute for sensor types other than the accelerometer.=C2=A0=20
> > >=20
> > > I'm not following why we need to drop this attribute for the
> > > gyroscope.
> > > Perhaps lay out what the combinations of controls are and the
> > > attributes
> > > we end up with.=C2=A0=20
> >=20
> > It's not like we need to drop this attribute, it's just that I don't
> > see a
> > need for it. The only reason I added this attribute was to be able to
> > control (e.g. lower) the rate of data coming from the sensor while
> > maintaining a high accuracy for event detection; and accurate event
> > detection requires a high sampling rate for the accelerometer.
>=20
> Ok. So key here is for accelerations we are looking at impacts as a
> typical
> use case, whereas gyroscope tends to be slow orientation change stuff.
> That sounds a bit usecase specific. If someone is using these to detect
> shaft rotation
> issues they are going to care about sampling rates on the gyro as well,
> or is there something inherent in the gyroscope events (i.e. maybe there
> aren't any gyro events?) that makes this not relevant?

All the events supported by this driver (motion detection and tap
detection) use acceleration data only.
Some chip variants (e.g LSM6DSV) have more advanced features such as
configurable finite state machines that can take inputs from both the
accelerometer and the gyroscope and generate event interrupts; but I don't
think these events would map cleanly to standard IIO event types.


--=-/eBKoYvDQGax51Lnk/S/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlqjEYACgkQ7fE7c86U
Nl/hYwwAsREJSJiBWAiO8Im4GVFnL/lbjztKyJQnQdjdTwTAhaJzH1rXIQKG8yFp
u//E5bpMxSk64TmwqJU6ALUqttchVxyoGDuergMTvbQv1M/GMe9KroSomRNO0nKS
vi2Ua7U2IZzPf0R4d7fLJxKk6KCkgKsR7zhb43R3GoAhIqfHutQPdETevfPlZXl2
QF64zR4TQwx44lgPzbrDK3lbC6TIhTQ5yIFFpeM5t8edhYB54QnpdQEslr9Sprv0
6XtK7I76l/dkfYsSees2c5xqvTB7xd7yMWOEQhtErP1UYsw7QCj4A2UmoClE6HcT
HjErv/HN7wsMo6GKWHpgMC8557EMPojjDbcxPXBprcugwjz3EAWfW2rmtxthhEgc
mUtSjKDdxdVN66dVFjNQdvZErnv9mKXszyA9a9VY9zwZvI6BMLURQxnoIrL0XxEs
vD4oHfdwfWRxSSK0by+CylqkBuie/1StM467lGYRV06pgaTW5ExKZ/poGYWnEJpj
0xw5r0Ig
=dFik
-----END PGP SIGNATURE-----

--=-/eBKoYvDQGax51Lnk/S/--

