Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B790B25C8CF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICSgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 14:36:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbgICSf4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Sep 2020 14:35:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162C220709;
        Thu,  3 Sep 2020 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599158156;
        bh=RtFoZ0/9FKBv0NTeglDQyJxlpPjtAuuFzyEfVWbYL/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iavpkADgyXpdM5nvDI2uBmrQmcmuRVGLko5/Aya/zvL5HmCnLZXy6tZeed4GPfSQQ
         x4dOle5uTGKaoje2j86nvAwDk8Yhh1yvonCXXaZ53aUzOc6trOytcYX3GRJBbaw36g
         Gc/f82DBNFa6sMuOFeEnrog16zff3se6iW6ytTFM=
Date:   Thu, 3 Sep 2020 19:35:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/8] iio: accel: bma220: Convert to use
 ->read_avail()
Message-ID: <20200903193551.3b89702e@archlinux>
In-Reply-To: <20200831090813.78841-2-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
        <20200831090813.78841-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 12:08:07 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert to use ->read_avail() instead of open-coded attribute handling.
> 
> While here, fix the typo in array definition and append comma in case of
> the future extension.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I missed a build warning inline. Now fixed.

> ---
>  drivers/iio/accel/bma220_spi.c | 36 ++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index 3247b9c8abcb..cb634a3a995d 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -30,7 +30,6 @@
>  #define BMA220_SUSPEND_WAKE			0x00
>  
>  #define BMA220_DEVICE_NAME			"bma220"
> -#define BMA220_SCALE_AVAILABLE			"0.623 1.248 2.491 4.983"
>  
>  #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
> @@ -55,19 +54,8 @@ enum bma220_axis {
>  	AXIS_Z,
>  };
>  
> -static IIO_CONST_ATTR(in_accel_scale_available, BMA220_SCALE_AVAILABLE);
> -
> -static struct attribute *bma220_attributes[] = {
> -	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group bma220_attribute_group = {
> -	.attrs = bma220_attributes,
> -};
> -
> -static const int bma220_scale_table[][4] = {
> -	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000}
> +static const int bma220_scale_table[][2] = {
> +	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
>  };
>  
>  struct bma220_data {
> @@ -182,10 +170,28 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int bma220_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	struct bma220_data *data = iio_priv(indio_dev);
Not used.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)bma220_scale_table;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*length = ARRAY_SIZE(bma220_scale_table) * 2;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct iio_info bma220_info = {
>  	.read_raw		= bma220_read_raw,
>  	.write_raw		= bma220_write_raw,
> -	.attrs			= &bma220_attribute_group,
> +	.read_avail		= bma220_read_avail,
>  };
>  
>  static int bma220_init(struct spi_device *spi)

