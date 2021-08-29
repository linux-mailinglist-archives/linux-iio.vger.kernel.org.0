Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B63D3FAD2C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhH2QmB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 12:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhH2Qlv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Aug 2021 12:41:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C7FC061575;
        Sun, 29 Aug 2021 09:40:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f22so13029073qkm.5;
        Sun, 29 Aug 2021 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ji321exc53a4JxTUvbkiptwl4tQt4o11O/DIl8Ea0bw=;
        b=YMZnc2V2Y4FQ+/uhBKwsIeyZewJ4seAQpd86JDxoz+Q1Btrbv1z0KVkt2jmRFdPjuW
         EIQhozgo0gMFQQRsijsq8sr/yvZPlD9T8gMW9mwIo2Y2RKOtb1AdXOOVT6BEg2LkR91x
         VNO4cj/lt9QBH5+SxfxeG7m5tBMJPY9BV91gepWTQ5x98tTJjfKuQkWi/Rz+uuJkmeC8
         gb1P8VBUI4t5v8iIfLI1WVaBjY6ZDz1niF/Levavy3qdBy70mqXKlmh84WAxeEHXi6Bv
         JRI/sF01jS+Wj6d+n0/je90SpgNhCIJjQF3Xlv9gfIQFsspPOhO8+HF53PiBsXf68upR
         9N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ji321exc53a4JxTUvbkiptwl4tQt4o11O/DIl8Ea0bw=;
        b=krFn9nzS6z57JjAFqVTXrVRK21ow+hIkLPDux7GrEODQ+1NZYipZyLg2mL1OGly5XU
         45NwVDw7uLeXneKfxBaze4WmxAWO43CaMy7l3iarWzlsA/a+b641azXZby8LW2+Gyd5b
         gXSAs3s4FJnEJwbhhLsssyTYBP5lQ8pjF7whcwVSXEyW7gWHD8vQEszFdO1wIgSPkDKD
         PjX3qtrN5gc230NbDjNuEOPesbggywsYnADtVA16VNjlxh6gFpTxBEIx6wsmOHoKIrDs
         zbkmh+CATmrf0piKXhqVwxA6XRYQJIuH63BpOCU3I0Slq4ZHuUkayUZt+Ry2S9/1GX5g
         evvg==
X-Gm-Message-State: AOAM533BwBgSk9twrVofz4w0j3QUENPOR72dBHyE+MBQ/oAVluv806Dp
        NV6A3HaReULkoLBR9IOWYaNyc3YBSTZ3JQ==
X-Google-Smtp-Source: ABdhPJzJ7cVdZr0gVSwY0tAjzm9+kWfbJH3T7Tawxfe+8cLlvz+xfRo1q6dNwevYPZWVm9+YDgqP1w==
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr18617012qke.30.1630255258513;
        Sun, 29 Aug 2021 09:40:58 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h24sm7162614qtp.63.2021.08.29.09.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 09:40:57 -0700 (PDT)
Date:   Sun, 29 Aug 2021 12:40:55 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <Nuno.Sa@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
Message-ID: <YSu4l9b0e1V3XjOc@shaak>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
 <20210815213309.2847711-4-liambeguin@gmail.com>
 <CAHp75Vd-AfmwMyYyy5ygwmvGfwZLh9VwvBEzSwW3fc99jxFpnQ@mail.gmail.com>
 <CDKXZBW1JDOD.1ZXIT12Y3WK5B@shaak>
 <CAHp75VdC8GFmV-uOHPQpv5q=q0ZwSKFXW6gOL-hK6N4_qS1YJw@mail.gmail.com>
 <CDKYL1RFEMBA.2VURZKBX9F3S@shaak>
 <CAHp75VcUhgpxUE4h3YgYaGAsvHstBzSo9QDwe+D4t264uj_21A@mail.gmail.com>
 <20210829153539.3b2cf037@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829153539.3b2cf037@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 29, 2021 at 03:35:39PM +0100, Jonathan Cameron wrote:
> On Mon, 16 Aug 2021 16:12:58 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Mon, Aug 16, 2021 at 4:07 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > > On Mon Aug 16, 2021 at 8:48 AM EDT, Andy Shevchenko wrote:  
> > > > On Mon, Aug 16, 2021 at 3:39 PM Liam Beguin <liambeguin@gmail.com>
> > > > wrote:  
> > > > > On Mon Aug 16, 2021 at 4:04 AM EDT, Andy Shevchenko wrote:  
> > > > > > On Mon, Aug 16, 2021 at 12:35 AM Liam Beguin <liambeguin@gmail.com>
> > > > > > wrote:  
> > 
> > ...
> > 
> > > > > > > +       tmp = 4096000;
> > > > > > > +       ret = device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);  
> > > > > >  
> > > > > > > +       if (ret < 0 && ret != -EINVAL) {  
> > > > >
> > > > > Hi Andy,
> > > > >  
> > > > > >
> > > > > > What does this check (second part) is supposed to mean?
> > > > > > The first part will make it mandatory, is it the goal?
> > > > > >  
> > > > >
> > > > > device_property_read_u32() will return -EINVAL if the property isn't
> > > > > found in the devicetree.
> > > > >
> > > > > This checks for errors when the property is defined while keeping it
> > > > > optional.  
> > > >
> > > > Don't assign and don't check the error code of the API. As simply as
> > > > that.  
> > >
> > > I'm not against getting rid of it, but I was asked to check for these
> > > errors in earlier revisions of the patch.  
> > 
> > Okay, I leave it to you, guys, to decide, just note that the usual
> > pattern for optional stuff
> > a) either check for (!ret);
> > b) or ignore the returned value completely.
> 

Hi Jonathan,

> Hmm. My thinking (I suspect I asked for it to be checked, but can't remember :)
> was that I'd really like to know if a device tree contains a property but that
> property is invalid for some reason. The docs give a bunch of reasons beyond
> the property not existing (which is unhelpfully described as just 'invalid parameters'). 
> 
> I guess that's a bit far fetched.  Let's drop the check as Andy suggests.
> 

Understood, Thanks for making the change.

Liam

> Dropped that check and applied to the togreg branch of iio.git, initially pushed out
> as testing for 0-day to poke at it.  + we are about to enter merge window so I don't
> want linux-next to pick it up just yet!
> 
> Jonathan
> 
> > 
> > > > > > > +               dev_err(dev, "invalid value for adi,internal-ref-microvolt\n");
> > > > > > > +               return ret;
> > > > > > > +       }  
> > 
> > 
> 
