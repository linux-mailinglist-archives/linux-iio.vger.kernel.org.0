Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1539D1D80FA
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgERRns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 13:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgERRnr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 13:43:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1C4C061A0C;
        Mon, 18 May 2020 10:43:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so12818648wrp.12;
        Mon, 18 May 2020 10:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OHAAyO0W2XsNLLS4j8T1nBDjeOOazd8u5B0nFYGpWJQ=;
        b=BrvcABYiv83eYdE9kaIBawPuXjcgsvPkrJBjlmIZxpEEFYC7lxAprLa97ClPV9zGaQ
         5Yrn5O0sPbpYIEGLXawkDvIjkI1VjqNlBk2CAhgUUt4UW38ZVRt4xMmaYt8pcr/35aUc
         JVZR1K2MwB+TLMkTwz8tDgq9w6DBvS2AfCE1fZMZ+WULzvposjYVV49xwmF/1ZyRsxeW
         S0Aqc/JN/2n5iTzNlWMydj4aMkfrtY6C6cWTm1CPp/c/OWe8KdiO0KfgimwF1cLJYCb4
         /UAFmb7WY9XfWMxPO5tzLmSVLPu1JYPJxBBx7+EaOnoApnK/F6ma3IH+xpW6NNjDqEQh
         7N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OHAAyO0W2XsNLLS4j8T1nBDjeOOazd8u5B0nFYGpWJQ=;
        b=a60k7d16Rx/JM9sEHoIeMtBjb0oucxBrU6J0/LwQuB8ezdsKXqIXgUTa2kt4fp+/Sq
         TA+zh2fUJL7/yGxABJedHUuekULCRMXP+rjvEGhq6MNDHh7n6EUaeA52qsbCI66hGTHW
         CC3OwmUTCBhhmSjnMKnuwB8oUKoijeI9u8jWt0j75WN9jMZYOBQ5Fbp8KS88EjLNlrj+
         96iMNOTE/DZotmBaFb37L9vt+yABrZQHrAaHmmIEZih3zLBPSfRH9Yl1aRsyF1YlrhHQ
         NTzV7C/8fcs/lIr6rFJkFnBFJrSX1A4CQigIKXhsxZd9k9R2Ik6oaXz1ui9W5bHcyEGl
         quHw==
X-Gm-Message-State: AOAM532Fw3ttxicufxNvBeVm8VpT6IR/StSTq7D+yJPI2dJ9nm6YdG4t
        lJlEd5BgZTfwf3MioJw5H+g=
X-Google-Smtp-Source: ABdhPJySEx6eVHpcSMmLvOS6v6+mWHZOufi95+CGyDrRxcC41LHxo2+wpoZQqfq21qvjsbrPkACr5g==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr20662433wrv.310.1589823825235;
        Mon, 18 May 2020 10:43:45 -0700 (PDT)
Received: from jonathan-N53SV ([151.81.99.112])
        by smtp.gmail.com with ESMTPSA id u74sm397237wmu.13.2020.05.18.10.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 10:43:44 -0700 (PDT)
Date:   Mon, 18 May 2020 19:43:35 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200518174335.GA6392@jonathan-N53SV>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
 <20200518133645.19127-4-jonathan.albrieux@gmail.com>
 <CAHp75VdFJUNOtRyCNEGnvoOCZYoPvyhjC15_iC72JD-1sOavwA@mail.gmail.com>
 <20200518160120.GA21361@ict14-OptiPlex-980>
 <20200518164317.GL1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518164317.GL1634618@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 07:43:17PM +0300, Andy Shevchenko wrote:
> On Mon, May 18, 2020 at 06:01:20PM +0200, Jonathan Albrieux wrote:
> > On Mon, May 18, 2020 at 05:55:51PM +0300, Andy Shevchenko wrote:
> > > On Mon, May 18, 2020 at 4:38 PM Jonathan Albrieux
> > > <jonathan.albrieux@gmail.com> wrote:
> > > 
> > > > +       gpiod_set_value_cansleep(data->reset_gpiod, 1);
> > > 
> > > (1)
> > > 
> > > ...
> > > 
> > > > +       /*
> > > > +        * If reset pin is provided then will be set to high on power on
> > > > +        * and to low on power off according to AK09911 datasheet
> > > > +        */
> > > 
> > > Wording is confusing, perhaps you have to use 'asserted / deasserted'.
> > 
> > Thank you for the suggestion, I'll be working on rewording as soon as
> > possible.
> > 
> > > Btw, in (1) it's also "high" (asserted). I barely understand how it's
> > > supposed to work in all cases?
> > > 
> > > > +       reset_gpiod = devm_gpiod_get_optional(&client->dev,
> > > > +                                             "reset", GPIOD_OUT_HIGH);
> > > > +       if (IS_ERR(reset_gpiod))
> > > > +               return PTR_ERR(reset_gpiod);
> > > 
> > 
> > I'm sorry but I'm not sure about what you mean by saying all cases.
> > Currently  I'm testing this driver on a msm8916 device having AK09911
> > magnetometer. At the current stage the driver is failing on probe 
> > because reset pin is not connected to VID (as datasheet requires in case
> > of pin not being used). In case of reset pin not asserted, register's
> > reset is triggered resulting in empty registers, leading to probe fail.
> > For this reason pin is asserted during power on in order to have 
> > informations in registers and deasserted before power off triggering
> > a reset.
> > 
> > A workaround that gets AK09911 working on device is by setting the
> > reset pin always high on device tree. This way registers gets reset by
> > a Power On Reset circuit autonomously and reset pin never triggers the
> > reset.
> 
> You need to distinguish electrical level from logical (GPIO flag defines
> logical). So, I'm talking about active-high vs. active-low case.
> 
> Now I re-read above, and see that here you assert the reset signal. But where
> is desertion?

Oh I see, I'll try explaining by points the proposed approach:
- reset pin is active low
- during power on gpio is set to 0 so the reset pin is high, thus no reset
- during power off gpio is set to 1 so the reset pin becomes low, thus resetting

this is a possible solution but maybe there are other ways to achieve that, 
do you have suggestions on how to get a better approach for solving this issue?

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Jonathan Albrieux
