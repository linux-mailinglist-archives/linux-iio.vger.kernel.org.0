Return-Path: <linux-iio+bounces-10404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF4998F2F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DFF28BC60
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9D819ABB3;
	Thu, 10 Oct 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebwvrfhy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B819B3EE;
	Thu, 10 Oct 2024 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583223; cv=none; b=tlehbmJ8ZbWATd3pbl2jUDGfgk6VHMH2spAGOoSNqAy1ehMDX5BiWEvcTdKhyU++9l134bEUxbCo3OSr0sWYOa5Q+KjCQPJfGTLyB4Ercs9gQl1rcckXuuMlFhmWRENR2fAbKGdfVkCJxf956p79okKmF5QLiuxs/JOFHGnM2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583223; c=relaxed/simple;
	bh=M03HvDIvoBZcMXsv4bbTfZHLxqsuwYaDsKHJPKdP8xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P85aUPYHmsPO6bpZC9rbTDAj3jSnKZLg0wdwdA1qK+JLfZkULY+Frd17IIgpfzc1f3Yt8I+SfPoYqCwEs6ZtDCSMfGywCSPuNmIrYeFxVu5BkEp+XkbFNZzI73tc/y6/qAYz/o9QezY2SegHJ94C84P6A1HXhe4Rsr3vm71iDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebwvrfhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6206EC4CEC5;
	Thu, 10 Oct 2024 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583222;
	bh=M03HvDIvoBZcMXsv4bbTfZHLxqsuwYaDsKHJPKdP8xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ebwvrfhyTL5Ze9UAHtaJg9q7n2/xnjxQKrk4QP2JhvnFVMOTkMcUzQ9nt6TYbNGcl
	 gGpG6vI5L2LoY2ryPjtZ5g9w1TWhhWhaE8ELLRTvDympq23WwwDRIERPCmZjmrZuAS
	 buHQ0JjrYN0D4r2B6MVKHCPeZbO75KvWIBTEdye8jQVn7g1Zt2fCagOKv2aFoikSr+
	 2/hQSo7n15rIjFsJvOgksy66flfM5EROIovUswcHFy4dEjSp2lKPUteMimYjQ97AeQ
	 1iZfUQ0agtlAbsuaOkfppuQB3+2NtS/bVy/pLqW7N0N9s0WyUVjcFsbzsWrEz58YOu
	 AvckdtKtFXvKg==
Date: Thu, 10 Oct 2024 19:00:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>,
 Nuno Sa <nuno.sa@analog.com>, Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer
 <sean@geanix.com>, Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>, Alexandru Ardelean
 <ardeleanalex@gmail.com>, Gustavo Silva <gustavograzs@gmail.com>, Shoji
 Keita <awaittrot@shjk.jp>, Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas
 Klinger <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 04/13] iio: adc: ti-ads8688: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241010190012.42401d09@jic23-huawei>
In-Reply-To: <34f22420-ec6b-438e-9edb-1aa7a837eb98@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-4-67c0385197cd@gmail.com>
	<20241005184018.6b06e850@jic23-huawei>
	<34f22420-ec6b-438e-9edb-1aa7a837eb98@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 20:21:06 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 05/10/2024 19:40, Jonathan Cameron wrote:
> > On Thu, 03 Oct 2024 23:04:50 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> This driver makes use of triggered buffers, but does not select the
> >> required modules.
> >>
> >> Fixes: 2a86487786b5 ("iio: adc: ti-ads8688: add trigger and buffer support")
> >> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.  
> > Fixes tag must be part of the tag block.
> > 
> > Also this one looks to be a false positive. The driver includes
> > buffer.h but doesn't actually have buffered support.
> >   
> 
> Are you sure? These are the errors I get when I compile the ti-ads8688.c:
> 
> ld: drivers/iio/adc/ti-ads8688.o: in function `ads8688_probe':
> ti-ads8688.c:(.text+0x1cf): undefined reference to
> `devm_iio_triggered_buffer_setup_ext'
> ld: drivers/iio/adc/ti-ads8688.o: in function `ads8688_trigger_handler':
> ti-ads8688.c:(.text+0x3be): undefined reference to `iio_push_to_buffers'
> ld: ti-ads8688.c:(.text+0x3c9): undefined reference to
> `iio_trigger_notify_done'
> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> make[1]: *** [/home/jc/pw/linux/linux-next/Makefile:1173: vmlinux] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> 
> And I see the offending functions in its code. Am I missing something
> here or are we talking about different drivers?
Miss read by me.  I picked up on the 8344 in diff.
That does have a spurious include so I stopped looking closer!

Anyhow, now applied to the fixes-togreg branch of iio.git and
marked for stable.

Sorry about that!

Thanks,

Jonathan

> 
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> ---
> >>  drivers/iio/adc/Kconfig | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >> index 45872a4e2acf..e6be1f1ec79f 100644
> >> --- a/drivers/iio/adc/Kconfig
> >> +++ b/drivers/iio/adc/Kconfig
> >> @@ -1483,6 +1483,8 @@ config TI_ADS8344
> >>  config TI_ADS8688
> >>  	tristate "Texas Instruments ADS8688"
> >>  	depends on SPI
> >> +	select IIO_BUFFER
> >> +	select IIO_TRIGGERED_BUFFER
> >>  	help
> >>  	  If you say yes here you get support for Texas Instruments ADS8684 and
> >>  	  and ADS8688 ADC chips
> >>  
> >   
> 


