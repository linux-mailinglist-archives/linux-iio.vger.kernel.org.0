Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF6D5E60AA
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiIVLOO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 22 Sep 2022 07:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiIVLON (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 07:14:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B701EDCEAB
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 04:13:57 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYCFc4pqHz67vBH;
        Thu, 22 Sep 2022 19:08:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 13:13:23 +0200
Received: from localhost (10.81.208.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 12:13:22 +0100
Date:   Thu, 22 Sep 2022 12:13:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5 v3] iio: adc: ti-ads131e08: Silence no spi_device_id
 warnings
Message-ID: <20220922121321.000026ea@huawei.com>
In-Reply-To: <20220922054334.a5t6zdxayx2zwjwd@pengutronix.de>
References: <20220921163620.805879-1-weiyongjun@huaweicloud.com>
        <20220921163620.805879-2-weiyongjun@huaweicloud.com>
        <20220922054334.a5t6zdxayx2zwjwd@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.208.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Sep 2022 07:43:34 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> On Wed, Sep 21, 2022 at 04:36:16PM +0000, Wei Yongjun wrote:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> > 
> > SPI devices use the spi_device_id for module autoloading even on
> > systems using device tree, after commit 5fa6863ba692 ("spi: Check
> > we have a spi_device_id for each DT compatible"), kernel warns as
> > follows since the spi_device_id is missing:
> > 
> > SPI driver ads131e08 has no spi_device_id for ti,ads131e04
> > SPI driver ads131e08 has no spi_device_id for ti,ads131e06
> > 
> > Add spi_device_id entries to silence the warnings, and ensure driver
> > module autoloading works.
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/iio/adc/ti-ads131e08.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> > index 5235a93f28bc..fcfc46254313 100644
> > --- a/drivers/iio/adc/ti-ads131e08.c
> > +++ b/drivers/iio/adc/ti-ads131e08.c
> > @@ -807,6 +807,8 @@ static int ads131e08_probe(struct spi_device *spi)
> >  	int ret;
> >  
> >  	info = device_get_match_data(&spi->dev);
> > +	if (!info)
> > +		info = (void *)spi_get_device_id(spi)->driver_data;  
> 
> I wonder if this hunk is orthogonal to the patch? For the purpose
> mentioned in the commit log it would be enough to skip this hunk and
> don't provide driver_data in ads131e08_ids[] below, wouldn't it?

Maybe need to expand the patch description, but this is needed.
Without it the patch is buggy...

By providing the new table, non firmware registration paths are enabled
that were not before (board files + I think Greybus still uses that path?)
If those are used they will get NULL from device_get_match_data() with
predictable bad results.

Jonathan



> 
> >  	if (!info) {
> >  		dev_err(&spi->dev, "failed to get match data\n");
> >  		return -ENODEV;
> > @@ -926,12 +928,21 @@ static const struct of_device_id ads131e08_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, ads131e08_of_match);
> >  
> > +static const struct spi_device_id ads131e08_ids[] = {
> > +	{ "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },
> > +	{ "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
> > +	{ "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(spi, ads131e08_ids);
> > +
> >  static struct spi_driver ads131e08_driver = {
> >  	.driver = {
> >  		.name = "ads131e08",
> >  		.of_match_table = ads131e08_of_match,
> >  	},
> >  	.probe = ads131e08_probe,
> > +	.id_table = ads131e08_ids,
> >  };
> >  module_spi_driver(ads131e08_driver);  
> 
> Best regards
> Uwe
> 

