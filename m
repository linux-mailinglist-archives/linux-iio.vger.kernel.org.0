Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1118EAB0
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgCVRQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVRQW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:16:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E852A20724;
        Sun, 22 Mar 2020 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584897381;
        bh=9gTSfKk8I5LGL+fLb1nRkCc9tX0yRLSUxp6O7JviomM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HVwlwDZK+8wkAt4cBeICxTGTIEKNm9DZTpVY4HWSBxvkVBJDdNnSbi6yEgOOc+sah
         4K/mMu5ULKmx8czqlx/CTFrxM4qo2YOoFsK4q7nTIO7+awEowUsBusmT+XtMFZEgbC
         gnUEA0GRL2vzCR4c1R5OvK1vdf/GXaep2INaTd6I=
Date:   Sun, 22 Mar 2020 17:16:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/5] iio: pressure: bmp280: Use IIO_DEVICE_ATTR_RO
 macro
Message-ID: <20200322171617.5b176335@archlinux>
In-Reply-To: <20200317101813.30829-2-andriy.shevchenko@linux.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
        <20200317101813.30829-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Mar 2020 12:18:10 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use the IIO_DEVICE_ATTR_RO macro to create the device attributes.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hmm. Minor gain but fair enough I guess.

Could consider using the core support _available attributes instead.

I'm not usually fussy about moving drivers over to that unless we have
an in kernel consumer, but if you are going to touch the code it
might be nice to move to them :)

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 5e229b95308e..25be3ff1a6ab 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -588,7 +588,7 @@ static ssize_t bmp280_show_avail(char *buf, const int *vals, const int n)
>  	return len;
>  }
>  
> -static ssize_t bmp280_show_temp_oversampling_avail(struct device *dev,
> +static ssize_t in_temp_oversampling_ratio_available_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
> @@ -596,8 +596,9 @@ static ssize_t bmp280_show_temp_oversampling_avail(struct device *dev,
>  	return bmp280_show_avail(buf, data->chip_info->oversampling_temp_avail,
>  				 data->chip_info->num_oversampling_temp_avail);
>  }
> +static IIO_DEVICE_ATTR_RO(in_temp_oversampling_ratio_available, 0);
>  
> -static ssize_t bmp280_show_press_oversampling_avail(struct device *dev,
> +static ssize_t in_pressure_oversampling_ratio_available_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
> @@ -605,17 +606,12 @@ static ssize_t bmp280_show_press_oversampling_avail(struct device *dev,
>  	return bmp280_show_avail(buf, data->chip_info->oversampling_press_avail,
>  				 data->chip_info->num_oversampling_press_avail);
>  }
> -
> -static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available,
> -	S_IRUGO, bmp280_show_temp_oversampling_avail, NULL, 0);
> -
> -static IIO_DEVICE_ATTR(in_pressure_oversampling_ratio_available,
> -	S_IRUGO, bmp280_show_press_oversampling_avail, NULL, 0);
> +static IIO_DEVICE_ATTR_RO(in_pressure_oversampling_ratio_available, 0);
>  
>  static struct attribute *bmp280_attributes[] = {
>  	&iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
>  	&iio_dev_attr_in_pressure_oversampling_ratio_available.dev_attr.attr,
> -	NULL,
> +	NULL
>  };
>  
>  static const struct attribute_group bmp280_attrs_group = {

