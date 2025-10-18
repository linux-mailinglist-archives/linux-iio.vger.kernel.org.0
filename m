Return-Path: <linux-iio+bounces-25222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C52BED048
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2691A3BE408
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E910FD;
	Sat, 18 Oct 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTY/bGz5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1C354AFD;
	Sat, 18 Oct 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760793360; cv=none; b=hAsgI0/EKXmoEA4Tpp9FERlVASfJeFfPdySytZTiKtA9fPiBuf6g5P8y8lJUutZJkHwHYorkpQ0lEMC6l7vwzDJUNWeTBen5OuKi1+/VJ7xCdzQEbh6AZNENaCTmcJf+UR4DT053T/TaGeGl66ifMCD7DVqpd0N3iVVULP3Fgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760793360; c=relaxed/simple;
	bh=hysF+JKp4Ag3WbayIb6tgZXGP0K/o0xHdRxBPWpRpuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+zZP4SeILO2BKimkFogmj0/ZNWe1OmOooXQxT8prTMHO8V5g1T/FGveDXPQGIB4Su2fiqtkA9VNZlCzUi7vdlf6MDKD21ojgg7wzmjKa76flFD7jJN9KE4ePUvspKdcgyfiVmSJuTk24BcrPKbsxMjcIg8sXJmkgJ49r3v21cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTY/bGz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5B8C4CEF8;
	Sat, 18 Oct 2025 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760793360;
	bh=hysF+JKp4Ag3WbayIb6tgZXGP0K/o0xHdRxBPWpRpuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTY/bGz5F3a8sPgALBriMkN5WvJ0ojLBrrwANQhMz+rrRYVlFkt/tZ2nfc3j3vd5F
	 PPXYmgCmDV1HOXJ3TVz+74sMoFM9ooQxek393jUOzESFnfFjkQx0kOvjfFcOJ9DwFt
	 UiGoNB6ulQZZ6Vr29bDOB3eG5rBJTvSks+2wIsJ9L28cVhHLy6vFCjIg0v66tHCjSg
	 nrs4JuznCMcZ5VxlhVHRsQcHsFeIorw+t/XDz/N0+yE81ljS4yYqHr/vj/qgnZcYcI
	 Ku7CwxVJS9dagT5ue0M1ehdOmgaojTcuf8xHKYWvRt82LwEdxG1yGC010euKg9OWxz
	 Jgqxx9jC5vqDg==
Date: Sat, 18 Oct 2025 14:15:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Frank Li <Frank.Li@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
 devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>, Adrian
 Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v5 0/5] i3c: Add basic HDR mode support
Message-ID: <20251018141551.3e5c46c1@jic23-huawei>
In-Reply-To: <2025101319545551cfb399@mail.local>
References: <20251007-i3c_ddr-v5-0-444184f7725e@nxp.com>
	<20251012180327.5d94dda2@jic23-huawei>
	<2025101319545551cfb399@mail.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 21:54:55 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 12/10/2025 18:03:27+0100, Jonathan Cameron wrote:
> > On Tue, 07 Oct 2025 16:06:12 -0400
> > Frank Li <Frank.Li@nxp.com> wrote:
> >   
> > > Add basic HDR mode support, only support private transfer, not support
> > > CCC command.
> > > 
> > > Update i3c framework API to allow pass down mode and extend driver callback
> > > function.
> > > 
> > > Implement HDR transfer in svc i3c master driver.
> > > 
> > > Simplifed HDR flow is (ref i3c spec line 5514) Figure 129
> > > 
> > > <--              SDR            ---> | <--- HDR
> > > START 0x7E RnW(0) ACK CCC(ENTHDR0) T   HDR-CMD(00-7f write, 80--ff read)
> > >   
> > >                                     ----> |    
> > > HDR-DATA HDR-CRC HDR-RESTART .... HDR-EXIT
> > > 
> > > Note: HDR-CMD is 16bit data, which included 7bit slave address and 8bit
> > > read/write command.
> > > 
> > > svc hardware can auto issue SDR part.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>  
> > 
> > Whilst there will probably have to be a v6 for the ACPI ID issue in patch 5,
> > I'd like to ask the question of how are we planning to merge this?
> > 
> > Maybe an immutable branch either in IIO or I3C trees that the other one picks up?
> > 
> > It's a new driver so could gamble on taking the IIO driver the I3C tree but even
> > then I'd like a topic / immutable branch in case any IIO wide refactors or similar
> > hit this cycle.
> >   
> 
> I can definitively provide an immutable branch once this goes in or if
> you are more comfortable with this, I guess there is no urgency and we
> could apply this over two cycles, first the I3C part and then you can
> take the driver.
> 
Mostly because I'm really forgetful and hence don't like tracking stuff over
multiple cycles, I'd prefer an immutable once all patches are ready to go.

Thanks,

Jonathan

> 


