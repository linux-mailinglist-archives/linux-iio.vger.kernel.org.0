Return-Path: <linux-iio+bounces-15931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378CA4081C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442FE189C7F7
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E6620ADD1;
	Sat, 22 Feb 2025 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp3fRkHh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F7207E1D;
	Sat, 22 Feb 2025 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225218; cv=none; b=Pfvixpu5fS4g4KOAyuorPUpteWOLIzlBtu+7u9MHwhdi41aqCVHCST6ntav7D0VTytCdXuuyH4+wDQbE8QEVyGM0ih3HycO9LH3MQedmYEOYrcy+rCHpiJJD6zTguBLVeqq1cwfJtrF+s2AzrS54f3gErFOkOLwOH2YyoV6dUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225218; c=relaxed/simple;
	bh=n/LG/dKXU2OIZXGkhCaxoGXfyyXVnUjTtrluECT61AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoHEm7BLw7+GlSEw5FKHSw6P4gT5ogxnW+es1yNHi8soxwmlQJfojnmWenygRahtiY2YLZ8mvLNJY9FAx93Xr8uI4pXbgZc7jzgx8uLXRVIsi0haZHmOPX7AyPpJOejopOpqrrN5SYJUx0dtrKXJDPxvXPIIPImbiwzazHtMQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp3fRkHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F10C4CED1;
	Sat, 22 Feb 2025 11:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740225218;
	bh=n/LG/dKXU2OIZXGkhCaxoGXfyyXVnUjTtrluECT61AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qp3fRkHhy3Y5GKMrBn84A8SvAW69doXDsfXZ7vmJ4ygmUyRPE4w6pQmNpF8JjBGle
	 9oHBiiHiOjSw6F7U0CGTet+h0+7pdGNSEQR2In+t58dDLFZljGhSCm3nKN4xP+zPSD
	 JgqyfekBRJ72sEN7spZOWnpyqgICgiAyg1wJfiqpHTbKMKIsXlieppAnEm0qfscTPb
	 yvN0s688ZzXchiejUslubn3wyaR7fPXQaMbVMJ2FC8i3Qly0xOKG23iZfh3t2ovCR0
	 Y9g8Lk+JR+6pGHCGqs0GOC73pTdszStgkj5U1c8ZU2LDiCzUsKiF2gtDv6DRsTG02j
	 4rSe/JEK4DFsQ==
Date: Sat, 22 Feb 2025 11:53:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] Support for TI ADS7128 and ADS7138 ADCs
Message-ID: <20250222115328.3208a0ce@jic23-huawei>
In-Reply-To: <BE1P281MB242028CC2123871D0FD167A1EFFB2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20250213-adc_ml-v4-0-66b68f8fdb8c@softing.com>
	<20250216155436.239a4b35@jic23-huawei>
	<BE1P281MB242028CC2123871D0FD167A1EFFB2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:56:53 +0000
"Sperling, Tobias" <Tobias.Sperling@Softing.com> wrote:

> > Von: Jonathan Cameron <jic23@kernel.org>
> > Gesendet: Sonntag, 16. Februar 2025 16:55
> >
> > On Thu, 13 Feb 2025 16:58:56 +0100
> > Tobias Sperling via B4 Relay <mailto:devnull+tobias.sperling.softing.com@kernel.org>
> > wrote:
> >   
> > > This patch series adds support for Texas Instruments ADS7128 and
> > > ADS7138, which are 12-bit, 8 channel analog-to-digital converters (ADCs)
> > > with build-in digital window comparator (DWC), using the I2C interface.
> > >
> > > The driver exposes the interfaces to read the raw values, as well as the
> > > minimum and maximum value for each channel. In addition several settings
> > > can be configured, like the DWC, sampling frequency or an averaging
> > > filter/oversampling. Interrupts triggered by the DWC, if configured, are
> > > then exposed as IIO events.
> > >
> > > ADS7128 differs in the addition of further hardware features, like a
> > > root-mean-square (RMS) and a zero-crossing-detect (ZCD) module, which
> > > are not yet supported by the driver.
> > >
> > > Regarding the I2C interface the chips using opcodes to define the way
> > > how the registeres are accessed, like single or multiple register(s)
> > > read/write or setting/clearing only bits.  
> > LGTM. Applied to the togreg branch of iio.git and pushed out initially
> > as testing for 0-day to take a look at it.
> > 
> > I did notice whilst applying that the Kconfig ordering for these TI parts
> > has gotten scrambled. So at some point we should clean that up and
> > bring them back into alphanumeric order!
> > 
> > Jonathan  
> 
> Ok, thanks for the info. Then everything is going its way I guess. :)
> 
> I can prepare a patch for the ordering. Shall this be based on top
> of this patch set or just the master branch?

This is a rare case where basing on my testing branch is the
best option.  Right now that matches togreg, but I'll probably be
applying some stuff on top today and that might touch this file.

Jonathan
> 
> Tobias


