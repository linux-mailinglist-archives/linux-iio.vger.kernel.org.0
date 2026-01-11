Return-Path: <linux-iio+bounces-27611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E949ED0EF78
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190B8300A1E2
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8783242C2;
	Sun, 11 Jan 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDEw26+B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514CA14F70;
	Sun, 11 Jan 2026 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137427; cv=none; b=SEHmwBYHUAqa3zHziGAgkWuf+OCrUxRdGHPQgp3cFSX4xHPY1gT1+WctaOpISYcWuHVSZVgE3ZIY/+R5mgkMd3JhzkD6hnYNSw+lIOkJrkj4P/hx9WARKM0OB6HosGdoXqd4MPys7MhydOc4iDyHZe/cDW0iU+dKJUUhmj/lbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137427; c=relaxed/simple;
	bh=UTmaJCOuxe5QH+YMHACQ5BxE2XUjeKBk9T6SiIG2zVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0QmLxJde1InyUn2R/jr0S3j0SMe7p+Lz0cB9giT4G9h+jgTOCE63UTVNwcgSpMUtzGiDLvhzRKQVvdfOGU6yEgu/keJgK2MgKNX8XbnIjY8LqejbBVHLgp5KbU+7fI3FBXyCjIudIPHZpLfrI6BeTB2S5RHfIC66Rs/vokkoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDEw26+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E84C19422;
	Sun, 11 Jan 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768137427;
	bh=UTmaJCOuxe5QH+YMHACQ5BxE2XUjeKBk9T6SiIG2zVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XDEw26+By+nLyw1HgAH7dqiYdpAfhEKqOcpGJgHapq8pZ88JULt/I2AR2sWzJ4L/O
	 IYBP33vhOUJn3pnSDZazOKwUtbnN/OOzgGe4lkaele608uzuAdRQtGbVjLWVhieceT
	 2A31nfoBXOBH7lvdGOu20cfySOMFhTET+uk4TU2Az2yd8MCAe9nHGhHF8yD8BeAr18
	 o5mvGqD5QqTqh+T+yxl/oiFy55Wi7zk/nulu9KkVr89Ny4aoH+CqrCj3W4Hp+rUCgE
	 YE6wFOWRkSwX6gkZasN3/rrlWB2raqYCYK2v4INmVxZ6VmbHLHXrMSwkIYf0whYJ0f
	 fTYWS/A8o7m+A==
Date: Sun, 11 Jan 2026 13:16:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7476: Remove duplicate include
Message-ID: <20260111131658.005da0a6@jic23-huawei>
In-Reply-To: <fd506e0f-9e52-498d-8e35-077ab52efbd7@gmail.com>
References: <20260107082920.2151042-1-nichen@iscas.ac.cn>
	<fd506e0f-9e52-498d-8e35-077ab52efbd7@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 08:06:13 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 07/01/2026 10:29, Chen Ni wrote:
> > Remove duplicate inclusion of linux/bitops.h.
> > 
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>  
> 
> I would also appreciate having the includes alphabetically ordered as 
> Andy suggested. This, however, is a fine fix as it is so:
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied this one.  As Andy observes in v2 review the first patch
should be this anyway!

Thanks,

Jonathan

> 
> > ---
> >   drivers/iio/adc/ad7476.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > index 1bec6657394c..21d3f6aae972 100644
> > --- a/drivers/iio/adc/ad7476.c
> > +++ b/drivers/iio/adc/ad7476.c
> > @@ -16,7 +16,6 @@
> >   #include <linux/gpio/consumer.h>
> >   #include <linux/err.h>
> >   #include <linux/module.h>
> > -#include <linux/bitops.h>
> >   #include <linux/delay.h>
> >   
> >   #include <linux/iio/iio.h>  
> 
> 


