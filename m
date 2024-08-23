Return-Path: <linux-iio+bounces-8713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D350195D21A
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 17:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579F91F21764
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A544189535;
	Fri, 23 Aug 2024 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rGt1E5cn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76F1885AF
	for <linux-iio@vger.kernel.org>; Fri, 23 Aug 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428486; cv=none; b=gbwjdN6XU1H8BIV0uml1kEXxthWUspayhBcMD5U6FWDW/uAmuyGs5wzJvGqFMVbZcTkR4eGbz4Unir1IdCPTlrZHPtirUd2Iydit/tJe5f6rvPqdkmgEsugJzRYa8pFLouX2cBvaxrBr0iQ1dZt9nCiNBZWBCM400+qLQqrjU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428486; c=relaxed/simple;
	bh=HtH6qdjMIdNtGGtymO0i5WzD6uli6CQK2z4uzaNG4FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1Xt+nF/TQ/sPzGcxsdJN5uZkFf0JOlVFaNbikQuDVC3a2x92mvkdwtpZKIoZbPHSMDmxRf1w2hqvpvAkgrtYHG0+dxOEqzEw0BheXTJB90ysyEaQACwOx0uJLHPkVfcREljPXzyJNKrirz0eAtiv5c19IP9Od6WHmEhE9wCO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rGt1E5cn; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-498d7ab8fefso814375137.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Aug 2024 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724428483; x=1725033283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtH6qdjMIdNtGGtymO0i5WzD6uli6CQK2z4uzaNG4FU=;
        b=rGt1E5cn2AxIdVu6Tsk37EKwsewAAstndYElxOF86jIeDZtfyzwfWTNE+vWgHXIzaD
         xnvYxFW13cYqqihZC86i7UtkxWwARXNcmdo+AI3r/XXrZnOPhcMiTh/ZHJWOwGA8k3c/
         kcHIQ2cB51pE3gtBH0FLYtqHLSKLcMXp6o0blRxgdJ9GhgwzdkzexUenMAHBleFcPUmG
         t6EdMzzV46M5CZdX3bvauNDhAN3dnj6/zIITNkyzuNhcXJeAo+Zbi/WvZdU04DyzHpy5
         n0FJwrho670O2swnnUtcCH2VDMkE1iIzN6snalb4XQweFir3TlB1SSnr4EbykgKDJDFy
         SNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428483; x=1725033283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtH6qdjMIdNtGGtymO0i5WzD6uli6CQK2z4uzaNG4FU=;
        b=px6Za9neHvIbw5uR/JncKgprOTdR4dt/jdhSJDBKHfQlzozZB0L1kN/eSvk1U8AeoZ
         BSqKWadZzqHRtkOgEQzFpkGjfEtjXIZFimRPuECI+4Ld5o6WlsgceA8zGFg21ENl+96s
         GDj6lCBpJQi5CJwzM892ujS6iGCjfHga8J+viXKOpPxqHFJb94fWjQFHDcSoWhIx7zwP
         o5BtgBioU0LV85Prcb7EOvZlgENiL0t0zqA1n+jzFZWWoGFv7bbu9pj4g9/v4B+YQBnV
         bduP+/3B8P6aqH3z5iH3/UfEyB7wpy5UHnkVFhihgMXy/2RE6yJsku+aeYDpM/4rzB5F
         fj5Q==
X-Gm-Message-State: AOJu0Yxg5bzsuk2xbsuCk6kceSZpMQpQiQiuAelXPMKPYmyjw1vQ0ZAo
	BqxBepX/eJZ2HVzEsv2MzrEtyUdtuXfIyt7+I4jBSr2k0aoWiNalVAxPIkLpJSLTWtUe4uNNEtT
	1RyYL0QWKfYbBTIvv3onoaiQgMfF/vk92GTa2KQ==
X-Google-Smtp-Source: AGHT+IG1JZThU0IKB0v806PR64JcpLViiPaNVXo5A6m1YTr+RoSCgI0tMbvBD/tvM/LTvUHRsK0DDSy3l7BR399yJcQ=
X-Received: by 2002:a05:6102:3907:b0:493:ce48:a2ed with SMTP id
 ada2fe7eead31-498f4c4190amr2791122137.29.1724428482611; Fri, 23 Aug 2024
 08:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819064721.91494-1-aardelean@baylibre.com>
 <20240819064721.91494-8-aardelean@baylibre.com> <3c4edf41-fd3b-4258-9b9e-a81b25568403@baylibre.com>
In-Reply-To: <3c4edf41-fd3b-4258-9b9e-a81b25568403@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Fri, 23 Aug 2024 18:54:31 +0300
Message-ID: <CA+GgBR9H66u0mB-cQt_6tT2kh9TCW0Bm_BiHEUyVGvmGHBGEJg@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: adc: ad7606: add support for AD7606C-{16,18} parts
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:33=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 8/19/24 1:47 AM, Alexandru Ardelean wrote:
> > The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
> > The main difference between AD7606C-16 & AD7606C-18 is the precision in
> > bits (16 vs 18).
> > Because of that, some scales need to be defined for the 18-bit variants=
, as
> > they need to be computed against 2**18 (vs 2**16 for the 16 bit-variant=
s).
> >
> > Because the AD7606C-16,18 also supports bipolar & differential channels=
,
> > for SW-mode, the default range of 10 V or =C2=B110V should be set at pr=
obe.
> > On reset, the default range (in the registers) is set to value 0x3 whic=
h
> > corresponds to '=C2=B110 V single-ended range', regardless of bipolar o=
r
> > differential configuration.
> >
> > Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.
> >
> > And the AD7606C-18 variant offers 18-bit precision. The unfortunate eff=
ect
> > of this 18-bit sample size, is that there is no simple/neat way to get =
the
> > samples into a 32-bit array without having to do a home-brewed bit-buff=
er.
> > The ADC must read all samples (from all 8 channels) in order to get the
> > N-th sample (this could be reworked to do up-to-N-th sample for scan-di=
rect).
> > There doesn't seem to be any quick-trick to be usable to pad the sample=
s
> > up to at least 24 bits.
> > Even the optional status-header is 8-bits, which would mean 26-bits of =
data
> > per sample.
> > That means that when using a simple SPI controller (which can usually r=
ead
> > 8 bit multiples) a simple bit-buffer trick is required.
> >
> Maybe it would be better to just use .bits_per_word =3D 18 for the 18-bit
> ADC and not worry about "simple" SPI controller support for that one?
>

+cc Mark Brown for some input on the SPI stuff

I'm generally fine with choosing to not support SPI controllers that
can't do padding to 16/32 bit arrays

But, at the same time: would it be an interesting topic to implement
(in the SPI framework) some SW implementation for padding a series of
18-bit samples to 32-bit arrays?
(Similarly, this could work for 10-15 bit samples into 16 bit arrays).

Apologies if this is already implemented and I missed it.

But if there isn't such a functionality (padding done in SW inside the
SPI framework), then I could probably spin-up a proposal.
I think that the functionality could be spun-up in a separate
patch-set/discussion; and this patchset would just go with
"bits_per_word =3D 18".

It could be done as a new field in the "struct spi_transfer", or
something else like "spi_pad_rx_to_nbits(struct spi_device *)"
Or other suggestions welcome

Thanks
Alex

