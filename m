Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B73A7F01
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jun 2021 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFONSi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Jun 2021 09:18:38 -0400
Received: from www381.your-server.de ([78.46.137.84]:56122 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFONSi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Jun 2021 09:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=1W66/H3s5teygc09wl/WulwH9FbiheGuWC5Ppmmimvs=; b=WCYNX9hfx3J7n3ysa0Vyy7/8ir
        is7s6b91MDKlgOdyb4+seYHyMAWvBkTthTgNOiOIBlnO46RuKjP+UEMCgp8+TGmtAp2QTCQ/uu6wZ
        HjHW7iRCVuMYE1XRpNFtj5V5KNj2MbgnnWNX8vSKhlO1ygxrFY2cAMly3a8cAVfhYOJPfWSCO9kRA
        IIZUhd6k7fGDiDsFXqanRtSV/7e324IUxeiC7M94rajDpsXYT349grSVD6aXHrpUVuyOflFLf3Lhl
        S0sPSzB8yTy2Y/djF5EFQZXdI4QLfyBEOi6o4Si8vYy095RV1wUOtNUjNJ+m61l2mIMy86Ex2Y6o5
        OHGaFOfQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lt8vg-000D9G-HI; Tue, 15 Jun 2021 15:16:32 +0200
Received: from [2001:a61:2bdf:6601:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lt8vg-0004et-BX; Tue, 15 Jun 2021 15:16:32 +0200
Subject: Re: [PATCH 01/12] iio:accel:adxl372: Cleanup includes
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20210611171355.202903-1-jic23@kernel.org>
 <20210611171355.202903-2-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <86b0811c-d3fc-d87e-adb1-71046d4a9c36@metafoo.de>
Date:   Tue, 15 Jun 2021 15:16:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210611171355.202903-2-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26202/Tue Jun 15 13:21:24 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/11/21 7:13 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Based on consideration of the output of include-what-you-use.
> Drop some unused headers and include others that should probably be
> there based on direct use.  Also a few forward definitions to avoid
> any potential future include ordering issues.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>


Acked-by:  Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   drivers/iio/accel/adxl372.c     | 4 ++--
>   drivers/iio/accel/adxl372.h     | 2 ++
>   drivers/iio/accel/adxl372_spi.c | 3 +--
>   3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index fc9592407717..c679cb9f3ed1 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -6,12 +6,12 @@
>    */
>   
>   #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>   #include <linux/bitops.h>
>   #include <linux/interrupt.h>
> -#include <linux/irq.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/regmap.h>
> -#include <linux/spi/spi.h>
>   
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
> diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
> index 80a0aa9714fc..86bf8955d60c 100644
> --- a/drivers/iio/accel/adxl372.h
> +++ b/drivers/iio/accel/adxl372.h
> @@ -9,6 +9,8 @@
>   #define _ADXL372_H_
>   
>   #define ADXL372_REVID	0x03
> +struct device;
> +struct regmap;
>   
>   int adxl372_probe(struct device *dev, struct regmap *regmap,
>   		  int irq, const char *name);
> diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> index 1f1352fee99a..927379f9b497 100644
> --- a/drivers/iio/accel/adxl372_spi.c
> +++ b/drivers/iio/accel/adxl372_spi.c
> @@ -6,9 +6,8 @@
>    */
>   
>   #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/regmap.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>   #include <linux/spi/spi.h>
>   
>   #include "adxl372.h"


