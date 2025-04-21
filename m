Return-Path: <linux-iio+bounces-18418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D6A95050
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AE81893895
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65D26461B;
	Mon, 21 Apr 2025 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP5EJVrK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F18D2641D5;
	Mon, 21 Apr 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235457; cv=none; b=uGm2ySiVFEcWZZo806q3msW/Y1ENcWzDQ1A6OCl9XY1zuo9NKOwy9fIiT9ZUPwoMFf1VIK2YJEeBmTvnhHDJYzMEcIe7V8zM18aQlS1BuCvRpzh9iJMWzUF8X8BaId17edOt1zrbte+F+RZM9++ZimODTAOjii55sYrxSHMKL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235457; c=relaxed/simple;
	bh=aJdgUbtTRV3TkqzcwM6X02hCl1vvO5pAYQeD66ZHgBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avjHKWWqlnlVsDrp/00N0AgA8zE9/5bfTTSSqbtAE0d27LT37ct3FfDb89dneui9aNpNwpwmTn/Gm3RXuaGZ9Zo+5GQvt3jXBsGj7dKzbrcb7aHJUpwwidz1Sfv0Hsya06ihOWRVn5AJG0Z1HIHcsWQUzPM/198qlZ8MrljfjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP5EJVrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFADBC4CEE4;
	Mon, 21 Apr 2025 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745235456;
	bh=aJdgUbtTRV3TkqzcwM6X02hCl1vvO5pAYQeD66ZHgBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kP5EJVrKCaG8Z8ltV1+AGgKNfwzd7RBfBGr0wlANayMtdzbJ8pmzs732WNx0K/EQQ
	 OWrsWHCMpwc+OMsQ9ybes7pLvMe73UshrrG8iDa25xZota0wNwjKX9oMHj1lhLWPEk
	 SZ61f/1zUWIqdmucnPR6dMZbuK65p0dAW2efUXigV2Cl3o7qHR42HhYq+4sIyFCIG4
	 9LMsBnotj6DmOCulxmGII7vWpqo9wDfsuzZORSaojEQBA+l1b+5ztM+WWiSMa6qgI5
	 EFRNry4gzmc2hYjVg6vM3oNj9DNhUTwCjTZ3SVavEwey5EM/fChNFi72XRcrWh50/H
	 eZ6g09Q785TAw==
Date: Mon, 21 Apr 2025 12:37:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 2/3] staging: iio: ad9832: Refactor powerdown control
Message-ID: <20250421123728.1564039d@jic23-huawei>
In-Reply-To: <20250420175419.889544-3-gshahrouzi@gmail.com>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
	<20250420175419.889544-3-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Apr 2025 13:54:18 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> Replace custom implementation with out_altvoltage_powerdown ABI. The
> attribute's logic is inverted (1 now enables powerdown) to match the
> standard. Modernize driver by using the standard IIO interface.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 44 ++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 0872ff4ec4896..a8fc20379efed 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -167,6 +167,34 @@ static int ad9832_write_phase(struct ad9832_state *st,
>  	return spi_sync(st->spi, &st->phase_msg);
>  }
>  
> +static ssize_t ad9832_write_powerdown(struct device *dev, struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad9832_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned long val;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		goto error_ret;
> +
> +	mutex_lock(&st->lock);

Look at how guard(mutex)(&st->lock);
can be used in this driver to simplify things considerably.
May make sense to do that before introducing this new code.

> +	if (val)
> +		st->ctrl_src |= AD9832_SLEEP;
> +	else
> +		st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
> +				 AD9832_CLR);
> +
> +	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> +				st->ctrl_src);
> +	ret = spi_sync(st->spi, &st->msg);
> +	mutex_unlock(&st->lock);
> +
> +error_ret:
> +	return ret ? ret : len;
> +}
> +
>  static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t len)
>  {
> @@ -227,17 +255,6 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  					st->ctrl_fp);
>  		ret = spi_sync(st->spi, &st->msg);
>  		break;
> -	case AD9832_OUTPUT_EN:
> -		if (val)
> -			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
> -					AD9832_CLR);
> -		else
> -			st->ctrl_src |= AD9832_SLEEP;
> -
> -		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> -					st->ctrl_src);
> -		ret = spi_sync(st->spi, &st->msg);
> -		break;
>  	default:
>  		ret = -ENODEV;
>  	}
> @@ -266,8 +283,7 @@ static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
>  
>  static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
>  				ad9832_write, AD9832_PINCTRL_EN);
> -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
> -				ad9832_write, AD9832_OUTPUT_EN);
> +static IIO_DEVICE_ATTR(out_altvoltage_powerdown, 0200, NULL, ad9832_write_powerdown, 0);

Take a look at the use of extended attributes used for this like we see
in ad5064.c
That will need an actual channel though so is a more significant rework.

>  
>  static struct attribute *ad9832_attributes[] = {
>  	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> @@ -281,7 +297,7 @@ static struct attribute *ad9832_attributes[] = {
>  	&iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
>  	&iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> -	&iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
> +	&iio_dev_attr_out_altvoltage_powerdown.dev_attr.attr,
>  	NULL,
>  };
>  


