Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C273DDD3E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhHBQJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 12:09:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3560 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHBQJh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 12:09:37 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gdjcb3Z1yz6BBjB;
        Tue,  3 Aug 2021 00:09:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:09:26 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 17:09:25 +0100
Date:   Mon, 2 Aug 2021 17:08:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Rodolfo Giometti <giometti@enneenne.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/1] iio adc: add driver for Texas Instruments TLA2528
 adc
Message-ID: <20210802170858.0000531e@Huawei.com>
In-Reply-To: <CA+U=DsqHcrXWi5TF=6gsuU8f3muMThJG1BTNQXov1KWbsdGkFw@mail.gmail.com>
References: <20210802130441.972978-1-giometti@enneenne.com>
        <20210802130441.972978-2-giometti@enneenne.com>
        <CA+U=DsqHcrXWi5TF=6gsuU8f3muMThJG1BTNQXov1KWbsdGkFw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


...

> > +
> > +static int tla2528_probe(struct i2c_client *client,
> > +                        const struct i2c_device_id *id)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct tla2528_st *st;
> > +       int ret;
> > +
> > +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> > +                                    I2C_FUNC_SMBUS_WRITE_BYTE))
> > +               return -EOPNOTSUPP;
> > +
> > +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       st = iio_priv(indio_dev);
> > +       i2c_set_clientdata(client, indio_dev);
> > +       st->client = client;
> > +
> > +       indio_dev->name = id->name;
> > +       indio_dev->info = &tla2528_info;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +       indio_dev->channels = tla2528_channel;
> > +       indio_dev->num_channels = ARRAY_SIZE(tla2528_channel);
> > +
> > +       st->ref = devm_regulator_get(&client->dev, "vref");
> > +       if (IS_ERR(st->ref))
> > +               return PTR_ERR(st->ref);
> > +
> > +       ret = regulator_enable(st->ref);
> > +       if (ret < 0)
> > +               return ret;
> > +  
> 
> I was thinking about whether to mention this earlier.
> But, an idea, is to do:
> 
>         ret = devm_add_action_or_reset(&spi->dev, tla2528_reg_disable,
> st->vref);
>         if (ret)
>                 return ret;
> 
> Then the i2c_set_clientdata() call can be removed, and the
> tla2528_remove() hook as well.
> A simple example can be seen in drivers/iio/adc/ti-ads8344.c
> 
> I'm not insisting on it. Since the driver is simple enough.

I'd prefer this, because otherwise someone will come along and change
it later creating more patches for me to review :)

Jonathan

