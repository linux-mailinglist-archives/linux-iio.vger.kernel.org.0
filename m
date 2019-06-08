Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E2939D4D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfFHLeh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfFHLeh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:34:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AC22146E;
        Sat,  8 Jun 2019 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559993677;
        bh=5o3WJ+PlDP4ACOl8NEp4Y7t3xVI0OyqdulVA5Cshjk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BqEPKE/NNqSsqN3rY2sMii1L6Z4fGDv4u6ybd1DlIY1fJK7gf95lAVRQMsxa6QUkD
         yMBZaRY8SDsWxHnKVoEej6gnM/K2l2BKy9FzXgH89I0r/dlK6652P9keGLw4bgE4Xe
         Tl0jef6D1lVt5u/9lXtVIpoh0qMVxQ5t4T8jgM9k=
Date:   Sat, 8 Jun 2019 12:34:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad7606: Add debug mode for ad7616
Message-ID: <20190608123431.14f8dd07@archlinux>
In-Reply-To: <20190527125650.2405-4-beniamin.bia@analog.com>
References: <20190527125650.2405-1-beniamin.bia@analog.com>
        <20190527125650.2405-4-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 May 2019 15:56:50 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Support for register access was added for spi devices.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied.

Thanks,

Jonathan

> ---
> Changes in v2:
> -nothing changed
> 
>  drivers/iio/adc/ad7606.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 8e09ad4bb72e..0eccfc873802 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -134,6 +134,30 @@ static int ad7606_spi_write_mask(struct ad7606_state *st,
>  	return ad7606_spi_reg_write(st, addr, readval);
>  }
>  
> +static int ad7606_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	if (readval) {
> +		ret = ad7606_spi_reg_read(st, reg);
> +		if (ret < 0)
> +			goto err_unlock;
> +		*readval = ret;
> +		ret = 0;
> +	} else {
> +		ret = ad7606_spi_reg_write(st, reg, writeval);
> +	}
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num = st->chip_info->num_channels;
> @@ -645,6 +669,7 @@ static const struct iio_info ad7606_info_no_os_or_range = {
>  static const struct iio_info ad7606_info_os_and_range = {
>  	.read_raw = &ad7606_read_raw,
>  	.write_raw = &ad7606_write_raw,
> +	.debugfs_reg_access = &ad7606_reg_access,
>  	.attrs = &ad7606_attribute_group_os_and_range,
>  	.validate_trigger = &ad7606_validate_trigger,
>  };

