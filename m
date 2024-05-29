Return-Path: <linux-iio+bounces-5428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C888D30CF
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEFB1C25B7B
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EECA181BBE;
	Wed, 29 May 2024 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDgymBkU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962B016938C;
	Wed, 29 May 2024 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970173; cv=none; b=D5Y/TPQ6s+uNzIX2YaYOlw/qHeoxQ6FPM+PoddITd8zRwCR+firggaZrm1F0xmeC/VPo5EiNaAQaoX9JESyAKUWIOmE8XR5vPFymva7N7F0xK0g7IdIJFQ8QNT96R6mWeWDZtz+X3Tx5ywJ+vZutaH+nMqwoHJ/oI59qGr2BTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970173; c=relaxed/simple;
	bh=i8tU8Ic/k4UuZKzBZDNg1YpkDmhPR4yS0jCvgdiGZq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIMgBMcGMj/0+TyDzT9CUp1ARej+EW1JIeQj/3u73mtgikh+oS7DVzVXIDPnIqMNGOuQA2W/eRfZuEKEnOc2F/vulxa94O3uzi4v+nnpShdKxPZ08ekdeCT0gQZe/IPTQ5aTj8GO5dE731b6kaRCA4thJosEKU9ygMBkEhShDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDgymBkU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57857e0f465so2223257a12.1;
        Wed, 29 May 2024 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716970169; x=1717574969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i8tU8Ic/k4UuZKzBZDNg1YpkDmhPR4yS0jCvgdiGZq4=;
        b=MDgymBkUgKtSqi+yQH3Bxo7SNFhIAzlHIlPzgyvkfXUCGB/yFGsqJ6Cq7EEvBcNlSl
         zhxgDDhLkzLnDveeRUnq0sY2QxepV755pIeBnnas1xONFELQPLEJverJN+E9ukdf6m85
         au1bGK9zKRRwflnSu2xuvWnbGPPJgTJF0fqKs/i1WfLo55LVt80Z55ulOevQAUF3WsAc
         2QkxuLwwqDKvFe6wPaXgIABFLs95gz23uw4HCSKmeNXIc2D0r7Wn1K/QmL+QrL4QL1J5
         zX3jU2UVNNF+3tD3jtDJ2u6cDbJZez/xH0AraJhMwCXS4p0jABbjZvimAC+oWi+Lm+44
         qLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970169; x=1717574969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8tU8Ic/k4UuZKzBZDNg1YpkDmhPR4yS0jCvgdiGZq4=;
        b=YSs8tONvqN+7xXIiozjhTm+sRwpeTgIzyEtZlcMfzHkMeLqUaoaJDiL+yeRshFnlJP
         8tEjXlkCteliDiJgFURaSDVkKeSGLtqIXO58ZoShikuXITY/faC8qcI41P7kWR3gPisS
         vylFAsOX60+9GjzUV+HKnzzlysifARxWbZe133BYZ6HAF8KMKFXp5PhvdVe4B/wccGF4
         UZvsAT+kxwsCgmjeAChOFeKM6k1I5moS6BwCbHqBnp1k6nUSB4VVsOs4FF7ttABdQU8d
         OLDvv42LDjcfqRAlBxuCW3Yn/NGZVx5WdRmM36vl+TrRyqhGocaUM+Un2mBRqyYNOhI7
         PCLA==
X-Forwarded-Encrypted: i=1; AJvYcCXzMYxZ8TXzKKhCsXwZwBd63GMnVV+lZLbP0vp0PbQrIvd6Cj8ojMWDYi8dUSVXYpIJsxBswZmvsCO99E0o7DpHug6zCP1KJlzM3G31OrGC3aWcQscFGP9b3d46vz5KOwSEndSIx8N0
X-Gm-Message-State: AOJu0YzK3rhl+6cN982zFwYJs1JD9mTNbFodudgvfHuzgiXkoR70vD1V
	pR//8AZ6eTWA31JijEDsw62DZNnQjbupSU2pUQvlWFUXXyOhKZx+
X-Google-Smtp-Source: AGHT+IEq6l34HhXrnlWLRvGM2v0fq27OL/+bpjCQdVA04/gtddmggIC7N+1G0ngNMVw4U02/TUo3ZA==
X-Received: by 2002:a50:d7cc:0:b0:578:33f1:dafb with SMTP id 4fb4d7f45d1cf-578518ec3e4mr9976662a12.4.1716970168941;
        Wed, 29 May 2024 01:09:28 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579ced17435sm4346473a12.53.2024.05.29.01.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:09:28 -0700 (PDT)
Message-ID: <73d7ba0e54a93696aa2c8cab3e6599038bddf533.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad9739a: drop COMPILE_TEST option
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, Anshul
 Dalal <anshulusr@gmail.com>, Andrea Collamati <andrea.collamati@gmail.com>,
  linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 May 2024 10:09:28 +0200
In-Reply-To: <81ec1d1a-d8de-47e4-a5d4-eeaaf1e806a2@app.fastmail.com>
References: <20240528121304.3695252-1-arnd@kernel.org>
	 <539a815398a3c991c1bc1a53967fbcba282dfe3b.camel@gmail.com>
	 <81ec1d1a-d8de-47e4-a5d4-eeaaf1e806a2@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 09:23 +0200, Arnd Bergmann wrote:
> On Wed, May 29, 2024, at 09:20, Nuno S=C3=A1 wrote:
> > On Tue, 2024-05-28 at 14:12 +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > Build testing without SPI results in a warning:
> > >=20
> > > WARNING: unmet direct dependencies detected for REGMAP_SPI
> > > =C2=A0 Depends on [n]: SPI [=3Dn]
> > > =C2=A0 Selected by [m]:
> > > =C2=A0 - AD9739A [=3Dm] && IIO [=3Dm] && (SPI [=3Dn] || COMPILE_TEST =
[=3Dy])
> > >=20
> > > There is no need for this particular COMPILE_TEST option, as allmodco=
nfig
> > > and randconfig testing can just assume that SPI is enabled separately=
.
> > >=20
> > > Drop it to avoid the warning.
> > >=20
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Only for my understanding. When does COMPILE_TEST makes sense to add?
>=20
> The most common use is to enable building a driver
> that is platform specific on x86 allmodconfig
> or on randconfig, e.g.
>=20
> config LPC18XX_DAC
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "NXP LPC18xx DAC driv=
er"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_LPC18XX || COM=
PILE_TEST
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on HAS_IOMEM
>=20
> Since ARCH_LPC18XX is only visible on arch/arm, the
> driver would never be build tested on anything else
> without the ||COMPILE_TEST.

Makes sense... Thanks!

- Nuno S=C3=A1


