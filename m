Return-Path: <linux-iio+bounces-10775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7145D9A4D9E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A5EB22483
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2BF1DFE15;
	Sat, 19 Oct 2024 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhQq5cRR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73628EF;
	Sat, 19 Oct 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339463; cv=none; b=Q9RYNQw5MCDUcW4OMqos+cVzUxKFuFl4Bg9IARYqlKrl/eZS353mHKsZk6cL3jDM58Chne+iLMdQ9AmHQKnCzD986dLWoGCPG1VemtUznbNId4lWxKNg2iFR8MkpOIQney2JWs+50Vyw1xH2fWTnxF6ApiPAmxkutjJMM3E7EOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339463; c=relaxed/simple;
	bh=iflsmVDvSJnfEanvEwKT7iKmKWPw5/HBrPRt8P5wumo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kk6ZSTtTZgLDhEM2+vXaqD0Te7jakCa1sUuIsaYvJFWFMHJbtMAeRgVHxomCDuyh38yVwl8G7fI3bOvwJcz5TVaR7tG1cevoyaw/tzcBaT6fYD832JC7E8Ov7zCvK0aD2YwkY40M6VKWx32dm0wIblfQO8EO86Q1dBXfefSgen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhQq5cRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E05BC4CEC5;
	Sat, 19 Oct 2024 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729339462;
	bh=iflsmVDvSJnfEanvEwKT7iKmKWPw5/HBrPRt8P5wumo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhQq5cRRAhhGNy2tm1ca4/8glZTU1ZwSBNrJyEg0X0W/4uGoYwPAuGX/CNtdLj9kb
	 lMmHw85uJRe6Yvx99fS8KyX+LMvPzu3lB99lHMlj/8BeWJPmC3p3C7S9OwZJd63OP6
	 e98gSMZJYEZmUlt8EM6uXywQB4PA24MAla3kdXCCcw/NyL9FcMw75lEl8fiaCUkAzq
	 /mZ7XNueFiLbeMRZ9xmb96/OGJ8YYMiovov1qcV10TEyoorwPpwHmI6OWyH/XDvb2j
	 Xol5gF6kDqZ2xlqlfBhx+eS/1GEyEk+9NRXELu2Fr5n80EVMYb/TF0iAExloDReIHE
	 cy0yAT6zUy9BQ==
Date: Sat, 19 Oct 2024 13:04:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <20241019130414.014a6384@jic23-huawei>
In-Reply-To: <20241018-iio-read-avail-release-v4-2-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
	<20241018-iio-read-avail-release-v4-2-53c8ac618585@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 12:16:41 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Consumers need to call the producer's read_avail_release_resource()
> callback after reading producer's available info. To avoid a race
> condition with the producer unregistration, change inkern
> iio_channel_read_avail() so that it copies the available info from the
> producer and immediately calls its release callback with info_exists
> locked.
> 
> Also, modify the users of iio_read_avail_channel_raw() and
> iio_read_avail_channel_attribute() to free the copied available buffers
> after calling these functions.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
Hi Matteo,

The cleanup.h stuff is new and comes with footguns. As such the
'rules' applied are perhaps stricter than then will be in the long term.
https://lore.kernel.org/all/172294149613.2215.3274492813920223809.tip-bot2@tip-bot2/
is what we have today. Particularly the last few paragraphs on usage.

> @@ -857,7 +879,7 @@ static int iio_channel_read_min(struct iio_channel *chan,
>  				int *val, int *val2, int *type,
>  				enum iio_chan_info_enum info)
>  {
> -	const int *vals;
> +	const int *vals __free(kfree) = NULL;

Unlike below this one is 'almost' ok because there isn't much below. However,
still not good because of the risk of future code putting something in between.
At very minimum move it down to just before the place it's allocated.

It's a bit messy but maybe what we need is:

int *iio_read_avail_channel_attribute_retvals(struct iio_channel *chan,
				     	      int *type, int *length,
				              enum iio_chan_info_enum attr)
{
	int *vals;
	int ret;

	ret = iio_read_avail_channel_attribute(chan, &vals, type, len, attr;
	if (ret)
		return ERR_PTR(ret);

	return vals;
}

Then you can do
	const int *vals __free(kfree) =
		iio_channel_read_avail_retvals(chan, type, &length, info);

	if (IS_ERR(vals))
		...

and obey the suggested style for cleanup.h usage.

Would need some clear comments on why it exists though!
(+ maybe a better name)


>  	int length;
>  	int ret;
>  

> diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
> index 0a40f425c27723ccec49985b8b5e14a737b6a7eb..6b7856e69f5fb7b8b73166b9b6825f4af7b19129 100644
> --- a/drivers/power/supply/ingenic-battery.c
> +++ b/drivers/power/supply/ingenic-battery.c
> @@ -6,12 +6,14 @@
>   * based on drivers/power/supply/jz4740-battery.c
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/property.h>
> +#include <linux/slab.h>
>  
>  struct ingenic_battery {
>  	struct device *dev;
> @@ -62,7 +64,7 @@ static int ingenic_battery_get_property(struct power_supply *psy,
>   */
>  static int ingenic_battery_set_scale(struct ingenic_battery *bat)
>  {
> -	const int *scale_raw;
> +	const int *scale_raw __free(kfree) = NULL;
This isn't a good pattern as per the docs I just replied to v3 with.
Whilst the code is functionally correct today, it is fragile for the reasons
in those docs.

>  	int scale_len, scale_type, best_idx = -1, best_mV, max_raw, i, ret;
>  	u64 max_mV;
>  


