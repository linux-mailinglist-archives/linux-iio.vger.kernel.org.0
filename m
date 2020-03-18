Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8513618A0C3
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCRQnQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:43:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42544 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCRQnQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:43:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so11414649plz.9
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fcnUHoACse7eTRxCkZZOXp83dug0akVVK+r5f16wH6o=;
        b=TVdB8R15xKD/dTLCokpwXYwZwQIa+dqy1ca4BGeX7BbX5YlindJlsX45waczjgcX4P
         1Pt78KsZc/CU854gBLqoYCQ0kLbgYmlsdyDR7aP4KWggHXJaD4gv3HlUo1vZi2DAq3e1
         KLcmpmZuGnQhBNg3qmK5LfT9U3MANtwTdZ8qaYdlNwDrniW3CKSRhjHrSecIxjyfX7JP
         odVc7oVpwBR0si0mo1euGjb4bkgUqv5LF/Ruvt1zJ+cPBf2ZwpuJ9d/4eu2dmhxEERAp
         YKKjhFW4qxNuzrf1HI3b2QZBPjOj2eAt8bz7ioRvPI+li7yUg6QZqbounQ6tiJmgmr8F
         BOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fcnUHoACse7eTRxCkZZOXp83dug0akVVK+r5f16wH6o=;
        b=PxRgMKa/WOndtRfHfC0NBtFXFrWk1r8tSJ9ujJggL/N5E2Ss1FSYzAfTNpVfd2oCVr
         q56FQ4kQsXdY/4k9OUY7HudnqOqerc56PygW/FH3KhbwqLsR1HvFcGPi0fPcOq2MnlOT
         Fs7r1QtR5fVhkwwRzAmDh0U+Z4+qVl4fXB408Xt85gjV2ZRUcXToGBs7oXYnmwH4eRSH
         PogrmSEJAae+mzy+zuCHFTeS8WCIeboJZAtOgiuRKrvbB5on4spDGhLLA4k33KbI26R+
         c9GL8rPlHuzV1ksZ6iGNb/AbG+6GeiTD7bZGoC3ksUuywkVBj0zU2jQ465pX4fdGOGDn
         k2fw==
X-Gm-Message-State: ANhLgQ2upX5/TuLioJ3lfNb+T3MtOMiJYu/izLzojlK3cTQux17jk5nO
        H0XjA8hHUsjVzY5QWNXzYnqwCods
X-Google-Smtp-Source: ADFU+vsqsswASHESGzD7c5z8l1Ojrd09NUiGMZl9HyM43jsjKTFwiUU4DAznTcOYJ/9DjEQ0iTMq0g==
X-Received: by 2002:a17:902:aa06:: with SMTP id be6mr4814334plb.132.1584549794986;
        Wed, 18 Mar 2020 09:43:14 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id u9sm3297501pfn.116.2020.03.18.09.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 09:43:14 -0700 (PDT)
Date:   Wed, 18 Mar 2020 22:13:08 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: iio: adc: ad7192:
 Reformat lines crossing 80 columns
Message-ID: <20200318164306.GA23434@deeUbuntu>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
 <20200318093158.192a27ce@elisabeth>
 <20200318160649.GA23154@deeUbuntu>
 <5e724ad5.1c69fb81.7d54e.9f63@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e724ad5.1c69fb81.7d54e.9f63@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 09:52:41PM +0530, Rohit Sarkar wrote:
> On Wed, Mar 18, 2020 at 09:36:50PM +0530, DEEPAK VARMA wrote:
> > On Wed, Mar 18, 2020 at 09:31:58AM +0100, Stefano Brivio wrote:
> > > On Wed, 18 Mar 2020 09:56:59 +0530
> > > Deepak R Varma <mh12gx2825@gmail.com> wrote:
> > > 
> > > > Macro arguments are computed at the time of macro invocation. This makes
> > > > the lines cross 80 column width. Add variables to perform the
> > > > calculations before hand and use these new variable in the macro calls
> > > > instead.
> > > > 
> > > > Also re-indent enum members to address checkpatch warning / check messages.
> > > > 
> > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > ---
> > > >  drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
> > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > > > index bf3e2a9cc07f..0265f6607d75 100644
> > > > --- a/drivers/staging/iio/adc/ad7192.c
> > > > +++ b/drivers/staging/iio/adc/ad7192.c
> > > > @@ -156,8 +156,8 @@
> > > >   */
> > > >  
> > > >  enum {
> > > > -   AD7192_SYSCALIB_ZERO_SCALE,
> > > > -   AD7192_SYSCALIB_FULL_SCALE,
> > > > +	AD7192_SYSCALIB_ZERO_SCALE,
> > > > +	AD7192_SYSCALIB_FULL_SCALE,
> > > >  };
> > > >  
> > > >  struct ad7192_state {
> > > > @@ -477,17 +477,18 @@ static ssize_t ad7192_set(struct device *dev,
> > > >  }
> > > >  
> > > >  static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> > > > -						    int *freq)
> > > > +					     int *freq)
> > > >  {
> > > >  	unsigned int fadc;
> > > > +	unsigned int sync3_filter, sync4_filter;
> > > >  
> > > >  	/* Formulas for filter at page 25 of the datasheet */
> > > > -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> > > > -				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> > > > +	sync4_filter = AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode);
> > > 
> > > Have you read page 25 of the datasheet? Why is this called
> > > sync4_filter, with a 'y'?
> > > 
> > 
> > Sorry, I am not sure what you are referring to. Can you please elaborate
> > or point me to where the data sheet is located?
> > 
> > Deepak.
> 
> Hey Deepak,
> You can find the datasheet for ad7192 here https://pdf1.alldatasheet.com/datasheet-pdf/view/988287/AD/AD7192.html
> 

Thank you Rohit. I got it. I understand Stefano's comments now. I named
the variables with a 'y' to keep it similar to the macro
AD7192_SYNCn_FILTER. Let me know if the variable name looks odd and I
should rename it to sinc4_filter instead.

Thanks,
Deepak.

> Thanks,
> Rohit
