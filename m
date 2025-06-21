Return-Path: <linux-iio+bounces-20828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BBAE2AE4
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636453B51BE
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B92594B4;
	Sat, 21 Jun 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjGA/QwW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4914658D;
	Sat, 21 Jun 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528713; cv=none; b=M7MkNoC/fSfgPn5bCyWCx8Lyy7iDaBqaXeGHW/8CXqTLw7ijO7C2lDsgiFIYcjSGIwQBxmX1b87OGttp1BusoP5ScfPOHZUphPzmgpt8vcD2XbbE0Y3qcbkAKK4wFQU/gtyvJPc3AfBZn2FlTGUFA5IfrlYNnK+TGHGd/Y73Vvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528713; c=relaxed/simple;
	bh=MyCmQU7hUcanUE1IYoSvASBojWays08z4lzKAcFr9e0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM5vgfUPJvHosb2mXl1g+mnRdZIIh1330IFsjoG72aNF3SbUaCnbWh9oIynr+iFWZVt4D0o24dLlg/1HXV2QyJGQMzmXIyfV0jv0Qte1Q3p1cQMiwkXAOQCsgzo2aIYzreBYHEKxGSZsWK/+4wlRr0IBKwCGUAg0LeMMmwum8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjGA/QwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEC7C4CEE7;
	Sat, 21 Jun 2025 17:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528713;
	bh=MyCmQU7hUcanUE1IYoSvASBojWays08z4lzKAcFr9e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YjGA/QwWl8Bu11WPVre6hHiq4R/xlWCYuFreRBMp0n81kqvGyOG4iGXQQQLqz5T3M
	 5PTNwtJeCFnZr4cgGWCFYMHKkRT5+w75tyajDu7sIzTUnqDBZ2K7RDQfRXUQLI6ePe
	 LUcCJFyfFKopBIhb1LkbNEpJmyFo9uzSAEJ8sHGfBpiTM4rugqcU9+vru6FGluVcGb
	 bnFtDhLx3YV8FIFcK7GK9tkk0wFIZAaCEWvYigrOlwlFa4hjsNMOYtlTtEQVIWZTH0
	 fPJxsSh/FInB/Ass9IM9iw8SjfKxdQy0dGs1ljFAAsbJsT3KdR19Eag6ISM8+yjz/D
	 kFDbVbvQWRzzg==
Date: Sat, 21 Jun 2025 18:58:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: accel: sca3000: use sysfs_emit_at() instead
 of sprintf()
Message-ID: <20250621185824.69a11319@jic23-huawei>
In-Reply-To: <20250618031638.26477-5-andrew.lopes@alumni.usp.br>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
	<20250618031638.26477-5-andrew.lopes@alumni.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 00:12:19 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> Use sysfs_emit_at() instead of sprintf() for sysfs operations as
> suggested in the documentation, since it is aware of PAGE_SIZE buffer.
> 
> Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hi.

A few comments inline,

Thanks,

J
> ---
>  drivers/iio/accel/sca3000.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 058a2d67c91c..bc0046b19511 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -423,16 +423,16 @@ sca3000_show_available_3db_freqs(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct sca3000_state *st = iio_priv(indio_dev);
> -	int len;
> +	unsigned int len = 0;

No need to initialize as set on the next line

>  
> -	len = sprintf(buf, "%d", st->info->measurement_mode_3db_freq);
> +	len = sysfs_emit_at(buf, len, "%d", st->info->measurement_mode_3db_freq);

sysfs_emit() when you know you are at the start.


>  	if (st->info->option_mode_1)
> -		len += sprintf(buf + len, " %d",
> +		len += sysfs_emit_at(buf, len, " %d",
>  			       st->info->option_mode_1_3db_freq);
Fix alignment.

>  	if (st->info->option_mode_2)
> -		len += sprintf(buf + len, " %d",
> +		len += sysfs_emit_at(buf, len, " %d",
>  			       st->info->option_mode_2_3db_freq);

same here.

> -	len += sprintf(buf + len, "\n");
> +	len += sysfs_emit_at(buf, len, "\n");
>  
>  	return len;
>  }
> @@ -783,7 +783,6 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct sca3000_state *st = iio_priv(indio_dev);
> -	unsigned int len = 0;
>  	int ret;
>  
>  	scoped_guard(mutex, &st->lock) {
> @@ -794,25 +793,22 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
>  
>  	switch (ret & SCA3000_REG_MODE_MODE_MASK) {
>  	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
> -		len += sprintf(buf + len, "%d %d %d\n",
> +		return sysfs_emit(buf, "%d %d %d\n",
>  			       st->info->measurement_mode_freq,
>  			       st->info->measurement_mode_freq / 2,
>  			       st->info->measurement_mode_freq / 4);
> -		break;
>  	case SCA3000_REG_MODE_MEAS_MODE_OP_1:
> -		len += sprintf(buf + len, "%d %d %d\n",
> +		return sysfs_emit(buf, "%d %d %d\n",
>  			       st->info->option_mode_1_freq,
>  			       st->info->option_mode_1_freq / 2,
>  			       st->info->option_mode_1_freq / 4);
> -		break;
>  	case SCA3000_REG_MODE_MEAS_MODE_OP_2:
> -		len += sprintf(buf + len, "%d %d %d\n",
> +		return sysfs_emit(buf, "%d %d %d\n",
>  			       st->info->option_mode_2_freq,
>  			       st->info->option_mode_2_freq / 2,
>  			       st->info->option_mode_2_freq / 4);
> -		break;
>  	}
> -	return len;
> +	return 0;
>  }
>  
>  /*


