Return-Path: <linux-iio+bounces-5521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9CE8D5B41
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5B61C23DC4
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 07:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0832D81211;
	Fri, 31 May 2024 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf/uIU73"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14F1103;
	Fri, 31 May 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139447; cv=none; b=gux89YuX/DGyhgyOG9mh+7WL2sX3LG8otbg+bxaQd9kN6665tXQgxmT7rUyoczR85CoO4SYAYIWmaMzP+7D8SGXFtxL2v3cxWu5LQWYA9qRP1L4jyojoP/tacukF7fryq8hCEfD6U9le66Ze1Op3fFAadeD8pRW5XOoLZYlrrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139447; c=relaxed/simple;
	bh=xnYHvMY/VTUJQpNxXLQRjtHgfqwpbPpAJyNpCSPfo4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7BDStq3dRRizVtaULLnrhqi5ABsMe52+leIyOMGTEViizS9j57Cckn+ax3NGyIXsf2xRGn1k0yjd+PtzMJglMG/hwd4gw/9DcWJYDgE7cR8a81F+T0c22P8nenGAdDmtvky52k2fbn2YAOFu4ncOVHi26lUgqmL+Je+UQVILl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf/uIU73; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a621cb07d8fso176921866b.2;
        Fri, 31 May 2024 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717139444; x=1717744244; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RPVtW4WD9DDygIanrUK44ByDkBngRzp2yu/M+5s0FQY=;
        b=jf/uIU73XW3agHvnh7nMpebG02PobO+MR3TY4LYv1GVv0X3ctRRyWyUfi1l2GcB7cc
         IpKtkj1uX1pRRiJ69esISO0U9VJSQxVHxwnccVyHvr+tr+BnJzhH7VKoHPKX9N04V45X
         Mqll6QmxwSo8tSeLRkkKwPZawW1h6KY++4lZaVWVDnWoeigHOXia+kUD0kttcboEEdv2
         FICHXWNI30g1oAJ39CjBdR9YGGPUse7aEacBZ5EmvWgzsbjd4PtnD+HAzT8F/Pmh8Egx
         zsRFniHKehO/PafBZjuxWOjQey0yH7tPg4V87QHXzUtrF2thWEq3zctMT75XVbsuhY2E
         M7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717139444; x=1717744244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPVtW4WD9DDygIanrUK44ByDkBngRzp2yu/M+5s0FQY=;
        b=YGWRjtx/gbkDViSFM5fQ4ziQ2yHFFM9jq3s+8tfMZ11Qz+o9jh68/z+Ilu+zNcTxvI
         wCL4X9XrZgDotumo0ffskWyz+BvaPBGiTHHLaE8SnbOBYF95/mfTEU7ijUw0GZe3cwBC
         7wglTz04svcBJclU9y6iDb0K3xtdnIRlTmwMQk2cXWnKM4SVog0MQCDEdTghdNdpmH17
         uvf/kPpIuLUu5qkhpzrm579IhX/dhUw54BpM9pJ/qz0eQ5wmvPMags7Xn25KJqXZFJNC
         4zWNby+U39Rd5TesQd8k0Jy3IFBgE/WIf8KMVfL6HFGfrbnMzHkFEIeChfxvLWeY1mdY
         AFCg==
X-Forwarded-Encrypted: i=1; AJvYcCX88n2bBvfO0ErZmTsQXl3eqyMcEjFO+fSRJy1NmpvMo4i6H2D9iQfUN5ss06Gk3/PXpvePymN/LOuIo/GruYCp+3olBAm3SREgcVrw7QCanu0aJFdlPIKbrGkJchQsbaxNJzBB0Fft8NEaWxzxywwh30kTFgJsdH4hfEUNUbhTnbdXIQ==
X-Gm-Message-State: AOJu0YxCc3VI8XT+UwrHdXrKlZlKh3u2e3eeGlQgeFT/4E/Ef4j3HXpI
	Ksgy1pwt3JfFLlSHyBfKbtpeZPpwlxvHvlNOzlyQPoMFOvsVeBqu
X-Google-Smtp-Source: AGHT+IEtAP+6SRyTm8Mw4bvv45VqtX8Hk/sPp93MfTus1eE2vZ2fnZAl2MXuOHIdtdXWZTYw4qis7w==
X-Received: by 2002:a17:906:1d42:b0:a65:4268:dfca with SMTP id a640c23a62f3a-a6822636771mr66549866b.65.1717139444107;
        Fri, 31 May 2024 00:10:44 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f03867sm55697666b.27.2024.05.31.00.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 00:10:43 -0700 (PDT)
Message-ID: <5e263d5ce90d6ad187adb7d4a007ce2e79095829.camel@gmail.com>
Subject: Re: [PATCH v3 3/6] iio: adc: ad7173: refactor ain and vref selection
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 09:10:43 +0200
In-Reply-To: <d2f4e6da-75b1-4450-b295-45772dfb3f33@gmail.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-3-7e9eddbbd3eb@analog.com>
	 <71452f6882efe6a181d477914488617d28a38e2f.camel@gmail.com>
	 <4b704b553282c0689dfef714c49ba97a33198898.camel@gmail.com>
	 <d2f4e6da-75b1-4450-b295-45772dfb3f33@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-30 at 17:45 +0300, Ceclan, Dumitru wrote:
> On 29/05/2024 15:49, Nuno S=C3=A1 wrote:
> > On Wed, 2024-05-29 at 14:27 +0200, Nuno S=C3=A1 wrote:
> > > On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> > > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> ...
>=20
> > > > +static int ad7173_validate_voltage_ain_inputs(struct ad7173_state =
*st,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ain[2])
> >=20
> > Pass the pointer and size of it... Also, it should be made 'const'
> >=20
>=20
> I'm learning here: what is the purpose of passing the size of it?
> This is a specific case where the size will always be 2
>=20

Basically readability... Yes, in this case it will be a stretch to assume w=
e'll ever
have anything bigger than 2 (so the scalability argument is not so applicab=
le) so I'm
ok if you don't pass the size. It's just I really dislike (as a practice) t=
o have
raw/magic numbers in the code. In here, it won't be that bad as by the cont=
ext, one
can easily understand the meaning of 2. Nevertheless, I would, still, at th=
e very
least consider to either use a #define or a better name for the iterator (a=
nything
more meaningful than 'i' so that it looks more understandable than 'i < 2')

- Nuno S=C3=A1=20
>=20


