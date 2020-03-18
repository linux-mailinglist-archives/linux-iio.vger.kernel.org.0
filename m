Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5272B189F7C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 16:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgCRPT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 11:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRPT2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Mar 2020 11:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D2320757;
        Wed, 18 Mar 2020 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584544768;
        bh=O3sFf4pylIltl1MSb6cyEp6cT9cnjfUiA8TDrdSTS5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DM/UFrVygjTBJBMWDPpMMgTzLnEXUrTUN0T7Yvhv9Yh27+wOP/7PKaTugtsbLmabQ
         b2gpva4FDOSoZ1V1s9vQdy5aM98iCNtfQnYemBC98DnJh0JId4UPG7OzD8UQ9pIu/g
         Jpklxdn+LABdS8Qhfv9dP8trklj6bvxK9NHfrmLk=
Date:   Wed, 18 Mar 2020 16:19:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7280a: Add spaces around
 operators
Message-ID: <20200318151924.GB2862853@kroah.com>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
 <20200318060038.GB1594471@kroah.com>
 <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 04:12:28PM +0100, Lars-Peter Clausen wrote:
> On 3/18/20 7:00 AM, Greg KH wrote:
> > On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
> > > Add spaces around operator symbols to improve readability. Warning
> > > flagged by checkpatch script.
> > > 
> > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > > ---
> > >   drivers/staging/iio/adc/ad7280a.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > > index 19a5f244dcae..34ca0d09db85 100644
> > > --- a/drivers/staging/iio/adc/ad7280a.c
> > > +++ b/drivers/staging/iio/adc/ad7280a.c
> > > @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> > >   }
> > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > > -			     in_voltage-voltage_thresh_low_value,
> > > +			     in_voltage - voltage_thresh_low_value,
> > >   			     0644,
> > >   			     ad7280_read_channel_config,
> > >   			     ad7280_write_channel_config,
> > >   			     AD7280A_CELL_UNDERVOLTAGE);
> > >   static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > > -			     in_voltage-voltage_thresh_high_value,
> > > +			     in_voltage - voltage_thresh_high_value,
> > >   			     0644,
> > >   			     ad7280_read_channel_config,
> > >   			     ad7280_write_channel_config,
> > 
> > Did you try building this code?
> > 
> > It catches everyone...
> 
> The problem is it builds. The token is stringyfied and
> "in_voltage - voltage_thresh_high_value" is a valid string.

Ah, I thought it used to break the build when it happened.  Oh well,
it's still a great "trick" to see if people understand C or not :)

thanks,

greg k-h
