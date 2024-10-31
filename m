Return-Path: <linux-iio+bounces-11691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180419B7A38
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 13:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB9C1F21552
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAFF19AD94;
	Thu, 31 Oct 2024 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEOyinpL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505E61BC20;
	Thu, 31 Oct 2024 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376328; cv=none; b=Ze49gq9MlY2wK+vRxESSsWQaT7y0sXKRT5bP/Z6hQ3Gp5d5Xjr+XIiq85gDMiDis+ictCwX0zuI62nlGvi1QH3Kkeaezi/O7wiOX070ZncPJyVPKskAV7Fp17B183kHvNjohQgUKNPlk3iZAdrtt3tF+wpy/htMSTMRAc7u1Yjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376328; c=relaxed/simple;
	bh=itGgNJ/MvfHhpdeQxu1G7+Fskh4njZ6sYEjKkG6Meec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0ZtCGrmesltVyXimdX8WX9fUpKw20F2VJOd6+k4jbknAIYDRZs6PXJX1y88oTX75W9N/sDQLlaDbB2xfokI4zS+NshvTzB/VP9O8XGRRr4T0Dkv78lFOvQgI3wQazqWHDwoXxXburhgItERNG/0+drt4R3KxPIxMbpwHUQSvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEOyinpL; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so8348351fa.0;
        Thu, 31 Oct 2024 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730376323; x=1730981123; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=itGgNJ/MvfHhpdeQxu1G7+Fskh4njZ6sYEjKkG6Meec=;
        b=HEOyinpLe9e9hdwODIcg5tqMMhc/XLTCXm+6mgOeEfT+NLNylpOYS1YpzjxKNfTDBF
         QAGBIKL84hLnBrYPS+YTd8pjaIaG4ka0gPOhoM20DKd5De66JiNSTFPgCy37gEmH6mFS
         w6C8+2Im8NBHCUwgNOrW7VZYq8hBiLKWVlt1try7lzqwc2FQe0x1lweEOvfdtUtQqDfS
         2fHkj6oK2umBjH1Dr+CoH2QJXZF946xC/nRqTC0FZ2M+WNFU0opTiE2QHPTKv4ULdfnc
         h5eHgB1rPqtT/vhANznwWswn4wfOWIhGdmWgJAmS1/P3Ky7UrFgVdgGaKhE9ZVsCZz6O
         l5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376323; x=1730981123;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itGgNJ/MvfHhpdeQxu1G7+Fskh4njZ6sYEjKkG6Meec=;
        b=Vs5i0EC3ArT6Zdut0KNuHzL/4SIYOT9emfeBBe65otetRgriZPOzbTeLwT5Urvxsz5
         JJj4R097foAEZlFho7iOUdG2YbEXvL3E/VI8nALKd64+oV4fJMDbKI3ETucve6uB9BXu
         5JZ1L6vpSzxnEkC154INKNG8xXiJAu7yxUo8DeCPHGDBLdb0ETCZohjg7w2kfCLNTgOh
         H8qLPvZavkzmMcU4rm6Ol06Prwxd1FeEBTBmIhpoY1c+4gPpLIPw+ajJ84a/CcEZjkKk
         t9+gHvm70BDi3GUBXAR3ATTinTvKNJxtT+AsDczcdY/xQyNbxnhfCM573A/voKT3MrEk
         xSWA==
X-Forwarded-Encrypted: i=1; AJvYcCVEp3MU9hmqV6cDFVqJPw1x1ZotngcSFKQKgatpBpCms7s3YuB2GC8lqScTKJDvduqw9jafP6BHZYpY@vger.kernel.org, AJvYcCXpPJCT/3RWJTYwSuFsUZ91GRYUbBX9QjroC4Cfy9hC7l1LHhdf4Jo81cs1nz7S+1CjGrBj94EfDcUI@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/f90V/ac6U5mt5yax34m/+YMzOX1Edi30J2ZRdD2nXSJ5K4m
	AfB/F2EGmCCqzJNncECMnMUgecOzbJKIYF4aryVGLQRFBSoKMjmi
X-Google-Smtp-Source: AGHT+IF0vHzdjAwBOtAxuErmhIJGUx3dMUZZHOKQl4KmPSgcmcXcPNcYVZGV4nJLE7UvKPccQGS+Xg==
X-Received: by 2002:a05:651c:12c3:b0:2f9:c337:aca9 with SMTP id 38308e7fff4ca-2fed6de9eb3mr7950631fa.44.1730376322928;
        Thu, 31 Oct 2024 05:05:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bb78cf7bsm46531835e9.1.2024.10.31.05.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:05:22 -0700 (PDT)
Message-ID: <1de551c284aaa9f4e91f91fa0c4ac570c8b7f2c9.camel@gmail.com>
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
Date: Thu, 31 Oct 2024 13:05:21 +0100
In-Reply-To: <y3amm7yj37lravbk6fcwze3jlllp4extmffqtx4jaoeqjt6uyl@nsdrcy2dk5kr>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	 <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
	 <a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
	 <20241030204429.70cdcf35@jic23-huawei>
	 <y3amm7yj37lravbk6fcwze3jlllp4extmffqtx4jaoeqjt6uyl@nsdrcy2dk5kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-31 at 11:40 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Oct 30, 2024 at 08:44:29PM +0000, Jonathan Cameron wrote:
> > On Wed, 30 Oct 2024 14:04:58 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >=20
> > > On Mon, 2024-10-28 at 17:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > Some of the ADCs by Analog signal their irq condition on the MISO l=
ine.
> > > > So typically that line is connected to an SPI controller and a GPIO=
. The
> > > > GPIO is used as input and the respective interrupt is enabled when =
the
> > > > last SPI transfer is completed.
> > > >=20
> > > > Depending on the GPIO controller the toggling MISO line might make =
the
> > > > interrupt pending even while it's masked. In that case the irq hand=
ler
> > > > is called immediately after irq_enable() and so before the device
> > > > actually pulls that line low which results in non-sense values bein=
g
> > > > reported to the upper layers.
> > > >=20
> > > > The only way to find out if the line was actually pulled low is to =
read
> > > > the GPIO. (There is a flag in AD7124's status register that also si=
gnals
> > > > if an interrupt was asserted, but reading that register toggles the=
 MISO
> > > > line and so might trigger another spurious interrupt.)
> > > >=20
> > > > Add the possibility to specify an interrupt GPIO in the machine
> > > > description instead of a plain interrupt. This GPIO is used as inte=
rrupt
> > > > source and to check if the irq line is actually active in the irq
> > > > handler.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > > ---=C2=A0=20
> > >=20
> > > Hi all,
> > >=20
> > > Regarding this, I do share some of the concerns already raised by Jon=
athan. I
> > > fear
> > > that we're papering around an issue with the IRQ controller rather th=
an being
> > > an
> > > issue with the device. When I look at irq_disable() docs [1], it feel=
s that
> > > we're
> > > already doing what we're supposed to do. IOW, we disable the lazy app=
roach so
> > > we
> > > *should* not get any pending IRQ.
>=20
> I think this is wrong and you always have to be prepared to see an irq
> triggering that became pending while masked.
>=20
> > > Also looking at drivers as the xilinx gpio controller, it seems some
> > > are careful about this [2] and make sure to clear all pending IRQs
> > > when unmasking.
> > Your links are both to the same place.
>=20
> The right one is:
> https://elixir.bootlin.com/linux/v6.11.5/source/drivers/gpio/gpio-xilinx.=
c#L419
>=20
> I think this is buggy, see below for the reasoning.
>=20
> > > Jonathan also said this:
> > >=20
> > > "True enough - that race is a possibility, but not all interrupt inpu=
ts
> > > are capable of gpio usage whilst setup to received interrupts."
> > Race should be easy to avoid using a level interrupt now I think more o=
n that:
> > can't miss a level.
>=20
> In general this isn't true. If it were that easy we could just assume
> all irqs being level interrupts and simplify the irq code a bit. At
> least for the ad7124 if a conversion is done, the chip holds the line
> low until the next conversion is done. In that case it deasserts
> DOUT/=CC=85R=CC=85D=CC=85Y for a short while to create another falling ed=
ge signalling
> another event. I can imagine this to confuse level detection?!
>=20
> > > To my understanding this also means this is doomed to fail for some d=
evices or
> > > am I
> > > not following it?
> >=20
> > If you were wired to one of those, you couldn't use the GPIO trick, but=
 then
> > don't have a GPIO in your DT in that case.
>=20
> Yes. If the device isn't properly connected in hardware you're out of
> luck. But that is also true if the spi clock line isn't connected. So
> apart from the requirement that "properly" involves things that are
> unusual for other SPI devices, that's expected. Having said that it was
> clear before because the MISO (aka DOUT/=CC=85R=CC=85D=CC=85Y) line was a=
lready know to have
> to be connected to an irq capable pin.
> =C2=A0
> > > All that said, my naive feeling would be for a masked line to not get=
 any
> > > pending IRQ
> > > and if it does, the driver should make sure to clean all outstanding =
interrupts
> > > when
> > > unmasking. But I'm far from being an expert of the IRQ subsystem. May=
be it
> > > would be
> > > interesting to get some inputs about someone who actually knows bette=
r?
> > +CC Thomas Gleixner,
> >=20
> > Annoying case where a wire is both the interrupt source for dataready a=
nd the
> > SPI data line (if separate clock signal is toggling)=C2=A0 So currently=
 the driver
> > masks interrupts at the host end, but we have at least one interrupt co=
ntroller
> > where they end up pending and fire on reenabling the interrupt.=C2=A0 Q=
uerying the
> > device to check the status register then ends up causing it to happen a=
gain,
> > so that doesn't help.
> >=20
> > Proposal is to query it as a GPIO (or maybe a separate GPIO wired to th=
e same
> > pin) to check the level when an interrupt comes in.
>=20
> In my understanding it's the expected behaviour of an irq controller
> that a masked irq becomes pending if the irq event (level or edge)
> happens and then triggers immediately after enable_irq() -- independent
> of laziness being used or not.
>=20

I'm really not sure about that. If a consumer disables/masks an interrupt, =
then I
would think it expects no interrupts. If one comes during that time, it see=
ms
reasonable to me that the IRQ is discarded.=C2=A0And if the expected behavi=
or is to have a
pending IRQ if we got it while masked, then I'm not sure why we have the UN=
LAZY
thing. I mean, let's always do the lazy approach which is effectively only =
masking
the line if we get an IRQ while disabled (and also mark it as pending). If =
both
approaches result in a pending IRQ...

But again, not sure what are the expectations here and far from an expert o=
n the IRQ
subsystem.

> That's also the only way to prevent missing interrupts. To understand
> that consider an irq that signals there is data in a fifo. The handler
> reads that data out and when it's empty returns. Returning results in
> unmasking the interrupt again. If new data arrives between seeing the
> fifo empty and reenabling the irq you miss the event if the irq doesn't
> become pending while it's masked.
> >=20
I could argue that's the old issue of not handling the IRQs fast enough in =
the
handler in which case some other alternatives would have to be implemented.=
..

Anyways, I guess it can go both ways. Because it can also be plausible that=
 if one
IRQ came while the line is masked then the consumer does not really care ab=
out it and
if we get it right after enable_irq(), we get a spurious interrupt (which i=
s the case
here). But well, in the end you might be right in the sense that putting th=
is
awareness into the irqchip is asking for other issues. And for devices that=
 cannot
disable the IRQ at the device level and rely on disable_irq(), we need to h=
andle it
at the device level.

- Nuno S=C3=A1
>=20

