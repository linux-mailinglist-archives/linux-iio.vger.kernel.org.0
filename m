Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551B4A49E4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2019 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfIAOuo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Sep 2019 10:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbfIAOuo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Sep 2019 10:50:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EAA521872;
        Sun,  1 Sep 2019 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567349443;
        bh=d8gad1MhncuQ6BWWcbf4cgx6ffDXU06wGu8V4SV4Xek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lSxFsFvX+OffaW+blrTaULqsVhgEH1JeU88GOBzM3Ll2UWMprdIe1WbMw+gYZ2ao5
         6uFQww1u9zVqpAGozhTzD7OUbAw1d1CTHCMy9Y7ovYnO4kVH/Aoam6emIU1/bkYrlT
         bMsKyDJ/M7YAF/4q2akCsG1VPzbt/aq2M3URLAJ8=
Date:   Sun, 1 Sep 2019 15:50:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [BUG] Re: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain
 value for LSM9DS1
Message-ID: <20190901155023.249271e1@archlinux>
In-Reply-To: <20190831093224.GA5393@lore-desk-wlan.lan>
References: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
        <20190827210857.718d7f9b@archlinux>
        <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
        <20190829083714.GA2880@localhost.localdomain>
        <f34694f0-ea7c-0327-532d-7a2904952771@puri.sm>
        <20190830072354.GA5910@localhost.localdomain>
        <531903f2-a4df-87a8-6417-68463261b859@puri.sm>
        <20190831093224.GA5393@lore-desk-wlan.lan>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Aug 2019 11:32:24 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On 30.08.19 09:23, Lorenzo Bianconi wrote:  
> > >> On 29.08.19 10:37, Lorenzo Bianconi wrote:  
> > >>>> On 27.08.19 22:08, Jonathan Cameron wrote:  
> > >>>>> On Tue, 27 Aug 2019 10:26:35 +0200
> > >>>>> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >>>>>  
> > >>>>>> Get rid of invalid sensitivity value for LSM9DS1 gyro sensor
> > >>>>>>
> > >>>>>> Fixes: 687a60feb9c6 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
> > >>>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> > >>>>> The zero degree scale is certainly odd otherwise, so good to tidy
> > >>>>> this up.
> > >>>>>
> > >>>>> Applied to the togreg branch of iio.git.
> > >>>>>  
> > > 
> > > [...]
> > >   
> > >>> struct st_lsm6dsx_fs_table_entry in st_lsm6dsx_settings will always have 4
> > >>> elements for fs_avl array and since the array is defined as static the
> > >>> uninitialized elements are set to 0.
> > >>>
> > >>> Could you please share the ops you are getting?
> > >>>  
> > >>
> > >> How this oops during startup can look like is appended below. I know
> > >> that exactly this change causes it. Can you test this too please?  
> > > 
> > > I did it but I have no issues
> > >   
> > >>
> > >> Given the cleanup nature of this patch, I think it's best to revert it
> > >> in case of any doubt.
> > >>
> > >> thanks,
> > >>
> > >>                           martin
> > >>  
> > > 
> > > is it the full ops? It seems some parts are missing.
> > > Are you running some userspace aps reading in_anglvel_scale_available or reading/writing in in_anglvel_scale?
> > > Could you please double check if the following patch helps? (just compiled)
> > >   
> > 
> > it does not, and you're right, the problem should be somewhere else.
> > I've yet to debug it further.
> > 
> > thanks,  
> 
> Looking at the previous patch I spotted an issue (not related to the one you
> are facing)..actually we can set device gain to 0 forcing to 0 sensor output.
> I will post a formal patch to fix it.
> 

Rather than messing around with a pull request that has already gone
to Greg, I'm going to leave this as it is for now.

The trace doesn't make a lot of sense to me and whilst a bit messy (as fixed
up by Lorenzo's follow up) I can't see why things would crash.

So needs debugging and that isn't a problem given we are only looking
at putting this support into rc1.  Not ideal, but there is time
to work out what is wrong and fix it up!

Thanks,

Jonathan


> Regards,
> Lorenzo
> 
> > 
> >                         martin
> > 
> >   

