Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E531A55AA47
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiFYM7i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiFYM7h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 08:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B2B19012
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 05:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC881612A8
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 12:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6785CC341C6;
        Sat, 25 Jun 2022 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656161976;
        bh=5z56iY7Os1Ac5uuVxhl9VJ087eDsrv/LCNNSpdwro2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xr5efM+KZhWQaYGOzUjZ90zyVzDjbeO1P2PR7UQ5y9io9bNO6/Di5HBqMZI8W+DHA
         HAtwYQb6s+uYd4nZU3Lff5Y21152Fl4Lg4eIWxliQgXE9Su4Bc8xxpPjYMf6Cb3Eke
         tw/h7lz1wIwQOAPHpQG8/ezQh/NPPJuPt/Y9dJxXlfqJNixZ9fjN5DI5H3ZQRxiiwH
         rvay+1zHRc1dN/RWTJ3s9ft62EA6o5FMCq6FNPEtPp/l2xLlmyQns2vADdDPtLCch8
         cSfkpSKFRiDAJDs1Pa7PO+yhsLX6v8E2MgVMmDyc7MlJoI+jXxLXyJ8CvThX2lqAvH
         PA65Iqfexq09w==
Date:   Sat, 25 Jun 2022 14:08:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ismail Kose <ihkose@gmail.com>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 11/36] iio: dac: ds4424: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Message-ID: <20220625140855.757b5fcd@jic23-huawei>
In-Reply-To: <CABEhyf8EezacO8hSCDtz8kDnWeTWFJYBz0XJufjmyprv5u3rmw@mail.gmail.com>
References: <20220621202719.13644-1-jic23@kernel.org>
        <20220621202719.13644-12-jic23@kernel.org>
        <CABEhyf8EezacO8hSCDtz8kDnWeTWFJYBz0XJufjmyprv5u3rmw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jun 2022 11:04:12 -0700
Ismail Kose <ihkose@gmail.com> wrote:

> signed-off
> ismail.
Hi Ismail,

Thanks for taking a look.

As with the other one, please reply with an
Acked-by tag fully stated as that's what we need to apply it to the patch
(and what automated tooling like b4 will be looking for.

Thanks,

Jonathan

> 
> 
> On Tue, Jun 21, 2022 at 1:19 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Using these newer macros allows the compiler to remove the unused
> > structure and functions when !CONFIG_PM_SLEEP + removes the need to
> > mark pm functions __maybe_unused.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Ismail H. Kose <ihkose@gmail.com>
> > ---
> >  drivers/iio/dac/ds4424.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> > index 5a5e967b0be4..509394690bcc 100644
> > --- a/drivers/iio/dac/ds4424.c
> > +++ b/drivers/iio/dac/ds4424.c
> > @@ -171,7 +171,7 @@ static int ds4424_verify_chip(struct iio_dev
> > *indio_dev)
> >         return ret;
> >  }
> >
> > -static int __maybe_unused ds4424_suspend(struct device *dev)
> > +static int ds4424_suspend(struct device *dev)
> >  {
> >         struct i2c_client *client = to_i2c_client(dev);
> >         struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > @@ -189,7 +189,7 @@ static int __maybe_unused ds4424_suspend(struct device
> > *dev)
> >         return ret;
> >  }
> >
> > -static int __maybe_unused ds4424_resume(struct device *dev)
> > +static int ds4424_resume(struct device *dev)
> >  {
> >         struct i2c_client *client = to_i2c_client(dev);
> >         struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > @@ -206,7 +206,7 @@ static int __maybe_unused ds4424_resume(struct device
> > *dev)
> >         return ret;
> >  }
> >
> > -static SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
> > +static DEFINE_SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend,
> > ds4424_resume);
> >
> >  static const struct iio_info ds4424_info = {
> >         .read_raw = ds4424_read_raw,
> > @@ -312,7 +312,7 @@ static struct i2c_driver ds4424_driver = {
> >         .driver = {
> >                 .name   = "ds4424",
> >                 .of_match_table = ds4424_of_match,
> > -               .pm     = &ds4424_pm_ops,
> > +               .pm     = pm_sleep_ptr(&ds4424_pm_ops),
> >         },
> >         .probe          = ds4424_probe,
> >         .remove         = ds4424_remove,
> > --
> > 2.36.1
> >
> >  

