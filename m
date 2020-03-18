Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5713B18A066
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRQWs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:22:48 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52992 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRQWs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:22:48 -0400
Received: by mail-pj1-f67.google.com with SMTP id ng8so1560452pjb.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s3CKavgybeEOpXAZe+xBIGcFk7Vj/l1+eTJ8QUFIoJs=;
        b=Yxge4Ry5vFOHN/E6WRoS1R820nnS6WJDZq9mjgaZLOrnbqWkKFIp8dPZVt//BWqS0r
         5Z2azsstxdYpDTnytEEpvmzQwbz7QdePieWGNQkT90JaQaPGtLDDPityknQdXpD96o7Z
         CpcuyC4Zb6Q2eYS16bz/6gtvs+6klzKe45WaFNPYyYgAKHkO+dXdffvu3JpS2CFGdpDt
         KQjfXzHO8fya59guzla/8qjh2/XCGZBVI4u3F/c3pUL4aDzOQjQFhwVvmXBS8N2yOuM4
         B5OyT3KdQFQMiccd1fhZ9FYQ2IZETmWQ8E8uJyriGXAdQt9oLJgOYf05c/K7MwmzDi98
         WXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3CKavgybeEOpXAZe+xBIGcFk7Vj/l1+eTJ8QUFIoJs=;
        b=U7UzObXqzTmVElsEaXhCrbOdjHkNfCRbTai1zmXZ8+CWwX6iNdXeu8e2B0h0J99Nmr
         RnUQYWrIIbdNFyccjPqAhC28+lTG7EohPcsPLvprp/Rj3AmYu5By8TF48HJJTwIuCsVD
         uNCPzNAuzCS5Pdx9Ah9jzwOiua1XHf0wJ6glysSeXTid9Se5SuhuRj1oryEK0TDXNJpU
         qFe48KJ9c++a3gtbsmMsqlmxVrbBndu/Bmgjzp72cODalyMXTLKgDcJT7gZfmS92cbpK
         4P2ka4+yFzR5cp0ia9K5wqOQuRwS/3YkNQmxw2efBFZ/9kGjr//Yv/eBIcz4ZB2k50Cu
         Rv6A==
X-Gm-Message-State: ANhLgQ1JKH7Qt9unBDzyZU5Dvf+srTYpZe9U4Caa1fYbBCrcgxz0o56r
        k6lWIkk2C2IzInfzfPF6/vWshGN/8Ws=
X-Google-Smtp-Source: ADFU+vuvZvhCj/RnrQOTAISMOb/daExPGR+dHXjaxabBbv1m+SDkzzsJSqqdh6kK5LmeC4g0K19pMA==
X-Received: by 2002:a17:902:788b:: with SMTP id q11mr3719212pll.20.1584548566539;
        Wed, 18 Mar 2020 09:22:46 -0700 (PDT)
Received: from SARKAR ([43.224.157.42])
        by smtp.gmail.com with ESMTPSA id a19sm7223462pfk.110.2020.03.18.09.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:22:45 -0700 (PDT)
Message-ID: <5e724ad5.1c69fb81.7d54e.9f63@mx.google.com>
X-Google-Original-Message-ID: <20200318162241.GB10427@rohitsarkar5398@gmail.com>
Date:   Wed, 18 Mar 2020 21:52:41 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     DEEPAK VARMA <mh12gx2825@gmail.com>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: iio: adc: ad7192:
 Reformat lines crossing 80 columns
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
 <20200318093158.192a27ce@elisabeth>
 <20200318160649.GA23154@deeUbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318160649.GA23154@deeUbuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 09:36:50PM +0530, DEEPAK VARMA wrote:
> On Wed, Mar 18, 2020 at 09:31:58AM +0100, Stefano Brivio wrote:
> > On Wed, 18 Mar 2020 09:56:59 +0530
> > Deepak R Varma <mh12gx2825@gmail.com> wrote:
> > 
> > > Macro arguments are computed at the time of macro invocation. This makes
> > > the lines cross 80 column width. Add variables to perform the
> > > calculations before hand and use these new variable in the macro calls
> > > instead.
> > > 
> > > Also re-indent enum members to address checkpatch warning / check messages.
> > > 
> > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > > index bf3e2a9cc07f..0265f6607d75 100644
> > > --- a/drivers/staging/iio/adc/ad7192.c
> > > +++ b/drivers/staging/iio/adc/ad7192.c
> > > @@ -156,8 +156,8 @@
> > >   */
> > >  
> > >  enum {
> > > -   AD7192_SYSCALIB_ZERO_SCALE,
> > > -   AD7192_SYSCALIB_FULL_SCALE,
> > > +	AD7192_SYSCALIB_ZERO_SCALE,
> > > +	AD7192_SYSCALIB_FULL_SCALE,
> > >  };
> > >  
> > >  struct ad7192_state {
> > > @@ -477,17 +477,18 @@ static ssize_t ad7192_set(struct device *dev,
> > >  }
> > >  
> > >  static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> > > -						    int *freq)
> > > +					     int *freq)
> > >  {
> > >  	unsigned int fadc;
> > > +	unsigned int sync3_filter, sync4_filter;
> > >  
> > >  	/* Formulas for filter at page 25 of the datasheet */
> > > -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> > > -				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> > > +	sync4_filter = AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode);
> > 
> > Have you read page 25 of the datasheet? Why is this called
> > sync4_filter, with a 'y'?
> > 
> 
> Sorry, I am not sure what you are referring to. Can you please elaborate
> or point me to where the data sheet is located?
> 
> Deepak.

Hey Deepak,
You can find the datasheet for ad7192 here https://pdf1.alldatasheet.com/datasheet-pdf/view/988287/AD/AD7192.html

Thanks,
Rohit
