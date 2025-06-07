Return-Path: <linux-iio+bounces-20300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33984AD0E6C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B067A5F27
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F2A1E8345;
	Sat,  7 Jun 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPVmn9u4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043A7263B;
	Sat,  7 Jun 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312430; cv=none; b=TK+4peg7EkmJo/TDY+OxdUz6saFByZIcUuzP8KLlSe3aRks700QfhFbRdI3aBxwu1/x56T9GpotJdzcWWFp3em4f19w40Yj9arAERq8blgirjyPSM3wUvtgedLl0+fgHBeiA8TYjvgauf2Qf0OrJNpP3WTxsVpYdkNBGgphSfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312430; c=relaxed/simple;
	bh=jH5iUK/ZumuFL9SJdUxHayX4sw9/fNOOcHbgrmRExC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSLa4Ai4jamjt8ShQo9PoVfKtnvoYEVQb/9/A9w9pcEkIF7900/KybasOqCQoQKEZXF6iV13ixoroGkDpPZUfQonpqE/W85cm6KkN837FUTL1eh56w6b2GUap8xaj+XkTerDWHeANpg7CPMDt3WBhIcJDNgLxrLhGZvXicBAgzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPVmn9u4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBC6C4CEF1;
	Sat,  7 Jun 2025 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749312429;
	bh=jH5iUK/ZumuFL9SJdUxHayX4sw9/fNOOcHbgrmRExC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NPVmn9u49+6AsLKBu8MXeUh9jJYneCr1DfiukdrLZwlHamiEqk0sLfegXqYCu/nD+
	 Zp7SpdhBGI86Tkcoa0NrCa0pSYQC5liDuOcT+MtXYMj16o301jTg0ISNuTUbMkTAD1
	 Jsuv8nSnBlcH+5ZNrmjI+Uv70YTkiQ6pZF51cJxGcsWsYnCDbDMOiALBwgRyF/q9UK
	 DSGGe5P/o8HAb2LT8BrURiuDRkSMLzUQIBuu+5OZl4NrVMOaLelf7uWJfhqsFVK2LP
	 +141J2wqnU40IxzNokL5usqPM8N9ZsmgX1pM6165u2EE9fQEEauZavtnWciWP3Zd1c
	 MwgtHtL/C560g==
Date: Sat, 7 Jun 2025 17:07:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
Message-ID: <20250607170703.3fab39e9@jic23-huawei>
In-Reply-To: <5zdrnf75n2nfuk3bjzynnj2b57fkptk3lltjf4xaloxorzk27w@6qwdcn5tfynz>
References: <20250603-fxlsrace-v2-1-5381b36ba1db@geanix.com>
	<b1f0dbee-13bd-4e5c-90b9-c6d88cb15971@baylibre.com>
	<5zdrnf75n2nfuk3bjzynnj2b57fkptk3lltjf4xaloxorzk27w@6qwdcn5tfynz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Jun 2025 13:36:15 +0000
Sean Nyekjaer <sean@geanix.com> wrote:

> On Tue, Jun 03, 2025 at 08:29:51AM +0100, David Lechner wrote:
> > On 6/3/25 7:25 AM, Sean Nyekjaer wrote:  
> > > fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
> > > iio_for_each_active_channel()) without making sure the indio_dev
> > > stays in buffer mode.
> > > There is a race if indio_dev exits buffer mode in the middle of the
> > > interrupt that flushes the fifo. Fix this by calling
> > > synchronize_irq() to ensure that no interrupt is currently running when
> > > disabling buffer mode.
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
> > > [...]
> > > _find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
> > > fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
> > > fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
> > > irq_thread_fn from irq_thread+0x110/0x1f4
> > > irq_thread from kthread+0xe0/0xfc
> > > kthread from ret_from_fork+0x14/0x2c
> > >
> > > Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: David Lechner <dlechner@baylibre.com>
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > > Changes in v2:
> > > - As per David's suggestion; switched to use synchronize_irq() instead.
> > > - Link to v1: https://lore.kernel.org/r/20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com  
> > Were you able to find a way to reproduce the bug well enough to
> > test this?
> >   
> 
> Yeah. Sorry I didn't included the reproducer :)
> 
> I added:
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index f2558fba491d..ce9a14245f83 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -1040,6 +1040,8 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  	unsigned int reg;
>  	int ret;
>  
> +	usleep_range(10000, 15000);
> +
>  	ret = regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
>  	if (ret)
>  		return IRQ_NONE;
> 
> And it was reproduceable within 10 secs:
> root@localhost:/sys/bus/iio/devices/iio:device0/buffer0#
> while true; do echo 1 > enable; sleep 1; echo 0 > enable; sleep 1; done
> 
> With synchronize_irq(data->irq); I have not been able to reproduce it.
Nice.

Applied to a temporary tree that I'll rebase on rc1 once available.

Thanks,

Jonathan

> 
> /Sean
> 


