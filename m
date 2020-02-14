Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18C15D93D
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgBNORU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:17:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387441AbgBNORU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:17:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AECFF206B6;
        Fri, 14 Feb 2020 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581689839;
        bh=DKnOQbBScN3rAJPl6gMM+HfAt8FsN2y5ESMTV2xNhRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NkLfFdxkI4mgvTRJ8QUSd+OfrijkEFDCfTaeek7w6FkQIuDNl8aFafvGa+6TRQIAF
         XoxY8bgqfgYXwPO7zuZgjjuPtP/qdIDzP0unmxteYauzp/2stJYW+VDaSqOUPHQtrk
         RpjVj75XdCQ6GEl97mx9ksd/c3XL2jjZ8Ylxm4s0=
Date:   Fri, 14 Feb 2020 14:17:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: check return value from
 st_lsm6dsx_sensor_set_enable
Message-ID: <20200214141715.73ec5f52@archlinux>
In-Reply-To: <f0f53dbfdb2c638f8ebb3deca4576886625fa6e8.1581078931.git.lorenzo@kernel.org>
References: <f0f53dbfdb2c638f8ebb3deca4576886625fa6e8.1581078931.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  7 Feb 2020 13:37:54 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add missing return value check in st_lsm6dsx_shub_read_oneshot disabling
> the slave device connected to the st_lsm6dsx i2c controller.
> The issue is reported by coverity with the following error:
> 
> Unchecked return value:
> If the function returns an error value, the error value may be mistaken
> for a normal value.
> 
> Addresses-Coverity-ID: 1456767 ("Unchecked return value")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing.
Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index eea555617d4a..95ddd19d1aa7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -464,9 +464,10 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  
>  	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
>  	err = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
> +	if (err < 0)
> +		return err;
>  
> -	st_lsm6dsx_shub_set_enable(sensor, false);
> -
> +	err = st_lsm6dsx_shub_set_enable(sensor, false);
>  	if (err < 0)
>  		return err;
>  

