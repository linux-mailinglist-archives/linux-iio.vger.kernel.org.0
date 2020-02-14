Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9198B15D8EC
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgBNOEh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:04:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNOEh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:04:37 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6717C2187F;
        Fri, 14 Feb 2020 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581689076;
        bh=5Nbgc0I1ZGw5tQgg23msJW9B2YwB5KeCgv9blVtlys0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lai5Ucn8ixgYM2a1hMt7uSDt6leWjx5bKHXuu8RxTimuXROi0pqaL8wbE/hmWoiXI
         i0YVh1BIAg4ggNNuph0vW4hLL+2MxZdh8P1UEuO0bfBrnD6fdx9W9eph2jKmCRyfeE
         v9Y0TZBJjCTT7Do/1ccWPThT4UsUUddisX+ozYCw=
Date:   Fri, 14 Feb 2020 14:04:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] iio: core: Handle 'dB' suffix in core
Message-ID: <20200214140430.1038a639@archlinux>
In-Reply-To: <20200206151149.32122-1-beniamin.bia@analog.com>
References: <20200206151149.32122-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Feb 2020 17:11:45 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> This patch handles the db suffix used for writing micro db values.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
A few things came up in build tests that I've fixed up. See inline.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.
Thanks,

Jonathan

> ---
> Changes in v5:
> -handle both 'db' and ' db' cases
> 
>  drivers/iio/industrialio-core.c | 39 ++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 65ff0d067018..684c3b151b29 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -769,17 +769,18 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
>  }
>  
>  /**
> - * iio_str_to_fixpoint() - Parse a fixed-point number from a string
> + * __iio_str_to_fixpoint() - Parse a fixed-point number from a string
>   * @str: The string to parse
>   * @fract_mult: Multiplier for the first decimal place, should be a power of 10
>   * @integer: The integer part of the number
>   * @fract: The fractional part of the number
> + * @scale_db: True if this should parse as dB
>   *
>   * Returns 0 on success, or a negative error code if the string could not be
>   * parsed.
>   */
> -int iio_str_to_fixpoint(const char *str, int fract_mult,
> -	int *integer, int *fract)
> +int __iio_str_to_fixpoint(const char *str, int fract_mult,
> +			  int *integer, int *fract, bool scale_db)
Should be static.

>  {
>  	int i = 0, f = 0;
>  	bool integer_part = true, negative = false;
> @@ -810,6 +811,14 @@ int iio_str_to_fixpoint(const char *str, int fract_mult,
>  				break;
>  			else
>  				return -EINVAL;
> +		} else if (!strncmp(str, " dB", sizeof(" dB") - 1) && scale_db) {
> +			/* Ignore the dB suffix */
> +			str += sizeof(" dB") - 1;
> +			continue;
> +		} else if (!strncmp(str, "dB", sizeof("dB") - 1) && scale_db) {
> +			/* Ignore the dB suffix */
> +			str += sizeof("dB") - 1;
> +			continue;
>  		} else if (*str == '.' && integer_part) {
>  			integer_part = false;
>  		} else {
> @@ -832,6 +841,22 @@ int iio_str_to_fixpoint(const char *str, int fract_mult,
>  }
>  EXPORT_SYMBOL_GPL(iio_str_to_fixpoint);
>  
> +/**
> + * iio_str_to_fixpoint() - Parse a fixed-point number from a string
> + * @str: The string to parse
> + * @fract_mult: Multiplier for the first decimal place, should be a power of 10
> + * @integer: The integer part of the number
> + * @fract: The fractional part of the number
> + *
> + * Returns 0 on success, or a negative error code if the string could not be
> + * parsed.
> + */
> +int iio_str_to_fixpoint(const char *str, int fract_mult,
> +			int *integer, int *fract)
> +{
> +	return __iio_str_to_fixpoint(str, fract_mult, integer, fract, false);
> +}
The export symbol should have moved to here to follow the function.
> +
>  static ssize_t iio_write_channel_info(struct device *dev,
>  				      struct device_attribute *attr,
>  				      const char *buf,
> @@ -842,6 +867,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  	int ret, fract_mult = 100000;
>  	int integer, fract = 0;
>  	bool is_char = false;
> +	bool scale_db = false;
>  
>  	/* Assumes decimal - precision based on number of digits */
>  	if (!indio_dev->info->write_raw)
> @@ -853,6 +879,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		case IIO_VAL_INT:
>  			fract_mult = 0;
>  			break;
> +		case IIO_VAL_INT_PLUS_MICRO_DB:
> +			scale_db = true;
> +			/* fall through */
>  		case IIO_VAL_INT_PLUS_MICRO:
>  			fract_mult = 100000;
>  			break;
> @@ -877,6 +906,10 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		if (ret)
>  			return ret;
>  	}
> +	ret = __iio_str_to_fixpoint(buf, fract_mult, &integer, &fract,
> +				    scale_db);
> +	if (ret)
> +		return ret;
>  
>  	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
>  					 integer, fract, this_attr->address);

