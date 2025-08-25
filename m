Return-Path: <linux-iio+bounces-23195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0A2B33B4B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388453B1421
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A32C2AA5;
	Mon, 25 Aug 2025 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxLIIGX/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C6393DC5;
	Mon, 25 Aug 2025 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114824; cv=none; b=f8CmeWPkGQ9r6IGm33Kaore4YbQPKuF8a2xTKyOYnxKtIC2mUrj0YP+GqgzlC7gt10qJRkLQXC4FQrq0635/Rw9FtAiWdJO20yiFoHpu/HIrHfTjOg1j7trwmCmIcDQEovQyOvqZsduNCgmrQM/Nkn9nnHmc4sDNSXHYTI8V9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114824; c=relaxed/simple;
	bh=zB3jWL43/9hfoBTQ4XSVJc1rY4cToZ+X8RdEirunYk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwxTyylzSz/ohojE4Fo6didNQMBlU/ge0+ebiEq8tavtcahk5pbBVIWsQTUUltSsfc0hJfLPaBxwbDkvOsyKrg0yrH7kALb8EPnWyeBXjoEdvkCkvGBMW11Uv/X+vecTKswvvWGGyNDNk+y3k8ucRmdb+QyFYp23oemQFEra+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxLIIGX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63679C116B1;
	Mon, 25 Aug 2025 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756114823;
	bh=zB3jWL43/9hfoBTQ4XSVJc1rY4cToZ+X8RdEirunYk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kxLIIGX/CfGqtkxuIQrRx4B25TJKwEDbCKPbgpfcDfm5ZNSPZgns2Q8KWf6XJzL3r
	 qvZ/+2hhYwp397pr+0mhXw8V5BABBcU6Nj41Qp2f1gRbC6cMcE/+Mw2XV6QW6Tro10
	 f/JwZbRZ2ofL3QzZf0Mq1Vo33ijtY/UCcNc/IfCBgVKbfbNTMlmGIoe2PmTw8EFE8P
	 k6NFMFPepM3U4XEl6vjVXEolUvra6mOMuwus0nArTjU2CAzvN+LHcpKDKv6Iy96uQx
	 ildoy9rs6UyumFx5eEAT5t2V8lr1DEwoRmRBOAJx30lvC7dmr23TrqYSTfyKUOk2Hn
	 wEwLwttApU5XA==
Date: Mon, 25 Aug 2025 10:40:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Xing Guo <higuoxing@gmail.com>, <sfr@canb.auug.org.au>,
 <l.rubusch@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-next@vger.kernel.org>, <shuah@kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] docs: iio: Fix unexpected indentation for adxl345.
Message-ID: <20250825104016.0cc2ac2d@jic23-huawei>
In-Reply-To: <20250822103718.000062e1@huawei.com>
References: <20250818124124.5b978e64@canb.auug.org.au>
	<20250819065634.1154322-1-higuoxing@gmail.com>
	<20250822103718.000062e1@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 10:37:18 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 19 Aug 2025 14:56:34 +0800
> Xing Guo <higuoxing@gmail.com> wrote:
> 
> > Resolved the following building error:
> > 
> >  Documentation/iio/adxl345.rst:161: ERROR: Unexpected indentation. [docutils]
> > 
> > Fixes: fdcb9cb9178a ("docs: iio: add documentation for adxl345 driver")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/linux-next/20250818124124.5b978e64@canb.auug.org.au
> > Signed-off-by: Xing Guo <higuoxing@gmail.com>  
> 
> +CC linux-iio.
Applied.  Thanks,

> 
> > ---
> >  Documentation/iio/adxl345.rst | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
> > index 4bd038cb4a37..afdb35f8b72e 100644
> > --- a/Documentation/iio/adxl345.rst
> > +++ b/Documentation/iio/adxl345.rst
> > @@ -157,6 +157,7 @@ sensor terms, free-fall is defined using an inactivity period ranging from 0.000
> >  to 1.000 seconds.
> >  
> >  The driver behaves as follows:
> > +
> >  * If the configured inactivity period is 1 second or more, the driver uses the
> >    sensor's inactivity register. This allows the event to be linked with
> >    activity detection, use auto-sleep, and be either AC- or DC-coupled.  
> 
> 


