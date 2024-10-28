Return-Path: <linux-iio+bounces-11511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F039B39C4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 19:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945DE1F21FC2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441611DFD83;
	Mon, 28 Oct 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9omb63v"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB11DF998;
	Mon, 28 Oct 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141875; cv=none; b=DaGhqaqHDNb83/Ghkg8Kuaqkxrhm7AKH6XoJc0IyodH03a+1RbY5968uHzWi/dBF+CmNR60YA7MaEqoce4vEww5OwmUFq4Xe8MjWTlDgyr8ewqBnahIp8bWKDqPBz2ndhvO0SFRHNGM0Gp1/dXuc7VEnxc+aIKRG4N0opVA8Q0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141875; c=relaxed/simple;
	bh=99bsmP2XptepQH6V0KONvO6BgemdcaIH4y46oakt+Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHPadDGXaDXkRNhGZRDvXXJeQof6Js+x8fNVcopFIUPTZXw3q7x044lSL+5WnqEUe6yLPPs6vlppzg6F6DuCQlSDX02ItOjZZ10u1pxKnFwlhqcB+wsy5joAjrC0mUWMNtvm7XnT4lNzFqGpk2FSdIPqsZwrk/9un9OZsQnlvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9omb63v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467FFC4CEC3;
	Mon, 28 Oct 2024 18:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730141874;
	bh=99bsmP2XptepQH6V0KONvO6BgemdcaIH4y46oakt+Qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d9omb63vyBkSMnzyBel2WyWqRSXkricfeA8eWPY1OgHpYnr3d0bsdSVRYalkNjyi2
	 gRWwGjZLmMDriEcVjUpwJnLbBd9fiOFfFmUau3kSg5lFl22UwkbhkqqCbjXQyE2+IM
	 /2ZKAt9F78m1O4SZuh4Nc+BtK/YTJYWg5Ikd2YOZqSjv+tKAKKgF6N8wL6uXq1/7v9
	 24tsKIHHIFcv5nqp95Ld3MXUbv75w4oC8Fy0azcSaZx4bMv0eUCNHcO3auVQEJilsV
	 5e8pyPNiox9K4KfZfQlvwt9hiKyLfa7z9HHLwYLBnJZmErh1hmlsLU9o4ynyiPXUQz
	 AcnWrfmnkPBvQ==
Date: Mon, 28 Oct 2024 18:57:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
Message-ID: <20241028185744.3109b300@jic23-huawei>
In-Reply-To: <e557quqqexisgj423ayhq6wntzx567dikaucckjnduvhvp4esw@bvvg3zcctnox>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
	<20241024171703.201436-6-u.kleine-koenig@baylibre.com>
	<20241027115409.2de280dd@jic23-huawei>
	<e557quqqexisgj423ayhq6wntzx567dikaucckjnduvhvp4esw@bvvg3zcctnox>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Oct 2024 22:53:39 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> [dropped Alexandru Tachici from Cc:, the address bounces]
>=20
> On Sun, Oct 27, 2024 at 11:54:09AM +0000, Jonathan Cameron wrote:
> > On Thu, 24 Oct 2024 19:17:03 +0200
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
> >  =20
> > > For the AD7124 chip the logical irq line (=CC=85R=CC=85D=CC=85Y) is p=
hysically on the same
> > > pin as the spi MISO output (DOUT) and so reading a register might
> > > trigger an interrupt. For correct operation it's critical that the
> > > actual state of the pin can be read to judge if an interrupt event is=
 a
> > > real one or just a spurious one triggered by toggling the line in its
> > > MISO mode. =20
> >=20
> > This text should note that this is a limitation with the interrupt cont=
roller.
> > The IRQ is disabled when those reads are going on, yet the controller is
> > still detecting the interrupt and reporting it on reenable.
> > I'm not an expert in what the kernel IRQ subsystem requires so maybe
> > this is a valid implementation. =20
>=20
> This is even the saner option and a controller not triggering might miss
> irqs. Consider the process that triggered a conversion and then calls
> enable_irq() is preempted long enough that the conversion is already
> done when enable_irq() is called. The completion would just time out and
> no measurement reported.

True enough - that race is a possibility, but not all interrupt inputs
are capable of gpio usage whilst setup to received interrupts.

>=20
> > > Allow specification of an "interrupt-gpios" property instead of a pla=
in
> > > interrupt. The semantic is that the GPIO's interrupt is to be used as
> > > event source and reading the GPIO can be used to differentiate betwee=
n a
> > > real event and one triggered by MISO. =20
> >=20
> > This sort of hack is a bit nasty and if we are going to do it we should
> > allow for double wiring - so to separate GPIO and interrupt pins on the
> > host wired to single pin on the device.
> >=20
> > The binding does that by allowing both interrupts and interrupt-gpio
> > but we need to make that explicit in this text. Arguably even when
> > they are the same pin the binding should treat them as independent
> > and the driver should get the gpio from one, and the interrupt from
> > the other. =20
>=20
> This would also need a code update because currently the interrupt-gpio
> is only used if no interrupt is specified.

Absolutely.  It would require slightly different code.


>=20
> > I also definitely need input from Analog Devices folk on this series. =
=20
>=20
> Good candidates to comment are still on Cc:
Yeah. I was poking them  :)

>=20
> Best regards
> Uwe


