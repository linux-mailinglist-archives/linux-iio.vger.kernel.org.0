Return-Path: <linux-iio+bounces-27356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5889CDFDB7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C91F730090BB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D2223A98E;
	Sat, 27 Dec 2025 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9mC8cuy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675592222A0;
	Sat, 27 Dec 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766845919; cv=none; b=I+KcgzdUivoygxKJhiXcDDd2L8PRt+NJKU7GIDsnyam4qLdAEIcjv5JcND5ebfvTXtnM5ddy+lML+7pPfuCIp6funn/b54JUFSEI/yR8PC5K0MgfN15DcWxYK8itmNidpv2cmRrQ+H4ery8mIGVqGZIR/l9TBwD7+lWo6i6vneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766845919; c=relaxed/simple;
	bh=+BiTeNfTmnCwqczNtn0sr4nRJ2IlQb/iBhjl7OlUtPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGrN1HX3NWdJv8PTma8NwUwkz8+ke0Cjtr9NUn8adTMQHTfwY/kePOqMyAUiy8X+Rb3xb1zsHm6WM2jFw8VfujyPNODvkMb48ZHhNrCcHFE8DU3ear8SkiSvE5sW27X010AoAawRBf9I6YoHFmA4ExympQpbDoLStr+t76A/q/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9mC8cuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE8BC4CEF1;
	Sat, 27 Dec 2025 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766845918;
	bh=+BiTeNfTmnCwqczNtn0sr4nRJ2IlQb/iBhjl7OlUtPU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z9mC8cuyAa7uo2fTfAqmT3FvGnkgr9hNIcZ+fCqTm3fMJIIbmVqtjsU+NLFf0YDZQ
	 V18C7ddcxtuGkcZX3GbOkGWJdnqeJ0T5yZ16f0Un910oCLqYJpvUgems7yOla/TNh7
	 YMnkQ+Lj3p77fgYLo6mFp0Wo8MZ/Zf9832SNDR2yVTR5doyNyctKAD3WaUefebpkST
	 yQEZtLeq0f/1nQ2Yd4usIl3iChaukr8GmXM3ZKBcN3VVjwg+rDzecYjNsSIg/nTZ2O
	 uKalewr9sU3sAxh6XQWEuAXPyM3PaGmIIyhjvUjRDla4RyrwESaIr2NHzGW0VCXSvI
	 udYUD/YxELEcQ==
Date: Sat, 27 Dec 2025 14:31:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <20251227143149.4d2f43fa@jic23-huawei>
In-Reply-To: <aUlQTxtWo0VUi4Yh@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
	<aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
	<aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
	<20251221182151.288a6da4@jic23-huawei>
	<aUjd5AJHohyW_kXM@lipo.home.arpa>
	<aUlQTxtWo0VUi4Yh@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 11:06:07 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Petre,
> 
> On 12/22, Petre Rodan wrote:
> > 
> > hello Jonathan,
> > 
> > thank you for the review.
> > 
> > On Sun, Dec 21, 2025 at 06:21:51PM +0000, Jonathan Cameron wrote:  
> > > On Sat, 20 Dec 2025 10:25:19 +0200
> > > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> > >   
> > > > Hello,
> > > > 
> > > > On Sat, Dec 20, 2025 at 01:47:05AM -0300, Marcelo Schmitt wrote:  
> > > > > On 12/18, Petre Rodan wrote:    
> > > > > > Zero out input buffer before reading the new conversion.
> > > > > > Perform this operation in core instead of in the bus specific code.
> > > > > > 
> > > > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > > > > ---
> > > > > >  drivers/iio/pressure/mprls0025pa.c     | 2 ++
> > > > > >  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
> > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> > > > > > index 00b1ff1e50a8..7cc8dd0d8476 100644
> > > > > > --- a/drivers/iio/pressure/mprls0025pa.c
> > > > > > +++ b/drivers/iio/pressure/mprls0025pa.c
> > > > > > @@ -16,6 +16,7 @@
> > > > > >  #include <linux/mod_devicetable.h>
> > > > > >  #include <linux/module.h>
> > > > > >  #include <linux/property.h>
> > > > > > +#include <linux/string.h>
> > > > > >  #include <linux/units.h>
> > > > > >  
> > > > > >  #include <linux/gpio/consumer.h>
> > > > > > @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
> > > > > >  		}
> > > > > >  	}
> > > > > >  
> > > > > > +	memset(data->rx_buf, 0, sizeof(data->rx_buf));    
> > > > > This is unusual and I don't think it's needed for the SPI path. Doesn't the I2C
> > > > > subsystem overwrite the rx buffer with what it reads from the device?    
> > > > 
> > > > I thought it's best practice to ensure that old conversions are not accidentally re-used in case the read operation fell thru the cracks.
> > > > that's exactly why in this particular case the BUSY flag is implemented on the hardware side.
> > > > 
> > > > please tell me how a few byte memset() would be detrimental.  
> > > 
> > > We don't normally do this as old data isn't a potential leak of anything
> > > sensitive.  
> > 
> > from my point of view as someone writing drivers for chemistry lab instruments, stale readings are to be avoided at all costs.
> > it's not about leaking sensitive data, it's about providing a warning sign if the read operation fails silently.
> > 
> > as an extreme (but fictional) example, a pilot looking at an altimeter would immediately recognize that something is wrong with it's pitot tube if it's giving out an off-scale static reading. if instead the output is believable (which would be the case when older readings are repeated due to an uncaught intermittent read error) then there would be some uncertainty and he would not know to definitely ignore the output of this particular instrument and trust another one instead.
> > 
> > the same logic applies to any instrument in a lab setting. 
> > a digital titration system that mixes multiple reagents needs to rely on fresh conversions to know when to stop a process. some advanced sensors even provide an incrementing conversion counter, others simply signal that a measurement is ongoing/not fresh via a BUSY flag and these are designed so that the driver can avoid a stale reading.
> > 
> > getting back to my driver, some pressure sensor series have a latch-up sensitivity and they misbehave during reads in various ways under certain conditions. I understand that you say that silent fails are unlikely but I'd like to keep the memset, for peace of mind.  
> 
> I agree with you that old conversions should not be accidentally re-used nor
> errors silently be ignored. But, to me, memset the read buffer to zero looks
> like we don't trust the underlying I2C and SPI layers. In that case, we should
> fix data read in those subsystems (if there is anyhting be fixed there).
> Though probably unlikely scenario to happen, how would one trust the sensor
> reading in a scenario where the extected measurement would be close to zero.

There are two different ways to get stale data in these buffers.
1) read fail. Those we absolutely should trust to be handled correctly by lower layer
   with errors reported and the data therefore not used.  Whether it is stale or random
   garbage doesn't really matter.  0 is often a perfectly valid reading so no extra
   info from seeing that in the buffer.
2) Changes in configuration that move the holes around or create some.  This is the
   more interesting corner.  I don't think the stale data argument applies because
   any software reading the data in the holes and doing anything with it is inherently
   buggy (plus as above, 0 is almost always a valid reading!)  Some drivers will
   even read other data into those holes (checksums etc are common).

So I don't see either as being a particularly problem here.  I don't mind the buffer
being cleared on each read but it doesn't to me seem necessary for any correctness
or security related reasons which are the two cases we need to make sure we clear
data for.

Jonathan

> 
> My suggestion is to look for a way of ensuring the transfer timing requirements
> specified in data sheet page 18 [1]. See the dummy delay transfer suggestion to
> patch 09.
> 
> [1]: https://4donline.ihs.com/images/VipMasterIC/IC/HWSC/HWSC-S-A0016036563/HWSC-S-A0016036563-1.pdf?hkey=CECEF36DEECDED6468708AAF2E19C0C6
> 
> >   
> > > However in most drivers this only spills out at all as
> > > a result of say a change in configured channels and is normally harmless
> > > as userspace knows to ignore stuff in the gaps anyway.  If there is
> > > another cases here (you mention the busy flag) then add a comment on why
> > > it makes sense. I don't in general want drivers to start doing this as
> > > it is in the fast path and sometimes the memset is non trivial (here it
> > > is probably irrelevant as the buffer is small).
> > > 
> > > Thanks,
> > > 
> > > Jonathan  


