Return-Path: <linux-iio+bounces-27672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127AD18ED4
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0DBE301A319
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 12:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634DC38FF0C;
	Tue, 13 Jan 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUdZvrmT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74D38FF0E
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308207; cv=none; b=T+ApN3gWZp1ywc1XyA7c0I0CpTap0ME0y1pB5Y7euyH8R0N/4xkNoi0oNWS9L1jTsl+YRxKZqCKsu+y3I+5K3DC+z12Ab1Zrux2SGJcViBf/dIFnk493Lz2G+qfHl6Gx3+EF86WGL9RkIy3Hi5B2/ho4pC5tJBPr3Gn0IxuEKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308207; c=relaxed/simple;
	bh=L3O3sJt+mUneccefToyfz3RiAzBZW6i9zO3xClpZC2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LwYR0ab6eTv76gHQfuPxmPCNk9KO/UOJP8lXGuRxixs1H+Z0SZtL7g0j1TzjT2EEnAPE2UFY+p8fulv7kchOgL0fq67INQzNWnQ7rjIDr1e4o7HoswBU/BgAF0Fjy2rmK9e2EuIuabh9R3u+VE+HsJUS22Xe/jWocCj+PZlBKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUdZvrmT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so6327305f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768308204; x=1768913004; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVGMWIu4q8p1YyDY5Ndf2gr61lPlH/BoDgK4ZgFot58=;
        b=KUdZvrmTer1xIX3vjoPWzoJ0iVMy1cN4LOR8GhnD7h+Gs23FqC+m8GyyBn3knCNPpy
         NA779LMTefmNJjYJcsi48v1obFoPQeWNvYkdKkrc0RXRG8Irs/mXyEu9Ot0WVgB9ogl/
         lA9zYWL3Fk7yyBdoF60EmHNoykicNBGiJU2v3Hrd5yA37cxp/x+Bn6w0cev0rG4PmXzk
         ipCx+0b+LvGvkIwWx9EMHLUgo/cN6bTNOruZBJt0gjV8Z5c6OolNUZMjNbiW8RuhW/Oe
         6XGl+vpJVb2ua4tYm7NDjQRuwC5nl99/+9Cri4pIZ7ifxzxe5NJV20SDLpEddV30aH6c
         LOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308204; x=1768913004;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVGMWIu4q8p1YyDY5Ndf2gr61lPlH/BoDgK4ZgFot58=;
        b=mQFY+5x/npefsMYRkEH+K/72NxcBP+tgM3wB18BCnPNEOjgcn8iCxz2e7DKublaKpM
         NQSx10ZqHeiEvczlkHo9ae75E1NDdkaMGaP3YtIWXbMWgA3P/yp/Sj8dC+p9JzohWIyK
         w8YnKRjAoHuDtbHxDrYK9w8EX4iMBxF18K3t2l6YDsyShrxkMC17VlvTJxxrnhGvYXYP
         87ygi+eIkJotNWNgndTBheu6SeiRLlLCRjjb2hC2bxqjIlbHSu081RrYtC2xXsohR1Fv
         wLJG9kgB3NRR3gRaG98CFkd4GBANRJiMkzzG1wouZ1uGDyC9yz4c197Hm3/Cn3G8LjF5
         oITw==
X-Forwarded-Encrypted: i=1; AJvYcCXCDdlKEtYTm/2wRfGH4NY5TlocCZcZYqALqVUOND+UIA8AFQzBAV66P6LR5F16yvrxWA2Tfcz15zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2z56j23EpddA9zu9p5VLCz5cBt3h2AygYjyh5D6ULZbd6QAV
	AFHckihXiqqEhhqHI2VLvv1EEB71cnU6TCBr3d8jiOq/EgvO/xONUIl8SQH1uc3D
X-Gm-Gg: AY/fxX5aD/F1MhYba+nx3+eWZ/SwZlj0mk+MqNGpaqZWOnFtnOKK/3Gl/SbvTBsaPol
	K+07HqZehRS2ldAm9WDRl1TT6ra6Ycp8/p6vdWcw94WY5vsV1b1lidOlihygbDBBVYNe1pP3Kor
	MyVNcTiHVxeMhMtrKaSSXjSQrRrVl9MK0Ozwa2Q/NeE+/eyhrmUQwgYH+VZ56zdJKXH+v5c1z7V
	XCXl5nvq2HJni59vCOyWihCBAWDtQJQYJSJ+4yD51gyo5IuxaeWMHEiTDNTZoj6IY2WIoLIEm66
	5a2Hi0UUKL40WMBZBj9m/xHrwvlX239OypcdnMDD+R30xbhEa0FSYTvfAX8xYqZC6I09T2LkNy+
	3JL9LW1H1U1oRbkHOgDNJ1FpZDKes63TpaZzGdQpAyrTev7HRzy0dMsnb7kvzRIEd0qWmpXo1Aa
	QmBhw2BkXjCHo=
X-Google-Smtp-Source: AGHT+IFjZ9JQSa0TsHDK8takR3IQvAY4G3RlkYtO0mzzhCMkuO7qULp+a2Ir7ye8NQZAS07jOTQgGA==
X-Received: by 2002:a5d:588f:0:b0:430:fdfc:7dd3 with SMTP id ffacd0b85a97d-432c37d2efdmr26634762f8f.50.1768308203832;
        Tue, 13 Jan 2026 04:43:23 -0800 (PST)
Received: from [10.5.0.2] ([185.128.9.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ede7esm44956945f8f.32.2026.01.13.04.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:43:23 -0800 (PST)
Message-ID: <186a9a1a9cf8bd6c4c91bac62344b7015e696005.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
	 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Jan 2026 12:44:06 +0000
In-Reply-To: <39f4b68b-0bbc-4c41-a8ee-206209900a66@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	 <20251221200014.29af7df8@jic23-huawei>
	 <356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
	 <997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
	 <20260111114109.28b01266@jic23-huawei>
	 <d36d38b2ae691371c653927fcba310bc525e0aac.camel@gmail.com>
	 <51085acb-91c9-43ad-8f7e-94f1e9c995ed@vaisala.com>
	 <f4cd3b85c47b2829cc54c514dffd254433f796e4.camel@gmail.com>
	 <39f4b68b-0bbc-4c41-a8ee-206209900a66@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 13:49 +0200, Tomas Melin wrote:
> Hi,
>=20
> On 13/01/2026 12:52, Nuno S=C3=A1 wrote:
> > On Tue, 2026-01-13 at 09:47 +0200, Tomas Melin wrote:
> > > Hi,
> > >=20
> > > On 12/01/2026 15:21, Nuno S=C3=A1 wrote:
> > > > On Sun, 2026-01-11 at 11:41 +0000, Jonathan Cameron wrote:
> > > > > On Mon, 05 Jan 2026 14:57:02 +0000
> > > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > >=20
> > > > > > On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote:
>=20
> > > > >=20
> > > > > When we say the backend needs no driver, where does the data end =
up?
> > > > > Is the idea that it goes into some processing pipeline and sent t=
o
> > > > > some external path that we have no visibility of? i.e. We configu=
re the
> > > > > data capture in Linux but never see the data?
> > > >=20
> > > > Yes, that's also my assumption about Tomas's usecase.
> > >=20
> > > The data becomes available to user space but there is currently no
> > > immediate need or natural place to create a separate instance to
> > > function as a backend device.
> >=20
> > So do you have some completely different data path bypassing IIO (just =
curious)?
>=20
> Yes, IP handles data reception and data transfer outside of iio context.
>=20
> >=20
> > >=20
> > > But that being said, I'm leaning towards thinking that perhaps a
> > > minimalistic backend should always be registered after all. That woul=
d
> > > keep the idea of the backend always existing intact.
> > > But since the backend can be missing a lot of the features defined fo=
r
> > > the current ADI backend, capability handling would need to be added t=
o
> > > the backend framework to make it functional.
> > >=20
> > > Looking into how this could be achieved with reasonable impact, I hav=
e
> > > tried to identify capabilities that we could add for starters, and th=
en
> > > have the frontend behave differently depending on what features are p=
resent.
> > >=20
> > > Something like this (added to backend_info),
> > > .caps =3D IIO_BACKEND_CAP_TEST_PATTERNS |=C2=A0 --> backend patterns =
are avail.
> > > 	IIO_BACKEND_CAP_BUFFERING |=C2=A0 --> backend has buffering cap.
> > > 	IIO_BACKEND_CAP_CALIBRATION, --> backend supports calibration
> > >=20
> >=20
> > Looks reasonable but I'm still a bit afraid to open this can of worms. =
But as Jonathan
> > pointed out multiple times on the backend code, this is mostly inkernel=
 interfaces so
> > it is easier to deal with bad choices :).
>=20
> I understand this concern, but would anticipate that there are only a
> limited number of capabilties that need to be handled, so it should stay
> fairly managable.
>=20
> > =C2=A0
> >=20
> > We would still need to "combine" these capabilities feature with a dumm=
y backend that
> > would dummy implement the more common/expected like (chan)enable/disabl=
e and so on.
>=20
> I think the dummy backend is probably not gonna be needed as the current
> axi backend can advertise the available set of capabilities. The
> frontends are then free to make use of the capability bits as needed.
> In my use case, I need to implement a limited backend that does not
> claim any capabilities but only provides a minimum set of functionality.
>=20

Ok, looking at the driver indeed it seems we would not need much advertised=
.
Let's see how something like the above would look like and discuss on top o=
f that.

- Nuno S=C3=A1


