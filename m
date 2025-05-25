Return-Path: <linux-iio+bounces-19870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE64AC342B
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8BC1892671
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150371F1301;
	Sun, 25 May 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkbUWayD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5181DED42;
	Sun, 25 May 2025 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748172416; cv=none; b=TEKwY6sY/un61ZPAZcgSLLQqv9L1WSRbH42dm+HWtz/Z1zf6kuMQzKP4EVlNJD8arAz6yz83bh7+6dzZ6wJsq4PcLBjz0BQR/PiMxMDUfwIGK4p+5Y+738UHOhRp+tFDzEMazups54Fhc89LsteBQOn6D6+uNo76nlT3D4mZ9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748172416; c=relaxed/simple;
	bh=WcIHmZvlNdDhgDSlCzv1i0xcANKdKA3YFU7kHFc5euQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sf7AJyU98ywRNTgqpO1/qI1gkX+YZ/fin61+rhTysCEor/p4kWldb/sfEjzugNW1V2zAa5E/ixubNLTrh/6cZoJOKXMavp+xuyeh9ERHhzTQMG98KptNunv5qo1naYJxLW29uBq+bF7dgXM+0XMZc02krwzQpqY8QFt49YnvkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkbUWayD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA459C4CEEA;
	Sun, 25 May 2025 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748172416;
	bh=WcIHmZvlNdDhgDSlCzv1i0xcANKdKA3YFU7kHFc5euQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bkbUWayD4NAlJm1+XnBXjkFHYi051BYt3+nVLMZPCg2/cG3sYyhV2gEIDElQaidjW
	 +SwVOSq9JYqmJ5jFrOaC8FHaHKtxXxbUL4w37hakibw3/dDYZiOeqHX7wpaegX17rF
	 OjewbOQG27qFAgQUNujNTd6ZvYml4K3JcaWVEiNa4HOMXN+6U9wrFBO7qf1PG4zIdx
	 q6LDvi7RQjC09WEuLfjOvjPcuWQWTioI2MAVYeNO1eXem1jJLx2uEBGX5Jbn3YEMLU
	 +iD7RKR8L0/sRGe1KaTxh5tKqNAxBHjSnuqEHRPcqHIWlKljD2o/maKhxyw8c8dkiI
	 p6t/gB2T2Hkcg==
Date: Sun, 25 May 2025 12:26:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, corbet@lwn.net, lucas.p.stankus@gmail.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/12] iio: accel: adxl313: prepare interrupt
 handling
Message-ID: <20250525122648.38428bc2@jic23-huawei>
In-Reply-To: <aCzcskqKEXpM2jui@smile.fi.intel.com>
References: <CAFXKEHYe_LBV=95Rm75UXF97oUU5CTYzDdwXJZ=cr+4fGOf80g@mail.gmail.com>
	<aCzcskqKEXpM2jui@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 22:49:06 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Tue, May 20, 2025 at 09:32:18PM +0200, Lothar Rubusch wrote:
> > Hi Andy, I forgot to put my mail addresses as well. I copied your answer
> > now from the mailing list archive. Hence, sorry for the bad formatting
> > of this mail.
> > 
> > One question / remark down below.
> >   
> > > On Sun, May 18, 2025 at 11:13:15AM +0000, Lothar Rubusch wrote:  
> > > > Evaluate the devicetree property for an optional interrupt line, and
> > > > configure the interrupt mapping accordingly. When no interrupt line
> > > > is defined in the devicetree, keep the FIFO in bypass mode as before.  
> 
> ...
> 
> > > > +        ret = regmap_write(data->regmap, ADXL313_REG_INT_MAP, regval);  
> > >
> > > Don't you want to use regmap_assign_bits() or something like this to have
> > > the above ternary be included?  
> > 
> > Thank you so much. I guess this is a function I was looking for quite
> > a while and I know several places where to use it.
> > 
> > Anyway, I saw, my hardware test setup still runs on an older kernel
> > w/o regmap_assign_bits().  
> 
> You are going to upstream the driver, right? So, we don't care about old
> kernels as there was no such code at all, and since it's not a fix for
> backporting I see no impediments to use the modern APIs.
> 
> > So, I kindly liked to ask if you have any objections against leaving
> > regmap_write() for now? Actually I'd prefer first to see the
> > activity/inactivity stuff in, in case this will need some more
> > modifications and I need to verify them on hardware. I think, leaving
> > regmap_write() here would make that easier for this patch set. Please,
> > let me know?  
> 
> Ask maintainers. I will not object if they agree on your justification.
> 
Hmm. Given the good progress you are making on this driver anyway I'll
go with 'maybe' particularly if you add a final patch on top that
updates the code to use nicer bits of regmap that have been introduced
more recently.

Jonathan



