Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B28C517CF2D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgCGPwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCGPwY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:52:24 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0157020674;
        Sat,  7 Mar 2020 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583596343;
        bh=Q5OgmfAuoQXNCqMtFrWXCGyZGPd5S7/Agtzu3prSlIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RdH06yS6QRnangGMOBtGsnbpXQfMYaoG4QRdhMXss9L3kcA3SwzjrIen7+y8/vZWJ
         UFWJCMp4qocFeItVJmffS0nWuqqNv2+9YTOuyD7jC0qB1fadfaqZqdeb6fRGe7Y6h4
         Mi9p2onjwof8LAuR4I70uy67xjjTRjnzT3IEN3zw=
Date:   Sat, 7 Mar 2020 15:52:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: light: gp2ap020a00f: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20200307155220.2e238b0c@archlinux>
In-Reply-To: <20200306111137.23572-1-alexandru.ardelean@analog.com>
References: <20200304082653.19374-1-alexandru.ardelean@analog.com>
        <20200306111137.23572-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 6 Mar 2020 13:11:37 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
> 
> For the predisable hook, the disable code should occur before detaching
> the poll func, and for the postenable hook, the poll func should be
> attached before the enable code.
> 
> This change moves the postenable/predisable hooks into the correct
> positions.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Seems unlikely anyone who knows this driver well will respond, so
applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it - maybe...

There is an odd warning I'm getting in here on x86 builds but it
has nothing to do with your patch so hopefully autobuilders won't
moan about.

thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * Fix omitted compiler warnings: 'warning: unused label 'error_unlock' [-Wunused-label]'
>   Reported-by: kbuild test robot <lkp@intel.com>
> 
>  drivers/iio/light/gp2ap020a00f.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 4d70c5bf35da..7fbbce0d4bc7 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1390,6 +1390,12 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  
>  	mutex_lock(&data->lock);
>  
> +	err = iio_triggered_buffer_postenable(indio_dev);
> +	if (err < 0) {
> +		mutex_unlock(&data->lock);
> +		return err;
> +	}
> +
>  	/*
>  	 * Enable triggers according to the scan_mask. Enabling either
>  	 * LIGHT_CLEAR or LIGHT_IR scan mode results in enabling ALS
> @@ -1420,14 +1426,12 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  		goto error_unlock;
>  
>  	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (!data->buffer) {
> +	if (!data->buffer)
>  		err = -ENOMEM;
> -		goto error_unlock;
> -	}
> -
> -	err = iio_triggered_buffer_postenable(indio_dev);
>  
>  error_unlock:
> +	if (err < 0)
> +		iio_triggered_buffer_predisable(indio_dev);
>  	mutex_unlock(&data->lock);
>  
>  	return err;
> @@ -1436,14 +1440,10 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> -	int i, err;
> +	int i, err = 0;
>  
>  	mutex_lock(&data->lock);
>  
> -	err = iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto error_unlock;
> -
>  	for_each_set_bit(i, indio_dev->active_scan_mask,
>  		indio_dev->masklength) {
>  		switch (i) {
> @@ -1465,7 +1465,8 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  	if (err == 0)
>  		kfree(data->buffer);
>  
> -error_unlock:
> +	iio_triggered_buffer_predisable(indio_dev);
> +
>  	mutex_unlock(&data->lock);
>  
>  	return err;

