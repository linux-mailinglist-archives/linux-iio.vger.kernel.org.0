Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2E312B3D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 08:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBHHvo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 8 Feb 2021 02:51:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2513 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBHHvo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 02:51:44 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DYymD3b6dz67m3R;
        Mon,  8 Feb 2021 15:47:24 +0800 (CST)
Received: from lhreml718-chm.china.huawei.com (10.201.108.69) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:50:59 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml718-chm.china.huawei.com (10.201.108.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 07:50:57 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 8 Feb 2021 15:50:56 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
Thread-Topic: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
Thread-Index: AQHW/WjOz1HcIZ4+F0WGI66byv11FKpN4Rlg
Date:   Mon, 8 Feb 2021 07:50:56 +0000
Message-ID: <ad342dd10155419097b852761aa21038@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-21-jic23@kernel.org>
In-Reply-To: <20210207154623.433442-21-jic23@kernel.org>
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
> Subject: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
> 
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Rather than using the fallback path in the i2c subsystem and hoping
> for no clashes across vendors, lets put in an explicit table for
> matching.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c
> b/drivers/staging/iio/cdc/ad7150.c
> index 0bc8c7a99883..33c8a78c076f 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -12,6 +12,7 @@
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> 
> @@ -655,9 +656,16 @@ static const struct i2c_device_id ad7150_id[] = {
> 
>  MODULE_DEVICE_TABLE(i2c, ad7150_id);
> 
> +static const struct of_device_id ad7150_of_match[] = {
> +	{ "adi,ad7150" },
> +	{ "adi,ad7151" },
> +	{ "adi,ad7156" },
> +	{}
> +};

Does it compile if CONFIG_OF is not enabled?

>  static struct i2c_driver ad7150_driver = {
>  	.driver = {
>  		.name = "ad7150",
> +		.of_match_table = ad7150_of_match,

of_match_ptr(ad7150_of_match)?

Do we need dt-binding doc?


>  	},
>  	.probe = ad7150_probe,
>  	.id_table = ad7150_id,
> --
> 2.30.0

Thanks
Barry

