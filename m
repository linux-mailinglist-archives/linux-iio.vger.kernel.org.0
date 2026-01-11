Return-Path: <linux-iio+bounces-27589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D78AD0EBB7
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1438E300D178
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EAE33A6FE;
	Sun, 11 Jan 2026 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEn6W8Lx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59833987E;
	Sun, 11 Jan 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768131903; cv=none; b=Jvjs3OOBG3CKwP9DLFcGZBQL+tbLXlCzx4Yu7Z4jsECuSglVCxJ7b7+B71Ft8L/tGLvXEEA+PtHI+UADmn9kaYejfuZMwZ2j8uM59wmI1yHJstEOfON75UVcdkTiG6QGsjfp3LpMu4vm2Xg6pIQoz4S23jXPlweGSpqCwiEXAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768131903; c=relaxed/simple;
	bh=0/8hyGhH5axErmx9TU/Oo85SA0umpgVD5AMLZjzPeEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOX0DJ0rhJ4E2d+wSQyy/eDkzwv7ESAvRCODzyo1fTulZx/RD0PAPT0A1ibiAnfl37Xwqx6cWcJn8PqlMa+O+3Dm+856ZMwczjriOk63+9gW4r0ZMHgZN5OBBExp7H3K/4s1mefhI3PMcXoud3ar22+8M23Uom3ZQbdybZmirco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEn6W8Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5955C4CEF7;
	Sun, 11 Jan 2026 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768131903;
	bh=0/8hyGhH5axErmx9TU/Oo85SA0umpgVD5AMLZjzPeEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cEn6W8LxktqbLjDvj0Uh7Idfy7QJRFL/YAaNIAwA+0N8GJ7iTAPPNq43uNvqMBiIi
	 zshmCml2z01DLsaV9CESf/ZFRqH2appv1SsJICDUT+vTsuDpQI8M9RWcvzCEWPIe0j
	 xoALgQS0azrRpNU4N0dpjNJ0HXIYgvDGl1EOzft8Bp9+I6fl3g6Mppp0uf1cG9JPmA
	 trN3HGtpSH6jL8Yshg02KjDc9eYcJmggGy0y/wAYKqN5fCOPNwdom1HZ4K5Iho/SKv
	 4yeR/JUnlsxyq902/e8Zqox6X0d5zueCh9L+igftVlH1yg7KMjJLQ581hYX85y7BlR
	 yMWmFP+WyyTDA==
Date: Sun, 11 Jan 2026 11:44:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <20260111114454.304ab6ef@jic23-huawei>
In-Reply-To: <aVjMk4Z-VRaRYYeK@sunspire.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
	<aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
	<aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
	<20251221182151.288a6da4@jic23-huawei>
	<aUjd5AJHohyW_kXM@lipo.home.arpa>
	<aUlQTxtWo0VUi4Yh@debian-BULLSEYE-live-builder-AMD64>
	<20251227143149.4d2f43fa@jic23-huawei>
	<aVjMk4Z-VRaRYYeK@sunspire.home.arpa>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Jan 2026 10:00:19 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello and a Happy New Year!
> 
> On Sat, Dec 27, 2025 at 02:31:49PM +0000, Jonathan Cameron wrote:
> > On Mon, 22 Dec 2025 11:06:07 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >   
> > > Hi Petre,
> > > 
> > > On 12/22, Petre Rodan wrote:  
> > > > 
> > > > hello Jonathan,
> > > > 
> > > > thank you for the review.
> > > > 
> > > > On Sun, Dec 21, 2025 at 06:21:51PM +0000, Jonathan Cameron wrote:    
> > > > > On Sat, 20 Dec 2025 10:25:19 +0200
> > > > > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> > > > >     
> > > > > > Hello,
> > > > > > 
> > > > > > On Sat, Dec 20, 2025 at 01:47:05AM -0300, Marcelo Schmitt wrote:    
> > > > > > > On 12/18, Petre Rodan wrote:      
> > > > > > > > Zero out input buffer before reading the new conversion.
> > > > > > > > Perform this operation in core instead of in the bus specific code.
> > > > > > > > 
> > > > > > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > > > > > > ---
> > > > > > > >  drivers/iio/pressure/mprls0025pa.c     | 2 ++
> > > > > > > >  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
> > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> > > > > > > > index 00b1ff1e50a8..7cc8dd0d8476 100644
> > > > > > > > --- a/drivers/iio/pressure/mprls0025pa.c
> > > > > > > > +++ b/drivers/iio/pressure/mprls0025pa.c
> > > > > > > > @@ -16,6 +16,7 @@
> > > > > > > >  #include <linux/mod_devicetable.h>
> > > > > > > >  #include <linux/module.h>
> > > > > > > >  #include <linux/property.h>
> > > > > > > > +#include <linux/string.h>
> > > > > > > >  #include <linux/units.h>
> > > > > > > >  
> > > > > > > >  #include <linux/gpio/consumer.h>
> > > > > > > > @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
> > > > > > > >  		}
> > > > > > > >  	}
> > > > > > > >  
> > > > > > > > +	memset(data->rx_buf, 0, sizeof(data->rx_buf));      
> > > > > > > This is unusual and I don't think it's needed for the SPI path. Doesn't the I2C
> > > > > > > subsystem overwrite the rx buffer with what it reads from the device?      
> > > > > > 
> > > > > > I thought it's best practice to ensure that old conversions are not accidentally re-used in case the read operation fell thru the cracks.
> > > > > > that's exactly why in this particular case the BUSY flag is implemented on the hardware side.
> > > > > > 
> > > > > > please tell me how a few byte memset() would be detrimental.    
> > > > > 
> > > > > We don't normally do this as old data isn't a potential leak of anything
> > > > > sensitive.    
> > > > 
> > > > from my point of view as someone writing drivers for chemistry lab instruments, stale readings are to be avoided at all costs.
> > > > it's not about leaking sensitive data, it's about providing a warning sign if the read operation fails silently.
> > > > 
> > > > as an extreme (but fictional) example, a pilot looking at an altimeter would immediately recognize that something is wrong with it's pitot tube if it's giving out an off-scale static reading. if instead the output is believable (which would be the case when older readings are repeated due to an uncaught intermittent read error) then there would be some uncertainty and he would not know to definitely ignore the output of this particular instrument and trust another one instead.
> > > > 
> > > > the same logic applies to any instrument in a lab setting. 
> > > > a digital titration system that mixes multiple reagents needs to rely on fresh conversions to know when to stop a process. some advanced sensors even provide an incrementing conversion counter, others simply signal that a measurement is ongoing/not fresh via a BUSY flag and these are designed so that the driver can avoid a stale reading.
> > > > 
> > > > getting back to my driver, some pressure sensor series have a latch-up sensitivity and they misbehave during reads in various ways under certain conditions. I understand that you say that silent fails are unlikely but I'd like to keep the memset, for peace of mind.    
> > > 
> > > I agree with you that old conversions should not be accidentally re-used nor
> > > errors silently be ignored. But, to me, memset the read buffer to zero looks
> > > like we don't trust the underlying I2C and SPI layers. In that case, we should
> > > fix data read in those subsystems (if there is anyhting be fixed there).
> > > Though probably unlikely scenario to happen, how would one trust the sensor
> > > reading in a scenario where the extected measurement would be close to zero.  
> > 
> > There are two different ways to get stale data in these buffers.
> > 1) read fail. Those we absolutely should trust to be handled correctly by lower layer
> >    with errors reported and the data therefore not used.  Whether it is stale or random
> >    garbage doesn't really matter.  0 is often a perfectly valid reading so no extra
> >    info from seeing that in the buffer.  
> 
> for this sensor a raw conversion of 0 is out of bounds. valid values are between
>  output_min and output_max:
> 
> 	[MPR_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 },
> 	[MPR_FUNCTION_B] = { .output_min =  419430, .output_max =  3774874 },
> 	[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 },
> 
> I expect that the user will recognize such an abnormal reading.
> 
> for the SPI transfer specifically there is a latch-up scenario in which the MOSI
> signal is being clamped down by the sensor in sync with SCLK [1].
> I do not know how all SPI controllers act when MOSI is forced to GND, thus
>  provided the memset() for a hypothetical scenario in which the SPI controller
>  just resets during the xfer (due to a brownout) and if this condition is not
>   recognized by the low level spi layer (I see no way to test this).
> 
> [1] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1588325/am3358-spi-tx-data-corruption
> (my guess is that ABP2 and MPR series of sensors share the same silicon implementation)
> 
> > 2) Changes in configuration that move the holes around or create some.  This is the
> >    more interesting corner.  I don't think the stale data argument applies because
> >    any software reading the data in the holes and doing anything with it is inherently
> >    buggy (plus as above, 0 is almost always a valid reading!)  Some drivers will
> >    even read other data into those holes (checksums etc are common).
> > 
> > So I don't see either as being a particularly problem here.  I don't mind the buffer
> > being cleared on each read but it doesn't to me seem necessary for any correctness
> > or security related reasons which are the two cases we need to make sure we clear
> > data for.  
> 
> clamping an output signal to GND smells to me like 'undefined behaviour' when
> one looks at a large number of SPI controller implementations and this memset
> would provide an early warning, at no cost.

Ok. Add a comment on 0 not being a valid value for these channels and the
fact that it might be useful for diagnosing the condition you describe.

All I really want to do is avoid people seeing a 'memset is needed here' patch
and posting them for other drivers where it doesn't provide anything useful.

Jonathan

> 
> > Jonathan
> >   
> > > 
> > > My suggestion is to look for a way of ensuring the transfer timing requirements
> > > specified in data sheet page 18 [1]. See the dummy delay transfer suggestion to
> > > patch 09.
> > > 
> > > [1]: https://4donline.ihs.com/images/VipMasterIC/IC/HWSC/HWSC-S-A0016036563/HWSC-S-A0016036563-1.pdf?hkey=CECEF36DEECDED6468708AAF2E19C0C6  
> 
> yes, thank you Marcelo. your delay xfer idea works and it will be part of V2.
> but that issue is completely unrelated to the memset modification.
> 
> best regards,
> peter
> 
> > > > > However in most drivers this only spills out at all as
> > > > > a result of say a change in configured channels and is normally harmless
> > > > > as userspace knows to ignore stuff in the gaps anyway.  If there is
> > > > > another cases here (you mention the busy flag) then add a comment on why
> > > > > it makes sense. I don't in general want drivers to start doing this as
> > > > > it is in the fast path and sometimes the memset is non trivial (here it
> > > > > is probably irrelevant as the buffer is small).
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Jonathan    
> >   
> 


