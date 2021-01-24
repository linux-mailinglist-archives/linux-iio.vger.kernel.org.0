Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A09301C3E
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbhAXNat convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 24 Jan 2021 08:30:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAXNas (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 08:30:48 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F9E322583;
        Sun, 24 Jan 2021 13:30:06 +0000 (UTC)
Date:   Sun, 24 Jan 2021 13:30:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 1/4] iio: adis: add helpers for locking
Message-ID: <20210124133003.6005f9e6@archlinux>
In-Reply-To: <20210121114954.64156-2-nuno.sa@analog.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
        <20210121114954.64156-2-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 12:49:51 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

> Add some helpers to lock and unlock the device.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Hi Nuno

For a patch like this I'd also expect to see it immediately used in
all relevant places in the driver. I don't want a mixture
going forwards of this vs direct access to the lock.

No need to separate that into two patches for such a simple case
just introduce this and put it to use.  There aren't that
many call sites anyway from a quick grep.

Thanks,

Jonathan



> ---
>  include/linux/iio/imu/adis.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 04e96d688ba9..f9b728d490b1 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -428,6 +428,16 @@ static inline int adis_initial_startup(struct adis *adis)
>  	return ret;
>  }
>  
> +static inline void adis_dev_lock(struct adis *adis)
> +{
> +	mutex_lock(&adis->state_lock);
> +}
> +
> +static inline void adis_dev_unlock(struct adis *adis)
> +{
> +	mutex_unlock(&adis->state_lock);
> +}
> +
>  int adis_single_conversion(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int error_mask,
>  	int *val);

