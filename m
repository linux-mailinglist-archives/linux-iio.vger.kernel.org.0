Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C5318F39
	for <lists+linux-iio@lfdr.de>; Thu, 11 Feb 2021 16:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBKP4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Feb 2021 10:56:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2550 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBKPxa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Feb 2021 10:53:30 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dc1GK6ZjRz67lvW;
        Thu, 11 Feb 2021 23:47:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 11 Feb 2021 16:52:03 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 15:52:03 +0000
Date:   Thu, 11 Feb 2021 15:51:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        <song.bao.hua@hisilicon.com>, "Rob Herring" <robh+dt@kernel.org>
Subject: Re: [PATCH 20/24] staging:iio:cdc:ad7150: Add of_match_table
Message-ID: <20210211155101.00003bf7@Huawei.com>
In-Reply-To: <CA+U=Dsowq14DJ0Dw7LBpbfeSf8BuqFJiWC12DeasKFB9=LtkhA@mail.gmail.com>
References: <20210207154623.433442-1-jic23@kernel.org>
        <20210207154623.433442-21-jic23@kernel.org>
        <CA+U=Dsowq14DJ0Dw7LBpbfeSf8BuqFJiWC12DeasKFB9=LtkhA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Feb 2021 09:11:21 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Feb 7, 2021 at 5:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Rather than using the fallback path in the i2c subsystem and hoping
> > for no clashes across vendors, lets put in an explicit table for
> > matching.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/staging/iio/cdc/ad7150.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> > index 0bc8c7a99883..33c8a78c076f 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >
> > @@ -655,9 +656,16 @@ static const struct i2c_device_id ad7150_id[] = {
> >
> >  MODULE_DEVICE_TABLE(i2c, ad7150_id);
> >
> > +static const struct of_device_id ad7150_of_match[] = {
> > +       { "adi,ad7150" },
> > +       { "adi,ad7151" },
> > +       { "adi,ad7156" },  
> 
> Is this missing some match_driver_data logic?

Odd though it may seem, we can still use id->driver_data
even though we matched against these ids from the point of view
of probe. 

https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L528
In particular the call of i2c_match_id(driver->id_table, client)
which is passed (buried in client) via of_modalias_node() the
of_device_id string with vendor prefix stripped. 

We could do firmware specific match data logic, but we'd then need
to fallback to the i2c id->driver_data anyway if it failed.

So as things currently stand I think it is better to avoid duplication
of the data and just keep it in the one table.

The disadvantage is that we have to keep the two ID tables in sync.

Jonathan


> Something like this:
> https://patchwork.kernel.org/project/linux-iio/patch/20210207154623.433442-7-jic23@kernel.org/
> ?
> 
> > +       {}
> > +};
> >  static struct i2c_driver ad7150_driver = {
> >         .driver = {
> >                 .name = "ad7150",
> > +               .of_match_table = ad7150_of_match,
> >         },
> >         .probe = ad7150_probe,
> >         .id_table = ad7150_id,
> > --
> > 2.30.0
> >  

