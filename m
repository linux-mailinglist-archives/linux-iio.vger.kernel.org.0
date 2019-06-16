Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDC47430
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfFPKSI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 06:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfFPKSI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 06:18:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778A32084A;
        Sun, 16 Jun 2019 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560680287;
        bh=22Nyl8r5NyujEokw6IbfB3M3uwmZEcDVVxHqLyjGrAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t3Y/hPQk6Y8RrOPdI2Afc/IrTEmx6ELkPRXG2g3JQvnVpf0/lB8YuwpJDRo5pnqVG
         Qp/2WjOqyaRYXdrz2s5yzJn1wvEFF7IVaXzJ8py/MQL/yw3Ysj2wl4IwC2/kGmI/1e
         vcrL17OhNPhmcA+2889gkgcyOon4gipSdMgXs6v4=
Date:   Sun, 16 Jun 2019 11:18:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/3] staging: iio: ad7150: use FIELD_GET and GENMASK
Message-ID: <20190616111802.51498c02@archlinux>
In-Reply-To: <4f88fd66e478289006353645d84b7af1b5aa345c.1560529045.git.melissa.srw@gmail.com>
References: <cover.1560529045.git.melissa.srw@gmail.com>
        <4f88fd66e478289006353645d84b7af1b5aa345c.1560529045.git.melissa.srw@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 13:32:21 -0300
Melissa Wen <melissa.srw@gmail.com> wrote:

> Use the bitfield macro FIELD_GET, and GENMASK to do the shift and mask in
> one go. This makes the code more readable than explicit masking followed
> by a shift.
> 
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to paly with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7150.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 8234da4b8c65..091aa33589d7 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -5,6 +5,7 @@
>   * Copyright 2010-2011 Analog Devices Inc.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -45,6 +46,9 @@
>  #define AD7150_SN0                 22
>  #define AD7150_ID                  23
>  
> +/* AD7150 masks */
> +#define AD7150_THRESHTYPE_MSK			GENMASK(6, 5)
> +
>  /**
>   * struct ad7150_chip_info - instance specific chip data
>   * @client: i2c client for this device
> @@ -137,7 +141,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	threshtype = (ret >> 5) & 0x03;
> +	threshtype = FIELD_GET(AD7150_THRESHTYPE_MSK, ret);
>  	adaptive = !!(ret & 0x80);
>  
>  	switch (type) {

