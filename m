Return-Path: <linux-iio+bounces-17791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4ABA7ECC9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 21:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FE87A234F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008F21A931;
	Mon,  7 Apr 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="titk398F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3520FAB3;
	Mon,  7 Apr 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053375; cv=none; b=pCyUxfYvOTRXfcGRiullz8E9r/jLtreTGJJAMbS4pHVbgs2dPfutOHDLxV8MsOFTUQ3DK8UTP3xN2hAUOjKeJHx0AqToYdT7s31abtVPMmY1gnzklumPibQ3qM7ZG5Opmzl6bRmMW0IOsod4ri9RRdIv+Tz/mLi4NaZIEBL0zcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053375; c=relaxed/simple;
	bh=ls3pQ4zOX2ZmPqSHWr22ns/S7b4klP0cQbKelqg20fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOeCr/cnAjUAyMBG32ekquI7d+Pa//bINVfhF4vzv4/GVLjRheSGDfY+3/nWEbnuvjLkQ63Bw/kcAmqJSI8Jm+oFlmW0byMsRHFNori1DsCncON8JRlVOIfbUSLgsVPEwyrPz9ttVYQFKeMSmzQmxiyQtrvCq7gIeMScKgpq9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=titk398F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F906C4CEDD;
	Mon,  7 Apr 2025 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744053375;
	bh=ls3pQ4zOX2ZmPqSHWr22ns/S7b4klP0cQbKelqg20fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=titk398FE7EbC7BBzPwmqLT7MITU9HVzPAAGefV2GTa5Ff6MueDlvsEil0p8rkm8A
	 vj+cPlcVFdMBJpgphUFuCUu9pYm1AG+hEH3J42Uegnzj0Nzwb/eIckUgVQHXcti15S
	 hnIaVWRynRNaMAvcf8ht6AiroI3rRDyOlT13r12YNFoi1vyKbJqEealMC46gIN7M8S
	 0X60hMTtGTpZou0fmj915fID7NurZPSU8mAGC9PS++HeJdfxVto3Uwkj+bsK8qOrX+
	 WIDqFheeFWKXVXOsgX5+3fNGo8CvpIdEp6cUJjpBpwGcCQOXeCR1wLSfAy+ETvP2KN
	 HgJcPOeLbNBUA==
Date: Mon, 7 Apr 2025 20:16:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Linus Walleij <linus.walleij@linaro.org>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/7] iio: convert GPIO chips to using new value setters
Message-ID: <20250407201607.27257aa2@jic23-huawei>
In-Reply-To: <20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@linaro.org>
References: <20250407-gpiochip-set-rv-iio-v1-0-8431b003a145@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 09:18:08 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. We're in the process of
> converting all GPIO drivers to using the new API. This series converts
> all the IIO GPIO controllers and also contains some additional
> refactoring patches for ad5592r in preparation for the conversion.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Nice.  All the _rv patches look good to me. Just a few minor things
on the precursors.  One other driver crossed with this, but Matti has
posted a patch updating that one as well.

https://lore.kernel.org/all/Z_N_J52IZ2IaWawl@mva-rohm/

Thanks,

Jonathan

> ---
> Bartosz Golaszewski (7):
>       iio: dac: ad5592r: destroy mutexes in detach paths
>       iio: dac: ad5592r: use lock guards
>       iio: dac: ad5592r: use new GPIO line value setter callbacks
>       iio: adc: ti-ads7950: use new GPIO line value setter callbacks
>       iio: adc: ad4130: use new GPIO line value setter callbacks
>       iio: addac: ad74413r: use new GPIO line value setter callbacks
>       iio: addac: ad74115: use new GPIO line value setter callbacks
> 
>  drivers/iio/adc/ad4130.c       |  10 ++--
>  drivers/iio/adc/ti-ads7950.c   |  17 ++++--
>  drivers/iio/addac/ad74115.c    |  18 +++---
>  drivers/iio/addac/ad74413r.c   |  28 ++++-----
>  drivers/iio/dac/ad5592r-base.c | 132 +++++++++++++++++------------------------
>  5 files changed, 95 insertions(+), 110 deletions(-)
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250401-gpiochip-set-rv-iio-b064ce43791d
> 
> Best regards,


