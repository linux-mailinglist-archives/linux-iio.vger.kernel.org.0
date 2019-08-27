Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F389F3CA
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfH0UJC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 16:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0UJC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 16:09:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB232186A;
        Tue, 27 Aug 2019 20:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566936541;
        bh=YJ790dnx33Um0ruxeNoQGSZwh6wWiRH2WNlSpN/9A/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gdfwQNhFBA7pVjn9ou1M+wVbctk1FZCBSgsQ3xhoWn8+JHXVf2xj3jA8c8gfX+qYC
         MaKtNCKxdD33QlRAlAQsSdBICQxcWlhkIA2Qs4QW3XAVjkCg+OUvfP10MQeS+Prx4F
         KmzyJip2bFqsTOUQwlQhDcl7YHOvNQ1cfahXAbko=
Date:   Tue, 27 Aug 2019 21:08:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain value for
 LSM9DS1
Message-ID: <20190827210857.718d7f9b@archlinux>
In-Reply-To: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
References: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Aug 2019 10:26:35 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Get rid of invalid sensitivity value for LSM9DS1 gyro sensor
> 
> Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
The zero degree scale is certainly odd otherwise, so good to tidy
this up.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index fd152fff0a8c..c85c8be3a024 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -151,10 +151,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  					.addr = 0x10,
>  					.mask = GENMASK(4, 3),
>  				},
> -				.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
> -				.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
> -				.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
> -				.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
> +				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(245), 0x0 },
> +				.fs_avl[1] = {  IIO_DEGREE_TO_RAD(500), 0x1 },
> +				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
>  			},
>  		},
>  	},
> @@ -1196,13 +1195,19 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
>  					    char *buf)
>  {
>  	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> +	const struct st_lsm6dsx_fs_table_entry *fs_table;
>  	enum st_lsm6dsx_sensor_id id = sensor->id;
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int i, len = 0;
>  
> -	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
> +	fs_table = &hw->settings->fs_table[id];
> +	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
> +		if (!fs_table->fs_avl[i].gain)
> +			break;
> +
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> -				 hw->settings->fs_table[id].fs_avl[i].gain);
> +				 fs_table->fs_avl[i].gain);
> +	}
>  	buf[len - 1] = '\n';
>  
>  	return len;

