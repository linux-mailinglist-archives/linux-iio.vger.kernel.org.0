Return-Path: <linux-iio+bounces-23425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5233B3C7FD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 06:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BD11BA7475
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 04:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA2427BF7C;
	Sat, 30 Aug 2025 04:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4buTszi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1C21B199;
	Sat, 30 Aug 2025 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756529702; cv=none; b=PuXCoigRkiPTaV5GsaGnJp3KEG0CSYqJMVOWDccG4xSruzO2hRAPUOsh+VWkTk3njUtrx5KmFHzn48asTI0lBpkLQiFZeBAhsQ3OSrCCg4NqZj6XY2wtzm1roHbhcEay3T9UDcbBcUFNXfotyjklDi1hPZOUsfxRVAQaw78/2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756529702; c=relaxed/simple;
	bh=PblzP8bpvQ+dLTi4ROYQbeGB9S4128ks9eaC/YIJxJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa8325teicEabi0LMpcaKDM4LCuVUATAEJ+8pxCn7PUb1vu8zPSTXiGeCmTrtGjanV3MiwMu3ugkpLefdWWIBV1O2a1RnE2vslWa88UzbRbPpj4FMfQcq7P+BP13ZIbz/dux9WfzjO5K8768tiZEhap/f66lWI54udtfwX2glc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4buTszi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb72d51dcso405695666b.0;
        Fri, 29 Aug 2025 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756529699; x=1757134499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+yI5stLOIjwsXcdEiYs3bjB2p7CosaRO1p+h70Op2g=;
        b=I4buTszimWuv8rveKFArOLd/pcB5kqhuC2grgX0w/rvqNeKjapR6kW4qp2WIMCqSCc
         oBHuaEbrN/YEZylCs/tgtCcRWffwv+iLVdoZ2i7EH2MVr5ZXFPhRF2WITho8QuB4lVhW
         eytcMjAYNwFBJBGQSrq0VaO6KTWP0xxvfeDww/9WWb+jhkzhzRMk+qLJmFgZKEolp0+y
         GUIMOO0kADWFvimISnfqKtWmDipA/Eam04675XCZ398Lv0GAL/mbHJn1HWVuGnZh4dHF
         NOwuB8h723Gvho1ifQgPSE9sFusvv6PnZTkPmx5nto4WhZN2aiGG1uH6Y42txGG3LzkM
         R8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756529699; x=1757134499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+yI5stLOIjwsXcdEiYs3bjB2p7CosaRO1p+h70Op2g=;
        b=X9+3KxpZgnhZPUKp51rMBNVzlPkBbcugYup1aPrF16RAFtHRWVG7UovDUonOS0PvnL
         9LFJHhUleRSTBW12YI+Uuzdexv9OhrilJ7s/AaA12atuNwx2BupN1MXClDtmkj8VVi4H
         wXabOYHcGbgYayRxrfyYftyEAFtA7iOjXS9ByvrtCy+rxObd3Ba+oYxScwkk8FwPE7MZ
         K0kKvTaW3+KGft93x/rbPO7F7y7n5OCMXrxXY60+FD5B+H6YjC31/uwRrc2Ed+8GcLIX
         e4jPx+Am+NnXH9rO9POArMh21uSCCeW6RJ5ZRqzZFCqWGz1MCkEkFZnZIO8RIM0P131M
         ADcw==
X-Forwarded-Encrypted: i=1; AJvYcCW1TzOVSGQFIEzTssjJBq/xb/N4EIOO92OqkDICHj7qYcqxzjiiL/3F+Lgp1dEsnYtSEOyzYQXRLKl7@vger.kernel.org, AJvYcCWfIGS9qykbuCfBEHxAUdFrY4wcXtD/jnvlAswcdgATSuu/GI+lg5ZKk9yAK87rfd5C2MmTNVwAgfLRPEpO@vger.kernel.org, AJvYcCXFfMm1HvsMICX8brhs6YBDNkj9redkRf1hHR/Oq4xmklNXUsVnH6/wGn0CQoFmwk9PxtEl8yX6wfPu@vger.kernel.org
X-Gm-Message-State: AOJu0YwNO9n4AZx22YFqq6rVwhNybIyVBp1VY8rWb8bBcsrwjWYTNfRC
	JZDfeaPi+IGEo9JaGP1OIOQ7SPdGGX3wt0Krkb63ZcnMztE96N69D17L44WNNkznB/Xz6J5pNTI
	2lB8hz2W0knaz3vlvAaG0NBgEQmz2xQESvdl+HCwYUA==
X-Gm-Gg: ASbGncsY0q/UMSjcTwMfhlP+EJh3GtjUyvY5T3V9o3738XYeTtsL5rwDc7MfWgv9oSK
	F2KkYQjGnTZAu/qg6bQfpW9QzfrP4RLPLGIVg9BX/k6Ej/U3Tfwha5sUKY9dbfZXSMOB5T0e1pu
	sHl512E2Gk6JpS/AYfi0q2kCTXG/ymjA/6rNfewlCDJ+HJ8EoeBMHt+z9Qv6ntJ7DAV+safcLPb
	ef4S1Nd8aExk/+wuQ==
X-Google-Smtp-Source: AGHT+IFj0e6R7gW2dq3SzRGVuI1tLR8avZykV/RaQ/6DCp+U4IEsYzRITqaeMNPY0l+hpisRYcj9AGWI2otRn873in0=
X-Received: by 2002:a17:907:940a:b0:afe:f8cb:f8bc with SMTP id
 a640c23a62f3a-b01d9732721mr80627866b.35.1756529699312; Fri, 29 Aug 2025
 21:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824041013.9872-1-Jonathan.Santos@analog.com>
 <CAHp75VcGG_h+wpo7hHL=ERYqbrvvAaufwPAYBsEbRn3dB8-dfA@mail.gmail.com> <aLH7XNuaZ2CkQVWo@JSANTO12-L01.ad.analog.com>
In-Reply-To: <aLH7XNuaZ2CkQVWo@JSANTO12-L01.ad.analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 07:54:22 +0300
X-Gm-Features: Ac12FXw4AD2S_KJ5yR8SUzJlz6H_1uxrxXZpHKycQS1wQzd31-mvrNC149lZJY0
Message-ID: <CAHp75VeP=G1Pa6=Q1gok5+mA7grDWrgAEM_m8FqjAwme==jt-A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
To: CAHp75VcGG_h+wpo7hHL=ERYqbrvvAaufwPAYBsEbRn3dB8-dfA@mail.gmail.com
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:11=E2=80=AFPM Jonathan Santos <jonath4nns@gmail.=
com> wrote:
> On 08/24, Andy Shevchenko wrote:
> > On Sun, Aug 24, 2025 at 7:10=E2=80=AFAM Jonathan Santos

...

> > > +       unsigned long denominator, numerator;
> >
> > struct u32_fract fract;
>
> Problem is that rational_best_approximation requires a unsigned long. I
> could do:
>
> rational_best_approximation(fract.numerator, fract.denominator,
>                                             INT_MAX, INT_MAX,
>                                             (unsigned long *)&fract.numer=
ator,
>                                             (unsigned long *)&fract.denom=
inator);

No, this is not good. And it will overflow. See below for a better alternat=
ive.

> But I don't know if this is the best practice.

The best practice is to add a patch to extend that to cover unsigned
long and long
https://elixir.bootlin.com/linux/v6.17-rc3/source/include/linux/math.h#L122
It's just a couple of lines which I review and acknowledge
immediately. (Just make them a precursor patch)

BUT, looking at the code, I don't see that people use the same
variables for input and output (otherwise it's also considered not the
best practice, for example, in the cases when input can be made a
const).

That said, the patching math.h is optional, either way, make sure your
input and output are different variables.

> One way around this would be to represent the gains in fractions instead =
of 1000x, example:
> then we could drop the rational approximation.

I like the use of rational best approximation. I think it gives a
really nice algo for simplifying fractions.


--=20
With Best Regards,
Andy Shevchenko

