Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3918A10A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 18:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCRRBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 13:01:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46855 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCRRBB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 13:01:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id y30so13995459pga.13
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+lB/rzYuX4ROylVdnzkiqJeHxEdfyO+qVyE6Y4WNzPI=;
        b=R8RrrF+C+CxaEW0EmL1+g7SBQ/PKbK2ufGzaMEW62oRW0XZYdm5Mg8Oc1ASsu9VCUi
         5XfXwR4BXY3Yttbc/pyE2Qi5khjMlK0j9uKOYpJYf9XaXDg5xJCfBUPhy7lRQxRGK9O8
         V/5ObG/GtQkVy5rYq9DmX34DYQmQXMYRUsdbCrZzn5TZNNxtlTmb0oGXg33b4OrDq8EV
         le9sGN3i/mS9EH37ny3OF85bcqXWtiBurO87JqPKKF44BZCE+H6ff3Emo+4EXeJvuT2m
         UF7GCldMmSzqIkVgsSu1P1gL0Cx2EjCfHp/Qv8OuwhQhe86gpQMtxBM7hff1Vw+OnYAW
         ewIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+lB/rzYuX4ROylVdnzkiqJeHxEdfyO+qVyE6Y4WNzPI=;
        b=t9FByaBzupuqA3mDGHQqE0xUlYkExf2/Rl9D8ItH2Ggoe6imX6Yoox42RGRXwowcQI
         TIz21yIcYoh24Q81oG5RlCcjYr7ZxvEy4ItqhWZZwqBdowbf+gAQY8ttnlga/944tTru
         mV7FZ5ceNwOPngZ2c39hX2rsTq7/qy/w776w967trVjlCwz1jwj6eMThVa78JXtrheBi
         I7JtDjH07zNHN6dF7IljFxySRWoIM7IcMJAsdVCjkHD6qgZzu6CCbxJAaHgTfOG+++7F
         KSl0C/ekGeIhKFRvuxzEfAIXsdUl6ZIb+2koeNG6KGWtbMv8n4Tz0+sRHm7GOuCXcthJ
         M3NA==
X-Gm-Message-State: ANhLgQ1KO0NuaQjOCxUNHenuGIZufMxrD0ZDzSPEAKGwlnkIBqMp2xmZ
        2rqOOw0ZLO+cQeVn8alE35k=
X-Google-Smtp-Source: ADFU+vuLZLC6Fz6yVQTCxBS+IygCj5Wq/uVtfiHcKo8VN80+Nu36n1enXm4QHiXvb6Coa9ZSHG2W3A==
X-Received: by 2002:a63:348b:: with SMTP id b133mr5708459pga.372.1584550859126;
        Wed, 18 Mar 2020 10:00:59 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id u24sm6578007pgo.83.2020.03.18.10.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 10:00:58 -0700 (PDT)
Date:   Wed, 18 Mar 2020 22:30:53 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH 2/2] staging: iio: adc: ad7280a:
 Add spaces around operators
Message-ID: <20200318170051.GA23498@deeUbuntu>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
 <20200318060038.GB1594471@kroah.com>
 <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
 <20200318151924.GB2862853@kroah.com>
 <20200318162353.GA23226@deeUbuntu>
 <alpine.DEB.2.21.2003181727440.2979@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003181727440.2979@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 05:28:17PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 18 Mar 2020, DEEPAK VARMA wrote:
> 
> > On Wed, Mar 18, 2020 at 04:19:24PM +0100, Greg KH wrote:
> > > On Wed, Mar 18, 2020 at 04:12:28PM +0100, Lars-Peter Clausen wrote:
> > > > On 3/18/20 7:00 AM, Greg KH wrote:
> > > > > On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
> > > > > > Add spaces around operator symbols to improve readability. Warning
> > > > > > flagged by checkpatch script.
> > > > > >
> > > > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > > > ---
> > > > > >   drivers/staging/iio/adc/ad7280a.c | 4 ++--
> > > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > > > > > index 19a5f244dcae..34ca0d09db85 100644
> > > > > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > > > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > > > > @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> > > > > >   }
> > > > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > > > > > -			     in_voltage-voltage_thresh_low_value,
> > > > > > +			     in_voltage - voltage_thresh_low_value,
> > > > > >   			     0644,
> > > > > >   			     ad7280_read_channel_config,
> > > > > >   			     ad7280_write_channel_config,
> > > > > >   			     AD7280A_CELL_UNDERVOLTAGE);
> > > > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > > > > > -			     in_voltage-voltage_thresh_high_value,
> > > > > > +			     in_voltage - voltage_thresh_high_value,
> > > > > >   			     0644,
> > > > > >   			     ad7280_read_channel_config,
> > > > > >   			     ad7280_write_channel_config,
> > > > >
> > > > > Did you try building this code?
> > > > >
> > > > > It catches everyone...
> > > >
> > > > The problem is it builds. The token is stringyfied and
> > > > "in_voltage - voltage_thresh_high_value" is a valid string.
> > >
> > > Ah, I thought it used to break the build when it happened.  Oh well,
> > > it's still a great "trick" to see if people understand C or not :)
> > >
> > Yes, it did build. I am sorry but I am not following you fully. Can you
> > please let me know if the change I introduced is not good. You may
> > please direct me to a document where I can read more about it.
> 
> The code involves a macro, as indicated by the capital letters.  You will
> see the issue when you look at the definition of the macro.
> 
> julia

Thank you Julia and all. I got my mistake. I will revert the change.
Sorry for the trouble.

Deepak.
> 
> >
> > Thanks,
> > Deepak.
> > > thanks,
> > >
> > > greg k-h
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200318162353.GA23226%40deeUbuntu.
> >
