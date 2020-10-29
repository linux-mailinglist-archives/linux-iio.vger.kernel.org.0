Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3213E29EFB5
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 16:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgJ2PZ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 11:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgJ2PZy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 11:25:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BE92087E;
        Thu, 29 Oct 2020 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603985150;
        bh=md/5mtqaLq4poF+cAam22zEdu3VEziPtNNrcvka9+Hw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vgnqYdYULcpSZMBCz39KartBFuGOrCazQ2C5KFusCZi0E6T6v9amOfe2Km+nhIClY
         TG/ftx/kufVyme5XotS3aVbbrG2NJlH4rKwGAiAeaiiPVfVpgFe7vCeCLu26ZtdaAg
         l/tdDYHHen0Ptsp38RaprFyYsGgM7zw/tyvMlaiM=
Date:   Thu, 29 Oct 2020 15:25:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v1] iio: pressure: dps310: Use get_unaligned_beXX()
Message-ID: <20201029152545.18eecc9a@archlinux>
In-Reply-To: <20201026180515.19680-1-andriy.shevchenko@linux.intel.com>
References: <20201026180515.19680-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Oct 2020 20:05:15 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Cc: Eddie James <eajames@linux.ibm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi Andy,

I am a bit in 2 minds about this one.

I'm not 100% sure on the register arrangement here, but it 'looks' like
a be64 followed by some smaller registers.  
It isn't documented like that in the datasheet though, so representing
it as such might confuse people...

So, we 'could' use a structure with a __be64 and some __be16s then all
would be aligned, but it would be hard to align with the datasheet.

Unfortunately what you have here is also rather hard to align with
the datasheet...

Jonathan


> ---
>  drivers/iio/pressure/dps310.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 0730380ceb69..6a21cb5d3d37 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -127,7 +127,7 @@ static int dps310_get_coefs(struct dps310_data *data)
>  	c0 = (coef[0] << 4) | (coef[1] >> 4);
>  	data->c0 = sign_extend32(c0, 11);
>  
> -	c1 = ((coef[1] & GENMASK(3, 0)) << 8) | coef[2];
> +	c1 = get_unaligned_be16(&coef[1]) & GENMASK(11, 0);
>  	data->c1 = sign_extend32(c1, 11);
>  
>  	/*
> @@ -138,22 +138,22 @@ static int dps310_get_coefs(struct dps310_data *data)
>  	c00 = (coef[3] << 12) | (coef[4] << 4) | (coef[5] >> 4);
>  	data->c00 = sign_extend32(c00, 19);
>  
> -	c10 = ((coef[5] & GENMASK(3, 0)) << 16) | (coef[6] << 8) | coef[7];
> +	c10 = get_unaligned_be24(&coef[5]) & GENMASK(19, 0);
>  	data->c10 = sign_extend32(c10, 19);
>  
> -	c01 = (coef[8] << 8) | coef[9];
> +	c01 = get_unaligned_be16(&coef[8]);
>  	data->c01 = sign_extend32(c01, 15);
>  
> -	c11 = (coef[10] << 8) | coef[11];
> +	c11 = get_unaligned_be16(&coef[10]);
>  	data->c11 = sign_extend32(c11, 15);
>  
> -	c20 = (coef[12] << 8) | coef[13];
> +	c20 = get_unaligned_be16(&coef[12]);
>  	data->c20 = sign_extend32(c20, 15);
>  
> -	c21 = (coef[14] << 8) | coef[15];
> +	c21 = get_unaligned_be16(&coef[14]);
>  	data->c21 = sign_extend32(c21, 15);
>  
> -	c30 = (coef[16] << 8) | coef[17];
> +	c30 = get_unaligned_be16(&coef[16]);
>  	data->c30 = sign_extend32(c30, 15);
>  
>  	return 0;
> @@ -323,7 +323,7 @@ static int dps310_read_pres_raw(struct dps310_data *data)
>  	if (rc < 0)
>  		goto done;
>  
> -	raw = (val[0] << 16) | (val[1] << 8) | val[2];
> +	raw = get_unaligned_be24(&val[0]);
>  	data->pressure_raw = sign_extend32(raw, 23);
>  
>  done:
> @@ -342,7 +342,7 @@ static int dps310_read_temp_ready(struct dps310_data *data)
>  	if (rc < 0)
>  		return rc;
>  
> -	raw = (val[0] << 16) | (val[1] << 8) | val[2];
> +	raw = get_unaligned_be24(&val[0]);
>  	data->temp_raw = sign_extend32(raw, 23);
>  
>  	return 0;

