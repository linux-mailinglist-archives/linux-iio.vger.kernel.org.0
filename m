Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F91248EB4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRTa0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHRTaX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2020 15:30:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A887C061389;
        Tue, 18 Aug 2020 12:30:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f26so22719213ljc.8;
        Tue, 18 Aug 2020 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rPPnDufFdYrGPA1nsHLUw/AvqpK5ENwF2dGNkDul8PU=;
        b=DV3V1dGMGlTyDIPW77LGUHfsOuddUzK/QEK6Z1InNc20uLgwHC5W8Xz8V/6m3/KkC5
         RnLmvxeD7QQvqQAQxwFP/I5LC+r412q7S9yyrsdM9zEqLw28Trd99Xvgv5RL97ukzhum
         /CMoPvMCA/qxfXkZv2qjx/kLKLLMN4mCUr40AXZ7qRHv/79KCtX5cVVknm+23wMwiSSH
         d1Wp+b6Urh0pEL+A6BR/rQGBq3fh4vlZ3m2STk7sFMNDz0OuCghtuRVoblO+WKJ8N8tq
         KtJrW0bs104Ui3M7szGa+KXM4kO4p7TXbAzo0tFcYVkNJUzFFnwNpQqyqM0tD0mQbB51
         FBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPPnDufFdYrGPA1nsHLUw/AvqpK5ENwF2dGNkDul8PU=;
        b=b7Qx2Hc8j2avn9HAWkXTPrNyn7/0RrajjYT0sItuBz0VNO+Lv7BAtMhCpFEnG+X3Pu
         NH69UVfNH5WBH6kX7eJ7Flo5yEX//p8pyG1dgI3mTyQ6/E6eZAs7FyikIptQMvpzradT
         UiCrpZSnuAhz6JZc+MaAm/1nPVfXDa5DWS9g6OdWMTOSf8+cnkCTGpkQ/tYc5JHuBG3F
         GfHt+NZY1sY4/QN3D1XxKO3AVuC1LYvM0u7s4yyM4aJ89NCHlAy1ZUPSOt+DNNHFKHmb
         kRwXoyumAr1XX7NGAJH8+DubxomPGAhq8pnXAvX9Ix3dtN1BtoS8IgbX+9Mk0PgQbc9w
         K4ZQ==
X-Gm-Message-State: AOAM533ToDmhkjNRVY1E/jH5OFEL3PRvApBSjTmP2aRmvn+WpTJAtKNg
        9YZVHWsUfBliq1baX1cnAqM=
X-Google-Smtp-Source: ABdhPJyqvpAh0sZAgkzYo/NZ1B7oSlm4TG5zBof9Mty4QbMcBihJyDUj2gcqsp5/NGX8bm0ShVn+9w==
X-Received: by 2002:a2e:9047:: with SMTP id n7mr11160392ljg.125.1597779021514;
        Tue, 18 Aug 2020 12:30:21 -0700 (PDT)
Received: from rikard (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 80sm6169362ljf.38.2020.08.18.12.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:30:20 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
X-Google-Original-From: Rikard Falkeborn <rikard.falkeborn>
Date:   Tue, 18 Aug 2020 21:30:17 +0200
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: dac: ad5686: Constify static struct
 iio_chan_spec
Message-ID: <20200818193017.GA1610@rikard>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
 <20200526210223.1672-5-rikard.falkeborn@gmail.com>
 <d822bd34435902f096cdeb27ae0dc029d29bfb2c.camel@analog.com>
 <20200531144715.089886ce@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531144715.089886ce@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 31, 2020 at 02:47:15PM +0100, Jonathan Cameron wrote:
> On Wed, 27 May 2020 04:50:46 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Tue, 2020-05-26 at 23:02 +0200, Rikard Falkeborn wrote:
> > > [External]
> > > 
> > > These are never modified and can be made const to allow the compiler to
> > > put it in read-only memory.
> > > 
> > > Before:
> > >    text    data     bss     dec     hex filename
> > >    6642   12608      64   19314    4b72 drivers/iio/dac/ad5686.o
> > > 
> > > After:
> > >    text    data     bss     dec     hex filename
> > >   16946    2304      64   19314    4b72 drivers/iio/dac/ad5686.o
> > >   
> > 
> > Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > 
> Applied.
> 
> thanks,

Was this one really applied? I can't see it anywhere? The rest of the
patches in the series are in Linus' tree.

Rikard

> 
> > > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > > ---
> > >  drivers/iio/dac/ad5686.c | 8 ++++----
> > >  drivers/iio/dac/ad5686.h | 2 +-
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > > index 8dd67da0a7da..6de48f618c95 100644
> > > --- a/drivers/iio/dac/ad5686.c
> > > +++ b/drivers/iio/dac/ad5686.c
> > > @@ -206,12 +206,12 @@ static const struct iio_chan_spec_ext_info
> > > ad5686_ext_info[] = {
> > >  }
> > >  
> > >  #define DECLARE_AD5693_CHANNELS(name, bits, _shift)		\
> > > -static struct iio_chan_spec name[] = {				\
> > > +static const struct iio_chan_spec name[] = {			\
> > >  		AD5868_CHANNEL(0, 0, bits, _shift),		\
> > >  }
> > >  
> > >  #define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
> > > -static struct iio_chan_spec name[] = {				\
> > > +static const struct iio_chan_spec name[] = {			\
> > >  		AD5868_CHANNEL(0, 1, bits, _shift),		\
> > >  		AD5868_CHANNEL(1, 2, bits, _shift),		\
> > >  		AD5868_CHANNEL(2, 4, bits, _shift),		\
> > > @@ -219,7 +219,7 @@ static struct iio_chan_spec name[] = {			
> > > 	\
> > >  }
> > >  
> > >  #define DECLARE_AD5676_CHANNELS(name, bits, _shift)		\
> > > -static struct iio_chan_spec name[] = {				\
> > > +static const struct iio_chan_spec name[] = {			\
> > >  		AD5868_CHANNEL(0, 0, bits, _shift),		\
> > >  		AD5868_CHANNEL(1, 1, bits, _shift),		\
> > >  		AD5868_CHANNEL(2, 2, bits, _shift),		\
> > > @@ -231,7 +231,7 @@ static struct iio_chan_spec name[] = {			
> > > 	\
> > >  }
> > >  
> > >  #define DECLARE_AD5679_CHANNELS(name, bits, _shift)		\
> > > -static struct iio_chan_spec name[] = {				\
> > > +static const struct iio_chan_spec name[] = {			\
> > >  		AD5868_CHANNEL(0, 0, bits, _shift),		\
> > >  		AD5868_CHANNEL(1, 1, bits, _shift),		\
> > >  		AD5868_CHANNEL(2, 2, bits, _shift),		\
> > > diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> > > index 52009b5eef88..a15f2970577e 100644
> > > --- a/drivers/iio/dac/ad5686.h
> > > +++ b/drivers/iio/dac/ad5686.h
> > > @@ -104,7 +104,7 @@ typedef int (*ad5686_read_func)(struct ad5686_state
> > > *st, u8 addr);
> > >  struct ad5686_chip_info {
> > >  	u16				int_vref_mv;
> > >  	unsigned int			num_channels;
> > > -	struct iio_chan_spec		*channels;
> > > +	const struct iio_chan_spec	*channels;
> > >  	enum ad5686_regmap_type		regmap_type;
> > >  };
> > >    
> 
