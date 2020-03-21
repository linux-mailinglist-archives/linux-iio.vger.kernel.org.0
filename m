Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6FE18E311
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 17:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCUQyA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 12:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCUQyA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 12:54:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B591620732;
        Sat, 21 Mar 2020 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809639;
        bh=3OFO/Pt4NkrJXnqZ0NyowoUTBAD3ZMj9BkUGqTmpO3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nNt6NmIqenvJXsab1AoS0v7a1usw4uLqichUSyvRurBQMYUZ7UELV6KHuN4MZgOxf
         AUcKIdYzDALcKFJZGiCAn4+nG8Fbr+2gFcyGQmlymnMTlMDq5GfbJq6g1o4oRGVnGC
         W4lyu1Y+IEZTGKO1W5g1K7tUsgTZjHitfMrrTLHE=
Date:   Sat, 21 Mar 2020 16:53:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v2 4/5] iio: ad_sigma_delta: remove unused IIO channel
 macros
Message-ID: <20200321165355.025fe7d6@archlinux>
In-Reply-To: <20200321090802.11537-4-alexandru.ardelean@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
        <20200321090802.11537-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 11:08:01 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Now that all channel SigmaDelta IIO channel macros have been localized,
> remove the generic ones.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  include/linux/iio/adc/ad_sigma_delta.h | 58 --------------------------
>  1 file changed, 58 deletions(-)
> 
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 5a127c0ed200..a3a838dcf8e4 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -133,62 +133,4 @@ void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
>  
>  int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  
> -#define __AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> -	_storagebits, _shift, _extend_name, _type, _mask_all) \
> -	{ \
> -		.type = (_type), \
> -		.differential = (_channel2 == -1 ? 0 : 1), \
> -		.indexed = 1, \
> -		.channel = (_channel1), \
> -		.channel2 = (_channel2), \
> -		.address = (_address), \
> -		.extend_name = (_extend_name), \
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> -			BIT(IIO_CHAN_INFO_OFFSET), \
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> -		.info_mask_shared_by_all = _mask_all, \
> -		.scan_index = (_si), \
> -		.scan_type = { \
> -			.sign = 'u', \
> -			.realbits = (_bits), \
> -			.storagebits = (_storagebits), \
> -			.shift = (_shift), \
> -			.endianness = IIO_BE, \
> -		}, \
> -	}
> -
> -#define AD_SD_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> -	_storagebits, _shift) \
> -	__AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> -		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> -
> -#define AD_SD_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
> -	_storagebits, _shift) \
> -	__AD_SD_CHANNEL(_si, _channel, _channel, _address, _bits, \
> -		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> -
> -#define AD_SD_CHANNEL(_si, _channel, _address, _bits, \
> -	_storagebits, _shift) \
> -	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> -		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> -		 BIT(IIO_CHAN_INFO_SAMP_FREQ))
> -
> -#define AD_SD_CHANNEL_NO_SAMP_FREQ(_si, _channel, _address, _bits, \
> -	_storagebits, _shift) \
> -	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> -		_storagebits, _shift, NULL, IIO_VOLTAGE, 0)
> -
> -#define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
> -	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
> -		_storagebits, _shift, NULL, IIO_TEMP, \
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> -
> -#define AD_SD_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
> -	_shift) \
> -	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> -		_storagebits, _shift, "supply", IIO_VOLTAGE, \
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ))
> -
>  #endif

