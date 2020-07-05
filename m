Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA014214C2D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGELsL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 07:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 07:48:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04DA920723;
        Sun,  5 Jul 2020 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949690;
        bh=rDkLTaJ4VPckMkuuGjiXEY81pmUpquRpMHbD3nSCGTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oaffv0VNcwpQSN12ohP/DyMde4E3WdYy/lRV6x3rMym8TIeOgsUofecf3t7Qry4bh
         eig7rs4yKKDsVmgFsH9rtTqAqBDl+mwlG9Vos7ZGiH3YXeK9cn6meDdpPgzpOL4NRv
         ulZzleHrjB5klporJsZqfbC9HLDdc/5JLu0ECfSA=
Date:   Sun, 5 Jul 2020 12:48:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 17/32] iio:humidity:hts221 Fix alignment and data leak
 issues
Message-ID: <20200705124807.6fa6fd14@archlinux>
In-Reply-To: <20200607155408.958437-18-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-18-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  7 Jun 2020 16:53:53 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data.
> This data is allocated with kzalloc so no data can leak
> apart from previous readings.
> 
> Explicit alignment of ts needed to ensure consistent padding
> on all architectures (particularly x86_32 with it's 4 byte alignment
> of s64)
> 
> Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo device")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
I'm scooping up all the ones in this series for which I have an ack so
that we can focus on getting remainder reviewed.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hts221.h        | 7 +++++--
>  drivers/iio/humidity/hts221_buffer.c | 9 +++++----
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 7c650df77556..721359e226cb 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -14,8 +14,6 @@
>  
>  #include <linux/iio/iio.h>
>  
> -#define HTS221_DATA_SIZE	2
> -
>  enum hts221_sensor_type {
>  	HTS221_SENSOR_H,
>  	HTS221_SENSOR_T,
> @@ -39,6 +37,11 @@ struct hts221_hw {
>  
>  	bool enabled;
>  	u8 odr;
> +	/* Ensure natural alignment of timestamp */
> +	struct {
> +		__le16 channels[2];
> +		s64 ts __aligned(8);
> +	} scan;
>  };
>  
>  extern const struct dev_pm_ops hts221_pm_ops;
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 21c6c160462d..59ede9860185 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -160,7 +160,6 @@ static const struct iio_buffer_setup_ops hts221_buffer_ops = {
>  
>  static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
>  {
> -	u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *iio_dev = pf->indio_dev;
>  	struct hts221_hw *hw = iio_priv(iio_dev);
> @@ -170,18 +169,20 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
>  	/* humidity data */
>  	ch = &iio_dev->channels[HTS221_SENSOR_H];
>  	err = regmap_bulk_read(hw->regmap, ch->address,
> -			       buffer, HTS221_DATA_SIZE);
> +			       &hw->scan.channels[0],
> +			       sizeof(hw->scan.channels[0]));
>  	if (err < 0)
>  		goto out;
>  
>  	/* temperature data */
>  	ch = &iio_dev->channels[HTS221_SENSOR_T];
>  	err = regmap_bulk_read(hw->regmap, ch->address,
> -			       buffer + HTS221_DATA_SIZE, HTS221_DATA_SIZE);
> +			       &hw->scan.channels[1],
> +			       sizeof(hw->scan.channels[1]));
>  	if (err < 0)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
> +	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
>  					   iio_get_time_ns(iio_dev));
>  
>  out:

