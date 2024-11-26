Return-Path: <linux-iio+bounces-12692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1C9D9CE1
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8546E283B3D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 17:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EA81DB951;
	Tue, 26 Nov 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd3sce0I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806D182BC;
	Tue, 26 Nov 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643378; cv=none; b=FvwQCX/aON2qwwcTGl4YvqnzqjHMFnJ/zVmeFz9XvIkWffU1YEPmsZ3GeOsWGstw3poxGgPYKRO71VnP8l4roMqdoGfWma6MwH42PJ/xZJ9lnCYvuiapXS1YbET4luLgx4tOVDqt+hv//rQYf+IJEHLBehWMYHRzC4OS3II/7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643378; c=relaxed/simple;
	bh=kb7kJuyxrPP67D4+V8ZBPqBtb77qXjoqsX4FGhfEFHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0rIsv0aopUGk4eiNpk4ZMRCFSllruIosTl/mD/bxAcvDnd0MltGfnx4Hr4TTxZkquhzy15VDAghJs1eaKjTPcdNQoUhY7csUj1im38+FUDXltbdtjw7mmw3WeTB2oddVtaOjikkzd8TPv0AwJcbaDYyTiRQal9umYmxoth9pFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd3sce0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96567C4CECF;
	Tue, 26 Nov 2024 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643378;
	bh=kb7kJuyxrPP67D4+V8ZBPqBtb77qXjoqsX4FGhfEFHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bd3sce0I7B7CN1FNSDWRtccp+in9NodjfGdXuri8JAMfuPmZV5Ra1aGGV4CiJydWA
	 qn0JLUo1POalNCHIoT4o9FxkbzUhJbTaKsow4kVqJdNTdlFdsUy7pNAnpEpVArhLtp
	 lLrWbYGw6OGNp2715CIqW5RecQD5WZyRUeOPS2UcLmvL6OKNFXG8oHhh9s3VABRsXh
	 Q6ejf78EBL1M2PtlkcB4hKTQQLy9draoGmm0AEZ87VVmdRrpvcjl5lv8+ACHj8xFzx
	 QYsPIn5IrV+hoy6CwaToQwt/0sgGajzsNjLFG03l9VGW4+RpCxUQtKK/PfgA8aSc6H
	 xI/eAJ1L9o/6w==
Date: Tue, 26 Nov 2024 17:49:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 07/22] iio: accel: adxl345: initialize IRQ number
Message-ID: <20241126174932.7987df3e@jic23-huawei>
In-Reply-To: <CAFXKEHbLg9COcKkv2AX-TfdW+-RO7CpJjMLQ3YJtcNbnXcs9xA@mail.gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-8-l.rubusch@gmail.com>
	<20241124181428.59b85176@jic23-huawei>
	<CAFXKEHbLg9COcKkv2AX-TfdW+-RO7CpJjMLQ3YJtcNbnXcs9xA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Nov 2024 17:16:07 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Nov 24, 2024 at 7:14=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 17 Nov 2024 18:26:36 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the possibility to claim an interrupt and init the state structure
> > > with interrupt number and interrupt line to use. The adxl345 can use
> > > two different interrupt lines, mainly to signal FIFO watermark events,
> > > single or double tap, activity, etc. Hence, having the interrupt line
> > > available is crucial to implement such features. =20
> >
> > If there are two interrupt lines, you need to be more clever.
> > Imagine only one of them is wired. How do you know which one it is?
> >
> > The query needs to be done by name.  When there are multiple interrupts
> > the ones found in spi and i2c structures could be anything, so don't use
> > those.
> >
> > See fwnode_irq_get_by_name() =20
>=20
> One of my bigger question marks is this here: The sensor has two
> possible interrupt lines, INT1 or INT2, on which it will notify. But,
> only one is connected. Hence, the irq passed e.g. by SPI will
> automatically refer to the used one. Only this one is going to be
> configured as irq. Or, am I getting this wrong? Alternatively, no
> interrupt line is connected. This was the initial driver setup. In
> this case, it's generally BYPASS-mode for the FIFO and any further
> feature is not possible due to a lack of notification.
>=20
> My questions now arise, when it comes to configure the IRQ line in the
> sensor registers. The sensor needs to be configured, that the used
> interrupt line for notifiction is INT1 or INT2. In the later patch of
> this series - "set interrupt line to INT1" - I init it with "INT1".
> But, this actually then can be configured. I can think of yet another
> /sysfs handle (could be dynamically changed at runtime, I'm not sure
> if this makes sense); by an additional devicetree binding (currently
> my preferred idea, I'd default to INT1, but let it configure to INT1
> or INT2 - or better default to bypass mode?), or is there an IIO way
> of configuring it to INT1/2, or a better way? I rather tend to DT. But
> this is still not part of this patch set.

>=20
> Do I miss a point here and should still apply the
> fwnode_irq_get_by_name()? This looks a bit like the DT approach, isn't
> it?

Yes - this function does exactly what you need here (it is a very common
situation! Try grepping for INT2 and you should see examples)

To fill in the information you need:
1. Try getting INT1 by name. If succeeds use that and set config on basis I=
NT1 is wired.
2. If not try getting INT2. If that succeeds then use INT2.=20
3. If that fails no interrupts.

The binding should 'require' interrupt-names so that you always know
which one is which in the interrupt properties.

If the binding just had one interrupt before, then we add some text to say =
that
it is only valid if the provided interrupt is INT1.

Jonathan

