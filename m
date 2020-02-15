Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129F815FEFD
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgBOPg6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 10:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgBOPg5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 10:36:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A64F2082F;
        Sat, 15 Feb 2020 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581781017;
        bh=M2+/yfpUyLGN7E4gfvySoS0R960CpS+2bqx2UOAVy68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t934JHHFwAEdqpVJ5z2PFlSXiW44G5BzAqmsqIY/zjnskHlhfMwWuMiYxtyLc/Qjo
         MjiSxQph9ehhN5vMS5unFCqWU6prxwCcp9Rpf51x8FCSOwnzSd9Bkib0vviVUDBJII
         LaL8LCTP8OCxPpRLyD8ZswFSDfakmX4Cjnni0EJo=
Date:   Sat, 15 Feb 2020 15:36:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: accel: adxl372: Set iio_chan BE
Message-ID: <20200215153653.4aee3b1d@archlinux>
In-Reply-To: <20200214092919.24351-3-alexandru.tachici@analog.com>
References: <20200214092919.24351-1-alexandru.tachici@analog.com>
        <20200214092919.24351-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Feb 2020 11:29:16 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Data stored in the iio-buffer is BE and this
> should be specified in the iio_chan_spec struct.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
To a quick glance this looks to me like a fix we should be backporting.
Please add a fixes tag if so and I'll get this lined up to go in during
the RCs.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index bb6c2bf1a457..538e5053a946 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -237,6 +237,7 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
>  		.realbits = 12,						\
>  		.storagebits = 16,					\
>  		.shift = 4,						\
> +		.endianness = IIO_BE,					\
>  	},								\
>  }
>  

