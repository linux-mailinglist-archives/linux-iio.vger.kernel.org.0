Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52584107E5F
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfKWMcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:58778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfKWMcK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 07:32:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB61D20714;
        Sat, 23 Nov 2019 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574512329;
        bh=YlL3g8Dgqv3XFojHHqMEsB5RJIOSLEyvm2/rRa3OW6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wViwsUjTMnvA481Mb9IaQOZOujRMQSwExD7G8EegpJ0uxQ5fbze1DSIn3t7veDpwu
         JIrV+6J94DbsLrZN1O0Rt0ctPIj8e3ujGcSFfNmLRhPFmCN4Dt7y9d7n4hHcSJGvh6
         v50RIEz9hzH5Y/PHEYwMJuPztjGeO1edbdZl+nrc=
Date:   Sat, 23 Nov 2019 12:32:04 +0000
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
Subject: Re: [v3 3/9] iio: max31856: add support for configuring the HW
 averaging
Message-ID: <20191123123204.49fe367b@archlinux>
In-Reply-To: <20191120144756.28424-4-andrea.merello@gmail.com>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-4-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Nov 2019 15:47:50 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> This sensor can perform samples averaging in hardware, but currently the
> driver leaves this setting alone (default is no averaging).
> 
> This patch binds this HW setting to the "oversampling_ratio" IIO attribute
> and allows the user to set the averaging as desired (the HW supports
> averaging of 2, 5, 8 or 16 samples; in-between values are rounded up).
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
Applied. Thanks,

Jonathan

> ---
>  drivers/iio/temperature/max31856.c | 43 ++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index d97ba9ee1598..8457ca9ae326 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -12,6 +12,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/util_macros.h>
>  #include <dt-bindings/iio/temperature/thermocouple.h>
>  /*
>   * The MSB of the register value determines whether the following byte will
> @@ -24,6 +25,8 @@
>  #define MAX31856_CR0_OCFAULT       BIT(4)
>  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
>  #define MAX31856_CR0_FILTER_50HZ   BIT(0)
> +#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
> +#define MAX31856_AVERAGING_SHIFT   4
>  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
>  #define MAX31856_FAULT_OVUV        BIT(1)
>  #define MAX31856_FAULT_OPEN        BIT(0)
> @@ -51,6 +54,8 @@ static const struct iio_chan_spec max31856_channels[] = {
>  		.type = IIO_TEMP,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
>  	},
>  	{	/* Cold Junction Temperature */
>  		.type = IIO_TEMP,
> @@ -58,6 +63,8 @@ static const struct iio_chan_spec max31856_channels[] = {
>  		.modified = 1,
>  		.info_mask_separate =
>  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
>  	},
>  };
>  
> @@ -65,6 +72,7 @@ struct max31856_data {
>  	struct spi_device *spi;
>  	u32 thermocouple_type;
>  	bool filter_50hz;
> +	int averaging;
>  };
>  
>  static int max31856_read(struct max31856_data *data, u8 reg,
> @@ -109,6 +117,10 @@ static int max31856_init(struct max31856_data *data)
>  
>  	reg_cr1_val &= ~MAX31856_TC_TYPE_MASK;
>  	reg_cr1_val |= data->thermocouple_type;
> +
> +	reg_cr1_val &= ~MAX31856_AVERAGING_MASK;
> +	reg_cr1_val |= data->averaging << MAX31856_AVERAGING_SHIFT;
> +
>  	ret = max31856_write(data, MAX31856_CR1_REG, reg_cr1_val);
>  	if (ret)
>  		return ret;
> @@ -217,6 +229,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = 1 << data->averaging;
> +		return IIO_VAL_INT;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -225,6 +240,33 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int max31856_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct max31856_data *data = iio_priv(indio_dev);
> +	int msb;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val > 16 || val < 1)
> +			return -EINVAL;
> +		msb = fls(val) - 1;
> +		/* Round up to next 2pow if needed */
> +		if (BIT(msb) < val)
> +			msb++;
> +
> +		data->averaging = msb;
> +		max31856_init(data);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static ssize_t show_fault(struct device *dev, u8 faultbit, char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -313,6 +355,7 @@ static const struct attribute_group max31856_group = {
>  
>  static const struct iio_info max31856_info = {
>  	.read_raw = max31856_read_raw,
> +	.write_raw = max31856_write_raw,
>  	.attrs = &max31856_group,
>  };
>  

