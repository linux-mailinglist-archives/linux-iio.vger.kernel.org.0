Return-Path: <linux-iio+bounces-16390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71284A4EB98
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457D47AA47C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C1290091;
	Tue,  4 Mar 2025 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaQ4KsRb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004323A992;
	Tue,  4 Mar 2025 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112294; cv=none; b=hGg2sQnbe3jUoAZaAlBjadajroIW6Oaa1vcO2QmOETzmnwieIqCZBoC77MIm4+kupLxPKtdF8SZ2WNziaLGY9i2qLJL4D39ST6xBoVUMJqNeAji13kflTJ3n3Jyq/G8MUk8BIoHB0YxnF02SReZP6OWHDcGszi8/KgDM8Ul6Bf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112294; c=relaxed/simple;
	bh=0rWoi9sOTkydlHrr+99ixe/DLfbAvgSbUMg9GwlQiRw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAQ1grcCOGam3MZJdjppeTGgrOB1N+9PW+6mvIbH9cDT5zMu963AcZPgvqMXpG1DFFaiTSbrzULXuxkZ+jlmggr5o3kDseLiGQe5rBOjJoSDq4nUwsW0bht5f3Dv3Lv3HJhVCELSmxjgkiwwRn90V8K8RfKLBlz1MY0liJ+UFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaQ4KsRb; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f556b90790so1356832b6e.0;
        Tue, 04 Mar 2025 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741112292; x=1741717092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W2cQF9unlo/BmJtKzaBmA4Dm/hPukihoQePLlVpussA=;
        b=CaQ4KsRb3mA3LXT1xb4O/jx4KJIaxn524plJ+zYBN+i3DX4GLuPhJC7a+9lt5SmHxr
         4AbgGjWYhY9HAeK5ug5pv+c1Fuwmsjeg8Q7FqnLbNAtSwXKKopHz+Lv7NH9rtYNw4Xxn
         JNgOqPdd8Sv8CvJcusgUXqKqDQwPIQwyPf27traeZ0TMUnjUphNOAM3d6vwRgWhV3Y9e
         0xpeGrwdI9l2ZdbiaxfmEeyCijc/D5gNKygHoFY7wtUrih7s6ktGkfCLmcJgtgw64fsH
         5tMMPpL/dJWSAVpTKWK11iT+BTBF1L9IqtoN/QFgC2IZusZiVNJirfyNyhCw6VO2JXQa
         dVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741112292; x=1741717092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2cQF9unlo/BmJtKzaBmA4Dm/hPukihoQePLlVpussA=;
        b=pwoaKZYHvnik/pOf2i4j8LcyhpQaRoXlto36e96369pCYr4/dzt0zAdKYji/TULPTg
         qRgwMD62M6Kr5R3/00DFe1plOuiOzC8y4qe3zoI10WGpMOFAECLrScfMyoRjOnSpeSJX
         Taw/c3Tnsk5EVOucmn9fJvBKTQzC2W6C2anojNKVCn0TJi4ImG2iLzCgUooWAKuI9spK
         hH2J+cH/sMHw0ecNJ0zJFg3B0ACtbudy+KIRIbn0KYD6M6zAjaWstUhlmexh24zzsZzs
         rT85sqKMWtrMBfxqW53MKJ2EAnRXvN0S1tyR0WOj0/QuQk5ByMmHIA53ziPjLwhRNitl
         ykSw==
X-Forwarded-Encrypted: i=1; AJvYcCWIVgfStiRINwdjqvR0/gH8vMf1OL9kXlIqDdhNC5ExV5AFbmuCnZX+dIImcKrXyYbdnMesjJv3bJU=@vger.kernel.org, AJvYcCWKhABopiKO+aX0CAsQdKhrhgHxw0XMMAlZZHstC3lEBRrbqYv8zoU0tyz/TcmuHlXbjrv7Hz3g71s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrini3aCpq6nwaatWqMY73FmDyKclHCWoRLln+dRTchbXF1P8
	I4M+4pEiuH8YR0WQ9l6EpD4OHUdZkB7cw2xCvJ3bIguBFPC8tPX1
X-Gm-Gg: ASbGncvjRRMJwS/keMA5otYFcE6e1n6Uct2ubeIH93qAmeIKBMsSkqyQlyAe7DYWvQ6
	MUfXlc+sTOuxkkc1U6YYQ+STK3uyUS5hMHf6EXCmVhwAUbNO22nrq7SuZ1itNGqHokRJCQU8zj8
	AqsdcyJ4BgoojyFYtbSyZCJ84QSvu+XiqU01YmOHAC+f0ZVYabW9ms1OpMGYPLLl021CNDyFpbV
	n0ZJcMGwSZNu4W9k17h33aMDr7a7zuTDbHZzAhyP1qYm5TNVYg0OoaLBq6IXWX6Em+vPRzuJ+/w
	8nOC0pU+fGi/0wNiWQVMslbmTzZ6edfE0B5VVjpf97m/6jjTocW8
X-Google-Smtp-Source: AGHT+IE+aLlChk6lQijuZTt9YQfrJ2HVaeAGxXKHK9WTRDvUGIFcAD03B/ztFbasRdDNmVWrsc+0fw==
X-Received: by 2002:a05:6808:2e85:b0:3f3:fb4e:f5b5 with SMTP id 5614622812f47-3f5585256a9mr11969079b6e.12.1741112291629;
        Tue, 04 Mar 2025 10:18:11 -0800 (PST)
Received: from neuromancer. ([2600:1700:fb0:1bcf:e5be:37f5:61db:7fd9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f676b0c205sm544863b6e.44.2025.03.04.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:18:11 -0800 (PST)
Message-ID: <67c743e3.050a0220.327e31.55b3@mx.google.com>
X-Google-Original-Message-ID: <Z8dD4ktEW69zIpJm@neuromancer.>
Date: Tue, 4 Mar 2025 12:18:10 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, andre.przywara@arm.com, lee@kernel.org,
	sre@kernel.org, lars@metafoo.de,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 0/2] Fix Regression with AXP20X for 6.13-rc1
References: <20241210224859.58917-1-macroalpha82@gmail.com>
 <20241211215826.06162190@jic23-huawei>
 <67606b09.050a0220.3905d.5bc7@mx.google.com>
 <CAGb2v64vn-h02Bn2AKftphpNNcx9h9K3pKvdjuANsDhwiqbsrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v64vn-h02Bn2AKftphpNNcx9h9K3pKvdjuANsDhwiqbsrQ@mail.gmail.com>

On Tue, Dec 17, 2024 at 02:04:37AM +0800, Chen-Yu Tsai wrote:
> On Tue, Dec 17, 2024 at 2:01 AM Chris Morgan <macroalpha82@gmail.com> wrote:
> >
> > On Wed, Dec 11, 2024 at 09:58:26PM +0000, Jonathan Cameron wrote:
> > > On Tue, 10 Dec 2024 16:48:57 -0600
> > > Chris Morgan <macroalpha82@gmail.com> wrote:
> > >
> > > > From: Chris Morgan <macromorgan@hotmail.com>
> > > >
> > > > After performing a git bisect, I identified a commit that broke the
> > > > battery and charger driver for my AXP717 PMIC. This was caused by
> > > > commit e37ec3218870 ("mfd: axp20x: Allow multiple regulators").
> > > >
> > > > After digging into it, it appears when mfd_add_devices was called with
> > > > a platform ID of PLATFORM_DEVID_NONE, the devm_iio_channel_get() call
> > > > made by the various AXP20X power drivers would not be able to generate
> > > > a dev_name(dev) for some reason, and the iio_channel_get() call used in
> > > > the devm_ helper would fall back to making a iio_channel_get_sys()
> > > > call. After the platform ID was updated, now iio_channel_get() is no
> > > > longer falling back to iio_channel_get_sys(). At least this is my
> > > > limited understanding of what happened.
> > >
> > > The dev_name(dev) not getting a name doesn't sound quite right to me.
> > >
> > > Time to look at the ancient creaking ghost that is the iio_map handling.
> > >
> > > struct iio_channel *iio_channel_get(struct device *dev,
> > >                                   const char *channel_name)
> > > {
> > >       const char *name = dev ? dev_name(dev) : NULL;
> > >       struct iio_channel *channel;
> > >
> > >       if (dev) {
> > >               channel = fwnode_iio_channel_get_by_name(dev_fwnode(dev),
> > >                                                        channel_name);
> > >               if (!IS_ERR(channel) || PTR_ERR(channel) != -ENODEV)
> > >                       return channel;
> > >       }
> > >
> > >       return iio_channel_get_sys(name, channel_name);
> > > }
> > > EXPORT_SYMBOL_GPL(iio_channel_get);
> > >
> > > We didn't invent the relevant phandle stuff in DT via the patch you point at
> > > so all that matters is what gets passed to that iio_channel_get_sys()
> > >
> > > So key here is that dev should be set, so we are passing dev_name(dev) into
> > > iio_channel_get_sys()
> > > I'm guessing that changed...
> > >
> > > Ah.  The iio_maps in
> > > https://elixir.bootlin.com/linux/v6.12.4/source/drivers/iio/adc/axp20x_adc.c#L158
> > > are our problem. Those hardcode the consumer_dev name. The fix just changed
> > > those names. Back when this infrastructure was written we were in the world of
> > > board files, so everything was hard coded in them - or in an MFD like this
> > > it was treated as a singleton device.
> > >
> > > So as to how to fix it... Assuming the new device names are the same for all
> > > the mfd parts that make up each pmic, then you should be able to figure out the
> > >  extra the number and build the channel maps to allow you to find the numbered
> > > devices.
> >
> > Is there a way to figure out the device number at runtime? The issue is
> > each time the device attempts to probe and fails, the device number
> > increments, making it a "hitting a moving target" problem.
> 
> The ADC device is a mfd cell or child device of the PMIC mfd device.
> So you should be able to use dev->parent to get it directly? We do
> that at least for the regulator driver.

Sorry to dig up such an old thread. I'm taking a look at this one again
and can confirm passing pdev->dev.parent to devm_iio_channel_get() is
insufficient to get the driver to find the correct ADC channel. Would
there be another/better way to do this other than the
devm_iio_channel_get_sys() as proposed? Or should we be walking the
parent somehow looking for the named ADC channel on each child device
(which would also require a new symbol most likely)?

Thank you,
Chris

> 
> ChenYu
> 
> > Thank you,
> > Chris
> >
> > >
> > > That's a lot lighter change than moving over to DT based phandles for all this.
> > > (which is the modern way to handle it).
> > >
> > > As a cheeky check, just edit those maps to whatever IDs you have and see
> > > if it works.  Probably not an upstreamable solution but will confirm we have
> > > it correct.
> > >
> > > Your patch works because we allow for some fuzzy matching (I can't remember
> > > why) that doesn't use the consumer device name.
> > > That works as long as there is only one instance.  I'm guessing all this
> > > mess came about because someone has a board with two of these devices. On such
> > > a board we need the precise matching including the device name.
> > >
> > > Jonathan
> > >
> > > >
> > > > To fix this, I added a new devm_ helper of devm_iio_channel_get_sys()
> > > > that directly calls iio_channel_get_sys(), and I updated all the
> > > > affected drivers with the new routine. I then no longer experienced
> > > > any issues with the drivers on my devices.
> > > >
> > > > Chris Morgan (2):
> > > >   iio: core: Add devm_ API for iio_channel_get_sys
> > > >   power: supply: axp20x: Use devm_iio_channel_get_sys() for iio chans
> > > >
> > > >  drivers/iio/inkern.c                    | 18 ++++++++++++++++++
> > > >  drivers/power/supply/axp20x_ac_power.c  |  4 ++--
> > > >  drivers/power/supply/axp20x_battery.c   | 16 ++++++++--------
> > > >  drivers/power/supply/axp20x_usb_power.c |  6 +++---
> > > >  include/linux/iio/consumer.h            | 20 ++++++++++++++++++++
> > > >  5 files changed, 51 insertions(+), 13 deletions(-)
> > > >
> > >

