Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9659B18A06D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRQYE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 12:24:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34959 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRQYD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 12:24:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id g6so11406730plt.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sfRBQs5Dz5VvxU1A2guJOa7lJTCHsI6FTFKGIebxiLg=;
        b=uDQ1IytFO3yVt58CQ2Td/kbum+bs7anqBJTh1zRZ+9i5iiRwYoy6yv5Qu1YveN/2bb
         PnBoO2IIDsY+W3icf/CJUauBBhg05s3x7bjwIld/bhqu72f1spMoiRXMGCgk70A6mzjo
         CjNHQ8oyJXICLbjvkPuR1oUa63VdrzTPDbyn5Yu5a1YpkTyS3U7CMcXL+gW9Z3j+pI7m
         mk2TDs+cWCuHXD5VX2vlu89+F1Xp4Y6Eq55aWw85HM6AIatlzTIZ3GpldQpIUKAiHKOT
         sJaW9ZEyJH+VRicCoV+iJ+bysnrBT7zBkKX906ex+8VlCqYDA6jihEQUzC7qwjtv6rTB
         gdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sfRBQs5Dz5VvxU1A2guJOa7lJTCHsI6FTFKGIebxiLg=;
        b=gGHohA/lgaO/PI6/wQrJf0Ekmp8OUsKyv+ulsRio6NhIpEjYcSauXLaK05/XSIjIk1
         rOQA5j1VbacHEPjmGy9ZXQB5FAd+aNDxvlJeIrILo98x1G3XdF+/k2o/GyKeNocgnIqy
         wo/mWboB24Jgq6yOyp3NrXe5jQbxVcw3BJuYX0BhQtjuArZ9mWcA+32WuP5yOb/cZknQ
         OyGPv6chcu4WMdcbV5lfTJasVNA/19TsQGh9i5ud/V7SdOJWoON9pfKrVyw6GYXWc5bI
         HCQgfjtjo8CJWo+t5wtBEiY9lRYMxSpC0gckLsYZkU8F/h1X0mMmU/GhYzJlU7CyoZ8P
         3jYw==
X-Gm-Message-State: ANhLgQ3QE1AteGOOycFQ2uhwt204onWLaT3lf6W0M8gJZM4owJyttqRV
        RvBVf/rv4RvIG31PQ6mUa00=
X-Google-Smtp-Source: ADFU+vv/6302wqFSb2p+EQAZKGrBV4Ov2uR9irG+8OOVqH+Ms9WCcMQUgdORCPfGNLzLiGa0KnqhGA==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr4525413plr.201.1584548640964;
        Wed, 18 Mar 2020 09:24:00 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id y131sm7280908pfg.25.2020.03.18.09.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 09:24:00 -0700 (PDT)
Date:   Wed, 18 Mar 2020 21:53:55 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, Michael.Hennerich@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7280a: Add spaces around
 operators
Message-ID: <20200318162353.GA23226@deeUbuntu>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
 <20200318060038.GB1594471@kroah.com>
 <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
 <20200318151924.GB2862853@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318151924.GB2862853@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 04:19:24PM +0100, Greg KH wrote:
> On Wed, Mar 18, 2020 at 04:12:28PM +0100, Lars-Peter Clausen wrote:
> > On 3/18/20 7:00 AM, Greg KH wrote:
> > > On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
> > > > Add spaces around operator symbols to improve readability. Warning
> > > > flagged by checkpatch script.
> > > > 
> > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > > ---
> > > >   drivers/staging/iio/adc/ad7280a.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > > > index 19a5f244dcae..34ca0d09db85 100644
> > > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > > @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> > > >   }
> > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > > > -			     in_voltage-voltage_thresh_low_value,
> > > > +			     in_voltage - voltage_thresh_low_value,
> > > >   			     0644,
> > > >   			     ad7280_read_channel_config,
> > > >   			     ad7280_write_channel_config,
> > > >   			     AD7280A_CELL_UNDERVOLTAGE);
> > > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > > > -			     in_voltage-voltage_thresh_high_value,
> > > > +			     in_voltage - voltage_thresh_high_value,
> > > >   			     0644,
> > > >   			     ad7280_read_channel_config,
> > > >   			     ad7280_write_channel_config,
> > > 
> > > Did you try building this code?
> > > 
> > > It catches everyone...
> > 
> > The problem is it builds. The token is stringyfied and
> > "in_voltage - voltage_thresh_high_value" is a valid string.
> 
> Ah, I thought it used to break the build when it happened.  Oh well,
> it's still a great "trick" to see if people understand C or not :)
> 
Yes, it did build. I am sorry but I am not following you fully. Can you
please let me know if the change I introduced is not good. You may
please direct me to a document where I can read more about it.

Thanks,
Deepak.
> thanks,
> 
> greg k-h
