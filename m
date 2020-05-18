Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E961D7DB0
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 18:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgERQCB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQCA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 12:02:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C2C061A0C;
        Mon, 18 May 2020 09:01:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so12501818wrt.9;
        Mon, 18 May 2020 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9SSAcWWQEWD0r3Pko5lkNYBqf2cJb3ilW4xHvkzbc9I=;
        b=MArjN6+oacAwZQGLd8doq6gdFJ0WT4Kb25b+spk8eQpNEELJfKBkAiwG9HaZYt3kfV
         n5AZKmlkj/DXuI/Rc0m4dWo4+ZJKH2LZVXZuQbQ735O0LaMitBaRTdBV3Bd7Fkjw8HoR
         oRAFfSozNAKRNaKSL+j2nIDT4rV0zp0IFfAgnr3Z6rO6qoVDjDcRDgpJVTwSf1WxUFHm
         Kdx0yV0GVZI52ulLcFDWl7DU1qRHEoRbMugSprRMnJj2p5jM9INfkX8ZnDYDjqcKBuVk
         MavDletV6NJe2uUYog3u/jaK+4wROkr7iDFVoOivj4Rf152ZddwNy7kbAK2qGrSKKmr6
         TVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9SSAcWWQEWD0r3Pko5lkNYBqf2cJb3ilW4xHvkzbc9I=;
        b=kwcyc+aff9wNLHOjU71gZzW7NA4JpBM4X8mplckvG+cwVtJiomBgtX8ujFqHLdSHdg
         xrHuZqXaIIieY0xi9W1EGG6TrEhL2LtWCP085XMirkJ7Dov539gfV+tWr37b+lQWtQM9
         HTLNB9jFpg5h0l96tRKCVTao5ha+7XC18lgAu1LQ67tOCrnL5+VME8ZmhxV8wmbP6k2G
         tVqA/xNOanJaomG3GHWq1O2FgMbP9A6aNiIDMvPa2oeUqQI6iexI3MD1z800rTFFDATq
         CivKJ0bhrk+sL26KZFBPJysl4HT4Tnp49gYzjFb9uPAiqb/5617coxMW8yJxOSLZRfV4
         ERPQ==
X-Gm-Message-State: AOAM533zfXtoREVUE3kGfUb47qd50xyuofyb+OfZ3FJFVW08foQpuosf
        44nX1eLNiGjzRQi/NSPVjBg=
X-Google-Smtp-Source: ABdhPJxlB/26iS1Qh1s66tzdQo+jkzTvK0fB4tNlbfmbOIrBYS3GZJGvXhEyqbh9cO61i0owgfIf9A==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr20601532wrm.364.1589817718065;
        Mon, 18 May 2020 09:01:58 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id q5sm18237471wra.36.2020.05.18.09.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 09:01:56 -0700 (PDT)
Date:   Mon, 18 May 2020 18:01:20 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200518160120.GA21361@ict14-OptiPlex-980>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
 <20200518133645.19127-4-jonathan.albrieux@gmail.com>
 <CAHp75VdFJUNOtRyCNEGnvoOCZYoPvyhjC15_iC72JD-1sOavwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdFJUNOtRyCNEGnvoOCZYoPvyhjC15_iC72JD-1sOavwA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 05:55:51PM +0300, Andy Shevchenko wrote:
> On Mon, May 18, 2020 at 4:38 PM Jonathan Albrieux
> <jonathan.albrieux@gmail.com> wrote:
> 
> > +       gpiod_set_value_cansleep(data->reset_gpiod, 1);
> 
> (1)
> 
> ...
> 
> > +       /*
> > +        * If reset pin is provided then will be set to high on power on
> > +        * and to low on power off according to AK09911 datasheet
> > +        */
> 
> Wording is confusing, perhaps you have to use 'asserted / deasserted'.

Thank you for the suggestion, I'll be working on rewording as soon as
possible.

> Btw, in (1) it's also "high" (asserted). I barely understand how it's
> supposed to work in all cases?
> 
> > +       reset_gpiod = devm_gpiod_get_optional(&client->dev,
> > +                                             "reset", GPIOD_OUT_HIGH);
> > +       if (IS_ERR(reset_gpiod))
> > +               return PTR_ERR(reset_gpiod);
> 

I'm sorry but I'm not sure about what you mean by saying all cases.
Currently  I'm testing this driver on a msm8916 device having AK09911
magnetometer. At the current stage the driver is failing on probe 
because reset pin is not connected to VID (as datasheet requires in case
of pin not being used). In case of reset pin not asserted, register's
reset is triggered resulting in empty registers, leading to probe fail.
For this reason pin is asserted during power on in order to have 
informations in registers and deasserted before power off triggering
a reset.

A workaround that gets AK09911 working on device is by setting the
reset pin always high on device tree. This way registers gets reset by
a Power On Reset circuit autonomously and reset pin never triggers the
reset.

> -- 
> With Best Regards,
> Andy Shevchenko

Hoping to having answered to your question,
Best regards,
Jonathan Albrieux
