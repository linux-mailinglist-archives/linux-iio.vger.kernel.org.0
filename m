Return-Path: <linux-iio+bounces-3264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A833F86F49D
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 12:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB441C20C22
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4DB65C;
	Sun,  3 Mar 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXs9bY3A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C6BA26
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709466109; cv=none; b=hYL39kU1Y7Yr9HiNJH1rUilmt9pCfmT9rodtmu0vp+8y9FmYI3bFeirqQdZ5MJ0sf0g2T2HgY8aFdNEJfXBUIQcB8j/EB/OibIID3QahrHvMZMu/917IbnHKYnJBroCSIwNS2ohLAw/61sNDNJvHmH6TU2KkEApMQiwwGVGmpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709466109; c=relaxed/simple;
	bh=qF70aBMpuqBbrax19pvTJZIEpC2gG/FOnJFen2g1yZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtICREI6Sb+hMkLxFbctPFflafTT7Ftbk3CsK1BRSkI3ExLq5AzKGHfdyLuF1cZsck3lcnCCk+OOeYYe/AIveoLlF3OK0H6213iS+uvwRN4bqM5+z0FPocO6nmdSr0I0LuJXOfsuFS8DcH7khToldAM7fEeRT8ASVFYjhYjCjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXs9bY3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B4CC433F1;
	Sun,  3 Mar 2024 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709466108;
	bh=qF70aBMpuqBbrax19pvTJZIEpC2gG/FOnJFen2g1yZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXs9bY3Ah+PPA5UAbaa/sy3cgn0XzqjvDi3iMLx5t0LiOc2z4PQqXQC571AY3qRKT
	 +ItmYr6QYEtelP88dh/PDD3Aup7dVOxZwvrxJ1nnByRkmjTD2alh+ZqumiIbQst66R
	 7aSSaHbBO3C5w97BPMYyuIC1GcMEcDe01dlenbOXY07rh4xfzr/ALOMgtLFqa0r5Ak
	 ZTk944gwgq2n64K1rSMPZ3PdrT5CRzTNpKeEgp7Mr7gAO670Nk04CFLWKuXJVxfMCc
	 x3qzVdXC5kBB1GY9V4ntRtDvl/Ub5T4V+2PzjlAMAqmZhSI86b080+R58nnoBEkL5G
	 dnpEwHjSFT5WA==
Date: Sun, 3 Mar 2024 11:41:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 3rd set for 6.9 - cleanup.h handling of
 fwnode_handle_put() related (not ordered wrt to PULL 2)
Message-ID: <20240303114137.194421b1@jic23-huawei>
In-Reply-To: <2024030239-gift-cabdriver-266b@gregkh>
References: <20240229202300.3321cc11@jic23-huawei>
	<2024030239-gift-cabdriver-266b@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Mar 2024 20:06:03 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Feb 29, 2024 at 08:23:00PM +0000, Jonathan Cameron wrote:
> > The following changes since commit d4551c189d6e6a3fcf7f625bd4b273e770fad35a:
> > 
> >   Merge tag 'iio-for-6.9a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-02-25 14:11:41 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.9c
> > 
> > for you to fetch changes up to 64e19caa5564ecc43edaa7fb818d53de650d9b34:
> > 
> >   iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped() (2024-02-28 19:15:43 +0000)
> > 
> > ----------------------------------------------------------------
> > IIO: 3rd set for 6.9 - cleanup.h related.
> > 
> > I have separated this set out from the more normal patches as they can
> > go separately and that may simplify the merge window.  Greg, up to you
> > how you wish to handle this in the char-misc tree.
> > 
> > Introduces __free() based handling for fwnode_handle_put() to
> > allow scope based release of these handles on early exit from functions.  
> 
> This should be fine, right?  No one complains about these.

Agreed this type isn't novel. However, there is only use use so far outside of
device_for_each_child_node_scoped() and that's in a patch that includes
both a direct use of __free(fwnode_handle) and a couple of
device_for_each_child_node_scoped()

[PATCH v5 1/9] iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
https://lore.kernel.org/all/20240224123215.161469-2-jic23@kernel.org/

> 
> > Also introduced device_for_each_child_node_scoped() to provide a
> > a convenient way to process child nodes without the need to explicitly
> > handle the fwnode_handle_put() needed on early exits from the loop.
> > Typically these early exits are a result of error handling or completion
> > of a search and have proven very prone to being missed.  
> 
> This is trickier, there was a load of different versions floating
> around, do you have a link to the "last" version of this patch series
> that got applied here?

https://lore.kernel.org/all/20240217164249.921878-1-jic23@kernel.org/
For the infrastructure - some of the users were in follow up series
(the DT to fwnode conversions Andy asked for and a v5 series to update
 a few things and pester people for reviews).

> 
> > One instance of such a leaked resource was found during these conversions
> > though review of that patch was too late for this pull request.  
> 
> I don't understand, does this series fix that found problem?  Or is it
> coming?
That one is still to come - review came in too late for this pull request.

https://lore.kernel.org/all/20240224123215.161469-6-jic23@kernel.org/
Though I remembered the issue a little wrong as it's a failure to set
the return value to an error, so arguably worse than an error leak as
we'll falsely carry on when parsing the fw failed.  The resource leak
cases were review of DT versions that came from Julia's coccinelle
script.

> 
> > A number of drivers are also converted over to generic fwnode handling from
> > the device tree specific version.  
> 
> Deleting code is always good, but:
> 
> 
> > 
> > ----------------------------------------------------------------
> > Jonathan Cameron (16):
> >       device property: Move fwnode_handle_put() into property.h
> >       device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
> >       device property: Introduce device_for_each_child_node_scoped()
> >       iio: adc: max11410: Use device_for_each_child_node_scoped()
> >       iio: addac: ad74413r: Use device_for_each_child_node_scoped()
> >       iio: dac: ltc2688: Use device_for_each_child_node_scoped()
> >       iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode based.
> >       iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify probe
> >       iio: adc: ad7124: Switch from of specific to fwnode based property handling
> >       iio: adc: ad7292: Switch from of specific to fwnode property handling
> >       iio: adc: ad7192: Convert from of specific to fwnode property handling
> >       iio: accel: mma8452: Switch from of specific to fwnode property handling.
> >       iio: accel: fxls8962af: Switch from of specific to fwnode based properties.
> >       iio: adc: hx711: Switch from of specific to fwnode property handling.
> >       iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
> >       iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()  
> 
> You are mixing the two different handlers in this series, right?  How
> about 2 different ones, one for each?  Or do they start to conflict?

It's one handler in here but two usecases so they are dependent.
First the basic __free(fwnode_handle) then the device_for_each_child_node_scoped()
which uses it internally..  The patches that mention DT are conversions over
to fwnode_handle that incorporate using device_for_each_child_node()

As for the ltc2983, there are users of just the __free(fwnode_handle) but in
IIO at least, far more users of it via device_for_each_child_node_scoped().
So not that useful to split the series :( 

The device tree equivalent is a separate series not included here.
That just got the necessary DT maintainer tags RB from Rob Herring today.
If we get a little more time (i.e. an rc8) this cycle, it would be
good to get that in place as well - I'll queue it up for linux-next today.
This is the DT series.
https://lore.kernel.org/linux-iio/20240301223942.GA3179769-robh@kernel.org/T/#t

Jonathan


> 
> thanks,
> 
> greg k-h


