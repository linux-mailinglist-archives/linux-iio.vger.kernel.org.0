Return-Path: <linux-iio+bounces-5014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB598C45A9
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD471C22681
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E0F1CF8D;
	Mon, 13 May 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uMpModaY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027E82B9D5
	for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619993; cv=none; b=bv3dP0m651ktGVtVbuAbrta3NbD/t1M8ld4kwjnDLzbwV2KS+qiR+Hf2+g1COokksQxwpZLKbNb6Lu+mC/ol3ndbOLndSSNjssWUNu4RL2sh48kYpxBk9S6DJFoYDHIYpJMmJZNH8zKYjGT/ugkojP4Ebcq8mrcbt1Mg+Dormkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619993; c=relaxed/simple;
	bh=+P2SBhCjt1cNR4Hf9i6Gn7yMnwDDxmC4jAga89KBFuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcfOSZbCavLmzFiOrhtaqoXfaJxYTluEnJ8LYOOEaW1GNOPl9oEZldb4huHD9rK8+EmOF3hIAOoqmLc1QQb8tSkybOOz8hv6MDkaUTvNIeXUdcdLi2ZBRj+K3aj0C/pLUdsQPY0jhve+tIarTG4+6169buSHTPc7ChNVYolvgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uMpModaY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e6792ea67fso15439891fa.1
        for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715619988; x=1716224788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXw985lX5WlJQmTXNpCIqA41wwGetKb+YHxlJsQLqRM=;
        b=uMpModaYv/H/oI7+De0gNVizuEccAKWldn0kSElxpz/rh8aMUeq/+9KzwaYCqX8ri+
         211heG2kYg+4Nk17DCqrHBD3Xh1SVC0w/0IkVv/llELypli35hjvisBLxQeC5d4YEif9
         lUIeeqJyW7u68NTJjuXdOTvIGljGo/on5VrpiE+OQvbzSSzagU89cgaaFgUYlCtdjpQd
         qprrFIBa4x8Ze1Mx1tne3tQeVP7BcCmbmT8wuemhOmFs/NzeW3DuekXkdpC19A1OsE/x
         DriXu0c4jcxfCLe7fmn5QAUuN48au5ZzZKJZdSlEpHLAS6n5rhBRQoJz3dK1F0xmaxVt
         0oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619988; x=1716224788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXw985lX5WlJQmTXNpCIqA41wwGetKb+YHxlJsQLqRM=;
        b=m5B/S/9++UpRp87DsQibj6AXUI82DEY+HIJ3ZAVKaon1T/3lQDTC2qABwKoIJpTGjT
         e0PCSI6uRKmDfYxqEd6RTo0u/7+Pc3c1wbpdJ6ZmA+KoXRAb66ea3kZKXI9D6cJbVv06
         +Gcm83GjVVvB8Lpn5tmtugIyI+O3Wqxpf4+ZTjZ1Tn0QoCfuvbQA9HWjQfGLum7GA66v
         o5J5ZKORAwWAQ+sYtR9OmDHbg/+y9SixvVelN/U+gSjzirIyb6sxHbb/l9CNCbHeA+bh
         efsQpvGLGrWr64PF4t+N8htIuZTZYg6qwxrKcxwCYcQy2k6v1FqaWFC+HpbtUtsnW2yF
         VBoA==
X-Forwarded-Encrypted: i=1; AJvYcCV1C8REK5qAtr0Ffu32tR0zCWsQ5PB5P8tH80PPv7dVaC2qXvCmRycFpuplBwHI5hIkezcScvG4y4tgg6LMoVbeVpTxENV1qU7y
X-Gm-Message-State: AOJu0YwxIBap4BLSzTLcra/xyvkN+lEEag7H9c/zdh9m7nZw+5r7MxCl
	cAwQWo24rU4v7IaQBNlOd7fgvCEIW5hRKxKBIZtwyZdTIH5d1cDBmjbgiBkfEXvCrUm4+LHIln4
	W6iYr5s3N53gy+KbNIupGj0SNEVro+4zVXxyHEw==
X-Google-Smtp-Source: AGHT+IHKzXmraEEpr9cm14X7+52nWL86ByTUDO6GdlPQ4N4YO+I2wY0fIqMJ7Li7S33/GHOlNNDE8KzdgJFvMG4euIY=
X-Received: by 2002:a2e:b1c5:0:b0:2d8:8eb4:11a6 with SMTP id
 38308e7fff4ca-2e51ff5ce50mr63520551fa.12.1715619988132; Mon, 13 May 2024
 10:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
 <20240510-dlech-mainline-spi-engine-offload-2-v2-1-8707a870c435@baylibre.com> <20240513-headsman-hacking-d51fcc811695@spud>
In-Reply-To: <20240513-headsman-hacking-d51fcc811695@spud>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 May 2024 12:06:17 -0500
Message-ID: <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
To: Conor Dooley <conor@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	David Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 11:46=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, May 10, 2024 at 07:44:24PM -0500, David Lechner wrote:
> > This adds a new property to the spi-peripheral-props binding for use
> > with peripherals connected to controllers that support offloading.
> >
> > Here, offloading means that the controller has the ability to perform
> > complex SPI transactions without CPU intervention in some shape or form=
.
> >
> > This property will be used to assign controller offload resources to
> > each peripheral that needs them. What these resources are will be
> > defined by each specific controller binding.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >
> > v2 changes:
> >
> > In v1, instead of generic SPI bindings, there were only controller-
> > specific bindings, so this is a new patch.
> >
> > In the previous version I also had an offloads object node that describ=
ed
> > what the offload capabilities were but it was suggested that this was
> > not necessary/overcomplicated. So I've gone to the other extreme and
> > made it perhaps over-simplified now by requiring all information about
> > how each offload is used to be encoded in a single u32.
>
> The property is a u32-array, so I guess, not a single u32?

It is an array to handle cases where a peripheral might need more than
one offload. But the idea was it put everything about each individual
offload in a single u32. e.g. 0x0101 could be offload 1 with hardware
trigger 1 and 0x0201 could be offload 1 with hardware trigger 2. Then
a peripheral could have spi-offloads =3D <0x0101>, <0x0201>; if it
needed to select between both triggers at runtime.

>
> > We could of course consider using #spi-offload-cells instead for
> > allowing encoding multiple parameters for each offload instance if that
> > would be preferable.
>
> A -cells property was my gut reaction to what you'd written here and
> seems especially appropriate if there's any likelihood of some future
> device using some external resources for spi-offloading.
> However, -cells properties go in providers, not consumers, so it wouldn't
> end up in spi-periph-props.yaml, but rather in the controller binding,
> and instead there'd be a cell array type property in here. I think you
> know that though and I'm interpreting what's been written rather than
> what you meant.

Indeed you guess correctly. So the next question is if it should be
the kind of #-cells that implies a phandle like most providers or
without phandles like #address-cells? Asking because I got pushback on
v1 for using a phandle with offloads (although in that case, the
phandle was for the offload instance itself instead for the SPI
controller, so maybe this is different in this case?).

>
> > I also considered adding spi-offload-names that could be used as sort
> > of a compatible string (more of an interface name really) in case some
> > peripherals may want to support more than 1 specialized type of offload=
.
> > ---
> >  .../devicetree/bindings/spi/spi-peripheral-props.yaml          | 10 ++=
++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props=
.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 15938f81fdce..32991a2d2264 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -113,6 +113,16 @@ properties:
> >      minItems: 2
> >      maxItems: 4
> >
> > +  spi-offloads:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      Array of controller offload instances that are reserved for use =
by the
> > +      peripheral device. The semantic meaning of the values of the arr=
ay
> > +      elements is defined by the controller. For example, it could be =
a simple
> > +      0-based index of the offload instance, or it could be a bitfield=
 where
> > +      a few bits represent the assigned hardware trigger, a few bits r=
epresent
> > +      the assigned RX stream, etc.
> > +
> >    st,spi-midi-ns:
> >      description: |
> >        Only for STM32H7, (Master Inter-Data Idleness) minimum time
> >
> > --
> > 2.43.2
> >

