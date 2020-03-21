Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E718DF67
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 11:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgCUKZg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 06:25:36 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54174 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgCUKZg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 06:25:36 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so3639543pjb.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2020 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GV6AYP7Qr5KcHjwhZEBtuMmcE1Vx0cgZ94j7L8L7P+Q=;
        b=Tjpv1N0meLL6K559HHlnLIWF/jI3ZrBg7DyCgthGpNcaf4zYNwVdTujaztCVNMrUd8
         szI3CB4sibRFH3OaajjfaHhlnbyxlqbGRksUsydKfDagmQfSoqHfKsJXfu+YEZdHZWWu
         POD/m/si4TupAEzWvD6uo+MO2/731Wl1hi0v4mJtfBP0+WjvEh3bSPLgtngyHOJazyLd
         LQTu0CKPgOqCKGJjd04dPQzbBBNv7HtQppEfGo5QQLStvPmHpLNBv5vQ8XTIzL1/IsMQ
         KlhXuthhn5Yshug7S4RAUsjyCaVus/7PWfZ55LXn4oYuB4rRXQQazUxgEuyngGJdlbss
         2b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GV6AYP7Qr5KcHjwhZEBtuMmcE1Vx0cgZ94j7L8L7P+Q=;
        b=raFxLdXpu0qeLTILAfQ7nF5JOJ2GHNNp1VcO+IdYGwc3C1DbFWoprD7V++i0dMZAnQ
         f7hldI5Hfc+8Fzg0artDYjK8qjySC9y/YNsHCP7PepbXPT1r1mC2X8qkeMw36F5y6JhD
         hiSF+TJWYH3EZMcHxkExWvH3t8ttXOyITh7UzgFOQhoaiFfyFMw+laftrKx7R6T8FhYr
         3rqklkRnP03YdCHC/U5giBr0srGxSBFNu/lo1vqiBdyEt+j94FO+ZkSf4Qdiu3+Qd5b0
         A0KzclYBAPnsw259PB3VIgd3xQyxsEqqSmnmt8sGdhvfM7OHwMU5WrOaSGqG5tqC0peV
         1mUg==
X-Gm-Message-State: ANhLgQ3QMsAXtAyxBX5wllkspWrx3UpKV0J+/4MtTu9t++yEA9fjOW4O
        w80ay1SRXbhI2oFUjQJ5GDE=
X-Google-Smtp-Source: ADFU+vsNw8f+xhE68zAUTpBU6weoDd+MD4cPOvTXSg/aEztbuBQFthqpofL9svgNaEcl+up51hKKSA==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr14086355pjb.79.1584786332770;
        Sat, 21 Mar 2020 03:25:32 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.132])
        by smtp.gmail.com with ESMTPSA id v123sm6140571pfv.41.2020.03.21.03.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Mar 2020 03:25:32 -0700 (PDT)
Date:   Sat, 21 Mar 2020 15:55:23 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "julia.lawall@inria.fr" <julia.lawall@inria.fr>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Message-ID: <20200321102522.GA3019@deeUbuntu>
References: <20200318060038.GB1594471@kroah.com>
 <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
 <20200318151924.GB2862853@kroah.com>
 <20200318162353.GA23226@deeUbuntu>
 <alpine.DEB.2.21.2003181727440.2979@hadrien>
 <20200318170051.GA23498@deeUbuntu>
 <b471d6102a731d577fff9f2175d4e35217a45e18.camel@analog.com>
 <alpine.DEB.2.21.2003190802450.3010@hadrien>
 <f783d807e2e74ae492c83eb9827ac43767411808.camel@analog.com>
 <20200319161608.GA14738@deeUbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319161608.GA14738@deeUbuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 19, 2020 at 09:46:10PM +0530, DEEPAK VARMA wrote:
> On Thu, Mar 19, 2020 at 07:07:20AM +0000, Ardelean, Alexandru wrote:
> > On Thu, 2020-03-19 at 08:03 +0100, Julia Lawall wrote:
> > > [External]
> > > 
> > > 
> > > 
> > > On Thu, 19 Mar 2020, Ardelean, Alexandru wrote:
> > > 
> > > > On Wed, 2020-03-18 at 22:30 +0530, DEEPAK VARMA wrote:
> > > > > [External]
> > > > > 
> > > > > On Wed, Mar 18, 2020 at 05:28:17PM +0100, Julia Lawall wrote:
> > > > > > On Wed, 18 Mar 2020, DEEPAK VARMA wrote:
> > > > > > 
> > > > > > > On Wed, Mar 18, 2020 at 04:19:24PM +0100, Greg KH wrote:
> > > > > > > > On Wed, Mar 18, 2020 at 04:12:28PM +0100, Lars-Peter Clausen wrote:
> > > > > > > > > On 3/18/20 7:00 AM, Greg KH wrote:
> > > > > > > > > > On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
> > > > > > > > > > > Add spaces around operator symbols to improve readability.
> > > > > > > > > > > Warning
> > > > > > > > > > > flagged by checkpatch script.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > > > > > > > ---
> > > > > > > > > > >   drivers/staging/iio/adc/ad7280a.c | 4 ++--
> > > > > > > > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > > > > 
> > > > > > > > > > > diff --git a/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > > b/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > > index 19a5f244dcae..34ca0d09db85 100644
> > > > > > > > > > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > > @@ -825,14 +825,14 @@ static irqreturn_t
> > > > > > > > > > > ad7280_event_handler(int
> > > > > > > > > > > irq, void *private)
> > > > > > > > > > >   }
> > > > > > > > > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > > > > > > > > > > -			     in_voltage-
> > > > > > > > > > > voltage_thresh_low_value,
> > > > > > > > > > > +			     in_voltage -
> > > > > > > > > > > voltage_thresh_low_value,
> > > > > > > > > > >   			     0644,
> > > > > > > > > > >   			     ad7280_read_channel_config,
> > > > > > > > > > >   			     ad7280_write_channel_config,
> > > > > > > > > > >   			     AD7280A_CELL_UNDERVOLTAGE);
> > > > > > > > > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > > > > > > > > > > -			     in_voltage-
> > > > > > > > > > > voltage_thresh_high_value,
> > > > > > > > > > > +			     in_voltage -
> > > > > > > > > > > voltage_thresh_high_value,
> > > > > > > > > > >   			     0644,
> > > > > > > > > > >   			     ad7280_read_channel_config,
> > > > > > > > > > >   			     ad7280_write_channel_config,
> > > > > > > > > > 
> > > > > > > > > > Did you try building this code?
> > > > > > > > > > 
> > > > > > > > > > It catches everyone...
> > > > > > > > > 
> > > > > > > > > The problem is it builds. The token is stringyfied and
> > > > > > > > > "in_voltage - voltage_thresh_high_value" is a valid string.
> > > > > > > > 
> > > > > > > > Ah, I thought it used to break the build when it happened.  Oh well,
> > > > > > > > it's still a great "trick" to see if people understand C or not :)
> > > > > > > > 
> > > > > > > Yes, it did build. I am sorry but I am not following you fully. Can
> > > > > > > you
> > > > > > > please let me know if the change I introduced is not good. You may
> > > > > > > please direct me to a document where I can read more about it.
> > > > > > 
> > > > > > The code involves a macro, as indicated by the capital letters.  You
> > > > > > will
> > > > > > see the issue when you look at the definition of the macro.
> > > > > > 
> > > > > > julia
> > > > > 
> > > > > Thank you Julia and all. I got my mistake. I will revert the change.
> > > > > Sorry for the trouble.
> > > > 
> > > > I'll try to make some time to address this somehow, so that checkpatch
> > > > doesn't
> > > > bump into this.
> > > > 
> > > > In the last 2-3 years, I think I saw 3-4 patches trying to address this [for
> > > > various Analog drivers].
> > > > So, don't feel too bad.
> > > 
> > > Maybe a comment?
> > 
> > Comment works for now.
> > Anybody wants to do a patch for that?
> > If nobody sends a patch for this in 1-2 weeks, I'll send one.
> > 
> > Particularly, this would help with review, since people that are unfamiliar with
> > IIO-specific macros would also find it easier at review.
> > 
> > The good part, is that it's only needed for AD7280A.
> > AD7192 has been re-worked, and is no longer on checkpatch's radar.
> > I'm reworking AD7793 now.
> > 
> 
> I will be happy to add a comment around the code area to indicate
> ignore checkpatch warning for the mentioned argument. Please confirm if
> that is what you are expecting to be done.
> 

Hello Alexandru,
could you please confirm if I should add a comment around the code in
ad7280a.c to avoid further changes being made to the string argument?


> Thanks,
> Deepak.
> 
> > 
> > > 
> > > julia
> > > 
> > > > 
> > > > > Deepak.
> > > > > > > Thanks,
> > > > > > > Deepak.
> > > > > > > > thanks,
> > > > > > > > 
> > > > > > > > greg k-h
> > > > > > > 
> > > > > > > --
> > > > > > > You received this message because you are subscribed to the Google
> > > > > > > Groups
> > > > > > > "outreachy-kernel" group.
> > > > > > > To unsubscribe from this group and stop receiving emails from it, send
> > > > > > > an
> > > > > > > email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > > > > To view this discussion on the web visit
> > > > > > > https://groups.google.com/d/msgid/outreachy-kernel/20200318162353.GA23226%40deeUbuntu
> > > > > > > .
> > > > > > > 
