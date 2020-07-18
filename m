Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3131C224CD1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGRQDw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 12:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRQDv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 12:03:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6B52076A;
        Sat, 18 Jul 2020 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595088231;
        bh=UxT9RTMFLldS9pWVu6sdlbemYgzNQ1fnC3xzAqU04tE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZRNghIrPQPxAp/2jSfIJ48Z3xl4JVhfnqVlUr+xarellCmqPQi/Dyc6RNdhv5wDup
         1L2KgDcwHaOu0/D5HoTyBPaeV4RUnxh5pN1j3ZU9DA51G1N7zkxqESODTSvlSNEX7X
         tfv0xLsjCEdxVOQh5zKLQEO/hJZ9ywp1X6qCl9p4=
Date:   Sat, 18 Jul 2020 17:03:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 25/30] iio: imu: inv_mpu6050: inv_mpu_ring: Demote
 seemingly unintentional kerneldoc header
Message-ID: <20200718170346.5540100b@archlinux>
In-Reply-To: <20200717165538.3275050-26-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
        <20200717165538.3275050-26-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Jul 2020 17:55:33 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> This is the only use of kerneldoc in the source file and no
> descriptions are provided.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:118: warning: Function parameter or member 'irq' not described in 'inv_mpu6050_read_fifo'
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:118: warning: Function parameter or member 'p' not described in 'inv_mpu6050_read_fifo'
> 
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 9511e4715e2c1..b533fa2dad0ab 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -111,7 +111,7 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
>  	return result;
>  }
>  
> -/**
> +/*
>   * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
>   */
>  irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)

