Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC811B87CC
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDYQxt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQxt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:53:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17DD0206D4;
        Sat, 25 Apr 2020 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833629;
        bh=UV9KYwwqh7/w5fmi/n97rx6YOlO1XQqVDCam0wu/dX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M+PGtVFazBmir9rJ4CevPckMHC4dVLggDQHscSXgT8EkiVyb/9pqlPjmGoiD4YkID
         d1UH9SxJvyMSqzg4YtrIqwVmuAVCW1eZnL2p0sXTXHbP6ErTulSsoqt1npBnSEt5J1
         wOjPWZAI5mgXNFUaqyF3ZAhT185KvMK64UUhxDe4=
Date:   Sat, 25 Apr 2020 17:53:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v1 16/16] iio: st_sensors: Use get_unaligned_be24() and
 sign_extend32()
Message-ID: <20200425175345.693b2f36@archlinux>
In-Reply-To: <20200421003135.23060-16-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-16-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:35 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use these functions instead of open-coding them.
> 
> Cc: Denis Ciocca <denis.ciocca@st.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
This one already has the header, so applied to the togreg branch of iio.git
and pushed out as testing with no changes :)

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 0e35ff06f9af..bfc39ef64718 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -20,11 +20,6 @@
>  
>  #include "st_sensors_core.h"
>  
> -static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
> -{
> -	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
> -}
> -
>  int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
>  				    u8 reg_addr, u8 mask, u8 data)
>  {
> @@ -545,7 +540,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  	else if (byte_for_channel == 2)
>  		*data = (s16)get_unaligned_le16(outdata);
>  	else if (byte_for_channel == 3)
> -		*data = (s32)st_sensors_get_unaligned_le24(outdata);
> +		*data = (s32)sign_extend32(get_unaligned_le24(outdata), 23);
>  
>  st_sensors_free_memory:
>  	kfree(outdata);

