Return-Path: <linux-iio+bounces-11686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B90E9B78D4
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 11:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB6B23C76
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F1199E9B;
	Thu, 31 Oct 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WnAesqFu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C24199939
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371249; cv=none; b=KuWMdqpy7zKJ6KpOSTX6akcc8bsJtdbY5xqAs7rbUDqwtOsHpbX7oHUJ9H6k4h8qNtRPdhwt9NM0Aw7Py6jwJ3WXGxvTLg5+rFx4xVYdedWLaHXdE2ZYSqI/+b1u2MLUTmZuHq3xJ0/LgBItDjRLKlVcrZlU2hX8zedQuReXqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371249; c=relaxed/simple;
	bh=XtnAwlHqbDwEqBbAVelZJFoPIxrzfr7UOto+zsLrlkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb8l5eskZaTaLAF6p6P5kmpOPaH/TmJsVEXD+1aZqmFihQzRGLDU6JqCBiTooWM+PHKnqJ7mizYIELpk7/pMEAISioJqTkeuKVhf5oVvNjc1XpPKNcqxM/wxfBljcSNMrKHYdVoz+4KyoX8+iPFfTNn78UKwnuDzaSJMJyAcm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WnAesqFu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316cce103dso8144395e9.3
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730371244; x=1730976044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgKmGA2XP6AGtqM9oW1AxbuyILWkrlt7gPefc+gScmU=;
        b=WnAesqFuDcvek1e+QHgl4Bpl3rZuQvcSZyBeB+aZTFhmUsnXaWhaYGFBEJ+7kfnsPs
         AsKtsRyISTpgbzzt0i5yazgmHbcsLyXjuJ1l5qEnutpaw1jIuTFrnj3Z57CDM8jOoec/
         WqrNb3nV7qUmobnd4O+S6tEEJtW91fnc5SeINuKq4OmFe0Eb4xsreSNgLztwW/8+c9y9
         wXjf/PJ+eQiyeLpd2wMLxU8NLTpDVVNgwSEdDEBmCX98HDPBdfZvAxn8clkiYnmYV2ts
         XQ52+smTpnqtcOG3qez7yTP3f8CbD+/26YUXprElkmIFqgjqyIVbRYS54rM4kt3Z+RZz
         V+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371244; x=1730976044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgKmGA2XP6AGtqM9oW1AxbuyILWkrlt7gPefc+gScmU=;
        b=uH6qlX+RQ6G0u5Ym1wCqa4y5anG8LWPhL/MOdRvuq713oIGJ0mNXzzLyy+Q0JyvcRg
         XasaPFn8yhAid4VNqzoA0RGWZmBDRpVwFKbhg3ytxwopsZgPjmfL8yJairCNakyY1cEo
         B3mL5s3Y50UQPG+wDLfxY/vWOwPD4y9D6c1n8/fK/IrJ+h47zaRZqSCbWd7P8LEMuK5f
         MaY51QJI0isIES7uX8W4p/4ztu6cGO14X5swEZjRks1UDHqc1F/tptMzrbTu4g3DhYL3
         Y4WDBkjZKhZo9DMZxwIZLUT1760Z46P+4hIhk+SBXL3R0fpmNqMirOCKnKyXyluDRmde
         QUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgrYvpJmpsO1UiivP9kOxLckcaMIUqSW9XJzanydI6j37AjutBvMVAY0UnYtD9Ye0h4OsPJrrRWFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCYcAPpOSr/wDoMTO8zn5/dG6q2r1aLLR/q1Ejv5/mZaIKxlE
	hn0SS06sBKGzR2WKcjgTeZCEvLdC4LJ3Pe9/OI4CPUdfdFdOFUvA538dVjLFAIs=
X-Google-Smtp-Source: AGHT+IFPYqx1ZOnNkJk+PcsQb0H+6RC0VdaFuA9KFeFSW0MTwuAVcXEfqSuPspkXtnVhb/q30nPQfA==
X-Received: by 2002:a05:600c:1d8b:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-4319ad06901mr232128505e9.26.1730371244319;
        Thu, 31 Oct 2024 03:40:44 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6984f0sm21970065e9.46.2024.10.31.03.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 03:40:43 -0700 (PDT)
Date: Thu, 31 Oct 2024 11:40:42 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for reading
 irq status using a GPIO
Message-ID: <y3amm7yj37lravbk6fcwze3jlllp4extmffqtx4jaoeqjt6uyl@nsdrcy2dk5kr>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
 <20241028160748.489596-9-u.kleine-koenig@baylibre.com>
 <a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
 <20241030204429.70cdcf35@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vu4ylvzikv3ve35j"
Content-Disposition: inline
In-Reply-To: <20241030204429.70cdcf35@jic23-huawei>


--vu4ylvzikv3ve35j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for reading
 irq status using a GPIO
MIME-Version: 1.0

Hello,

On Wed, Oct 30, 2024 at 08:44:29PM +0000, Jonathan Cameron wrote:
> On Wed, 30 Oct 2024 14:04:58 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2024-10-28 at 17:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Some of the ADCs by Analog signal their irq condition on the MISO lin=
e.
> > > So typically that line is connected to an SPI controller and a GPIO. =
The
> > > GPIO is used as input and the respective interrupt is enabled when the
> > > last SPI transfer is completed.
> > >=20
> > > Depending on the GPIO controller the toggling MISO line might make the
> > > interrupt pending even while it's masked. In that case the irq handler
> > > is called immediately after irq_enable() and so before the device
> > > actually pulls that line low which results in non-sense values being
> > > reported to the upper layers.
> > >=20
> > > The only way to find out if the line was actually pulled low is to re=
ad
> > > the GPIO. (There is a flag in AD7124's status register that also sign=
als
> > > if an interrupt was asserted, but reading that register toggles the M=
ISO
> > > line and so might trigger another spurious interrupt.)
> > >=20
> > > Add the possibility to specify an interrupt GPIO in the machine
> > > description instead of a plain interrupt. This GPIO is used as interr=
upt
> > > source and to check if the irq line is actually active in the irq
> > > handler.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > > --- =20
> >=20
> > Hi all,
> >=20
> > Regarding this, I do share some of the concerns already raised by Jonat=
han. I fear
> > that we're papering around an issue with the IRQ controller rather than=
 being an
> > issue with the device. When I look at irq_disable() docs [1], it feels =
that we're
> > already doing what we're supposed to do. IOW, we disable the lazy appro=
ach so we
> > *should* not get any pending IRQ.

I think this is wrong and you always have to be prepared to see an irq
triggering that became pending while masked.

> > Also looking at drivers as the xilinx gpio controller, it seems some
> > are careful about this [2] and make sure to clear all pending IRQs
> > when unmasking.
> Your links are both to the same place.

The right one is:
https://elixir.bootlin.com/linux/v6.11.5/source/drivers/gpio/gpio-xilinx.c#=
L419

I think this is buggy, see below for the reasoning.

> > Jonathan also said this:
> >=20
> > "True enough - that race is a possibility, but not all interrupt inputs
> > are capable of gpio usage whilst setup to received interrupts."
> Race should be easy to avoid using a level interrupt now I think more on =
that:
> can't miss a level.

In general this isn't true. If it were that easy we could just assume
all irqs being level interrupts and simplify the irq code a bit. At
least for the ad7124 if a conversion is done, the chip holds the line
low until the next conversion is done. In that case it deasserts
DOUT/=CC=85R=CC=85D=CC=85Y for a short while to create another falling edge=
 signalling
another event. I can imagine this to confuse level detection?!

> > To my understanding this also means this is doomed to fail for some dev=
ices or am I
> > not following it?
>=20
> If you were wired to one of those, you couldn't use the GPIO trick, but t=
hen
> don't have a GPIO in your DT in that case.

Yes. If the device isn't properly connected in hardware you're out of
luck. But that is also true if the spi clock line isn't connected. So
apart from the requirement that "properly" involves things that are
unusual for other SPI devices, that's expected. Having said that it was
clear before because the MISO (aka DOUT/=CC=85R=CC=85D=CC=85Y) line was alr=
eady know to have
to be connected to an irq capable pin.
=20
> > All that said, my naive feeling would be for a masked line to not get a=
ny pending IRQ
> > and if it does, the driver should make sure to clean all outstanding in=
terrupts when
> > unmasking. But I'm far from being an expert of the IRQ subsystem. Maybe=
 it would be
> > interesting to get some inputs about someone who actually knows better?
> +CC Thomas Gleixner,
>=20
> Annoying case where a wire is both the interrupt source for dataready and=
 the
> SPI data line (if separate clock signal is toggling)  So currently the dr=
iver
> masks interrupts at the host end, but we have at least one interrupt cont=
roller
> where they end up pending and fire on reenabling the interrupt.  Querying=
 the
> device to check the status register then ends up causing it to happen aga=
in,
> so that doesn't help.
>=20
> Proposal is to query it as a GPIO (or maybe a separate GPIO wired to the =
same
> pin) to check the level when an interrupt comes in.

In my understanding it's the expected behaviour of an irq controller
that a masked irq becomes pending if the irq event (level or edge)
happens and then triggers immediately after enable_irq() -- independent
of laziness being used or not.

That's also the only way to prevent missing interrupts. To understand
that consider an irq that signals there is data in a fifo. The handler
reads that data out and when it's empty returns. Returning results in
unmasking the interrupt again. If new data arrives between seeing the
fifo empty and reenabling the irq you miss the event if the irq doesn't
become pending while it's masked.

> Any thoughts on this nasty hardware and what is responsiblity of the devi=
ce
> driver vs the interrupt controller driver in this case?

+1

Best regards
Uwe

--vu4ylvzikv3ve35j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcjXqcACgkQj4D7WH0S
/k6l0Qf9H43QChnW4w6qaJbshV3+8ZGstbguoZE1x5XYLSNe+7l2bvdXeQHitndw
e3f6GhaFNsrUJDleicZxpAqPQ/btwJ3RsUs57l84iuH3svthZsiXpFASAAgzSNDn
FB0oEaA7tBqP5df2mV6hgatju/wJ60nSfE+SksNW1newP61JGLohqv3FCwJk3hgi
ZOitlJonKXLhZGt7o+vpyJ20giyFftf0LY7/5uKNGorfoKODJHFz4OVSehEAC82u
WCtdJ3/5j/bcrAJZcV+HUS5MVJiIQ5ZpxS2A+BIW7qGBZ8NE3azjxHlRbzDzMLNv
58mIqfx8LXGKjOF7ekIr4iJHRfIo7Q==
=2pE1
-----END PGP SIGNATURE-----

--vu4ylvzikv3ve35j--

