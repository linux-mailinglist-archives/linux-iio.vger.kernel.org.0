Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1645AC5A1
	for <lists+linux-iio@lfdr.de>; Sun,  4 Sep 2022 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiIDRQd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Sep 2022 13:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIDRQc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2022 13:16:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE99733A2F
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 10:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6732B80DF0
        for <linux-iio@vger.kernel.org>; Sun,  4 Sep 2022 17:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB07CC433C1;
        Sun,  4 Sep 2022 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662311789;
        bh=e4kCOEdiN7n3Nn3oHDiolXIiA/dTPJWrR0GEF4+mUvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bs2OycnbIMlNoX9zm91TOJ+RWU6JG948kaPMPJM8aiW3NOAoiypHKwSnnBpimQnrT
         G19hrUeJUkj4a+PVelu2zSJCudyAJrC2J8Dtnye12nsOtn46JuM+04nC0hypn/kizZ
         3NbBRDStv21FUyL6AIXW7AUTQK5ShE+Uj/uNMXL6dXR47+CkJp1WVRitt1tUwrMJw9
         mgCr9fe3u2hydhtPHGnpPe3ka4z53XfCZFb6TxZ1sKMUJVhg2SjG3B9okv4fa+cxHf
         /Io1Ulx9XmyGyZcwh+OvJ/l276IWZ2shpbEYlEeqEj7dP3PAOly1JtZQiVNhJD8Py2
         e4qWjCwu50S9A==
Date:   Sun, 4 Sep 2022 17:42:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Crt Mori <cmo@melexis.com>, <linux-iio@vger.kernel.org>,
        "Paul Cercueil" <paul@crapouillou.net>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/2] iio: temp: mlx90632: Switch form UNVIVERSAL to
 DEFINE_RUNTIME_DEV_PM_OPS()
Message-ID: <20220904174221.3176431a@jic23-huawei>
In-Reply-To: <20220811151834.000061da@huawei.com>
References: <20220807190414.1039028-1-jic23@kernel.org>
        <20220807190414.1039028-3-jic23@kernel.org>
        <CAKv63us-VHQLwAMCbw9wMR=2KXGjWASgkDRVPgMg9zi1oRZmtA@mail.gmail.com>
        <20220811151834.000061da@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Aug 2022 15:18:34 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 8 Aug 2022 13:26:42 +0200
> Crt Mori <cmo@melexis.com> wrote:
> 
> > Not sure if I should apply both but:
> > 
> > Acked-by: Crt Mori <cmo@melexis.com>
> > Tested-by: Crt Mori <cmo@melexis.com>  
> Absolutely.  Both is perfect. Thanks!
Given I forgot to pick this up and your set is moving towards being merged,
I'll not bother with this one.

Jonathan

> > 
> > 
> > On Sun, 7 Aug 2022 at 20:54, Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > The callbacks in this driver are simple and it doesn't matter if
> > > they are unnecessarily called multiple times.  However, we might as
> > > well not repeat the effort if the device is already suspended.
> > > The new DEFINE_RUNTIME_DEV_PM_OPS() has the advantage that we don't
> > > need to mark the callbacks __maybe_unused.  The compiler will still
> > > remove them for us if CONFIG_PM is not set.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Crt Mori <cmo@melexis.com>
> > > ---
> > >  drivers/iio/temperature/mlx90632.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > > index 7ee7ff8047a4..9fc69d099784 100644
> > > --- a/drivers/iio/temperature/mlx90632.c
> > > +++ b/drivers/iio/temperature/mlx90632.c
> > > @@ -952,7 +952,7 @@ static const struct of_device_id mlx90632_of_match[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, mlx90632_of_match);
> > >
> > > -static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> > > +static int mlx90632_pm_suspend(struct device *dev)
> > >  {
> > >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > >         struct mlx90632_data *data = iio_priv(indio_dev);
> > > @@ -960,7 +960,7 @@ static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> > >         return mlx90632_sleep(data);
> > >  }
> > >
> > > -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> > > +static int mlx90632_pm_resume(struct device *dev)
> > >  {
> > >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > >         struct mlx90632_data *data = iio_priv(indio_dev);
> > > @@ -968,14 +968,14 @@ static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> > >         return mlx90632_wakeup(data);
> > >  }
> > >
> > > -static UNIVERSAL_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
> > > -                           mlx90632_pm_resume, NULL);
> > > +static DEFINE_RUNTIME_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
> > > +                                mlx90632_pm_resume, NULL);
> > >
> > >  static struct i2c_driver mlx90632_driver = {
> > >         .driver = {
> > >                 .name   = "mlx90632",
> > >                 .of_match_table = mlx90632_of_match,
> > > -               .pm     = &mlx90632_pm_ops,
> > > +               .pm     = pm_ptr(&mlx90632_pm_ops),
> > >         },
> > >         .probe = mlx90632_probe,
> > >         .remove = mlx90632_remove,
> > > --
> > > 2.37.1
> > >    
> 

