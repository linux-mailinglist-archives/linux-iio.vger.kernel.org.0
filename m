Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF72D320BB4
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBUQ1I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:27:08 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35462 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhBUQ1I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2021 11:27:08 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id ADA4A9E00E6;
        Sun, 21 Feb 2021 16:26:24 +0000 (GMT)
Date:   Sun, 21 Feb 2021 16:26:22 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: fix warnings about passing signed values to %u
Message-ID: <20210221162622.02f6ca2c@archlinux>
In-Reply-To: <20201128155648.376646-1-jic23@kernel.org>
References: <20201128155648.376646-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 15:56:48 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> In reality, we already know both of these values are positive
> but it is still better to make that explicit at the point of use
> with abs().
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>

Maintainers curse. If someone could sanity check this that would be great.
I never trust myself not to do anything stupid :)

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index c2e4c267c36b..00644666f7fe 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -608,14 +608,14 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  			return scnprintf(buf, len, "-%d.%06u%s", abs(vals[0]),
>  					-vals[1], scale_db ? " dB" : "");
>  		else
> -			return scnprintf(buf, len, "%d.%06u%s", vals[0], vals[1],
> +			return scnprintf(buf, len, "%d.%06u%s", vals[0], abs(vals[1]),
>  					scale_db ? " dB" : "");
>  	case IIO_VAL_INT_PLUS_NANO:
>  		if (vals[1] < 0)
>  			return scnprintf(buf, len, "-%d.%09u", abs(vals[0]),
>  					-vals[1]);
>  		else
> -			return scnprintf(buf, len, "%d.%09u", vals[0], vals[1]);
> +			return scnprintf(buf, len, "%d.%09u", vals[0], abs(vals[1]));
>  	case IIO_VAL_FRACTIONAL:
>  		tmp2 = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>  		tmp1 = vals[1];

