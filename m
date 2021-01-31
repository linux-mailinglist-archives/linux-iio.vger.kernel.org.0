Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2486309C41
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 14:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhAaM7q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 07:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231575AbhAaLuF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 06:50:05 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDB264E10;
        Sun, 31 Jan 2021 11:48:46 +0000 (UTC)
Date:   Sun, 31 Jan 2021 11:48:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio:adc:ti-ads124s08: Fix start stop conversion
 command
Message-ID: <20210131114841.720ce829@archlinux>
In-Reply-To: <20210121191431.12057-1-dmurphy@ti.com>
References: <20210121191431.12057-1-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 13:14:30 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Fix start and stop conversion commands.  The proper command is not be
> sent.
> 
> Fixes: ("e717f8c6dfec iio: adc: Add the TI ads124s08 ADC code")

That's not the right format for a fixes, tag. I fixed it whilst applying.

> Signed-off-by: Dan Murphy <dmurphy@ti.com>

I've not applied this because there is another START_CONV in the
driver and I'm not sure that one is right either. It looks to be
a very similar code path to the one you are fixing here.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads124s08.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index b4a128b19188..f05d4e0e1c9d 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -237,7 +237,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  
> -		ret = ads124s_write_cmd(indio_dev, ADS124S08_START_CONV);
> +		ret = ads124s_write_cmd(indio_dev, ADS124S08_CMD_START);
>  		if (ret) {
>  			dev_err(&priv->spi->dev, "Start conversions failed\n");
>  			goto out;
> @@ -251,7 +251,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
>  
>  		*val = ret;
>  
> -		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
> +		ret = ads124s_write_cmd(indio_dev, ADS124S08_CMD_STOP);
>  		if (ret) {
>  			dev_err(&priv->spi->dev, "Stop conversions failed\n");
>  			goto out;

