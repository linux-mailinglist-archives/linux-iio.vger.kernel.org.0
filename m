Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE081EEE
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfHEOVy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfHEOVy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:21:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB47206C1;
        Mon,  5 Aug 2019 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565014913;
        bh=XAA7Flg5c5GFi9m33JML4YyxGkePU4glbZekU7pANpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gZflbhZO5wL2IJqDdj7C3PyIeif9ajRKpt9I2gvPVDtdzb0BypyhzRjIT5ogW0iiD
         3UNvEFV3B0mUBPiGQAEB0bngO9gMJWRpAvhhzezVw9W+zDrbSe441TA2IDrlzsj9MP
         fei20FuVg8oNi/hkg02l57xqlkefBr7QDWebJGf4=
Date:   Mon, 5 Aug 2019 15:21:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: make IIO_CHAN_INFO_SCALE shared
 by type
Message-ID: <20190805152148.0ea55f6e@archlinux>
In-Reply-To: <20190801143908.27608-1-martin.kepplinger@puri.sm>
References: <20190801143908.27608-1-martin.kepplinger@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Aug 2019 16:39:08 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are always
> the same. The scale is still defined to be in "info_mask_separate".
> 
> Userspace (iio-sensor-proxy and others) is not used to that and only
> looks for "in_accel_scale" for the scaling factor to apply.
> 
> Change IIO_CHAN_INFO_SCALE from being separate in all channel to be
> shared by type.
> 
> This removes in_accel_x_scale, in_accel_y_scale and in_accel_z_scale and
> makes available in_accel_scale.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> AFAIK in all other drivers, IIO_CHAN_INFO_SCALE is "shared by type". Sure
> devices are different, but LSM6DSX devices still don't have different
> scales for x/y/z channels :)

I'm fine with this, but would like a Lorenzo ack as we have had
devices in other series where these are not equal.   It used to
be common in accelerometers as I think it was hard to get a large
range in the vertical direction.  Doubt that applies on these modern
parts though!

Thanks,

Jonathan


> 
> thanks,
> 
>                               martin
> 
> 
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index af379a5429ed..59c3ab7cbb6f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -56,8 +56,8 @@ enum st_lsm6dsx_hw_id {
>  	.address = addr,						\
>  	.modified = 1,							\
>  	.channel2 = mod,						\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> -			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
>  	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.scan_index = scan_idx,						\
>  	.scan_type = {							\

