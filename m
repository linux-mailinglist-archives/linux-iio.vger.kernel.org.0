Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45F418A18D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCRRbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 13:31:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43438 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgCRRbL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 13:31:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id f206so3248209pfa.10
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HTqD50UmZr45My6NDxgCN8OAOaGi7lH1op3LMlJyHq8=;
        b=h5ffyvKMJRys5b/9wFJ7Bms4kpRKV0vgeD1c7kybEAMBadJZ0WgnLXvaNXieJRyDYl
         lQIj/g2NQnBk/ZDCbsUsnmfH6aV668g4vjIf5hkvVCNygF9/+9RRCt4QJHL+Mmhbz9Fl
         IToLMKMeCmDEMte81ZgJCdGps2TZBL6dwPTi5DhpfDRySWYTvXN78AHVKDhJkgElRtjU
         N9bZY1UzPdeU/3Zj/xBbZGwmbDcq0LuSmfQkMh2pb3gbaTBo3D+c1Ar65dXkcFzkCdWE
         UrWyS10EbIYWWUMU73xqP/y8PTnZkrkav78JVVFgIxVvDL6xO0OIDMY7nWm+5g8kvKhB
         RYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTqD50UmZr45My6NDxgCN8OAOaGi7lH1op3LMlJyHq8=;
        b=nIyZ+mChxf98mzGR/NW80UCPJoefNhEreIxrXFbyN+Hu4jc8yvrQp95CEiwvBVdKi5
         MTs/le3k2yxvuj4hYvxtu2EyZkupE24XJslEnde0WwwILfnNY/92aculViFMbcdYGIdd
         L0gFuee7UO8/+Rb+XflEsb68TCQXtPmVZXGJD2FcjM3GAKWD3KtkHrPefqdBDSCPz63v
         HjfbOAcuni7SAGmErFIiBNKZqvmpfZA6i0WwApTM+VSuPhQZSeVJFI6VLM8e7SLqNEvX
         M8MCqZFZ5q5JgOjkegLa1RAqjAGgRkSDrZQnQOxcMBfwSGEOyV1oKJ9eY52rAMmi+jus
         SheQ==
X-Gm-Message-State: ANhLgQ1/muv7gNiWEeGCHp+QLI+iLl/9lOyYUJFppt6sxvdJ8Tq9CukL
        eSspjJU3TFVBiB0ZFwbn64Q=
X-Google-Smtp-Source: ADFU+vuj2oALlMfF26Kk0CKIMACjZe8I43+Ze3oN1LskRCGJSZRqBcpm7wZMtp0U3r0HBjrtyM6skQ==
X-Received: by 2002:a63:7783:: with SMTP id s125mr5662374pgc.214.1584552670514;
        Wed, 18 Mar 2020 10:31:10 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id x27sm7464069pfj.74.2020.03.18.10.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 10:31:10 -0700 (PDT)
Date:   Wed, 18 Mar 2020 23:01:04 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: iio: adc: ad7192:
 Reformat lines crossing 80 columns
Message-ID: <20200318173102.GA23740@deeUbuntu>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
 <20200318093158.192a27ce@elisabeth>
 <20200318160649.GA23154@deeUbuntu>
 <5e724ad5.1c69fb81.7d54e.9f63@mx.google.com>
 <20200318164306.GA23434@deeUbuntu>
 <1fe9df37-4d83-82e6-bd57-ecb4195447a5@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fe9df37-4d83-82e6-bd57-ecb4195447a5@metafoo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 05:44:16PM +0100, Lars-Peter Clausen wrote:
> On 3/18/20 5:43 PM, DEEPAK VARMA wrote:
> > On Wed, Mar 18, 2020 at 09:52:41PM +0530, Rohit Sarkar wrote:
> > > On Wed, Mar 18, 2020 at 09:36:50PM +0530, DEEPAK VARMA wrote:
> > > > On Wed, Mar 18, 2020 at 09:31:58AM +0100, Stefano Brivio wrote:
> > > > > On Wed, 18 Mar 2020 09:56:59 +0530
> > > > > Deepak R Varma <mh12gx2825@gmail.com> wrote:
> > > > > 
> > > > > > Macro arguments are computed at the time of macro invocation. This makes
> > > > > > the lines cross 80 column width. Add variables to perform the
> > > > > > calculations before hand and use these new variable in the macro calls
> > > > > > instead.
> > > > > > 
> > > > > > Also re-indent enum members to address checkpatch warning / check messages.
> > > > > > 
> > > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > > ---
> > > > > >   drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
> > > > > >   1 file changed, 8 insertions(+), 7 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > > > > > index bf3e2a9cc07f..0265f6607d75 100644
> > > > > > --- a/drivers/staging/iio/adc/ad7192.c
> > > > > > +++ b/drivers/staging/iio/adc/ad7192.c
> > > > > > @@ -156,8 +156,8 @@
> > > > > >    */
> > > > > >   enum {
> > > > > > -   AD7192_SYSCALIB_ZERO_SCALE,
> > > > > > -   AD7192_SYSCALIB_FULL_SCALE,
> > > > > > +	AD7192_SYSCALIB_ZERO_SCALE,
> > > > > > +	AD7192_SYSCALIB_FULL_SCALE,
> > > > > >   };
> > > > > >   struct ad7192_state {
> > > > > > @@ -477,17 +477,18 @@ static ssize_t ad7192_set(struct device *dev,
> > > > > >   }
> > > > > >   static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> > > > > > -						    int *freq)
> > > > > > +					     int *freq)
> > > > > >   {
> > > > > >   	unsigned int fadc;
> > > > > > +	unsigned int sync3_filter, sync4_filter;
> > > > > >   	/* Formulas for filter at page 25 of the datasheet */
> > > > > > -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> > > > > > -				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> > > > > > +	sync4_filter = AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode);
> > > > > 
> > > > > Have you read page 25 of the datasheet? Why is this called
> > > > > sync4_filter, with a 'y'?
> > > > > 
> > > > 
> > > > Sorry, I am not sure what you are referring to. Can you please elaborate
> > > > or point me to where the data sheet is located?
> > > > 
> > > > Deepak.
> > > 
> > > Hey Deepak,
> > > You can find the datasheet for ad7192 here https://pdf1.alldatasheet.com/datasheet-pdf/view/988287/AD/AD7192.html
> > > 
> > 
> > Thank you Rohit. I got it. I understand Stefano's comments now. I named
> > the variables with a 'y' to keep it similar to the macro
> > AD7192_SYNCn_FILTER. Let me know if the variable name looks odd and I
> > should rename it to sinc4_filter instead.
> 
> Hi,
> 
> Please send a patch to rename the macro to SINC as well. This is a typo in
> the macro.
> 
> Thanks,
> - Lars

Sure. Will send a separate patch for the macro name correction in the same
pathset.

Deepak.
