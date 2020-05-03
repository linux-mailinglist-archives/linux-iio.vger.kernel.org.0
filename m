Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F17A1C2CA7
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgECNLc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 09:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgECNLb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 09:11:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD162073E;
        Sun,  3 May 2020 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588511491;
        bh=mQPk8N/wB1H4HRuP+wEdA14zmdfViu6521LM06iYBSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rZ7IeZ8BIF6R/TFh7l9NA6VwJmKlVPpBuo7F4Y6JM+9GN9O1nLXDee2XokPFmBYd6
         /pFPhjc7l33d0iov7Qmqz9vUx27TcHDXvyeaMcFrO7Kh+uPLCqCWK6bPeYCMC/T3oc
         Y4TiVOHRpDJIQWH1xzMPrgYmkZdkWXy2jWeWhADE=
Date:   Sun, 3 May 2020 14:11:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] iio: adc: ti-ads8344: Fix channel selection
Message-ID: <20200503141126.4edba889@archlinux>
In-Reply-To: <20200430130547.2175250-1-gregory.clement@bootlin.com>
References: <20200430130547.2175250-1-gregory.clement@bootlin.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Apr 2020 15:05:47 +0200
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> During initial submission the selection of the channel was done using
> the scan_index member of the iio_chan_spec structure. It was an abuse
> because this member is supposed to be used with a buffer so it was
> removed.
> 
> However there was still the need to be able to known how to select a
> channel, the correct member to store this information is address.
> 
> Thanks to this it is possible to select any other channel than the
> channel 0.
> 
> Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Oops on this one :(

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads8344.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index 9a460807d46d..d384ca3437da 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -32,16 +32,17 @@ struct ads8344 {
>  	u16 rx_buf;
>  };
>  
> -#define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
> +#define ADS8344_VOLTAGE_CHANNEL(chan, addr)				\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
>  		.channel = chan,					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.address = addr,					\
>  	}
>  
> -#define ADS8344_VOLTAGE_CHANNEL_DIFF(chan1, chan2, si)			\
> +#define ADS8344_VOLTAGE_CHANNEL_DIFF(chan1, chan2, addr)		\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> @@ -50,6 +51,7 @@ struct ads8344 {
>  		.differential = 1,					\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.address = addr,					\
>  	}
>  
>  static const struct iio_chan_spec ads8344_channels[] = {
> @@ -105,7 +107,7 @@ static int ads8344_read_raw(struct iio_dev *iio,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&adc->lock);
> -		*value = ads8344_adc_conversion(adc, channel->scan_index,
> +		*value = ads8344_adc_conversion(adc, channel->address,
>  						channel->differential);
>  		mutex_unlock(&adc->lock);
>  		if (*value < 0)

