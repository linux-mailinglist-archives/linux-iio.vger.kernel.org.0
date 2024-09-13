Return-Path: <linux-iio+bounces-9494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3351977D24
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 12:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097311C21028
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB531D79BD;
	Fri, 13 Sep 2024 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0oE51jG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C51272A6;
	Fri, 13 Sep 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222691; cv=none; b=QfqyUKRR0vtbkPL+wHcjgFnT41PBzaN9kiE0joSw6dDC3k/gIAaIK7P4sFZGjYnMYDA7Jm70DacoY9jxtTnGeG1xFvxSOmJNXKhtXKArHiB4+oeakw8DL2PofmxdL/JX+wXI8fmD3i0WLqqe9xrqMQedjhZQgSImbZpCHQ0jAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222691; c=relaxed/simple;
	bh=rq0cpoOgAqPg2i8ruVnsc/sSAuiTwarjDXcOaAEYfXo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GCrVmeGwJnMgiGgiw8wOAqwkdl5/S0s7OYstumpFCtYJkZ9miFKLFrvCs/sKmNCV2zw+Ku5ZY4Vo3fhtqWSoIYKA5L+u+nl3WnhUQQyTWsyb4X+tO0wPKbzvlh+VBv+gKq2/qmVJ9wNvYgw74zfNafZVu2hacEuZUu5R7pF3iNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0oE51jG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so19024805e9.0;
        Fri, 13 Sep 2024 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726222688; x=1726827488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kx5BsABkoElJE7bjexxNubeyaOGJiSqqc8lQf9xJ58Q=;
        b=B0oE51jGBj0ZKAyD0lA/QMotEfWtsZ6b4WgvUn91D7IPWfeYl6ifYJefTbU0/StIl+
         iXum81AFs0Obvl7zhP5Ci/IlIJ6xTaIsr2rmjgjgNgHe0XfKBvlPrORVkxWWUQm7X86H
         tgrL7gjU6bDpbmNLlc+ku4aA/i4JiArbIU3dm+mOEE6nbsIB7n71CK8nd1Rj9HRSghp2
         TFVy4NLQfH9e97ZVkziqEhP+h1XkboklPKpFCuyPHdafcdFSz0MzGssTeT/BAcC3wN4k
         rzDmpiSYGjGTcLExAW2n9xurqE8G8HmqQ7V7IefIPaQghKGBvWX9GAFhfWNMtIm7WSjh
         09oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726222688; x=1726827488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kx5BsABkoElJE7bjexxNubeyaOGJiSqqc8lQf9xJ58Q=;
        b=l28xs8uNfPcRXk/3yf0DkgxWNIgLDa4JqjrMQfLQS6XpoH15iU9hkmugVEZMJ47e+S
         NuCiOo3lGLP5VmD+3X00XNdWOP3fTJw59/P3EiMjyx2KC9+zrM980S6CMqbX1M6zF5oi
         xgWtbzGoc8NC8oN1MeWBR7ADRqUgVZYrXPzPIgB5JJuayGh9VIhd/kudYrCY4YeenlKS
         +pfGi+Rdu1oBwtEn7vlZiAVxxnwPaM1JQpmyvESjASaJ1+b5dXUbVz1JFoldz6NQnuRg
         ehuvzq67MVPGd/yVHu02ySFO/u/33ur/UF1ixf38Gf9rb1e9fzo/RJj9c5ciMkS/0JL8
         gKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMYH9fsGMWdSR2nbjQRFvb2y8xpb75O99u4+WVA897aJEFgvy52xVPBs/hVETyn2C/QrMQIwDCEuFe@vger.kernel.org, AJvYcCWpCLx0eSEGwM+YB+7/KqgzAp/MjeZbT6IuzYtFHzu/r8SgzgG+7sYOUEfG6n3ab+qlxfVqqEUjHmXA@vger.kernel.org, AJvYcCX+U56JJmtkchdlGxwQO6WhwFSDpGHBddVsyS0igY/kF3OGoTu77TtpFmdN7w/ZmFaGQprVDJFZxGsDGzPo@vger.kernel.org, AJvYcCXQ1xsMMYPXnEcg9QQLvtq3tpO3ideoaX2wF45BaTv5YMwYeQNFWk+Bs3DubEJxU/vclV/zPMREPQ9i@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZbci6+aoN0spfXpzJTn2vY5B2KVPvBZXoChT4mWQ0HTIFaha
	BknM/rwe/Wl539rv+2DHO9ApcF7Ezy2pFZbJTwAf7SdN+sVvTGPu
X-Google-Smtp-Source: AGHT+IEErEMp5HKQGF5Xiah+gi6I3jO7IyCsIxXTBZS6IkyJs7SzH7NjDnG+zYgZu1BvEiIjkfAT/g==
X-Received: by 2002:a05:600c:1caa:b0:42c:a574:6364 with SMTP id 5b1f17b1804b1-42cdb531b89mr45506795e9.12.1726222686967;
        Fri, 13 Sep 2024 03:18:06 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05a700sm19998105e9.10.2024.09.13.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:18:06 -0700 (PDT)
Message-ID: <0a4e7fe39cf36774b28c86f6baab5ef8c20e3d6b.camel@gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>,  Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org
Date: Fri, 13 Sep 2024 12:18:05 +0200
In-Reply-To: <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	 <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
	 <20240826102748.4be0b642@jic23-huawei>
	 <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-13 at 09:55 +0000, Esteban Blanc wrote:
> On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote:
> > On Thu, 22 Aug 2024 14:45:20 +0200
> > Esteban Blanc <eblanc@baylibre.com> wrote:
> > > @@ -460,12 +517,21 @@ static int ad4030_conversion(struct ad4030_stat=
e *st,
> > > =C2=A0	if (ret)
> > > =C2=A0		return ret;
> > > =C2=A0
> > > -	if (st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> > > +	if (st->chip->num_channels =3D=3D 2)
> > > +		ad4030_extract_interleaved(st->rx_data.raw,
> > > +					=C2=A0=C2=A0 &st->rx_data.diff[0],
> > > +					=C2=A0=C2=A0 &st->rx_data.diff[1]);
> > > +
> > > +	if (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> > > +	=C2=A0=C2=A0=C2=A0 st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> > > =C2=A0		return 0;
> > > =C2=A0
> > > =C2=A0	byte_index =3D BITS_TO_BYTES(chan->scan_type.realbits);
> > > -	for (i =3D 0; i < st->chip->num_channels; i++)
> > > -		st->rx_data.buffered[i].common =3D ((u8 *)&st-
> > > >rx_data.buffered[i].val)[byte_index];
> > > +	/* Doing it backward to avoid overlap when reordering */
> > > +	for (i =3D st->chip->num_channels - 1; i > 0; i--) {
> > > +		st->rx_data.buffered_common[i].diff =3D st->rx_data.diff[i];
> > > +		st->rx_data.buffered_common[i].common =3D ((u8 *)&st-
> > > >rx_data.diff[i])[byte_index];
> > > +	}
> >=20
> > I wonder if doing it in place is actually worthwhile.=C2=A0 Maybe unpac=
k into a second
> > array? That is still fairly small and may make code easier to read.
>=20
> Okay sure
>=20
> > > +static const unsigned long ad4630_channel_masks[] =3D {
> > > +	/* Differential only */
> > > +	BIT(0) | BIT(2),
> > > +	/* Differential with common byte */
> > > +	GENMASK(3, 0),
> > The packing of data isn't going to be good. How bad to shuffle
> > to put the two small channels next to each other?
> > Seems like it means you will want to combine your deinterleave
> > and channel specific handling above, which is a bit fiddly but
> > not much worse than current code.
>=20
> I can do it since that was what I had done in the RFC in the first place.
> Nuno asked for in this email
> https://lore.kernel.org/r/0036d44542f8cf45c91c867f0ddd7b45d1904d6b.camel@=
gmail.com/
> :
>=20
> > > > * You're pushing the CM channels into the end. So when we a 2 chann=
el device
> > > > we'll have:
>=20
> > > > in_voltage0 - diff
> > > > in_voltage1 - diff
> > > > in_voltage2 - CM associated with chan0
> > > > in_voltage0 - CM associated with chan1
> > > >=20
> > > > I think we could make it so the CM channel comes right after the ch=
annel
> > > > where
> > > > it's data belongs too. So for example, odd channels would be CM cha=
nnels (and
> > > > labels could also make sense).
>=20
> So that's what I did here :D
>=20
> For the software side off things here it doesn't change a lot of things
> since we have to manipulate the data anyway, putting the extra byte at th=
e
> end or in between is no extra work.
> For the offload engine however, it should be easier to ask for 24 bits
> then 8 bits for each channel as it would return two u32 per "hardware
> channel".
>=20
> In order to avoid having two different layouts, I was kind of sold by
> Nuno's idea of having the CM in between each diff channel.
>=20

Tbh, I was not even thinking about the layout when I proposed the arrangeme=
nt. Just
made sense to me (from a logical point of view) to have them together as th=
ey relate
to the same physical channel. FWIW, we're also speaking bytes in here so no=
t sure if
it's that important (or bad).

That said, as we should have labels anyways, I'm not being the blocker if e=
veryone
else prefers to have the RFC layout :)

- Nuno S=C3=A1



