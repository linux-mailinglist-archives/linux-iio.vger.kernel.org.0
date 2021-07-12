Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13A43C5ADC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 13:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhGLKk2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 12 Jul 2021 06:40:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3380 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhGLKkX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 06:40:23 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNg0j6tm9z6GF6n;
        Mon, 12 Jul 2021 18:26:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:37:32 +0200
Received: from localhost (10.47.25.8) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 12 Jul
 2021 11:37:31 +0100
Date:   Mon, 12 Jul 2021 11:37:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: light: adjd_s311: convert to device-managed
 functions
Message-ID: <20210712113713.000044da@Huawei.com>
In-Reply-To: <PH0PR03MB6366FCE9E3F85195F881C88899159@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210628135132.73682-1-aardelean@deviqon.com>
        <20210703185007.2c2283f4@jic23-huawei>
        <CAASAkoYMaSuRnSWwtcoZVaGj+m6bDtu7ms2idHBtp5JFzDEp1g@mail.gmail.com>
        <20210711112618.50c5bea1@jic23-huawei>
        <PH0PR03MB6366FCE9E3F85195F881C88899159@PH0PR03MB6366.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.25.8]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Jul 2021 07:45:42 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, July 11, 2021 12:26 PM
> > To: Alexandru Ardelean <aardelean@deviqon.com>
> > Cc: linux-iio <linux-iio@vger.kernel.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; pmeerw@pmeerw.net
> > Subject: Re: [PATCH] iio: light: adjd_s311: convert to device-managed
> > functions
> > 
> > On Mon, 5 Jul 2021 09:38:21 +0300
> > Alexandru Ardelean <aardelean@deviqon.com> wrote:
> >   
> > > On Sat, 3 Jul 2021 at 20:47, Jonathan Cameron <jic23@kernel.org>  
> > wrote:  
> > > >
> > > > On Mon, 28 Jun 2021 16:51:32 +0300
> > > > Alexandru Ardelean <aardelean@deviqon.com> wrote:
> > > >  
> > > > > This one is a little easier to convert to device-managed, now with  
> > the  
> > > > > devm_krealloc() function.
> > > > >
> > > > > The other iio_triggered_buffer_setup() and iio_device_register()  
> > can be  
> > > > > converted to their devm_ variants. And devm_krealloc() can be  
> > used to  
> > > > > (re)alloc the buffer. When the driver unloads, this will also be  
> > free'd.  
> > > > >
> > > > > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
> > > > > ---
> > > > >  drivers/iio/light/adjd_s311.c | 34 +++++-----------------------------
> > > > >  1 file changed, 5 insertions(+), 29 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/light/adjd_s311.c  
> > b/drivers/iio/light/adjd_s311.c  
> > > > > index 17dac8d0e11d..19d60d6986a1 100644
> > > > > --- a/drivers/iio/light/adjd_s311.c
> > > > > +++ b/drivers/iio/light/adjd_s311.c
> > > > > @@ -230,8 +230,8 @@ static int  
> > adjd_s311_update_scan_mode(struct iio_dev *indio_dev,  
> > > > >  {
> > > > >       struct adjd_s311_data *data = iio_priv(indio_dev);
> > > > >
> > > > > -     kfree(data->buffer);
> > > > > -     data->buffer = kmalloc(indio_dev->scan_bytes,  
> > GFP_KERNEL);  
> > > > > +     data->buffer = devm_krealloc(indio_dev->dev.parent, data-  
> > >buffer,  
> > > > > +                                  indio_dev->scan_bytes, GFP_KERNEL);  
> > > > I got some complaints about exactly this trick in a review recently  
> > so I'll  
> > > > pass them on.
> > > >
> > > > Whilst devm_krealloc() usage like this won't lose the original  
> > reference, its  
> > > > not what people expect from a realloc() case, so to not confuse  
> > people it is  
> > > > better to do a dance where you use a local variable, then only set  
> > data->buffer  
> > > > to it once we know the realloc succeeded.
> > > >
> > > > That avoids this looking like the anti-pattern it would be if that  
> > were a normal  
> > > > realloc in which case you would just have leaked the original  
> > allocation.  
> > > >
> > > > More interestingly, why are we bothering with resizing the buffer  
> > dependent on what  
> > > > is enabled?  Can't we just allocate a 128 byte buffer and not bother  
> > changing it  
> > > > as we really aren't wasting that much space?  Just embed it in the  
> > adjd_s311_data  
> > > > structure directly and don't worry about the allocations.  Will need  
> > to be  
> > > > aligned(8) though to avoid the push_to_buffer_with_timestamp()  
> > issue.  
> > > > Using something like
> > > >
> > > > struct {
> > > >         s16 chans[4];
> > > >         s64 ts __aligned(8); /* I hate x86 32 bit */  
> > >
> > > do you want to me t also add this comment? :p
> > > [just kidding]
> > >  
> > > > } scan;
> > > >
> > > > Inside the priv structure should work nicely.  
> > >
> > > i agree; will do it like this;
> > > i hesitated a bit due to the inertia of converting things to devm_  
> > 
> > A long discussion on rust usage in linux diverted into the issues around
> > devm.
> > I 'believe' that we are fine in IIO after some work Lars did a long time
> > back
> > to make us resilient to unbinds whilst the chardev was open, but
> > probably
> > worth keeping an eye on that discussion.
> > 
> > https://urldefense.com/v3/__https://lore.kernel.org/ksummit/CANiq
> > 72nkNrekzbxMci6vW02w=Q2L-
> > SVTk_U4KN_LT8u_b=YPgw@mail.gmail.com/T/*m6db86a574237c22a3
> > 2ecf49b596b3c2917967c5e__;Iw!!A3Ni8CS0y2Y!oeM8GJzKVXb8mYa1m
> > VJNw5fI2adsFk3FKkFzbnqyuDkUMKVTKQ3OoT0cnXP5rA$
> > 
> > I'm a tiny bit nervous that there might be races where we are doing
> > the devm_realloc.
> > I 'think' we are fine, but the 'think' and 'believe' in these statements
> > expresses
> > a slight lack of certainty!
> > 
> > Jonathan
> >   
> 
> Hi,

+CC Lars who might recall how this all works!

> 
> It's the second thread where I see you mentioning this, so this I will take the
> opportunity to also give a bit on though about this. I actually have in mind a RFC
> (hopefully sending it out this week) for this as I think we might still have some 
> issues with open chardevs and device unbinding.
> 
> What we have in [1] is not enough to make sure the whole thing is synchronized with
> device unbinding... We still have the door open to races where we call 'iio_buffer_ready()'
> or even 'rb->access->read()' after the device gets unbinded. Maybe we are lucky and
> nothing bad really happens and we just error out in the next time 'read()' is done on
> our fd. 

My understanding of that test is it was only intended to ensure a smooth exit 'after' the
buffer pull down has occurred.  From vague memory rather than careful analysis, the
reason it is needed is we only send the break out signal once for a given buffer,
so we need to be sure that userspace doesn't call read() then ignore the error returned
due to the buffer going away mid read and call read() again.  There may be races in the
first time path though. In particularly I'm not sure the reference count on the buffer
is raised during the read and it perhaps should be.


> However, during the possible race,  I think it's very likely that we end up touching
> the same data structures concurrently. On some devices, we surely
> (in theory and if all the stars align) have a path where 'iio_buffer_flush_hwfifo()' might
> be called with 'indio_dev->info' already set to NULL...

Yeah, the hwfifo stuff is more recent, it's definitely possible there is a race around that.

> 
> IMO, the only way to have this fully in sync is to use the 'info_exist_lock' as it's done
> in [2]. I think [2] was actually "fixed" when Alex sent his patches for multi buffer support...
It's rather painful to take that lock. If we can make things safe with appropriate reference
counting that's definitely preferable. 

For ioctl's they are always slow path so the exist_lock route is fine.

> Naturally, for the read case, we need to make sure we are not going to sleep with the
> mutex held so we might need an unlock -> lock dance which is not that nice. But I'm
> not really seeing another way. We also need to look at other file operations and also
> for the events case to see if this is also a thing.
> 
> Naturally, I might be missing some subtlety and that's why I had this planned as RFC.
> But since is mentioned here, I thought I could bring this up as in the end I might not
> even need to send the patches :)
Wise move :)

I'd suggest that any fix in this space would ideally be accompanied by a confirmed race.
Heavy use of sleeps can usually open one up enough to actually hit them in a few tries.

Jonathan
> 
> [1]: https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-buffer.c#L117
> [2]: https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-core.c#L1763
> 
> - Nuno Sá

