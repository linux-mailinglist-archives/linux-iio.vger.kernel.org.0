Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AFED2EC
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKCKlg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCKlg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:41:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64786214D8;
        Sun,  3 Nov 2019 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572777695;
        bh=kU0RyGJdDtCTeSFh1Anb/QfudizmltEVxFG4CYeJO+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=elfTpveFV8M1/e2X4K0egqmHeczXePvC204nHkvxzlTbA1w/zkRXa74zP+1MvmDH2
         HkRlzCH+au2KFjA7r3Hv2vm1rLWD236EeQLwSkqC05NvC9L4B/OaIA3SyNLq/soKhk
         XWqZr/2CI4YcgM1EF8zci9ir713VclzDiiw1DYjw=
Date:   Sun, 3 Nov 2019 10:41:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 08/10] iio: imu: adis16480: assign bias value only if
 operation succeeded
Message-ID: <20191103104131.4f4782e2@archlinux>
In-Reply-To: <20191101093505.9408-9-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-9-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:35:03 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This was found only after the whole thing with the inline functions, but
> the compiler actually found something. The value of the `bias` (in
> adis16480_get_calibbias()) should only be set if the read operation was
> successful.
> 
> Fixes: 2f3abe6cbb6c9 ("iio:imu: Add support for the ADIS16480 and similar IMUs")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hmm. It's not really a fix as such unless there is an in kernel consumer
that is using this and not checking the return value.   I thought about dropping
the fixes tag, but it is avoiding confusing the compiler so I suppose we might
as well leave it marked as a fix.  I will add a note that this doesn't cause
any known real problems and so probably isn't stable material.

Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index b9e2695bcfad..c0e7e768be41 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -451,12 +451,14 @@ static int adis16480_get_calibbias(struct iio_dev *indio_dev,
>  	case IIO_MAGN:
>  	case IIO_PRESSURE:
>  		ret = adis_read_reg_16(&st->adis, reg, &val16);
> -		*bias = sign_extend32(val16, 15);
> +		if (ret == 0)
> +			*bias = sign_extend32(val16, 15);
>  		break;
>  	case IIO_ANGL_VEL:
>  	case IIO_ACCEL:
>  		ret = adis_read_reg_32(&st->adis, reg, &val32);
> -		*bias = sign_extend32(val32, 31);
> +		if (ret == 0)
> +			*bias = sign_extend32(val32, 31);
>  		break;
>  	default:
>  		ret = -EINVAL;

