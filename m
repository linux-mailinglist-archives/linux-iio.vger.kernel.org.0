Return-Path: <linux-iio+bounces-18550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19105A97AB3
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12D17AAE98
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132E2C2574;
	Tue, 22 Apr 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2pZ9Ltg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2D8634F;
	Tue, 22 Apr 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362267; cv=none; b=L9tptKNS414d1Z7DDFB3W7IjDzKS50VqxDcT9RKNkEOEWwLmMcCVaG8nqsY2SRTWhqA8ORasVUqwJW2i5jx0PJaJzHXGnz/NXijErF/tyCAIzy0JBldA8hm9E5psvxDJ637EWIhfz+94c3H7revRIVydXRvu+xoctS4atDc977Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362267; c=relaxed/simple;
	bh=xKFeD+QaeLGzNUOYFH4M+KARAkjJY+Gn/GCxeecB5HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGTB4bCYKVM+mLx8O9Blf208mVQvMyjx36WMF6FlVNVzZ3CJxp4th9oIRGybnOWAoMzpK2Y8MAdhmSWoMTjqTHwXkGJ1wH1FAItym8O1jZcl98F03IOdO6PWi7pZmVOp2qSGKM2nzZM88+emn6geUcT/0DsiilXAsou4idaZRlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2pZ9Ltg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso876199166b.3;
        Tue, 22 Apr 2025 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362263; x=1745967063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtNg2abh49QsnTa1XSIwbO/eokylj5yxtKMHXP/aBRw=;
        b=F2pZ9LtgqeukdZ34OTs7PuPZw7XxL8scdVNrOKNYJEYnBApVKAOrFwGuJljROCeRG2
         I7DQpxnA3wEJavZFM1kYmNT9OTvf1rpWw1JQ1ygtxRPhajdFVrVIuvAKW/5yG5Fa9kNH
         jFoW/ggSxsXxvbvxk+Mqcx2aiinTPTLAz7y8F/4gwcUZwrj59ECZ4SmAIx0/gE5sMckQ
         zObcQbBSWr7s8ArDoVuOtkW0rGUIg0Gz8LQZx2wPN4mYs8E5uaMKQQfZrRieGtB4t+Qp
         4hztktSz2wg6oYsdlHoG6OkEvomkdup2D0VX5vbBdL3/OKyA+F06b6HlsvD06+ucO2iI
         ngPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362263; x=1745967063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtNg2abh49QsnTa1XSIwbO/eokylj5yxtKMHXP/aBRw=;
        b=EKTAFGOBTa5788Ur14DD4sQbKG3DbEMbds/1ePFs37/q+l74aHCX0EVJt5KTGA4ijA
         u45E9c48OR4K5Lwdw5EsEwAq8cBbkIhqh+1J4hnZA3IrNk46AbtzJzlhin88fTYHg+K8
         H3ZOhjz+q332/jALz7PiiIJ7dZNeCFil7GBMGeK5hxcPlOG7vqPDY62IXntnrrpm1hHD
         8ifQ9n+PDAq5/JthtG28PzvYTTuOKLtLJ5PyXr/+C+yc8i+H/Spava31DN4+FeT9+U/S
         aMLA6D5nehqAscJIVV6gBDAvhgzWew8tuaQSOlmUmZbIVeacdqowr76oqL+cksWJvRa6
         As3w==
X-Forwarded-Encrypted: i=1; AJvYcCUi0BelkG9Um4M13q4rzbfpWvJ4Eb+fTjFyN4FKw0/1k30+5bYCD3EsqlxWW61E/bjzMVux9vvGCWM=@vger.kernel.org, AJvYcCWunwSYC8TTAvViGGg+22xQaRg+jTnCQaNJ+J6Yr5FWP4QWuytXtrpRZL8md/BHjn11fLo83/yfPtci9fCv@vger.kernel.org
X-Gm-Message-State: AOJu0YywCu8qtdGv7qsD4TiD+X7NaFfeVWq5dl9E2RFdBk7nXVnU1BLl
	OZwSakz3fUOZEiJvKpD991DqOByhZL9cvkbozLQnVG3z4V87O7XGfd76AAu8gC47b9FOMNHz4gf
	thvuMaOkz7qgAZI+RollVKduVkfU=
X-Gm-Gg: ASbGncsR7ZGCMdFtwJcgmNFbzHgvFolOuICFB0yVsJTj4IDDR7S5Twhpv4gkr+ZAXCa
	PnHyMDNi5kq6235wwz601JVsr3wbE6Ez5xbGsyDzaFTDV0bHURJLtUoVRoRK3eYxT1857jxdslB
	z1q+kxHu569Ur8csywnXT8NQ==
X-Google-Smtp-Source: AGHT+IE5r0MFZFYCu7PJn/lLZUKtD7zvLcloIWqKzgfm6B6oQoGOwioIpprZLoxLjQ81aU2yyIye6lqvTx9A4VFkpPo=
X-Received: by 2002:a17:907:7b85:b0:ace:37d6:a5ce with SMTP id
 a640c23a62f3a-ace37d6b029mr163304366b.19.1745362263600; Tue, 22 Apr 2025
 15:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-1-3fd36475c706@baylibre.com>
 <CAHp75VeuNhfJrNAZZwY2tEHte=UPHLOPNUz7y_J20xv2+_Zdeg@mail.gmail.com> <f0948adc-8130-4417-8c59-f0b52a7a0e01@baylibre.com>
In-Reply-To: <f0948adc-8130-4417-8c59-f0b52a7a0e01@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 01:50:27 +0300
X-Gm-Features: ATxdqUFWkS9PxNa71tt9rtag-1SYSUfDj-KjVRpIxd6xsGuKNSHNFIJoyiRJZ98
Message-ID: <CAHp75Vde6BOmyc1UevU9EymVVzRD29w=KzkAdaAvsUb50UsrcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iio: introduce IIO_DECLARE_BUFFER_WITH_TS macros
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:37=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 4/22/25 5:30 PM, Andy Shevchenko wrote:
> > On Wed, Apr 23, 2025 at 1:08=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote:

...

> >> +_Static_assert(sizeof(IIO_DMA_MINALIGN) % sizeof(s64) =3D=3D 0,
> >
> > Why not static_assert() ? Because of the message? But static_assert()
> > supports messages AFAICS.
> >
> >> +       "macros above assume that IIO_DMA_MINALIGN also ensures s64 ti=
mestamp alignment");
>
> I just knew that was standard C. But I support BUILD_BUG_ON_MSG or static=
_assert
> would work just as well here.

In the kernel we use u8, for example, however in the standard it's
uint8_t :-) Same with many compiler attributes and wrappers on top of
the compiler things.
According to v6.14 codebase the only one driver uses _Static_assert()
for that (there are many in tools/ and more in BPF, with a few headers
where it's fine (esp. in UAPI where no static_assert() available).

--=20
With Best Regards,
Andy Shevchenko

