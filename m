Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D42107E60
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfKWMdu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMdt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:33:49 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAB5920659;
        Sat, 23 Nov 2019 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574512428;
        bh=SX9uwNtL9v7qjWNQRu7F8p6qR03K6r5mhx5QqxMZNcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iF/AmsuB3TDjwSt7yOh64uAzbOPCXTEMXiAVAZZEbn4yzCn7K/8VEJWy9h/SzuTAH
         rgE3lqfRzQTZPuCiWnzVl6UT8ImvKVk91sfq6Sb/IQ0PwKQjcJZ60edA5K0fKDw+hR
         aFyhhUy+FfdQ399HekWAc99fJCKCxlo+ORyZDR48=
Date:   Sat, 23 Nov 2019 12:33:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [v3 4/9] RFC: iio: core: add char type for sysfs attributes
Message-ID: <20191123123343.7ee8cd86@archlinux>
In-Reply-To: <20191120144756.28424-5-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-5-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:51 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch introduces IIO_VAL_CHAR type for standard IIO attributes to
> allow for attributes that needs to be represented by character rather
> than a number. This is preparatory for introducing a new attribute whose
> purpose is to describe thermocouple type, that can be i.e. "J", "K", etc..
> 
> The char-type value is stored in the first "value" integer that is passed
> to the .[read/write]_raw() callbacks.
> 
> Note that in order to make it possible for the IIO core to correctly parse
> this type (actually, to avoid integer parsing), it became mandatory for
> any driver that wish to use IIO_VAL_CHAR on a writable attribute to
> implement .write_raw_get_fmt().
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Cc: Daniel Gomez <dagmcr@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
applied.  I dropped the RFC part though given it's going in ;)

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 22 ++++++++++++++++++----
>  include/linux/iio/types.h       |  1 +
>  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f72c2dc5f703..958b5c48a86f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -596,6 +596,8 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  		}
>  		return l;
>  	}
> +	case IIO_VAL_CHAR:
> +		return snprintf(buf, len, "%c", (char)vals[0]);
>  	default:
>  		return 0;
>  	}
> @@ -837,7 +839,8 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  	int ret, fract_mult = 100000;
> -	int integer, fract;
> +	int integer, fract = 0;
> +	bool is_char = false;
>  
>  	/* Assumes decimal - precision based on number of digits */
>  	if (!indio_dev->info->write_raw)
> @@ -855,13 +858,24 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		case IIO_VAL_INT_PLUS_NANO:
>  			fract_mult = 100000000;
>  			break;
> +		case IIO_VAL_CHAR:
> +			is_char = true;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
>  
> -	ret = iio_str_to_fixpoint(buf, fract_mult, &integer, &fract);
> -	if (ret)
> -		return ret;
> +	if (is_char) {
> +		char ch;
> +
> +		if (sscanf(buf, "%c", &ch) != 1)
> +			return -EINVAL;
> +		integer = ch;
> +	} else {
> +		ret = iio_str_to_fixpoint(buf, fract_mult, &integer, &fract);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
>  					 integer, fract, this_attr->address);
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index fa824e160f35..8e0026da38c9 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -25,6 +25,7 @@ enum iio_event_info {
>  #define IIO_VAL_INT_MULTIPLE 5
>  #define IIO_VAL_FRACTIONAL 10
>  #define IIO_VAL_FRACTIONAL_LOG2 11
> +#define IIO_VAL_CHAR 12
>  
>  enum iio_available_type {
>  	IIO_AVAIL_LIST,

