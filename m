Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2A95FF0FD
	for <lists+linux-iio@lfdr.de>; Fri, 14 Oct 2022 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJNPSc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Oct 2022 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJNPS3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2022 11:18:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482B1D3C60;
        Fri, 14 Oct 2022 08:18:27 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mpqkl1JDxz6802C;
        Fri, 14 Oct 2022 23:17:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 17:18:25 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:18:25 +0100
Date:   Fri, 14 Oct 2022 16:18:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
CC:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH 1/3] iio: temperature: ltc2983: allocate iio channels
 once
Message-ID: <20221014161824.00001ca2@huawei.com>
In-Reply-To: <20221014151123.00003268@huawei.com>
References: <20221014123724.1401011-1-demonsingur@gmail.com>
        <20221014123724.1401011-2-demonsingur@gmail.com>
        <20221014151123.00003268@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Fri, 14 Oct 2022 15:11:47 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 14 Oct 2022 15:37:22 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > 
> > Currently, every time the device wakes up from sleep, the
> > iio_chan array is reallocated, leaking the previous one
> > until the device is removed (basically never).
> > 
> > Move the allocation to the probe function to avoid this.
> > 
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>  
> Hi Cosmin,
> 
> Please give a fixes tag for this one as we'll definitely want to
> backport it.
> 
> Reply to this patch is fine as b4 will pick it up like any other tag.
Fixes: f110f3188e563 ("iio: temperature: Add support for LTC2983")

(from direct mail)

> 
> > ---
> >  drivers/iio/temperature/ltc2983.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > index b652d2b39bcf..a60ccf183687 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -1385,13 +1385,6 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> >  		return ret;
> >  	}
> >  
> > -	st->iio_chan = devm_kzalloc(&st->spi->dev,
> > -				    st->iio_channels * sizeof(*st->iio_chan),
> > -				    GFP_KERNEL);
> > -
> > -	if (!st->iio_chan)
> > -		return -ENOMEM;
> > -
> >  	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
> >  				 LTC2983_NOTCH_FREQ_MASK,
> >  				 LTC2983_NOTCH_FREQ(st->filter_notch_freq));
> > @@ -1514,6 +1507,12 @@ static int ltc2983_probe(struct spi_device *spi)
> >  		gpiod_set_value_cansleep(gpio, 0);
> >  	}
> >  
> > +	st->iio_chan = devm_kzalloc(&spi->dev,
> > +				    st->iio_channels * sizeof(*st->iio_chan),
> > +				    GFP_KERNEL);
> > +	if (!st->iio_chan)
> > +		return -ENOMEM;
> > +
> >  	ret = ltc2983_setup(st, true);
> >  	if (ret)
> >  		return ret;  
> 
> 

