Return-Path: <linux-iio+bounces-3404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0497A877274
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C921C21239
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F34225DA;
	Sat,  9 Mar 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKUNIbyV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD10BA4D;
	Sat,  9 Mar 2024 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710005625; cv=none; b=blWuoa3+76PL/Rj96zkVEqI9dxDeEV+lquFm76WvCKngdjbj8kwWvq71cXT0qLFv/zEm3b0xHwlMSxuYeovcwSOqH2GgcwG4f1rq1s0owT/5sdK6l8lsUbBeqf2IuBbptyf2JXys4V59k7tWZmxdzY21Nh4hLVsH/GsXLULqOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710005625; c=relaxed/simple;
	bh=43+u3G6xDTCsFtxNzsytl8KImGbMHMBkKuAb0LJ0ric=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJKkE2zRn7gFyAvYYNrJfJTdjwVlm2pCFEYKGe7D38RXONEXjNNs54bJeyAtM+whztuEO9+1+GniuWIva6vSwPc3fwCZgcAeHF7Yn/peIY0HOwtc834xYdmCdLHfoFEpKa9MtmQncdNuqLBWBYOwECbTgixHV14GWPs+SBZNqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKUNIbyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA86C433C7;
	Sat,  9 Mar 2024 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710005624;
	bh=43+u3G6xDTCsFtxNzsytl8KImGbMHMBkKuAb0LJ0ric=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aKUNIbyVZDaESr8d9yZ9VQJ1YcROgg+SeTuAWXtzFOk+kJ+251k5A3a5c+Vct/N7M
	 jWuYIZVhQxEutrLuuWNfJvoo0YKTE/e0bavh8eyqN/YYucQxsUHruuGFa5uF4EZ7gY
	 A77b+A91MtFx0cjdIuBTbCra0ULRwaXpZ7cwR7e4iCzxa5c/DT3tPMqh1KK2UGmXMr
	 4ZYx5SFJ4ofAj3p9KMdMNVwU2MwqJ4bUc2mt8AyX+wjuotH509qrCDwcZFm369R3dG
	 R0eNhdIgFGOvK7KOY3v4d096cqX/P3tz+9RrS/puEO0XZpoT1m2TNzHFskpDoI2Bdp
	 d2FwX8mtEjomA==
Date: Sat, 9 Mar 2024 17:33:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Frank Rowand
 <frowand.list@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, Peter
 Zijlstra <peterz@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, marek.vasut@gmail.com, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH v2 0/4] of: automate of_node_put() - new approach
 to loops.
Message-ID: <20240309173332.277fce7d@jic23-huawei>
In-Reply-To: <20240303115633.41128a62@jic23-huawei>
References: <20240225142714.286440-1-jic23@kernel.org>
	<20240301223942.GA3179769-robh@kernel.org>
	<20240303115633.41128a62@jic23-huawei>
Followup-To: linux-kernel@vger.kernel.org
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Mar 2024 11:56:33 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 1 Mar 2024 16:39:42 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sun, Feb 25, 2024 at 02:27:10PM +0000, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Some discussion occured on previous posting.
> > > https://lore.kernel.org/linux-iio/20240223124432.26443-1-Jonathan.Cameron@huawei.com/
> > > 
> > > Summary:
> > > * fwnode conversions should be considered when applying this
> > >   infrastructure to a driver. Perhaps better to move directly to
> > >   the generic FW property handling rather than improve existing
> > >   of specific code.
> > > * There are lots of potential places to use this based on detections
> > >   from Julia's coccinelle scripts linked below.
> > > 
> > > The equivalent device_for_each_child_node_scoped() series for
> > > fwnode will be queued up in IIO for the merge window shortly as
> > > it has gathered sufficient tags. Hopefully the precdent set there
> > > for the approach will reassure people that instantiating the
> > > child variable inside the macro definition is the best approach.
> > > https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/
> > > 
> > > v2: Andy suggested most of the original converted set should move to
> > >     generic fwnode / property.h handling.  Within IIO that was
> > >     a reasonable observation given we've been trying to move away from
> > >     firmware specific handling for some time. Patches making that change
> > >     to appropriate drivers posted.
> > >     As we discussed there are cases which are not suitable for such
> > >     conversion and this infrastructure still provides clear benefits
> > >     for them.
> > > 
> > > Ideally it would be good if this introductory series adding the
> > > infrastructure makes the 6.9 merge window. There are no dependencies
> > > on work queued in the IIO tree, so this can go via devicetree
> > > if the maintainers would prefer. I've had some off list messages
> > > asking when this would be merged, as there is interest in building
> > > on it next cycle for other parts of the kernel (where conversion to
> > > fwnode handling may be less appropriate).    
> > 
> > I'll let you take it. For the series:
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > I've got some drivers/of/ conversions too, but they are probably next 
> > cycle at this point.
> > 
> > Rob  
> 
> Thanks Rob,
> 
> Whether this makes it for this cycle is probably dependent on whether
> Linus does decide to do got to rc8 as hinted at as a possibility
> + whether Greg feels comfortable taking these through his tree
> (char-misc is the normal path for IIO).  I know various people
> are hoping this series makes it, but if doesn't we can do an immutable
> tree early next cycle (though obviously that may reduce speed of adoption).
> 
> We are discussing the equivalent pull request for the fwnode version here:
> 
> https://lore.kernel.org/linux-iio/2024030239-gift-cabdriver-266b@gregkh/T/#m87e7208820ebf6416a77a2973773b65a087b4796
> 
> I've optimistically applied this series to my togreg-cleanup branch
> and merged that into the togreg branch of iio.git for linux-next to pick up.
> 

Greg, would you consider a last minute pull request for these, or picking them up
directly?  It would be helpful for Rob's follow ups and the work Julia is doing
with coccinelle and automating of locating cases to apply this approach.

If the device_for_each_child_node_scoped() series is fine this is almostly
exactly the same thing for the device tree specific case. Not sure what your
plans are for that pull request so I might be jumping the gun.

If not (and assuming the generic property version does make it in) I'll do
an immutable branch based on rc1 so that others can build on this via that.
Fiddlier solution for everyone but given how late we are, perhaps the wiser
one.

FWIW they've been in linux-next a week without issue.

Jonathan


> Thanks,
> 
> Jonathan
> 


