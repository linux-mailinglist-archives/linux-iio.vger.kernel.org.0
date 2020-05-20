Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328931DAB27
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 08:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgETG4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 02:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETG4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 02:56:30 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A24AC061A0E;
        Tue, 19 May 2020 23:56:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so1741088qts.9;
        Tue, 19 May 2020 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TB5FjjudCnoVQlZCNJ7wIvh0DQ8onthhTDmqoaW0vQQ=;
        b=lfnFCgj5KUFNLZCdbrRAbiYgN4J25MNk1LUL2HnYGLen+N2nwKXDuHtH5CJxpWJk1M
         iLDjRZUCxkuaDDAcB2K4tUWGe+EeprYuW9HfUu+QCemg7YTMImD/OF9IPjbBnoYnVKyx
         hfkHtXI68iCtQI8tM270nE9xhucB9ZAg9QZ149HpeFhFVkvaSvTfbMN65We74dhBEl9C
         lDQG9udVbiattf64yOAkZQFcjH1UoKVsV7Kz7mHWGJ2g/yLDADBj1FTeiFFchP50GAPt
         CAQbbqDnjW/+SWwymOrCPmDwpAm5xAzhCVfpCLSVXPg2+2sqk0Xyk2nEtOUrDgS2SOn1
         2qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TB5FjjudCnoVQlZCNJ7wIvh0DQ8onthhTDmqoaW0vQQ=;
        b=LN94G3SkYqcCvRYYJL1QKJfLgRGpkGgx7zCcfUdeH02+IJIHQs/sULP3x9r9ITspns
         JKtuaZJBfTePPT+537bS5FchVahMo0EUEbDtohhk7krXL2PuHa5kED9nWpRxpsNuEV2N
         YbC1RrYh+5ImuOh0tFw30Y/oYF+TXgN1U6+HzsUd8OdM3kKOqck6JESdNj25E1PUx5nV
         lXKtoUyc0LI8Z92a3ONYQ+vuGz8rSFed5PpNYSFXqwLCaywvn04g1xy6efKlvFPoSWNG
         KI4blxeZJJ1fcwCkkfzyVozMzHwzmNOtHt4HXcmN1kVnE3FoKc6X04u3xevaQADFLb3u
         oBKA==
X-Gm-Message-State: AOAM532T+C1E+N+UngyMyB1pWXO/wRfeuOaje45pzrhBUV0PrW9WlXx2
        uH/mayFpyRVLrOT6O+Lu8zU=
X-Google-Smtp-Source: ABdhPJzZGRauvO9SJPW3cGCfiyGEjVM/OHM40naBh5ery73Gai7ADtfx+kYda7Yzt+XEoE2OZ2O4WA==
X-Received: by 2002:ac8:302f:: with SMTP id f44mr3722990qte.121.1589957789285;
        Tue, 19 May 2020 23:56:29 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id l186sm1497247qkf.89.2020.05.19.23.56.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 23:56:28 -0700 (PDT)
Date:   Wed, 20 May 2020 08:56:06 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200520065606.GA3361@ict14-OptiPlex-980>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-2-jonathan.albrieux@gmail.com>
 <20200519132207.GA4623@gerhold.net>
 <20200519140354.GB30573@ict14-OptiPlex-980>
 <20200519160137.GJ1634618@smile.fi.intel.com>
 <20200519164433.GA8726@ict14-OptiPlex-980>
 <20200519183705.000040e5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519183705.000040e5@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 06:37:05PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2020 18:44:33 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > On Tue, May 19, 2020 at 07:01:37PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 19, 2020 at 04:03:54PM +0200, Jonathan Albrieux wrote:  
> > > > On Tue, May 19, 2020 at 03:22:07PM +0200, Stephan Gerhold wrote:  
> > > > > On Tue, May 19, 2020 at 02:43:51PM +0200, Jonathan Albrieux wrote:  
> > > 
> > > ...
> > >   
> > > > > > +maintainers:
> > > > > > +  - can't find a mantainer, author is Laxman Dewangan <ldewangan@nvidia.com>  
> > > > > 
> > > > > Should probably add someone here, although I'm not sure who either.
> > > > >   
> > > > 
> > > > Yep I couldn't find a maintainer for that driver..what to do in this case?  
> > > 
> > > Volunteer yourself!
> > >   
> > 
> > While I'd really like to, I have to decline the offer as I currently don't have
> > enought knowledge to become a maintainer :-) but thank you! (Who knows, maybe in
> > a couple of year!) Now I'll make the final edits and will submit a new
> > patchset soon with all the changes
> 
> Don't be so hard on yourself.  We all get thrown in at the deep end :)
> 
> Note that being a driver maintainer (or even just the binding) really
> just means you get cc'd on the patches and I'll make sure you've had time
> to review them if you wish.   Best of all, if you have hardware (and time)
> being able to test them, that is extremely useful (whether you are
> maintaining the driver or not!) 
> 
> I closely review the majority of stuff that comes through IIO and in
> the case of bindings we also have Rob and co. doing an amazing job.
> We have some excellent additional reviewers who review IIO stuff all the
> time, some of which have reviewed your patch I see.  Without them I'd
> never survive the deluge.
> 
> Of course it's entirely your decision, but I'd definitely encourage you
> to give it a go.
> 
> Thanks,
> 
> Jonathan
> 

Thank you for your encouraging words and for the trust! As a tester I will
be very pleased to give an help on this hardware but as a maintainer I
could contribute little to nothing at the moment and I'm not being hard
with myself but currently I really have to focus on the basic concepts first
and I'm lucky enought to have willing people helping me to do so :-)

Accepting to become the maintainer after the first contribution let me feels
like I'm burning some foundamental stage. I really hope you understand!

> 
> 
> > 
> > > -- 
> > > With Best Regards,
> > > Andy Shevchenko
> > > 
> > >   
> > 
> > Best regards,
> > Jonathan Albrieux
> 
> 

Best regards,
Jonathan Albrieux
