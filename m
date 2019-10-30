Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8CEA45A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2019 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3Tne (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Oct 2019 15:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3Tne (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Oct 2019 15:43:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6997205C9;
        Wed, 30 Oct 2019 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572464613;
        bh=SvrbAEw49Plnafe/VzNSWq8FLiN2PZsNxZj5PIYPCAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qhMfLygR9U7KoGtM2N9i/dXW6g1ijNGhj7Oz//aFnrSyQHID47A0Xju37huThLgpU
         h2ojTqe8N+JdKsUkmDhwMG6UVR57UeaIW3J+7nW8m+arNodehDgUpxDiZMAUYkY6hF
         qhqdix6PJKUna/ZSbL6CNrR4Cu4Vn9z04ds/n3uw=
Date:   Wed, 30 Oct 2019 19:43:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] drivers/iio: Sign extend without triggering
 implementation-defined behavior
Message-ID: <20191030194325.2ad20a8e@archlinux>
In-Reply-To: <20191028200700.213753-5-bvanassche@acm.org>
References: <20191028200700.213753-1-bvanassche@acm.org>
        <20191028200700.213753-5-bvanassche@acm.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Oct 2019 13:06:55 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> From the C standard: "The result of E1 >> E2 is E1 right-shifted E2 bit
> positions. If E1 has an unsigned type or if E1 has a signed type and a
> nonnegative value, the value of the result is the integral part of the
> quotient of E1 / 2E2 . If E1 has a signed type and a negative value, the
> resulting value is implementation-defined."
> 
> Hence use sign_extend_24_to_32() instead of "<< 8 >> 8".

+CC linux-iio

> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 4a3064fb6cd9..94a9cec69cd7 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -21,11 +21,6 @@
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
> @@ -556,7 +551,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
>  	else if (byte_for_channel == 2)
>  		*data = (s16)get_unaligned_le16(outdata);
>  	else if (byte_for_channel == 3)
> -		*data = (s32)st_sensors_get_unaligned_le24(outdata);
> +		*data = get_unaligned_signed_le24(outdata);
>  
>  st_sensors_free_memory:
>  	kfree(outdata);

