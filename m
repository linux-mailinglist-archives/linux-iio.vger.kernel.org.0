Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE3A18A030
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCRQG6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:06:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47029 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRQG5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:06:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so14127269pfo.13
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fri9PqkqhwvvbowUeaeg84Qe5DMBL3espMfmU2oUWLg=;
        b=rZ2yk0NvbkhcqJmrq9GfjopWiOPRajOtySOI+NG5xIFacAGglUPRr+GDCpRtXUzz9f
         sIXZptA/ks08GFr8Yy1Ibju4QJZWa4aHg1XvilUEmMO82xeFM+zrPbBqboT1ACHgxSwt
         pmEcvGFWkBusC3w/XKlcTbLlrOW0TRcT9rhh/yVLirbdLT+OuEz+pRZrPQdtZriVN9M+
         eXERcWUlisCiu8lYmyxP4DoB1NzEpNYHQKPvooN7VIl3ZqHbQbgw7oywNfbeZGuciowX
         J8CvrXFKmXSjaFSRC0hGPVco8s2NFM6MeVvtWoUIPJ6NneU506jvnl8LRTQpDsJsYYXj
         NTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fri9PqkqhwvvbowUeaeg84Qe5DMBL3espMfmU2oUWLg=;
        b=OJ90I+dRMcUEVq1sOXJm9/DBtat9A5+k80NnY42W9TlOgfowmixlu64Eki8HJRnIpg
         ++9BElE9T0bY/1y603WaXaRRfEqmWtlWYka9nJNvC56MFoP6SPKrbqK1tKYALdM0MV2y
         ZZO4Unmhdx8RhR3tzP501wQnK+plOTZl2KcIB49OUK2QLGPedXXwcYEx4IMCYSpe19Xi
         dQPTAHtARoB0rQrWFibz2xaBmR6XckfrSGry/ncs4FU8VME2VRDuc6U9hrl5GEY/anqq
         20/faltw+g7iYQXgEdm0uJWxc2/wZxqNdEGjk3cMLM0gC2qCb57XZ9K2lCv4Ct8rMpfW
         MrNw==
X-Gm-Message-State: ANhLgQ0V9izIetrIgekBfiZgdFTLSTv/Ht04KRDJojWsSQRwr3f+YEzB
        VillvCPwgqXW1Q0cSduSNwc=
X-Google-Smtp-Source: ADFU+vvi+LAhDT+y3h6VfR4PH7EwPv2GoJ8OjmaCkV8EO4DwiCNFM9zotmP94MiMcO0NLyibcEifKg==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr5105271pfu.155.1584547616416;
        Wed, 18 Mar 2020 09:06:56 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id l6sm6744762pff.173.2020.03.18.09.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 09:06:55 -0700 (PDT)
Date:   Wed, 18 Mar 2020 21:36:50 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: iio: adc: ad7192:
 Reformat lines crossing 80 columns
Message-ID: <20200318160649.GA23154@deeUbuntu>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <50419988d636c90511a07da256c91aa3b3e33bff.1584505215.git.mh12gx2825@gmail.com>
 <20200318093158.192a27ce@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318093158.192a27ce@elisabeth>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 09:31:58AM +0100, Stefano Brivio wrote:
> On Wed, 18 Mar 2020 09:56:59 +0530
> Deepak R Varma <mh12gx2825@gmail.com> wrote:
> 
> > Macro arguments are computed at the time of macro invocation. This makes
> > the lines cross 80 column width. Add variables to perform the
> > calculations before hand and use these new variable in the macro calls
> > instead.
> > 
> > Also re-indent enum members to address checkpatch warning / check messages.
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7192.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index bf3e2a9cc07f..0265f6607d75 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -156,8 +156,8 @@
> >   */
> >  
> >  enum {
> > -   AD7192_SYSCALIB_ZERO_SCALE,
> > -   AD7192_SYSCALIB_FULL_SCALE,
> > +	AD7192_SYSCALIB_ZERO_SCALE,
> > +	AD7192_SYSCALIB_FULL_SCALE,
> >  };
> >  
> >  struct ad7192_state {
> > @@ -477,17 +477,18 @@ static ssize_t ad7192_set(struct device *dev,
> >  }
> >  
> >  static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> > -						    int *freq)
> > +					     int *freq)
> >  {
> >  	unsigned int fadc;
> > +	unsigned int sync3_filter, sync4_filter;
> >  
> >  	/* Formulas for filter at page 25 of the datasheet */
> > -	fadc = DIV_ROUND_CLOSEST(st->fclk,
> > -				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> > +	sync4_filter = AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode);
> 
> Have you read page 25 of the datasheet? Why is this called
> sync4_filter, with a 'y'?
> 

Sorry, I am not sure what you are referring to. Can you please elaborate
or point me to where the data sheet is located?

Deepak.

> -- 
> Stefano
> 
