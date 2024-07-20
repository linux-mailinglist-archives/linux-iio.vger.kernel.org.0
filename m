Return-Path: <linux-iio+bounces-7726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C09380E4
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89AD1F21AE2
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0776E12C470;
	Sat, 20 Jul 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKUJOHkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF774129E64;
	Sat, 20 Jul 2024 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721473607; cv=none; b=RyI8nIIrDZgUWLWJoM2V3/xj8Ka45MK4iilctWHu35R7VcP0GILZ6jguML/fXcGt4oat9HqWhvv3q5eC9s8fc30YZ1c6E0JZeHEdGnjReWESmrgTyP0uzZfvQvq/wreAnNLNdhnvpK76zkMEiXur5FYGZdLsXfxogLnep4IAW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721473607; c=relaxed/simple;
	bh=3hlsRR2sfEyeeRzqGSxLJFuuwMm4bIUfoz9fGYr9woQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umwjqJEYyIkavbWo8F6N9iVlZUq2VmW9a2tK6xZTI8xnBZWhNrxXZWTwLqI8nWptapns1l+f6JEFjsHv0W4UzQohNCadJMSazrmZnfRpMZWlGuDfzY1ITuw9r7KQb1kpW+Dq1lU0BfquvRhWmopVjzGIuI5VLBAcAkVL5vvFxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKUJOHkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A33C2BD10;
	Sat, 20 Jul 2024 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721473606;
	bh=3hlsRR2sfEyeeRzqGSxLJFuuwMm4bIUfoz9fGYr9woQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iKUJOHkOqCMz+mdvjeKy/fQbXv7gATJmmMcfm43TTftn7n62sE+C+CEe7lqV6LByU
	 YMvINY4iVrKFuX8FdaFVY4dASVGX8U61i5Jf0JGCGbg2AD/tW2IgTbGWAmN9QJ7++a
	 DwKs+awKCpVsV4Ysl1AkhQyvIbMD7eHclzlGTNSLGBfTeNiOq9zhUfzZOX6r5r22c1
	 7BRMax39P0z3svFLU2tTRkRD6cgbPp9ALco4z0hsESTLe0vwmJ1eSnllfT7/dCj2wA
	 837fMuzY+EqMI2GLz6joHYUD3azzt3OLlGDKr/Ag6rx2yDmRAfiFV1r0QLslGAMQYQ
	 FC3Xk6yyCrczA==
Date: Sat, 20 Jul 2024 12:06:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] iio: pressure: bmp280: Fix waiting time for
 BMP3xx configuration
Message-ID: <20240720120636.38b9cdcb@jic23-huawei>
In-Reply-To: <20240711211558.106327-3-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 23:15:50 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> According to the datasheet, both pressure and temperature can go up to
> oversampling x32. With this option, the maximum measurement time is not
> 80ms (this is for press x32 and temp x2), but it is 130ms nominal
> (calculated from table 3.9.2) and since most of the maximum values
> are around +15%, it is configured to 150ms.
> 
> Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied to what will be the togreg branch of iio.git and marked for stable.

If it needs to move quicker as we have reports of problems from users
let me know.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index cc8553177977..3deaa57bb3f5 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1581,10 +1581,11 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  		}
>  		/*
>  		 * Waits for measurement before checking configuration error
> -		 * flag. Selected longest measure time indicated in
> -		 * section 3.9.1 in the datasheet.
> +		 * flag. Selected longest measurement time, calculated from
> +		 * formula in datasheet section 3.9.2 with an offset of ~+15%
> +		 * as it seen as well in table 3.9.1.
>  		 */
> -		msleep(80);
> +		msleep(150);
>  
>  		/* Check config error flag */
>  		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);


