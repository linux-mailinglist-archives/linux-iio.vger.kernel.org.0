Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93024E6EE
	for <lists+linux-iio@lfdr.de>; Sat, 22 Aug 2020 12:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHVKkr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Aug 2020 06:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHVKkr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Aug 2020 06:40:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2408206BE;
        Sat, 22 Aug 2020 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598092846;
        bh=cEGdT8XAvc9Giu0jlhAu2qtpm1zG83Ohouivsv6T9bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=epuCfRXIEATNcPOoOjtwWgFLWUB00N88Km1/PhnQpIKAjAsVqGOjb8SZXn6KvNsMb
         kLfxL5VxQYDwJRoeOVz1/g9vUzxC2k9IDgJHfNJ1ltZHzjBtkwFE5v4xxCY3nDhXRl
         rMjSqXVIF/FTAWHZBFwftKoYhOXfHJMEuoMDHIkc=
Date:   Sat, 22 Aug 2020 11:40:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, knaack.h@gmx.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.9] iio: adc: meson-saradc: Use the parent device
 to look up the calib data
Message-ID: <20200822114036.49199bff@archlinux>
In-Reply-To: <20200815181355.407034-1-martin.blumenstingl@googlemail.com>
References: <20200815181355.407034-1-martin.blumenstingl@googlemail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 15 Aug 2020 20:13:55 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On the older-gen 32-bit SoCs the meson-saradc driver is used to read the
> SoC temperature. This requires reading calibration data from the eFuse.
> 
> Looking up the calibration data nvmem-cell requires the OF device_node
> pointer to be available in the struct device which is passed to
> devm_nvmem_cell_get(). This however got lost with commit 8cb631ccbb1952
> ("iio: Remove superfluous of_node assignments") from indio_dev->dev. As
> devm_nvmem_cell_get() is called in the initialization phase the
> device_node is not yet available because the NVMEM cell is looked up
> before iio_device_register() is called (which would then set the
> device_node automatically).
> Use the parent device to look up the NVMEM cell instead to fix this
> issue.
> 
> Fixes: 8cb631ccbb1952 ("iio: Remove superfluous of_node assignments")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Gah.  I hope we don't have too many more non obvious cases like
this hiding.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 93c2252c0b89..1a9189ba69ae 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -707,7 +707,7 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
>  	size_t read_len;
>  	int ret;
>  
> -	temperature_calib = devm_nvmem_cell_get(&indio_dev->dev,
> +	temperature_calib = devm_nvmem_cell_get(indio_dev->dev.parent,
>  						"temperature_calib");
>  	if (IS_ERR(temperature_calib)) {
>  		ret = PTR_ERR(temperature_calib);

