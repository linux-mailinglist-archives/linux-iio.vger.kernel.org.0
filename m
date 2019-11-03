Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600CCED2EE
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKCKq2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCKq2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:46:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE642084D;
        Sun,  3 Nov 2019 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572777987;
        bh=6EcJF2ludy24RFEi5IAldOHVVHiTtLQ71yaCaLw4elI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z5hXBU9FQee8a0Be/S6STnWr6WVeMVq+mJ83KxUyFqWBOoSiAgP+KNX9G9jfU+gcq
         5qQQB9ExlBmIp7bGRL82Br0uQ049q70rOLmALFHvCZZ4AZmqr03uwX4d4fhq5M1ZjT
         mg8gc5Y2zPl+IOGZHYekjP3dICkqNbSnIy2kj0iM=
Date:   Sun, 3 Nov 2019 10:46:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 09/10] iio: imu: adis: assign read val in debugfs hook
 only if op successful
Message-ID: <20191103104623.19fb5fec@archlinux>
In-Reply-To: <20191101093505.9408-10-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-10-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:35:04 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This was also caught by the `-Wmaybe-uninitialized` warning, which
> (ironically as-is) it makes quite a lot of sense to do for this.
> 
> Fixes: 78026a6fde8f7 ("iio:imu:adis: Add debugfs register access support")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
This one is protected against any actual results in the caller of the
function, so I've added a not again to say this is not stable material.

Need to do this explicitly to avoid it getting picked up in efforts
to catch fixes that should have been tagged.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index dc2f9e061d98..85de565a4e80 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -229,7 +229,8 @@ int adis_debugfs_reg_access(struct iio_dev *indio_dev,
>  		int ret;
>  
>  		ret = adis_read_reg_16(adis, reg, &val16);
> -		*readval = val16;
> +		if (ret == 0)
> +			*readval = val16;
>  
>  		return ret;
>  	} else {

