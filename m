Return-Path: <linux-iio+bounces-16235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF439A4B141
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 12:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73AC16C0D0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFC1D5146;
	Sun,  2 Mar 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITuNki81"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1423F362;
	Sun,  2 Mar 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740915916; cv=none; b=BEXuyVNc5aqgRHgfvz4tgG7EP+VTX9XFVqHes2DYOzSLufCpiuUnHGq1m7G8IFYKvGC94Ba/lHXSn3UuYXfweHmtzKROgZIMk9kXnMCD53Eq7RSqzcdN10qsibZqdCO0ikMFB0OEBBONGKVL2Z8t0fQqTR3yMzNgntHbtR/hVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740915916; c=relaxed/simple;
	bh=RZ35PwK5QdmuASYp+brV92imGKksvWNy8ydEI+CYhZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHf7kZn/jkqjHGnm3CnM2J6OHEP4Jf4gi/NSXLfNfokOm/tJNOQhyR21O9bW6cSVKB/MW3u23hgwUWjOLgA5Cf6YUvBdvNbsCH3zPKLqj5Eh6q57nOOlL8VsHDGFJw4AxCScmVP8IK6uGUSr8FSoMWhVFoJv6A/NEgMd5C/XZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITuNki81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D17C4CED6;
	Sun,  2 Mar 2025 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740915916;
	bh=RZ35PwK5QdmuASYp+brV92imGKksvWNy8ydEI+CYhZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ITuNki818+acnmzD4eDkf+UnNZjwNFnXsXc8TsyhfG6dVOheqg3JIDvZo1CxWLkid
	 tsVavoiL3eFNCk35FGcukmpJjqyMngoQjXAAgSqVvxejC37SXAGmZfIPcYz8eztdlM
	 M62+xez2xnk5D9st3Gac0GzCptMn6pZ9V0I/1pqeKesxxsjGzddILcN9d8+zYe/evL
	 mH/WH827hEFoJZg1ZHZoIatRpe3Bw6jFNDMaeWccJumLXvBRl1Cb4qWd0ckd8n3CKr
	 QDL4fKi8hnpfjefFtlrHtqnNm9r4sl+T6j6Am6W25K4a4yDxGW7uBuJM3HtLoxUdIw
	 Q+fN69YLadThA==
Date: Sun, 2 Mar 2025 11:45:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 04/15] iio: accel: adxl345: use regmap cache for INT
 mapping
Message-ID: <20250302114503.26cbcd97@jic23-huawei>
In-Reply-To: <20250220104234.40958-5-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 10:42:23 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Use regmap cache to replace maintaining the member variable intio
> for the interrupt mapping state. The interrupt mapping is initialized
> when the driver is probed, and it is perfectly cacheable.
> 
> The patch will still leave the function set_interrupts(). A follow up
> patch takes care of it, when cleaning up the INT enable register
> variable.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h      |  4 ++
>  drivers/iio/accel/adxl345_core.c | 63 ++++++++++++++++++++------------
>  drivers/iio/accel/adxl345_i2c.c  |  2 +
>  drivers/iio/accel/adxl345_spi.c  |  2 +
>  4 files changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index bc6d634bd85c..a2a81caa292a 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -8,6 +8,8 @@
>  #ifndef _ADXL345_H_
>  #define _ADXL345_H_
>  
> +#include <linux/regmap.h>

Why add this include?

The file should have a forwards def of
struct regmap;
which is currently missing.  If you clean that up in this patch that
is fine (mention it in the patch description though as it isn't
directly related) but I don't see a reason to include regmap.h here.

Given rest if fine I'll tweak this whilst applying. Applied to the
togreg branch of iio.git, pushed out for now as testing for 0-day
to poke at it.

Also move to a newer kernel tree. The changes in export symbol
should be causing you build errors for this path. I'll fix that up.
Quotes now needed around IIO_ADXL345 in the EXPORT_SYMBOL_NS_GPL()
calls. I fixed that up.

Jonathan

