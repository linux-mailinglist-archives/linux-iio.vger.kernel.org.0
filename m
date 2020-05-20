Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5111DB56C
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETNoa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETNoa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 09:44:30 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468FAC061A0E;
        Wed, 20 May 2020 06:44:29 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d1so1317858qvl.6;
        Wed, 20 May 2020 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3vK3nsBFTUox5VtXfjXHT3m8C9Ys2vrzWellcEOT1UA=;
        b=fWIF3URjdiqbEqnnNsEITEtGMuDoHZJukdB+4gulXXy0hu6od4l6l4n1FWjj+iNu9h
         M+28gRKWO3EWVw0ALS7pP1nE9rLI5f7pM6eqerSXIR3EpX4ZEikYFY4CHGbCjYpf0G6e
         vW/qW2TRCfc8wPB2LijF6j8pa18sEw6U5MPlxAZdL4OAymMEdvb3X305E/W5rEa9CqWt
         KI2o2CoPw6SsOr23dg0XGeN8HVijlmOHndcP8jm9PycsGrpZ8jqEKaWMzu0BurLGIALj
         PMYW8q2ARjuM7CjHvuxHx9l/kUQayoFK7olj0uELaEY1IWoo/IHhIY77ZHUoQp6ZuoKi
         pKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3vK3nsBFTUox5VtXfjXHT3m8C9Ys2vrzWellcEOT1UA=;
        b=iefnIUUvJjjZAA5pOzddaHumMHUpvwfQNmP3N8c2vY6/P5G7hVyjKgR8fvSECAH5LH
         RoUfxvSvZ9H2c4Ne7GD7EvS1CM+RR8I+lhgXUqPQNGCWTFWpY5MqJzjjDxNiJrgujFke
         tFJjt0mu+vyTTKrEJK42k37cIJGpqsqu6PXB5A4/tbvFERT1CT3D4xbTmGOuT2ADHBmV
         BvhWw9DTCZAv/OQuqBd5/EyDHT6Kl5QlqlWa8XLwm0QPNRD9jo0tqjanhkVHR92Ei31/
         ySUu6CSl52Rb+u4JcgTvA2VnRHGMiLaFui3DvQwDWZEXE/iED/j9psROsR79ddxZTp4P
         +99g==
X-Gm-Message-State: AOAM530f2GOsucYGQvYtY+DIGQVHf8p2KQBHqh9Up2d9MWYPJUe0ENfs
        vIDLoPq9PgFPM11GE39SOYg=
X-Google-Smtp-Source: ABdhPJyX9D4tU8jsRgHl5ZmQSrl6CZAtPsiMfgqBGdwxfHZJmZillxmWXIsxInkdJ6RKFMwWzeciZg==
X-Received: by 2002:a0c:9e53:: with SMTP id z19mr4905737qve.47.1589982268293;
        Wed, 20 May 2020 06:44:28 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id i5sm2311091qtp.66.2020.05.20.06.44.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 06:44:27 -0700 (PDT)
Date:   Wed, 20 May 2020 15:44:16 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200520134416.GA6875@ict14-OptiPlex-980>
References: <20200520073125.30808-1-jonathan.albrieux@gmail.com>
 <20200520073125.30808-2-jonathan.albrieux@gmail.com>
 <CAHp75VcWBe=3j68t9pmRk=xigsym_f_EHG4HLLKe_cmQi5E6mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcWBe=3j68t9pmRk=xigsym_f_EHG4HLLKe_cmQi5E6mA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 20, 2020 at 11:23:18AM +0300, Andy Shevchenko wrote:
> On Wed, May 20, 2020 at 10:32 AM Jonathan Albrieux
> <jonathan.albrieux@gmail.com> wrote:
> 
> > +maintainers:
> > +  - can't find a maintainer, author is Laxman Dewangan <ldewangan@nvidia.com>
> 
> Alas, you'll never go forward with this.
> One (easiest way) is to drop this patch completely if you won't be a
> maintainer of the binding.
>

That's too bad. How can I be a maintainer of the binding?

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thank you,
Best regards,
Jonathan Albrieux
