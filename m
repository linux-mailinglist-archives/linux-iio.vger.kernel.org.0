Return-Path: <linux-iio+bounces-21608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17376B03158
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846143B5435
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA64231A51;
	Sun, 13 Jul 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR9DVSfB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F5A15746F;
	Sun, 13 Jul 2025 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415825; cv=none; b=HUm6gqGiP35U7WRIIQ97gAJ6k+PK4/sh0ZC5iZG98uXdtJbZmtQ5/FETMp0efn2S3S5OUgm9uJhebdeLV2JcOh4ODDaLI43Ax384LFZZe3F4nZznJ4m1u5dxeLuPOsSCGFt1O/8XBVC4CFtssRi5cOlk3ECdYbFUKld/vEnaauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415825; c=relaxed/simple;
	bh=xurqLhShBn9ORVHzPNJ7as+R/dvH0EDOJ+H0NB6U/bU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h270MlEdnmNXLGNWkG36TSEPOjabB+Py6R3OtNIG54bNt7cKKM142Z8RdOvtN+Y+1XAGtuHHRhs5xxixwRfsTfYl0tWUG1Uiv4Y3iAgqd4QZ6O9euNY7b6PNClO6YmokdxjLuqUU/2xGxL4nb5AgwHkwjGxjOXVnkhOGOaOfN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR9DVSfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8155BC4CEE3;
	Sun, 13 Jul 2025 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752415825;
	bh=xurqLhShBn9ORVHzPNJ7as+R/dvH0EDOJ+H0NB6U/bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lR9DVSfBDgU70fjBjyXisAX/nkQsUpJHDm3NvMNGjgxv2bPTWwCH+heo6S2ZHRETj
	 OADzImH75uJUkCA8q6JWwr8HTk5WPbrKac5MlRWI8R5nXBrY0xoQj5ILfVZrwNJ2Da
	 gavDKr4e3KkOeIVA0CLoFVfv8ucxF0SyWdFOqzEYpsxyI/fH+/VO43Wox+N2G7Cc8p
	 wGz6vKE5+dW5GKZbDb6TShQQMxRv0NRLXLQ/gNpFYyrdfTMhDyTfYjHNs+kjEz34+8
	 TNCQQbbVNzU6vy3KgTlzZx5gXWjwi9jZT+P6QDfUi4GIbNIIhM8Foa5FQWAWAU6fnQ
	 lXjAf4tX13m1g==
Date: Sun, 13 Jul 2025 15:10:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
Message-ID: <20250713151017.28b9d162@jic23-huawei>
In-Reply-To: <4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
	<aHE-o5_TvGtUyHoI@smile.fi.intel.com>
	<b564a925-1d17-43fc-86fb-8db0d845de44@baylibre.com>
	<aHFO7LhWXOuglaoz@smile.fi.intel.com>
	<4d41eafc-46b1-48c7-982a-1a3566f9b423@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 13:38:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/11/25 12:50 PM, Andy Shevchenko wrote:
> > On Fri, Jul 11, 2025 at 12:04:03PM -0500, David Lechner wrote:  
> >> On 7/11/25 11:41 AM, Andy Shevchenko wrote:  
> >>> On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:  
> > 
> > ...
> >   
> >>>> +#include <asm/byteorder.h>  
> >>>
> >>> Hmm... I see nothing about this change in the commit message.  
> >>
> >> It is for __be16. I kind of assumed that would be obvious, but sure,
> >> better to be explicit about it.  
> > 
> > Isn't it in types.h?
> >   
> 
> No, only CPU-endian types are in types.h. The actual #define for
>  __be16 is in include/uapi/linux/byteorder/big_endian.h. This is
> included in one driver in staging, otherwise it is only included
> in arch/*/include/uapi/asm/byteorder.h. And asm/byteorder.h is what
> Jonathan used for similar in some of his recent IWYU patches as well,
> so I assume that is the preferred way to do it.
> 
Never trust me :)  I may have been after be16_to_cpu() or similar
though rather than the type. Can't remember. When I get back to those
I'll take a look at the logs.



