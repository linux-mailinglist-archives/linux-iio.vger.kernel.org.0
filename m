Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34663626CD
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 19:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbhDPRbX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 13:31:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2877 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbhDPRbX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 13:31:23 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FMNN81KF4z688M0;
        Sat, 17 Apr 2021 01:23:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 16 Apr 2021 19:30:56 +0200
Received: from localhost (10.52.127.203) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 16 Apr
 2021 18:30:55 +0100
Date:   Fri, 16 Apr 2021 18:29:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>
Subject: Re: [PATCH 21/57] staging: iio: frequency: ad9834: Provide missing
 description for 'devid'
Message-ID: <20210416182927.00000f60@Huawei.com>
In-Reply-To: <20210414181129.1628598-22-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
        <20210414181129.1628598-22-lee.jones@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.203]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Apr 2021 19:10:53 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Also demote kernel-doc abuses
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/staging/iio/frequency/ad9834.c:87: warning: Function parameter or member 'devid' not described in 'ad9834_state'
>  drivers/staging/iio/frequency/ad9834.c:93: warning: cannot understand function prototype: 'enum ad9834_supported_device_ids '
>  drivers/staging/iio/frequency/ad9834.c:320: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I was leaving the staging stuff in IIO related to W=1 as good material
for newbies, but I guess if you are blanket cleaning it up then fair
enough.

Sounds like Greg will take the whole series so,

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/staging/iio/frequency/ad9834.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 60a3ae5587b90..94b131ef8a22c 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -58,6 +58,7 @@
>   * @spi:		spi_device
>   * @mclk:		external master clock
>   * @control:		cached control word
> + * @devid:		device id
>   * @xfer:		default spi transfer
>   * @msg:		default spi message
>   * @freq_xfer:		tuning word spi transfer
> @@ -86,7 +87,7 @@ struct ad9834_state {
>  	__be16				freq_data[2];
>  };
>  
> -/**
> +/*
>   * ad9834_supported_device_ids:
>   */
>  
> @@ -316,7 +317,7 @@ ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
>  static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
>  		       ad9834_show_out1_wavetype_available, NULL, 0);
>  
> -/**
> +/*
>   * see dds.h for further information
>   */
>  

