Return-Path: <linux-iio+bounces-4027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8698973CA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 17:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93D628501E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Apr 2024 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203D414B095;
	Wed,  3 Apr 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AWMVjxtY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0B14A4C4
	for <linux-iio@vger.kernel.org>; Wed,  3 Apr 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157290; cv=none; b=sFj8xlJPaTjWdDTHgPXdTbvvHpEgB8qVz1aXlLZyb28Ahi9HyQqWBuZDcy+m82SNQ2OjwqwjBOG3KjhcYb9CipqJRVGFKK8pCXNtlMxwgNw9eOfS69bVGlPXacjod1tUoqxgPMyq2ZiwGTc2H+I9vr/GdUCFspxZSzyYnyMozfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157290; c=relaxed/simple;
	bh=okMqtAJdJt2mKknsEiqIBDifkB1qCYqpQVnmksBqJLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Okjvaezy2yYnyqJ2YNImTqhwcT2geXmbReXGiQaIP1fwRFG1RuKU6i2nSysepuWMf7tm3gIqf4rhl9wrfTWZBtVIcPlw+Ss/N5ETqPaLD5SvRyGNLY8ckdm2IpbsKgy2cc3itZr1gUnYRBCVVKRkNS4MSKpjcRaf+dWJzJtKwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AWMVjxtY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso85519101fa.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Apr 2024 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712157287; x=1712762087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8On6x+LYibbtDP6IBIgF4A+aMOZN1d3uu3/VQOdT6Nc=;
        b=AWMVjxtYCIvAHhRmFKuPHli/mfkYqal/o/qp+19PaRvbbFmF8FkYkGA2fPLgMpKvWA
         8kqExIolNOPOa+SktvatzD5t7ZhxvMR2Lw2DtrmMeBNmF1VKa/2GBht468wdeLW0xrjL
         jWaXrU0VYou2I0vPcWdxKewpfprsRKl1dtr383nVSR3pIHh0Q2xdbjT5KKttA5pI9hSO
         P6kMmAg9jADUF1c+rUoRV1Ook2K1pq7H8dSsM5YnWcQOcwTw7AGMajWrAw1aAPzZ9S+D
         y0Ng0frrV1UHwbNFAYLNLp2GeuWB1QYhWT1iNXeoch1J3KLjeCjnqoukPEQAYBREjnBq
         f0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157287; x=1712762087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8On6x+LYibbtDP6IBIgF4A+aMOZN1d3uu3/VQOdT6Nc=;
        b=dHABM/sUaAJ2liehD2y8l8Rxak/V4EVJwFDMsYsQ8+pMxHpJXmqzZkMASrEX0WTiY7
         sQmiTfjD81CP2X78O8hYDSW27xQLxylszBUuJ8otLvxbnlNv5Kj2wFCEgRZBaSqEvG+2
         J95LAN9MR01tIRgW/Drhi44aBEwMqmJMy44R0jJIDZrBUuvmYUUqVUPlaMFJr0UdKzy9
         3puEGjwSldqlEatdi/bdqYS3FtVaR42DRKDfnVFp4Mk1sCMGjVTIRpSWTP6aJ1YB/uan
         C49uZaYwhGoiS8dltNVL0tG6yX5pYfE8WNeU3FmmEpviHyI8Vl/OIK3SschToTF4V1mk
         glKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKQZyZryNhfGpXiQqDv8YIgD1gEu/wO4zecPlIzdyvd8pD3gFIz0B/yu/r4742GB09T0LdrT5Cb0QSRaXultD+Z4AkH1PXSZD6
X-Gm-Message-State: AOJu0YzkqfZN6BXwLURt4QKZ/HsM0JFEFP4XAiWM/4FSdFV4YAkA4Aie
	/qsX/cFLWsva0H+OpQugTSEW96I/Dlm3oSzu6ksV6Uv20Fni/q3F++3euy4Is6ZA/hthbiR4GN/
	laQrBxIUYb4Lp3ywYfqfa/4z71NoAIBkX3CHrkQ==
X-Google-Smtp-Source: AGHT+IH7piIbVZFBEOcJtVy6rEGRW0U40dXyS1jzVfSYyjpbI87gg+pbV2IGLZoqKJDqmJFZJ6ZDhT4+Zh0znZwRjiM=
X-Received: by 2002:a2e:9ace:0:b0:2d4:1fa4:9eb8 with SMTP id
 p14-20020a2e9ace000000b002d41fa49eb8mr9893359ljj.40.1712157286650; Wed, 03
 Apr 2024 08:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <CAMknhBGJt1TG0-UXMqqCT6nxJKAX7ZbsPF19eeWqwKsXbKOQoQ@mail.gmail.com>
 <0db40597-0d66-4d5b-8165-d9a4c068a42e@gmail.com> <dce3ae6c-6e65-4134-8927-549e9b4afd4c@gmail.com>
In-Reply-To: <dce3ae6c-6e65-4134-8927-549e9b4afd4c@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Apr 2024 10:14:35 -0500
Message-ID: <CAMknhBHLEjtiQVOVODdvfH=pOP656=1RNb=9-rt37H7iowVDBw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:08=E2=80=AFAM Ceclan, Dumitru <mitrutzceclan@gmail=
.com> wrote:
>
> On 03/04/2024 10:45, Ceclan, Dumitru wrote:
> > On 01/04/2024 23:22, David Lechner wrote:
> >> On Mon, Apr 1, 2024 at 2:37=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
> >>>
> >>> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> >>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >
> > ...
> >
> >>
> >> Also, I just noticed that AD411x have only one AVDD input instead of
> >> AVDD1 and AVDD2. So we need an if statement that says if properties:
> >> compatible: enum: - adi,ad411x, then properties: avdd2-supply: false.
> >
> > Already addressed by this:
> > "
> >   # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
> >   - if:
> >       properties:
> >         compatible:
> >           not:
> >             contains:
> >               enum:
> >                 - adi,ad7172-4
> >                 - adi,ad7173-8
> >                 - adi,ad7175-8
> >     then:
> >       properties:
> >         vref2-supply: false
> >       patternProperties:
> >         "^channel@[0-9a-f]$":
> >           properties:
> >             adi,reference-select:
> >               enum:
> >                 - vref
> >                 - refout-avss
> >                 - avdd
> > "
>
> Mistaken vref2-supply to avdd2-supply.
>
> But still, the presence of avdd2-supply does not influence anything at al=
l.
> Driver does not use it, you cannot select it for channel conversions.
> Would a restriction like this really be required?

It is true that it is not likely to cause any problems we don't fix
this but why would we want the bindings to intentionally be incorrect
when there is an easy fix? Driver implementations should not influence
leaving something out of the bindings [1].

[1]: https://www.kernel.org/doc/html//v5.10/devicetree/bindings/writing-bin=
dings.html#overall-design

