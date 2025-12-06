Return-Path: <linux-iio+bounces-26831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA05CAAA53
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F1A3163D32
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28282F0C70;
	Sat,  6 Dec 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYFTxawB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585268632B;
	Sat,  6 Dec 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038675; cv=none; b=iFDAW4ZbQtbSMihHjQzxY5OwecIFZpmcko5K55/88oLrv6ZZnBSgVIY5mI13zk0a61fuq5W9AfXiAZ4RnCCwZwLLGUrtSk2yL4JZjSmNz/GuRgLZ/jiEO8ocyr7RCOskUdqivNyaAD6Fa4dBjfHBmDTpCPLob9uTz+p6uqxsGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038675; c=relaxed/simple;
	bh=CFjhP+ZceOE1ys/wBO743XszSyWObLsmhtUQedKfNUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZ3/oowqnlTYEwhUNZcCDJe2CQarx7HCZnFjNQEgrx0hj/RImFFd3BCVabw3BQyaVlt1z6zZTq1RwFsQJ/1jYscsXLr3wTFvzbqoOBUgqq4/zES9YVnkqrpNDhhMeaO8ZXNMfZJ90Jolly+KKSCO0e6/CJ28IvCIVtyOiAavlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYFTxawB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35C2C4CEF5;
	Sat,  6 Dec 2025 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765038674;
	bh=CFjhP+ZceOE1ys/wBO743XszSyWObLsmhtUQedKfNUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CYFTxawBBuBRjv1DRad+RmOw+68HM5xqPObRQFicJ3PzyEKcTh9aAJqofoG3Sa+C9
	 4Bw2RAOAnqm/b5nz8j4jDBOSd1ElSK0bGSSIdIdG1f7iNHN+2SO4yh94NgQztaDOU/
	 SAq0VUn5Kh3LyP9133qxGNOxRtY0cDH5aTLW0pbBAYBDV++FnS2//+Pze7vJ90md36
	 ak+9qpH9Nco6xQcvvmqCcpAvUzh4KVDo3mZZ/GF+zO6PdpzTJOsKEOIHh4EVciot1l
	 7A1OxPVGtU6tHdLwtV2MmEFCZlOQ6odGuQYCMvQsifkSDAjxo/vLIEv+L1+s7gzMTq
	 D/1PWPDfyzrsA==
Date: Sat, 6 Dec 2025 16:31:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jorge Marques <gastmaier@gmail.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: adc: Add support for ad4062
Message-ID: <20251206163103.514c1aad@jic23-huawei>
In-Reply-To: <aSQhCKBC36T9t-H1@smile.fi.intel.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
	<20251013-staging-ad4062-v1-3-0f8ce7fef50c@analog.com>
	<20251018171032.144a126c@jic23-huawei>
	<ou6qwayt4g7qaoe5dm7tdg6jl5dwquslpfbok6on5r2q2wytyl@wlqxj5y6ircj>
	<aSQMjZbc75cQtFqJ@smile.fi.intel.com>
	<o4kt2of4xql4azufjgiecm4jzuexgm6nkvr7aghbwfk6qd7yqd@r4plggehzces>
	<aSQhCKBC36T9t-H1@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 11:10:32 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 24, 2025 at 09:57:26AM +0100, Jorge Marques wrote:
> > On Mon, Nov 24, 2025 at 09:43:09AM +0200, Andy Shevchenko wrote:  
> > > On Sun, Nov 23, 2025 at 08:48:09PM +0100, Jorge Marques wrote:  
> > > > On Sat, Oct 18, 2025 at 05:10:32PM +0100, Jonathan Cameron wrote:  
> > > > > On Mon, 13 Oct 2025 09:28:01 +0200
> > > > > Jorge Marques <jorge.marques@analog.com> wrote:  
> 
> > > > Mostly acknowledgements and explanations, except a comment on ACQUIRE usage.  
> 
> ...
> 
> > > > > > +static int ad4062_read_chan_raw(struct iio_dev *indio_dev, int *val)
> > > > > > +{
> > > > > > +	struct ad4062_state *st = iio_priv(indio_dev);
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);  
> > > > > There is a nice new
> > > > > 	ACQUIRE()/ACQUIRE_ERR() related set of conditional guards defined that
> > > > > let you do this using cleanup.h style.
> > > > > 
> > > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a0abc39450a3123fd52533a662fbd37e0d1508c
> > > > > 
> > > > > This looks like a perfect example of where those help.
> > > > > 
> > > > > When I catch up with review backlog I plan to look for other
> > > > > places to use that infrastructure in IIO.
> > > > >   
> > > > I tried implementing, here becomes
> > > > 
> > > >         ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> > > >         ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> > > > 
> > > > At buffer and monitor, since we put the device as active during the
> > > > lifetime of the buffer and monitor mode, either I leave as is, or I bump
> > > > the counter with pm_runtime_get_noresume, so when the method leaves, the
> > > > counter drops to 1 and not 0, then on disable I drop the counter back to
> > > > 0 and queue the autosuspend with pm_runtime_put_autosuspend.  
> > > > >   
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = ad4062_set_operation_mode(st, st->mode);
> > > > > > +	if (ret)
> > > > > > +		goto out_error;
> > > > > > +
> > > > > > +	ret = __ad4062_read_chan_raw(st, val);
> > > > > > +
> > > > > > +out_error:
> > > > > > +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > > > > > +	return ret;
> > > > > > +}  
> > > 
> > > I read the above code, I read it again, I don't understand the reasoning.
> > > The ACQUIRE() doesn't change the behaviour of the above code.
> > > 
> > > If you need to bump the reference counter, it should be done somewhere else
> > > where it affects the flow, or this code has a bug.
> > > 
> > > If I miss something, please elaborate.  
> > 
> > The part highlighted does not require bumping the reference counter, but
> > at the buffer acquisition and monitor mode, to not put the device back
> > in low power mode during the lifetime of those operations.
> > 
> > Buffer more:
> > 
> >   static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >   {
> >           struct ad4062_state *st = iio_priv(indio_dev);
> >           int ret;
> > 
> > 	  // [ Some code ]
> > 
> >           ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> >           ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> >           if (ret)
> >                   return ret;
> > 
> > 	  // [ More code ]  
> 
> >           pm_runtime_get_noresume(&st->i3cdev->dev);  
> 
> 
> Yes, this looks good if it makes the error paths cleaner.
> Also consider adding
> 
> 	struct device *dev = &st->i3cdev->dev;
> 
> at the top of the functions that use it, it might make code better to read.
> 

Sorry I'm late to respond to this.  If we do end up doing this
Raphael has been posting some new macros to help and I'm rather dubious
about using an acquire to grab a first reference then upgrading with with
a second on the use paths.  I think ACQUIRE in this particular place may
just not be appropriate.

Jonathan

> >           return 0;
> >   }
> > 
> >   static int ad4062_triggered_buffer_predisable(struct iio_dev *indio_dev)
> >   {
> >           struct ad4062_state *st = iio_priv(indio_dev);
> > 
> >           pm_runtime_put_autosuspend(&st->i3cdev->dev);
> >           return 0;
> >   }
> > 
> > Monitor mode:
> > 
> >   static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
> >   {
> >           int ret = 0;
> > 
> >           if (!enable) {
> >                   pm_runtime_put_autosuspend(&st->i3cdev->dev);
> >                   return 0;
> >           }
> > 
> >           ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);
> >           ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> >           if (ret)
> >                   return ret;
> > 
> > 	  // [ Some code ]
> > 
> >           pm_runtime_get_noresume(&st->i3cdev->dev);
> >           return 0;
> >   }  
> 


