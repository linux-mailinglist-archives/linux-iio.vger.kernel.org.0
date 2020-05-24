Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD291DFFE3
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgEXPel (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 11:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbgEXPel (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 11:34:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50754207CB;
        Sun, 24 May 2020 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590334481;
        bh=wT+ESqG7vZqzvtm4IF1yCazLxtRoy8QN9SSj2Wr1oNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K4RlZyCoPWC56P5DgXEeaNWi/roVGgZo9wiqsTi4+juzjzKgxc3UPxdUKEdnCkQlR
         sx9uVO+wSuOoQf/MSOXWhtREKBwlpKcq57GHt9S/3Ag0farf0aGNvy0sZFFyU1gFrb
         UeZlF0JW+3udyEfuwwEfeigEueBfoqs7H5L6+RUU=
Date:   Sun, 24 May 2020 16:34:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Andrew F . Davis" <afd@ti.com>
Subject: Re: [PATCH 08/11] iio:health:afe4404 Fix timestamp alignment and
 prevent data leak.
Message-ID: <20200524163432.2c1407e5@archlinux>
In-Reply-To: <20200517173000.220819-9-jic23@kernel.org>
References: <20200517173000.220819-1-jic23@kernel.org>
        <20200517173000.220819-9-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 18:29:57 +0100
jic23@kernel.org wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 40 byte array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak appart from previous readings.
> 
> Fixes: 87aec56e27ef ("iio: health: Add driver for the TI AFE4404 heart monitor")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andrew F. Davis <afd@ti.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/health/afe4404.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index e728bbb21ca8..cebb1fd4d0b1 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -83,6 +83,7 @@ static const struct reg_field afe4404_reg_fields[] = {
>   * @regulator: Pointer to the regulator for the IC
>   * @trig: IIO trigger for this device
>   * @irq: ADC_RDY line interrupt number
> + * @buffer: Used to construct a scan to push to the iio buffer.
>   */
>  struct afe4404_data {
>  	struct device *dev;
> @@ -91,6 +92,7 @@ struct afe4404_data {
>  	struct regulator *regulator;
>  	struct iio_trigger *trig;
>  	int irq;
> +	s32 buffer[10] __aligned(8);
>  };
>  
>  enum afe4404_chan_id {
> @@ -328,17 +330,17 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct afe4404_data *afe = iio_priv(indio_dev);
>  	int ret, bit, i = 0;
> -	s32 buffer[10];
>  
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
>  			 indio_dev->masklength) {
>  		ret = regmap_read(afe->regmap, afe4404_channel_values[bit],
> -				  &buffer[i++]);
> +				  &afe->buffer[i++]);
>  		if (ret)
>  			goto err;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
> +					   pf->timestamp);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  

