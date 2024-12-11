Return-Path: <linux-iio+bounces-13367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895089ED92C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 22:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1028A188523B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DF81F0E52;
	Wed, 11 Dec 2024 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/jfkras"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7601F0E49;
	Wed, 11 Dec 2024 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954315; cv=none; b=J6vBVQi1pb1BssU0SwtB07NGnxZt4WuTFNcqhczBKGc1yrnqM9L4xjlGiK1XAEQfBSnFMd6l5SWEw7Hy2ENBcZXwStAMaRYT5HXm1x+GCk6c2taVsoSBeQFThEjKE6Iwy8gqVQhklIBQtD0PGRwJPG8slIRK1Mt9wMftzDZqFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954315; c=relaxed/simple;
	bh=mtRfsIDJx8TKtmUkrUZxBiLI1Kd/1ErosmAyqYokDjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW8UC/IgcL2B8OZGogstpE0VtzYL7Cb2lPHjLPQcKMQQ/huTfl4Yq7/xxUHL0jlROY8o+uBTFcEBEDbf8MUfyPVcb+XGZUplxCWphWyy2sysifLN/GPwZdupapNwhRGJmXXzH7HR0n3NJ6IoKWmny0G20H8eQhEvQbbjYepiZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/jfkras; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35399C4CED2;
	Wed, 11 Dec 2024 21:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733954314;
	bh=mtRfsIDJx8TKtmUkrUZxBiLI1Kd/1ErosmAyqYokDjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/jfkras2NRtVqAh7LiClOWpI5RyUvhMDUbgIz3VV9uaaMHJCupsi0QORUIk1XSxy
	 Wu3rJ3MWiS9av/p85iwBVrqJiSzIUPiZXcqU0OuMRPMJA7VaaQS9LRlrB+Bdue/xH0
	 bB32VTAULDRvBoZAm1s97Xss/8XYLQqKDiOuuGiJz9Ky8nnDtcraedbRVpxVt51w2/
	 c4T2k3LfFp0AdiWX/OvMa7qXWF/5mvZ59H6tSXgCFpExuTD7G+mQZWj/7uUlUiU/zs
	 5iP+aIJibDrKFGM3dR/LIGjnZJM5yhdLeMA5p+TS18ajwsjnQnTpUlmYekO/qCnHp4
	 xOSvzVUpPp5fg==
Date: Wed, 11 Dec 2024 21:58:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
 andre.przywara@arm.com, lee@kernel.org, wens@csie.org, sre@kernel.org,
 lars@metafoo.de, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
Message-ID: <20241211215826.06162190@jic23-huawei>
In-Reply-To: <20241210224859.58917-1-macroalpha82@gmail.com>
References: <20241210224859.58917-1-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 16:48:57 -0600
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> After performing a git bisect, I identified a commit that broke the
> battery and charger driver for my AXP717 PMIC. This was caused by
> commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators").
> 
> After digging into it, it appears when mfd_add_devices was called with
> a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_get() call
> made by the various AXP20X power drivers would not be able to generate
> a dev_name(dev) for some reason, and the iio_channel_get() call used in
> the devm_ helper would fall back to making a iio_channel_get_sys()
> call. After the platform ID was updated, now iio_channel_get() is no
> longer falling back to iio_channel_get_sys(). At least this is my
> limited understanding of what happened.

The dev_name(dev) not getting a name doesn't sound quite right to me.

Time to look at the ancient creaking ghost that is the iio_map handling. 

struct iio_channel *iio_channel_get(struct device *dev,
				    const char *channel_name)
{
	const char *name = dev ? dev_name(dev) : NULL;
	struct iio_channel *channel;

	if (dev) {
		channel = fwnode_iio_channel_get_by_name(dev_fwnode(dev),
							 channel_name);
		if (!IS_ERR(channel) || PTR_ERR(channel) != -ENODEV)
			return channel;
	}

	return iio_channel_get_sys(name, channel_name);
}
EXPORT_SYMBOL_GPL(iio_channel_get);

We didn't invent the relevant phandle stuff in DT via the patch you point at
so all that matters is what gets passed to that iio_channel_get_sys()

So key here is that dev should be set, so we are passing dev_name(dev) into
iio_channel_get_sys()
I'm guessing that changed... 

Ah.  The iio_maps in
https://elixir.bootlin.com/linux/v6.12.4/source/drivers/iio/adc/axp20x_adc.c#L158
are our problem. Those hardcode the consumer_dev name. The fix just changed
those names. Back when this infrastructure was written we were in the world of
board files, so everything was hard coded in them - or in an MFD like this
it was treated as a singleton device.

So as to how to fix it... Assuming the new device names are the same for all
the mfd parts that make up each pmic, then you should be able to figure out the
 extra the number and build the channel maps to allow you to find the numbered
devices.

That's a lot lighter change than moving over to DT based phandles for all this.
(which is the modern way to handle it).

As a cheeky check, just edit those maps to whatever IDs you have and see
if it works.  Probably not an upstreamable solution but will confirm we have
it correct.

Your patch works because we allow for some fuzzy matching (I can't remember
why) that doesn't use the consumer device name.
That works as long as there is only one instance.  I'm guessing all this
mess came about because someone has a board with two of these devices. On such
a board we need the precise matching including the device name.

Jonathan

> 
> To fix this, I added a new devm_ helper of devm_iio_channel_get_sys()
> that directly calls iio_channel_get_sys(), and I updated all the
> affected drivers with the new routine. I then no longer experienced
> any issues with the drivers on my devices.
> 
> Chris Morgan (2):
>   iio: core: Add devm_ API for iio_channel_get_sys
>   power: supply: axp20x: Use devm_iio_channel_get_sys() for iio chans
> 
>  drivers/iio/inkern.c                    | 18 ++++++++++++++++++
>  drivers/power/supply/axp20x_ac_power.c  |  4 ++--
>  drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
>  drivers/power/supply/axp20x_usb_power.c |  6 +++---
>  include/linux/iio/consumer.h            | 20 ++++++++++++++++++++
>  5 files changed, 51 insertions(+), 13 deletions(-)
> 


