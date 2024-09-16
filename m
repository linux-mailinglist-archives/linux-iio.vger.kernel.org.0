Return-Path: <linux-iio+bounces-9607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E216979E46
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 11:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC121F213F0
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9726714A4D0;
	Mon, 16 Sep 2024 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mnW2KrCs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8013EFF3
	for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478348; cv=none; b=i0a/YUP/mJipBmAD98G7Nnag2fphCrtolbIQ791RfyDT1+Vdy4E3hw5PzW2WTcZ4sNwAsVec4lwgGqT0zwAdiZ5Bgk/mLXcRtPTCDL/+MXTAEY94zYhw0bTGzDMnCN89N3K7QaIv94nXO3lQI0qCAD0+7rwx5l8Hzwd+ICRYO7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478348; c=relaxed/simple;
	bh=tUn3Lb8xB6w5JpvkBfX8jr4Rmxy4aQ9cSkNjcTe14E0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E+KbjEKEBfyFFXEP1RWgQpOJzL+TIb5u/fzjNHNKcrjgAQkXN5Y1zXX9Al0bwvRUbEJ7Qlh8OxwO/Q+lAtovKdKcyStSNacsvs7v5fySo5p5ir13fsTXDep1kmJqBLUVeLrY8FbtC4ze8902YtKS1SKuxzLXuGuhYU/ZGHsazbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mnW2KrCs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cafda818aso41243285e9.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2024 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726478344; x=1727083144; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S0+hnJtME97aYVYNEFjXn7v5J7Z9ezZzdhIUThh/M4=;
        b=mnW2KrCsukwIHvFgTRnD99W6i3JiusOmnT/9JNoAcEqcsPi4jSPQFo4/sngLw5H4Xh
         zbQ0ya6+2S1XN3bzj/4LoBxc/9LHaFg3NegV5wUs/wncGjNesdKcG2gLV2F0Qt2DYzdI
         233ZvArSV3qszjeqDgzJvkFn6BnU1NDIFwuubPr3JVcugYQ/jtQIB6iyLwGC8TSuHak+
         K3s1VUYlmHq0vKYKMZnFo69SWPbz8RDU7JN/UG56EnlN2vHTyTMSTLVn3PY/KtzB2qtw
         m96DXjZV7vLPQhx5JyyxnxakQJ7hKTHwpbcwQj0E/uH30R7csiYB/1tEeEeCuVIRpTYV
         eaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478344; x=1727083144;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3S0+hnJtME97aYVYNEFjXn7v5J7Z9ezZzdhIUThh/M4=;
        b=XcrMIohXFceFVS1XKZRLH7GTq4SQEx8TW7bMYssrLVNlW0TfcyKdqDyCMXnHqfWYhG
         hCkYXrCuf4oNGz2xuYKhCugTcYIHoXTvg1WnNdL6TaLFRWgGaTX8MyJeKU4t+iL4TPcs
         4pwqyBRPhN/ZtMduB/QwipUv8KsX5L0wUMwxE+M87QlTI7hC1PtmVcOjSK+4J1phgG0a
         9cVNduElmkesN5d2B4Vr4RJIHaagvGBIEnPDuaCF7lq187W7JSwuv9AUa5thF5luLebN
         w0Q8jGlWzDAaCE+VdT+UkQM7gdDi9ykZEkHqmQnAvF9p8QpmJvE4AMejJb3xyasOiLeC
         Y2uw==
X-Forwarded-Encrypted: i=1; AJvYcCXwmNJV3gWDBMv0R42bVls6KkIBflB6uGErIORfqLTjrGLOQnOnRHEHE9U1ugb6q9geNQOVSaRduHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwteH8jNjj22RKKZyue1hdtoR6TQtlcVc5uo1s/QQ2vNhq4XsKD
	mX7QcC+1nVgFydYtruF8qIDK3QHcDtCJxqn59XMDgNWWwptM4uQwgcnb+uBYMMQ=
X-Google-Smtp-Source: AGHT+IHAcQcrc3voHWoxZH5ruJpkQ2UnBhuAfFL7M0m2Kh1+BP66VwdpFaj9SlK3Tb1udKSqVEmBjA==
X-Received: by 2002:a05:600c:4f51:b0:42c:b95c:65b7 with SMTP id 5b1f17b1804b1-42cdb531b1cmr103606165e9.8.1726478344247;
        Mon, 16 Sep 2024 02:19:04 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e6f2486esm6806258f8f.0.2024.09.16.02.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 02:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Sep 2024 09:19:02 +0000
Message-Id: <D47LHT5XPYTX.3OWFQR9N23FZH@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, "Jonathan Corbet" <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
From: "Esteban Blanc" <eblanc@baylibre.com>
To: "Jonathan Cameron" <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
 <20240826102748.4be0b642@jic23-huawei>
 <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
 <0a4e7fe39cf36774b28c86f6baab5ef8c20e3d6b.camel@gmail.com>
 <D4567LFFTYJQ.2YC5OODKOVPNB@baylibre.com>
 <84961c1f857dfc8498c41ac97235a037111ed6d5.camel@gmail.com>
 <20240914122529.14759e63@jic23-huawei>
In-Reply-To: <20240914122529.14759e63@jic23-huawei>

On Sat Sep 14, 2024 at 11:25 AM UTC, Jonathan Cameron wrote:
> On Fri, 13 Sep 2024 15:46:17 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> > On Fri, 2024-09-13 at 12:55 +0000, Esteban Blanc wrote:
> > > On Fri Sep 13, 2024 at 10:18 AM UTC, Nuno S=C3=A1 wrote: =20
> > > > On Fri, 2024-09-13 at 09:55 +0000, Esteban Blanc wrote: =20
> > > > > On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote: =20
> > > > > > On Thu, 22 Aug 2024 14:45:20 +0200
> > > > > > Esteban Blanc <eblanc@baylibre.com> wrote: =20
> > > > > > > +static const unsigned long ad4630_channel_masks[] =3D {
> > > > > > > +	/* Differential only */
> > > > > > > +	BIT(0) | BIT(2),
> > > > > > > +	/* Differential with common byte */
> > > > > > > +	GENMASK(3, 0), =20
> > > > > > The packing of data isn't going to be good. How bad to shuffle
> > > > > > to put the two small channels next to each other?
> > > > > > Seems like it means you will want to combine your deinterleave
> > > > > > and channel specific handling above, which is a bit fiddly but
> > > > > > not much worse than current code. =20
> > > > >=20
> > > > > I can do it since that was what I had done in the RFC in the firs=
t place.
> > > > > Nuno asked for in this email
> > > > > https://lore.kernel.org/r/0036d44542f8cf45c91c867f0ddd7b45d1904d6=
b.camel@gmail.com/
> > > > > :
> > > > >  =20
> > > > > > > > * You're pushing the CM channels into the end. So when we a=
 2 channel
> > > > > > > > device
> > > > > > > > we'll have: =20
> > > > >  =20
> > > > > > > > in_voltage0 - diff
> > > > > > > > in_voltage1 - diff
> > > > > > > > in_voltage2 - CM associated with chan0
> > > > > > > > in_voltage0 - CM associated with chan1
> > > > > > > >=20
> > > > > > > > I think we could make it so the CM channel comes right afte=
r the channel
> > > > > > > > where
> > > > > > > > it's data belongs too. So for example, odd channels would b=
e CM channels
> > > > > > > > (and
> > > > > > > > labels could also make sense). =20
> > > > >=20
> > > > > So that's what I did here :D
> > > > >=20
> > > > > For the software side off things here it doesn't change a lot of =
things
> > > > > since we have to manipulate the data anyway, putting the extra by=
te at the
> > > > > end or in between is no extra work.
> > > > > For the offload engine however, it should be easier to ask for 24=
 bits
> > > > > then 8 bits for each channel as it would return two u32 per "hard=
ware
> > > > > channel".
> > > > >=20
> > > > > In order to avoid having two different layouts, I was kind of sol=
d by
> > > > > Nuno's idea of having the CM in between each diff channel.
> > > > >  =20
> > > >=20
> > > > Tbh, I was not even thinking about the layout when I proposed the a=
rrangement.
> > > > Just
> > > > made sense to me (from a logical point of view) to have them togeth=
er as they
> > > > relate
> > > > to the same physical channel. FWIW, we're also speaking bytes in he=
re so not sure
> > > > if
> > > > it's that important (or bad). =20
> > >=20
> > > The best we can do (if we managed to do it HDL wise) is to reorder th=
e
> > > data to get both CM byte in a single u32 after the 2 u32 of both diff
> > > channel. That would be 3 u32 instead of 4.
>
> Entirely up to you. :)

Ok so here is the plan I propose:
 1. Use the layout of this patch (common byte channels just after their
 respective diff channel) as it should work out of the box for the offload
 engine (once it's merged [1]).
 2. In case of performance issue, switch to the RFC layout (both diff
 channels then both common byte channels) and try to modify the HDL for
 the offload engine to reduce the memory footprint by one byte for the 2
 hardware channels case.

[1]: https://lore.kernel.org/lkml/20240722-dlech-mainline-spi-engine-offloa=
d-2-v3-0-7420e45df69b@baylibre.com/

Best regards,

--=20
Esteban Blanc
BayLibre


