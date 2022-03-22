Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDE4E482C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 22:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiCVVQj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 17:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiCVVQi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 17:16:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20064192
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 14:15:10 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNPP639Dbz6801q;
        Wed, 23 Mar 2022 05:14:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 22:15:07 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 21:15:07 +0000
Date:   Tue, 22 Mar 2022 21:15:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marek Vasut <marex@denx.de>
CC:     <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ti-ads1015: Switch to read_avail
Message-ID: <20220322211505.000020f1@Huawei.com>
In-Reply-To: <20220320181428.168109-10-marex@denx.de>
References: <20220320181428.168109-1-marex@denx.de>
        <20220320181428.168109-10-marex@denx.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.191]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Mar 2022 19:14:28 +0100
Marek Vasut <marex@denx.de> wrote:

> Replace sysfs attributes with read_avail() callback. This also permits
> removal of ads1115_info, since the scale attribute tables are now part
> of chip data.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> V3: New patch
> ---
>  drivers/iio/adc/ti-ads1015.c | 102 +++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 66431d1445d9b..b1257f65d7431 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -81,6 +81,9 @@ struct ads1015_chip_data {
>  	int				num_channels;
>  	const struct iio_info		*info;
>  	const unsigned int		*data_rate;
Should probably change this to signed.

> +	const unsigned int		data_rate_len;
> +	const unsigned int		*scale;

Why unsigned int given we use it as an array of signed ints?

> +	const unsigned int		scale_len;
>  	bool				has_comparator;
>  };
>  
> @@ -108,10 +111,18 @@ static const unsigned int ads1115_data_rate[] = {
>   * Translation from PGA bits to full-scale positive and negative input voltage
>   * range in mV
>   */
> -static int ads1015_fullscale_range[] = {
> +static const int ads1015_fullscale_range[] = {
Technically unrelated but good fix and not hurting patch readability significantly
so perhaps not worth a separate patch.

>  	6144, 4096, 2048, 1024, 512, 256, 256, 256
>  };
>  
> +static const int ads1015_scale[] = {	/* 12bit ADC */
> +	256, 11, 512, 11, 1024, 11, 2048, 11, 4096, 11, 6144, 11
I wonder if it's worth either using a 2D array and casting
a dimension away, or perhaps just formatting these pair wise
so we can see what is going on more obviously?

I don't feel strongly about this so up to you.

> +};
> +
> +static const int ads1115_scale[] = {	/* 16bit ADC */
> +	256, 15, 512, 15, 1024, 15, 2048, 15, 4096, 15, 6144, 15
> +};

