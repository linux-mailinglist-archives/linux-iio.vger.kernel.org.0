Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9E0E1A5E52
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDLLic (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgDLLic (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:38:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E3E6206DA;
        Sun, 12 Apr 2020 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586691512;
        bh=tVCDDWtcQtbB1lZLEaiB5lN7ts0DMoNVhW0b7Etn49U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hovffOIazgnz86myi3OtY2VthDf3RPBMjUSv47fblnM/6fM0ymYsUSFC7ltm4uc6T
         LbitMgWSkBo6M01oZUGnPFmfA9hXPPGTMTHUFGweJ5dWXgVvKwCZ1tIScAvXxOUpSr
         DthzgxRDTcaJbtSrHpUfEaVIbNnArERZpTAQaOtQ=
Date:   Sun, 12 Apr 2020 12:38:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexandru.tachici@analog.com>
Subject: Re: [PATCH v2] iio: adc: ad7192: fix null pointer de-reference
 crash during probe
Message-ID: <20200412123828.6fa25008@archlinux>
In-Reply-To: <20200407063310.85466-1-alexandru.ardelean@analog.com>
References: <20200406123109.56947-1-alexandru.ardelean@analog.com>
        <20200407063310.85466-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Apr 2020 09:33:10 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> When the 'spi_device_id' table was removed, it omitted to cleanup/fix the
> assignment:
>   'indio_dev->name = spi_get_device_id(spi)->name;'
> 
> After that patch 'spi_get_device_id(spi)' returns NULL, so this crashes
> during probe with null de-ref.
> 
> This change assigns the 'compatible' string from the DT table, as the new
> 'indio_dev->name'. As such, the new device/part name now looks like
> 'adi,ad719x', and now has the vendor prefix.
> 
> Note that this change is not doing any NULL check to the return value of
> 'of_match_device()'. This shouldn't happen, and if it does it's likely a
> framework error on the probe side.
> 
> Fixes: 66614ab2be38 ("staging: iio: adc: ad7192: removed spi_device_id")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hmm. Returning the compatible isn't compatible with the ABI.

I think we will have to introduce a bit of indirection here to
allow for a 'chip info' type structure with the name and the magic ID value
that is currently in the data field of the of_device_id table.

That way we can have the name explicit.   Note I don't want to
mess around with stripping the prefix off the compatible as that sort of
thing is hard to read.

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * fix colon for Fixes tag
> * updated commit title a bit; to make it longer
> 
>  drivers/iio/adc/ad7192.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 8ec28aa8fa8a..0039a45e1f33 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -888,6 +888,7 @@ MODULE_DEVICE_TABLE(of, ad7192_of_match);
>  
>  static int ad7192_probe(struct spi_device *spi)
>  {
> +	const struct of_device_id *of_id;
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
>  	int ret, voltage_uv = 0;
> @@ -937,10 +938,12 @@ static int ad7192_probe(struct spi_device *spi)
>  		goto error_disable_avdd;
>  	}
>  
> +	of_id = of_match_device(ad7192_of_match, &spi->dev);
> +
>  	spi_set_drvdata(spi, indio_dev);
> -	st->devid = (unsigned long)of_device_get_match_data(&spi->dev);
> +	st->devid = (unsigned long)of_id->data;
>  	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->name = of_id->compatible;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = ad7192_channels_config(indio_dev);

