Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5143443E3CB
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1OfO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 28 Oct 2021 10:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhJ1OfN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:35:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BE260F70;
        Thu, 28 Oct 2021 14:32:45 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:37:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>
Cc:     linux-iio@vger.kernel.org, Jack Andersen <jackoalan@gmail.com>
Subject: Re: [PATCH] iio: dln2-adc: Fix lockdep complaint
Message-ID: <20211028153711.581fd9c8@jic23-huawei>
In-Reply-To: <20211018113731.25723-1-noralf@tronnes.org>
References: <20211018113731.25723-1-noralf@tronnes.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 13:37:31 +0200
Noralf Trønnes <noralf@tronnes.org> wrote:

> When reading the voltage:
> 
> $ cat /sys/bus/iio/devices/iio\:device0/in_voltage0_raw
> 
> Lockdep complains:
> 
> [  153.910616] ======================================================
> [  153.916918] WARNING: possible circular locking dependency detected
> [  153.923221] 5.14.0+ #5 Not tainted
> [  153.926692] ------------------------------------------------------
> [  153.932992] cat/717 is trying to acquire lock:
> [  153.937525] c2585358 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_device_claim_direct_mode+0x28/0x44
> [  153.946541]
>                but task is already holding lock:
> [  153.952487] c2585860 (&dln2->mutex){+.+.}-{3:3}, at: dln2_adc_read_raw+0x94/0x2bc [dln2_adc]
> [  153.961152]
>                which lock already depends on the new lock.
> 
> Fix this by not calling into the iio core underneath the dln2->mutex lock.
> 
> Fixes: 7c0299e879dd ("iio: adc: Add support for DLN2 ADC")
> Cc: Jack Andersen <jackoalan@gmail.com>
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
> 
> Note that this patch is needed for the driver to be usable:
> 
> mfd: dln2: Add cell for initializing DLN2 ADC
> https://lore.kernel.org/lkml/20211018112541.25466-1-noralf@tronnes.org/T/#u
> 
> 
>  drivers/iio/adc/dln2-adc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index 16407664182c..6c67192946aa 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -248,7 +248,6 @@ static int dln2_adc_set_chan_period(struct dln2_adc *dln2,
>  static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
>  {
>  	int ret, i;
> -	struct iio_dev *indio_dev = platform_get_drvdata(dln2->pdev);
>  	u16 conflict;
>  	__le16 value;
>  	int olen = sizeof(value);
> @@ -257,13 +256,9 @@ static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
>  		.chan = channel,
>  	};
>  
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = dln2_adc_set_chan_enabled(dln2, channel, true);
>  	if (ret < 0)
> -		goto release_direct;
> +		return ret;
>  
>  	ret = dln2_adc_set_port_enabled(dln2, true, &conflict);
>  	if (ret < 0) {
> @@ -300,8 +295,6 @@ static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
>  	dln2_adc_set_port_enabled(dln2, false, NULL);
>  disable_chan:
>  	dln2_adc_set_chan_enabled(dln2, channel, false);
> -release_direct:
> -	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
>  }
> @@ -337,10 +330,16 @@ static int dln2_adc_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
>  		mutex_lock(&dln2->mutex);
>  		ret = dln2_adc_read(dln2, chan->channel);
>  		mutex_unlock(&dln2->mutex);
>  
> +		iio_device_release_direct_mode(indio_dev);
> +
>  		if (ret < 0)
>  			return ret;
>  

