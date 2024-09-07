Return-Path: <linux-iio+bounces-9298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670297032D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2696B22D78
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8F15FD1B;
	Sat,  7 Sep 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riaywG1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6E15AAC8;
	Sat,  7 Sep 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725726949; cv=none; b=ICqLqTdG01LZCIWqcg4mvI/4Jucl0tjErLlC7Lq+cqMFdRCsT6C+bbOuzcTV+Qes1F21lx7nRGvJNj/v+D45EPQEi2QWk9xXFC9bhXFkhkmKBay6ehp6Rb/021T3oLd4qGH67O4OFPTWNtMXm2HQVVxIaqFdiHWJwtMDOt+s95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725726949; c=relaxed/simple;
	bh=Spba6BOIbr3am2h7wYdkLKDmMFJAWbNGAYjxoiVZMrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/pshDWGKbVcF6cTLodOEGpQrv3MQ8RBGFhRo5LRFaVLSKnT2ZvaBxdqSf5z8+y+NXXMH+NWg12uFYGmz6scEhl+6xia60KH0ZDyXBuKJAlB25oFckOrc/N1UpeAHjHtCrY3TpgUd7FoKy+vB5Yh17ZVZxrnPO63oeY0S30kzoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riaywG1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859A3C4CEC6;
	Sat,  7 Sep 2024 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725726948;
	bh=Spba6BOIbr3am2h7wYdkLKDmMFJAWbNGAYjxoiVZMrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=riaywG1bTtLhnb8iizjxukYuoyRnClq19Aq0zTVS6pM+k/UsQrIOhsEM/rA0f2lRZ
	 +Snem5bHJxXcfy5YkdBS/jcs5an9sP/bpiGKS3+nXlLyplBmecFRse9bfzI/KwUi9t
	 LDVPnCmAwYg12+z/gcg3zvoNSNaVbIxGlHxtBnH6J6LxM5Q2bdj2FWcmyWQ0qi+2XW
	 WxEjxAmyjT0PEyC4qE3PTnrU/PcxrTZRU9l+OYjrLlcXjZG5W7VXzYwBeQUppAtpVX
	 nzy3H4sO7cxztMOETWiy1w/Wi+CUe1ygfVaQlrcF+qKfXX7pWIWgAUFlBU0aKVgyLA
	 mx0wzcFPOywcA==
Date: Sat, 7 Sep 2024 17:35:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 0/7] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <20240907173537.632e8484@jic23-huawei>
In-Reply-To: <20240904102955.GD44250@vamoiridPC>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
	<ZtcfCVcV_1hCVp7N@smile.fi.intel.com>
	<20240904102955.GD44250@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 12:29:55 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Tue, Sep 03, 2024 at 05:36:57PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 02, 2024 at 08:42:15PM +0200, Vasileios Amoiridis wrote:  
> > > Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com  
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > for the patches 1,2, and 3.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 
> Thank you very much for the reviews Andy.

Too many patches floating around at the moment (not yours!) so I'm going
to reduce that number where I can just to make it easier to keep track
of what needs more focus.

So picked up patches 1-3 on the togreg branch of iio.git and pushed
out as testing. Note these are probably 6.13 material now.

Jonathan

> 
> Cheers,
> Vasilis


