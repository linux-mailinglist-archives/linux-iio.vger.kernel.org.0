Return-Path: <linux-iio+bounces-16222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE29A4AEEA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 03:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AEE16E376
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 02:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974412AF06;
	Sun,  2 Mar 2025 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SthxoFh4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51916F9E6;
	Sun,  2 Mar 2025 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740883590; cv=none; b=Yu9nwEs1vZIYgvn29RF3/BVpfW+k8+UCT9C3CCFexKN1BrN985PZxEnH2eyI9L+rT69KzheXjKE6Tf331jn5VbE/It75Oz4dNAI2So2D4RfF6D6EaTrKE2wIHUg2gFexzD05dqgLTj8Z3sk3K//qt55UbxsyFMK3rvlHLIcJ2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740883590; c=relaxed/simple;
	bh=Fs0KaqDfOkVhmG3fRCO/ElSH7kHUyQydhtrmgoHhvAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAsej/cC4EmST295bmb03cTO1exc8TuhDpMuAIBKZQlPGMqEQ/10OYbH0UI6GSv4NDos1Tp35GOkftIoQUt9A1RDEX2v2eZDAlAoENTn8YWRlXOXtFbU9Rbz+PsA2GMlYKeIMWjQ2Wa7kxxO9KADjysA74RXJ7yiV5f3froLxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SthxoFh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD460C4CEDD;
	Sun,  2 Mar 2025 02:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740883589;
	bh=Fs0KaqDfOkVhmG3fRCO/ElSH7kHUyQydhtrmgoHhvAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SthxoFh4F8CP0wBUOGfEz6bpjWMBoiR1tDOOW+8gLfDe0RJOWjSLGjl5em6v6S2cR
	 1X4y85UmF3JQ1hKXY8cfwZAWVMBKSRd7yxLOOPdibH+LkgrpjdHsWuSl6I1TeP8ovX
	 UvDdUJtYJs4YnNLgs1kQNEOdEP64ReDFi0OZbhxHrcr1lPaauA+Csv7jhpryuYMtUq
	 6r6AIUQOw1C98ab1BKY7A345RIXsciOsxcnDPOBLksMmJPu2csn+XVpQT1DJdQWEuW
	 WF5EpiRMCOxhfg8fyRCr8+civeJ+DAre3soVQUrqG5sH+lKyp8MOED5YuP8ZWuMwL+
	 vN41QDl3dNMNw==
Date: Sun, 2 Mar 2025 02:46:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 Yu Jiaoliang <yujiaoliang@vivo.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Include cleanup.h when using guard()
Message-ID: <20250302024618.3d01c339@jic23-huawei>
In-Reply-To: <5b352ce7241e5904a317dd26950c7cd4daa59fc0.1740748394.git.mazziesaccount@gmail.com>
References: <5b352ce7241e5904a317dd26950c7cd4daa59fc0.1740748394.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 15:14:03 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Directly include the cleanup.h for the guard() instead of relying it to
> be included via other files.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied.  Thanks,

J
> ---
>  drivers/iio/adc/ad4130.c       | 1 +
>  drivers/iio/adc/ad7091r-base.c | 1 +
>  drivers/iio/adc/ad7606.c       | 1 +
>  drivers/iio/adc/max34408.c     | 1 +
>  drivers/iio/adc/pac1921.c      | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index de32cc9d18c5..afcea2d6d494 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index 606486c4dfe8..931ff71b2888 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d8e3c7a43678..11505846eb4f 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -5,6 +5,7 @@
>   * Copyright 2011 Analog Devices Inc.
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
> index 971e6e5dee9b..4f45fd22a90c 100644
> --- a/drivers/iio/adc/max34408.c
> +++ b/drivers/iio/adc/max34408.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index 90f61c47b1c4..1c28df132e9f 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/unaligned.h>
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
> 
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6


