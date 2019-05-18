Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D74122246
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfERIiy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 04:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfERIiy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 04:38:54 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C16B2166E;
        Sat, 18 May 2019 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558168733;
        bh=DfCuoB3rUc3K5ggTuUa5PZ9e4azTyiBVjrgrq3T+OHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ms2Rs5UTYWYcjCe0ZVmc1i6ep/kDz0S58638OOcfCHE+iK2t5eXGW+h78pqx/oIIF
         60eG5pDFNyQ7vFg5nNowuxo82FbwuSuZ6uPlLMTB+vXANFMfjpZqg1eAXCwLyiM4pL
         mj00LRBKk/XJ4ALZUNvh+NTqU5/5k5GVj1h3Sui0=
Date:   Sat, 18 May 2019 09:38:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        martin@geanix.com, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer
 support
Message-ID: <20190518093849.4a8817d9@archlinux>
In-Reply-To: <20190511170039.GA4547@localhost.localdomain>
References: <20190507080225.108000-1-sean@geanix.com>
        <20190507080225.108000-2-sean@geanix.com>
        <20190511123755.2d220233@archlinux>
        <20190511123054.GA14837@localhost.localdomain>
        <a8dc4bcc-b004-b287-2126-7c3b082dd3ba@geanix.com>
        <20190511170039.GA4547@localhost.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 May 2019 19:00:41 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On 11/05/2019 14.30, Lorenzo Bianconi wrote:  
> > > > On Tue,  7 May 2019 10:02:25 +0200
> > > > Sean Nyekjaer <sean@geanix.com> wrote:
> > > >   
> > > > > This adds support for using iio triggers, this is needed because
> > > > > our hardware guys forgot to connect the irq pins from imu device
> > > > > to the SoC.
> > > > > 
> > > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>  
> > > > Hi Sean
> > > > 
> > > > A small question on the size of the buffer needed inline.  Otherwise looks
> > > > good to me.  
> > > 
> > > Hi Sean,
> > > 
> > > this patch does not make sense to me since running st_lsm6dsx_read_oneshot
> > > you need to wait to power up the device (and you will power it down at the
> > > end). I guess you will not be able to read at a given ODR (e.g. 416Hz).
> > > Moreover you can't read from the hw fifo without the irq line since
> > > you need to read a full pattern from it in order to maintain the alignment.  
> > We are not using the hw fifo if the hw irq isn't present...
> > So if I understand correctly we could speed things up a bit, with leaving
> > the sensor powered by implementing a new reading function and
> > calling st_lsm6dsx_sensor_set_enable when we enable the trigger?  
> 
> I do not think so since in this way you will not know when the hw has updated
> the output registers
> 
> >   
> > >  From my point of view you have 2 possibility:
> > > - poll the output registers from userspace (this is what you are actually
> > >    doing from inside the kernel, what is the advantage of doing so?)  
> > Yes this is exactly what I'm trying to accomplish here.
> > It would be nice for us to have the same hrtimer/trigger to sample this and
> > our adc.  
> 
> Since we need to wait the data to be ready there is no difference between reading
> them polling the output registers in the sysfs and doing so
> 
> >   
> > > - fix the hw bug  
> > Not possible on +20K devices. ;-)
> >   
> > > 
> > > Moreover if I read the patch correctly it has a NULL pointer dereference bug
> > > since hw->iio_devs[i] can be NULL (e.g. if sensor hub is disabled)  
> > Right above, there is:
> > if (!hw->iio_devs[i])
> > 	return -ENOMEM;
> > 
> > Should be enough...  
> 
> Do you mean when we alloc hw->iio_devs[]? If so the for loop stops at
> ST_LSM6DSX_ID_EXT0 while you are going through the complete list here
> (ST_LSM6DSX_ID_MAX)...
> 
> > > 
> > > Regards,
> > > Lorenzo
> > >   
> 
> What I think can be doable is to read data trough the hw fifo but use
> the iio hr timer as trigger. We need to set the hr timer timeout according to
> the pattern len and read the complete pattern. I am not 100% sure it will work
> since read accesses and data generation are asynchronous (so there will be a
> drift).
> @Jonathan, Denis: can it work?
Usual nasty trick to this is you read the fifo faster than you
in theory need to.  I wouldn't use the hr timer trigger for this though as it
adds apparent semantics that aren't true.  So spin a timer up inside the driver.

If you aren't using the fifo you can also do a higher efficiency check by
polling the status registers at twice the rate of of expected data generation.
When they are all set you read.  So basically you poll in the interrupt line
by reading the registers it reflects.  There are device variants out there
where there is an interrupt pin on the die but it doesn't reach the edge
of the package. In those cases we always have to use hacks like this.

Anyhow, seems no actual need for this. I just wanted to put some comments
in here for the future!

Jonathan


> 
> Regards,
> Lorenzo
> 
> 
> > 
> > BR
> > /Sean  
> 

