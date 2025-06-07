Return-Path: <linux-iio+bounces-20306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE1AD0EA4
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889E616D7F9
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13DD1FDA9E;
	Sat,  7 Jun 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+n4g9Jk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D236D;
	Sat,  7 Jun 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749315556; cv=none; b=R0GgXWYcKzVHpmu4HNrqpmxV4MYqVWl+eQ9VlX96sb/noDgN19/Te3lgvrv+qIcx+M34RKYBfrRb18E5yk4bN+8g9qeKcWjjArWRSZaLrMC+IihpRqpEyKOg7MqE+cqj0DPiSOHp8fCNbjr4ZuDciTz77Zg2HeEubPfBB0VmRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749315556; c=relaxed/simple;
	bh=Yd7rpYba+Q4AtfrfgdJ46W7L8QFSYgftwPePKTRDz38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEEUtW7VYdBt+thrNv5KIRXNEHi2qmb9rWx4DR5wzAOlsceAuBPcJNkzl6aHStG1otHZ2bvem0JbPM1GWXoVHMbQSnsKm1S53fSdl1aZOkWVGMdxT+hxvYQK4jpP5e93M+tY1IiKmRh8+lE/m3vx7UgxGrtWAHFrr/UMw+eiX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+n4g9Jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716AEC4CEE4;
	Sat,  7 Jun 2025 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749315555;
	bh=Yd7rpYba+Q4AtfrfgdJ46W7L8QFSYgftwPePKTRDz38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+n4g9JkLDIXpUcOmEt3RcnI5lX0AzFfVQ1LrI9iydTutPYEFPwzcLKe7bc3JVqdA
	 +GDc7DEpwm/mgAtYLJyTKFM1xCyodYxnRw2t8bnuzakYfkocqJKmyapQE+YGRmnp/Y
	 rKOuzu/u9D7e76+9m5Mj+RE6ds8EolRrCBwz6iRuT1tOaJKbjDgBfRjlJQN2I+ofUb
	 RYNwjM/lwjsmFpl3it/Ti3o4zFwk0VG+zd68IJQM7j8uh1gGNCJ533Xknupy4h9T0G
	 Mxw0hqY1JK+ZWksA+MWkhlZFswIPn6JCeVtpyh+hWVhVSI1IjCXaNmlk/4IzwHcFqJ
	 1jprErtTtiLFQ==
Date: Sat, 7 Jun 2025 17:59:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v4 02/11] iio: adc: Add basic support for AD4170
Message-ID: <20250607175904.08d7b994@jic23-huawei>
In-Reply-To: <aD78Di51VHxtOtJG@smile.fi.intel.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
	<e79f9a126672b33b8a7c01f650fee43a68c74029.1748829860.git.marcelo.schmitt@analog.com>
	<aD27cobHWeBX8o30@smile.fi.intel.com>
	<aD3XQfUfxIiz62ZU@debian-BULLSEYE-live-builder-AMD64>
	<aD6x2caTMd1eBInM@smile.fi.intel.com>
	<aD7kcFupREh4lW0s@debian-BULLSEYE-live-builder-AMD64>
	<aD78Di51VHxtOtJG@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Jun 2025 16:43:42 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Tue, Jun 03, 2025 at 09:02:56AM -0300, Marcelo Schmitt wrote:
> > On 06/03, Andy Shevchenko wrote:  
> > > On Mon, Jun 02, 2025 at 01:54:25PM -0300, Marcelo Schmitt wrote:  
> 
> ...
> 
> > > > > > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > > > > > +{
> > > > > > +	/*
> > > > > > +	 * The use of static_assert() here is to make sure that the comparison
> > > > > > +	 * is adapted whenever struct ad4170_setup is changed.
> > > > > > +	 */  
> > Does the reason given in the comment justify the use of static_assert?  
> 
> Should I repeat myself? It makes a little sense when no memcmp() is involved.

The intent I think is to reduce the chance of a field being added without
this match function being updated.   Not a very strong test but maybe
better than nothing...

Not sure how memcmp() is relevant.

> 
> > > > > > +	static_assert(sizeof(*a) ==
> > > > > > +		      sizeof(struct {
> > > > > > +				     u16 misc;
> > > > > > +				     u16 afe;
> > > > > > +				     u16 filter;
> > > > > > +				     u16 filter_fs;
> > > > > > +				     u32 offset;
> > > > > > +				     u32 gain;
> > > > > > +			     }));  
> > > > > 
> > > > > I think it doesn't make much sense unless one uses memcpy().  
> > > > 
> > > > memcpy() is used to update the setups after reg write succeeds.
> > > > Also, previously, memcmp() was used to compare setups.
> > > > Since struct ad4170_setup has only unsigned integers (no floating point fields
> > > > like ad7124 had [1]), ad4170 works properly when comparing setups with memcmp().
> > > > Though, it was asked to do explicit field matching on previous reviews [2] so
> > > > that's how it had been since then. Well, both ways work for ad4170. We can
> > > > compare setup with memcmp(), or do the comparison field by field. I don't mind
> > > > changing it again if requested. I guess we only need to reach an agreement about
> > > > what to go with.  
> > > 
> > > The question was "why do you need the static_assert() now?"  
> > 
> > To ensure that the comparison function gets updated if struct ad4170_setup is
> > ever modified? This intends to be similar to what was implemented in ad7124
> > driver as the chips have similar channel configuration mechanisms. We also
> > have ad7173 and ad4130 using static_assert for analogous purpose. There was
> > also a comment about static_assert above.  
> 
> Does this won;t work if you changes field types? (Assuming only integers to
> integers) I believe it doesn't affect the field-by-field comparison.
> 
> The other drivers may have different approach, have you studied them? Do they
> use memcmp()
> 
> > > > [1]: https://lore.kernel.org/all/20250303114659.1672695-13-u.kleine-koenig@baylibre.com/
> > > > [2]: https://lore.kernel.org/linux-iio/20250504192117.5e19f44b@jic23-huawei/
> > > >   
> > > > > > +	if (a->misc != b->misc ||
> > > > > > +	    a->afe != b->afe ||
> > > > > > +	    a->filter != b->filter ||
> > > > > > +	    a->filter_fs != b->filter_fs ||
> > > > > > +	    a->offset != b->offset ||
> > > > > > +	    a->gain != b->gain)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	return true;
> > > > > > +}  
> 


