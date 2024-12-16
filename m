Return-Path: <linux-iio+bounces-13549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A1B9F388A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 19:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230C21882287
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385DB20B20C;
	Mon, 16 Dec 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpXevEET"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F220B1F7;
	Mon, 16 Dec 2024 18:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372109; cv=none; b=CEzV6Kl6K+8aLPwWJR9WeG7enSOCz77KI3uY8CJVeQoMl2j/PSS/jhn1iDucHDJagaysuYFA/vef/VxuWeGUgiR6+FF1WBgIKw0s61qWIvIjyf57N3ki2oua9OmNSH0gAJ07nk5LaW2Sm2a5JWWfEgXO6EKjC/daDYFeeyEdTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372109; c=relaxed/simple;
	bh=bMkdDg7KXMyQUIXyWwV466xkGSRLO/v4NElIK9lbNMA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2nmTURpjWhss1jRNn7z1rDMs8OqgTqB3eLoo+vCXnb+J/Gyxm6A6HvtmVa+e3D3pb8gmc6xQUxEDg4iCeEW6l1jKo6DfRKurxPV9M4qJusnpj3c2UcGWlHeHNsmXSEAUojv33kAzuMoQeZ1/2YSbvMlWfaNY8Gqz+Nuvzqwnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpXevEET; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e17ab806bso2399618a34.2;
        Mon, 16 Dec 2024 10:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372106; x=1734976906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xw+uyCaVO9HpfMH4azX0y4S8Gld/qa/5jQMFg0G1Me0=;
        b=KpXevEET5h3Uc5WbykPnkEoxAl36kS0olAlemfNdtHjjoNWTFlhwPdx+C5Iw0+dD/j
         KPFXOM+hDM4JWZ8Ohi53f5+549qEnMA3O7GjJCp9fvGG92+MBBOKjVnh1nql1TsXx3xl
         nnCeM3f6BvRedEaa5IN7SdyKrJBox2QG0+NJC8MOmXvpL0ePksmyRO2FaL3I+Oqd0l7A
         y+OPwCHa568by0mRmzEppTrirWXoKMQiqojZmh8ZuwGm9S/2o9oUyk8Ip5cGzFOE2oRi
         xzzgkj+AO2uTHK0ZukB52C6wq0zgR/mcMssGLnjsPwX8rEEbf7sri8BXUapMCOItKcrz
         bJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372106; x=1734976906;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw+uyCaVO9HpfMH4azX0y4S8Gld/qa/5jQMFg0G1Me0=;
        b=Uw2NaT0m/K2qCa6jnDM6YKKnOauekrVw9c19p2MeAGSBSgLe96+ZZMYl2fMM6+qeN+
         E55WO7bV0BFADA8CCSwcd01fjaCD8KgZFbBtU+9NxDM0ouafLKbFLaqSvm5nqw+PS4Iu
         WjCbbHqiZtbGfTd3mcAiPRNbbPfdj/pD5dymHXGTay90EFQmiYoQT5W3SCGIa4ocA+Mk
         cjvxnaLIP3ge9WmP5bCGJs5Iwr56G9kx81MRo7TiIDV/NNkOXJola+SCVZwYb+HaIKVf
         f3ujkem+g97pqmwcEvchmsgtZy9FlknyG2C5oF1CfN9QkMjPxHeh8H3xwERC8qVpY4ks
         tCyg==
X-Forwarded-Encrypted: i=1; AJvYcCXa5EYXqmmtR3hdUJjdKImJ5kyeZEgbU6M2uBX+f9yzH5pd4x4b3lMaHevx7jRS9IyWri6JJfWLYQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdnuLwS9eea8YOUDyPY1HnCjGB1sLmDEDZyFyKFW8VqU0y/MQ
	AV3zgY3FiGD8+LJB1hqg6kpmw5Q4jIQKFNGBmSkK9RQpZhaQ1NlFIP3gzg==
X-Gm-Gg: ASbGncusYRFcNBDg0Id1wE1eiuj6AyC3tzB+a/q5rgo4+Wrr9l60gNgJqhNYYHwkh9V
	M2GtUIArt6nuw/Z3RyEqrRiHwQvWzjZDes1KsHhE53n2UasJssB33uiELIZq69xPp7hx1rCn/jm
	aQMdKecNENRqqwa9SERv/UX/bTl3OzYxkc8neuacthknsTrbupExaaIE/jewTvre8VR1iNkxSnH
	LnVKwiJeFDPPWFbjzuTjf8pBs18+HJMwQok7/7V4NU41XX12+Gat8ykWuGH4SXN
X-Google-Smtp-Source: AGHT+IFNpt9P3jjKrQ3tdUWXTe5N3G5KayaUEXJF/46JwvzV6qYJNy/ZAB0lqY9CHLJU/n7/WD8wTQ==
X-Received: by 2002:a05:6830:6995:b0:717:fdb4:c207 with SMTP id 46e09a7af769-71e3ba62e68mr8759599a34.26.1734372106025;
        Mon, 16 Dec 2024 10:01:46 -0800 (PST)
Received: from neuromancer. ([2600:1700:fb0:1bcf:4090:604c:955c:7697])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e484cc754sm1519713a34.60.2024.12.16.10.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:01:45 -0800 (PST)
Message-ID: <67606b09.050a0220.3905d.5bc7@mx.google.com>
X-Google-Original-Message-ID: <Z2BrByIyx87KHMRR@neuromancer.>
Date: Mon, 16 Dec 2024 12:01:43 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	andre.przywara@arm.com, lee@kernel.org, wens@csie.org,
	sre@kernel.org, lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
References: <20241210224859.58917-1-macroalpha82@gmail.com>
 <20241211215826.06162190@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211215826.06162190@jic23-huawei>

On Wed, Dec 11, 2024 at 09:58:26PM +0000, Jonathan Cameron wrote:
> On Tue, 10 Dec 2024 16:48:57 -0600
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > After performing a git bisect, I identified a commit that broke the
> > battery and charger driver for my AXP717 PMIC. This was caused by
> > commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators").
> > 
> > After digging into it, it appears when mfd_add_devices was called with
> > a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_get() call
> > made by the various AXP20X power drivers would not be able to generate
> > a dev_name(dev) for some reason, and the iio_channel_get() call used in
> > the devm_ helper would fall back to making a iio_channel_get_sys()
> > call. After the platform ID was updated, now iio_channel_get() is no
> > longer falling back to iio_channel_get_sys(). At least this is my
> > limited understanding of what happened.
> 
> The dev_name(dev) not getting a name doesn't sound quite right to me.
> 
> Time to look at the ancient creaking ghost that is the iio_map handling. 
> 
> struct iio_channel *iio_channel_get(struct device *dev,
> 				    const char *channel_name)
> {
> 	const char *name = dev ? dev_name(dev) : NULL;
> 	struct iio_channel *channel;
> 
> 	if (dev) {
> 		channel = fwnode_iio_channel_get_by_name(dev_fwnode(dev),
> 							 channel_name);
> 		if (!IS_ERR(channel) || PTR_ERR(channel) != -ENODEV)
> 			return channel;
> 	}
> 
> 	return iio_channel_get_sys(name, channel_name);
> }
> EXPORT_SYMBOL_GPL(iio_channel_get);
> 
> We didn't invent the relevant phandle stuff in DT via the patch you point at
> so all that matters is what gets passed to that iio_channel_get_sys()
> 
> So key here is that dev should be set, so we are passing dev_name(dev) into
> iio_channel_get_sys()
> I'm guessing that changed... 
> 
> Ah.  The iio_maps in
> https://elixir.bootlin.com/linux/v6.12.4/source/drivers/iio/adc/axp20x_adc.c#L158
> are our problem. Those hardcode the consumer_dev name. The fix just changed
> those names. Back when this infrastructure was written we were in the world of
> board files, so everything was hard coded in them - or in an MFD like this
> it was treated as a singleton device.
> 
> So as to how to fix it... Assuming the new device names are the same for all
> the mfd parts that make up each pmic, then you should be able to figure out the
>  extra the number and build the channel maps to allow you to find the numbered
> devices.

Is there a way to figure out the device number at runtime? The issue is
each time the device attempts to probe and fails, the device number
increments, making it a "hitting a moving target" problem.

Thank you,
Chris

> 
> That's a lot lighter change than moving over to DT based phandles for all this.
> (which is the modern way to handle it).
> 
> As a cheeky check, just edit those maps to whatever IDs you have and see
> if it works.  Probably not an upstreamable solution but will confirm we have
> it correct.
> 
> Your patch works because we allow for some fuzzy matching (I can't remember
> why) that doesn't use the consumer device name.
> That works as long as there is only one instance.  I'm guessing all this
> mess came about because someone has a board with two of these devices. On such
> a board we need the precise matching including the device name.
> 
> Jonathan
> 
> > 
> > To fix this, I added a new devm_ helper of devm_iio_channel_get_sys()
> > that directly calls iio_channel_get_sys(), and I updated all the
> > affected drivers with the new routine. I then no longer experienced
> > any issues with the drivers on my devices.
> > 
> > Chris Morgan (2):
> >   iio: core: Add devm_ API for iio_channel_get_sys
> >   power: supply: axp20x: Use devm_iio_channel_get_sys() for iio chans
> > 
> >  drivers/iio/inkern.c                    | 18 ++++++++++++++++++
> >  drivers/power/supply/axp20x_ac_power.c  |  4 ++--
> >  drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
> >  drivers/power/supply/axp20x_usb_power.c |  6 +++---
> >  include/linux/iio/consumer.h            | 20 ++++++++++++++++++++
> >  5 files changed, 51 insertions(+), 13 deletions(-)
> > 
> 

