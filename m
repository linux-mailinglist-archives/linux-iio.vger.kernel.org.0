Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED304F63C5
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiDFPtE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Apr 2022 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiDFPs1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2022 11:48:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A44BC585;
        Wed,  6 Apr 2022 06:09:40 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KYPsB5dFhz67sbK;
        Wed,  6 Apr 2022 21:06:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 15:09:04 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 14:09:03 +0100
Date:   Wed, 6 Apr 2022 14:09:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        "Linux PM" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: chemical: scd30: Export dev_pm_ops instead
 of suspend() and resume()
Message-ID: <20220406140902.0000021a@Huawei.com>
In-Reply-To: <CAJZ5v0gUECCmFJoVnmR8SK-pBg5v4QrtLgeKT7VTmgdykuZAzA@mail.gmail.com>
References: <20220401140605.31871-1-Jonathan.Cameron@huawei.com>
        <20220401140605.31871-2-Jonathan.Cameron@huawei.com>
        <CAJZ5v0gUECCmFJoVnmR8SK-pBg5v4QrtLgeKT7VTmgdykuZAzA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Apr 2022 20:19:11 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Apr 1, 2022 at 4:06 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Whilst here move to the new infrastructure using pm_sleep_ptr()
> > and EXPORT_DEV_PM_OPS() so as to let the compiler remove the unused
> > code if CONFIG_SLEEP is not defined.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---
> >  drivers/iio/chemical/scd30.h        | 5 +----
> >  drivers/iio/chemical/scd30_core.c   | 8 ++++----
> >  drivers/iio/chemical/scd30_i2c.c    | 2 +-
> >  drivers/iio/chemical/scd30_serial.c | 2 +-
> >  4 files changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/scd30.h b/drivers/iio/chemical/scd30.h
> > index f60127bfe0f4..1ac9f3f79271 100644
> > --- a/drivers/iio/chemical/scd30.h
> > +++ b/drivers/iio/chemical/scd30.h
> > @@ -68,10 +68,7 @@ struct scd30_state {
> >         scd30_command_t command;
> >  };
> >
> > -int scd30_suspend(struct device *dev);
> > -int scd30_resume(struct device *dev);
> > -
> > -static __maybe_unused SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
> > +extern const struct dev_pm_ops scd30_pm_ops;
> >
> >  int scd30_probe(struct device *dev, int irq, const char *name, void *priv, scd30_command_t command);
> >
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> > index 9fe6bbe9ee04..6c6c11c2772a 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -517,7 +517,7 @@ static const struct iio_chan_spec scd30_channels[] = {
> >         IIO_CHAN_SOFT_TIMESTAMP(3),
> >  };
> >
> > -int __maybe_unused scd30_suspend(struct device *dev)
> > +static int scd30_suspend(struct device *dev)
> >  {
> >         struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >         struct scd30_state *state  = iio_priv(indio_dev);
> > @@ -529,9 +529,8 @@ int __maybe_unused scd30_suspend(struct device *dev)
> >
> >         return regulator_disable(state->vdd);
> >  }
> > -EXPORT_SYMBOL(scd30_suspend);
> >
> > -int __maybe_unused scd30_resume(struct device *dev)
> > +static int scd30_resume(struct device *dev)
> >  {
> >         struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >         struct scd30_state *state = iio_priv(indio_dev);
> > @@ -543,7 +542,8 @@ int __maybe_unused scd30_resume(struct device *dev)
> >
> >         return scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
> >  }
> > -EXPORT_SYMBOL(scd30_resume);
> > +
> > +EXPORT_SIMPLE_DEV_PM_OPS(scd30_pm_ops, scd30_suspend, scd30_resume);
> >
> >  static void scd30_stop_meas(void *data)
> >  {
> > diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
> > index 875892a070ee..7c332e4e8e46 100644
> > --- a/drivers/iio/chemical/scd30_i2c.c
> > +++ b/drivers/iio/chemical/scd30_i2c.c
> > @@ -128,7 +128,7 @@ static struct i2c_driver scd30_i2c_driver = {
> >         .driver = {
> >                 .name = KBUILD_MODNAME,
> >                 .of_match_table = scd30_i2c_of_match,
> > -               .pm = &scd30_pm_ops,
> > +               .pm = pm_sleep_ptr(&scd30_pm_ops),
> >         },
> >         .probe_new = scd30_i2c_probe,
> >  };
> > diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
> > index 568b34486c44..8664f3ce6b33 100644
> > --- a/drivers/iio/chemical/scd30_serial.c
> > +++ b/drivers/iio/chemical/scd30_serial.c
> > @@ -252,7 +252,7 @@ static struct serdev_device_driver scd30_serdev_driver = {
> >         .driver = {
> >                 .name = KBUILD_MODNAME,
> >                 .of_match_table = scd30_serdev_of_match,
> > -               .pm = &scd30_pm_ops,
> > +               .pm = pm_sleep_ptr(&scd30_pm_ops),
> >         },
> >         .probe = scd30_serdev_probe,
> >  };
> > --  
> 
> Applied as 5.19 material along with the [2-3/3].
> 
> Please let me know if you need a non-mutable branch to pull from in
> order to base other work on these commits.

Yes please.  A non-mutable branch would be great.

Thanks,

Jonathan

> 
> Thanks!

