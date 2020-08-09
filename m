Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1972D23FF72
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgHIRRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 13:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIRRp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 13:17:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4437C206CD;
        Sun,  9 Aug 2020 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596993465;
        bh=HqCmB91dp9wJXUfZ4P5DScloKB8YtYKjt9MQu6txdqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fLdTc83DSJBXydjL8xsSdkGOFtvcZaODxnZ9PXYicXoeA3It8/S8Y9UbvAgssERZj
         Jcs3YHDKZ0kXI6450A/y9RKCxcnck58sH4pCP75mRxaLA1COIqfKurqZl45PFLhNDU
         nlXjDhcXzufco+Y7OwSZKha+V66BMIC8sKnr+YXs=
Date:   Sun, 9 Aug 2020 18:07:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 01/27] iio: accel: kxsd9: Fix alignment of local
 buffer.
Message-ID: <20200809180721.643946ab@archlinux>
In-Reply-To: <20200722155103.979802-2-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
        <20200722155103.979802-2-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 16:50:37 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
> is not guaranteed by an array of smaller elements.
> 
> Note that whilst in this particular case the alignment forcing
> of the ts element is not strictly necessary it acts as good
> documentation.  Doing this where not necessary should cut
> down on the number of cut and paste introduced errors elsewhere.
> 
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan



> ---
>  drivers/iio/accel/kxsd9.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 66b2e4cf24cf..0e18b92e2099 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -209,14 +209,20 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
>  	const struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	/*
> +	 * Ensure correct positioning and alignment of timestamp.
> +	 * No need to zero initialize as all elements written.
> +	 */
> +	struct {
> +		__be16 chan[4];
> +		s64 ts __aligned(8);
> +	} hw_values;
>  	int ret;
> -	/* 4 * 16bit values AND timestamp */
> -	__be16 hw_values[8];
>  
>  	ret = regmap_bulk_read(st->map,
>  			       KXSD9_REG_X,
> -			       &hw_values,
> -			       8);
> +			       hw_values.chan,
> +			       sizeof(hw_values.chan));
>  	if (ret) {
>  		dev_err(st->dev,
>  			"error reading data\n");
> @@ -224,7 +230,7 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev,
> -					   hw_values,
> +					   &hw_values,
>  					   iio_get_time_ns(indio_dev));
>  	iio_trigger_notify_done(indio_dev->trig);
>  

