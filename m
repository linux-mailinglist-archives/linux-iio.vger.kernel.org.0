Return-Path: <linux-iio+bounces-26852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78020CAACE8
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 20:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D44304E146
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1EF2BCF5D;
	Sat,  6 Dec 2025 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecxW/l2H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D5C1EFFB4;
	Sat,  6 Dec 2025 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765049281; cv=none; b=Z5IQ0FFYOiaxandaYzSLMcPjQpC6N5WMpgCSYgLb3UN0cXkRXh2QqgTKnPRamhC+eEDa1z/vwFR4AnhQl+o56gSJvgGpWrzMNMyzjiY/0jTBsFOxprP3/GDlQRrNQkHY41nDDJ9HhPNk214KvLGS1T0aLz6dQVq13ldVe4aqmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765049281; c=relaxed/simple;
	bh=pOBV8eKHl5mixY5XtEgEjcNebw0gfBa1dach5jJPpYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0RvWt+9FRFvbeRmL2Fvvw6aPTpo8bdVOo0hqiYudZkjhQq1ArwPQRLZ6K3u+V/2+e5LSX01LGDYRYTHQN8SGhzNta3GGjJ5OAB0jnWGFlUopVNXj6pWilbFknxERBvGpIrrnLb7/9LLG8woBRWVKnl42xtQ9MbIpkYPNyCdBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecxW/l2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835CFC4CEF5;
	Sat,  6 Dec 2025 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765049280;
	bh=pOBV8eKHl5mixY5XtEgEjcNebw0gfBa1dach5jJPpYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ecxW/l2HvBRKsuAqxkglNmCJ2V2LhuKkgiTGnccTjJOv2sXEskfiPbnTkHltbDRK1
	 swNngCOoVl7ob4eGxgttGJX4+6m8NlIDYtktpp9hwojjIpumErYCP2x1v6wIe2/40n
	 OgYgCl+UsaOrtJGJfK1P2sQ+GvO6PkqJ6jnK4eRnaKQY8gvdZozsNttjAtw7gkgXAw
	 5oKNBPiyOLeYxe9/8kecY4vaC9Kx8T+nP1Vl0I2a5/t8GUrIo661O1EKM/v1YW8heN
	 kdrBTcsKYYtHv5E2/YGOsmrmybymuQQK4Y8pGDRA4+acRkV39K4ddP3VN46nTt2Hk2
	 Nwdw0Dlo/JqZA==
Date: Sat, 6 Dec 2025 19:27:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Tobias Sperling" <tobias.sperling@softing.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <20251206192750.03469a87@jic23-huawei>
In-Reply-To: <DENT9F7BM1O3.1XA58W93TC6AQ@gmail.com>
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
	<20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
	<aSsBdJZDWcadxEHC@smile.fi.intel.com>
	<DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
	<18fbf486-c1cc-4cd2-af12-ffa093fa9ce7@baylibre.com>
	<DEN50VFOIB5O.1ENBKI6JQ0ZC@gmail.com>
	<248b009e-0401-4531-b9f0-56771e16bdef@baylibre.com>
	<DENT9F7BM1O3.1XA58W93TC6AQ@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Dec 2025 09:46:37 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Mon Dec 1, 2025 at 4:53 PM -05, David Lechner wrote:
> > On 12/1/25 1:47 PM, Kurt Borja wrote:  
> >> On Mon Dec 1, 2025 at 11:07 AM -05, David Lechner wrote:
> >> 
> >> ...
> >>   
> >>>>>> +	if (iio_device_claim_buffer_mode(indio_dev))
> >>>>>> +		goto out_notify_done;
> >>>>>> +
> >>>>>> +	if (iio_trigger_using_own(indio_dev)) {
> >>>>>> +		disable_irq(ads1018->drdy_irq);
> >>>>>> +		ret = ads1018_read_unlocked(ads1018, &scan.conv, true);
> >>>>>> +		enable_irq(ads1018->drdy_irq);
> >>>>>> +	} else {
> >>>>>> +		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
> >>>>>> +		scan.conv = ads1018->rx_buf[0];
> >>>>>> +	}
> >>>>>> +
> >>>>>> +	iio_device_release_buffer_mode(indio_dev);
> >>>>>> +
> >>>>>> +	if (ret)
> >>>>>> +		goto out_notify_done;
> >>>>>> +
> >>>>>> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> >>>>>> +
> >>>>>> +out_notify_done:
> >>>>>> +	iio_trigger_notify_done(ads1018->indio_trig);  
> >>>>>
> >>>>> Jonathan et al., maybe we need an ACQUIRE() class for this? It will solve
> >>>>> the conditional scoped guard case, no?  
> >>>
> >>> No, ACQUIRE() is not scoped, just conditional. I don't think it
> >>> will improve anything here.  
> >> 
> >> Maybe I'm not understanding the problem fully?
> >> 
> >> I interpreted "ACQUIRE() class" as a general GUARD class, i.e.
> >> 	
> >> 	guard(iio_trigger_notify)(indio_dev->trig);
> >> 
> >> This way drivers may use other cleanup.h helpers cleaner, because of the
> >> goto problem?
> >> 
> >> I do think it's a good idea, like a `defer` keyword. But it is a bit
> >> unorthodox using guard for non locks.

Agreed. This one is weird if called guard().

I'd not be against a defer() if it existed, but my guess is Linus Torvalds
will just say this is too weird and helper function for everything before
the unconditional cleanup is the way to go.

People did mess around with __free() for cases like this but that is very
ugly given no 'constructor' occurred so mostly those got rejected I think.

> >> 
> >>   
> >
> > To take a simple example first:
> >
> > static int
> > ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> > 		 int *val, int *val2, long mask)
> > {
> > 	int ret;
> >
> > 	if (!iio_device_claim_direct(indio_dev))
> > 		return -EBUSY;
> >
> > 	ret = ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
> >
> > 	iio_device_release_direct(indio_dev);
> >
> > 	return ret;
> > }
> >
> > using ACQUIRE would look like:
> >
> > static int
> > ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> > 		 int *val, int *val2, long mask)
> > {
> > 	int ret;
> >
> > 	ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
> > 	if ((ret = ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
> > 		return ret;
> >
> > 	return ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
> > }
> >
> > It makes it quite more verbose IMHO with little benefit (the direct
> > return is nice, but comes at at an expense of the rest being less
> > readable).  
> 
> This is verbose yes, but we could avoid having two functions in the
> first place and implement everything inside ads1018_read_raw() with
> ACQUIRE(...) on top.

Agreed - there are places where this makes sense but I'm not keen
on lots of churn to inject it in places where we already have
the two function approach.

> 
> >
> >
> >
> > And when we need it to be scoped, it adds indent and we have to do
> > some unusual things still to avoid using goto.
> >
> > static irqreturn_t ads1018_trigger_handler(int irq, void *p)
> > {
> > 	struct iio_poll_func *pf = p;
> > 	struct iio_dev *indio_dev = pf->indio_dev;
> > 	struct ads1018 *ads1018 = iio_priv(indio_dev);
> > 	struct {
> > 		__be16 conv;
> > 		aligned_s64 ts;
> > 	} scan = {};
> > 	int ret;
> >
> > 	do {
> > 		ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
> > 		if ((ret = ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
> > 			break;
> >
> > 		if (iio_trigger_using_own(indio_dev)) {
> > 			disable_irq(ads1018->drdy_irq);
> > 			ret = ads1018_read_unlocked(ads1018, &scan.conv, true);
> > 			enable_irq(ads1018->drdy_irq);
> > 		} else {
> > 			ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
> > 			scan.conv = ads1018->rx_buf[0];
> > 		}
> > 	} while (0);  
> 
> Here we could use scoped_cond_guard() instead, no?
Just in case this comes back. Please no!  

scoped_cond_guard() manages to thoroughly confuse compilers.
It got so bad when we tried that originally I went back and reverted
all use of that in IIO.

> 
> >
> > 	if (!ret)
> > 		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> >
> > 	iio_trigger_notify_done(ads1018->indio_trig);
> >
> > 	return IRQ_HANDLED;
> > }
> >
> > So unless Jonathan says this is what he wants, I would avoid it.  
> 
> I will submit this as a separate RFC patch. We can continue the
> discussion there to avoid delaying this series.

Thanks and very wise to not yet use it in here as that discussion
may take some time given there is naming involved ;)

Jonathan

> 
> 


