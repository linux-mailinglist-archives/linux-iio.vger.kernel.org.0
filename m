Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5A1E973D
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgEaLT6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 07:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEaLT6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 07:19:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCA720707;
        Sun, 31 May 2020 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590923998;
        bh=wjrvK62QSKCLp8g0ecuqyfXMcIzVqut+DWa6xuhekds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VQc/pPqi+RRLhxqBPyVGmkupkU/9uUB8boq19qb3wfU6h1nj/Ry8IO6WUu7mQF94f
         QOXt2t0cT980Qfy6n6D6nMfUi6EYZIcCUSSg9cd7l2tD/alvffX3SeoyXg8ZeWzGy/
         LmeivD3RCbo9yAVhEW178uG2oDxm+MLBDVZFCUf4=
Date:   Sun, 31 May 2020 12:19:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: mma8452: Add missed iio_device_unregister()
 call in mma8452_probe()
Message-ID: <20200531121952.100b5e87@archlinux>
In-Reply-To: <20200528064121.547001-1-hslester96@gmail.com>
References: <20200528064121.547001-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 May 2020 14:41:21 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> The function iio_device_register() was called in mma8452_probe().
> But the function iio_device_unregister() was not called after
> a call of the function mma8452_set_freefall_mode() failed.
> Thus add the missed function call for one error case.
> 
> Fixes: 1a965d405fc6 ("drivers:iio:accel:mma8452: added cleanup provision in case of failure.")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied to the fixes-togreg branch of iio.git 
> ---
> Changes in v2:
>   - Add fixes tag.
>   - Modify description.
> 
>  drivers/iio/accel/mma8452.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 00e100fc845a..813bca7cfc3e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1685,10 +1685,13 @@ static int mma8452_probe(struct i2c_client *client,
>  
>  	ret = mma8452_set_freefall_mode(data, false);
>  	if (ret < 0)
> -		goto buffer_cleanup;
> +		goto unregister_device;
>  
>  	return 0;
>  
> +unregister_device:
> +	iio_device_unregister(indio_dev);
> +
>  buffer_cleanup:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  

