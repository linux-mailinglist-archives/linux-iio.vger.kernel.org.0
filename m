Return-Path: <linux-iio+bounces-10949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2A9AB5FB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407A01F23821
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D861C9EA3;
	Tue, 22 Oct 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKXpYr0E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07F1C9DF7;
	Tue, 22 Oct 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621803; cv=none; b=rJqLDF7cIlcg757cdgNyOPpSNLhu5xeNzb4iQcEdbkQAH7RTIXH+YYQOyv8sn+F+l6c1acpFWK2w8/SjfJp7lZgw3UlSFCIF5I0+fivCkOLtz99NNXUOJf3TiBf2cQ3MgFAEKwRc0oMdvP10BAOUq565Y5nG7BnM5j8cuCq1t4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621803; c=relaxed/simple;
	bh=EVAvYEzgrFvL0fsZIkIeDpyDGGOUwxxZY4ScVZbasuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHfi/OXlPGeMv4ZC1hw+icaV/n5cJyW9ycSxc37A1/IGEkJZNgUYnwoinPsK0rTZ7SyxPIWOkEklspTxXV36kgrVeg1TEV4thidLphs8OUAPYuqZGP6UsnsB6tss9MHduYHcnT+zHs+GuwbRtwTRSfFaXfmZx+wRajZG73G7sCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKXpYr0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917B7C4CEC3;
	Tue, 22 Oct 2024 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729621803;
	bh=EVAvYEzgrFvL0fsZIkIeDpyDGGOUwxxZY4ScVZbasuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WKXpYr0ELUmW4KwvxXrIQHBOe8+0ANH4cinonSdYCKOOhhGbpOgHxMl1Gy5hg4oM2
	 EQcx9j21dE4fY9Q8jaA7T5WrgBhiGqVb7/mNms186DWBzZba2o0lbTKESzcDD1mPIM
	 M3UznbhK5NOmg/vdTBnfqfvYf7JrWoIgA1+OpjLd6W0/2AY6m8WW0Wvj+qQPHXbMeJ
	 yWb+hQz5EQfK4Yufvqa0vZ5pEPoCUolAmUf0nVI2H8A6w4XM51SlCE1HyqVArUTTAZ
	 ZKqxU8RDM5RXy+RKgv9DnqwHHErRc9ghv+4dpWfmBGMkVNAesvyZxoPXL1xcNlPoMs
	 p7sLWjtMfBAxQ==
Date: Tue, 22 Oct 2024 19:29:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: adc: Remove "default n" entries
Message-ID: <20241022192956.69b78de2@jic23-huawei>
In-Reply-To: <20241022143600.3314241-1-andriy.shevchenko@linux.intel.com>
References: <20241022143600.3314241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 17:36:00 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Linus already once did that for PDx86, don't repeat our mistakes.
> TL;DR: 'n' *is* the default 'default'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a21ed997a8c1..d8abe28eec89 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1619,7 +1619,6 @@ config TWL4030_MADC
>  config TWL6030_GPADC
>  	tristate "TWL6030 GPADC (General Purpose A/D Converter) Support"
>  	depends on TWL4030_CORE
> -	default n
>  	help
>  	  Say yes here if you want support for the TWL6030/TWL6032 General
>  	  Purpose A/D Converter. This will add support for battery type

Applied.

