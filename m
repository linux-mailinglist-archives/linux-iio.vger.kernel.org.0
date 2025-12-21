Return-Path: <linux-iio+bounces-27284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C5CD43D1
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7BD43004CA0
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236E303CA0;
	Sun, 21 Dec 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFut0Czu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE342FF140;
	Sun, 21 Dec 2025 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766341320; cv=none; b=fywW1KAG/T47bfR6YCyDpHRT052TxvEYTWsn55+sfMgrWuRUghdfd8Djur5fs7z94PgebE2j0d9/eFDUvyJsqVwU3a9/uAU7/3cLNi+GW0Nd1MMBwT/8QltjgZih9apFNxLaVsTqHnBRK7GVu6LiBdzDLqa/pEUXwH9Kwmz/4gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766341320; c=relaxed/simple;
	bh=yDqU3f1pUnnhvYYFPr+oGxLF2DVqq0c84LHt92WqAl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHvuuvtJYjkV9OFTqePCjrWOR7ak83HJkNZPphWPhtyKObUrdD41U/lTxUdeJf0pWiqhlBMbI8oGFG5Jpav8OtT0qF5b7dEZn7hftj8UMQ3USELUygUo6JkpW55oQ6N2d5D7zyXjmq4HSBLh0BZUPFgc6lc6l1dqnIhJICPxPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFut0Czu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72AC4CEFB;
	Sun, 21 Dec 2025 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766341319;
	bh=yDqU3f1pUnnhvYYFPr+oGxLF2DVqq0c84LHt92WqAl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NFut0CzuVKjNdRsVPRtfJEGckui9t/WYAU3avyafPuJlADisd8sXwI5mmaGwl2z+S
	 aIPyhHhjFs+s9ckPuyFvRuCxZDIgUhp85f/NEmlWdpIkLrBbEvBpqmDRIfgzDrTWGo
	 m796JEGSDU0GxZTJKUGQjwjCdjEoEyNMeoRrKaxjmGtPultJHKqXQObJnl/3TEHTJy
	 3AfUtC3k0PTxPLymrtCpQoGGxAlJBMftFAr2Vy3MntXIBjki6YDNQyBO8d8xbloBs0
	 8Qr91uXDs6AqQI5j7Kc/evO0laSduJMNUiqFy/SOK3wRgAWG0BlN/ZaI+vxV/MLU2z
	 3iXB6WrP0YlbA==
Date: Sun, 21 Dec 2025 18:21:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <20251221182151.288a6da4@jic23-huawei>
In-Reply-To: <aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
	<aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
	<aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Dec 2025 10:25:19 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello,
> 
> On Sat, Dec 20, 2025 at 01:47:05AM -0300, Marcelo Schmitt wrote:
> > On 12/18, Petre Rodan wrote:  
> > > Zero out input buffer before reading the new conversion.
> > > Perform this operation in core instead of in the bus specific code.
> > > 
> > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > ---
> > >  drivers/iio/pressure/mprls0025pa.c     | 2 ++
> > >  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> > > index 00b1ff1e50a8..7cc8dd0d8476 100644
> > > --- a/drivers/iio/pressure/mprls0025pa.c
> > > +++ b/drivers/iio/pressure/mprls0025pa.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > >  #include <linux/property.h>
> > > +#include <linux/string.h>
> > >  #include <linux/units.h>
> > >  
> > >  #include <linux/gpio/consumer.h>
> > > @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
> > >  		}
> > >  	}
> > >  
> > > +	memset(data->rx_buf, 0, sizeof(data->rx_buf));  
> > This is unusual and I don't think it's needed for the SPI path. Doesn't the I2C
> > subsystem overwrite the rx buffer with what it reads from the device?  
> 
> I thought it's best practice to ensure that old conversions are not accidentally re-used in case the read operation fell thru the cracks.
> that's exactly why in this particular case the BUSY flag is implemented on the hardware side.
> 
> please tell me how a few byte memset() would be detrimental.

We don't normally do this as old data isn't a potential leak of anything
sensitive.  However in most drivers this only spills out at all as
a result of say a change in configured channels and is normally harmless
as userspace knows to ignore stuff in the gaps anyway.  If there is
another cases here (you mention the busy flag) then add a comment on why
it makes sense. I don't in general want drivers to start doing this as
it is in the fast path and sometimes the memset is non trivial (here it
is probably irrelevant as the buffer is small).

Thanks,

Jonathan

> 
> best regards,
> peter
> 
> > >  	ret = data->ops->read(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
> > >  	if (ret < 0)
> > >  		return ret;
> > > diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
> > > index a0bbc6af9283..0fe8cfe0d7e7 100644
> > > --- a/drivers/iio/pressure/mprls0025pa_i2c.c
> > > +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> > > @@ -25,7 +25,6 @@ static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
> > >  	if (cnt > MPR_MEASUREMENT_RD_SIZE)
> > >  		return -EOVERFLOW;
> > >  
> > > -	memset(data->rx_buf, 0, MPR_MEASUREMENT_RD_SIZE);
> > >  	ret = i2c_master_recv(client, data->rx_buf, cnt);
> > >  	if (ret < 0)
> > >  		return ret;  
> 


