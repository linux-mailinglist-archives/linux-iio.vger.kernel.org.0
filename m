Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00A7CD00D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJFJYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfJFJYF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:24:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E594206C2;
        Sun,  6 Oct 2019 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353845;
        bh=jjYJ64Ba1rAziT8V2I1ePtC/ym/d3iSw/snszFX9Zwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NaCdpHAVObgn7oYSkHKwsYYvGnFt5H8wcW61r1qkI5AoN2Iavl97K71HX+dI4042f
         /AmA6iVIg2RnWu1r6+zoxpXyR0rHFMLCZVvdILCZjvQE4I7JWKf5ATlg6ICGLdHjYi
         20+OA5CAnYX9pbG8VJz6f8Grsg/l5bAktAbfCVE0=
Date:   Sun, 6 Oct 2019 10:24:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] iio: imu: adis16480: use state lock for filter
 freq set
Message-ID: <20191006102401.43be8398@archlinux>
In-Reply-To: <20190926111812.15957-11-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-11-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:18:12 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> It's the only operation that does 2 operations (a read & a write), so the
> unlocked functions can be used under a single state lock.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index dc13d8a33612..01dae50e985b 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -550,6 +550,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int freq)
>  {
>  	struct adis16480 *st = iio_priv(indio_dev);
> +	struct mutex *slock = &st->adis.state_lock;
>  	unsigned int enable_mask, offset, reg;
>  	unsigned int diff, best_diff;
>  	unsigned int i, best_freq;
> @@ -560,9 +561,11 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
>  	offset = ad16480_filter_data[chan->scan_index][1];
>  	enable_mask = BIT(offset + 2);
>  
> -	ret = adis_read_reg_16(&st->adis, reg, &val);
> +	mutex_lock(slock);
> +
> +	ret = __adis_read_reg_16(&st->adis, reg, &val);
>  	if (ret < 0)
> -		return ret;
> +		goto out_unlock;
>  
>  	if (freq == 0) {
>  		val &= ~enable_mask;
> @@ -584,7 +587,11 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
>  		val |= enable_mask;
>  	}
>  
> -	return adis_write_reg_16(&st->adis, reg, val);
> +	ret = __adis_write_reg_16(&st->adis, reg, val);
> +out_unlock:
> +	mutex_unlock(slock);
> +
> +	return ret;
>  }
>  
>  static int adis16480_read_raw(struct iio_dev *indio_dev,

