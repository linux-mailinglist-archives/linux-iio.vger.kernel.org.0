Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9433F43E300
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhJ1OFg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhJ1OFe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:05:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF38610CA;
        Thu, 28 Oct 2021 14:03:05 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:07:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: mma8452: Fix trigger reference couting
Message-ID: <20211028150731.753d4e40@jic23-huawei>
In-Reply-To: <20211024092700.6844-1-lars@metafoo.de>
References: <20211024092700.6844-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Oct 2021 11:26:59 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The mma8452 driver directly assigns a trigger to the struct iio_dev. The
> IIO core when done using this trigger will call `iio_trigger_put()` to drop
> the reference count by 1.
> 
> Without the matching `iio_trigger_get()` in the driver the reference count
> can reach 0 too early, the trigger gets freed while still in use and a
> use-after-free occurs.
> 
> Fix this by getting a reference to the trigger before assigning it to the
> IIO device.
> 
> Fixes: ae6d9ce05691 ("iio: mma8452: Add support for interrupt driven triggers.")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Gah. I thought we'd gotten all these years ago. I guess this one slipped through
the net.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 715b8138fb71..09c7f10fefb6 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1470,7 +1470,7 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	indio_dev->trig = trig;
> +	indio_dev->trig = iio_trigger_get(trig);
>  
>  	return 0;
>  }

