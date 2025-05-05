Return-Path: <linux-iio+bounces-19141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D788AA99B5
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE6B169FFC
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED682686B3;
	Mon,  5 May 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjc3O5yi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87121991A9;
	Mon,  5 May 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463887; cv=none; b=IV58aUfJInNwCN5cx8DuBg692A1TVQfymD0nznKGIP50U6qPfmp/6i723NWo1lGtXkb7Eym6hrNeSOCU59O8CxgmDL6oPne5DUR69OoTGbux6T9LkC1joyoyInbz25/4eNzub/wG415SVTRMtt+nYi0faudvxOorbseWmBtYKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463887; c=relaxed/simple;
	bh=Lypr8PqwayMP96zhHBlB+3M0p/syxYZMFsxUdSjBoeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKsuAsjYC1H1fKK3jdS2TLZgs2G4tm2TaFIRR8DCG1LGrayvP5t8v23yUlb124HUXHcXv7COTobhQzXOMWW+WH0pUniQ5klv1+maxWe10QVxDK4OuSQPsOx3iMdErqGUj2H2w/+9cuKr9bfZEbOQlEF0SK9zllQWkbIzDYCop+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjc3O5yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7E7C4CEE4;
	Mon,  5 May 2025 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463887;
	bh=Lypr8PqwayMP96zhHBlB+3M0p/syxYZMFsxUdSjBoeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qjc3O5yivfkrhGsJNCFTEVT1y1XMjoAXhwZ5CKwBbiF4zbvuc0ErMQbym5QQeawYY
	 sRj4a1jLP0x3qHA2KJblpW2oYEbWLwDwLVoInBlp69IXxmNKOVX0qjELXCQO4Ed7mR
	 9ucNMsVQ46QSRhQ2XAz86W/Zg8ElgWdPsFABuBHdjSraU41796B1p6wOOGa6Ykj90V
	 rS/FPO3tF27wpVGyLE1J7NvY8h8nlE9nBwBg3hQEd+Tb7B/eSgYIcMup6ksBmiitpb
	 H6BrSCPA39WFpc1JiUvq1UTVU/Wssni74M0merb7kZtBQNSm85nr5/1dfUlVRS5C8b
	 pkb0J5VfVr84w==
Date: Mon, 5 May 2025 17:51:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: accel: fxls8962af: Fix temperature
 calculation
Message-ID: <20250505175120.40076227@jic23-huawei>
In-Reply-To: <20250505-fxls-v3-1-8c541bf0205c@geanix.com>
References: <20250505-fxls-v3-0-8c541bf0205c@geanix.com>
	<20250505-fxls-v3-1-8c541bf0205c@geanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 May 2025 08:20:19 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> According to spec temperature should be returned in milli degrees Celsius.
> Add in_temp_scale to calculate from Celsius to milli Celsius.
> 
> Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> Cc: stable@vger.kernel.org
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
See below.

> ---
>  drivers/iio/accel/fxls8962af-core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index bf1d3923a181798a1c884ee08b62d86ab5aed26f..27165a14a4802bdecd9a89c38c6cda294088c5c8 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -23,6 +23,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> @@ -439,8 +440,16 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
>  		*val = FXLS8962AF_TEMP_CENTER_VAL;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		return fxls8962af_read_full_scale(data, val2);
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = 2 * MSEC_PER_SEC;

For a temperature?   Andy was referring to that particular units.h
define for a the delay that happened to be below the code you were changing
in v1 not this one!  Here we have MILLIDEGREE_PER_DEGREE defined.

> +			return IIO_VAL_INT;
> +		case IIO_ACCEL:
> +			*val = 0;
> +			return fxls8962af_read_full_scale(data, val2);
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return fxls8962af_read_samp_freq(data, val, val2);
>  	default:
> @@ -736,6 +745,7 @@ static const struct iio_event_spec fxls8962af_event[] = {
>  	.type = IIO_TEMP, \
>  	.address = FXLS8962AF_TEMP_OUT, \
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_SCALE) | \
>  			      BIT(IIO_CHAN_INFO_OFFSET),\
>  	.scan_index = -1, \
>  	.scan_type = { \
> 


