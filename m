Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C163515D9B4
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgBNOsA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbgBNOsA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:48:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 008D5222C2;
        Fri, 14 Feb 2020 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581691680;
        bh=Anl7Lg/k4Apl3KJ8JFDdjtGaJ8emtEZYytqz4kydcDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=alREsvtTeRgdsXC/qS8aUDcffI+XaygKd/dUn0zQlZuk/y564Rz0aRquMH6W36Gl0
         2OU3+b7fnRa6Oru8kHg7JvW+/yD9UtReRZMAODAXR0Jmu1NWZoGVB3tup81V2S00Zd
         WhgtCMmVKSb7aTPonxbmno1Uo0+3jp4IvugvtfDo=
Date:   Fri, 14 Feb 2020 14:47:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V4] iio: adc: ad7124: Add direct reg access
Message-ID: <20200214144755.617e1aba@archlinux>
In-Reply-To: <20200211084453.16866-1-mircea.caprioru@analog.com>
References: <20200211084453.16866-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 10:44:53 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch adds the posibility do read and write registers from userspace
> using the kernel debug direct register access option.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changelog V4:
> - verify limit againg ARRAY_SIZE(ad7124_reg_size)
> 
>  drivers/iio/adc/ad7124.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index f0206d819fda..a3c0647a5391 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -98,6 +98,14 @@ static const unsigned int ad7124_gain[8] = {
>  	1, 2, 4, 8, 16, 32, 64, 128
>  };
>  
> +static const unsigned int ad7124_reg_size[] = {
> +	1, 2, 3, 3, 2, 1, 3, 3, 1, 2, 2, 2, 2,
> +	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
> +	2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3,
> +	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
> +	3, 3, 3, 3, 3
> +};
> +
>  static const int ad7124_master_clk_freq_hz[3] = {
>  	[AD7124_LOW_POWER] = 76800,
>  	[AD7124_MID_POWER] = 153600,
> @@ -427,6 +435,27 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ad7124_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7124_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (reg >= ARRAY_SIZE(ad7124_reg_size))
> +		return -EINVAL;
> +
> +	if (readval)
> +		ret = ad_sd_read_reg(&st->sd, reg, ad7124_reg_size[reg],
> +				     readval);
> +	else
> +		ret = ad_sd_write_reg(&st->sd, reg, ad7124_reg_size[reg],
> +				      writeval);
> +
> +	return ret;
> +}
> +
>  static IIO_CONST_ATTR(in_voltage_scale_available,
>  	"0.000001164 0.000002328 0.000004656 0.000009313 0.000018626 0.000037252 0.000074505 0.000149011 0.000298023");
>  
> @@ -442,6 +471,7 @@ static const struct attribute_group ad7124_attrs_group = {
>  static const struct iio_info ad7124_info = {
>  	.read_raw = ad7124_read_raw,
>  	.write_raw = ad7124_write_raw,
> +	.debugfs_reg_access = &ad7124_reg_access,
>  	.validate_trigger = ad_sd_validate_trigger,
>  	.attrs = &ad7124_attrs_group,
>  };

