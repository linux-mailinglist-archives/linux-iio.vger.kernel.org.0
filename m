Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F836115BD1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfLGKST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLGKST (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:18:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D030217BA;
        Sat,  7 Dec 2019 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575713898;
        bh=XCnQaeIuMoHrpbfaG5HFaQYHcBgU5OVXNIk5bCkD72k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1q3FgpsjA/3UaWMEEGbTT0Lq5Ln2/6eCrwbn3Bc5PrYCCatVTGqK0/Y/R3WXuAgKy
         6JukkPj9W1V3fRdef4sDsbQHLzwfST+bHTCjZAkm31RxvWdvv8HUckgfHOZ5oxf7dq
         vc10Y1e+XJD2DGgsw4J7t3pxfw9Km01Jj0RHCf6s=
Date:   Sat, 7 Dec 2019 10:18:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <fabrice.gasnier@st.com>,
        <biabeniamin@outlook.com>
Subject: Re: [PATCH] iio: adc: Move AD7091R5 entry in a alphabetical order
 in Makefile
Message-ID: <20191207101814.2c7aad79@archlinux>
In-Reply-To: <20191203101713.22888-1-beniamin.bia@analog.com>
References: <20191203101713.22888-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Dec 2019 12:17:13 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Ad7091R5 was added in a non alphabetical order after AD7124 in Makefile and
> KConfig. This patch fixes that and place Ad7091R5 before AD7124.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing to
make not difference (hopefully :)

Jonathan

> ---
>  drivers/iio/adc/Kconfig  | 14 +++++++-------
>  drivers/iio/adc/Makefile |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 976567d4dbef..27bb4e56eaea 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -21,6 +21,13 @@ config AD_SIGMA_DELTA
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  
> +config AD7091R5
> +	tristate "Analog Devices AD7091R5 ADC Driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for Analog Devices AD7091R-5 ADC.
> +
>  config AD7124
>  	tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
>  	depends on SPI_MASTER
> @@ -32,13 +39,6 @@ config AD7124
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7124.
>  
> -config AD7091R5
> -	tristate "Analog Devices AD7091R5 ADC Driver"
> -	depends on I2C
> -	select REGMAP_I2C
> -	help
> -	  Say yes here to build support for Analog Devices AD7091R-5 ADC.
> -
>  config AD7266
>  	tristate "Analog Devices AD7265/AD7266 ADC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 84936ec24411..bf8354cdbc34 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,8 +6,8 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
> -obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
> +obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7292) += ad7292.o

