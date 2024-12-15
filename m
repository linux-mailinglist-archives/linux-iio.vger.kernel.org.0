Return-Path: <linux-iio+bounces-13491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F036E9F23BA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E5161A9A
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A71465A5;
	Sun, 15 Dec 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa1PSBtJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625C1119A
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265849; cv=none; b=l+Teqtsw624tzq9wIwLHG5CXTwv9mFmJ1WQnp9ecvuKg2POM1wdvPbBbbPt2vQK41thFQV9rMVrZglUJfoFuJUGY9vdgtaulGcomsyFCjm1AfmndDRqn6Q/S55sVmygp37vgfakdXDSzrK0LzI9T/e09Fjer77/bL8TJM58nDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265849; c=relaxed/simple;
	bh=qApTtuixGSvNcTyH2GJARb6Ym9EpJv7YrdvvXHOj4h4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXeoJ/KTtAC44H58/HFoF8wGwjLVhfcdiSfksN7y//SDs0S9VGhDMa+mLIFmHErVVFAyTrLSlhwACPRN9T2lDPFitpzdpZ9wGJorgAlRxRmm92OV53YdTtui+pG33DPvccnOMIq2rjP0PgHT4MITbsRdVHPTYy+3D8hav+jXwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa1PSBtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455C4C4CECE;
	Sun, 15 Dec 2024 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734265848;
	bh=qApTtuixGSvNcTyH2GJARb6Ym9EpJv7YrdvvXHOj4h4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wa1PSBtJq/j8OAHEWOVIIioO6DMfrTdkbaucZ/d6pszppj8s08Bj9PQ2KohPfSOWA
	 GXfu9IpAKDbjCrOV9iOmF9uNXBCM9MyCvj8QZV+9xy14i1B3rsKW3OnNWUSzbuYOU0
	 MgSfSch9cZCWcW0u2d4Tu9KMpc+dCBPe2WRZ/C0mL2AckSBqSVGXNIXxLadg4ooQFd
	 RWQiHwFf82k2Ts1pu7N4XWlZo6659uM6Ay6G51tppSZpdmDwah2thUNYBQedgU5PQa
	 JPq8Ve/rw3U6gaoOQXCUaFDA2TEylWiZ+AmVoZxfJVQ5MwCZDP8ILeWuQ1sPsrAH+a
	 I5f/Vlu9iA6+g==
Date: Sun, 15 Dec 2024 12:30:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, andriy.shevchenko@intel.com, Fabio Estevam
 <festevam@denx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads124s08: Switch to fsleep()
Message-ID: <20241215123040.36d60bd7@jic23-huawei>
In-Reply-To: <20241209181624.1260868-1-festevam@gmail.com>
References: <20241209181624.1260868-1-festevam@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 15:16:24 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
> 
> According to Documentation/timers/delay_sleep_functions.rst,
> fsleep() is the preferred delay function to be used in non-atomic
> context, so switch to it accordingly.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
This is one is stalled behind the cansleep patch which I decided
was trivial enough and sort of a fix so sent the fast way.

If the two had been together I'd have included this as well, but now
it's just an optimization so needs to go the slow route.

Jonathan

> ---
> Changes since v1:
> - Use andriy.shevchenko@linux.intel.com in the Suggested-by tag.
> - Add Reviewed-by.
> 
>  drivers/iio/adc/ti-ads124s08.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index f452f57f11c9..77c299bb4ebc 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -184,7 +184,7 @@ static int ads124s_reset(struct iio_dev *indio_dev)
>  
>  	if (priv->reset_gpio) {
>  		gpiod_set_value_cansleep(priv->reset_gpio, 0);
> -		udelay(200);
> +		fsleep(200);
>  		gpiod_set_value_cansleep(priv->reset_gpio, 1);
>  	} else {
>  		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);


