Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3953E1F07AE
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 17:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgFFPqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 11:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgFFPqf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 11:46:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BB0D2063A;
        Sat,  6 Jun 2020 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591458395;
        bh=7y8urbgDLDMRgmjtop+7mf/WwBfxEw4g79Vo2LnnViU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VzLdAq2+MBpVLc+XslFS7EN6z4tjRHVlmd/36ktECnruJKRWCLBd0WSKMUF6MrInK
         ZE2c6SucoP/Q0dzIKmaDE/T7ae63nrXsZUZtu829s0iU7+eGbD5p8x5MBO4mCSnqE/
         8Vw/+1j0pEQ+Bqgzl3AgD3mUsA90ry63BNxjlYqc=
Date:   Sat, 6 Jun 2020 16:46:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: lm3533-als: use
 iio_device_set_parent() to assign parent
Message-ID: <20200606164631.25cd78a6@archlinux>
In-Reply-To: <20200603114023.175102-6-alexandru.ardelean@analog.com>
References: <20200603114023.175102-1-alexandru.ardelean@analog.com>
        <20200603114023.175102-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jun 2020 14:40:22 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This assignment is the more peculiar as it assigns the parent of the
> platform-device's device (i.e. pdev->dev.parent) as the IIO device's
> parent.
> 
> Since the devm_iio_device_alloc() [now] assigns the device argument as the
> default parent (and since this is the more common case), for cases
> where the parent needs to be different, the iio_device_set_parent helper
> should be used.
> 
> That makes things a bit more obvious about the new behavior of
> devm_iio_device_alloc() and makes it clearer that iio_device_set_parent()
> should be used.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/light/lm3533-als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index bc196c212881..8a621244dd01 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -852,7 +852,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  	indio_dev->channels = lm3533_als_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
>  	indio_dev->name = dev_name(&pdev->dev);
> -	indio_dev->dev.parent = pdev->dev.parent;
> +	iio_device_set_parent(indio_dev, pdev->dev.parent);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	als = iio_priv(indio_dev);

