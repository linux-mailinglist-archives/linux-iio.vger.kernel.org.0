Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D65CC9C6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfJEL74 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfJEL74 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:59:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4057B222CA;
        Sat,  5 Oct 2019 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570276796;
        bh=q7zxs1RUKjiM+657AhQSzNqHIMiamwXMj6rFy2fVCA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fbDCWB2URWQqEGX6PGzHM/4VIgmOwcNRxj2UscEcVeEuVQsdg7CtAsHLhsevwN74r
         dD492VdiZs0OHQOmedvLS6023Mn5DGBuLHspZWBrbv9EG478OflVeovmMeUj5TFwsD
         N7C5faplyI7yCDKq4LfjvYeFrUyo8lRh5fcym1kc=
Date:   Sat, 5 Oct 2019 12:45:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix waitime for st_lsm6dsx i2c
 controller
Message-ID: <20191005124516.012bbd2a@archlinux>
In-Reply-To: <46d302e91284908061e0a39e36b9a3122aa6fb1a.1568670658.git.lorenzo@kernel.org>
References: <46d302e91284908061e0a39e36b9a3122aa6fb1a.1568670658.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Sep 2019 00:01:29 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> i2c controller available in st_lsm6dsx series performs i2c slave
> configuration using accel clock as trigger.
> st_lsm6dsx_shub_wait_complete routine is used to wait the controller has
> carried out the requested configuration. However if the accel sensor is not
> enabled we should not use its configured odr to estimate a proper timeout
> 
> Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Marked for stable and applied to the fixes-togreg branch of iio.git.

This one seems completely tangential to the stuff applied to the togreg branch
so shouldn't cause any merge problems.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 66fbcd94642d..4c754a02717b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -92,9 +92,11 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>  static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>  {
>  	struct st_lsm6dsx_sensor *sensor;
> +	u16 odr;
>  
>  	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> -	msleep((2000U / sensor->odr) + 1);
> +	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 13;
> +	msleep((2000U / odr) + 1);
>  }
>  
>  /**

