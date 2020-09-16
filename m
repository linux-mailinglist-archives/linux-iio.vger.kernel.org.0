Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA1926C701
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgIPSOs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgIPSOc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 14:14:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1937221582;
        Wed, 16 Sep 2020 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600280071;
        bh=e6tjX3AZSUdyzKyerPV7zrM6nT1CqJ4Mtu7Z0dRX+JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mnsqJITC7J5lkVg2jQuYfXtBMqzGq4e/pMKLAvBiHUykik/CKs69vGRbN7yQroOMt
         MRNfRXyBV2PAPI+aglnSV/0XoSCpRCaEGJsUbwaXrY7o/IzCsSrbQZ0AcedAutp6Yp
         oDp5n6465k9m6oYzwkqxgtipLH5CnAiXN1VSkXls=
Date:   Wed, 16 Sep 2020 19:14:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad9467: refine mismatch vs unknown chip-id
 messages
Message-ID: <20200916191429.38fdc488@archlinux>
In-Reply-To: <20200916083128.73729-1-alexandru.ardelean@analog.com>
References: <20200916083128.73729-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 11:31:28 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> We should probably print what the expected chip-ID is. We already have
> that information available, based on the device specified via
> device-tree.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
applied.

thanks,

Jonathan

> ---
>  drivers/iio/adc/ad9467.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 8a6682b567be..f068256cfca9 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -390,7 +390,8 @@ static int ad9467_probe(struct spi_device *spi)
>  
>  	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
>  	if (id != conv->chip_info->id) {
> -		dev_err(&spi->dev, "Unrecognized CHIP_ID 0x%X\n", id);
> +		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
> +			id, conv->chip_info->id);
>  		return -ENODEV;
>  	}
>  

