Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960DF185C87
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 14:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgCONId (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 09:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgCONId (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 09:08:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1C620575;
        Sun, 15 Mar 2020 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584277713;
        bh=Ap2wlUnkhdDAcTZTZWw0CLc18JpccKznpp2WPyUlBD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N0C6SS6wwy0QDss3y4YxkqDM1h29WWwC2Ba0HJ27A1khF36uPzWf2hh60QrKjsQTA
         wxg0k9vKu+HrXhb4JIwQzBLOm0iioi6dRpRN9bBYEKsurzxD6CRLn3LjdPJq9jaSrC
         UNIjOgYu4ztfRsQbmZHDa723bc+waNsNwvFtAFWY=
Date:   Sun, 15 Mar 2020 13:08:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1] iio: adc: intel_mrfld_adc: Use be16_to_cpu() instead
 of get_unaligned_be16()
Message-ID: <20200315130829.45790821@archlinux>
In-Reply-To: <20200311092223.9673-1-andriy.shevchenko@linux.intel.com>
References: <20200311092223.9673-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Mar 2020 11:22:23 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There is no need to call unaligned helpers on stack placed variables
> because compiler will align them correctly, accordingly to architectural
> ABI. Moreover, using bitwise type makes it explicit to see what we are
> reading in bulk transfer. On top of that, use sizeof() instead of
> magic value.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/intel_mrfld_adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
> index c35a1beb817c..a6d2e1f27e76 100644
> --- a/drivers/iio/adc/intel_mrfld_adc.c
> +++ b/drivers/iio/adc/intel_mrfld_adc.c
> @@ -75,7 +75,7 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
>  	struct regmap *regmap = adc->regmap;
>  	unsigned int req;
>  	long timeout;
> -	u8 buf[2];
> +	__be16 value;
>  	int ret;
>  
>  	reinit_completion(&adc->completion);
> @@ -105,11 +105,11 @@ static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
>  		goto done;
>  	}
>  
> -	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
> +	ret = regmap_bulk_read(regmap, chan->address, &value, sizeof(value));
>  	if (ret)
>  		goto done;
>  
> -	*result = get_unaligned_be16(buf);
> +	*result = be16_to_cpu(value);
>  	ret = IIO_VAL_INT;
>  
>  done:

