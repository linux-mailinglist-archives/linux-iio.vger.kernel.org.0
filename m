Return-Path: <linux-iio+bounces-10948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996189AB5F9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ED91C22FED
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DB1C8FCF;
	Tue, 22 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0QYrtps"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1C19DF40;
	Tue, 22 Oct 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621763; cv=none; b=gJuz486OjcDkrgzy9nMAFV5AqqzYc4+ZiR4EEGewpDQGnku77mGAX8JlOC+H0Impfoz9msrg4PL26y/FQ0OwnblNr9it3MC3gOQXRVWiZfBu+csym96rJqOARkmcC4vJ/Vtc7SMT09sQeYw+MwOvfmXB1YUgEju6WmbkiXLbqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621763; c=relaxed/simple;
	bh=niFMHusebEt/PY8xe/Xe5giunGLJb0Vw5fWTt+9rLCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBHozWQCiJuuZEWAZFB88O9+v0ZHg9dfJ0aqNYsxbgW0hlPY78dTR609JUG9wOSuwwvJV948ka4zsDbuci8C6JAUG2lkt4SYETrKhk5ngOJiNb5HEjhN1HtoI51BRHOo0IX51XoSECyldE7J9+IHv/JPwkWX078lcxwmvcG+C40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0QYrtps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7614C4CEC3;
	Tue, 22 Oct 2024 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729621762;
	bh=niFMHusebEt/PY8xe/Xe5giunGLJb0Vw5fWTt+9rLCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q0QYrtpsaGkSYyULsGy9aNU7N3LrYr83cp2DXIO7scidxo6akqhrjfx6rwfmDWHQ7
	 vZVbJ6xb9OJtRAVewQUl0f8DSdqKeBiQyeGA+QIU5E85hqRKd4orUPqTQFaLe+E2MC
	 l+1uYi4AOUmsGwROobPVfFFotTAPfv8OiIfkcgJi8Oh3ak4ATR6ULeAWOppe9JMNlo
	 bCrwHQpaqUhP2eFMDa2TN5w6Mwwy9RN24VujhMzs92SNe+TzKN+Cy0u1noNANVZUpb
	 Wrbjh10ViZk1IcNKKjQq1huB/nSKSyYFTCwyzuktpX7/Wb0teskrjPRJYN76k8xnID
	 DDKLrfv0N64nw==
Date: Tue, 22 Oct 2024 19:29:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: light: Remove "default n" entries
Message-ID: <20241022192915.705adc68@jic23-huawei>
In-Reply-To: <20241022143605.3314275-1-andriy.shevchenko@linux.intel.com>
References: <20241022143605.3314275-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 17:36:05 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Linus already once did that for PDx86, don't repeat our mistakes.
> TL;DR: 'n' *is* the default 'default'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.
> ---
>  drivers/iio/light/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 39c0e08a8e06..4d0ba043b65e 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -248,7 +248,6 @@ config SENSORS_ISL29018
>  	tristate "Intersil 29018 light and proximity sensor"
>  	depends on I2C
>  	select REGMAP_I2C
> -	default n
>  	help
>  	  If you say yes here you get support for ambient light sensing and
>  	  proximity infrared sensing from Intersil ISL29018.


