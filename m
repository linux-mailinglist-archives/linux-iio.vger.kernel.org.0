Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D60F9178402
	for <lists+linux-iio@lfdr.de>; Tue,  3 Mar 2020 21:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgCCU35 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Mar 2020 15:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbgCCU35 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Mar 2020 15:29:57 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3878920CC7;
        Tue,  3 Mar 2020 20:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583267396;
        bh=t9RfzDI52bSHUruw7b5ag96Nwcv1BtePTSwBPCrtTh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BggjB16YMLOvuRdQBwnOMv5hvOiicsOrXbTaiVcsZU56rTqYFdMEVrsUS38BFZWu4
         vgpUdpBPj+LcFpVtgomLpvpcf8ze+8knY/XWmDOgz4avEhzOMDICUNqsb3QVYjHxWW
         MKI5WG8kXtviErKmIG18klTUzkCbUa9qpeibZn8A=
Date:   Tue, 3 Mar 2020 20:29:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     dragos.bogdan@analog.com, JManeyrol@invensense.com,
        linux-iio@vger.kernel.org
Subject: Re: [GSOC][RFC] Proposal
Message-ID: <20200303202950.1bc0dfc5@archlinux>
In-Reply-To: <5e5c9393.1c69fb81.18044.9bc8@mx.google.com>
References: <5e55473d.1c69fb81.82355.928d@mx.google.com>
        <5e581673.1c69fb81.9fd7b.25c2@mx.google.com>
        <20200301143418.438ce7f9@archlinux>
        <5e5c9393.1c69fb81.18044.9bc8@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Mar 2020 10:33:09 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> On Sun, Mar 01, 2020 at 02:34:18PM +0000, Jonathan Cameron wrote:
> > On Fri, 28 Feb 2020 00:50:15 +0530
> > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> >   
> > > On Tue, Feb 25, 2020 at 09:41:37PM +0530, Rohit Sarkar wrote:  
> > > > Hi,
> > > > I am proposing to work on the accelerometer MPU6050 as my primary
> > > > project for the summer. The work items are outlined in [1] thanks to
> > > > Jean.
> > > > If time permits (which it should), I will be picking up other tasks
> > > > outlined in [2] by Jonathan and Alexandru.
> > > > 
> > > > 
> > > > Would like to hear people's views on this.
> > > > 
> > > > [1]: https://marc.info/?l=linux-iio&m=158257639113000&w=2
> > > > [2]: https://marc.info/?l=linux-iio&m=158261515624212&w=2
> > > > Thanks,
> > > > Rohit
> > > >     
> > > 
> > > Hey guys,
> > > would love some feedback on this.
> > > There are no proposals as such on the GSOC IIO page [1].
> > > Was wondering if there is any new iio driver that can be made into a
> > > gsoc project.  
> > 
> > Hi Rohit,
> > 
> > A couple of questions.   Do you have a gsoc mentor lined up?  
> 
> On the GSOC IIO page (https://wiki.linuxfoundation.org/gsoc/2020-gsoc-iio-driver)
> Dragos has been listed as a mentor. Haven't really heard back from him
> yet.

I would definitely be looking to discuss this with Dragos.
 
> 
> > You should discuss a proposal with whoever that is.
> > 
> > My gut feeling is that the features suggested by Jean-Baptisite
> > do not form a particularly good focus for the body of a gsoc project.
> > There are too many rather disassociated items, without a connected
> > 'story'.
> > 
> > They are good items for getting familiar with the subsystem and
> > a particular driver but for the actual project you probably want
> > something that is more 'yours' in the sense that you drive it from
> > initial prototypes through to final upstream code.
> > 
> > Previous projects have (I think) mostly centred on support for a new
> > driver.   
> 
> Makes sense. Is there any new driver that needs to be added though? And
> if not what else can qualify as a project?

There might be something, but that sort of project is much harder
to structure than a clear implement something.

There are always new devices that don't have drivers that someone
is interested in supporting.  The main requirement is to find
find something that the mentor things is the right balance of
complex and not too complex to support.

The link you have above suggests Dragos was thinking of an Analog
devices part (which makes sense given his day job ;)

You are still fairly early (which is great) so it may well be that
Dragos hasn't yet spun up for this round.

Jonathan

> 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> Thanks,
> Rohit

