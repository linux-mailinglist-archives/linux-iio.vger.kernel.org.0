Return-Path: <linux-iio+bounces-11655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20019B6DFC
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 21:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E91B1F21C65
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D51F4288;
	Wed, 30 Oct 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i852va25"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04EF1EB9FD;
	Wed, 30 Oct 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321077; cv=none; b=q62rNPp6atQUdTV/bETuQvPc0w8E03ts8j0LuZTxhykMSkPdlHs0W/zOzYexwQ31bLaRQRf+m6mAoKG0Tf4xSb0dIh2PVLfnKxsySdRm3sYeOSXXjAxPhIpGcYAOjwUxbY+Mkzhr33bjG8RL5TBnKKCoUCgPs50HzLEM0bT+pSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321077; c=relaxed/simple;
	bh=cgo0duRBfUwMyZzBD2j7irRNNvnjmyH23pGtMEZlfRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfGKlKLMSSuDFLjSo+qurx776jFssFt6kGvDZTb2xqxsXmzOfJFgPsdR9l1zgP95gXokpCqqVUqCQaDGXtCOitV3D23CARE4uhqBxkIL8p/lmw0Md7pMZw4UzN0+zsG4esU0reGf4+Y9GMSdqx/1wUwbOIyAmtoCUMACtPB9bdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i852va25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D772C4CECE;
	Wed, 30 Oct 2024 20:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321077;
	bh=cgo0duRBfUwMyZzBD2j7irRNNvnjmyH23pGtMEZlfRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i852va25qG679TqiwpPh1rVUaNL/V9OVxtlP458tievnRbJDD3cT1caRY0mgPYaqB
	 Q8/fmIbQbUt7yaBQJ/IIEvFnHJMPrMONDEjpNTU2H10oAOVMeL31v1AOwVUWRdt2GJ
	 YKF3JH4HEIR7HIgG4xEHKQEgX+OpA9xeH16IfQt2zN7a8vhBJKaABGnyOzB3NwfqdB
	 PwzJwW/IZD32ejxO5gbgRNShxhWht9gc4Uw+YBm/SLQ+z+EC6FjYHD0YlG0ThXea+e
	 lspFQpUiGgb6ownJoae8t4NSf3Wqgz2oE1sg0EjDR3gGEXsFkE35o562wTtmnJsh/l
	 KKESxVksnnfQA==
Date: Wed, 30 Oct 2024 20:44:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/4] iio: adc: ad_sigma_delta: Add support for
 reading irq status using a GPIO
Message-ID: <20241030204429.70cdcf35@jic23-huawei>
In-Reply-To: <a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	<20241028160748.489596-9-u.kleine-koenig@baylibre.com>
	<a575430a74a7825a2df9fad1a8e073ad0507b0e7.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2024 14:04:58 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-10-28 at 17:07 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Some of the ADCs by Analog signal their irq condition on the MISO line.
> > So typically that line is connected to an SPI controller and a GPIO. The
> > GPIO is used as input and the respective interrupt is enabled when the
> > last SPI transfer is completed.
> >=20
> > Depending on the GPIO controller the toggling MISO line might make the
> > interrupt pending even while it's masked. In that case the irq handler
> > is called immediately after irq_enable() and so before the device
> > actually pulls that line low which results in non-sense values being
> > reported to the upper layers.
> >=20
> > The only way to find out if the line was actually pulled low is to read
> > the GPIO. (There is a flag in AD7124's status register that also signals
> > if an interrupt was asserted, but reading that register toggles the MISO
> > line and so might trigger another spurious interrupt.)
> >=20
> > Add the possibility to specify an interrupt GPIO in the machine
> > description instead of a plain interrupt. This GPIO is used as interrupt
> > source and to check if the irq line is actually active in the irq
> > handler.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > --- =20
>=20
> Hi all,
>=20
> Regarding this, I do share some of the concerns already raised by Jonatha=
n. I fear
> that we're papering around an issue with the IRQ controller rather than b=
eing an
> issue with the device. When I look at irq_disable() docs [1], it feels th=
at we're
> already doing what we're supposed to do. IOW, we disable the lazy approac=
h so we
> *should* not get any pending IRQ. Also looking at drivers as the xilinx g=
pio
> controller, it seems some are careful about this [2] and make sure to cle=
ar all
> pending IRQs when unmasking.
Your links are both to the same place.
>=20
> Jonathan also said this:
>=20
> "True enough - that race is a possibility, but not all interrupt inputs
> are capable of gpio usage whilst setup to received interrupts."
Race should be easy to avoid using a level interrupt now I think more on th=
at:
can't miss a level.
>=20
> To my understanding this also means this is doomed to fail for some devic=
es or am I
> not following it?

If you were wired to one of those, you couldn't use the GPIO trick, but then
don't have a GPIO in your DT in that case.

>=20
> All that said, my naive feeling would be for a masked line to not get any=
 pending IRQ
> and if it does, the driver should make sure to clean all outstanding inte=
rrupts when
> unmasking. But I'm far from being an expert of the IRQ subsystem. Maybe i=
t would be
> interesting to get some inputs about someone who actually knows better?
+CC Thomas Gleixner,

Hi Thomas,

Annoying case where a wire is both the interrupt source for dataready and t=
he
SPI data line (if separate clock signal is toggling)  So currently the driv=
er
masks interrupts at the host end, but we have at least one interrupt contro=
ller
where they end up pending and fire on reenabling the interrupt.  Querying t=
he
device to check the status register then ends up causing it to happen again,
so that doesn't help.

Proposal is to query it as a GPIO (or maybe a separate GPIO wired to the sa=
me
pin) to check the level when an interrupt comes in.

Any thoughts on this nasty hardware and what is responsiblity of the device
driver vs the interrupt controller driver in this case?

Jonathan

>=20
> [1]: https://elixir.bootlin.com/linux/v6.11.5/source/kernel/irq/chip.c#L3=
66
> [2]: https://elixir.bootlin.com/linux/v6.11.5/source/kernel/irq/chip.c#L3=
66
>=20
> - Nuno S=C3=A1
>=20
>=20


