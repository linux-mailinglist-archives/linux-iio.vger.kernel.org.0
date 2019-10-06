Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4895CCFE3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJFJUG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFJUF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:20:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E9F206C2;
        Sun,  6 Oct 2019 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353605;
        bh=ZojxG3+c8vG1+5/cHSJ+/Oc0G00t4JuXttf7aa2h+C8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rDTU6vXXUkyEBDs1wnX9ISnQwOJcQ9h9imDp38FX0aGmnc06aozccyVmrM6UOEJwB
         Bg2op460lhz3BYqAIKkGoAfwwSrqdoXmww7IFDpp79zKXscQxyZVJK/EJDGx/8o4Xh
         T8rw5hNgwBVMO28CtyWhjbZRn26Nnp7dBvjK3PZA=
Date:   Sun, 6 Oct 2019 10:20:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] iio: imu: adis: protect initial startup routine
 with state lock
Message-ID: <20191006102001.10e6d9b2@archlinux>
In-Reply-To: <20190926111812.15957-7-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:18:08 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The initial startup routine is called by some ADIS drivers during probe,
> and before registering with IIO. Normally, userspace should not be able to
> do any access to the device (as there shouldn't be any available).
> 
> This change extends the state lock to the entire initial-startup routine.
> Behaviourally nothing should change, but this should make the library
> function a bit more robust.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

> ---
>  drivers/iio/imu/adis.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index b14101bf34b9..7468294d1776 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -331,7 +331,7 @@ static int adis_self_test(struct adis *adis)
>  {
>  	int ret;
>  
> -	ret = adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
> +	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg,
>  			adis->data->self_test_mask);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Failed to initiate self test: %d\n",
> @@ -341,10 +341,10 @@ static int adis_self_test(struct adis *adis)
>  
>  	msleep(adis->data->startup_delay);
>  
> -	ret = adis_check_status(adis);
> +	ret = __adis_check_status(adis);
>  
>  	if (adis->data->self_test_no_autoclear)
> -		adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
> +		__adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
>  
>  	return ret;
>  }
> @@ -362,19 +362,23 @@ int adis_initial_startup(struct adis *adis)
>  {
>  	int ret;
>  
> +	mutex_lock(&adis->state_lock);
> +
>  	ret = adis_self_test(adis);
>  	if (ret) {
>  		dev_err(&adis->spi->dev, "Self-test failed, trying reset.\n");
> -		adis_reset(adis);
> +		__adis_reset(adis);
>  		msleep(adis->data->startup_delay);
>  		ret = adis_self_test(adis);
>  		if (ret) {
>  			dev_err(&adis->spi->dev, "Second self-test failed, giving up.\n");
> -			return ret;
> +			goto out_unlock;
>  		}
>  	}
>  
> -	return 0;
> +out_unlock:
> +	mutex_unlock(&adis->state_lock);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(adis_initial_startup);
>  

