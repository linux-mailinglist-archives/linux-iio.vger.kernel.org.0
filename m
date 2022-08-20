Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03559AD76
	for <lists+linux-iio@lfdr.de>; Sat, 20 Aug 2022 13:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbiHTLaT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Aug 2022 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHTLaR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Aug 2022 07:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474587F114
        for <linux-iio@vger.kernel.org>; Sat, 20 Aug 2022 04:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7415601C6
        for <linux-iio@vger.kernel.org>; Sat, 20 Aug 2022 11:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEEAC433C1;
        Sat, 20 Aug 2022 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660995016;
        bh=mlfJPma2hDp7Q9I5atvaTLFriRaOKxF/lcYTSyOnwkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A+IMnbk/rP6aORGAvJRAgRrdxzm+Faf2Nf6e7xV9ky8o8E7A1ugbt1HMul7QjUfHu
         FpCiHZyx9nUUoeuYG1Zq1kiWBXm1YvY92E2hIxiipFu2vGqDy9eBUb1PUgY2tiJ8+4
         XsXi+Sx7Y0sVDp3GAnwmXwWJoh91xAUad51wYizXll67kmioIaqm18stYLP1fygTMC
         nzDsr9wN2QDDsyknOE3GO3hyYHgtO+GQtvyh+xkImgCmpHbooDBGFT5xjkMpf1S/KV
         OMf8pDAk3iSI+7ZkhyZ6mjUJF9zcleR2LDi40ZHo6Nr9lP6CHReRtp6mcxHWvD+qjX
         8tqv/ec5pHTBA==
Date:   Sat, 20 Aug 2022 12:40:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] iio: adc: rzg2l: Use RUNTIME_PM_OPS() instead of SET_*
Message-ID: <20220820124052.48d6686a@jic23-huawei>
In-Reply-To: <CAHp75VdgcJ96tg-XMHAricQc9Dti3+PKhFiOtSnCn45ehpoxJA@mail.gmail.com>
References: <20220807190712.1039403-1-jic23@kernel.org>
        <CAHp75VfFGUQevM3skOF_wSxSvTTUy98KCDqyOXUhBLpZ6-g4UQ@mail.gmail.com>
        <20220813171303.7b682989@jic23-huawei>
        <CAHp75VdgcJ96tg-XMHAricQc9Dti3+PKhFiOtSnCn45ehpoxJA@mail.gmail.com>
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

On Sun, 14 Aug 2022 22:12:59 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 13, 2022 at 7:02 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 8 Aug 2022 11:34:23 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Sun, Aug 7, 2022 at 9:11 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> > > > Here we could use DEFINE_RUNTIME_DEV_PM_OPS() but that would have the
> > > > side effect of providing suspend and resume support.  That would be
> > > > harmless but also of little purpose as this driver does very simplistic
> > > > power management with synchronous power up and down around individual
> > > > channel reads.
> > > >
> > > > In general these new PM macros avoid the need to mark functions
> > > > __maybe_unused, whilst still allowing the compiler to remove them
> > > > if they are unused.  
> > >
> > > ...
> > >  
> > > >  static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> > > > -       SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> > > > -                          rzg2l_adc_pm_runtime_resume,
> > > > -                          NULL)
> > > > +       RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> > > > +                      rzg2l_adc_pm_runtime_resume,
> > > > +                      NULL)
> > > >  };  
> > >
> > > DEFINE_RUNTIME_DEV_PM_OPS() ?
> > >  
> > Disagreeing with the patch description argument on why I didn't do that?
> > The extra ops set will never have anything to do...  Mostly harmless,
> > but kind of gives the wrong impression of what is going on in this
> > driver.  
> 
> As per thread with Paul, this patch has no function change intentions,
> but also, if tested on hardware, enabling system sleep states
> shouldn't be harmful.
> 

This one is different from that case where there might be side effects.
Here the suspend and resume are (I think) guaranteed to have nothing
to do in all cases - because the driver does synchronous power
up and power down in all paths. So in all cases we are already in runtime
suspended state on a call to suspend.

Joanthan
