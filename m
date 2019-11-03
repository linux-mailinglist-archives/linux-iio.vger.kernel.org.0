Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727B0ED2F2
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfKCKt7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCKt7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:49:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39AEF2084D;
        Sun,  3 Nov 2019 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572778198;
        bh=ne/vHOE3Urg25Rv7TiV6GHwnQ1v7+5j+IHPyOIHr81E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ii63cUivDRAooYv8gyFF45y899rLgQFq2bMHNalmT51C5vIZ7jUKvdYvLMqRqZZbq
         VyUQjdNzEkN+6PaUaccuk3fYpudIzEcgpztEQmqjCHPGpD/2B87n6hr7vwdyxFKZQD
         9LcUQ1iX7nltUNrpa6riVijZF3EemDVW9Y71em7o=
Date:   Sun, 3 Nov 2019 10:49:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 10/10] iio: imu: adis: assign value only if return code
 zero in read funcs
Message-ID: <20191103104954.445e1e21@archlinux>
In-Reply-To: <20191101093505.9408-11-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-11-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:35:05 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The inline read functions in the ADIS library don't check the return value
> of the `adis_read_reg()` function and assign the value of `tmp` regardless.
> 
> Fix this by checking if return value is zero and only then assigning the
> value of `tmp`.
> 
> Fixes: 57a1228a06b7a ("iio:imu:adis: Add support for 32bit registers")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Again, I added a note to say I don't think this is stable material.
As far as I know we don't have any actual bugs caused by this as we always
check the return value further up the stack.

Let me know if I've missed something.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  include/linux/iio/imu/adis.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 4c53815bb729..92aae14593bf 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -129,7 +129,8 @@ static inline int adis_read_reg_16(struct adis *adis, unsigned int reg,
>  	int ret;
>  
>  	ret = adis_read_reg(adis, reg, &tmp, 2);
> -	*val = tmp;
> +	if (ret == 0)
> +		*val = tmp;
>  
>  	return ret;
>  }
> @@ -147,7 +148,8 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
>  	int ret;
>  
>  	ret = adis_read_reg(adis, reg, &tmp, 4);
> -	*val = tmp;
> +	if (ret == 0)
> +		*val = tmp;
>  
>  	return ret;
>  }

