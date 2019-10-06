Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA44DCCF41
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 09:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfJFHzv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 03:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFHzv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 03:55:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7CB20867;
        Sun,  6 Oct 2019 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570348550;
        bh=cTgYkYNvEZUYhQCHpW90nyT6f6A7TtppG794I28rVTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iEKJ+J1ZgM2slbrLYGR/XpKcffRRCaVg/tc3k8FA8k0vE1CRYhhO4sPxRJRYi7s1P
         VluT2TbuWcb4ec+bBPr8/ZVsYQpbvJQBmfGwoE1P2LlIe4RVDi2zJoOK7gBSM8hXjt
         KXZ2ozaNJvYiBSssUj/soQplrBzWHuicQvGTIs8c=
Date:   Sun, 6 Oct 2019 08:55:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     patrick.havelange@essensium.com,
        paresh.chaudhary@rockwellcollins.com, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de,
        matthew.weber@rockwellcollins.com, colin.king@canonical.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: max31856: add support for configuring the HW
 averaging
Message-ID: <20191006085545.2df79667@archlinux>
In-Reply-To: <20190923121714.13672-3-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
        <20190923121714.13672-3-andrea.merello@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Sep 2019 14:17:13 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This sensor can perform samples averaging in hardware, but currently the
> driver leaves this setting alone (default is no averaging).
> 
> This patch introduces a new IIO attribute that allows the user to set the
> averaging as desired (the HW supports averaging of 2, 5, 8 or 16 samples)
> 
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>

Sounds like oversampling combined with a lower sampling frequency, so
there is standard ABI for that.

Jonathan

> ---
>  drivers/iio/temperature/max31856.c | 43 ++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index d12613f7ba3c..8b2e0102fa5c 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -24,6 +24,8 @@
>  #define MAX31856_CR0_OCFAULT       BIT(4)
>  #define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
>  #define MAX31856_CR0_FILTER_50HZ   BIT(0)
> +#define MAX31856_AVERAGING_MASK    GENMASK(6, 4)
> +#define MAX31856_AVERAGING_SHIFT   4
>  #define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
>  #define MAX31856_FAULT_OVUV        BIT(1)
>  #define MAX31856_FAULT_OPEN        BIT(0)
> @@ -65,6 +67,7 @@ struct max31856_data {
>  	struct spi_device *spi;
>  	u32 thermocouple_type;
>  	bool filter_50hz;
> +	int averaging;
>  };
>  
>  static int max31856_read(struct max31856_data *data, u8 reg,
> @@ -109,6 +112,10 @@ static int max31856_init(struct max31856_data *data)
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
> @@ -295,14 +302,50 @@ static ssize_t set_filter(struct device *dev,
>  	return len;
>  }
>  
> +static ssize_t show_averaging(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", 1 << data->averaging);
> +}
> +
> +static ssize_t set_averaging(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf,
> +			     size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct max31856_data *data = iio_priv(indio_dev);
> +	unsigned int nsamples;
> +	int shift;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &nsamples);
> +	if (ret)
> +		return ret;
> +
> +	shift = fls(nsamples) - 1;
> +	if (nsamples > 16 || BIT(shift) != nsamples)
> +		return -EINVAL;
> +
> +	data->averaging = shift;
> +	max31856_init(data);
> +	return len;
> +}
> +
>  static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
>  static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
>  static IIO_DEVICE_ATTR(filter, 0644, show_filter, set_filter, 0);
> +static IIO_DEVICE_ATTR(averaging, 0644, show_averaging, set_averaging, 0);
>  
>  static struct attribute *max31856_attributes[] = {
>  	&iio_dev_attr_fault_ovuv.dev_attr.attr,
>  	&iio_dev_attr_fault_oc.dev_attr.attr,
>  	&iio_dev_attr_filter.dev_attr.attr,
> +	&iio_dev_attr_averaging.dev_attr.attr,
>  	NULL,
>  };
>  

