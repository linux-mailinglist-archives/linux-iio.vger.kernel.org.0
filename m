Return-Path: <linux-iio+bounces-11692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACD9B7A7E
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 13:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542E9B211EA
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED1E19CC16;
	Thu, 31 Oct 2024 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfgPyGXp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926C14831D;
	Thu, 31 Oct 2024 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377724; cv=none; b=eB+JICZKM1RlAPtr0iJINJCUdX+KFSih5B/AXHqE5HKP8o1hQK/jNIce+zWuVnjTU2vQB03zD3orc5nnKYxyORG7YUG+iTvi9A3TGwZaoqDH+0D0pBqUUXe3HEzeiOBKZLU5nPdvK6qs/kQkPounIRSjOtXqwdA0PfhdorJ+1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377724; c=relaxed/simple;
	bh=COHtKEhdwDfMKAwGFRKy2mayNeckWQPMt9AH5PbUzjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WStG2oIAArdWEmtHkRhOD5ep0oMg9mm/gWgDR/17X2VvnAC2sgNbIpoASDyodU3qJ/I7AtPnKtGq/Fe3FtfYx1zBckcsi7v02e1/im0N7icf/gccvCFnAZh4rb+L/3XGY5nbEPEtRe5PyDn0JoQxR53/GHBBaroKXJhAocm1plc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfgPyGXp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431ac30d379so7290025e9.1;
        Thu, 31 Oct 2024 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377720; x=1730982520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=COHtKEhdwDfMKAwGFRKy2mayNeckWQPMt9AH5PbUzjI=;
        b=TfgPyGXpMC1i5yu2bEe11cOE2iZ8mWBqgvud2ZXR8bzBPq5PO1BnETHWHKKOnSUWdJ
         cdo7wuD7AFx7eObg+GUmiYS+m3yBLhqPHQV/60TXSCDELrS9tw3tLwr0OuGlJHa2cgsX
         iF5Yxhwea86zFo2CN/CMLW6DSBzE5XLV6mCMuqQHptc/TOXxprmC4myP0Px9UcLbDfTF
         ILvaM6I0191MbwfZdD/i8bn05WFToVxtfsdMtHnI4ZpQWdcRwEwSAR8FYBQKvosB6i4N
         K3FG7ym2NRL77KR7t9d/5WzzQU6JXySRh6m1FG3EpLQpGme0aibezCickzpX4xNGPz70
         Cr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377720; x=1730982520;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COHtKEhdwDfMKAwGFRKy2mayNeckWQPMt9AH5PbUzjI=;
        b=e9wBJjMI7S2Yybk66hEwJ6I54F1QB1f/OYJyoBqzQtbNAymfxekvLfe3Bxj/Jtd4Mz
         MujT6hytr/Ms2ulKM2ysLrtFF5Q2NpADkg2icHuY5xliALzlwGf3jF7MsLovMA/P4sYy
         jMIab+FM0Fs7ObseOaupf/uRTptoG9nOQfe8WIONComts2R7uuavpPwkRRdvYfWwuJKN
         bb/OnxNM888l4Mn1ew/NLorLCrK0MCstJ4YovvGS+ImR5ynvkD5pVGsrrnCzrTTEcMzV
         iFvV3e5eh5urQqqycNxc0GozXqtP3WsQOSc5bs4cI2QXWTPFzc64cK7ule5hY79JW7IC
         YxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYRUnRC2fgFbP36veWdeFrtoS1OHSRfu8UVxkcmJDCqe+JCLP5YIZW9GzWPC7fa4NNpWM4+sOytXOa@vger.kernel.org, AJvYcCXnf5SLr4ZM6Jaassoofsb2EpoLduQocphqyT0IR5aNyY0SDIL6Y4cECJJdEXWKImTCjPZbN2DjnhXI@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLOVoD9LAxkXdANHYAB+xppFJtN9ClfFPux+eKY494kGRNq5f
	+WKaMqAd0DFfgUfnZ6DNOlx/olllUNKCMWzIUSTFrxjNaMdXmRGv
X-Google-Smtp-Source: AGHT+IH6SzX6eS9ZqhvWgHjqhxNBZDRVINQzZiCLhro6kw1u+seP2+O9n8q/Bgtgrdx4AvAlLyFhBw==
X-Received: by 2002:a05:600c:3514:b0:431:4880:3120 with SMTP id 5b1f17b1804b1-4319aca55a6mr150311295e9.11.1730377719847;
        Thu, 31 Oct 2024 05:28:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6983f6sm25656565e9.45.2024.10.31.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:28:39 -0700 (PDT)
Message-ID: <4232185aa896721ac4b3bf25a7ec6025cf6b883d.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for
 reading irq status using a GPIO
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,  linux-iio@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>
Date: Thu, 31 Oct 2024 13:28:38 +0100
In-Reply-To: <1de551c284aaa9f4e91f91fa0c4ac570c8b7f2c9.camel@gmail.com>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	 <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
	 <a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
	 <20241030204429.70cdcf35@jic23-huawei>
	 <y3amm7yj37lravbk6fcwze3jlllp4extmffqtx4jaoeqjt6uyl@nsdrcy2dk5kr>
	 <1de551c284aaa9f4e91f91fa0c4ac570c8b7f2c9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-31 at 13:05 +0100, Nuno S=C3=A1 wrote:
> On Thu, 2024-10-31 at 11:40 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Wed, Oct 30, 2024 at 08:44:29PM +0000, Jonathan Cameron wrote:
> > > On Wed, 30 Oct 2024 14:04:58 +0100
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > >=20
> > > > On Mon, 2024-10-28 at 17:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Some of the ADCs by Analog signal their irq condition on the MISO=
 line.
> > > > > So typically that line is connected to an SPI controller and a GP=
IO. The
> > > > > GPIO is used as input and the respective interrupt is enabled whe=
n the
> > > > > last SPI transfer is completed.
> > > > >=20
> > > > > Depending on the GPIO controller the toggling MISO line might mak=
e the
> > > > > interrupt pending even while it's masked. In that case the irq ha=
ndler
> > > > > is called immediately after irq_enable() and so before the device
> > > > > actually pulls that line low which results in non-sense values be=
ing
> > > > > reported to the upper layers.
> > > > >=20
> > > > > The only way to find out if the line was actually pulled low is t=
o read
> > > > > the GPIO. (There is a flag in AD7124's status register that also =
signals
> > > > > if an interrupt was asserted, but reading that register toggles t=
he MISO
> > > > > line and so might trigger another spurious interrupt.)
> > > > >=20
> > > > > Add the possibility to specify an interrupt GPIO in the machine
> > > > > description instead of a plain interrupt. This GPIO is used as in=
terrupt
> > > > > source and to check if the irq line is actually active in the irq
> > > > > handler.
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.co=
m>
> > > > > ---=C2=A0=20
> > > >=20
> > > > Hi all,
> > > >=20
> > > > Regarding this, I do share some of the concerns already raised by J=
onathan. I
> > > > fear
> > > > that we're papering around an issue with the IRQ controller rather =
than being
> > > > an
> > > > issue with the device. When I look at irq_disable() docs [1], it fe=
els that
> > > > we're
> > > > already doing what we're supposed to do. IOW, we disable the lazy a=
pproach so
> > > > we
> > > > *should* not get any pending IRQ.
> >=20
> > I think this is wrong and you always have to be prepared to see an irq
> > triggering that became pending while masked.
> >=20
> > > > Also looking at drivers as the xilinx gpio controller, it seems som=
e
> > > > are careful about this [2] and make sure to clear all pending IRQs
> > > > when unmasking.
> > > Your links are both to the same place.
> >=20
> > The right one is:
> > https://elixir.bootlin.com/linux/v6.11.5/source/drivers/gpio/gpio-xilin=
x.c#L419
> >=20
> > I think this is buggy, see below for the reasoning.
> >=20
> > > > Jonathan also said this:
> > > >=20
> > > > "True enough - that race is a possibility, but not all interrupt in=
puts
> > > > are capable of gpio usage whilst setup to received interrupts."
> > > Race should be easy to avoid using a level interrupt now I think more=
 on that:
> > > can't miss a level.
> >=20
> > In general this isn't true. If it were that easy we could just assume
> > all irqs being level interrupts and simplify the irq code a bit. At
> > least for the ad7124 if a conversion is done, the chip holds the line
> > low until the next conversion is done. In that case it deasserts
> > DOUT/=CC=85R=CC=85D=CC=85Y for a short while to create another falling =
edge signalling
> > another event. I can imagine this to confuse level detection?!
> >=20
> > > > To my understanding this also means this is doomed to fail for some=
 devices
> > > > or
> > > > am I
> > > > not following it?
> > >=20
> > > If you were wired to one of those, you couldn't use the GPIO trick, b=
ut then
> > > don't have a GPIO in your DT in that case.
> >=20
> > Yes. If the device isn't properly connected in hardware you're out of
> > luck. But that is also true if the spi clock line isn't connected. So
> > apart from the requirement that "properly" involves things that are
> > unusual for other SPI devices, that's expected. Having said that it was
> > clear before because the MISO (aka DOUT/=CC=85R=CC=85D=CC=85Y) line was=
 already know to have
> > to be connected to an irq capable pin.
> > =C2=A0
> > > > All that said, my naive feeling would be for a masked line to not g=
et any
> > > > pending IRQ
> > > > and if it does, the driver should make sure to clean all outstandin=
g
> > > > interrupts
> > > > when
> > > > unmasking. But I'm far from being an expert of the IRQ subsystem. M=
aybe it
> > > > would be
> > > > interesting to get some inputs about someone who actually knows bet=
ter?
> > > +CC Thomas Gleixner,
> > >=20
> > > Annoying case where a wire is both the interrupt source for dataready=
 and the
> > > SPI data line (if separate clock signal is toggling)=C2=A0 So current=
ly the driver
> > > masks interrupts at the host end, but we have at least one interrupt =
controller
> > > where they end up pending and fire on reenabling the interrupt.=C2=A0=
 Querying the
> > > device to check the status register then ends up causing it to happen=
 again,
> > > so that doesn't help.
> > >=20
> > > Proposal is to query it as a GPIO (or maybe a separate GPIO wired to =
the same
> > > pin) to check the level when an interrupt comes in.
> >=20
> > In my understanding it's the expected behaviour of an irq controller
> > that a masked irq becomes pending if the irq event (level or edge)
> > happens and then triggers immediately after enable_irq() -- independent
> > of laziness being used or not.
> >=20
>=20
> I'm really not sure about that. If a consumer disables/masks an interrupt=
, then I
> would think it expects no interrupts. If one comes during that time, it s=
eems
> reasonable to me that the IRQ is discarded.=C2=A0And if the expected beha=
vior is to have
> a
> pending IRQ if we got it while masked, then I'm not sure why we have the =
UNLAZY
> thing. I mean, let's always do the lazy approach which is effectively onl=
y masking
> the line if we get an IRQ while disabled (and also mark it as pending). I=
f both
> approaches result in a pending IRQ...

Hmmm maybe the real point with UNLAZY is to not take the same interrupt twi=
ce. One
through the resend mechanism and another one through HW.

- Nuno S=C3=A1



