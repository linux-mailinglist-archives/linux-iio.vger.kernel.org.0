Return-Path: <linux-iio+bounces-9506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78B97816F
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7028CB21295
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497391DB540;
	Fri, 13 Sep 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwiAXrvo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764A1DA600;
	Fri, 13 Sep 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235183; cv=none; b=U2Hlmk/N6fnK6GUrefMtgy1jaFnbhLiOKeNvrGQZBe/PSKzBCdT9EZFydN0c+s5lyWnsHLfqO6uYPWfPD+zFwxK8dVcIFvBUxFVwP7Ap+8GXZjHklGpu6ttagY6X3UcKVsZumDXG4F8m/byxvZ1SxMlRkBCFlJSaUwLvKFyCPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235183; c=relaxed/simple;
	bh=k3SaSIw+5cdu41t10Wgn4gD1im3EUxo+zV84Aqklf2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meKwiO9JipuidRoiJHZ72ARpcjpdZ+SRbS4as4c5ZHG+/bn5GBtG/6w76AS0gCtqqvYCqc40y2COe59xDVtkgNAQY/XQPKKy7nrkcEhyf+OxOV2m4Tg6QPVLLkmjvA3Xd666FLyc+H9UPqCFrZ3dQgKXy0aAxf8BIGiKLzfR/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwiAXrvo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb2191107so17807725e9.1;
        Fri, 13 Sep 2024 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726235180; x=1726839980; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfduLuvsKg6eBFII0Ig+uMU+Bi2A5zMk2ggjeQnvzmk=;
        b=CwiAXrvogENAd2Sl1cMEq6i1FM1rFh0BpcykxG2auKr7UhpMyFyb+o8QevMvc6yQrH
         ijriMDs1TpCfW//IjyvU+iFvNFKQ2GMsz1NLBPzCWlg4sI5U1Wo4CpEQCofxI1SVHeFf
         J6YgcQCLwZk+yrTPaU9yeLyFAhIRM+Ex4NXzGp2Mw/b3w0X7z7usv1aiyQRtHTGRkyw6
         fwG4N01I13PIf2fgQYUeKk5uAVNyH/Q+nao8JCDFs0t0mbCWohedktCgR7888XTa0DWm
         mSuhmcCUjhZ5v1FuKjRSMxXuL+5PlemvInpZG6e49C3pKwqvkVGA+B35ikUW3llA9UXF
         wmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235180; x=1726839980;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfduLuvsKg6eBFII0Ig+uMU+Bi2A5zMk2ggjeQnvzmk=;
        b=jcK2oGEwMgdct/EmyZKhNyJsfij5y7PwlFKv/gPlqSr0DgaUavWO/bklLPN5fYsOtJ
         Czo5EYm+a6n2IoS1oggwiVQyZn4jbviAzCTI3sYeeTQ3bI2sQYY/uRs9ur4yK/W/3peP
         1vK6kAxuCkqcaLnPB9iQ6pvZUpHpW6/0R2ql2oI/IgW7MyaIHdGVfP+wrh2R+YKD/w5F
         DGhIynBC2S6kz5veIGha0R/Xt+lM5RPco3pUXidlS7jk/ACAxf3+DxAOrICaVXhtSiRV
         RRPixkx07rmN6skqyq1ciEm/itre/RNgrNlDBaKKwzjRRQRvvP5wgj1ufv6tg2lf2/Xq
         3rbg==
X-Forwarded-Encrypted: i=1; AJvYcCUAsJrEbErEnXRGkDn0iwoC4OdhYgIQZv+Y07o91wAzLKXgFPwnmqCG29UiW0+FRAj1uNtdbRopv9ALo1+s@vger.kernel.org, AJvYcCV10OlFcCeiwSsO/4//nuVbmJdEc6ZThbQKbdfHssFU0KVsYCuuI4LtZlsK8x2g+DNd+9PNeEQnZ75D@vger.kernel.org, AJvYcCV4fOlbhLJ5FmiFivvE/rmzAbQxWyAaxYP+RLj7O3m3oFbuGruDvb+Vwpep1euze1jTEa9SaCE/YTYF@vger.kernel.org, AJvYcCVRdqvJSQb0A+10bQILm0OXkFEtMUv1Fo9QgCNvZZ5x0C4hdhHcAC99ACF/Q7UEPDG9XzGjaUqEDl+5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HLuuavCGqMdrb+svShN21fAbFCWdBpgo9OtSN0wecgAVLJdG
	vk/GuOdzedn9TpCeCb8N2uO7MNyBB0lUgIruONkSRnynSw5XPSSr
X-Google-Smtp-Source: AGHT+IFEB323XdIuf48ZUgv8Y/doK07A8Vh8Hg4zl8bZxFxqztDimv74fJ6wwoGuHyeUyE4bD0/rDw==
X-Received: by 2002:a05:600c:4f0c:b0:426:6f17:531 with SMTP id 5b1f17b1804b1-42cdb530cc2mr58082855e9.13.1726235178879;
        Fri, 13 Sep 2024 06:46:18 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1899efsm26262915e9.30.2024.09.13.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:46:18 -0700 (PDT)
Message-ID: <84961c1f857dfc8498c41ac97235a037111ed6d5.camel@gmail.com>
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
Date: Fri, 13 Sep 2024 15:46:17 +0200
In-Reply-To: <D4567LFFTYJQ.2YC5OODKOVPNB@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	 <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
	 <20240826102748.4be0b642@jic23-huawei>
	 <D452E2M75XCM.13OQGAPJ7JJ4A@baylibre.com>
	 <0a4e7fe39cf36774b28c86f6baab5ef8c20e3d6b.camel@gmail.com>
	 <D4567LFFTYJQ.2YC5OODKOVPNB@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-13 at 12:55 +0000, Esteban Blanc wrote:
> On Fri Sep 13, 2024 at 10:18 AM UTC, Nuno S=C3=A1 wrote:
> > On Fri, 2024-09-13 at 09:55 +0000, Esteban Blanc wrote:
> > > On Mon Aug 26, 2024 at 9:27 AM UTC, Jonathan Cameron wrote:
> > > > On Thu, 22 Aug 2024 14:45:20 +0200
> > > > Esteban Blanc <eblanc@baylibre.com> wrote:
> > > > > +static const unsigned long ad4630_channel_masks[] =3D {
> > > > > +	/* Differential only */
> > > > > +	BIT(0) | BIT(2),
> > > > > +	/* Differential with common byte */
> > > > > +	GENMASK(3, 0),
> > > > The packing of data isn't going to be good. How bad to shuffle
> > > > to put the two small channels next to each other?
> > > > Seems like it means you will want to combine your deinterleave
> > > > and channel specific handling above, which is a bit fiddly but
> > > > not much worse than current code.
> > >=20
> > > I can do it since that was what I had done in the RFC in the first pl=
ace.
> > > Nuno asked for in this email
> > > https://lore.kernel.org/r/0036d44542f8cf45c91c867f0ddd7b45d1904d6b.ca=
mel@gmail.com/
> > > :
> > >=20
> > > > > > * You're pushing the CM channels into the end. So when we a 2 c=
hannel
> > > > > > device
> > > > > > we'll have:
> > >=20
> > > > > > in_voltage0 - diff
> > > > > > in_voltage1 - diff
> > > > > > in_voltage2 - CM associated with chan0
> > > > > > in_voltage0 - CM associated with chan1
> > > > > >=20
> > > > > > I think we could make it so the CM channel comes right after th=
e channel
> > > > > > where
> > > > > > it's data belongs too. So for example, odd channels would be CM=
 channels
> > > > > > (and
> > > > > > labels could also make sense).
> > >=20
> > > So that's what I did here :D
> > >=20
> > > For the software side off things here it doesn't change a lot of thin=
gs
> > > since we have to manipulate the data anyway, putting the extra byte a=
t the
> > > end or in between is no extra work.
> > > For the offload engine however, it should be easier to ask for 24 bit=
s
> > > then 8 bits for each channel as it would return two u32 per "hardware
> > > channel".
> > >=20
> > > In order to avoid having two different layouts, I was kind of sold by
> > > Nuno's idea of having the CM in between each diff channel.
> > >=20
> >=20
> > Tbh, I was not even thinking about the layout when I proposed the arran=
gement.
> > Just
> > made sense to me (from a logical point of view) to have them together a=
s they
> > relate
> > to the same physical channel. FWIW, we're also speaking bytes in here s=
o not sure
> > if
> > it's that important (or bad).
>=20
> The best we can do (if we managed to do it HDL wise) is to reorder the
> data to get both CM byte in a single u32 after the 2 u32 of both diff
> channel. That would be 3 u32 instead of 4.
>=20

We are starting to see more and more devices that do stuff like this. Have =
one
physical channel that reflects in more than one IIO channel. For SW bufferi=
ng it's
not really a big deal but for HW buffering it's not ideal.=20

I feel that at some point we should think about having a way to map a chann=
el scan
element (being kind of a virtual scan element) into the storage_bits of ano=
ther one.
So in this case, one sample (for one channel) would be the 32bits and thing=
s should
work the same either in SW or HW buffering.

That said, it's probably easier said than done in practice :)

- Nuno S=C3=A1


