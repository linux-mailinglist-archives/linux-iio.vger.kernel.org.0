Return-Path: <linux-iio+bounces-2986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930548624B9
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7121C21AFF
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6129437;
	Sat, 24 Feb 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyCCxW+2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8F1798C;
	Sat, 24 Feb 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775372; cv=none; b=EvziXkoCjtTUIbhPFWw89Cf9d+OYJ/DDD91BBN8Cdl8FnWCi8CTJIXCsovt1HIdld0Ow+sy995ORD5FfUC6FvlRxxH42O75THlJ4XeLzNFW1aeafrkM3FJr+P1vkAZLs3ToFsi5d4+Eeq143rheecwQixI1NsMpkRCuPvVYfF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775372; c=relaxed/simple;
	bh=FPQ9lETrmP4wu/O2ohnbZ8lLxVvGDSsrtykAtXiGb/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnqrlbyukNYOuMGA/z2m3wGdwvO8JZxd/pNPLxPTSBOgohJj6vy1lAS7+wT4DjYQeOXf4psxknaV8n41v7fqp/dYCPF0WXZY/QfYivHHp1BMeHB9z4fCwufzw+QAXcX19FhhiAm4qIopUqC8LYzCqk5GYdUOHpySZwAeRVr5DTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyCCxW+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFB2C433C7;
	Sat, 24 Feb 2024 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708775371;
	bh=FPQ9lETrmP4wu/O2ohnbZ8lLxVvGDSsrtykAtXiGb/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iyCCxW+2ph3NSLrdFDhsSdJ2JZB+3Ouy6wSmXvwtHD/dnqn1H3Lt2gIl5mzJDicX7
	 bUtE8wrf0b7rfTE0yLrwAA34lRdEoDvcfEtlcv/oGOHUwcTlIvnCUA6pNwu+bu3dcO
	 bz34ANvj/ZzxgJYYbnaXpru6j37GwgLZvAsxz05W5A9rCUAN8vAS/TZu17yuL3Lq6y
	 mF4x7M1fTpu9a7nxO16XU7hnJ+f1iCR5V9dGWZW96oVGQY88z0TweAzUTeDNcKZO0W
	 s5c8n0hUhUHxDHUrNvqLe7zLH2Z2aj/FPCYTAUWpJSje72CwSbvwR+SymRyNeF2Gw8
	 2yKQEGsI3vUEA==
Date: Sat, 24 Feb 2024 11:49:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 <linux-iio@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/15] device property / IIO: Use cleanup.h magic for
 fwnode_handle_put() handling.
Message-ID: <20240224114912.6da6aa9d@jic23-huawei>
In-Reply-To: <20240219154947.0000681b@Huawei.com>
References: <20240217164249.921878-1-jic23@kernel.org>
	<ZdNAQi6IlMN-quO_@smile.fi.intel.com>
	<20240219154947.0000681b@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 15:49:47 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 19 Feb 2024 13:49:22 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Sat, Feb 17, 2024 at 04:42:34PM +0000, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Sorry for the rapid resend, Andy noticed I'd messed up creating the v3 patch
> > > set with some updates committed in the wrong patch.
> > > 
> > > Since v3: The updates to alignment of device_for_each_child_node_scopd() were
> > >     in the wrong patch. Move them to patch 4 where they should always
> > >     have been. (thanks Andy!)
> > > 
> > > Since v2: Thanks to Sakari and Andy for reviews.
> > > - New first patch moving fwnode_handle_put() into property.h
> > > - Tweak alignment in the loop macro
> > > - Pick up tags.
> > > - scopd -> scoped typo fix in some patch descriptions.
> > > 
> > > As can be seen by the examples from IIO that follow this can save
> > > a reasonable amount of complexity and boiler plate code, often enabling
> > > additional cleanups in related code such as use of
> > > return dev_err_probe().
> > > 
> > > Given we are now fairly late in the cycle, I'd expect to take this
> > > through the IIO tree and we can make use of it elsewhere next cycle.
> > > 
> > > Note I don't have the hardware so this is compile tested only.
> > > Hence I'd appreciate some Tested-by tags if anyone can poke one of the
> > > effected drivers.
> > > 
> > > Julia Lawal has posted some nice coccinelle magic for the DT equivalents.
> > > Referenced from that cover letter.  Similar may help us convert more
> > > drivers to use this new approach, but often hand tweaking can take
> > > additional advantage of other cleanup.h based magic, or things like
> > > return dev_err_probe().
> > > https://lore.kernel.org/all/20240211174237.182947-1-jic23@kernel.org/    
> > 
> > It seems you are got all necessary tags to go.  
> 
> Light on the driver changes to use it, but seems that we have
> reached convergence on the infrastructure.

What I'll do in the short term is pick up the changes that have been
reviewed and gained tags (so the infrastructure plus a few of the driver
changes) and then send a v5 with the remainder. I suspect the driver
changes have gotten lost in the deluge as IIO has been very busy this week.

Whilst I will occasionally pick up my own IIO changes with out review
tags I normally only do that for trivial stuff like build fixes.
These are simple but not simple enough!

So applied patches
1,2,4,5,12 and 15 to the togreg branch of iio.git which will be initially
pushed out as testing for 0-day to look at it.

Thanks,

Jonathan

> 
> I'll let it sit until the end of the week though as I want to
> get a pull request out anyway before taking this into my tree.
> 
> 
> > I commented with some side notes that may be addressed later on.
> > Up to you.  
> Thanks. I'll catch up with those shortly. 
> 
> Jonathan
> 
> >   
> 


