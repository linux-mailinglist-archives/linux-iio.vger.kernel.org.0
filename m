Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6155AA43
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiFYM6L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiFYM6H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 08:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3A5580
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 05:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B8D61167
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 12:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2176FC3411C;
        Sat, 25 Jun 2022 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656161881;
        bh=coh9xwwrMismVks+snj/hNHnXKS1pN8Zs2dPSVuYK0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TMFP3KNNJrL5KsWl8ZH2EiP4Gq0iygRrN6DSed+zxH8iKxmbgLfk2s8bvdfzMR4VO
         qQCZzMwRIiQYxp3lS54w/DPYR3SkuOYItLpRjQw/AI9Tx/6n++AkEDte3YyYEMVFTh
         Ph4KurMnQ3r4C0YCW4BWNUGnUM7xK5DFmXdMnQWMo7xCN5gE3PNPwSGht2g6ZoiACR
         XylvsSIN6VIzhdZr8QVks3zR3QAAIy4VpFeIqXcZq/m7eUBpOgwfA6WVbfqYrv4QWT
         bAiONWZAGRjOEQjLsUpGh3RcEc1EhwP7jtnFY3Yajk1DBcZV95X5suaMd070aFMChA
         7zqz6FtX4rZLA==
Date:   Sat, 25 Jun 2022 14:07:22 +0100
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
Subject: Re: [PATCH 14/36] iio: dac: max5821: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Message-ID: <20220625140722.39ed5e48@jic23-huawei>
In-Reply-To: <CABEhyf-N-hi7z3SQK4FRWyztwJ=3t17NZT-gGCEugQhUkpcZQA@mail.gmail.com>
References: <20220621202719.13644-1-jic23@kernel.org>
        <20220621202719.13644-15-jic23@kernel.org>
        <CABEhyf-N-hi7z3SQK4FRWyztwJ=3t17NZT-gGCEugQhUkpcZQA@mail.gmail.com>
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

On Thu, 23 Jun 2022 10:58:30 -0700
Ismail Kose <ihkose@gmail.com> wrote:

> Signed-off
> ismail

Tag for this would be
Acked-by
as you aren't involved in the sign of chain for this one, rather you
are reviewing.

If you can confirm that it would be much appreciated.
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
> > Cc: Philippe Reynes <tremyfr@yahoo.fr>
> > ---
> >  drivers/iio/dac/max5821.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> > index 540f9ea7cada..e001b594d5b1 100644
> > --- a/drivers/iio/dac/max5821.c
> > +++ b/drivers/iio/dac/max5821.c
> > @@ -267,7 +267,7 @@ static int max5821_write_raw(struct iio_dev *indio_dev,
> >         }
> >  }
> >
> > -static int __maybe_unused max5821_suspend(struct device *dev)
> > +static int max5821_suspend(struct device *dev)
> >  {
> >         u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
> >                          MAX5821_EXTENDED_DAC_A |
> > @@ -277,7 +277,7 @@ static int __maybe_unused max5821_suspend(struct
> > device *dev)
> >         return i2c_master_send(to_i2c_client(dev), outbuf, 2);
> >  }
> >
> > -static int __maybe_unused max5821_resume(struct device *dev)
> > +static int max5821_resume(struct device *dev)
> >  {
> >         u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
> >                          MAX5821_EXTENDED_DAC_A |
> > @@ -287,7 +287,8 @@ static int __maybe_unused max5821_resume(struct device
> > *dev)
> >         return i2c_master_send(to_i2c_client(dev), outbuf, 2);
> >  }
> >
> > -static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
> > +static DEFINE_SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend,
> > +                               max5821_resume);
> >
> >  static const struct iio_info max5821_info = {
> >         .read_raw = max5821_read_raw,
> > @@ -374,7 +375,7 @@ static struct i2c_driver max5821_driver = {
> >         .driver = {
> >                 .name   = "max5821",
> >                 .of_match_table = max5821_of_match,
> > -               .pm     = &max5821_pm_ops,
> > +               .pm     = pm_sleep_ptr(&max5821_pm_ops),
> >         },
> >         .probe          = max5821_probe,
> >         .id_table       = max5821_id,
> > --
> > 2.36.1
> >
> >  

