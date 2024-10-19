Return-Path: <linux-iio+bounces-10774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415D19A4D3E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDA9B221F4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B51E04A5;
	Sat, 19 Oct 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlVWWSpG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F31E00A2;
	Sat, 19 Oct 2024 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729338650; cv=none; b=VerpQ9ESPtMG/1/XxgBDsQtOAQi0Mn5l0xw81OauCBnUHMxt97sjCgnBkCnOrjpbTDbVmbgC1v4K1QHrHw4bV+ratpTNV8IX4z2uPhrSFr0mrcSF1NmP+eEkHk7pC2CGByzEsgDgGQYZy8ZrEfxS+V9M8TJhCxFBlG7Nes2AEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729338650; c=relaxed/simple;
	bh=UF88XjBA4TjV9HP12LMIErvhKTzP0Epzl0HzZ5AyxUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em7uLx1fTdogHNqYWAovbIREylir7bC82rpssJ/m/obcpVUMTJhL8itVcEszU0VIEwshjFoD5DzP53EvtGcaiEZx9t1VITnjl34dNNfIVD81od3QW4lZStBJSo9EghKWdveswFqgJ8WwXUhlXMIQ2SBlpkcCj8ZkhSQC18hozX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlVWWSpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F74EC4CEC5;
	Sat, 19 Oct 2024 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729338650;
	bh=UF88XjBA4TjV9HP12LMIErvhKTzP0Epzl0HzZ5AyxUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VlVWWSpGfFgq6l2uJ4tEWzg4y2o2v9GVmcm859TKizH7FU3fu5JIH3/DvG9+8lbwX
	 MpP6guuUo6KTzKcRVMA6HnDcjNOd5h7Cn72/mMFGIOpFrDfX2+Jna/cxduJgR8XK0Y
	 PQSO80/n4jPGdDPXXIl8k50GM75u8IqFsnMxN9M/bFkTNibbhCeHAQhnh0xJG0qJi7
	 F5gdchAYKBwrRW2+MUjLIijpkWiiWkDutbpkfrNcH1fEf0V0AlNsRo4bMqPHH6lHen
	 UhPKOjJBjU2x2P/u+h5nhdrHhe/Ue14BFzi4ldJwAgruEqdHSX6CJLtrbsoxfyOOIQ
	 k+u3pNhtN1DGg==
Date: Sat, 19 Oct 2024 12:50:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers
 <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul Cercueil
 <paul@crapouillou.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <20241019125041.5e85dcce@jic23-huawei>
In-Reply-To: <172916216326.53359.1590082756395527593@njaxe.localdomain>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
	<20241015-iio-read-avail-release-v3-2-ac3e08f25cb3@gmail.com>
	<7qvxz3fuwcjeq2ewv3nterlf72wbymt7np5nnjitzkt6smzh7v@737455c4xapy>
	<172916216326.53359.1590082756395527593@njaxe.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 12:49:23 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Quoting Sebastian Reichel (2024-10-16 23:08:30)
> > Hi,
> > 
> > On Tue, Oct 15, 2024 at 01:06:35PM +0200, Matteo Martelli wrote:  
> > > Consumers need to call the producer's read_avail_release_resource()
> > > callback after reading producer's available info. To avoid a race
> > > condition with the producer unregistration, change inkern
> > > iio_channel_read_avail() so that it copies the available info from the
> > > producer and immediately calls its release callback with info_exists
> > > locked.
> > > 
> > > Also, modify the users of iio_read_avail_channel_raw() and
> > > iio_read_avail_channel_attribute() to free the copied available buffers
> > > after calling these functions.
> > > 
> > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > ---
> > > diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
> > > index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..3db000d9fff9a7a6819631314547b3d16db7f967 100644
> > > --- a/drivers/power/supply/ingenic-battery.c
> > > +++ b/drivers/power/supply/ingenic-battery.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/power_supply.h>
> > >  #include <linux/property.h>
> > > +#include <linux/slab.h>
> > >  
> > >  struct ingenic_battery {
> > >       struct device *dev;
> > > @@ -79,8 +80,10 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
> > >               dev_err(bat->dev, "Unable to read channel avail scale\n");
> > >               return ret;
> > >       }
> > > -     if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2)
> > > -             return -EINVAL;
> > > +     if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2) {
> > > +             ret = -EINVAL;
> > > +             goto out;
> > > +     }
> > >  
> > >       max_mV = bat->info->voltage_max_design_uv / 1000;
> > >  
> > > @@ -99,7 +102,8 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
> > >  
> > >       if (best_idx < 0) {
> > >               dev_err(bat->dev, "Unable to find matching voltage scale\n");
> > > -             return -EINVAL;
> > > +             ret = -EINVAL;
> > > +             goto out;
> > >       }
> > >  
> > >       /* Only set scale if there is more than one (fractional) entry */
> > > @@ -109,10 +113,13 @@ static int ingenic_battery_set_scale(struct ingenic_battery *bat)
> > >                                                 scale_raw[best_idx + 1],
> > >                                                 IIO_CHAN_INFO_SCALE);
> > >               if (ret)
> > > -                     return ret;
> > > +                     goto out;
> > >       }
> > >  
> > > -     return 0;
> > > +     ret = 0;
> > > +out:
> > > +     kfree(scale_raw);
> > > +     return ret;
> > >  }
> > >  
> > >  static enum power_supply_property ingenic_battery_properties[] = {  
> > 
> > It should be enough to declare scale_raw like this at the beginning
> > of the function and otherwise keep it as is when you include
> > <linux/cleanup.h>:
> > 
> > const int *scale_raw __free(kfree) = NULL;  
> 
> Nice! I wasn't aware of it, thanks! I'll try it and submit it in next version.
> 
> I think that also fits for the similar usage in iio_channel_read_min() and
> iio_channel_read_max() as well.

Take care with this + read the documents.
The constructor and destructor should be in one line.
https://lore.kernel.org/all/172294149613.2215.3274492813920223809.tip-bot2@tip-bot2/
specifically the second to last line.

It's a clever tool but use with care!

Jonathan


> 
> > 
> > Greetings,
> > 
> > -- Sebastian  
> 
> Thanks,
> Matteo Martelli


