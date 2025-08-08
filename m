Return-Path: <linux-iio+bounces-22452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA0B1E8A2
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BBC5847D9
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F827A139;
	Fri,  8 Aug 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc38OoL6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FAB279DAD;
	Fri,  8 Aug 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657601; cv=none; b=taZCrgqnDWGX0L3p3TQTPSQ3K9nowKhsUnvzvk2AJD/6JWuFt9mrQgZQ/8Ttly2wqNW6qMsLyaY8CVSfhinzNH7enCNS2LcFHoq8dh/DYG7AhzlUFn0Q/bqIn+T83TlJC5l39rKZS8gJxm89GvLxyMMX1kCi6R+SuOx/np4miIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657601; c=relaxed/simple;
	bh=b9w76l/dF5/PsV8fhzagizQRSQEVBdBkYYuMG2nBS30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc8ZmaQpx6cpniGsO3jUrfcuibhubf6/lKG1zzmORNJ6BcWg1J23TQwxzDZIei/O+d6LbIv2VLAC0y+rJr5QTEJZqSjcJpcENtMEkS/1tBHUS+8k0hyUmq1pFr3ZrEaa4gdhaVfdTB8ZUKNwMnTxA9JWYGJ5v/3jHap/0/JTR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc38OoL6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso3688728a12.1;
        Fri, 08 Aug 2025 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754657598; x=1755262398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbxREPl4QZ5d1d6Rgrjzzhw7jd1PsCQZvw+2e8oVOVw=;
        b=jc38OoL6e+9k6NKGa4bk5nJltKK7zOSgP3CQ25XyRsR0oUA4C4sQMKEqOboRUETDr0
         WvMo2r63nzON5L2ey9c8mTX071S5t3QvlyG4+vXJ0kMGleFi2TOiD8jJvHt1ecDujiMB
         cARcVe7L+K1DZVB0Q329WE62LCg31+bl285LqPto78Ce8nnV8AsTAqhZlHSKz3i5brjq
         WHJfT4PT3aQOCTLHGk5VfjGGPvtYvijvV1YYpL6btCm+D7/CrY8vEU7ToeczaofqhWuI
         0ndGuG0y97lZyn6AnBgKO4xrnHrEwtcXxOaq2ABV3PKkkQ4vHAx6PG/R0MgJn2QfBH4H
         N4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754657598; x=1755262398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbxREPl4QZ5d1d6Rgrjzzhw7jd1PsCQZvw+2e8oVOVw=;
        b=OFe1CIH8fRBo+pFYRtbpfgaCPXdTzmfYUDh5lo9qWhLaHP6Qaun+u0U473GgQbeDiS
         7L+qauRPMXFr0/w/Nn02w6noLNNzVpf6WjDVpCj4cg4RoKADp/OpaGvoCWtQ9U+AzgrO
         7aRp7Ao4DNbsMkxZdlnVLasmdUgb3e7oESxfpXYJka7w+Srtwh38MM9IZpUFPGt5/vvF
         9kftcYzgFUgaRnYI6muFCgmIwM7Ple0Cb0UNVwsZ7urJDF/zUEHrTI+XRTNW8koxSOmv
         98FUw8dp/yGz/Mp4uIWnDIAWSFjBJqaeC7V5xQ5B+yJVHkISFSaxx4pGpCxfCLq0nFHq
         LcKg==
X-Forwarded-Encrypted: i=1; AJvYcCUQnJkkjOVSE4hN5CnZpkEn2asdSw5HkoeUIHfjnnZKYUrHolxX7yzer4z0kOxIPDuLmJU+HLALqiz+@vger.kernel.org, AJvYcCUdlJiDAiHmYEmqh5GtDbqBahAu8Rvqa207AIlVy3iaQV4jR5rYB+S2FbM6C2G1MGBaZZ07KLYTUKIG@vger.kernel.org, AJvYcCXE7H4K4aE5lCZtPL2cgKl8lMm4kPUu2b9zZeLY1uRNfmE0ugu/LxZ3UGFB5x8pQT/7LemRWV4ozkIf1T7u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4y3Rb+FV1IV0aCIdCfzL5TzVdzasYS8YSZjaZb0oM/Q8afHPy
	6QBNyGk4jBzeUKpBP4wBgry+Y3P9ihK46SBxo8L/H1ZdSGjg7IDSLBR9tlHwuqg3NFyUvnAvFNo
	87v8d0JKcDRpet2U8F/Oi1jba1XXbPeNcarHJC9zGRg==
X-Gm-Gg: ASbGncvbEA5zX3tqnPLDWzIZKNnRpq87W6OGW3F7z4Ux+CINgOgFTf/xhFifQuvZL7R
	mhANBhCut7WsHCeoY29Jt9uxbdc2KMLu0vkIp+WfqLxZ2dRDF6Wbnu/1DxmVWLQ20Q1jzOwIhbr
	2BgJ4NKc6DMXZLwduCMwYQ3fPpoJ49ZrczC1PYvWOpYxG/qMSsIVVZ8TUHbjbGB/73Z1QJ8Dy7L
	LkGuTVjaZgYxOvw0BaC
X-Google-Smtp-Source: AGHT+IE6jxqNr85I7ZGkEkmU01kgCQJ33QIEpCnyzxl3L69ABnE2MV9BjbB9Verf2AUEMGXeGEB+/TMaOHdjorzlUBg=
X-Received: by 2002:a17:907:d13:b0:af9:4fa9:b0fa with SMTP id
 a640c23a62f3a-af9c6422244mr234707766b.27.1754657598429; Fri, 08 Aug 2025
 05:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <CAHp75VcHR78Uwgo74n-i3a1sSfDxBwVKWihcnFp5x3d=puAySQ@mail.gmail.com> <13505077-fb36-4126-9767-fead98e01009@gmail.com>
In-Reply-To: <13505077-fb36-4126-9767-fead98e01009@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 14:52:41 +0200
X-Gm-Features: Ac12FXxd7zmXy-o_lQY2wGMCz9cEmsuTSrLvDzDvDqgNvrZCufAdpIwWoJ7-9H4
Message-ID: <CAHp75Vf7PbHPFuVjmK1xPMZxotc81S6FAQkgZ0ETNXSWozaUQw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 7:38=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
> On 08/08/2025 00:16, Andy Shevchenko wrote:
> > On Thu, Aug 7, 2025 at 11:35=E2=80=AFAM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:

...

> >> +       BUILD_BUG_ON(ARRAY_SIZE(st->channel) !=3D ARRAY_SIZE(chip_info=
->channel));
> >
> > We have static_assert(). Why can't it be used?
>
> Don't know. Can you please enlighten me why one is preferred over the oth=
er?

Despite already made changes, I answer to this. The static_assert()
has at least two benefits over BUILD_BUG_ON():
- it can be declared in a global scope
- it produces more condensed (to the point) error message

That's why in general it's preferable over BUILD_BUG_ON().

--=20
With Best Regards,
Andy Shevchenko

