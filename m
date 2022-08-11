Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2533D58FE27
	for <lists+linux-iio@lfdr.de>; Thu, 11 Aug 2022 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiHKOSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Aug 2022 10:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiHKOSk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Aug 2022 10:18:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4869E6E2D3
        for <linux-iio@vger.kernel.org>; Thu, 11 Aug 2022 07:18:39 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M3TS76DdGz688Z6;
        Thu, 11 Aug 2022 22:18:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 11 Aug 2022 16:18:36 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 11 Aug
 2022 15:18:35 +0100
Date:   Thu, 11 Aug 2022 15:18:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Crt Mori <cmo@melexis.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Paul Cercueil" <paul@crapouillou.net>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/2] iio: temp: mlx90632: Switch form UNVIVERSAL to
 DEFINE_RUNTIME_DEV_PM_OPS()
Message-ID: <20220811151834.000061da@huawei.com>
In-Reply-To: <CAKv63us-VHQLwAMCbw9wMR=2KXGjWASgkDRVPgMg9zi1oRZmtA@mail.gmail.com>
References: <20220807190414.1039028-1-jic23@kernel.org>
        <20220807190414.1039028-3-jic23@kernel.org>
        <CAKv63us-VHQLwAMCbw9wMR=2KXGjWASgkDRVPgMg9zi1oRZmtA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Aug 2022 13:26:42 +0200
Crt Mori <cmo@melexis.com> wrote:

> Not sure if I should apply both but:
> 
> Acked-by: Crt Mori <cmo@melexis.com>
> Tested-by: Crt Mori <cmo@melexis.com>
Absolutely.  Both is perfect. Thanks!
> 
> 
> On Sun, 7 Aug 2022 at 20:54, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The callbacks in this driver are simple and it doesn't matter if
> > they are unnecessarily called multiple times.  However, we might as
> > well not repeat the effort if the device is already suspended.
> > The new DEFINE_RUNTIME_DEV_PM_OPS() has the advantage that we don't
> > need to mark the callbacks __maybe_unused.  The compiler will still
> > remove them for us if CONFIG_PM is not set.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Crt Mori <cmo@melexis.com>
> > ---
> >  drivers/iio/temperature/mlx90632.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index 7ee7ff8047a4..9fc69d099784 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -952,7 +952,7 @@ static const struct of_device_id mlx90632_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, mlx90632_of_match);
> >
> > -static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> > +static int mlx90632_pm_suspend(struct device *dev)
> >  {
> >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >         struct mlx90632_data *data = iio_priv(indio_dev);
> > @@ -960,7 +960,7 @@ static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> >         return mlx90632_sleep(data);
> >  }
> >
> > -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> > +static int mlx90632_pm_resume(struct device *dev)
> >  {
> >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >         struct mlx90632_data *data = iio_priv(indio_dev);
> > @@ -968,14 +968,14 @@ static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> >         return mlx90632_wakeup(data);
> >  }
> >
> > -static UNIVERSAL_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
> > -                           mlx90632_pm_resume, NULL);
> > +static DEFINE_RUNTIME_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
> > +                                mlx90632_pm_resume, NULL);
> >
> >  static struct i2c_driver mlx90632_driver = {
> >         .driver = {
> >                 .name   = "mlx90632",
> >                 .of_match_table = mlx90632_of_match,
> > -               .pm     = &mlx90632_pm_ops,
> > +               .pm     = pm_ptr(&mlx90632_pm_ops),
> >         },
> >         .probe = mlx90632_probe,
> >         .remove = mlx90632_remove,
> > --
> > 2.37.1
> >  

