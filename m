Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FF591BD7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 18:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiHMQCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiHMQCi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 12:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7159BE27
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 09:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4075560ED3
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 16:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072C2C433C1;
        Sat, 13 Aug 2022 16:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406555;
        bh=Xf6ReF9OVisF0V3ECIek/mGH+9zCH7obSMxQDFxwb3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PX3o/SxWoKqxRoegn1fy7gWv00EGRo+qQjEOcw7uOAy7xBmFC93alwKAf6osLBv9F
         jCxs9UCmnyu3vswAJwEOsmK4Ghp35kTuKXF/HDHuifesdOJNZTy1mVG6+qoYMrabon
         2VWZeVqHpuzrTMsYB/HOuoMnQelN5wm/ICdOT09peY7T8PS2Hs436YhRGTAWQeecMP
         9TPcPNovANGrSzD+x8Z3VePhxRxTrLNQgXFYO6rMNOObKANDh1n7GnLmg9P2Br3sEO
         VnOefMe5yGuKN99uYXtQygOqVc6vYJXUfzTAt7P6t2lPBCdDNSr4kqX8mZ7GYPoAWf
         jG8wBT+knZ/yA==
Date:   Sat, 13 Aug 2022 17:13:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] iio: adc: rzg2l: Use RUNTIME_PM_OPS() instead of SET_*
Message-ID: <20220813171303.7b682989@jic23-huawei>
In-Reply-To: <CAHp75VfFGUQevM3skOF_wSxSvTTUy98KCDqyOXUhBLpZ6-g4UQ@mail.gmail.com>
References: <20220807190712.1039403-1-jic23@kernel.org>
        <CAHp75VfFGUQevM3skOF_wSxSvTTUy98KCDqyOXUhBLpZ6-g4UQ@mail.gmail.com>
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

On Mon, 8 Aug 2022 11:34:23 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 7, 2022 at 9:11 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Here we could use DEFINE_RUNTIME_DEV_PM_OPS() but that would have the
> > side effect of providing suspend and resume support.  That would be
> > harmless but also of little purpose as this driver does very simplistic
> > power management with synchronous power up and down around individual
> > channel reads.
> >
> > In general these new PM macros avoid the need to mark functions
> > __maybe_unused, whilst still allowing the compiler to remove them
> > if they are unused.  
> 
> ...
> 
> >  static const struct dev_pm_ops rzg2l_adc_pm_ops = {
> > -       SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> > -                          rzg2l_adc_pm_runtime_resume,
> > -                          NULL)
> > +       RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
> > +                      rzg2l_adc_pm_runtime_resume,
> > +                      NULL)
> >  };  
> 
> DEFINE_RUNTIME_DEV_PM_OPS() ?
> 
Disagreeing with the patch description argument on why I didn't do that?
The extra ops set will never have anything to do...  Mostly harmless,
but kind of gives the wrong impression of what is going on in this
driver.

Jonathan

