Return-Path: <linux-iio+bounces-8195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B0946993
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82688281C6C
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5713A24D;
	Sat,  3 Aug 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="L3bFNHR4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A281ABEA7;
	Sat,  3 Aug 2024 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722687189; cv=none; b=G8byUTIvYRvFZXJZv/CGa2bAu/uxzFZRrvbzS8ZF9SPBU7rJLr0Gg+i1+vAOGhFlYHe+uot5BYV85rS0WUolTukomdDeh15H86GcNzBBbhKnL+2bYdXMX0KUvbXS3/LHN5nh4Pdoe4kK6paZVcAtxlW5FobuRyi5AYl3mVf+WkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722687189; c=relaxed/simple;
	bh=/+TaaxXgbiMt4LF0JEKjTSLDdxxWoittoRBPcfRUaIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EibVNuMuV3m0lnPpXwWLnWJ04uuCbVYPxK9CrBLcrfRktRHNNrcGgBpF9lHziOs//5bRe0hSIv62JqyXnib9L58WFJie8FpQjJZ13Esvh80DyAEsaoidsf1mBNav0ljsBXrRpCkL8ifbK11pP3eLqIxMEVcwlco1R9tfS/k3Ssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=L3bFNHR4; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1F7A41F9D7;
	Sat,  3 Aug 2024 14:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1722687176;
	bh=em817O2iX9N6mMMcKL4oOGN6A/aMFg9EauJEH6drpRk=; h=From:To:Subject;
	b=L3bFNHR4JBBT9+RiB3hZgpo0lCMBgjzV57E91OiTvHAQ9tCc7jqdnY5bsMI93KFAR
	 eA+LdCAyWtKu/RkfqVvwY5AniQj9ElRgiFTmDK6JZFUuaUSd2axCIfi5IM10H2aR4l
	 GgVwAd7CZrggemqLgVkgZ9Pvw8eYTM8b1RB8K3v0MzvD9p/4YlgMSoyJgIs4JsONjs
	 WNNPYeVMTb/BnCPMrKw7pB4rrWfr3W4eNkZrLZBifTOtrSl70dcsXwYRS6fYHkRS6Z
	 6SoDjEEIasrf1P145rN6uqRWIY6MSkPp6uskUCBx07uIo7g8GAgWZgV5wRuYa2EbR8
	 qpIublG5POXjg==
Date: Sat, 3 Aug 2024 14:12:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: ads1119: Fix IRQ flags
Message-ID: <20240803121252.GA6207@francesco-nb>
References: <20240731140657.88265-1-francesco@dolcini.it>
 <20240731142016.6immldd7i4y7v2iw@joaog-nb>
 <20240803122127.221da36f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240803122127.221da36f@jic23-huawei>

Hello Jonathan,

On Sat, Aug 03, 2024 at 12:21:27PM +0100, Jonathan Cameron wrote:
> On Wed, 31 Jul 2024 11:20:16 -0300
> João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com> wrote:
> 
> > On Wed, Jul 31, 2024 at 04:06:57PM +0200, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > Remove IRQF_TRIGGER_FALLING flag from irq request, this should come from
> > > the platform firmware and should not be hard-coded into the driver.
> > > 
> > > Add IRQF_ONESHOT flag to the irq request, the interrupt should not be
> > > re-activated in interrupt context, it should be done only after the
> > > device irq handler run.
> > >  
> > 
> > Reviwed-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> 
> For the direction, there is a risk that we will break someone who
> has a firmware that isn't setting this correctly.

> I don't mind doing that if we have another board that needs control
> (and is setting it appropriately) though.  Is that true here, or is
> this just cleanup?
> 
> If it's cleanup we tend to leave these alone (but not introduce them
> into new code!)

The driver was just introduced by me in v6.11, I assume that the only
user is a board that is not yet available in the upstream Linux kernel
(we gonna send the DT soon), with that said I am relatively confident we
are not going to break any user.

The reason for sending this patch is that we just stumbled across
a different driver that was hard-coding the IRQ flags and it was not working
for our hardware, at that moment I realized that the decision on the just
added ti-ads1119 was not the best one.

The idea of this patch is to clean this up _before_ any user is
affected.

Francesco


