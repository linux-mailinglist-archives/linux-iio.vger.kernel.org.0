Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E25ED2DA
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfKCKbP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCKbO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:31:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13992080F;
        Sun,  3 Nov 2019 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572777074;
        bh=20l8v/y2V3ek5NI+W8ID8qa7S1TqL/BeyjegTojxYIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MZX2QdfeJVHnNlbg1uGWwQTvF3A2/JmXrlYm6bNiiXpJxecg9O+lUkLqJIJaeAE4d
         wr7MeS0gQLvVS4XG1LqtIGBJlcMKDRqxn9MTdrqveO0TOzrKWVmKegNoaOCxD3aaRF
         7ThQWgAXtTZLt0fwygqYNrrNXEtaMpI4MasF6XV4=
Date:   Sun, 3 Nov 2019 10:31:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 05/10] iio: imu: adis: check ret val for non-zero vs
 less-than-zero
Message-ID: <20191103103109.37849bc2@archlinux>
In-Reply-To: <20191101093505.9408-6-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:35:00 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS library functions return zero on success, and negative values for
> error. Positive values aren't returned, but we only care about the success
> value (which is zero).
> 
> This change is mostly needed so that the compiler won't make any inferences
> about some about values being potentially un-initialized. This only
> triggers after making some functions inline, because the compiler can
> better follow return paths.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 1631c255deab..dc2f9e061d98 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -286,7 +286,7 @@ int adis_check_status(struct adis *adis)
>  	int i;
>  
>  	ret = adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	status &= adis->data->status_error_mask;

