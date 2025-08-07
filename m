Return-Path: <linux-iio+bounces-22417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E1B1DEAE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5CD3A3CF2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 21:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6623959D;
	Thu,  7 Aug 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYz+tPmN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5C9478;
	Thu,  7 Aug 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601415; cv=none; b=PYPupb6nommkYV0C3becF9ahAlcR5P/FSRWwCBohHQG5iDzlrApsTosPgreco9bTMsIOJn4bzPaliZLTcCu9G173Jb+L632vpOMCJj+FNc3/inOYshtRKuYE6WmfqxuiRsvqXNgriWT9UTrg4ZcTpi2JhYQfOPvdWdg75/icFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601415; c=relaxed/simple;
	bh=9eUhhK5dfV8YL1qqjnFaB8UyCfsTlH1y3uerlBWSZeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6RfQRer/hHrJE7/0d8ecABCtooetDbQdCDUF7Om2WaUx0Ibk0IT3zlts+Ki4bT3c2df4oFDnbh1WtGhMlu26Arna3HPjykAC4LMIz4YC3A1biV16y+ycph3WhzwIrrHY4vQhlV8Ewv0VMG1OmCK3nnTUkTBZ1IkHzd7jpdnAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYz+tPmN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af937728c3eso426197266b.0;
        Thu, 07 Aug 2025 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754601412; x=1755206212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW5VKuizdz3uQCAD3P3uaQbe86Sv96LJNl4VjT7BKPw=;
        b=HYz+tPmNnTNWjbC25e5lgggvlbEIPbUPX4+NSb/dVTwGnS5KOBlHV+BhQ/4j8D+92s
         CCjUuMthwnbsB22IqudR/Ynd4BDELr0zgiZVuSj64lxXtzw0YZ2igasjEylHKqWG0p4V
         SgKkTBAn/J87FNzOlSbYgTmWrgp5khBuwKEWyVGJ22RIDuZgKdb8uNz2xd14OzogOM4K
         06PClJATN0Sj0XDdLvvEjkHHocqjZ8KQgRcHdUfJ+JoYDmA6MsbEenODPDU/dA7QWk5g
         iVyb54/yBYMEQ5LIt+kaTM/7y22+MoCFHtGOQ4gbFCoSJKfZ73EOfHXon9DO5Rq3bMm/
         Q1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754601412; x=1755206212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YW5VKuizdz3uQCAD3P3uaQbe86Sv96LJNl4VjT7BKPw=;
        b=jTm0+bUYn8pB4Cvwracq6vESvmkD1zIVCUZrv8EfZHngywmejPRFJHESagN5fXPm2T
         dHk9D2zGlU1YqaTJoWsZZSGmn23K9zNgx76EP7iyoaTLMH3S6MPrJ1l0Gkf5lua4u7Wp
         iqKb+AorSdXcyJ0izGCDZQcu3Os6OTLGBh/FA0krGgW60AdxKoCcY9fn3fYbWUG3mu1+
         9yHnMqEsL9JLQCwHuSklaUGeue4V4YBR8s2EI9+z6CHwivgL9vOvIJFleVlg2lbv6K4Q
         pFz7HWULXWkq3gVzrczOJzz2aKOsFw7tWHgMFh+I/p0q0deDV8LAaDUQMrSlUH3bYCcw
         TPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUsyJgCGl96XmFgRsN85hCN0z2/n2ZCwjbnKzfiTa73sKcr9Gf17NEOBPhbcZ6woZJ3hII+unKKTIVy@vger.kernel.org, AJvYcCVcUnSxWv36xyJw22s85TPYoV+7lKey6Xg/7/n3PN37RYhuWFwLnvrcoSZq8AE5t/pn/8Xyjw/bMa+8@vger.kernel.org, AJvYcCWJgtXN8IIH7bQvNbhKw1Pdo7cIApRg8aQP//T4h6idwT5ixQ7bM878twiAnDpEvbEUDEDMs1UKEsKQSA0T@vger.kernel.org
X-Gm-Message-State: AOJu0YzrU83azi89ogkZUXWwyUWAH8D6emn4GWtEHmN9Y3LnXR+6FyHh
	xUERGrT65wmRPDeXcCyBY9R3M1e/isIXD0Lf/OQz3tV5AYntneO/xaw2svma0iaR5UMD1Fagmc8
	XBkD2hMghgSX2plOMMfxPz67YJdG6Y60=
X-Gm-Gg: ASbGncs2KhQkBPwJiW+E01nBjiTNqTdtwITc7q9DoVwSi9RSeDwzS5U5LWWSnHE0dkA
	p8SH6H73haf4diVbgv+j95EHrmstafWL41mencn/22UeNV6nw+8YM8hpnrMCjLMKbT5a0r5k2Xm
	GCn8OQp4jk066MqP1lMfXq3Pa2lKKCf3Srjjxs8IENcW7NaQdM2RQ6DcvxLSrRh6eN+1C1S7rPE
	fxH9g7EVRtg0raXOB5Q8sKnuFtIgK0SRCGCOyc/QA==
X-Google-Smtp-Source: AGHT+IF5mbNBW94ntEyvRzUawU+yBnKWoEcM/OnUqQN7n9Ea/8VYGKZD45os8JeDIaa6K+ZOhjnNz0shSTGeBPPSwns=
X-Received: by 2002:a17:907:7e9d:b0:af8:fded:6bad with SMTP id
 a640c23a62f3a-af9a3e3e611mr529635666b.18.1754601411885; Thu, 07 Aug 2025
 14:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754559149.git.mazziesaccount@gmail.com> <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
In-Reply-To: <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Aug 2025 23:16:15 +0200
X-Gm-Features: Ac12FXykDcbCUdUI9iHmPN3WsJWpiJjJXg5mSCfo0Pc5LWH32gtNwUrRRah3vi4
Message-ID: <CAHp75VcHR78Uwgo74n-i3a1sSfDxBwVKWihcnFp5x3d=puAySQ@mail.gmail.com>
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

On Thu, Aug 7, 2025 at 11:35=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> The ad7476 driver defines separate chan_spec structures for operation
> with and without convstart GPIO. At quick glance this may seem as if the
> driver did provide more than 1 data-channel to users - one for the
> regular data, other for the data obtained with the convstart GPIO.
>
> The only difference between the 'convstart' and 'non convstart'
> -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
> channel's flags.
>
> We can drop the convstart channel spec, and related convstart macro, by
> allocating a mutable per driver instance channel spec an adding the flag

and adding

> in probe if needed. This will simplify the driver with the cost of added
> memory consumption.
>
> Assuming there aren't systems with very many ADCs and very few
> resources, this tradeoff seems worth making.
>
> Simplify the driver by dropping the 'convstart' channel spec and
> allocating the chan spec for each driver instance.

channel

(you already used 'channel spec' above, be consistent)

...

> -       int ret;
> +       int ret, i;

Why? Is 'i' going to be used to hold a signed value?

...

> +       /*
> +        * This will never realize. Unless someone changes the channel sp=
ecs

realize --> happen

> +        * in this driver. And if someone does, without changing the loop
> +        * below, then we'd better immediately produce a big fat error, b=
efore
> +        * the change proceeds from that developer's table.
> +        */
> +       BUILD_BUG_ON(ARRAY_SIZE(st->channel) !=3D ARRAY_SIZE(chip_info->c=
hannel));

We have static_assert(). Why can't it be used?

--=20
With Best Regards,
Andy Shevchenko

