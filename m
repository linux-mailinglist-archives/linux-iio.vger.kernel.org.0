Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDD312B48
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 08:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBHHy6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 8 Feb 2021 02:54:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2515 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhBHHys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 02:54:48 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DYymV2FTmz67lxL;
        Mon,  8 Feb 2021 15:47:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:54:06 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 07:54:05 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 15:54:03 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 14/24] staging:iio:cdc:ad7150: Reorganize headers.
Thread-Topic: [PATCH 14/24] staging:iio:cdc:ad7150: Reorganize headers.
Thread-Index: AQHW/WjJCVzQa/9ftkaZv0Z2ZjlcxKpN4qtg
Date:   Mon, 8 Feb 2021 07:54:02 +0000
Message-ID: <971adc6a4bf94a8c9a48504e06592cee@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-15-jic23@kernel.org>
In-Reply-To: <20210207154623.433442-15-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Monday, February 8, 2021 4:46 AM
> To: linux-iio@vger.kernel.org
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: [PATCH 14/24] staging:iio:cdc:ad7150: Reorganize headers.
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Whilst not important, it's nice to have the general headers in
> alphabetical order.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

>  drivers/staging/iio/cdc/ad7150.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c
> b/drivers/staging/iio/cdc/ad7150.c
> index 5d4783da7f98..9e88e774752f 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -6,13 +6,13 @@
>   */
> 
>  #include <linux/bitfield.h>
> -#include <linux/interrupt.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/slab.h>
> 
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> --
> 2.30.0

