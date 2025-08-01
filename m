Return-Path: <linux-iio+bounces-22176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23BEB18917
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 00:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD335AA462D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27402264CE;
	Fri,  1 Aug 2025 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipvrn3ZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA488207E03;
	Fri,  1 Aug 2025 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085759; cv=none; b=fB5h9yrFU4QmExzbEbXIy9On2nyX28J1Ff5bV7Dj8kYQ0GOw2Q24L0SRtQhBdhNGtArXquBwGTNfZ0UV0RYadAWraiGX+sdgD4+aQHFXe7vvAwqkWwjqimF3uHs7s7O9a4+U4oYGGkL2IyzJTHtNxuxgVqjxF4dWYvDhSQtoTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085759; c=relaxed/simple;
	bh=6shhsmOa9537nSzALzaClYTzvSQ041r/HPWfbFTrzu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXKYUDSUGgpRnf5ojHouu4tXMZLHSWtVclRXwWnmi7uV/aCiPrPdZV/a3JB09dUo9xhY6TZGotlQMB9SpSUY6O1z5zCbKSsF61vOLPW424UKKxfo5wP1vnlVV2OyesbAMwol0Zl2iZGld5tu/VJ+CumxMWmmbqx9SuBLNZKpH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipvrn3ZA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af93bcaf678so100808066b.0;
        Fri, 01 Aug 2025 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754085756; x=1754690556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6shhsmOa9537nSzALzaClYTzvSQ041r/HPWfbFTrzu4=;
        b=ipvrn3ZALX7GrY3ZFvq50CivTK1DkI4Dn1Pj5lZ5tShASvoErQiAoSn9jLaf0IH0tl
         RczuRH87s+Qw5AHR/YkED8nOxlTVQb4yDSfLMkUGb0RTTQiiWun4UsfuFdRo58dB9v9t
         Rl5SWaS1u/nzwhsTc58tqPXbLA3hE9emfk7gOmgzxBHHdvMToz7hfb3bWotWVvwnElMs
         U7BJ2uKsl7/Is3XYKBHmlHpl3oro521Ncb+fGSNmNpfQnmkobKTYAumllB1K5DAvZGeC
         IGA/pP6zGwKgC6cOAt5LGROYKQTl2cugol+Bc5BqQbmyRw4tT4uU6KTO5kMIZN18LGqq
         gAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754085756; x=1754690556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6shhsmOa9537nSzALzaClYTzvSQ041r/HPWfbFTrzu4=;
        b=mhZk5LoI2vDjjgDzj1Ay8sW8Rqcho9EPvp88o2F+R894+utYScITsAiq3xO31pwoUE
         SaJJ6d8Yuw1N7wndkzhLUgmHwakp6/TC8IsxjHLsfqltfHGO543gA3gtYV/es597VmqY
         7tv/oSOCvGYT4Xb/M79gxZOhNu4AhLt+cICkvN5d3qC07lEhiwOhWLRFHyz+yUng54zN
         sLfBFr9ibNueOJhBu6tLjAf1eGMsywPcpm6lQ+XraNE94nOn+Hws0DY7wleyKnGc58pY
         ygu5mJUccxJ37+ueljDyfdmAo28jwH1VrDxXCokOSbn4ST4YbHVp8E1KtOlP5SinX8jB
         KT/A==
X-Forwarded-Encrypted: i=1; AJvYcCVrf1ybnSRP5u7FLjb3U60kYMZc8qB8lOxQkPecDqTAgWh5RqMiiDwlukxjyIwI8Ye7aL7ZcYKJvcZMwebn@vger.kernel.org, AJvYcCXGRyjDP7Ap48D09LaxrHp1q5as+fdl9tbzGiqOyRmn9yjiMGuklSK3GU85NefVItD4k5I9ip2d3bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZt9/KWvM4iU8/mWvUi3jK3o6KpBt22XIvAe0h1xTVgUcQ69B/
	gg70sCiHwVXYgFiGTQ66/AAZgZGgwuCswn+MfhSfNi7DtRKjBE96ZcqJKYn5pNMs/xga5ACu2Vh
	TT2dadnH4kF4UCGD+sG5nhZ2wFCxZ2UM=
X-Gm-Gg: ASbGncvPNi5cy2etDZ1FBJotFUH617FNMh+VrEyoHcOSPYJwoBeAWNElgRypDq/MasN
	CK3nuGvNrHjABm3iJH02o6ZKHK46qniBgNHaDYi0fhz0XC01RLhq5D2KBZwu5TCutPBNYkNOcKz
	EIhyeCzU3RlcOOkyxvGCXQX7Q13nTOUsF1x6LztM1P5+ST1HcmQmv2qtTEJOTEwf4+PpPrN8h6P
	ATlBG8Log==
X-Google-Smtp-Source: AGHT+IEOrjdBS8qR0cLal4YE8OYocdcEucADefhnUSyEUlqAphqAR6aw+RfmQdz332wyWSHXM7HhYlhvxMmpogk/5mA=
X-Received: by 2002:a17:907:7f0f:b0:ae0:db23:e3e3 with SMTP id
 a640c23a62f3a-af940017c8dmr157691766b.16.1754085755835; Fri, 01 Aug 2025
 15:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754041258.git.mazziesaccount@gmail.com> <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
In-Reply-To: <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Aug 2025 00:01:57 +0200
X-Gm-Features: Ac12FXy2U3nHPM-c1Tv54OHI2hVcb8efeg1MS2GnbFr62Fx-8ffRLi45Z9KvkoY
Message-ID: <CAHp75VerC+m1XMpZFO6dLp+0HdB1+Xn47on38Mg5AXfDYwWd4A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] iio: adc: ad7476: Simplify chip type detection
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:07=E2=80=AFPM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> The ad7476 driver uses a table of structures for defining the IC variant
> specific data. Table is indexed using enum values, which are picked by
> SPI ID.
>
> Having the table and an enum adds extra complexity. It is potentially
> unsafe if someone alters the enumeration values, or size of the IC data
> table.

I don't see the problem here. I like the part about converting ID
tables to use chip_info instead of plain integers, but other than that
I do not see how enum is worse than the split version.

--=20
With Best Regards,
Andy Shevchenko

