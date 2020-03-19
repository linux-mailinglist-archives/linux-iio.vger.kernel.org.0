Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0680E18BC2D
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 17:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgCSQQT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 12:16:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44504 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgCSQQS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 12:16:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id 37so1505745pgm.11
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2020 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yfshhC39biBSdzchj6GiihemTNljr8EJSQyq8KQYNfE=;
        b=rrR/PhBqsQW2DbgSgjU/i4DlcEhjvnHOv39jEQxizd3DN18RoLPEQ9Fxm9k0Hu7ZH1
         HJrTi1e6xrgZW/JgaY/7CJQ8saZZ1Djwn8KHyb1uNQkyPl1ggiP4IdGbrCYyX73mrV3u
         E2Jp0R0LXmmcZYdDsp5/ehfP83gy4ROvisCc9SWTJuDrRl4C6Qp+CErAeOHhmoeNgwA5
         0EbqFg4of7Jy1kju1rS65RCNfn26hU+y1y9aQ/HUNFjKtK6CFCQSuTiU+S+ZQL82nMzS
         gxZG+1yZnKMHjbKEWRjTBJ0Ahq0vhVy66+8xyUlANCtmiXIHCW1AuwFZ8dpdRY68bX3I
         77FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfshhC39biBSdzchj6GiihemTNljr8EJSQyq8KQYNfE=;
        b=m017h0UPHXQYB2e2aQuW431VBrsA+G2Q7l3+id8p2NC1dQcnDEMekDQeQqZ/oJ/1kH
         2SbCk2hrcW0rwQHwp3F7EjBMIAUDhNocTGrsgksv6rpJG84BgAGYq9Ppygz4ohBFk/Ee
         N1wEKt5S0xRT+rXwU0XNGPLNWeZlvcuYUHV97rC49d1q4cSmkQ/l/A7xS1WYB3nlC8Hc
         3rzxzFW9FFHp1sSS6kC4jovtuxsr2FPRamEjS36LlXbJGiWhm6za96U/cgL9pSWXqJFb
         vLhIzt6TYxHho4yKSVGEEeSpor2TyUfnRqwpAvdpOmt3/k4PuXt8c8OcfPKz5ovM/d91
         bBAw==
X-Gm-Message-State: ANhLgQ0yKmTH84kCBysGbryFwd/3P5Uz+RnrUeQQIF6qR2bP+eybPB8y
        0e9szslHUv5w4zmhqZyEvC1tQ3FY
X-Google-Smtp-Source: ADFU+vvGa4xhHUAFYNY0tmbD+y2OimV7uIIJNhzFxFDislVLQCj9+0A7eqYUPIkfRZUi/AczHN3nYg==
X-Received: by 2002:a63:c54b:: with SMTP id g11mr4177225pgd.164.1584634577220;
        Thu, 19 Mar 2020 09:16:17 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id o128sm3151789pfg.5.2020.03.19.09.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 09:16:16 -0700 (PDT)
Date:   Thu, 19 Mar 2020 21:46:10 +0530
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
Message-ID: <20200319161608.GA14738@deeUbuntu>
References: <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
 <20200318060038.GB1594471@kroah.com>
 <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
 <20200318151924.GB2862853@kroah.com>
 <20200318162353.GA23226@deeUbuntu>
 <alpine.DEB.2.21.2003181727440.2979@hadrien>
 <20200318170051.GA23498@deeUbuntu>
 <b471d6102a731d577fff9f2175d4e35217a45e18.camel@analog.com>
 <alpine.DEB.2.21.2003190802450.3010@hadrien>
 <f783d807e2e74ae492c83eb9827ac43767411808.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f783d807e2e74ae492c83eb9827ac43767411808.camel@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 19, 2020 at 07:07:20AM +0000, Ardelean, Alexandru wrote:
> On Thu, 2020-03-19 at 08:03 +0100, Julia Lawall wrote:
> > [External]
> > 
> > 
> > 
> > On Thu, 19 Mar 2020, Ardelean, Alexandru wrote:
> > 
> > > On Wed, 2020-03-18 at 22:30 +0530, DEEPAK VARMA wrote:
> > > > [External]
> > > > 
> > > > On Wed, Mar 18, 2020 at 05:28:17PM +0100, Julia Lawall wrote:
> > > > > On Wed, 18 Mar 2020, DEEPAK VARMA wrote:
> > > > > 
> > > > > > On Wed, Mar 18, 2020 at 04:19:24PM +0100, Greg KH wrote:
> > > > > > > On Wed, Mar 18, 2020 at 04:12:28PM +0100, Lars-Peter Clausen wrote:
> > > > > > > > On 3/18/20 7:00 AM, Greg KH wrote:
> > > > > > > > > On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
> > > > > > > > > > Add spaces around operator symbols to improve readability.
> > > > > > > > > > Warning
> > > > > > > > > > flagged by checkpatch script.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >   drivers/staging/iio/adc/ad7280a.c | 4 ++--
> > > > > > > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > b/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > index 19a5f244dcae..34ca0d09db85 100644
> > > > > > > > > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > > > > > > > > @@ -825,14 +825,14 @@ static irqreturn_t
> > > > > > > > > > ad7280_event_handler(int
> > > > > > > > > > irq, void *private)
> > > > > > > > > >   }
> > > > > > > > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > > > > > > > > > -			     in_voltage-
> > > > > > > > > > voltage_thresh_low_value,
> > > > > > > > > > +			     in_voltage -
> > > > > > > > > > voltage_thresh_low_value,
> > > > > > > > > >   			     0644,
> > > > > > > > > >   			     ad7280_read_channel_config,
> > > > > > > > > >   			     ad7280_write_channel_config,
> > > > > > > > > >   			     AD7280A_CELL_UNDERVOLTAGE);
> > > > > > > > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > > > > > > > > > -			     in_voltage-
> > > > > > > > > > voltage_thresh_high_value,
> > > > > > > > > > +			     in_voltage -
> > > > > > > > > > voltage_thresh_high_value,
> > > > > > > > > >   			     0644,
> > > > > > > > > >   			     ad7280_read_channel_config,
> > > > > > > > > >   			     ad7280_write_channel_config,
> > > > > > > > > 
> > > > > > > > > Did you try building this code?
> > > > > > > > > 
> > > > > > > > > It catches everyone...
> > > > > > > > 
> > > > > > > > The problem is it builds. The token is stringyfied and
> > > > > > > > "in_voltage - voltage_thresh_high_value" is a valid string.
> > > > > > > 
> > > > > > > Ah, I thought it used to break the build when it happened.  Oh well,
> > > > > > > it's still a great "trick" to see if people understand C or not :)
> > > > > > > 
> > > > > > Yes, it did build. I am sorry but I am not following you fully. Can
> > > > > > you
> > > > > > please let me know if the change I introduced is not good. You may
> > > > > > please direct me to a document where I can read more about it.
> > > > > 
> > > > > The code involves a macro, as indicated by the capital letters.  You
> > > > > will
> > > > > see the issue when you look at the definition of the macro.
> > > > > 
> > > > > julia
> > > > 
> > > > Thank you Julia and all. I got my mistake. I will revert the change.
> > > > Sorry for the trouble.
> > > 
> > > I'll try to make some time to address this somehow, so that checkpatch
> > > doesn't
> > > bump into this.
> > > 
> > > In the last 2-3 years, I think I saw 3-4 patches trying to address this [for
> > > various Analog drivers].
> > > So, don't feel too bad.
> > 
> > Maybe a comment?
> 
> Comment works for now.
> Anybody wants to do a patch for that?
> If nobody sends a patch for this in 1-2 weeks, I'll send one.
> 
> Particularly, this would help with review, since people that are unfamiliar with
> IIO-specific macros would also find it easier at review.
> 
> The good part, is that it's only needed for AD7280A.
> AD7192 has been re-worked, and is no longer on checkpatch's radar.
> I'm reworking AD7793 now.
> 

I will be happy to add a comment around the code area to indicate
ignore checkpatch warning for the mentioned argument. Please confirm if
that is what you are expecting to be done.

Thanks,
Deepak.

> 
> > 
> > julia
> > 
> > > 
> > > > Deepak.
> > > > > > Thanks,
> > > > > > Deepak.
> > > > > > > thanks,
> > > > > > > 
> > > > > > > greg k-h
> > > > > > 
> > > > > > --
> > > > > > You received this message because you are subscribed to the Google
> > > > > > Groups
> > > > > > "outreachy-kernel" group.
> > > > > > To unsubscribe from this group and stop receiving emails from it, send
> > > > > > an
> > > > > > email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > > > To view this discussion on the web visit
> > > > > > https://groups.google.com/d/msgid/outreachy-kernel/20200318162353.GA23226%40deeUbuntu
> > > > > > .
> > > > > > 
